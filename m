Return-Path: <netdev+bounces-259638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL/OMSDFl2kN8QIAu9opvQ
	(envelope-from <netdev+bounces-259638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 03:21:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F331643C4
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 03:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5C7030512BF
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 02:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6689F2C1788;
	Fri, 20 Feb 2026 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmGGFKtV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE792C08D4
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771554014; cv=none; b=nr76cU1+heiw+Pck2ZlmD9a/Sdo2gFNvLiSOSPm7LgfXu2+pbre/9uTFidGyXHXb/FOMLsTLlkvsnbCHVsMu9hz5Emy6Y5aLCbFWy+ip3SIOfkpJWOG5Z67eK2s3F7xJZhT3A8E8A9RIddJOnsRWpLQG0p7gWxwCFscqkZLw4cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771554014; c=relaxed/simple;
	bh=hWgcS6hW5BnKXv4iu4HmBnm+2LB33SX/iNSBf6jMyew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUupdKWkb2Y2+GO6+G+aRriqcoss26l4jVhjS5VWiTjj3sMMrd4WTVen204/b5ZjXoOzKBvtxL9ZKM93Kz2Aqt7KXqxzQBJu+YasKG8JsOCx8H0AJrvLQC3OMoWNmQP8y/xJ3//mFOIsKVLv7zVTZ41I3pdrghgSAo8IabHVAG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmGGFKtV; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-797d3864d89so17953277b3.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 18:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771554011; x=1772158811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RaV8hw3AXOrpstqaeQMdx39+aahmt7LDfsKU5eK6HU=;
        b=ZmGGFKtVRMXDH7xtK3EansrrcpwesZRVh4YCk7id9V5hwpMCOmj3hOvdToNIjIIiPS
         /IQra1kJ3K9qiR5VvD2s2LdpeajQFqsUy0nKQWMTAmDtoS9IGP3uQ7i5kXf9mOrgdaH/
         FD/siNkLCXz4zn3dbr3ck9PYBYnqFxy1Fehu62xLc+e7kVUnM4+NxyI3PYeGTjmKmduk
         YMSWZIzHimmk8LJ0z25gJbKQ7BM9WjD28E6aVXTz/6QFg0O1jiMJ7u+eEJU2BJc/KzLH
         4cJ4ayAnFxUhpp7Yv5de34EUI62HlkQ3gcTYYi3IaHxfYoujQgi0nftVgJDQ+Sgv6Oc9
         68zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771554011; x=1772158811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6RaV8hw3AXOrpstqaeQMdx39+aahmt7LDfsKU5eK6HU=;
        b=iuQSQUMQ+ttfMh3FusFhHuKNI0NgOn8iBWX2TeRGz5Yk51+0pDPbDEw9BDI4DB8Xyb
         hg4p0OJcc4NvBY9jv50l5g9K95JwbkbH3ah/v7x4CHNmlb1IW+97NZ7SbW4pEZZhuGvA
         M62aDoGnUIQqrriG6+qJlUQe742a1zKTTUVHPpSU/KM8YuKB+LaCffoEhQ0LisXVyfep
         ffGqRPPDk1PHw75S0HC8sZjOt1asjfylO7OJ4RtLvjkCGFfOWdf/oL8AGJoDLeKDZTIC
         yIXom7wbyrxCphI0JXt/aH+9LdSgobRWAM/TBAIvmBuJF0KBOpJ78sodKOrzRQlDbsxE
         4BSg==
X-Gm-Message-State: AOJu0YyPU2h+HB/DcwknI1btZqUiiQzgIab5nimNZIOeajPTjWuAjfQ2
	uEw1QX3N/nGkT7s1ZVJtQ4h3BSNbaOgyhwhji7TUfL35V851EkRZbk/whnG/Ti/5Am0=
X-Gm-Gg: AZuq6aJ3eQBK5a4VYCO22H+2xXbU+8SqIBIrF1QClKZV5fb0z7D4NLuQql0xbpDv9st
	BITBgYNvuIlO/Dn2lFgexGHn/ffnzLhTrgu9PG9R8urqHmV9m7ZHe9tYtHI2IxuXfeCvPW6FKla
	d2rG6HUHP3e8bWB9hWEu5pgo763oVzurAnWab7Eh341xTxl7ywX2gKfQl8jsdH+0+MwnnSh7QND
	VjgnAPleXiUNGnjis0cCqhOtRHp8oBzcekKv1SzmlWKxLVrbF2ZrwU9g5RTnqJz7mYCpKEO1TW7
	eyaNE1/dWp7jPpgEbLedNjo/YzlWq+CJLuQILYS4VBeTg/hjoicwYbt6VROMcM7n7jHR2BrMyoN
	sfO4C8Eub87cEUtf5Te9UiwTT+s12KOj7GJOD++BXTPcI85I3bdqA6kFfpXt2qSU1uZO9
X-Received: by 2002:a05:690c:802:b0:796:2fde:5df5 with SMTP id 00721157ae682-797ac5ce756mr105281867b3.32.1771554011568;
        Thu, 19 Feb 2026 18:20:11 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-797d142c2dbsm45550347b3.47.2026.02.19.18.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 18:20:11 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Linus Walleij <linusw@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/2] net: ethernet: cortina: fix nvmem mac addresses
Date: Thu, 19 Feb 2026 18:19:49 -0800
Message-ID: <20260220021949.40817-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220021949.40817-1-rosenp@gmail.com>
References: <20260220021949.40817-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[googlemail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259638-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30F331643C4
X-Rspamd-Action: no action

of_get_mac_address can return EPROBE_DEFER in case an nvmem driver needs
to be loaded. Handle to allow nvmem mac address overrides.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/cortina/gemini.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 8726e5ffbce7..4225676662c8 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2525,6 +2525,8 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 	netif_napi_add(netdev, &port->napi, gmac_napi_poll);
 
 	ret = of_get_mac_address(np, mac);
+	if (ret == -EPROBE_DEFER)
+		return ret;
 	if (!ret) {
 		dev_info(dev, "Setting macaddr from DT %pM\n", mac);
 		memcpy(port->mac_addr, mac, ETH_ALEN);
-- 
2.53.0


