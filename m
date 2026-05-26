Return-Path: <netdev+bounces-291588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPelK+JdFWp7UgcAu9opvQ
	(envelope-from <netdev+bounces-291588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:46:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0878E5D29C8
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B49533033D11
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00543CD8D3;
	Tue, 26 May 2026 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="d+8DKQ+h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f100.google.com (mail-ej1-f100.google.com [209.85.218.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF2F3B9D9E
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784868; cv=none; b=g/yduqNYafvkhpQXsNcNURTyODdig8Pb0BNNI8hY8k96K2JYdElnvFDZZL7IAdPRhtOlYi4rQn1YAQHMSScwXBV3oswSoM/U1FenM9MRXdJBjktS5PV9QtmEXf+qFjk1SHh1c+LmnKu0vS8R9IUTcw+AMawUgCq4NnfLsG3Hegw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784868; c=relaxed/simple;
	bh=As0IIB8SaM9g0iJhsygQfNz95ki/F/8soFisaCB0aVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dx7xx4y28sm629nXeiT5x5o4pglXgSFmQ2oWMzGIrK4lvNbG+Y5SSep07XmY7Fi39he8i27zMbnhWybRgxPwzLJZueuQ/4rVOD6A8lWaATuZo58s+V+7UZmUllOCzndlOq61dFu3au624ga+ga5hnph0+qT8SYrla2SbkKGYXhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=d+8DKQ+h; arc=none smtp.client-ip=209.85.218.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f100.google.com with SMTP id a640c23a62f3a-bdb3eb93e20so863113066b.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779784865; x=1780389665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bivjaMuNT9oJ2l/Y7Zh3L+bPRfO/kPb9uY6ej/NrXA=;
        b=d+8DKQ+hHJygs0so4Hy/IKWGbrZlfKK0RDhny50H2VCSZRENj2EYt58y7Va6Tilk9q
         hjlWz89uL3GCk/JFOnLrvQEhX6iDOQQI2iKZ1AgM9dZh3iut8zY939xveV7V2ta2/elp
         HsZbzUBMermBtteouD5MDHgck2TQ2mbhTUs7VqOQfMlydbKiJixmQfAdSMVzq+ASXzKa
         86i1SZQuuZHiR1KpjRHkL3EIgaUueT7Jxn0qdfPqpLhRH+Q4+PBFM9EEBTSycxrHNh1B
         TUb42CDpSPgK2Gmv+Lmg1txcFNOmksA/4N83F9He/0LVJUf9MEZ5scWfnVbJ58ab1rid
         +ItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779784865; x=1780389665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+bivjaMuNT9oJ2l/Y7Zh3L+bPRfO/kPb9uY6ej/NrXA=;
        b=aTl2nVAkTbazV8WHOo5rgA/JYxStXisg5DtERDiZ5F/1WywM9iBf0bn/6GU9abhnbB
         jnBM7X19xOuk8BJmWm8d7gKtQtsufagGlnY66W+csHWdEnQQMX1YNG9B5n2U+a4WWKBm
         OCMFmNSk2aBHobeALcer4Kc3XPKPhJBFY1lcxw+YdUyA2+wzKcoU1XdBM/FAJDHxzU+D
         VKf/W9iYHEVH1fFdIMd7/xMDu/2mVqAW161xCSW6MfW1hlt0lcuunLiHQmd4a/fmUeZx
         0E6yraIdL+4JvqEfsxcjj+kH3YFlVj82blu2exhi9hHivRBqpfMaqocOdoVgRGXXy8zj
         WMsA==
X-Gm-Message-State: AOJu0YzisK12KN9pV5ryhn31evMZQJobioMQea6uDlnkMmbRhUQvWgCs
	OrxbIXaFb4rpOzq3ohXSer4SsjDj0yH5sMW1PrtLEPxNdIE4gbuYDAPrfFLHgMgtDKhUUIddnEH
	UyyR2HfgdevpmxoXDYTUyd9S2t3LE6hwD8+km
X-Gm-Gg: Acq92OGskARvVzSNQrgK1dCe58pJ/8cUuLFZkmajs7G6B18txmsr9EWx6mfo+Jy5qMs
	5DBHceRX2959zhovSKAvI5veCVvjgpEsjF881rqzuWeu9lfWBXhnk/CYZzbn2JszuRuBQ+1NzvZ
	AV9vQ6jaJEpUhycqOWayYtTBlCLhQcz2pek0qghiik4Ut/1prMkfcKoXlV8O0dUNVyPDkV4T9Hk
	h2RdeTDpK0zyS4xilxGJuM4/fdDUL2GNK22VBYsrthbTQGdJ9Yqpvs0Vum+0h1lTnbAOEN/wcG7
	lAK2purNk7eHoUUjvVJs0lVLcEUNI9ua84Z0i85QDscwlv5Tr0N8oAFQqkm58Jh8FW78o04QxUM
	LUtKD29+JJhc7D2E7dhWrKEcmdqKDuvwga+ohF+jGNllXSLvJqkXS
X-Received: by 2002:a17:906:23e2:b0:b9c:b069:8ac3 with SMTP id a640c23a62f3a-bdd22a40293mr785056466b.3.1779784865261;
        Tue, 26 May 2026 01:41:05 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 4fb4d7f45d1cf-688bab32430sm554306a12.9.2026.05.26.01.41.05;
        Tue, 26 May 2026 01:41:05 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 0C0BB124AE;
	Tue, 26 May 2026 10:41:05 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	jonas.gorski@gmail.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v7 1/6] tools: missed broadcast_neigh if_link uapi header
Date: Tue, 26 May 2026 10:40:43 +0200
Message-Id: <20260526084048.1696544-2-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260526084048.1696544-1-louis.scalbert@6wind.com>
References: <20260526084048.1696544-1-louis.scalbert@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,jvosburgh.net,google.com,kernel.org,redhat.com,greyhouse.net,vyatta.com,gmail.com,6wind.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-291588-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0878E5D29C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add missing IFLA_BOND_BROADCAST_NEIGH in if_link uapi header.

Fixes: 3d98ee52659c ("net: bonding: add broadcast_neighbor netlink option")
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 tools/include/uapi/linux/if_link.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 7e46ca4cd31b..97a2d4411534 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -1526,6 +1526,7 @@ enum {
 	IFLA_BOND_MISSED_MAX,
 	IFLA_BOND_NS_IP6_TARGET,
 	IFLA_BOND_COUPLED_CONTROL,
+	IFLA_BOND_BROADCAST_NEIGH,
 	__IFLA_BOND_MAX,
 };
 
-- 
2.39.2


