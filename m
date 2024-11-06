Return-Path: <netdev+bounces-142563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F03A99BF9E7
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 00:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E89284096
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB3A20CCED;
	Wed,  6 Nov 2024 23:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Jj6iCG+w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C4D20E01B
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935369; cv=none; b=uYqL1rJVse9sn1VTF3dhAmCE+G5xeqmoqygULMkFDcLf/nQx3VS6HsAMRNGXxNf8TPjEsWJ7l+dwQTS6b8MeG+bIYVzg9i+JCK2YeXWHJbf6s5I+409vo6ij5J3JHwiAXne4Ttk6TTQ251MLEi4JoVysju9iA/mN2Usp3qtfvao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935369; c=relaxed/simple;
	bh=jOfBxqENdSf1o1pW9AbEfiJ7ZTE7QI+vRP1ScfCbdPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZnJToX8ep4uDV/cfrxI7BEp9vBgRSaL/Jv1Q076LIIXNCHkogZ9YcypWqTfz8b4EV4O2shL6mZUcjqccDXHlyR3JJkYmevWyjVl+UqMk9t/1H1L4OfCSg7H2vmkw6s7NeATbN/dZKfW72z9QapB12KwqHO/+otmoXmQhCvCS/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Jj6iCG+w; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720aa3dbda5so204398b3a.1
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 15:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1730935366; x=1731540166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydMjaDBHGP4Lclf9xzXBO/5cdGNcVM/AKLksSI3sEJg=;
        b=Jj6iCG+wmhpRWEaBi7iiyQ9Zpc4aRA1i/2nuxQ5a3Im9O0otcrQUUmFD+qkuxbGVua
         3GPa9lq3xe4BsBtAld0ulncLO7/tWIDsrtlZCoW6a4WdsHdvpCAwJH98Y4k4bTYpPeVA
         0k2pPkAVfFOPguDrp+Flri8J7nYsB5VqfmKuL5x+FgENJoyx11aWv8IiyX7OaniUxxyc
         NUsNU05cUpgdA+FQKDYDfipjjGwLgJpSDK0NocSY/ONng+OyYuxYL1aTMkWjALBtjPgH
         YHYRBTCLYtRSd7YDFSlAfPK5LP8J7I0xG5xt/CuDyDSGUkVlgZu2Ol3+FvTjyKo4yxgw
         h/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730935366; x=1731540166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydMjaDBHGP4Lclf9xzXBO/5cdGNcVM/AKLksSI3sEJg=;
        b=WaxEH57ELaLdR9EVDA29Io0jadzaQqjaYV5CS1Pn1YVqGzRk/Yg6BBtR3+/GFkvL71
         0+9LEcmAYBydozJt66/DbQwRe7+y6wp26VYRF7dBeqIA1evo3TnAi/4mA+2KC7LBgzZ2
         i9/3+VbSwPhclKxiO8r/r946bQY7NCidHx+qNdz0wP4WqPPG68HHNPGCO9uLgroT0kqj
         VUMHxZmjrq/toQ0FjuRZlxv+lbJXeDM0ioYGettzXnnfIBT0WjuD2N64xFDgjPJJXvpz
         HXhfD/KZI/W79pTD+RLe7m74EPWWr7vIKuztKcZFE1jLrGiYjvoxzFJPwQI7zn7P/Lmi
         XVpA==
X-Gm-Message-State: AOJu0YzAwVf6aavBFvee4P+qtdz+SUvI+YFIbO4cXwqdeDpQ2zukMeUf
	TrWBu9MU+2BF9+fm4yxVN9J0ndawu60A0Z87HcwUl3UkoMsV0okRQExuMTtWhEQCQtuDtRmD3VI
	U
X-Google-Smtp-Source: AGHT+IF/EhaMc7fzgDGnQqC9rGXvQ2RrvnawI/SmabYZLwWg1vQ4FFUedV1FQWsXM7FD+72xYFUSEQ==
X-Received: by 2002:a05:6a00:14ca:b0:71e:7674:4cf6 with SMTP id d2e1a72fcca58-724080b6e40mr71119b3a.8.1730935366370;
        Wed, 06 Nov 2024 15:22:46 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ef5sm101396b3a.63.2024.11.06.15.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 15:22:46 -0800 (PST)
Date: Wed, 6 Nov 2024 15:22:44 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bjarni Ingi Gislason <bjarniig@simnet.is>
Cc: netdev@vger.kernel.org
Subject: Re: dcb.8: some remarks and editorial changes for this manual
Message-ID: <20241106152244.21a1c384@hermes.local>
In-Reply-To: <ZybRdNeIHWohpWYN@kassi.invalid.is>
References: <ZybRdNeIHWohpWYN@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 Nov 2024 01:27:16 +0000
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
> Signed-off-by: Bjarni Ingi Gislason <bjarniig@simnet.is>
> 
> diff --git a/dcb.8 b/dcb.8.new
> index a1d6505..2202224 100644
> --- a/dcb.8
> +++ b/dcb.8.new
> @@ -2,74 +2,74 @@

The format of these patches does not allow for simple application to
the iproute tree. Patches should be on the same file. All your patches
have .new which won't work.

The simplest way to handle this would be:
 - take a git branch on your local repo
 - do the work there and commit each change
 - when ready to:
     $ git send-email --subject-prefix 'PATCH v2 iproute' --cover-letter main



A normal patch looks like this one.


diff --git a/MAINTAINERS b/MAINTAINERS
index 1b49d69e..84931abd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30,6 +30,7 @@ M: Roopa Prabhu <roopa@nvidia.com>
 M: Nikolay Aleksandrov <razor@blackwall.org>
 L: bridge@lists.linux-foundation.org (moderated for non-subscribers)
 F: bridge/*
+F: ip/iplink_bridge*
 
 Data Center Bridging - dcb
 M: Petr Machata <me@pmachata.org>
-- 

