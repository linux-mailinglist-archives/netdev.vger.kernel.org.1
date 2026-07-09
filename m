Return-Path: <netdev+bounces-306274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wgzRA2yxT2ptmwIAu9opvQ
	(envelope-from <netdev+bounces-306274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:34:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D3F7324CD
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:34:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="nTZXEq/p";
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=SWW8AHWd;
	dmarc=pass (policy=reject) header.from=mailbox.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306274-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306274-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E4AF30885FB
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BB92E9ED6;
	Thu,  9 Jul 2026 14:11:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1797125B081;
	Thu,  9 Jul 2026 14:11:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606316; cv=none; b=XWPk+81Lbqp+V5mfUmQMp04g49S3J3dL7fzStvsKzK97DFUTNOrDbmt9qrN90TwlKM1JHojheXM3LtBxg8wQxfH9ZIpIY/lTdiANvfA/0fp1jtbT3GoK1405G/oVNTf+GjjCdRj43qv+0+7j6CvcBIiCGBuASxBgGCAC2Bonl8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606316; c=relaxed/simple;
	bh=mWbP2+Hzt6NOsA5S+X3iSMAtW4HUCWL1Tn2tEgduIxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tjJrqkK8MCUBfo3iDPQgFhAAJxzhnSwm0S2tSvddw0xlHZ731npCKxS2RmwcQkprV3qj9OS/4wcfGtR4NWSEHW8LOIc67ugzYIuth+qNO0XWvbVINejp0VxJFboIsGuwMnK1TrCAhhNSOwCed4plQqciZvQ9pWAH9oBIOr7CXNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nTZXEq/p; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SWW8AHWd; arc=none smtp.client-ip=80.241.56.152
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gwxjM5dv0zKvtZ;
	Thu, 09 Jul 2026 16:11:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783606311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D5M001/X9CVn4ScHLoRqgK9VNEW2LByAELLAivYQiEw=;
	b=nTZXEq/pMtPwZj2aIQGjQNs41LkvDv7A9v7OSTFxga2jhETZ2k3YUwh1HeGLjoAsr2cuN3
	Po+6hnfFuoReWrjuwVH6VSQKKfPRJZ/oHA+fG75LNeZLBnC9B05UYPQZ/FfScm9vSP+vJT
	DWWyxnRJ32wxGr8qTIikak1hXCt8M15YPv+f0bIkr+mnNCMe/zcjrVnX7JzGaDKTlXHAiI
	HHPatYLq9Ll4MkSsZ4A97uTodOC1bM6+CndvTn+6I3YcwTFeCidkIq8JkOguzuhL9hkvjl
	fa+uJgoCSYFh8mGS/tiGPpVs5NUpPthKdSZ7wJeqtV9q+10TpzkXqdc768p0DA==
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783606309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D5M001/X9CVn4ScHLoRqgK9VNEW2LByAELLAivYQiEw=;
	b=SWW8AHWdaBAfPP1T+fP3jVBeGmE2S1Iw+oOLZg7roQDvAlpzRm+GIP0BZsRne/CzvMXJd/
	28G0fwlG9dGGFoMrL/STF84XtsuqbdKxFeYTyN1p7A25g5QURw4ziSUedYn0lYeHfy0GkC
	6YWlWi5LgvMQTY+2fZ/sNG4y6UxYcF3Q76W8fg9fRmO1ZOQDTggNosFw0K+xQNWMEwpZ/A
	q8bPK8Oi1LTiOIfVi/fxYkejqvPbtR98XADKP9XOn3h1uxpPbWvCHnWaxhA07ab/hNwt3+
	bPIIpGUFp9/HON/Wq/Gmi6IwUDqyNG9pz0HBKrT8vyQZd+gwbLtNTAQdAbZZuA==
To: Vladimir Oltean <olteanv@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Manuel Ebner <manuelebner@mailbox.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs: packaging: fix brackets
Date: Thu,  9 Jul 2026 16:10:12 +0200
Message-ID: <20260709141012.400011-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6ad87ef3ed1b3b9ba63
X-MBO-RS-META: 33pbrwb6r993k4zzx6y5dzzs3zsutzc9
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306274-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jacob.e.keller@intel.com,m:kuba@kernel.org,m:manuelebner@mailbox.org,m:andrew@lunn.ch,m:vladimir.oltean@nxp.com,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lwn.net,linuxfoundation.org,intel.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[manuelebner@mailbox.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manuelebner@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:from_mime,mailbox.org:email,mailbox.org:mid,mailbox.org:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17D3F7324CD

Add two ')' to nested functions in code block.

Fixes: a9ad2a8dfb43 ("lib: packing: document recently added APIs")
Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
[v2]
 add Fixes tag.
 add Reviewed-by.
[v1]
 https://lore.kernel.org/all/20260709121427.391749-2-manuelebner@mailbox.org/
---
 Documentation/core-api/packing.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/packing.rst b/Documentation/core-api/packing.rst
index f68f1e08fef9..cff1a262efce 100644
--- a/Documentation/core-api/packing.rst
+++ b/Documentation/core-api/packing.rst
@@ -330,7 +330,7 @@ Here is an example of how to use the fields APIs:
 
    void unpack_your_data(const packed_buf_t *buf, struct data *unpacked)
    {
-           BUILD_BUG_ON(sizeof(*buf) != SIZE;
+           BUILD_BUG_ON(sizeof(*buf) != SIZE);
 
            unpack_fields(buf, sizeof(*buf), unpacked, fields,
                          QUIRK_LITTLE_ENDIAN);
@@ -338,7 +338,7 @@ Here is an example of how to use the fields APIs:
 
    void pack_your_data(const struct data *unpacked, packed_buf_t *buf)
    {
-           BUILD_BUG_ON(sizeof(*buf) != SIZE;
+           BUILD_BUG_ON(sizeof(*buf) != SIZE);
 
            pack_fields(buf, sizeof(*buf), unpacked, fields,
                        QUIRK_LITTLE_ENDIAN);
-- 
2.54.0


