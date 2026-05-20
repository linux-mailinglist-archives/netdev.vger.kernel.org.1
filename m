Return-Path: <netdev+bounces-289974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N9FLY3FDWrg3AUAu9opvQ
	(envelope-from <netdev+bounces-289974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:30:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A522D58FA6A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 664B730C567E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E823EA972;
	Wed, 20 May 2026 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVQyWPAT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7014031B114
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286620; cv=none; b=OoNeT7d/K7JXPRXUfYFvy3EjGLLR+h+fP6Mp1N7Gf60zDr+C+mlRPDLOSkO/wEMvAc6CR4HGZCtTfMC7SHU90CkoL5+gutpsy2PLFz9hktsLOUQhykZKqOds1k+t+svBhRhfjyAtSxekGecrxefBatCxJpYoa1kXz8FRcda7D+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286620; c=relaxed/simple;
	bh=WjKqJkiCTtmvejCIJSk2+o8+CaSQCH4dCt3cUySSNT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Opw8NV7o8lHnP3T1rM/OIMWeRMbYR3s5WZi6Bb+FxxGeRrrt7uVOyNH2PdP/qjqQaqo69nAs4DVls80iWJMXAbKRZOhZkOfV4vD4q3TjZ+2txD4yRbDrt/KaWVLYDXFhhm6TCqONZZ7t9m9NNovSdI3K7hTxPwT/dRg6W6cXWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVQyWPAT; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-63124ac76f5so1389247137.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 07:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779286616; x=1779891416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx7r4Y10liUqwimwJdlvRGNK/vx0KHWn1LAYPWA617s=;
        b=WVQyWPATep/Iwv/N0fjKzeadrtnVzQp0seoFvJBZam/ptuvhzMcGrSIdjsdAHi5gAi
         6NRIkIE7zMI06DbifRdAjjhcs8G4cQteNNB791/qKH5GPtekoTgyY+r20//OeqFWz9Mp
         HNEudbUCzaVJ9nFQfkiIkYb8uKR4Ec9n/cJco+NypUUaztJeK9cqJrDahlPR5aKW598d
         q6qAcDEokJE1vtPhBit+iPRgkcOOgCHqE+TDocLUPPUi3ezk7t+xnavEDVi1gg7lbMyH
         FXm52GznWG9hTdzSnGWxUYwAUuCCGdU+Ln4nzYhyT0EVEg00A9AIjdjXyIWU2EFfiWbT
         ObYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779286616; x=1779891416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rx7r4Y10liUqwimwJdlvRGNK/vx0KHWn1LAYPWA617s=;
        b=X8Qgi4y57/P+2fx9+nz5bAvsSz5YIOwHOzfH576yi+IeJ7h8gnFXO9iJg2YTOPscM9
         QN7oEJswUOqXBjQ7jXRLj+lb+degF/5ijTvTYzu9dwgDr/o14QWnBdJTP3tx8xjQXK7J
         kGs4PMQsdkm69dG1z1wrjt0J6u2QOM4YiS49Gc+/fbgyb27YTAOqPLoPIQOfBFq6DRyI
         bOaG6j3PUR7SN2Q1SD5XnFmS38pcmKhRvItOcqK6T5EUvzuV4Of458DtuFdDwZzkaJey
         +zlH3go1Vl4sMUWSjIAlStnUqK6CCMvvagJUryBd7ywRrIPRX7eoKlYL081uZrCIV5v+
         Bs6A==
X-Forwarded-Encrypted: i=1; AFNElJ+mHLQbMMHrxadbZP9iutN+FtKoGlX+LH/reYYWQv4QKbk7AYFrmE+Jn6rZzcsZ8k1j6+5b0i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR97NUf/2ZW1Ajj/h+5pDo7kJNhRVVBQ1m8puBxV0+z9Sb2KkR
	JXh5C97pq5np32GDYBwg3ZbtqvV+TEXEnMAHwm4TAJMA7wHe76SsuDYh
X-Gm-Gg: Acq92OHf0GjTIysSmCrWoa1VWCopdRbsRwZwXna6scjYH5D4+repjX+NRoyVuQ0VP6f
	VbTfoZURJvpEGd11/UnCgBxGWAGztXhxKoyFIprxyeO9lsQvWyXxOKBoYg6vE75t8UkZRXJFVGo
	JorgDPB4G2gDFYAG+h8syFOCMMym8qg2cAk2NomGUDLMqEGEJ7ixNVVB/+/GzxrpqRlTIjNjKi/
	MZPGlnOgH7aNX3TGZ5HTHg+mshNjml4AmRRb/RQNyllUu9TYxt4AWzPBjWDAPUXYnNfqTmgJsnF
	oITgm9vIMVqu2RK28I2TNOC9EFLFaZkYKBtTDtxpBl1JqiYqpbeOx6+Dj1O3GrAzA/ot7tRcd/s
	Y/ZEoH/tzkBlm0FMSmJLGO0VOkkdOJODNeYGzXxM99I0v6L6Rx+6w7O8vczyxufX/SwRmv5ft56
	eiGM3NXJsQvngXMd4c1g1NCGzJUPzMQvT4duiJWm4nDTOjXh2IUAUaijQfDG8ELM0hqj2/izt2R
	L+xrh9+UawS6pzNan4jLNRQVDpG7Nw=
X-Received: by 2002:a67:e105:0:b0:611:61d3:819c with SMTP id ada2fe7eead31-63a3cf120a2mr11450388137.10.1779286616271;
        Wed, 20 May 2026 07:16:56 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba463814sm2138952485a.5.2026.05.20.07.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:16:55 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] ieee802154: allow legacy LLSEC ADD/DEL ops to pass strict validation
Date: Wed, 20 May 2026 10:16:40 -0400
Message-ID: <20260520141640.1149513-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520141640.1149513-1-michael.bommarito@gmail.com>
References: <20260520141640.1149513-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289974-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,datenfreihafen.org,bootlin.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A522D58FA6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The LLSEC ADD/DEL doit handlers under the legacy IEEE802154_NL family
consume IEEE802154_ATTR_LLSEC_KEY_BYTES and
IEEE802154_ATTR_LLSEC_KEY_USAGE_COMMANDS, both declared in
net/ieee802154/nl_policy.c as bare length entries with no .type
(defaulting to NLA_UNSPEC). Generic netlink strict validation rejects
all NLA_UNSPEC attributes via validate_nla(), so every LLSEC_ADD_KEY,
LLSEC_DEL_KEY, LLSEC_ADD_DEV, LLSEC_DEL_DEV, LLSEC_ADD_DEVKEY,
LLSEC_DEL_DEVKEY, LLSEC_ADD_SECLEVEL, and LLSEC_DEL_SECLEVEL request
fails at the dispatcher with "Unsupported attribute" before reaching
the handler.

The doit path has been silently dead since strict validation became
the default for genl families that do not opt out. The dump path is
unaffected because dump requests carry no LLSEC attributes to
validate, which is why the LLSEC_LIST_KEY read remained reachable
(patch 1/2). Introduce IEEE802154_OP_RELAXED() mirroring
IEEE802154_OP() but with .validate = GENL_DONT_VALIDATE_STRICT, and
use it for the eight legacy LLSEC mutate ops so admin-driven LLSEC
configuration via the legacy interface works again.

Fixes: 3e9c156e2c21 ("ieee802154: add netlink interfaces for llsec")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ieee802154/ieee802154.h |  9 +++++++++
 net/ieee802154/netlink.c    | 20 ++++++++++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/net/ieee802154/ieee802154.h b/net/ieee802154/ieee802154.h
index fd9778f705503..e765adc4b88f2 100644
--- a/net/ieee802154/ieee802154.h
+++ b/net/ieee802154/ieee802154.h
@@ -16,6 +16,15 @@ void ieee802154_nl_exit(void);
 		.flags	= GENL_ADMIN_PERM,		\
 	}
 
