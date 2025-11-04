Return-Path: <netdev+bounces-235602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A28FC333F9
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8AB118C4661
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9DE3148D3;
	Tue,  4 Nov 2025 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYS5PxKW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0BE2D0638
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295951; cv=none; b=CbzcmzMsqTDyFMKRe/+3jaO2Vzj91tE4J54eEF+UBdvj6VHS0mV81P3DlUis+As/QZ56xqdReeYXySYTY/eo15eNDTns1CXTi3Kir5q5X+XJ0FCO47dgyHwhlVVnksQMzGroN39RkJFYtQfH8SA05JhId3QcpUTIwbz8wPkzRE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295951; c=relaxed/simple;
	bh=ZR9/j052YDNAkFJ3hHReoZQ9gREe6fypHqzQIW+W8y4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fVhoLe8IG6fMa42H3QlIHH4n4lLw0YjdDiRAiZd8GRcMHXLpgVqX+lhvQEFcCkjhily3bWKgAUgicv0qq44XcqrPHpNS2kwsj6Wb9EAoQ/zHQT/XxSmQN6+9G+936GA/ZgIznNXVbJN/Z3OEKkHubIv1sJa/O+3WyH58SABUyjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYS5PxKW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2953e415b27so39533585ad.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 14:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295949; x=1762900749; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k7OH/VaXbxgdDQ3VEdnOK5yc54+Zfxu1IfTiRbOYzNo=;
        b=jYS5PxKWCGC96YVaoEPvU/GV3r+WFCWDCkjEsppc2/g9tcCb8RJKJUO/Ol7iCNIiNU
         AS0W/WifMk0vbSaXxR2AhrAyf6G1X355l+R/mRId9n5ZviHQlhji6s8BQtC7TYC36hOh
         SDi7f2iwH1uFJzhC+Cj1QVs8d5AFlbxF41RUqTw+4SQyOW+ll76vVxGVuU7lkztr8l2v
         GpgQRZoxWFtDRlg/nAHdLt1ydlkIO3aDAnFRHemGQnMD0YFkAxGodWtRUQdtzwZ3hmMv
         hUERZ2/yXIgRMmlfaXAB9kkz/9amrb8cC4OO55rrn0g1uyy0HKC11wyVKfxIeqpYh7Dd
         CJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295949; x=1762900749;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7OH/VaXbxgdDQ3VEdnOK5yc54+Zfxu1IfTiRbOYzNo=;
        b=Oyx7YgQ6DPXbrIWsVQFA5Ooc+j2K0KK9IQ8VtZSV7itjcCBSFjtty0tioGKVbOpkmc
         /UZagdPFmZaefLnzhILXEdF+iLGVUrIY6DcowrdXcJUUeSpDFku0QWgEMKJG8qd6cyrw
         eXXNU866Ub+b0VvopD4hl2sC3rCzAWzPVix2Ho3cpb9jj7GsA5jz5wG4bY0FAaYn/flv
         SSaI8nW8LXaB6iL3fx6CHATL1mHwA53Xcm+oTQ/+NcYh6iVWy1u1MzqaNYd7ohRZX67K
         JjsZz73MtjZ4S+O4ulLozJNDOWgbTvyX4J03CJ8wZJQrAujLoQQ523Kz4kQmEVSkTTNe
         uelQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTrGKF9pLsTvYTWQn1f5PGn+CxZOpHhz5twwbpFdWXlU0dzIDE2QwOsbGrR/jITVYKXfalzhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxso+12/c+ajZyHYS68VO4v/BhAjbE3j+Th+fHuzkcKEA+ZfkHM
	BrUHD6Ga/++BZw+MF/b9wTwRALEw0Q+yAfMl9kAJJlpByCg1wcKlNCRf
