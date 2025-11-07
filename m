Return-Path: <netdev+bounces-236564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EFAC3E041
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A433A5C3D
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7092EA177;
	Fri,  7 Nov 2025 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3lbuwiX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12431246BD8
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476593; cv=none; b=VMEIG+cIGlXp+MH+pj1LvsmuBDwFd+Qir4qk/PGotQGibG+M/tikyIQE2rdkHDG9m6rdlkeLInSqBeEKsQlFmLnfVFFQ1PvHB4H63bS55NO3v2BeGfX81XLOTwWN4Iqm7Md9gZ1scql82hCFqW4PvdUoPUlDHpQQDaIZyj2Mh8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476593; c=relaxed/simple;
	bh=579y5r6qisDyc0vXZIHMWG8pM549D8gpzJUlycZNzkY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ev8BolSux+mj7iNCjL06ZjkMeqxVPOSQgpcnfxZQigAenrVZp62md6trj3EqSqFggZJx1f/x3QiEoufK+OpQ8SbJvQ8XAFp0JddpwgmUIgqYCoMB6rGL3oMeh9Y2PQU8yGMnnWgc1e256O/sdeJNC0Lm9paqfk3Wmf+UvubyJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3lbuwiX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29555415c5fso2656355ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 16:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762476591; x=1763081391; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xcUPU8X7KL1Zl3smrmhHQZ2OCBnQgt1CnJSI/1SUSoQ=;
        b=b3lbuwiXV2SKO59OSxe4pgmw2CXcRfVDsYj0NUYp+xFaSEtiDSYYuMmnimTI62ubtg
         ABaA3+/bqEJytzEMM3XpYnX8TSbMNZFqM6E+AKa1IHEYSn15Q0xjF8z5BrELURpZMF86
         rY3N9J75x5OL5m1AplPK2gaj4e9vJGvpG2l/hLdHpycC0N1KoZKXq+Zo/5XcYFGuRui/
         yuyAXrBkEZGDVUx4axURtQaNeY1g7lKJ5IIM0RGVkOgHIC7zG5d4Ff6kexR7Bj/S80G8
         K7B/eWtgT6VmA/6wWoM7XRUqYaZOXKvLckGtKO61mruAfJQ2i1J7f+X+eIdl4TKAro+S
         U8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476591; x=1763081391;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcUPU8X7KL1Zl3smrmhHQZ2OCBnQgt1CnJSI/1SUSoQ=;
        b=BfHay4hIZ+EdRuSIebQY1iZ9YA4NTue/s+hOnIbGLTTQRQBssPS161zsplqa+lu9iM
         IGE0Lk9tdYmI6VMAxemWogG4IMkBLSkFrxkfTiz6Z+TgQuNbJjG9DLGTI8T3o7rmmtN6
         tnB+TgkE1A4fEFE+/Fu2faomi6soBrvnp4DgIm+7dUpi6l60mTwhgJVb2GMTRDsySiPL
         jvmFMJkZsosOYhzDDoxdLAhUu62ZJS7MMi9buAEQnv53Mb9buLk/jsJ1oSJ6LyqSfwmn
         xKXm1jy0HNEiSxOKcs1V+zFIUqSHSYaM3lyNwNcdcvnjxYDWUFsB/SDVPpa4pikSSJ9V
         8KsA==
X-Forwarded-Encrypted: i=1; AJvYcCWv04M/NwQSQEHeAMXKbyVholhoQP+CBoW3Y5R+9GgsGui4Wis2Ai1KhCgpczMrYgzfvseu554=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUFe7Y6XlxzEejeXJ8p9Zt7/vfyNZoObFCJuBKMpK8CPPOqTZY
	MzvLD7qPj1ZOcDckSxQiPTxrLrgJAK1ArZt2BqZeWxBRUIIoekkEYrRa4MpUaA==
