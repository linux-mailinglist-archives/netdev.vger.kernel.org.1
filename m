Return-Path: <netdev+bounces-244297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EC6CB426E
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 23:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 311FA30088E4
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 22:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992FC2C0F79;
	Wed, 10 Dec 2025 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="nWbERGgN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4408479
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765406403; cv=none; b=U/tWEhBKip7eV8XEEQeyHqzknIKi/kOwjYhanMt/WK2OqUd4W/QQZJKHxfUm4BWWIvFrIFKW9r8+6iuFgC1d8g1HSsREDDqe1zuaAenMs1bInlZxXPeyZKL9C9nDKIQFm2fLOHtuma7K8cIqHeRvgEICZG7275ceOMOxXRfqJlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765406403; c=relaxed/simple;
	bh=bUFa2Lu8becjSfQGRl+emmgJ3RWjc/QnITO7//favBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHRbwykpjGbKa/qQwcFF734LGXYN7X3QLkZ7qyLYBzQJ0EtCJHz/7W/0QJxJkulc1osOKAwNtDG1boNo/xQTcEauCnZCtvMJViiQlt4nSu1dRb5+8d2rMkMGWPebthukkQPjKciS0nwAAQRfuzZNqHQRc1gch7bzA4h++ZGUOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=nWbERGgN; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 13F09403F1
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 22:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1765406391;
	bh=KipHyPoGdNmHVhvrjZItubkk6d7DbSHLsSlutsFdqeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=nWbERGgNBRvOHNsHo1L9uFrMF3PtjgI7oOAwLHXS6VigQMECA5AlfbjKu+UcvkiAI
	 mo2fWz8MuY5/3UJj5JVMsYRR5M0mKTyGqE0R67/HaHj6/cKKooG9e8h8beCXwkFmaf
	 fStx+9DdcoK2pf30sX7stA+l11jJ+KWy1D6caCvmGfee2UQ19QU4HWKezP/mllRCWw
	 CSHSIK9LgXwlVEeOtADVXNPKYR2LA+QaHTylKMcP43pVayGtf2+cRTXCJumcIamUUU
	 ILCEHv+RslOvM8zB07E/rN3bHsZeEAeAchWmILIcIdYWBOQs2sa8CfGYggoxPgSy+9
	 Kcywyrx5nmhY5YrucqjTV5ULlGlHDmsV27d9Y5albwkNawXymCcnYZFsQI7cq4XfVu
	 zWnQssqYe0O8RHn5yI+D+kecU1FPCKvW6is+PAKubh2hy7HyvubO4eu1OW+vsS6Ved
	 /OsOL40/Ng1CUI1KqK84vdSl+U3W/9mqGLMPTgZ9Ira6m/YapHebTyhrm8TwrAq9gG
	 Y1JRRTnXZ+yureBDVvopFhNkEZkzeoE+mlkHhUC/hf5i6bvjaDAYnlarpzJIHohguo
	 OuvrTf9ME2fmK8dLBo5noZaDwxainFkoDCM552Xo2hFr3q7IE0T2s4JyWVef6KxVQf
	 ZmDvMKj4OYQjNmrme1o35ZGE=
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b5c811d951so85737385a.2
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 14:39:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765406390; x=1766011190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KipHyPoGdNmHVhvrjZItubkk6d7DbSHLsSlutsFdqeg=;
        b=aY0W6TeFHtHy2YP2JnvBBKQNJhyb1Y+s7kC/PMoXZZHqWZKFMQuan//yRQ3GoumhdL
         HQ6RgxtxeZYU4BCNcYN6pYl/2InDXQfd2PBIljKGzvxZDhrQhvD3aOFNbQ1lENpCcZ9o
         SQZ4+4g6iZuyxPyK9m3qqUrkfTg2tpBBh3VCQztCng+ho/pjUsBh15zDciIzUE31bUQO
         RdldY1cboYuDPQf99yrNeil6w8eJ5la7XwVAxB+vSQuJRDBR9IqB3NrKSjlDAew9q1hj
         JO3XA2iO9ZwNd8TZeLyRczCdoWWwgGag8Aum7ufni73apiWrauEWdOrqCAHyXEktkA1Z
         HDiQ==
X-Gm-Message-State: AOJu0YwvJb8viPueqNw/YtmS/4DDsZ3bjZZhHjYJGvArJMZAVc7s/yRe
	a/kUUAA+hChfVRxkNH8wmMLef5fXFm4s4/nXHWvigBUS4JeQV4kZAR3vBwvAKexhH9Vw+aIRJdP
	Zn6c+pc5QwZ1kSxKt3dHLX3PHl0IFhOi/SputeX4bgPt6T/9ldv+EnQro605bm6DHAjLpjawj9S
	zqJkYcwg==
