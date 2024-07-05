Return-Path: <netdev+bounces-109432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6581C928760
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 12:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893301C2271E
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 10:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE05147C9A;
	Fri,  5 Jul 2024 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S09WL7eJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959FC148FE3
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177189; cv=none; b=jxhd5RjcIRIAkDTpqbYgv/WQfRVNDpE1X1QXdNBajd9MTURDEflXifk+d62R27pdJHS0AF1dH2V22t5WaqUlHPoa/Em8TYdXC9sotSx7ivPC6osNLtOpbfm07+rwaqthFe+PlUhyNE/ykw2EzcZv8rl8nxe6toOBEr3CZPeBNbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177189; c=relaxed/simple;
	bh=OVwqISTWovAIkQN4/EgRkZ+vD4eftfc/wgbHBWVWsjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpXaBevTm2mbNCZPC0dNAG6Qo9prGsk+6nSismt+VgGPpA/AgPYkFv5d6jNMCmc+jTeNr+0pye4MubMSGy5Mj2FlRDO9fgT/gSWfg9ggz0GLU4FHiRPZMHamP25c6KmU83rL8cQOmLzfsXdbO7y7G9+ln2BNpaI7AhYuoOJMcA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S09WL7eJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ee4ae13aabso15708151fa.2
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 03:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720177186; x=1720781986; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IwCe746/Ce3+X8YJ4u9+OppkGmoTNZZWRS7gUOb5NW0=;
        b=S09WL7eJOz5KgqfM3xOWP2Utib7+0yhK249UeIXP3XZnc8pooh+MnW219E/KHKapI0
         RTrvugmgVtjoWVdx4i/HJ8K780RIn5H2NW7dl/bR5QkrsgTgtw8gzDrSC2pw+bRFcMRf
         iHFkEZV9U968qxVRwZMjcWmURaEgFSwPtEXPrj3Li4p3C47E7OQSeJVa9NLxfLNoMPh0
         G/qoQ06anYQLIG4QwoMKno6Sb6Cccb8mn3i1l70cBgE+dZa+Hasf/h4+h3XMNX1ZRFk6
         kMfue811vbbSeeQ21RKayxG5J5Q+GkfJTslgVXUalC/3HnT4ZBm7Rt+6oT9E0r1VPqKK
         E6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720177186; x=1720781986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwCe746/Ce3+X8YJ4u9+OppkGmoTNZZWRS7gUOb5NW0=;
        b=soJjvPdfQt2qd3gkFCtK4zQjT7q5RkLBjK8qbvUzonrof9hpI4QkCBe1fhnhg3VBpY
         Tgz5h6EpVp/UvoxHd4I+XGipZaVi7XdysOYw1zMpIvQSajIhXGm8CTioFtoToJCrlHp/
         CuAi+T2LqgoPzR39jlnTP5JzWq9ErZhTsmZmq7pJ6U+fFzPWo0FufhREF+F/n4Xyvq8D
         GCgGKl8dvBUN9PqYIw8j3VKxpgPKY8Ez6xF1VYG92Hfxcl3RqoPNJZKdx0J+2KGn2QR2
         TgVruZt8qZHAxNsTxjqq6GKo437xNI6D9hu2hH7tpCYVfAWjZCicXFeNwEUliozrJYQv
         Ss6A==
X-Forwarded-Encrypted: i=1; AJvYcCXeR/GeCF05LIq0crD2e2YwUbb6/HYhQUBBh+CK9cHXqalx75Kuk3Aph2njVL8/kh6oM93hl2E826KDQ8a+P9Op74hfKYGK
X-Gm-Message-State: AOJu0YySxQAGwk6h1MV1wc38foRS2a6WsB80wvmAMurjxfGd+bQwdiDL
	SSR2nvj8f9ey1vo5iZP+nj7PEZCiAxAI4iNh7Qp43+EIMieIQEVj
X-Google-Smtp-Source: AGHT+IHhV9spZKEmfNykvFeqOJwg1mmW+m4Atofy6IrkLX/QoqsEiGq1GgD7wt8KqTgX2BepWFK/4Q==
X-Received: by 2002:a05:651c:19a2:b0:2ea:e98e:4399 with SMTP id 38308e7fff4ca-2ee8ee01aa7mr37825351fa.36.1720177185529;
        Fri, 05 Jul 2024 03:59:45 -0700 (PDT)
Received: from mobilestation ([81.9.126.50])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee8f958b3dsm5177181fa.43.2024.07.05.03.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:59:45 -0700 (PDT)
Date: Fri, 5 Jul 2024 13:59:42 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 06/15] net: stmmac: dwmac-loongson: Detach
 GMAC-specific platform data init
Message-ID: <qj4ogerklgciopzhqrge27dngmoi7ijui274zlbuz6qozubi7n@itih73kfumhn>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <b987281834a734777ad02acf96e968f05024c031.1716973237.git.siyanteng@loongson.cn>
 <io5eoyp7eq656fzrrd5htq3d7rc22tm7b5zpi6ynaoawhdb7sp@b5ydxzhtqg6x>
 <475878c7-f386-4dd3-acb8-9f5a5f1b9102@loongson.cn>
 <7creyrbprodoh2p2wvdx52mijqyu53ypf3dzjgx3tuawpoz4xm@cfls65sqlwq7>
 <d9e684c5-52b3-4da3-8119-d2e3b7422db6@loongson.cn>
 <vss2wuq5ivfnpdfgkjsp23yaed5ve2c73loeybddhbwdx2ynt2@yfk2nmj5lmod>
 <648058f6-7e0f-4e6e-9e27-cecf48ef1e2c@loongson.cn>
 <y7uzja4j5jscllaq52fdlcibww7pp5yds4juvdtgob275eek5c@hlqljyd7nlor>
 <d8a15267-8dff-46d9-adb3-dffb5216d539@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8a15267-8dff-46d9-adb3-dffb5216d539@loongson.cn>

On Fri, Jul 05, 2024 at 06:45:50PM +0800, Yanteng Si wrote:
> 
> 在 2024/7/5 18:16, Serge Semin 写道:
> > > > Seeing the discussion has started anyway, could you please find out
> > > > whether the multi-channel controller will still work if the MSI IRQs
> > > > allocation failed? Will the multi-channel-ness still work in that
> > > > case?
> > > Based on my test results:
> > > 
> > > In this case, multi-channel controller don't work. If the MSI IRQs
> > > allocation
> > > 
> > > failed, NIC will work in single channel.
> > What does "NIC will work in single channel" mean? Do the driver
> > (network traffic flow with a normal performance) still work even with
> > the plat->tx_queues_to_use and plat->rx_queues_to_use fields set to
> > eight? If it's then the multi-channel-ness still seems to be working
> > but the IRQs are delivered via the common MAC IRQ. If you get to
> > experience the data loss, or poor performance, or no traffic flowing
> > at all, then indeed the non-zero channels IRQs aren't delivered.
> > 
> > So the main question how did you find out that the controller work in
> > single channel?
> 
> sorry, I meant that if the MSI allocation failed, it will fallback to INTx,
> in which case
> 
> only the single channel works.  if the MSI allocation failed, the
> multi-channel-ness
> 
> don't work.

Could you please clarify what are the symptoms by which you figured
out that the "multi-channel-ness" didn't work?

Suppose you have an LS2K2000 SoC-based device, the
plat->tx_queues_to_use and plat->rx_queues_to_use to eight and the
loongson_dwmac_msi_config() function call is omitted. What is
happening with the activated network interface and with the traffic
flow then?

-Serge(y)

