Return-Path: <netdev+bounces-243392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5FBC9EC38
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 11:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF483A891F
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 10:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E036B2F360A;
	Wed,  3 Dec 2025 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="tsDYJQ1K"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4CC2F2909
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758943; cv=none; b=pzq0Pxs/5PTESyh39XD7+FfYejNmRFZ6Hl0iRZ3RyM+9JVyNS6dX9xF/1C9EDJGIJ4p5+oU5tPjWyEB09HK8mxNV57+y5RpIR0Vys2udVtKgiMeJb3mufuIEkGTVDON1WKREEvqE0/YirpAtEBd7/VYFRY62hj2vFZ6CAb1UvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758943; c=relaxed/simple;
	bh=Z1D04chXBYJFwwNAJuYTORWw41cHBHStJVr7oBf+7vA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OrCuQwAzQH7NW+/3Wu+rCee1ZgCR4vHfpUDUdOKyWgaasCXaJcmbQxV8qn9S2vRL4VtPNPLwNMEMKNzkkukoF8TQPk2um4vuRpLqTQPfcBLXvFLKAQ5JcOlUmxLeMJaw80YohGpva6XLtzGLs5eGn9LLOx35A356QjQqLyFa4Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=tsDYJQ1K; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1764758931; bh=Z1D04chXBYJFwwNAJuYTORWw41cHBHStJVr7oBf+7vA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tsDYJQ1K0iglRE14nGbybI33DvZiEHJDpwLf7+4qzlWDw7YnnivsiBkY+wZTomsI7
	 NZTO3hjhp32nCXa5TLoR/Y6vhPtVC5jjNel3kUPPfAjmx++XOFv/RJlgS4lAJIHPML
	 hXHhChUFYTv8SmVB+eFps0lZUjzWr/AIR1WwqQ8JfBusqE2CbubqblW0X+uwswU/Vq
	 4Xh4TTIXlPdRswkjRgGVLEJzGqB3GwdESbuCoLprKigFlDIvncn4Pplxsi3QGsYwYo
	 ziA1GY7C515CMMOQy0WrDC9zx79Ts4GdranAKgjPIk8be3aVpsgZQlvibyEYio5KWv
	 XeA9DuF4QVw3A==
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonas
 =?utf-8?Q?K=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/5] Multi-queue aware sch_cake
In-Reply-To: <20251202111036.07964fdd@kernel.org>
References: <20251201-mq-cake-sub-qdisc-v4-0-50dd3211a1c6@redhat.com>
 <20251202111036.07964fdd@kernel.org>
Date: Wed, 03 Dec 2025 11:48:50 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87tsy796y5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 01 Dec 2025 11:00:18 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> This series adds a multi-queue aware variant of the sch_cake scheduler,
>> called 'cake_mq'. Using this makes it possible to scale the rate shaper
>> of sch_cake across multiple CPUs, while still enforcing a single global
>> rate on the interface.
>
> Let's push this out to v6.20 (or lucky v7.1).

Alright :(

I'll resubmit after the merge window with the header changes Will suggested.

-Toke

