Return-Path: <netdev+bounces-244341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BB4CB521C
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 09:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4C19300A86B
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 08:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3B729C351;
	Thu, 11 Dec 2025 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ulqw3Hi7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04A1285CA7
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442298; cv=none; b=GaMRVLFICUYLX2ON82yduuFOUPgvQBB7BVaMEgc+nSad/0Y8MPLiPxcly7qRA1mu/MGXDxR6BvUnZnd/fpgnOy3qx9SF5dF6AU1pTpnhmDjclMD2i3ZeiVNcnCMsNHyUHPwv/FyV0O6K+9LTRIHJG3VxMQLzDe+0Kah7+yJYKk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442298; c=relaxed/simple;
	bh=rqOciKOGlRMnIs2IsSG8/n7lvAuH5dsUqS/rCEgD3Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ps7ThCBK1DAutXGGCJzRB85j/DNUCGYO5gf/xAtyc4MZWEDFm70zKawrphQTuWMy3e+qgniVazNibhXiWdPiAp+RTPUPvHUELYVQpyM8l4FpODrMqhKZJv9REFWvPsN9LvikjsJMkmL+/3F9mC2Wgc6LsR49GcAbRoHizuEFv80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ulqw3Hi7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so7157815e9.2
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 00:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765442295; x=1766047095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Sg8nQv6XwVOonN2RpR1c8Sf1QdNCd4fo1IwTQexW1A=;
        b=Ulqw3Hi7BLzoFD1xv/GnBP/sLeZAV+7h8oqYU7E2Uh29DdEy8B7CJkWiyo5Tg0+2bX
         AJnzxvfY9vOyUlZSViaeqypZnDZDuhic85bTHY2b1ZM8tN2l3Wthzh4worzEqd9R/N+5
         h3FcDOecBXAFBOfO5oQhzzcdB6DHtN9KcP1o4820t25MdIuMv6bdo3DTkWa2sk57nvH/
         UBRws0Dd15/SywfH1fmvDAYZoeodJdfzC6i2ZZlwbNl+dpHXs6MKNJXobr5Wb1CbpYJm
         IaYkIG38UL+nnQdhF0k7w4tYubx9aQ1HTw+XU1P3AduF6YXRP1vfoATeahCXfa6fxNNs
         VglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765442295; x=1766047095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Sg8nQv6XwVOonN2RpR1c8Sf1QdNCd4fo1IwTQexW1A=;
        b=W33B7OAa9ritepKm8rubpT+euKyH1WrU67dQ4p4WtzreLUwAQYx3fu9XJf9jbYuDrt
         FzTpSqaChNLZpRgqY33+Ye+BXqKUTbZIpzSj6RORkPdJSS1Lb0325fO7AqfrmooUj7Su
         NSbDGBeUU9SzoEfUXxlZrV495mLPuVFVLNAXcrysSGV/GvjUH3pL+qBu3zePaXzba1Bv
         uMxq/o1c71Ow2XrUYyGUijd0Z32mDO5qN+rmDm6yt0zWnepDOZQG5AmKhk1BwEUCvrrk
         bsNe0c1IHAJA91yZWrTESTOIzuh5gDvHNrTzL1XH1NbdJIQiHho14whCa54muGGwWurl
         ihpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6wdxRgRm6aCqC1ihCYaJmZrEwlhMfMXyQb371g5WckMBz3flBbxAwUNo/8cMwSes9PjuR+Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzReG0jPlOZXcsbtENsNP6KMNoDWY8bzmLKQIJN7+nTeTRiKEWG
	GGGi27Io7sS5eYQdcvnuZnlDcW9jKpx2qsvxEldJS6Y6e8aWjSoV77PtWknXXcYgjAk=
X-Gm-Gg: AY/fxX7HW0bRRmJEpJ4R1H+sBj5O8Jv6wbCOt1XecqPk9+woheZq42YgwdZ3Uitv4gw
	FFDGBJbDaIF0eWyqcRRwf2vcXf7L1Ub7rMF9/MZzxcPsqfb/3LeTYGZ61wViH5vqLRpJzGvUiZN
	lDIz3N7VS5mP5UUYsMsJkXpdL6DGrlDIw1kZQhv+Iry17TdIwkXapMTQP+RfvMgmG3CGBw2Q4zc
	z+/72/4NO8aLQGHB34y9+OmtS7wTI0LqP58JUaEZjD/z1UZqt1iSDFccy502IKwV3jFO1cgHoHq
	62dGXTtrvhABVV9/7OK3K3TGxpJNolcxi4lI0DwRtUQOPvS0nw3TCax6P+PMJBqyUxpxNLHzJAD
	qi8E8gDN6OxShPviF2jtPijoXNhYyQE3L8f92iwgIM0xWEkZu6U1qVTSPe/iZ/qFaz/qpl3vTDh
	dkgzxnwUqQRaHzC3bH
X-Google-Smtp-Source: AGHT+IGSsWe5a0d99Xs6fnmOMLI4LBdo2k+QjtiypzD0IVANglEDUotcgPQFMk6WXuHYX1bSUfn69A==
X-Received: by 2002:a05:600c:c165:b0:477:6e02:54a5 with SMTP id 5b1f17b1804b1-47a8378cdf5mr49788055e9.18.1765442295248;
        Thu, 11 Dec 2025 00:38:15 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89f74284sm22968035e9.9.2025.12.11.00.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 00:38:14 -0800 (PST)
Date: Thu, 11 Dec 2025 11:38:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: Fix error code in
 virtio_transport_recv_listen()
Message-ID: <aTqC8rhgHmxC5fAQ@stanley.mountain>
References: <aTp2q-K4xNwiDQSW@stanley.mountain>
 <xz4ukol5bvxmk2ctrjtvpyncipntjlf4bdr7kjdam2ig5gf7ho@vuuwwu7asj7i>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xz4ukol5bvxmk2ctrjtvpyncipntjlf4bdr7kjdam2ig5gf7ho@vuuwwu7asj7i>

On Thu, Dec 11, 2025 at 09:30:06AM +0100, Stefano Garzarella wrote:
> On Thu, Dec 11, 2025 at 10:45:47AM +0300, Dan Carpenter wrote:
> > Return a negative error code if the transport doesn't match.  Don't
> > return success.
> > 
> > Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > From static analysis.  Not tested.
> > 
> > net/vmw_vsock/virtio_transport_common.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index dcc8a1d5851e..77fbc6c541bf 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1550,7 +1550,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> > 		release_sock(child);
> > 		virtio_transport_reset_no_sock(t, skb);
> > 		sock_put(child);
> > -		return ret;
> > +		return ret ?: -EINVAL;
> 
> Thanks for this fix. I think we have a similar issue also in
> net/vmw_vsock/vmci_transport.c introduced by the same commit.
> In net/vmw_vsock/hyperv_transport.c we have a similar pattern, but the
> calling function return void, so no issue there.
> 
> Do you mind to fix also that one?

Sure.  I will resend a v2.

The check doesn't catch that one because the != comparison is
hidden inside the vmci_check_transport() call.  So I would have missed
it.  Thanks for catching it.

regards,
dan carpenter