+#define IEEE802154_OP_RELAXED(_cmd, _func)		\
+	{						\
+		.cmd		= _cmd,			\
+		.doit		= _func,		\
+		.dumpit		= NULL,			\
+		.flags		= GENL_ADMIN_PERM,	\
+		.validate	= GENL_DONT_VALIDATE_STRICT,\
+	}
+
 #define IEEE802154_DUMP(_cmd, _func, _dump)		\
 	{						\
 		.cmd	= _cmd,				\
diff --git a/net/ieee802154/netlink.c b/net/ieee802154/netlink.c
index 9c9fd14d0ca8b..cacad21347eca 100644
--- a/net/ieee802154/netlink.c
+++ b/net/ieee802154/netlink.c
@@ -100,22 +100,22 @@ static const struct genl_small_ops ieee802154_ops[] = {
 	IEEE802154_OP(IEEE802154_LLSEC_SETPARAMS, ieee802154_llsec_setparams),
 	IEEE802154_DUMP_PRIV(IEEE802154_LLSEC_LIST_KEY, NULL,
 			     ieee802154_llsec_dump_keys),
-	IEEE802154_OP(IEEE802154_LLSEC_ADD_KEY, ieee802154_llsec_add_key),
-	IEEE802154_OP(IEEE802154_LLSEC_DEL_KEY, ieee802154_llsec_del_key),
+	IEEE802154_OP_RELAXED(IEEE802154_LLSEC_ADD_KEY, ieee802154_llsec_add_key),
+	IEEE802154_OP_RELAXED(IEEE802154_LLSEC_DEL_KEY, ieee802154_llsec_del_key),
 	IEEE802154_DUMP_PRIV(IEEE802154_LLSEC_LIST_DEV, NULL,
 			     ieee802154_llsec_dump_devs),
-	IEEE802154_OP(IEEE802154_LLSEC_ADD_DEV, ieee802154_llsec_add_dev),
-	IEEE802154_OP(IEEE802154_LLSEC_DEL_DEV, ieee802154_llsec_del_dev),
+	IEEE802154_OP_RELAXED(IEEE802154_LLSEC_ADD_DEV, ieee802154_llsec_add_dev),
+	IEEE802154_OP_RELAXED(IEEE802154_LLSEC_DEL_DEV, ieee802154_llsec_del_dev),
 	IEEE802154_DUMP_PRIV(IEEE802154_LLSEC_LIST_DEVKEY, NULL,
 			     ieee802154_llsec_dump_devkeys),
-	IEEE802154_OP(IEEE802154_LLSEC_ADD_DEVKEY, ieee802154_llsec_add_devkey),
-	IEEE802154_OP(IEEE802154_LLSEC_DEL_DEVKEY, ieee802154_llsec_del_devkey),
+	IEEE802154_OP_RELAXED(IEEE802154_LLSEC_ADD_DEVKEY, ieee802154_llsec_add_devkey),
+	IEEE802154_OP_RELAXED(IEEE802154_LLSEC_DEL_DEVKEY, ieee802154_llsec_del_devkey),
 	IEEE802154_DUMP_PRIV(IEEE802154_LLSEC_LIST_SECLEVEL, NULL,
 			     ieee802154_llsec_dump_seclevels),
-	IEEE802154_OP(IEEE802154_LLSEC_ADD_SECLEVEL,
-		      ieee802154_llsec_add_seclevel),
-	IEEE802154_OP(IEEE802154_LLSEC_DEL_SECLEVEL,
-		      ieee802154_llsec_del_seclevel),
+	IEEE802154_OP_RELAXED(IEEE802154_LLSEC_ADD_SECLEVEL,
+			      ieee802154_llsec_add_seclevel),
+	IEEE802154_OP_RELAXED(IEEE802154_LLSEC_DEL_SECLEVEL,
+			      ieee802154_llsec_del_seclevel),
 };
 
 static const struct genl_multicast_group ieee802154_mcgrps[] = {
-- 
2.53.0


