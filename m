Return-Path: <netdev+bounces-192314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7758ABF78E
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 16:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB125022CC
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912A919F101;
	Wed, 21 May 2025 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze9geiXd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80F166F0C;
	Wed, 21 May 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836813; cv=none; b=I6Z/px4SXmDVhCsslhIVXanurwLa/YD//Ll5Q6EjFgl6a1wna1LQfztAx8Il2O58fQCW5irrsb9LvnoXxwh4/1cr1MeePZmeMb8Jvn1jgXN49xEhntnTEA5/vWK2xCbd2APSqKTqd8aaCY6kPAxALDq0BmravelhOKr2YulFhJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836813; c=relaxed/simple;
	bh=oaxMgYhPNZMs2/XTZyPamnePQQnQGkysxNcqm+SqnTk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SdKFeBvvku0K2AzqHbmJHI9NsFIMbvSrCcN1GWGqE4rHzJPQjDbOtUy94FHKjXH+0MfPL1dKog4xWi0PHnPi6LsBaFs9jNwTpp9pq2927okLTW+hdhVsYwddsNnRoHCOC6h6JtVA/h9OJ8LSJ9o3oLOs8n388U6vollv9SFxCyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze9geiXd; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-327ff195303so57591831fa.1;
        Wed, 21 May 2025 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747836810; x=1748441610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oaxMgYhPNZMs2/XTZyPamnePQQnQGkysxNcqm+SqnTk=;
        b=Ze9geiXdRASSnANYhg1tci2KKRTMqWuge+I2lMYjhN87Tu13uKq0uXM4TePEKYMgRC
         RInM7hKWRHn8oJIlKblE+UB2oYa+g8/m8zQiJc/mTgfBMzSpgsI/4VHTJl1GdiUsCsk0
         A+PVnfeiRGaewBuLJK9IEZ8txjmpnQB9EjWjzC9Qa+uBurt2hL4SRjQB5KbB2DQZVF/B
         NwIOwu/Y3Vy8u2gflbmh4ffDP64YiFljOG01WxbdbBhjuCx3Njx/JOLcIsx7lO2z2OwN
         xYjhzS6+XJdgjOu9YsbFE3tWe3u0F8Ns+oau3BYLJjFcjoji19j/ZRdlm1msEzkSrkfE
         HFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747836810; x=1748441610;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oaxMgYhPNZMs2/XTZyPamnePQQnQGkysxNcqm+SqnTk=;
        b=oDnAh+96WFTFJKiDc0QN4flqyDjriOnd5uSgr+tsxfsHmoYG0NmLcJTD+WWI1Q6hp5
         GNnTEnysUbUM1m2uWX+QeyLtZUmr2Kb1JxLFPF611Sxnzua3QJDEtF4lwSeRF2CVn/2i
         PUD0GIoPEXsiD7T0gLY4d7ryLILLvJ3CePmZlKVLr0zEY7XzQgloPw8TM3XP+guuEXJH
         4aU4PSi6MFsB+5/48ZW/kJcivcgJrTAWiy7Xwx8khGaHglas9MkThfqPekTtdOROWb7+
         eVSfaUl2pDpmq71ba/tSBbauiCZLlBAT/15a1ansbcCE3M+FHR6QUaULdM0b5c9YHj/R
         IAKw==
X-Forwarded-Encrypted: i=1; AJvYcCUbmKHbKgPjvXTW0oK6lmhLN84LdB8kmLlceyXPQVfCtbA/QZTPyDq935UIu48oHiXHsl/HDZNypLoVWrI=@vger.kernel.org, AJvYcCXep4fRzwP31rRD6po9kbxTnE6dNl1rFV/59toHyBp+18X4GfdjykiktRFT1ZV4x3Mx8i4uU8HB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx37RJ8jb5M9alsCdgmE5E2nzQ9ZZXWTd6vDbyIXkPUMiQjjoTc
	Zx7KKIL4spFL1ockpJUlLfVjkTfymiGN+RrxgrRJ7HnbYSpvFCHKfU/WMQ4xQGESSsWoT6V5jOv
	tFWq+qp3zQfcF8KestAXMRN/uTaxRsbZjcJJDBA==
X-Gm-Gg: ASbGncslX8H4CxzZWtYabEWrYTyboGvgGKH1V+7hbmTBSF/ltVlC2GhC0QtHO1oYoNk
	Zqr/N556owbKQiy2seKQb4/fZEqNnm9lmccCHP/3+oJiRq706hNRUmK0/4CdrKPhU5H3ZGX0yRj
	LjpE0gexroeeBkHADQQXcqWAYZugoApqAVaogJF0RxuX0Zqjz972qX3oQ8uq8OETQg
X-Google-Smtp-Source: AGHT+IEOaJbZM++Q0KRojp+3Aw+w6HCigFRyvGnKt7bSYukI4l+/DOz+RnKW0io0hgTr694UyJcCFQl5DVWoxiXsTNM=
X-Received: by 2002:a2e:a590:0:b0:309:bc3:3a71 with SMTP id
 38308e7fff4ca-32807791587mr73247681fa.31.1747836809372; Wed, 21 May 2025
 07:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John <john.cs.hey@gmail.com>
Date: Wed, 21 May 2025 22:13:15 +0800
X-Gm-Features: AX0GCFtOanhlZwGarVR69NoPJG3inDQ0psVlqb1GB6FHnNhWwdUWQX8s8vwof3g
Message-ID: <CAP=Rh=N4QcPLWQ2dqUHmKYeEhig3Cbi-3N8Q4-7qGT00htXrVw@mail.gmail.com>
Subject: [Bug] "WARNING in should_fail_ex" in Linux kernel v6.14
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.14.

Git Commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557 (tag: v6.14)

Bug Location: net/ipv4/ipmr.c:440 ipmr_free_table net/ipv4/ipmr.c:440

Bug report: https://pastebin.com/xkfF5DBt

Complete log: https://pastebin.com/uCfqY4D8

Entire kernel config: https://pastebin.com/MRWGr3nv

Root Cause Analysis:
The kernel warning is triggered in ipmr_free_table() at
net/ipv4/ipmr.c:440, where the multicast routing table (mr_table) is
being freed during network namespace exit (ipmr_rules_exit).
The warning indicates that the multicast forwarding cache count
(mfc_cache_cnt) is non-zero, implying that resources were not
correctly cleaned up prior to netns teardown.
This suggests a possible bug in reference counting or teardown logic
of the IPv4 multicast routing infrastructure.
Additionally, the environment is running with fail_usercopy fault
injection enabled, which deliberately triggers copy-from-user failures
to test kernel error paths.
While these failures are expected, they may interact with multicast
socket setup/teardown paths, exacerbating latent issues.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
John

