Return-Path: <netdev+bounces-235604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17A1C3340A
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A8342808C
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D2E333738;
	Tue,  4 Nov 2025 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ghumm7Pj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2211314A62
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295953; cv=none; b=NuSRtXdH2MfBzM530QX+YhxEsJQav+YDkI33VWWqTcIxwrJ7Yb6OTxlWAy89TKnEr7ew/zTGwD7XPNoXivR6o/YiW6eCZsQdq/ZdG2fobgcnxL98iZ57AwQpAN9m5GgfcQHYXMl4rtSVcuDytQeuQfGJFxihQOc1IAstOtlLzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295953; c=relaxed/simple;
	bh=MP2KoZXX+79Mi4EOxuj0JaxBOJBdoc+sCYGsGHNCwUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=murqO0GS9nyNhdMqy75s4ZCAGePriZExhwwfUkmpRRIy9fD5MTcLbEqgSe0oK3KDt2CAp9Yt/i9ry4wOmzv/z4qoV/GhJ9n5U0doAhGxHFruHyXB/0ADUZnLP1ef6h9eREeWFJ2Crh99AVuGsGLLQgVLkzwtkXw6NrZUn0xPo9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ghumm7Pj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so5873413b3a.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 14:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295951; x=1762900751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2TtF77uA9Y6v8jmRi2a/W5oTLXZ//NRPnuqn89vDsU=;
        b=Ghumm7PjRqXPAsnxOBc2oQIiGww/tpfuDykkyRIgzJ+5rMGZX395wg4T+TEasn/6nO
         KZ1UHkU9oAci8OcLg+7qGS1hJgnmzFCSi3N4W/1Ji4P2E8SAG3KwjhgeLtGa7sMEAZiW
         fJv5x7DXAnvgAQXqtqTNfrlKjew+n6k12B7ufE4Yn1zgQypFfF+2KoQXY32G3rlx1nWL
         BGkCGQAXbBKrj4dvrH9rcwvl/vUo1U+n6D8snWKNrxrzWAPD6gEIfXGWN+ek40ITjoew
         Vd7Ghxbm2uJE0V8pOuBLxJfM3XXRsQrV2oxJK9jUF6F5FBUzEhfIRwnEcw5DbKXZmudD
         UFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295951; x=1762900751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2TtF77uA9Y6v8jmRi2a/W5oTLXZ//NRPnuqn89vDsU=;
        b=d4Mj2bNM2KOt2aF/JSd49NtvvgWc7kwyxQy01rPqj5w5SWawFbaJA15rX5u98kDQ0t
         fY/K/11F/WSnn5Z2behJsvbChUNicNbA4Z1YW5EvMAHMk838L3ECimhkPSoyy0vJQuFM
         jzYzG247AliQ3OmMW5KPl9I4CLy1VjeZM3NjLbxD0+UvkUos06OCsaxG2QfbbarGEs3t
         R/Eks1uXmF8nvGmwSK9e1+1Y9IWq6++uB2bS2qq5DDJDVCL+6j4l9bcV3n3cZWh5lFUJ
         /JRkQC7/1NXuuxqmlgtssVIS1H395pz1A/zA521AuTRB9q39TJJrcyOHKq1GpTU4OQrB
         ZH/g==
X-Forwarded-Encrypted: i=1; AJvYcCUTcDP6SV2JrW4yPrfg5MvM+gO0FoQMdnBlsP6H9b9LiXipGsfCMf2TTNbZPe4/x0dFMjt0yZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXY0UPM88N0OXOFvr7Xzn4G52KJI2uPU3eaZ/z3B7jcwfvGWD
	fVOL3mJRAYwmFqMe6KRletV+2r0Ne9BVbBhr33d6+fOyJMIDPte4Gklg
X-Gm-Gg: ASbGncv/GeXl1ppvJTE1zzW8xDQJ5dgYlfGNfzSBfvfHqaQKwMcfz4uwB3kitInU9FC
	JfFFB66B1yCYYcI6emyqTLtpc1TBbfAxtYzmHKMqW1F7R+/+yxnQLtLLRPsJ5/ZCRYxYbmZEC+O
	iAgDYECBULuO6b03ALIKVu0Jk1FLVO4tnJen6EYNPz2Y5ZeG1Tsz1y0uIG6WfMkpAso7Uh6txrh
	rfR1aDl22K+EIi2Z3311xtJ+EOb48GDRbgA2KP8dF/K8BThvT6UaS6mJezBKB+a5Zx8z5DhJoYi
	GPwWEjLjUGPKhepbTorT2jKAOZDIRT+LqwQoGRrXtG/b72zOtevcOCZ5F4YSr1Cwlt7H0pzjE4O
	50cweP/+ycEsyODRG0oacpDlNIa1geiFryVRHcrq0I9rCS2BLEFuwjFe3burvVP2+Gaf5iuuT
X-Google-Smtp-Source: AGHT+IHjLept3ve48AUPW/GiyFbQHZFSoms2OQFSZb1ZP3j5dSJ+0pBWFTSSrVMg5PH2kQRmlJsbhw==
X-Received: by 2002:a05:6a20:7483:b0:34e:63bd:81c1 with SMTP id adf61e73a8af0-34f839f5a57mr1249874637.3.1762295951213;
        Tue, 04 Nov 2025 14:39:11 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd324680asm4163732b3a.1.2025.11.04.14.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:10 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:52 -0800
Subject: [PATCH net-next v2 02/12] selftests/vsock: make
 wait_for_listener() work even if pipefail is on
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-2-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Rewrite wait_for_listener()'s pattern matching to avoid tripping the
if-condition when pipefail is on.

awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
exiting upon finding a match causes false-positives when the pipefail
option is used (grep exists, SIGPIPE emits, and awk complains with a
non-zero exit code). Instead, move all of the pattern matching into awk
so that SIGPIPE cannot happen and the correct exit code is returned.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- use awk-only tcp port lookup
- remove fixes tag because this problem is only introduced when a later
  patch enables pipefail for other reasons (not yet in tree)
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 1715594cc783..da0408ca6895 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -251,9 +251,11 @@ wait_for_listener()
 
 	# for tcp protocol additionally check the socket state
 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
+
 	for i in $(seq "${max_intervals}"); do
-		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
-		   grep -q "${pattern}"; then
+		if awk -v pattern="${pattern}" \
+			'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0} END {exit rc}' \
+			/proc/net/"${protocol}"*; then
 			break
 		fi
 		sleep "${interval}"

-- 
2.47.3


