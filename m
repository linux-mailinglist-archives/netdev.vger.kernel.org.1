Return-Path: <netdev+bounces-261990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHbdK9UVommizAQAu9opvQ
	(envelope-from <netdev+bounces-261990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:08:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D261BE7E9
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C90E53099517
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 22:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3041F47AF47;
	Fri, 27 Feb 2026 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5XgNqP8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98C647AF45
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772230081; cv=none; b=ATxHPFMTNAwwchgKDFbI3wxQfKsMGnijxoXZrGYH6Zo+0Q7mZJ/6479Ur0uBvG2PUS8ZEl7YlATM1kgKBtRQwN6wE3PS6mkrOlkBZcrETPgwhmK4EAVb0d51DRsM5j17VqoWxVR3KAcsib0qwdFnSKi7kxTfYsEyYfikTSJQAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772230081; c=relaxed/simple;
	bh=XosBuH0cOsIM2MlJxGHPbVhML7EOzTRfJgAWMKK5bEs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fl959aNnovUScDAcy4Z3CehonPzJ/InLGXTtwZ+SWXnEvWt+9H7TpLG2VtmWnK2tI2jbHl7LkdMvdAmQ56MDzkXrV5lx07WnaeMLu2mVeAvP58dj1M9w6ruW21wmujPY6aCwQF33vBsWHuPWqHBJe/BfDNoWyNtJ2vOvrCe4JXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5XgNqP8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48069a48629so27059695e9.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 14:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772230078; x=1772834878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ov9UBADYytJ7sEuVM0YTU2+8SnVRBPSYViXVIfWve6w=;
        b=g5XgNqP86Pmhc0NghJkQGM338jdn6ILejXcL7oAIal9Kevz6e/7VhHkxSpQhRmHF0T
         wX+NcWr3pYsEebpka+BpMvn5/Rt6mTTK++iXmvyKeCkCJm2UuJeF2QxJEXvetKv/ex8b
         KCZ+QoWy1ehp26MVPoK5zZ9NnM5l8NMSoHSx9Eb7PhoHHCTZ7lqZhZSD3ogm/PqVy3YU
         4jycxKYP/WXqERSPWDfDp+iD6UZ+Sdfa+AIcM0Q1TiMZXKHXHtBrrEcT7b2y/jgZwpfI
         wMzC5tLAd1/kmJsVrT/yCVYm0VMMvZr9upFuPcMC9x0RGL0lg3eNEkFqwO50YCPp74PC
         Xh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772230078; x=1772834878;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ov9UBADYytJ7sEuVM0YTU2+8SnVRBPSYViXVIfWve6w=;
        b=BJgkfmVaur8PrSQNSbF+qR9mJkt+bdK6O+O6VCJlCEav3kqEjhfEb2vbplRSndjsS1
         pLh9tPauMzkxi7qDorV8QjRE/52g69JkO3kJVq5J1ZU4KfbpwKMy+wM1DqBn4jpeo9zB
         3eoiWkzvj+GYhd1/3A3J6DPELaxoWQGrxPkJpEHjP0Y77QiUTOT7n0WDCsZGSNQ/6wom
         xulOxoOUY+tlmoSZZn5fNWgGaAvqhiZTOgcye5+mNmnCUxyHBz4UxX7PJHJN1tYxnNWD
         hlUH5dlfklS+OnOYxb0bigqQ6N1jo1h5s/gs22KKv5H4szMsZKLvNYJ1dIyHF7MbTSut
         ASGg==
X-Gm-Message-State: AOJu0YwVVstbfbEg2XdhbEXHSKSfz/Ons/aIk3jqGFqTheG3gGbOgz87
	FnUi4afg8nWnBWaJBOeFtzoOWJM0vnpGOsjXFNo+TqHihJZ4X5J5zwiH
X-Gm-Gg: ATEYQzwpVo7yOVSYpX2+gdE7SfXqTNQQ2ZJCKOCcJJETOMbiOk/Mbm3EH40icZgp0xp
	sC0IhFbDgS5DU7/zB74JGMihftWxpzgEXGGXe+8Cu5l8sNfeW6x7fJ6f4BGFaag4D0gdLLcnoAu
	wvh09Ed/ddCXucDV/KcQCHIkbmDwhrKRVd4r49QIVby5kQe/P1h19buof4Kw1Gfw1vlOE4vKQNB
	YwRUdlpE9JhfJTQcbgVFQY7mD3Rl4yWwNOYGbuurM03d9nTvjifmHNCKBUCTn7XYhCWwsOlZojP
	qglzknWysmC4R1nYU6pQHGWZDvBDPvBdhw6E9bl51ScdtvbV3twQcIjmkJFq0G5LfW8pGjabuFe
	xVe8YBmQSf5t0Cx8oRfQghgXnZzQCNr5oS5/9bZDnFwWq9KIKOndKAItbXG9W9w8St6dVE99e5p
	MNxHs8C1EPYnJkxYbCSVeQ+e/tWXrE0KzcqRX9MlQPbtkSt5yfBZ92Jw8SOpV1VfTt3YmBqfgrR
	kUqgXL68EJ9MnXbGScjtqJkvB872XQA5xejMLtRXntBe1wb9RJ4BlgPuaxyWQaJ3Q==
X-Received: by 2002:a05:600c:35c2:b0:482:eec4:758 with SMTP id 5b1f17b1804b1-483c9c1532emr75166885e9.26.1772230077847;
        Fri, 27 Feb 2026 14:07:57 -0800 (PST)
Received: from ?IPV6:2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93? (p200300ea8f145500d4cd9f12bbf59c93.dip0.t-ipconnect.de. [2003:ea:8f14:5500:d4cd:9f12:bbf5:9c93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7030b9sm194989555e9.4.2026.02.27.14.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 14:07:57 -0800 (PST)
Message-ID: <054bbf60-d8ac-45ce-8b80-9c396469b7f9@gmail.com>
Date: Fri, 27 Feb 2026 23:07:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 4/8] net: phy: avoid extra casting in
 mdio_bus_get_stat
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <799114be-1456-442b-b479-142e7ee9d254@gmail.com>
Content-Language: en-US
In-Reply-To: <799114be-1456-442b-b479-142e7ee9d254@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261990-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26D261BE7E9
X-Rspamd-Action: no action

Using void * instead of char * allows to remove one cast.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index f189e9fbcbd..fb2bcc69c8d 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -136,13 +136,13 @@ static struct mdio_bus_stat_attr *to_sattr(struct device_attribute *attr)
 
 static u64 mdio_bus_get_stat(struct mdio_bus_stats *s, unsigned int offset)
 {
-	const char *p = (const char *)s + offset;
+	const u64_stats_t *stats = (const void *)s + offset;
 	unsigned int start;
 	u64 val = 0;
 
 	do {
 		start = u64_stats_fetch_begin(&s->syncp);
-		val = u64_stats_read((const u64_stats_t *)p);
+		val = u64_stats_read(stats);
 	} while (u64_stats_fetch_retry(&s->syncp, start));
 
 	return val;
-- 
2.53.0



