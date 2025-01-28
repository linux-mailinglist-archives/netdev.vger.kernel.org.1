Return-Path: <netdev+bounces-161353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC13DA20D15
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5815A1619DB
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF771A9B3D;
	Tue, 28 Jan 2025 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="IA/45HV5";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="Z7TVgGpS"
X-Original-To: netdev@vger.kernel.org
Received: from e3i103.smtp2go.com (e3i103.smtp2go.com [158.120.84.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998591A841B
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078230; cv=none; b=Jc30crTZrCt+IvN4/gt4dWt89W9xeWzIwkwHx0UR1Usq57TDEkwWUep5Dc/k3YphpiJvTNdT1vp0povMblvbgVzGmGSHOgXw+kEa1ezBgO2+iuuiPQaYu0Oo4sV/vXeNo1FirtL6ADg4mfof4302gbycIyCM1beIHoTsKma0i2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078230; c=relaxed/simple;
	bh=SA2dA2cFh5kIUaABXLBFt0k0NWbeFGJ9IJMwK9IllJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S2clP5Zdcrj7Ijk0vCLtcxsO3Ipi93aSUof9+M1oanhdX97XWObe5lbgB+ghHFszi7wgoxcUAr/GYe8Mgb1QeuhATmGd3TU+lM78P8L1HraVx4Otbwfw1miaV1fstO3ppZhS9AIcI9Ph6YiC93VtP0bn96b4Wcezrm/2OevhMvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=IA/45HV5; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=Z7TVgGpS; arc=none smtp.client-ip=158.120.84.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1738077319; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=+xSsdRmbHklVvRjU75VCmBGTMgpvR753FjKrsS8EVyw=;
 b=IA/45HV5zAUi5E17LgVycLfMUA8emVaGCfxfO3qH+3HSaaDvMl6JQaCGCqGp9+mkEjEBL
 jPFdv53uIYcdCNOOJ/wixYdZHoShC0S/xFjrd0ifL2IGzx54j9+BsHPSrq5cTqLnZsrEsD/
 uNUwTXlgZVxQMKiW6s8BguUW6hh63NWujTYdHBf47ui2FX6aFBMM7qs5cvZ8q8+SlvbZlFi
 FkN0uUaya2j+NoW2BZxw3GJzDNf+6nrTz/Eg8EBg+a78QLQCzBcwFH9LbWKWMq+4rzlZMpk
 jJ2UQZse3E/lXw9JEM1qFt8fm04AWrWGol0ewQyzELSrG/4sTx5xK++yGsVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1738077319; h=from : subject
 : to : message-id : date;
 bh=+xSsdRmbHklVvRjU75VCmBGTMgpvR753FjKrsS8EVyw=;
 b=Z7TVgGpSgoU04jFFBlKQB9mlMBCJAOJ9FTp5Zaf00DRs81ujNThaKoAMsufU6vKHKmw7F
 9yD/1ig0hpnzM00COuCI1Z8yKDxB3b6aY2FXbuYsAISmt7k6ApMGJ7Qj7GoUd9rTt2QybOp
 tj9PfuYAb8514qZeSRXJ9WD1dAar9E5yQ3jEH5j19Mry8ghkniH28l622tYNvfv9+jquye8
 xWQ/M1srEcDHTMyMO+Dx/FySXG9HeK/wBM5Sngj4BiwYQKY3tIo+6V7lbvjx9HByET2EnzV
 1vvpCkGzaJfpEXxxeHCkkaI/SvtmgEuF/lfg//kCbAcfLI7/xawVxtga/Ong==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1tcnIs-FnQW0hPqPnK-kBbu;
	Tue, 28 Jan 2025 15:15:02 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Sven Eckelmann <sven@narfation.org>,
	Erick Archer <erick.archer@outlook.com>,
	Kees Cook <kees@kernel.org>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH] batman-adv: Fix incorrect offset in batadv_tt_tvlv_ogm_handler_v1()
Date: Tue, 28 Jan 2025 16:11:06 +0100
Message-Id: <ac70d5e31e1b7796eda0c5a864d5c168cedcf54d.1738075655.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sA6pqHVkxx
X-smtpcorp-track: 260jryGB6Vfi.cMOXufxcbyPu.UXqQhgxJwJA

Since commit 4436df478860 ("batman-adv: Add flex array to struct
batadv_tvlv_tt_data"), the introduction of batadv_tvlv_tt_data's flex
array member in batadv_tt_tvlv_ogm_handler_v1() put tt_changes at
invalid offset. Those TT changes are supposed to be filled from the end
of batadv_tvlv_tt_data structure (including vlan_data flexible array),
but only the flex array size is taken into account missing completely
the size of the fixed part of the structure itself.

Fix the tt_change offset computation by using struct_size() instead of
flex_array_size() so both flex array member and its container structure
sizes are taken into account.

Fixes: 4436df478860 ("batman-adv: Add flex array to struct batadv_tvlv_tt_data")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/batman-adv/translation-table.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 3c0a14a582e4..d4b71d34310f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3937,23 +3937,21 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tt_data;
 	u16 num_entries, num_vlan;
-	size_t flex_size;
+	size_t tt_data_sz;
 
 	if (tvlv_value_len < sizeof(*tt_data))
 		return;
 
 	tt_data = tvlv_value;
-	tvlv_value_len -= sizeof(*tt_data);
-
 	num_vlan = ntohs(tt_data->num_vlan);
 
-	flex_size = flex_array_size(tt_data, vlan_data, num_vlan);
-	if (tvlv_value_len < flex_size)
+	tt_data_sz = struct_size(tt_data, vlan_data, num_vlan);
+	if (tvlv_value_len < tt_data_sz)
 		return;
 
 	tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
-						     + flex_size);
-	tvlv_value_len -= flex_size;
+						     + tt_data_sz);
+	tvlv_value_len -= tt_data_sz;
 
 	num_entries = batadv_tt_entries(tvlv_value_len);
 
-- 
2.40.0


