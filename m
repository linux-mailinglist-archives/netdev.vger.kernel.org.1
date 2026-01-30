Return-Path: <netdev+bounces-255264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MgrLLYgfWmkQQIAu9opvQ
	(envelope-from <netdev+bounces-255264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:20:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1ABBEC80
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 258923014127
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA36349B1F;
	Fri, 30 Jan 2026 21:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhqRfTd0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D5B3126A0
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769808048; cv=none; b=TddIpzxk6xvTS8nRQretuIhAGfJsSbxLqfMW/Ur3Bqub00VifO1rSwZyyurbp6Wlq2neP0m8lRYeSuM1Vd/LtfrlW5gcy4w3uYhukYBg1EvoaYoMp4WTA50f4JxBYH7j2UYzo/XtiyADlG/txPd5DKK2hASRypitCZTkJYvUn2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769808048; c=relaxed/simple;
	bh=O6DVy51tK45M5Ru/B0lKi3tsE9n3lqKvhT7HQFAiUzE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=plbv/Crg6N7bW5KPOpYOlcLnemx9inlBsgofYdIkvnYOncwpOtah+MR7GHOAr6xQLNH1A5kQ9zSkuSrpIIPUp7gceXpASfrwRqTAf8XdqYJsoNzSdReZNI17rS5S9Z9efTpA4teICjoQ3WMmXHJAOm8w4JbWYhmQXW1VCWSr9Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhqRfTd0; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b720bb90d0so2709399eec.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769808046; x=1770412846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3E5SSWeJBgLlbOqkeHjP949TlCZuP4YQ9p3foyNMLg=;
        b=IhqRfTd0ehn8btdYoa78j8Qm8HJYzcG/pnZ1+3XDdwInh8JCDBHTazQgKbvrlyso3o
         fgAqRmtcfrLCm+GXeUGIoRUJ2zIhpOSbTBfrtSLPFHAjyNpqo0YYAI00goPoqIPqeJpM
         //CZPXpjdEsx5KVRmQjCdKHexjCrlyfrP/KN4BvjDvOaHK3s+6qTE8wf40a6wFd29G03
         2liNBIa0Xgwi6Asztwg+bJeE8ommLEQ/H3hCYxL3jVfVLHYZE3+4rvABh3fFXmZ2PzKt
         hfElc7iHnCXm2ifhdGHjU2i6xZFKIjWhI8ONJnVSyyniWNEA/3cLAxEuR68YKWqmr0uf
         5TIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769808046; x=1770412846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3E5SSWeJBgLlbOqkeHjP949TlCZuP4YQ9p3foyNMLg=;
        b=WZdl9ugMI8L2wyjiLV1GE78ixdtna/OZ5YpbdmxoZDFuBPkluguP3a4mTwEWzOmJt6
         Q8zZcmPf2sHyiE9WPBUnU9zivhh9u3VsjpIE7hIHinHOJzNU9YlzGjhvewPLXIkbBY2c
         hjE4yxEGytc4zBXE6OqkK4GichcDhBR+PVYc1bX7JuKneAtbF07Y+YuxiaYwRSkRBW38
         6/DcfGiooWrt9Q5RjtvKwdwhJ4p2CswvUF8XViHIi+mFIcIN5wDGY6zCQZILJGGsnhHH
         0lSvR0z+/ECgy5bx78tIemZz+/RLBeibaxyubHTQD5cUY+/CM2rjG6fk3yLht+MKabP3
         /zGA==
X-Gm-Message-State: AOJu0Yyq0Ib/llis45Ta93LOZVTqRF20MfDi+AlyNNuTotS40m+frC//
	KTs9T1wFYanICZ2V4qsrDOdzgbT+2uwwRH7myAGGBzlen1SO9lq8yY3GaDR2iA==
X-Gm-Gg: AZuq6aIpAnWd9OkVVQeWqNl7A3EpgoVGamroMBeITlIiULL0LQRz1cxh+wH1r6+xjOk
	izuW2ekkApWPy69HqedjFzSfycEIeUzmU90me72zkKmsFhixF9wc7dts8GFLqnfHK6v8otwrlhx
	1LNqy05KN39/0lv5J12QTkWvaJFUtV1ou+er5xHc599rGK70EPzx8ejkmZQuByO+Pko3r2s68HM
	me5K/N0qKWZkSpNK0XoX0ram3xoEzRkdAjR1PjLZzi4CmsXUCgckUOqtNmqIl23oBZbKuj7Y8zW
	TWhb7PINM4Nf6DiG2maSJ77jYar45EUFfxgW5mr7XFVtlTS/SwAf0IQ+AB2zvR6a8cfCVe8skQQ
	KRqau8j+lX9QtMADNoy2J/KLe3mCyZhOE5ov09ZERAnrocNHUo0yhLvrQRZh4DYzqvkrUOqldI5
	vGMpwYJP2Uwi0vuSS5iwa0WQ==
X-Received: by 2002:a05:7301:1e48:b0:2ae:5dc2:3b11 with SMTP id 5a478bee46e88-2b7c86348f4mr2204556eec.2.1769808045493;
        Fri, 30 Jan 2026 13:20:45 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe92dsm12655925eec.17.2026.01.30.13.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 13:20:44 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jiri@resnulli.us,
	kuba@kernel.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net] MAINTAINERS: Remove myself from TC maintainers
Date: Fri, 30 Jan 2026 13:20:21 -0800
Message-Id: <20260130212021.46610-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255264-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiyouwangcong@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli.us:email]
X-Rspamd-Queue-Id: 5A1ABBEC80
X-Rspamd-Action: no action

Recently TC maintainer Jamal intentionally a broke reasonable
use case:
https://lore.kernel.org/netdev/aG10rqwjX6elG1Gx@pop-os.localdomain/

Although I tried my best to help by:
1) Strongly objecting this breakage from the very beginning
2) Reverting it and offering a much better solution
3) Offering Jamal for video chat on 8 Jul 2025 and 26 Nov 2025

None of them worked.

So it makes no sense for me to continue caring about this subsystem.

Most importantly, intentionally breaking reasonable use cases is
against my moral, I don't want to get ashamed.

Thanks for the opportunity!

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12d0858e02c5..d9f4156dd7d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25468,7 +25468,6 @@ F:	kernel/taskstats.c
 
 TC subsystem
 M:	Jamal Hadi Salim <jhs@mojatatu.com>
-M:	Cong Wang <xiyou.wangcong@gmail.com>
 M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.34.1


