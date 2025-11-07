Return-Path: <netdev+bounces-236857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BCEC40D26
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 17:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 903CB4F58B7
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316EE330314;
	Fri,  7 Nov 2025 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="fuLA+/fX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461B2F362F
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532010; cv=none; b=J4iDxCp3loV1uuRwmPFk/93HnaUEhP78/lnR1hkbdv6CsdMEuTKi9I+zrsd1GQoHJ7MFzjXej920o4mWEx4AT+yQWisedIe5yGlLVpnltvVfon8eDErgvE7+6wVJQNeIknNW5hQkm6/xElPPlLKxH06tzT7re2e1JZqMv08I0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532010; c=relaxed/simple;
	bh=ov9AbCvMXeqLPS1VSANRucrIGYK67murCuhMUPrdtJU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=DZ5JWtOpdy1B32CO8CTIjuYZSOqtXGUE78tSDHpGxKQQkwRDi5iKYvxzzrw29T4GHzuAP+yeCPETvr9APT79hJFrQLCgo+u+fliQSLfwHh7tlDqaNe7uMEvm5cGoLoDM9jnKfbQ5etdChmxzZ8NZPxcCKZyGiQwLQy5gneLakKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=fuLA+/fX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7810289cd4bso919252b3a.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 08:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762532007; x=1763136807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EIjsRm7p+l4fjWE/zN8BwesxBVMtqaTS7yD1zLUzJpg=;
        b=fuLA+/fXosveYT8CtLqTuJtX2xhqrcRAzHCNzWAbFCYwhGY2SYXINBYVMnCGixMKIZ
         7qQWe1IAANrSTSY+7dNoTu+p5bvtwrFvwsk7vO18BJm6NQjL44CcrBwjeKDePjNUpBJJ
         NkMBjQUGasNJYD4U5Q24TIMjWYHTO60bVBYakoDw4DGHji5jRWwMDWyJFHIv8Lgj+pAD
         IcJAClkK7QLOkbu+9QUjBwZ7lLnV6CpK8b67zjnjbByb+n3ikAW9Mo/l3NXblPEy5dyU
         eI3wB+XW4W6ocOn4EpANl/jGzzXnyTA52UjFMunyZWyMgLENYGlUJDEuOo1Utm8+VTBC
         tifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762532007; x=1763136807;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIjsRm7p+l4fjWE/zN8BwesxBVMtqaTS7yD1zLUzJpg=;
        b=I8qrh5ynR6TC5WcMUdp97ACt1iugTrKTdL9JjiNtXAtJLOSSsW05uaLC79gwH0TW3f
         9TheD6oRO60J5EI7BmcJP5Ep9rbqrQVYKvY16x8Yna5Iz+hq8d7fb8zN5Mofd0E7oq6w
         aRmNJhhZqgVM0RgKWubgM9fLKcwKi+chh7WzRlZ9iyvF0FDyxIc1GZxYgMx2UAKm4W8l
         ruQ2QeRW82VU/tFAoKvAorGaDOhKaGuYAQCT1C4jtCF73H9+ukREIC0Y4Za919QKiUA4
         bhWyqZmgEpUK7xEwYkzCzFyIvVGHE4h01bHA+59tvpw3EhWYwu9ZBhzBBn797v9rBL00
         FNvA==
X-Gm-Message-State: AOJu0YxyVo0vt7fYKEiLk7Lb2p/7rZwZBtcW1deGc/X17LPiMsQm5iw/
	cDh4k1fLuji+qQrskuv6VMSZp785irDJddiwjdxqTkK95HBWMkA/Zbsqf5Idcn5KT4BQNaVLKl6
	YsLEF
X-Gm-Gg: ASbGncs6dnZkti/voFSEbWtPKG9sedyvgfqZSRJRmkucmTBdEyUbm+VCg5WhYPR3aDG
	UqawkCJH/pJ1l+mm4hex8voU7WYczW4rxlUlVrCpBbtNF/lYQacAtUyZQ60bA6pbZVnplUkJhWw
	RgNMjXj60ZlD/1SQfE2m9akJtmCsAGdFoXqrRpEh4VsJntuyIuCicbQW2sQHiL1RgWD2jGsk99e
	mvKG5HT2IzQR3WvNsqUXB8Z7XCg4/qRuI1EvVBPbU+zFAsIzMUIzl69hyKR/moWCtc5oQ2UyjkL
	SzVU/zmxqIjbQ7g++HXPxxw1ijVDoZUhfcIfiZ+w5nMdDBLhX5ZTW9OcQ4UjdXIQbLWo4Fv8rh7
	fk8Vv7aFReyl9IvfBsZ0cbQ89P0RgKCjvfLtplWzmsp75euPgXnCvvKBOiWwG4BUr0ThukYMgaL
	C9u7Pnlicjy4Mg8ANimMLDb38HVOBsOChoIQ==
X-Google-Smtp-Source: AGHT+IGQ3dAOy71dk6S86TtBUG8hhVsP+zHiZi5xfUMGs7L3jiPx7MG09NX7doU7Lg6h3XsMnHzF6w==
X-Received: by 2002:a05:6a21:33a0:b0:34e:959d:e144 with SMTP id adf61e73a8af0-3522a971f26mr5625822637.54.1762532007497;
        Fri, 07 Nov 2025 08:13:27 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff74bfsm3421373b3a.27.2025.11.07.08.13.26
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:13:27 -0800 (PST)
Date: Fri, 7 Nov 2025 08:13:24 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 220766] New: Packets dessapear
Message-ID: <20251107081324.3ab69917@phoenix>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Fri, 07 Nov 2025 15:47:37 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 220766] New: Packets dessapear


https://bugzilla.kernel.org/show_bug.cgi?id=220766

            Bug ID: 220766
           Summary: Packets dessapear
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: wads31566@gmail.com
        Regression: No

Created attachment 308921
  --> https://bugzilla.kernel.org/attachment.cgi?id=308921&action=edit  
Network topology

A network hierarchy (network_topo.png) implementation with namespace and TC get
packets lost unexpectedly.
Linux namespaces(created via "ip netns") and connected via veths to a single
bridge inside of the root-namespace. For setting up a veth settings TC is used
like that:
"$CLI tc qdisc add dev veth-${TARGET} root handle 1: netem delay ${DELAY_MS}ms
${DELAY_DISTRIBUTION_MS}ms distribution normal
$CLI tc qdisc add dev veth-${TARGET} parent 1: handle 2: netem loss 0 rate
100Mbit corrupt 1% duplicate 1%"

At this case, where we have a non-zero delay and banwidth limit. And when both
of those attributes are set it produces some packet-loss, i.e. packets are
counted as sent on the client namespace link statistics, but the received
amount of packets on the client side is always various and real loss percentage
is different from defined one. Usually the loss is about 3-7%.
Loss is counted as a servers-bridge sum of received packets and sum of packets
sent from the namespace link statistics.
But when only delay and no other netem params used - it works fine.

Mine assumption is that is becomes a bug, when several params are used.

Uname: Linux 6.14.0-35-generic #35-Ubuntu SMP PREEMPT_DYNAMIC Sat Oct 11
10:06:31 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
tc -V: tc utility, iproute2-6.14.0, libbpf 1.5.0
Distros: kubuntu, openSUSE Tumbleweed
As a traffic generator iPerf3 was used.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

