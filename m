Return-Path: <netdev+bounces-248055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3FBD03BE7
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5001A327062D
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61E425CDC;
	Thu,  8 Jan 2026 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhj58B8q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lv3afKew"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4407F426EBD
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872672; cv=none; b=at4o/QkypcLCyOs6F4MSLiuRK1Doyow9cmR2c2nqtq1BlfERiuqVY/cPDmer0oriEvNPEvl+KJqlWzf8VMxU6Lb2BYSH+f203tBTVTgVDR2GaNquQhFTHqxw/aOXP314aCDpCIFkVUh5od7fZ2uCcr6ENSLisEpkWQf0ATq4Jgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872672; c=relaxed/simple;
	bh=MhjOQ6tmOpwUURIT+Tj/wOwtK7iu+4OcYSITUD2+mYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lJJ6EnIpKaLVH3dp77aSpswhCCWrNqkenmVnJutMNHtDP2SPQjRyi4CfrERtYn+2AGNQY6Z9iz+j79SZsmkVhFD43+Dm/JOhaeYJQJnUUeTpoZcfzY+tPmStPGQB9HHT+UHvfgAOyfjdlfgJE0xdVzJFC+CMM6AEIYRInH6fzFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dhj58B8q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lv3afKew; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767872665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G1ixihK0gQ+hFNZb+Yl0BISPWkVFMXZp1kkOJZgBibE=;
	b=dhj58B8q6Ok3URHNwCTlGAPytgA6AEKUspzSQ4pSNmTucOkcAxkVt7RXnFkWTqzZBCaV5G
	WvGPOtDJ3qEwnABdBm+tzA/aNC9cpOFbSU2jWxRJ2yirITti8e+SPqSB+bb6kePoD47l5+
	28t23a4dWFpZVcHeSu9Sz+eBxdJHA3U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-Yx3wUOgfNym4z8Ir3nkJbQ-1; Thu, 08 Jan 2026 06:44:24 -0500
X-MC-Unique: Yx3wUOgfNym4z8Ir3nkJbQ-1
X-Mimecast-MFC-AGG-ID: Yx3wUOgfNym4z8Ir3nkJbQ_1767872664
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso34845645e9.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 03:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767872663; x=1768477463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G1ixihK0gQ+hFNZb+Yl0BISPWkVFMXZp1kkOJZgBibE=;
        b=lv3afKewWf2tMrNUctgw3sC3w23e2QSbxi/4iwozfveSahpZ1lpDtxQ0e9f9f0Iwaw
         Wc1E3d+v87PgHm6SBQKtW2Ah63VPEEOdxxZsej6De8EJiVlFb8J+Iz+AiqNrnjHj7E1v
         zsagI5CvUw0lA3ka1eUpidY68iqaNHB6OwGVhEi2HzJr7dgFncB+ri841Z5gXm4jgcld
         nLR/8vwHsAz9o+QAxZdzom8lxrbIxXtmnRd7lIQeEpLGPCscC/V1LMKEPijO7aqAFF+9
         iCzbEKu//cB0LgTpoRsY5KC373lnufhj4V8IzyCaKHENnZt7I1lQK8L84phTMq/L/Pdg
         TQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767872663; x=1768477463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1ixihK0gQ+hFNZb+Yl0BISPWkVFMXZp1kkOJZgBibE=;
        b=gHMl9MEQzdN9FUUwR1lqjsOZJncCZM7jJg3592jmv5GhKjbKbkFtLIEOBLbNSORJGJ
         DyIetRpLLUsU/NsZlVCb0GHVWnTjXoI2x7JuyO8DLt4KfVokqs9VCQ6H7QO1G/f+Fv16
         LmZlGMsb7XLL3RQkWiUIN4ARXM0U+qMgYJQf4ungL0F0h6ne2U9d2uVNaS2RgWOUrrMI
         ZPe3Te4JnGirDIXOO7h3xDSVf6qIFEjoZeVOX+AJ1AlByFHAP8hlaTO2/nuzI3EwZCGS
         q91DPWolIK0dtDHe+C165IvBPyGpRHS54dt98tFDdzVsJapjeIuzhv/ncrTfbVFXFBnw
         Dduw==
