Return-Path: <netdev+bounces-249785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 912A2D1DC37
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C332E300DCAB
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4665938757B;
	Wed, 14 Jan 2026 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nq+u8htP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQlqzXfp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247D34F48A
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384679; cv=none; b=ePCM0iuut01g6RTwE6pIKZRZQjz0wp4HrfszmRzqh13PUAFM6LI0tUUO8B286AgAcs/NlT3lyro6iuVoIs90uxI05xBQq56hb39N2+QpxP9sbJJL2sg/UpL6aZNCheGDbv53U9e3/kmtY6mtLACn3ne928dPBj1mVoTrJaThbyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384679; c=relaxed/simple;
	bh=36C4TLxXEoaix8+fMcGoCyyRChcqMGjtLcHigyw3xhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDvA/1fhetwzBSd+755+Zlzif+AVRY5mvxfTAcvoHasrIYBnEj691TpX05ukFaBoGltctiffaVugrl2/ZW0Fidz/qOkEHCwFHabcPSnmoCMKQa4Eyzzbny8JTAiCF2temHrWsFDpXLVARHH8R/1s8KOnFadifE7BYDhsYaaUfL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nq+u8htP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQlqzXfp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768384677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XuY/fex5vMBZkn75cmI85OoF3EbBEOIpBs2f4KCfT7Q=;
	b=Nq+u8htPhUTfkJoQJcSAbrdTjZ21PQLmHKIRvI6fcgHC0hqM/XohE6bnmnXhBpZ7KJDD80
	lUbiPRDsVifi1xSyf/g068JfoPwSQ8Z6t9BZIbEuoRBnGyJ0zaqToGSda0e5byGM8QNJpL
	+ej0sQtO4LqRcLZ/G2VNpnnwOBKUd5A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-7t51fULwOMK3ZuTxzSOVIA-1; Wed, 14 Jan 2026 04:57:55 -0500
X-MC-Unique: 7t51fULwOMK3ZuTxzSOVIA-1
X-Mimecast-MFC-AGG-ID: 7t51fULwOMK3ZuTxzSOVIA_1768384674
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so10710265e9.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 01:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768384674; x=1768989474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XuY/fex5vMBZkn75cmI85OoF3EbBEOIpBs2f4KCfT7Q=;
        b=ZQlqzXfpnQ2pDruT5B8sjn8qsNjY+fkKLMytz1ZEgHfFX6TY8wFh7A9qnoylHljs04
         aoqh7AyDffeAZ20Wk2Adp7zDsXuFUn7Mr9kwwELULdrhwJWAlDPnQkNR4ABMwpEo9PZk
         5IGGRfboTdTUYYuPSdrNhwJQcFODTCcceTS9Af5ffLvPkv4cCb8htH0JkJPClaKJVVpN
         7BtESg5jyORObUkYjAwtfm38NbeU4eWg+Xy1AF+WREGfSjOIS/SKfKwrwP6Yo+177w9L
         6tY9Uh+kxLkMIknust8LfB4pw1bFwVPBhZtcnHHIm6+rH3VOLxMQhhDiF0/yS+CQVql+
         AOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768384674; x=1768989474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuY/fex5vMBZkn75cmI85OoF3EbBEOIpBs2f4KCfT7Q=;
        b=F0lFgyS8/MHimQp44dMFSeSd/djBSGpjJn0bGCpBmtBOgQTZUuNYN5p322wxqGnPHt
         09Go/qoQzjYzc2Inwn1i2S0yPq1w6hho9SBWPGi53TaXGq7SlTyAN3Rn/TrISbrYSuX8
         c7AfjgGjyd1O5X7xlQogupCL7v7ek4pUaBAKgMq/CIV/qIDorVK+/X/KsdqL5U7++kaV
         cX+ahGJwiaqdMglOKYsN40/k4GBb4v/bdNtQTIrIX9Whj6S81NNJOBqr0rfl5WBll7q/
         6/V23SuoTVji0w3qJ2YLku4PpNSlPlhrYbH0m9Div0DtVNQ1y9EMhAepmJzntrBjUDWa
         KRkg==
X-Forwarded-Encrypted: i=1; AJvYcCUCGmVMQmbdZ6nvXSMhihgTf5MsRLDAPitg0QWcUr7OYlxHQ1Cv6+AtuS70nNGWLMpSvOABB5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA3YC6OkmQ8IOVSKbUpS//y30MEZzqA5qvl35IOm7akd1RYWK0
	WXn8dWWaMkk1Kc1gANiBGhHu2ff+78WREfNBUB0L0E+Nd5VzJIWKOdlxp5K9skit3dDMTs4237N
	PZcZNhUUIg7ywG447Ga5eV2YdkmGXwmm2CrzPdRi4pF/6mC80du53ucQEwQ==
