Return-Path: <netdev+bounces-299958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GU2LEbC5MWoopgUAu9opvQ
	(envelope-from <netdev+bounces-299958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 23:01:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA04695562
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 23:01:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=H+vzG6ss;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299958-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299958-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D349300B2BB
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED37138237F;
	Tue, 16 Jun 2026 21:01:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D6928A3FA
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 21:01:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781643689; cv=none; b=N5ku65Xsaherp2/s8nByWVSQdPZqgUHGOixetycE1fylxq2NpBRPLLkUKdaB9olzNjQKk+3C6iBYWd8LE7DAX2ekn7F9zos/MfpO5wunrGY0uRvyflIvmALp+GIE/ZbLnmAeHJM4Vg93rtWXExW0+99Y0c453vJtQuK9Wt04b3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781643689; c=relaxed/simple;
	bh=QL+6PjHmDG2RTHrGkE252ABZ6JjJ3rD26t7BbfcIWXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kMtVkR5oV2K/2jwEBamvDJNGWzreQoo7AsaWqpgg9R3AFJ1WXaw7Dvi1la00Ae0lfuFAB0lCI59JFLQ1eXYHsSa3mV7jrl2UxXQbtJ8l2h7ttUjyOz/1AYYukt9WgwFSeK4Tjwo78Z5u1VQ3/+n9WKc4kT5vTQ98r8A6kccPfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+vzG6ss; arc=none smtp.client-ip=209.85.215.170
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c85a2ca7bf7so1867786a12.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 14:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781643688; x=1782248488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YAWzaQQD+TwU42qVxhk3XlLYYY09pYfRsBqz1erTu+c=;
        b=H+vzG6ssF550rx91nyVuUbhnZ7j4qx4/RcNrX4b1suEcGYBKElKdrAo2izPSQOpB3x
         kW2KLSEh6r1F5vd33ZPwhpftZYYtD2YLnMOeN7t+9frWYm4KAPGTUKAHcKMSYrskofYC
         k8fS+pWTKxhO1pPTVFJJ6obWehmCD1jSjuGub22VHnIo5hpVUP/vGkD/bUioHNQotvJI
         PBT1F14z1AxI5LAJAk6ZXaE9f7mN4sEf16jMU7c6HJiZ385RGi9kokHGtMQE8rok7a7g
         +FEh8HC4QGWKs0dvQTH/SLYq+A+v7ct8/3hmnBp9Xfvr3e7fhgtulvoVXh2WraXNVgMh
         ba4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781643688; x=1782248488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAWzaQQD+TwU42qVxhk3XlLYYY09pYfRsBqz1erTu+c=;
        b=mAYWDR3q2Vt7hKf597Wwm2i0khpEimMyjva7f4yV8t/NLXHly92v74qjheF6F93ytc
         JgpXPyenBVKsTblCOcELOHerEFKmzvp1ww5ystaFyXlXYf7qI5Fa6IDeszeK3THE5ode
         GMXdxj21aktky9gxEnKgiMkEGHwF8E6e+SUul1FjyadunYY5l+PLVjnmWDYTCFDcwxaO
         UlJ61suPxA/lgK0jGNyf2ZCJ4Z7qBcVPUuLODPXizjsfENtD/NoASRMGnwroxJicsQ6A
         izHr0C2cyWIZhf3Xhm+IIBIM/xxDSHBma7jRm8vToilYJQ00+0cGKHy5+uG0yWk4GFO2
         nU4g==
X-Forwarded-Encrypted: i=1; AFNElJ91mmJLoWVOmMQIymgzIRKN0G6wdbRcV3R6EG48S4c+jjyvTGNvBmJrMOx0z2v5U/eZLrUGIzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE8ZDsEWNBwBwlufPHjIDG2Z7PP9IxtQW6w4I+wREZc++erAAZ
	5+M+LX1hdKwaVeVFW+WrvIiK/Vebsh6SQJX5OR99YyFgg4SX2APwcojG
X-Gm-Gg: Acq92OHMi4afmWvSasxe2MQ1IbDjwO+l0lHquEZ7+cZXurvEHS0TKPjS1XVXDMwBqD9
	VxuJxTNToBJVDMgmu0G7PaKRQE+UCyGl//cAxtdRxFwoRt+6IuRiDsE1ly7G21h54QzMOSYdYi4
	ghBfJflpDFbVEkhpKJLxzL6+lt3NgABjIVmuQRL5QORolzjn1tJPJuqJOmcafPPuMHvalANOScI
	oz472uRCWthPdKKhDAfegePvga6S5kv58vzzYSi1JdMqfHmsHBC8NPV8vJWQRJP7NG8kvnvxqjN
	QY0qa/62aTBKnXcZ7Dy/QMb46Zi0zYW71hh3bW8RnJ4DFlDWfLBlG0Mm/vCHKBe2xU8ZaTREs3w
	AU+7OhqnX9s8fYABfjzD7yFowhL0JWVk4xyQM9/Ng0D9IFqquFMrCBdojkcU7445cw2qmQ55Rdu
	weEtqewbZpXY5F4Uuvxb3SfoIkCbCKjK4ZhSYpf7Zf
X-Received: by 2002:a05:6a20:b603:b0:3b4:6155:cde8 with SMTP id adf61e73a8af0-3b8be3b191dmr870958637.21.1781643686603;
        Tue, 16 Jun 2026 14:01:26 -0700 (PDT)
Received: from localhost ([2409:40c4:3a:b56e:6db1:8c82:df5:7a4c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5e974sm12333720a12.4.2026.06.16.14.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 14:01:26 -0700 (PDT)
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: anthony.l.nguyen@intel.com
Cc: przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Subject: [PATCH] e1000: Remove redundant else after return
Date: Wed, 17 Jun 2026 02:30:08 +0530
Message-ID: <20260616210008.109635-1-lovekeshsolanki00@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299958-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:lovekeshsolanki00@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lovekeshsolanki00@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lovekeshsolanki00@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3EA04695562

The else branch is needless because the preceding branch
unconditionally returns -ENOMEM

Reduce nesting by removing unnecessary else

Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 9b09eb144b81..3d97e952c916 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1546,11 +1546,10 @@ static int e1000_setup_tx_resources(struct e1000_adapter *adapter,
 			      "for the transmit descriptor ring\n");
 			vfree(txdr->buffer_info);
 			return -ENOMEM;
-		} else {
+		}
 			/* Free old allocation, new allocation was successful */
 			dma_free_coherent(&pdev->dev, txdr->size, olddesc,
 					  olddma);
-		}
 	}
 	memset(txdr->desc, 0, txdr->size);
 
-- 
2.54.0


