Return-Path: <netdev+bounces-204937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2767FAFC94D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3465F3B47EE
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28FA2D8DD9;
	Tue,  8 Jul 2025 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3941vTR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C89D2D8388
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973433; cv=none; b=GscDXWP41IEyzjhpMfVZ3a8eta536GCPMP6imvOcnoTQxXYQAE+kNRoF0BU+60sZFjFlk+i5s5vT+ZeSeQTqNyQn2VdIzVXTjpeZqFtsPi3reVA4PDklj87+DDet7wZxzoXMZ3xusvze84L2pdl/Eka3gCE0Juod30y2WL6NcxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973433; c=relaxed/simple;
	bh=SW4IfHix+f4Je4esfBdglGbT4aI4+HKwBw41uiZTcKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SEampsP2OBNMXIv+9ibUNH26QfmX+iLg4knvj4Hvjb3ClnXvkYVXURGHIBlwA3YEx9Ui+3yED8xzyyFVmoYX5z/njjshdD6waSwr/I9SMCFZGazNZtPXl0XcJab/VFN3qmQLSk34rW4oZ8X5y7ilkckV6d7dTkfYHQNthHpKfO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3941vTR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751973431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hLJpDQTyK8jsS2YvDzZqaAeQiFLy072zwpHz83Qr2vg=;
	b=S3941vTRZY10UrTr24XTj/M/BPIkNqMMUWx7zT+u+zCgsyoOQuk43VgdQMehP4SnJxKL/t
	iqM951ychcW/FLoaXsgIhIedmS0tzC2Sw1zu2ZwjowR612A/Fm/Gv69zfB+9nV3lwPV7Pk
	wAFPBf3BldMRJ5ITYddpE1cWVexRgEg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-u2qMzOtwNKevuWP72zMlxg-1; Tue, 08 Jul 2025 07:17:10 -0400
X-MC-Unique: u2qMzOtwNKevuWP72zMlxg-1
X-Mimecast-MFC-AGG-ID: u2qMzOtwNKevuWP72zMlxg_1751973429
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a58cd9b142so92073591cf.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 04:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751973429; x=1752578229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLJpDQTyK8jsS2YvDzZqaAeQiFLy072zwpHz83Qr2vg=;
        b=YoMV4XZSRnz63+mScA1p5ewNot7NkhP9rmiaX3Ym8T0HGg2A8xI3j4jrjPPt/7TYQz
         JfUDvLUy+CtwwuNLX0YZZpjgLb5oTEHLYFRJJwX+UJySDm8oR3GZzbDcghC+8ISM7RrM
         zc8E2+jUvcYUoXT4bR7iVfxv0NJMpqhu1dhpWcgDCwqXKAknsbtOgKfMlQxDrxx27edL
         LOnUvBdsua1AFD+xwtbzqzRy4QsYO0KK6I+4UR/ISOV/D5puf0qHXloK/alDpo5ibZZr
         CsgdEySQ17m9ps982PrRVGec1CXHpfBClTN25C8ETmPU9ZU/szHhK2ls2RWfvtZ4sgek
         Mqew==
X-Gm-Message-State: AOJu0YwG3MnK1nz06Xjc+xrvWhuUdj5BN6wdO8fRPUvwUBZKq9gkwC4q
	CvncvZrZLgo7zGPuWUcL+KZo5xrcK4sD2wHLOKJPFg77QWlquPyVG/M6VCINqZn6fsa5jOyaUn1
	CCMxPPRubcM5c/oSSFsi17T3Bihd8JeqgPa4LCbtecKQHDHgI5OHBQxT7BY87S8QseVO/bNi3fH
	Gs4IBPYdAgh1AqlbQOm/goaj54fFlBsaJXZJUVp1W2Iw==
