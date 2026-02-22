Return-Path: <netdev+bounces-259870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFHiJVfmmmnImgMAu9opvQ
	(envelope-from <netdev+bounces-259870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 12:19:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE5716EF64
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 12:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18F543011590
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 11:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FD1237707;
	Sun, 22 Feb 2026 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTM9j4+/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0922121ADCB
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771759158; cv=none; b=GieNY8ePTa1hdx+mvWWG/GLJ+44QkI8Yrl1L6OV80r5ImNDYgmGQkrW3/edg7pcdP9+RhRpb4TSkWhqWcAxFRfyrplFM17Q9vrpgpfSc9BySRUdiBf8JRMcU31p3eP0SY6fk/ga7GJd1XGuA2eiAqtMgHkoehwTpDTXpgurgD8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771759158; c=relaxed/simple;
	bh=z9U3voXKAW1dQW4AvalaDk7/sRwNuHWW6nH2z8AUJ3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mB0xdnYmRFHsMeAxDnTqn85tQqFCwQdyiuVKlTRrH4SeDJpm46wt+lHnfb2E/sue9kTnQZTckRusiZBgZGNXXoZzwm4p/eRBwtRW2zEKajzmeCtw4yKO/tfbERGebZ5uGxDsKW399UsLju8oOx8EoekcHez7VsnaqI7u4mZqdFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTM9j4+/; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bd8097c709so1866623eec.0
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 03:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771759156; x=1772363956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amTmzSl8ryBjjcQX/dMxltL1tsvRdkBfJuWHJ8vklYI=;
        b=JTM9j4+/uceArCOKGlwraCSSjj6FMBe3ErNHERVQmrMUQ/MJSlhfpr1TDisQ4VBHfn
         zm77Y66Ydv1v02qtxXHsCvmkdb6b4N8Yn+6793AkBLdlEeZTiUZt3CGA/7dTT54UpGWc
         Qrgc7mBSPZZ20l3v8/eVDJiD73Ytx75AtOQlXbBuV++ot2Vm79xoCWG5vjB53+R/ESzu
         J2ZmTeJNVayGkDMZV6Mgs6nabFpEDgYikCtU0ssSYxuDfNxhq7ociKtxZLW4fLAsx7f0
         XuPohsCvLg6zfm8JKXZOW1lZNzL+1YF4+VbmlI2kOdu7f2WZg0NT3gJhV/AmHSrhTx4U
         qOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771759156; x=1772363956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=amTmzSl8ryBjjcQX/dMxltL1tsvRdkBfJuWHJ8vklYI=;
        b=Mf0DkVlWTDcnZKxir94kyPPw8X2N/SDoajFcYbiNoedf7/Q/s5gakOTrcq3a2AlNTI
         QEZjB+W9BedehqAwOfnRpOxo/aEbkZy/4khrCNW4cZOiBPJbXI+9wuAWU2iyqeShInV2
         CE/Yy1HMQ/WkCHTo1Gs8muRRT3y8+YIzOpNapHkrNcp7KN5OP8bORpazh/J3n0DV3zo1
         mb0W8b4jogbGtUfaItDoRffWDp+ZA/Gz+BwwDTr+6D0fUxWj3040f09Ad9cf3A7H1BPE
         fGA1zplnvgO569QZAqq+cdhc+7+DjxlP3QZKL2ft/xD/6ZdkvAyKaQ5UPiiD7nLNwluW
         OInA==
X-Forwarded-Encrypted: i=1; AJvYcCWGJEZeJLOgtueKC+USQf7s+J1jptipaRdSiqNElq0D6dI6njPeTl5GPHJZ4oC+UD1AgvlMwCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxptoLizZ7KT2dwz3Y0qN4Sn7nGKb+n6b1JrNBvZC4SlsQHqYDZ
	0U7JvN1egslXCXl05T4z3IQco7U8hp3dlf8AH+lr1QTd4ps3DLiaNnDu
X-Gm-Gg: AZuq6aLiI6pKRjH0dx3okK0fn51GTR9ZAl0u2VxQyxjmRO4wV9qKPi3Qf7hw9gsWLyW
	dU3N3oKn2FzvvquUt1LBP4whBQ5XUWODq0p+HuFv7fK7zi2Ey3YEVmtgyOlj3/Eub2XE2TvUk/z
	vpzuImpPmqDuMsFm11uaCKN4pHt8AXozlpcqk8HYOo0dSVMrltJgC6xNt0SKdgi/bQm9ZPkBLC/
	N5BS3R/8trmYc87a2lFK57NxmoUpi47c2/nStOEoUqueb/GoQmZpGuvPD/1LkIgd0dRqMycEqxL
	WSKZIKL627YaZYI3BcFt4EzKJPNYVUW/iSxdv32QHNmuHMwBfclGIAsRpDuFSlEdhaIJKSVsZYB
	Hn/AJT9b+luPy/OW6UdoloDkdkGff2e3JmhbpdBOvd6M8s0Iiu8hdN2DrQTNOCKo+pYJJ+iBv0L
	/CjtX/CZn0PO1hIrR0UHwkMxvR4nHfD0XY1mw4I1zWUPvDT7URMAEFtPTtZtevpRRU73Z0JFoDO
	D9Xrdrk02RtPo8B+92drLY=
X-Received: by 2002:a05:7300:2308:b0:2ba:8543:c91a with SMTP id 5a478bee46e88-2bd7bb51d87mr2389557eec.2.1771759156106;
        Sun, 22 Feb 2026 03:19:16 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af9f74bsm4437200c88.15.2026.02.22.03.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 03:19:15 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH 2/2] selftests: net: tun: don't abort XFAIL cases
