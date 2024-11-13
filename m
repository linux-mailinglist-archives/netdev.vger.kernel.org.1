Return-Path: <netdev+bounces-144352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6156E9C6C61
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213C728BCB8
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CE71FB8AB;
	Wed, 13 Nov 2024 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="aR57yyCW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699111FB89B
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492462; cv=none; b=d/d4Q47bDw0b/SDnHEYMMozTGjSc0nL5ahpdi1vxgurE9ENgu2fpBriDtbRD/J8JCdZN3H8Gtyv4WMKUVAbErh0ESpJ2g/9smk0QBgES62pLDHkkfcV2DleSLXotT0TVgW6tR+Hobk17Rz5mey/JqSqnCRPFMfVCjpMvcVh5S7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492462; c=relaxed/simple;
	bh=4v0pqQyTH7t8NVaat+tToZL3uBhcP2zFoq2e7M8SqUg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=snFFVV9yb6/S7TT3ljlxOouy8TOAW6FTlxUDuxE/pjQON+uiXoe4pupzjhU79ooTN6zYA0ujAyxJ/mye47OV8FrVq0pbGnkckCGiemN6gpO4Fv4TH5k+0xcU7ZlN2WVy74T0dXXa3NWiU/H3jAG+vCl5e3kGPAE/xU9gZuG9Hk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aR57yyCW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9acafdb745so122645066b.0
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 02:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1731492459; x=1732097259; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3421nGyxycdlxBS3Se4XjxKREs6nxiGlxIA6uMBT3Js=;
        b=aR57yyCWQTN5CCNAAq9KHHKyGmhXQjMTvRoZxvfJu7PK8EadL9JiOnjDjgkGVVqLZw
         6ROZAIHbsArpA5jell38oTCRxhFHSG+iSpwWco/RO15rjQ7U2G5pWMuwRU7ZLabw1Kcv
         FF7hytauPEJ8UtUtUCraT94LtMF5Z/WmXzNVXTBTh1WNew3QgbfL5sSjpBedA7fsOD9l
         7onjfDZ+K6uhthp1+DlSiXF4JLoUN2r32m5p/JSsVgcNQzOj3BRA7QkwXWJrXqb3tNfX
         Up0SGne+Xymd/TLKomRsPy8b4EX59vgLvXJDoIn8V7k2TJM6He3qPa0IOQmZyMv78oax
         vA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731492459; x=1732097259;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3421nGyxycdlxBS3Se4XjxKREs6nxiGlxIA6uMBT3Js=;
        b=KLpXKnVNMXtimm2Z+hQ1cFQnvFdXa/uV2E2OYY9PbeMX11f+pFMTS37o4oW2JX2Klb
         no62NGrlMztNimSur/Zl81wpAW7SQGLZ4EaTrZUreAuATCX0JTC6GqieHxBZdZg0rGAs
         jhfk254enhJJE3ZvTCpAklBwc15J57bB98vaGb+OMRm+60NcdGuj8zqIO1XUK2ZqswRr
         VbZ1ePARW+H0XedjxduHrnTyke+Lww5Bb9M2DS9L7I8/DNF8Xf7zaNvqrJFGr0nWEiK2
         0kuZoFoMOq5Y6dHNOeeJ3pogRUK05wYF/5cwhPRLMHPoYJn7IYZ83mHtYPb4fuQH/wZH
         xwNw==
X-Gm-Message-State: AOJu0YzJawUOWk+EbtNgb6Wapi9S9HiPffd10F5LikkUHWuHbxMbj01T
	VKIsfopptDUmOvvElRChGewMYivHiZHIMJGdVfLFLMZnBQsXDvOutgls1e5PMz4=
X-Google-Smtp-Source: AGHT+IEGpwDm9/Y4GxiWLa+D1Lcob9itmwhM8Tt0nNdFrA/v7e6MlKB0R0Hl7rob4qzbqXK9BlRwBQ==
X-Received: by 2002:a17:907:eac:b0:a9a:a3a:6c48 with SMTP id a640c23a62f3a-a9eec767f39mr1941709366b.2.1731492458598;
        Wed, 13 Nov 2024 02:07:38 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2dc::49:c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc4b94sm856668466b.127.2024.11.13.02.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 02:07:37 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH RFC net-next v2 0/2] Make TIME-WAIT reuse delay
 deterministic and configurable
