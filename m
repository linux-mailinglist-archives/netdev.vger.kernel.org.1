Return-Path: <netdev+bounces-244582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8812CBA7F1
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 11:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC31C30D25DF
	for <lists+netdev@lfdr.de>; Sat, 13 Dec 2025 10:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1592F12CE;
	Sat, 13 Dec 2025 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTl4HWdZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FE92F0C78
	for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765620102; cv=none; b=LLA0S5kvpmX3isiiokcK5GK4qpLKBQ2WJmX2KDjUKeb/Q+9wT4dqqbKwOflOn8UnU7rO6QS0U8gCZG3GqaKrzM+BwJu2aa+tuwYL5/+m9M05XAekviQ1RCpdsHteHybiO6jx5vblASdLx5+Dk2Kjlw9G1dKSSkFQFhl5uNJFw2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765620102; c=relaxed/simple;
	bh=ISTnauUgqtX3anx20hEwzWdxOhqzLzx2s9oiIgXjk6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sr32/wO+GYYzGamS9mAmyLiBcyBNIa7qZmccxZ7887pcwlTIfn6e30Iii23U15EUfixuWgo2Gb2uLPf5cYtYG+tJet6HhTt26miSGYiEzjQQ4hrv5raGahS/PALa3pXHSYFXYRlec5NG/qfpnvsUyK+fIxqlSBqXXEbla5rDoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTl4HWdZ; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so72169f8f.3
        for <netdev@vger.kernel.org>; Sat, 13 Dec 2025 02:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765620098; x=1766224898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuXEsI4o+Wa379m0TvRCtoXu9MdxgJfMN/rAoI/CIR0=;
        b=UTl4HWdZmSuPRYFLzXSNfDETXE//lIsGQsMLl6f4tcVdDorn1D3wK9X3YCvf//mtNF
         88Q4DzO8oMMkdqi0NMBSZb2ADpm3vaL+BEXJeMzb4wN3AAVEEtUhjYkmrX6/elVnwKE0
         LOzVkneOoMZn8W90D0Us1fTY/PqF1TwFycOYmrKsooCDls0q4dp85c17XEibIiSZf6RN
         Kxp8wRP2DqziBcRhbpjUOEgjXUlqZYjRIR014GAN2k5sI4c3dDxMci9WCjoaYZ+Baulu
         sdt2S6JxmKh9SFESGIEzt1ZkBpb87QyQofk/ZMFgS2avV2M+eLZepY0fyBMe9FRt4PWy
         t9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765620098; x=1766224898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iuXEsI4o+Wa379m0TvRCtoXu9MdxgJfMN/rAoI/CIR0=;
        b=MfM32bCtlMatUm53UuUL0yBxALYFHmvsSq276PeyGnRdg5RHuvQcAdp20RdXmf6Luy
         /KbMmif60oSiv2W2EhEwPagB/L9/SH5aX9ahGGp6SCf5fExAGrudlqju88HmXe9ZTies
         tVDvexhTDi8mNIYTNaRU+oQ82BP44NcAzA0Akw8pv8DSgRaceOrFq50xux7zlp/vKZ1z
         VpsEDuPYP9f35JFm1aDEirEwJaFqpIxCCPIi4aMy8vYTE0MzEiy6YLCJfvo0WsOKwZfD
         aLThWMgAGw1SkZrHRTESBbN69kxyXdAiKn/kC+cwNMo5kS6xMIVOusZCAWrWHNV9USnu
         Npiw==
X-Forwarded-Encrypted: i=1; AJvYcCU4FZ8L101eZscTE5BgkKcaFEyl0xE9FgIXE8+p7r13+0Qlfwi6KS5/CO3OX5dna8yWR/YSPDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMUTYazhCcu3qNzFexPp39dgjyXHAQuDOY7kgbkqO7KEMyUvzy
	rqbC71ahFdFJY2X0YDBi+JrGnv/IrrNiWsZlEYkPY4mHFMASX9XUNFc+