Date: Sun, 22 Feb 2026 19:18:47 +0800
Message-ID: <20260222111847.692325-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260222111847.692325-1-sun.jian.kdev@gmail.com>
References: <20260222111847.692325-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259870-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBE5716EF64
X-Rspamd-Action: no action

The tun UDP tunnel GSO fixture contains XFAIL-marked variants intended to
exercise failure paths (e.g. EMSGSIZE / "Message too long").
Using ASSERT_EQ() in these tests aborts the subtest, which prevents the
harness from classifying them as XFAIL and can make the overall net: tun
test fail.

Switch the relevant ASSERT_EQ() checks to EXPECT_EQ() so the subtests
continue running and the failures are correctly reported and accounted
as XFAIL where applicable.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 tools/testing/selftests/net/tun.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index 8a5cd5cb5472..cf106a49b55e 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -944,8 +944,8 @@ TEST_F(tun_vnet_udptnl, send_gso_packet)
 	ASSERT_EQ(ret, off);
 
 	ret = receive_gso_packet_from_tunnel(self, variant, &r_num_mss);
-	ASSERT_EQ(ret, variant->data_size);
-	ASSERT_EQ(r_num_mss, variant->r_num_mss);
+	EXPECT_EQ(ret, variant->data_size);
+	EXPECT_EQ(r_num_mss, variant->r_num_mss);
 }
 
 TEST_F(tun_vnet_udptnl, recv_gso_packet)
@@ -955,18 +955,18 @@ TEST_F(tun_vnet_udptnl, recv_gso_packet)
 	int ret, gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
 
 	ret = send_gso_packet_into_tunnel(self, variant);
-	ASSERT_EQ(ret, variant->data_size);
+	EXPECT_EQ(ret, variant->data_size);
 
 	memset(&vnet_hdr, 0, sizeof(vnet_hdr));
 	ret = receive_gso_packet_from_tun(self, variant, &vnet_hdr);
-	ASSERT_EQ(ret, variant->data_size);
+	EXPECT_EQ(ret, variant->data_size);
 
 	if (!variant->no_gso) {
-		ASSERT_EQ(vh->gso_size, variant->gso_size);
+		EXPECT_EQ(vh->gso_size, variant->gso_size);
 		gso_type |= (variant->tunnel_type & UDP_TUNNEL_OUTER_IPV4) ?
 				    (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4) :
 				    (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6);
-		ASSERT_EQ(vh->gso_type, gso_type);
+		EXPECT_EQ(vh->gso_type, gso_type);
 	}
 }
 
-- 
2.43.0


