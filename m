Return-Path: <netdev+bounces-92090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFDA8B559B
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CCA1C210BF
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 10:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE903613C;
	Mon, 29 Apr 2024 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="MQjJrVDR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666B62209F
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387354; cv=none; b=pXitV2aJmeZXU9WxBrIhZUn1prNW0YOk1hw7wqoAna6twEFEnmKO8M7qWe1fxYrvW3to8BLFj24jf19CreSyUd68G2BhO8pdob05S0uCiGwNPOfzqQ85n6/s8rtUYQP8maR9emhKi9taMmLOcIpgMUod7aITi5bZKPh/i43s5p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387354; c=relaxed/simple;
	bh=Nz2aHzGyxCGbf4VQ25wGGdpxEimyVAT/uALfZ2g/QAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCJsP6A5tCx2OUGFKMxisWf47giXq9XLv3pU7n0MSmaV66tQQE9bYjFJVipMmhyNDpYapNS/sMAb+Sw4a5ogZhE1GV4jZfq1TCFLBmiUBK2/Oy7jCBA/aunIMlYUevLz7lMP0BjFf7b6LIZiM3iXJb/K2DUMG9/gMzq5GVU2vwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=MQjJrVDR; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so5924399e87.2
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 03:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714387352; x=1714992152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nz2aHzGyxCGbf4VQ25wGGdpxEimyVAT/uALfZ2g/QAQ=;
        b=MQjJrVDR7Xxv/wR6ZCxyW2eft9B9LwEi/6FNy/Yj1QGvU2Wb82/BDgUug3V+7kz6zk
         4RyYquUImHPfMB5zcBR/K7kR8kigXKQ+7/66xSpns6m58UUzeNDNMju3BpoatZiHFbT5
         g9Tc3AG3rWdUX84MvbjtM3NmYF5jpq1mlA4jcZlNPlUEBj3jF5X7oiBVqeH/z71wvhmG
         l4o9qNtMVhozLxaWYhGkLhZc300/7p9XK1EDi1fRISYXTTe2ozqrjbvZhTUN3ZA7I7iU
         iajX1WX0L6ahcGe2BSRO3/Bbx5Y+dcAEaXue0l69+znOjJYVXT59HO7fjpkHU3W5ciHv
         KHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714387352; x=1714992152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nz2aHzGyxCGbf4VQ25wGGdpxEimyVAT/uALfZ2g/QAQ=;
        b=Suv8Xi7X0FS5zQszxppo7qKMlZEQQs11fvNbDfBrrGR3q8fHnjuajtNg7d/kvSZheZ
         3+rrqHm9e3Yt7SWmNB0/gvYxA7Vj7iUEpk1YpxIviW7+YWhaJnr6aobR8HpmxbA0VqYb
         n1L03OJea3X/Xug+DN2YzGHuzttvm1ikofrv5pThAO1wOP7ojkBw6OGmqrpVkgit5GR6
         UdcQZUM/0Hwn6PRdsB20+pJmz3mxYzZCI30ARww6NXh35JAD7sUZSx2tnZ8GDiabxhMU
         E0MWvowFI59O3S4hqdcOXcI+4iw0KiA5rrYESq2uNcIIH0NffJUFJluvlXuZjAOx6Jp9
         lmrA==
X-Forwarded-Encrypted: i=1; AJvYcCXLKNowNzFIHj32hZZjIhTpkak6m4j1pfau89VMizPqAiRQXdpO5Ov0F8IN7mYbT0J9bW0q9uFFz6u5s7th05eA8NcLir1O
X-Gm-Message-State: AOJu0YzcmkX+BWMlS2apya309FXceRbe+xGh9uri3WrKKOh0tps2pPvS
	5gLnURarGMQQT1SWx20IEZaFDPJCVAbkDhgeBTzu0gPdBb+5r+nLDGeJEoJ6Q/Y=
X-Google-Smtp-Source: AGHT+IGC/EWccJ9E9/wUYZ6qvH0GazTIQwjcgftBrMnJ0ZHtEs6kojINIqdEOv8KtHZPrjAeqTfdhw==
X-Received: by 2002:a19:5f42:0:b0:51c:d28d:526b with SMTP id a2-20020a195f42000000b0051cd28d526bmr4779616lfj.6.1714387351618;
        Mon, 29 Apr 2024 03:42:31 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id m7-20020a056512358700b005175dab1cfdsm4044973lfr.257.2024.04.29.03.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 03:42:31 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:42:29 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 13/12] net: lan865x: optional hardware reset
Message-ID: <Zi95lRl-WfeMgPmR@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <Zi68sDje4wfgftyZ@builder>
 <13c38696-25ed-418d-b85e-950736384a0b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13c38696-25ed-418d-b85e-950736384a0b@lunn.ch>

> You sent this patch in an odd way. We don't normally see headers like
> this. I've been using b4 recently for patch management:

Sorry about that, I appreciate the suggestion!

You left good comments on the implementation side as well, I'll wait
with addressing these. Parthibans feedback does invalidate the core of
the problem I set out to solve with this patch.

If the patch is not dropped I'll ofc address these points!

R

