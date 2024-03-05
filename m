Return-Path: <netdev+bounces-77401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FDE871919
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 10:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21912812F2
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 09:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1325103D;
	Tue,  5 Mar 2024 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="M/rs/m26"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2D53370;
	Tue,  5 Mar 2024 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629735; cv=none; b=Il+iVfaWzthCG7obZKfqkkpO88lQ0aGT10hO8x9CuRMovHN32vI1ra29QdRxKMJ70i8NlpWQw2o4Bi4hNVsNOn5Scuv9Zd02mhQnblYZu/CAuLzPzr/SfKprbufhEmWfLBAb0ARUsKroDFyfRjTbsPi+C6LYTsMOnAt344zU4Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629735; c=relaxed/simple;
	bh=87zO1li67o9oCjCgct+OtLhcsg2+fr4+Vxz3c7BSiRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tWy7pGoCiADaJnYo1mzXvjLgd4MjJ5aFr5L/PVw7BnoEjY+W22WaiIyjZ/DkpAHg9mcaYUudM149JdCIIb6GVD7OqfwDG3qm1geTrBvzo/lyAV3htPFFSxKtRzjT7Aw+2P1aDPmFwsISVSgKFCN1KNBsCIM+me+H9Ev5AqUhBl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=M/rs/m26; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zM31mjwX3JTMgX8Kh4H//nkl0RTMrwfwymox2pK/WPs=; b=M/rs/m26NRtupCMN5yiExKoG2j
	N7INKJ7fFPJ8i2hgHkcUo1Zp03gmv6Lbi4mLvX160bfvkFWchn/z8pzCH4eRz9j52YTz0TVpInYiL
	jBUsZezh2gAtH9OC1vig7rdh5nI9YMEDCEfaIn1+QDQwzC3s073nOdhsgEyHpNX45YsQg3vFovFPx
	zTrpvQT5l3mvOiW26SKzfU3HGQB/g5CkmHvtKjk2F82RZWrSG49JCYiQDIHglNxLjfSx8gVee9rJa
	pgKZCGyWNGXQYakfYQU9wvV8OYp361pvA3obncb5jh6DsxB/ghs1EHF/ZYv5XaG4K4mXMbcJOJRhj
	WxPEKapA==;
Received: from 38.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.38] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rhQn4-000Dg3-9V; Tue, 05 Mar 2024 10:08:50 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 2/2] selftests/bpf: Fix up xdp bonding test wrt feature flags
Date: Tue,  5 Mar 2024 10:08:29 +0100
Message-Id: <20240305090829.17131-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240305090829.17131-1-daniel@iogearbox.net>
References: <20240305090829.17131-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27204/Mon Mar  4 10:25:09 2024)

Adjust the XDP feature flags for the bond device when no bond slave
devices are attached. After 9b0ed890ac2a ("bonding: do not report
NETDEV_XDP_ACT_XSK_ZEROCOPY"), the empty bond device must report 0
as flags instead of NETDEV_XDP_ACT_MASK.

  # ./vmtest.sh -- ./test_progs -t xdp_bond
  [...]
  [    3.983311] bond1 (unregistering): (slave veth1_1): Releasing backup interface
  [    3.995434] bond1 (unregistering): Released all slaves
  [    4.022311] bond2: (slave veth2_1): Releasing backup interface
  #507/1   xdp_bonding/xdp_bonding_attach:OK
  #507/2   xdp_bonding/xdp_bonding_nested:OK
  #507/3   xdp_bonding/xdp_bonding_features:OK
  #507/4   xdp_bonding/xdp_bonding_roundrobin:OK
  #507/5   xdp_bonding/xdp_bonding_activebackup:OK
  #507/6   xdp_bonding/xdp_bonding_xor_layer2:OK
  #507/7   xdp_bonding/xdp_bonding_xor_layer23:OK
  #507/8   xdp_bonding/xdp_bonding_xor_layer34:OK
  #507/9   xdp_bonding/xdp_bonding_redirect_multi:OK
  #507     xdp_bonding:OK
  Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED
  [    4.185255] bond2 (unregistering): Released all slaves
  [...]

Fixes: 9b0ed890ac2a ("bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/prog_tests/xdp_bonding.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index c3b45745cbcc..6d8b54124cb3 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -511,7 +511,7 @@ static void test_xdp_bonding_features(struct skeletons *skeletons)
 	if (!ASSERT_OK(err, "bond bpf_xdp_query"))
 		goto out;
 
-	if (!ASSERT_EQ(query_opts.feature_flags, NETDEV_XDP_ACT_MASK,
+	if (!ASSERT_EQ(query_opts.feature_flags, 0,
 		       "bond query_opts.feature_flags"))
 		goto out;
 
@@ -601,7 +601,7 @@ static void test_xdp_bonding_features(struct skeletons *skeletons)
 	if (!ASSERT_OK(err, "bond bpf_xdp_query"))
 		goto out;
 
-	ASSERT_EQ(query_opts.feature_flags, NETDEV_XDP_ACT_MASK,
+	ASSERT_EQ(query_opts.feature_flags, 0,
 		  "bond query_opts.feature_flags");
 out:
 	bpf_link__destroy(link);
-- 
2.34.1