X-Gm-Gg: AY/fxX5dYewLDr+XMeZfTGIifa8K4YHjhlLs5FydyAlht6SEYUP/5rMvxaAmW5tzW3j
	esVbi5HxKK+s4UNCheeK8LOFMafQvT7IlxY4FsmADWlhjzFe1SRM0ssY+HRS6HJe68EU2H+X33l
	/SVp/UMKMELKrRwQQoouypiSE0YerHsNMZitGaoQol1Mr/ceWAXLsWAcMpUT8xgbBvKQw8Id56D
	c2FJ2hxkN4NYgypStS39CFqc+f1ZY6xEy5vfl9FcDRSCcjJvfLPn2Hvm05yGupnY/qXoMCY4jO8
	pqeyalgaa2RTAaDOFekVno7zJ81x0cwTlcCCDuuD1TsUZxoI98+f4mCvNtRsbuVNl3C4Lb9pGOp
	J9LyMVpp66XQ054BtMyP1wI4tRbIqBSl4QlVMOGJGcUSXtmHpyaIRof8qwetx9pTdApgKvSD/ji
	0eNVa5I3LdEicSDONSYszXojq3p8pRJg+Q+Eo30nj2VTVJwnXfSb/e
X-Google-Smtp-Source: AGHT+IE5jCmsnzEvOJCvLTCmPIB9nQFTexaypDGXRYykLDOoO4cf1BafRcQOIhwXKJ8zZAF1vBRyjA==
X-Received: by 2002:a5d:464d:0:b0:42f:b707:56e6 with SMTP id ffacd0b85a97d-42fb7075cabmr3502696f8f.34.1765620097989;
        Sat, 13 Dec 2025 02:01:37 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b9b750sm16558826f8f.42.2025.12.13.02.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 02:01:37 -0800 (PST)
Date: Sat, 13 Dec 2025 10:01:36 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Geert Uytterhoeven
 <geert+renesas@glider.be>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v2 02/16] thunderbolt: Don't pass a bitfield to
 FIELD_GET
Message-ID: <20251213100136.3d83a236@pumpkin>
In-Reply-To: <aTzPT2kAt96ypGU-@yury>
References: <20251212193721.740055-1-david.laight.linux@gmail.com>
	<20251212193721.740055-3-david.laight.linux@gmail.com>
	<aTzPT2kAt96ypGU-@yury>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Dec 2025 21:28:31 -0500
Yury Norov <yury.norov@gmail.com> wrote:

> On Fri, Dec 12, 2025 at 07:37:07PM +0000, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > None of sizeof(), typeof() or __auto_type can be used with bitfields
> > which makes it difficult to assign a #define parameter to a local
> > without promoting char and short to int.
> > 
> > Change:
> > 	u32 thunderbolt_version:8;
> > to the equivalent:
> > 	u8 thunderbolt_version;
> > (and the other three bytes of 'DWORD 4' to match).
> > 
> > This is necessary so that FIELD_GET can use sizeof() to verify 'reg'.
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> > 
> > Changes for v2:
> > - Change structure definition instead of call to FIELD_GET().
> > 
> > FIELD_GET currently uses _Generic() which behaves differently for
> > gcc and clang (I suspect both are wrong!).
> > gcc treats 'u32 foo:8' as 'u8', but will take the 'default' for other
> > widths (which will generate an error in FIED_GET().
> > clang treats 'u32 foo:n' as 'u32'.  
> 
> FIELD_GET() works just well with bitfields, and whatever you do breaks
> it. I pointed that in v1, but instead of fixing it, you do really well
> hiding the problem.

It doesn't, pass 'u32 foo:6' when using gcc.

	David

> 
> I see no reasons to hack a random victim because of your rework. So
> NAK for this. 
> 
> In v3, please add an explicit test to make sure that bitfields are not
> broken with new implementation.
> 
> Thanks,
> Yury


