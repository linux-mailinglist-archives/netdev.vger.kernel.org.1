Return-Path: <netdev+bounces-150368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E639E9FC4
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 20:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9246164C92
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA75197A7F;
	Mon,  9 Dec 2024 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YxJDp+PF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CEE13B584
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733773107; cv=none; b=EWNPxIn6h9Y3OemPdP2e8HL++uWvDbs6UIjFX67/SfWi9rDR95Ea5PhjKb81a2qmJRYNwuYlIbWf1yNZNcBmcAikZSvqpsePE/5CHgZWrnVlC2NEpbozW20PONA8Fhvs6RMWen4qqRg2cYyfuFlStrvR3mq6EfUdBC01b4yxmYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733773107; c=relaxed/simple;
	bh=atil/lOdgy/Ws5476Rl28gs3kgqtzKy2LcblqKw5w+A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TCKalQLCh62+EDAYFAriWLtUdFtLV55frQloHeRdop2AxF5d6r2sDM85Neuw+pbbW3GnRPKrxTeF+8/shulUXcwwSNz8+pmU9JP1S3P17ugzmC8Y0EphzYeruv0oTzo24Wix6rAhaHVL7RioN+CXBMt3yHIIJ2g2x6aWEveXPs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YxJDp+PF; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so6038461a12.1
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 11:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1733773104; x=1734377904; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HI/HcMLu7s9szrWTpewc5YaMsQsU7zXZgMTmj+UB35w=;
        b=YxJDp+PFG5Yh6OxCmgiJmtL3ej2Mjmp3f8P3oYzYKaoW1AJlpudn1B4tDcyQd17bUP
         d5lB3dwfXXxnpMWqOlmPRlh1vC0obLklZEs0OkBDipJPeI2ebM74L/VeT8rSHe8Sjp4M
         uoNfoqvO83iFTfuHd4HVt5+sX23ft0PJzYLC48MPT9qdwc1pmuWndZnzwyoLO4TpsmzS
         Ht1UwZQ3Xp9KG77Iu6NNmO8+PO8SLXKzfBzL2vWSt/Cc5xvIgPy5qiH3PH4W7Gd4ro1h
         DOmwajRdgSh4HygjNYqJFmc3yNpSRjsyQs1EeiOXosryX2E5wOKylF4bF3VqeL8Ww6z6
         8Ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733773104; x=1734377904;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HI/HcMLu7s9szrWTpewc5YaMsQsU7zXZgMTmj+UB35w=;
        b=Ym4ZSk8I6aebiI95n2EPEtKvxdThNSOzGQR1CvUATilMGw1ZwuJqoQnxxRSh1L7SEK
         RjJxtz3GjZaUKsYtCOiOVIi86DF1xJs8e8Niucjtu8eTjwpUog6X4X/WnsxYIQLH3XCn
         itfUBECfO9YKtIEOtJebylJnT0GsalrQQT7NeqW1DzCBPZyN6H8plip7H1JF+KvBMWZC
         4fj7IYgS9rdbo/XpOpknU7VQFTLjtrYimDcNc/cJj1woL/enVdRNY+LkCmB9BuBZexiz
         5p8qKHiAcFRkt3mjTeJmh50rauhSe1BPCECh+Llbft33uOI//xZgWax68UDWOdLSLywO
         WLYQ==
X-Gm-Message-State: AOJu0YzCbxcyWx1GUq82WVnlBP0YtbR5Bl+7q0+rWx8XCI33W86VKrk8
	h2hdwZCgJEOISYe3SywtVmhOYCO9OlxvnlfGTr4ccPxc7UwyNI2gbdavQmT07tQ=
X-Gm-Gg: ASbGncvlnVfchn4hboInzz2BRlevPshAPk51afrOqp8ip82UZfHzaN9FwSVPR7EqMeI
	ZGctll3Uvm8Soke/NDc+EDeu/jjkeNPf1m6ek7yhRsaztDl0jUoH6YTDE35H9hCBDQUBOFIx+m8
	7rpn/ppIDCtXYw9eKLXyr/jD50jgp4xBMkfp3cMuJ26OAcfIKTrYKHHxkkwDz9435aCLhXFF4E5
	t6e1qRKd+4Ji1CjGCWMfNTBqdmkK9+LoNtDYsECbzc=
