Return-Path: <netdev+bounces-296189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZoNtNaUWJWq3DQIAu9opvQ
	(envelope-from <netdev+bounces-296189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 08:58:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4301664EFB1
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 08:58:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EVfWTAeF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KP1RhKdK;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EVfWTAeF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KP1RhKdK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296189-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296189-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D7A3013A81
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 06:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8946A2EA47C;
	Sun,  7 Jun 2026 06:57:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525F22E2DDD
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 06:57:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780815456; cv=none; b=ISDstMtiJ4zNPgKy0E7adMqCjmuK3ilztbDpip50k/IxieGslRPHmcrQtv2TtkQaowHVtrH1Q7KR5uEoQAJ0KeZcICqErUdFhFrcazshi2cq4QR6RpJ6LqWzcay6v6hfYB2t+cEWtFgAZXbEWn6GDFtcAjaYDZLI5Yw+Mil6UxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780815456; c=relaxed/simple;
	bh=k4s5ik3Ik/k9mGVrRyeyGmxznXJENirRCrol/4UY0ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBup/7iZERt3Hl+B0PEs23FQbcTqDH7g3cpOfDxOskes0BSgkSR2Q64/o3zfodTRJWh/rRNw7Jzs2SensxscSV/aXUwvIyPQCmDImVgbVNn3kPBwNAIhI5vAwsRiaP3tF2coFIqWgT47iCOIysh8DgVoCosUI1KSBdsC0LdU8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EVfWTAeF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KP1RhKdK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EVfWTAeF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KP1RhKdK; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A500D68927;
	Sun,  7 Jun 2026 06:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780815448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BchahcDOuuwAPY3fjv6S/QxPtUMFkdq+WOrryYwXpOg=;
	b=EVfWTAeF02w53DEn5KrPkUBbNJduPuYQMcu+qFnUX69AoPCo7LMae32yt9lb/jA1ZiH014
	LSLMbarBVULpOh+cu9D9XlT0t6ansFeZP97s5xMY88DYvZEMxihX+3AliOElpoK+WgThs0
	hbKv7dNuhemzUN7NZKz5WeLLacbVxbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780815448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BchahcDOuuwAPY3fjv6S/QxPtUMFkdq+WOrryYwXpOg=;
	b=KP1RhKdKfwSjwR70XGRM7fX68UBppJalYrHYiR7GK35NQMR0xRXxwDMNxIfzmHdeF1SrMi
	oscAhLOfitpqZzCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780815448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BchahcDOuuwAPY3fjv6S/QxPtUMFkdq+WOrryYwXpOg=;
	b=EVfWTAeF02w53DEn5KrPkUBbNJduPuYQMcu+qFnUX69AoPCo7LMae32yt9lb/jA1ZiH014
	LSLMbarBVULpOh+cu9D9XlT0t6ansFeZP97s5xMY88DYvZEMxihX+3AliOElpoK+WgThs0
	hbKv7dNuhemzUN7NZKz5WeLLacbVxbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780815448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BchahcDOuuwAPY3fjv6S/QxPtUMFkdq+WOrryYwXpOg=;
	b=KP1RhKdKfwSjwR70XGRM7fX68UBppJalYrHYiR7GK35NQMR0xRXxwDMNxIfzmHdeF1SrMi
	oscAhLOfitpqZzCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36FBD779A7;
	Sun,  7 Jun 2026 06:57:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mKGYClgWJWoLIgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 07 Jun 2026 06:57:28 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 2/2 iproute2-next] iplink: set NLA_F_NESTED for IPv4 devconf attributes
Date: Sun,  7 Jun 2026 08:57:15 +0200
Message-ID: <20260607065715.4573-2-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260607065715.4573-1-fmancera@suse.de>
References: <20260607065715.4573-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296189-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:fmancera@suse.de,s:lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4301664EFB1

In order to use set multiple IPv4 devconf parameters at once,
NLA_F_NESTED flag is required.

ip link set dev enp8s0 inet forwarding on proxy_arp off

Fixes: fdb064bf64e5 ("iplink: add support for setting IPv4 devconf parameters")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 ip/iplink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ip/iplink.c b/ip/iplink.c
index 9799530f..3f0b46c9 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -579,7 +579,8 @@ static int iplink_parse_inet(int *argcp, char ***argvp, struct iplink_req *req)
 
 	afs = addattr_nest(&req->n, sizeof(*req), IFLA_AF_SPEC);
 	afinet = addattr_nest(&req->n, sizeof(*req), AF_INET);
-	inet_devconf = addattr_nest(&req->n, sizeof(*req), IFLA_INET_CONF);
+	inet_devconf = addattr_nest(&req->n, sizeof(*req),
+				    IFLA_INET_CONF | NLA_F_NESTED);
 
 	while (NEXT_ARG_OK()) {
 		NEXT_ARG();
-- 
2.54.0


