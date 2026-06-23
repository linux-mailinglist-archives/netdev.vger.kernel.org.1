Return-Path: <netdev+bounces-301416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LYHcI/LBOmoTGAgAu9opvQ
	(envelope-from <netdev+bounces-301416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:27:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B0E6B90A4
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:27:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="UMHkL/cB";
	dkim=pass header.d=redhat.com header.s=google header.b=OrQ4pUnH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301416-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301416-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAF09307384E
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CED838B7CD;
	Tue, 23 Jun 2026 17:26:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3E338B149
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:26:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235608; cv=none; b=SKlc9NZivj1mn9v6o8Ld2Ia2TYxfDMBIVvwhp7kPPSTOWIIpNbQWLuuKwMr9Ct/Qotxrfbei+N4bywT+yBWSmxyAsPrEfyVYtdz4ADBFZqfiwWeGh1ZxIVGakAG9revMpQqiyGTiz29g8GQyperQWA2UeEt6uMSBKEqlCpELB5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235608; c=relaxed/simple;
	bh=rip9uRV7z1MrHq44c9P9AtUk8yQpQ+kZiXRL/p9vnmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CutssQvcknTLOfm1rZSNUQX1RzXaThqvCGoMXRqSlj9JacinXe2wjAN7SbKN6TYqVVC7odwGLf0j1V83MvbkoF8gDGDTZ19zf6SOotDjUT90PVbONdSXZdjI0gIp3w/NUK55wKHggWDZ7axvey72CCszGxlEhGLIDT0EDB2VuGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMHkL/cB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OrQ4pUnH; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782235606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lVPkNP6BJkSGxsw8Xm+oSCJFyrrNmnKR4VG6pNKWuqE=;
	b=UMHkL/cBt9u4LU5O9Ozvgx4IZp1j7yLBffa2cpF18SDH9hmeWTZi6O5GC7Rq73z+C2a+MT
	yHQY2ZI3EtM6J/qvuFBc5xjxnZ7hDafE4MqeLBvHb/Bvp0p/wmMDhUFtuS1q4TquQRxc+c
	s7WbtS1iVZiM5zn0GHVfciHrMEirlq8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-1Wr_Xe2fOx-RYOuPvj7gHQ-1; Tue, 23 Jun 2026 13:26:44 -0400
X-MC-Unique: 1Wr_Xe2fOx-RYOuPvj7gHQ-1
X-Mimecast-MFC-AGG-ID: 1Wr_Xe2fOx-RYOuPvj7gHQ_1782235604
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46250b59ed5so98317f8f.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782235603; x=1782840403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVPkNP6BJkSGxsw8Xm+oSCJFyrrNmnKR4VG6pNKWuqE=;
        b=OrQ4pUnHp2YYjc1FdTz+DLqvRxFJ01jcGUSNWcjh+CW5S7E3SyrOMCTOGZtqmrA324
         7jdbZ9Olg136ZlaewucoVRRQBy6AJZB4eu8YByQG8hpRinGLR1I1e1CeNMg4kcYndIrR
         Q+Or4zQPzvjIclxOVRvsACpPRQVBVBtICcx1IHbBVa3YoeNh/DhdBIzN2CecnKaS6tqn
         C2QJdXeR94c0sxH7cY1E5W++ZxCz3w+SzYu+e+0B5wGnFOKm6M8nGRAY9PSfWMhzNXX/
         ACumuXFtdAwcIWexOPj9E176dNnFZvuklReamEy3CHAd71UItcoRb8/kxoG7hkKemJLY
         nxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235604; x=1782840404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVPkNP6BJkSGxsw8Xm+oSCJFyrrNmnKR4VG6pNKWuqE=;
        b=BbviW0Es+CgX4vrmzxM0dlRG5s3pzyNDA3njR6h/1qhgK8n2kt6nxzEt+fyLZVkY5C
         eULvdn0ohwZVbeKV8yZ5rnAUH2Cah7hynNR4KNBcIwfmBP1lKDSSdSK0VTvhdDkZ8n4H
         SWMBQaj42KVRXalgf/yGxtF6E30E9L6zqfrSCr7RQ603nsXF5wN6b3vNeq+PptHrBbPV
         uLtd1B2vTvqWBptReDJudyogyVmjQh1X7dKXmg6MFmHBfpj4Pko38EU9KHhCBeVWD2MU
         tPgRmFSK1aEJ7YNUejSPbGG/qe55WfVPRSVT3v5hgtC7qEn76ElKI0RxNyRwBDIP39i+
         fFbw==
X-Forwarded-Encrypted: i=1; AFNElJ9bmlk+X4Wduy1+CpjoNzD/p5yVj8Wvq1FhAIF54t51xQ0SRPoeJJxvyGoYHTqVJHFieLcF7QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7s9UiqWu+PI8ihIWAV8s1jELTB3Oh5jwwiyuej2Rf4E7KX1HH
	n0J6eM88OW3ykrA5lhTDIvbErfYw/3zjhraFsEO9fd/0mgeFOrXNSR4iIA2phQCUspKj6I7W+16
	2vQ46Ox/iXnMMXJWWE9U2uJ4Tm3U5lt9U2oTMwwmOko3lr7fe3Nn8sHLwJQ==
X-Gm-Gg: AfdE7clNXzB3GqBp78j5PXUuLkMFHS9tl9h+DiGatDHr5B6cWJvB3Dg4dQ/BlqIcnlz
	CTzgABdIq5NE7O0ANhmxxV9W8tv8w4DhYVkWg80zAB/HMG1xxhJv+L/WBXQ94+uUtW0htwEpwNC
	6OAdt1NYtCMLiXntKcR8iYNiKchJV8GijW093TeXQJKFSrpWEFQV9XoFeYOZz3rCGU+qCUUPjVW
	lr7ueQSnNI/RbW70j3r2brp0ftwCW+nR/P+Q5T5p/2MCOzv2NCBZKOyXoiqfQeIoT2WBu8dd3II
	CCxpyjtK8o24aymwaLn8yWm2TUFzNEYwMQUhQe1Z51L5XGF2aLdhafkt8k/KUNOh00KiZzxq4jT
	iB1bxyeAgGKiR/13ODoclI1ikmJGeS03G
X-Received: by 2002:a05:600c:d4:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-49240e20de0mr257222885e9.5.1782235603253;
        Tue, 23 Jun 2026 10:26:43 -0700 (PDT)
X-Received: by 2002:a05:600c:d4:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-49240e20de0mr257222385e9.5.1782235602685;
        Tue, 23 Jun 2026 10:26:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd15535sm425803415e9.3.2026.06.23.10.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:26:41 -0700 (PDT)
Date: Tue, 23 Jun 2026 13:26:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, oxffffaa@gmail.com,
	rulkc@linuxtesting.org
Subject: Re: [PATCH net-next v3] vsock/virtio: rewrite MSG_ZEROCOPY flag
 handling
Message-ID: <20260623132014-mutt-send-email-mst@kernel.org>
References: <20260623153819.697635-1-avkrasnov@rulkc.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623153819.697635-1-avkrasnov@rulkc.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301416-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,meta.com,linux.alibaba.com,vger.kernel.org,lists.linux-foundation.org,gmail.com,linuxtesting.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:avkrasnov@rulkc.org,m:stefanha@redhat.com,m:sgarzare@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jasowang@redhat.com,m:bobbyeshleman@meta.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:horms@kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oxffffaa@gmail.com,m:rulkc@linuxtesting.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rulkc.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0B0E6B90A4

On Tue, Jun 23, 2026 at 06:38:19PM +0300, Arseniy Krasnov wrote:
> Logically it was based on TCP implementation, so to make further support
> easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). This
> patch only rewrites flag handling (e.g. it doesn't change logic).
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>


It seems to change logic though:

> ---
>  Changelog v1->v2:
>  * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
>    already added.
>  Changelog v2->v3:
>  * Update commit message.
>  * Remove one empty line.
> 
>  net/vmw_vsock/virtio_transport_common.c | 47 ++++++++++++-------------
>  1 file changed, 22 insertions(+), 25 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 09475007165b..41c2a0b82a8e 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -328,38 +328,35 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
>  		return pkt_len;
>  
> -	if (info->msg) {
> -		/* If zerocopy is not enabled by 'setsockopt()', we behave as
> -		 * there is no MSG_ZEROCOPY flag set.
> +	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
> +		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
> +		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
> +		 * handling from 'tcp_sendmsg_locked()'.
>  		 */
> -		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
> -			info->msg->msg_flags &= ~MSG_ZEROCOPY;

So previously without SOCK_ZEROCOPY, MSG_ZEROCOPY was always ignored...


> +		if (info->msg->msg_ubuf) {
> +			uarg = info->msg->msg_ubuf;
> +			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);

now it's not in this case?


Maybe the right call, but saying "does not change logic" seems wrong.


> +		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
> +			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
> +						    NULL, false);
> +			if (!uarg) {
> +				virtio_transport_put_credit(vvs, pkt_len);
> +				return -ENOMEM;
> +			}
>  
> -		if (info->msg->msg_flags & MSG_ZEROCOPY)
>  			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
> +			if (!can_zcopy)
> +				uarg_to_msgzc(uarg)->zerocopy = 0;
>  
> +			have_uref = true;
> +		}
> +
> +		/* 'can_zcopy' means that this transmission will be
> +		 * in zerocopy way (e.g. using 'frags' array).
> +		 */
>  		if (can_zcopy)
>  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> -
> -		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> -		    info->op == VIRTIO_VSOCK_OP_RW) {
> -			uarg = info->msg->msg_ubuf;
> -
> -			if (!uarg) {
> -				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> -							    pkt_len, NULL, false);
> -				if (!uarg) {
> -					virtio_transport_put_credit(vvs, pkt_len);
> -					return -ENOMEM;
> -				}
> -
> -				if (!can_zcopy)
> -					uarg_to_msgzc(uarg)->zerocopy = 0;
> -
> -				have_uref = true;
> -			}
> -		}
>  	}
>  
>  	rest_len = pkt_len;
> -- 
> 2.25.1


