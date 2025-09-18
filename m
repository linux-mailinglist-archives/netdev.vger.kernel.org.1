Return-Path: <netdev+bounces-224236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1020AB82BEB
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 05:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD351C22F12
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 03:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD5225416;
	Thu, 18 Sep 2025 03:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqQSzHav"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52891FECBA
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 03:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758165858; cv=none; b=PfXmM07NMHy8Xfl2dqINsr63ai9QzDfpLzcP8f4vM14oiooVSGnKC8HJ/tCHINCK7vL+nykDw+UR/uzhZgfPvME5IXT8IusYfwA72IX8RkzXpZSR0bCwfChc8Ui9hIe0avFCEBWa7ylhRxLdXhoiDwa6jVkl4Vr2UP2oUOJj/1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758165858; c=relaxed/simple;
	bh=DvWUuw32eTmD0TBOxqoUtKRjTwAHv8x8+456fT8H83A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JUuZJiPrBsxYO0P5OSpDI2GnhHbU9p7Lyd5AiRWfPLpJyL3PmsNImIoIJ2JsJ0lYqqgmzeUnkDPZpbXuTb0u048xMwgr7v4BwVCSZlQxCnFCr5yP3N5yr+356DFUWDB+2zKdat2tGYxwX2/3cunPBR41hyCL6RzWnPC5rLaR8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqQSzHav; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3fe48646d40so7903285ab.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 20:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758165856; x=1758770656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DvWUuw32eTmD0TBOxqoUtKRjTwAHv8x8+456fT8H83A=;
        b=UqQSzHavKO8bNoOS5GJuJjjmFKpG2Vt9+mSlxKqbXd8ndtw2oEq+XUeATQOSQQoErP
         Usn9+iBzREgMsPLeDmwnwfIMB42uIT56LWuTSMswHR6VvR0uvEoIAOG77ITEDql2TWz6
         F7eW7PqUCBCXwPz/pJOD24JJBi1mubUj0lRCCpKlyycufgyXSLpJyR4JvF850JXFUHWG
         k2YR4e4qqSnSQqZGBrwKs1R4ZReD5v5dULh1b+uR7aSTKZqYj4pMjkewxFmZ4uytKGZP
         6YxxsPLIsL/ynYGJM+ZKiXEEKsn6tCOP1GQ5zl2lZjVDoMuX5tq6MSbdC0evEgPmc+Z3
         3XXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758165856; x=1758770656;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvWUuw32eTmD0TBOxqoUtKRjTwAHv8x8+456fT8H83A=;
        b=dH3WOfUHap6jCqcDHY4YXeeWrbof6aPDJNdq4QDLWqssjdRzI2palFY4s8N4q1VMM4
         WgMZupaPgvCcxZ88y0bN/Nhq+AyIjWFpYgL1DnixGNqqH7VfTuEWmLJ5wPlXsJHCkEBo
         dHuDI2g2/pkg23knNHnGGVNqAeEmlpxD9sxAKTMtA+ftctPRwspeEtdHkrtxUzx2U5GD
         ibZKrNg1z2PU20B2v52lV0C6cDUqOYN5HrpEwMkyriM3Q8m32uG2BCxFvfIDiwDfc1sl
         pKjHT6VtW1x4CHzEsh9vUjfjKIi/kmu20Ope74O2OmJrHYjNqhJ+6lx5Hb4M3WPvALtt
         w4NQ==
X-Gm-Message-State: AOJu0YwfV9waFQeylNWHWfN4CDuFccuF85cfPwabcnDz1NFU7GlvcA/n
	DokEdcu/pszbrv7OE7rDhh9WeHRrHO2UYEyGn7YN6GD38gD7OB0ixFYYzhK7q+lZQjqvD483ZfP
	NdHrBJGS3+WxyLlMkv+/R3n9go+7llGvFQ5si
X-Gm-Gg: ASbGnctlkDwOCFDy0s9EZSTgjjrC5Zu4SfK9eWCzBarN45qXCV709flMw6w90UJJ/0X
	wvdyXDFS+mq7776NLvYyZrG9OgXEaKCQYZFm3PI+Fu5YLejF80Cc+PQcinggQ9MD9Acf4f3Xzsd
	GaxQBB1TJ/Yb9G5CsL1H39nQ2RgPc+NOLlXOjMLy2xeFxnm2aRl2Z2PmsOLa1pdz5YCeW/H8ePT
	XwBwpulkMLjC2Aqlt2UEuPTEVZsdgUbg10EJ86UNaMjEl6V1IF6Rwg/6VE=
X-Google-Smtp-Source: AGHT+IHfDggKv5QOJ/N9XWK5VNhvBo2x601ZNaTZuASjaVHdh6hja61z3hw04catZiFTV9IVWU2JHH32rSqA68zyY2A=
X-Received: by 2002:a05:6e02:3787:b0:423:fd65:fefa with SMTP id
 e9e14a558f8ab-424444e68c1mr26363375ab.6.1758165855748; Wed, 17 Sep 2025
 20:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: CHANDRA SEKHAR REDDY <ccsr007@gmail.com>
Date: Thu, 18 Sep 2025 08:54:49 +0530
X-Gm-Features: AS18NWAP7q_fkSyvuwb8OByZDBUBkGuLAC104wFC2wov2kFHWMzA9WOBzEoAGSk
Message-ID: <CAHD5p1U5vrrcT1QpqPDwEgQJANdX67N-j0Hy4sh2ED+6BPMstQ@mail.gmail.com>
Subject: [REGRESSION] v5.15: UDP packets not fragmented after receiving ICMP
 "Fragmentation Needed" (works in v5.10)
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "arun85.m@gmail.com" <arun85.m@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Team,

We are observing an intermittent regression in UDP fragmentation
handling between Linux kernel versions v5.10.35 and v5.15.71.

Problem description:
Our application sends UDP packets that exceed the path MTU. An
intermediate hop returns an ICMP Type 3, Code 4 (Fragmentation Needed)
message.

On v5.10.35, the kernel correctly updates the Path MTU cache, and
subsequent packets are fragmented as expected.

On v5.15.71, although the ICMP message is received by the kernel,
subsequent UDP packets are sometimes not fragmented and continue to be
dropped.

System details:

Egress interface MTU: 9192 bytes

Path MTU at intermediate hop: 1500 bytes

Kernel parameter: ip_no_pmtu_disc=0 (default)

Questions / request for feedback:

Is this a known regression in the 5.15 kernel series?

We have verified that the Path MTU cache is usually updated correctly.

Is there a way to detect or log cases where the cache is not updated?

If this issue has already been addressed, could you please point us to
the relevant fix commit so we can backport and test it?

We have reviewed several patches between v5.10.35 and v5.15.71 related
to PMTU and ICMP handling and examined the code flow,
 but have not been able to pinpoint the root cause.

Any guidance, insights, or pointers would be greatly appreciated.

Best regards,
Chandrasekharreddy C

