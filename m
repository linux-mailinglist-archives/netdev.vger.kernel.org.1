Return-Path: <netdev+bounces-73576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 382D585D374
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 10:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D23C1F235BB
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 09:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBAB3D0DA;
	Wed, 21 Feb 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KGrfOqHQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5B83D0C5
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507683; cv=none; b=kh0NlpFmMmAFuw9BnyUQwfrOyU7xWSrU8zmKuZCJxZP69unOawk5nRvSU9xTtpqu33/Bow6vL7ngmHRpADAo94j4ZoI8BidgbLVR8YJ7IQytGxzch4aGquGaTtXPNRcWg27TAf9l0aKaCNT2HWXy5hoZjBGUQ2zjS7Kxth4ib20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507683; c=relaxed/simple;
	bh=rqOJUF9M6mrQc8dXD7M61zFQtSxp3b+ZbBeG2t6aQ78=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZKLvD1rMdzyVRJMuPsyZ0q2QlQBwJKBL1M6Nb308czwVrwWo1zGKg4uM0VgvyfPvc38zzwDd1zaJtdSEow0PK2DejN+mmiZ2cybNRW+6wzY4XjFA39Il2fnwAw+PHzTLNIxX9+gSr44q0r0H+NH2hwL2DXxp21h8Q4zE9irvOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KGrfOqHQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dce775fa8adso931706276.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 01:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708507680; x=1709112480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eT/uH0qZq3eqCfd94wgAJ0+lZ7IXzMci6RxxltQCKcU=;
        b=KGrfOqHQz28RK8t77rt5ggx03KxOwAFzkpedVpi5057cKMpApzJygU4Zjxbktz584G
         pzqxZcplfxBJKKStCROql6+LlpHjEulo+NwsaS66AWIcNfNiFyMXg72DJHI9kAxkAwpD
         pjgwbVfBhM7xVRkBB1bdlqUIWkkb3TJ/O88666LvBVWwzVGcOB6BXvfjx/RZxCNLi7jJ
         84ETuusGPKXg2Zwn0kK6WPg1CW5dpLKKbr9Hcs66so2YNmPhh2EjamJsxJ/rTIP2q8qX
         IoDqNKMITG2fR3csA4vkehNX+mQssYD3GEGKCsIWfnTZsCL4qeqqTBJZZ9P3ix5CPaJO
         tScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507680; x=1709112480;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eT/uH0qZq3eqCfd94wgAJ0+lZ7IXzMci6RxxltQCKcU=;
        b=UqQgSl1gtKzB/urKjk81VbonWHkAo1lvv4AUTq5xx956ZNp5fsES2pWk5nnGMnFNc2
         G8hijLHjFF3Xt61hdTpSdK5HCLjjRCX5pj8cCev/FyS9teaDeIJDJuG6uk8Qs2vmTkgv
         MqcCZsb33bEEMLal8mGGmBsfr9qpUnYXuVR474qPlc38Zck3RHBdo7gKYeb1c+ezpJPc
         0Z0GJeFfDjBiWKJd22bUZrmSuBexAla3cchGxRL+n8tq5M7NM2V5gp4a5e30tOzA23iU
         N9vRJcwxFFc1Ud6ABI9oJ8bzbcxeNfu06bAf8kXemWS/hh5tNjfwkdGWFdmI932pRWxn
         6j9g==
X-Forwarded-Encrypted: i=1; AJvYcCX9A5sjSN0wX1bUh3BVd9VUmaVNptx5/OCa1Ld0lQFBhBooc06PD1oMX+eZ41ZDl61LoYYd4CrgjilgEdVIOuY0LhlUzUFS
X-Gm-Message-State: AOJu0YxHAl03VBPnB0qQb2IOvV0OTvtKpBeDP0UJqYxnjlfELCnM+1+X
	uoqYYP5t94xsG8PO5+7hvygbowKKrFZ8zRMA9an6KPRFaLN5VjDV7NsJNBNXI5KU0xRxsbb9sI8
	ksY/3eCGyYg==
X-Google-Smtp-Source: AGHT+IGgpxMwkWEuztRpScY6gpG7tiyfC6FQuhNT36WOurGMxJcdy1PSlvVZEYKt9//gZI89E5vnji5S6AEFRQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:188f:b0:dc6:dfc6:4207 with SMTP
 id cj15-20020a056902188f00b00dc6dfc64207mr4738387ybb.10.1708507680618; Wed,
 21 Feb 2024 01:28:00 -0800 (PST)
Date: Wed, 21 Feb 2024 17:27:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221092728.1281499-1-davidgow@google.com>
Subject: [PATCH 0/9] kunit: Fix printf format specifier issues in KUnit assertions
From: David Gow <davidgow@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Kees Cook <keescook@chromium.org>, 
	"=?UTF-8?q?Ma=C3=ADra=20Canal?=" <mcanal@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Matthew Brost <matthew.brost@intel.com>, Willem de Bruijn <willemb@google.com>, 
	Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>
Cc: David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Daniel Latypov <dlatypov@google.com>, Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

KUnit has several macros which accept a log message, which can contain
printf format specifiers. Some of these (the explicit log macros)
already use the __printf() gcc attribute to ensure the format specifiers
are valid, but those which could fail the test, and hence used
__kunit_do_failed_assertion() behind the scenes, did not.

These include:
- KUNIT_EXPECT_*_MSG()
- KUNIT_ASSERT_*_MSG()
- KUNIT_FAIL()

This series adds the __printf() attribute, and fixes all of the issues
uncovered. (Or, at least, all of those I could find with an x86_64
allyesconfig, and the default KUnit config on a number of other
architectures. Please test!)

The issues in question basically take the following forms:
- int / long / long long confusion: typically a type being updated, but
  the format string not.
- Use of integer format specifiers (%d/%u/%li/etc) for types like size_t
  or pointer differences (technically ptrdiff_t), which would only work
  on some architectures.
- Use of integer format specifiers in combination with PTR_ERR(), where
  %pe would make more sense.
- Use of empty messages which, whilst technically not incorrect, are not
  useful and trigger a gcc warning.

We'd like to get these (or equivalent) in for 6.9 if possible, so please
do take a look if possible.

Thanks,
-- David

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/linux-kselftest/CAHk-=wgJMOquDO5f8ShH1f4rzZwzApNVCw643m5-Yj+BfsFstA@mail.gmail.com/

David Gow (9):
  kunit: test: Log the correct filter string in executor_test
  lib/cmdline: Fix an invalid format specifier in an assertion msg
  lib: memcpy_kunit: Fix an invalid format specifier in an assertion msg
  time: test: Fix incorrect format specifier
  rtc: test: Fix invalid format specifier.
  net: test: Fix printf format specifier in skb_segment kunit test
  drm: tests: Fix invalid printf format specifiers in KUnit tests
  drm/xe/tests: Fix printf format specifiers in xe_migrate test
  kunit: Annotate _MSG assertion variants with gnu printf specifiers

 drivers/gpu/drm/tests/drm_buddy_test.c | 14 +++++++-------
 drivers/gpu/drm/tests/drm_mm_test.c    |  6 +++---
 drivers/gpu/drm/xe/tests/xe_migrate.c  |  8 ++++----
 drivers/rtc/lib_test.c                 |  2 +-
 include/kunit/test.h                   | 12 ++++++------
 kernel/time/time_test.c                |  2 +-
 lib/cmdline_kunit.c                    |  2 +-
 lib/kunit/executor_test.c              |  2 +-
 lib/memcpy_kunit.c                     |  4 ++--
 net/core/gso_test.c                    |  2 +-
 10 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog


