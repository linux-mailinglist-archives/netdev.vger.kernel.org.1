Return-Path: <netdev+bounces-262385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGJaHq0dpGlkXgUAu9opvQ
	(envelope-from <netdev+bounces-262385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 12:06:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F03B51CF413
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 12:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86CA23015A60
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 11:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF164308F23;
	Sun,  1 Mar 2026 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxGhjSaz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FEE2D9EC2
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772363176; cv=none; b=E/3Xy0pRXBpBNyTyLgbkSeFdF4+VLY3kpcsuW7tSAynwhTi89iT1i8mhxvYCPy9R25+KDemxX8qBeDsmcv0eKSZFFCp3kqOo39qk5EWSHABOItGfuYc5Agrc+2W96b7xn+1SerW/hR7zOYLOJZbWkUcx9HmyN61fkCRHl5YN+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772363176; c=relaxed/simple;
	bh=mRH3xKEK4rDJ1na/2dFebNCA+wGDrTgkC4NvwtV1EcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIifIDrLTsDO7669IUugNN9RT88XbdcFGiFIP0cteS0fiIdlbmRYa/y+25zePNEuSydwCgYN10OlcP6pjBTGytVaS7gNUyTaKVC6TnGEVhpgIG3Lj0/lpijg1j9k5/Ln7GkbNahRveuUD3lBj3TY3g35MJb7mPvx/WbQCKeM9MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxGhjSaz; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-896f4627dffso51266286d6.0
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 03:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772363175; x=1772967975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4/5/+DIm0PUNzsRnH2ixLLbCTuqehmznv3FgCZlvEE=;
        b=KxGhjSazHM01sZbaIqx1b1wk8DIcZ1Z6KUsEHRXNsew43WR7MA95XF++3Pvqpkc48E
         XhZSIuDgVRRC1LkKkX0c4RgtTrBFYI4fFtQM2IpQJO7jnzezPOrtC6p0p2dr9tsTvVxx
         ap96MYg7pV0dcTk974M1qUO+FaWqk5oEv92za2kglMt0Bu7408vD73arbkYNU27mmGQa
         T66KOhwR3x+MiE8gl1OZo4mLbcex8J+oHS/J6AVWpGk6KSaWio1AY5D9a703lQIqW3My
         I+59+35P8OKXQuDsIcA7XWfH7v1fZP1RvPioudG+NhUw3sZWuETEwUrWYzPL+hDRlGrM
         pmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772363175; x=1772967975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g4/5/+DIm0PUNzsRnH2ixLLbCTuqehmznv3FgCZlvEE=;
        b=NedpV5Gby8vTSQ6sNcZRFa6I5PTDPakpRwUpd1lYrBcSHer2jYoMr4+L5Q7UQKu+aq
         QjxorXJDvOVswv3RgciPi2+tQca+b6uVbMFdbKvfOdfi+rpPzeujCs0eRv0zd4aIISWF
         SGxhAcBSjNIIV286vX/lo0vgmtrFZWBKj51WDcM6k0ofkQ6tZ1NgkP5gIdnaeSCnd8MK
         IuuaLXvkqca5LlSAYe6NoxI5LrcCr8b7j2WKBJlMvsBF64jwtC/nOOnhwyLNt1iw+Acn
         NQgRaWIYa+53rP+UoQN+n2484uaDLcvjrjdaUsNOPDuuiDVzc2dJyaAQcHJVf50Tf8G5
         QanA==
X-Forwarded-Encrypted: i=1; AJvYcCXIkVbnb5Y4hYr3O4icqyHf5TT6Pxa/3xG3PP/h8fQe316gs9OaAJ2Izgq/RuZJ2VBLDsA1ZCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsyySVlnOQcdbIp+s937/2YVRfF+qRKZIABuFZ7a/qz/vlH047
	hwCX61mcrPzrKSqivGQeW3XpvTdcdXb59ubjZViwnyiQ9BL8vXbONYoJ
X-Gm-Gg: ATEYQzxZNYIWhVnOyci9eZ7fzkdQI4qqj60ThAuJP5FrNn9pB+28Kog6hy29/VQUn8H
	TWvXGJZBf2rMIo8DbbeGyUBWDko+jpvmHHTeyuIgSj1Hjl8Xk5/XTzcxCHUvKwaDr6UhviDHxhY
	0YbjCC3bkPxv0ciUnHEcryoPO/axsLuRtcCjY01mVcpoc7cxOGd4BRfrvqUecexaFyXZ0lKq2+a
	Rpz9BOqbRvzIH2YmsxgDVn1fgnQXUpp71hMfr5Kb015uYGizDL795FoQaRDsSTrl8ANMQZRMO7b
	RnuOphkFVrvBVa6hlXBvPU4CwDJ1gmRZlYrrJGIjRGjH78rmwDMDZrzE/5iC4TiLWAwun5NHOGM
	n98JTOjdFkv7qSQCGkf69COXZzln+Ymyw4oaXg1zEHS+v1oR/zvM2T76KWWoY2Peq+iKjfGpT0Z
	N2qtjDYbbnROfuLWPNhmJVyo/GQM/UkjkwYa91t24QR3c5nC0isy7kir5vRjgPJmF009dwMZct3
	Kyd9VfPigTBeSHV
X-Received: by 2002:a05:6214:258d:b0:87c:2967:fd32 with SMTP id 6a1803df08f44-899d1db6789mr128135196d6.22.1772363174553;
        Sun, 01 Mar 2026 03:06:14 -0800 (PST)
Received: from PF5YBGDS.localdomain (70.15.25.19.res-cmts.sm3.ptd.net. [70.15.25.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716caebsm83888876d6.15.2026.03.01.03.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 03:06:14 -0800 (PST)
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
	Lee Trager <lee@trager.us>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2.2 1/5] net: export netif_open for self_test usage
Date: Sun,  1 Mar 2026 06:06:02 -0500
Message-ID: <20260301110606.3739-2-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260301110606.3739-1-mike.marciniszyn@gmail.com>
References: <20260301110606.3739-1-mike.marciniszyn@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262385-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,trager.us,gmail.com,linaro.org,kylinos.cn,fomichev.me];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F03B51CF413
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
v2 - no changes

 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 43de5af0d6ec..d1d5694d1ff0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1724,6 +1724,7 @@ int netif_open(struct net_device *dev, struct netlink_ext_ack *extack)

 	return ret;
 }
+EXPORT_SYMBOL(netif_open);

 static void __dev_close_many(struct list_head *head)
 {
--
2.43.0


