Return-Path: <netdev+bounces-34135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C87A2454
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79551C20A22
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE21614F70;
	Fri, 15 Sep 2023 17:11:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1312B1097B
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 17:11:17 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4135910F7
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 10:11:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8141d6fbe3so2827167276.3
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694797874; x=1695402674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bOqFz4mwu4R8vVhIHYO47D/MyrIS2uBdDRxhIpCvwuY=;
        b=JwG+DbNsDLV9VBySrOCi5UcX1b+LS9Fwx3tlhXxoP8wrVMUFqFAwOMejtEb2gnVkhh
         d4ShbJCa06o/n1ggzQ/CQQJxq+ejRVKK6k0sX0LPfwcAMiEK5Y+Rx668AlEldyo2vGmP
         cRxKD4u3FMNiMQj6seoRTGyQa3dAXr++DZiiJEGrBfZXfkjcamOIhtBdZ8Rj3HQINyvy
         LjGi0T5bySYIJZY4kmMzR3qGl91DR+ZgR8AtVVt0UZbXgoZDzWyogNN13Vbo1FSX7CxD
         QGiOB/LXNv6ZPGwkx5y89+wXYETRyBNcBt1jS6VymByrj4DLXTcfroic3NF28O9705zB
         6seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694797874; x=1695402674;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bOqFz4mwu4R8vVhIHYO47D/MyrIS2uBdDRxhIpCvwuY=;
        b=cE/06tPMGwp28LqGzb4aYM0pSHV6XHfuN+0bihEMl2hnOiTMJc6yQpdefYYJZaRcPy
         pt4Nf3W5ATHOnZTNT+yz0xOoFecgQtI2sec/4GTe06ofxKe4w5AB6++q+2hEE4zgmUiF
         u4k541vVHWBEA/VcoZZYF4t+BGW4EoZYt8YqOwHJA4oHf223JYJSRne8D3QOihVYxkJc
         ZGbfleIXg6zauApoXJPVJf7kG4EF5W/LCYuJaeForMAEiULJ2crF2tXvaTWgFfoxTJVR
         eGUPrfRmfsJiyQYP4AfkhCHcaKeHKam2w8490nrYFAF6T6yZJCVp4Nl2h5Txav+hybVu
         7jNw==
X-Gm-Message-State: AOJu0Yw5hMrYPSQjAFU9flVpJ1xljJvbW/BElg89ApC2ESrGOgqFxCs0
	Uq+NqwlIAZdYlFBYjNn9I9c8h/7lIeah1g==
X-Google-Smtp-Source: AGHT+IG7rGE3Ztuz1Grnmkp8w2vtWInjs5QzEYeJJbfCf6lDpmA/8jA7FGucjoqfvQlgDMwKTaP3deHGl0CsJQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:118a:b0:d80:183c:92b9 with SMTP
 id m10-20020a056902118a00b00d80183c92b9mr60345ybu.4.1694797874299; Fri, 15
 Sep 2023 10:11:14 -0700 (PDT)
Date: Fri, 15 Sep 2023 17:11:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915171111.4057930-1-edumazet@google.com>
Subject: [PATCH] scsi: iscsi_tcp: restrict to TCP sockets
From: Eric Dumazet <edumazet@google.com>
To: Lee Duncan <lduncan@suse.com>, Mike Christie <michael.christie@oracle.com>, 
	Chris Leech <cleech@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Eric Dumazet <eric.dumazet@gmail.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Nothing prevents iscsi_sw_tcp_conn_bind() to receive file descriptor
pointing to non TCP socket (af_unix for example).

Return -EINVAL if this is attempted, instead of crashing the kernel.

Fixes: 7ba247138907 ("[SCSI] open-iscsi/linux-iscsi-5 Initiator: Initiator code")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Lee Duncan <lduncan@suse.com>
Cc: Chris Leech <cleech@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: open-iscsi@googlegroups.com
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/iscsi_tcp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 9ab8555180a3a0bd159b621a57c99bcb8f0413ae..8e14cea15f980829e99afa2c43bf6872fcfd965c 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -724,6 +724,10 @@ iscsi_sw_tcp_conn_bind(struct iscsi_cls_session *cls_session,
 		return -EEXIST;
 	}
 
+	err = -EINVAL;
+	if (!sk_is_tcp(sock->sk))
+		goto free_socket;
+
 	err = iscsi_conn_bind(cls_session, cls_conn, is_leading);
 	if (err)
 		goto free_socket;
-- 
2.42.0.459.ge4e396fd5e-goog


