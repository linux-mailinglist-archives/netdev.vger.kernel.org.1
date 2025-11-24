Return-Path: <netdev+bounces-241139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AD4C802E9
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 12:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAD054E3FFF
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 11:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C862FD686;
	Mon, 24 Nov 2025 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olT/0Ads"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D32FDC3C;
	Mon, 24 Nov 2025 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983188; cv=none; b=ad+CmGZIYhac8dZ3YtmUFDyoSytqJ00HrCJjO1d/ms5UonuP8WrJbsScfcMPQn+q38dwagLAYliwLcnfFwPaPvM9qeSOShTF9il2b/mR4UrynvFbPUNAUUBbmfxUeBcJr/W+GagebhrPgkfoESlJ/FIdtnuBh+xwd2DEKNJDq0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983188; c=relaxed/simple;
	bh=zyLpxW28Q0T2f6/rD+Ss09t0Vdu9Bh+cK5fBHg2ssRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cbBXO5At5jy2LN0U/RwK/fwL/2GMAjOslg/cs4UlT3qd5VX51wF0muhkS4K5/DmjRDFh8iq1fNLvOKfJgvieaDaoGRd2tr31XLYCHTxJRFfhy17GI+83CmYGKUkiAw1A3Qjdb/X/YXsjA0PQkvW2n8aAwj5dTF94cCjyfojQ5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olT/0Ads; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDE6C116D0;
	Mon, 24 Nov 2025 11:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763983187;
	bh=zyLpxW28Q0T2f6/rD+Ss09t0Vdu9Bh+cK5fBHg2ssRA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=olT/0AdsOwX4WUui+OFazvpUT2rK8iNJ3Lmp2oeKXxCOHCaLAK3IQ7XbSR+cFPHlZ
	 tk53ZE1gDzgEKZVRfsKYduRQ+TJ1hyyF6B+QiodaX5qEK63Rri1zPzHLqUbg3xhrZe
	 MsiySkKasKICIV9d6gV1g6RILFJOE7QMcLjfAIFN6PDj54NEd8fKkgB2veSzrhVavX
	 PETS1Z1SDgBTAl6S+zplJBAR82Gr8gKVbcZKZa6547n4tW8kOw1wALkPEuE+NcDNCY
	 vjdWz0ntlwgF2iKdB7UY51nR0F7XJARPJ83eQ5H80UtI4Np4batm+Wxinv7Ws2MfCQ
	 2P5pjHqO2QKQw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Nov 2025 12:19:23 +0100
Subject: [PATCH iproute2-net 3/6] mptcp: add 'laminar' endpoint support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-iproute-mptcp-laminar-v1-3-e56437483fdf@kernel.org>
References: <20251124-iproute-mptcp-laminar-v1-0-e56437483fdf@kernel.org>
In-Reply-To: <20251124-iproute-mptcp-laminar-v1-0-e56437483fdf@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 David Ahern <dsahern@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3754; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=zyLpxW28Q0T2f6/rD+Ss09t0Vdu9Bh+cK5fBHg2ssRA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJV7L0Ym7RkPgRI3LmyOXkDU3XqLz/mvw2XtP+evju7S
 SXz65sJHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPpyGBk2Nr14XrEO3MNB4+T
 nUfKbjms+63xZOmS+vvM7hc7FCdmf2NkuHsxLOS2i9nU57cCZDm+Xbkl5C215eFrt+7Gn1s/7jr
 8mREA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This new endpoint type has been recently added to the kernel in v6.18
[1]. It will be used to create new subflows from the associated address
to additional addresses announced by the other peer. This will be done
if allowed by the MPTCP limits, and if the associated address is not
already being used by another subflow from the same MPTCP connection.

Note that the fullmesh flag takes precedence over the laminar one.
Without any of these two flags, the path-manager will create new
subflows to additional addresses announced by the other peer by
selecting the source address from the routing tables, which is harder to
configure if the announced address is not known in advance.

The support of the new flag is easy: simply by adding it in the
mptcp_addr_flag_names array.

The usage menu and the manual now references the new endpoint type. The
new corresponding counter has also been added in ss.

Link: https://git.kernel.org/torvalds/c/539f6b9de39e [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c        |  3 ++-
 man/man8/ip-mptcp.8 | 16 ++++++++++++++++
 misc/ss.c           |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 2415cac8..2908b69e 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -32,7 +32,7 @@ static void usage(void)
 		"	ip mptcp limits show\n"
 		"	ip mptcp monitor\n"
 		"FLAG-LIST := [ FLAG-LIST ] FLAG\n"
-		"FLAG  := [ signal | subflow | backup | fullmesh ]\n"
+		"FLAG  := [ signal | subflow | laminar | backup | fullmesh ]\n"
 		"CHANGE-OPT := [ backup | nobackup | fullmesh | nofullmesh ]\n");
 
 	exit(-1);
@@ -59,6 +59,7 @@ static const struct {
 	{ "backup",		MPTCP_PM_ADDR_FLAG_BACKUP },
 	{ "fullmesh",		MPTCP_PM_ADDR_FLAG_FULLMESH },
 	{ "implicit",		MPTCP_PM_ADDR_FLAG_IMPLICIT },
+	{ "laminar",		MPTCP_PM_ADDR_FLAG_LAMINAR },
 	{ "nobackup",		MPTCP_PM_ADDR_FLAG_NONE },
 	{ "nofullmesh",		MPTCP_PM_ADDR_FLAG_NONE }
 };
diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 500dc671..c03935dd 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -66,6 +66,8 @@ ip-mptcp \- MPTCP path manager configuration
 .RB "|"
 .B subflow
 .RB "|"
+.B laminar
+.RB "|"
 .B backup
 .RB "|"
 .B fullmesh
@@ -169,6 +171,20 @@ path manager will try to create an additional subflow using this endpoint
 as the source address after the MPTCP connection is established. A client would
 typically do this.
 
+.TP
+.BR laminar
+The endpoint will be used to create new subflows from the associated address to
+additional addresses announced by the other peer. This will be done if allowed
+by the MPTCP limits, and if the associated address is not already being used by
+another subflow from the same MPTCP connection. Note that the
+.BR fullmesh
+flag takes precedence over the
+.BR laminar
+one. Without any of these two flags, the path-manager will create new subflows
+to additional addresses announced by the other peer by selecting the source
+address from the routing tables, which is harder to configure if the announced
+address is not known in advance.
+
 .TP
 .BR backup
 If this is a
diff --git a/misc/ss.c b/misc/ss.c
index 989e168a..b3566f6b 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3308,6 +3308,8 @@ static void mptcp_stats_print(struct mptcp_info *s)
 		out(" bytes_acked:%llu", s->mptcpi_bytes_acked);
 	if (s->mptcpi_subflows_total)
 		out(" subflows_total:%u", s->mptcpi_subflows_total);
+	if (s->mptcpi_endp_laminar_max)
+		out(" endp_laminar_max:%u", s->mptcpi_endp_laminar_max);
 	if (s->mptcpi_last_data_sent)
 		out(" last_data_sent:%u", s->mptcpi_last_data_sent);
 	if (s->mptcpi_last_data_recv)

-- 
2.51.0


