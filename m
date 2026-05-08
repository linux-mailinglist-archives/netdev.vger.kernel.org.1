Return-Path: <netdev+bounces-285928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELe8MLcR/mnBmgAAu9opvQ
	(envelope-from <netdev+bounces-285928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:39:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC3D4F9837
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BF8030650BB
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADB440FDAF;
	Fri,  8 May 2026 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9PM+uEP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3DB40FD96
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258289; cv=none; b=QMIXQefGME+2sUyraKfypjV/pSKQNlo3uW8CYmoC68Nmny1aSGdwVlbpXXlQ9oWYqbwHwEDebcRjzF1QpmWrOlTYga44lwH/5JJBuh8qwcZkAsMJbZf5+pEJrjDpUM98UR6xW62FIcmSk/0akhXxV2uoVTvZ77+UmgbL1jrgl2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258289; c=relaxed/simple;
	bh=wNU0Th5XFAiJ7y6G8CDjt/dAtEYXDL6KcaolFhQPjEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ONvvYJea8wEuNBWh7MHNCkf1yCbPwNf7Jxr5MxFHbQE1UBwPxPWDE6L+3MP4MvFP1T9JIy2uT8BeewsFj9RfcycxRP09xtKcs40lgLVGS70QMjamkfL0CudDShA5+frbOg4RvVym5s8C2o9PmypgxfC6e73cp4MTxYLBUqDcR34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r9PM+uEP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so20894775e9.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 09:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778258287; x=1778863087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WT56FP1Bt4LcxLxZsWkK8+jNPLJAOL9nE1Hwe4/BncM=;
        b=r9PM+uEP1VTIerMwcLlTxQTqfFiZsRbwjH47TYsZJUVlNKXLHDDOZfmrrQ58M9syDh
         ohtYUYUFMSCp6IJTO/NnElsvRuLWgo+P8mXLtarBTBPhLf8ehx0B7brv2EvYQE242AG+
         vho9obhSXoyp9WFVuZ34GH5P2c6e9gGxMIzdiI3kOnL5hxhiOa51ai+N06tbP2tVVxo7
         T1sms07yGafuNEj/qprrLSq/g9TGQszn7K2jrjlTxB0YzBQQTXt17DxvgS0wpaXgaA2q
         JMd1Rv813g39HnXgD9aK5XYVDM1rmayk0CfDp8IgpFdKmMKJx7vLPy4tB6NRAzYsZq/b
         V1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778258287; x=1778863087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WT56FP1Bt4LcxLxZsWkK8+jNPLJAOL9nE1Hwe4/BncM=;
        b=dLMfWTWAX7Qg4xS28R7ap99KqNBlD36keGFGEZ+VDuAXBD3kiuuII0Nyk0lf0c/6Ng
         nD9Hiq84pnpBZQ4eVvz1LiDuLYTT3eVPt6iEVwpX66zfm/S+poAFScHndAI+D6AUDUiJ
         M1MbLG8eEz8xJxLAD7HxL6+U+91zOmMuR1jQbJzf3dbwIPpCt37v6ECxRphlaPIlojUv
         c6XHa7SI+0N4Yy4h+AmFCf8q9Ycswwz6XbMNDNIbbscVQT7UEvd+vMadLbYnz9GIgnFh
         e5K13azootWg04jvyJBLFGAYBEf2AgXMxf4P/ucEfQq9vECbfzXPLDlI2aoBk11j2GNl
         YPJw==
X-Forwarded-Encrypted: i=1; AFNElJ+SpfNvl999uzDJ81WIvWsEn5x7M1QjLqQFocT6TbTC1JnTqxqmfTqzJutSCFiKonEB83Qw0HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF7gkrpcGHGqbPmDpFfN3WVN64jkAVGozDXlNAjVnlOeYFrpS3
	w2ELod7QTrcY49qodUmc1m7SpTw4lYv52XeiRG6rl/7QQljPUPq8XWRe
X-Gm-Gg: AeBDieuEpoODOdxU+/1xSDJDqsasoRhXkMn2rb97/rpVcKshsZuB0cAMnq1Q7B8Ze1p
	CiyJnjCjIeuwCxRU8h80HrGrEdQozxdGgjlKhyFiA+F6d5hg/5Ev57dzhnLK0rF/g7oVDb86yWX
	NRg+R400kYwNrEebqDg4x5iHuRkrLptrSgHNyWrFy2g1rytyZl5whD4XvVSmOitqew6irO60biD
	DypuBwC+ykHt8OLheIxz8BYOgJpaYEsAaUOSwAZopHGp83AcEKnzd16dY71aVLGvu6IypvA/GQh
	DVCKO2i9L36Ucel8YtOw9cOhVat1QLXXpGdH5A7nnu5opOtGEbPF/x/sJo2ig2O6tjFg8p3auA1
	SXtqL5kFyeiqQuanKQGFEg4k3eEKg/k0yJ5ktC/r9M7ZYNRciWGRx0cwBjNNKzMPsNXbAfE9b9z
	7pK0ekOc473syVAtEn5XJk4mzFUId1aFuME1gMhB7aZeGam5uz1rciwTbpbGDjWdHiMqo=
X-Received: by 2002:a05:600c:3b8f:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48e642deefamr69130145e9.7.1778258286363;
        Fri, 08 May 2026 09:38:06 -0700 (PDT)
Received: from arey-arch ([2a02:1210:7298:ec00:73f0:d2e7:188c:1f61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd32afasm6901045e9.5.2026.05.08.09.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:38:06 -0700 (PDT)
From: Adrien Reynard <reynard.adrien.08@gmail.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	kasan-dev@googlegroups.com (open list:KASAN),
	workflows@vger.kernel.org (open list:DOCUMENTATION PROCESS),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML))
Cc: Adrien Reynard <reynard.adrien.08@gmail.com>
Subject: [PATCH 4/5] docs: fix repeated prepositions across documentation
Date: Fri,  8 May 2026 18:38:03 +0200
Message-ID: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3BC3D4F9837
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-285928-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,google.com,arm.com,lwn.net,linuxfoundation.org,davemloft.net,kernel.org,redhat.com,nod.at,cambridgegreys.com,sipsolutions.net,googlegroups.com,vger.kernel.org,lists.infradead.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[reynardadrien08@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
---
 Documentation/dev-tools/kasan.rst                   | 2 +-
 Documentation/networking/switchdev.rst              | 2 +-
 Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 4968b2aa60c8..3a8bd40ad905 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -392,7 +392,7 @@ reserved to tag freed memory regions.
 If the hardware does not support MTE (pre ARMv8.5), Hardware Tag-Based KASAN
 will not be enabled. In this case, all KASAN boot parameters are ignored.
 
-Note that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
+Note that enabling CONFIG_KASAN_HW_TAGS always results in-kernel TBI being
 enabled. Even when ``kasan.mode=off`` is provided or when the hardware does not
 support MTE (but supports TBI).
 
diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
index 2966b7122f05..948bce44ca9b 100644
--- a/Documentation/networking/switchdev.rst
+++ b/Documentation/networking/switchdev.rst
@@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
 monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
 bond will see its upper master change.  If that bond is moved into a bridge,
 the bond's upper master will change.  And so on.  The driver will track such
-movements to know what position a port is in in the overall topology by
+movements to know what position a port is in the overall topology by
 registering for netdevice events and acting on NETDEV_CHANGEUPPER.
 
 L2 Forwarding Offload
diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
index c37e8e594d12..7b08738c30aa 100644
--- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
+++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
@@ -1092,7 +1092,7 @@ be formatted as plain text.
 
 Developing always goes hand in hand with debugging. First of all,
 you can always run UML under gdb and there will be a whole section
-later on on how to do that. That, however, is not the only way to
+later on how to do that. That, however, is not the only way to
 debug a Linux kernel. Quite often adding tracing statements and/or
 using UML specific approaches such as ptracing the UML kernel process
 are significantly more informative.
-- 
2.54.0


