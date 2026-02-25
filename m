Return-Path: <netdev+bounces-260892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM/uCyranmkTXgQAu9opvQ
	(envelope-from <netdev+bounces-260892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:16:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7F719655E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98FCA301BC25
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F3D393DFC;
	Wed, 25 Feb 2026 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FY5+aEiN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71931393DEC
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018155; cv=none; b=aws5x8xECysoeiYMXs8RLaFM6P7/MUjJ+2TRxryhzjYytbc29ZSv3bwxL4uxo9xpL06lNiL8ie1BF8LEkADHx2n6kF6bJtojhxpkj9LqQhLGQzHqsRC92OdPY0dyfkobD+wCX9AjG7Uen84ejoNJ83XhegNQtEq1TQOARJk0FcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018155; c=relaxed/simple;
	bh=z9U3voXKAW1dQW4AvalaDk7/sRwNuHWW6nH2z8AUJ3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYokz9C1ZzsHVweQrXA11/WeVCMjalHrmrTUFmSKKfF5YTiesEvuahqLQBC6weGf7uSwK+ZJ/EFZYC1F1lRyz+/36djHfhPVptagRCt8a95YFaginsGdod1p2b8icfCvd0oMcTt140aXfLfWgkCX6hXEsywngqDQAIQ2f0VUT/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FY5+aEiN; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-45f053b7b90so4571020b6e.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 03:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772018152; x=1772622952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=amTmzSl8ryBjjcQX/dMxltL1tsvRdkBfJuWHJ8vklYI=;
        b=FY5+aEiNLYtcVcEvpFjqs0KrYjN7m6rWAP8vDbSmTe4afI7cOjcSsGST9+4uObu+QA
         SvpyFA+ywSIJpnJ4tBSd1Q7qV86sxb0Z9mJ47AF0mlNpDzSVj+bm/s+3kTI2qNzzmZuM
         Fcno5b68VobhOHEcjeVeZA4ZGKB4yrp+va+XEajKUi2MIDKkhDtqtWy/63DbA2kPrKwT
         h9d55NtV76F3nmUI4TMMkaDce3B/qvYkVqfPBvwjQ9tGWS/HvG0l8SeBWghn77oMflF3
         oRZxgm6Fj/IL7a6wO39XQ3XF+6OxZlh13J9+/9MFxaV4wPwREKDDigAY4ATzTPnTTvVM
         SXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772018152; x=1772622952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amTmzSl8ryBjjcQX/dMxltL1tsvRdkBfJuWHJ8vklYI=;
        b=LXi0MjJyIthd6Ftki8pWM9pRBcJiKqDr74uoggklQo+KTFgrUN13NR0ZK9eGza0bTH
         PaLqwt5OqwO2RBMH4ZjAa0B7EDMKkHUc83fXOaXbvf8xzenAO8CziRLiRm3jKwm7BKUf
         c2RQ7+z13lF30ddAWvE+VCfRCY8ymK+fD3g7KEcsSMNhYVkxm/cTxfRZukX8bUyswDFK
         iQJs0WGKTU7oCmgm1VD3OXJOAzrJM9JDGqrAird6p0wJnTv/wVTWHlXzm80Jn89wOYFY
         Nd1d6vsv5j8waO+NpMPqsDqR57LQ5JEzLdoB2tYN0auHfbQgwkBta66XRLehR4retbtx
         pfrA==
X-Forwarded-Encrypted: i=1; AJvYcCW1leCBjXXHGacjCeChp5XWMwbYyfYFQCEy8Q/ho0Dfq9SFNd2aL3Ym+hAwlOq2bMfJrLoQgW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMt4tk6DX8W7RMrVxOotZKv3lTrMmS4vspU2oyp2SDX7TzD7HR
	gXCONbNd2hWBxNri+V+LrLX/R+O5tX8pPRAe5xOKOt7No3eKUcr7gIls
X-Gm-Gg: ATEYQzwUTzAZgS4h2c4oUM1A3m/fdMvSoDL31b46lyohAvz4kojdJkZcpV7In9MzSLE
	SK+ByBKBmRmLOh0YXiSaByUCvTAHZ1J6Wyag+0dVLIp73EIuzEG7keep1neDpZK4lGirsdjYOxI
	6f5DPxQc0Rj9zx0u5uom5ZbCIbEIcoQH25qYH62jNr+WEQY5uFHueu4VRhQUKMev405UWqm5u/Z
	p4ykv0j1qCeLY6AfBIFIPV0uzuGIR8QAqGfCRsPf8SsrtBHh2pcvBtBasKGxqKCydAgRYBL9Oyj
	ETgM/o6nGW2zfo2+rYxTVvCQIl1jL/j+VdnZmyWOsb0BqU2scRm3rql1uaYimSy2U3e6zIGf0UC
	oUa4PN7WvXjuvszxjkK7kIn5YYtk5OQJzBjmzu/mVsILZL1EdbHko1Cwxo5UyRvjeg7oqXnuNUz
	oC1xPJJG9dWSZbk4H4KOh30C8U202sqUAlBwkNrsNhsn3u49aYXg+r1NVHqEGZin1S91jQW1yH/
	K0jWpNfvpA/z33E3qg7uBRu2ayaen8LaA==
X-Received: by 2002:a05:6870:c1cc:b0:40e:98cf:e01d with SMTP id 586e51a60fabf-4157ac6d17dmr8762285fac.20.1772018152330;
        Wed, 25 Feb 2026 03:15:52 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157d34a224sm13053927fac.17.2026.02.25.03.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 03:15:51 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v3 v3 2/2] selftests: net: tun: don't abort XFAIL cases
Date: Wed, 25 Feb 2026 19:14:51 +0800
Message-ID: <20260225111451.347923-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260892-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C7F719655E
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


