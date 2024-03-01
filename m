Return-Path: <netdev+bounces-76651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C2286E709
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E051F299F0
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5DF5663;
	Fri,  1 Mar 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYVKZqAp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494275224
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313589; cv=none; b=pW8TzpBEMP4WRzdFwvgDo/TSjCySV0pwmB5xvWAZWJaZ/qgMP2/+3UZBICLio6KHWcY04/rbQREfw+9ZzX0NeR3m7M3Uij6ClyoCUb9sNPx4aqxTPk/4bctK6I1DJfs4hWpJOKryT3rpJD7Czk1B22zPKwnwpR0TF1g57k672Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313589; c=relaxed/simple;
	bh=w2OnS+SOIr456HO/VPrpK7JlM5CV57TM4cjagRl4+nQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IMVbflaK+RLur5gcAl1Kz42wwKNEIKzX7SSq1Fqf2ZqZyRt3u7+LsYdX5y/nakZinZk40p3KP04UzXlBGhjoqcuL0FqIsSX7tRGuVcyp1QSYzYkdtJVtztzKb5OWMfPXYeWMVyrjzQquqMV6vDgH4zAquAIWbukPODIu03BslN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYVKZqAp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60983922176so15609097b3.0
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 09:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709313586; x=1709918386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RBJk3iEweK/I0XacG9XBu2+Ddu6SpmyQDNdVCSa1TW0=;
        b=bYVKZqAp433CxDQ3agGET/XTYVpmKmZ5zv71+WarRVuVirahoHhYOUJf0X9qDQHIAO
         BJDg/Vaommg/iX8v12DOV0cTvYrdCFbM4QtDpMWQYfBgTAooLJwaitm5JqnJEX9S32S8
         Gk/NWG3pnVPgG1/nV8kZfP4kPyqXLStzGO/s4R3nWhvrobC4CW7Q8WkPC1iYUhKG0rb9
         MZXdr5lnQk2M7PlIUg9wAdyMoKS+el3TiufccmnYWo7UkUmAssovAZgpi1qM3bPS6kQe
         9DSKV5VWwiuLkIpu1CI3U3ftNC/OpkE2HQs7ShgK/4PXG6ZKEh9O5Yo62WzF71b0UqNm
         b45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313586; x=1709918386;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBJk3iEweK/I0XacG9XBu2+Ddu6SpmyQDNdVCSa1TW0=;
        b=S9yCEzH1p0PfPoOAcxB6SneL/77fY6GlJNDmqa+xUE7K9hpVAbn5vh51Q9UFBwf0Uc
         H7FF5hOUljfnSaIAjIPgFY/xjhsonXCNRMPtugXet002NtaYA0v2XxhZsx5s7f1DD22c
         dyfSqNbKQWInpwgR4rbfg2YKWig2unkPEJl/uo9hZsxYQx3JoUVIkurL+BmDG3d/dSW7
         kLDCYKPbr6t7jj3L/0FLO19fTLJSFnpmQvyG5EUajyrZRB21tKMuI10VybHg4KqgJXj4
         7p9t49Ba0vMZtBUO1khTIIpGOD2Q9/z4nG/ePEncWyrFtZjl2C+4unpVgHrld4kqBuGM
         xJYA==
X-Gm-Message-State: AOJu0Yz0JMXZcQhjDDMjCTQweuK/moX4MiNj8bD7yqWtS66r3OPp4ZQl
	JxGSIIJ/nZFlcOr+aCfbIX2262by+vyqd/I2SeaDndni6cKqs8bbnlgPvqqz7RHvUonYe/q69OK
	LiNwdtEBy7Q==
X-Google-Smtp-Source: AGHT+IH/pj5tbe0JdD9fFIDH8ivz3zSzJa3DTzmM0Eh50pTA+4YMKCbAKPhy2gpGQtEEA+u8wA03tzpqCxtxoA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:fce:b0:608:c5b5:3d37 with SMTP
 id dg14-20020a05690c0fce00b00608c5b53d37mr547918ywb.2.1709313586324; Fri, 01
 Mar 2024 09:19:46 -0800 (PST)
Date: Fri,  1 Mar 2024 17:19:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240301171945.2958176-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: align tcp_sock_write_rx group
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Stephen Rothwell and kernel test robot reported that some arches
(parisc, hexagon) and/or compilers would not like blamed commit.

Lets make sure tcp_sock_write_rx group does not start with a hole.

While we are at it, correct tcp_sock_write_tx CACHELINE_ASSERT_GROUP_SIZE()
since after the blamed commit, we went to 105 bytes.

Fixes: 99123622050f ("tcp: remove some holes in struct tcp_sock")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/netdev/20240301121108.5d39e4f9@canb.auug.org.au/
Closes: https://lore.kernel.org/oe-kbuild-all/202403011451.csPYOS3C-lkp@intel.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h | 2 +-
 net/ipv4/tcp.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 988a30ef6bfe956fa573f1f18c8284aa382dc1cc..55399ee2a57e736b55ed067fc06ea620bbe62fd3 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -304,7 +304,7 @@ struct tcp_sock {
 	__cacheline_group_end(tcp_sock_write_txrx);
 
 	/* RX read-write hotpath cache lines */
-	__cacheline_group_begin(tcp_sock_write_rx);
+	__cacheline_group_begin(tcp_sock_write_rx) __aligned(8);
 	u64	bytes_received;
 				/* RFC4898 tcpEStatsAppHCThruOctetsReceived
 				 * sum(delta(rcv_nxt)), or how many bytes
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c82dc42f57c65df112f79080ff407cd98d11ce68..7e1b848398d04f2da2a91c3af97b1e2e3895b8ee 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4651,7 +4651,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tsorted_sent_queue);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, highest_sack);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, ecn_flags);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 113);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 105);
 
 	/* TXRX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, pred_flags);
-- 
2.44.0.278.ge034bb2e1d-goog


