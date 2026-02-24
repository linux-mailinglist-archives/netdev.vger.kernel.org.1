Return-Path: <netdev+bounces-260454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLEwMveBnWlsQQQAu9opvQ
	(envelope-from <netdev+bounces-260454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:48:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1CA185A0F
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E6F730F65D0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D5A377541;
	Tue, 24 Feb 2026 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnZ4JUTX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE9E36EAA6
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929926; cv=none; b=Zo7QLYPcFNKweLaSAyhME3QjZJspI8sj18qRdiRJVIEVgXAOZWtE4If2mIvKHbaI8wbN99WpJhV+4dak9c5sXTaEhbnyrHIkB0q6P/9wVHqQutWVLvJXflLtYnUKW+KVTegJKlshlTM6yRvArUlxL/jYL86BVvwL0bXqHS8/G6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929926; c=relaxed/simple;
	bh=z9U3voXKAW1dQW4AvalaDk7/sRwNuHWW6nH2z8AUJ3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDRe43LhZg9BAhyFTSmCajKH9x7+BQV7L7+HQxxmdnMjJTvKUJZemOGvsxQlxxXIAnVGm4wWMx6ac+HGVwK+/VL/Ta5mV0FgTATWFarUg4oniC8K9JsVyVDbMkADX/YkomdYB9f6K+mD1eBK0i8L1RyAhtnDUIOX087CglqZJx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnZ4JUTX; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4645dde00a7so2111279b6e.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 02:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771929924; x=1772534724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amTmzSl8ryBjjcQX/dMxltL1tsvRdkBfJuWHJ8vklYI=;
        b=KnZ4JUTXg1hfGvSPEUFW3Z6BHaWQo/FtX4yruy5fBEkWTQEynqbY7+BzLPaZSIkpxO
         GnKqYP+q6r3Pq9euwXo9ssBivyt7cd2L6TYljY6HP/C7vIgQHm06jcVw70YX5virfvmv
         4EcsVSy6IV/4/Tp7zPQgCDK49BKuURPVXXdd9UonA8AkedRHPiptJOHDuQjVKFwHdZW5
         BOhaksMBR62RkKKYIzk1SDLc987cQ/KHaXb/lmrtjXmJmHGV800ZN2UJ7JVPd5FCu27M
         A5OZwPuh0NTQplxh9X++0eDT+QSu6pq5jGjF7AL1uceK8CmX5hNtaoDbymhJ2VBnypA4
         2HWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771929924; x=1772534724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=amTmzSl8ryBjjcQX/dMxltL1tsvRdkBfJuWHJ8vklYI=;
        b=BdptPeG/AIri77HfQhGYVAejVzePKsRUmQ+UDoCl/fFb5mNgWtIg1se163KYZaRSe0
         PQ9aJwHXFlZoQR2vN/1y+fLnTyFMi+OeZwq9CmhtV9ryw8e/0AJnB9aOu25igpl4scIc
         vmJt/jM3g/AAREDZX5FmkrE/7hn/hpmXfP5DWKoaakUfL8cLSQpJ44FfOfq4euoW7mQG
         e3Gc8QGuzayoAgfvJQfCWdkP6WjTXEy0rWZJgtYvw/5YXt8b8yEZWpg9BfyK9MjOkuhl
         MElK7LoV8Whq5cp6pr3x7boeYsJB29gTRR23QVrSPLgrj9b2ShDDhG+YYW8kzGDM+eUT
         CH0g==
X-Gm-Message-State: AOJu0YwEhPt3UWR4oPNFDl/BDfs0hq3O89tBFplAJPPrI+ei6nDmF6eP
	9VUrKLIqIvGcIPzr1yaF4KCyE4YiWdZWgdog/09y2jMmuTwcGpdUvxj7E3K+lOZ8PbRh2A==
X-Gm-Gg: AZuq6aLisArj2ygaJE+SX3ZqWqtE0Y+hv2raEXIjdBOaV6qwoK9LVmA7WddcM+OPsum
	c+VoNfrGJsxjLpAeWzMIBU5Pr80Lc6NIyfMmpbWi8QtdSdBzdXgQFGa+wXqpP5yOgsIpdWWTlt/
	vdqiluNTzJTGmI1wPCeASKwDY9I+p5AkM9bTbSeOx8mrMlRo+gw5UCGs0vK2jJ04RBKLyOsPYTF
	ENhhJoaA5v/qP564F0nbQniMayz8KNkm6FPUwnWPJSnFnwShmr6+6hOrymhmqy0GK662MYSCq2H
	GMeiPe5tfosdu41d5g2JnAlKta6CkBUA+eJaAvB5eeCj4ojAkUpf4kXQFqYKHFO/5ujrC/Uj6ca
	Bzfyn3Ff0ONr4+kVCuDgECFFlt/5oIZFHDddG4UG96zXS/yX675h62LGEHGDaLicCKfQABnys2X
	pyMBVXTpytvEBVRbVnPostmWj61dAi9z1ZxKffQVdo3KFbHCCeJeJ+2tMqi7+NGFG0GS0C/BdQr
	8mBtGM0MG6ywLYGhvzg/Z0=
X-Received: by 2002:a05:6808:508a:b0:45f:103c:2478 with SMTP id 5614622812f47-46427678333mr8896045b6e.30.1771929924057;
        Tue, 24 Feb 2026 02:45:24 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157cfa6624sm11210270fac.8.2026.02.24.02.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:45:23 -0800 (PST)
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
Subject: [PATCH 2/2] selftests: net: tun: don't abort XFAIL cases
Date: Tue, 24 Feb 2026 18:44:34 +0800
Message-ID: <20260224104434.14912-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224104434.14912-1-sun.jian.kdev@gmail.com>
References: <20260222111847.692325-1-sun.jian.kdev@gmail.com>
 <20260224104434.14912-1-sun.jian.kdev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,amacapital.net,chromium.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260454-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 4B1CA185A0F
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


