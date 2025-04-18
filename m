Return-Path: <netdev+bounces-184045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D86A92FD6
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A901B634F0
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B49A267B8D;
	Fri, 18 Apr 2025 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSCZS95n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57965267B85
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942639; cv=none; b=Jf8zrQGXPw0jYvJ/PaV67nnX/BgQhh83+S6r3e20rENHZQ0mVsqO5osv5Xew/ioogW9WLTdNYyO9GaTTvPav66+IXsmLjClhqfJxqZbahicclbjKoKUkGvX7YJ5hA/nHf2ntEEyDWSKg8qStDchG/Kx5poEgvoTfbA0S1Uc7nQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942639; c=relaxed/simple;
	bh=4q7GscTnySXqttsVM0VOs66z8TkTCLkmxK90LqMsTVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJSw5OIXSleWPDiBxwBdlDfEbucVe+snnT4zIVKxZeaa0G//B7AiooOI46SPRs42Rv5KgsUoUfCZIqvIsxgiopCt+wdLhN8BBVOT12MEcXJHD815gnv1UniPE9EosP6VAJdnnsiKXsYp0zsnmjTCb6m/isf0U8W+2pcpsRSbiSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSCZS95n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE89C4CEEA;
	Fri, 18 Apr 2025 02:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942637;
	bh=4q7GscTnySXqttsVM0VOs66z8TkTCLkmxK90LqMsTVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JSCZS95ntlIoiWIwvF128/nnpKthCvevOcfHv5QuK50jSZI1faPW8kit2zjRioMnT
	 7kWEWCTdcgD2bec7JK12XArt2HRQhCvY2MCBlogFs/oiK5JGU1sMlWy/KtfdNiPrgp
	 zCTBnJaiYKMgADiw5ypgvnk2ywFzVfzNjA/m75UiGpEbf8ccXykPueRGRa5aufM1uq
	 TT4rLy81n5Wachtt8h1jrLvFC7uBt7ML98giKa1y+4fo2O/c+QMNH4RcLjI4GwdD01
	 H9AZJ5S5Vm8b4aiqbmOK5goaiYNuC143T3hqjkCRzF8VN8UxOlI9JbQxqItQ6NX5CV
	 YVVinEL3XFIiA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 03/12] netlink: specs: rt-link: remove if-netnsid from attr list
Date: Thu, 17 Apr 2025 19:16:57 -0700
Message-ID: <20250418021706.1967583-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418021706.1967583-1-kuba@kernel.org>
References: <20250418021706.1967583-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

if-netnsid an alias to target-netnsid:

  IFLA_TARGET_NETNSID = IFLA_IF_NETNSID, /* new alias */

We don't have a definition for this attr.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-link.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index cb7bacbd3d95..7f411e8cd755 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -2460,7 +2460,6 @@ protonum: 0
             - xdp
             - event
             - new-netnsid
-            - if-netnsid
             - target-netnsid
             - carrier-up-count
             - carrier-down-count
-- 
2.49.0


