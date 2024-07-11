Return-Path: <netdev+bounces-110903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7001192EDB3
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 19:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BDF31C20F9A
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 17:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE0916D320;
	Thu, 11 Jul 2024 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lxFOa4My"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B871616B72E
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720718769; cv=none; b=YouIdXAisy8XzBldAN/5pL0FHUBe1XOGoMGIW/0vDoxy8R4jrTOGCWahiMyFpz6o2DJmwjlO3yU+k6wdwdZxOC/SsQTIUTG8Mpn+fGI7sFdi8lzWZl9WIohl6j7164iXnjy0G1p5XiCn45frh0yfMR1g61y0woA2EXhUr1/7tSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720718769; c=relaxed/simple;
	bh=NL6FAHl0DdHAVvybNSXbXE/HErIHx+TpbEjK05Y/Btk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkTaETx13cPHhmjCNYTR1bDanRJfTudoclybO1a+lQTF5++HizMy5OaALCLWEShVheO7bFFnyr91PTUJTCvepDv3U/LzqXU/oSQL15OCzC1cNfSBqWSL0to1KMZ1xExUS+pxMpGhVi3kTDQlKDa9LFfnVfxGtsXe9YVE2IRxfVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lxFOa4My; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58c92e77ac7so544a12.1
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 10:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720718764; x=1721323564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZelHgDiE2Mwr/j3jqzT5W85kBsMTyXuTyyOHRfUHwRg=;
        b=lxFOa4MyfBCwNH8IoMoTBnSBAZ9XKSEly3ai3xUd4CFahzejOxSsOxjxyAh3pXAp59
         L4cvejsGTDBg+MHmlD+19jDIpQK5ITY90qJRP3L1Bk4DO5bgnicqSLyWU3BRg+5wVbw2
         d/kjuVvvSVN1BHSK8x88SnM8yl1LzIJwjytQyECnUayLfWs3UHRhe8tZLqGOE1LGubqc
         EOA9wl0LIfVuhHRGoDyQnOP+yOYkVdZPI0q44ECaNxnM0WiQHHaAxtd2EFPnrho1MV/v
         ORIvnv89zAYU9F94Q5QhgyD5Nxd89tAFFEYAsE4TTCX/ydtWh5DscSYywaV3KQW3m1T5
         GXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720718764; x=1721323564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZelHgDiE2Mwr/j3jqzT5W85kBsMTyXuTyyOHRfUHwRg=;
        b=ouWB6+zx/1IUFNY3jEmcsudEd9XFofg2cN4Or/aPa9L/Lhm9MwOTryGvBA1soQ7WQN
         +RAHyIaNke4QF5JQiIvpYb4l+dQadRMCYLuOaw/DUWIICH4D25C3qwJ8hv32TLvGturF
         kaQKzPET7hBSGpS2Q9Jegm2uqBc9k5LKn2e1iXq1R8xpg4Xnh4xS/i8aMTRAwPjLnMzv
         fBat3GivFPDo8bYTc2CVcaZS6CfjlT7ugYKMTejRHxpR/+/bIPmrrDV3NfuC1I9DlCin
         CbEtmCEdx3nFwyc18kX56eVXEj4UwADrlUHA5MnKOhPvr5ky+KqZceu/AoDW0XYRVPnC
         TM4A==
X-Forwarded-Encrypted: i=1; AJvYcCVQpJkl3WGvek62OXzPhVwBkEyB8QdCwN4vT5QL8GmLhcxP0z4cJDlye70Y+VJsPbtem74YOQoopvvggqXIopD1CHAo6/R9
X-Gm-Message-State: AOJu0Yx9Y/xmr+9owpfzt9UfpNlO73QOPnonr3r9EadrQgXoOV1kN5QJ
	DM1jhY4yaRE9Ip1mPL4z7b5mwzZ4mVbknXP2Iw4WeySvDL9xsPqI1uWwglrCNQ6ZvFlh4rv56Ao
	tdn/1sodd61qlazmFMyBHUZMABD/WXLbgpPMa
X-Google-Smtp-Source: AGHT+IEBnyU7h2Anut+GsUbLlq5dHu8ZItBcrWFPd6u39n6lND3Yd1yoce3fwwJNpQw6TmzdsvWTrq10CAeXhFwwRzI=
X-Received: by 2002:a50:c345:0:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5984df473e7mr230973a12.3.1720718763661; Thu, 11 Jul 2024
 10:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711071017.64104-1-348067333@qq.com>
In-Reply-To: <20240711071017.64104-1-348067333@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jul 2024 10:25:49 -0700
Message-ID: <CANn89iJS434T_knwiX2mHYsyD5xQzJceeJkRg5F-kaLy8OqD9w@mail.gmail.com>
Subject: Re: [PATCH net-next] inet: reduce the execution time of getsockname()
To: heze0908 <heze0908@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, kernelxing@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 12:10=E2=80=AFAM heze0908 <heze0908@gmail.com> wrot=
e:
>
> From: Ze He <zanehe@tencent.com>
>
> Recently, we received feedback regarding an increase
> in the time consumption of getsockname() in production.
> Therefore, we conducted tests based on the
> "getsockname" test item in libmicro. The test results
> indicate that compared to the kernel 5.4, the latest
> kernel indeed has an increased time consumption
> in getsockname().
> The test results are as follows:
>
> case_name       kernel 5.4      latest kernel     diff
> ----------      -----------     -------------   --------
> getsockname       0.12278         0.18246       +48.61%
>
> It was discovered that the introduction of lock_sock() in
> commit 9dfc685e0262 ("inet: remove races in inet{6}_getname()")
> to solve the data race problem between __inet_hash_connect()
> and inet_getname() has led to the increased time consumption.
> This patch attempts to propose a lockless solution to replace
> the spinlock solution.
>
> We have to solve the race issue without heavy spin lock:
> one reader is reading some members in struct inet_sock
> while the other writer is trying to modify them. Those
> members are "inet_sport" "inet_saddr" "inet_dport"
> "inet_rcv_saddr". Therefore, in the path of getname, we
> use READ_ONCE to read these data, and correspondingly,
> in the path of tcp connect, we use WRITE_ONCE to write
> these data.
>
> Using this patch, we conducted the getsockname test again,
> and the results are as follows:
>
> case_name       latest kernel   latest kernel(patched)
> ----------      -----------     ---------------------
> getsockname       0.18246             0.14423
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Signed-off-by: Ze He <zanehe@tencent.com>

There is no way you can implement a correct getsockname() without
extra synchronization.

When multiple fields are read, READ_ONCE() will not ensure
consistency, especially for IPv6 addresses
which are too big to fit in a single word.

