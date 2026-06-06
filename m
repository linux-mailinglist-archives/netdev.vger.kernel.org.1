Return-Path: <netdev+bounces-296107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S/TtJYcbJGoW3QEAu9opvQ
	(envelope-from <netdev+bounces-296107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 15:07:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 907E364D953
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 15:07:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GCXT0SLQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296107-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296107-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 735053002D22
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 13:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF4C3ABD88;
	Sat,  6 Jun 2026 13:07:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5E305057
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 13:07:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780751227; cv=none; b=mN3Sl+YXw7hiChOA14B1GYyaim6MDBNg8HI4P9GJ+iveiXCJ0hcnqV8abTknfYYmkWsSvM+ptPSLV11zNuGZE8/pLkyvQRbhDWfri+oUfJYN9DKNVGCB+G/FCILOTSEmqjGikdMcyva5K81/5805CIbQfEdg1/f0MuZxJHrFa/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780751227; c=relaxed/simple;
	bh=zGAZQLnnO8wRdkqImUtN/1JljtVR1Sb1oGyOfKSdwwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vgg7LiiFpueS1qY/zCJx86DzG+i3gmIdIZgnOnjhwxXufTUgjLkKqDqCnttbRG4MYs70OqCighM5ZS61n4ojVw82+YKngy2M5VzqmFdsANy1PgVaHe33y/wR0autlI0CSXKGiZCEFLexfQiAKaio0kkiCoC4RRKuBO4IMj5I4BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCXT0SLQ; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c3184c71so22003005ad.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 06:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780751225; x=1781356025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FXutoFiHd1QWVLtGM5qFwqc7LjI/s5kpy+TgHDVlLiE=;
        b=GCXT0SLQZlrevydQF+/WlDlfYQEwCST7Bu/Mj7TxF2lSAwy33zy4FPf0PQm1scpf0f
         Z/hJafNgT848VgTTzjEM5CqWTgg9nyezQwqHOLS0hu1Eo2W3wlyC9++cj7D164SCQolY
         DBcV++PKbG4J6tnutEC6LsYH4+klq7xvRdWxO7TnBjRC94jkctFQd18f+jhvhjpjQxmS
         tXpj5WV3J1fB+3RkfIqrB9PKNPqmq5gnAW6Ux022Z7R8AYlkyj7wU2Sy8f1MvHjHa/+m
         Cm6GfZPvgPuBP3NheYfdJAYa+PqyWl/khmeP/CJHPjbXRjOQQfP9eqYWQ0IJ1xuymazy
         nqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780751225; x=1781356025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXutoFiHd1QWVLtGM5qFwqc7LjI/s5kpy+TgHDVlLiE=;
        b=ir7Que3Fv965sG0UyJ78jBneb3NfGSGwCt9GraxJzz/AzfYzmdCFEOpW6V6lcsWJFe
         jpXmpqv9pFaj+l9LjQp9pupdHmnxAQZ+twJGqnnZzDmFMTAh6+iMms0xx4QRbT1G5M/n
         jw+DlSL756OxUgMLcdJccLmGnX4l9F3CUDtZ1KYnxbzyxZLRthQ6/Cl4JChhtZXuRfuD
         ndcBMF61wnBjJvSCa3chPgen5LTSUs6Apgp5liNOxQ5ryXikrbPGF4/iwf7wxW0lZDJC
         lLvOSnuqMDFyqZoLdWEpP7dFueGF/NNGTYIk6eNPxKp7kEwKRPlr6hvXmpMiIQ09L60j
         oLeg==
X-Gm-Message-State: AOJu0YwRh+KdKrnjJtUDvA+l5QIO39SvUxpX8e+EtDT5bWCwARjPpX0h
	cQLPRhQ0uF+6KRuyg2fVr/d3IspBlPfoLgcnKNT5/MHPyx5vfHPYLxKlUp+r6o81
X-Gm-Gg: Acq92OGxrs0Y7vW8m5h48IQhl88umQZt/9H14DpvGxoW8wdlqb8SjRdW5ki/eF7motm
	VNnsc+c1aQg8OY71bOncfHGZYyhG/nJf93gANNjn0eINxnr8pOClMpqO0gq0B0oasHdDdVjRu3Y
	f1XA8M8FulN1D+i9gKwvgeFB4+Baje0QIunqxHHdr40Bvb8hKhvNl3T1BBQMO8v0SfvQcxHsFLv
	O1JmcJFGLI4zWqND7O9cSoskP+gDefsVdxjvNWM/iEGfLSzZ1BZVwiOGgLWSWu1F1KkkXA6krEK
	55t6fsCEP5CddPnccvFy7GyGdLSJFtE18sT/GXe9NUbgMYWzOA9aC3RESWD8Yttf41kAzRFX9tv
	QRUbQKQGm9HObEcJ7kwde4W5ffy+S5CCf17/csvR1VZmIgd81YEKKPWvJ8XHbvoP5wRezX/rTdP
	gapITj0q1xB8fHxfHPCEQ0btnpug+lE9WTXE0DIoSp1byl0iFCkkcTHRkaGzRiqRLvbp/iWSM=
X-Received: by 2002:a17:902:f64c:b0:2c1:5a24:b4ed with SMTP id d9443c01a7336-2c1e83541f3mr102636255ad.37.1780751225401;
        Sat, 06 Jun 2026 06:07:05 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661b:3046::4cf:38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e627sm126349745ad.52.2026.06.06.06.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 06:07:02 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 0/2] net: dsa: yt921x: Add ACL support
Date: Sat,  6 Jun 2026 21:00:05 +0800
Message-ID: <20260606130011.307812-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296107-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 907E364D953

v5: https://lore.kernel.org/r/20260602083755.79411-1-mmyangfl@gmail.com
  - validate tcp flags
  - fix TRAP action
  - unconditionally discard rule on deletion
  - trap traffic when hardware meters are exhausted
  - avoid devm_*
v4: https://lore.kernel.org/r/20260528193726.1893365-1-mmyangfl@gmail.com
  - make use of software fallback
  - guard duplicate POLICE and PRIORITY
v3: https://lore.kernel.org/r/20260523020704.503966-1-mmyangfl@gmail.com
  - handle ACL tag code
  - fix the upper bound for FLOW_DISSECTOR_KEY_PORTS_RANGE
  - extack messages when possible
  - check the redirect target for FLOW_ACTION_REDIRECT
  - fix candidates overrun
  - fix the activation order for rule and action
v2: https://lore.kernel.org/r/20260520022242.120640-1-mmyangfl@gmail.com
  - v1 was mistakenly sent as v2
v1: https://lore.kernel.org/r/20260514192140.3468543-1-mmyangfl@gmail.com
  - fix issue reported by test robot

David Yang (2):
  net: dsa: tag_yt921x: handle ACL tag code
  net: dsa: yt921x: Add ACL support

 drivers/net/dsa/yt921x.c | 1072 +++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/yt921x.h |  286 ++++++++++
 net/dsa/tag_yt921x.c     |    2 +
 3 files changed, 1357 insertions(+), 3 deletions(-)

-- 
2.53.0


