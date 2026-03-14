Return-Path: <netdev+bounces-267792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOjLA8aetWms2gAAu9opvQ
	(envelope-from <netdev+bounces-267792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:45:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D1228E2ED
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3329E304734F
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B612DEA62;
	Sat, 14 Mar 2026 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="DDGd+WxR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776E2315785
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510267; cv=none; b=Eh9wd/cR2mM9pcs9xOtKNS18kOq80dAsayWbrqD5MnlinbiguHXqLis6YlOia4pjtTg30BgRVQ7hKbgKlGxYeROJDt6JJC+kTerEWZhcmgx1/ZrjCLAhD2B2dPAX1gwOnIyiAPERlLBDXAWWhynO4ijv5DqJnT4mAqH5C7G2FwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510267; c=relaxed/simple;
	bh=qKqtxCzBXIzGk8JlmvBjYx71RKayrMcxp+vv//+DAyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUFO++xKoLn5a7nPgCpMjSLuOWdwX9RDRhCVcAYu5fqkR+cdRGhBbMbg0i2Sb2AZk8NGJh34Ip94Ei8Qd6tSjdDBrEQJ+1adlAkhFoMNJ/pdYAyOJIdnA5kGWaNxQh0WgGtZzE0i4BBZhsQmcirG8Dyr85z4cp2EDLWtZ23fho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=DDGd+WxR; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-127380532eeso2846284c88.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510265; x=1774115065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffNE/V5dVULFOqPtPyBXTaniKjCJVhXKcrWx81ht9Ek=;
        b=DDGd+WxRLZkNLYgWUzktbmH+U4DiTdTPGH0la3Cvdqojch+y3FFOGPx5iKo/Uco26D
         dQg+ovklsSEiPS0J6Jgt5ZACLl+LODJyQyZyZNSr/CJLZxDJGS9QWEQS2DR5bMT5qOA3
         NBWX7luvQen7BEzWd+UMrEXSdmzc1FoSBXsoFEf1nqSRKyyXGOd4gS/vMNzs6ytDMrRe
         2M9MJ6xLmeMVKNSTKAnJxynPdSn3PO7BXhUL2f4pGKYR09uv29ljyu91t0zf4nhchMih
         xk6i/N9o6KliyvWaOner7VBe75B+dN9cgqRIypWV3msLGgS73uJwS37rIzMlb7dV7PC/
         KHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510265; x=1774115065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ffNE/V5dVULFOqPtPyBXTaniKjCJVhXKcrWx81ht9Ek=;
        b=NoJnCWG4JOZhHVdIevvPatZCcd8WqPVyrW3/4sFXzULAx8tvHmeqaKCwvNKAk3dbyZ
         eTl06F+ru1lzWVt7K0WoCb4OMH2Qdy1BXKptwUrJhbspnF+QELh8ZU/XhwBuhGPx1OU0
         DBprdVjP791Y6D+HxMs4w8cT3XP3PadL5HVyKVWox1mQaWHKdByCELnZjvG21kS2lPrk
         GdQcmL0o46RBvc9vnoGgMT7IhUZxHCQi2HuW79iiXB2PYOfPJlwK7SpvYHGsnEdChRLo
         KstlFC7OAzU9s0RQcnaBv+JsRVd47QnnY6Cy05RqHQpw49zNieleKZX/IdY61Cw7zzjI
         tB7A==
X-Forwarded-Encrypted: i=1; AJvYcCXi60bq3DI0zozUh3GN80Ye1RI3n6E9zvxQ26x1PerZPDSzOzS2Neng4mZpJLE0mxEjz+7rSiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywvZUNbLN+vqVyUgxaXJhg6/kR3a6rcLL6sA+iIyW71TyUqDg1
	2spuCMVFwLUcqypmvKtdIJq6Qm1ZnHbPPgYNpkH4Hegs4tTZYQjB+CkZWFA/G04y4w==
X-Gm-Gg: ATEYQzxS7PoJ30DdDAIZpqLvDDep1WGAYyJ9Lijs+SVHHkEXYUZAb4lmFl0vyend9ge
	rHwuUu3xx4MbS/4WKokiq1IZ1yji0o95GYOgidhYdhI3chaIxYC1mt221K544MwjMOEUJsX8ybC
	LoaIOeA6rQLCiekKLliiEEjBsQvaFHAXEFGDLJJEyhd457S2k9aJF3GmtsiJbZ4Thjy5e9HHMty
	EwADGfaFQ9YGmjxug2+kfyQbL5TEzVs1VRAVRtbrycQU+fsb/zncEc2Ama8Bk+Le/QxbebMY3qy
	2WmMCG+NPRnHyKVMCDTmB5a+t8Avftyjn9EszpNHm9uMaPZL3yWas2TC+bkhhuOqjGlEwlbapqG
	P+ptmgbqUIwzj97Nbdiz1B2sl6pxtFp9dTa4e6sBAbg5xfAkR0EZYttwCWUlR0VtMtHihnfWadD
	MFZh6dM8roLT6HR0Ae2DD9QoJpTuZPZpWXudVtrxVnkxi8+50hlfbsBDRjXWre9fozdnP078402
	VfFDcNS
X-Received: by 2002:a05:7022:b9d:b0:11b:8278:9f3a with SMTP id a92af1059eb24-128f3d1bfd5mr3724311c88.8.1773510264562;
        Sat, 14 Mar 2026 10:44:24 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62837ccsm8326734c88.3.2026.03.14.10.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:44:24 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [net-next v8 07/10] ipv6: Document enforce_ext_hdr_order sysctl
Date: Sat, 14 Mar 2026 10:43:30 -0700
Message-ID: <20260314174333.46406-8-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314174333.46406-1-tom@herbertland.com>
References: <20260314174333.46406-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-267792-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,herbertland.com:dkim,herbertland.com:email,herbertland.com:mid]
X-Rspamd-Queue-Id: 81D1228E2ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document the enforce_ext_hdr_order sysctl that controls whether
Extension Header order is enforced on receive.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 Documentation/networking/ip-sysctl.rst | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 453643c70c8d..fa0ed1936f59 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2617,6 +2617,36 @@ ioam6_id_wide - LONG INTEGER
 
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


