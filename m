Return-Path: <netdev+bounces-191221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF3CABA69B
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09AD5504429
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C9627E7F8;
	Fri, 16 May 2025 23:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="egu87PWE"
X-Original-To: netdev@vger.kernel.org
Received: from sonic309-20.consmr.mail.sg3.yahoo.com (sonic309-20.consmr.mail.sg3.yahoo.com [106.10.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911A22CBE6
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747438385; cv=none; b=Ogl8JpJjnnsqCAu7gxVIeo8nmFxh476uo/KGwW9g8tCyUTJz9ppaYTTAQOPrb1rDnSjJg/fcnpxf2y1oIOjT3mCEoyz1QK15mcpybQYlIv8ini8G0kJfGBuxMytguSUdKhDDM9e9QDgtByeGT6egrFQ+eAt1zaYxvFShq+4K86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747438385; c=relaxed/simple;
	bh=kWHJTdcPhiPkNZ5oAFAFErSwnx5rkOKUjVq3C3oPAng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=PHt3BvI8l4i8cS5RyCldUYim+8+dOI9121imrrHgx0GXKEbpcRG6/sxIxrOcYzCkbR0aR1/qrjst8417g36SBVjCMxqmB52LWzlZl0d2tzQ+P5t5Kv4v4DO5OHatwINTYGJRXD9qIfgnCkgY6JGQbEf7BJ1auCTbAwiowvCH0J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=egu87PWE; arc=none smtp.client-ip=106.10.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747438381; bh=wkR30jwCpMW6sl3bfgfbSavFKJ2pRI5smriO5yGx65E=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=egu87PWEnp9yjQv8T5F+z2Kc/SxFivE/VNScGSDO5qfEmDvppdE13yQGLrh84kHF8fi7Pz7ZWZtPtx/p7dK7ASKrsjZeUIUeLsCltMOj6rW37Gr0BbI3NBZrGTPJGm/r8uYHiWkKiPKEP4xDTPBn6S3Kg6ipeiI4zEQK7RDHBbWzvawbkcLwJuejdABzZfl5S6MPN0I/Bi5YLrMSPy6NAlP/evXr9kum9dD1+rRN/m5e8xeCfU1LvnIBDCX3WN1W/mUaDvav5Hw8qBk2PgH6mqs2Mce62vJQMvb7fCAzdB81vasjFYlnCmPPxXXaLnACqw0Ryzswy3GBACpjIOlAGQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747438381; bh=crfMsy9Dwl8mRv/XWxPT8DXI4c1p8F3Gi+TgLhvxTEh=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bW3c3Iwtuk/1nbtmafLWUR/qF23QHh1hX0MgIinzSiSKxqwEZgxjcQ5sznDrN4LgI9I7APm2PXiSO5gx6E78h2jLNlKbvrSTc9Jeat6/nzRLP6aMbfRHB5vc4CqsJ9Lf/hRBy26HUWELiWQiZS2cPdnq6rfUrivD8Kxigt5zQOgkVM1PfT/jGp4dXLAsQ3/LtS6V8/rKf9+3cb0xRHxaoxMWRl1g/9isT6zv71MMaaVraL27OmSdJMZcQsJYAF7bx8k2hlVlBdlMPdQVBQ4ZfNytyKUNSjgVkmNP4c7kbhn4b4yMm3XKY/o7Ei6jwLEHvWncH4sH+0BX00bpjBbTgw==
X-YMail-OSG: CvXh03QVM1lBALp1BtNdaogdCNp9tky80xuBlTLRS37kTE6EVhjGVZVrjJdL31K
 aoyxCT6EvCggR6o774MEKG8lLJHdv6iAfs3me2jQvuOpbVhdSioivtaoFGjKGEU525eK8Tct_hva
 jigf5bf1fncUv0MLDvatZze_gYtbHwbFueKx1BFsilURk1nfgSf7x3V8yqxaoxEKjII7.d7vzYpw
 dfwLkF1P6MBE43fKL.TNEkuvzN77DkWyXzRN12jDPhspKJdWYw4jseUK4okysvt8sPen2sKW1ybu
 QcB_W0VTzpmc3qdd2VvSQr4TYkzeMtgXzFKhF8yBv5BXLQUfUx752mkpklQBGBmkT4FMVVXBA8Vz
 TgyW5DY66USIW4.DzKZVcgtvP3hcXibzPjETpenYc9paXRny3GYCuvVdrhp3RuRIpIEzpfXU1i8c
 n83LrHQHEyPeyPSnCXxRe9M89s2dJAYWTlo0QT3w28Ml8t5s15fL9SXnOLo3GAxDS4oeLE0gH1TW
 CQeMy6hNPzz9Sb_NPk2sikKUhqvTktk8Kdj4FXLd9L0jgfF8q8KhY0jtmF1.O_sLXUX_u2Nb_bhq
 URxs17sHLeVLVBWYwF9hAKY79_WBWW.T2FK_8IkgW63yGexwv0Z1dinzJQoyObtDJFTzMbRoPKmZ
 6.BDQDiymHOe3fdc2anOrZ_v89o1yWWZauCewUDQKoDko4AWkGzhXYVbBkoOrsgNNVB7XVsFqfyJ
 vJ1ex2xLphqUyMqWwajnpY_jTJ2W3k4HLgbnYcwvglDs2S9i2BbAD2rHfMZdaOH35ZGR75YYqIZb
 T0870MykJHFJ5xJ3lFV1ks58.7WnNyi4ewyG8uLnbMLHbC_46BO3zj61HHBCFCAi9Kp_Rvc5DVqv
 hx1peSOBqsrQk3vO1MEclzM009ve9dFa0k.qd3dcso.ynV39VkDCcMilq7.xwb8NIdWIF6xJ5.Xk
 Hjgi0IwcbwO0TvV0CK_eD6i7PxH.sjYqR0ujRPfcQXta9atXsXAUgpN_9C_kvbetJWHsyodVCGeY
 4hFIM.eZNXN3ZjkBa_vsr7ei7Df0Z9RzxlpRXYRpmVQXM_VNp2WCE9HiqxLih11M.rZQmuOQHSsK
 pR_s2Ej_Ckv.7PtcXz0gcPmVsOljFB_pvdmQ_zSuDKYz.Uy9_4ikTR0MReQIt.IbGb85t6tprN_N
 45so7GSh20i9Wt8iN15VvERCAQ_bMC5EkUzPvPra5A0DijdhueMXTEiOqwXJWwM9jVZ3slwIgHYE
 8YOiHbjk2au_.JYxus70KVp34yCHZnzullIhDYoC2SyFEhD8fdLm4uNY0U3x9tZa7_rl3xF_8GSP
 OQF3Or.4GbiBj5OgHHO69eTF2WN03M8d2iLsbtD0u9P1Q13lqBQKtjYGknPkec2rWt5sQxV.6yIP
 sjPzoaQxIFRcKUn4PtJOavlZNkPXUSy3hyl00tfWrhA5vYbwIojFdNFA7BIqUEYAj6.uIUB_iv2T
 Lg_vjaV3x6ZuN2SfOJQ3uYZCQ2H3uR4u.YFhN6fUn57UHxM_Fa7R1VhT8ajaGoGt_1nxoW4utlLf
 OzHvDWwARZnyyvi1feCkbkIOTpgKRaBhSBPhiKQJUbn2GmB7uF3TW5C5AdxsJL3gIAjduQFm8Kza
 8emIJfj2KmJOHyFBQ6kgfNg_0uq9758XW3rLXGuUveKRlYXsnMYoaWS3Z47RxM1IidPHMANkPLF1
 fqb0wuBMevoIpmO7ivqpQR_NN1J48yXA15VW_fMstZi3omLQ9E2A5cqobc_ZCMfg_awLOZw1Qv3E
 QLy4c4NrWApmdyQkLYhopyckMHj7s3hhXxR7Njwx9KCqI2rE_n2w8SU1PaQuShbBUfYLUWp7LQAI
 cV6UT2OR.I.obWwvu_7VLjDd0rtZ5_kqxBGqHzYvJjGV.zSBh8B9U0Q1bJmsh998DwJHfFwlh_Dd
 MOnktMUXX0_a2FioSMEO5pmE4956kflcRcHJIwZp9vaH6rW3oyr.62mhUuJqWJm0SNK26zF2PV.6
 pYujiK2LjWhcSwmTfpmlC32RbCg6uYJW_w_6NE.4.FbH6iF7iLmUiKp8AvpiO32oafSuAGmKhRUB
 evJF.Ce3ucM.950uES9cVv_2184t1XXTSlKBh1irRCijonzfDL.N3caNhKUk2tNrTejlL3x5q63H
 wYTUE.haVx7lTfZWnWo8_FbtcCbGcHIvRHjnE97sc6klB85vJzEByXCFLr45EO94ikunK_FU3S1Y
 VB80Vk2n_
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: def904c3-9ff2-43b1-8e25-7c50ad645ce6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.sg3.yahoo.com with HTTP; Fri, 16 May 2025 23:33:01 +0000
Received: by hermes--production-gq1-74d64bb7d7-4jn9v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1c9a854e7c31166c3a8d30fc711772dd;
          Fri, 16 May 2025 22:52:25 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	sdf@fomichev.me,
	sumanth.gavini@yahoo.com
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: drv-net: Fix "envirnoments" to "environments"
Date: Fri, 16 May 2025 15:51:48 -0700
Message-ID: <20250516225156.1122058-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250516225156.1122058-1-sumanth.gavini.ref@yahoo.com>

Fix misspelling reported by codespell

Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
---
 tools/testing/selftests/drivers/net/lib/py/env.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index ad5ff645183a..3bccddf8cbc5 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -12,7 +12,7 @@ from .remote import Remote
 
 class NetDrvEnvBase:
     """
-    Base class for a NIC / host envirnoments
+    Base class for a NIC / host environments
 
     Attributes:
       test_dir: Path to the source directory of the test
-- 
2.43.0


