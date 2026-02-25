Return-Path: <netdev+bounces-260749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MLHJ9xunmk+VQQAu9opvQ
	(envelope-from <netdev+bounces-260749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 04:39:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBC21913B1
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 04:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C0AD3070B9F
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A0529D29E;
	Wed, 25 Feb 2026 03:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Phz/w6/f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B22BEC23
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990741; cv=none; b=Z9AX4HK+ksapGfb2evz4XR0kzj1KM+Pg8qvvNb3YK9a1EHCdTq0y9f8pM8B+GTpD+TTGZgyt/2vhQv05kxrpKveh5upPlFV4yvDC/MnUCORODlkhgJkmfpsuldLdTkPEMJvQpZt1wmKsldxe+KTHm4v0oVS5JO1URCf9xWdIFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990741; c=relaxed/simple;
	bh=Xmf0Usl2CbiEJ++dZC/dkjhOytdRgouJKZh4aFkNkks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poL6m96aoD2PhdkXl3MLpaJAxDCPDkFwdkfG/XOnCoDQiCIaKg5D+9nNEww1Kp6pRQ33R1khYMbMoFCYi7s+yHG4dbxbbAN+9Uk3mxxGjGtMy79wKz3Fgf2BtkwdYZfrZJI3tFHDc26p7cDJONYBtiHt7+H7Nb5VhHY6jSokB/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Phz/w6/f; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso463439a91.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 19:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771990739; x=1772595539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1x6mfY87rLHQQy6u5hEHImplDq7CY6og6rQC/w4gcIk=;
        b=Phz/w6/fN+I9dmIs3HRecR/af3PTONFhFAAvysU7IkpEEBQ9pIZbrdlVZhpL58INf2
         tA6oj+W7Ybn3bhnOsdzzRUahaMYumOHIq+zTyl/Gx3nLI+iJLPme054nZBLUDpnpj2or
         MTryVNfs9fG4pH8mtRHd7SsS49/uV6Akp+gSzSKRJDV353Fw3rJiCT+jpG66Anf/rwD8
         iCjI56waJvF1zDHy1zrl4RFFkp0j2hk7iylERdR0JJCB6pXHnILTI3oOD8uxuyTRNWeq
         NnNU40VaFgXqi+66s7IB8PvzR96fLY0dJ0URziSBYadnLQTJsZXbEJsck9+V8KiH+hUV
         y2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771990739; x=1772595539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1x6mfY87rLHQQy6u5hEHImplDq7CY6og6rQC/w4gcIk=;
        b=VU4r8pqxc6hdKzgjSUNUhJG7P7oEFT8gmo4ezZnTS7z7cUx+QZ5evDGcyFH9lZf+fw
         qFpwZhbhYbZtt8akPNhLK1GNddMJ9ZFm3oexw1cjPJWFSUMZ1wyduoS+A0pYlxLMuR7Q
         ccJjLo1lmAWDtdSZHfI7TrTU1FI7qL5GJ4ok9/dOQBLh8rdSSGjpN91dkTM9PQAPtRRT
         I4J2A5QYCeNtcIMmKI6jX3zrM3cspeLg5rv0Z5ni4Y8Tls3RnPC1NQHz7fRHJn64YITb
         du65xHho9W0tRjzwHuI2/9G0n0AnfMG1WkIZ/QtW13x9CzDjeNDdIgSSVGUTb6afe+Hq
         JhKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIUk0/AdD2fvDVSWoLk8jw14tUFmmSpgigYDpSpmcXFbYHbY43EMrKtAYNMaJJr8aEECs4gqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCh9a2cPDrqJdxdLGeywRNCSrpYx+8/AkxpFvSLWGnKSqylHEB
	wdWaEgE75azx48aWjRgxhFYB9XbrewqDVRsDqlpQioIR2sRS3xyg8+n/
X-Gm-Gg: ATEYQzxsfHFDlh8sri0u3ajF4RAV8Te00SlOxTSYH2xYJrGJuTxjvtcRgJO7iA1T/D0
	4qY6a4to2NDD9lZGddfXl8Z9r/T3YA4nfPWs0JXlHpeuBdWoAWx7ZSjwIjf70ecmbtY8wi3sDVw
	EUYU6axUktma4iqkbZQMgIvDM9dNBSNGiiI6XBnKIaqHbX8u16jo5IiGb5SLoIvqePhmuAi3lM1
	xDQDFX41KCbaBeJJMZHmFl8G/P0H8FO2xuf4vPDcpq3BU6eknvk5/BULOL770WTm0Fr1BFQuVyi
	SPB3j8rpKnoS7HoIXg6PPfTTGaaDUbnKLANwRqWsq7QWmt1YgSJmgGxqLXGvajwI4BUf/l5ZL7q
	b0/MLRFq64zTkor1udjWKWbs/zRpACLX+w6BCLfqZIEduI2tYkmmuUopKwlqouB2/Jh1aBBenDv
	c9uk386aMkeexhB2g5RGAuok7P3zajb1tcSjAFmiMj1YNNtoyk7xtgK4DswfdG4fYyWud4Bg==
X-Received: by 2002:a17:90b:56cb:b0:353:4f7:cc3a with SMTP id 98e67ed59e1d1-358ae6a20c3mr10834421a91.0.1771990739052;
        Tue, 24 Feb 2026 19:38:59 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359018838b2sm1161746a91.5.2026.02.24.19.38.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 19:38:58 -0800 (PST)
From: Eric-Terminal <ericterminal@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux.dev,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v2 3/4] net: bridge: replace deprecated simple_strtoul with kstrtoul
Date: Wed, 25 Feb 2026 11:38:39 +0800
Message-ID: <20260225033840.33000-4-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225033840.33000-1-ericterminal@gmail.com>
References: <20260225010853.15916-1-ericterminal@gmail.com>
 <20260225033840.33000-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=ericterminal@gmail.com; h=from:subject; bh=c73ZZJhJVbdBF0f9KkqjyvY2nE5EvyIEm2O6pWmXnD4=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWTOy5PnqLqsF81puzI5ayHffb3zHYcZDL1UHARPrTOS+ L/mqIZHRykLgxgXg6yYIsvd//vm5nrdmnOd+3AuzBxWJpAhDFycAjAR55eMDHuY6jkmG7ptFBOa 4PKkJd6hVPdHv8EUc5nrVxctfxvR8I/hv1doohTPKjst3sM5214eqV8idXiXa8/OijYjjbnujbs /8wIA
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,blackwall.org,kernel.org,oracle.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-260749-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2DBC21913B1
X-Rspamd-Action: no action

From: Yufan Chen <ericterminal@gmail.com>

Replace simple_strtoul() in brport_store() with kstrtoul() so
conversion failures and range errors are returned as standard errno.

This keeps parsing strict and removes deprecated helper usage.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
 net/bridge/br_sysfs_if.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1f57c36a7..cdecc7d12 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -318,7 +318,6 @@ static ssize_t brport_store(struct kobject *kobj,
 	struct net_bridge_port *p = kobj_to_brport(kobj);
 	ssize_t ret = -EINVAL;
 	unsigned long val;
-	char *endp;
 
 	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
@@ -339,8 +338,8 @@ static ssize_t brport_store(struct kobject *kobj,
 		spin_unlock_bh(&p->br->lock);
 		kfree(buf_copy);
 	} else if (brport_attr->store) {
-		val = simple_strtoul(buf, &endp, 0);
-		if (endp == buf)
+		ret = kstrtoul(buf, 0, &val);
+		if (ret)
 			goto out_unlock;
 		spin_lock_bh(&p->br->lock);
 		ret = brport_attr->store(p, val);
-- 
2.47.3


