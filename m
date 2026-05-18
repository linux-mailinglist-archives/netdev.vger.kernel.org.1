Return-Path: <netdev+bounces-289146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMaXNIlaC2oCGAUAu9opvQ
	(envelope-from <netdev+bounces-289146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:29:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E6B572435
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D0C23049670
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF219387574;
	Mon, 18 May 2026 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJoAkiEn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C15D38A720;
	Mon, 18 May 2026 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128696; cv=none; b=Lq+tiQI5tXa1bk9gUWTHU/QnKNy7elKj7U0vlCJVs2XS0BP5cnpXR03Gx/vLxkAxBtIcOpgQPUKBFNT0HhDMMrzGUeXN2jASKYdfu253Hpy5f+miv5Ms+ugz6buHGYzs6hHZdgqxhJHaKylHau2KLay8ypzmlUYsdXtQob915Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128696; c=relaxed/simple;
	bh=n9SuNozrSOzZhLDAOVkimbEDTCJ3gQowyLTYOZKeHSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iyhJBxPEJLWVSmKGbGucN3hsUVSNEQvD4p1Mv46lB7xTQTvlU/MT1U/MsZrFXpYs8wJ2KRvmkFExJmejuk3dF4Tpr/KJDxgHSMyAZ7lJYppqXt5pD1YQn4j/dRWrOM7o45RMtiaDlWnDMp8hbo3jMLiZWiVlObYvHeYEZGz59f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJoAkiEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DCFC2BCC6;
	Mon, 18 May 2026 18:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128696;
	bh=n9SuNozrSOzZhLDAOVkimbEDTCJ3gQowyLTYOZKeHSw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hJoAkiEn6GExcXDvdbcsElB5jR96pLT6Yb8xj/fQQqNhDzE82HO/4YIum2mz7MyjA
	 NK/Uxw5JCe8wCVcxCos0mezSVy+lYL2vYH0UMCT6JG6LYBgO85HTXQskKFv6FItuRb
	 yef0/whpVL/isvUxGyJwavWhcZpV9aAvrV7hgAw46rXW/FjXA6B6fEtCHyvINcERtN
	 8Rsz5x1Ys0jDPfnbCxjr4Z0Qv0hymjxg/Nb4VZTtoksHmDhuOlvzk2X6Wy6fsb2Dn4
	 ppbBZb2rs6sZvLci4B+GtoRDFz6FKX9B9SgmYDt6M7X7A99kkfjJwHZMKwcvbVMdhm
	 yuFhTJc2X5R2g==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 18 May 2026 14:24:29 -0400
Subject: [PATCH net 2/7] nvme-tcp: store negative errno in queue->tls_err
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-handshake-file-pin-v1-2-4bbcb7e62fda@oracle.com>
References: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
In-Reply-To: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=x/9vqzlpF3pMsoHvTNGwDspyw8WZEQKJLSCQI6ALpEw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqC1l076OEac041r0mxI+Z5S2sJEJZC22dodIZA
 QMmHspv5aCJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagtZdAAKCRAzarMzb2Z/
 l5wWD/4n0zVSZMdZiMdNLyXMCfqW62f32YzVIVpoKZxkxkVYbaNThbabaytjejyEc/pbv7MqVeD
 9kTAuzUgG1Znh/3Lnwa8YFX9JL8XyB1R/lEvTAe5ca3RPb3Gwv2PvrvOsUkRki4XjNm9M2amv93
 f7ie1VnZUPTar1DxT1VImOAJTLeBbioehA8YWm5J9VepZFkD4vWKk3PGY8p4kt/6UAfisPlaEqv
 vC9EMVz4xVwnNlOHXZaEXCwO1leedR8rf6LiISDjSosuotjOtqUleKJ/B1Ezf1wadP+6tHRJNs+
 I7TrSiwyvgkAxaHAKLvVMtTzko6bfCgxJjfonUGK1hG9ClWs+jZKpN0RKXJGsPMVLzLRasDhDQF
 VgT7D0zxxiEXmgIxj4pQm47vEYFUcCLz1U20Hz93Hsu2dBVb0erkJAcCZ4E9/GyNg3ExuVDh3y6
 ASkOmvhRfoWsffaTs95luC/bHWRqqkT6j9sCSrm0OV+kVSCHoCRWxl+5hTOxaxTIdj8NXu4Yoqc
 UsdhcN+RFmzfe/atC88XE/U7x+zU7lGAEBWnVF12djTRtbU6cRqIYV0Gvv5IuLtu40qEBbHNPP4
 VXhC0zaY1JpF4kj6rPAiccI4rfOoFw4cpWpmsvqgJ6yf37nrpcb2ItPGs8PpxD8drJ/MyJCTHdz
 NJIWLt657qfVJLg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-289146-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:mid,oracle.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 68E6B572435
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

nvme_tcp_tls_done() assigns queue->tls_err in three branches.  The
ENOKEY lookup failure and the EOPNOTSUPP initializer both store
negative errnos.  The third branch, reached when the handshake
layer reports a non-zero status, stores -status.

The handshake layer delivers status to the consumer callback as a
negative errno; the other in-tree consumers --
xs_tls_handshake_done() and the nvmet target callback -- treat
their status argument that way.  The extra negation in
nvme_tcp_tls_done() flips the sign, leaving tls_err as a positive
value (for instance, +EIO), which nvme_tcp_start_tls() then
returns to its caller.

Drop the extra negation so queue->tls_err uniformly carries a
negative errno on failure.

Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 15d36d6a728e..68a1d7640494 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1702,7 +1702,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
 		qid, pskid, status);
 
 	if (status) {
-		queue->tls_err = -status;
+		queue->tls_err = status;
 		goto out_complete;
 	}
 

-- 
2.54.0


