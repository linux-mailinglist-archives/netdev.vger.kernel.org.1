Return-Path: <netdev+bounces-256430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLMgLlBCgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:45:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF63DDC8B
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD58530F1A1B
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34552374723;
	Tue,  3 Feb 2026 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIs1Xhm5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0248F369984;
	Tue,  3 Feb 2026 18:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144161; cv=none; b=ucuQwGRLeCK6h/LoNVrT2jut6yvK6OSFqWgzbkNlsbaN/tINR84HdTEeHEIM1G28DxRgtj/OE6653B3VfDcSXSgIM4qbgcc1LDkNbCayvCXn5g4mLONtOmSBuNdi+CIpbQcFAVPhL/aOUi+jt2/yjo/fMkf1TYJUO0Px+UxLfwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144161; c=relaxed/simple;
	bh=hjN+cfvuaZoonGW7J/zR6+MM8yqBXe63BQgV6RkW3rI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NlLfiHDxjI4rg625wuq6z/9awPcKAV385hVvw3vjzlUdYpAfjS9UVECdDBsMLbJYC+CyhY9RRLOnZT8LVlgEUy/JpwtkeTmUMe7GrWOb/E3uGTnqMLFqtkjYDV6Mk2J6Kz8qhFsYwD2kBjW48Zuz8l303n3hIJAE32IlBw9REYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIs1Xhm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958ACC116D0;
	Tue,  3 Feb 2026 18:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770144160;
	bh=hjN+cfvuaZoonGW7J/zR6+MM8yqBXe63BQgV6RkW3rI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iIs1Xhm5c8xCnIh4zi0tm3a4jp2tPx8KMKSg7GjCDeHitLeOSNBfSXMcdoML/usGl
	 OyBMYBIZu76pxaob/ZYchHOKyz++OGMkC7LeqeEBj/1Qis2pcgJcDxhemxnUT8JW/L
	 w9NR+VtIOcTSWzq1tuib94DdaUVjedYDAnCKyf2rdk7KXx9TKfL4xoLyV1lwEfsdRh
	 hzlHItjO4+AtQQZJCgLIXuwJZ5IIImouy/c+nZ1Gri1NN0+TXH4qGeCDIiZYE5C+C5
	 iXqZia25Zfvf5wfJaMZnDQbWSPV7flJ3ZMVinviQnK/1MkAZ+c3FH22S9e+BC43+Ht
	 Hi16NEcSGTeTw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 03 Feb 2026 19:41:21 +0100
Subject: [PATCH net-next 05/15] mptcp: pm: align endpoint flags size with
 the NL specs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-net-next-mptcp-misc-feat-6-20-v1-5-31ec8bfc56d1@kernel.org>
References: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
In-Reply-To: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hjN+cfvuaZoonGW7J/zR6+MM8yqBXe63BQgV6RkW3rI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbHDszVzqxFjVstSh9Fc+dmrp47c2tWRy3T3dY3tt2M
 Pj7Gs+LHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNpL2JkuPlbetnDMA0/6yrf
 lrV9Gdy1h5d/PSj04+lXg/vnfxVffs/wV9qIc2rJ4Yim/AdVx5ftPPJo2/kaBmaH4ucnNyn9+O0
 qyQMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256430-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5AF63DDC8B
X-Rspamd-Action: no action

The MPTCP Netlink specs describe the 'flags' as a u32 type. Internally,
a u8 type was used.

Using a u8 is currently fine, because only the 5 first bits are used.
But there is also no reason not to be aligns with the specs, and
to stick to a u8. Especially because there is a whole of 3 bytes after
in both mptcp_pm_local and mptcp_pm_addr_entry structures.

Also, setting it to a u32 will allow future flags, just in case.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 66a30409f217..f4bfe91ca7f9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -246,14 +246,14 @@ struct mptcp_pm_data {
 
 struct mptcp_pm_local {
 	struct mptcp_addr_info	addr;
-	u8			flags;
+	u32			flags;
 	int			ifindex;
 };
 
 struct mptcp_pm_addr_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
-	u8			flags;
+	u32			flags;
 	int			ifindex;
 	struct socket		*lsk;
 };

-- 
2.51.0


