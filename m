Return-Path: <netdev+bounces-296202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 87rUFdc+JWqhEwIAu9opvQ
	(envelope-from <netdev+bounces-296202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 11:50:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B9864F418
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 11:50:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=uYduBuZF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296202-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296202-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E9323003BFE
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 09:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E156388377;
	Sun,  7 Jun 2026 09:50:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C12C2EA749;
	Sun,  7 Jun 2026 09:50:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780825806; cv=none; b=IfvZ86wuKOFdO2qd9byaI/hR3nUngeVXU5hPwJAnwjIV5pEdnnBBQIBlt/BO3+I8PJnT5W5w2bmnco/LQcYGT5TzFkvYK0hzijqQEPeMzRiKgLS/W+ByRFfcwD99wRE+Yzg8f0jvonM/+FtmJeXBf46FIqPMEjzPKsO1NTWmbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780825806; c=relaxed/simple;
	bh=7BmVU4tkNybgTi7CezIgNFD+tIc9a04Bw3NSwlWmOEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sw2cR+JJIurE0MwsJu6RZOHSG0W+RZaAOla6r8qNsmxsFC+nChwcQ6NPQ6joqV5Zjj5njwSviQyCuBlXSY/dJdv0ICGTd0b9yKv7qiQKW3CK9t9nXm1zfygEw1NAt76Km0fwRyBeXL9dEjPGoQn4jEUiu/LK66SxXlrGT/KsPxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=uYduBuZF; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 1CB326019C;
	Sun,  7 Jun 2026 11:50:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780825803;
	bh=lH/8Y4s/HAN0AI55N4GmKCh8A5UwLJBN8qLlXk0B/E4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uYduBuZFWVAg0XIH/Cyhh7GOUgoMKji9CxSN0U3p0kfmpwDYTuvX3GCftNk8VoMae
	 Cb8yD0lJJxIt+S/X3Vu8FuOn9vGPCKZ1ONjGWqXehZk/ZvrIgAYiBlLA+jFlOSEqYR
	 iApE4ZKi764EZOa1z115q8pYMTCJLKrJgOpzoxGfx9hDfOGfz+PMDXOOn9UHnM/9aJ
	 khozBBGbA7l9dxeK+az3ZhsuOB6KUoVo7xNN+Adc1slZufU6Blg5IHOvdO9WAaE5Yy
	 cOpS2bnw3jM1vriw9V3UObmVVc81RdchcXuvBKHvE4wiEd7nVbrRF1jiBvQcAW7FO1
	 PqJD88ipXfBFw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net-next 02/15] netfilter: nfnetlink_osf: fix mss parsing on big-endian architectures
Date: Sun,  7 Jun 2026 11:49:41 +0200
Message-ID: <20260607094954.48892-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260607094954.48892-1-pablo@netfilter.org>
References: <20260607094954.48892-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-296202-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67B9864F418

From: Fernando Fernandez Mancera <fmancera@suse.de>

The MSS calculation in nf_osf_match_one() manually shifts bytes to
construct a 16-bit value before passing it to ntohs().

This works on little-endian hosts but it does not work on big-endian as
the bytes are being always shifted and set in the same way for all
architectures.

Use get_unaligned_be16() to fix this on big-endian systems. It also
simplifies the code.

Fixes: 11eeef41d5f6 ("netfilter: passive OS fingerprint xtables match")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nfnetlink_osf.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index acb753ec5697..92002079f8ea 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -95,11 +95,7 @@ static bool nf_osf_match_one(const struct sk_buff *skb,
 
 			switch (*optp) {
 			case OSFOPT_MSS:
-				mss = optp[3];
-				mss <<= 8;
-				mss |= optp[2];
-
-				mss = ntohs((__force __be16)mss);
+				mss = get_unaligned_be16(&optp[2]);
 				break;
 			case OSFOPT_TS:
 				break;
-- 
2.47.3


