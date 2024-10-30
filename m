Return-Path: <netdev+bounces-140243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6529B59F1
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 03:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFA61F242C8
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 02:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B209193063;
	Wed, 30 Oct 2024 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKtDsbgN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81211BE46;
	Wed, 30 Oct 2024 02:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730255392; cv=none; b=Jk90alWxO47gz0xLfSOmc3owAT40M+J9c0f/9rc1B58aixfkKvd+bLH0kmfSzDy9nsXisO+2hUOgy7RgTfykWv1OQmoNoe6b30Ep0JxazxVhvEEyxjBihC/nCJYbQtnGdt0v41FeaO+djdGHj/qC6M95qabQTEsjalsQgZ3qxmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730255392; c=relaxed/simple;
	bh=9ruMqdY2bry4FJOiAjnED7TcQMhgrho6KLl9cyXbF9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jxqo4ykSvYhSU6buL4OT3xvENlr5/v2CUDvbS59Ew/hp8Ftiie4Lv7cPqvv32jtuuBX4MSE85HhZ2DgeG2CKYvZTnj0Z0cyIyDhYaf4tgqmnjwll4rO3MCb6yXx4ygGrhKpRyF3R0+sGB4AMjOs1SumIf5nYr7riasAz3V3H2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKtDsbgN; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2a999b287so4983197a91.0;
        Tue, 29 Oct 2024 19:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730255390; x=1730860190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/o5XK5OJrkzuHt0jaoQyx3CwN+lOhE6gCV0XZuBDN8=;
        b=EKtDsbgNA+rD2AajU5fIiaIoAqhIOg+RON+oookTovOK5JPRMNxTxW5qEZhi+55nrE
         0JB2SJC/mtZzTb5eUzqTOHTVqEjrbi0cY7nmt0PqGWtgo70K11O8neFNE9IdWdOGOms3
         fU4Ya6/BLnXLp619Jqcpw205dRKfRzb/IExmZGZMTcWNCNdhhByE/FovmjvWb60UrIaX
         jYs05U4Ycw61fGIiH9UmfPJ66YoXLC6kN2K6v5BxUxCfsP0hDP1qswH2ZM7B3JRWnEbO
         S9tBpH9AqGQWVry4AjuE5vTXpiLM3qbjAu37CwgqVqEm+iZogPac1z6sPuSxlsde062U
         naSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730255390; x=1730860190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/o5XK5OJrkzuHt0jaoQyx3CwN+lOhE6gCV0XZuBDN8=;
        b=LvvpX9w2WIl6IOX76apiZFnyA9bwtGIVlhMGcyldhu7OSnLwgx/0F0BFcXmfe1z0+N
         wEGFGq1U8GxkpQGBfwEL9uk3ay5XNrBQDIGc9DX4t77b9WoetKMpyzTekZ5jTW78pHXF
         UHbH+InjXLUUbreqn0QRLPEpIhhACU97BvSQ9Hup0m+d54vIp3xizEPgRaeozrxrI1Tx
         we8dskx/QW+GouaNCpAlH1B4CU+GnBzFAXgkU9sVo4AJi0HrQjZMyBMOVijHPqvEktW7
         bzcDF2wmhWY91d3ZCbB0cdzYErh9YZj/aVTjzQtrQnTyH7WOFKH3+NnM+FksaTpu97wJ
         NT7A==
X-Forwarded-Encrypted: i=1; AJvYcCWDCx+5KnSJ3EzfaQe0MtigO3GWHVRzFH4x5e0lWJ5/+fUf90OUyzVZvv1F8ECGWzpOrzziHDnu0GOIzCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4w300XmmcBTuTiHfGHkNwEPkvk41PWocwx5HOzkWVi3AS3vEW
	FaQarYy/aoGSGYCvpkTJLgjotqS0kyFLL2YFqvp5Ct1CTWtNF+0R
X-Google-Smtp-Source: AGHT+IFijIy1xOySQ/m5xGQRS6VrQCf5Idul7+RyGkBFMYnlMj95XQcicMtXJGIScuTdNjzKS8VqNw==
X-Received: by 2002:a17:90a:c703:b0:2d8:7561:db71 with SMTP id 98e67ed59e1d1-2e8f10a6eadmr14210471a91.25.1730255389397;
        Tue, 29 Oct 2024 19:29:49 -0700 (PDT)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa0ed8fsm431801a91.3.2024.10.29.19.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 19:29:49 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:29:35 +0800
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew
 Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
 andrew+netdev@lunn.ch, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 xfr@outlook.com
Subject: Re: [PATCH net-next v5 3/6] net: stmmac: Refactor FPE functions to
 generic version
Message-ID: <20241030102935.00005ad5@gmail.com>
In-Reply-To: <20241029185231.fgy6tofi2uoslp3l@skbuf>
References: <cover.1730084449.git.0x1207@gmail.com>
	<0f13217c5f7a543121286f13b389b5800bde1730.1730084449.git.0x1207@gmail.com>
	<20241029185231.fgy6tofi2uoslp3l@skbuf>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Vladimir,

On Tue, 29 Oct 2024 20:52:31 +0200, Vladimir Oltean <olteanv@gmail.com> wrote:
> Let's not change the output of stmmac_dma_cap_show() sysfs attribute if
> we don't have to. Who knows what depends on that. It's better to
> introduce stmmac_fpe_supported(), which tests for both conditions,
> and use it throughout (except, of course, for the sysfs, which should
> still print the raw DMA capability).

stmmac_fpe_supported() is a better option, thanks.

> 
> Which devices would those even be, which support FPE but the driver
> doesn't deal with them (after your XGMAC addition), do you have any idea?
> 

Well, nobody can tell that but only Synopsys, as you can see that
stmmac_hwif_entry in hwif.c defines quite a few MAC cores.

Since FPE have been an optional implementation for MAC cores, so I think
we should not convert FPE implementation from optional to mandatory for
new MAC cores, for example, a new MAC support is pending for merge:
https://lore.kernel.org/netdev/20240904054815.1341712-1-jitendra.vegiraju@broadcom.com/

stmmac_fpe_supported() is a perfect option to handle these concerns.