X-Gm-Gg: ASbGncuUUQtbse6AZsKdZ1POVbxA1kNYO1jC8NWKb6Cb4fKOtz995sK236KWQtOdZya
	gJiCUeRkwIMT0+ryejCdFAbBlUmJuMX53tukZ4IyOctaO5qd2uwjSDDrFMVwHbxf2LkNoGkAdYp
	9gVI217zvACtxTzdCrl5AmeNRm/0/0F34x6a/G5f5pnoUeoc8ujjqqbLAAsP+dDfe0M1Vlu2Z01
	w/odal2i4OfQkxnVEjOhSEyVz8SoEKbW64dT0CkkDg8qLAdxzxj1toUUziz4ZPDR+mr6Xr5plDX
	L63c+yUGGBadkv40+cisDBPPSBxCwGg7fqq3mAY33WNxGAoQH5j3nNKk5p+59eoV1DDHJQIZnRn
	ne5n4AG4wHouiJeh+3svnCr2H0hty0UCEiiOXfgREUE8gs2WhOKUr5SJUzgztJBsD
X-Received: by 2002:a05:620a:454e:b0:8b2:d56a:f2f6 with SMTP id af79cd13be357-8ba38462156mr630343285a.0.1765406390076;
        Wed, 10 Dec 2025 14:39:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+LDDjEB7X473PU/XcA5iEkbKSMkYGyGhbIqiq2PsB75Gw1x2r5nksKVNHtEIvJpL5F0T41A==
X-Received: by 2002:a05:620a:454e:b0:8b2:d56a:f2f6 with SMTP id af79cd13be357-8ba38462156mr630341485a.0.1765406389668;
        Wed, 10 Dec 2025 14:39:49 -0800 (PST)
Received: from localhost (modemcable137.35-177-173.mc.videotron.ca. [173.177.35.137])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8886ef0d2f0sm7238936d6.44.2025.12.10.14.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 14:39:49 -0800 (PST)
From: "Alice C. Munduruca" <alice.munduruca@canonical.com>
To: netdev@vger.kernel.org
Cc: "Alice C. Munduruca" <alice.munduruca@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net] selftests: net: fix "buffer overflow detected" for tap.c
Date: Wed, 10 Dec 2025 17:39:32 -0500
Message-ID: <20251210223932.957446-1-alice.munduruca@canonical.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When 'tap.c' is compiled with '-D_FORTIFY_SOURCE=3', the strcpy() in
rtattr_add_strsz() is replaced with a checked version which causes the
test to consistently fail when compiled with toolchains for which this
option is enabled by default.

 TAP version 13
 1..3
 # Starting 3 tests from 1 test cases.
 #  RUN           tap.test_packet_valid_udp_gso ...
 *** buffer overflow detected ***: terminated
 # test_packet_valid_udp_gso: Test terminated by assertion
 #          FAIL  tap.test_packet_valid_udp_gso
 not ok 1 tap.test_packet_valid_udp_gso
 #  RUN           tap.test_packet_valid_udp_csum ...
 *** buffer overflow detected ***: terminated
 # test_packet_valid_udp_csum: Test terminated by assertion
 #          FAIL  tap.test_packet_valid_udp_csum
 not ok 2 tap.test_packet_valid_udp_csum
 #  RUN           tap.test_packet_crash_tap_invalid_eth_proto ...
 *** buffer overflow detected ***: terminated
 # test_packet_crash_tap_invalid_eth_proto: Test terminated by assertion
 #          FAIL  tap.test_packet_crash_tap_invalid_eth_proto
 not ok 3 tap.test_packet_crash_tap_invalid_eth_proto
 # FAILED: 0 / 3 tests passed.
 # Totals: pass:0 fail:3 xfail:0 xpass:0 skip:0 error:0

Using `memcpy`, an unchecked function, avoids this issue and allows
the tests to go forwards as expected.

Fixes: 2e64fe4624d1 ("selftests: add few test cases for tap driver")
Signed-off-by: Alice C. Munduruca <alice.munduruca@canonical.com>
---
 tools/testing/selftests/net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/net/tap.c
index 247c3b3ac1c9..dd961b629295 100644
--- a/tools/testing/selftests/net/tap.c
+++ b/tools/testing/selftests/net/tap.c
@@ -67,7 +67,7 @@ static struct rtattr *rtattr_add_strsz(struct nlmsghdr *nh, unsigned short type,
 {
 	struct rtattr *rta = rtattr_add(nh, type, strlen(s) + 1);
 
-	strcpy(RTA_DATA(rta), s);
+	memcpy(RTA_DATA(rta), s, strlen(s) + 1);
 	return rta;
 }
 
-- 
2.48.1


