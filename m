Return-Path: <netdev+bounces-167510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB6EA3A86E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 812EF7A22D8
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683841CAA93;
	Tue, 18 Feb 2025 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b="CAL8Yhyi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438EE1BEF7D
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739909460; cv=none; b=MCPClhp6DPovkAL8V/w+0bbTZ2SqtTTYX525rKTP0maucrqNMvf9HPacW6NTLNofDsvcjSz2k5aP6GHYcodDFw9mS9NchjuG86v9Xu3NZ7kt9Voh7R4AqcFhTdD+hzMP5eViREjcs1iyarH+crWdoH0qXKr2WNn9FUYTdrHMKr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739909460; c=relaxed/simple;
	bh=9SAAvBtQ8AgdQK9vMCxMwqNnvbJ3ladEGRrXv8Hxppw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VUgZJr8pisMtzXbpoL0Odcc6tQtKdeNbwNqMYTN+s7R2glSwCR4JIrrdWT90J9cHEupZbG9L79Pk6XO7hdGCvDkjnZp1GbjJmNJTqyF1kIVQV98X5GEGcLN8ELndyMONgksZ7ufHWW2DQzQikzSqfmS+YR4GVI88pMjDoL1C1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com; spf=pass smtp.mailfrom=8x8.com; dkim=pass (1024-bit key) header.d=8x8.com header.i=@8x8.com header.b=CAL8Yhyi; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8x8.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8x8.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-471f7261f65so1873071cf.0
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 12:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8x8.com; s=googlemail; t=1739909456; x=1740514256; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+2iJw/+jsYUZck/5+ojP6C6CYCnc0XRK08SPFL0iKE=;
        b=CAL8YhyiT5PgQCMc7lnWO7BaX1bn5mtiJi4yS3BRAhfhb8ljocfJLqxM0JwMi+X5R1
         a8uzmYyzHGFcP1JavmexxSpIQsWyXwxvZGmAtV9nBGN2b1Ec2OIaeqwtxwU4NXSGYCD+
         FuehdagZi57M/J+pdNOK60BJhGTrpGNCZRZWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739909456; x=1740514256;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+2iJw/+jsYUZck/5+ojP6C6CYCnc0XRK08SPFL0iKE=;
        b=aVgXEKd8znJoFrYDXXmdCHhRjoRFTQoPSgJTh0L7n6gKI9Ajs4IRL9AoIkX9fTNS1+
         xI+60zNca4PRxxkZCdQyHHqslK+wBD88ResT31FaYENBm2Tm9gH8KTiF8/M65fOVuz5m
         KsXzqFbnnk6Y/JAFVuE+5iEKWsTa+zY0+AA0kZi9RWWVq4MRf5F+lHqnrYo7HVwr2qBu
         8jwv+8ag9bRgdNmruPL/Yv1dkWFgTwHTVgxDsL4T+y97Ywx78ad+fwTDGxq/3ACjw/At
         H3h4JyBXkKC0M6lFL84jiEd7CUWT6eYGrAguVSsV+sjOoicTUisj/rQ0k+qmMrGdcalY
         vq6A==
X-Gm-Message-State: AOJu0Yy2alV8fViIYqjX9UvFpgJCuzLNocdhSSoEvGMw5pUbwo5ip8h7
	PjObD79PmpGvCjlsoHopkIWO2dUb1h/KRwh4c85PsD02CMbDA/x9LDAWJif52vckwIWHL8RSbMs
	=
X-Gm-Gg: ASbGncv69p/sR+E+D/jUzhKo7PGgZftnhB9bREtga5oiODQUhH0psRSykVoGPvx00v8
	WnRm8R4F7eH7jS0+VvRJ/OhV+thZX2ilOKc6dHuuJv8AaL4p73qGrzhQIDjFH/6ZEIngru0vkZG
	Fg1pZYy7NSSCQdXjVdERopWr+4Khsl5ZhPJuvNpoCvAbzn+rcbLSxfvz+egpuUomYbaCrhf2Rt8
	XydtF6gwll8Syi3sLh8Gi5V0YjNv8DO5VWof0gx8dvl6TXyqDeuBC3x9CnQAgvOaF8hWmmI7Oqh
	B+EqVgQYmnY14kM/Inbw9twOXxoduWN3kaRH/lE1wZp7n3oozcsyIgSa
X-Google-Smtp-Source: AGHT+IFyMotOnN+qKXovP+eZAo5JpRFwHh3sv+IdbbwSrvz3yPdI2CLBQb1fxNWid9QobjTcGYwJog==
X-Received: by 2002:a05:622a:1f95:b0:471:825d:aa52 with SMTP id d75a77b69052e-47208112090mr18122001cf.20.1739909456347;
        Tue, 18 Feb 2025 12:10:56 -0800 (PST)
Received: from smtpclient.apple (hotpot.cs.columbia.edu. [128.59.13.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f506f819sm21484761cf.62.2025.02.18.12.10.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2025 12:10:55 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: [PATCH iproute2 v2] tc: Fix rounding in tc_calc_xmittime and
 tc_calc_xmitsize.
From: Jonathan Lennox <jonathan.lennox@8x8.com>
In-Reply-To: <20250216221444.6a94a0fe@hermes.local>
Date: Tue, 18 Feb 2025 15:10:44 -0500
Cc: Stephen Hemminger <stephen@networkplumber.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6A0B441-A9C9-40B5-8944-B596CB57CF0E@8x8.com>
References: <20250216221444.6a94a0fe@hermes.local>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3776.700.51.11.1)


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