X-Gm-Gg: AY/fxX6C2XXZ3YpdNbfHcT5g3VR38VCxrEvsfpbIteE1gtsr8pXvoSbcrNkj3tuWWqw
	rS1gsP8GfJzPpT2HcOpn2MshS1OpcM7Masw/VEc+A7rtzFc//yx+pTA4vi+hmo1odfkRh/24SrT
	aziaPJIzQ+D+XeQFSuAnMXNBYdyqpDkl2FpRDyEZCEoSQkHG/S2n2FQ49lNXtCMnYY9KxEucr2O
	hwFEAAjZRc2PDzlf6GoGID/9og55uPPmqWQHSmi/EUZWgGG4mBcYqNohF3Cielgjd/6Y4aT1bZ6
	XkpopJ/iCSlktCIyRPG+2D/nI5x17fkqrWGquhH2sJJGPXFmJYTU2PRMUPqYBkBPMWJfVO8igP2
	UPYV27MHT9alRgB+xj2U875P/2DD//ICDUUJYdAZcqoO4jT+5mzdieodGaM38Wg==
X-Received: by 2002:a05:600c:8b76:b0:47e:e2ec:995b with SMTP id 5b1f17b1804b1-47ee32ff3fbmr19462285e9.9.1768384674478;
        Wed, 14 Jan 2026 01:57:54 -0800 (PST)
X-Received: by 2002:a05:600c:8b76:b0:47e:e2ec:995b with SMTP id 5b1f17b1804b1-47ee32ff3fbmr19461915e9.9.1768384673944;
        Wed, 14 Jan 2026 01:57:53 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee0b4559asm19833435e9.0.2026.01.14.01.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 01:57:53 -0800 (PST)
Date: Wed, 14 Jan 2026 10:57:47 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] vsock/virtio: Coalesce only linear skb
Message-ID: <aWdoY6JqlRiwfFfJ@sgarzare-redhat>
References: <20260113-vsock-recv-coalescence-v2-0-552b17837cf4@rbox.co>
 <20260113-vsock-recv-coalescence-v2-1-552b17837cf4@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260113-vsock-recv-coalescence-v2-1-552b17837cf4@rbox.co>

On Tue, Jan 13, 2026 at 04:08:18PM +0100, Michal Luczaj wrote:
>vsock/virtio common tries to coalesce buffers in rx queue: if a linear skb
>(with a spare tail room) is followed by a small skb (length limited by
>GOOD_COPY_LEN = 128), an attempt is made to join them.
>
>Since the introduction of MSG_ZEROCOPY support, assumption that a small skb
>will always be linear is incorrect. In the zerocopy case, data is lost and
>the linear skb is appended with uninitialized kernel memory.
>
>Of all 3 supported virtio-based transports, only loopback-transport is
>affected. G2H virtio-transport rx queue operates on explicitly linear skbs;
>see virtio_vsock_alloc_linear_skb() in virtio_vsock_rx_fill(). H2G
>vhost-transport may allocate non-linear skbs, but only for sizes that are
>not considered for coalescence; see PAGE_ALLOC_COSTLY_ORDER in
>virtio_vsock_alloc_skb().
>
>Ensure only linear skbs are coalesced. Note that skb_tailroom(last_skb) > 0
>guarantees last_skb is linear.
>
>Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport_common.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

Thank you for enriching the commit message!

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index dcc8a1d5851e..26b979ad71f0 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1359,9 +1359,11 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>
> 	/* Try to copy small packets into the buffer of last packet queued,
> 	 * to avoid wasting memory queueing the entire buffer with a small
>-	 * payload.
>+	 * payload. Skip non-linear (e.g. zerocopy) skbs; these carry payload
>+	 * in skb_shinfo.
> 	 */
>-	if (len <= GOOD_COPY_LEN && !skb_queue_empty(&vvs->rx_queue)) {
>+	if (len <= GOOD_COPY_LEN && !skb_queue_empty(&vvs->rx_queue) &&
>+	    !skb_is_nonlinear(skb)) {
> 		struct virtio_vsock_hdr *last_hdr;
> 		struct sk_buff *last_skb;
>
>
>-- 
>2.52.0
>


