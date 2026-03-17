Return-Path: <netdev+bounces-268455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA8kOxT6uGkumgEAu9opvQ
	(envelope-from <netdev+bounces-268455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:52:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B602A4772
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E88803019FE7
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 06:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A314349B12;
	Tue, 17 Mar 2026 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEttchVN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4203347FF4
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773730312; cv=none; b=EpwaBkumCR5adUHkhIb9teZoR23BAWVR5mEGQDEmLMq/G+Q1av4e+OdGUfF7XXKu2A3gOkbUmeu937yvhzzGoGQqLlIpAa9mqHN9kcD5jRjfkDoY1jGTooZQjenegbGOm+vvtsu/MciNHWFKhkvCwDEjkgbCqnkbolmVC6jU96Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773730312; c=relaxed/simple;
	bh=ImbWQoR+dgm8+9dV9PXvczLRAxo2SxKksFr3fwuIhLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1DTxfuLdkBQJZmuNTIWR8aZmUOZ0YJ2oTccdQkczPUJQHVv76GArF5/qLA5fFE36pmEVVcZcK1KNql3Qwwu640ZmsEXiUy38vEVrSgoRZpOxsMEro56zOo+6pyusS8ftNo4MWTTK1Xs0xj+yIW96GeSdcCa+MOnDqtilRBPPBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEttchVN; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d4be94eeacso6124901a34.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 23:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773730309; x=1774335109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+IJ2HT7GzgVpfj7oyAsWSh4v8318zxK4LdAKWsY7NU=;
        b=VEttchVNmTAHva0Ips9bn6B3mdor+xxVQf0380ZUVMKtJtDtfk/gyhYG7XLoFWKkPw
         6etKYvToF3rOsEG49LUZbO369awuHZec7IBpfrx2ITkKnfDMo/jp57EMC4blBav62+7C
         dkSuoB4EL9fD1eCFQGT96caDptfve5+p2WuKUz7QSfY1diQyndBSkphZ/yL7UP2O7xs1
         paQ0V9pLgewZ6DggzyTaN330Ruy56PqJgXT+dh2CQfNF8KbZqdMgwPB6he8jb2U4tdvm
         akiXfYAAULVp0jqVV17GwqNpHDP6QiQDFCPT+nPGwNu6jlg1cWXYwdfu2QxnmLLGjgoe
         bPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773730309; x=1774335109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j+IJ2HT7GzgVpfj7oyAsWSh4v8318zxK4LdAKWsY7NU=;
        b=P3t7P7kCT4e1Upbv3ZiUWsbwuyt5iNSqrdhPff7f+zs7S9s+IdewnEcLGpZuimwQcN
         JEu6ul9o1VsLOxjsERFe2FrW/WuVwOh7HdHDcNZGMHXULX8uYChdq/nlCPSQzKsZCP+K
         oUuwWcCKqPpy7OlD40YEiemlSBn9+tv+KUmOwgL8Dwjsl9tsyxtG6lB5U/FKfRjvf2nr
         cs+KHTCOZNsyJrHsYhhDBg62RWC9ajvxxBCL1ARB4HRrAKjBTjOXsMHoBmonjyzv6VlL
         SOXUOwZxvcuVYbJ8YMjTSKiJcucvffVM75qG4bAKgBMnAfcHFWZztvdg0qK6q77yteaH
         tYog==
X-Gm-Message-State: AOJu0Yyrx/ISXyHNh+8296SgU8hVYBtwJeSid2UYWOMgtacqx//mNIa+
	s9oKLlGH6NvpQRTBD1ROtY9n3WBrk9KHptd8honK4VSjZ/oGveAt3FGuiptpET3zXRY=
X-Gm-Gg: ATEYQzzCnKLmr9qdme8ohbXIdaMsSsowu9ssmVkOHQHSeupBBmjI679P6Ujs7sh0OR7
	OiFxkspJe9piJ4lrfgFdg+LvcEqjNp35MU2CQOj7aJxEPD7fMZZIidkcdTNbcs61lnAZJlwlnAd
	rTmLx8ZIvC7fYdk27eXS+29IMkf1xHftmlfA4yT6Kx3wGXAD95RPxuwdhfeQaJV2a7+AoEDNzUV
	nYBwLCpYxQ0qsf9V4OfZDIntV8bHBErh0slzbMRZ7kAbAaLFdin5pDyjmT+Exyesdve5maEG7W8
	PxfYs4/yDWx5hhlP0ibv3SV0l5t4yhD+3c2HBTgJqQkxHs07MzQN2KSWyEp842+gifAZ4kCaBT3
	LwGh1rjZNFBGXLUj9RQtMkc0A1DOp/V8jG5Qf0FZrCceuYGL2LfOcyHPhE+wQqk7IQV/PlsiIgB
	lBnuSm25ASoPAj+ssPte6gkcv+fIQA3AZ3+h8e/ixV3uCutXJoCSBFb7K4LWb8gz6x0+EllDuIh
	RUTDHpuwlfQ8M6POtoUiWLg/b5CY6ZeZYJLnwnOpg==
X-Received: by 2002:a05:6830:3686:b0:7d7:4721:9a56 with SMTP id 46e09a7af769-7d78260bee6mr11651705a34.32.1773730309488;
        Mon, 16 Mar 2026 23:51:49 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ae68a4bsm14058432a34.19.2026.03.16.23.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 23:51:48 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	ncardwell@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH net-next 1/3] selftests: packetdrill: stop pinning rwnd in tcp_ooo_rcv_mss
Date: Tue, 17 Mar 2026 00:51:35 -0600
Message-ID: <20260317065137.1533226-2-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317065137.1533226-1-atwellwea@gmail.com>
References: <20260317065137.1533226-1-atwellwea@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-268455-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03B602A4772
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_ooo_rcv_mss.pkt cares about the OOO SACK state and the resulting
tcpi_rcv_mss update.

Its exact advertised receive-window value is incidental to that test and
can legitimately move when unrelated rwnd accounting changes adjust the
ACK window.

Drop the hard-coded win 81 checks and keep only the ACK/SACK shape and
the tcpi_rcv_mss assertion.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt b/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt
index 7e6bc5fb0c8d78f36dc3d18842ff11d938c4e41b..0b19de9f9307b3d0ee579bc9e3a2b9219a88cd8a 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_ooo_rcv_mss.pkt
@@ -17,11 +17,13 @@ sysctl -q net.ipv4.tcp_rmem="4096 131072 $((32*1024*1024))"`
    +0 accept(3, ..., ...) = 4
 
    +0 < . 2001:11001(9000) ack 1 win 257
-   +0 > . 1:1(0) ack 1 win 81 <nop,nop,sack 2001:11001>
+// This test cares about the OOO SACK state and the resulting tcpi_rcv_mss.
+// Keep the ACK/SACK shape exact, but do not pin the precise advertised
+// receive window here because unrelated rwnd accounting changes can adjust it.
+   +0 > . 1:1(0) ack 1 <nop,nop,sack 2001:11001>
 
 // check that ooo packet properly updates tcpi_rcv_mss
    +0 %{ assert tcpi_rcv_mss == 1000, tcpi_rcv_mss }%
 
    +0 < . 11001:21001(10000) ack 1 win 257
-   +0 > . 1:1(0) ack 1 win 81 <nop,nop,sack 2001:21001>
-
+   +0 > . 1:1(0) ack 1 <nop,nop,sack 2001:21001>
-- 
2.43.0

