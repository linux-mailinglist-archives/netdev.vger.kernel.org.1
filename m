Return-Path: <netdev+bounces-35248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F40E37A822C
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 14:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68E52813B5
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37506328C1;
	Wed, 20 Sep 2023 12:58:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EFF63B2
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 12:58:05 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E3C110;
	Wed, 20 Sep 2023 05:57:59 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so54177745ad.0;
        Wed, 20 Sep 2023 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695214679; x=1695819479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DCn7kCF2X383hQp234RmSk/lE9r04EvQ6j/6XU/gTro=;
        b=PTZ6BAIfz7bfa8s9TL+iAAGfc1ZT3xLg1txW7fNwUOKiUO5nAIYDghbMoisQGBF/X7
         XaGkBmra/GExedcPie9Z4EsAwsFOxBDvQYvOimR+YlOg7FXCst5E50CfobqP5sS3Acc6
         zaR/MMU0h9ReAcwxAlQokB+suKGAVphwyoDldn41+l34GIyL6TeALCQv9ozdoftqlucg
         ioG1VTG1mtr9U2bnTXUGU3Qbdpm3csBG9dkfWU6DG9gySYnkVIbGx8rH6hPuGoFrsqdf
         xBpoJDIoyzgkGo2aaYgko+qk+daMfUaxREsQ4FGJozpMYHodP9c08OQHIuoWVS3RK935
         tADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214679; x=1695819479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCn7kCF2X383hQp234RmSk/lE9r04EvQ6j/6XU/gTro=;
        b=pfCtO493LHwJNIvJDT3bUL+G9mdkM4fd/5PIdc7cZcJ1SaGjbCER6RVpL9U6NFZE8+
         ftRRjQV5WHnlilHDcWepF+Z6aUMgH7viPfRR/DRhdcFExxFTpYXCbNK9YXhUxVET7K5n
         oWr8M7KnjfA7wo0RFUZ9ivSzKMaZWis6DY/hhckwntR4afaoqO6TO+AYKZsCMTDv0FK7
         wqA3HBHt7fGeEDadTJUDrd1/O+tKX+x8HziP3ccwYyxXgtmIf/Q2xO2/TLDdX+f/SRd0
         K91sdKBXEDxI2LFpIVloSTB38YwlvVqmp77dJpb4AQbG6mIvsSi7l3j4W8608G9lgbHV
         etuQ==
X-Gm-Message-State: AOJu0YzxKqwebyUjQEtwgmZqcVA5KGHLjdy0bKipFuT3ijyeBJNrjAou
	gkFfcH1sRT4JzJMnmosn39U=
X-Google-Smtp-Source: AGHT+IF1qbplKWJq8+qvKLgkxtWLu1XnqKJgnNH5DFjpBTsx2fiWOnxyqe4TrHwRawzySv+K4CRsPQ==
X-Received: by 2002:a17:902:748a:b0:1be:1fc:8ce0 with SMTP id h10-20020a170902748a00b001be01fc8ce0mr2203543pll.12.1695214678930;
        Wed, 20 Sep 2023 05:57:58 -0700 (PDT)
Received: from localhost.localdomain ([50.7.159.34])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902e74800b001ba066c589dsm11839614plf.137.2023.09.20.05.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:57:57 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bpoirier@nvidia.com,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	gregkh@linuxfoundation.org,
	keescook@chromium.org,
	Jason@zx2c4.com,
	djwong@kernel.org,
	jack@suse.cz,
	linyunsheng@huawei.com,
	ulf.hansson@linaro.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v5 1/2] pktgen: Automate flag enumeration for unknown flag handling
Date: Wed, 20 Sep 2023 20:56:57 +0800
Message-Id: <20230920125658.46978-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When specifying an unknown flag, it will print all available flags.
Currently, these flags are provided as fixed strings, which requires
manual updates when flags change. Replacing it with automated flag
enumeration.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 Changes from v3:
- check "n == IPSEC_SHIFT" instead of string comparison
- use snprintf and check that the result does not overrun pkg_dev->result[]
- avoid double '\n' at the end
- move "return" in the OK case to remove "else" and decrease indent
---
 net/core/pktgen.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index f56b8d697014..48306a101fd9 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -1318,9 +1318,10 @@ static ssize_t pktgen_if_write(struct file *file,
 		return count;
 	}
 	if (!strcmp(name, "flag")) {
+		bool disable = false;
 		__u32 flag;
 		char f[32];
-		bool disable = false;
+		char *end;
 
 		memset(f, 0, 32);
 		len = strn_len(&user_buffer[i], sizeof(f) - 1);
@@ -1332,28 +1333,33 @@ static ssize_t pktgen_if_write(struct file *file,
 		i += len;
 
 		flag = pktgen_read_flag(f, &disable);
-
 		if (flag) {
 			if (disable)
 				pkt_dev->flags &= ~flag;
 			else
 				pkt_dev->flags |= flag;
-		} else {
-			sprintf(pg_result,
-				"Flag -:%s:- unknown\nAvailable flags, (prepend ! to un-set flag):\n%s",
-				f,
-				"IPSRC_RND, IPDST_RND, UDPSRC_RND, UDPDST_RND, "
-				"MACSRC_RND, MACDST_RND, TXSIZE_RND, IPV6, "
-				"MPLS_RND, VID_RND, SVID_RND, FLOW_SEQ, "
-				"QUEUE_MAP_RND, QUEUE_MAP_CPU, UDPCSUM, "
-				"NO_TIMESTAMP, "
-#ifdef CONFIG_XFRM
-				"IPSEC, "
-#endif
-				"NODE_ALLOC\n");
+
+			sprintf(pg_result, "OK: flags=0x%x", pkt_dev->flags);
 			return count;
 		}
-		sprintf(pg_result, "OK: flags=0x%x", pkt_dev->flags);
+
+		/* Unknown flag */
+		end = pkt_dev->result + sizeof(pkt_dev->result);
+		pg_result += sprintf(pg_result,
+			"Flag -:%s:- unknown\n"
+			"Available flags, (prepend ! to un-set flag):\n", f);
+
+		for (int n = 0; n < NR_PKT_FLAGS && pg_result < end; n++) {
+			if (!IS_ENABLED(CONFIG_XFRM) && n == IPSEC_SHIFT)
+				continue;
+			pg_result += snprintf(pg_result, end - pg_result,
+					      "%s, ", pkt_flag_names[n]);
+		}
+		if (!WARN_ON_ONCE(pg_result >= end)) {
+			/* Remove the comma and whitespace at the end */
+			*(pg_result - 2) = '\0';
+		}
+
 		return count;
 	}
 	if (!strcmp(name, "dst_min") || !strcmp(name, "dst")) {
-- 
2.31.1


