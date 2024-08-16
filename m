Return-Path: <netdev+bounces-119176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F60195483B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 13:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2DC1F25D65
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D1F194AF6;
	Fri, 16 Aug 2024 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6OM/Kd2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE981547C4;
	Fri, 16 Aug 2024 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808905; cv=none; b=g0W0OiJnCQpfxhL31OhoYRFXJ2DXSoPx3ELsMKijfek+7FrWXlGz8AT7Y0XLObcp7A4sgndF1bxpNpz4VLyUFfy/YzjrNOJ9pscrClabgD2JJ49ANIyxounHcq2xb6o2RAd9HtHLWre78dFsd/+bT4REG2YoBTmbQkEBYTWq8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808905; c=relaxed/simple;
	bh=mFGmQo3obq248oRCshtEnzGXBHV65xQZPgg9M7+Lrco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IU3/IxAkOtSJLNKHVDXjQ2K71CKz/jZtUBrhYyTdOdgGdqdh8gaELqrRWO21+qd/o+uNEXMLuMksupF+pN56CFJZ/viwHU+sSeww4UjJCoj07zPwnTn5zB/QoEwqxUCms78uGikdh0RXbBf14+pn2z9hxpV5812BQkeG8SjF268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6OM/Kd2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a94478a4eso516562266b.1;
        Fri, 16 Aug 2024 04:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723808902; x=1724413702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IY44BvNIQ8HMdyx0QMRty049Oi1G15aZuupS+GebtAw=;
        b=l6OM/Kd2T6fVkebJwi+Gc/nt8H+4t5/wFnAMbHKN1UKlAlPxor+KXqS2T3MAClASQg
         aCGPIkKZ8dbHi16EnmEtp9/hv2KRCh2yvRnv4SNlnZBvydMWJWWEhd3VAL0PyUqO9yre
         AZ/0sDfgXvsHcNRstdGd0yZHM9YxRYFzHXeTZrJMnWb75/BX70SGBlgQi6AKGyyYqG5H
         5+yyZ0PQjbHPYemdoMkgYGPtfMPOaEcwqWXnSdZQIOh2XOaJnu1B5eRQVx+RIc5eO2M2
         Br/uxR7X4FpD7XL3c8hXqkmBE4Zi1WDelR/DsHsqVXM/ifm7vtTnnN/Q+y6RwsSHl1Ac
         rRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723808902; x=1724413702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IY44BvNIQ8HMdyx0QMRty049Oi1G15aZuupS+GebtAw=;
        b=IXyEEfgFk5R8iUcF55/gJ+HEKraFl2dXhJe7rmiLKKJVO7Dts1mpmyZYvaYxf56JpX
         rarfFciyNkam/bniKX75JU1op3fwop3PiQnNiiElvo1jEFZS7QTQTTuco5ZaGub8lbxd
         SR90rR8SSo4EVQP1+afSjGK0q9QWRr5xsPL+M1N4Bx8YA1c+yqdvEQgp1qoYzCpbgXl/
         mqkUM/c7L75n7kv3m0JB85Lm3wg+baghMhKJucKS7aYfQuGqr8yzy5EK64O5DVARYfUi
         4QoxsWUfFD8iJilWpKhRaPVyvLW1LAUmZ9HAANlGTEkVUv6WUMcTk67UgCAIMIceSTRU
         x6GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXmjxJpKBLVOa6jjgpd1dEgoxRKWWe/qBdfOjylN6XIisScZa3j8u2KUNr8kNCFgZ3G8lQlKEhZ9k6afUN2EGhRBlEVibl5DtjSWCgRELxZAfcHrC4jkd59Gccsa3G3iw9JrfO
X-Gm-Message-State: AOJu0Yz2gZSGlNvx6jac8t74l8ihBBg6J1VcMGAsTFKE5AQtd8borkf2
	TqW+3L5qCBdqpofDDakRw2UKKgCMHQvrhblfbfdJ0r5wbTqGD3RT
X-Google-Smtp-Source: AGHT+IEMqNZbH50JXVZEb5SoTpw0eEiq2X6PpNhKEqpktgqE6co9AWSShXZz8K636iWMPF7XES4lEA==
X-Received: by 2002:a17:907:3fa4:b0:a72:64f0:552e with SMTP id a640c23a62f3a-a8394e34235mr243281566b.19.1723808901548;
        Fri, 16 Aug 2024 04:48:21 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839344fdsm244834166b.100.2024.08.16.04.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 04:48:20 -0700 (PDT)
Date: Fri, 16 Aug 2024 14:48:17 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v2 0/7] net: stmmac: FPE via ethtool + tc
Message-ID: <20240816114817.gp7m6k2rlz7s4e5a@skbuf>
References: <cover.1723548320.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723548320.git.0x1207@gmail.com>

On Tue, Aug 13, 2024 at 07:47:26PM +0800, Furong Xu wrote:
> Move the Frame Preemption(FPE) over to the new standard API which uses
> ethtool-mm/tc-mqprio/tc-taprio.
> 
> Changes in v2:
>   1. refactor FPE verification processe
>   2. suspend/resume and kselftest-ethtool_mm, all test cases passed
>   3. handle TC:TXQ remapping for DWMAC CORE4+

This is starting to look better and better. I wouldn't be sad if it was
merged like this, but the locking still looks a little bit wacky to me,
and it's not 100% clear what priv->mm_lock protects and what it doesn't.

I can make a breakdown of how each member of fpe_cfg is used, and thus
understand exactly what are the locking needs and how they are addressed
in this version, but most likely not today.

