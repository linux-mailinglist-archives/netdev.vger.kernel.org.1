Return-Path: <netdev+bounces-212623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7BAB217B1
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92DF919061BE
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 21:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4129C2E3B14;
	Mon, 11 Aug 2025 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahM98o0Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F272DBF69
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 21:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949280; cv=none; b=UO1RRbsJ13R73JuE5ZwZccYvs1ILA2+AwjQEuyV33CgpEVfgf4+Ev4HaAEXoa7jZvKOlzc2dEDs5/JXCOnXbfLsynhF3I28GHtvF9zHswnHkKryJY3f+CJtSTGP8hzNjjPMVshn8XUtnPFZMRIYbnkHouxEhS80Y2HEjBkJFkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949280; c=relaxed/simple;
	bh=8ApyO04k7IbHnnk4PYaM+2Tq73cQwY31cxlpbfkYseg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GX5oHfUNmza98cyNdKKSYYmjC9/tN2nvScz74YYDTZij0wA/eZcW2gNM7b6/qthK/bhPkBYINMOqK5QjBYlg853Pt1BZnnlALHhsfzSTvzf+iuhht+60T6O4ISOn8nEZ0v2+G2Uy0CSXtMveKmzKjcuspYTFIWbKRrIbvMnApiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ahM98o0Q; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bcd829ff1so4538451b3a.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 14:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754949277; x=1755554077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yF1g3oXikYUTce3LYILKIzoofLdD51XNE38ZPkD8kTg=;
        b=ahM98o0Q1qFSpGb/M5VRfl0+I5Hcu9Q1uKkaRnQ6q6RFGsxZiqemq6euMWLmw7Rccc
         Ov5R9WFn9DqO2qJOfgvqBEc+ZFD5gtMMxsxeHg70qmO92gtjFsj60mJp3ZAdIiV1Asg2
         T4dCFlJgsIugAJc1epxd0TTzhMQ/kyFVRBNBWCW1E5tOjbxPt+K9JMdGSwJhGd0NtiZc
         6aFhO3RPF7hWo0enf0tUUn7kjLsV1MNjJXziYRh2X8MUcYJwn/vQqkPnoHCvFqxxXQYY
         b0dofpUY8Y7nkAA+vvVDqIu/erXddzeC+eQgpNCyBkxp+zOJhgRiBGAnJhYy+29/iuXR
         Hwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949277; x=1755554077;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yF1g3oXikYUTce3LYILKIzoofLdD51XNE38ZPkD8kTg=;
        b=kRMvWWO1yPiSmFziljyKXtccnGh7nYCTihb2MDs+wq4x50reQ6IiiQ3aRtvFx5rLkX
         xaLwkR7HET0Cl+BxZhuHoCZxIeYb5jG90j5BpE/SUijXX3iF5+dK/KHvK23FhD5cP8Zc
         nISK55+hSETGmWw4HpDNblUZcAYXb1PQu1fkl9lC/IYLF9Wdf1Ne+60qEGlfBXZB9E/M
         8lCatnp0uMs5IUlB0U8Re3nzxauFRLNaHO1WuSacy+uZcFAWLlf/dxnFSQaiBLaJ4S2q
         P2nUHhAGcRPVl0muSfEJyU2VXbv5zkwuyJQN12yCIpqO9m5D0Z/kFIliL10efOOx8sRs
         G9YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLk8FpFFNtnBrp9xoaO2T6UmsogSYwfALSLsL5WmwSTgoz0Q5wVJw3H/lZKqYtjC6vrjBoNDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmRiAEqRNWSQDNnoGjg8sVoR22a6LC1ZNYUHnB3BQc+oDWMv4t
	pSNJKnq0hfgS9l9zF/Gv1+E/bxSNDGXN4N3yODJHm95HAWyiE5NEZ0FMOFkUKS5KPhT90hX8vCk
	VijmMMg==
X-Google-Smtp-Source: AGHT+IH3ISCZjCgVhC1295aCfBs1szwnwZA3j54T0ipU0zrltsXoCNT4sirsHC9xa7mN/gWoZcktTpV0Ayk=
X-Received: from pfbbd33.prod.google.com ([2002:a05:6a00:27a1:b0:76e:118d:fb38])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3c8f:b0:240:195a:8324
 with SMTP id adf61e73a8af0-24055015142mr22017659637.2.1754949276854; Mon, 11
 Aug 2025 14:54:36 -0700 (PDT)
Date: Mon, 11 Aug 2025 21:53:04 +0000
In-Reply-To: <20250811215432.3379570-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811215432.3379570-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811215432.3379570-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/4] selftest: af_unix: Add -Wall and
 -Wflex-array-member-not-at-end to CFLAGS.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-Wall and -Wflex-array-member-not-at-end caught some warnings that
will be fixed in later patches.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/af_unix/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index a4b61c6d0290..0a20c98bbcfd 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -1,4 +1,4 @@
-CFLAGS += $(KHDR_INCLUDES)
+CFLAGS += $(KHDR_INCLUDES) -Wall -Wflex-array-member-not-at-end
 TEST_GEN_PROGS := diag_uid msg_oob scm_inq scm_pidfd scm_rights unix_connect
 
 include ../../lib.mk
-- 
2.51.0.rc0.155.g4a0f42376b-goog


