Return-Path: <netdev+bounces-256865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADT8GojOg2kFugMAu9opvQ
	(envelope-from <netdev+bounces-256865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:56:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF8ED1F3
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DD4630210D7
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2F7396B66;
	Wed,  4 Feb 2026 22:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Vus+XugV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764BF37AA7F
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245601; cv=none; b=a5awc5SElrknNFg+5rxVcJqY4hZfzgrCmxl8SJ26H7j7El2BEs8+Rn10QgMy61pZ4vyKkDVe2uOgL8i2x5uSAx2lX9lm53aWPwLCie+g07XjaQ8fODtltp9Zs0M0O16pQTC/CoQHgXGT/UjuaTWMUrts0Flnyj2VBTowe8ajksE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245601; c=relaxed/simple;
	bh=Cw+g5v3qix+K2odnskbDKUaL7BsivFlPIFkwMw+imrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtJA/hsGWOcWLG1ys47jLTk8wSb1nHn9jTzBAEYnlTKalO/U6nSRU98XdcEzVAuU858PaToIjLAu2gjLU2JlsacqHOuf1jjQoBoELJEOHk7Hy6OFMyqjlos7uMaUOykJzJsznF6t8htOiTOidWrU1JzgZi8eKEmc6M/qU/WC1FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Vus+XugV; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b71515d8adso241694eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 14:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770245600; x=1770850400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNcjs1Gb3OyQsrNzp9lhT3Tf4SZm991wAEQLanHnlzI=;
        b=Vus+XugVfusJNcMsuYhIBoZ1muVinRqtEpDTN45QHdlxlqbCPArY45XcLCOe4lZz5T
         u7E4CfEeqj1uOxPyTx2sOhpKhoLKLaeqm07E5NogPhGraot9MyaPa6L0BV00MDyNXl2I
         ni4KLruBTY++xzMVNfcp7EER34g2QAx1jfIO7an20n4ZhfHF+Hlt3mBlwqO8U0ntCl/V
         9KXCwQmSv4K3tHGabfE9rKTZ2T2xKRwuxPrNTbJdUPbp8hOeC7BeFkHiiryK8VrDyssy
         mOw8n933JOwCt7vxo+HhNgQIJCkYf42RYfTAx168YzHAzp8DPntsaeiu1bw+KUqMzq3w
         Wk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770245600; x=1770850400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lNcjs1Gb3OyQsrNzp9lhT3Tf4SZm991wAEQLanHnlzI=;
        b=Zeb54w6KsaJ/RCN+39LRR7SDfBaz8km+ipzxv0SJwn8aVXUMQQgvi2CKKCL3R417TF
         suD9R+5t7waJifbTNZgIDulJqkqT7IojT+iOKGQZDdYJgjspjUIShWjfU5Fy2TxIR5Oe
         ZUO4DYbsZhHFZRF7Rd6qVqlIgRkGlgZvSiwBUFXQKK6mw/Xu3eFtW1LhjaFrEWgSUOSi
         hsZq4CIzRk9suLHo6bjl9S97zyEkfRDCZVQfrDbm7/Nw+fdXdWMluWewUN55eY/j8GCX
         F9hwoFC2gLWmBbqdxnszg2cyHWi8emLzPBZT4c+OopB4AHr0ZM03S8NzVKR9q4JGcS0k
         UzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGLAtGcCYKl0uwaUc6B7G08LYMeFc6SGOcfj6qx+FFwUM+OXLFW7In2f/Lw9KoloTFJbSoVCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5YcvrqfnTPCJkDxQ9RwNRDKT0Gs6dKzqSMMZyZPs8vKHzrq32
	oBAfeSafr25YQ+IRftvsIyxh/SfbpCbF3QX1OngbivRDCbdXi7js0252NXpxE6HDZMfeDOTGWhg
	Jft8lUQ==
X-Gm-Gg: AZuq6aKOQ9R6AoRYpRvbSGONsqB6t8BsCRooh7TmMiZbPB1rDNpjNHECZlnnAmxTFCP
	udziT+DS47CcEssbgk6vOakvIlBlP/6K4NZfNKjtyEBZAYNxTzZx2UtC5X/fy94RHBnRi0L4V9B
	h4kpYpemo7A6ucPgh8YdeEr8PSTYWS7vCl5w39S0MhezwO0266BxpwqM9hskK6PYrHjLJAKat5c
	LTABd+YW7KCK3bKVtA3VOS0EEmrCeA8cXWMSqDpcJ50agpeQ4Lfrd57PdS+bHgPqqftpggVrd5J
	2HtcDM10DKVhdxFVxf+5tk70F4or+Z3htlkvUbuL9GuaHxfIxdCHC6poJJ7Zh5zALumjvUAWkXs
	6x3L5p3gbWWJI8ltkSJjh41Yaq8cPB6b2DgC52BuTzb2zbOVo9uK2JrEZNqdZnVEUu/SaMpU5eT
	V6YGOrhHYxpQNM4xtPFpVv57DKK0Gw8xBA3ClKZUTCQa2PD2LncuAGQZqK
X-Received: by 2002:a05:7301:9f16:b0:2b8:2fd8:21c1 with SMTP id 5a478bee46e88-2b83291cb4emr1736520eec.10.1770245600309;
        Wed, 04 Feb 2026 14:53:20 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:5ee7:5720:1d16:9b50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832feacc6sm2587040eec.35.2026.02.04.14.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 14:53:19 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v7 07/10] ipv6: Document enforce_ext_hdr_order sysctl
Date: Wed,  4 Feb 2026 14:51:51 -0800
Message-ID: <20260204225154.58245-8-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204225154.58245-1-tom@herbertland.com>
References: <20260204225154.58245-1-tom@herbertland.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-256865-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9BF8ED1F3
X-Rspamd-Action: no action

Document the enforce_ext_hdr_order sysctl that controls whether
Extension Header order is enforced on receive.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 Documentation/networking/ip-sysctl.rst | 34 ++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index bafb2ab08d0e..ce783551b687 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2487,8 +2487,8 @@ max_dst_opts_number - INTEGER
         Default: 2
 
 max_hbh_opts_number - INTEGER
-	Maximum number of non-padding TLVs allowed in a Hop-by-Hop
-	options extension header. If this value is zero then receive
+        Maximum number of non-padding TLVs allowed in a Hop-by-Hop
+        options extension header. If this value is zero then receive
         Hop-by-Hop Options processing is disabled in which case packets
         with the Hop-by-Hop Options extension header are dropped.
         If this value is less than zero then unknown options are disallowed
@@ -2583,6 +2583,36 @@ ioam6_id_wide - LONG INTEGER
 
         Default: 0xFFFFFFFFFFFFFF
 
+enforce_ext_hdr_order - BOOLEAN
+	Enforce recommended Extension Header ordering in RFC8200.
+	If the sysctl is set to 1 then the ordering is enforced in
+	received packets and each Extension Header may be present
+	at most once per packet (except for Destination Options that
+	may occur twice). If the sysctl is set to 0 then ordering is
+	not enforced and Extension Headers may be present in any
+	order and have any number of occurrences per packet (except
+	for Hop-by-Hop Options that must always be the first Extension
+	Header and occur at most once in a packet)).
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


