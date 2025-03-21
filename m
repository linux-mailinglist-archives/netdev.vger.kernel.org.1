Return-Path: <netdev+bounces-176746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E92CDA6BE1E
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 16:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E5A77A1119
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA62618DF6D;
	Fri, 21 Mar 2025 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=avride-ai.20230601.gappssmtp.com header.i=@avride-ai.20230601.gappssmtp.com header.b="myleGmuv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5764A8F
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570267; cv=none; b=txvjoV5oE3t2Ax0sLxcjkGRDinji1OuCGWHUvyCZ2NdNQH+yFERJXY1SUVdCS0CzatqJ2kWhd+wQaaVKJ9cxLAh3OssbyURMUM40QcJf9OSM60DyRloLnqBmpkoPlospd0Iofo4VeNEW+I0NqAUjvneH/9QJFpOMYSonW9XiXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570267; c=relaxed/simple;
	bh=6+bQ9CwVbhlWVgx4LSJrTNYpNBkzWeozgzLCHdjBxWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3QhNLeSc9pJjRETzKpQeEx9h4MTtnDvjGBxbKlt72SozvPHCAzi7Wr3E8ckPbelTxWcuDUKRxwM8OjiF98sQrF6eKYQXF4ezS1I/pqn5wlKgOSlRdqAn6mh1LppkCR/jpcxmQH3B4vH+L1FmXCvAXp3j7G0hO/AN4LPWIYy8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avride.ai; spf=none smtp.mailfrom=avride.ai; dkim=pass (2048-bit key) header.d=avride-ai.20230601.gappssmtp.com header.i=@avride-ai.20230601.gappssmtp.com header.b=myleGmuv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avride.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=avride.ai
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so3622242a12.1
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 08:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=avride-ai.20230601.gappssmtp.com; s=20230601; t=1742570264; x=1743175064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6+bQ9CwVbhlWVgx4LSJrTNYpNBkzWeozgzLCHdjBxWM=;
        b=myleGmuvwx19fD+aHFZHBogMyI+sVSjyegtRv67AaychwK25kDGIXhI3Bg2q8lxa0Y
         MEwEGmeOs//KwyBX4vrkm9XzP5AVmilRo3NJSD3J5+7O7LtzTEaxV5+kVzReirB27MOz
         XkJaqAf3LlLmWjyhKJdVjRBXBT8kKYjMq1x0QvheUfO8BMitJv5OCul/CJMyTGo4TUmR
         aa12hJjqRwFzJfs6SFqGno84S4/npEkBS9p/8ri90LoV+aF2kepepVzYKrgsVNxjPTF6
         WhhVe4CR1x8IqhtCBTZtXN04LQBrxA0gqHiVP/q4m7Y8vrkh69NPpQUrjyrtx5GiCxCm
         hGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742570264; x=1743175064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+bQ9CwVbhlWVgx4LSJrTNYpNBkzWeozgzLCHdjBxWM=;
        b=u7d6/PxqxKVnesfq9Vh4KPqmVgLZM3MusTsgjKUZF0D+VQCgPdezUtUeA735AYL5Fi
         AbJa4lKbm8WBDUr5UBvKBRMLzWJbei5lZ2ClBI58kSkgHZsYR3KHVvt6HvTQyMsWH9QZ
         t5uEBWurdwMByMNp6jqc6UuHgoxLsZk66WJ++mKbO//XQcI2pGrgsY57v02Z6bC+ZbUJ
         B0JI1LN5NA/HuCiVa0hYGqEaWisI11e0vpyc8Og7205n17EmNpeog5+dLlJC5gJUc5sb
         ADHN2UhfZVXBD3W/EhJa5IkVUgz/AbLunx5uuBYRwQEwMKw0BJxQYS3nCeK7Qa0eJemh
         JGjA==
X-Gm-Message-State: AOJu0YwqFP7B2cmOFNQjZKyKoYrpqPicWAtFjwzjYl055eACEr7dLTJH
	T6x3vNSEIKTB+BebHv/1W0jea2iiT+2Njp73Vn3dpUn7oXeGLUTT7aDPditzEj06aq1VMh+kRjG
	xqlBIn61OaMlPr3VK++arcelvKn/J87jyusV6Gw==
X-Gm-Gg: ASbGncsA+0+LOIhkipgc03D/Ukf033B/hz+Ubn1EX4bFcRw84w5Pgo4lt/12zBKl1+e
	uW0Bh6uOPDs87t30d4RH2OWNfX43woBE9ZR5r5ayS2y3F3ewqxbA8Ubm99pu0py0XSH0HJKStVJ
	qWKy70yIN7ppm25V/PGoNyTnwg6P1tawRKmtHbn78lzQaNij/sodvRy7TQ
X-Google-Smtp-Source: AGHT+IFiCXMmchJZic09GP3CXTdT4ktUpCCWCtdA19Sv0/Pfq1+6FVhqMHB1XYRPpPXFjZrWmuU93W2u5slFkxqiHzY=
X-Received: by 2002:a05:6402:354a:b0:5e7:b015:c636 with SMTP id
 4fb4d7f45d1cf-5ebcd406bb2mr3452656a12.6.1742570263869; Fri, 21 Mar 2025
 08:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai> <8f128d86-a39c-4699-800a-67084671e853@intel.com>
In-Reply-To: <8f128d86-a39c-4699-800a-67084671e853@intel.com>
From: Kamil Zaripov <zaripov-kamil@avride.ai>
Date: Fri, 21 Mar 2025 17:17:33 +0200
X-Gm-Features: AQ5f1Jq8Ne56mXh6cAI8VAGlKFID3gt7gYWzKc2HJVmP0bvEgKTanWSh0e8DRbY
Message-ID: <CAGtf3iaO+Q=He7xyCCfzfPQDH_dHYYG1rHbpaUe-oBo90JBtjA@mail.gmail.com>
Subject: Re: bnxt_en: Incorrect tx timestamp report
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> That depends. If it has only one underlying clock, but each PF has its
> own register space, it may functionally be independent clocks in
> practice. I don't know the bnxt_en driver or hardware well enough to
> know if that is the case.

> If it really is one clock with one set of registers to control it, then
> it should only expose one PHC. This may be tricky depending on the
> driver design. (See ice as an example where we've had a lot of
> challenges in this space because of the multiple PFs)

I can only guess, from looking at the __bnxt_hwrm_ptp_qcfg function,
that it depends on hardware and/or firmware (see
https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/broadcom/bnxt/bnxt.c#L9427-L9431).
I hope that broadcom folks can clarify this.

> This part of the driver is tricky. ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE
> reports only 16 bits of 64 bits timestamp, 48-63 range, which doesn't
> overlap with anything else. The assumption is that when the driver
> processes this event, the register which reports bits of range 0-47 has
> already overflowed and holds new value. Unfortunately, there is a time
> gap between register overflow and update of MSB of the cached timestamp.

Indeed, PHC counter reading is pretty complex in the case of the
bnxt_en driver. Final timestamp that is sent to the userspace is
combined from 3 parts which are stored in different places and updated
using different mechanics. Apparently in some corner cases the driver
fails to produce the correct result.

> There is no easy way to solve this problem, but we may add additional
> check on every read, probably... Not sure, though

Right now I've just added an extra check into
bnxt_ptp_rtc_timecounter_init function, it should work in some cases
but I do not believe that it is the right way to fix the original
issue.

