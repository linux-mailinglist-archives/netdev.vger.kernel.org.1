Return-Path: <netdev+bounces-280464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L37KZHy6GkdRwIAu9opvQ
	(envelope-from <netdev+bounces-280464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:08:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD01448419
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B21593074F5C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C92F221F24;
	Wed, 22 Apr 2026 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjGH35/P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5547F31E84D
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873911; cv=none; b=aHkGgrfBkyPYS2cQTnAXhzg179VJ09VF2BNuVJaUlh8EJKbCLbHJvc6vPyHS1DeVuJ625ryfMGooJLDwpIXb3FLH8Q6KW2GLCeutsDVNPEq1TID7PI4RWV3I2FP3zElAgZRLEi4W++ssz6LJk/jtViX9OGj++wWjHsxZFb0+bBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873911; c=relaxed/simple;
	bh=Z9kfZQjc8u03pqVuFhO2vTd+dmQQl8Rd9xzVj4p/OEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryTphN9YYFwRs0agk2JHjU9BK6rW0kZs6kpBxpVnpqM7qs+anxIeYLjblrQ4+gi73+L9WRrF/xKHRB7oyA2kpnHlrgoStq3FIzMHlREduKYbmAVo2xscrJ4LlASZnqQxXbURE6BfhRilWuACW7yVXu6tniXi5QvX1qX3XuMDlro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjGH35/P; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94ab69af6c8so4014146241.0
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776873908; x=1777478708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T41S3e1bOdreWpo/hZ3sh+PHsdpPzBXbDDp5teurtVY=;
        b=jjGH35/Puy/6TqBUceLbIC0ITq2GN81G7Kwdm+TElSqcGJ+8p+5c4t+LzpT3O6ells
         Wa8TwC7reqlWwkMXgznIq+w6bJ/hkocmpiIQsK3O0Ui/Qw8ZyElT3lIAX9/jTXIV4esu
         4b4uF74rv0UR8nIQwShdCO7iFJitQw4RbWRvm7bi4MsMOf9AoeQmiPpX3nKjAyjDzyFW
         cMw6jSrpgqN6clVckuRl+yRKlJT4ZzOV1zvHx/nxHetQYSl2rbmBe0hmd0FpkMAAohlt
         NUgzSWNVfbb6ruIYuh9CFkWv+dVmPtf9hFmNP2R6Jcrr09EfdfGXtGj0Q/JH6BHlO1VB
         1zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873908; x=1777478708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T41S3e1bOdreWpo/hZ3sh+PHsdpPzBXbDDp5teurtVY=;
        b=oAXrk2JrTbcMifrGmUTKiY70zipJiPnmEtVqFxzR+1dz0UaCRfnepNcDSUUbprQxiu
         RkJ5QRlXrn3abmukW5FTeiENhE5R4EqgcaV8uvmV/i/b6xATPM6yC8kK9d40ArxxSKQt
         pDbMS5vA2LxJh/O7p4jsf6OEbEh9Iwusw4YKxKr4n99423TQGxfJUXvVjRmvin6U4430
         JZ/VW7O1FIb/ChBqEtdJszq7ZYzoCzZbjVWImF4Vy97f0Ibot1UhRmH5ltfITt2QbRvH
         7c0b8H/9gvPARJcF0BNovcOtn3fDq/K833jPweR569zxVpZVhx6uWCDWyn1Kg+AlV6d1
         Fnog==
X-Forwarded-Encrypted: i=1; AFNElJ/DjTuSV2lafsRy5R0U1io5ufA6MS0nwKjyu4uYfptmHj7kIzdy9PR7Vuh0qzE44JEA+z7UYS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIA5QxsJrq2Ob5T86Zxe3Ygic0ajm6V8dFNSZE3CCG2r4Nz+J2
	J2Km1Q42zwCIY7ntgCVHmVKoNz9y3F+niuIMohJBol0d1IjMYvkCxyK8
X-Gm-Gg: AeBDietkYIPplEu9iSJdpxlf19oEIWIgA3kmo8WuBS6h6P4uwWd+mvu1qHjA4OEh6U8
	OaTycIdonNrH+go6yvUTkusQ+Ev0QJ6OEW7EiHoPvHB746MmAi/hZDGNOwYbr57iurheTge8B5U
	YNQfjJtWcE9sr+9kxMBNEOYVrjCg2I1cU7qkeq4fULjqfWdS12b633cNsFaFCS+ZouF57d+Y5vD
	Gue+nMHV0kQoGptq7vtHXYIllaamFkX6I52vVL7DynmYlEPiGM6Xj+UpCRd5SZQOjc0nrD2W1W6
	H2xpigBwbo7rktp7E89NAi2bu0bJPw+0NnPRFM1DOhfcfCGBCnunYfqPiwmZlOQW6jNHRqzYEaV
	gkaaWD8VyYu4plbIQBXGMPc9RWdqLkJ19/sE1rqNIUikUKF47ucuNETNazFIksquqevvb6E3tcP
	xlE1q0CdyeLDWZIexsGUA0OHYNpzB4RiZ/dZTbw0rM9gP8xseTW9Dbh8LrKo/3/yOBIHWREtnbM
	y26FGfihk70UDrUzZ+8njx6LSOrHUc=
X-Received: by 2002:a05:6102:418e:b0:5ff:dffc:7949 with SMTP id ada2fe7eead31-616fe04aa37mr7617322137.12.1776873907505;
        Wed, 22 Apr 2026 09:05:07 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac462d9sm136370786d6.7.2026.04.22.09.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:05:06 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/6] net/ncsi: bound filter table state to software limits
