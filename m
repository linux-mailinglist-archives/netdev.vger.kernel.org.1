Return-Path: <netdev+bounces-278115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JbWA18F3WkZZAkAu9opvQ
	(envelope-from <netdev+bounces-278115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:01:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 516C83EDA6D
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52A2130234C7
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8709E3E120F;
	Mon, 13 Apr 2026 15:01:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B97C3E0C76
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092474; cv=none; b=rwoIyqdgGFjWix1yOwXeEi3giFwpp0vAEUiBOlqqj3zCmECQ6zlt1uKheA3RMFR6Q1+NIFKEWp60yJNca+0+H6G96ikNhYxhs2kF77SJGHKPCQAoFHNBRNCIhMazzMbqFd0swkA7nZqyCqKvm01IrM5df4d65ImBb+3Kan+O0Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092474; c=relaxed/simple;
	bh=U8xAKrmSj+O0xYfqbpjlFvhugckixzVj+Gix8fSfjO0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=IVR8YDgO30kMt8ZonbPSKv5ciQI/LrCBZxBggd235ERxPROq7X1Yu486PrgAS4O2LdZn42YlrPePhD09QgZ5EQOdUwPFrirMVDZ/S8KBV7NVKXp7VAm22PyMeqhdMJwrX2C/rXz/KgO+8NshYcrsPMRfija3jq7h5xKDbuFTBKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35da86144daso5439584a91.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 08:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776092473; x=1776697273;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlSroUvQLnPQy/vliop0r/9IQklxRKU38FSvvT0IkJU=;
        b=ekIbic467O2+PQrKLQzyqqxaQkHstNcbqMXb93unvkHf2YbmP2KQfdP6w7n6LBYhPy
         OktV18mkB5ONhTJOAk2ifiTidO9sYRDH3ebMXObzSdjcdheUtrTEoGeT81T2P1xSpfvq
         mJY0gc38N/YLpIkxE0Apyb/DR+oiWNkSPhE5gEi20mDwlYs61bJcAmQJ7ziXovwDktuq
         l9SE7kKCg8NmmKe3KqonfVe44WcRuZdRAmEfqwQ+7biTVtpRADwFfJIuHbdbKm66vy90
         qVWlKuV4o0dF1du8Pin1BC2I4KWor91tC516XIhFYJgphArX5rt1HtrDmyI8alHt3QUT
         WO1A==
X-Forwarded-Encrypted: i=1; AFNElJ97OAo8RGNRqGHJi3pyPoyi311CYO1TPbTaD/nFJc3l+D/c2/YP7RFrXjGPA7NYKzBehP6WXxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJSA5gJmRJErWYPOHSur2UJ9gZGI4GTZvcLkFkbZ6xsG/G8PrK
	//mFqHm/GFnqimdxUGOPLGoVP2AkqZUTyGOgetLSxNiRGRYc948tv/ZB4ljgI2XexSaXbUnZzIx
	8NQoUq+4niZ09DJeJ/S0bZnEzJw5Ds2ZxuLnnfb398kUS0uLihZoPcdYS7hY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90b:28c4:b0:35f:b69d:7292 with SMTP id
 98e67ed59e1d1-35fb69d7632mr3809862a91.15.1776092472566; Mon, 13 Apr 2026
 08:01:12 -0700 (PDT)
Date: Mon, 13 Apr 2026 08:01:12 -0700
In-Reply-To: <20260413150024.1003490-1-shardul.b@mpiricsoftware.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69dd0538.a00a0220.468cb.0049.GAE@google.com>
Subject: Re: [PATCH] wireguard: device: use exit_rtnl callback instead of
 manual rtnl_lock in pre_exit
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: shardul.b@mpiricsoftware.com
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, janak@mpiric.us, 
	jason@zx2c4.com, kalpan.jani@mpiricsoftware.com, kuba@kernel.org, 
	kuniyu@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, shardul.b@mpiricsoftware.com, shardulsb08@gmail.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,mpiric.us,zx2c4.com,mpiricsoftware.com,kernel.org,vger.kernel.org,redhat.com,gmail.com,lists.zx2c4.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278115-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,mpiricsoftware.com:email]
X-Rspamd-Queue-Id: 516C83EDA6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> wg_netns_pre_exit() manually acquires rtnl_lock() inside the
> pernet .pre_exit callback.  This causes a hung task when another
> thread holds rtnl_mutex - the cleanup_net workqueue (or the
> setup_net failure rollback path) blocks indefinitely in
> wg_netns_pre_exit() waiting to acquire the lock.
>
> Convert to .exit_rtnl, introduced in commit 7a60d91c690b ("net:
> Add ->exit_rtnl() hook to struct pernet_operations."), where the
> framework already holds RTNL and batches all callbacks under a
> single rtnl_lock()/rtnl_unlock() pair, eliminating the contention
> window.
>
> The rcu_assign_pointer(wg->creating_net, NULL) is safe to move
> from .pre_exit to .exit_rtnl (which runs after synchronize_rcu())
> because all RCU readers of creating_net either use maybe_get_net()
> - which returns NULL for a dying namespace with zero refcount - or
> access net->user_ns which remains valid throughout the entire
> ops_undo_list sequence.
>
> Reported-by: syzbot+pFBD3bslSSshiJCd3rxy@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=cb64c22a492202ca929e18262fdb8cb89e635c70
> Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
> ---
>  drivers/net/wireguard/device.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
> index 46a71ec36af8..eb854c5294a3 100644
> --- a/drivers/net/wireguard/device.c
> +++ b/drivers/net/wireguard/device.c
> @@ -411,12 +411,11 @@ static struct rtnl_link_ops link_ops __read_mostly = {
>  	.newlink		= wg_newlink,
>  };
>  
> -static void wg_netns_pre_exit(struct net *net)
> +static void wg_netns_exit_rtnl(struct net *net, struct list_head *dev_kill_list)
>  {
>  	struct wg_device *wg;
>  	struct wg_peer *peer;
>  
> -	rtnl_lock();
>  	list_for_each_entry(wg, &device_list, device_list) {
>  		if (rcu_access_pointer(wg->creating_net) == net) {
>  			pr_debug("%s: Creating namespace exiting\n", wg->dev->name);
> @@ -429,11 +428,10 @@ static void wg_netns_pre_exit(struct net *net)
>  			mutex_unlock(&wg->device_update_lock);
>  		}
>  	}
> -	rtnl_unlock();
>  }
>  
>  static struct pernet_operations pernet_ops = {
> -	.pre_exit = wg_netns_pre_exit
> +	.exit_rtnl = wg_netns_exit_rtnl
>  };
>  
>  int __init wg_device_init(void)
> -- 
> 2.34.1
>

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.


