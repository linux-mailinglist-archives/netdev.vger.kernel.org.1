Return-Path: <netdev+bounces-282540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABsiBCCS8mlhsgEAu9opvQ
	(envelope-from <netdev+bounces-282540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:20:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6F149B52A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 825E6301153C
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE92639B951;
	Wed, 29 Apr 2026 23:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hnc4IVGS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4752E39B94C
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504755; cv=none; b=j3cdtOA10XuIEszOU0vJGzq7GqMPodYlwOlkjn6Mq6c/5nlMZWBZs9vsF56w5jxO+X4cDzClc0szHOsJhV3NLjCGlp9jCSXxBKglPdZRSJcUzoR7fDu+oEa9sul9fFiHrv9P7kA54Fkmc46xfo+tZilFAMEF4g1Wl9pZMacGjrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504755; c=relaxed/simple;
	bh=vnf9u5bZr2Jh4vHEhpzns0hJLI6h1CacL4VAyx/kSbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J/mXdQQGk+EP4Ll7ZWGke1TVdZr3VJLUyd/5BjZLMgywbWhMx9yJN7xY6rnXvXfe1k+6jY2OznJD5nXatpXYB514EIbNcMDqzeBeO471arq+8yD+nkOFWMLnPqA8Sdkmc/RuIrhjLyZkMDBf7sAxaJj/cIyOrF5tTrxUG6kMipg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hnc4IVGS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43eb012ac4fso179999f8f.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 16:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777504753; x=1778109553; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xg4uL55KM0rpFJAt2ymSaCICrZWf1oCpfyBNCgcrMb4=;
        b=Hnc4IVGS5eyTt3dBGI3jm2Yi6bpyGq2/IUGR094lMMJWJAtbIgU/AOcylkkxkIsEvz
         Dfss/BJgqLchl9JUobzRcrZ/hzevpBuKHvo5Qtt5BL6Ha9wZgK6iZh7huH5HQ4QizekW
         6wfl2WkpR6hreV1/2kHsZxbrwaQpi3TphNw/dgR716Vz06x0TF0VfHIlMWs/DGvGw61G
         UVLQu2Ahx/yphAhkflW72+qQdlyef0tjbrqq7B1RqzWv7rd67inn/DiHm6cEy/oKnvQ4
         iq1GElBXS9UIav1DK2Cj5W0W71i6HVJEfPDJDJbt1OgXhDcI+GaXZdwJf7DKa1WHB27R
         TtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777504753; x=1778109553;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xg4uL55KM0rpFJAt2ymSaCICrZWf1oCpfyBNCgcrMb4=;
        b=iejeEi7t1hc5CKvTNEKl8ilwtluPQPtVkgFZx/Y8Kgs3iUpSPZ0A8pCK+1t+EoL8gn
         OU/cH/26z3Z2BtIKWa0bbxEmOWdaFGhSiG5wPcWVMQ63qExkFB4NeVoNw/sDbiV5W4bj
         zGZ769w2Os5nrO7VZmnvmpiWk6h7Z8lJtS2fB6BHrdGGHdIgQMeCIm3CyU3u1Y0KQvy1
         iHwr0bigaqtRb2Qb3TAsp92r1DSXzv0J+FfUGmjqRtkk2OpKaOWo0qmd1qHjC1R+Hin5
         D/Rcxq2a6y6AMOgViv5Bq/+QaEX6a1+Mu3EW8dd6RajW2eaaLnPcvx3x8he8CpvLSHOG
         kLFg==
X-Forwarded-Encrypted: i=1; AFNElJ8stJZB6JBrkUa8H+Ome4Hz/d7c36YgjqXXcrfY/UNs+vCsZtjskYwDOy+FQTR7CO9R3ygySIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3wwth4W5MtKnzPFUgmY3OuX7WSMhnqtmPRxJJoGDQMo0zb9K7
	bUm86z+rTJloR/F9sS5YZn3cIg1xBaNvz/iRkWBX0HpkcAr2Yvi9a5c=
X-Gm-Gg: AeBDiesKF/crfC/nC4A+wDAZR1/ugk3k3EeIlN++FHR+IfABrHr8Qas1jqkBeQYvBev
	Rvx+nZ4ac86FwnhlGSJAFreZ8JnXGDJyTrnWap7Tm+Qo1sOBApp9+uNO+6E6jOSVK/iSi2P2I7Z
	rQ3S97RTIjF+nMtz3J5weH+QfpuepEmzbVK0PAUGpCPkYuqAZELMADbt4H9hRYlWGHXQBCByMGQ
	nh9JC3mWi8HexqHhtfNjb4/8CvJDQjIKqfV62BtHCUjCBTAhkzYLU1rLJJBbzDKi+QgToM/1uWv
	CP1o7lDzRESqaMdT8xz38Rmuj2W4aAP7jzYniohHsgb9cRU9vvUfW8GCZzicl7xijxsq+hA+Hj/
	EKBBK3bnYTxI9GmQ763uSptegm8wbAAsymqeey6ocWGkt6GdJvw8aWa83weu+eKJKqI9KhZboOC
	HZwv5NbfTFWAjMLQ==
X-Received: by 2002:a05:6000:611:b0:43e:a81d:c475 with SMTP id ffacd0b85a97d-4493cf2d583mr611329f8f.6.1777504752636;
        Wed, 29 Apr 2026 16:19:12 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48517sm7502180f8f.5.2026.04.29.16.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 16:19:12 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] netfilter: ip6_tables: guard
 ip6t_unregister_table_pre_exit against NULL ops
Date: Wed, 29 Apr 2026 23:19:11 -0000
Message-ID: <177750475157.3021974.6858117535916205046@talencesecurity.com>
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
X-Rspamd-Queue-Id: 1C6F149B52A
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
	TAGGED_FROM(0.00)[bounces-282540-lists,netdev=lfdr.de];
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

Same race as the ipv4 counterpart: ip6t_register_table() adds the
table to the per-netns list before assigning new_table->ops.
cleanup_net can find the table with a NULL ops pointer and crash in
nf_unregister_net_hooks().

Guard against this by checking table->ops before the call.

Fixes: ee177a54413a ("netfilter: ip6_tables: Use xt_register_table()")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/ipv6/netfilter/ip6_tables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index XXXXXXX..XXXXXXX 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1804,7 +1804,7 @@ void ip6t_unregister_table_pre_exit(struct net *net, co=
nst char *name)
 {
 	struct xt_table *table =3D xt_find_table(net, NFPROTO_IPV6, name);

-	if (table)
+	if (table && table->ops)
 		nf_unregister_net_hooks(net, table->ops, hweight32(table->valid_hooks));
 }


