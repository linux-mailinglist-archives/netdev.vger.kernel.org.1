Return-Path: <netdev+bounces-260483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJouJDmOnWkXQgQAu9opvQ
	(envelope-from <netdev+bounces-260483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:40:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A571866E3
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59DD530518F1
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460D937F8A4;
	Tue, 24 Feb 2026 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqNQhcbE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED7E37D116
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933166; cv=none; b=tVmL9SgCYne+ik1P+/0P9SbV8ajwFve9pZTmUIhaavQXWhJHSM2ENrtXSbxjO0Gr4XuY/plBBPCTTwaaR3j3nh1EVFJlsRcNfkyMmOetgS76fFBxc7QXnI5/EVZ6SUoRtykgpkQnK8Uxg5uM1M7NMSBcWMbUgao3ZBmcB9pp3Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933166; c=relaxed/simple;
	bh=z9U3voXKAW1dQW4AvalaDk7/sRwNuHWW6nH2z8AUJ3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9akj6KA4+KkXELpPkddZE4Hm9heqh6mXlSrIP4eRPq1nj6J1r1KBfrKZVj4Yka1oGz9/vtaDTtx2e6vLqxKqSxHGzqZVMKZSipNFy4CucB/1QQYKXLqLfWNg9QlZQeE+Vqgj+uM1RsodmpisutgbwcNIq4xSermaNx/14z6cHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqNQhcbE; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d4d8712b40so2045889a34.2
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 03:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771933164; x=1772537964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amTmzSl8ryBjjcQX/dMxltL1tsvRdkBfJuWHJ8vklYI=;
        b=HqNQhcbEHnmf2Qvf719iuNlfyxuuHtEpGKbIvvIuBkxbG/t4W4NnM041lXsw8hI+AS
         PJVg26+bLTJ4xeGmS9qv/6zqtN1OBZSMpQ0IKXcyOWxV8Dy7v/Ka1mkRRjm4aagVVuK5
         OHUkAZ5wtM1Y0mClpnXjROabaDeJ/YyLXRVhpTNxeDH5kVDQ/GxS+eJXkY6f3dNF7NV5
         us4sHOxInhXa9S/Xze9wUNjT0Ui1JEeSr1xvRySuNhEke6DOktJM1yfzJP66IiKpvl+/
         t8LSu+6CkKyAPS4Uk2vzbr8GGb/4ygg9JLPm1qxPQl2w+a2bYLsOOWewDdD83HaIIVcQ
         WYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771933164; x=1772537964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=amTmzSl8ryBjjcQX/dMxltL1tsvRdkBfJuWHJ8vklYI=;
        b=M6MipIBznQDczJS51X19IYOIUJsxnV75ppcttTRBxeH3fKRZl81hDIqDq05Y/UbL7D
         iLQN1A1aYSpLbVk+QzaCNVLEjNZzZ1MynH5OF8dW34ZYnNEnbrhrSwhItKpncsKYTJT1
         0tBG7bYBOd+C/8JBtk/p2y6MMUGitfM7OEZ/muCyzPqMECpLMipEaepi1vYftEcRQuCI
         c7FM5aNlBN/7kqYO59jnadgO/+zP3KY1MyoqwGvZ3lIihRGL/AkbQb1w7qXmZsKZ6QL4
         CBmRdOdYpoeUDK4rYfToO0Z3yvDSO5ZxIqjvxdT4DuiRxHuhZ0/dH/L+NHQICDJcxlSg
         gR0Q==
X-Gm-Message-State: AOJu0YysboYomKw/WNKAoKumPxgy26sLKs8IFi07JxSTgeUqYGKud6wy
	h50DDZOINBMIewr8D6Q4miF3Nawv4BZMiE0WlFf9UDzSsSu4tAsCfebG2pV6WQ==
X-Gm-Gg: ATEYQzxA/fMIP+LKuwYgV+N9H8TLx2/aZDLFRvuypOTBBfaeDHLSqL3TwgYC/U0E9dP
	Bz/n65ku6poQR5s6u3gRe6DUAcyfnqGgALsJeVVdI6crgb4Q+uU3VhyHODiA2YGQ+z9jnXTlitJ
	3qP2sNo3IC3ElAHwhzGHVQDd2EGyfMLaWUQ/PSxnPNkL7OCqPvfvcDdNRkLGRisHi9nEAUXY59B
	LE2hfI8muZB9+En1dUOmy++N+90ls3Ly7E6pCFyhC6SpUizcp02xl/KbsLPO41BVX7b9bMCnTp5
	o5mFPjsFrHM20vIrXeXh6KaxH8HsT4Rg/i52xMqdX8BckPz3TnU49+luuvdAEEHisRa8Ssct0YF
	vTmHB6gDKMMUd6WNNSmVhFndUHRTC+dRSfn3YrkEI9j1aynw9ud8nGAsLgLXPcfwwq03VzlC/vi
	tzQeD0nb0j8BPFbBNpSZgyF74wPGoiZna5aBTE/X74GZ1NlnXk3HeVNJdSPx6ZTUGo9CHrem+mu
	14X6rMd7tGvy97X3Dr+0p8=
X-Received: by 2002:a05:6870:63ab:b0:35b:32d5:8fbb with SMTP id 586e51a60fabf-4157b1225c3mr6861360fac.37.1771933163741;
        Tue, 24 Feb 2026 03:39:23 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157cf9a388sm9899241fac.6.2026.02.24.03.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:39:23 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	horms@kernel.org,
	shuah@kernel.org,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v2 2/2] selftests: net: tun: don't abort XFAIL cases
Date: Tue, 24 Feb 2026 19:39:00 +0800
Message-ID: <20260224113900.3331-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224113900.3331-1-sun.jian.kdev@gmail.com>
References: <20260222111847.692325-1-sun.jian.kdev@gmail.com>
 <20260224113900.3331-1-sun.jian.kdev@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,amacapital.net,chromium.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260483-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54A571866E3
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


