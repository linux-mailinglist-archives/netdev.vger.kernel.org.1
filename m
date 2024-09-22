Return-Path: <netdev+bounces-129182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 262D897E24B
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 17:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4281F2121B
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 15:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4BDE56C;
	Sun, 22 Sep 2024 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIYqdxIC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E23C632;
	Sun, 22 Sep 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727018898; cv=none; b=jc3DWjmgF8T0lRt/e29dLO878QrUrxIMvsAaYJNs54fuBSHHTEjzsIPD3oJs24uymA5DwI2aImjwUlR/WlqSF2wRdoQFxTqzeLKlOt08HQtsFoO74OB3vfW/wRzfDCZamsnu286PAbJJ6krp7ksmwO3s0PYB+5wMyaAgsFnrVSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727018898; c=relaxed/simple;
	bh=MlOVCIZr0b+xfTsVyWc2m4Wd8mDINI3qkQYSzCkBm/4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NKR5Mxri0vLSO/bePx4868QQ2HixLz7Kl5Ye+SU/JwnmblXWQmpLvzkiMvDixElooerGy+oymNulhtPVH5OZRFIIhU1H2uzglTPKabaSb8etxdyUD/ckCUZZfC+UF3C0sE7bdEDInzi6WiYoPWI9MKOH6FA6RdrEbPJwv6Tf4xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIYqdxIC; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a9ae0e116cso412694685a.1;
        Sun, 22 Sep 2024 08:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727018896; x=1727623696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FLqwzyjIHd1Z44gTOSWyBuwpGemYzWSR8FwZR5ykbY=;
        b=DIYqdxICL3I+iDL0rm8810R16U+TDTYn/v8sM5fSh1Rj6YppKcRCS5e4x5B3dxljSh
         IMfL0XdLGkgprEXcRPhW5CRZo973FtkVopD1lGuj3NTgtpGincd7r+Z10sbmZ5Qqsg66
         AljAd0bZFUtYI4tVcEaWxXZrTXbxF2h4fxCtFEtQ4EqEuC3reufZvL0kBYisuTMvTfDj
         enhIAUy7Yd+E36q56SsmNs1/EWLNDAScgrbZWiLCbgLip3q/xMw5R1SxjaCcBTEEJtuk
         OiJpI6ryL5TFkOHhEtbzaeUAm7/0eWoN/0G0Er66t7YvFn34uJ7gQKV4hyTyb0FRynUY
         2AzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727018896; x=1727623696;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4FLqwzyjIHd1Z44gTOSWyBuwpGemYzWSR8FwZR5ykbY=;
        b=l/lSpL/DpZnq4ufmj7thvAzp0MJTNBjWs4Yp8ccQN0TDStsZUhbQDM0ESdgu3qeGst
         vkInBmwg/H15FXeBUha17tQ5MJKndm/ArIfy84H5eMH0zgD9mjEC01ZBSIK6P2094kCd
         wa2ORr40X+GJipeIcfMprYQn/cQ9VaZNeNaQhVdsnTH+UYFDUvbvoFarZunUJspUH4Hu
         VWfF2rDrKYkwVn25cnM9b8Un3UbLSr5zPynwx3OeQna2t4Vya2h5+UyrYCTCJcm9hego
         P0EscusAKTs4ZqQTr54Fv7JAameP6JBKYr090qUh0+t/5D9H2u2dB1aXS8rKqcgRHWmw
         /cDg==
X-Forwarded-Encrypted: i=1; AJvYcCUof5V5Mg2EeTvdznSh0IXPH6JFPGBKtqHTeeaX/r+i2FKEtp8UHUeKYxClLaVzaUD1t2s1F4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwEQC4puTuaaDR5TRvlFAlNtFU23daLYBTEzY6xBRHZHc10BEL
	CxM2Wn3qG9GX8wJUx1vHurLUvpLb/S9c5yqBvRa7BFP0HG5nHgSP
X-Google-Smtp-Source: AGHT+IEKP7MO4f/h0LRuNTfLEIxZifEzmlbNIE51B4D1m5hsifHgSMoOU5ljZ4hxqEQu2TqIDClDNA==
X-Received: by 2002:a05:620a:1aa7:b0:7a9:b739:3763 with SMTP id af79cd13be357-7acb80ccc18mr1516287685a.28.1727018895895;
        Sun, 22 Sep 2024 08:28:15 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb07ddd98sm391774485a.21.2024.09.22.08.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 08:28:15 -0700 (PDT)
Date: Sun, 22 Sep 2024 11:28:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: linux@treblig.org, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
 "Dr. David Alan Gilbert" <linux@treblig.org>
Message-ID: <66f0378ecf981_3b28232942a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240921231550.297535-1-linux@treblig.org>
References: <20240921231550.297535-1-linux@treblig.org>
Subject: Re: [RFC net-next] appletalk: Remove deadcode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

linux@ wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> alloc_ltalkdev in net/appletalk/dev.c is dead since
> commit 00f3696f7555 ("net: appletalk: remove cops support")
> 
> Removing it (and it's helper) leaves dev.c and if_ltalk.h empty;
> remove them and the Makefile entry.
> 
> tun.c was including that if_ltalk.h but actually wanted
> the uapi version for LTALK_ALEN, fix up the path.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

