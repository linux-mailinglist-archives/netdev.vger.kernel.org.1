Return-Path: <netdev+bounces-136926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E25E9A3AB1
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF11289205
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68D9190497;
	Fri, 18 Oct 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9q8Eih0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A9B20E31C;
	Fri, 18 Oct 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245636; cv=none; b=CYjIlAb/zrEqTUERdnzbuxAwM8+7MfhMrIp1lnKuBSbBmM0p6snY0qAk++MjdYgpjxFBFvqjalBw3bFaJmgdiTFPUcRVaf3yMhPs4Qfwwks1qKhsj/jHpDUWn5yLt0BlomY0GGXCPSQSs80f9zvgErVJXyxaz+9yvgJTwGWaMlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245636; c=relaxed/simple;
	bh=FW4aQWEvArHEKkA8fQ+kXYU10rHyGFQtsjKYYYgCvOg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oO3BOJWmN4gDNq5qyYgjrskJlZN/1ueOEK/XYFEXqqA9SqhjbEeAtOT27/CqFKEtrdvf7A9SuKTjUXUriUvNBpLgwQ05+Fca8GjQ5knD8UThRum9Yn6j3xT2NImdZ9ReuidVpynut1IlzWiQTWRygW5IsLcOGiQloWDAHpQFdEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9q8Eih0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20e6981ca77so1450175ad.2;
        Fri, 18 Oct 2024 03:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729245635; x=1729850435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5lubNeeLRmHthC4s9tNZn8PtHhfCx2MwTc3L+mSp18=;
        b=X9q8Eih0P+qh5rdP5pM2zGy3FwxNQDIjXrSai3ri2sBW50mtdoE7PRebsJZU0Ij1QF
         OVadSx0KLJ/uj8xIppveCN/Uf3dxhU7Lwc2+5ThCqT+7w0NuistiBuGhZQRc5PNvYE7L
         6ng20pOmHvfKa42zfCJVoOkU4ksloCbrCkxWMr4u8PRpzODQ4xjZis34EJJy+1Lu/w2s
         BfjquVLSPMuIUfRxY3/WxmWxHtHsJPfjQvUgqaER82sS8oKxZj+xnRXY7HfY04k9YiKc
         XM3Z9pUpPFPdXeSHWkslFhIEUPuG/XdYOS25pbkIALYBtTWhP2KyPByFLz72B5C1sFyI
         0LGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729245635; x=1729850435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5lubNeeLRmHthC4s9tNZn8PtHhfCx2MwTc3L+mSp18=;
        b=xPeeYLlpXVws3fExzvNhTXX791LLt4F98TFP9+z4LSsVXROnYhakjfwt/nwHVmd/wh
         awQwS1C/9g341vjSnKQLFjzT85Ng0d74tJ9BnT1DArCG6uueG57sZ6oxBnXKI+cnTWFa
         mEjKip6tFzeonJZ1RcDN4iJFk7pzmnr/P59VRdmgec1lBbxyJYdd1D1JWyk6ZVfmLbyP
         S08SLlGfNRQyhvOcNTCf0GrYQS0uni9KLFuACIt/grIu7oMtVq1jdZN8POuRa5T42JMf
         EX5XqTj08tKZAE7DWpvDNdS6SxdK8mCdbc0t7QJun+f+QYQ3K5JenehHlqaDfVZDzVLx
         NT6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhEGbjFV9me0U23V59WzGkYujyboGeJlbUBR29OTBoqwV5qyDnrtEB8tuFV42cCY/OUiIzuFo6JEY/wSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw02MlYVdYRSVY0KovjjETZzD+3UkVUtabQiz+HlIdpXrj9uyes
	GHeYggqBNUA5uk4TZdEFId2Eqoo4i/TuM6kEEhGnZELNdThCEBuI
X-Google-Smtp-Source: AGHT+IFR6ppSFGXKnbyyRbTLquP9bQee0BM/QDbaB/L3oOWSNl9Ejff+zHPGZ4gjWD8RwNrZRPZWrQ==
X-Received: by 2002:a17:902:f60e:b0:20b:ab4b:5432 with SMTP id d9443c01a7336-20e5a70d59amr22619825ad.12.1729245634446;
        Fri, 18 Oct 2024 03:00:34 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8d6cd6sm9343225ad.131.2024.10.18.03.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:00:34 -0700 (PDT)
Date: Fri, 18 Oct 2024 18:00:23 +0800
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew
 Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Serge Semin
 <fancer.lancer@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 xfr@outlook.com
Subject: Re: [PATCH net-next v2 7/8] net: stmmac: xgmac: Complete FPE
 support
Message-ID: <20241018180023.000045d8@gmail.com>
In-Reply-To: <20241018091321.gfsdx7qzl4yoixgb@skbuf>
References: <cover.1729233020.git.0x1207@gmail.com>
	<1776606b2eda8430077551ca117b035f987b5b70.1729233020.git.0x1207@gmail.com>
	<20241018091321.gfsdx7qzl4yoixgb@skbuf>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 12:13:21 +0300, Vladimir Oltean <olteanv@gmail.com> wrote:

> This is much better in terms of visibility into the change.
> 
> Though I cannot stop thinking that this implementation design:
> 
> stmmac_fpe_configure()
> -> stmmac_do_void_callback()
>    -> fpe_ops->fpe_configure()  
>       /                    \
>      /                      \
>     v                        v
> dwmac5_fpe_configure   dwxgmac3_fpe_configure
>      \                      /
>       \                    /
>        v                  v
>        common_fpe_configure()
> 
> is, pardon the expression, stuffy.
> 
> If you aren't very opposed to the idea of having struct stmmac_fpe_ops
> contain a mix of function pointers and integer constants, I would
> suggest removing:
> 
> 	.fpe_configure()
> 	.fpe_send_mpacket()
> 	.fpe_irq_status()
> 	.fpe_get_add_frag_size()
> 	.fpe_set_add_frag_size()
> 
> and just keeping a single function pointer, .fpe_map_preemption_class(),
> inside stmmac_fpe_ops. Only that is sufficiently different to warrant a
> completely separate implementation. Then move all current struct
> stmmac_fpe_configure_info to struct stmmac_fpe_ops, and reimplement
> stmmac_fpe_configure() directly like common_fpe_configure(),
> stmmac_fpe_send_mpacket() directly like common_fpe_send_mpacket(), etc etc.
> This lets us avoid the antipattern of calling a function pointer (hidden
> by an opaque macro) from common code, only to gather some parameters to
> call again a common implementation.
> 
> I know this is a preposterous and heretic thing to suggest, but a person
> who isn't knee-deep in stmmac has a very hard time locating himself in
> space due to the unnecessarily complex layering. If that isn't something
> that is important, feel free to ignore.

In fact, I can drop the stmmac_fpe_ops at all, avoid the antipattern of
calling a function pointer for good.
Since this is a new module, we can try something new ;)
Thanks.

