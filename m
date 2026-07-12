Return-Path: <netdev+bounces-306914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XubcIxXxUmpzVgMAu9opvQ
	(envelope-from <netdev+bounces-306914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 03:42:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3857436CF
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 03:42:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Kt9wjT/F";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RxicZHdl;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Kt9wjT/F";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RxicZHdl;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306914-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306914-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1C8B300CB0F
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 01:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3B822538F;
	Sun, 12 Jul 2026 01:41:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC08E23D7F4
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 01:41:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820505; cv=none; b=bLpaAbCnnOb9v9m0FxQTxBb/QldekQblkSmJTEtqFXuuF8V5MXMyY3KclCbL5fvDxtHxLumcHROz/CpEYBJWpalM3tGZ0hdCbbJNGiqxPhZcGe1+q6+mifKIlpvI1TuRCM3eDqKEq00NHl/T+E5hRkaGh47+H+r3fN2K0W1iNik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820505; c=relaxed/simple;
	bh=uQepJTW5bsthIHpjN00WzaUi/2LqkvhVW4zOOvL6ulo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyVqOlbbaEQlF7YXOYGtak7U7HT/TqqPftE3atYSumPJPj2bbkELamR7CqfOz+ryCVW9KYIG5qL83q5ZgK+VajnGYPDfFLDBagzsE0KVY1P86Xv7ENVD2YhspM/pEbjiYx1/sxApdbGphV9uKofKjgYB4gILY5+6p7ghhlJHIlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kt9wjT/F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RxicZHdl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kt9wjT/F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RxicZHdl; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CB987703C;
	Sun, 12 Jul 2026 01:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783820502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCVNOl+asOY39V6nfgcfX0SO0vLx5Gr5x9oNv0br2lM=;
	b=Kt9wjT/FEDKNlDlC44gNbPz0I5GmZzpp00qgj8Bw9B7aF9BvgLd5od/naolrs1PQYnSuus
	KSojyNwg5HVs0kkz3xInQK6U9wJhC1S67PJL/70HFn27jpzZ7OGegjC+CcaqIiIHsXKk9N
	sFbiysjNHMhGed2IVBm/EctdT3hmwGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783820502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCVNOl+asOY39V6nfgcfX0SO0vLx5Gr5x9oNv0br2lM=;
	b=RxicZHdlbz3vJy6GWmQiDcdfo68c6ua73gvJJuA/ArsNIartWu33KN5Ymg1OKEp9IJA8Nb
	OwDGII8MXILTGZDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783820502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCVNOl+asOY39V6nfgcfX0SO0vLx5Gr5x9oNv0br2lM=;
	b=Kt9wjT/FEDKNlDlC44gNbPz0I5GmZzpp00qgj8Bw9B7aF9BvgLd5od/naolrs1PQYnSuus
	KSojyNwg5HVs0kkz3xInQK6U9wJhC1S67PJL/70HFn27jpzZ7OGegjC+CcaqIiIHsXKk9N
	sFbiysjNHMhGed2IVBm/EctdT3hmwGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783820502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCVNOl+asOY39V6nfgcfX0SO0vLx5Gr5x9oNv0br2lM=;
	b=RxicZHdlbz3vJy6GWmQiDcdfo68c6ua73gvJJuA/ArsNIartWu33KN5Ymg1OKEp9IJA8Nb
	OwDGII8MXILTGZDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A33C779B5;
	Sun, 12 Jul 2026 01:41:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wCnSFtXwUmqRegAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 12 Jul 2026 01:41:41 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/13 RFC net-next] net: cipso: guard IPv4 packet manipulation functions
Date: Sun, 12 Jul 2026 03:39:09 +0200
Message-ID: <20260712013941.4570-12-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260712013941.4570-1-fmancera@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -6.80
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306914-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:idosch@nvidia.com,m:fmancera@suse.de,m:paul@paul-moore.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:from_mime,suse.de:email,suse.de:mid,suse.de:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F3857436CF

To enable compiling the network stack without IPv4, the CIPSO functions
that manipulate IPv4 options and generate ICMP errors must be bypassed.

Ideally, CIPSO should not be compiled when IPv4 is disabled but
currently it is too integrated within netlabel, so let's just bypassed
the relevant functions.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/cipso_ipv4.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index a05aa075de1a..17bb723299d7 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1714,6 +1714,7 @@ int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option)
  */
 void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	struct inet_skb_parm parm;
 	int res;
 
@@ -1738,6 +1739,7 @@ void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, &parm);
 	else
 		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, &parm);
+#endif
 }
 
 /**
@@ -2171,6 +2173,7 @@ int cipso_v4_skbuff_setattr(struct sk_buff *skb,
 			    const struct cipso_v4_doi *doi_def,
 			    const struct netlbl_lsm_secattr *secattr)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	int ret_val;
 	struct iphdr *iph;
 	struct ip_options *opt = &IPCB(skb)->opt;
@@ -2235,6 +2238,9 @@ int cipso_v4_skbuff_setattr(struct sk_buff *skb,
 	ip_send_check(iph);
 
 	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif
 }
 
 /**
@@ -2248,6 +2254,7 @@ int cipso_v4_skbuff_setattr(struct sk_buff *skb,
  */
 int cipso_v4_skbuff_delattr(struct sk_buff *skb)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	int ret_val, cipso_len, hdr_len_actual, new_hdr_len_actual, new_hdr_len,
 	    hdr_len_delta;
 	struct iphdr *iph;
@@ -2296,6 +2303,9 @@ int cipso_v4_skbuff_delattr(struct sk_buff *skb)
 	ip_send_check(iph);
 
 	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif
 }
 
 /*
-- 
2.54.0


