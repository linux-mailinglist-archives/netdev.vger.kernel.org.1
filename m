Return-Path: <netdev+bounces-69693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F8084C2EF
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 04:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE129B247FD
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 03:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1420F515;
	Wed,  7 Feb 2024 03:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Mnq/R7fs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071DF9C3
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 03:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707275535; cv=none; b=SZmKJe+/OLmjKXFofH+1EJ6XN4JWjAXSTVL5TJxL2chh3rkIxTGy4iNQy27bZccOwUqNUDohcFtzqd3kVE1uoBwgfpQmsxls97UiCl+NaQnNdsyoUdNVZAJOTpIL/gnTMVs///k6IvIFyABMHQzbCRuX1ELVCLCVa8fGFdo5hQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707275535; c=relaxed/simple;
	bh=zcH4xV1yyZNXrsM9Lbmmmzffn+Q86R1FhNUDUSd10FY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+1uD6J1MdafJRIPUHA7SziABNfT5yhkREP0bPKkrQBXj+w0wNrrykngsUIVvy8R+iytNQ/Uaomp4pGZeDZwzocoF5N+h+pfvPEvL3xARLQyAviDXhyQhcDODcczz+VR5qCjIWGUD0ry+vAin1w3QKflVjRC/HtBic0bG0G63QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Mnq/R7fs; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60481aa5ae0so1731797b3.3
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 19:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707275532; x=1707880332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o25XIvQmlaA7Ks7ow6LoVkBTWMA0F25iqLw9NrhCo4Y=;
        b=Mnq/R7fsk8mBy2IAg1+1ApzyM40ZS+7qIvUgKr/BHw5eFiOvaU/xwBpp3LklfespCP
         pWAfZd7Zy289v9zOzDYIz+fOg4z5LiSncVqiuFt0QX31eK9G5/3e0Yfnxb3AGIRknQSf
         +rWMJlkXK00/NzMtU1ExrHqWauKvz+sVfzhYM1kOPkl31RylYKJoB1A9YsxXXW8Sw5i/
         cGH7jbc7ug2Bs1ipgAHMvWOkENA0PIfgMAE3ullpIxhvsot8rYWfbjGWmrk5TPBmjnns
         DrQIH4vzEbtcYFHmEFSrh6Tt0KTafuq93kozUc7iO4Movxwor4Nwy80YVRi1d7YE6e6X
         YD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707275532; x=1707880332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o25XIvQmlaA7Ks7ow6LoVkBTWMA0F25iqLw9NrhCo4Y=;
        b=vEUagN1gk/By8LRRxr/x6R3KDolo1IYkCSyWRQ6fcbqdBHk2QM4eCPqLvP2z7tEcfG
         MGsiLhdRaYAeeoTT8F5wAoxdrEqj/xhPkdFjwz9/Ae5rpGmxCXSI/kxbETYSIs2ejpYe
         7Tb/K8lgwE679noGARIU1KF+vt3MvXhK9vo63HIlytpbowuKcMMuCUKV6a0OE7AmDXfD
         iRf+SkOWM9sgvc3g76idefUcG3aY7wbse6DpXp2sQhfnHhI7iflJ5BiU1DJxeRbjQ9aM
         5bWX74Q9CtXavB8aPBjVPbhW/QN+j+V1VSXu8rmbXVHEkjU39UfPaITi3qZObRIW6zby
         gE+Q==
X-Gm-Message-State: AOJu0YzNMt6QutZ4Jc7yp+aYPRouOozI/sLgyyED07HuRPupmvYzp2LZ
	zsGto03YOpeGkmB8QUwEAeCervgx2VxlAF82k2NJQpOKLiEekC8thueQD8YptdE=
X-Google-Smtp-Source: AGHT+IFG+lRcFGJV0MHF2hi1Y1htMY4Xl75YwloCN7b6FZ+BSfRT8NUuRRBzNmetboCMi1Zah7C1Qg==
X-Received: by 2002:a81:b24a:0:b0:5e8:995f:6a0f with SMTP id q71-20020a81b24a000000b005e8995f6a0fmr3729595ywh.13.1707275532578;
        Tue, 06 Feb 2024 19:12:12 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id d19-20020a637353000000b005dc27ff85c1sm259615pgn.0.2024.02.06.19.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 19:12:12 -0800 (PST)
Date: Tue, 6 Feb 2024 19:12:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Stephen Gallagher <sgallagh@redhat.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] iproute2: fix type incompatibility in ifstat.c
Message-ID: <20240206191209.3aaf9916@hermes.local>
In-Reply-To: <20240206142213.777317-1-sgallagh@redhat.com>
References: <20240206142213.777317-1-sgallagh@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Feb 2024 09:22:06 -0500
Stephen Gallagher <sgallagh@redhat.com> wrote:

> Throughout ifstat.c, ifstat_ent.val is accessed as a long long unsigned
> type, however it is defined as __u64. This works by coincidence on many
> systems, however on ppc64le, __u64 is a long unsigned.
> 
> This patch makes the type definition consistent with all of the places
> where it is accessed.
> 
> Signed-off-by: Stephen Gallagher <sgallagh@redhat.com>
> ---

Why not fix the use of unsigned long long to be __u64 instead?
That would make more sense.

Looking at ifstat it has other problems.
It doesn't check the sizes in the netlink response.

It really should be using 64 bit stat counters, not the legacy 32 bit
values. (ie IFLA_STATS64). Anyone want to take this on?X

Also, the cpu_hits offload code is a wart. If it is of interest, it should
be more than one stat.

One last issue, is that change the size of this structure will break old
history files.

