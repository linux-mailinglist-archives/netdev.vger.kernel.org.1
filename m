Return-Path: <netdev+bounces-132426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C916A991B04
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 23:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7FBB21A0A
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 21:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30755166F1B;
	Sat,  5 Oct 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfGD5exN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A040F165F16
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728165366; cv=none; b=Z4tLdgu76wMgsu9rzjrTrIxeUQXohMMG5zTkKGmtXfluMTgmH6NClEYeU0hGmdiMz6PSZJEunULyY9yVzIYFOQVUOLA0drFqstVPZno5l108kuyUjH2TAtbaawJ10k3bl724yNWRYPENbV2cvv3VABxemDUVX1cYCH12uhrjv0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728165366; c=relaxed/simple;
	bh=Kv3tGeYVEvki+TLXFk7nQI92L8KqidN/GBFVcVcLd+s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FncxuOdPUNFf5ChYR6f4aXtFP7ZuFJ5vegu1AglRzVK3Wzs//rSJKm+XxiUo816gqxGJZ9WoP9Ug2QVEICd14Sb1ukWl5lKeIKdmay9SA+dG+nJMedUG7Rd5S1u9q+hMc/Rhcm/HchU909ANJzeMZBypqOxrsedz0huQJhxf6oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfGD5exN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2d1860a62so24284527b3.0
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 14:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728165363; x=1728770163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UjrRZf+/scm4ik6V8Y3O+VVxMpeJ9ouK1fJjBIa+BxA=;
        b=lfGD5exNlaJ3N8q909yLbyjvmTVwnLaWDJBWjyuYPD1H715L/ULegSOQs39jDrM5Pv
         0bLUpIoxXoxiLHvcuK0IhzquL6/YPHckuqOvFf31sY+grAPx/ylHZ35qgTXWUNq0nS63
         VAqTBRzoYyMKQTFyU4EO9NFUSHeiFlUktU5Oigr8uRgYK4Kyjn8bNhOdtyfi6RPCirye
         iEj2RXOrXn+FY3u1QM6olAhlVA0UkdCxyAfUUKLG0LeaAfUuXP8WjOHwhcICskY7ufV4
         ExDl8nZc99/OwRG3Hi4iLrXG5RQxjA0WE1LmMtsqPJ3sutyS9rHHjD/tMZheBPv4+FwR
         NOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728165363; x=1728770163;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjrRZf+/scm4ik6V8Y3O+VVxMpeJ9ouK1fJjBIa+BxA=;
        b=pJDSN0Syo1drAkQmNIab3Tv0lnR/pQyz1JOfflFZMQHGWWvA46p6EVKOB9vZBr4jVm
         288i0HtvqjukB9kBqlVCpZkfEFPw5eXUesRVJXBn7Qbo3PQ02lTmSSIs5AJSlU8WkjgJ
         tGxk4K6CMEO+DEbEuQGOFaZmyC57OYHdZYviaM7YGubvlVSWGMU4TaHFJl8xXhos45a+
         LBE8cT7pXf1++bxb33/6yv8yZNn5eOdyMyIms6yc+6214yfAGP2f5Lan0JRMoiMFHunn
         iUedbhB6MMnHOavZXdhh3eL+CW8EKs9P8ZfQmjqdOtj3p/B9CLtU5YG8d1GD59eKFo7h
         gPyw==
X-Gm-Message-State: AOJu0YxTtT9lVMgCpEpEoz1pswjRaMmOBowsxYW5I5fYrawRDho977tG
	7j/K7DGbvBUWh9nWX8pskBlkccWD4L/9ijFCpTIuGsXufr7kksaepGZh639Um2Ooi43vjKtFrto
	50V5MBw==
X-Google-Smtp-Source: AGHT+IHWpc6AdTIJHoH8hPk5oe2zVGLycQ2hBiOKJKUuhmS+kKN3bJkizgngYFJ0CrJraC8hT/t8k3PUgXO9
X-Received: from gthelen-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:2c:2b44:ac13:f9ac])
 (user=gthelen job=sendgmr) by 2002:a25:8b89:0:b0:e25:cea9:b0e with SMTP id
 3f1490d57ef6-e2893939abemr5252276.9.1728165363498; Sat, 05 Oct 2024 14:56:03
 -0700 (PDT)
Date: Sat,  5 Oct 2024 14:56:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241005215600.852260-1-gthelen@google.com>
Subject: [PATCH] selftests: make kselftest-clean remove libynl outputs
From: Greg Thelen <gthelen@google.com>
To: Shuah Khan <shuah@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"

Starting with 6.12 commit 85585b4bc8d8 ("selftests: add ncdevmem, netcat
for devmem TCP") kselftest-all creates additional outputs that
kselftest-clean does not cleanup:
  $ make defconfig
  $ make kselftest-all
  $ make kselftest-clean
  $ git clean -ndxf | grep tools/net
  Would remove tools/net/ynl/lib/__pycache__/
  Would remove tools/net/ynl/lib/ynl.a
  Would remove tools/net/ynl/lib/ynl.d
  Would remove tools/net/ynl/lib/ynl.o

Make kselftest-clean remove the newly added net/ynl outputs.

Fixes: 85585b4bc8d8 ("selftests: add ncdevmem, netcat for devmem TCP")
Signed-off-by: Greg Thelen <gthelen@google.com>
---
 tools/testing/selftests/net/ynl.mk | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/ynl.mk b/tools/testing/selftests/net/ynl.mk
index 59cb26cf3f73..1ef24119def0 100644
--- a/tools/testing/selftests/net/ynl.mk
+++ b/tools/testing/selftests/net/ynl.mk
@@ -19,3 +19,7 @@ $(YNL_OUTPUTS): CFLAGS += \
 $(OUTPUT)/libynl.a:
 	$(Q)$(MAKE) -C $(top_srcdir)/tools/net/ynl GENS="$(YNL_GENS)" libynl.a
 	$(Q)cp $(top_srcdir)/tools/net/ynl/libynl.a $(OUTPUT)/libynl.a
+
+EXTRA_CLEAN += \
+	$(top_srcdir)/tools/net/ynl/lib/__pycache__ \
+	$(top_srcdir)/tools/net/ynl/lib/*.[ado]
-- 
2.47.0.rc0.187.ge670bccf7e-goog


