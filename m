Return-Path: <netdev+bounces-70573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75B984F9A7
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 17:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F069B20D52
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A605339E;
	Fri,  9 Feb 2024 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="WqaW+4sp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1515364D6
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496414; cv=none; b=f9f4tzhRqmsBSqb2kHBW39pjr+bhR2CyfQ8foJDwhw1Kdr0oXvkrymd9ZqiP3DBPTBLY8wXqdV/F/klFahwOcSYGBqQJWovV8G0S2c8BjmFoo4vhWITmkibyR1XnvbSUNOYpqyGWe91DtpebWV0H6rBVH3wIyt7tneXaqY/LYkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496414; c=relaxed/simple;
	bh=bSjT20LSUIvhaQfymo78eewB7ruv4I7fuHPIMglPpAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diCHd8H6Z0XmD8+RATe42wyrb1ro0kIChQEBHHR2sgT37ucGwr/khh9UHAk56mTQEkVmqLEMIOnw7gzbzsV5Sj+jQ+ZLGV3szXWes8UZ/yNFRoS/JJkfqgiYFGW+ugHaLt3D6sUfa5unJxpjj55EQ2YhkiSWzMzcLuawWLZvdnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=WqaW+4sp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d944e8f367so9398115ad.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 08:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707496412; x=1708101212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luf6+bc/gBu6qOni8/G8YdZLsoiqZFA+MfSeAt/UVp8=;
        b=WqaW+4sp+MnHwhna7SY4e/i3DZNcA6OmdAeAzl81n+9QAcjo7fNJxOvUewuWvAG7xi
         ofZiF8MM5+6APyZd0pQv+OxHzNI8D1C1NFqnTz5Q0dPfXWyTn5SzHhJOv5wbFz7VkZCA
         r6WKBC9nMINvDbK/HoapTiGei2ZS/Xn8KZeylThaHqbXjtAGCUum9e8d1FIOAc3ltADc
         sIOwnssBE3MvnI8PqPvVPYLVyws/ijiO/ctoAcqIJtWdQuyw9oFc83g08GqKsQk9FCOS
         NbyChNEYFke7Fb4XYtFRle2U/Ep0KgmqzkMcyyS5J1mzNWKePwIVOXuWP0nvWq+GBdhe
         NNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496412; x=1708101212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luf6+bc/gBu6qOni8/G8YdZLsoiqZFA+MfSeAt/UVp8=;
        b=wjizFx/N7zFbjdjRBahH5WqEGofgDfSwnKqOtZDgobEqjLlS+uwAObQr30aHdiYLeo
         Ge4P65C9VxFDxavSPOhA9TStqVlmJoMMAPMgoX+SnucgpNlwUqd2z7bn10NA6CavLEKK
         3v90BUFdt4doQGSN4JXlQ0g9zWK91IT1NaGRXw5/D9yh8x1+vJeCZVaZGN/OENHl/o84
         IwwuVazybr3xmAsR4hzhGt/mHfB3UpKzbSGRs0xKbSh4YsskoUj+AfT+CrAZqy0M3b3s
         EdMba2bo2c0iG84fsAPYGEMa+TqE9F3hU1tczscl6SJ3UTJvZSBuJypB+zwHLMcODB8c
         bybw==
X-Gm-Message-State: AOJu0YzRMhz197GeWklD4apAaTb6+Izu6LGYVEtKEqTdhc+N6OI5h86T
	8aDKfV6azSXCHfJyRJuoIcdbODUzKxypgFyY4og7BNRttLjnP/EpwD8/hYyEAY8=
X-Google-Smtp-Source: AGHT+IHLNl11ZwDIytn3ZftnkWCWvB4fj/JKad846Nhw0fBJfput77zQN4cd6P7ASkdGcVQGpyxATA==
X-Received: by 2002:a17:902:e74d:b0:1d9:4d3f:cbf8 with SMTP id p13-20020a170902e74d00b001d94d3fcbf8mr2174735plf.22.1707496411984;
        Fri, 09 Feb 2024 08:33:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVGRH0BPBYjq1gkZN6KnE4Fw/H1j36Gq0xEEfx2ddugb7f9gBn7DXaecV20TChPQm/pZJRRkzT11/N2CqBtiXHl/XpePazYYoKNR30ipQ3TjWrGYT0YxvsGA==
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id kt4-20020a170903088400b001d91849f274sm1703050plb.134.2024.02.09.08.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:33:31 -0800 (PST)
Date: Fri, 9 Feb 2024 08:33:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: dsahern@kernel.org, netdev@vger.kernel.org, Denis Kirjanov
 <dkirjanov@suse.de>
Subject: Re: [PATCH iproute2 1/2] lib: utils: introduce scnprintf
Message-ID: <20240209083330.391a773e@hermes.local>
In-Reply-To: <20240209093619.2553-1-dkirjanov@suse.de>
References: <20240209093619.2553-1-dkirjanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 04:36:18 -0500
Denis Kirjanov <kirjanov@gmail.com> wrote:

> The function is similar to the standard snprintf but
> returns the number of characters actually written to @buf
> argument excluding the trailing '\0'
> 
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---

I don't understand, why not use snprintf in ifstat?
None of the cases in patch 2 care about the return value length.

