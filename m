Return-Path: <netdev+bounces-293944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJWBH4QsHmqohgkAu9opvQ
	(envelope-from <netdev+bounces-293944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 03:06:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B1B626C74
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 03:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D029300CE66
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 01:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F1D330B3A;
	Tue,  2 Jun 2026 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfv77ot8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E2D32B109
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780362370; cv=none; b=nqJEgYVcUIOMk0PBNPvnJ01gkgAto2G5rbjZIgIZBDofaVmE/JFyAsIZBYaL+XbZrGwPbswMxb6x986x+c/TN2hHAHZAQFfpek6Ij4JuyPSSCWM0++iNvWtntt2xuAD/zrBHEpMO9N55PfhaBCOyHSnWkZynl2grNEXF73rkNq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780362370; c=relaxed/simple;
	bh=SPuNjNp8A0Zl/TJKGXESaD4k1bO4yqVtv1eunXpANEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xu+gaQUSqTMwVTp23tiqo+8sbTTw/aD2vHBNDTTZD/rGA4ZA8rxnrpXW8eQZZqFSXvmZZyTJQTABQXuOETs4q3keKH+Zc+0zCArrzEePjEHbidEblSKA2muql8YY5asTFSd78B5r3hKFLt8ba1Tim8fQz9hd2PSWoHcdLGeKHw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfv77ot8; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9153e2708aeso313770285a.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 18:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780362368; x=1780967168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MSDNDfUs/NxbWcXNNg7qyqWhJd8aRin4937n/eP10yc=;
        b=kfv77ot85zAVXhQ5OH78csxA7j4d+qXUh/UZSGEfj8bt9V4LfkT3DDqkTh0OLELzl1
         rLJ7yi1InCnB/Qr/C3sKteS3BWWgYnaqQeO9LMg+/NF/p4ixb4A7QG9dVvmPenqxrA8/
         Wc+8/N5d3bkmzhvJtO5RAYpDpAHWBIX16H+00pWoccaPbgwUF7Qucm4XTiXQLaGMuuRW
         CdGpNEGlLXkTnWFNKwZrOJTmHiYfDA+kzAysh+ov2qgB0Shkbv4wkTUutLQWeulP+EMb
         RzI0Rx77Y2jxul1zQzGesIwf671gy5DzrJLh/E77GLfAeytdl1NfyA1UizRq/bWlSvFY
         P96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780362368; x=1780967168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSDNDfUs/NxbWcXNNg7qyqWhJd8aRin4937n/eP10yc=;
        b=RK0CA2nrIJO4BMMGt6DfTa4fTNqxR/A+IfzLwmeOW8Sfmkhjw8ERiENlQAxgwGIHNa
         +Vxmcllg35T6vDVx1ixtIYmkAYNS//iwDSSdBVoqGfgCTnqArLmUngHQ8ofkWCjLd2y5
         EYcFuZmKj7X6TBocGUtyyiNPxAbMYSkmRMQy0oFIe+Y7yJc05YTuNiblYAynxT2LWdTB
         f0+YYPP3/wC4YznAA9n+wo++QIY45IgWXCD0vv+yXk0dtTSkrzYCxO43IowwQoMjuBPg
         XjCduozru0w0wyOI9FC3kivdT/2Z1iKPZJrx8gsPaJuKem7NKR5Rj2miv5WyUHHQjgUC
         fF5Q==
X-Gm-Message-State: AOJu0YzfttNQ0ghtyRnIhFuxRMp7Zyio5CS1ppvIkekn98bN8kqRhRy5
	S+ehbVsmC7B3ymjf4j6kAMmYdsJZYa3z2hjc2Iyc9kamYkyoRq80ex9cTYBBGw==
X-Gm-Gg: Acq92OGoBIEOlNtAEjPc5Zni+ucpLnPejU0NDivkuz67y+KX5KdOaLk8k2+b1J1UlvX
	fp4NuwbqG6iCVw+jzNM/1E2Cpc6tHK7dhvQsqxi1H/G9cWjB3Gx61GbH9Ib9jCUTgqQWq3eAr4h
	3vyHObP1FAcYOGaBLhL4WSgGDyxu9lkl25kJCBWTe2IVcNJ1vVCoAc5h9oX4Nyh6h5QmX42RBXt
	zPwHumicwgFFwpuACUc3sxvyrqWkOhokcNJYSO66G6xri2AgZawlIu7jbAttqagWFrvp1WynZrn
	VU1rygbt1DaJSmUKgPrRFXxZzdftJiWFY7EGh3NPkdxoznxc6ZWBgRgcSm/R9avHb3k9eChtPTW
	asrTKNvN3tQ2XTkuRWpLh9rLl6P2qiCzYBExqI9xfHwuDMuZJ40F4ZIvD/jzU+SVEH3n5++5lfI
	L/zWuk1zCEHce/if9xB1fccUrilmT3GkP8cf9Q0/guTdkpQP6X+KpGns+mmn1U7Y0QeqVo7anhT
	hYpAzrrOoh6NIeL97HmoOrjkNA7JZ8LhsO07vI1NrJbQ9zMlZQFpC9gQgiS8JqUaQiYM7yDfu9Q
	K2b7dWlSN70=
X-Received: by 2002:a05:620a:a28b:10b0:915:2404:bfe9 with SMTP id af79cd13be357-9153d96abf4mr1604595085a.9.1780362367772;
        Mon, 01 Jun 2026 18:06:07 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153244de53sm1190856485a.8.2026.06.01.18.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 18:06:07 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Brian Geffon <bgeffon@google.com>
Subject: [PATCH net] sctp: validate cached peer INIT chunk length in COOKIE_ECHO processing
Date: Mon,  1 Jun 2026 21:06:06 -0400
Message-ID: <eb60825fa22d6f9e663c7d4dbb69f397b5d34d42.1780362366.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-293944-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D5B1B626C74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a listening SCTP server processes a COOKIE_ECHO chunk, the cached
peer INIT chunk embedded after the cookie is parsed and its parameters
are later walked by sctp_process_init() using sctp_walk_params().

However, the chunk header length of this cached INIT chunk was not
validated against the remaining buffer in the COOKIE_ECHO payload. If
the length field is inflated, the parameter walk can run beyond the
actual received data, leading to out-of-bounds reads and potential
memory corruption during later parameter handling (e.g. STATE_COOKIE
processing and kmemdup() copies).

Add a bounds check in sctp_unpack_cookie() to ensure the cached INIT
chunk length does not exceed the available data in the COOKIE_ECHO
buffer before it is used.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/sm_make_chunk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index de86ac088289..85264862fb6b 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1730,6 +1730,7 @@ struct sctp_association *sctp_unpack_cookie(
 	struct sctp_signed_cookie *cookie;
 	struct sk_buff *skb = chunk->skb;
 	struct sctp_cookie *bear_cookie;
+	struct sctp_chunkhdr *ch;
 	enum sctp_scope scope;
 	unsigned int len;
 	ktime_t kt;
@@ -1759,6 +1760,10 @@ struct sctp_association *sctp_unpack_cookie(
 	cookie = chunk->subh.cookie_hdr;
 	bear_cookie = &cookie->c;
 
+	ch = (struct sctp_chunkhdr *)(bear_cookie + 1);
+	if (ntohs(ch->length) > len - fixed_size)
+		goto malformed;
+
 	/* Verify the cookie's MAC, if cookie authentication is enabled. */
 	if (sctp_sk(ep->base.sk)->cookie_auth_enable) {
 		u8 mac[SHA256_DIGEST_SIZE];
-- 
2.47.1