X-Gm-Gg: ASbGnctpowRaSTq6n7BHM3O218Kww6HEIMiWnAYFg6IpDJvnDErfXuwfhJKnSIZsVNQ
	msV7CLYh8homlY+04DJiFlOXLyaS+eNG5ZUVdJjMI6cJUM7yr7K2RkcOKEK3qGi/93R9RutHJh2
	FDUFkc/JF0C+vfE02E1SSYt2E3fkoxG9OcFBRJqtSbQh8OGhHjZLyMGmAkDI2aZpmfI5bB4TRJv
	KmddgsnB5bPukNmqZRJCkVU5YHUEy6J3O6O9Ejjo7muwr061sIKgAajVjKV/YqC7qd0lWeKvwqJ
	3by4I+UUGuubvW/hbUVtoWQ2EOgSumAAxVpIQ2AFE9jrC2g2QrxtO9DttjGWzg8suvfEzgkoky3
	+7rdkhKIySkXSXKIztb1fGY+1w1xewPI8Mr3SQ625O4XOS4q7pPsHhzZllRj4QodlyL/FmmZP/A
	==
X-Google-Smtp-Source: AGHT+IGVbNnnCv/JKP0L4AJIgAT7XYbbLVjx7tiV6GHUi/PF7nRC7D/K/BXQFE6YswbPc0qA9n+hkw==
X-Received: by 2002:a17:902:d4c1:b0:290:2a14:2ed5 with SMTP id d9443c01a7336-297c03a5f63mr17937825ad.4.1762476591127;
        Thu, 06 Nov 2025 16:49:51 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c8f07csm42074815ad.78.2025.11.06.16.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:49:50 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v3 00/11] selftests/vsock: refactor and improve
 vmtest infrastructure
Date: Thu, 06 Nov 2025 16:49:44 -0800
Message-Id: <20251106-vsock-selftests-fixes-and-improvements-v3-0-519372e8a07b@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAChCDWkC/52OwWrDMBQEf0W8s1+RZCcmPuU/Sg62tWpEYsnoC
 ZES/O8hptBr6XmHmX2SIAcIDepJGTVISJEG1TaK5usYv8DB0aDIansw2hqukuYbC+6+QIqwDw8
 Ij9FxWNacKhbEIqwPfddp7yfrR2oUrRk7SYP6pIjCEY9Cl0bRNUhJ+Xt/UM2+/8TsX2PVsOYOp
 771zs6YzHlBGT/mtLzT/7LBYTL9yR27Y/tru2zb9gLV0w7oMwEAAA==
X-Change-ID: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3

Hey all,

This patch series refactors the vsock selftest VM infrastructure to
improve test run times, improve logging, and prepare for future tests
which make heavy usage of these refactored functions and have new
requirements such as simultaneous QEMU processes.

These patches were broken off from this prior series:
https://lore.kernel.org/all/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com/

To: Stefano Garzarella <sgarzare@redhat.com>
To: Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Changes in v3:
- see per-patch changes

Changes in v2:
- remove "Fixes" for some patches because they do not fix bugs in
  kselftest runs (some fix bugs only when using bash args that kselftest
  does not use or otherwise prepare functions for new usage)
- broke out one fixes patch for "net"
- per-patch changes
- add patch for shellcheck declaration to disable false positives
- Link to v1: https://lore.kernel.org/r/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com

---
Bobby Eshleman (11):
      selftests/vsock: improve logging in vmtest.sh
      selftests/vsock: make wait_for_listener() work even if pipefail is on
      selftests/vsock: reuse logic for vsock_test through wrapper functions
      selftests/vsock: avoid multi-VM pidfile collisions with QEMU
      selftests/vsock: do not unconditionally die if qemu fails
      selftests/vsock: speed up tests by reducing the QEMU pidfile timeout
      selftests/vsock: add check_result() for pass/fail counting
      selftests/vsock: add BUILD=0 definition
      selftests/vsock: add 1.37 to tested virtme-ng versions
      selftests/vsock: add vsock_loopback module loading
      selftests/vsock: disable shellcheck SC2317 and SC2119

 tools/testing/selftests/vsock/vmtest.sh | 355 ++++++++++++++++++++++----------
 1 file changed, 243 insertions(+), 112 deletions(-)
---
base-commit: 8a25a2e34157d882032112e4194ccdfb29c499e8
change-id: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


