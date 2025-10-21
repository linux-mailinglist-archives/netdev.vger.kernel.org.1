Return-Path: <netdev+bounces-231185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA0DBF61B4
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8390D4EC56F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4DD2E0B69;
	Tue, 21 Oct 2025 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F37qAdLy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD29244693;
	Tue, 21 Oct 2025 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047016; cv=none; b=k/lPp82y1QL6yD06iH4S9WZ6KJlgKdaWRE/cjgIDDFjyvti+2Y4Rp3VBae0atHkYMdryZ7UF7EaV5u9PcDVf8qJbTdmO55a0veuLuTrelLB3IE8P/0YAsLi9XnbHBUWF0l/w2TKpqHit4VlxNW15k5D3otGcly1BW6pAfVr84JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047016; c=relaxed/simple;
	bh=jPD4ml6t5HKNxNOxwm2N8DznQdh6UR/72Xht9+nYrWY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Omprj7kSlmTyWkCXnjPNR18Ge028EbMpYYsy3/5+IDxYwJ498RPWwU7QY4LFviAvTiR5RsACRNhV4pxwIF2r5dowqg41cp/jk7icYjFlEa2nSY+/mPOwsgO3RLH9o01vG36yAnggRpvTLF4BB70Avf69dfeeOFpUHnvlJ3vnNf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F37qAdLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A83C4CEF1;
	Tue, 21 Oct 2025 11:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047015;
	bh=jPD4ml6t5HKNxNOxwm2N8DznQdh6UR/72Xht9+nYrWY=;
	h=Date:From:To:Cc:Subject:From;
	b=F37qAdLyaRUmSWWUBSwXMLLHY5btLVlFx2q8VdSASndaUDl8Fuyb4yYXHt4nsjN78
	 8pGun7VkGM8kStSvAjmKn9EATy9FNXvTb/6xet/Meq8qJvG6NfQ7NUUKYSEGHKG+t+
	 VUh8hOFsRxZsQwZTBNDizotYh5lqELfP8Nb+ZaBsCj10h3lXNPOknghVmaCHpaETxf
	 IO6qpJbmFV5ED8CWTDMl8u4qCLJcuOZwq7uJEe1hA9sxRZVMyPsh729T46eJh4WMvQ
	 4Ozi62DtdueRBqiu5fpLO90B3tIqsLK7Hf7OX93t65mPCdW2E5YfD2Yg50jb+5YXLI
	 l98Bq2XygCTfA==
Date: Tue, 21 Oct 2025 12:43:30 +0100
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] net: inet_sock.h: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <aPdx4iPK4-KIhjFq@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use the new TRAILING_OVERLAP() helper to fix 2600 of the following
warnings:

2600 ./include/net/inet_sock.h:65:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

This helper creates a union between a flexible-array member (FAM)
and a set of members that would otherwise follow it (in this case
`char data[40];) This overlays the trailing members (data) onto the FAM
(__data) while keeping the FAM and the start of MEMBERS aligned.

The static_assert() ensures this alignment remains, and it's
intentionally placed inmediately after `struct ip_options_data`
(no blank line in between).

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---

I think it's worth mentioning that the introduction of the new
TRAILING_OVERLAP() helper saves us from making changes like the
following, for this particular case:

	https://lore.kernel.org/linux-hardening/ZzK-n_C2yl8mW2Tz@kspp/

Thanks

 include/net/inet_sock.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 1086256549fa..a974588803af 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -62,9 +62,12 @@ struct ip_options_rcu {
 };
 
 struct ip_options_data {
-	struct ip_options_rcu	opt;
-	char			data[40];
+	TRAILING_OVERLAP(struct ip_options_rcu, opt, opt.__data,
+			 char			data[40];
+	);
 };
+static_assert(offsetof(struct ip_options_data, opt.opt.__data) ==
+	      offsetof(struct ip_options_data, data));
 
 struct inet_request_sock {
 	struct request_sock	req;
-- 
2.43.0


