Return-Path: <netdev+bounces-253586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GgbETTFd2nckgEAu9opvQ
	(envelope-from <netdev+bounces-253586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:49:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E68188CC21
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF64D3008C39
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA63D287518;
	Mon, 26 Jan 2026 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="OUJi0Jg/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA62882AA
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456943; cv=none; b=KRfnbOrKjp0x64CVAcsFefmYdIA7By74wvOzBTkN/Ur90N+wY1Sh0Y4LbyE+dbryGDnzo2wHvEkXNpXLJFbUZL8PZsxU5pWNtPJAFui5l7K1jhPamrKgA9lWhj6S20lUZAuziEZozW7ptxiRdhW7PiG83MMd8UWsga3vy+j6wXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456943; c=relaxed/simple;
	bh=r8Lc7H83l4M5PnLfAJGlX+xbp8bcWHDwmhpjwfGra1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmK89rE766fWFcftwMTtA3iKYC3dAzehRJ5X1jndpllYPswUEZ+uylRcdcElGr0u2+SyYKEq3vQcYZXK+qBOpT3Q/T7feOJX27VC1KxEEQZDAjZ+/nr+PlVZJRSKaieZaRpjhI/qOXpBvgzwFJHOot59GImPgR1QErtG7FJt9qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=OUJi0Jg/; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12460a7caa2so6944216c88.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769456942; x=1770061742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hp4xT2211A2z3PT0Rk2oMz47A04bz4M6b3S5qxzHThA=;
        b=OUJi0Jg/m0Q/WVHGxUJE7m3o5wtsUI2aKOD7P6lgKgCRt2Wktkcv+2jsss5wT3DbOF
         +aRtqHMVGjdMdIa4xO0/flxcHeWP5lRnIbopT1ZNWEO3LWmAVTcjX/QSje+jZ6CU849H
         jEL7YeTqizEbLO/HyUSZYCqBwhQDuSGGiJJZ23b8KKbbuPd0V8zXQKT0ujhxnnKO0/mS
         VuCmGh2aF3Yt9aE2kTt64nK2HFxL8ioIrKePhKcC72Ilk6/VFEy4GgvPYBlvNk9HbeC6
         07sQBgaP0OD7FEg8kkHcG5fpEa7Fb8jNoNilMgT3087Zae8Kowh9CLEISHKQ0X+kTVAv
         B73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769456942; x=1770061742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hp4xT2211A2z3PT0Rk2oMz47A04bz4M6b3S5qxzHThA=;
        b=PDFioIBdcq1kmjBG70QsanDCNbh0YZ4XU2B+yepZ1nycRht4MrCVlTqRlGknmPxBEh
         nmsffchI1pbtKG5NCXUqxlmE0FvsYUsf1aUppFNTRtZWmISNYa0tz+tUds9LQiDy8hta
         a+WeSbTt8hWU9IOgbTYUKx9cO5jHTguPozkjjUdoRCJjtUrnQIwRwU6pPiNhfhxBGsW7
         z7kH7nRjTf+zuaHyMxsqtqCGgGGbsomSMpPB9RefU4eTG8sim8HqKN3X40GGhaNnQWGl
         Wtpo/Li7st1+X5P5tb0PuIYeKdj0Ncq/v14SQJYNFsTRzdUelaH0An5GDEATFXCaUbHB
         HR2w==
X-Forwarded-Encrypted: i=1; AJvYcCW17U0869b87vT/jGgt3gLEYjDBg8FdnmpmTmZ12ekhsY/KUbgX1UXlwfYWLzv+Qjd6Be77uXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu3mZ0xTmnLM4Q++9QvcQ25goAwpalZYxad3UdYKb5FgOPFS6S
	6SmXvc1G5MRPhQrosouljjbA7fxgnvzyPviqWoX17fuug3eQypa5W049PrmsSL17gw==
X-Gm-Gg: AZuq6aJtgpwzoVn6wADjVXCKtY6bLdKJrWZUm7jJNl8qgf2BS++mqUSSWrj1Z1a9bvZ
	VLpwEKtekSpLNSfcubZnp/VrDjE9saeJxAKJ7KVAgD1AG1rYBSpo3T0OSTdVch9fhEaRy8DmHqW
	CWKwsd1boZa6oPCSTz1NJT/d6a+EwYgFgXVTmB/VsaqhSQXdpRpIz/ocLEgyiKqvjEd+Y8D7Td+
	FgMlnRh9DvqVmsi/fCdknsrqXP76MxwzeRLG+qQfHg4hIeQEAcLysQiWwgWjkfSJNRh3aDm/8x+
	QxpUqPFCNrgJB92mgoQfu9XOT96qLyGhrLeML8mydz7fTBpxpc3tDy13m14e/L3P+RfSTUge7AW
	O2vdzFRdVmKhb1PCNFv4hMUI7mFmfx31aZW1vfPjB2QAFbUyX+sLraQPQmlTr4zLAg2jpKkvOSx
	pSwMlISQxQgDDRv3Pcq+9FgWdJbpKgk4jteb8BDSi9D14UaTAU/wpI5UTWJGfmI0Huvw==
X-Received: by 2002:a05:7022:791:b0:11a:2f10:fa46 with SMTP id a92af1059eb24-1248eb4069dmr3007589c88.0.1769456941442;
        Mon, 26 Jan 2026 11:49:01 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:1485:5851:22a:4c2d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d99804asm21121295c88.12.2026.01.26.11.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 11:49:01 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v5 7/7] ipv6: Document enforce_ext_hdr_order sysctl
Date: Mon, 26 Jan 2026 11:48:26 -0800
Message-ID: <20260126194826.236075-8-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126194826.236075-1-tom@herbertland.com>
References: <20260126194826.236075-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253586-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[herbertland.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,herbertland.com:email,herbertland.com:dkim,herbertland.com:mid]
X-Rspamd-Queue-Id: E68188CC21
X-Rspamd-Action: no action

Document the enforce_ext_hdr_order sysctl that controls whether
Extension Header order is enforced on receive.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 Documentation/networking/ip-sysctl.rst | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 4f568b0e39d2..1b12b955fa34 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2581,6 +2581,34 @@ ioam6_id_wide - LONG INTEGER
 
         Default: 0xFFFFFFFFFFFFFF
 
+enforce_ext_hdr_order - BOOLEAN
+	Enforce recommended Extension Header ordering in RFC8200.
+	If the sysctl is set to 1 then the ordering the ordering is
+	enforced in received packets and each Extension Header
+	may be present at most once per packet. If the sysctl is
+	set to 0 then ordering is not enforced and Extension Headers
+	may be present in any order and have any number of
+	occurences per packet (except for Hop-by-Hop Options).
+
+	The Extension Header order is:
+
+	    IPv6 header
+	    Hop-by-Hop Options header
+	    Destination Options before the Routing header
+	    Routing header
+	    Fragment header
+	    Authentication header
+	    Encapsulating Security Payload header
+	    Destination Options header
+	    Upper-Layer header
+
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
+
 IPv6 Fragmentation:
 
 ip6frag_high_thresh - INTEGER
-- 
2.43.0


