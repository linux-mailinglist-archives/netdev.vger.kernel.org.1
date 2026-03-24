Return-Path: <netdev+bounces-270877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONUIIXkqwml5ZwQAu9opvQ
	(envelope-from <netdev+bounces-270877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:08:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C91EC3029C3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 07:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F055D3009155
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 06:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E1D3ACEFE;
	Tue, 24 Mar 2026 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNUZPI81"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF3E3AB27F
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 06:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332267; cv=none; b=X7PlXl5iRVetHgdkEIcm+JLicOVrD8ePA9nac2Wg3orhq/xNWj/Mwu5bWvBEFaBBrUBe9Z/6MiM6ph0XJp5n/gv5Y+KjM8hT3A7Hv4Tllws44WJUfpxFzvJgxbx08Yt3+m3TwzIz3WyeyK9QD4qtEZM8mvxEqxOWTnLy5EakwI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332267; c=relaxed/simple;
	bh=26i1VlGHPVJPO2ACFKcL2SsSaS2lRM1qcERjVWdSklM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aoOmugpuhbYP+vNgQDLmIQhaB99iVDUApO41q09O/1InUX+6ZnbShlpj93Uwbqon4l685GBFtAjGO43prlX7TcSu9iXC6ptzjZn3pppWoCQdyCctr/SiHfpytHdFpIW++y8OntFS80/7UYYm3mW/PlWAf1UmammJ/pH21PUMmvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNUZPI81; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d744d9acbeso1396901a34.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 23:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774332263; x=1774937063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eXxXF6JthqgVazDRt0dSHWifir8Ryp7bwwT8LqL/1Pc=;
        b=DNUZPI814vvOqSP6oHM1c6Vdxeze9ClyuecM/lPFExXJd9zWf9rfEdsFFFJ/zEU4ti
         woWF0QP24I+KGCXk9A/H7k7cIQ6TzceEsw2qs7hTyNQQkriIkjX5a7zugceNF7d3s3W3
         t4hbJPxSAV1d6KO0gC4WOuk70ROmjlsAA5PL47GTT7qCS1KtKDId1C8pa+wZpJsiF71s
         4Ih3swUYSA9hk+tIlQaCvl0ZwjWxQ0XNrPMp+3iEhHyFQp2u+Gr0vLOsP6mWVymO+5tV
         Hjyx/l6d/vjak84Nt0nNneH8wKlZUTp58XywtNbueSd956U8tq6+X30g9Nuq2W+lXuPL
         GQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774332263; x=1774937063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXxXF6JthqgVazDRt0dSHWifir8Ryp7bwwT8LqL/1Pc=;
        b=cqIrL9P7Jh4pQrEiLiSujFCVcC10OrtVysJrVNfGXKTFseTBL+al2VOhpnJm6cIPgh
         ZZIOaD4HdwX2wolfzb1JBRwiflFwKjnC5mWBxdkPo7D7SZBGEPUCBGwTrgvSCS1Ya3rY
         U/OLLyumc5MswzKNSrQcEhMhB7OQ2N1ZcpJ+PM/0JXE7h1ZCDLPqJTc/guZxTTlTTwNv
         zWxjeM0zl00pagFGVS11hOFAd2EFFy1l71/yEfQwQZuz+MrvOHDhhzuWSFteF2FoGRrA
         MFuukWrRZhVAwH7ogwX0hjoS95nri+MFhpQSSivYTmI6+wLKEQUGybtwvnOq+GEWTHBj
         vCgA==
X-Gm-Message-State: AOJu0YyAUex4WrT/EvISc17Zy7j+uR4+dDcqJAQsW+JEUtwYexww7uNS
	KrCMuY/EbKB6tTdLYAYluGvyeES5FptPbEi5qPwFUHToNfVaLYV3XWGdijQsg3nZ
X-Gm-Gg: ATEYQzwzXRnKurH6M/Bm5tYpxM0gZn2tzmx426rHpDlmuOZ0HA8KfC/HWRR3BDS0HG3
	3UOG666fC/ndFc7OCL2WUD47iXlT0kwzT/QoIVirJWIvI7AKQivL/5/r0o/mxLnRmFkIwrVDdQJ
	DQMm9FTzc6XkoMqDvvrrtnffnb80pm6ceb/WqbDRiFwwbhcHiFu8Ho6+Ws609oLVHwc9Mpn5ENK
	UinPKttOtxm8zCwDMRhqlOvf/+L5zh9gMh9kpxU8dNUr3Ak4Ud+GYAIbtRV9ELaHvG/dTbosLWI
	KtpyQqLEjWaegITl6huyUO9/QkcayvChTM/ppAS4vxoBejSywAMDgqwCaJA4o4xOYlrFjyRVyyw
	1f8mG2sv7ylgC1UGw89h/WauqnGURxNpj6fOZ3EqmPDff4KmO4dL3xLvuCCNFoD+vT+uXwgZeSd
	6Qfoge1D/kAp+cQqcL9K7q0AWyjYeHB2xomF6/JmvA1Q83n5Dg/ZevNOH09KXG/g4ZcgNbbw+bW
	WV/9Wz3uaJLHK9ZLXWb949X2BLyxxynJ51/OOeGsQ==
X-Received: by 2002:a05:6830:4118:b0:7d9:ad99:9ff0 with SMTP id 46e09a7af769-7d9ad99a072mr6395542a34.30.1774332262611;
        Mon, 23 Mar 2026 23:04:22 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadcb757sm11429957a34.15.2026.03.23.23.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:04:22 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	gmbnomis@gmail.com,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH net-next v2 0/3] tcp: fix scaled no-shrink rwnd quantization slack
