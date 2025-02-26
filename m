Return-Path: <netdev+bounces-169962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A96A46A32
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19391887210
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D8C233724;
	Wed, 26 Feb 2025 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/bileAy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DAD21D5AE
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596030; cv=none; b=Bxg7QL9S+BbzAsAOpxNIt5WZXsY0LITcsmeAdMb2URyC/9nH4FAuiVjzkmEsmtTT21CHMHJb9E3+6ghLiuebDlQn9f4TGK/3bEg0cwEdipH3RgFCgDeXkmD8n5hMJmX25u3OtkDAtU7LZbqRoQkUYCD5QK+0ln0jKAA4ImhWzdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596030; c=relaxed/simple;
	bh=TsS84v9JdWmfPVDdVYGY/9M7Q6kFMPR93OYLjrN4ZrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhA4lZ1GVbRBvxRzeyNR685bSt/nSFQFEKvrh0Uv5GszWR8aPrVJXamSyfa+Dqp33GR+AFRwn8FRFOM3v/n0krZDULLA5n+kYcCcDJkB4Aglohpi9vp+Lu2VeroaGOTXeWXVJPxmfnnsPW6ND8xYT2WP4DzbZsPi+FndGoOJiho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/bileAy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2211acda7f6so1679305ad.3
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 10:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740596028; x=1741200828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApVb9aX9RMqgiQYUhLLiCvBNmIkleTTnf+cTqiJtybA=;
        b=B/bileAyWDLjAT6RQTp35Bex7WfvlAeoVEMmb2yeb0bekqvqphqQ4VnP0FoQgFBYev
         4WEd+CrorYKsL5c72lyLh6iZpKmhyP0/Qdl9DW60LdxyPyT3+x6RiBoSazIUcSioyE2l
         hlAcQCDeRGTJTFFjP/TPrsxWcNiTJ0+vCuFbgmTLgkYrkNqjNGJbaCL7+RAJ87Sq2jbk
         zWevCzfAg1KS2tGpwFT4uzknROlihyOETp0t3M/k1i4GwWfKI1D56Kxi3QeMZUSSebz+
         bHnCz2BHOOpxo+pCEfxElXvYOq+BC7fkmtLKpA7LF394Wog0SCFll5bQaA4It07NNJxw
         y3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740596028; x=1741200828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApVb9aX9RMqgiQYUhLLiCvBNmIkleTTnf+cTqiJtybA=;
        b=XprCVE76KNKGePQFrQQkQdMjFpRcXfPfDXlvaqLIqp2R13qDuqeDjzXbwOq5gYOMQU
         Yd3cigEMzbAxbzQ8SgkVq9IA2I/vI1SdRhWa+zDmhaOEOafmtfdRO9v9L7G60TcRV20A
         GMFe4BMB+/hghnxRlc1R31N2BZn4Zo6evS2LCWOvjtDwZsm3E3rakYfIKVYtxHy4AiDl
         XRt+a5QbbDwQXBbh68mituFQKa0QFX5TT6U3D+yZnTxH84D5gsY4mstimB+Oeyg1GB1x
         +XUkL7gUAyHWZq+5IO/3S5sUkNuCkLzG9o03K151fxmwcOK2OoKwwudr/QpQDs54XAdt
         kd+A==
X-Forwarded-Encrypted: i=1; AJvYcCVH3n3AjyxdrNMg8WWlLbcVxSuyxXCoLKgGo57orYKrmePMDTT4LhD5KAwguTSZLSfzDKfIA88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUcZqWaYMWpJiE1iFlnkESvosMEhRLth3jgGiSXlO9Pqh67t+D
	9W5/zDCDTH0jSji5dvvK9qKSur9OPMnjhv47Z4DHafnSKCr99pY5kYx7BbUm
X-Gm-Gg: ASbGncs6zAfJdIwxWyRPFppv4Z0tHPTIoF7Fq5PTAgiokwgwRfyXsz/A17OPkymE8aU
	lgLqbCJRR66Vwa2ww8c3yqb9W5EgpWvoFh+EZ9lSgcGiOhZ+6KSytqDAoxzQPnE0CrNeg5faUGr
	wcCNkSUkdT4TP12+7x59Yt0d1UlAdD2V5bRC81JLDgKlTLsRSwkHKWkSukDt0eb8aKbJJUgB5Ny
	UaGT2quIPgowoJn1MkTp8QTI+hTWpCzygKcPRCeoXSYVHQAbWabAvB2+6ofOUZiFIih0OLMKyDH
	d1M+MPxqfgmIkeyXwFMQ+WzKQNKpzev4jhMcsV0/azDO7MnIEYak
X-Google-Smtp-Source: AGHT+IGN4L9yno/FUJDitdSHAryXQ3XRrRXjq5uV3DQ7crHcMRDe9NcQuj2qyEAX6vbANhox3fL3ew==
X-Received: by 2002:a05:6a20:748d:b0:1ee:67ec:227b with SMTP id adf61e73a8af0-1f10ae8e409mr8062778637.26.1740596027659;
        Wed, 26 Feb 2025 10:53:47 -0800 (PST)
Received: from jlennox2.jitsi.com ([129.146.236.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81edc4sm3960442b3a.133.2025.02.26.10.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:53:46 -0800 (PST)
From: Jonathan Lennox <jonathan.lennox42@gmail.com>
X-Google-Original-From: Jonathan Lennox <jonathan.lennox@8x8.com>
To: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: Jonathan Lennox <jonathan.lennox@8x8.com>
Subject: [PATCH iproute2 v3] tc: Fix rounding in tc_calc_xmittime and tc_calc_xmitsize.
Date: Wed, 26 Feb 2025 18:53:21 +0000
Message-Id: <20250226185321.3243593-1-jonathan.lennox@8x8.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5b9f16c1-450c-4a39-be2c-634b4f1864b5@kernel.org>
References: <5b9f16c1-450c-4a39-be2c-634b4f1864b5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.34.1"
Content-Transfer-Encoding: 8bit

This is a multi-part message in MIME format.
--------------2.34.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Currently, tc_calc_xmittime and tc_calc_xmitsize round from double to
int three times — once when they call tc_core_time2tick /
tc_core_tick2time (whose argument is int), once when those functions
return (their return value is int), and then finally when the tc_calc_*
functions return.  This leads to extremely granular and inaccurate
conversions.

As a result, for example, on my test system (where tick_in_usec=15.625,
clock_factor=1, and hz=1000000000) for a bitrate of 1Gbps, all tc htb
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


--------------2.34.1
Content-Type: text/x-patch; name="0001-tc-Fix-rounding-in-tc_calc_xmittime-and-tc_calc_xmit.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="0001-tc-Fix-rounding-in-tc_calc_xmittime-and-tc_calc_xmit.patch"

diff --git a/tc/tc_core.c b/tc/tc_core.c
index 37547e9b..32fd094f 100644
--- a/tc/tc_core.c
+++ b/tc/tc_core.c
@@ -23,12 +23,12 @@
 static double tick_in_usec = 1;
 static double clock_factor = 1;
 
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
-	return tc_core_time2tick(TIME_UNITS_PER_SEC*((double)size/(double)rate));
+	return ceil(tc_core_time2tick(TIME_UNITS_PER_SEC*((double)size/(double)rate)));
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

--------------2.34.1--



