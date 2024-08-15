Return-Path: <netdev+bounces-118946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E01D953A0E
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 20:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E071F27EB3
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4426F2EE;
	Thu, 15 Aug 2024 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPvLLmpd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9826CDCC;
	Thu, 15 Aug 2024 18:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746584; cv=none; b=VXggVKU8IMWgzok2fdfB47582qAFiBZ20DLaV0ShEWiQhTuIYWjFeb+frcxh8jfqiJkYmCu7EchtEok8G4G1XSooFHkKbZcZmuSMbJMLk7uoENM2uYZLDn78h8LrJKjHNw/B8XyeTSPNItGWmlyImaJfE0FvKTH5IqnerNG46Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746584; c=relaxed/simple;
	bh=yO7162N4YLtU2/brXvyxJHhtffw2+I3lhuH775R20WI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TNnHRPhhSSju6yULuo9Cm1huMgqSRmHY6mL3ZspnUu/7QgVauQlJKUsYL2KWiV1q+wecEa+W49i8faJItoNwWhPWPQBDUaNyTw8GXVJiJTbk2Cps7K/EuwUycsbGY3sZuJWKaf/ViGUwMXQ0nA1HQAMK9+2WQJCx8pAjMPL0UJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPvLLmpd; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-26ff1dc94f8so738695fac.2;
        Thu, 15 Aug 2024 11:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723746582; x=1724351382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J8sgbfdFOBV3bkG4ieD0q/AsDipcY3APfDNOmRhHFEE=;
        b=VPvLLmpdB1NfO4XB6Ygc3Vu/llvHjFbmRkkuGavbxpLdWlvORe9xNW5Rebiw2leGWW
         arlcl84TkXhcH1WtWt3KAB4siBgiaRcCKmBHOBThfBu/Io6fNdrHDNV+0MlF51NA71aD
         dXJvJb1An9BZY0O4vLJYOCZRlXNwhxg8WrcvfkLsc+Ko5NxfvKOHrcZyV26luvpUYK/q
         4zxjb5TjNi8dEPwscl7/nlkXAj5mt/EToWx+f8sQ7eBjZ6zY82UcazGO8wJPIwGG1y0H
         8p02PloPj78sbpT6j2bzN8dESKGBWtlNPdjDSn6mH+7QjcuxjWD6p5+N//0NqAF1QLgG
         +gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723746582; x=1724351382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8sgbfdFOBV3bkG4ieD0q/AsDipcY3APfDNOmRhHFEE=;
        b=vaKm5UzBTZWaOznOj/s80WuSNmExIBgYP3aevUcuAYOGOLic11J/4xsS/sEFbxIr5Z
         lRScFGAx6XUcNZX3vxMaSvNoTuEKLFrtsBDWAUIUigKTt7rp6bl0LEH+aHsXf56iUP78
         aLrDI8Albu5NImPGrrpR3/joqBYU0Bz/Vglqso7wpbg9Iu2/vR19qXTxEGSqSYCjD2dV
         U9V3wNwH9v6lHo+5VFIefKwdQb5HytzL45brIAyTV7z3EYNd9LRWZRZ8I/mLV1DOseqp
         gpMOFWcHUJDhGTi1aSQTwEjKTUiRzraqV6xNQYxLzhO8Y1kl95hs2x6jEiSEoHnfEWn5
         zSYA==
X-Forwarded-Encrypted: i=1; AJvYcCU1xzavFiwdQS6phSKX34g8pubDmsRJfhwvTNrW60YB5t1A6VWhE9bqJtBHpHnzoAoxoJbJSLGMWnz/EmFFpqzbR4UWpYeSTS4MJp46C4AqD5akzRdPfvls3X6wuQ7pu+U8ttgPcxIKhkX44E+St7IAk2ghkYxX3uMNmJ2PXWsstcHWrK9lGmGT1Z7a
X-Gm-Message-State: AOJu0YxruV+IZUTk2A7ZN4zC/79n4ULDr2Dnxz/n4S5JAxbwunpGsw11
	QL+PyAfCrx84Q/J/cD4cVRlLCAFRBifu9YgOR5bkXMMc2ntKJh5gITBLOtuP
X-Google-Smtp-Source: AGHT+IGSG5seZMR1+T+WdGh9WqTgjPnjbmJNRK41twGjcjwgdhrfvAarAHV/rx0xgm6YlFbnuXXWOQ==
X-Received: by 2002:a05:6870:d187:b0:260:fb11:3e49 with SMTP id 586e51a60fabf-2701c569751mr409173fac.45.1723746581516;
        Thu, 15 Aug 2024 11:29:41 -0700 (PDT)
Received: from tahera-OptiPlex-5000.uc.ucalgary.ca ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356c76sm1431683a12.62.2024.08.15.11.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 11:29:41 -0700 (PDT)
From: Tahera Fahimi <fahimitahera@gmail.com>
To: outreachy@lists.linux.dev
Cc: mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	jannh@google.com,
	netdev@vger.kernel.org,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: [PATCH v3 0/6] Landlock: Signal Scoping Support
Date: Thu, 15 Aug 2024 12:29:19 -0600
Message-Id: <cover.1723680305.git.fahimitahera@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds scoping mechanism for signals.
Closes: https://github.com/landlock-lsm/linux/issues/8

Problem
=======

A sandboxed process is currently not restricted from sending signals
(e.g. SIGKILL) to processes outside the sandbox since Landlock has
no restriction on signals(see more details in [1]).

A simple way to apply this restriction would be to scope signals the
same way abstract unix sockets are restricted.

[1]https://lore.kernel.org/all/20231023.ahphah4Wii4v@digikod.net/

Solution
========

To solve this issue, we extend the "scoped" field in the Landlock
ruleset attribute structure by introducing "LANDLOCK_SCOPED_SIGNAL"
field to specify that a ruleset will deny sending any signals from
within the sandbox domain to its parent(i.e. any parent sandbox or
non-sandbox processes).

Example
=======

Create a sansboxed shell and pass the character "s" to LL_SCOPED:
LL_FD_RO=/ LL_FS_RW=. LL_SCOPED="s" ./sandboxer /bin/bash
Try to send a signal(like SIGTRAP) to a process ID <PID> through:
kill -SIGTRAP <PID>
The sandboxed process should not be able to send the signal.

Previous Versions
=================
v2:https://lore.kernel.org/all/cover.1722966592.git.fahimitahera@gmail.com/
v1:https://lore.kernel.org/all/cover.1720203255.git.fahimitahera@gmail.com/

Tahera Fahimi (6):
  Landlock: Add signal control
  Landlock: Adding file_send_sigiotask signal scoping support
  selftest/Landlock: Signal restriction tests
  selftest/Landlock: pthread_kill(3) tests
  sample/Landlock: Support signal scoping restriction
  Landlock: Document LANDLOCK_SCOPED_SIGNAL

 Documentation/userspace-api/landlock.rst      |  25 +-
 include/uapi/linux/landlock.h                 |   3 +
 samples/landlock/sandboxer.c                  |  16 +-
 security/landlock/fs.c                        |  18 +
 security/landlock/fs.h                        |   6 +
 security/landlock/limits.h                    |   2 +-
 security/landlock/task.c                      |  54 +++
 .../selftests/landlock/scoped_signal_test.c   | 331 ++++++++++++++++++
 8 files changed, 443 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/scoped_signal_test.c

-- 
2.34.1