Date: Wed, 13 Nov 2024 11:06:41 +0100
Message-Id: <20241113-jakub-krn-909-poc-msec-tw-tstamp-v2-0-b0a335247304@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADF6NGcC/42OQQ6CMBBFr2K6dkyLFKgrExMP4Na4KGWQCrSkr
 agh3F0grlyxfD+T92YgHp1GTw6bgTjstdfWTBBtN0RV0twRdDExiWgU04xxeMj6mUPtDAgqoLM
 KWo8KwguCD7LtgHIpC57sY5nGZNJ0Dkv9XhJXcjmf5s1gAIPvQG4TVNoH6z7LCz1bztbXegYMp
 OAiU2xPRamOqrHPomykw52y7Vz72cRKW8KTNOeUJmWO/7bbOI5ffpQqxDQBAAA=
X-Change-ID: 20240815-jakub-krn-909-poc-msec-tw-tstamp-05aad5634a74
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Adrien Vasseur <avasseur@cloudflare.com>, 
 Lee Valentine <lvalentine@cloudflare.com>, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-355e8

This is an iteration on an effort to make the TIME-WAIT reuse delay
shorter, which we have recently presented about at Plumbers [1].

I have addressed the RFCv1 feedback and reworked the changes so that the
scope is limited to just the TIME-WAIT reuse code and does not touch the
PAWS implementation. Please see patch 1 description for the discussion of
this approach.

The end result is that with this patch set the TS.Recent last update
timestamp is interpreted as a millisecond value only in the true TIME-WAIT
state.

I feel that switching the TS.Recent last update timestamp to milliseconds
everywhere in one go would needlessly bundle up the risk of causing
regressions in both TIME-WAIT reuse and PAWS detection code.

Unless there is a strong guidance from the maintainers to do it all at
once, I'd sleep better if we could do it in steps and attack just the
TIME-WAIT reuse first.

This patch set is accompanied by a set of packetdrill tests for both
slow (after 1 sec) and fast (after 1 msec) TIME-WAIT reuse covering happy
and failure scenarios. They can be reviewed at [2]. If the proposed changes
make it into the kernel, I will to submit a PR to the packetdrill repo.

I also plan on adding coverage for PAWS old duplicate detection, as I don't
think we have any in the packetdrill repo. They would be part of the
follow-up changes where we would have to touch the PAWS code to use
milliseconds for TS.Recent last update timestamp everywhere.

We will be rolling these changes out internally to a limited set of
production machines to catch any potential regressions before posting
another iteration. We will report on any findings.

Credit is due for Adrien Vasseur and Lee Valentine for the initial report
on how use of IP_LOCAL_PORT_RANGE when TIME-WAIT reuse delay it up to 1
second long can lead to port exhaustion under connection pressure.

Goes without saying - we are looking for your feedback, while we test this.

Thanks,
-jkbs

[1] https://lpc.events/event/18/contributions/1962/ 
[2] https://github.com/jsitnicki/packetdrill/tree/tw-reuse-tests/rfc2/gtests/net/tcp/ts_recent/tw_reuse

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in RFCv2:
- Make TIME-WAIT reuse configurable through a per-netns sysctl.
- Account for timestamp rounding so delay is not shorter than set value.
- Use tcp_mstamp when we know it is fresh due to receiving a segment.
- Link to RFCv1: https://lore.kernel.org/r/20240819-jakub-krn-909-poc-msec-tw-tstamp-v1-1-6567b5006fbe@cloudflare.com

---
Jakub Sitnicki (2):
      tcp: Measure TIME-WAIT reuse delay with millisecond precision
      tcp: Add sysctl to configure TIME-WAIT reuse delay

 Documentation/networking/ip-sysctl.rst               | 14 ++++++++++++++
 .../networking/net_cachelines/netns_ipv4_sysctl.rst  |  1 +
 include/linux/tcp.h                                  |  9 ++++++++-
 include/net/netns/ipv4.h                             |  1 +
 include/net/tcp.h                                    |  1 +
 net/ipv4/sysctl_net_ipv4.c                           | 10 ++++++++++
 net/ipv4/tcp_ipv4.c                                  |  9 ++++++---
 net/ipv4/tcp_minisocks.c                             | 20 ++++++++++++++------
 8 files changed, 55 insertions(+), 10 deletions(-)


