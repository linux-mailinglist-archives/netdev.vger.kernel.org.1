Return-Path: <netdev+bounces-296521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4eVIM3G2JmqjbgIAu9opvQ
	(envelope-from <netdev+bounces-296521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:32:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CE065632D
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:32:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="lL68/l1X";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296521-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296521-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E09E30861F9
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 12:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7835D3783B0;
	Mon,  8 Jun 2026 12:22:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180E937881D
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 12:22:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921362; cv=none; b=qbeYM7ohjjY/FO5LeyifN+tqdZDfN0XfPDwjRZWtl6C5DyqYpgWj8z8yQIufXvJvITOPcaWYSNbVGuOOnbtEWwAlOfikZS1D/9efuob0A3a5cujNT57smM091+NXrj4ghNPeq+0h2WOaP/ECD/3p5iM5CC2wNKfcCa2Zo2BZiRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921362; c=relaxed/simple;
	bh=Dv4CwM9ZJOk/ZPx0EzS3EGyLNfcz1WIk/MBj+Uewcho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PymKfmUZrwgfHKKykuD+lU5y0z86arWrfS1ZjHMltzcXkZyiL1Y5Ao6MrUxeXJWm9NkRK878hXNjOVY+tVlBwWB+CAiZuxtSx+koLLaULC40hf1dBnjObou6zTsg4AWELrgqToGWOqno/HBj8QN1vYzRmVnFafcjA2kVKsnPYCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lL68/l1X; arc=none smtp.client-ip=209.85.222.174
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-91591f19716so543001985a.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 05:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780921360; x=1781526160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MSD/IG5I8Kz7SKo3TgnNWdd+GMqLGnCV42fz5tyyscg=;
        b=lL68/l1XTnja/AgP3x2Aox8rkZ7AYsxizYpNNRhDz6wP1f6gYXWytuBr3ROgXWo9uu
         SHxqel6LVR5RhfLZgB1g+alZu5RbwSGPd5n17tnt8QuSULg5z0Sfis17BwV1aFqoq9gV
         rKK8R69Ws494gHx0+SL2fi7vpVeCnMNB5iqHQn1to051drjbaSvUXGs8BfVT/D0mUYBn
         /Zu2+Cjwg7cxnWnI5HPmnUgyyXAYDBCykEaWQgZUs28pUWbJVOPO7mes593KQd+TQ2nV
         2hy1IzrRLEGsaVuf3+gWdf5r/5b8LFyWFcbBNqpryhQT4QIDi53NjbojCfzJchbpWvTE
         WT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780921360; x=1781526160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSD/IG5I8Kz7SKo3TgnNWdd+GMqLGnCV42fz5tyyscg=;
        b=bV1ITe9NQxtmNqHyHwGEKebDbtbQSIZsx4B6JHbG47FjmAsxR7xRQaqCotnsVeCDv8
         Jy/NhrooteiSvJh7KCVCNRdnbsRfOpK4LPo4sMShBLoUSo5pIn+15rQOE4sI7ETujKW/
         TOxj8c4gwOHTxuMHy0lQRLmIoWeW0FI5Ff+ihgJmPmlc+5Us6CEQpHvX4vsuPadHD2Zu
         vbum24w4waGvZSMt6s5xJDy7bgbpU6qdlqhnYhidb3gBjb0R+nm+tXMVN8eGI+eadm5D
         Ei+Ghrpcz5Uj0xw+u+VgvQW0yc6lEWjAMH7Qzyq0LCdF1C9QBdO+3PH1rGdzsNMXsoyP
         K3wA==
X-Forwarded-Encrypted: i=1; AFNElJ8xmXY6cmP4XwRzbcycgP33+YTmN8Tw3Lgo1pmD8k63ZJUr6ylPXtW6Baqyy9aYDTqaweLKTho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWcVYl4lwC+gAihx5P7kzpGrq3G8oTDjFFz79BYoWDc0q2cban
	2m+ZsXKakxDYxSaLfkCxURWnf373ReVJ238yWtr+/VgJzv4j8gobhxrJ
X-Gm-Gg: Acq92OEfEFiM2VFGkVfv0CALEYNzg7VwOrjX9eu6CvHi0/n+zb0p7lNjuGdXFk2yYxd
	YL7n4peXMKl4O99Db34KVpXzV6bKZ76WeaAFL9io0ezxUnvlepdA4dC9WwLFjSRthVGWjiUDAkm
	IeyMI3+JUJSvUZ2GBrJRVTG6k5E2obI30iD6KzUhyTCdSZYUjAlxdDTnlb+ohTsUAWCbI/EwfDv
	1gtBvppBpdj5amXt+CyvSDzREuadDq6+tbmG/fLU15WMneQ/vICeLeX2HDvbsUnM0TkP3TzuRjw
	PsvYFHnRAvWS1cCawM2YJhn0a6V9IY4BLiIVVLi/t/pnfpbkeYfB7Cw9bZpjf7MBkp5bDa6ooS7
	fDesnV/K1fAOyiONkvVzX6aHlJczO093dIIeFef+NKrH8S1gQP4OC+b1qMFY/P1w416LP2iPoby
	XOd5eYRnYATL9q+P1ggxUcC6grI3KF5vHPbDvWwBNPaTRRYrIoOSv45tIIOlN6AQDN2K9nHWK26
	URJlOBzKmIeg+I0kAlJVOZuQ0SEFYQ=
X-Received: by 2002:a05:620a:28c5:b0:914:cf92:46fb with SMTP id af79cd13be357-915a9d8894amr2422734485a.32.1780921359977;
        Mon, 08 Jun 2026 05:22:39 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a381febsm1691715685a.23.2026.06.08.05.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:22:39 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vlad Yasevich <vladislav.yasevich@hp.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
Date: Mon,  8 Jun 2026 08:22:34 -0400
Message-ID: <20260608122234.459098-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296521-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:vladislav.yasevich@hp.com,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64CE065632D

__sctp_rcv_asconf_lookup() in net/sctp/input.c only checks that the ASCONF
chunk can hold the ADDIP header and a parameter header, then calls
af->from_addr_param(), which reads the full address (16 bytes for IPv6)
trusting the parameter's declared length.

An unauthenticated peer can send a truncated trailing ASCONF chunk that
declares an IPv6 address parameter but stops after the 4-byte parameter
header; reached from the no-association lookup path, from_addr_param() then
reads uninitialized bytes past the parameter.

Impact: an unauthenticated SCTP peer makes the receive path read up to 16
bytes of uninitialized memory past a truncated ASCONF address parameter.

The sibling __sctp_rcv_init_lookup() bounds parameters with
sctp_walk_params(); this path open-codes the fetch and omits the bound.
Verify the whole address parameter lies within the chunk before
from_addr_param() reads it, the same class of fix as commit 51e5ad549c43
("net: sctp: fix KMSAN uninit-value in sctp_inq_pop").

Fixes: df2185771439 ("[SCTP]: Update association lookup to look at ASCONF chunks as well")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v3:
- Simplify to a single bounds check that the whole address parameter
  fits in the chunk, written as an addition to avoid unsigned wrap
  (David Laight); drop the redundant lower-bound test and the
  param_space/plen locals (Xin Long).
v2:
- Regenerate from net/main so the patch has index lines and applies
  cleanly (Xin Long).
- Use unsigned int for the decoded length and compare it against the
  remaining parameter space after the ADDIP header (David Laight).
v2: https://lore.kernel.org/all/20260606183821.1688525-1-michael.bommarito@gmail.com/
v1: https://lore.kernel.org/all/20260604175803.2142975-1-michael.bommarito@gmail.com/

 net/sctp/input.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/sctp/input.c b/net/sctp/input.c
index e119e460ccde0..864741fae4187 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -1204,6 +1204,14 @@ static struct sctp_association *__sctp_rcv_asconf_lookup(
 	/* Skip over the ADDIP header and find the Address parameter */
 	param = (union sctp_addr_param *)(asconf + 1);
 
+	/* The whole address parameter must lie within the chunk before
+	 * af->from_addr_param() reads the variable-length address; otherwise a
+	 * truncated trailing ASCONF chunk lets it read uninitialized bytes past
+	 * the parameter.
+	 */
+	if (sizeof(*asconf) + ntohs(param->p.length) > ntohs(ch->length))
+		return NULL;
+
 	af = sctp_get_af_specific(param_type2af(param->p.type));
 	if (unlikely(!af))
 		return NULL;

base-commit: 9988931df99cf5d68af360e1f23b9c674a0b1b4f
-- 
2.53.0


