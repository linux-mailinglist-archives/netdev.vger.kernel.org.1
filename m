Return-Path: <netdev+bounces-299476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9BEvJQoHMGofMAUAu9opvQ
	(envelope-from <netdev+bounces-299476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:07:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 121D9686EE6
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:07:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=EKySjeyz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299476-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299476-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C48C30C55E9
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E393F5BF7;
	Mon, 15 Jun 2026 14:05:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542833F7A83
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 14:05:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532339; cv=none; b=PKJiwfWzvk7/RA7YPwwgQPrsuCh3awln9DkyYDQ/EQOlICwnXMR7g6ExYHpJ5ghPtMMDk1XSITsQgQnAfxvTYI8zvRuttVQ24/DxUpNjuuo629KoUwJpuhT9erMO5YmbLufUv2Vt3qc1Mw5350BO/i5H2+Awh6ypnejfqO55mjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532339; c=relaxed/simple;
	bh=WEKfdR3nIfiUBVE84Vc5XVgzZju8SkfK1ojCBLqiM+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rFd0b/ehccveWzvBYJ4AwKvqhyOc9ke4MwKybbALJNHUT72bdBv1TYSA/m19dGf+umxXgmxB9qB+Nqf7kS6M6JI4HExSGkV7p4WGVOYXoGGu7JlOQhxjjGs3YVZi5peBT1lZs0rXhRHQnATblvBA5SqBCGnPPajBFaMLuNekHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=EKySjeyz; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490cdae130cso16391965e9.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781532335; x=1782137135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cvAw1dsEWiSRXIXzLCtyB3OxbKLq8//WuTTzMwNXLh4=;
        b=EKySjeyzwVR2/b6wcOTqk0G9chk5aVfbuDom3iyG2nsa867olWyjzEYgRdgVATTf+v
         Vk4YQOGGQsJtFRAigF2e6sgD6rIOW9Xoax4GGSCfvwEEXeGNrcLFQwako20qHddp0CHS
         iNP/QZNWjm4roTQjLgtVONL/M1Huj/0jL8ohQx161EAyIdolIkPRkGiDhu+fx/fj/V/S
         OlHIiXc3D7zV/YyiP64jIttKzu+A0WDmHCSiFw5ak7qVAQnDq2D+o3UpT8kYUu9FaLhC
         UTiBnpFzk4l27gW5WyGY3fbL1LdZ//tzXCmqwmCroyLaknk//RF1TPBrTKOC+tU/UeYr
         g+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781532335; x=1782137135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvAw1dsEWiSRXIXzLCtyB3OxbKLq8//WuTTzMwNXLh4=;
        b=T41jv/V5EIfKAkEdRo3MheYLZqj/GfaDTUwLlmIcXErm0drNTpOGdIdKg7uFDAwKdC
         wlyfDkUPA3lt+XZoD0CSyA/TVkJVD3/H+jffcZiJOG+51sgmqLvYE342H3GP5PNOAMkT
         IkuCtIkRjIrc5zILkVljmU3Ap6DCqRNA4IEBtae9uLwl1LZOfHW3oCXSywF4h9st1tho
         fI/XAqIsSVDnZJI8TJ+AmFL8IUc9BLPurYo7Yn5Rpy0G4XH0ufIT8lOGrj2xLFNHy1Ax
         dNgceUcfR1SMNpbkM7b/SY7X38s+q3ndpoQ7IypqsMJ7U/E2eag0l5VtKnVOWj1QHIbo
         PBKw==
X-Forwarded-Encrypted: i=1; AFNElJ+N8MGgwmHgB6aNPX9DWn3GV28OysNSyDlom3QCrCNRpp5FDPc2pEcixpDQ2y1CzNKo3f4TFlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzSQFeyV6FLMrDNAWbVqms5qlcIwhq76M3r7TUcfJOSwTscPCD
	Wy+lENqA6HU10gnflw2qs6+TC1bun1NkM0eAq2z7gKNc73LSTjUKpvgPZmTF8UD1MBrh
X-Gm-Gg: Acq92OEOHFpihJYnGMJEKYnZ5yNGVmkSvI1wUe+KYFsTVMEb8eZalqRtu4WLceqx8I4
	c+cMkIDSeDq/4mgL6qmMJK+s/Z2kjN1n1m9c0iX/juZTBWLivF8bnojDu8lcDvhTfryofhYiGBo
	mHNd5Yo4nYzWtYhiga+uvbIKyB6F3gaL6WNnX9YgS6AuDU5HsacIAKgA7Z42whi84sxQkRtnOaA
	P57RGEf4Ajk3JvVDdUitlLg7yuXmVE7l5oGF9vSXZTHPSQ4ttDBrzkFrzDeTfDX5y5RvwqCLlpJ
	UAALo2LE62nL9F2Jv32L3kb/BhGhM6B+YxtRbJVfPoTYaY6b6VWu2UERcy72s0feLyJejM1TXam
	m+g06jUbFHdRJgnrY31xHbkN1OWrsHB9s3SKRybK2Ff9b50su7CpyJcMSCV2MxtRF63VS5LKsKP
	ZVQmc7QPoqwMBqlYruhZxm5gxd9csOuM8oh7lBM/ZN9EsJkUevZt/Wo79Eztu0FLK+0g0zthxlM
	arfqFcuoACF5YfrkEcX9HD7mTVwsG4JOS572QNNHm9l3Q==
X-Received: by 2002:a05:600c:47d3:b0:490:d354:bcf4 with SMTP id 5b1f17b1804b1-492200e2409mr89495105e9.27.1781532334628;
        Mon, 15 Jun 2026 07:05:34 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c4240sm32087268f8f.27.2026.06.15.07.05.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jun 2026 07:05:34 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: piotr.raczynski@intel.com,
	michal.swiatkowski@linux.intel.com,
	wojciech.drewek@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net] ice: eswitch: fix use-after-free of metadata_dst in repr release
Date: Mon, 15 Jun 2026 16:05:32 +0200
Message-ID: <20260615140532.52676-1-doruk@0sec.ai>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-299476-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:piotr.raczynski@intel.com,m:michal.swiatkowski@linux.intel.com,m:wojciech.drewek@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:doruk@0sec.ai,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	DMARC_NA(0.00)[0sec.ai];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 121D9686EE6

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

Fixes: fff292b47ac1 ("ice: add VF representors one by one")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
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


