Return-Path: <netdev+bounces-169158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8A9A42BD6
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F5818873AD
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A57266184;
	Mon, 24 Feb 2025 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b="lMQY0cdS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D1B262D38
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422590; cv=none; b=TGxZ/FJNvjF9EZu2yaA/CEjdlVwL4vriDbxpLggO0xNbLi478iSTjt1R6S4wgizVl/ehryaIapVoOkOmY3xQMqJCVojK1paN+9olUD5oF0bgZjLn3/xT9FsncldJ5V+/ViUikhavhO7+fj8BB6XCrXEPk00Cszfd3l0VI4sB+VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422590; c=relaxed/simple;
	bh=9C7igh+fNqX5yqcRwkvJslw/1KToWxfKrzs75Qf2AdQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eUZCLpjk5tbSYCZJ7Fg1akAgHkkAUfkrLufsECajxrfgzFLcXrUyshXVEe+8/Ix+Rf6DqDXj77XX+OpKDMOsLr3Zw2UHZJxVizKGactw2vbekmaDO2+N3JtGdtxujIgqUrE3uioQixWPo7I3ElbOvCBpwGPb4MZDLvg20nyi5mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com; spf=pass smtp.mailfrom=8x8.com; dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b=lMQY0cdS; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8x8.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-472003f8c47so43749551cf.1
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 10:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8x8.com; s=googlemail; t=1740422587; x=1741027387; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIX2cYq6RA9Ewe7XHAqMPt9l+R/vxbk5Vh7fsVgslJ4=;
        b=lMQY0cdSiT2HEvXL0YdBg5jKqoZbh1Ara+bMAZ9lzsGSidSzDbRmi0O1yq7cFBKbSJ
         GjYpwO9uB/+HxZwcpuSlAn7ZFK6L1CtNDF1zC8CkU11xFTXHWBYt8ALEJCcQpeZep3X3
         gCN+bxX32l9g/Z+LYUDo+s2B5RpCm13bh+z7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422587; x=1741027387;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIX2cYq6RA9Ewe7XHAqMPt9l+R/vxbk5Vh7fsVgslJ4=;
        b=BuXzRPxXSH8ZZlTy21TuTyITwzmJhwcw1UuFtqlqB4kFYtmO4DaKnLnCT7W00Z4DL5
         c/nrxCFG75JTFii53MyeZcY0gENiU4RdTvLncVAnBwesj7rx4p+L0ffegOtmtw1N9G6l
         ZFCQ136avkz9lk18rrORXGHGrPuTsLEZ462vp3XOvQIE3EfCmcd6OCWb8Bdeu6PTBjr3
         PlRNzD7gdQKfaY3IdBiM37O1ZvfuAJoMNATOhzCqltGKOKCsKonkY1jG4QciKxZemBsu
         Gmpi2/C3/HFkq+45OhTklyD+M/LphGeXsCPsUx8DrsdoWWPDohea3ymBQ4kczGjYhUFp
         9c0w==
X-Gm-Message-State: AOJu0YwSZeP/hottykB2yzrakHTMWBB3DGC7QJvU0W9dSPxxaBDQD0Hj
	ZbwbVUHy2he3haJdmP8bRXAU3HsHkzwWLsP2ruvcy0zvzBTEEaGmo25BMNH6SfBzFcbDAjUxTpw
	=
X-Gm-Gg: ASbGncsyAcfQcuQe0tYrovRXXmdTOSmOXHRV0/wzkevVMsdI0bt01QkY2ut62AhI4cr
	RvkcB2CTuFgxIDoFvVJDSa1t+DFyFjLzNhKj+bYOGCOV6Npix4VOx5zD/XcsVeFJURETl0bw36H
	7VxVsUPUCqeYay1s62l+n0oKTJYSdDxgFwgU8uRb3lgYUXqTq53z9m55WlMgq4KlKVr/IvObCDO
	tpGH/gG1RJdrRyk7wgrcMJXvTf9r4Y1wtj4DPo/O1zjGzG4887lrrRgZrUsW/P/X+Eti5zoAyl0
	aRI0GXlaGJH8kcYluxcVdReZwgP5ZETq6hasF1mvnzf8AuFEpAfE7KLM
