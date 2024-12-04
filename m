Return-Path: <netdev+bounces-149113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5729E45F0
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 21:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C9B4BA11FE
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 18:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0B61A8F73;
	Wed,  4 Dec 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UFKbZPKC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFE1A8F79
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338421; cv=none; b=YtHCr5YzFJUwJXcpk1/JQpiTbVfZ4cmn3E+47kOAly3nMVacBI+qmSkfFLXtp8CKRteJjoy6XPXZEQ73NmyTT1yBeu81Q96bxILdwjyXq+q3GfVvmeJY8GgLcZs/xWwX91+ibqN7h4aJI7/SmUe7fJDIYItc7I7E8I+vWEu3WcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338421; c=relaxed/simple;
	bh=b1bd+9WwmJhwWruk11bVr39QcPR31rGvJgnyEIhbHas=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XeYjyFlX65CzNMYT+bSwm+d1yhuJwJpZLhw6vUKP7paFS4LVH1YldNB6ewdgfESVR/SOjUOKG9n0MmQxiYrJ95byl7xpjQk2Cin5A9QdbeSW3TtWWSXXPeWs4gsTKRgyiDv81zIsvqIo6fGsHnypKuTQ+FVngD8MGFtSTDwCwf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UFKbZPKC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso48331a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 10:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1733338417; x=1733943217; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=75U4KbWAD62bu5OTFH5nd50knNES9Wq2qZjo97XrgQk=;
        b=UFKbZPKCfyCiyuQo+97Oo3KwCF02ziuB/WbHctXGtT+gMVLZIFdY6Ran9yGAY4LduY
         9hzNLrWBHuKvF8lSbMPI2ES+8NOaH6jMDiXEjhsaopbNQm6lyuUpWyaOQ3TtJLos/n6o
         hWWCSz632zQ+YNwkfrfRSMPgPu0CrlNYiTjqkOpGiW+mdIK6LTM7Ykpus4cYD4VId3i+
         mpCDy+RI2JCQV/LqNhQ0WPVdCgWQPUR/6Q1UZOBbhY+zT5zUrjJhFdQ5CSzpIQgWxRNg
         hxRv4jZV9RH9VcY/45WoNCS0ZdqU/XIkaEerDN034Mzo+ebgvcYDpn/5tuwOjLsk5mYz
         0lQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733338417; x=1733943217;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75U4KbWAD62bu5OTFH5nd50knNES9Wq2qZjo97XrgQk=;
        b=A9gI+OWL2EAAx62ct+PPRDPh/1IEFJTfCWpikqVza3o8l9V8C9av+tTB8u5sdDu5Cl
         prFhSxX0o9R1zRitqZTLEWAMOm9U5sro0CC7AJFCsMCnZ0UNO6FyeDazpJrtW3l73UQw
         jiWAys5wXd67SHnwzRK1Z1x5tjBHqoTbXMTTKZ8xKXlWuIkT8rbne1dBjwzwPJRBEiY0
         91cgOMC1CHrRSbJKYe2tGhHFGALoevwbOzp0Izh2LFwBKmB3nYvb6CPpm5qyehjpqwiz
         hzgFwdJk+m883g+8y0vjksXc3cZNknn9vPGQqp9YFmc6IWno/uW3jH6CZyugb2E/M91Z
         oKyw==
X-Gm-Message-State: AOJu0Yx2LvBCDJzAIMPY9FbZzS0LQ4Ae3/WEdV3n+qmSX6QXqK7iMxHV
	09kF0XuyL1BNuJp8v4Dv3LVlMVXMU147y0Q43iPE71fJqGqgOvo8XsL/7fxoyfHOYaw3Bhcj5WX
	Q
X-Gm-Gg: ASbGncsz4BTJzUSoR8SL2uoj5ngcVJDN89B0sxqu/mN8yRPnRrPGH570zNlxdZrICxo
	uAP2W8yhKiS9AXE3sqM6f93zrFiZy68DvBkpCYMeObvM4smS6xwVOGUeZuji/G+x1K+oHlQybZC
	rTqJJ+EIdj4dO/S3jwK2Gsde0f/jDMC8yafFK3V5LK7xmAgi6fLvapUR2hflm0uhhHhEV7Co2lG
	wXbcazX4IHxvxjK6Viqr7wOvC6XlcIgIk9mu9/Xag==
X-Google-Smtp-Source: AGHT+IHpaTl3h8m6X+3KQAxyYVHhTNP/QuZHD/5oSgm/+NAYHq8sDB43PliLsPFdzPEBGZm4J85qfQ==
X-Received: by 2002:a05:6402:2550:b0:5d0:fda4:f7cd with SMTP id 4fb4d7f45d1cf-5d113d089d3mr5102227a12.29.1733338417045;
        Wed, 04 Dec 2024 10:53:37 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2dc::49:15e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c247csm774533866b.25.2024.12.04.10.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:53:36 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH net-next 0/2] Make TIME-WAIT reuse delay deterministic and
 configurable
