Return-Path: <netdev+bounces-282539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VhyXJwCS8mmDsgEAu9opvQ
	(envelope-from <netdev+bounces-282539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:19:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FF949B4F8
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05AF0300A668
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A770639A07B;
	Wed, 29 Apr 2026 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlQrKjdb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ECD3932DE
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504748; cv=none; b=FO73Uc9njUHfcLnV7uJhBkNs7+BDyIBLvSPVw7KC0fCmBiJAf+esXsS4GwUbCQvEcHb4tnFYNgFIYzBWG72PntyUrst0ztR7sQMqnQgE3a/vTjeYg4O882zs6nNyIXbjq/Xzits/lsl4VLoRUHlwxF4Y9Sx86cTEdzLwR4j7AHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504748; c=relaxed/simple;
	bh=igdzl3lWughU8xzCp/zAPhHTuBkDvNwNGNOG2lHylPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aYy35Y4FCXzqiwciYIcKsGCVfdKulrKXA0AzwmZhnz60ecOWFQzzktUDYTw+x4BAtqvYS8J1RNg8aVzgcHxontYFV1q6H8mFOEeifGQkeMpVc1MlwwIbGyqgrHKl4flR+gZ/y9MFTttPIngLc6avdcVBm8iJ4Ayb6q20Atg1sBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlQrKjdb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891b0786beso1730345e9.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 16:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777504745; x=1778109545; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hd/6unjwJeqPaRYpTI3Uva7eVyvTUW4co6d4pCO9ZrM=;
        b=MlQrKjdbqLfhRHKSUETNy+dcsdvcLMGFE0mwUK3+0EMp/UBUPtEL3nudeiuHYW1Dyr
         YZN0kOfRJ4VzM3LfXvty4/7DVSh8zHeyCL+rJbfOg5sIftW0k0/PWEHyWPs+3nl3vMaK
         NazR9A/jzHU4FpdZqKK1CDtVljCSIwAwYvj7LP7e1et2f+/No7cgJ3yub+930TYBjDMh
         oUub5Jk1lGvP2LUCGmITdNChvQ4UGu0Xnen/QE5sTFBfwbH844nsWUpJzkQ6FA7FdHvK
         fRvJTjcUpV8IMecTEKxEY4AbQmOBjMR6lTCo3sPBvfLbCXBhe8E+1MitrUss1kSOjbQj
         MAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777504745; x=1778109545;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hd/6unjwJeqPaRYpTI3Uva7eVyvTUW4co6d4pCO9ZrM=;
        b=pIBdlacAm/XsCxCj7BYGM25soZ5qLqVGoG8Q8NUsXRkbJOzaYP6t/sdhlHXcxVMWHJ
         PWc5+zVP2DSzcj+IPX13+gPBpg0IhrUgJm0eYL+6GgmfyyCDTF6buZA10pNGryTcSkp1
         q0QYHIfUAwwpvu5PABixwWtmJO1UuQYMXPEQ3ys+wso3KyvhAd4kux+knvURzKH/KFBn
         dW+rJ0hYC53pferuNthv+mgf8YygfDmWbLTW+BUd1ppehow/4B3zMIhQ7PK5yQo6TNBH
         29jXpI3cvDddv3IzIKr3cgYu+58PYDmoEJ0y9DlS/8RYXQM04xVtcrveIbEWbsNh1B2r
         2pgg==
X-Forwarded-Encrypted: i=1; AFNElJ/5SzWe3PAz8m9PKnwPgXad3RhqnZigSodKL2xKsq290gPiTvWIsjEAWHf49VbZwcLTU1HfLWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoFZSZCwQ2jv4Q76ofPiTzqG3pUsqh9KfqnCWXUGVG059zHzEG
	vPFKlHAnLOaGNQk3nFZ4Ze5tJ2O6CmOAUe8XZwoieF20X061DmTrPP0=
X-Gm-Gg: AeBDieuQ7Ii360J4RFP/1l7oeYyHkrs+Nx+cD+r2mOc1ml3xNGe7yeERwKjAQ20dKdV
	e9gV45rhe6CejHoFP6aFpmJXd3Xg6NJ1o/Z8NyxumgVJ3qSOqHoBH31rqZvphc3aC0x0WeY7yjJ
	1v/rAilVWxN5aMXMERmJudFetbiTIZ+1CmJB0jzwGlW7f4f5AGxsXy74RzPMBmcGa+Re9fGJQNR
	QWGTp7bf5l4kGucr5W88Pwy66WA1dvQBuC0ozEjdT4KdL0YaeIcRxouoPKDw9KkPkhzFcV2JEhO
	CAvAtJU0fFZzQknNQBvzRZqLyoxeq0XahDbrFGtqIS4cvTC0Q4HYntbN5i0MGBXgDk66Y9chZrF
	MlsLDvJUIcAgIBtp5KbTa8yqKyd+moYEQYs4z8v6t+aKcIIalKfW3RCGjSG/wdZzE2jjmycZ9uy
	MmTxndVqNuEtD2SrX3KB055x4U
X-Received: by 2002:a05:600c:c4b7:b0:489:1fa4:50c6 with SMTP id 5b1f17b1804b1-48a8447b30bmr8849785e9.20.1777504745521;
        Wed, 29 Apr 2026 16:19:05 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82307f7csm21201605e9.12.2026.04.29.16.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 16:19:03 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] netfilter: ip_tables: guard
 ipt_unregister_table_pre_exit against NULL ops
Date: Wed, 29 Apr 2026 23:19:03 -0000
Message-ID: <177750474339.3016150.13196470704394042910@talencesecurity.com>
In-Reply-To: <177750472539.3004201.15967003942391945312@talencesecurity.com>
References: <20260429175613.1459342-1-tristmd@gmail.com>
 <177750472539.3004201.15967003942391945312@talencesecurity.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A2FF949B4F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282539-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:mid,talencesecurity.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

ipt_register_table() adds the table to the per-netns list via
xt_register_table() before assigning the per-net ops copy to
new_table->ops.  If cleanup_net runs during this window,
ipt_unregister_table_pre_exit() finds the table via xt_find_table()
and passes the NULL ops pointer to nf_unregister_net_hooks(), causing
a general protection fault.

Guard against this by checking table->ops before calling
nf_unregister_net_hooks().  If ops is NULL the table is still being
set up; the register path will either complete and register the hooks
normally, or fail and clean up via __ipt_unregister_table().

Fixes: ae689334225f ("netfilter: xtables: Bring back xt_register_table()")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/ipv4/netfilter/ip_tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index XXXXXXX..XXXXXXX 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1795,7 +1795,7 @@ void ipt_unregister_table_pre_exit(struct net *net, con=
st char *name)
 {
 	struct xt_table *table =3D xt_find_table(net, NFPROTO_IPV4, name);

-	if (table)
+	if (table && table->ops)
 		nf_unregister_net_hooks(net, table->ops, hweight32(table->valid_hooks));
 }


