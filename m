Return-Path: <netdev+bounces-260175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ajEB8urnGlnJwQAu9opvQ
	(envelope-from <netdev+bounces-260175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:34:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C27C17C6CF
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5477B302800D
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DF336AB49;
	Mon, 23 Feb 2026 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idLI2owS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034BD3358BE
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875146; cv=none; b=fVU6v2rJIhhuYcTR1R01ZEwG0b98HaCI1HADM72v/sltft933hQjJOs2QiJ+yeT8eNt75EeEFf2K0ba3U++Wkyhi9GJbzcsvlcuLDVJKKwTfKWxG3hzfxhlKC23Kb7y7N9M1JcTHD17k5A9PEJxLJ6IUq+Kh9gt0nn9QbLX4W1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875146; c=relaxed/simple;
	bh=oRY5mYJ0Vq2mYX+WoQCCUBRZpEcYR7BHeCUiCMyj2o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqEFf69A7QnfiYgPOvMjmdP7qQlUmwOcc3ZD2KZ5wbO0+lwBz2uFQgAPKcvsfTL2EtxOZJ5lMG/IeZFSKjdlnjbryuVZS4g2FQYkCk40433xDa7mNNY9BLKLVEjlwEQGd7Yo99QTLtz24SSbtJAaZxeA4l+GmX+CF+esr3fNqk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idLI2owS; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59e6b7b11ebso5490448e87.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771875143; x=1772479943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiVEvW+ooFPtf+vnLc8gcI/mJyzTncbCHQKWmZG3W3I=;
        b=idLI2owS2nNkknnfnvGUs04nKjuYkvHz6FJ7vBbUZ5D20R38YzwkDhH38pOx/u3Ei3
         oqvdPXrLteYCoES/jKu7ryhNaMWqC9fM5IxH2J+yvb/TXetOg8o11CbCfFbCF6kJYgrH
         SSfmfA+Eob8wixAWnV8IoOk2+xn/ueqUj8Trx5ikmZABbQFkfZgt/Pa7LSrIMS9IUbFM
         BjNNsPON7CWTAI3qU8jcBdRHbo+9LaMcJgkjoia7ppliiBG6TgzNKMpUz+xJq8NC8T96
         gLq2QbgqxmywdtW88CDlzEruQTyZVJHp3hw7obnzFjmDAW3bwnKI7GcynJqHuav/1L7V
         WEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771875143; x=1772479943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yiVEvW+ooFPtf+vnLc8gcI/mJyzTncbCHQKWmZG3W3I=;
        b=It92w+e4jLm0D+2Su7RkJDFxkadyKm2ShC3B7EiflAt26pyWptgfaL5eyoMIkYfRAL
         OUtbDKTJgapDY7yf0HMZ1uolBQ4d3sZQT9UK/wvfA7EpFyqwdmUkSsovx6ouXcWH0cSb
         0UMHlVv8CgdQj1s+mKnGqglwbuKJ5QBpnjR48v6VWuEHM+ar7t5EDLK0Nj1m141WdHXJ
         Ip1Bjcv7q3vZawD2yLetPr2/UaDFD2uKSk3wk2hrcdyG2usNBijJldWj53JlXXZu7IVU
         jOoHpo0cB/o6movBYZJGBcKlPsxFn4BNH1wYgwP7Oh6XK7epYHIP0zECjHfI7QsfQtHl
         s2ug==
X-Gm-Message-State: AOJu0Yygp7UFiNRA1VSNFJ2O6EuC9l8qy+vWZuZoCfU+uCjCx3QOU4pN
	WZxJqgCR7JT+rjukK6VnPHzSjZthnSDRak9J3zfEUUN68eEHlkBekNeGZvmaen/a
X-Gm-Gg: ATEYQzxFCjinY1+2bNTN8i1SrPHHRJyKGw2AdgCjPII4dKfQcClnfe2GV2OWSsGD/pp
	vTDTyx6HKDpPQYqgnazwLdjARbRMJt51I3jjAUDZ3VS3QGq42ZSkAICMZ0yrvYF218bug4zHu9j
	2rxpZhNczdeBgNg7KxTqReLxLiFNCgIAtfeXdynicc65pDwa98n+DPTo3BUQSqeiRBZM+E+7PmN
	cNeodMy3qoGjnWtkQSTOqwEw93B/CyP3Js0K2CKpHajG6iG7RLS+lptRVMP118V+fxuHdUx6/iv
	OgT4Q0/o+M2KCFJGsSa7IZvR3pMq2t9s+uZCFDXQLXxpQWuOIT0LnWsab6MscckBk5eE7P3DmPk
	5uHmVa8fcKvYFSSzLXIQWBoTQGH05psAPBRVDYoKejp/KztCmMKUybswOh0/xueQaBfUrhKQ32e
	HWtZpFkgE8a7DCVlDdFOPz
X-Received: by 2002:a05:600c:8b25:b0:482:dbd7:a1c1 with SMTP id 5b1f17b1804b1-483a963bd2bmr157155845e9.34.1771868962847;
        Mon, 23 Feb 2026 09:49:22 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:20::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9fb2sm21626774f8f.1.2026.02.23.09.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:49:22 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	alok.a.tiwari@oracle.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	dg573847474@gmail.com,
	donald.hunter@gmail.com,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	idosch@nvidia.com,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	lee@trager.us,
	leon@kernel.org,
	mbloch@nvidia.com,
	mike.marciniszyn@gmail.com,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev
Subject: [RFC net-next V3 2/5] net: ethtool: Update doc for tunable
Date: Mon, 23 Feb 2026 09:49:11 -0800
Message-ID: <20260223174914.74461-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223174914.74461-1-mohsin.bashr@gmail.com>
References: <20260223174914.74461-1-mohsin.bashr@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,pengutronix.de,redhat.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260175-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6C27C17C6CF
X-Rspamd-Action: no action

ETHTOOL_PFC_PREVENTION_TOUT enables the configuration of timeout value
for PFC storm prevention. This can also be used to configure storm
detection timeout for global pause settings. In fact some existing
drivers are already using it for the said purpose.

Highlight that the knob can formally be used to configure timeout
value for pause storm prevention mechanism. The update to the ethtool
man page will follow afterwards.

Link: https://lore.kernel.org/aa5f189a-ac62-4633-97b5-ebf939e9c535@nvidia.com
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 include/uapi/linux/ethtool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index b74b80508553..1cdfb8341df2 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -225,7 +225,7 @@ enum tunable_id {
 	ETHTOOL_ID_UNSPEC,
 	ETHTOOL_RX_COPYBREAK,
 	ETHTOOL_TX_COPYBREAK,
-	ETHTOOL_PFC_PREVENTION_TOUT, /* timeout in msecs */
+	ETHTOOL_PFC_PREVENTION_TOUT, /* both pause and pfc, see man ethtool */
 	ETHTOOL_TX_COPYBREAK_BUF_SIZE,
 	/*
 	 * Add your fresh new tunable attribute above and remember to update
-- 
2.47.3


