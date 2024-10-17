Return-Path: <netdev+bounces-136429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FDB9A1B53
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75651C21F48
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F9D1C1AB1;
	Thu, 17 Oct 2024 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2jb80Sn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20491C1AAC
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148777; cv=none; b=F8XgSuMmJHCsLqpusy8HkED1zlUpseBLzkpZcXJ9VoffumQR3c7ePZ6bQoZsG5pEm20BBCsda501R/yUl+uSekox4XVaHp/Snb6iMSu1YI57UmmQsh6ZPLsIyx6SToC0i+Vxwd4zwohBTJKOHr/OGtHC8AEIZrJTVpTnsRLv0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148777; c=relaxed/simple;
	bh=aschrE2Mu7PMsJzyvdAlq5/GE3RxDCjeUBGeqRTPbW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEfg2TZcgv/vvb3XPhavSxEe73eI0bETjVZuIM2UUEUUpoJXE78nWHJZ0n1/4kRQfIgcu+WEHyusRZOBX3+gr35urRwRvJSCZ9YS6zMofwMiJuFiF/QYO33hoXWjt4c3ypYKVDRUVVL07NxDxxmdwY2NXBoToPVYHG/sLLsFzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2jb80Sn; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c939e5a0f6so90851a12.2
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 00:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729148772; x=1729753572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rnDgSxm/L0K26bbocZ8FXq79nAB7fwk6bluC5pHziSo=;
        b=V2jb80SnHjCxr5Iis3etaITixTgF9vF7+QqD+iv2YaN+f0w5jCnJNNhw9ai39bJQCy
         J128RfIuRsar/ZwrP4xwn0imoyYI1RehtIpDQ10iJsJ7x4qrdp8YYtkEJvImq0beJUIh
         zjClcPhGC01Ispe+lQ/zISYZ42ocH4UYBaGktUqO0NNoZwxEf8ttpr9lJTeXm90Hot9K
         M5h0b1C2ZygqMu3ieBUcQvha+dFcHmN62O6lsmD53QbtemU9FltLSI7V3WKIC7IBPwJt
         NEVA+jqGEVVHmj/ccc6H6OWk3o2VlTn9vLsl3X+zM9at9cN2R2fNoLKGrAnsOKhslBMk
         NuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729148772; x=1729753572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnDgSxm/L0K26bbocZ8FXq79nAB7fwk6bluC5pHziSo=;
        b=RPc3m9SBRQ2w46SmthrhYPoUOi00atU4+9r1GQfx1iSEBMSwJG0imCbvxwTEBL7bK3
         sHWDuzkn9VoMX/QTVIHvFCRdRtm2KwL52G9jvWycIOh84do3iBLvVaLj5SX2m2NksI80
         MPFjRULE01j269t9VUi1B3Hzw/oXEEjwDlRuUmBlS1IsoSmN299YX22mEPiXI/arPwHG
         9yRETuAooAG0228Sa0RZBh+XQFB+aKXA8jWIlQcq6FO4PaVMUhGVlM9GdjBCEh/NtNb9
         cxpkEftdk0ogaROhKoNgca3gXZRV8ziL1FIC19XXqnNvRryaL/fUMy1yHu5lYb/GwK0t
         t7ww==
X-Forwarded-Encrypted: i=1; AJvYcCXOHcvyMP8Zd7RdVS2wLOzIWVxfWzwPkj0OViovTsc45Cgww9nhIkjkcPOo7w8vvQfONpYtHbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhwFfChwWIQZ8q4wlwjZ8kUbHP446m36zRb/rIGtU30oceGTC0
	kAHJ8b6N0F6be3xA0nzjEETL3vPM4vhukPJSITAYJFhGWV10k8SW
X-Google-Smtp-Source: AGHT+IHflo+PlFe3qeJtIxY7rAE5RNAwkhRGS9UcAKJ3UhzXw3edl07XMK4xNPNaoOXh1cjpwyHXTg==
X-Received: by 2002:a17:906:6a10:b0:a99:fbb6:4970 with SMTP id a640c23a62f3a-a9a3b0a7f81mr217046066b.0.1729148771979;
        Thu, 17 Oct 2024 00:06:11 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29817f60sm259285866b.140.2024.10.17.00.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 00:06:11 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:06:09 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 5/5] net: phylink: remove
 "using_mac_select_pcs"
Message-ID: <20241017070609.ml7stvi4xlvktl4s@skbuf>
References: <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
 <E1t10nk-000AWo-Sv@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1t10nk-000AWo-Sv@rmk-PC.armlinux.org.uk>

On Wed, Oct 16, 2024 at 10:58:44AM +0100, Russell King (Oracle) wrote:
> With DSA's implementation of the mac_select_pcs() method removed, we
> can now remove the detection of mac_select_pcs() implementation.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

