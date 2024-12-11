Return-Path: <netdev+bounces-151147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F095E9ED016
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 16:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F9116AC11
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100021DE8A0;
	Wed, 11 Dec 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amq5WS5a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697191DE890
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931676; cv=none; b=VTcmN/9oShuPy9aBRZLAcRLecBlRxTpaC+MZOwztkHPfsQXEzBhSvryj04rKWXj+hTHuPOTBiePF24qiyPUWn+0xj4+TejMajyixKsFFm89Dwb1dAp69k9OOh7ftXugTtEa62RCLnzJApyjDqic82JRrPfW3WOGVvgaLV7D7JN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931676; c=relaxed/simple;
	bh=Cp99lddmIdkxY3uhNTaLdk3y/fpyyjHn/Q+aB+ZTxmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od6Qv5dshDhNMRzdx3pfHT2z532iFBtJP+vXMN1Zt8aCYq531iiW/whI2NWE6exx4ClBp9LohOwlPn6YoqyeOBO97bCL0nOL5t5iKsGt4KtH/zw38wkgHYxCHGIHSz84XAEyCY9p5ii8K5W3z7RJ44jtFDQIE9myfTkoHH+9HaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amq5WS5a; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361aa6e517so1896055e9.2
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 07:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733931673; x=1734536473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8l9PnRKkhxpY8BNg3B91T+HhXeJT5qSGCNtJEIq4I/g=;
        b=amq5WS5a7YGi9ON0ceGesCuO52U3RL8YCpBxwKg12GKPgQCOJk1g+XWlmSR+gbnYGG
         v9NtNpOV2LCWhFT50LLjR36Y4Ur0H/nuBaIm4jPoKnLIkBKnaRf27O4AudFVUxTgO4Pu
         UAcMZQoGt7bzLplX7ByhV9jMZFZB7Y0Yx/7w71fx3lDazjKFj1ElUTxjT5r0ZMtvfJA4
         fQAqU8vxEYMxi3bYpKvPNAsqeBFPpeVL/kf/H6v51jBoipYpmwbn+mqDDX43Ex8i6U+8
         7OfFcnoN3xDtutkukIidJpsMCqpmg+OohA/s0d/BY+gODLwUU1wt9azhJcXFTaNgp+eq
         w7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931673; x=1734536473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8l9PnRKkhxpY8BNg3B91T+HhXeJT5qSGCNtJEIq4I/g=;
        b=NGWASfhdPaYXGF8KalsIx/e99pAD0/uzJ/8tQgd7G+QxmEOK7FQk9IfnH4j5brAIyZ
         /xtDl0cjl8kEuorsxaBduqxIVJkDT9U/zmD2J4jPADksEORF7Sn989o2VkaOIhFbOSU0
         bRNQfXRWzRB8Wmf49+V+hwDw1zUb858C4bQCGegegdWCeVekJyVLztKCE2JSvF2AEK9w
         FamuC3zOWtJboa8NR5VlPq4M/GL2M83NiJN77zgNfPBCDVuK3PKSdo0vCU6SS/ulBotl
         oz0V366/0xbyM5bFbZ9NfYYR8WVmtEpdIN4CJ14Ajzjt0b0i+xwCDBcbm1kHHB9kALdG
         9YvQ==
X-Gm-Message-State: AOJu0Yy86LkRNQRb+rsdaAWdwhpy+wLjOeCorGiXfO87ryFgX7KTwX3j
	aXtPnZduoJs9lo/E3VRE0g98+zr8oA29g9ixM5lwEJyAM0op/kBh
X-Gm-Gg: ASbGncv833nabm2OYDIw5Wba2Zjp7hx3mmJ/dpdSakWDseGcxlH53wqCXB9qfBabQ6P
	Zd1OGn46FykMYcgCLoXvm+Mfsxao1IEQJDIrrrjgyvjIguy1FOumD4iNkxWL9oSh1YGzNKQ/liv
	ZEDqoHIIvSW9sOo2nIt11xZDue06DOwCVteWVP2cS5ERrQHaMfL/il7jpBBMtm3nyG4azc3Cl5u
	O40NfD6StTGQ9jvjJSt0/9QV7bDPYmvtOx6NeKMBw==
X-Google-Smtp-Source: AGHT+IFzlKTVuhqtPmI+K6Fc68RKifotH9GSsn3z114a8c6LeJuKNSdpG4uyaR5ADH3cpSLI2YVFuA==
X-Received: by 2002:a05:6000:1f85:b0:385:faec:d93d with SMTP id ffacd0b85a97d-3864ced38d3mr1078511f8f.13.1733931672606;
        Wed, 11 Dec 2024 07:41:12 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824cad16sm1518576f8f.63.2024.12.11.07.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:41:11 -0800 (PST)
Date: Wed, 11 Dec 2024 17:41:09 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com, lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <20241211154109.dvkihluzdouhtamr@skbuf>
References: <cover.1733930558.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1733930558.git.lorenzo@kernel.org>

Hi Lorenzo,

On Wed, Dec 11, 2024 at 04:31:48PM +0100, Lorenzo Bianconi wrote:
> Introduce support for ETS and TBF qdisc offload available in the Airoha
> EN7581 ethernet controller.
> Some DSA hw switches do not support Qdisc offloading or the mac chip
> has more fine grained QoS capabilities with respect to the hw switch
> (e.g. Airoha EN7581 mac chip has more hw QoS and buffering capabilities
> with respect to the mt7530 switch). 
> Introduce ndo_setup_tc_conduit callback in order to allow tc to offload
> Qdisc policies for the specified DSA user port configuring the hw switch
> cpu port (mac chip).

Can you please make a detailed diagram explaining how is the conduit
involved in the packet data path for QoS? Offloaded tc on a DSA user
port is supposed to affect autonomously forwarded traffic too (like the
Linux bridge).

