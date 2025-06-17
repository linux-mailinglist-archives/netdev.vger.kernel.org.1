Return-Path: <netdev+bounces-198776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AB9ADDC40
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88430169634
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0584E25A334;
	Tue, 17 Jun 2025 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="pfDII7wp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B32EF9AB
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188277; cv=none; b=odpo057W2jUje6jMHQNWgu83tMymvzDYtgr3edHN31ytMVspWe9pfZzz9MQBeCnBdiuk+FOa+igDDGsEF4oXYvec6epV+ihFoqjQ+3uB36bu5Y2bsMDK5my42XIsCY/FYYXFY8GH18ymJUVkwzKoYt5WwhmUMzu9wvTcg2JAcBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188277; c=relaxed/simple;
	bh=wxITHfSd4Ig5ClVxNHkuxbcHqov31yIkQRlSdXDIb7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sESFSFQC36mWdoOTjWxNcSzaUQrnHpbhlonpBSMJlJ24eJOu848AZEAGc1GLbnICUQNH4PY8irQi4YXCqvWIQx7JbV7DNq8uZWEF9NZlgsCwo6yys+7pBSGZpOoKI1ffRGqZEhvF81jUkk1/DHcHwnwL4WPsKY1xIq0oVMuiJK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=pfDII7wp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d6ade159so51417265e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750188273; x=1750793073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7RPRiJ0Ed2jA45UVI8gliv/ukTvA9NeHa3s8FNmv+M=;
        b=pfDII7wpK43uKGNVpRDi6xONcIogQbRrrQXS4xu7xFlKjoxFs97U/zhJIN2g6jJBb/
         qRyl863o2EW7VRQHbpdZuYx3ge30yQTRlwBq4NbN4KDhBJEyY0fvxExKZXQdCzKC0co2
         xpFJBLy1xOHaFzAudmF2To/Rx4DQJvE3/etZN2QeFl8mvFlovd3RYMfsuM6Ln5TZz4mD
         gHIL5jj1Y+rDqFLRxElr8Yg+gLXCaG2O7KBrKVtnu34X2/gkdmvVBzXG1uPi01MPe9x6
         EpMtoQ/VZOyzzGiblQRHftck6GmMNQhPaRxeN1bD7/TXCwZSzOf1RKyF2Olkz4nW0lVw
         1T9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188273; x=1750793073;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7RPRiJ0Ed2jA45UVI8gliv/ukTvA9NeHa3s8FNmv+M=;
        b=r//AfhBRsGKLvYeniOTUWDbRs40BMDI6aOmWqfW99qCzCAuvY8sbjjVEanCBjrG0za
         qsFrc1Xegomqv+3uuQqmqpvv/T1vFw2oL1jG/1vLDg3sAw7SJvXDemOcutv+BCZhBAOH
         T6jUEHeXZNJupW8+3VbcRIk4Vv0Rv26O2IeeRcXrK5VRbkDUIJmzThSk6ZVUAGp+oCno
         3v7uxMZrLMBqmWe64gG/ruE82GvYWnyErQiHOCqxPQE4sXVlPLIv8IHbwHdy2UiR7c8t
         DQQtQDRsYRL1vg+PHt1bSoJtnZGs2X5AgVCGJQukGnuciGA4Ei7MdPKLwcWCZyaJ628Y
         llaA==
X-Forwarded-Encrypted: i=1; AJvYcCW5S5QdzKz8RhdiLdEpJ/gmhieCfK3QGq1z875geaGyDTZXswIoUaDMfv9b9XqiLwq+ohUOOH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPwMyGnr9qP9kBDBYAufLMhXke9cJ2yKGme/CNn+UMz3YJiSia
	XmJLcdKHH7mnmzVPThqH0o/9bEIhNuxfdN2eNiLupdAIRbRwxf9Bp6/7g5Hh/KItbZs=
X-Gm-Gg: ASbGncvlo9ZwDJtLLBfMRrSHPeJ0TGa2wX2iqegkwR4a44kzAGBIOlSDHcnD9A00jnL
	D9CEozJ14DVLEqka22bLpnLVeOvL9iwaXI6G0IziIZVsh5HnIjh546o+ue9VsZeHWC7aW2VEPX3
	aGUjxpJQc6ehzSASSWFHZQLsjx351lrQZlX4f+fPkPXBcHAPGVpRHnP7sOika7yxqmd59SBeHTl
	5gUP521EqBzZ/wVFlag11PaL4mune5EagTs/6oyW4697K0utjtyiHA2I+XxY8SKUsJU2f7Wu18c
	nYp2ilRh5Z6ndvXcDBYIO6XKEElXaMcB0yDJqyq7OIRlngO+krJLfjcFtoSsXLCz3lUbTV3jtYb
	Aag==
X-Google-Smtp-Source: AGHT+IHv7oLwDdiYp7ysXYFCTl73zyg1Dspeyvfysc0A5b0bxuxAspxe/+i/y20VaFFZJrzZpCqTcw==
X-Received: by 2002:a05:600c:8b2a:b0:440:61eb:2ce5 with SMTP id 5b1f17b1804b1-4533cb488b5mr142546035e9.17.1750188273665;
        Tue, 17 Jun 2025 12:24:33 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e151c3csm189391655e9.30.2025.06.17.12.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:24:33 -0700 (PDT)
Date: Tue, 17 Jun 2025 22:24:29 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	madalin.bucur@nxp.com, ioana.ciornei@nxp.com,
	marcin.s.wojtas@gmail.com, bh74.an@samsung.com
Subject: Re: [PATCH net-next 2/5] eth: mvpp2: migrate to new RXFH callbacks
Message-ID: <aFHA7Zsg8ZtOZtKi@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, madalin.bucur@nxp.com,
	ioana.ciornei@nxp.com, marcin.s.wojtas@gmail.com,
	bh74.an@samsung.com
References: <20250617014848.436741-1-kuba@kernel.org>
 <20250617014848.436741-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617014848.436741-3-kuba@kernel.org>

On Mon, Jun 16, 2025 at 06:48:45PM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../net/ethernet/marvell/mvpp2/mvpp2_cls.h    |  6 ++--
>  .../net/ethernet/marvell/mvpp2/mvpp2_cls.c    |  6 ++--
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 31 +++++++++++++++----
>  3 files changed, 33 insertions(+), 10 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