X-Gm-Gg: ASbGncsRcfg/zmhWuh1PEPnoey/+B5R7xaXsVxHg+GNbVN9Fi/e8T8p29VVIQzpF+8X
	G2Bd2dBd4bfvuNOSRR7NQGniExtMb+VVU/cKmsP+ni9AdKVwsZYvhqVLrj+27QsGGaaZ9DNZP3A
	BmlwjUvnjm3NwNeDcQYdlq9s7GZegOgNbpu27KoCRY10lnwTAAle/R4wC5yQNvNBjWuJAaLRVvH
	hqH7zP5po2wrXKiEwpYZEVoecRlvX0URIjjqWe9HNDl5dXBGCviKiXJrBNrKtnO+iKgUp93xNg1
	VvmFuLKTsfevZsdauIQ25+M02ARHVg==
X-Received: by 2002:a05:6214:1c49:b0:702:d9d7:b6e2 with SMTP id 6a1803df08f44-7047daea654mr37844286d6.34.1751973428868;
        Tue, 08 Jul 2025 04:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmdZdg7FkyHCs2tm7yZmuVxog/GLdnlBjbdngjYdDrQNIKIT5juBSVSyb2m4opt+Qg+0n1ew==
X-Received: by 2002:a05:6214:1c49:b0:702:d9d7:b6e2 with SMTP id 6a1803df08f44-7047daea654mr37843036d6.34.1751973427927;
        Tue, 08 Jul 2025 04:17:07 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.147.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d5ac2csm74424756d6.95.2025.07.08.04.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 04:17:07 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net-next] vsock/test: fix test for null ptr deref when transport changes
Date: Tue,  8 Jul 2025 13:17:01 +0200
Message-ID: <20250708111701.129585-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

In test_stream_transport_change_client(), the client sends CONTROL_CONTINUE
on each iteration, even when connect() is unsuccessful. This causes a flood
of control messages in the server that hangs around for more than 10
seconds after the test finishes, triggering several timeouts and causing
subsequent tests to fail. This was discovered in testing a newly proposed
test that failed in this way on the client side:
    ...
    33 - SOCK_STREAM transport change null-ptr-deref...ok
    34 - SOCK_STREAM ioctl(SIOCINQ) functionality...recv timed out

The CONTROL_CONTINUE message is used only to tell to the server to call
accept() to consume successful connections, so that subsequent connect()
will not fail for finding the queue full.

Send CONTROL_CONTINUE message only when the connect() has succeeded, or
found the queue full. Note that the second connect() can also succeed if
the first one was interrupted after sending the request.

Fixes: 3a764d93385c ("vsock/test: Add test for null ptr deref when transport changes")
Cc: leonardi@redhat.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index be6ce764f694..630110ee31df 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1937,6 +1937,7 @@ static void test_stream_transport_change_client(const struct test_opts *opts)
 			.svm_cid = opts->peer_cid,
 			.svm_port = opts->peer_port,
 		};
+		bool send_control = false;
 		int s;
 
 		s = socket(AF_VSOCK, SOCK_STREAM, 0);
@@ -1957,19 +1958,29 @@ static void test_stream_transport_change_client(const struct test_opts *opts)
 			exit(EXIT_FAILURE);
 		}
 
+		/* Notify the server if the connect() is successful or the
+		 * receiver connection queue is full, so it will do accept()
+		 * to drain it.
+		 */
+		if (!ret || errno == ECONNRESET)
+			send_control = true;
+
 		/* Set CID to 0 cause a transport change. */
 		sa.svm_cid = 0;
 
-		/* Ignore return value since it can fail or not.
-		 * If the previous connect is interrupted while the
-		 * connection request is already sent, the second
+		/* There is a case where this will not fail:
+		 * if the previous connect() is interrupted while the
+		 * connection request is already sent, this second
 		 * connect() will wait for the response.
 		 */
-		connect(s, (struct sockaddr *)&sa, sizeof(sa));
+		ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
+		if (!ret || errno == ECONNRESET)
+			send_control = true;
 
 		close(s);
 
-		control_writeulong(CONTROL_CONTINUE);
+		if (send_control)
+			control_writeulong(CONTROL_CONTINUE);
 
 	} while (current_nsec() < tout);
 
-- 
2.50.0


