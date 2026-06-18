Return-Path: <netdev+bounces-300465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uCVcMEkGNGqQLQYAu9opvQ
	(envelope-from <netdev+bounces-300465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 16:52:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D8E6A107E
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 16:52:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=OWe3wKCp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300465-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300465-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C635E30B85FA
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976B53B3C1B;
	Thu, 18 Jun 2026 14:50:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB133BCD29
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 14:50:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794209; cv=none; b=AhsMzxWmcHmlp0KikR/S30W3P6BxiM/NhLGD/C0eBId2XPjfvepY4QK/UndslXsswGPDAfZ0tqlBHTUIIrL8bR2DTgNlBSDpeBFFJuj6tizqRwnCdkquiyw3K5JaKNUaiRcjkH5LJs78UaxoFOCpkfs3A2qHsGue1SVFw23FHys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794209; c=relaxed/simple;
	bh=ebfiHxJXCBorfmGp3WjFdqGfKJbX3u6ZqUXNuY7295I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ulx3/oiJFgpNYLk3CAzf5KkGjtEjorTPmVP4yrF5NghJ12kUU4huJrl59dzBajif4AN1fyBTqdmltRbcJjjLu8XPCJ57xJ9OyUX2WX0731jm7GVzaZmJ+ChVA6Tm7R9HpuszmptYn3e5twjCseMzhdJ9hMkHaYFKmkGEh6sXsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=OWe3wKCp; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-464192ab2e1so537289f8f.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781794206; x=1782399006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGgWyECjMo0A+7T5xX6MZZ8UBQzM1ZYjMx5fmvyGYBI=;
        b=OWe3wKCpatSlqAJ0W4mfntjH8iNWNZGerCIVxVNBwcq3/U9JgJ2m3yFpLQ5LuLdjND
         xWrZjRN1+qrQhoUP61bExW1pJox9IjKseH/HgNbVyigGjyM1GQAPHK/QNPBbPjHijAcp
         0YRmG2ZTAC0NMUf/qqV3zuQFbf+mkMtSHMZoOHDFUi3u9hwDvKkGZ8Ri+sW9VI0+SX1U
         QKByRdO+B1GyOzIiGww8Y//Zc5KDFyk6uphFfLFeFjfhZG/Is1U0diZ8ETYG2mQSo0tY
         LCcIh7LVAeOFOYsVzQkZFRD2mNsKz2C3jz00bdodGoOC+Ni4nEyySfhQU66P35nr9Jvx
         FFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781794206; x=1782399006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGgWyECjMo0A+7T5xX6MZZ8UBQzM1ZYjMx5fmvyGYBI=;
        b=UeB1dV98w8oQgsMQinywAvQ7Tkxrzhcqi/w7RChWLRrhWhM1C8DHe9uFTfsZbe0KwI
         GbE6jx11XFJrOfQJYTSEnFpeMnwawQJhZl+nJ1z1PgM4xWZ4JMTKvqhYdr+JKLB2HQAF
         dAXXhuK380ekCRCw6Jw2EXDBO0XI7IfsDLJurE81/yO/VVQI/LULnbHJwaEjHaLoXmC1
         LkDrwGUD8d/htnyu1fv2eDLW3gIGW5tJRZn1aMqPUwWdUEdNECyB7qJBp6TFkePPs+2S
         tiol6opggSMaOPsW8kiSEHYyYfqwgYF+o4bAyK0F8F+pUpAt/8WY8PfG/qU7gH9gjnwQ
         ocdw==
X-Forwarded-Encrypted: i=1; AFNElJ82JaVZH6SkTMKPa7XnJUGgMzg2INjtbr7Ho3Gl8bgEa6UeQvf8lCTUFBJjHzXZSCNKIHrk4Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAD1zmPO42H99WJ07gH/jcMp2v8UyhPL7vg3D4FouVhdhMfkYz
	/YMf5bK+TjWargs3GCs8ZJrdVR8EUeuX4mU05HrQfmEB3bpk8+tl2u9i6XY5OzRxdQZC
X-Gm-Gg: AfdE7ck/O2OeKSVwLLXDmaNyacC8LBaBgQ1iW9jN3k8P6PEpWqznaGkrz7iUyqH8oX7
	I2YTP3LVjFW0UvUu7P6QcAcWG05xNS2aFgYN5lp1i/JTMXE/g+r8kM6zWRgQ6d+IWt2mQcfGAxD
	cvSpHcEv0FoEc/eTGzyL7Z+MLVMOOtdQ6cbLcIz2sgYruXA47deAmygfC9ewUPk8V5DpwWeNkk6
	4EyU0PAZU8Mrwln7lMWgEGKjFBvcegL7xM9aCLzQBwiuzVzoVdldlMzkB5dLrnr+3NkDNYCsxqH
	UnbgilB4XRmm1IrsHByu8su1wKZLyrAnpLdh6FLhRzAqsaymd+xBb9AXygevlcwMm3rTBdVU0UO
	G84c0qOu3MMVbUJ0Y6wFK96N0jlfm7B2rMu5igzQPM543MUjIUc/3R8bx+is3nGLxRAQDXPN8Ka
	hUnMu4OFvK2kb4WndxVG+O5pHo3xrLJgyAGvmTts9nxs6UnZeyBfjWzRohdzHMoGTqb/BoOx6LS
	ScbZAZBJDJGNCQTrPaQ47vQ8lmgJ7c2yYk=
X-Received: by 2002:a5d:5f87:0:b0:45d:3cb0:5ab1 with SMTP id ffacd0b85a97d-463ad9ade76mr6300952f8f.38.1781794205917;
        Thu, 18 Jun 2026 07:50:05 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2e592csm66701717f8f.36.2026.06.18.07.50.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Jun 2026 07:50:05 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: michal.swiatkowski@linux.intel.com,
	wojciech.drewek@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net v2] ice: eswitch: fix use-after-free of metadata_dst in repr release
