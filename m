Return-Path: <netdev+bounces-295285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uXuOBFeOIWpYIwEAu9opvQ
	(envelope-from <netdev+bounces-295285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:40:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2CC640F76
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:40:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SQD+fnzX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295285-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295285-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73FA530C76AF
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6916D48BD52;
	Thu,  4 Jun 2026 14:19:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40248B380
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:19:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582772; cv=none; b=kdCiWUg8uD57KL36SLyfu/W+h2uIo73eGPH7YnznUWuny3hK2K7gdnqNyzO1GoLoc3d53hd/l0oYBAc7sx9PX3lOi5TbPteL5g7N/4U5C/KnTv1QVu15vAP04N0dtYnl8xM51MEqP01nJ2hl/d9Jxw90vXu9e7Uw30E0mXAZDt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582772; c=relaxed/simple;
	bh=bZBJK1bEyOHMOP+p6S1oJ0XzlGGuTJSxJohxL9ZrAFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VfaqsDim+SUcpSel1arpNKxVDdDayGTiuiSF33ka32Fzv0gpZJQKHlJ4LejAFIX5YSN+GPg08vu/Tn9hWxLH4CuBnu6jzDK8hR3aDMh1qT+KOyJSB9bcI3v1R8nRyIWJjrA1BWdVL7UyoTqJlwU9Hyt5gtic9HmIlrPEOfOQNts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQD+fnzX; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-46013161068so406659f8f.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780582769; x=1781187569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMJns1srValYD3xrGqq9bBco3mB6WrjFlMQ0l4f/4n0=;
        b=SQD+fnzX6+74vx0kZss/aosFKYlhirDw7MR2vEBmHXHriwkfjsjT23bjGTtYCx/+QT
         JDO1xH6QwUZXZgfXjpyi6VvyBTAzJVUOVCZEp8S4aeI4Hbiz02NrVOY3egr+VVyLjG+k
         5U/mGzvaHdCFguDJwzSVz15xehjZmwZl8hEqTh/2MJA28wdYbACg5Ux5pR4XhdYLZshP
         FxKsJPMmtOQbXgQruYkUjrEGqH3gQF7Fwyr6cvBNJ9m93IiBgTOLkUNdqfDya+fEPlRq
         rp2lmT/rseQnDGUai2p7twA0e5pC272vJR7YRpUAFBwlbrDtSvVsOqAltPWArPuOEOr6
         968Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582769; x=1781187569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMJns1srValYD3xrGqq9bBco3mB6WrjFlMQ0l4f/4n0=;
        b=Z6Ghv1fYD/F+9Jxa1Y4ptjJzcF4Z+uSnbCnJOuUDIFygm7OtGuNSQZw/HlGZtcoS0l
         Uy6eudHomd6PUm5ejdurJ6F8FnAJDwFQsku7goHDr1amxj6GAtfXhTEIhL7x1Wa+I0xh
         V+wzBQ424y6XbRk1Tgycxzl/VfE9ngXtfVnw+GK/IHr8VVRVEoaQIKAZ9Tu4DzgQsoFf
         2/prjY4tkG6l0+X3u2Prx62t56iKHc61qCMSdT1uFtk9x/vCvyyb+5y7H1BmlSDwCJn+
         fw7m7tOAMMoVJxn/SvvTPdMqXAOg/S9SWnuJQXEzANzUtL+4lGoIsUNJWvNy0yyR14Bl
         2Mfg==
X-Gm-Message-State: AOJu0YxEPGJM++rocWCtGz9ZCP5Z/yGHNdNCiXKsimK2wdkMPJvTR5iQ
	tJhPvNwqM6WV8uT0asgox9Qtb1HVCkovfP03G2O6du2bt1Pfrakh9b8m5Rljrvk73w0=
X-Gm-Gg: Acq92OGATmXNFv0daWq+zaCy7ZLqucQeNu99ZD5H5OAk1yFU7wQGRrbvJBWWqqLiBHe
	risXFQJ6JAuhayq0SUkB2kDKJQFeQi2Tiz8dX1yxZaS8soOx4rloc0MWREzUmXIjP+L0MulWYgz
	h3sxqjJoBInC061uQ/GubRcp+PkMm49K9yngTQPLt7m93xnT+9oWEQGL6e6MEo/HcQ4A0foI6vg
	YY8qtmMjNTrd0GAWmVHZEx2Ecm8eTEjLSqxO18eKgZk2kD3TFKGNDSF2CeikTenticxKdiNX/Ex
	RcOKFf05TCLcyRIebrmaE7jkd6HRdfVuJLBFka1tEsUAJh7gULinIZnWwbu1yFyd1dMh8keXnFj
	aUI/andB1jawfX+DSTL9Q2UYpI+GIQu0RlBVWfGop9Qv7yRP8cisYg/ki8AyTx1gyo3H5qaFrk0
	ceTjrgUBxvE0kMd0qhdZbRa1KwaaeJqs3poHIaSdtYcO4srtUChtPwG4oNr6k7XJmnEHWprgnZt
	ao3X7RXqxoQ7LFKAesUYw==
X-Received: by 2002:a5d:64e4:0:b0:45f:f142:d56c with SMTP id ffacd0b85a97d-460217c1330mr13296092f8f.16.1780582769247;
        Thu, 04 Jun 2026 07:19:29 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc412sm17274297f8f.4.2026.06.04.07.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:19:28 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Claude <noreply@anthropic.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: garp: reload skb header pointers after pskb_may_pull()
Date: Thu,  4 Jun 2026 15:19:22 +0100
Message-ID: <20260604141925.237746-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,anthropic.com,davemloft.net,google.com,kernel.org,redhat.com,mails.tsinghua.edu.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295285-lists,netdev=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,anthropic.com:server fail,sin.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:devnexen@gmail.com,m:noreply@anthropic.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:tglx@kernel.org,m:zhaoyz24@mails.tsinghua.edu.cn,m:mingo@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,anthropic.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A2CC640F76

garp_pdu_parse_attr() keeps a pointer into the skb linear area across
pskb_may_pull(skb, ga->len), and garp_pdu_parse_msg() dereferences gm
on every loop iteration even though the nested parse may pull again.
pskb_may_pull() can reallocate the skb head, which would leave those
pointers stale.

This is not reachable today: GARP PDUs arrive via the 802.2 LLC SAP
path, where llc_fixup_skb() already pulls and trims the whole payload
into the linear area, so the inner pulls never reallocate. Reload ga
after the pull and snapshot gm->attrtype into a local anyway, to harden
the parser and match the skb_header_pointer() discipline used by mrp.c.

No functional change.

Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/802/garp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/802/garp.c b/net/802/garp.c
index c7a39f298ad6..56b934ec1aae 100644
--- a/net/802/garp.c
+++ b/net/802/garp.c
@@ -452,6 +452,7 @@ static int garp_pdu_parse_attr(struct garp_applicant *app, struct sk_buff *skb,
 
 	if (!pskb_may_pull(skb, ga->len))
 		return -1;
+	ga = (struct garp_attr_hdr *)skb->data;
 	skb_pull(skb, ga->len);
 	dlen = ga->len - sizeof(*ga);
 
@@ -492,6 +493,7 @@ static int garp_pdu_parse_attr(struct garp_applicant *app, struct sk_buff *skb,
 static int garp_pdu_parse_msg(struct garp_applicant *app, struct sk_buff *skb)
 {
 	const struct garp_msg_hdr *gm;
+	u8 attrtype;
 
 	if (!pskb_may_pull(skb, sizeof(*gm)))
 		return -1;
@@ -499,9 +501,10 @@ static int garp_pdu_parse_msg(struct garp_applicant *app, struct sk_buff *skb)
 	if (gm->attrtype == 0)
 		return -1;
 	skb_pull(skb, sizeof(*gm));
+	attrtype = gm->attrtype;
 
 	while (skb->len > 0) {
-		if (garp_pdu_parse_attr(app, skb, gm->attrtype) < 0)
+		if (garp_pdu_parse_attr(app, skb, attrtype) < 0)
 			return -1;
 		if (garp_pdu_parse_end_mark(skb) < 0)
 			break;
-- 
2.53.0


