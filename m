Return-Path: <netdev+bounces-292830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEndCDqaGGr+lQgAu9opvQ
	(envelope-from <netdev+bounces-292830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:40:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA96F5F73EA
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8323C30377B9
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361F83E3147;
	Thu, 28 May 2026 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHH09aO+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D2351C1F
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997218; cv=none; b=JaRsZSLlHj0KKpJ2YoEgzhTRgzYHXSI0dDW9c6sgtLgJeLajyM5XlCnxTzRBGVP8KW8eBqCedVWx4puMKg32SZKvTMAQCJi2yVaQVzMcPHqduYYcA36iizC2dZbaE6M9bAcGVg/klafK7iGWyErsqbyV+88u6G28QvtohLUteFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997218; c=relaxed/simple;
	bh=pRgco4WNNdgR8495tajkq9qSwa/BIpevqW2Y2olzEAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKygMvrEW53kFc0ihzJ7PiyVsQAqBx1328FX6kDFmYHhgKV8Dl+wvHWg1xVPPAPFjvMZ9i9YJLe9527A9OrewdIAgmTheh1ZQTtQCTz6/S40zApLqxT2nAKAbhAeJQFUMtfdyDjO3UnlBwrNPqo6BE0ubYpLeSrDfjM1WlZE7FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHH09aO+; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c85725ce182so47845a12.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779997216; x=1780602016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0v1mafeerf+0c330SrsP+aoq+1EhfoexoEg8eIBj6Kg=;
        b=SHH09aO+cEPXinP8Muy9jz/pCiJE4tk2tZWPnssEYcSHTbAl8MqRzYV0eQEh7CMppm
         /fKJwfWt0W0uV6/RVaPtJ2AkzLfHYVbetnv7u0L0hTaXbVuDVQuCsi8z+qEgHZT6k7Ps
         MTJioxo/M2t+OCGr4FnE3OE7eWuIe55ZcOiOJ7ZGg1vvc1xlw+nfcfYKzW5b6+ZXG9Ng
         PA9GHodpszJ5GUNjWkMV2JuP+C/gtyJmBHvygC9582HryjM+9e6sDxLgq7u+opPsDNa7
         y/KAFdmvtPNOHh5GrXBcO08/vUmaG1JSz+7Jp6M1ZwSpww5J6UgqiVTBgvsGydo15y+1
         r+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779997216; x=1780602016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0v1mafeerf+0c330SrsP+aoq+1EhfoexoEg8eIBj6Kg=;
        b=GOOjMgVmfh9mkvuEx2DT59Yk6pusisPldubi10QWFk7cIhXuaCmlbnwHJihdHzP/cd
         36jUDxokEov6Y5zQx7YhrZ72JR3ebuVyAoB2lL6ga/+4HQLpMFGgrhbTz/U44+Jg24Kq
         GrfQhQoigm59ABQxKUnjBVSGcj7bKcGI/stUZ4PzQcI9He+0NlVDDxBXvJSlhgwPnsyP
         ek4kTxh8OE4cU8b9SV0WMRxuxs+5r9k3I7KT74Jjs7xzVLNAeHCv6dqOO5O94/+6ZkQe
         BUzpDanepJYB8PHCKnoVwbo77Jj6W7M9zwrv8du0EyKBk4eEqmnwSl1GI9v64DtZNvzH
         GGgw==
X-Gm-Message-State: AOJu0Yz6Aa81BbETRN8ewbKK7CIyUrF2SLGsYf+mIITgvDZn3sze5f46
	LPiQWbw1rD+xS0fKzlI/ZrPTZPrMEIOZQ3ZKUfMzUWmZJVCkciVybDz4AkUCxVEq
X-Gm-Gg: Acq92OHrD26NTpmxCztRN59tzQlmZEtzNXsWtTqLyyu01luVEiLszidhgS0hBh1mGrR
	TO+HJ0eYJdavenPF1HRfbXkjioPnlilW2Eh2NOJQXi+fL0ackOQVlN8bjT2ur3+Tgi2HSv9LrOi
	JQ6SYg9ZY+fZ742eJSdqLbVoZxIontwxMlf4qbmRQ5LZrFzvvS/iZNn+vqSzuVeCLNZG9jZcFHN
	6W70jyPkRfNlZD2cYMKpZCXOmGDUvvJ88xbbeppLvqd357kFrULdRmulzZgE3GNBXgIGeAoC9lF
	n4vX35mGAN4qzgHcOYvVe6pkjDhaVzBdJfknPahfAkWK7/bmLmskZtjz2ov0KXoafjhWInSo3NA
	sMr0hEzoTlArA/jJyzVLUgrwwdeS8lM8ZJGgpOuKMfdbTIrpuQDdA6W2+uvqBJbbbtwWT9wC+7M
	1yx/ua+bzyG0LmxP2Cr/jFeyPWOmXMsI3J1PRfr2SRuNP238dZjqcES1wpbsJz1MXoui1Ffhyz
X-Received: by 2002:a05:6a00:9298:b0:841:71fd:60c4 with SMTP id d2e1a72fcca58-8420c27c5f3mr415125b3a.4.1779997216263;
        Thu, 28 May 2026 12:40:16 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.215.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6eac68esm5900184b3a.15.2026.05.28.12.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:40:15 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/2] net: dsa: tag_yt921x: handle ACL tag code
Date: Fri, 29 May 2026 03:37:18 +0800
Message-ID: <20260528193726.1893365-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528193726.1893365-1-mmyangfl@gmail.com>
References: <20260528193726.1893365-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292830-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AA96F5F73EA
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


