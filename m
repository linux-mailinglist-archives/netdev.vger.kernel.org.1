Return-Path: <netdev+bounces-266777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLELH53WsWnVFgAAu9opvQ
	(envelope-from <netdev+bounces-266777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 21:54:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F01E226A2DD
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 21:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A8A03028369
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3403358B6;
	Wed, 11 Mar 2026 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlUHX9+k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B513D539
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 20:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773262490; cv=none; b=abKGSWTJ6D6SE0oDkDTa8WwYJECrgKKkFwd88LRS7XDSwgPe5mro8rrPb5fIdqQ8n7I3n4gQGWfA2GVzcW0ED8tI+4Yf2o5grx88gYQlkMjIy5wcTuFmFEHhGF/kiDJ3CVssENhzSlNS1hP7WIdl+etODB3Ph7sxLushuE83cFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773262490; c=relaxed/simple;
	bh=Owg7Pcsxs/6IIL25irM2uvL22l2LuCBtZQ1UH1mUUgg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QUHucdOF6Cf7eCIbFRRJUbRN23NKiWJnS/900HR9muUbuFUPD4w0c9E+pP/3sAj0HCKTI22AD0kDucn8Nn+aFIanG/3mSjSusCSG/tfcCORFDDLmsXQ0m8UjsVS840suHavRP9FKgelldcTZY8w5BavUnDcw1PrYuVCNybzLllc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlUHX9+k; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4853510b4f3so3522245e9.0
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 13:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773262488; x=1773867288; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8UZEaziRoHLGkhpk3JfJq82ogKkuVgGchfAl3/e6EQ=;
        b=DlUHX9+kfiSU7+awk4znLypW4CDK9mUii54f3Vt7Thnd1+RhQa8HGBHiq4FvRbL0Qr
         1JY5Wi0BFZh30uTJmPtVr2DM8sO84xnXWxlcOERBgRRv2OxaRHzpo9Camh9sNhw6OvRp
         pdR+b2SloTqrEqArVRMvqwlK3nnztxsAuZTt1Au0lUKUjI2BhZj27SxjEYth+NHVcc2s
         0ePLOgmcM/vz0i8MDOADwl8tdqMh2QJgUnAARGQYkRyl1h/bQ+7r3m0GBhCnG/wCurUv
         /QhFmGZgJil4fwhep3/udiyu02PsWq55nr9EDANBNLEuwnSlI5asIiIJmC00VY+1Aete
         ubkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773262488; x=1773867288;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N8UZEaziRoHLGkhpk3JfJq82ogKkuVgGchfAl3/e6EQ=;
        b=sP2TYCzy2H+e93EwIfr+3RSlDvrd4Tsg9YBa2VjlNB44ku3+5T+ydugp5tlmQg32Mt
         /UK2VCsczGoGEznLVRpN9zA83zaqeXfLtMHqlNE7oVUBL8MDsYCTbWkOvBOS0MMDnxq5
         lH5e4ezgOkLhQfIgmiUVvsdoyT/J9PR8xbm8DuegFbffthB9mn3vwUw7rVEP0+nL51Fo
         0dr4xPkvorKTjm684ybH3S7k4Alc+CFXlTzFnCkUz5y2AMhO7kKGsyjyNw7zPdkN2IB2
         x953/zrMwZtPlL8HJad2dZL9+xn3ApFDvQjHSWN/EVAp0swZRoc9sCeiE8AblLbPYAXb
         XvLA==
X-Gm-Message-State: AOJu0YxoKKBqQvQ6azoB6DgTDyrrr/VDKgWuO5UHOZ4Wquq7dmt3wwSp
	4w7xrjDvNTlK7nIUmwP/AttusGgHOc+Srrw8WSJq4L8L7gaxfvPECD8p
X-Gm-Gg: ATEYQzyNJiEgOTq34DUB7aFOZyefYBM34C5wUT8jWxb4NV/QLk8KMjPyC8eppaGs92H
	WGKY4VuW7mbfBSS38wd4BKqmciCabp/o5qcN03De7EJyEm+hmxELMgxwPPlXI1od/sPxM6OhvA0
	FLwPPHjDZ+PwM7qOrS6v1TMyhfzEAiYBmc1ULohIFgflF+3nFemlS2QY1HQbicXBJmQHuLHAfy6
	RHZTpysxhIojpCbNWOOnHOKiG2s+3n8fC0dNkwyrQ+n0/xEza3MZW6jwqj8RNTFEXsRDXWwQ7RM
	FA8FBbyJRhlml0Xwy67aLB32tXjm0C3GUESPZNXfrfr5UqlC8V0Q79SGVvuU9GUgbFxxKCrp+pp
	8raC/ZomNzT8U3atzZpHJ4G4xRAIrLkrtVaF6Gs6ojIYW3LyYKbxK/5YZIPOp7WjEKbdFi1rlrV
	nosqGJ4bLhUxipQ4Wjp8WBfSvlzHHjbcFg5dauBA1AI6p1GD6j68jeDIPTL7rSM2BvGNt4Hhxas
	UpdqVpmvZ/fOiO4rkf9RE6hddhRZJ1KPE/RqU72tkMvAwwQhW3zztDLk+go4D2SJw==
X-Received: by 2002:a05:600c:1d0e:b0:485:3f1c:d887 with SMTP id 5b1f17b1804b1-4854b10d0d6mr71335815e9.26.1773262487542;
        Wed, 11 Mar 2026 13:54:47 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f15:ce00:4cb2:38f4:6cca:d180? (p200300ea8f15ce004cb238f46ccad180.dip0.t-ipconnect.de. [2003:ea:8f15:ce00:4cb2:38f4:6cca:d180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0c3d66sm23847185e9.17.2026.03.11.13.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 13:54:47 -0700 (PDT)
Message-ID: <880ca62b-a5d3-4865-bbce-2d2210928239@gmail.com>
Date: Wed, 11 Mar 2026 21:54:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: mdio: remove selecting FIXED_PHY for
 FWNODE_MDIO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266777-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F01E226A2DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fwnode MDIO has never used the fixed PHY code, therefore don't select
symbol FIXED_PHY.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/mdio/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 44380378911..53e2c047d80 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -7,7 +7,6 @@ if PHYLIB
 
 config FWNODE_MDIO
 	def_tristate (ACPI || OF) || COMPILE_TEST
-	select FIXED_PHY
 	help
 	  FWNODE MDIO bus (Ethernet PHY) accessors
 
-- 
2.53.0