X-Gm-Gg: ASbGncvFKIEMsJsG5Xx4XIsATEaOZ4grYf4/savEop24MAqel9Y6ds/8YRK8qcinQd7
	XQlS4Y+Rxlf8Nw4eMZ5LpZvwKuMJabxz2n6lwbw7hJq9O8YNaxwin/f794WBOebczU2+49MYRMX
	39/G3JJN/gj4BWhUEqEga6Cg70AtcLeIKlcnztQXbRvfl0N8a4ZhGIe7J1fsVJZBH5fwxDX8PkI
	5j2kfT7w8IhsGJ5Sy03wvXEbxOPG0K81y+0AtunzbklNJhAx4gVCt7b4SKCF8SyWFYp9paYICf7
	uTCGkztkmBiKiG3z1+GkwwhjKi2IMTL5zTBUqoYv9ugPs2axUYn/DNuINx4DLMTAde20O9hTVua
	yhL+R4/OqYJu+wHts4pz9Fmx6pUlOQyYGhQY7MRADN9l7EnHDrE2/6hvdE1i+vgqQ96FlXZVFFg
	==
X-Google-Smtp-Source: AGHT+IEf8Nrub88wm5PzVqxHEp7+fQp/JKH+iJ9scU23Jg6FQodVkNNRoH/TfsmpGm25Zf50pWGuAA==
X-Received: by 2002:a17:902:dac2:b0:272:dee1:c133 with SMTP id d9443c01a7336-2962adb20f8mr14797755ad.22.1762295949382;
        Tue, 04 Nov 2025 14:39:09 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5d174sm39069295ad.77.2025.11.04.14.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:09 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v2 00/12] selftests/vsock: refactor and improve
 vmtest infrastructure
Date: Tue, 04 Nov 2025 14:38:50 -0800
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHqACmkC/52OywrCMBBFf6Vk7UiSvtCV/yFdpM3EBm1SMiFUS
 v/dWAS34vLOvZwzKyMMFomdi5UFTJasdznIQ8GGUbkbgtU5M8llLbgUkMgPdyB8mIgUCYxdkEA
 5DXaag084octnXrdVxY3ppVEsw+aA+zKzrsxhBIdLZF1uRkvRh+f+QRJ7/5HJX2VJAIcKT21pt
 BywF5cJozoOfnqr/6Khzpj2pJuqKb+0btu2F09HTHczAQAA
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

Hey all,

This patch series refactors the vsock selftest VM infrastructure to
improve test run times, improve logging, and prepare for future tests
which make heavy usage of these refactored functions and have new
requirements such as simultaneous QEMU processes.

These patches were broken off from this prior series:
https://lore.kernel.org/all/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com/

---
Changes in v2:
- remove "Fixes" for some patches because they do not fix bugs in
  kselftest runs (some fix bugs only when using bash args that kselftest
  does not use or otherwise prepare functions for new usage)
- broke out one fixes patch for "net"
- per-patch changes
- add patch for shellcheck declaration to disable false positives
- Link to v1: https://lore.kernel.org/r/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com

---
Bobby Eshleman (12):
      selftests/vsock: improve logging in vmtest.sh
      selftests/vsock: make wait_for_listener() work even if pipefail is on
      selftests/vsock: reuse logic for vsock_test through wrapper functions
      selftests/vsock: avoid multi-VM pidfile collisions with QEMU
      selftests/vsock: do not unconditionally die if qemu fails
      selftests/vsock: speed up tests by reducing the QEMU pidfile timeout
      selftests/vsock: add check_result() for pass/fail counting
      selftests/vsock: identify and execute tests that can re-use VM
      selftests/vsock: add BUILD=0 definition
      selftests/vsock: add 1.37 to tested virtme-ng versions
      selftests/vsock: add vsock_loopback module loading
      selftests/vsock: disable shellcheck SC2317 and SC2119

 tools/testing/selftests/vsock/vmtest.sh | 332 +++++++++++++++++++++-----------
 1 file changed, 216 insertions(+), 116 deletions(-)
---
base-commit: 255d75ef029f33f75fcf5015052b7302486f7ad2
change-id: 20251021-vsock-selftests-fixes-and-improvements-057440ffb2fa

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