Date: Tue, 24 Mar 2026 00:04:07 -0600
Message-ID: <20260324060410.1137199-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-270877-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C91EC3029C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

this v2 addresses the review on the earlier quantization series.

Simon was right that the original 3/3 only showed the explicit
rcv_ssthresh-limited ALIGN-up behavior. For v2, 3/3 is replaced with an
OOO-memory-based reproducer that first grows rcv_ssthresh with in-order
data and then drives raw backed free_space below rcv_ssthresh without
advancing rcv_nxt. In the instrumented old-behavior run that shaped this
test, the critical ACK reached free_space=86190, rcv_ssthresh=86286,
and still advertised 87040 (85 << 10). With 2/3 applied, the same ACK
stays at 84.

That follow-up also clarified why the broader 2/3 change is required.
A narrower variant that preserved the old rcv_ssthresh-limited ALIGN-up
behavior was not sufficient: earlier ACKs still stored 85 in tp->rcv_wnd,
and tcp_select_window() later preserved that extra unit because shrinking
was disallowed. Keeping tp->rcv_wnd representable across the scaled
no-shrink path is what lets later ACKs settle at the correct
wire-visible edge.

Problem
=======

In the scaled no-shrink path, __tcp_select_window() rounds free_space up
to the receive-window scale quantum:

  window = ALIGN(free_space, 1 << tp->rx_opt.rcv_wscale);

When raw backed free_space sits just below the next quantum, that can
expose fresh sender-visible credit that is not actually backed by the
current receive-memory state.

Approach
========

This repost keeps only the part with a clear fail-before/pass-after
story today:

  - relax one unrelated packetdrill test which was pinning an
    incidental advertised window
  - keep tp->rcv_wnd representable in scaled units by rounding larger
    windows down to the scale quantum
  - preserve only the small non-zero case that would otherwise scale
    away to zero; changing that longstanding non-zero-to-zero behavior
    would be a separate change from the bug proven here
  - prove the actual raw-free_space case with a packetdrill sequence
    that reaches free_space < rcv_ssthresh without changing SO_RCVBUF
    after the handshake

Tests
=====

Local validation:
- git diff --check
- checkpatch on the touched diff
- local vmksft targeted run of
  net/packetdrill:tcp_rcv_quantization_credit.pkt passes with this
  series applied for ipv4, ipv6, and ipv4-mapped-ipv6
- the same packetdrill fails on HEAD without 2/3 with:

    expected: win 84
      actual: win 85

Changes in v2
=============

- leave 1/3 unchanged
- rename gran to granularity in 2/3
- clarify in 2/3 why representable tp->rcv_wnd state is required across
  later no-shrink transitions
- clarify in 2/3 that the smaller longstanding non-zero case remains
  intentionally unchanged in this series
- replace 3/3 with the proven OOO-memory reproducer for the raw
  free_space case
- drop the IPv4-only restriction in 3/3 after validating the test on
  the default packetdrill protocol set

Series layout
=============

  1/3 selftests: packetdrill: stop pinning rwnd in tcp_ooo_rcv_mss
  2/3 tcp: keep scaled no-shrink window representable
  3/3 selftests: packetdrill: cover scaled rwnd quantization slack

Thanks,
Wesley Atwell

---
 net/ipv4/tcp_output.c                              | 16 +++++++++++-----
 .../selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt |  8 +++++---
 .../packetdrill/tcp_rcv_quantization_credit.pkt   | 62 ++++++++++++++++++++++
 3 files changed, 78 insertions(+), 8 deletions(-)

-- 
2.43.0

