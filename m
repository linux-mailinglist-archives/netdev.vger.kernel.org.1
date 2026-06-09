Return-Path: <netdev+bounces-297271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SoNbILVzKGrAEwMAu9opvQ
	(envelope-from <netdev+bounces-297271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:12:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E23664099
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:12:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YMdZ6LAx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297271-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297271-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51D22301B269
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 20:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967CE38889D;
	Tue,  9 Jun 2026 20:12:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54429CA6F;
	Tue,  9 Jun 2026 20:12:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781035949; cv=none; b=TRYko88J4ZyUgwZf+AmaEkBI9g/JTIMuwHj4aV5KH4qO1WndNOK3wZ7H9PM6zwj2CiUP8zot0l2c8LKxfbAUARTv17p4TaR2oAuZI1rm8j5IVscCWrMl0IjHxZjbDPy699HLX703gpDgw+sJQQ0ZhY7ZSk35oUMVHCXAG1Su8Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781035949; c=relaxed/simple;
	bh=/WneEHdOxYWtAFIpBmT/1e6o7BzaHIgbY+2QBtSvz1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3CYSEB763c2bf2i/Pc5/8Mtqv2G3KmSWs52MVcWEUCE/rtADRGiOdQDz2CpVpxewM76kxYyojjGRH8J83JsQFUJmXHz5pVLisLaytwwHwFjltk9WgkX/wgPYrpgMLtVfZ9NU4VxxYx9OvcH+mUgjOgDQIJpRaWnVrU30RU9dEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMdZ6LAx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4D21F00899;
	Tue,  9 Jun 2026 20:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781035948;
	bh=UWnaCnlR4Qal6dMK8IF3d62SaaZYGWk7fQ5gtbK7Npc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YMdZ6LAxb/PocllqC89BR4eAUWDpjL+vQ7ZbKZQo7JNJ0YivBJazAI4Ld/Z2TINM0
	 EfwK0OjmC0c7JJ82S8+jM59tlO3DYTlsSSlPBrnn3jw/RAbUCx6HCZ9NVxzWXmC8xE
	 hmv7uYGpTGZIor0J8XM6120A8C5SL2rVAl2NxkB6/bvTSPo23ZgEnPkYpQIPNym/IB
	 qiub2JElQ9rjE+DyCGKzaZ0GPQBgik5K8/shGlghSn9OEy6lghPtftKoyCE1UjKE10
	 t30M99yll/DuB5+jOE7kvy0K7zM8Qevs8vJ2/Y2/b6BHjEOrXfiEdYpAAzaSNZGHQ2
	 zcrBCSIaD8uyQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	skhan@linuxfoundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Subject: [PATCH net-next 1/3] docs: net: fix minor issues with XDP metadata docs
Date: Tue,  9 Jun 2026 13:12:22 -0700
Message-ID: <20260609201224.1191391-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609201224.1191391-1-kuba@kernel.org>
References: <20260609201224.1191391-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297271-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:corbet@lwn.net,m:linux-doc@vger.kernel.org,m:bpf@vger.kernel.org,m:kuba@kernel.org,m:skhan@linuxfoundation.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,linuxfoundation.org,iogearbox.net,gmail.com,fomichev.me];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fomichev.me:email,linuxfoundation.org:email,lwn.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58E23664099

Minor updates to the XDP metadata documentation:
- s/union/struct/ for xsk_tx_metadata
- document nested request and completion metadata fields
- point capability queries at the xsk-features attribute
- fix grammar in the XDP RX metadata guide
- typos

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: corbet@lwn.net
CC: skhan@linuxfoundation.org
CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: hawk@kernel.org
CC: john.fastabend@gmail.com
CC: sdf@fomichev.me
CC: linux-doc@vger.kernel.org
CC: bpf@vger.kernel.org
---
 Documentation/networking/xdp-rx-metadata.rst |  2 +-
 Documentation/networking/xsk-tx-metadata.rst | 30 +++++++++++---------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index ce96f4c99505..efdf5eeb49e7 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -36,7 +36,7 @@ metadata available in which case the driver returns ``-ENODATA``.
 
 Not all kfuncs have to be implemented by the device driver; when not
 implemented, the default ones that return ``-EOPNOTSUPP`` will be used
-to indicate the device driver have not implemented this kfunc.
+to indicate the device driver has not implemented this kfunc.
 
 
 Within an XDP frame, the metadata layout (accessed via ``xdp_buff``) is
diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
index df53a10ccac3..f240930ca1df 100644
--- a/Documentation/networking/xsk-tx-metadata.rst
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -14,9 +14,9 @@ General Design
 The headroom for the metadata is reserved via ``tx_metadata_len`` and
 ``XDP_UMEM_TX_METADATA_LEN`` flag in ``struct xdp_umem_reg``. The metadata
 length is therefore the same for every socket that shares the same umem.
-The metadata layout is a fixed UAPI, refer to ``union xsk_tx_metadata`` in
+The metadata layout is a fixed UAPI, refer to ``struct xsk_tx_metadata`` in
 ``include/uapi/linux/if_xdp.h``. Thus, generally, the ``tx_metadata_len``
-field above should contain ``sizeof(union xsk_tx_metadata)``.
+field above should contain ``sizeof(struct xsk_tx_metadata)``.
 
 Note that in the original implementation the ``XDP_UMEM_TX_METADATA_LEN``
 flag was not required. Applications might attempt to create a umem
@@ -45,15 +45,16 @@ the metadata area is ignored by the kernel as well.
 The flags field enables the particular offload:
 
 - ``XDP_TXMD_FLAGS_TIMESTAMP``: requests the device to put transmission
-  timestamp into ``tx_timestamp`` field of ``union xsk_tx_metadata``.
+  timestamp into ``completion.tx_timestamp`` field of
+  ``struct xsk_tx_metadata``.
 - ``XDP_TXMD_FLAGS_CHECKSUM``: requests the device to calculate L4
-  checksum. ``csum_start`` specifies byte offset of where the checksumming
-  should start and ``csum_offset`` specifies byte offset where the
-  device should store the computed checksum.
+  checksum. ``request.csum_start`` specifies byte offset of where the
+  checksumming should start and ``request.csum_offset`` specifies byte offset
+  where the device should store the computed checksum.
 - ``XDP_TXMD_FLAGS_LAUNCH_TIME``: requests the device to schedule the
   packet for transmission at a pre-determined time called launch time. The
-  value of launch time is indicated by ``launch_time`` field of
-  ``union xsk_tx_metadata``.
+  value of launch time is indicated by ``request.launch_time`` field of
+  ``struct xsk_tx_metadata``.
 
 Besides the flags above, in order to trigger the offloads, the first
 packet's ``struct xdp_desc`` descriptor should set ``XDP_TX_METADATA``
@@ -63,9 +64,9 @@ only the first chunk should carry the metadata.
 Software TX Checksum
 ====================
 
-For development and testing purposes its possible to pass
+For development and testing purposes it's possible to pass
 ``XDP_UMEM_TX_SW_CSUM`` flag to ``XDP_UMEM_REG`` UMEM registration call.
-In this case, when running in ``XDK_COPY`` mode, the TX checksum
+In this case, when running in ``XDP_COPY`` mode, the TX checksum
 is calculated on the CPU. Do not enable this option in production because
 it will negatively affect performance.
 
@@ -118,7 +119,7 @@ schedule with a 1-second cycle time, with all Tx Queues open at all times.
 
 The value of the launch time that is programmed in the Advanced Transmit
 Context Descriptor is a relative offset to the starting time of the Qbv
-transmission window of the queue. The Frst flag of the descriptor can be
+transmission window of the queue. The First flag of the descriptor can be
 set to schedule the packet for the next Qbv cycle. Therefore, the horizon
 of the launch time for i225 and i226 is the ending time of the next cycle
 of the Qbv transmission window of the queue. For example, when the Qbv
@@ -129,9 +130,10 @@ running.
 Querying Device Capabilities
 ============================
 
-Every devices exports its offloads capabilities via netlink netdev family.
-Refer to ``xsk-flags`` features bitmask in
-``Documentation/netlink/specs/netdev.yaml``.
+Every device exports its offload capabilities via the Netlink netdev family.
+Query the ``xsk-features`` attribute in
+``Documentation/netlink/specs/netdev.yaml``. Its bits are defined by the
+``xsk-flags`` enum.
 
 - ``tx-timestamp``: device supports ``XDP_TXMD_FLAGS_TIMESTAMP``
 - ``tx-checksum``: device supports ``XDP_TXMD_FLAGS_CHECKSUM``
-- 
2.54.0