X-Google-Smtp-Source: AGHT+IEzWPyRpNGDSfcL3JmcPMZRmtURtsSE684idXhjb68/5OGF3wcL8t9mha3LyWf13AwfXlzfQw==
X-Received: by 2002:a05:6402:518f:b0:5d0:b040:4616 with SMTP id 4fb4d7f45d1cf-5d41863b850mr1934981a12.28.1733773103879;
        Mon, 09 Dec 2024 11:38:23 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2387::38a:52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c7aa97asm6439440a12.73.2024.12.09.11.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:38:22 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net-next v2 0/2] Make TIME-WAIT reuse delay deterministic
 and configurable
Date: Mon, 09 Dec 2024 20:38:02 +0100
Message-Id: <20241209-jakub-krn-909-poc-msec-tw-tstamp-v2-0-66aca0eed03e@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABpHV2cC/43PTU7DMBQE4KtUXvPQ829iVtwDsbAdm5o2dmS7o
 ajK3UkjxAKElOVopG80N1J9ib6Sp8ONFD/HGnNaA3s4EHc06c1DHNZMGDKBPZXwbk4XC6eSQKO
 GKTsYq3fQPqDVZsYJUBozSMWF6QRZman4EK/bxAtJvkHy10Ze1+YYa8vlc9ue6dbvn5kpUDBa6
 t5Rjjq4Z3fOlyGcTfGPLo/36W9N79SUVJ2ViCpY/49GGYpdGkJvpRCqMxi4+K3d38/s5zGllO9
 Q2apaNJxLJjqOf9VlWb4AuNSMmNEBAAA=
X-Change-ID: 20240815-jakub-krn-909-poc-msec-tw-tstamp-05aad5634a74
To: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, 
 Adrien Vasseur <avasseur@cloudflare.com>, 
 Lee Valentine <lvalentine@cloudflare.com>, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-355e8

This patch set is an effort to enable faster reuse of TIME-WAIT sockets.
We have recently talked about the motivation and the idea at Plumbers [1].

Experiment in production
------------------------

We are restarting our experiment on a small set of production nodes as the
code has slightly changed since v1 [2], and there are still a few weeks of
development window to soak the changes. We will report back if we observe
any regressions.

Packetdrill tests
-----------------

The packetdrill tests for TIME-WAIT reuse [3] did not change since v1.
Although we are not touching PAWS code any more, I would still like to add
tests to cover PAWS reject after TW reuse. This, however, requires patching
packetdrill as I mentioned in the last cover letter [2].

Thanks,
-jkbs

[1] https://lpc.events/event/18/contributions/1962/
[2] https://lore.kernel.org/r/20241113-jakub-krn-909-poc-msec-tw-tstamp-v2-0-b0a335247304@cloudflare.com
[3] https://github.com/google/packetdrill/pull/90

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v2:
- Pivot to a dedicated msec timestamp for entering TIME-WAIT state (Eric)
- Link to v1: https://lore.kernel.org/r/20241204-jakub-krn-909-poc-msec-tw-tstamp-v1-0-8b54467a0f34@cloudflare.com

Changes in v1:
- packetdrill: Adjust TS val for reused connection so value keep increasing
- Link to RFCv2: https://lore.kernel.org/r/20241113-jakub-krn-909-poc-msec-tw-tstamp-v2-0-b0a335247304@cloudflare.com

Changes in RFCv2:
- Make TIME-WAIT reuse configurable through a per-netns sysctl.
- Account for timestamp rounding so delay is not shorter than set value.
- Use tcp_mstamp when we know it is fresh due to receiving a segment.
- Link to RFCv1: https://lore.kernel.org/r/20240819-jakub-krn-909-poc-msec-tw-tstamp-v1-1-6567b5006fbe@cloudflare.com

---
Jakub Sitnicki (2):
      tcp: Measure TIME-WAIT reuse delay with millisecond precision
      tcp: Add sysctl to configure TIME-WAIT reuse delay

 Documentation/networking/ip-sysctl.rst                     | 14 ++++++++++++++
 .../networking/net_cachelines/netns_ipv4_sysctl.rst        |  1 +
 include/net/inet_timewait_sock.h                           |  4 ++++
 include/net/netns/ipv4.h                                   |  1 +
 net/ipv4/sysctl_net_ipv4.c                                 | 10 ++++++++++
 net/ipv4/tcp_ipv4.c                                        |  7 +++++--
 net/ipv4/tcp_minisocks.c                                   |  7 ++++++-
 7 files changed, 41 insertions(+), 3 deletions(-)


