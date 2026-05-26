Return-Path: <netdev+bounces-291806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNZoBpnOFWrkcAcAu9opvQ
	(envelope-from <netdev+bounces-291806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:47:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E8D5DA06D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48EDD3150491
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933223AF64E;
	Tue, 26 May 2026 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="dBRf0RGR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b84mczJd"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BC83AF643
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811994; cv=none; b=lkk4apwo/ONe+PzvnfjwFjWlvsBO4SQm0l/kVOXIe8I3cHKhCLupmyx0AzLcvr+yLQwXWX7sQBqM59bSa+OSPqEs8mx48P3latN/Sbjlik5G1+dSZH0X/ANZkprVb3fNnsOQf61wsttGu3+6xwMdw+ozlCaHAt3rT0efHLLjzXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811994; c=relaxed/simple;
	bh=YNV0P3187X4bJ5z4JkmK9JtfzpaUHgewjelhe1nrlro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIJlKbkV35EK2lqk/y2eiJBi4lfT01TE2GUv6Jq6YPKmHel27HG5HpQwLn3Zzwh1e90/LKbRC+Kr9jEss3m7ZKZL5uX7zbJRA6bHzEkJjv6y5Z8UKptfX9Apgt8woul096wxTJ/9zVBThJzOTTzTDH5rL4lnReD8dXCHE5xihWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=dBRf0RGR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b84mczJd; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2BF1F1D0007F;
	Tue, 26 May 2026 12:13:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 26 May 2026 12:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779811992; x=
	1779898392; bh=4R4rqPdhmvE+WG+QusgyxV/z9YIC3V1TUrnQrZRogrE=; b=d
	BRf0RGRW+P8XGYmHtVQT6a0WSQGPdoA3wKTkDb3OSL/8P4/7kyyyM0j86JfkdxBP
	lcA89G08YhRiHVU3UxfTlTZoJs6gbTiLvj88BeQG+4Cvb3Hcv5OTYKqjzAv3p/Qa
	t3O6xA4XM4BqKiVPUOg3DhU5T6407vnJQ5QI1WET7qQjTwONgJ8tuZvc2AQBW8To
	sRXTwgvlaqEGWkxtMRMMtKhUwnGjLSg7w6nQOTsOFjf30lf9oEt/gX0cKs8Y4Giz
	lQxFNd6IqzN9dhNTTnYlKvH3Bk2Or9AnHSEFYaOeE4ASYG7tSXb8ntFpYDT94sXS
	NAOG5Oe5g52rnR0kQHQng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779811992; x=1779898392; bh=4
	R4rqPdhmvE+WG+QusgyxV/z9YIC3V1TUrnQrZRogrE=; b=b84mczJd8DgEQ5vr2
	T1NuxMLK4+hGnvhwHxW19K4Bdizgi3PxjU+VJIdc3G1FMNhXO+ysDNdrAtw7nQRm
	IYH3C6hSykEC+M05Km37/0LMnOfbjx3izLG8BFiWsRon59iIqlcUcnZg+DAaMgPj
	flt3lxSIu489iPcAqFckKymxyrtaSB1R7xbIfFt0IKuC+DPdvV5UnAnWxP0Ih0dE
	yaOOwoiJ2y1aZGLgM35XeQhKYK1oWhr25hvkZwnlIm1htCIzVAq7cyo5uGd4bhbB
	u0GyX0Kvkf1ZIBcdHQMz0xfSTJGXo4fKZmHpTIdApasQeNnWphiaHvVwAof7Dw5r
	lWEqg==
X-ME-Sender: <xms:l8YVaopLOObFyZTUWbcw_DO_Vqy_X1SfAsVWpcRbnbVVrf00PZFbHw>
    <xme:l8YVatJjlMhCW5Ig2UF2TvG2i1gK0u9IuyUOJj9nRgkfxeOLwgR7crGjHeu7L83to
    --bcEdcUY6X0VkUgNMc0ghIDWtQj_wHniKbTtU31zbJy57KvJPmUobH>
X-ME-Received: <xmr:l8YVakBIcVBtIJ4N3ebabLXd8wRGnG1zz4ltPh7d2fkmDaX9z3VgHFS86x5qaqWD_yU7dHKWG-sBKcUAvTBkFL7pxeAjSzE02c6rNA>
X-ME-Proxy-Cause: dmFkZTG4G9zbtpZgR+LIx8EkHbmWKiCUD5lWWjQ7rQgOwm/VyUoO4wynI5PAYAu1dD2VK+
    aE6JARqIKgaU0Q1bOd4rLnkhu7UmRwqeTgvkSV5d7grxG9FOkQ0oQeRmYwxzVcDeyksT5X
    MnuMadVg8leAkVjnwRPLpa+FDPLAPVROlFfmUAgtPHyfk3o9NrypRZ0abuRJIK8O5lp5p8
    tzBD3Olzgd7un01+SJnRGQin/adteeVD2Zbc2V/ul/M6kb/60qayxpEi+pujApdRm0DdBA
    gAhadAA2ZHV1xUAE8cGyD+tUbCqQfxKzuc5eRxGV7Mo52+ocM4y7T5twJ1LOAdcR6Qcts1
    snXkVQAae9bA/rcVRq6/XHh5EXm5+Xo83v0/qIW9T+aw/U5Tuv7NRGdob50esEtcM4M0wK
    vA171w4dQ5FDMszWUn95/r2ODK9Soo3fMupeEFlNFcLuHfWqaKbhVeXTXy2yqoSp0+R9sz
    bqTKU9Us25OYUacivKxxcf7sgJHOX4AWBeMd04cWjTJa+EGqsfRHJKAdN6VNLJiz1C1hRq
    SrMYS0a3mLDuL2rnZQaVU6KIIhnjVGYbHDhcn9JMpsmXe2iV+ndMBWGwqxcCxl/y4KUDcF
    qTgOgs0KeRq3gi053tkIW/qdqQjudyPf30Zga/MOh7RCf+dmfy2y0oCWFXyg
X-ME-Proxy: <xmx:l8YVav6Oi_OewRX3dMgGs4vKM_E45T1Y9en8AGrWyUp7clOMFUlfYA>
    <xmx:l8YVagFUC_u_mVw-CA2F6r-u8zDeWEppT8SiIded9nQeukm4grorNw>
    <xmx:l8YVaqQocJz-Q0cfy8oBclZTlny7CxAbxwsN0GkVayqKv0zkuct_Nw>
    <xmx:l8YVaqerIe5RzjIpJ3IGw1pfMN3tDW5IBl7Wu2iAhp3DHblT9LDsyA>
    <xmx:mMYVatG1Pl_PEbFkX-Qwn5mrtJ0d2ZYImKWYdJPmDEtFLUQlgghOXVO3>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 12:13:11 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net-next v5 02/11] geneve: Fix off-by-one comparing with GRO_LEGACY_MAX_SIZE