Date: Wed, 22 Apr 2026 12:03:38 -0400
Message-ID: <20260422160342.1975093-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422160342.1975093-1-michael.bommarito@gmail.com>
References: <20260422160342.1975093-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280464-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	FREEMAIL_TO(0.00)[mendozajonas.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FD01448419
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The NCSI filter state uses single-word bitmaps for both MAC and VLAN
entries, but Get Capabilities and Get Parameters responses can still
feed larger counts into that state.

Cap the stored VLAN table size to the bitmap width before it reaches
the manage-side bitmap walkers, reject GP tables that exceed the sizes
advertised by GC, and stop indexing the MAC filter bitmap past its
software capacity. Also stop shifting past the width of the enable
bitfields when GP reports more entries than fit in those masks.

This keeps oversized or inconsistent filter counts from turning into
out-of-bounds bitmap accesses and oversized table walks in the response
and manage paths. A follow-up patch in this series separately validates
that the GP payload actually covers the consumed MAC/VLAN table bytes.

A live x86_64/KASAN QEMU repro can drive this after GC advertises a
single MAC filter slot and GP then reports mac_cnt=65. Without this
change, KASAN reports a slab-out-of-bounds write in
ncsi_rsp_handler_gp(); with this change applied, the same reply is
rejected with -ERANGE.

Fixes: 062b3e1b6d4f ("net/ncsi: Refactor MAC, VLAN filters")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ncsi/ncsi-rsp.c | 46 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 1fe061ede26d..47ddf2bbb13b 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -22,6 +22,8 @@
 /* Nibbles within [0xA, 0xF] add zero "0" to the returned value.
  * Optional fields (encoded as 0xFF) will default to zero.
  */
+#define NCSI_FILTER_BITS	BITS_PER_TYPE(u64)
+
 static u8 decode_bcd_u8(u8 x)
 {
 	int lo = x & 0xF;
@@ -32,6 +34,12 @@ static u8 decode_bcd_u8(u8 x)
 	return lo + hi * 10;
 }
 
+static bool ncsi_filter_is_enabled(unsigned long enable, unsigned int index,
+				      unsigned int nbits)
+{
+	return index < nbits && (enable & BIT(index));
+}
+
 static int ncsi_validate_rsp_pkt(struct ncsi_request *nr,
 				 unsigned short payload)
 {
@@ -481,7 +489,8 @@ static int ncsi_rsp_handler_sma(struct ncsi_request *nr)
 	bitmap = &ncf->bitmap;
 
 	if (cmd->index == 0 ||
-	    cmd->index > ncf->n_uc + ncf->n_mc + ncf->n_mixed)
+	    cmd->index > ncf->n_uc + ncf->n_mc + ncf->n_mixed ||
+	    cmd->index > NCSI_FILTER_BITS)
 		return -ERANGE;
 
 	index = (cmd->index - 1) * ETH_ALEN;
@@ -798,6 +807,7 @@ static int ncsi_rsp_handler_gc(struct ncsi_request *nr)
 	struct ncsi_channel *nc;
 	struct ncsi_package *np;
 	size_t size;
+	unsigned int vlan_cnt;
 
 	/* Find the channel */
 	rsp = (struct ncsi_rsp_gc_pkt *)skb_network_header(nr->rsp);
@@ -819,6 +829,12 @@ static int ncsi_rsp_handler_gc(struct ncsi_request *nr)
 	nc->caps[NCSI_CAP_VLAN].cap = rsp->vlan_mode &
 				      NCSI_CAP_VLAN_MASK;
 
+	vlan_cnt = min_t(unsigned int, rsp->vlan_cnt, NCSI_FILTER_BITS);
+	if (vlan_cnt != rsp->vlan_cnt)
+		netdev_warn(ndp->ndev.dev,
+			    "NCSI: VLAN filter count %u exceeds software limit %u\n",
+			    rsp->vlan_cnt, (unsigned int)NCSI_FILTER_BITS);
+
 	size = (rsp->uc_cnt + rsp->mc_cnt + rsp->mixed_cnt) * ETH_ALEN;
 	nc->mac_filter.addrs = kzalloc(size, GFP_ATOMIC);
 	if (!nc->mac_filter.addrs)
@@ -827,7 +843,7 @@ static int ncsi_rsp_handler_gc(struct ncsi_request *nr)
 	nc->mac_filter.n_mc = rsp->mc_cnt;
 	nc->mac_filter.n_mixed = rsp->mixed_cnt;
 
-	nc->vlan_filter.vids = kcalloc(rsp->vlan_cnt,
+	nc->vlan_filter.vids = kcalloc(vlan_cnt,
 				       sizeof(*nc->vlan_filter.vids),
 				       GFP_ATOMIC);
 	if (!nc->vlan_filter.vids)
@@ -836,7 +852,7 @@ static int ncsi_rsp_handler_gc(struct ncsi_request *nr)
 	 * configuration state
 	 */
 	nc->vlan_filter.bitmap = U64_MAX;
-	nc->vlan_filter.n_vids = rsp->vlan_cnt;
+	nc->vlan_filter.n_vids = vlan_cnt;
 	np->ndp->channel_count = rsp->channel_cnt;
 
 	return 0;
@@ -853,6 +869,9 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	unsigned char *pdata;
 	unsigned long flags;
 	void *bitmap;
+	unsigned int mac_cnt;
+	unsigned int mac_nbits;
+	unsigned int vlan_cnt;
 	int i;
 
 	/* Find the channel */
@@ -862,6 +881,15 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	if (!nc)
 		return -ENODEV;
 
+	ncmf = &nc->mac_filter;
+	ncvf = &nc->vlan_filter;
+	mac_cnt = min_t(unsigned int, rsp->mac_cnt, NCSI_FILTER_BITS);
+	mac_nbits = ncmf->n_uc + ncmf->n_mc + ncmf->n_mixed;
+	vlan_cnt = min_t(unsigned int, rsp->vlan_cnt, ncvf->n_vids);
+
+	if (rsp->mac_cnt > mac_nbits || rsp->vlan_cnt > ncvf->n_vids)
+		return -ERANGE;
+
 	/* Modes with explicit enabled indications */
 	if (ntohl(rsp->valid_modes) & 0x1) {	/* BC filter mode */
 		nc->modes[NCSI_MODE_BC].enable = 1;
@@ -887,11 +915,11 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	/* MAC addresses filter table */
 	pdata = (unsigned char *)rsp + 48;
 	enable = rsp->mac_enable;
-	ncmf = &nc->mac_filter;
 	spin_lock_irqsave(&nc->lock, flags);
 	bitmap = &ncmf->bitmap;
-	for (i = 0; i < rsp->mac_cnt; i++, pdata += 6) {
-		if (!(enable & (0x1 << i)))
+	for (i = 0; i < mac_cnt; i++, pdata += 6) {
+		if (!ncsi_filter_is_enabled(enable, i,
+					    BITS_PER_TYPE(rsp->mac_enable)))
 			clear_bit(i, bitmap);
 		else
 			set_bit(i, bitmap);
@@ -902,11 +930,11 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 
 	/* VLAN filter table */
 	enable = ntohs(rsp->vlan_enable);
-	ncvf = &nc->vlan_filter;
 	bitmap = &ncvf->bitmap;
 	spin_lock_irqsave(&nc->lock, flags);
-	for (i = 0; i < rsp->vlan_cnt; i++, pdata += 2) {
-		if (!(enable & (0x1 << i)))
+	for (i = 0; i < vlan_cnt; i++, pdata += 2) {
+		if (!ncsi_filter_is_enabled(enable, i,
+					    BITS_PER_TYPE(rsp->vlan_enable)))
 			clear_bit(i, bitmap);
 		else
 			set_bit(i, bitmap);
-- 
2.53.0

