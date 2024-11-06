Return-Path: <netdev+bounces-142461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3E89BF436
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB2D1C23956
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 17:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CCD206948;
	Wed,  6 Nov 2024 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Z2baZQ8X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938A4204F96
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730913660; cv=none; b=QT3KpOtIorwXKH4rxfBjfBdvtXNBmdHVbgEho+1vT3KoIwdxQgkXQdIm4uoA2RBA0Stez6t63OEeHyA5awP1gBAMYx4cS2GjIs9xjKTlP7I72LA6EJSVzJITc1C/qzTrEYCQQ5OO/GlrDtKRPWfyZYSxjFyxwaj/RAI/y+MVvJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730913660; c=relaxed/simple;
	bh=39Cga9ndd7E5bChWBJmBEX/nr1Ku5Bbk888NF34tLGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D56yZYnYe4i0/RKLlR5suhIY5v2b66wg8/xVjPiMfcBDeV73PvdSx2FIo+sHCPv8LsLI9Y83qnAG+xyExUEZqPQ5u2HUsrCrIkutk+aSJY7x3a9EWnWz8N8+JycORmBP7xD5r+fs2KPnzLcQ5w1o1pri5O2tFPZWpgGREyVXxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Z2baZQ8X; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so5553903b3a.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 09:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1730913658; x=1731518458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaY2V4yeJYV0Wgd27pMihOqHFdjjKIapxqVymzwPFp4=;
        b=Z2baZQ8XEmUJjbQ3UkXF57XTfN91eNQEz5GzybWgg85fTkDuE+qExSxiQw+ilhn7Xf
         huhos9uwxMlBHjzNxSE8Ce9MYsC3mK2NF8mCxg8Ikwfinj1fBUKcCiq8j3rHYLgZ89uh
         Jm4271Aid7QEip/3GVOR+N7fgNyeBiSa9q4g5aOyH/jgHnvSJLadN1PuFd+cALBQ1eU9
         9oozZ8KOz42q/bShm2uxAVp+thn/IUr+0yhjHoYiFqCFGxrfJ/jdMai2mWtHDYa2Iy7j
         u0J2NgcWFtH695SY4yRtFpTe53PR+jzfTyU/1mxi1nt0iQUgsWl8uQhF2dgVJYQCOkjn
         ANEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730913658; x=1731518458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaY2V4yeJYV0Wgd27pMihOqHFdjjKIapxqVymzwPFp4=;
        b=c/9bekPz9ytAUNXvphxWrJBXLscJ6GUV+xQP7BUfwhoidmQ/N08QUmv+PMH2B/Ow9L
         6+0LYdlRJTs+M86tMkQ/RNCfg1f98HdVnP7u4Gn7jhnhX8l01iobU2b0I5mWIGCeZGQI
         WezFYU6NIjyJ7yBSeVsnkYIkEsPvbSo4L8dBHY2faTVEI4bf+710+0CoeWrx/T3xz7H+
         n0pyrTacrcFyFPKlNeUaBs9ADr2hie/nGObCwy+Rz7wER+DYhx1rQCAAqc08vPcykAVp
         LtlI7qFAMnq+WYtMz6jn5h+IwPRATrH5OLwHTHlZ40usBwHnUwW2B/Mh2ybEK8H/XaBw
         FcSw==
X-Gm-Message-State: AOJu0Yz/SoEYP+QV3MMioYR3Pg8ozNEmytK0m46Ilq5IwUqKNbblS0dM
	gKbKxvh/QOInonph95lqlRvytCfnjPwSZKt0gdcCebobBuATOOzCJXCJ4885Tf0=
X-Google-Smtp-Source: AGHT+IGtmPB1rlYfNUE9uX639gAH+GE5QcXH9TVy24CybVQU6ZZZfxvmv3USg2O5+DV45mYUDS83Jg==
X-Received: by 2002:aa7:88c8:0:b0:71d:fe5b:5eb9 with SMTP id d2e1a72fcca58-720c98d32d5mr29849705b3a.10.1730913656457;
        Wed, 06 Nov 2024 09:20:56 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e5717sm12006191b3a.54.2024.11.06.09.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 09:20:56 -0800 (PST)
Date: Wed, 6 Nov 2024 09:10:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bjarni Ingi Gislason <bjarniig@simnet.is>
Cc: netdev@vger.kernel.org
Subject: Re: dcb-pfc.8: some remarks and editorial changes for this manual
Message-ID: <20241106091046.2a62f196@hermes.local>
In-Reply-To: <ZyrAxcsS04ppanYT@kassi.invalid.is>
References: <ZyrAxcsS04ppanYT@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 01:05:09 +0000
Bjarni Ingi Gislason <bjarniig@simnet.is> wrote:

>   The man page is from Debian:
> 
> Package: iproute2
> Version: 6.11.0-1
> Severity: minor
> Tags: patch
> 
>   Improve the layout of the man page according to the "man-page(7)"
> guidelines, the output of "mandoc -lint T", the output of
> "groff -mandoc -t -ww -b -z", that of a shell script, and typographical
> conventions.
> 
> -.-
> 
>   Output from a script "chk_man" is in the attachment.
> 
> -.-
> 
> Signed-off-by: Bjarni Ingi Gislason <bjarniig@simnet.is>

Is the last of the dcb man changes?

