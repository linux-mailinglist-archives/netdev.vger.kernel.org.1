Return-Path: <netdev+bounces-292275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIgfJ3DlFmpIvAcAu9opvQ
	(envelope-from <netdev+bounces-292275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:37:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4345C5E4434
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5ACE301E575
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55935402BAB;
	Wed, 27 May 2026 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UVUIw1Pe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3DA403139
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885402; cv=none; b=Cfi19mE7NPomOM6ku8h1aBOyC7LTb+YJo7XdO9eJ2n8MkYUmpQnhz+OQhYJDHkCCqf4djZyuKSBhq63+f74/JJJHMnTVD2UCr/bTHzj48X34RghxC2xwbxuFDz13NEOdmUSisC41uAgtDejYygR6o4cBunz8RYHykYjRA2VTGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885402; c=relaxed/simple;
	bh=H7p6mpDtDLxmKvgOZ4pgS/ak1T+DvZzVyyf47SslWwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHuj0uioZlH4P684y4J2BHb0iwJ/5z2b+3Rn4EFP5B0pKHUrK2gdW/SmVrZ4JOYK2lqxQWhDQpXwW8kO/4z7MNu94s+tDZnDp9t1dB9hSfw3RKE6GgyXoVCW0klTg8FkjK4Q95SHq0goxyPQyCxK7TNSOcFnUJUGtCXoYBJFLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UVUIw1Pe; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-914cf9248ceso332176985a.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779885396; x=1780490196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oAXF5UZCW6iJvbxUWxjJToe/IDClMd9U7HBLuJfAyw0=;
        b=UVUIw1Pe+iVgP2MaWntCCcmTVdFtxJ43P4b9vkG6V1hz2oZ71ktASAYU+aXvwRtFzI
         4rmquspQgOIxfrJO7NE5Dfk+n3R9xiugHdCOzkWe7AYTGau3DVbRW89DDJrhC81sLaE+
         o6a6B18gLyrs7UQieFJwpEBol3hnlgs0gxkWfow1CvLpCIRXlNPoMJCkG96es13xPOin
         4d0BYlETpf3nX4upGpx0q00LdG5X8YdDbvKEf+fu3iB+XUkiBHhr4sI76mCB3WkEdpEj
         PTk67x4NA2ZHuWq9h9KCgW/rVZvP8Ncl51og1pGtrBnuYvzZHf6c6yfaTHPsQzPzcR1n
         17pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779885396; x=1780490196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAXF5UZCW6iJvbxUWxjJToe/IDClMd9U7HBLuJfAyw0=;
        b=VWGSC06bcFYr0DYxsk9nKOBjsTCqrZeFeVekgBHIT1Cmkzl0vP/bWfhtkvDu/4vfMC
         NynzjoLQ48LwkD1d++hbbYhbWZFgg6x6wuMSVoDeGvUlTnivBQUbQVZpJr8nGxHRD4g8
         10u8bBNHHvHy8sgt2+VJK/9UtsisnJlNYL7OOvaED/UUXR2RsBQDwcwYDCJ8y7axJYhM
         s0YtyLxjYnOPJScuYB8+DEYkBJyioxQR/PVBNVvP7PHfQD9h39M2BeuXIaOcqJBkUIYV
         Oc0a2UIMwc/65+w8d/s9FblZ4Q4y8nauNPamOjasNxI7+XlL1dIq9BngMQIcwO3Y5V/I
         nBhQ==
X-Forwarded-Encrypted: i=1; AFNElJ8j6tPTh56V5cTytMx0dRGMI6gSx2cVuGE8IPRfnoil6W/3kkNiozlViatsegxn5zNT9L1lpqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygRU/l2sOSvpdnOEWWryG5rQAEWePP6kgVJ75cZp/x4rr4tJGg
	CP1uTx6kYbShpYv80S3p8DC1yh3x+m1Pm/01nM2iJ0Pryy76SUTgvJRJmwnkTMrg1rw=
X-Gm-Gg: Acq92OGy16dZpRYMmaqNxUot93otYwdMw71tMDqMVRO9pxWIqY0LLx38mcYIWevg1yY
	TNGXaSu9IVqEtRFKf4ilHmB33wUlZIJrWBLxneDG2MePuMzi4ZGzlwBryEEyBpmLkRydJAEKDV2
	ehL+T5wde9nSYegTtEAwz1H7aRFIVr8oVPpxlJyMudFt3uLuag5yJkkfMC1hGzRPR7uq6LUZXcN
	fjnQp0OLBhdUggNZITpPnhIJZLg1b4ODbd35Bhr+CTn5SbXtEyP+VlaXf8PLrl0oXciaM5foa3t
	ubY1LOzAFTOYFouQKwse6gguKQAdxblryjtgR+IFaCR6vVzyS2W9K4jO3KfyGnMCfN4BN7mDQTR
	4bSyMBBs+hCGGwFeRdQd0XyvaU05AFZKn7omvnrzu8LgaTUNy5jwhFNST8wNQhRmwrAYy6UzMSN
	RXhJrfS/GdJ6DriVanJBNIERwRDDFt8VbI75prVSLFKAApnkWojI9IIFpL+KbROCnfbxY4v2m9n
	6PROg==
X-Received: by 2002:a05:620a:438a:b0:914:aaba:8d2e with SMTP id af79cd13be357-914b49336ddmr3211226285a.14.1779885395945;
        Wed, 27 May 2026 05:36:35 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8800e1dsm455621385a.34.2026.05.27.05.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:36:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSDUw-0000000EOYw-0lyZ;
	Wed, 27 May 2026 09:36:34 -0300
Date: Wed, 27 May 2026 09:36:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260527123634.GK2487554@ziepe.ca>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292275-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
X-Rspamd-Queue-Id: 4345C5E4434
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 02:23:46PM +0200, Christian König wrote:

> Yeah that's a good point, I should probably rephrase the question.
> 
> I'm aware of how TPH works by adding the extra ST to the TLP.
> 
> But my question is how is that useful to a PCIe endpoint? What is the effect of the ST here?

TBH I've never heard Meta explain what their device is doing with
it. At least it seems to be super important to their device..

Jason

