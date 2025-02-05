Return-Path: <netdev+bounces-163262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8F9A29BBF
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 22:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BFF188396A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 21:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471F31FECAC;
	Wed,  5 Feb 2025 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b="kEo5u/f1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0818323CE
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790198; cv=none; b=Kl+7J9JMFcJEENr5wgiZeBtnWerJAukjP6PoM6OqNfdD4dur1aBqYiweWOseYMEVHYbqDm4qJfW9UUwS7g3mVc48190qEHaCucxxuUAmJv4oM1fPB5mVd4KIJhknVM3M1Ff6v4/TkIjW6sCQbmnFtf6e7GDwxDX6oEK7+JEesvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790198; c=relaxed/simple;
	bh=T7xkQl6lTQISQSFw7vcNtYg+CAfCG8/N2vDb+DGWV3U=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=KEnc9r0Tm6k2J/Iw6pGWd/SlZA1I1Bd8mVEbg1cd47K3oh3FAKPmyC91t8/5d7OtbbyCVd/gw+8QaVAf9G54i5YwoW7ajRWU0iyE+9gnw/XCmZJEw553xtK+ptEMUma6JFhEuWrS7a8F4fLKsv3/bablZPlLB8S/Eu31GKuPGCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com; spf=pass smtp.mailfrom=8x8.com; dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b=kEo5u/f1; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8x8.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso3644056d6.2
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 13:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8x8.com; s=googlemail; t=1738790193; x=1739394993; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Np90NtsXg5VIefQ8osY2qFZzBLJJL01GTjzIBpE41pY=;
        b=kEo5u/f1Y7PTRGHzP9k9j82pUQzkE8TuJNJQWn/K88tD6PVoxn8ZSOd3rBcOLHfj0U
         osv0qkQpjylY/9HD2d4WL4PO7B5NhR7v//27NrGDhwwnUmy6QzROzj4BLzfzcBV2GI+S
         AZyg0/S2L3YJxUC5nzqyfz23Ts8xDVZWLIcXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738790193; x=1739394993;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Np90NtsXg5VIefQ8osY2qFZzBLJJL01GTjzIBpE41pY=;
        b=BEkgpWtjKmR/EYsNsoKt5o3bCWd+tUlEv5cIFOzK+g0V5qVDXsBS7Ois1SlX1qZMfV
         AcE9UzYnNwR0xtokmxnN95lICqiym25AnsVuRD8gVqr8tbVZqKKAYZrCZoVxeHtN3Rmx
         3fdZOEsnS6X1VVLE+tcfN9IIKl6xqIoDks7Y4rSiOEVTxvYFLGoYypz5bPaavLc7PY1S
         bjHQFndOcxAumjZ8pyImoaiZpycWZ2Uhp2dJiv4DVBE8ZaZFXK4DtanLFmzneVirdnBK
         TC5v2XtgVvsS7guu5ukdfaIxU4MpkWTEWMmHRYGe9bdJBvgwUyZB1JObCLIUuQTJ/GTE
         VrWg==
X-Gm-Message-State: AOJu0YwSj7i8a/eG9B7Pg5TkMJ7rtC1qlRC2xhRwrzjYWna8M98kFUy/
	46CnBA2Tatq6EhpDz/EHVoTYPno2kyhgqGuDNLVxz+/knfu30Yv3d6oBlhp5pvni1hGSvfwTkAA
	=
X-Gm-Gg: ASbGncusnyKEHZC6IIJXlzilYd0R6TmqytSLQL0HNzqB67IfWQqvzZwj1+RaG4Kpr5j
	q5LfISdPXDMWIZIC5QsLLliWW5djPifWn4UNXCFVduopSiZ6xM3wvezsJv9YlZrKuYfde8SonLh
	+UG0CV3Kf0A13fhDzlIB0gkrWGr0/hPVfruvbd4aPn8NkOqMa78N5sazttYKZ+DMgSA5agq856u
	Wy4Ily18FOfvrBGhob+boEzioqJk/wfhTOqyVtLBejn6AH8PJoAXnCr9jLmUWe2RUenlsm+cfxc
	/tTVYgP8PQ/z9kZgC5B+ocmJHUfaP005hcorMl/MgN4VvdFqbZODXAcH
