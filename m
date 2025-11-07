Return-Path: <netdev+bounces-236825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCD2C4062C
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 15:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91CF94E883B
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AA931A065;
	Fri,  7 Nov 2025 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJiKOAMq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2551F1E5B70
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526017; cv=none; b=IjdnwLy2HGReV6WH6jx1DRke3tuLMEfa3F7yrPK9SldriFnaM23tdCd65dbNbURxXkuvwjHB3nHeVDMwLmb5ahajT/+Ly2z8TjWNwFVzOLhKnqobrETqA2vyUC7AUvMZYD+QTCsbGmrXcfqXBGB/QYn0CEZXmlH1nhm7g4lTIoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526017; c=relaxed/simple;
	bh=VYv4VbKIBTMGATkaXkrYMjm0YUGRwfUgEtijjdf3tVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7Lra3nAM0vu5jrlaJN+M6vex12cJyKAY4b2Wjgu27xPO/KqnZIkixHP/Bry1VEOAW6JHbxAQ5cpjmfL2kOQQT2wlEiLGJkIwxcmG3w6bcA5Cfq4wsWxcAfieiFVKJ6JeLsnyb7KaYEn6VFayF2sgv3HuUrCxgPKLiy6PI5WGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJiKOAMq; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7868b7b90b8so7987747b3.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 06:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762526015; x=1763130815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVuiPgxoIdFU9eK0ffLkE96ijOOEBPKS5XMimJNBPpY=;
        b=CJiKOAMqKo5D/1mQZK/h+5JUwB1sEFbxe7da0jogRS2cdglc4CZAXt5rzdN8HmCjGE
         tgP4SJRVa0+xqTjl71qWyhEuCYikoE9ZbY1xXX+BU1brjW/tlzk+nUqhmxH4hVfNZDdr
         wX+gYYNFv7MeHydzMVO2QhwWc34+dwGTJpXHfcUFFKwjX9zblxMY7qJ/Vci6Ygn/hPz4
         3RUGu8DWjp0BWdJSVAqZgSIN/Op1d5qMMeGSCj6YBl9k+Zvj6B5xTsp1G7fx3n+BgyOU
         bHaA6FmaNwn1U49b6340jedPawyxnkxZGvCo1PJ3TZQqKW3lZQsxznTENmRO0RnRixPW
         2Z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762526015; x=1763130815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVuiPgxoIdFU9eK0ffLkE96ijOOEBPKS5XMimJNBPpY=;
        b=bW7VeR6kY2UlPRj7a2L3hrzFGSPAt6n55x0yPJ5XFrt5mXmZ1M5qptqrQmXV/Wrexs
         mMKgrebqceFnDaA5rVPPR3iJHaTlpfx4C4dtzXRvEb+xRRF9We7+CPJ109/zyCHUgIbi
         YIEOHSIhOsmeKFeh888mxefi7uy/855yRp4vzYL/0KYgczfIFU5Fbas5VFMFJwlCm4rq
         7sWFWoqkrWu23YQkerGdwmsdecDtE6/winmrhJJiHnFPZsN3Ohq/N0vaTJpf8S9Bo3ym
         BIaB/A8FNVjNq0hil94QnHa+2RadxCeVoRo4dNRgFGJdh6wkNTS8lRUCp7gFtjr/8VID
         Pxag==
X-Forwarded-Encrypted: i=1; AJvYcCUDhvEULTyTDrSbgkMuBLsDrC/JKIfgQ/KWtVeQATgA3UFWxuLExEu66wz2R9Cd/tb5w94sfIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqCdBzgt4iTSlAtcvvctoLittiqepUHUfy8wybm1vSJMKKNDpG
	5d5372Yjyj7bB8ySy4LBkp4qfFiezY0ZPR8SW+s730EsgUMRJhUoeBhn
X-Gm-Gg: ASbGncuUPNMYYyiwyy8K7e8MI9lK2WmPSirQrLQTkjZYvurhUzP91VunP/Qm7HOObyI
	+lLESWsI65DoJ1UKN56vLQiLVR/nn9NkCrzr7r3AfJfQIlYI8CPwmfP152LdX9cpqnNmeHTR6ub
	11rxy1nFIRBO4t6+WDx5/SZcyFSaLcch/1YL/QeK8Oq4RFITwqf3xz7e8WTwC3mFuPlwIGoyDsm
	EVtiH/51PjlwdpxnLKMPEPGeCmfPjLpbLq6ZJLJx6Jth5Ny4MAZzRgT2+SXYy+nVX4YFdj6/1Fg
	Gl+YTTEvcB5/2kDNwGWO0ZVFQtn3uyf7ofaUeTcEGMtJREgCAJi2l1ephVVr7k010tl4SrrtzB5
	H035aczruoN7b7QXkjXVsaEwdLP0nvbRd4qkgBASysq4CrtgG0CKydLlDRuCY/SLigsiLPuIPJ2
	iC9sv5Vx6HTEMa8rDWYsR3t+n/qeW1XYLr
X-Google-Smtp-Source: AGHT+IFGSfosbX24aGud2tUIAN0TjKPBi0xBs/kxp0rskWuLz9Gqspfd/w8KLNX31uQmkNqo82qJIQ==
X-Received: by 2002:a05:690e:4183:b0:63f:5785:a201 with SMTP id 956f58d0204a3-640c4170b06mr2559782d50.15.1762526015073;
        Fri, 07 Nov 2025 06:33:35 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640c72fa3aasm605605d50.6.2025.11.07.06.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:33:34 -0800 (PST)
Date: Fri, 7 Nov 2025 06:33:33 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 06/14] vsock/virtio: add netns to virtio
 transport common
Message-ID: <aQ4DPSgu3xJhLkZ4@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-6-dea984d02bb0@meta.com>
 <hkwlp6wpiik35zesxqfe6uw7m6uayd4tcbvrg55qhhej3ox33q@lah2dwed477g>
 <aQ1e3/DZbgnYw4Ja@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ1e3/DZbgnYw4Ja@devvm11784.nha0.facebook.com>

> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index dcc8a1d5851e..b8e52c71920a 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -316,6 +316,15 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> > > 					 info->flags,
> > > 					 zcopy);
> > > 
> > > +	/*
> > > +	 * If there is no corresponding socket, then we don't have a
> > > +	 * corresponding namespace. This only happens For VIRTIO_VSOCK_OP_RST.
> > > +	 */
> > 
> > So, in virtio_transport_recv_pkt() should we check that `net` is not set?
> > 
> > Should we set it to NULL here?
> > 
> 
> Sounds good to me.
> 
> > > +	if (vsk) {
> > > +		virtio_vsock_skb_set_net(skb, info->net);
> > 
> > Ditto here about the net refcnt, can the net disappear?
> > Should we use get_net() in some way, or the socket will prevent that?
> > 
> 
> As long as the socket has an outstanding skb it can't be destroyed and
> so will have a reference to the net, that is after skb_set_owner_w() and
> freeing... so I think this is okay.
> 
> But, maybe we could simplify the implied relationship between skb, sk,
> and net by removing the VIRTIO_VSOCK_SKB_CB(skb)->net entirely, and only
> ever referring to sock_net(skb->sk)? I remember originally having a
> reason for adding it to the cb, but my hunch is it that it was probably
> some confusion over the !vsk case.
> 
> WDYT?
> 

... now I remember the reason, because I didn't want two different
places for storing the net for RX and TX.

Best,
Bobby

