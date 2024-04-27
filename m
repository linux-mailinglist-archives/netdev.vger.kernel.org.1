Return-Path: <netdev+bounces-91922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 262598B4729
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 18:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C3428268E
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5824D5A0;
	Sat, 27 Apr 2024 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="lK+mRDQK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A68C11
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714236142; cv=none; b=DZhRilUQdrd4ACOB/o6G3lBUAyIA2LlnnYDMg5KhiFyZKLnRiZuVURp6NKtTqhmB56SZ/q9yp7eqX+ngV7H1AIbt7jADNuu3NxSfEYI9CfVsXvbrhDhexW4LSK1RXIPZiHrGeXVFzmWJhhK8wX05oKajUczGdMovYzrxJATqWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714236142; c=relaxed/simple;
	bh=UYaCrzrHgEXS2z96Z28qKpMTVj/h/q1Q/+GPlHo1kuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXlyhZ+sRyYPp/KQO5Mro8XxFMXGqLtG9B2fsF7YsZ7sHhkgUBOMW0xS+55SIGMWe5arXrfsFLWQKMDdSRiwLGQZJhzHTGleKx23IBu6rrgRWow2jf8uro01IM2Dt+Ah78n/SWItbdvfoYojH169EVwXq9vkh66b986oyriZouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=lK+mRDQK; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f3e3d789cdso1381938b3a.1
        for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1714236140; x=1714840940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPAEfI5ky+EjatqW656tSfhz1B0+Ku9mO8C0XbXXf0w=;
        b=lK+mRDQKWClD/St7SAch5vW3zARd4jICxmkC7M0kE4R7LpxenULUzpyEpEPKUuwUgB
         xmwAt0jz3q/6YhliA+mVq6pTf/OLgbxTXrCNLb841Tqtk4+6PaK6eKEV+f3SvxFCt3KO
         Mtt/yl/ZWZ6wfDm2nbpygWkwPeAvdEVPBabkKNpNEbZQeI2n9SDbGLQTvy5xKz5uY6Rx
         u//W8e2HO0/4Sw0PuIbA6Ze5zMeyQRP4tkWzX7vqG3KKPYFnuTPUf6h9LxQ2fDbb0azg
         KUbaN4LxJL78+/BId4FQOYvjQnoMVT9GL9cvlFrHwXCqtmoPSKdvGVaVVocRcBxPkNa4
         Lblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714236140; x=1714840940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPAEfI5ky+EjatqW656tSfhz1B0+Ku9mO8C0XbXXf0w=;
        b=sssyoG4T+XnHAggKVg16BjfBQtQKX+xFAfBiEYQYVqM2Kc5IN34LzLBqkdMREza4HK
         LnxIrwOTasNJQKP8fLAAJhD5+tWmoGcgmUo7UMaQbzxQQA2X9BAAtNuS2QZnwMn9fjV0
         gUwX4lffcoZEgVfE3d613z4UpDRzBgx6y3iCkLYqYsHBnXpOcQCJ8FIFrfkZ0+cpi2NK
         YwEaKnHe/WUQJvoJNbhmoJtBrqOi5+hRiHBHoEkNrJLqgmFB+DUFbkAC6It8vvHMc//C
         qX/BxnrcVaXDxzcmmG4kZ0V/8u6qn2S23DnZJxAv5r1D/SOyw9ZmjfzVI5JQVcbQIztW
         R46w==
X-Gm-Message-State: AOJu0YwvpfgFYHD39H9TvfYzz9mV6X+qi2jH/strTf4wP8HuDielneYJ
	uBlKX3y6iw5BMZlSwhdEkNJ8kOFt7ijkpN/zkFXXhf9mB1JrvwikPY2aA9qvZfI=
X-Google-Smtp-Source: AGHT+IFur3vrSU3Ldr8G3Jf4HegYNIEKVWXiXyEsQ1NatMCrDmYrcM5N64CgWStZvhM1mbW8BhpkWQ==
X-Received: by 2002:a05:6a00:2e9d:b0:6ea:b48a:f971 with SMTP id fd29-20020a056a002e9d00b006eab48af971mr9401239pfb.2.1714236139922;
        Sat, 27 Apr 2024 09:42:19 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id r23-20020a632057000000b005f41617d80csm16065411pgm.10.2024.04.27.09.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 09:42:19 -0700 (PDT)
Date: Sat, 27 Apr 2024 09:42:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiayun Chen <chenjiayunju@gmail.com>
Cc: netdev@vger.kernel.org, shemminger@osdl.org
Subject: Re: [PATCH] man: fix doc ip will exit with -1
Message-ID: <20240427094217.28b5314c@hermes.local>
In-Reply-To: <20240423070345.508758-1-chenjiayunju@gmail.com>
References: <20240423070345.508758-1-chenjiayunju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 15:03:46 +0800
Jiayun Chen <chenjiayunju@gmail.com> wrote:

> The exit code of -1 (255) is not documented:
> 
> $ ip link set dev; echo $?
> 255
> 
> $ ip route help; echo $?
> 255
> 
> It appears that ip returns -1 on syntax error, e.g., invalid device, buffer
> size. Here is a patch for documenting this behavior.
> 
> Signed-off-by: Jiayun Chen <chenjiayunju@gmail.com>
> ---

I would rather fix all of iproute2 commands (ip, bridge, tc, devlink, etc)
to follow the conventions used by other Linux utilities of return 2 for errors
in command line arguments. Doing that is unlikely to break any scripts because
a sane script will be checking for exit status of non-zero.


