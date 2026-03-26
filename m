Return-Path: <netdev+bounces-271835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHp0J7PCxGku3QQAu9opvQ
	(envelope-from <netdev+bounces-271835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:22:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F9E32F58E
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C1FE305594E
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A62358391;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uw2Fg2Aw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D453431E3;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502339; cv=none; b=cE8RjpVSyy4aCV/hV+LQfys08FideUkUlnoZaXIPSE8x+XmUnoAf3kXPot/pD4WwTXk2IpSDksepPQYOStXxrsLgqHL5BM8fcpU4Bn+MraI7qdPT5eX8/ALhp0Ql065AiGRjw2gYRjts6bILO53bDrXg37D+HhmCvKnw2a5Rb7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502339; c=relaxed/simple;
	bh=8nzLFxeuDNYsf3IkWcj76Hg9mmDN27Zptu4KIN/CWj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eo1EuqbufAvL5d5NspDmRRrhHwnERi2w/PTr19vfUKKSLd35qTAIx8V6fnB+4G+0sA0bx7BiFzAFq5m+m8KW7BiGn4Cdkahvi0u/+po1cxf99ZNmh3nOyIJWR3zK+x0J7+h+JyAPpR+Lf1S8Y//40zTyGiQ0EtvT0Gg+U5EmlMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uw2Fg2Aw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 560E5C19424;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774502339;
	bh=8nzLFxeuDNYsf3IkWcj76Hg9mmDN27Zptu4KIN/CWj8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Uw2Fg2Awo2ZC9SshWNX4To5unpSLUgX8Nt/lJ5MMzcGuMy7/PpqhCPMPAMJ0Xl8iG
	 tvCd5vJ55w+kczDAll/72TkDfTaSMKrltXjzr5kt6r0hK6wD2JycJ9scgUUOEPizyP
	 WIO8ftd0+ivEGLcewGxESW5dJBzDw1QyMyotIGUVOAxDct49KViDDCw814Da+qAjRy
	 Icxx1q02UJ4HXkNTu3cKD4lsfLCWRkQClfPF1lB7EhhAAYq1zz2P/ZqjGIwvgSUmAk
	 290lcq7ByzxILXuZwFLzi6No5zGaDRhZtiq7/MX93TNuHKSeiY1NqhlefYykDum0PW
	 +NwP6cRVvBe+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E290109E553;
	Thu, 26 Mar 2026 05:18:59 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Wed, 25 Mar 2026 22:19:02 -0700
Subject: [PATCH net-next v2 4/6] enic: make enic_dev_enable/disable
 ref-counted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-enic-sriov-v2-prep-v2-4-f72cf716ebfa@cisco.com>
References: <20260325-enic-sriov-v2-prep-v2-0-f72cf716ebfa@cisco.com>
In-Reply-To: <20260325-enic-sriov-v2-prep-v2-0-f72cf716ebfa@cisco.com>
To: Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774502338; l=2385;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=UFxmA9CX8KV13iHlUmy26fUHGETjz4zvpBBpux+w9yI=;
 b=JxRD9wvJzsZNpmzXqnmy0W1K9LtqxIV3ezpNSHS96K1Hwfi6DG/04EE0ofRjcwuhe48wHQhNR
 qXU2fFOgy59Dg0xQFVEof8u1lRmjRsDvo3Adgu0xnAnymdZj2sBD3jJ
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271835-lists,netdev=lfdr.de,satishkh.cisco.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cisco.com:email,cisco.com:replyto,cisco.com:mid]
X-Rspamd-Queue-Id: 24F9E32F58E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Satish Kharat <satishkh@cisco.com>

Both the data path (ndo_open/ndo_stop) and the upcoming admin channel
need to enable and disable the vNIC device independently. Without
reference counting, closing the admin channel while the netdev is up
would inadvertently disable the entire device.

Add an enable_count to struct enic, protected by the existing
devcmd_lock. enic_dev_enable() issues CMD_ENABLE_WAIT only on the
first caller (0 -> 1 transition), and enic_dev_disable() issues
CMD_DISABLE only when the last caller releases (1 -> 0 transition).

No functional change for the current single-caller data path.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h     |  1 +
 drivers/net/ethernet/cisco/enic/enic_dev.c | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 0fd9cd917132..67fd780b1fa1 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -260,6 +260,7 @@ struct enic {
 	u16 num_vfs;
 #endif
 	enum enic_vf_type vf_type;
+	unsigned int enable_count;
 	spinlock_t enic_api_lock;
 	bool enic_api_busy;
 	struct enic_port_profile *pp;
diff --git a/drivers/net/ethernet/cisco/enic/enic_dev.c b/drivers/net/ethernet/cisco/enic/enic_dev.c
index 2cbae7c6cc3d..659787f73cf1 100644
--- a/drivers/net/ethernet/cisco/enic/enic_dev.c
+++ b/drivers/net/ethernet/cisco/enic/enic_dev.c
@@ -131,10 +131,13 @@ int enic_dev_set_ig_vlan_rewrite_mode(struct enic *enic)
 
 int enic_dev_enable(struct enic *enic)
 {
-	int err;
+	int err = 0;
 
 	spin_lock_bh(&enic->devcmd_lock);
-	err = vnic_dev_enable_wait(enic->vdev);
+	if (enic->enable_count == 0)
+		err = vnic_dev_enable_wait(enic->vdev);
+	if (!err)
+		enic->enable_count++;
 	spin_unlock_bh(&enic->devcmd_lock);
 
 	return err;
@@ -142,10 +145,16 @@ int enic_dev_enable(struct enic *enic)
 
 int enic_dev_disable(struct enic *enic)
 {
-	int err;
+	int err = 0;
 
 	spin_lock_bh(&enic->devcmd_lock);
-	err = vnic_dev_disable(enic->vdev);
+	if (enic->enable_count == 0) {
+		spin_unlock_bh(&enic->devcmd_lock);
+		return 0;
+	}
+	enic->enable_count--;
+	if (enic->enable_count == 0)
+		err = vnic_dev_disable(enic->vdev);
 	spin_unlock_bh(&enic->devcmd_lock);
 
 	return err;

-- 
2.43.0



