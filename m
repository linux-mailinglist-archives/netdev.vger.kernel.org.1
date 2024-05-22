Return-Path: <netdev+bounces-97639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCAF8CC7E1
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 22:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAEF8B2127A
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 20:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D2A76048;
	Wed, 22 May 2024 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="psBMiPnT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613FA3F
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411558; cv=none; b=ogk2K9bMX2GkxhpqTB8EjZ+MFWj/ZzXTKMWFwggA9kB4GJFClofT5kDQVOiTRdb4DRdnpRL0pgvgbU0GObitQX3LMg97cH78gIT+3qeEVSXDmBrFXju6NDGT7Pha7brThGvzbWYcrI5wq8qSfmUUTc4vZqXKlvdTHY61gHsXOEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411558; c=relaxed/simple;
	bh=GxXhd6ykP3KCLUpHCcTExZoSVww4AzQvBOy3Q68XSnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6rzuTiXvEoCjpkZ+NU+8sDD2TK9UFCSh7tmdyqAsS55ym7MAxFtOMW7HOczkyD/wJKxMRxfLUchf6QWSvDn66wB8LtvbSfkEOjzLtwh986F7j9uPh+2ZhRxLcZ2XZPG26PTWEoq+W7j2XA019fFowU5evNtCA88nGRwq+jzn6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=psBMiPnT; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-66afccbee0cso1498307a12.1
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1716411556; x=1717016356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUGOoagIdA8cg5AluPsCcQ63vrp70i0VkCo1w1zHDWQ=;
        b=psBMiPnTCVWUSJayxqvvsFqc9nWadgiITjxYZsfT9T0Bb8HKlmwm/ZEJjpLqvfYFon
         uxurgJv5m/NKiL/J054d1J4BfJA0r4wXDAYuqyZONXxfW27w92WSSJUxrRUWiUL+Vu9S
         bfU/M5vs5UAFLbElczWS40up4CFQEjqEPj/LDtmN/rP+E7oy9L4e4o7fs2btxWo2uwhK
         aNXsJlRcoCGu54NKNIZ3yzl0kiLrqU3Xd7vREBzfsuE4UaoHaxmB5BV1A0WHXJ8m9G/1
         7qLf1uu6JSxvixNJquOHUL1E9OPXBm9h76Eqx1fcKDhhBK6ycJ8dR6lisZmVHWkOCemP
         jHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716411556; x=1717016356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUGOoagIdA8cg5AluPsCcQ63vrp70i0VkCo1w1zHDWQ=;
        b=pke9tBYYUN3HqHPi3e58Y3cDTXfBWYp/ymUzzaNeD1cPAn65G1mPIrLHUY9anUqMjn
         n5sADSPDBUCaTrEEvv2kiKUR85z3vX/x0p5Se/6IKdZzBBanDz4AuY1/6tEgm8maYnbA
         E67OuIyLCxx/zpqgqc5zlD+DzW2eeipthphRviYT4FkP+EZnATyASOtUJCGVRXwaQeTC
         /vSq3wEhLo7e9YE4Gp6ZqrmqoUad+EgibhBYEiiE/Io1TC6DgfXeF1+tjpxtZ5kK1dy4
         9F7Xz/vvuEbdhu0LNgkeD7hc/EqTPdqSVfKcVtbkDG9lVkBUvPhYZlrusFzP2ODkohni
         164g==
X-Gm-Message-State: AOJu0YwVwzTKt+UKFSoTgUrIPclzaSPtldlTGgTbHgEdS1wIlZAzBSAw
	NmzgzI5mABVzIOcxS6E+f3ri5oRR99yRWv+IMDNP1KwmHPtjFygtxgPMXM+plZQ=
X-Google-Smtp-Source: AGHT+IEYz7clVdoKY8qFGzyWnin7FrvOtpEI72Dji6L+pcXaB803eaEtelfAc+pLhbrlHeDB4G6/XA==
X-Received: by 2002:a17:90a:1f8e:b0:2b8:c813:1696 with SMTP id 98e67ed59e1d1-2bd9f456b80mr3255221a91.10.1716411556161;
        Wed, 22 May 2024 13:59:16 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bde008a188sm67049a91.53.2024.05.22.13.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 13:59:16 -0700 (PDT)
Date: Wed, 22 May 2024 13:59:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gedalya Nie <gedalya@gedalya.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] iproute2: color: default to dark background
Message-ID: <20240522135914.4dd914dc@hermes.local>
In-Reply-To: <01a20e83-c05e-4006-b64c-3edd34508296@gedalya.net>
References: <01a20e83-c05e-4006-b64c-3edd34508296@gedalya.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 03:28:16 +0800
Gedalya Nie <gedalya@gedalya.net> wrote:

> Signed-off-by: Gedalya Nie <gedalya@gedalya.net>
> ---
> lib/color.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/color.c b/lib/color.c
> index cd0f9f75..6692f9c1 100644
> --- a/lib/color.c
> +++ b/lib/color.c
> @@ -72,7 +72,7 @@ static enum color attr_colors_dark[] = {
> C_CLEAR
> };
> -static int is_dark_bg;
> +static int is_dark_bg = 1;
> static int color_is_enabled;
> static void enable_color(void)
> @@ -127,11 +127,11 @@ static void set_color_palette(void)
> * COLORFGBG environment variable usually contains either two or three
> * values separated by semicolons; we want the last value in either case.
> * If this value is 0-6 or 8, background is dark.
> + * If it is 7, 9 or greater, background is light.
> */
> if (p && (p = strrchr(p, ';')) != NULL
> - && ((p[1] >= '0' && p[1] <= '6') || p[1] == '8')
> - && p[2] == '\0')
> - is_dark_bg = 1;
> + && (p[1] == '7' || p[1] == '9' || p[2] != '\0'))
> + is_dark_bg = 0;
> }
> __attribute__((format(printf, 3, 4)))
> 

You mailer mangled this.

WARNING: Missing commit description - Add an appropriate one

ERROR: patch seems to be corrupt (line wrapped?)
#115: FILE: lib/color.c:71:
C_CLEAR

total: 1 errors, 1 warnings, 25 lines checked

