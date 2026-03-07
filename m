Return-Path: <netdev+bounces-265122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG5JKPkErGkxjAEAu9opvQ
	(envelope-from <netdev+bounces-265122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 11:59:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 815F622B401
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 11:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01C5B3013458
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 10:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3A634C124;
	Sat,  7 Mar 2026 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzwcV/An"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB8734AB1F
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772881134; cv=none; b=axHikzGZl+q01oxGR4ROaS2P3Np0UkGYLp2TL5aPqCdJTI03k1s0oTCFi0tX9TogJ9eHq+bBvaL9dJoDONdbWG4tSgwNHcX9dfTJV3tU0vydRwJ9/hubX13r1vvCFbw5WldkLy4vyuUJRVg+ziBNlcx1vxwe2bgsm4WKuCVFw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772881134; c=relaxed/simple;
	bh=93TQgJ8fwIHqNzuPGnTauQWb0Q4gUaZfsNNvvAc162s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4KgtBr9emafWsbNlSioQKXJ7mK5YSTvTssuzVcp0nCMusvR407QtO0qOC7cjnxTWn++TP3F5Zf9TFVP+SGubwKNc31Xm0KBFN0yu7IDmPL3DCHmgK+vpz2vNVzMMEv71oD0J5T9lFruUL1M3ySpOMy61xlzwmH9bEzDsYsBnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzwcV/An; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cbc593a67aso957260685a.2
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 02:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772881132; x=1773485932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bJqlJHeOUmKAaYm1Xbyn5/BnRtTCsqfQBFGOZH+2Y8=;
        b=fzwcV/An2OmjpEAYf3cQlM81ZylnZ8Hqp+md6TOroRbXs/covEr3edpNtnc+r3iRsB
         rDUEgoIo5UdDHVX2tg3x/tKd2OKNq970KkDqyFiI6g0GR1ew02UGEVpe76tGXUWxAXcQ
         Ry4uKKZT+3SaZ5go3oW7WJQvpdz9Jsp8PTRaY8bqjfUCMDLwLa0Bv29LlhboZnVUYWjh
         qXr2VGjUBSHz6KXlWm/kpe1GtZxP9nUMbEbOMZLUZiCzQb4gUSM+bFRXmFfau54uzAQO
         eCTtCukCljGqNRI9WQBznP1sC4wwr7FMIZnlwOOhUCu0SfleqOtXIr+pJ9Wxv5x96wZW
         LGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772881132; x=1773485932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+bJqlJHeOUmKAaYm1Xbyn5/BnRtTCsqfQBFGOZH+2Y8=;
        b=Xb3LNboCwpbeG/AuYhWDr2FMSGJQ/e/6nR9ZKZFDZhYcWBe4Fx152Qa916CCS56Nh8
         EHdiX958wiw9L6BCSFe/xwE9hgAxi3LoPCRzxnQu2eFwd4ZNsJmkXAh1kPDtNnuK9F4o
         bDJYXdzzC5+UpN9/vg5a/Q9wTJk2aA3mdvO3Jb/j/CPfjwxN9Rj+W3JLFALHwELiSLQN
         /2hDJr3WQ5hkHd4+Va2p65wXq9w1jIwpGzLSuICo+lebNQeyfJJREMV4XRQzTZSxofsd
         OARCPCZbAdz+e6Rn0ANoO8ZrLi8mdVwVCVMg6EnEgqTezdYY4MxcQESZNmhkb/mZ4o8W
         BWRg==
X-Forwarded-Encrypted: i=1; AJvYcCWb73ROGBzXHDdwGPZpKMjwUuMCOIL6VCVgOr23MwgpN1Tf6j8U1u4kkO7Crb5+thTYhtX/fng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxViK0cMS5bKsBbgCt772ME7e3dVOM8oDK/gfMxKVIhAoTBNW8
	BQt/tR7xe8AJBeH8Rxzxa04txawcEhxRBI1IHVIWg0Of67DQ68Jertur
X-Gm-Gg: ATEYQzymQLAKBPdmJBszAwdEA3CFCqOLpQo505IHmdH8qq1i1he0IYS5lZ2eIkdbGLt
	ngU8U3GF7XP6i8Lczg+87dvWWlCCYnmeTQaIjX/WGkaAfgFFS8smhHqv6fdjPAxXMXegEUcEiwI
	8gpghs3pXZjzF4sl812Qu31FjxPmpWz2+J4is9lxLTHBrqBhR5hhE/Q0SdSszxWLIHoR0YKltk+
	ZGpTjLLDxSChQZHZUZQMcDMDw8lXqYEbSlQqNEu9bhPMhgOZ0GTytWMJbtFOSwn88If6snoH9Hk
	+ftQTyjt8laxIuhKtjvZiEsXJpRUvUaVrWqvwECWibTKNOwZoqAkCI1uiH2dr15F2+ZV+HIhISM
	cnq2qUuXCLUg591ABYzqo9CvRMvMaIRYxQDmCuXNKHwivTyOewoWw1CsMgAKwsiHJfnhKppAcCk
	BaOqXhCel1AhI4wckkzxY2dh/oVHlLljxWSYb1/ALbX8Sw3vpMdoM/Ca/u
X-Received: by 2002:a05:620a:371b:b0:8c9:f8e5:9f0d with SMTP id af79cd13be357-8cd6d37fabdmr710288885a.32.1772881131520;
        Sat, 07 Mar 2026 02:58:51 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f4a2fdasm293278485a.17.2026.03.07.02.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:58:51 -0800 (PST)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Lee Trager <lee@trager.us>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/5] net: export netif_open for self_test usage
Date: Sat,  7 Mar 2026 05:58:43 -0500
Message-ID: <20260307105847.1438-2-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260307105847.1438-1-mike.marciniszyn@gmail.com>
References: <20260307105847.1438-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 815F622B401
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265122-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,gmail.com,trager.us,linaro.org,kylinos.cn,fomichev.me];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

dev_open() already is exported, but drivers which use the netdev
instance lock need to use netif_open() instead. netif_close() is
also already exported [1] so this completes the pairing.

This export is required for the following fbnic self tests to
avoid calling ndo_stop() and ndo_open() in favor of the
more appropriate netif_open() and netif_close() that notifies
any listeners that the interface went down to test and is now
coming back up.

Link: https://patch.msgid.link/20250309215851.2003708-1-sdf@fomichev.me [1]
Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 203dc36aaed5..964503d403f1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1731,6 +1731,7 @@ int netif_open(struct net_device *dev, struct netlink_ext_ack *extack)
 
 	return ret;
 }
+EXPORT_SYMBOL(netif_open);
 
 static void __dev_close_many(struct list_head *head)
 {
-- 
2.43.0


