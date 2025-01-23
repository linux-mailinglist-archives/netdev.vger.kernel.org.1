Return-Path: <netdev+bounces-160542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65A0A1A1EB
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93224188D99C
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 10:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CE320C47D;
	Thu, 23 Jan 2025 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj8MOap9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DACD1C5F14;
	Thu, 23 Jan 2025 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737628456; cv=none; b=SYywaFWEPthZETvR6a6ILmhm5PXHtFSHbYVjlR7ti4U2EKblTLhvs3zPzzOOyfdWnPH9yltKp0q+YWcEge4/ZWx3Z3nbfQsnHSc5Tb9RQh2zbcXr3yxgNqFhpzQZsWaGtb4TIXNtoziJ08ReoHLc4KsCJpL2ZtDhnTVdi3d+ZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737628456; c=relaxed/simple;
	bh=gsyxcjrfPRlVRrzpZn06sndNy0fCEKZf+MF9IrWJVv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2nf0gtT6VHIz5DG8pwkrcemMA8+c2BpPScj6i+Wec0bR6lEvahoAotchZtFHF19aFq+qD86wKyxZyIXmIzyDq5Dxfq6VBeGgJRSw/BJe2ccY9OtdzB94gLj1oIWxrdT7mSCrvtIXdPtYTLuC16ChTBo4LjzrYTDpzGJAt5Owpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj8MOap9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21680814d42so11179975ad.2;
        Thu, 23 Jan 2025 02:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737628454; x=1738233254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kta1kpUGyKQ79E+obX3jn+pQXvGIiJLwWQQsshofAyo=;
        b=Hj8MOap9vOH1Qd67NyQEpwKOmF5na4fDUNNh0dUbX5bVS6uzMpJFj9ZOv8z1IxvR/v
         +z5VEJekKSBnhWQOlzDV4FWLDfWaKI2Mc1Ev6R8FbfOpk2f7aWaCNZgGbNd1uZ+zQ+DI
         DCQxrbyKll8QoBHMmeMoawvVqFt2o/geCPHhThfRKpskvKcJCgSuRPiEnII9AlI4Nbh9
         oxkPJxRp03AIhfRa0LzpVIhNgeEQWcGZFodNIXwPN98GRnKqBwcknN1mmYv3bUPghDQp
         s05K0/jJK4bKRd/P4R33DjwuUX8i2+N2aW0hAf3+seKeqPge3Zd/BojtmqH9SMM4iRkP
         cU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737628454; x=1738233254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kta1kpUGyKQ79E+obX3jn+pQXvGIiJLwWQQsshofAyo=;
        b=McmotIzYre9G1NMKND99iGv7J/AAXNJMdY5zq4lwb3nrySnq265lyZhB6KqUNSg86r
         CGp/A2pHnQ0tvmePffEntDRoc14a7C04Js3JkchpKBR9Hkl6i+qFK4ko3NKvbgK2twOv
         wDrDgHBFvfAVDAX5+ujsKWy2kyMsYtT3MUB3LNFAMIqgJuKxZI1eQbq/ppXYt2COyASy
         hq99H/GdOSiXjQRTzPpRu9/uRHeh7xn63AbdMa09D1iy70B68WK3F2wQpJaP/2dQGv+D
         Hiho5LuSSUqqwcf9bG0Db2FSvl+mphjrm6lXFeFMn4qQ0F0Fc7eZbwctvgV7WRryqg4d
         Zjlw==
X-Forwarded-Encrypted: i=1; AJvYcCUOzSOfl2ePsIac4jmGRu/9/flh15f9LF6r6SSKrCYfdLtHrVEzJrZsy/vwc03kjyhyUoqsYTuI@vger.kernel.org, AJvYcCWDwxP+vjKNhEUjpxqk0jN/x9jhVQkz7FZKF7YbqpC2Po6Sued+vUcyK7+G5EHcepyJtwGBZ4WXuva98t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIgVzRe7Za11/+lhQLThHf4SiVsicNJLwpIsq2P3Ren0symTzt
	zwb8jMS/YJ9BPit2Rq620LL4UwzQxX/lp4P91T/cypiPfcYE9EbcOFlNmg==
X-Gm-Gg: ASbGncuekiZwUwmKX4J3Up1FzTmwJOaV6mk+n1Vnq7G2dPpq130bKrVhxvXg7JucVgx
	znBhS/0lJ7mIw3DwHs+AbKUMQX1MAW14rvmZUK13bDk42RHgMGGhhkmhLyDBbTmDxaFVxkb1j11
	Z20lNAMQDyLtxF9ZOU2IFo4Oy/EvyXEzw8bKJmpW258peiSSX5jgC5Ipcf9FMj0yJUYn9jdwvbv
	dfyt7wuHu8ae0+6hG2TfzccB6s1JZO78Yd5PgRNE62kJfM/SJPLrG2kbE8td4UpBvcH1pJtgFYp
	Y27mYJRN
X-Google-Smtp-Source: AGHT+IFQdN/5La2w5kfygfWxH2hklatSF3XsJgt3pGVejkBczyJ0ommryHlN7Qz3ElnZcfB2zwuP0A==
X-Received: by 2002:a17:902:ebcd:b0:21c:7e22:7844 with SMTP id d9443c01a7336-21c7e22789fmr246273405ad.51.1737628453532;
        Thu, 23 Jan 2025 02:34:13 -0800 (PST)
Received: from HOME-PC ([223.185.135.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3e088bsm109217575ad.173.2025.01.23.02.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 02:34:13 -0800 (PST)
Date: Thu, 23 Jan 2025 16:04:09 +0530
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: fec: remove unnecessary DMA mapping of TSO
 header
Message-ID: <Z5IbIeOxrkMoASdJ@HOME-PC>
References: <20250122104307.138659-1-dheeraj.linuxdev@gmail.com>
 <PAXPR04MB85106CE97288D52A04EB685388E02@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85106CE97288D52A04EB685388E02@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Thu, Jan 23, 2025 at 02:58:32AM +0000, Wei Fang wrote:
> 
> Hi Dheeraj,
> 
> I must admit that I misread it too. There is another case in the TSO
> header where txq->tx_bounce may be used in some cases. I think
> the most correct fix is to make txq->tso_hdrs aligned to 32/64 bytes
> when allocating tso_hdrs, then we do not need to use txq->tx_bounce
> in fec_enet_txq_put_hdr_tso(), because (bufaddr) & fep->tx_align)
> will not be true. This way we can safely remove dma_map_single()
> from fec_enet_txq_put_hdr_tso().

Hi Fang, Simon,

Thank you for the feedback. I have a clarification question regarding 
the alignment of txq->tso_hdrs.

In the current code, txq->tso_hdrs is allocated using fec_dma_alloc(), 
which internally calls dma_alloc_coherent(). As I understand it, 
dma_alloc_coherent() guarantees that the allocated buffer is properly aligned.

Given this, should we remove the alignment check 
((unsigned long)bufaddr) & fep->tx_align and the associated dma_map_single() 
logic entirely from fec_enet_txq_put_hdr_tso() as you have suggested?

-Dheeraj


