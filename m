Return-Path: <netdev+bounces-201660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D61AEA3F9
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 19:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5684E27C7
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7C8214236;
	Thu, 26 Jun 2025 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ3gtrYi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A215F20A5F2
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957609; cv=none; b=SQtsbSo48gt7QejrhoBklDwqn5nMCEcF1zpVlQCwjRm52s27AVMgf02p2SqyINT/ru19YggvHQFhL0osSxOhUz8K6ZoLb8KfcrkIDj5fyTq/i/joTELKTxfvcn7CN5FJxj8dIrwUrTBunPKs0Qmc7x2kQvu/+Wn532F8kFYXbJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957609; c=relaxed/simple;
	bh=fouh4L/OzBTxqsITo+gZhk8/dTB+lcUAEzBdrfJCD1o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Bu4SWqODtGHzm0X1PBHTipqL07iWsIwyaGFpYyrasw9vmhREMFzNAIEVyoulTP0Xfm/PyopzyrJrQE1VgPpEv+SXuZO3N5c6NSlf70dbmvxtSvPXUJXL5g19zSDYEdlF0hfJJCxOpuKA6kQXb1vAH9gHOrHocextcAK+Kt0mXP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ3gtrYi; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70e5d953c0bso14905717b3.1
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 10:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750957606; x=1751562406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TTTkxSEEtDGAJ6B5yivwWYIBaf9X+hMeLRgr9DVfbU=;
        b=lJ3gtrYi8k6olaVFmyGpu76ridIdrKh0hpmaboYmRYnuBFm8A4Ka3FB2IgjFRfaGQ5
         WKcQyF2sUpsvWcEhgK0FUlZu1RaeSrpPUn2up9nF0QusseI/iHmHTooL0eu4aw8K+EN5
         +B0HTdRswCyd6hMW7DXbT3F5dE9IfSLMEijuP9vCBaThI/jgLVkIMLMOdJZkUYxxHbr9
         KkMJX4D+5I35Xb5YTm8dV1pxB1lGdRo8SsBW+Phxi9YDZ9Jj1BhU5BI9++AfWMrOh4po
         dCD3qkAaxEXrZSIC1zho9gSQMgwyripputY8gSsA1fDT3FbTRxifjTBtaeuoCAOtnEj0
         hBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750957606; x=1751562406;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7TTTkxSEEtDGAJ6B5yivwWYIBaf9X+hMeLRgr9DVfbU=;
        b=uYHf87ctcYBa+MU4PdY+ayfbwA5Cf5Su6DAFS9SZZa0APFKhrOLwa7Ht1DWP8klS6z
         eY//M6DiS9OTrbcR/jrnmfd3YNCo8/Pd6Buq3iFd3tu9+9CuDiuc5KWWk29T1MDoBh8e
         mNlu+PxbwUQfVYtH13QwwtKkSkr7rrU0WSZC733rO0H/E7BvPNWc6jcMn4Da+yTZN1p2
         M5kp4qRKAK9bE870H4kgMPKvSIC0gc02e8/1Czm4xXkqCFzJCFg5jONzqHXtPeVZeImt
         p+MmPctZ7lEthTvzWO+//QWzf6T3OKhrpcIV5pds0/OpSI7uzBiZYVqQo2tM6vFif+d5
         Q6Uw==
X-Gm-Message-State: AOJu0YzThEFZZP6+5QF1wL4oWVJuM4HBbFHh30i8Lq539uxUl2Y5UTZY
	BXSqzicveI1hTlR1fIGtMqVHLuVXzIDjrHBDRjU4lBdWInoVSZgH8RtXzZo0lg==
X-Gm-Gg: ASbGncsdRdZaVeica1n2Mb3l2RcR8h7xahw1TIhD1kfxhavN+n1zm4BrfYJCmoOUfUf
	6otWmrVwLv4U2OzP0JsafYaqlTlmTSb7/bih/YJEuUEOlJNelWuCM83GUtsIHjWsGznD7GGAQJD
	gHRWIplPZMc7bp6JNek3vdfqiqH7iol1SDhhBWCop0uWGpLO00EomAywvprfk9I9AO3e+Njplra
	q6yG4HUQWbiRFvTV/LL/bBsQgJRmeXkt+2rF6ctalzDhuF7wy7TOmIvXaTGk3RUDGgE7k4/5YCZ
	z/R19Cm7KKUCIelNKZ7uvOiPDxX4D7eErdv2ZyABry7udLZdJwLpEjqdN3QYwQSFBTLqQPg1Se8
	xGvmyM6KqtNIpIzrhfK5RA9bjkvkjT7stzLPRd9TEXZGza8cnAZpI
X-Google-Smtp-Source: AGHT+IGlNupejwX5w0S0KLmAxUztVIfamKDLRw/NaNOknE32E/z6XXHd3lQBNj+O5Kai3h56HI19Qg==
X-Received: by 2002:a05:690c:6205:b0:714:691:6d1d with SMTP id 00721157ae682-71406dc6792mr111168647b3.24.1750957606395;
        Thu, 26 Jun 2025 10:06:46 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71515c9028bsm658947b3.62.2025.06.26.10.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 10:06:45 -0700 (PDT)
Date: Thu, 26 Jun 2025 13:06:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 Ahmed Zaki <ahmed.zaki@intel.com>, 
 Madhu Chittim <madhu.chittim@intel.com>
Message-ID: <685d7e2461181_2e676c294e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250620171548.959863-1-ahmed.zaki@intel.com>
References: <20250620171548.959863-1-ahmed.zaki@intel.com>
Subject: Re: [PATCH iwl-next] idpf: preserve coalescing settings across resets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ahmed Zaki wrote:
> The IRQ coalescing config currently reside only inside struct
> idpf_q_vector. However, all idpf_q_vector structs are de-allocated and
> re-allocated during resets. This leads to user-set coalesce configuration
> to be lost.
> 
> Add new fields to struct idpf_vport_user_config_data to save the user
> settings and re-apply them after reset.
> 
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

