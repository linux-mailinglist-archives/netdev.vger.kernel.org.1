Return-Path: <netdev+bounces-190703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E99AB8511
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC667A4D7A
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E444722370D;
	Thu, 15 May 2025 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3J727OK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570A9193402;
	Thu, 15 May 2025 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309079; cv=none; b=b4D7m92u5N5PbRVD7MKcfwQRyGt42A5KKiJ2hpEabjOKWOd8zQK8GElvQXDL1qc/FE9f3/HYQgtmgBVKq9OjBq+0xknlTI9rsafKb6aE1TIEPB6FhhUF4sNR42KktvkKv/t084dDwEF0NbNcl6z1DfgyzSEQJzSrqJzvZMFo4Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309079; c=relaxed/simple;
	bh=iQKtjTGdWhffjo3mtXYfuMteU+Sw4DI+VNBf1I2a2sM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XG2ppfRUeoMSwggWh5YSOoGdhzmSC4ypRnkFNkDbZAub4mVGsVyq9BEPG85l9jyqp6p9oRjT17LXBzjSVHljYRGDzxaxHFY+Xih4qOah6+U1pSusemh1m5eyk4o+RZfRNkemL2y0D2X1d7ClPBSfMOi2q1YyjdlaYBVggrOGQVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3J727OK; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e732386e4b7so923340276.1;
        Thu, 15 May 2025 04:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747309076; x=1747913876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iQKtjTGdWhffjo3mtXYfuMteU+Sw4DI+VNBf1I2a2sM=;
        b=G3J727OKE/t/cyhjNJz+gMFsMLVFNhRKZsNuvrl07Uois8MRr5mKeR8xr2yvtq0g6N
         t2bKJ2MY4atE7azkCHf5h0VjYelerllduNMSVG6XGK/mae1+Yj/YCVv12wkEGqmO35jn
         fUncVr8F+uK3pwWi27gRdQeGH3kOf+dDQXFhb4ckwPphCeIQRC2Oa0a/FQxIL7ooKMUg
         LGPDeRXyPaja5k9+sauphwQCdzeXOQKP7uAFkKJBod2KenIx6EWD6/qZwpROI0saYV58
         B9hpmV258hXBBMyWP+320hyBWG48Ldeinr+rU9lermJ4PTG3GaTHNxLKkJcdofQa0Ui+
         bmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747309076; x=1747913876;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQKtjTGdWhffjo3mtXYfuMteU+Sw4DI+VNBf1I2a2sM=;
        b=a8UB5OaKdac+1ARssiT/sO1HHKkoP/t5VjOqKHIWIDmLJpCoyoXHkpABeY+epMGRO8
         yPA7mXLidcTkuBLl4jvBBGdD9ICR3+K5gWPExCHFy0n6ZDwo+T4zy6arq7JrFd4h1bBD
         vVZV+ZAuyAB0JKUKoRpQswrh8LCzsp8iN8NqZsgK2hr1exYswdD1FpdgWELL9bFOly0k
         i+ko8Z4Orztgs5EQ2BicQDrkMd8OIQQpLDuz+buRRweXUiGmPR6FbeOxg8w4HfGkrwn3
         Kt4mRZCU+cuBg+Vzp/nOR13W7aErJuZ1b8GI1sOlFhqOgZWxAmP36Jwo8a4fMhqwkRi9
         royw==
X-Forwarded-Encrypted: i=1; AJvYcCWXqZjOFevqMR/HvXHzGu8mXhSK3BuLGJ7Oblw5JTkVcnh45xh+UwyboQzG0irgGOMzpf/S8nfxb7BRG+g=@vger.kernel.org, AJvYcCXh5BxUd+E3VOtkhqocy1kNvUM+0Ce0r09qpcCxpk86uKb0szrOE2NUi4sLyKL5MfiRmGgwuaSh@vger.kernel.org
X-Gm-Message-State: AOJu0YyNuKgqIwAp4/uMeXV2MdEPuffsThBwcHelBw6blTaGLg4LWIT7
	u+SDEIbpC4cMRobXafTW/IkJhTmMozZRuux/ZKx22bYguxKQAmV0eqK+q6O83fNf6czZ1+RN7Mi
	VzQ3l8cJ4QtgkctYTRvZYSTUAW3EyDJvrRVHhnQ==
X-Gm-Gg: ASbGncsD6PHTWYkZJ7JQilyUKoSeiD0/tICl0brVZDPukq7y+BU1/IL5MIBObwZiSyi
	74pjCooFZcToktMfHTFunn+3X7jMmSn4emfIBiliX2TuGrPV1uK/AmsNMcViOQ4DfO4lYPM6E+a
	8CcNrQ7IBCtTEnBxHBANTKDhi4328JmDPH+MQ=
X-Google-Smtp-Source: AGHT+IEX+uzW440MbnnG3rppHAnP7P4fuO2Qf0Q3QWah94LNZ9M7nuQjlLm7CC2O+Eg0X2sfydYhtCZ7h8kyxY2U6pE=
X-Received: by 2002:a05:6902:1b04:b0:e76:d5bf:4e1b with SMTP id
 3f1490d57ef6-e7b542fc4b5mr2690950276.19.1747309065753; Thu, 15 May 2025
 04:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Guoyu Yin <y04609127@gmail.com>
Date: Thu, 15 May 2025 19:37:35 +0800
X-Gm-Features: AX0GCFvEyUmHr1Xnj9kemy9i27JoAJTteQ_pqaNcNOk8epFfS-PQ1hLBjLRMZk4
Message-ID: <CAJNGr6tmGa7_tq8+zDqQx1=8u6G+VtHPqSg1mRYqTDqT986buQ@mail.gmail.com>
Subject: [BUG] WARNING in ipmr_rules_exit
To: davem@davemloft.net
Cc: dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I discovered a kernel crash using the Syzkaller framework, described
as "WARNING in ipmr_rules_exit." This issue occurs in the
ipmr_free_table function at net/ipv4/ipmr.c:440, specifically when
ipmr_rules_exit calls ipmr_free_table, triggering the
WARN_ON_ONCE(!ipmr_can_free_table(net)); warning.

From the call stack, this warning is triggered during the exit of a
network namespace, specifically in ipmr_net_exit_batch when calling
ipmr_rules_exit. The warning indicates that ipmr_can_free_table
returned false, suggesting that the mrt table may still have active
data structures when attempting to free it.

Possible causes include:

1. Incomplete cleanup: The mroute_clean_tables function may not have
fully cleaned up all data structures in the mrt table.

2. Race conditions: Concurrent access or modification of the mrt table
by other threads or processes during cleanup.

3. Reference count errors: Some data structures in the mrt table may
not have their reference counts properly decremented to zero.

Suggested fixes:

1. Add proper reference counting for mr_table to prevent premature freeing

2. Enhance ipmr_can_free_table() checks to verify complete entry cleanup

3. Implement synchronization between multicast route deletion and
namespace teardown

This can be reproduced on:

HEAD commit:

38fec10eb60d687e30c8c6b5420d86e8149f7557

report: https://pastebin.com/raw/seSjBgav

console output : https://pastebin.com/eD6Kbw39

kernel config : https://pastebin.com/raw/u0Efyj5P

C reproducer : https://pastebin.com/raw/EanQb7cs

