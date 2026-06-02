Return-Path: <netdev+bounces-294086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PSyEvOXHmoAlQkAu9opvQ
	(envelope-from <netdev+bounces-294086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 10:44:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C0262ACBA
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 10:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E370E307FDEF
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 08:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601C43C81B6;
	Tue,  2 Jun 2026 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQMv74Mj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519D3C7697
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389510; cv=none; b=dNO0DG/qnLgAY96QcTYAZ2uguorDVNyX/W2tGulFfSvc4ODAKILTr5XISthUNp0CoLZxm5baVwxLMM9snw0pIqtjUIT0M84d/uOsfuK+JATo5Zs+0JhiuILagfGfMpoUrM086iQrORRwYonTFA7hKkKm3z5xcHOXMxvTSMCQaZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389510; c=relaxed/simple;
	bh=pRgco4WNNdgR8495tajkq9qSwa/BIpevqW2Y2olzEAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfEo+Ay1A2oV4rO7F74W7B9SEzRlhP+lw0FMSFW7+EQuNMnK5nRfkpauSwkaJyWCEwEMMRH1MoAzAZKbzVKobQDEF/ehu+tL4lTtfr1hecnPRZmXbXCHUnKyCFZnhlAfefGIF5ySc48ZgJLYUbywH+FkAEFXDbr0RPrTdyiyU40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQMv74Mj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so14585545ad.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 01:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780389507; x=1780994307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0v1mafeerf+0c330SrsP+aoq+1EhfoexoEg8eIBj6Kg=;
        b=HQMv74MjkrRqibSbHw/w0CBaJXAjTL2p7obIP5c2Z8lyecRFrehvIhHAqUZO0SR0Vw
         u4MJHwQiq/z+dBFHBrDwVpqK5U4egwJUEvuerowx3mBqw89Ik2sXu6fhbQl2J7HYqiAd
         JvnLuhSnVkm3xNXFqNX/8IJLH2AtYZhvfQc5xReEii6Jznxi3ie6hlysffWpV5/UZRj0
         Us8F4IBVbeLKrY2vBiNBA7lQYZrKgPX7PA52+pxFVOc9bcSmSTnkb9yK/ejUXhSrzEgf
         48qFvY14RP7LgWoz22d3uAy2jNnPi52l0hhwZrGjp3QdcAGpnliSoz38Nh6SAAoZClKK
         3ATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780389507; x=1780994307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0v1mafeerf+0c330SrsP+aoq+1EhfoexoEg8eIBj6Kg=;
        b=pQtQ7yUMOlLcawhNB4D63X2q5jdk379NOx+6IuXBWdkjxpGzNozsXKzcmWSyVVeKdo
         HNi07/2VOQzPrdJzIlY6QKSInWFjIt7OMPTsfHkKEDldQGQdbFe2d+7Plo7DnNsPuvma
         RKPJUXNOxao739zKWnWE8/bM43rmx2R0D6/kco+twBoJrTUI4JtDnYssOf7CyLrZIxwk
         rdRXA1CEvecuVx6hLGgU39vzh0E8tcC2CqYiEgIl406EIbdKUKzFXLGV5Xej3Pigj73V
         +ObVJMInaWEfjzTI3GinQ1SqnvYcTG6S+v5Ga9wo+3AVR//BqR1Gs+yUCDx6Wj7lP5jP
         UJiw==
X-Gm-Message-State: AOJu0YwvXGEVWdhhKb2FhfVs3tqY1iGsL8LHxrcYuiMipU0swgB4AF7Z
	tO+CL3X+rQWqUsoLm5b4nzT7jM9hqckOnOsN5u03Qj8ggZuw8Zdrs5sMk0cqCzYP
X-Gm-Gg: Acq92OGQwT8QS+4oafwWHrXUIXmdpQ3nMjQH/KDSZn2s5gypCKMOY5Wt6kLOEKh6c0A
	UXzk1WhB+xWJ1Do3tLMxJzV1t/v+t9EL/6/W4O5Blm+hhwwJnoKZzMJU2MUVCNQ5bZGRFda5LWE
	/GpH//FuzS9tyeBzWU5Qmd7ysnLGXd69fW7Wv7Vs6UaUBysXLAk45DAI2Sz1YOucryfp6aTDPUv
	LF8dx+eIs2DP969CK7NnRddiYkflnB3EsmdAJGOt87Qh7ZgpoUqZME7vt1J4G3S9EfXKDu/tfaq
	nMKG7dBHuKUIFzB04t08Xmp0pFQ5MC0shk34E1ZbjpBCU9UMRA1B44AORSEpcW0o+W46zeoIOdJ
	08nUyf+49g4NJUOg6JiJnKYpEctZ0M5StQH9+zHYDE1kdTn25ZPLV+aTzGR1OtB0PmboknL+5hn
	9qKR0SMxHu9JUC4HzcRY8Kb00WcvV2V7SBEnalLNYaUQi3/3Tq1EpSVCleE6U=
X-Received: by 2002:a17:903:17c8:b0:2b2:ebed:7af5 with SMTP id d9443c01a7336-2bf367db158mr161415085ad.13.1780389507264;
        Tue, 02 Jun 2026 01:38:27 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a10165sm122804285ad.31.2026.06.02.01.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 01:38:26 -0700 (PDT)
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
Subject: [PATCH net-next v5 1/2] net: dsa: tag_yt921x: handle ACL tag code
Date: Tue,  2 Jun 2026 16:37:52 +0800
Message-ID: <20260602083755.79411-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602083755.79411-1-mmyangfl@gmail.com>
References: <20260602083755.79411-1-mmyangfl@gmail.com>
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
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294086-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C1C0262ACBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This prepares for upcoming ACL features that use forward
redirection in ACL rules.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/dsa/tag_yt921x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
index aefef8c770e3..f3ced99b1c85 100644
--- a/net/dsa/tag_yt921x.c
+++ b/net/dsa/tag_yt921x.c
@@ -49,6 +49,7 @@
  */
 enum yt921x_tag_code {
 	YT921X_TAG_CODE_FORWARD = 0,
+	YT921X_TAG_CODE_ACL = 0x17,
 	YT921X_TAG_CODE_UNK_UCAST = 0x19,
 	YT921X_TAG_CODE_UNK_MCAST = 0x1a,
 	YT921X_TAG_CODE_PORT_COPY = 0x1b,
@@ -129,6 +130,7 @@ yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
 			/* Already forwarded by hardware */
 			dsa_default_offload_fwd_mark(skb);
 			break;
+		case YT921X_TAG_CODE_ACL:
 		case YT921X_TAG_CODE_UNK_UCAST:
 		case YT921X_TAG_CODE_UNK_MCAST:
 			/* NOTE: hardware doesn't distinguish between TRAP (copy
-- 
2.53.0


