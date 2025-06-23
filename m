Return-Path: <netdev+bounces-200270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E6FAE4134
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D56C165EE5
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF58246BBA;
	Mon, 23 Jun 2025 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsRRLEoR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E34E23AE96
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750683219; cv=none; b=KzhifdBN2kcTPR84fmiJJUOXxf9vsTGJFwH2MJog5AaAjx2du8B6Y1fT94APiTiAgxF9ADpTrXPFhYZBMpGuH+bctZWpStLgF2L2v7VER0TgdS4grlPCFO7oMf/27uWlp3zoxrkwuiL904fynbh4i4Cn/0B4OTHRyTvbm7HQNYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750683219; c=relaxed/simple;
	bh=vSBRFFPaxRF8G+FGNBBLYeFG+YIbRuzFuHuuhHTWOuk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=AcCwO4wDyKD0F3cP23q9GVvs3b8bT1JhbiAWPOTQWVtq4MuPJGfx+M803QokGO5w9p+y3qx3eWKuHqDf4Pd/Bt2neDbycaOIFPLPDGQPeWBFVP/ZV8TWvG/gpkm+bOa/ouEDSZTrMKKKf68zP+UCzyPbLoCWWBi5EfiJX/pmUj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsRRLEoR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450dd065828so29867585e9.2
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 05:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750683216; x=1751288016; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vSBRFFPaxRF8G+FGNBBLYeFG+YIbRuzFuHuuhHTWOuk=;
        b=YsRRLEoRqR+bpIbC5qV+amRoKcHoZGqbphoumZVOCSgmMxd/otn8Dj1lm1QQtEjkTu
         WYveR+dpdwJf7hoDA3U9Ao3HJQPvGnqBqPB/ulxVjBD2QDadxLORFTQZZFbO8/L7H2y8
         pho2OjXc4blKNplRmXL1Pwbnk7DQ/8MCMLQxDIqZXpCDEaEW93p/NaLD28xFF/6yIRpF
         mTX6hX7WAuuIpq/JZe0FTEvNUoipYooKKO6mI9Id4diWohoFdBhHfHmrF46xuu30SJpI
         l6mqvtslPJxE+D3uLDvyNzrNQLN4juDkW3QLIQIrn4HMJnA+kA13i6z3E/PU0KlVIJOC
         GSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750683216; x=1751288016;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSBRFFPaxRF8G+FGNBBLYeFG+YIbRuzFuHuuhHTWOuk=;
        b=WTEdizgSWMOUQfi0PG1jrlRiRRHOogrqSMWj25lEZzPGic+vxbgsryGlGIbUajOO7I
         4HnoftIVGFu1CT5bj9Dc0giToFEJq3CwrCwGLWxsNjlhhyfxp7ErBJq/pZ4e8odiL2Do
         mBrNFYJYEdKV2q/zskgY71CWVDlZErvlNngmEexDtiXsHrFhE+rd5YcXduk+Owyq39QG
         ZoJ5f1wGkBJ/AxoLaADL6Bk4eBr5SX13KSDW7NaI2ZFIFNd//Byvym4jM6fVz+GHnWMa
         es/vMwy3MpB8sp/WCStPHFOtDgnETUKolQSkhNEP0XLRPnvHSDIGVPbLlomyHuuhYs16
         QhGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEJGTCaiyGsguHwRjgW+2lwKV0RKonB0LU7Yr8Q7861iU8JldLxxoi4IDNU/ffeH4ELv7zy14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26LEEyo+xi3AyVwe7KgAzz3ngDeZ4iD/E2Sc554+7kN20q9Uc
	l8Klzy2XXcVk9kbg418f4tsdCKoad9aXz0SrONEp7Y8cER9YAke3GH/p
X-Gm-Gg: ASbGnctJkdHynLKZRt97yqTBi80Q/ezHPL7WJSdsaHQmGQ2UpX/En/tIJ75hzj5nTv5
	cB8LBTUgMc4A4dW6IQa7Z1Ft7hdFtfM3SjG9AGYzm9xON+gfGLZ/1HrcETBUBeL008kVDnmDBaD
	z5UdK22XMcREFNcViL4ccGM51fqy1GzaZqZoeVJyDlj2Txbpmqu7pNCp1W7z3oir9me1v7xGiC2
	xMsjo3Jf89GThix9rIhxE3c1MA5rCPjKMqJzYP4SZnAhadD8sIu8xh+g4z6EDITIbqq3Qmr1GYM
	VhfYQpyZoJE26c2C/VIMF/F4lQHHa8CYPSewuVEcAJ+GpVl7VKkIDiib9oRSDUFi5mjAHMIlk5c
	=
X-Google-Smtp-Source: AGHT+IG4E0VOOfIh6HJFjxTvWZP9dzuZkm5goW49sTk7Zl/AgfaCK7Yp1Pl2uaa+ffQyhinXiXsn+Q==
X-Received: by 2002:a05:600c:45d0:b0:453:6150:de50 with SMTP id 5b1f17b1804b1-453659badc0mr98596955e9.28.1750683216174;
        Mon, 23 Jun 2025 05:53:36 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:ed85:62cb:5684:a2ca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453647070cesm109688125e9.33.2025.06.23.05.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 05:53:35 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  maxime.chevallier@bootlin.com,  sdf@fomichev.me,  jdamato@fastly.com,
  ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 1/9] netlink: specs: add the multicast group
 name to spec
In-Reply-To: <20250621171944.2619249-2-kuba@kernel.org>
Date: Mon, 23 Jun 2025 12:58:34 +0100
Message-ID: <m2ecvaekk5.fsf@gmail.com>
References: <20250621171944.2619249-1-kuba@kernel.org>
	<20250621171944.2619249-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Add the multicast group's name to the YAML spec.
> Without it YNL doesn't know how to subscribe to notifications.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

