Return-Path: <netdev+bounces-254372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB4JFNFEemn34wEAu9opvQ
	(envelope-from <netdev+bounces-254372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:18:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C87BA6B57
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13CAC30DD7D9
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC863101DC;
	Wed, 28 Jan 2026 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NSvCk+PI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A162308F1D
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619462; cv=none; b=hiD8jPHRU69EIDMNlzYT6UL/yxA5KRF0hvnoipBGsia+RDnb99Nx2RZ6q5AqMs24FgKLqauy082gi08D/izl9BoAszCifsz1CR8mLRY5SM84wQcTQkyxWCDIP8bQXAE/0u0uhcQsj+NCfEn3uqNCRHpOk4nwxmjnSEgNMAoycj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619462; c=relaxed/simple;
	bh=4K4OLHaqM/t/HXgyCFJoyTmAZzqjtCmqUqovtxJuMsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5XWKZqDPvq5q+rJ+Adq9dLyRDlp5rvcQ+HB1z6zsva2Dqb6ViQjSGnaQLImSakQRtsMZPkwQf0asdUOAyKLft6p7WTqEK60ukvmUYlJ6BEytkg8fYesZB0sWYIcMp24/JR5JqxTo/rHRzd0C8RWWzvT5zRSh68IFxIamrEh0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NSvCk+PI; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-501502318b1so68882961cf.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 08:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769619460; x=1770224260; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x5PPbKkTts0Y3gVIJ6pivviiM6v1XzmJpI/qsHikqnY=;
        b=NSvCk+PIgibHYCb0s3AdIGmdLI4QoBnFvDwKJuBP5DmiVW4yY79sJBf8qYBpOmDO5W
         s8uZeICawl1lVSPl0j34z6nCA3cC8ov0GbfWxFDPCYv1SaI3ci/SCe5k3h8tsfigeUsY
         RvLaI+VQqmAxSVnTJk47FWIRbTEfLfdLiT4oJ7Pa5gNT9oLy5IOaTMH34pLKFzUbPqvy
         KbQGVbRBLnVQ9UsP21MMKtDg6LPsUeLR9BRcU593Nmdr9qhbLnsy5O5phNWpSAojHfip
         oxPPubyWn1/0lV1ho0SvwtUhVoXMzhD3/k7PzFHAWVXpEi1TqTuv/tXK54d994vX3vkm
         9MPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769619460; x=1770224260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5PPbKkTts0Y3gVIJ6pivviiM6v1XzmJpI/qsHikqnY=;
        b=MGOABlSFfUL7Lshub0hQ/259feiu2z9IcTq9S0KCa4qGLWJzqkSYtreTRT2Ps+OZid
         KmIRGRSFGZftkryV60CLQd7CBxDl9s7Crsii7IkGYAeI7iBHAaVyY1MRc5gmfnlBiqkG
         Y6jPgiUojMOY0pcxg9ZqAS71XPs2LjcEYZ1IlloBSZXMmzaclVMCe9ytIjAqaV6l1H5U
         rD/+ZgCI4l/typTaEc6QtkfsLjarM/FPaxUTyizJXV05XfO3KaaXAk5zeGn7BTYPigVx
         tADzsElM8DGFJ6WKsdZPLxd+wy4/H5D1gYCS0HbcPI/2yBwUgMvr/iR6S/RjaKgV+MqT
         eTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY1/2UwG5P+a2Bc2eZUQ59Yu0nvPjITXNdVOetmG7Om5ry90pbyZfrFpykZX2rHPGI23k8Mk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKkvwCbPeplX+S4X8VtVftTwtxYDNDBb0WDcxvZKdXE3ShkE4X
	yCc6lV0SOvo9lKEnbc+yKwMvLgd65EMR2FNJakK42q+rqKXrc27HiO5xGWLXKeCR13E=
X-Gm-Gg: AZuq6aI4C+tOYgu3bFcdaA4u9NV5zzs3NMDOgBq6yfDsHCkUxYZLfxl6fY6TXjMMou7
	fz41G8EqFIgzan/Q5J6kW/Hjrxq5KNyOPx/ZGaErrk82yvVx9NHZ/YYfHaEocwN3PWvYF9Ebxd5
	n+WpGnavhygxAnp/eOCOgG2eAlHLwGckj4ikuN3nmFbtLt54Hxl8MqnbAa5TmACnP5iDkQIGxRM
	+CjU6s3cJeCPZzhMkJwIy27jICeEKu3mLSpbjF6K5TM+uWwzNvppyQ8HuTojYKGUjbSvFJw4Zgo
	SoktO1oT5JnY0iTgjfB3kbiAN4LELj+pbWmViUO/GPd5eR7C0CssteY22TTVEhBwcUQiYMlBIh3
	NZ5wqpCnk181pxUqzcSUS5s/+egobNYuoNEsvYC7X4SSIuXvB8LvN1pd6kKMWh/+nE+IBFO9mv6
	jFhr8cRAyLyFI9dudLHWHU6hBLQ1k8ems4EKyv479i9BbG37oX+OXfn8DDBWDDbpMaBiQ=
X-Received: by 2002:a05:622a:592:b0:4e8:a6f8:e3c1 with SMTP id d75a77b69052e-5032f886480mr76621061cf.18.1769619460454;
        Wed, 28 Jan 2026 08:57:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c85b9sm20499826d6.24.2026.01.28.08.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:57:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vl8rL-00000009KeE-1DOy;
	Wed, 28 Jan 2026 12:57:39 -0400
Date: Wed, 28 Jan 2026 12:57:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Message-ID: <20260128165739.GQ1641016@ziepe.ca>
References: <20260113164923.GQ745888@ziepe.ca>
 <20260124011436.172058-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260124011436.172058-1-zhipingz@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-254372-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C87BA6B57
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 05:13:19PM -0800, Zhiping Zhang wrote:
> On Tue, 13 Jan 2026 12:49:23 -0400, Jason Gunthorpe wrote:
> 
> > On Mon, Jan 12, 2026 at 11:43:13PM -0800, Zhiping Zhang wrote:
> > > Got it, thanks for pointing out the security concern! To address this, I
> > > propose that we still pass the TPH value when allocating the dmah, but we add
> > > a verification callback in the reg_mr_dmabuf flow to the dmabuf exporter. This
> > > callback will ensure that the TPH value is correctly linked to the exporting
> > > device’s MMIO, and only the exporter can authorize the TPH/tag association.
> 
> > That still sounds messy because we have to protect CPU memory.
> 
> > I think you should not use dmah possibly and make it so the dmabuf
> entirely supplies the TPH value.
> 
> > Jason
> 
> Thanks Jason.
> 
> We already have an end-to-end workflow around dmah (perftest → rdma-core → kernel)
> to carry the TPH hint, across multiple patch sets. References:
>   https://github.com/linux-rdma/perftest/commit/98bfb3679a1e71ec96df6a6d6c8124ac66ebce25
>   https://github.com/linux-rdma/rdma-core/pull/1623/commits
>   https://lore.kernel.org/all/cover.1752752567.git.leon@kernel.org/
> 
> Given that, I’d like to minimize churn and use the existing dmah-based flow, while
> addressing the CPU-memory protection concern you raised. Would you be open to
> reconsidering this approach?

You would need to initialize the dmah from the dmabuf and then lock it
to only be usable with that dmabuf. It doesn't avoid any dmabuf work,
it just makes the whole flow more convoluted.

Jason