X-Google-Smtp-Source: AGHT+IE7f3IBQXWUKpgpCxdfMYcLAujwZA44brEfNKww0MwrTQN098XElV8+zuWpu/uswiM8xGhRAA==
X-Received: by 2002:ac8:7e82:0:b0:472:789:4702 with SMTP id d75a77b69052e-4722299d2cbmr213207361cf.0.1740422587058;
        Mon, 24 Feb 2025 10:43:07 -0800 (PST)
Received: from smtpclient.apple ([2601:8c:4e80:49b0:a51d:1829:4848:c3d6])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f0bfe304sm96357761cf.55.2025.02.24.10.43.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2025 10:43:06 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: [PATCH iproute2 v3] tc: Fix rounding in tc_calc_xmittime and
 tc_calc_xmitsize.
From: Jonathan Lennox <jonathan.lennox@8x8.com>
In-Reply-To: <5b9f16c1-450c-4a39-be2c-634b4f1864b5@kernel.org>
Date: Mon, 24 Feb 2025 13:42:55 -0500
Cc: netdev@vger.kernel.org,
 Stephen Hemminger <stephen@networkplumber.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <952BE2E8-CE07-4D82-A47D-D181C229720A@8x8.com>
References: <5b9f16c1-450c-4a39-be2c-634b4f1864b5@kernel.org>
To: David Ahern <dsahern@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51.11.1)


Currently, tc_calc_xmittime and tc_calc_xmitsize round from double to
int three times =E2=80=94 once when they call tc_core_time2tick /
tc_core_tick2time (whose argument is int), once when those functions
return (their return value is int), and then finally when the tc_calc_*
functions return.  This leads to extremely granular and inaccurate
conversions.

As a result, for example, on my test system (where tick_in_usec=3D15.625,
clock_factor=3D1, and hz=3D1000000000) for a bitrate of 1Gbps, all tc =
htb
burst values between 0 and 999 bytes get encoded as 0 ticks; all values
between 1000 and 1999 bytes get encoded as 15 ticks (equivalent to 960
bytes); all values between 2000 and 2999 bytes as 31 ticks (1984 bytes);
etc.

The patch changes the code so these calculations are done internally in
floating-point, and only rounded to integer values when the value is
returned. It also changes tc_calc_xmittime to round its calculated value
up, rather than down, to ensure that the calculated time is actually
sufficient for the requested size.

Signed-off-by: Jonathan Lennox <jonathan.lennox@8x8.com>
---
tc/tc_core.c | 6 +++---
tc/tc_core.h | 2 +-
2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tc/tc_core.c b/tc/tc_core.c
index 37547e9b..32fd094f 100644
--- a/tc/tc_core.c
+++ b/tc/tc_core.c
@@ -23,12 +23,12 @@
static double tick_in_usec =3D 1;
static double clock_factor =3D 1;

-static unsigned int tc_core_time2tick(unsigned int time)
+static double tc_core_time2tick(double time)
{
	return time * tick_in_usec;
}

-unsigned int tc_core_tick2time(unsigned int tick)
+double tc_core_tick2time(double tick)
{
	return tick / tick_in_usec;
}
@@ -45,7 +45,7 @@ unsigned int tc_core_ktime2time(unsigned int ktime)

unsigned int tc_calc_xmittime(__u64 rate, unsigned int size)
{
-	return =
tc_core_time2tick(TIME_UNITS_PER_SEC*((double)size/(double)rate));
+	return =
ceil(tc_core_time2tick(TIME_UNITS_PER_SEC*((double)size/(double)rate)));
}

unsigned int tc_calc_xmitsize(__u64 rate, unsigned int ticks)
diff --git a/tc/tc_core.h b/tc/tc_core.h
index 7a986ac2..c0fb7481 100644
--- a/tc/tc_core.h
+++ b/tc/tc_core.h
@@ -12,7 +12,7 @@ enum link_layer {
};


-unsigned tc_core_tick2time(unsigned tick);
+double tc_core_tick2time(double tick);
unsigned tc_core_time2ktime(unsigned time);
unsigned tc_core_ktime2time(unsigned ktime);
unsigned tc_calc_xmittime(__u64 rate, unsigned size);