Date: Tue, 26 May 2026 18:11:51 +0200
Message-ID: <20260526161200.1135899-3-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526161200.1135899-1-alice.kernel@fastmail.im>
References: <20260526161200.1135899-1-alice.kernel@fastmail.im>
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
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-291806-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fastmail.im:mid,fastmail.im:dkim,isovalent.com:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 71E8D5DA06D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alice Mikityanska <alice@isovalent.com>

GRO_LEGACY_MAX_SIZE = 65536; total_len being 65536 is too big to fit
into a u16. As can be seen in skb_gro_receive, packets bigger or equal
to gro_max_size (or GRO_LEGACY_MAX_SIZE) are dropped with -E2BIG. Apply
the same boundary to geneve_post_decap_hint to avoid writing 65536 to a
16-bit iph->tot_len field with an overflow.

Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/geneve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index e8ff03ed87dc..ae8ff31cffa1 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -603,7 +603,7 @@ static int geneve_post_decap_hint(const struct sock *sk, struct sk_buff *skb,
 	ipv6h = (void *)skb->data + gro_hint->nested_nh_offset;
 	iph = (struct iphdr *)ipv6h;
 	total_len = skb->len - gro_hint->nested_nh_offset;
-	if (total_len > GRO_LEGACY_MAX_SIZE)
+	if (total_len >= GRO_LEGACY_MAX_SIZE)
 		return -E2BIG;
 
 	/*
-- 
2.54.0


