Return-Path: <netdev+bounces-125591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C258096DCA5
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82077280F44
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7600180C1C;
	Thu,  5 Sep 2024 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjfbRAYO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11697D405;
	Thu,  5 Sep 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548016; cv=none; b=Zl9PQ5QtqX2nzSU9/P8s1HEbcNevgqLLgsYsAXbBhpgAAULtbbaNo4jhYqxmbawSHuTHguu81KgUvzVNlSg/1irAtE/fFQ088fYCeqLZkwd1cnXnBSH+GBwHAoFIimA/xq5eBJp2uut5EQeNm2xOvwISUas+uFbgQmUBt1JopUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548016; c=relaxed/simple;
	bh=jqcZny1PU1DcuE8GExy2+KpWKtl29hP9zSYbnzunf1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnCSWgetVoEJyPMGi9FrXiDz42RSC12olI9oLMdPpfQRGI7fAqIqouxMdRQJIQYSBBi2Nk6oM5Oa0GSNGXFrZS+EEmcNOG8IPkKZdkK1/xzae1m4ZqXdiuanZhHaRXkoPTmd3+zxd/C26jwpN01gIx2HaoNqJEvZrxfQlxwkTLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjfbRAYO; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c26e5d05d3so113261a12.0;
        Thu, 05 Sep 2024 07:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725548013; x=1726152813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR0iYi2IfJinEuVM0L8yEAQAxrisPIV++kgfxATokkM=;
        b=MjfbRAYOQOEkNDdXJWL9He1XEVdK0OQXwiHa/dJ85M8R7a6RL3BTJwVWlfev0k9pL8
         G7AHyyAchhCX19ds0RAdRoCiwix854PK+idubgvLV1bNZue1ECd/Fz5cDlIvhPMHWc3e
         N1nVUKLo4BZ6cW2Acf02qOKxgcmsLZ2hX1+UrFp9qhhmTG+Hz9RQDjEBadnvEbdAQFGC
         ZKFtTJrO/LRrL/Nf6THTff2SCGNC4jSausz6vk180aLnXeeNJ0RYZDav5lhuS3P4meC3
         Gqn/GYbDXDVkv/bXSd6rbNvywLQ6l/TwuDSjgX6J/OEhsfOad0t0UUtnet1+k+4oN2LY
         zA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725548013; x=1726152813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZR0iYi2IfJinEuVM0L8yEAQAxrisPIV++kgfxATokkM=;
        b=l0RvzB3KDhldjsztQzUn2IYd6MIaBueTdu/ydnKC0qSlQ9x6IOBT789CWjY6kN+cSv
         9HvUeazgNzuwIRi1E3Xgh0Th/NihLdaMm3+t2/WzeG4Jj68R3RXo5SF1pf2ojCSkm9Ym
         assuqzECOBIY7LjEbaUz4JqXtTeXgauZUZA+E7HrnRZSeEYPz8wqtNfOS4m6Sll+DUoe
         sVewK4ZBtD+5ClMKbtjQdKqT0DcdrH/UgDTxjVtCXU9N8dFyFgOq65/4kJ5GTxpMr+Q1
         WR8je3QDURwZyqlHmbXaJF8nbb3q14MVjG8oYQ3gg28k8+hAZH0iJ2fMzAXumpF8XcoC
         tM2w==
X-Forwarded-Encrypted: i=1; AJvYcCVHWCBPvuEwHa3m4+SRYkUVZ1Xd1c0rsAMGpshe6HA37ASqxzZkTSJeMOUGVJcxxwWxZog8/7EK@vger.kernel.org, AJvYcCWCF77WEnfd0SMUMqApADw+xpVrkDnZ/fOImXPJotF8jp/UcwPneLjBCs9zA+mk+o34R9e+VrdmhKWZZ3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA9qlpT8SSNb1936ANHtx0KX45xngRbb595BHfPfnuIdJFQklg
	4MsMcKYlWak1hPEFrcbs9vpMJIIcZ50qG8Hae6q2Gc1JCp9Rvw6u
X-Google-Smtp-Source: AGHT+IHSJDF7488/JNd5/mBRKMIt/AGCz8WaJYYqZBzFyEHSWTtvg92OHespTIAyKntNsE/Yr1Q17g==
X-Received: by 2002:a05:6402:35ca:b0:5c2:4e5b:d0cc with SMTP id 4fb4d7f45d1cf-5c24e5bd937mr6396914a12.1.1725548012976;
        Thu, 05 Sep 2024 07:53:32 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc6a5cfasm1316252a12.92.2024.09.05.07.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 07:53:32 -0700 (PDT)
Date: Thu, 5 Sep 2024 17:53:29 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, xfr@outlook.com
Subject: Re: [PATCH net-next v8 7/7] net: stmmac: silence FPE kernel logs
Message-ID: <20240905145329.bqarpzzaciluwdxi@skbuf>
References: <cover.1725518135.git.0x1207@gmail.com>
 <cover.1725518135.git.0x1207@gmail.com>
 <508ae4f14cf173c9bd8a630b8f48a59a777f716e.1725518136.git.0x1207@gmail.com>
 <508ae4f14cf173c9bd8a630b8f48a59a777f716e.1725518136.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <508ae4f14cf173c9bd8a630b8f48a59a777f716e.1725518136.git.0x1207@gmail.com>
 <508ae4f14cf173c9bd8a630b8f48a59a777f716e.1725518136.git.0x1207@gmail.com>

On Thu, Sep 05, 2024 at 03:02:28PM +0800, Furong Xu wrote:
> ethtool --show-mm can get real-time state of FPE.
> fpe_irq_status logs should keep quiet.
> 
> tc-taprio can always query driver state, delete unbalanced logs.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

