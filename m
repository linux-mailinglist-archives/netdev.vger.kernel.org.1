Return-Path: <netdev+bounces-300114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tiAeDs5yMmqM0AUAu9opvQ
	(envelope-from <netdev+bounces-300114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:11:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B113698513
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:11:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=pg1mEsUN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300114-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300114-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C587300F1A1
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26E83D668F;
	Wed, 17 Jun 2026 10:06:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4403D413C
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 10:06:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690762; cv=none; b=e5ilOwmV9cWm2mM8F3tifLxATFy08d6Vw970jx5V2WKaLniSti1gJj28TEZlqwejRYNSqAfYct4HRI0fyplttcSMPA2/8no6kT36472Zk6NLyquU4ssQ3rmgFXudVhroluX27+bGrQ0U0/umCNifpvWeQISprlKEjClGmIyJlWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690762; c=relaxed/simple;
	bh=hmliK8samJNpT3PJSWzQYDk1lSB+31K5rpAqv2pdv9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbWJjI8b1mtIO6v8FLq0bwqTWo2gZjrUZA3aERz7/wlQRnIPjXSBzivGKI63p3BJzZaOmLlGZFABcoFNvESbtp2DEkE/ed3enUOFoIuzNh5t+ERhiFkw0KGXcepnDXH8tbSTA5nJOi+yV9yiOllvAAcBrQtq0PFRbl4AIfxVJs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=pg1mEsUN; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso3804607f8f.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 03:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781690759; x=1782295559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aFsSmP6aMO4TG59Hc8Zv34xLQSsBRpaPGd67pr1FIwc=;
        b=pg1mEsUNBDfRY+gSf/5TCzF8zqn9ST1QFtFYhIYqiGXayoKnoQHaHM+wYvMdm8VPiy
         kTRyJRrNf0huBCJXUF5eWqVoxhpFqjofmzUO1OMWAp4oN7s1IiQzCITUnhF0fGePqv3S
         H/MGnjyvxUrSbKNnMhp6/2bBkPlwzpTTreRhLxaSRZAJD5SGDgJQZOu/FWq96luCsx3W
         fQy7Jgq9PejRZFvHk0tDMRGWFbxc92F7tAAr7VsHkE0nzixmGYtzOPNlV4iPk9CaV5Fr
         pelBJfRSRWbRVoHEtNik2lLrHkdPTprqkZbfEtwcVd9+4M/Dkvp2nxmL+TcKK/qlNMFU
         Ns+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781690759; x=1782295559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFsSmP6aMO4TG59Hc8Zv34xLQSsBRpaPGd67pr1FIwc=;
        b=VcgggsLHN6NxFZHV1nqo4UcCkHXOGzzRMHlk5bM9fjPTWkKTkNeyYJD/3NGHHa8rwD
         PdwuZEHTOwIEq3BKkju1uj0UNZBe2bsEq63RExzzXDvvOQCbnkIa8x303tV0CexB6P7U
         iyhVdCceeUtTQRJQJy5kmdbXeSxlRksLfJNOuMaKu/XASPbd9FjsjcG0TQ/JNbuQbpL4
         7mTjF2bTDQ++jngStJUm2/6XdU9jF9ie5d4iHtpUWbv+vk9fAuDQhyacPGQenD4WnJnw
         kHstPkS+p7ORqKNxnMf0XFpPxOGWTB6oprbf0vEQBAnKmRGPGRqFEy5Nevg/rc9dOZ1x
         S6EQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sciXGjXDBUcdQEYa4GrHmKBzaD6ZS51orDKHeDEzOrrHzg7ZogMWPIKnbJLgJpQT9wCWh5us=@vger.kernel.org
X-Gm-Message-State: AOJu0YykguUepb0MMBN8gmA9KMo81Rx9CeTalkMfGI04bcVCTYNgYV9G
	O/dgdC1bR5m4izJrg+dV3/vdzArI+H8T6RYJSPRnHzCYTUYrVuBdfq5JEGkPTddf92na
X-Gm-Gg: AfdE7cm1KIwcxPCRvPMjBg1ZoY2HvmNGJnyZfK8nfe6MA3quZ8oRk4ylJ9sxl8fifmW
	uq3ah3/79jxj9CraABySAqv7AOO5KwFzul0lBkKzeP7ObEu5KU2U7ePujZFqVBc55aVhUlXrxw8
	RZ/ytxiT9YMJ1WEBGzeVMu11QwtxmEOTLMFLICVRrlYvnBHfUB78uL0iJzs3BrCsZ84RBNDx0Y1
	I2ojouH4kx7GnJXAeeIkQ/0vxH8jy7AOKNY9xBFgl5rVTgdWi+k/PB3Rs/I5YGwwkEBPCTjIPyR
	uVj9B1v1R7CcSNMfvvgnuilitBKMe5kdnewhqgMRfMEZ1VuREiiHRmmJWziqNDRZUTrEAa3CbT6
	cxV/m0ShegGRDQCd6g44qjwU6+LKPK69wcvaUv73ow8dk1cof74U1iQ8QGphGliJfPDHziyJ0Fx
	8mJP5W538idlj5V2nvM9/95twQ+rkJaOAy5+noZQoxWhloseYsHcUfzffe/FHJ+FdKqiJPVuAcY
	JNEWIx3HSkvSvYSJXcOBFn7DPfCqsJN8tg=
X-Received: by 2002:a05:6000:2302:b0:461:a159:98c6 with SMTP id ffacd0b85a97d-46235e9ac51mr5885239f8f.6.1781690758585;
        Wed, 17 Jun 2026 03:05:58 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm55033847f8f.11.2026.06.17.03.05.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Jun 2026 03:05:58 -0700 (PDT)
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
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net v2] ice: eswitch: fix use-after-free of metadata_dst in repr release
Date: Wed, 17 Jun 2026 12:05:56 +0200
Message-ID: <20260617100556.83620-1-doruk@0sec.ai>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-300114-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:michal.swiatkowski@linux.intel.com,m:wojciech.drewek@intel.com,m:horms@kernel.org,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:doruk@0sec.ai,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	DMARC_NA(0.00)[0sec.ai];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,0sec.ai:dkim,0sec.ai:email,0sec.ai:mid,0sec.ai:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B113698513

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
  - Correct the Fixes: tag to the commit that introduced the switchdev
    teardown (Simon Horman); add his Reviewed-by. No functional change.
 v1: https://lore.kernel.org/netdev/20260615140532.52676-1-doruk@0sec.ai/

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


