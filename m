Return-Path: <netdev+bounces-126426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D763C971233
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E30B23E18
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A261B0128;
	Mon,  9 Sep 2024 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2nKDU2H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F65515B995
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870951; cv=none; b=WnyozH5eBCtIuWVHwdwsfeoAgpQIRbE1IYzZoC99v746k2qM8/7938UuINaPHrYvBymv3oi1vmib5SRBRuf366OdeFB9lACBYGPjRd3qnVSqEACq2dLXXGjxiAhADsts805Key/3Pe+dRjrOzXAi90mYPEYPX5L6TzGnZzABUdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870951; c=relaxed/simple;
	bh=i0XW1CrHRvbVasBiVHoRmWk3AE8nSjcz0tGXNmYZObs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7yqxsyUeFqYezpvB1+jZ7/BIf1SbAL6fqs/JznN14ILJHA6mvbxY14QVnAGSOwsY5L2/ojW+fhCWe1Ig2OckUVL/5I5vPFXu68kG48YMnQepZkoY9rOnYAayKEabut/jqy0DL6tR8LK3YFTySolUv2EYISqfExfrfMCHpqpuA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2nKDU2H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725870949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r55frpya5Q9eSTrWeeMUpADF5rnli4WFTAfDBHmVzX8=;
	b=K2nKDU2HZqQOuS7WrfJ8hlYQoOF4mmIfyJfjUh4PjYVucF/qGpxt6PbZiKU5TMzIo2HpLT
	KErCW8CsBVEdbWeVO0lsA68SBgjL4JiUGv54nyakpQ77C23THK1MwPQ6Ug+/QxDNfKEDrP
	quHBgzFZCR4cT9/48wZIZncBBVLRJ2Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-rREmaoHZOQuf0ClAjN7p_A-1; Mon, 09 Sep 2024 04:35:47 -0400
X-MC-Unique: rREmaoHZOQuf0ClAjN7p_A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb080ab53so11542635e9.0
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 01:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725870946; x=1726475746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r55frpya5Q9eSTrWeeMUpADF5rnli4WFTAfDBHmVzX8=;
        b=vkzXBnVSeaJT9ycrDCoH/zoPMJWfvbTyMX1NFjtExs7kIATYUDa3+BlXRNAqy8JQu/
         AjskNpgpofee186LCUv+n7VDUCI/dYcX+CEFiZmmuBLmjz6H5NMBnE8HJ+iVAv2iG+pr
         B3OkYjCEmLnXhPjaArZwx5nLVykjTVs1vwOQ+IYvo+zAbXmbCbPlV8I4u7Ppmsz+Q7Xq
         aAG3jf+HzShLa2BVlnQPhjYaBr2j7zBb6j6Dc0+1KiH4365zHe0SSrtvUQoDLKwgdpGT
         TZRQTK0BBHDh6tP0ZYL28yChdzVE2LbmVxq2TitzRizN9C5xzhqNVSXs/ht2qVZC5tI5
         Cjcg==
X-Gm-Message-State: AOJu0YyDLod+6oDyyXT3GEbWrKtHiyoief6Qfldi2qeiNEquD5ZZhXsw
	eZvKs5jvO4/OkzzossG7Yx5TUlQYf48N9WTvr/tk+P6GeK6UFiGFcVFMyTTzotEQumE6WgoU839
	hiSUsWR11an47cEJ8z6GjFEG7Mwia6itKxlBYduc1R9IwXEFIajeTgwH4jk9pM5roW0BKyhvn4J
	jdLqQW8i2tTa8fMpTcYl0dhMsp+fIcZzl+EPyXFQ==
X-Received: by 2002:a05:600c:4f89:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-42cb80e625dmr15718115e9.0.1725870946081;
        Mon, 09 Sep 2024 01:35:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdSTE20nhb7hhNFCPnQIYrqDD9HcQvmIL8/38vdFPXxEeqfhw0jEfTmLZ6+2w82+gQOh9rhw==
X-Received: by 2002:a05:600c:4f89:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-42cb80e625dmr15717875e9.0.1725870945511;
        Mon, 09 Sep 2024 01:35:45 -0700 (PDT)
Received: from fedora.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb33a92sm69297725e9.20.2024.09.09.01.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 01:35:45 -0700 (PDT)
From: Ales Nezbeda <anezbeda@redhat.com>
To: netdev@vger.kernel.org
Cc: sdf@fomichev.me,
	sd@queasysnail.net,
	davem@davemloft.net,
	Ales Nezbeda <anezbeda@redhat.com>
Subject: [PATCH net v2] selftests: rtnetlink: add 'ethtool' as a dependency
Date: Mon,  9 Sep 2024 10:34:10 +0200
Message-ID: <20240909083410.60121-1-anezbeda@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduction of `kci_test_macsec_offload()` in `rtnetlink.sh` created
a new dependency `ethtool` for the test suite. This dependency is not
reflected in checks that run before all the tests, so if the `ethtool`
is not present, all tests will start, but `macsec_offload` test will
fail with a misleading message. Message would say that MACsec offload is
not supported, yet it never actually managed to check this, since it
needs the `ethtool` to do so.

Use `require_command` in `rtnetlink.sh` to allow single check command
for all the dependencies. This also requires adding the `require_command`
to the `lib.sh` used by the test.

Fixes: 3b5222e2ac57 ("selftests: rtnetlink: add MACsec offload tests")
Signed-off-by: Ales Nezbeda <anezbeda@redhat.com>
---
v2
  - Add `require_command` to the `lib.sh` and use that instead
  - v1 ref: https://lore.kernel.org/netdev/20240903151524.586614-1-anezbeda@redhat.com
---
 tools/testing/selftests/net/lib.sh       | 13 +++++++++++++
 tools/testing/selftests/net/rtnetlink.sh |  9 +++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 8ee4489238ca..890c579674be 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -218,3 +218,16 @@ tc_rule_handle_stats_get()
 	    | jq ".[] | select(.options.handle == $handle) | \
 		  .options.actions[0].stats$selector"
 }
+
+##############################################################################
+# Sanity checks
+
+require_command()
+{
+	local cmd=$1; shift
+
+	if [[ ! -x "$(command -v "$cmd")" ]]; then
+		echo "SKIP: $cmd not installed"
+		exit $ksft_skip
+	fi
+}
\ No newline at end of file
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index bdf6f10d0558..4a9ffd06990b 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -1306,12 +1306,9 @@ if [ "$(id -u)" -ne 0 ];then
 	exit $ksft_skip
 fi
 
-for x in ip tc;do
-	$x -Version 2>/dev/null >/dev/null
-	if [ $? -ne 0 ];then
-		end_test "SKIP: Could not run test without the $x tool"
-		exit $ksft_skip
-	fi
+#check for dependencies
+for x in ip tc ethtool;do
+	require_command $x
 done
 
 while getopts t:hvpP o; do
-- 
2.46.0


