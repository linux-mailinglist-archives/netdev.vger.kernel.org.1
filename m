Return-Path: <netdev+bounces-305421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3oM8BJTmTGoarwEAu9opvQ
	(envelope-from <netdev+bounces-305421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:44:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECA471B10E
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:44:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="di78U/GW";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305421-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305421-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5246F301919A
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 11:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2425E3F4DC1;
	Tue,  7 Jul 2026 11:38:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83A03F7AA6
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 11:38:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424311; cv=none; b=MFj8IP/MKPB14X8aKxn7gGs3130mUOVh5dMpnr4kvECFwOA6HyG47vaIHfCoxvETutsob6a/2o0aB1s3jGAbpPOmrpii23/fI/LE5fOYiKkNqMslLEf9nkApOk3BW6i04CMhCnj1qTECA7WdPwWgiFGtSDckKzvYs0PttVM8dJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424311; c=relaxed/simple;
	bh=hEzac39ba/5lX/9Eef9L5fGodksJwsGH6fZH1a9Oq/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLzjdCTJK5W6JKtDHw+/37bmD+iBbPB8vpkj4wrPsEAmkowjmAxcNYwKlRLbPQbjGd3rYmEymkZavpa1w/bpUc/GSS+qCNd8A5HYa3Q380nGVZo6HC2f8LlHTLmDeo0YrYBljo2SyJi73Oi2ggbADeGBPQqSd7GbsQMThA4QLT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=di78U/GW; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783424308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gD1iFtbwfwxUxYa7Q7fmRHwP16XfGqMl+jwvGG5JkzY=;
	b=di78U/GW1ndBolkO3OlQLjNS1hjPIiSD0Rr6Fsk+VRFJyLg+7CT2lMQWf40VX3NGo0GrDF
	j/H0kqr0a18OXFgJAbtyzYNE5DK6vLuCPwAb4qQqyyySvqtAy8nN46PnBGi3fNRpa26lRB
	mjCdSSJdL/lug34xl6dxfFadQuFZAdk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-ypl6u5h8Nd2a3Wg0OVKRtA-1; Tue,
 07 Jul 2026 07:38:25 -0400
X-MC-Unique: ypl6u5h8Nd2a3Wg0OVKRtA-1
X-Mimecast-MFC-AGG-ID: ypl6u5h8Nd2a3Wg0OVKRtA_1783424304
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E92E71808964;
	Tue,  7 Jul 2026 11:38:23 +0000 (UTC)
Received: from thinkpad (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 883541956040;
	Tue,  7 Jul 2026 11:38:21 +0000 (UTC)
Date: Tue, 7 Jul 2026 13:38:18 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+456957213f32970c0762@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: hsr: fix memory leak on slave unregistration by
 removing synced VLANs
Message-ID: <akzlKrj0AtfImcJS@thinkpad>
References: <20260707082327.3238690-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707082327.3238690-1-edumazet@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305421-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+456957213f32970c0762@syzkaller.appspotmail.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lunn.ch,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,456957213f32970c0762];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,thinkpad:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6ECA471B10E

On Tue, Jul 07, 2026 at 08:23:27AM +0000, Eric Dumazet wrote:
> When an HSR master device is brought UP, it auto-adds VLAN 0 via
> vlan_vid0_add(), which propagates VID 0 to its slave devices.
>
> If a slave device is later unregistered while HSR is active (e.g., during
> netns cleanup or interface destruction), hsr_del_port() is called to
> detach the slave port from the HSR master. However, hsr_del_port() currently
> does not delete the VLAN IDs that were synced to the slave device by HSR.
>
> As a result, the slave device retains a refcount on VID 0 (and any other
> synced VLANs). When the slave device is destroyed, its vlan_info /
> vlan_vid_info structure remains allocated, leading to a memory leak.
>
> Fix this by calling vlan_vids_del_by_dev(port->dev, master->dev) in
> hsr_del_port() before unlinking the slave device, matching the cleanup
> behavior in bonding and team drivers.
>
> Fixes: 1a8a63a5305e ("net: hsr: Add VLAN CTAG filter support")
> Reported-by: syzbot+456957213f32970c0762@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a4cb6ca.57639fcc.86d58.000b.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Looks good to me, thank you!

Reviewed-by: Felix Maurer <fmaurer@redhat.com>

> ---
>  net/hsr/hsr_slave.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index d9af9e65f72f07b1997b80c85db16d812fbda488..2d1e3ea72088e35d5d870b4cc86dd2f789670394 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -242,6 +242,7 @@ void hsr_del_port(struct hsr_port *port)
>  		netdev_rx_handler_unregister(port->dev);
>  		if (!port->hsr->fwd_offloaded)
>  			dev_set_promiscuity(port->dev, -1);
> +		vlan_vids_del_by_dev(port->dev, master->dev);
>  		netdev_upper_dev_unlink(port->dev, master->dev);
>  		if (hsr->prot_version == PRP_V1 &&
>  		    port->type == HSR_PT_SLAVE_B) {
> --
> 2.55.0.795.g602f6c329a-goog
>