X-Google-Smtp-Source: AGHT+IFwQ6GQl+seKN8li18Pv0cXorXItprM1KYyJsFBnNeYKq64+kwB3/CeJTWJ33dt8ZygYP0icQ==
X-Received: by 2002:a05:6214:76a:b0:6d9:3016:d10d with SMTP id 6a1803df08f44-6e42fc7df6fmr56179806d6.42.1738790193224;
        Wed, 05 Feb 2025 13:16:33 -0800 (PST)
Received: from smtpclient.apple (hotpot.cs.columbia.edu. [128.59.13.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254835618sm77946046d6.61.2025.02.05.13.16.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2025 13:16:32 -0800 (PST)
From: Jonathan Lennox <jonathan.lennox@8x8.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: [PATCH iproute2] tc: Fix rounding in tc_calc_xmittime and
 tc_calc_xmitsize.
Message-Id: <85371219-A098-4873-B3B9-0E881E812F2A@8x8.com>
Date: Wed, 5 Feb 2025 16:16:21 -0500
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3776.700.51.11.1)

The logic in tc that converts between sizes and times for a given rate =
(the
functions tc_calc_xmittime and tc_calc_xmitsize) suffers from double =
rounding,
with intermediate values getting cast to unsigned int.

As a result, for example, on my test system (where tick_in_usec=3D15.625,
clock_factor=3D1, and hz=3D1000000000) for a bitrate of 1Gbps, all tc =
htb burst
values between 0 and 999 get encoded as 0; all values between 1000 and =
1999
get encoded as 15 (equivalent to 960 bytes); all values between 2000 and =
2999
as 31 (1984 bytes); etc.

The attached patch changes this so these calculations are done entirely =
in
floating-point, and only rounded to integer values when the value is =
returned.
It also changes tc_calc_xmittime to round its calculated value up, =
rather than
down, to ensure that the calculated time is actually sufficient for the =
requested
size.

This is a userspace-only fix to tc; no kernel changes are necessary.

(Please let me know if anything is wrong with this patch, this is my =
first
time submitting to any Linux kernel mailing lists.)

---
tc/tc_core.c | 11 ++++++++---
1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tc/tc_core.c b/tc/tc_core.c
index 37547e9b..ba8d5bf0 100644
--- a/tc/tc_core.c
+++ b/tc/tc_core.c
@@ -23,11 +23,16 @@
static double tick_in_usec =3D 1;
static double clock_factor =3D 1;

-static unsigned int tc_core_time2tick(unsigned int time)
+static double tc_core_time2tick_d(double time)
{
	return time * tick_in_usec;
}

+static double tc_core_tick2time_d(double tick)
+{
+	return tick / tick_in_usec;
+}
+
unsigned int tc_core_tick2time(unsigned int tick)
{
	return tick / tick_in_usec;
@@ -45,12 +50,12 @@ unsigned int tc_core_ktime2time(unsigned int ktime)

unsigned int tc_calc_xmittime(__u64 rate, unsigned int size)
{
-	return =
tc_core_time2tick(TIME_UNITS_PER_SEC*((double)size/(double)rate));
+	return =
ceil(tc_core_time2tick_d(TIME_UNITS_PER_SEC*((double)size/(double)rate)));=

}

unsigned int tc_calc_xmitsize(__u64 rate, unsigned int ticks)
{
-	return =
((double)rate*tc_core_tick2time(ticks))/TIME_UNITS_PER_SEC;
+	return =
((double)rate*tc_core_tick2time_d(ticks))/TIME_UNITS_PER_SEC;
}

/*

