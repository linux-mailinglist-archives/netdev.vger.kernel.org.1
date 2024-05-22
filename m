Return-Path: <netdev+bounces-97645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B5E8CC82C
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 23:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34ECE1C20BE8
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191427FBCF;
	Wed, 22 May 2024 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="y4LHPNk4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA0442F
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716413640; cv=none; b=ciVxGdpePEqWZIPpEhIorTBARR3fh26592nrhgOrKd3KZlBhLcRDA/EK+SjBEKyOIdYm7iMMLZzsr0Roxmq2Xzx7PptLidQ0uJ6ePzmsXDnXFEB417aCEx7LwxwEgWX4t1m1JWfmDFOal0dgtlwwGjx2imqsn1xuxcWpZAharZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716413640; c=relaxed/simple;
	bh=s+mQzMK0UsIhd1GuiC5yyrSVYwG0zPpD+YdBWqmttbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cj710adWzPRLnIhIaSjvCPjb+wr+JYMmtWyPXtb+4mGwA5OWG1dAJFl1DFEuxIHrUznRFZ2UzMV4EQ+zTjJc9OZJUySX9FYjWJ2NGxCY5rT2OBy4k4CMbOEowjgFrgLpSyvK6Ckb/nyausOWIAh4qdd8X4rAolXXXZ5HCHlbF6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=y4LHPNk4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f44881ad9eso1694700b3a.3
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1716413637; x=1717018437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr0a5YkzoVQkHz450jWkQxICDMFHcUYImxN8TizQ4Xo=;
        b=y4LHPNk4IozJgO5ZP6F7w+BuZ1M9bb2A0W6tCZ+nDxwxGb7gCGYAHriI4FokdAhS5L
         wYP22A4lxDAfmW+C0hW7U9KhXrqBJkPcY4kadK9g8RerVzadzvmPaZXHiDPnXCLGXyJN
         ZWdVFKhj7hFhm4oxlvRCj/6yikuvt4wYUtwEQFa1sNkPp0NHnu9bQeT1JETctaameNfC
         95oH9HreU/WwOaq/Ml7YyhLGS1WFHTo+ePeBew3zStXi46OaL1Eq/GLD2agnsNmXqeBt
         zhyVgLLR9HJZgk0lFT8RyZBtg5Ez3ezKUZlACaJc1jCUuw3DbFr9avVzfNwl6LHizusu
         WhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716413637; x=1717018437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tr0a5YkzoVQkHz450jWkQxICDMFHcUYImxN8TizQ4Xo=;
        b=I05sAqJK/2ZgKtvzZul2yU4NMrCZj+7MWe1/GKW66tDnIIAPFWBmRg/p4iHVh+RN4u
         LOnxDRI3216siKlzg4bK3roQc2A+nRBebkE5LHPaHvewi49DHW1XP8CRNcgMm/Jku9ky
         t3MNabeEC6PBqKRMe+IcTh8oiRUvgnET9x3kdaWSAVqFQgvWKRpNnNR+CWBrmjaFCw3a
         dflwo5mOrVs7AuLFjVNq0t4KrJqOUq1ZK4kOIKeY+6xHkMuTNYmZgAFT0zUAArUb9LPC
         /Uh8kqqlhm8lvXU3Qzd/ZwlUzi8kHE8dLx/m1KGof8EKYWo+rC2HqX1BXz0Zi3ujaIjc
         vn3A==
X-Forwarded-Encrypted: i=1; AJvYcCXJzk3T8hTMO6IwZpF9oKbBTzpd7fbmWNVdVgOaMUnntNdktCBQh4hWkRaAQMFZEgyuKN0quEjku7Jny7kYOScQ9p/gEb4u
X-Gm-Message-State: AOJu0YzheWrgAU+ACAm2v0jdoA3gww5K3lpU1Vhmf765gkdu7RM4xWbo
	AjsYPaKIFWgKmPmADpd61Qi7ePDjficKVqhpQIGXjbN9WHwi1KfVMp+EMknh6sv3wVYMkY0aywo
	K4j0=
X-Google-Smtp-Source: AGHT+IH9F6yO7dz68vgoUUxn3yCjiyXgyk2LyGajfzPvm7TrTY85cqEMd3QH2L6seXy6WKuj+Cxl4A==
X-Received: by 2002:a05:6a00:b81:b0:6ed:21d5:b03a with SMTP id d2e1a72fcca58-6f6d61636f1mr3644671b3a.23.1716413636551;
        Wed, 22 May 2024 14:33:56 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b3181fsm22903443b3a.217.2024.05.22.14.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 14:33:56 -0700 (PDT)
Date: Wed, 22 May 2024 14:33:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Gedalya <gedalya@gedalya.net>, netdev@vger.kernel.org
Subject: Re: [PATCH] [resend] color: default to dark background
Message-ID: <20240522143354.0214e054@hermes.local>
In-Reply-To: <2866a9935b3fa3eafe51625b5bdfaa30@manjaro.org>
References: <E1s9rpA-00000006Jy7-18Q5@ws2.gedalya.net>
	<20240522135721.7da9b30c@hermes.local>
	<67841f35-a2bb-49a5-becd-db2defe4e4fa@gedalya.net>
	<2866a9935b3fa3eafe51625b5bdfaa30@manjaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 May 2024 23:02:37 +0200
Dragan Simic <dsimic@manjaro.org> wrote:

> On 2024-05-22 23:01, Gedalya wrote:
> > On 5/23/24 4:57 AM, Stephen Hemminger wrote:  
> >> Why? What other utilities do the same thin?  
> > 
> > I'm truly sorry, I don't understand the question  
> 
> Basically, you need to provide the patch description.

The color handling of iproute2 was inherited from other utilities such as vim.
There doesn't appear to be any library or standardization, all this ad-hoc.

In current vim:

    char_u *
term_bg_default(void)
{
#if defined(MSWIN)
    // DOS console is nearly always black
    return (char_u *)"dark";
#else
    char_u	*p;

    if (STRCMP(T_NAME, "linux") == 0
	    || STRCMP(T_NAME, "screen.linux") == 0
	    || STRNCMP(T_NAME, "cygwin", 6) == 0
	    || STRNCMP(T_NAME, "putty", 5) == 0
	    || ((p = mch_getenv((char_u *)"COLORFGBG")) != NULL
		&& (p = vim_strrchr(p, ';')) != NULL
		&& ((p[1] >= '0' && p[1] <= '6') || p[1] == '8')
		&& p[2] == NUL))
	return (char_u *)"dark";
    return (char_u *)"light";
#endif
}