Date: Wed, 04 Dec 2024 19:53:21 +0100
Message-Id: <20241204-jakub-krn-909-poc-msec-tw-tstamp-v1-0-8b54467a0f34@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACGlUGcC/42Oy27CMBBFfwV53anGrwSz4j8QC8eZgAuxI9sEK
 pR/b4iqLsomy6sjnXOfLFPylNlu82SJRp99DPPgHxvmzjacCHw7byZQKNxyDV/2cmvgkgIYNDB
 EB30mB+UOJRfbD4Da2lZXUtlasVkzJOr8Y0kcWKACgR6FHWdy9rnE9L20R77w9ZmRAwdrtNk6L
 tF0bu+u8dZ2V5vo08X+lf61mZW2Sld1oxGrrqH/ttffUfx95JzLFVYBCA1aKbVQtUT1Zp2m6Qe
 nL2/lgwEAAA==
X-Change-ID: 20240815-jakub-krn-909-poc-msec-tw-tstamp-05aad5634a74
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Adrien Vasseur <avasseur@cloudflare.com>, 
 Lee Valentine <lvalentine@cloudflare.com>, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-355e8

This patch set is an effort to enable faster reuse of TIME-WAIT sockets.
We have recently talked about the motivation and the idea at Plumbers [1].

We now feel confident enough with these changes to repost them as a regular
patch set. There was no feedback for the RFCv2 [2] so I'm working under an
assumption that the gradual, two step approach of converting TS.Recent last
update timestamp to milliseconds is okay with everyone.

Experiment in production
------------------------

We've deployed these patches to a couple of nodes in production. They have
been soaking for more than a week now. One node was running with the
default setting for the new reuse delay sysctl (1 second), while another
had the reuse delay set to radically shorter value (1 millisecond).

We monitored ephemeral port search latency, measured as time from entry to
exit for __inet_hash_connect(), and skb drops due to failed PAWS check.

p95 port search latency was same-or-better, while average latency showed
higher spikes than the baseline/control node. This calls for a closer look
at tail latency which we want to address by running synthetic stress tests
with stress-ng --sockmany.

When it comes to skb drops due to PAWS, we expected to see higher drop
count on the node with reduced TW delay, but TBH I would have to crunch the
raw data to be able to tell if there was a statistically significant
difference there from the control node.

Hopefully we can test PAWS reject with packetdrill, see my note on what's
holding us back below, because in production we have to rely on TCP
retranmissions to happen to observe PAWS reject packets.

I might be able to post the collected graphs somewhere on GH if people
would like to review those for themselves. If interested, please let me
know.

We are now expanding the experiment to more nodes in other PoPs to check if
we will see the same patterns as described elsewhere.

Packetdrill tests
-----------------

The set of packetdrill tests did not grow since RFCv2. I've fixed up
expected TS val so it monotonically increases across connection
reincarnations. It is a cosmetic change so that the test scripts better
reflect the reality. Packetdrill doesn't care. It doesn't track timestamp
offsets across connections. This makes sense. TW reuse is a special case
where the random timestamp offset doesn't change.

However, it also gets in the way of adding tests for PAWS rejecting old
duplicate segments after TW reuse - packetdrill aborts because it can't
infer the offset for TS ecr. I'm looking at how we can address that
shortcoming so I can expand the test set.

The packetdrill tests TIME-WAIT reuse are now posted as a draft PR [2].

Thanks,
-jkbs

[1] https://lpc.events/event/18/contributions/1962/
[2] https://lore.kernel.org/r/20241113-jakub-krn-909-poc-msec-tw-tstamp-v2-0-b0a335247304@cloudflare.com
[3] https://github.com/google/packetdrill/pull/90

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in RFCv2:
- Make TIME-WAIT reuse configurable through a per-netns sysctl.
- Account for timestamp rounding so delay is not shorter than set value.
- Use tcp_mstamp when we know it is fresh due to receiving a segment.
- Link to RFCv1: https://lore.kernel.org/r/20240819-jakub-krn-909-poc-msec-tw-tstamp-v1-1-6567b5006fbe@cloudflare.com

---
Changes in v1:
- packetdrill: Adjust TS val for reused connection so value keep increasing
- Link to RFCv2: https://lore.kernel.org/r/20241113-jakub-krn-909-poc-msec-tw-tstamp-v2-0-b0a335247304@cloudflare.com

---
Jakub Sitnicki (2):
      tcp: Measure TIME-WAIT reuse delay with millisecond precision
      tcp: Add sysctl to configure TIME-WAIT reuse delay

 Documentation/networking/ip-sysctl.rst               | 14 ++++++++++++++
 .../networking/net_cachelines/netns_ipv4_sysctl.rst  |  1 +
 include/linux/tcp.h                                  |  9 ++++++++-
 include/net/netns/ipv4.h                             |  1 +
 net/ipv4/sysctl_net_ipv4.c                           | 10 ++++++++++
 net/ipv4/tcp_ipv4.c                                  |  9 ++++++---
 net/ipv4/tcp_minisocks.c                             | 20 ++++++++++++++------
 7 files changed, 54 insertions(+), 10 deletions(-)


