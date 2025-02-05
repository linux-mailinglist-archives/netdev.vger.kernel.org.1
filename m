Return-Path: <netdev+bounces-163279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C35A29C82
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CEF3A4447
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 22:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5D1215778;
	Wed,  5 Feb 2025 22:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPy1u2pn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD4321517C;
	Wed,  5 Feb 2025 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738794055; cv=none; b=LMD2s7Xtq4VedDweMZnQvh9Pk/WSFLfdSI4ZcYXej/qogyFHpdoXGxiFUKiJN8bM9DacOQxV3tB3YBBOuQ6/9O1eRnd7AcgMTy1BwWExoiI8u48/dRhDauFBfRyH4/KIiEZTN0ZNdLRwsSJuU4xthGcZUd2O2E7c6ogMj5VfrQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738794055; c=relaxed/simple;
	bh=IkDOT8jW+y6VmqBLn6GhOSWV+JZ1q0tCtLKyZ94CV10=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TXpW48hoc6VH7ID04ThVdb7R1QO+GjEAWrzqTupLFtdbe8F8BI7Dw1K0HotvBKsJED7i4UHIc8k4vMZHrAPnLNYAfksKKVZDJdS/q0oCY5EcqlE62BSydH4nWVtomBIrra4w0HTFhb584r0C8IzlTooKUl9fbSsVdt4PJ5tjynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPy1u2pn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436a03197b2so1574185e9.2;
        Wed, 05 Feb 2025 14:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738794052; x=1739398852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2zEZsXNgio3ycLHzzBSdvhsr4ViTfHIhOPeOQIl0zg=;
        b=fPy1u2pnVdgSBYY66Xk7lHADJL8f8UG89btMU2103EWbBrUAkPx2M0jUs7AUk9Xddi
         uPH7MiVdq8BxST5EmiNZcXnrHpwp6gENngkwLuZnqI2BjD22NTeV+C6pWx3uKlD9Jkow
         vpvPXOdNssHVECwuyp/Vqr2ktSB7jIsbK0AMEJ0yCPedBzsAKoiBbJdzddApuOVI+c1c
         OYr7bP234bU9dTYqYgdHMAHU9RYOIPn/xC3b3bOBYpjTebsHzE72nc3lwBybX1xkM8Rr
         1LmRbkOdzCj0n/buYBa+NegBWRzMUBx9/Pj4zM632XTe2cWyf4p8LKecaX/ehmbeuyn7
         wJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738794052; x=1739398852;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2zEZsXNgio3ycLHzzBSdvhsr4ViTfHIhOPeOQIl0zg=;
        b=FlBCqoKUwCxuh8v1QYcRtetfpB1+cKAvDst+9k/pKOAmTPiMKaPGg5XwxoIJ8hTnfS
         n+M5p4fWhVMhtYqQRwGqFNhr/16xCJL0NdgIYgK5ODVf01exedxBHUGIRq6XE5YXzz2F
         EEd2CoTbh4/hLAOrb2zID2e3TRcx0j59eyiD1gcGYqZEN93WLbNFTk+zDvrInySWS63J
         y6btHrOONfws6B7BDCWWSF+AH58jdJI4SgZxecppRAencQnxECU4p4TauINcDTnfAKD/
         vZvwu7tv04R5u0f0xfE1Q74B3oN6EFggUqS6EnoVIQw447bVfT55SHPZ4eF8WLt0BMWn
         AX5w==
X-Forwarded-Encrypted: i=1; AJvYcCWhnUu8D7l5KvsYea6dxB9Ye9kDI4jb+yH87KliqK4TgxPXvjrkNxAujRK6bqR47fCPMKwWZ8NylVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb8v0Xk/j3iKLiegHSFdIt49SbByifM3d8UV/hafR4VZm2tl+/
	n7fIdqrY9zsGJkxyhDRuNwWN0LaQPo/3m8cXNygrlHRUt9tem9II
X-Gm-Gg: ASbGncs8wSBTSm5rvXRuPxfwJ5PC5mGEq8tiz3EY8PuZbZC8im7y4jCk999TfK4Y3kT
	dDa5ZJ01wpPDl3A3pK556TuaFVFnDbwzyuiYAw4t4FyMo7SdG3AAp0dEo2Wb9dCwqvySvGBEwqO
	EzU0+ccYn5nOEB9VopGIIwRS1CklbRgYyYMZQiVflI0preekGZI0rmZNtCTVHwwIgtFiicBDLqr
	yQ3tNZIdpwJZDUU3zeMtJqeu3Ni/YDrPLOHurDScxDlWjsm+mDTtanIJjI3l/FWvMxsfm2byF8B
	RQQY8E+lggKwLyMkovdvuWEPoGItB+DDZRGrEfOgAn4tkTE8UK49kl2B41pWN1hs9lcraHiJQQP
	xfoM=
X-Google-Smtp-Source: AGHT+IE45nBV8w8Pi9bDVA3sgaAiFG4Cx29HJ4EqpTj1KHdFgWKj8RIRVRM8fw0GCbh4U495Yg5ZtA==
X-Received: by 2002:a05:600c:4fcf:b0:434:f2f4:4c07 with SMTP id 5b1f17b1804b1-4390d43e840mr40248325e9.15.1738794051470;
        Wed, 05 Feb 2025 14:20:51 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d94d753sm33990125e9.11.2025.02.05.14.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 14:20:51 -0800 (PST)
Subject: Re: [PATCH net-next v2 1/2] ethtool: Symmetric OR-XOR RSS hash
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, linux-doc@vger.kernel.org,
 Cosmin Ratiu <cratiu@nvidia.com>
References: <20250205135341.542720-1-gal@nvidia.com>
 <20250205135341.542720-2-gal@nvidia.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <e559c577-0a74-2896-ae6a-7405ce6291af@gmail.com>
Date: Wed, 5 Feb 2025 22:20:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250205135341.542720-2-gal@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 05/02/2025 13:53, Gal Pressman wrote:
> Add an additional type of symmetric RSS hash type: OR-XOR.
> The "Symmetric-OR-XOR" algorithm transforms the input as follows:
> 
> (SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PORT)
> 
> Change 'cap_rss_sym_xor_supported' to 'supported_input_xfrm', a bitmap
> of supported RXH_XFRM_* types.
> 
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