Date: Thu, 18 Jun 2026 16:50:03 +0200
Message-ID: <20260618145003.47471-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:michal.swiatkowski@linux.intel.com,m:wojciech.drewek@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300465-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[0sec.ai];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[0sec.ai:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,0sec.ai:dkim,0sec.ai:email,0sec.ai:mid,0sec.ai:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23D8E6A107E

ice_eswitch_release_repr() frees the port representor metadata_dst via
metadata_dst_free(), which directly kfree()s the object and ignores the
dst_entry refcount. The eswitch slow-path TX routine
ice_eswitch_port_start_xmit() takes a reference on this dst with
dst_hold() and attaches it to the skb via skb_dst_set(). If such an skb
is still in flight (e.g. queued in a qdisc) when the representor is torn
down, the metadata_dst is freed while the skb still points at it. When
the skb is later freed, dst_release() operates on already-freed memory.

Replace metadata_dst_free() with dst_release() so the metadata_dst is
freed only after the last reference is dropped. The dst subsystem frees
metadata_dst objects from dst_destroy() once the refcount reaches zero
(DST_METADATA is set by metadata_dst_alloc()).

Same class of bug and fix as commit c32b26aaa2f9 ("netfilter:
nft_tunnel: fix use-after-free on object destroy").

Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2:
 - Correct the Fixes: tag to 1a1c40df2e80 ("ice: set and release
   switchdev environment"); the previously cited fff292b47ac1 only moved
   the affected code rather than introducing the unbalanced free, and the
   bug dates back to when switchdev support was added (Simon Horman).
 - Add Simon Horman's Reviewed-by. No functional change.

 drivers/net/ethernet/intel/ice/ice_eswitch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 2e4f0969035f..41b30a7ca4a9 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -95,7 +95,7 @@ ice_eswitch_release_repr(struct ice_pf *pf, struct ice_repr *repr)
 		return;

 	ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
-	metadata_dst_free(repr->dst);
+	dst_release(&repr->dst->dst);
 	repr->dst = NULL;
 	ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
 				       ICE_FWD_TO_VSI);
--
2.43.0

