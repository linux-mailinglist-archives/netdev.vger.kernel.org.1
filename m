Return-Path: <netdev+bounces-174899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F81A612C0
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 14:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223BF1B635E5
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79561FFC5B;
	Fri, 14 Mar 2025 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ku5g0O/a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1711FF1CF
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959239; cv=none; b=VXqgpUk1j9Es1gnbkP7lWhVjad8tRf+N7Wov492yl6Jd/Cm+9w6C5NU/6TeskCE5DOvLOEbsVZx/Tv5aMIdLVZfZOUk8xtcaxd3n1VSE4a32F/cc8tyHKTl11pz+QEyVAZwy/6KZgRhYZlItZGe++a9NfhcYb4jP0D1pj+O+8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959239; c=relaxed/simple;
	bh=3xh3DOvzyDAUCx/qDA5kF7cyI0VMcwnlJcCuIUwSCLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lip+YYLtAxhFe4AH5rXML3U+08Rn2cuByYi/iTCZGfptsPV16tfQ8+NWBPB9vzE4YUbPDQJmaGV/GfASr8+VHDw/LRNAi99LjUHwBY7EMiBXW1pmoNvcmc4V6L6qmbIroSL8Vnh1rK4GnTCu7p8BEzDyi+pdtWkA9y1gq3c6P5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ku5g0O/a; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso14237745e9.0
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 06:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741959236; x=1742564036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3xh3DOvzyDAUCx/qDA5kF7cyI0VMcwnlJcCuIUwSCLo=;
        b=ku5g0O/a1AvgjaVyIxY+u5l0IQV9dUkKdx7OWXGVzW6VLcKEYADC/O+XzbaaFtwkNK
         2TW5BrsAvbupqmGLH79QVgxGnLbwDbjJrevsRsr8B4n7ScIIeGiOWXKa3gQhXSxLWYtv
         w+naOL/mLkOt30ADZ60W6G4lBKJG5jrmeH4rJ1BdM1tkUKd+utpxYjM7vtlvaZ6KOwdI
         7VbWyRjC0kkP2XJU83ajuYZNQ49q6LysgWjzDv7zZZvCfFS96CGL7bWPS7Is3mteW3+o
         uApoTHK4DHtD2o4G/qD27YMuO2Hov8a7642GL++skC9Gu+/H7LVMuyWEqV+kiZl77uTJ
         v6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741959236; x=1742564036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xh3DOvzyDAUCx/qDA5kF7cyI0VMcwnlJcCuIUwSCLo=;
        b=wf1t9bgWVyl35f6LAeKiEoxrqKmHC0n5tB0Camt1BgAx/IVfy1MEJA5UadVnLzQ6K9
         U5ZxOlfSTRgGHBTQtO4sTOhhRI2bTq8qwKuz6Dgt/wMdM9XlwH4ew2qfXxoFfVHkfsND
         1oAZKCD/+BtlriDbaXHtXIZk6HDirQzLBGa1dwZpXGF9em2NMEoQVc+i2OE/alBn30qE
         4Xkdo8/hh1JMu/B7mKCZefJ/Ik5EeM05ORNxDgtG2OD8Cbgv1lOpv4BADKKXyrZtHFPO
         fpRHiBuSnVrGHYmWXON9ZiGOCbhSsdTcoPJy58ItWyS4DOUJxRzZd//cpEzZ3WZEqfDC
         lF4w==
X-Gm-Message-State: AOJu0YycuqieUMqmkUWy2lMvhYuqtUSG1reuC7sDIUoyCXB89P6e8M+i
	NSF8fiNmOlbwZgKz7rDDDbdBbmeCTUKAcJJvBujeKWcNaRbwxDABWOvi7/sXJG4=
X-Gm-Gg: ASbGncugOUCI1uah4I9/6n0F79My5eYE7c/UVWxWluPWinWUXdBjTunsMz+pPSWZ7s3
	gBpQ9/NtjD8KN87d8HMI5uxYe7OVm1Lo4H8BG2D+wGKgaztoA3wlpiyXR/qn4CJIUHG3eMyR13K
	icILCQpdhDp64T/F8c7mf0FNNGnpsk8b4I0mYpyNKPlwStpGiYSgn6eaz0fxLL2uU/Qm6WtBH2X
	EtiN9Akhkp5HX3de0N5iiTfehF2AJchDAfHxSnLqd5bAiWn4iACCCGMD7spAeLv77zI6PCgGERS
	k1vXSpSq1XtT0/9okXKNAssbNTGHCUeS14SyvbmwG+oYNAdbhEG5ClpGifZ+YOMSiyOX69w=
X-Google-Smtp-Source: AGHT+IEUYVVJisJTgwudR+GItzyMdrac+rFViwUHFROMotaVw5KsfY4bpgeBdfWcvbp+g6V5/j13kg==
X-Received: by 2002:a05:600c:3206:b0:43b:c7f0:6173 with SMTP id 5b1f17b1804b1-43d1f84acadmr27463965e9.4.1741959235903;
        Fri, 14 Mar 2025 06:33:55 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fad59sm17612565e9.26.2025.03.14.06.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 06:33:55 -0700 (PDT)
Date: Fri, 14 Mar 2025 14:33:48 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, pierre@stackhpc.com, 
	hkallweit1@gmail.com, linux@armlinux.org.uk, maxime.chevallier@bootlin.com, 
	christophe.leroy@csgroup.eu, arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v2 2/3] dpll: fix xa_alloc_cyclic() error handling
Message-ID: <nhvgxs7hu6oxshtj2vlowjcg7fw645xntjp75owtwbnovbacsn@3nuoo2gvxicf>
References: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
 <20250312095251.2554708-3-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312095251.2554708-3-michal.swiatkowski@linux.intel.com>

Wed, Mar 12, 2025 at 10:52:50AM +0100, michal.swiatkowski@linux.intel.com wrote:
>In case of returning 1 from xa_alloc_cyclic() (wrapping) ERR_PTR(1) will
>be returned, which will cause IS_ERR() to be false. Which can lead to
>dereference not allocated pointer (pin).
>
>Fix it by checking if err is lower than zero.
>
>This wasn't found in real usecase, only noticed. Credit to Pierre.
>
>Fixes: 97f265ef7f5b ("dpll: allocate pin ids in cycle")
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

