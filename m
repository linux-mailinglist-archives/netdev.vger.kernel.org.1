Return-Path: <netdev+bounces-145470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561FC9CFA28
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4EBEB3041C
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF0A20400F;
	Fri, 15 Nov 2024 21:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vcjs3LLs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C31FAC44;
	Fri, 15 Nov 2024 21:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707685; cv=none; b=pEMPk6I9teoDKwEEz44BnrRhTCNWHiWWbGYnaPdxjKeHRTj/9lD8aB14KBJfuQdxTnIWR/cNA81KoW9BU2x6SdaijOguG4IWm8rWoPfl7ARfpzwvzW+NJUL34bsSBoUbdqM/bc5+0aDEVvbYVUwMpr1jtVbQUSy3Cdzg3d2Hqas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707685; c=relaxed/simple;
	bh=PZUFopZFW011mgMW9hqK5D/QiGvWyJ859zbDEt+6aK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmbY2ZPIDA5kpgVM0W2dL/LP1hRHRQhrF3Qd3Jn0rs9xzSyXQINOTlxatad+lgHpLfqTQKVMRq1i2TA11FQceg6GzY/5QDSvGIz2Wfk1vY49rJLKLMzpaBYZFDfJDI47U9qyNdcLhB6PnOFlvk9S4c6jvGIGXmt+WaLHCUBDCLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vcjs3LLs; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso680942a12.3;
        Fri, 15 Nov 2024 13:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731707683; x=1732312483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ih3rsYrxbacXhs22/ceJtwa19H77jl+ddUaN6SDc00=;
        b=Vcjs3LLsTZUq27S99r+6sSUGeObutbVbOaDSu0bAMDxg3+60cq4Z5S/IzctJQbJZ6e
         h4km42sUNanBi1XNSOneWoOSasVIwgLv/XqXBxEXRiAM28MDOuq84oiBowaFWNKNmpa2
         doekIpKYL4M+lnuhNyUjtRibixiE4lEkds9old/hcVFzkWbSa6MOV+mQ07G9XuxESdMv
         OxRr4gmSg+tO2uv8tmlRsYlCiaIsg9grFxarzMdCgcXrQVkbYeuOaUeMbM6HPr4uZVj2
         0htc5QSm5O94wsDvHQutyI/55XaY5s6sLfFcQg2mv+7sqpMAUCyl9YX3HIzIzxxHKZHH
         +nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731707683; x=1732312483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ih3rsYrxbacXhs22/ceJtwa19H77jl+ddUaN6SDc00=;
        b=Ex1GYsbBtFAGWTy/9VpMVh5lxwiTwXlWxfDleH5wOlYfzaaZB6B8iIZVFo4KBsuSZP
         nbEtafHwZh9Z7Gt5rMwgtbTth33Umk2dqEqfSTu5dJhn2tv/Yf48SdMbkbko6i2b5a+I
         3NU7YmVoFKIAcbCkOAYC9tknzMPnf2G5ClhMzvnkhrXRkzLiWQZMyotjaSmNZRgkPHjz
         5x1KQOF9kqyWBqdLBmT7xF1KbndDgpZaRY8zKfffZ8V+/qu1C50T4zLw/JWtY4CE2nV7
         eTfKR8kSZgINPpm9lMWpgdK4vEbNKI2z61FCKe3H/YB/4WmWIIRPpsZE8lSWjs/yxGXR
         p+GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX8yTXducF5z8CoqQ7LqBzvmQJciOthSevacBxOVJoMJKF1nH+MaNzgHSR+/H5l+EwgYDhDAfG+y6heb3O@vger.kernel.org, AJvYcCVb+ReUG+68HW4ci9ewPpSd5jXM+d/X5hH9blqCEySY79CwY7qqGG5BFchCF3Riw+2GiMX9m40R@vger.kernel.org, AJvYcCXPbI5D87AcyYr78eQ18YYQh+vnqsMQVGpN3JGvoyR1spwIAgPb7Ky22aLlzcKxbFkOsYRr642PyNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyONFUlmDKRmoVfPTyV4L/IbKTA+19ziMwrKFU8f7pC8DQ0EXpW
	T+WH8thcArIjn31O1YthHx0eSnVwNh+TgeUowpFugsV3G5+glMA=
X-Google-Smtp-Source: AGHT+IEPQV9zwJoJlonYiQ4GuwJ0b3EHPHZ8jqkjsJ+ToR78Cl1m4Q7iPUEqcqWSzT4lX3EDev04eg==
X-Received: by 2002:a17:90b:350e:b0:2ea:14c4:7b8c with SMTP id 98e67ed59e1d1-2ea154cd16amr5207631a91.5.1731707683460;
        Fri, 15 Nov 2024 13:54:43 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06fbc909sm3320819a91.53.2024.11.15.13.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 13:54:43 -0800 (PST)
Date: Fri, 15 Nov 2024 13:54:42 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	donald.hunter@gmail.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, kory.maincent@bootlin.com
Subject: Re: [PATCH net-next v2 7/8] ethtool: remove the comments that are
 not gonna be generated
Message-ID: <ZzfDIjiVxUbHsIUg@mini-arch>
References: <20241115193646.1340825-1-sdf@fomichev.me>
 <20241115193646.1340825-8-sdf@fomichev.me>
 <20241115134023.6b451c18@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241115134023.6b451c18@kernel.org>

On 11/15, Jakub Kicinski wrote:
> On Fri, 15 Nov 2024 11:36:45 -0800 Stanislav Fomichev wrote:
> > -/* MAC Merge (802.3) */
> > -
> >  enum {
> >  	ETHTOOL_A_MM_STAT_UNSPEC,
> >  	ETHTOOL_A_MM_STAT_PAD,
> > +	ETHTOOL_A_MM_STAT_REASSEMBLY_ERRORS,
> > +	ETHTOOL_A_MM_STAT_SMD_ERRORS,
> > +	ETHTOOL_A_MM_STAT_REASSEMBLY_OK,
> > +	ETHTOOL_A_MM_STAT_RX_FRAG_COUNT,
> > +	ETHTOOL_A_MM_STAT_TX_FRAG_COUNT,
> > +	ETHTOOL_A_MM_STAT_HOLD_COUNT,
> >  
> > -	/* aMACMergeFrameAssErrorCount */
> > -	ETHTOOL_A_MM_STAT_REASSEMBLY_ERRORS,	/* u64 */
> > -	/* aMACMergeFrameSmdErrorCount */
> > -	ETHTOOL_A_MM_STAT_SMD_ERRORS,		/* u64 */
> > -	/* aMACMergeFrameAssOkCount */
> > -	ETHTOOL_A_MM_STAT_REASSEMBLY_OK,	/* u64 */
> > -	/* aMACMergeFragCountRx */
> > -	ETHTOOL_A_MM_STAT_RX_FRAG_COUNT,	/* u64 */
> > -	/* aMACMergeFragCountTx */
> > -	ETHTOOL_A_MM_STAT_TX_FRAG_COUNT,	/* u64 */
> > -	/* aMACMergeHoldCount */
> > -	ETHTOOL_A_MM_STAT_HOLD_COUNT,		/* u64 */
> 
> These comments could be useful to cross reference with the IEEE spec.
> Can we add them as doc: ?

Absolutely, I did port these (and the rest of the comments that I removed)
over as doc: (see patch 4).

