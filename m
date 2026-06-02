Return-Path: <netdev+bounces-294114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM/1ES+lHmq3IwAAu9opvQ
	(envelope-from <netdev+bounces-294114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:41:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8A062BB7F
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 11:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 734E93015881
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 09:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DDC3D1704;
	Tue,  2 Jun 2026 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="BYMu9odB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MW3OIvtO"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174C93D16FC
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393245; cv=none; b=KRFfL+SLSVWmSSgdsQuEifWjSvI9X7jtEbMCw65U6u96h01bDvyq6vS9epmreKbXE8fv0b0FxTfiL2v7LhXpFfYZWiciKzkZFDfWgB5z/BGweJtOTXYFh2sfHQ7HGIS91SL/jvCZRpY1L+I/m8fAFg+5x3sj5bQ3s0F7PFbVKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393245; c=relaxed/simple;
	bh=YNV0P3187X4bJ5z4JkmK9JtfzpaUHgewjelhe1nrlro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xb592GNvgA7ksr4qZelV5z3lLX8fyeminfB3R4PivEOh5P/8SM2IP5tyugnP/X9QXYU5J0hIbifBUOdaNS7cOZ0eLkNwxdLM6dPDveRVbYlNPINUYU34JXrEJ7y9vIUNnjV20MNf7QC6Hxj15EAQwhP16hp8PzxHpup46pLrxqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=BYMu9odB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MW3OIvtO; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 155B27A0135;
	Tue,  2 Jun 2026 05:40:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 02 Jun 2026 05:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1780393242; x=
	1780479642; bh=4R4rqPdhmvE+WG+QusgyxV/z9YIC3V1TUrnQrZRogrE=; b=B
	YMu9odBb/31Kr93QoXkQ8T/9I/FVKADMZqFbPECq1zpyJ12cAgk33NQx5Cj79wbo
	nUFY0AdtFczGf7cnu+pj6dkDaRgDmSwZn8GMUXkafvyQ06HhTrg/NbgAcUXQTJKf
	yKY2UMM8I82yl3Jw897NukoWzqM9ZprutpHJ2Px3y0FH3rvpA2Rldr6MfDiwBj80
	+ykfLOjB1uRPgovLdOiztumrvs6RmSLRLxaN1IsGFK9uJ8Fs6FAxuyWZEiXU8vcs
	0TWf9rxmfj7Prqne3d+28NSly7vEPdrDAKsLJagqbMy3uAalsumvptEBrwdC8VcB
	kOQC9apU6zx5WvQ1Q0D3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780393242; x=1780479642; bh=4
	R4rqPdhmvE+WG+QusgyxV/z9YIC3V1TUrnQrZRogrE=; b=MW3OIvtO0ZBfbMEbH
	axYtRJ7nCZ+8qn89NI99ouMJ2bqTmtKS2xMlXD0TQF2IGnze8gnSbr4H9PXr+24Z
	1z6eetxkZu7SKAf/912Vpo8dT0zEQP53zE9ke03bIDe+JO4384PJfOQBXsGcq1Ot
	WcheJVMUQfx2WxSwNhVFTDmQVh4EbZGLj9gjoUcKxUy6Zb5mUPdGmoPQlxL1Z6wg
	FaueGx9oRWy6sBCxc83DFP01Kw3sZAkJT9GMJG2jfM3KHX7BQM3lw7wp0TUH3/uc
	SlRT7cVo9BehttPY89lSm5ChAgk4FWknM0src8q7SqgFzi79F4yTkfbQf2Ig45fT
	2urrQ==
X-ME-Sender: <xms:GqUeavGeNKh36x3zR0JC802YpXsg_doWFx5-Dyup0pS-5o64fdrgoQ>
    <xme:GqUeaq1w5kjkdLckP9Wi4a67lJB7Y9v84bJ0Bb_p9wa7DpjEjDIBZXvDlANMToE_y
    Rg20SE1Qy5hDxlWiAxTv79TkAjArP9tXsTtqc1quwb6yqQz4h2bCt4>
X-ME-Received: <xmr:GqUean-D0W7nqe2MomnxoP6_ZH661std5oAwfDv9VkmMOgAQ-2G31KkFn63kTB5ENmZLFRv-x2tiYm6qeqY>
X-ME-Proxy-Cause: dmFkZTEhfRVF1SKd+GLnfZgooACD6hO2wJk+Zyim2TRNm1FE/QAPLbyY/pSJn/R1ebWLdW
    8ddtkh5p3JaW9uH4aGXXJD9FFQUSHMnrYr3OV6ljKpntCcdaC7UcJhE5szseZ2k5GRYeY/
    Lhvny7OVdXCJitqlBn5HEyGYj7iWIQvNEHlPT+KL5jFhxFuoRwHHVQ/22ycwjLowSE3ABx
    zXZkS8ByTzJZqhEcDidmGmaCAG3Qn6XL4ySjcbiTRQa5YDOaCIcA3JQ2yezAI+o892cMlK
    BfpgTV+tXB0+ERUl9fBWyXQ8QW4KFHxt8Ha5ZmXsci0qG/g3QjJvVgWrbXt6zdycTVBBDQ
    DpaaBFThvZRqxILdG3h/72zr9LoQ3B716c9LrpPfnH9gi842erty3oMj8Dct9MXisdy1+q
    /uxpWO2MlNPI+rU+Q7ETcIiNyjh77ysibLCO/89x+REDP7NjU2TYavX65Eq8P1FwYyKITK
    iPZwZWQV1m3Z9GFNR1ilz42fo1K9wtDzc374BGsSfw50wIsWee0PrU93lW57flFY6JvdeK
    eGmDBGkvu2qYY2Qy0BWyMdZL2EbyFVbNJx1LIKTOh5EyK75ldokw753plvZFHUyYJ/SCOX
    39LDW/cQ8dr9GPqtOy9BrfmPBebaQ8MxujJoBjdftb52ZiwhYNBcemWuUl4Q
X-ME-Proxy: <xmx:GqUeatFi05fsipHOnAybR1ObiuoJKLlYZOnzXlYokYremfca51F5ZQ>
    <xmx:GqUeatgWdLapdHkXliTREPQicukSWX3lVmzzZi2rImdNYnLtfLmWcA>
    <xmx:GqUeai9ITJdpM0nQ1jo53I5gyg1CfgWUAC8A4-CTx0qTQO-H4nzRQg>
    <xmx:GqUeatb7VSAjB2xOledicwl_1tKqZN3D8jqEg2gqePB51yT4XpVN1g>
    <xmx:GqUeakSPubzU7kdUFPIJQjh8o7roTFP8UYcj-iYwTK6vUarfJ2DWpBjo>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 05:40:41 -0400 (EDT)
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
Subject: [PATCH net-next v6 02/11] geneve: Fix off-by-one comparing with GRO_LEGACY_MAX_SIZE
Date: Tue,  2 Jun 2026 11:39:22 +0200
Message-ID: <20260602093931.516281-3-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602093931.516281-1-alice.kernel@fastmail.im>
References: <20260602093931.516281-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DC8A062BB7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294114-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Action: no action

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


