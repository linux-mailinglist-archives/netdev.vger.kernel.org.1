Return-Path: <netdev+bounces-89690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EF68AB362
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 18:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7331C229EF
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986C9130E4F;
	Fri, 19 Apr 2024 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="DIv90rFk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A1D1E502
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544274; cv=none; b=sroMABKg7Hi4biLnqJaFiXrgokg6WWJq7BHV9g/Q0iOI8iZIb0DHq9svdn4MsnzoIIIqB/zzGot2pig/ra/u7/VtrTQS5if0VokPMOGqAmRELD6mx9SCWqX2kUKLNrdCR1z/n1XPghx2ZRe/Mp+GNGhltTWby944j/Jm6a/9HMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544274; c=relaxed/simple;
	bh=Uak3nQX60wp3d+nPEjy5Ih1/XCbRSucCOAk1vaDdvSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFmpNvlmoJF9p36l7saMIjG96uXW8A0Bvgbj2DwrQLboMl4cUoMgr7g9j9Qw+0dpgeXFDCPZ23F1NWFe+rvsHDyHKUqpcVnc8kCU1qplNHl093RdGI6z4DEJZzhKrEmHp5klotVcnVO1ie16p912ads+J28nhFieBy/yRLq6eWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=DIv90rFk; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ead4093f85so2172549b3a.3
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1713544272; x=1714149072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uak3nQX60wp3d+nPEjy5Ih1/XCbRSucCOAk1vaDdvSs=;
        b=DIv90rFkeul7Sm4dbSWMtzFSSNqKlVx6q2vO2U9qeQvY2WSIBkv2C75RZE//mmRI2u
         vtjVYAm6DnEodBWW33QXIi/An9AlmnDbZlERaF5w0QpLYbGbQj0CSoVNuJk7sXyvqsWS
         WmABsx0TXsRkKIzPCWbe1CpnbIwZEhgH4tTyQrmEJ1bfJNtcFxgCldG1G6cZjkqQ9/YH
         5bwJsEmWEw9/kKOzx7wp1VSL71oVMsbsxvt/7Wet5c5baY62GRoDHi2H4AArtNhsgnMM
         OIzPm1iqmpqbCnHcXSlSNFURThdL1NkgWGkDvtHcYPUFDvz4Xsff6sGZbrfVwLCdn4e2
         jrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713544272; x=1714149072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uak3nQX60wp3d+nPEjy5Ih1/XCbRSucCOAk1vaDdvSs=;
        b=AbCt5utJnefJ2yX8IkyyGOVVhTcekYl7nzFJRcVx6iv/pqLZYHt+kjXnoU9K8Srpbm
         PTazf9EfuwbyRuJG27BLS6kqQOr28/ViGB2zfLBEm/Ev2GX9PCfHhODIPvgJaIgWwiQH
         gOWgu1jm6nBki2J3YC9tNecTCTuNHiWdQUGHn7Ii6UtNCAkQAntwKxizLW7subgpJ1S6
         fUhlCLdtsDkdbvjmt+8P6H+m/GoT5q2ravXPIY8CZ3kD5zD0ilAasnG1biE1PEXdboYO
         30n/UhyjCwmM1tUpiSy9if80bpRNV26b9w9/CZvBWcnVF45L2l1tFAyUhxBxLyDMDtLx
         KHVA==
X-Gm-Message-State: AOJu0YzAfuNJdl8nWy7jhs9DEd1zCLhyb13WoHv8CFkOSp14iUEkMpdz
	62SozV94VK/AvTLNQ0ToC6GXcpH4eFNKe1D3kqMi+cXtAwqKnSIHDOuaO1n26JEJ5Lv/IhAusMx
	M
X-Google-Smtp-Source: AGHT+IETtJ3M/rO8sgG1P3yYUKRycpoP1Wg5eJ9EU9GzYAqzsDXELje4L0tgMYJjwi5qH45NuRfMBQ==
X-Received: by 2002:a05:6a00:1942:b0:6ed:4288:68bc with SMTP id s2-20020a056a00194200b006ed428868bcmr3332970pfk.19.1713544271631;
        Fri, 19 Apr 2024 09:31:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id z18-20020aa785d2000000b006ed03220122sm1718558pfn.16.2024.04.19.09.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:31:11 -0700 (PDT)
Date: Fri, 19 Apr 2024 09:31:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Tom, Deepak Abraham" <deepak-abraham.tom@hpe.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: 2nd RTM_NEWLINK notification with operstate down is always 1
 second delayed
Message-ID: <20240419093108.0fb8c108@hermes.local>
In-Reply-To: <DS7PR84MB3039BEC88FB54C62BD107CF6D70E2@DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM>
References: <DS7PR84MB303940368E1CC7CE98A49E96D70F2@DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM>
	<20240417153350.629168f8@hermes.local>
	<DS7PR84MB3039BEC88FB54C62BD107CF6D70E2@DS7PR84MB3039.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 19:26:51 +0000
"Tom, Deepak Abraham" <deepak-abraham.tom@hpe.com> wrote:

> Maybe I'm missing something, but could you please explain how this really helps to not keep FRR busy?
> If I understood this right, the link watch code does not ignore events but merely delays them. So any link transition will be propagated whether its scheduled urgently or not urgently.
> So FRR will have to still deal with each transition keeping it busy with or without this change, unless FRR dampens flaps on its own?
>

A poor connection to a switch can cause repeated link down/up. I haven't seen it in person,
but have had to deal with user reports of poor router connections.

> Also from a design perspective, would it be better if FRR's issues with route flaps be dealt directly in FRR code itself? That way, in use cases where FRR does not come in to play, such a delay is not causing other consequences? Are there more such situations where such a delay is absolutely required?

Too late, now. Can't change Linux semantics without breaking many things. And it impacts not just FRR.

