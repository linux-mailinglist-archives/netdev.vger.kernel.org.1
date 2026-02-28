Return-Path: <netdev+bounces-262101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAtuGBeeomkN4gQAu9opvQ
	(envelope-from <netdev+bounces-262101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:49:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0D31C13FD
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 08:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20EC0304701C
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 07:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBBE2E7F17;
	Sat, 28 Feb 2026 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6SCd5gN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926222673B0
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772264976; cv=none; b=Hd6xZVvdzWbQngUHXFU+f+J9VQy76q6ISPPfUkmas8IareiNFXGOth3jkLFnOb8oeKdRoUwgnW9mdUtA+sLzh4U9DHDKPFvphLxlC47jpti7G+GB3V5I6OKMNdP9sM/UsCiMHEkKE6i50YUdzjRZdMgq+a+aaRCe99JuNsJLGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772264976; c=relaxed/simple;
	bh=wjYc9+A467gBJ1MBHXbnsqfQmtNcq2uWJM5XXcSSdj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1ejGGjvIC5sQ+eO+q6ho5ohoYfCjrqZxf6RQFOlYRX+R1pdmy6wU693dQ5NGabVyNkugZyahyNtwc3yfXi11SfO7wTOQot6ywOe+hT1eSOD+F1ppyl2t1OGLolipabinJxpotPqQg6aJj0u/lajWLfYlgNyAsBFWzJvprEvfAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6SCd5gN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2adec255754so18897705ad.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 23:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772264975; x=1772869775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uQsyceTj+Q/vii9FVOmBz/AIAH+opjiNSPLbnguOkJI=;
        b=D6SCd5gNc4m1mjYd0Jiwxr5lpolUyIYgzhmWftF8p3EJdEo/3BNDTjCoozZgwZTrT7
         B0m/DPgrpgI3pV9RKTqMguvm7+ffkYy++FpJdfxmamJocK+vQi2XVznP+jPkvtvvyMMC
         E7jB+pQJWTNqbuijjioFKB4PoS0RrDdfNnDFMstpDakQsry2ZnNhQiDokTSWbGKOtdMM
         hCzbsEjLbkfxOVaEqjqA0I6fKDC4nfik8kxCLyof4idPwFdGM+tKsurGdx5qfoKvmQEP
         RcjFhONH1fmL15wzKwFr7wj9ePN5QCmliQ4S7XXLMNdNtOJ9g3ApuMsoa3ShDGGVbSHo
         wGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772264975; x=1772869775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQsyceTj+Q/vii9FVOmBz/AIAH+opjiNSPLbnguOkJI=;
        b=ivan50EW/Ni5U5XbwH6J6Z9RclpErIoO3pxBFknV1ylcD9N2fxfq2EKHGruBeA4UM6
         4wA+EzDPDOHxtHt2LDVUgeDRAreLmRJOAbXgd7VESbSypGn6fpYDbKKf2COI0Q2xWLWS
         ER2nsoZar7XhEi1rgCLzF9F+WifMjNi4tZMvF0oY8zN4nwJYeW4fXpZsl3weIIODWIVP
         /ZlmNNW0jynrAagaegnjinDFz6qKtk+eC6SMiLCUoLZqBMmK9tQL5OoY5cOo/7cC3YXw
         rQzS9fTtPTyxzttiJ/l7yqu/Ug3xl6dPD3Q3qAGXLFvIl7SpU+rbRmV3uM989GeIFaQ0
         BCoQ==
X-Gm-Message-State: AOJu0YzUTb2G5qpcWPMgddh9OAOasOXbgPbnELoPncOX2tiXMIlHkjs7
	9Qlu1bq4FUy/nwSCtackDNVbjzynST3x2fmDWqga1ZCoHgKfVLpgEBGR1Ocei6EbhZk=
X-Gm-Gg: ATEYQzwCOm2mHb/v9yUaSwJBybGWXrAjN/DtHV0xp5wscHyiDVGnYJMNYtWhcW3UtoX
	afwWTfvQvHPk9CQXAd11tAmzJjBVfFFlt1HFM+XtU5/W0cwZPdKQmwcyf9jqY1lUU0tLbE51aB+
	7RB5HPTsK/Q8VO3BLmsbpjPzFdLiliOGzxt1dZS7ch8DZ656XV/wXKjrunrFOKGVc8/fLHZkBNi
	pCWjuJnJD+DEPblCkEB2t0p8Q8ppdYRVBS5dcteIzWLc8my2Ckw/pWlEcRgXf+fqdbfQJcxZ2zG
	fEkMTZidec+aH0CwX0ClCTccApwmXwTBXXSoDqrka9zIkH+8iDRkLsPQew7OF5ZVdZ+bKmhg9lg
	j0buGHqCULZf9/tLIQEvyDChYpfu9oDxy9EaoOMx3wc+iS/iSBPaorN4jKfaEBdjSxOX8AFgBa9
	blgjvl70CfeCcsyG45HVSyiuk0RidUSCiXgTAfPvApxEEYnhJhXGjregwCDHz3TijwTs/L
X-Received: by 2002:a17:903:3c25:b0:29e:9387:f2b0 with SMTP id d9443c01a7336-2ae2e4bb1fdmr59084675ad.39.1772264974773;
        Fri, 27 Feb 2026 23:49:34 -0800 (PST)
Received: from strange.. ([2405:201:e066:f03e:b47a:832e:ca46:7937])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5db596sm81457605ad.35.2026.02.27.23.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 23:49:34 -0800 (PST)
From: mr.navi8680@gmail.com
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Naveen Anandhan <mr.navi8680@gmail.com>
Subject: [PATCH] selftests: tc-testing: fix list_categories() crash on list type
Date: Sat, 28 Feb 2026 13:17:35 +0530
Message-ID: <20260228074735.10438-1-mr.navi8680@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262101-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrnavi8680@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: 0C0D31C13FD
X-Rspamd-Action: no action

From: Naveen Anandhan <mr.navi8680@gmail.com>

list_categories() builds a set directly from the 'category'
field of each test case. Since 'category' is a list,
set(map(...)) attempts to insert lists into a set, which
raises:

  TypeError: unhashable type: 'list'

Flatten category lists and collect unique category names
using set.update() instead.

Signed-off-by: Naveen Anandhan <mr.navi8680@gmail.com>
---
 tools/testing/selftests/tc-testing/tdc_helper.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tdc_helper.py b/tools/testing/selftests/tc-testing/tdc_helper.py
index e06f03c0fb5d..adb52fe3acc1 100644
--- a/tools/testing/selftests/tc-testing/tdc_helper.py
+++ b/tools/testing/selftests/tc-testing/tdc_helper.py
@@ -38,10 +38,14 @@ def list_test_cases(testlist):
 
 
 def list_categories(testlist):
-    """ Show all categories that are present in a test case file. """
-    categories = set(map(lambda x: x['category'], testlist))
+    """Show all unique categories present in the test cases."""
+    categories = set()
+    for t in testlist:
+        if 'category' in t:
+            categories.update(t['category'])
+
     print("Available categories:")
-    print(", ".join(str(s) for s in categories))
+    print(", ".join(sorted(categories)))
     print("")
 
 
-- 
2.43.0


