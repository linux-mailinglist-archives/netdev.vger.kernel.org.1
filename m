Return-Path: <netdev+bounces-293255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGB2Lyf0GWp/0AgAu9opvQ
	(envelope-from <netdev+bounces-293255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:16:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6640E608600
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F74B30499A4
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA60F348C4A;
	Fri, 29 May 2026 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="W6mucJMI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67574348C42
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085494; cv=none; b=lKn6o9XAvXW7SJUV4yKT9X3u4vJpP0NYygXx12ojiP4nl5kLXzwsQlCtl26aQl7GcNMIhj1pWQTcAyf5PvYpNh4xguU65iqL6uOauRLmGGmgQJjovPbG9wHCWdmgt1YX6vVrNzuA9qf572x9L7lWFqYEIMNmg4AkjG4rd5daRTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085494; c=relaxed/simple;
	bh=yIjjEsSzcNVlj5Jerb5VL9COIWs3RWb5zUy94AhWr9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pS/TxtNSB3wdShL4/oV5OHQDYsSY4alSgZt7TFJHTWzy5W0n4Z0StymmTr9LQi3YaW2RQhJl79BFjuvTCGoU8k6wH+eRaH1nNsVCfyT8fgAN7AbmfOXYA04rWF/BdjPullgueZxt+bSs2BJqC4aQNb6NHeeJd5tvEVb8kMzNfSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=W6mucJMI; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-914bd98faafso600212085a.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780085492; x=1780690292; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x50nMfXuC2+erTFJFRG2pVEkXmZORi5k9T8WBzn0C8s=;
        b=W6mucJMILm76P1OvgIkeoQrHk1o7XL8eEki7XJZS1XS2OjCf+Mt31OyMtZjR2qaphh
         JYplHQ+jawZn32wdHnTUZ7/BfzMzKsTBm8Fig6rF907+pur3pR03NcbXI3r1E4jPnjWi
         Pj4l7r9Cd2P7VD6P6PcOKOr4ri/urmF4R+FIVF9YA78pTdvWQQSYvF7Z7feosxpyprw7
         +tFE69MQ32W/Mxl0Hefoqfx48geK4OASrV2q31UfG3eYxFQEg3WoFwURPR8t8K7LU6Z6
         3WzIrlfGGwk+6WgLZUiy5+fga84k7c35MG0crSnEaA2c5absa3at7TeFsmJ2pdiwI3bK
         qt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780085492; x=1780690292;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x50nMfXuC2+erTFJFRG2pVEkXmZORi5k9T8WBzn0C8s=;
        b=tRHA2MtDE/gcYqf9Lv7TEED40EPRnkEVdlglwltlGwANJ3xbEowy+psnFsE/cAkMzp
         G0X8BVSw6FUtSynh1Zy1ldVcsfN8TMbC/vAltuhTdmnPHRTz33VQRgpA0UEaYY6GHBSI
         gdYqN7SW9BsVQm8a3nSgrX7y8/8CO9KGMNIzpKILZUZ7L2dzAn3EL6zHUBRKAGYi+08w
         WR1ZM4MBBl9x7rlti+jQL1lVUJRMVS8ZiEmdlrEGAdNXQzIKDt8imYLjrHwWnX0jZwMl
         hVqrelNFWg/X3Vu4LfRLP675OU3FLHuAFkKpi0jAQAQzf4hWKi0LEJ3WVbqMBF4cyGRm
         skRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+JbVkLFVpGRbF6WpIeG8w3OS8a+eatWNPKnUZWPSAQsviVt0+iScsnrZiO9rfjdOEwue3d7ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN2oEnwRWeF9j7c/OB63TQXDCGvQzXGPd1wBaWhzJhhJYeddA2
	rxNZRkPg9plCPERj5isso0O0jaLNqVUzcjYjZeQ+QR0F4lJ51v0sTGPX0ufxpsXON0g=
X-Gm-Gg: Acq92OG9zhcywEcTE8LTFZRuumdOt+zGsP1y7PFi1P+DNtTjvux3vgKSA+jqMKtWJrp
	iVicE6fXKeNghJe02I9QF5VaDgcUlDXgI9u6N743tmnOfKuzEl5ftPPmwFBpU7vQPl2DBBn+xap
	HoZxLD8BG+iSA3hoCta/67dXgoBPFJVr7DTia37W//jxzlQIEGlBfF/n6aSQBzYqRGokTbgBLAj
	jR0aeJjZz7Vcn5xKM35m5qfTlE5KVynPklTxmoGIDs3x38cSDXo+UYbMqBBLWJ10ZulgNfAA3B7
	Q4sJ6LK/nDaXGr7KZA8SAV4xh8JcMM+zOuQveURgFc078IdVN2I/e/V6d1i4NwyT4Cxksjwof82
	ShINkc36zXTvIwIlIJSUa+CLgOEaJrdAbvW70htnMw8j32T+KTOK+bfXIrYtiHhHMQQkbUxISaH
	PXSz6/ZPxEVdl0KCgu43qwjHCaSxn77vZ3oDqW931OWVspAoAOZjrICkZJuL00eUQdRZBaKKVh2
	FFneuLGVBANNEHc
X-Received: by 2002:a05:620a:649c:b0:912:671b:d090 with SMTP id af79cd13be357-9153d999728mr194543785a.24.1780085492316;
        Fri, 29 May 2026 13:11:32 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153244de53sm312617585a.8.2026.05.29.13.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:11:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wT3YI-00000000q8h-45Mx;
	Fri, 29 May 2026 17:11:30 -0300
Date: Fri, 29 May 2026 17:11:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260529201130.GU2487554@ziepe.ca>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293255-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6640E608600
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 09:36:00AM +0200, Christian König wrote:
> On 5/29/26 08:34, Zhiping Zhang wrote:
> ...
> > There's no in-tree vendor PF driver
> 
> Well I have to admit it's a bit on the edge but this sentence is a
> show stopper.

I think he means the device is not SRIOV. vfio-pci is the in-kernel PF
driver.

> DMA-buf is an in kernel interface for buffer sharing between drivers
> and any change to it needs an in kernel driver as justification for
> the added complexity.

vfio is the in-kernel driver, this series fully shows the in-kernel
API using vfio as the exporter and mlx5 as the importer. It certainly
meets the standard required to show in-tree users.

> When you have a complete open source driver stack which utilizes
> VFIO passthrough as the interface to communicate with the kernel
> drivers then we can eventually talk about that.

That decision is not up to dmabuf - what VFIO subsystem requires to
accept a new UAPI is up to the VFIO maintainers.

DRM and VFIO have very different views on what is required to merge a
new uAPI.

Jason

