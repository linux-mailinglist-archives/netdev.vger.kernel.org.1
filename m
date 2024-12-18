Return-Path: <netdev+bounces-152800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9E89F5CF3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68A07A1F83
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644A0535DC;
	Wed, 18 Dec 2024 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrnSlbqZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F00C5695
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734489789; cv=none; b=i9ZNcKLuf/gxRch9qSVInkcFFbdhHTeNFv5sxFMq8SxSFGtsT6vLFEKBIccyBJd9d77+3KXq8Vbtyvh4cEctHn2KnrDs7M+DWdTD831W6wsjCVdviCL78jgl27CnJydxXNlgmEsyAHqyvaNfPZF6ur8mu7eCJ4zzkDzMu0Vh3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734489789; c=relaxed/simple;
	bh=O1Y5YWRtO75eFNmeKICVn+fxRjJYR4DOGSpPsjlwWbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tCZDQ5KhWGuMJVcaIohbrPR7VhqwEalQcGfonieu9cF3Ul0NKuZCS6WssY1oGJ2Wclq/cMygeXMkc3mMZ6gH4c+wk+97O3Ah6dYlrxC50MJqjBiUz4c3dOMvnMT6KOCeGxhPAax6dnHX2NWK0lpHIgT61PI4sj38nIk/qSlEwq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrnSlbqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597C4C4CED3;
	Wed, 18 Dec 2024 02:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734489788;
	bh=O1Y5YWRtO75eFNmeKICVn+fxRjJYR4DOGSpPsjlwWbk=;
	h=From:To:Cc:Subject:Date:From;
	b=WrnSlbqZSy+rHUrmxeIymzeamVh6GOepihRd5HvSir0OOC9ekyMb5korYfzvktisI
	 y+IvmZVX+kjPcbP6FFmVbZvzvz0vjDeXgclYtBUNzfFAmYI+QJ2Hd0GepXTAK0fOMA
	 oafv5DTtrfu5td0qjfnq/rFNeh4CvQ81D0DTPimjglwWP2SrIiCuTkJMbQnT1CeiRM
	 mZSFXv6R8nEg+aLZdrGDCbcx+tGkM7q3d+wekxJw5oEyvo5Bqxf+YEIvJ2JNg1o9aw
	 HpUkfgXHOTCaBuxkRuXxk6fVzmv6nvhae+l9HH9kiZwGyQnIIkCL27Zp10Lfca8vwL
	 xagRE/qPSSL/A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jdamato@fastly.com,
	almasrymina@google.com,
	sridhar.samudrala@intel.com,
	amritha.nambiar@intel.com
Subject: [PATCH net] netdev-genl: avoid empty messages in napi get
Date: Tue, 17 Dec 2024 18:43:05 -0800
Message-ID: <20241218024305.823683-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Empty netlink responses from do() are not correct (as opposed to
dump() where not dumping anything is perfectly fine).
We should return an error if the target object does not exist,
in this case if the netdev is down we "hide" the NAPI instances.

Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for napi")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jdamato@fastly.com
CC: almasrymina@google.com
CC: sridhar.samudrala@intel.com
CC: amritha.nambiar@intel.com
---
 net/core/netdev-genl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index b4becd4065d9..dfb2430a0fe3 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -238,6 +238,10 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 	napi = napi_by_id(napi_id);
 	if (napi) {
 		err = netdev_nl_napi_fill_one(rsp, napi, info);
+		if (!rsp->len) {
+			err = -ENOENT;
+			goto err_free_msg;
+		}
 	} else {
 		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID]);
 		err = -ENOENT;
-- 
2.47.1


