Return-Path: <netdev+bounces-278676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD9uFjEy32lqQAAAu9opvQ
	(envelope-from <netdev+bounces-278676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:37:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C45400E26
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98B2A3026338
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 06:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF1739021A;
	Wed, 15 Apr 2026 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzME5p3c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9EB38F624
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776235036; cv=none; b=Tb7S7FmawG4dKFrTffXy2vz+u6/1De9v8bHqn+KhmU7j/Qsz1Ed6s3o2O3pOiP8WnMvB7hpR4VbIHhrTsjdqeay8+iOGuTk5Tu8Ab5ldM0TTQe/GYrL9Z379Jv/dv79IIfUE+lJvmk9GPeT/tEDpypjWhhugzUowazGISLA/1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776235036; c=relaxed/simple;
	bh=yJ9CzZdh0ITtrg/Qg4Whi7FTsOhB5NFwZmHZHk5gvDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XyRSVEiaG/I9UOVErPXWU9qw/ysYZhyRFvyGOfY5RnyNtwlNBx4UjNd5N1eiaeK9j60SxPrvzraW1sK/D9wTC9MV/6T/wAknTwCd0/Vlke3o+q/Xrf31FrlBt4i4pt6ZUvV+O5R4f3IDc/Bv7irZkeSBgB8mnV4xSKlb+CPQ5Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzME5p3c; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506a6cf8242so48843991cf.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 23:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776235034; x=1776839834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rrC9vNrM6E6rzZeBaqxVv48Wut0j5e/JM27h9uWS1lQ=;
        b=LzME5p3cZ//ZOSu7QCVtD6m3PnoYyPtXmpsibWdgflbxsNBCfy2GRVPZNtdXHqqI09
         9wjUKpf+PObtTmjsiMfPiWuoVqIMwf/xCf3ghGfEYCmF5/4dUhH1ojyedtqPzaGptyU/
         pyA3mkEhLMSfpIBlkbt7FGp3+Kejsix0vVXOKilLFDxmvBjbY46Ujf48/4d2XkoZo6fQ
         Fr2qiob10hzpVyUmkek0gYKDiMo/tVcEsKSlNeZYB1un9G+Rjb/g8id3kFkjZWWtP2Td
         z2Q1xN9aZtsTMMWHpVDYBnZ+uYfehu5FMFAyOpfEDUgPSJxBPfQTpJbFOcq19HFTI7jK
         o8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776235034; x=1776839834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrC9vNrM6E6rzZeBaqxVv48Wut0j5e/JM27h9uWS1lQ=;
        b=h9ObW+f7Of9WksJh1A4FPQNdKYpG4Yr6wBSfJspVx39m3ZfOQTMy9h2pBISMIFCj1k
         p7nX2H3bVz3adB+4xqVZ2n7Rq6DylmGVRJZYeTg8em31/6Cg3139iXdo0Gz0SgGkYFYK
         DzvBpBfm5nOeekDvTJhQSu3t9XWWLE6ajqPWLl2ro54UKG1TJDOmH1oXSjzUUTYUP9Um
         boneOG3sc0sshqkWWZSeGwN/8IRl8XU35uRihHs3/wV1L22zg6evOlyJeF0aUWBKDjag
         8IPNg0ozaO6yIYHcuALErslNxVNagB9IXd/ixXG4QXoKeERKsBMfgBKDzdF6JV4r2zlC
         CWGQ==
X-Gm-Message-State: AOJu0Yxhd5Amnemd6F2OdI/QaX8b5JdrIptuGZMd82xzksspiV8C98jF
	gAi31CVvBbamM4bUeXWW+6iuAbnACV32ls0DfZ08+mqtH0TegBB/KYsa+gNz5q5U9KQYiA==
X-Gm-Gg: AeBDietLxV9d305gyHJQMJICVy3Mm4iFuV8vqt/zxuVuNwZhH2kiW8mJpQMMlJ+M9f8
	n4lou03voSpo6Ek40TclhvdfSem9EJDxSsqk9SUazFwzTMkZzOU8If7KxjkYv+TC9CHRslzwkWQ
	DsCKVbG0e1CVedup2M7nhrNnJIXDO+x0Pi08TEkokDp6b8uKl//c9EaKguKoCkyXVwHPoqNn7I2
	rfD6Q4syIPP9PmziUNmrUC471iucrYti9Hl13HiMuZmXpE2Mye0IXGz4WtCLhd3guF6IXPNGzuj
	86UD9a4+nawDWQcciYkLjKlJTX9B3F1PAZiCGr7omLCVgjoMWku8PtIbSD1W+vxmfNi0vUq57hU
	mtuoBR3thse903zZ4TJ+YOf6nvv8ZCTkS2GqzJ6Xx4lzpufKoZEyVb1ic7FnMjF6tXyOTdkrEG7
	UJPMLtLxNhy2Qv+9OlqTCm0qS/6wcccpuyS9lVfjbof1PHJXr1M4AMSNkzopxyLwrNkRtVxFY8Y
	E97zzTaPr8JhTEaSRmOjQI+Z7uAUJP8YJQVwYA=
X-Received: by 2002:a05:622a:134c:b0:50d:82ca:7c9c with SMTP id d75a77b69052e-50dd5adaf18mr314133561cf.14.1776235033794;
        Tue, 14 Apr 2026 23:37:13 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1afebd48sm6222121cf.26.2026.04.14.23.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 23:37:13 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	jreuter@yaina.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v3 net] ax25: fix OOB read after address header strip in ax25_rcv()
Date: Wed, 15 Apr 2026 06:36:54 +0000
Message-Id: <20260415063654.3831353-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,yaina.de,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-278676-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6C45400E26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A remote station can send a crafted KISS frame that is just long enough
to pass ax25_addr_parse() (minimum 14 address bytes) but carries no
control or PID bytes. After ax25_kiss_rcv() strips the KISS framing
byte and ax25_rcv() strips the address header with skb_pull(), skb->len
drops to zero. The subsequent reads of skb->data[0] (control byte) and
skb->data[1] (PID byte) are then out of bounds, which can crash the
kernel or leak heap memory to a remote attacker.

Use pskb_may_pull(skb, 2) after the skb_pull() to ensure both bytes
are in the linear area before reading them. Discard malformed frames
that carry no control/PID pair.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
V2 -> V3: remove incorrect Suggested-by; add symptom, Fixes, Cc stable
V1 -> V2: use pskb_may_pull(skb, 2) instead of skb->len < 2

v2: https://lore.kernel.org/netdev/20260409152400.2219716-1-ashutoshdesai993@gmail.com/
v1: https://lore.kernel.org/netdev/20260409012235.2049389-1-ashutoshdesai993@gmail.com/

 net/ax25/ax25_in.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
index d75b3e9ed93d..6a71dea876a1 100644
--- a/net/ax25/ax25_in.c
+++ b/net/ax25/ax25_in.c
@@ -217,6 +217,11 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 	 */
 	skb_pull(skb, ax25_addr_size(&dp));
 
+	if (!pskb_may_pull(skb, 2)) {
+		kfree_skb(skb);
+		return 0;
+	}
+
 	/* For our port addresses ? */
 	if (ax25cmp(&dest, dev_addr) == 0 && dp.lastrepeat + 1 == dp.ndigi)
 		mine = 1;
-- 
2.34.1


