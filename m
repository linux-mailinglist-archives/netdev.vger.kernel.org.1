Return-Path: <netdev+bounces-212622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 369A6B217AF
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486872A5829
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 21:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8662827D771;
	Mon, 11 Aug 2025 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RnptrGuf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CCD311C2E
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949278; cv=none; b=D0h6tuFn1ubG9QVukA+FN8XDCWDzIrFNaP3mg+lwuqzkbf+ZHm888Pi0jvK0kVeXgE/+X9cH2tS8UEhzplwQoOwh/PorHxn+k1wG2k3E09JlYsbtyCFXnS6N+pS0Wc/8Y9zzmclfHCelx3s3Ie1W2+U8JHh/18SdJhHtD1KWv4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949278; c=relaxed/simple;
	bh=LUzy4F1jxgEP/hAesJlajksiRWctSFHfYK3H2fb22Ic=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EilmulgouXBQBKR+NQNM+7bEp9rW1KIObUdOqUAFwXUbOtSaM7e7TJMYru/pv0B1y3W1zmn5cjnsGrgj+Z9AQgowEnA/dV9DXDAFAZRx5b29C/IJIZa9AZqjEHUtavWztNtsnC8j5ZGDUGHP661JkQ1Xc3uzAEfTFqR12RgYL5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RnptrGuf; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76c19d1e510so4480485b3a.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 14:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754949275; x=1755554075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WgCMc4+gCjEnqzUP9a3ExlC4BT4VxxAl6FN8S2anLIA=;
        b=RnptrGufn3VC8z70YX7U7/fGN1C1WHL9BLF5eIsdd5g4655hFNb1LwgYyLrYlC7W86
         Sc/a+bUE7EiX2646XudWZGqt19kh8vsg+8gsBsewshNIcF46ssv43BWX6GjVCHP8lqnI
         kRzVf9i8G/1UbEqjAU2Xo4Cdfg1HXL8P75Ud3UkZ/FOJCalk1mRK/V9/oq48XaAmtIBL
         hzeH5IyA45OntSEXQV+7LUbSVX/qUbU/ommoKvY4M4HHnIJBgZuJyenTLBTwpAMT48FA
         D/mElMn/WBTSxC8PPSvRUyOvyIAaN3C6QlodtGNH5w7jLusN2s3uA6zFWQQbA1ulSW/R
         pE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949275; x=1755554075;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgCMc4+gCjEnqzUP9a3ExlC4BT4VxxAl6FN8S2anLIA=;
        b=ViO0vPhtF4YP2KcKJVC/gye8k6Ent8ENgPxXN2SH22hf23j0K6Qr3UCLd+2PqgNZrF
         R/HuS5aAm8Dh5NvNDIm7h8m/FEAbPSz2/eJDXNGnxAyRZBWT0cWcJkgiVhnQZRC9NkJv
         S4jsOhGMiKpVQ0MF2o85Lx8CWHU/dSIPyH4G/zJ0SS27TyHc8i1+zbkdvjuEruYCn8Fg
         8m7MOvzNgbP/YeRVd5KMuZrkxJhnZQogztRmf/Z2JdDSrKL4FffYaMdmPdhpMhhAgz4K
         eAUL3F2yocNM4kJm2hB3EIjOi2xEM/qnHvE9h3CYPP4tM89kU8rnaQp3tIkd0hwWj/gl
         0+Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVuDKV9NpwwaWwhlosUf4rX93DmNk8bgH/tovlc1CQOUb7m+JOAZfDPhTY49DH1alXpr/3Fgzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq1d9VFxdsKx9OB1N3egM6SBFZZxDRGz+fERjojvccan/GdlSs
	MNqQax6gutj5O9G33k+HzTuAQ0cUefS65JYxsHmNpQ+o1gG6KnW3UY4LIF4FjAU8LtT29qctKF6
	YabC+dA==
X-Google-Smtp-Source: AGHT+IFE1+tKLihfVZBQD1ogfm+0jADoMMSMP/mvWP2guq5TJjMt3J8BYNgW1SjUZDlgV+DygWHRdn0/M9M=
X-Received: from pfic9.prod.google.com ([2002:a62:e809:0:b0:767:efa:8329])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244a:b0:233:927b:3ffa
 with SMTP id adf61e73a8af0-2409a8b1f81mr1346554637.12.1754949275356; Mon, 11
 Aug 2025 14:54:35 -0700 (PDT)
Date: Mon, 11 Aug 2025 21:53:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811215432.3379570-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/4] selftest: af_unix: Enable -Wall and -Wflex-array-member-not-at-end.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series fix 4 warnings caught by -Wall and
-Wflex-array-member-not-at-end.


Kuniyuki Iwashima (4):
  selftest: af_unix: Add -Wall and -Wflex-array-member-not-at-end.
  selftest: af_unix: Silence -Wflex-array-member-not-at-end warning for
    scm_inq.c.
  selftest: af_unix: Silence -Wflex-array-member-not-at-end warning for
    scm_rights.c.
  selftest: af_unix: Silence -Wall warning for scm_pid.c.

 tools/testing/selftests/net/af_unix/Makefile  |  2 +-
 tools/testing/selftests/net/af_unix/scm_inq.c | 26 ++++++++---------
 .../testing/selftests/net/af_unix/scm_pidfd.c |  2 --
 .../selftests/net/af_unix/scm_rights.c        | 28 +++++++++----------
 4 files changed, 26 insertions(+), 32 deletions(-)

-- 
2.51.0.rc0.155.g4a0f42376b-goog


