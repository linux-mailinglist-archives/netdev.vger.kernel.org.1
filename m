Return-Path: <netdev+bounces-290717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNGkGegREGryTAYAu9opvQ
	(envelope-from <netdev+bounces-290717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:20:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DCB5B06F6
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD3AA301B4E0
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 08:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9B8385D85;
	Fri, 22 May 2026 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dgbYgyLk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4336DA03
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438048; cv=none; b=gbYaHaKcpDOKFoOafztE8xAp6jTrHJ9fb0zpyLiABuzgKb2yq2eSy3WzGc8m1kDawmvwBY/6DWTkWj5FfrY9ww/WzWem1VGBcZ2+yz2yTWW5CisZDYhTK/5/D44XA14CWLYsngGLeMY9W4Kjz7Qi/nscis1PKvIStMMD4hmnHDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438048; c=relaxed/simple;
	bh=eSHA+MRezVT5Xn+hDwxcTyYvWZGfivtSAv4+CT+jWNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RgGiqHnO06xvOoppo3B7g0B2jIuJWARAvMXwbHpAJDSazJAApatqFiwbwus5FRdNlOQ+4Dp0Ji0M1zclpm597QutVSHNTz/Z2XfZ1e4RfsEuV02YNtwecyTWhHsnYoXp8C6DlvShLzv5SnTxtKhe5b6Jcte6zax/JmCaALSZxDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dgbYgyLk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45d96d21e82so4014029f8f.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 01:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1779438043; x=1780042843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WACazbqwHnopUzM3DAQheQx+4pgTgNsG1wku00oKTn4=;
        b=dgbYgyLk3cJI5q11MFcMXZrkuxh0nvoTJUNUbnXCHB7Uo+OfQXaR3Xk9nNbdtwUnqs
         Sgb+cPPNVo7iBQ8rgIi0Ipi8Oq6yRFv7f8H0eTfoZGjOIgpkuPfb2MCb3OReLToKQ4tn
         bQoMmazxbV5HSOC7WFDt1Na83ZNM1HHN3OzhsatjOKuFt/vXWinbYXLXvw0R/i6ZwwNe
         tJLG1PPunRrp9FFoWeIQimVFL+IC5CxOm4llaMo5GQaKFrIlXRPuDlw8DmMt3n/zLm7d
         Ku3hxHQ7BpwHPUpNKGAoV4r5hFj5Op8lZtIabO/kqWLI4dZBaeXrUDGC3DxUH2sDJgRa
         GDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779438043; x=1780042843;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WACazbqwHnopUzM3DAQheQx+4pgTgNsG1wku00oKTn4=;
        b=iAz17mW5l6CP/rA6H7RF05vwgIxpJPwv+8X7ii1sNLBFxPM/CZtioE0aHWKSeyCql7
         tuJFS+aJ0+sh/jctynVlUhEx3BSXrmZ/X1SCVhHx27FmB0J4bzouEkTd0k/iIcd2Jve9
         iZsesNXzG6fFa1HKwPs1jVFg+fGBbA5plVnAk3x6ObyB2RoKUnY6Mbbv1HNJ3MUqIjSQ
         YglUJ88Lt49fpuP03x7kU0gEdSiKlbmWtCTXgV5KaHd+zGkMGJPoKYmDcn9Rypo91Rv7
         PqVr56Pc03LQ07Bk5VMwqgKcY5AijYB+Q34FbP1Fr0xBKiAOykkvrNhJgOzwO6x6kGQ8
         jAsg==
X-Forwarded-Encrypted: i=1; AFNElJ+iyJ4lDNkg2lpOr98Rq1HANQGDCGLKTHHjeeWj/lj/Cm+aw0aD4Qro4SjyCRYmHg47YEhKnHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFsJzSDT+RdvlS3JrKQIkcrzLPMu721BbugyJS//PfY+/Y4B1I
	ysgqEu4RB3zSvyD+fHjXKOEHGwj3YsgOq0cNWS8+arktrhkKQ6DCNpBAVRefA8jUDvEa+/3dQSh
	taTh3lbqbWUtG17S+3kh7I8PjSNDFH6YmsgLU+7OggOS0XMXRZFs=
X-Gm-Gg: Acq92OGDfEA7UrRfQW3areScMB+h78ljbgPUJEFiofWFet8yWgK9pgyXS6WFaKrOSCo
	IT91KDz7PIiK+tElwSxExYUgbiTlG/uecBaj0makruM09g5Ir/W0yIcQ3Ud1KWMA6XOJMga4UOn
	3DCL7Sle5zLsnhDeoWzBrKxU7O7oQq4cbCEoYUZd/O0Vbra3Gax1F5a+QkUMVY3jMD/TBCJrblK
	knpNQMd6A3z1Ef7yp2qzQ98CmrJrxTdmfCDfBJgDbI81HDPS6t6yAfYRESyKxPW7Cd12iwdX7XY
	W2BkMiNqnop/xMr+Fplg8l7dQbvXfU+OjojZShb+Y8FLhNo5uuuHHMO7FVuXlcWsI025bsL4txt
	ChlBBo0qj9AHoP64ADMZWn7psLoP2YDjy7dshb9FZUs3zoUjhEqK6yTJh/vi15bJj0uibRihQGb
	wyVUkip4XARQAtb/cWNoGO33F8tbsYukOVKxIWvKetCsyI1kwE7LKv1JnpNV8GuA==
X-Received: by 2002:a05:6000:4605:b0:43d:7bc9:9b2c with SMTP id ffacd0b85a97d-45eb3687941mr3590508f8f.17.1779438043092;
        Fri, 22 May 2026 01:20:43 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:c745:5339:4482:9cce? ([2001:67c:2fbc:1:c745:5339:4482:9cce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d49132sm2187719f8f.24.2026.05.22.01.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 01:20:42 -0700 (PDT)
Message-ID: <055d61c5-4b35-45e7-b1d2-371725cfa35c@openvpn.net>
Date: Fri, 22 May 2026 10:20:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ovpn: fix peer refcount leak in TCP error paths
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: sd@queasysnail.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260521083739.65061-1-jhapavitra98@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20260521083739.65061-1-jhapavitra98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290717-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:mid,openvpn.net:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D9DCB5B06F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Thanks for your patch!

On 21/05/2026 10:37, Pavitra Jha wrote:
> When either the TCP RX or TX error path calls ovpn_peer_hold() followed
> by schedule_work(&peer->tcp.defer_del_work), and the work item is already
> pending from the other path, schedule_work() returns false and the work
> runs only once. Since ovpn_tcp_peer_del_work() calls ovpn_peer_put()
> exactly once, the extra reference taken by the losing path is never
> dropped, leaking the peer object.
> 
> The race window:
> 
>    CPU0 (strparser/RX error):       CPU1 (tcp_tx_work/TX error):
>    ovpn_peer_hold()   <- refcnt+1   ovpn_peer_hold()   <- refcnt+2
>    schedule_work()    <- queued      schedule_work()    <- NO-OP
>                                      (work already pending)
>    ovpn_tcp_peer_del_work runs:
>      ovpn_peer_del()
>      ovpn_peer_put()  <- refcnt+1
>                                     <- peer never freed
> 
> Fix by checking the return value of schedule_work() in both paths and
> calling ovpn_peer_put() to drop the extra reference if the work was
> already pending.
> 
> Fixes: a6a5e87b3ee4 ("ovpn: avoid sleep in atomic context in TCP RX error path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
> ---
>   drivers/net/ovpn/tcp.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> index 5499c1572..d651ce85c 100644
> --- a/drivers/net/ovpn/tcp.c
> +++ b/drivers/net/ovpn/tcp.c
> @@ -151,7 +151,8 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
>   	/* take reference for deferred peer deletion. should never fail */
>   	if (WARN_ON(!ovpn_peer_hold(peer)))
>   		goto err_nopeer;
> -	schedule_work(&peer->tcp.defer_del_work);
> +	if (!schedule_work(&peer->tcp.defer_del_work))
> +		ovpn_peer_put(peer);
>   	dev_dstats_rx_dropped(peer->ovpn->dev);
>   err_nopeer:
>   	kfree_skb(skb);
> @@ -282,8 +283,9 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
>   			/* in case of TCP error we can't recover the VPN
>   			 * stream therefore we abort the connection
>   			 */
> -			ovpn_peer_hold(peer);
> -			schedule_work(&peer->tcp.defer_del_work);
> +			if (ovpn_peer_hold(peer))

why introducing this new if check?
It seems unrelated to the current fix.

At this point in the flow the hold() cannot fail, otherwise `peer` would 
already be a stale/bogus pointer and we'd be in bigger troubles.


Regards,

> +				if (!schedule_work(&peer->tcp.defer_del_work))
> +					ovpn_peer_put(peer);
>   
>   			/* we bail out immediately and keep tx_in_progress set
>   			 * to true. This way we prevent more TX attempts

-- 
Antonio Quartulli
OpenVPN Inc.


