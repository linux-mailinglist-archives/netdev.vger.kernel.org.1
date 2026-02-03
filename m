Return-Path: <netdev+bounces-256359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADYqNsolgmnPPgMAu9opvQ
	(envelope-from <netdev+bounces-256359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:43:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E994DC295
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34A1A31A44E0
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 16:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007AD3D3007;
	Tue,  3 Feb 2026 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxJ2NKhx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF12D3D3009;
	Tue,  3 Feb 2026 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136452; cv=none; b=pN/dOdVp6LMTU5GSnv+025VbDgVe1Wf5LEBsO9aByuoHD11HrgEGzw15NCl/0aGe63RRDXIyPNq/xRDr/EMdf2s+WIQ+Y7PedbtjnizQ92CsLHO4lbPZksSHrTIS9zTHeJwW3R7HGGphdxyHu43F3rSpSWUg5aWJdSIYzFesYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136452; c=relaxed/simple;
	bh=zPVP9b32gTmljreSY5oa7bG3eG5t4SD+ESMPgfqDiRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pj0VR8n9S9AwYyABfkoIjA58A6gTOKp88zPydIyJ8aSN7AqhzPxRl/w/9VUCCruxcb3p7rML2glEvKncce3px6In5hAuGpQ19ewR7/7vOCj7MT1oBnPtmUGrO0y06ITr+oP31Kebl1M0Q4VekDM8I1P15HqpfbOWDwUBU/KbYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxJ2NKhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECEEC19425;
	Tue,  3 Feb 2026 16:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770136452;
	bh=zPVP9b32gTmljreSY5oa7bG3eG5t4SD+ESMPgfqDiRs=;
	h=From:To:Cc:Subject:Date:From;
	b=cxJ2NKhxga7d59tgAw/LuOm4FUPfMQGeBxs3WQibj1x4g7XT6rGANjoIVL0K58Km5
	 dflTKPxojNPawqPj0iBPdbpodBdzhRfxYgNWm7XQdViwQJ5M+iqamvR1sj95QQiKh3
	 7v+jjsGDeTKBHw8Gwl12n+sbpHQxJKiLWaDbpJsuzrAOuFuQTT7VgdGnGrMfEXHODH
	 L14/OalyA1rWKds1riohcIpCOEC5yFi2kbwJbVfzvlitiOULY3dS+LJek5hVbIDeSP
	 2O8WoYH/PMc+d5oUBi6jx8PccW9AkZmfMSc6I0Xz2GFkucdJyhXRCLCqJWkh0Vy4Dv
	 lRtalglcFX9xA==
From: Arnd Bergmann <arnd@kernel.org>
To: Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	HarshaVardhana S A <harshavardhana.sa@broadcom.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH] vmw_vsock: bypass false-positive Wnonnull warning with gcc-16
Date: Tue,  3 Feb 2026 17:34:00 +0100
Message-Id: <20260203163406.2636463-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256359-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3E994DC295
X-Rspamd-Action: no action

From: Arnd Bergmann <arnd@arndb.de>

The gcc-16.0.1 snapshot produces a false-positive warning that turns
into a build failure with CONFIG_WERROR:

In file included from arch/x86/include/asm/string.h:6,
                 from net/vmw_vsock/vmci_transport.c:10:
In function 'vmci_transport_packet_init',
    inlined from '__vmci_transport_send_control_pkt.constprop' at net/vmw_vsock/vmci_transport.c:198:2:
arch/x86/include/asm/string_32.h:150:25: error: argument 2 null where non-null expected because argument 3 is nonzero [-Werror=nonnull]
  150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcpy'
  164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
      |                 ^~~~~~
arch/x86/include/asm/string_32.h:150:25: note: in a call to built-in function '__builtin_memcpy'
net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcpy'
  164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
      |                 ^~~~~~

This seems relatively harmless, and it so far the only instance of this
warning I have found. The __vmci_transport_send_control_pkt function
is called either with wait=NULL or with one of the type values that
pass 'wait' into memcpy() here, but not from the same caller.

Replacing the memcpy with a struct assignment is otherwise the same
but avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/vmw_vsock/vmci_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 00f6bbdb035a..a64522be1bad 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -161,7 +161,7 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
 
 	case VMCI_TRANSPORT_PACKET_TYPE_WAITING_READ:
 	case VMCI_TRANSPORT_PACKET_TYPE_WAITING_WRITE:
-		memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
+		pkt->u.wait = *wait;
 		break;
 
 	case VMCI_TRANSPORT_PACKET_TYPE_REQUEST2:
-- 
2.39.5


