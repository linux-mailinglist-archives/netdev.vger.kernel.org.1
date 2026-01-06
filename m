Return-Path: <netdev+bounces-247244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A74CF6223
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 01:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 501AF302AFF9
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 00:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952211F8BD6;
	Tue,  6 Jan 2026 00:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UUL7+GZ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0DB1C3BF7
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661082; cv=none; b=asiRQxPosyhpHU7xU/cqjWkvcjgrpvNXrdPgqqv3JqmEDprQbO73bpjMYMLBHuCe637nfR4nvuF5dMUG1bXfOcmwAXQc+JYtqVb4zRlXPhrIC5CKl3+Xmcw3rB0rww41nhdgnL5LJdgKBest6kd3+EFV4Hu52CrJv73X9bz8QHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661082; c=relaxed/simple;
	bh=KWvFDvXHT8S5dvDF1yI8ZG/GMpS/ULrliFX9M8TUh2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZpCMuzB6K3KePHYIKGqZEGSDYVcpehE4AA77EW+28y9+4RPRclKhnmWNWuysVqQbwl8ZA+vNi+7Yt9B7v1dy+BLUY/vPV2Ppoy1PCiyjajmVF3/dHyRHvnAHmrNIrsnEHzpAhWJxTFtooC5/RP00kH8RpysvnD3CXKn+Ll31BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UUL7+GZ3; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8bc53dae8c2so58123885a.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 16:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767661080; x=1768265880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWvFDvXHT8S5dvDF1yI8ZG/GMpS/ULrliFX9M8TUh2Y=;
        b=UUL7+GZ3a2PmrXbs0RK+LBv4xwA/xKvTWh77jr057j3BFwrpeqPWoL0Cz50sF0Kll2
         0MrO9BnnnIjJh1NK0+GoDzXJL/rrGji43Q9HMF8e06UtT8qQkGA1tW3vA1bm4Fgupd0q
         bNW9Lb/6GOiiTMt+66QLpNN7wghp4cBP4Z7UApZxqVlqLrrRMdW+bqjulHm9WqG3gbpw
         3EdpgPPeQy3so3TPap7EIoQspsL868iZGtbBaXjE5fpp92DJECwV9dOi3TGjZ10KIRr/
         6Z/lnkJM0HI3njqeVnJSLLfoJbZQZxe0R43IwUWmflG9RB319lWnTrGF81kiIknBJSfl
         /3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661080; x=1768265880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWvFDvXHT8S5dvDF1yI8ZG/GMpS/ULrliFX9M8TUh2Y=;
        b=STgnQ9A7VoPFdzaD103FPEEX4Jagm7vTxhxqQWupfJybqK0GGad/d3p298Z28R833c
         nL2CqW/5zOw2dqudK3jb4iSz3CbBfxtFJ+DukUPoRVG9I+woahLopGxBqCTJ8wtZfYcc
         dP5R4hUvqaoDFdy1ewrO0Jz7lIPj5cerLsmf4IXwAL+X8eDH+285E6UHzEOJfKY4d+Kc
         cyinRHuseFFBB1C46jJHjdMagK3qNevDOL87m2E7iK7ns0o7iPtE0uQUtpDN8fu4Vqsy
         S28uVZqyytFmfH0Aik6Y8cdobhCjj8nvaFKD5eCI2wJNr/7chcPSOnhqFipx5vCJiYJe
         gPaw==
X-Forwarded-Encrypted: i=1; AJvYcCVrq/rE0STk0yOeVAnMTVjwCjApjYS7OfF3M+HS2qplPJv2mk+4r/4lwWTYA0kuhfYXMiaMsoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEpxcj46I8xEaYQadDaBb6VUxH9RN94PWDkPDRTirbd4jfY7Uv
	6r+NamE826mzhG81+Zr1BTOQna7QrrJA3/ZPbpyHRVgaGJnGFZ1LSQi2Ex17/T9KBz4=
X-Gm-Gg: AY/fxX5BvJYKQ8vW7l0NFbO47znMUfwXNN0A2HZgnMbPZMQ6NreGNuKv3CbKcysinaH
	/lbJl2iuU/8ps/rxCI1J5KuvylsPvqU6alUAipSKHRpWMo10riR7nK+Dfezyg6OtAyZAkOsN40G
	1XBmhTqj/8tlKKO0cKlmoYFbur7pkh+kRLg6O/o7QTvSkAl+Bo6MEIqiF8UV4+GACfh7hipte+6
	Ydx00ikZERlxAD4t01T8aQ8n+XHT20aTU953MGiUQtQvR0sDCzIFrSQTfMPIhi0KPLfHqqwoq3H
	GnLQKM8GUqhMBS2s9SD8TocrQ7Szv2HfQJtPiri3zL/1n5tv3/SUxBOfpItTPZa4Ufspwd/KBps
	oVEZN701b/pwXIWHkP1KnYHzjsP7IBsy8g8GqD8m6DX/cUneOtEKjnhvemtQmto3HRPcnC9Lz2T
	4pWZEvhogbHJ/EmJsXuZ5dv0gTM+ntfP6cDW0/5ziKD4mfz7YQvMAn9dbg+OOeGE12tMU=
X-Google-Smtp-Source: AGHT+IGa0r5JunugmxLwRSZ3te7/5csaOdNw4asu9kfOiZSkSQ9900m9rT02+OnpqPMVecqSE44X0A==
X-Received: by 2002:a05:620a:469e:b0:893:2ba8:eec8 with SMTP id af79cd13be357-8c37ec0439fmr206640185a.79.1767661079931;
        Mon, 05 Jan 2026 16:57:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a6b5bsm65910185a.8.2026.01.05.16.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:57:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vcvOY-00000001EWh-2Hbg;
	Mon, 05 Jan 2026 20:57:58 -0400
Date: Mon, 5 Jan 2026 20:57:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Message-ID: <20260106005758.GM125261@ziepe.ca>
References: <20251204081117.1987227-1-zhipingz@meta.com>
 <20251227192303.3866551-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227192303.3866551-1-zhipingz@meta.com>

On Sat, Dec 27, 2025 at 11:22:54AM -0800, Zhiping Zhang wrote:
> For p2p or dmabuf use cases, we pass in an ID or fd similar to CPU_ID when
> allocating a dmah, and make a callback to the dmabuf exporter to get the
> TPH value associated with the fd. That involves adding a new dmabuf operation
> for the callback to get the TPH/tag value associated.

Ah, hum, that approach seems problematic since the dmah could be used
with something that is not the exporting devices MMIO and this would
allow userspace to subsitute in a wrong TPH which I think we should
consider a security problem.

I think you need to have the reg_mr_dmabuf itself enforce a TPH if the
exporting DMABUF requests it that way we know the TPH and the MMIO
addresses are properly linked together.

Jason

