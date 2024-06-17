Return-Path: <netdev+bounces-104099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2940890B354
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268CC1C23C5D
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3BE145B0A;
	Mon, 17 Jun 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CEOPCv9C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212E71428FC
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633862; cv=none; b=G5bIxhhYwOIULkUBJqLRA7+0PLEuMfNw4+TQW2o2zYx3jsmkLyAmq9Uz9ca6/K6M6SoWgZrvfvnEJp0BWrdbKuUT8t9y8L2gBdIqTwiUjNgm9XpalBZJblD8PitivoJ7bnDQ1rkktF4scHHeMu2XyLOlVm9EXQLmhiqILCPdueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633862; c=relaxed/simple;
	bh=gJB3RcNBcE0/JpE/eNjRla9bs9uh4t4dRien+AQ6M84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5y0GpBJxztmNyd7ooiD+6Fb9gc8GiFex5qEVJGZAntwwaaMRbE+BEUSOna2xkphH29HCliASZxJ+/YtcVLV7vl144NEdwwJJvxeOEnV975qG7t3NnWgrO3fcJ6isyq86/VxydzIuMpYJsyN+WWLfo8yZWOZbkkfGNrGmB3MiGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CEOPCv9C; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-797a7f9b552so308161285a.0
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 07:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718633860; x=1719238660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gJB3RcNBcE0/JpE/eNjRla9bs9uh4t4dRien+AQ6M84=;
        b=CEOPCv9CIojuITA3pObhkOe0s+8H6GZ+LmQgofJdIqT7KuDzDlHvQN1W+gAmg3clgr
         i7wSkPSkQel9Cotdgnrihmkvj7yxi5685vyiZTBZ8VzbCUuD7hhfJgd7CmxdJ7NbyApt
         Tve+MnzYU8oIGUaB4M4tftj7HXXWTVygpzYaJFMSmg4xdXLTc/p8WsziLJA/Q5gJNhLa
         UEPIrd/01vyT4EvW5Kjvk4WNSSYc5bjVosKsRTulsmGiem/MCnT2SgrzSxOvOvp7XGBw
         OkNsVpRcYwkPpcTNFJzqH8+xC7M2PikvBbWDXW3WZoOsFWfI5OXAAZFTDXfEXgGNTugM
         BH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718633860; x=1719238660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJB3RcNBcE0/JpE/eNjRla9bs9uh4t4dRien+AQ6M84=;
        b=dItmc0RLP/qIwcbUuctoEfNI/HiHm3Fi1iTZrq0KNv2OyZQiznKlXOhwbZ8NpCmhMc
         tWgbZMz1G95JOselY690h5BffkuSR5ZzS/UcOScMGdG8N0doftQg8+HDh3j8BYpdMPa8
         70+YE8HYnGQAuQqArCO5D37YZceATOflhSupsei7xXNWl3xSw77lh03d5GMxXga+P5EL
         W0nMX8uJfqqZoOdV8DhHa0cJVh8MksegNlRUbcrn7vT8UID7/fKR4+Jwey3y0yG96IqM
         uwWiv7OgEqQMDTWD+ttQHZvVnvgFghnP2vinSwviWpchYuOqkk6A3QsPRUjLJlLHqTCY
         Rb6A==
X-Forwarded-Encrypted: i=1; AJvYcCVavI44d4x7hL16IAoR6f/gicgloQJvUK+6dOpx51z56uIw+uRZX6KWU1tddMXBWBLlc6mo9hbBS4VtroQNzAjtJyoKVOTm
X-Gm-Message-State: AOJu0Ywjh7twREp6fMgP3UaqJJQJbUD0jxMd8KZLpL41coUF2nlvsxnx
	apvGoeKc2Ajfp4saVRcyZfjbpRDqk6ygbO8Ep2kCGnyR6v4DS74XKjub14RV9huMhlM9Lq8Eado
	4
X-Google-Smtp-Source: AGHT+IEeVElDnFU6HjCerK8KBYMeNyuzItK5u6pJekKDgwB6IP+lwMt8s0nxNZxohhF7K6rO8Pl5rw==
X-Received: by 2002:a05:620a:248b:b0:795:59ca:5066 with SMTP id af79cd13be357-798d258e2e6mr1129033085a.53.1718633859951;
        Mon, 17 Jun 2024 07:17:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4420c5e8e4bsm45859201cf.39.2024.06.17.07.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:17:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJDAw-008eAR-Pl;
	Mon, 17 Jun 2024 11:17:38 -0300
Date: Mon, 17 Jun 2024 11:17:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	ogabbay@kernel.org, zyehudai@habana.ai
Subject: Re: [PATCH 11/15] RDMA/hbl: add habanalabs RDMA driver
Message-ID: <20240617141738.GB791043@ziepe.ca>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-12-oshpigelman@habana.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613082208.1439968-12-oshpigelman@habana.ai>

On Thu, Jun 13, 2024 at 11:22:04AM +0300, Omer Shpigelman wrote:
> Add an RDMA driver of Gaudi ASICs family for AI scaling.
> The driver itself is agnostic to the ASIC in action, it operates according
> to the capabilities that were passed on device initialization.
> The device is initialized by the hbl_cn driver via auxiliary bus.
> The driver also supports QP resource tracking and port/device HW counters.

I'm glad to finally see this, I've been talking to habana folks a long
time now to get this worked out!

This will need to be split up more, like others have said. I'd post
the RDMA series assuming that the basic ethernet driver is merged. You
don't need to combine basic ethernet with rdma in the same series.

Jason