X-Gm-Message-State: AOJu0YyzjeUZBvvFBTiA24Bj3MTgTeFtxn+4xqNym4dhnQpTsTdQT8jS
	WI4PoGrcHUaTRHC/YdRZR8mxYmP8jXKzo4H1qMyyoBH/+LQK9Sy1wXp65NWZMCQ0ab72Ew4k33O
	DIh2NXbLofdc6G8zGXApF6g/2HofEo6285oAhNg57D/4EioZlriPnCC2WxzNdeptriUHRM0bH2z
	Xo4R/3vz98YYyikr0KjpFddGuawvp5s7zio7BiKLnrjw==
X-Gm-Gg: AY/fxX4Ztz6qsr5YMbhH6kdKO/g4n6mUd8PUPsE00PthFUvk+5H6Mcrg9dojZHZonD4
	sROGzeXAZg3DTzhIvbFnu3QNyBxbEPab6Cm5vd1l+Y0xvwaXjNBT9Z5iFINt3rz5hCtnnNBGIvY
	ZMJT3lta63DbzhoxpeSVstjd8IOUA8vAuikJdhf+LJnEr+WqSmhP+rJQFiqFF20rBTnm6KcCbBa
	fjD+A59Mw+TZZn0P/ovBw9wNa+Lst06ldI6PFls4e5xg0PxvCyCb0rz0MdPhMSxFQ3q4CyuVsbS
	xZCuVL62sixFSykPqQLIb4N1ouw9i38CGJy5wPoATeIJwJCs3vgQgAJ1if2Qwx8zlQqbqhidxT3
	fd8SGH2yQAQik/2J+UQ==
X-Received: by 2002:a05:600c:3556:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-47d84b3bb18mr71180765e9.22.1767872662900;
        Thu, 08 Jan 2026 03:44:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkHKGejy8Hjd+SNLXzLlfus0//cWgbdRbbQV3EefELMJbpz06K9AfM6OsyNmFE2rKQ3DJOqg==
X-Received: by 2002:a05:600c:3556:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-47d84b3bb18mr71180415e9.22.1767872662398;
        Thu, 08 Jan 2026 03:44:22 -0800 (PST)
Received: from stex1.redhat.com ([193.207.178.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8660be14sm37910885e9.1.2026.01.08.03.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 03:44:21 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net v2] vsock/test: add a final full barrier after run all tests
Date: Thu,  8 Jan 2026 12:44:19 +0100
Message-ID: <20260108114419.52747-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

If the last test fails, the other side still completes correctly,
which could lead to false positives.

Let's add a final barrier that ensures that the last test has finished
correctly on both sides, but also that the two sides agree on the
number of tests to be performed.

Fixes: 2f65b44e199c ("VSOCK: add full barrier between test cases")
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- code unchanged from v1
- target net tree and add fixes tag [Paolo]
- added Luigi's R-b

v1: https://lore.kernel.org/netdev/20251223162210.43976-1-sgarzare@redhat.com/
---
 tools/testing/vsock/util.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index d843643ced6b..9430ef5b8bc3 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -511,6 +511,18 @@ void run_tests(const struct test_case *test_cases,
 
 		printf("ok\n");
 	}
+
+	printf("All tests have been executed. Waiting other peer...");
+	fflush(stdout);
+
+	/*
+	 * Final full barrier, to ensure that all tests have been run and
+	 * that even the last one has been successful on both sides.
+	 */
+	control_writeln("COMPLETED");
+	control_expectln("COMPLETED");
+
+	printf("ok\n");
 }
 
 void list_tests(const struct test_case *test_cases)
-- 
2.52.0


