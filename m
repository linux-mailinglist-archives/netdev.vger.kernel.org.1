Return-Path: <netdev+bounces-284423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCmBFDD2+Wk/FgMAu9opvQ
	(envelope-from <netdev+bounces-284423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:52:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C187E4CEDEB
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24097306C13A
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC2547ECDB;
	Tue,  5 May 2026 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ce+Jvckf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9kJ6hfe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA2F47DD57
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989122; cv=none; b=K2ewetCFt4sWxpJN9jNlAiu1bHJvIfalP4/FO8ejSaJU2igzFpipe9fgZRZTEcQOhCf4OlXgB1XeZutMPCHv4MaeI6CVDjrCSfQWwTI80HjvD5rBAj2mnCf7MgrGHyh+aQrwQ+sR8OxbdBFV/x65plDpdlpqzjotsbcyyIGbcwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989122; c=relaxed/simple;
	bh=FYwyJcUh1yGE5As2Q/7Ku6QHLAJWBWFMlQ45xYvu8B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpH+utKOxkeyMe+qrgUk+1VbB4jF4IOLFkXsVL3x1FTN56CDVt7CvjvV/fG70kJEkK16skVbGULCfvOSWbOhAiiKsUzOn1ooGX0sFruDtG0Tiht3mxKI6UNmBzVKct1FaoX4iP4IEgK6N1sc6AQlFdCZ2BEX+rr7X+2No515Jyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ce+Jvckf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9kJ6hfe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777989119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fB7sNER4g4DilTXabFUlJ4D1a4B/9taTrBXoE4PehVQ=;
	b=ce+JvckfeVDypvea8PrEAdlSCop5kAu1KFxR0PacpX3nCjjys1wLNRs7sc2IJFIzN5Pm6D
	MSEx5ae2TdCpdPlffDdI+7CiZEdCuKjZYUARjEK5Zyu1m6TS6nx2HcDgveZl/U4xSP8WK0
	ipTdGh1qrusUkIWflterRhniPejKLdg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-WvhefAJxMNqLINnR3kcH2A-1; Tue, 05 May 2026 09:51:58 -0400
X-MC-Unique: WvhefAJxMNqLINnR3kcH2A-1
X-Mimecast-MFC-AGG-ID: WvhefAJxMNqLINnR3kcH2A_1777989117
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-449dcfe8005so4365537f8f.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 06:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777989117; x=1778593917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fB7sNER4g4DilTXabFUlJ4D1a4B/9taTrBXoE4PehVQ=;
        b=N9kJ6hfeziR9L54uFCw1qd68Fb6j26vTNLiIhyLG62rdVROFavQYgE7uvYSBZz4FEu
         bfxy1VPy0YOhPhuGffpSdvLhJyuj894vNYzTOF9NDNGtGcDJ1Jq85hzZEdXwQgmVnFCg
         f4wo+MFMzmy56717skPLH79f3rgk4Kene6eyJgPFr/skVScqZJVJyxi0PlY2LapWgzD8
         OW8A50mm5QTHZgGXkyvJufOicZAmq1ldPi2QahUZhGwcWvhZDhGpK9gXlqXmnUgS5hIP
         X47mpzEM8zFiDcn6PXYrmtlonkjnexKfQ72uk2lsgMYgPntbj0Cz4uDH6jWyF3rxl+P+
         67Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777989117; x=1778593917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fB7sNER4g4DilTXabFUlJ4D1a4B/9taTrBXoE4PehVQ=;
        b=X2erKPkZGn+4lN+sb6WE+0EYATtQgofEXpU2JwNPVex48ziLOuGna2PZV7Mu0uNho/
         3gmtnmRxeT6DjBlGfcRn6QBHvtMoFzo+g6/tjTApIG/5bXzK1OvDm+mldwG/3cVJO40X
         RUnlAsVbkf8Hik1EpvXoOnC13yMffMLbpwN6QcjUpQCjhTKz1rDRs9Z7zXVw+WmOM9mD
         5FFSBQ4akgc9r9ZJu+3IBxxNuzrzjenEyA18IIomHU/02zLsEvxvWfp5P5pKFRO37reH
         sA/HAt7S2irNt5K5JtXXhbhVsO+940vYEisV9jfVpRXMsA0u5W6PtP2Vw3drJgDIkRlt
         5mVg==
X-Forwarded-Encrypted: i=1; AFNElJ+/sWutaRtaZGt4cSgdAJUxDN1zb0eUV+gCOEUKJ+ekRLjGnwgkTP/hM4TSslZqrqZ8aRU+RIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8TnFVde48hIkeboYKt1rhi82fuJCnU2RV1tyjEnNF/cGcyXAv
	IBGUbLB3FeufGVaT1wBVtDna9O8NLDhxzMgW2Vb1ZDGKapdskcEPdlEt7DgxAqEGNsIq37Pd0ei
	x2Hnl+5jDyvAu0KZvHhhqnGHAFT6+Bx8dtCBV6jxcvdkjrjp3b/ZS9D6BQA==
X-Gm-Gg: AeBDievYlb5CVUDNLZb+Jw5IACCMMqR7Mjbrg5pfJLiOASpK5SEzsOefSPAJQLIc88X
	BJkNxAEJQFnSgRFfgW1+XPjoEfwviEYvRE5OCIurwaFrQ+eViIrF+QCzGpBIkFb103lGGxmp/xb
	HE73H+fc4ey0SHbf+f8tfbi9LpU/4QRiYDhXsjplRx/WMjy6A2+QO1eMpF/rKVXUED97E7HwLCH
	0Criao374FeTnRiWK9ukelWZqf15QsYM3gW8YT4zr1Vhmb0LjnAfeEtyXhEfyLU/MZKC8QBJ5/7
	dN6HeSby/vXyRSYTTCQGJyT0RkctCMg0RTuYAxUhv1Hvt8bO55goDQLgpT2+2jmhmQKEeBC0rL3
	ZwW8HRiZKJJ7YO6zdYyZ+X8UrjfFrOx4+oURWDT5I6o/lUXdLzCH7CdkIJ2VM1gvzcEmhAH9ONA
	==
X-Received: by 2002:a05:6000:1841:b0:43d:714:34e5 with SMTP id ffacd0b85a97d-44bb5b4d3cdmr23938887f8f.24.1777989117082;
        Tue, 05 May 2026 06:51:57 -0700 (PDT)
X-Received: by 2002:a05:6000:1841:b0:43d:714:34e5 with SMTP id ffacd0b85a97d-44bb5b4d3cdmr23938787f8f.24.1777989116454;
        Tue, 05 May 2026 06:51:56 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f2487dsm4641869f8f.35.2026.05.05.06.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:51:55 -0700 (PDT)
Date: Tue, 5 May 2026 15:51:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afn0ZdvZWswBuDMm@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430122653.554058-1-edumazet@google.com>
X-Rspamd-Queue-Id: C187E4CEDEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284423-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oasis-open.org:url,alibaba.com:email,sberdevices.ru:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]

On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
>virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>
>virtio_transport_recv_enqueue() skips coalescing for packets
>with VIRTIO_VSOCK_SEQ_EOM.
>
>If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>a very large number of packets can be queued
>because vvs->rx_bytes stays at 0.
>
>Fix this by estimating the skb metadata size:
>
>	(Number of skbs in the queue) * SKB_TRUESIZE(0)
>
>Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>Cc: "Eugenio Pérez" <eperezma@redhat.com>
>Cc: kvm@vger.kernel.org
>Cc: virtualization@lists.linux.dev
>---
> net/vmw_vsock/virtio_transport_common.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> 					u32 len)
> {
>-	if (vvs->buf_used + len > vvs->buf_alloc)
>+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>+
>+	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> 		return false;

I'm not sure about this fix, I mean that maybe this is incomplete.
In virtio-vsock, there is a credit mechanism between the two peers:
https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003

This takes only the payload into account, so it’s true that this problem 
exists; however, perhaps we should also inform the other peer of a lower 
credit balance, otherwise the other peer will believe it has much more 
credit than it actually does, send a large payload, and then the packet 
will be discarded and the data lost (there are no retransmissions, 
etc.).

Thanks,
Stefano


