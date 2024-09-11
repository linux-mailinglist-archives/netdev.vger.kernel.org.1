Return-Path: <netdev+bounces-127515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC938975A1D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA59B21305
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01661B9B2A;
	Wed, 11 Sep 2024 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eUW318JE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A131B5339
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078308; cv=none; b=aqMZOetQMemwPGX4no/nkvR0KBzgxAYu2D9Xtjuv/NsLq5+P+B+Um2/YKRuBlpsFKdC6+8hBbCKIGCIola8acQPIVdUHwaRFsNu1r6GN1O6GZfjhRJ2vX1926a9BrcnWr0IQ1o+3rBL+aaEOfj0PFG7DdQFKVzID4r7xppIJfDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078308; c=relaxed/simple;
	bh=z857oVhOO9Ge5wn4k4nabsLRCg+zyT2pPs33TkWJQgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVzHCBjlL38TZ3Mab8aYHL79+G0EdTj5dGVJ6Rpfke12SXVyqwS79eXqh2ifwvCfH7tw95/yEh4x5tpxg3nGvx3bI/So4KTZnaDVEbAFtY4DJCUlxkAq8l/MfOJJP8P8MG8Q35PtP6wa1DMTe9S9Lza7tnubT3vzZghbAHv7k9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eUW318JE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c3c3b63135so60992a12.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726078305; x=1726683105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QXiJI/L0vchgadKCOX7xJsbzxv2AfJtb8fmGhILgPNI=;
        b=eUW318JEqq3nOOv6q0RUOLmp8SJ1uSU1b2C8OAfpd/hUduiMZufOcxFsok2YhIY+sH
         gUgZGx7ODA4p1X1V6xWFU9PSHmtqwv30qc6TgN0gu4Dd1CP8o322VZbjeh3yL6DT/kwu
         13uZhH51W0HyJ0qal+HpoqxAI9CANUztim8FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726078305; x=1726683105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXiJI/L0vchgadKCOX7xJsbzxv2AfJtb8fmGhILgPNI=;
        b=Iq5Y0amCPucRhZ7GuwPf1MFV9j+YCAP0GK5QK3jrYF5p2ePk/wnIC8sj1sPTIMnXNV
         e327h5uEhGoj/ztuJtB9JNMra7OzhNA7VNkbj1lH941amHsmL1i7EF/F+PPxWDw+DUpi
         wnLcFam/dY00XQg2wzWYqhbCM2AoYwvEcAvl9EgswJFQbmH2ZEUvEkvZCZVhFs7A/dcj
         /Sicd0HIP/r2DD3KtgM9kF/YapZmRZiWT7IQvokUwYeg+EZ9PUKEPpxwVttJ5UtWXU6U
         dSnp0OANeV/j6xeeBsEHFKVJLiCGxefzCXypFQXCzLpiqsUAEVBFtkej3z27yQMYe/bD
         Qpfw==
X-Forwarded-Encrypted: i=1; AJvYcCWxaODjIe6e004hUP6Yz+7LoKnBPfmzt0aHLy982L2Pf5dOhAvRlQouRq8gRwbHBm5sq4zJK34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO7UvGQ6iTK+DlHGN7Cq1TJt5T0T3rX3Ubn/6V85X2diG5zC45
	wzDEERmuNZi7vYZnAB3aghmKi+5YASD9ziNvYrAW774VaF3+ZqMUVZ8BKaoxEhYpS5TKd1eGZoz
	cv+vH+A==
X-Google-Smtp-Source: AGHT+IHEyxVW3+w8T3S6enxb99EkFT5T5RiazLkgyvcpmHJR4swpsLRcDJ7LlTsEPyMTbi4c9sJFgQ==
X-Received: by 2002:a50:aad8:0:b0:5c2:6d58:4e1f with SMTP id 4fb4d7f45d1cf-5c413e57af1mr198444a12.33.1726078304798;
        Wed, 11 Sep 2024 11:11:44 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8c4d4sm5630728a12.82.2024.09.11.11.11.42
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 11:11:43 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so113688a12.0
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 11:11:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUySyzf8CLiBWjQ73uArxJPSzjySLwpwWN1Pf/Ojm8WcX0b68oRkNCWGwOyckUBZo6YXhNjGLs=@vger.kernel.org
X-Received: by 2002:a05:6402:33d5:b0:5c2:5620:f70 with SMTP id
 4fb4d7f45d1cf-5c413e4fbd6mr215370a12.28.1726078302536; Wed, 11 Sep 2024
 11:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726074904.git.lorenzo.stoakes@oracle.com> <b38d8936eaddd524d19823f7429138e2ef24e0d1.1726074904.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <b38d8936eaddd524d19823f7429138e2ef24e0d1.1726074904.git.lorenzo.stoakes@oracle.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 11 Sep 2024 11:11:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWJmQJSWz_5S8ZqEpDs1t3Abym9DPZfUzWu+OCNM3igw@mail.gmail.com>
Message-ID: <CAHk-=wgWJmQJSWz_5S8ZqEpDs1t3Abym9DPZfUzWu+OCNM3igw@mail.gmail.com>
Subject: Re: [PATCH hotfix 6.11 v2 3/3] minmax: reduce min/max macro expansion
 in atomisp driver
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Richard Narron <richard@aaazen.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Arnd Bergmann <arnd@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-mm@kvack.org, Andrew Lunn <andrew@lunn.ch>, 
	Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Sept 2024 at 10:51, Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Avoid unnecessary nested min()/max() which results in egregious macro
> expansion. Use clamp_t() as this introduces the least possible expansion.

I took this (single) patch directly, since that's the one that
actually causes build problems in limited environments (admittedly not
in current git with the more invasive min/max cleanups, but in order
to be back-ported).

Plus it cleans up the code with more legible inline functions, rather
than just doing some minimal syntactic changes. I expanded on the
commit message to say that.

The two others I'll leave for now and see what maintainers of their
respective areas think.

            Linus

