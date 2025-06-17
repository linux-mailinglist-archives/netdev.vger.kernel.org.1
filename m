Return-Path: <netdev+bounces-198486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475D9ADC54A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86F5171741
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB4228A70A;
	Tue, 17 Jun 2025 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a75bxEWj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65D23B601
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149944; cv=none; b=Dhr3TXzBANzjvLX92j/O7gPxhm3Xmp2IBt87s8gVAuRr46XPU7bCHha+pYF2iJpHGD9RdPF6/u0nhHLucswc4YN5Br94D2lRr4ZCTzOabqIBuT7UvEs5qx7Logw5CGoHTkEAjgOsr0oZkARNdE7nH+g8eFQ1jwZ7UXCr9dDz6ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149944; c=relaxed/simple;
	bh=Qo8up+mYBA49jQEuH9zzWhj2VUVYH7YMsUEyhRW/3r0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=evMDvKFqA7x+f9pziG6IP3qDvdjTDN4CD3oIWhXZoiwJeBWXeG3vOL6sZrErT+IK271VP589LdJ1/e5n2R27Hhj792SHoUKHF1uGipRqwxeTpbrSECJ6qqsZgRleulYreI9use6PkMsAg/8xnSByq/MMdKh0zp+LuUpghiMATlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a75bxEWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB65C4CEE3;
	Tue, 17 Jun 2025 08:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149943;
	bh=Qo8up+mYBA49jQEuH9zzWhj2VUVYH7YMsUEyhRW/3r0=;
	h=From:Date:Subject:To:Cc:From;
	b=a75bxEWjXFic1PakmB8kWp71Du8dsbAHz2jxsGgU4hUobTDZdG2otN6A2pgXmgjn8
	 duFwHfVytGlLYrKzoUc1izjCu0ASUiQSPQB2z4RHhARtC2yndq2hHvmeqDX82+DG1F
	 rCCflG96RX94PLA4jVfmVkpSDJ+XiYhKwvAgVF3mIUbR45lcX1gRr3hzqbrwtNcgdH
	 Z7Z0/Rit2d596dH9U+kn9xGhowQn1GWUsuwbDgfxO2IBAKMLg9QlVhffWcFrmEWM4k
	 xvHcS/Rk1tTQFTRVyzw0HwHsVj6D1/FG06wIRXCko6S4mI9qmOwXDjmo1R8kSpWiM8
	 FdSWDbtbHkVEg==
From: Simon Horman <horms@kernel.org>
Date: Tue, 17 Jun 2025 09:45:39 +0100
Subject: [PATCH net-next] nfc: Remove checks for nla_data returning NULL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-nfc-null-data-v1-1-c7525ead2e95@kernel.org>
X-B4-Tracking: v=1; b=H4sIADIrUWgC/x3MTQqAIBBA4avErBvQwP6uEi1ExxqIKdQiiO6et
 PwW7z2QKDIlGKsHIl2ceJcCXVfgVisLIftiaFRjVKs7lOBQzm1Db7PFzpmBTO+DChpKc0QKfP+
 /CYQyCt0Z5vf9AKWRdl9pAAAA
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.0

The implementation of nla_data is as follows:

static inline void *nla_data(const struct nlattr *nla)
{
	return (char *) nla + NLA_HDRLEN;
}

Excluding the case where nla is exactly -NLA_HDRLEN, it will not return
NULL. And it seems misleading to assume that it can, other than in this
corner case. So drop checks for this condition.

Flagged by Smatch.

Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 net/nfc/netlink.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
index 6a40b8d0350d..a18e2c503da6 100644
--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -1192,7 +1192,7 @@ static int nfc_genl_llc_sdreq(struct sk_buff *skb, struct genl_info *info)
 			continue;
 
 		uri = nla_data(sdp_attrs[NFC_SDP_ATTR_URI]);
-		if (uri == NULL || *uri == 0)
+		if (*uri == 0)
 			continue;
 
 		tid = local->sdreq_next_tid++;
@@ -1540,10 +1540,6 @@ static int nfc_genl_se_io(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	apdu = nla_data(info->attrs[NFC_ATTR_SE_APDU]);
-	if (!apdu) {
-		rc = -EINVAL;
-		goto put_dev;
-	}
 
 	ctx = kzalloc(sizeof(struct se_io_ctx), GFP_KERNEL);
 	if (!ctx) {


