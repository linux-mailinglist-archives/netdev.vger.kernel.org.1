Return-Path: <netdev+bounces-133669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B27EF996A1F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9B41F24586
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA4919408B;
	Wed,  9 Oct 2024 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j543NyZx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F236194091
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477222; cv=none; b=A1YeBxY+gsJTFLeiBBGrpYsXLAv9vnZMJ5qZ1f9cBlDyKVEO/EZ3p598bXhkH0LVdyxVACEcHMlr57oxcEjbqu96K2ycU+daexzT4eggDxqLqaxRU9Z9qXUFM0UYY+JCWrwQ/c0eVv/hIp4FcDWw6PBZZD0h+nAkEwJlh013oAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477222; c=relaxed/simple;
	bh=E6+7kZSss+7DWKnOVlWlCEIEkfY0pcNGHyVw+16l6vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HW1drnCfNmy2vayyzCnUBAMB/jwIsH4ND4HVdWfPP+Z0QGnng0RkdkIdtU4qiIa0aLq9XbKTPu2AP4KdH0nBBkQf9DHQQiCCL1iEXF3s6Pd/IueUz1+5gXnMVvB2E6Vcpa52SsCreSMyrX0eC6tmvfHZR2ZTK8Qd89QbPHhd0V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j543NyZx; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a994df6bf42so32233566b.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 05:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728477220; x=1729082020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6+7kZSss+7DWKnOVlWlCEIEkfY0pcNGHyVw+16l6vQ=;
        b=j543NyZxTHjN8Q5MxmTEiIPMrYJVtqFGNHXwbtkiLt8eUq2NbNa1ewmJqNmhltQ56Q
         h3Qg9uaY2DW//x0EDnGwdY9H5vljrT/SNOhiz/jjDk3Y1niblSDEF+wcqc7F+b8Eun2E
         kTEih/atLxvzc2BxdGmcaBN3CiH+8uTEl8twWcK3NqtVIkHKMQiV6q8q6lV0Ku+o3kMp
         1MsKQShQ5/NHbbvJi5vo+a7yfGuIjunkfCqi8bPdPwk5yL1ix1xXeobY+paHo/nTZauY
         7n+B2qfpP+VUEpdqXmpzzjnbYr707zbtnQqXGrafRVxyTvrPiCaY3Q4FqDbc1qBuX+zt
         8JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728477220; x=1729082020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6+7kZSss+7DWKnOVlWlCEIEkfY0pcNGHyVw+16l6vQ=;
        b=GGi3vb50wKICgXifSZTHhcKy9PoqJ1alwIufItJmxKYbdaFY4Y65OSW4a0/VAwZQXy
         YCFeMZFNXQXDqq2VjABhm7pkr58c50p2PRKAtLtcWlZ7NYbe5kZsq0U5WEzKttCE2t9Z
         GfLNgF6TEJmLOWOvENVgaaBxnQS2AgWdUcdFo553ZXvgV6um3xPvCFS6tkSLhBhbErg6
         1TrhW8fLoXZOPlUlqMISwAeVSVpZcR6DZota856i+Lm6cMnz43K71CHp6syllE9rSend
         GrmPATR0t/0s7eLHkW+5W5zZRaoSuRB3KzYeyc5oh3Q6kpKVc4kC3jRVYJPSPCbJO2hg
         LqOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw5Rcp+8jw4AmFQwEJINRvRF3ADOLTPfbEAmzFrc22qXO9x55e5VmbA9wdLs3NUFwV6qh+Sj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKfr1e02uIIIVbrLp8Qh7hXBwxTnL3XEK1lUA2R0uBC2BqIhEm
	8yahuFF5Te0H0bpzVx381gLu/wFAPebiZGYcNjWYBdl1nG6V/GTI
X-Google-Smtp-Source: AGHT+IEcTP0gkCqVCb2bzS3SKLLEC3iTj+tAl7xz4LLhqPyvHO2NQQRd+YxykG0Q2OAe/9EbkJRhcA==
X-Received: by 2002:a17:907:7283:b0:a99:41a4:5b19 with SMTP id a640c23a62f3a-a998d1e2e2dmr77484766b.7.1728477219431;
        Wed, 09 Oct 2024 05:33:39 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99497e7975sm500701166b.201.2024.10.09.05.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:33:38 -0700 (PDT)
Date: Wed, 9 Oct 2024 15:33:36 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: remove "using_mac_select_pcs"
Message-ID: <20241009123336.h67po7obsmg5nc44@skbuf>
References: <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
 <E1syBPE-006Unh-TL@rmk-PC.armlinux.org.uk>
 <20241009122938.qmrq6csapdghwry3@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009122938.qmrq6csapdghwry3@skbuf>

On Wed, Oct 09, 2024 at 03:29:38PM +0300, Vladimir Oltean wrote:
> there's no other possible value for "pl->pcs" than NULL if
> "using_mac_select_pcs" is true.

I mean if it is false, sorry.

