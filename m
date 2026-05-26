Return-Path: <netdev+bounces-291796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNpKIsfHFWqMbAcAu9opvQ
	(envelope-from <netdev+bounces-291796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:18:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 925B65D9855
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3683F3044A35
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043423AFAE8;
	Tue, 26 May 2026 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAO5XsWN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7FB3AF650;
	Tue, 26 May 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811332; cv=none; b=oJxVUyny5z6BjgaDZwec+0/5RnecLLlmJ9LwwmeYpT3YSWqzZY4clz5xssFvDUlqPf+un5FeundprkDHXehlVX4DNOTDsmloYFUiqlnwTsudhSr0QfEnoRYAEMERSdI7hcfqJyp9c1T+lj2oWEp6E+jHdyQxE2QCFzWFgLClfZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811332; c=relaxed/simple;
	bh=dAEaaUcdJF6g1mcUPCY6uW2HScEEcAY5/COhV+TTVfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUtoAM1iDlA1/s6hOAUegMuks7NMaYh9rgMXQQafoLanO4wyTOfYqtbZVoAdwCM/22Iae9k88t3o+4hoZlKZdrQruTmGIufvquPjzDB6esZD7ScNMFkyBmrBMQBZa+aIlM3Pis1/gIzdzmH9XkD7H1tjbZ18iApHoWOtOjVWJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAO5XsWN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E0B1F000E9;
	Tue, 26 May 2026 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811331;
	bh=FxL4PrMuNFeXEkmzJF/NMZhPHMrdk06ldVlfMSQy8Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GAO5XsWNTqgMPTWmhJHkSlM+NkMpX72pPeczy+wI7fFBeryuY3LfAJR22z8GhaE3o
	 rzANQ+1oqqV60VS1KlgyqVp7sgGNWX7pPPq4ljCyPA0crV9mxM0DF+YHRxz57iBxW8
	 /Fobzf7RfbqFmlnuKeumQnL/5ODUrpK+9PRENGptZlSQDxlgrK/1mnL53cyWDyU86A
	 2qG0/H8J1Vd9HdTppIVy42i5VHCMV/q0c6by3GDbAMxIj6V8baniT/+2rNfR44/EjT
	 pu4xbZHJxZK28YGX0tDBlG+0fSDX5wVmVQAF6LU2/hMCHZcwgnqNr1xFXRnbCW4mv8
	 qPSIeeZdM3rYg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	vladimir.oltean@nxp.com,
	willemb@google.com,
	sdf.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	jesse.brandeburg@intel.com,
	linux-doc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 08/10] docs: net: add Rx notes to the checksum guide
Date: Tue, 26 May 2026 09:01:49 -0700
Message-ID: <20260526160151.2793354-9-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526160151.2793354-1-kuba@kernel.org>
References: <20260526160151.2793354-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-291796-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 925B65D9855
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Rx checksum processing gives people pause. The two main questions
in my experience are:
 - what to do with bad IPv4 checksum; and
 - what to do with packets with bad checksum.

Folks often feel the urge to drop the latter, to "avoid overloading
the host".

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/checksum-offloads.rst | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/checksum-offloads.rst b/Documentation/networking/checksum-offloads.rst
index 907aed9f3a3b..d838fe5c1606 100644
--- a/Documentation/networking/checksum-offloads.rst
+++ b/Documentation/networking/checksum-offloads.rst
@@ -19,7 +19,6 @@ take advantage of checksum offload capabilities of various NICs.
 
 Things that should be documented here but aren't yet:
 
-* RX Checksum Offload
 * CHECKSUM_UNNECESSARY conversion
 
 
@@ -139,3 +138,19 @@ In Linux, RCO is implemented individually in each encapsulation protocol, and
 most tunnel types have flags controlling its use. For instance, VXLAN has the
 configuration flag VXLAN_F_REMCSUM_TX to indicate that RCO should be used when
 transmitting.
+
+
+RX Checksum Offload
+===================
+
+RX checksum offload is controlled via NETIF_F_RXCSUM. When disabled the driver
+must not set skb->ip_summed on ingress packets. As mentioned, IPv4 checksum
+is not offloaded, the RXCSUM feature controls the offload of verification of
+transport layer checksums.
+
+Note that packets with bad TCP/UDP checksums must still be passed
+to the stack. skb->ip_summed of such packets can be set to ``CHECKSUM_COMPLETE``
+or left at ``CHECKSUM_NONE``. Drivers **must not discard** packets with
+bad TCP/UDP checksum and must not configure the device to drop them.
+Checksum validation is relatively inexpensive and having bad packets reflected
+in SNMP counters is crucial for network monitoring.
-- 
2.54.0


