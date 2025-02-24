Return-Path: <netdev+bounces-169062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE8AA426B5
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E8D1883A77
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4932D24EF7C;
	Mon, 24 Feb 2025 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Q80XyUR3"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF1424EF60
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411578; cv=none; b=Rs6+kP7mJc01VlTyTktVIOFrLDlDD0rWgeX/XDGbcb/Yuthx+ZKtHMMqQovk8DLalilFyd3Amchez5Xa84Sl9nmnA2yGudvvjddUAghPnV+TmnTbu7iwHI9kAtUNpV4NRGQLJsfAvb/C7QTePvm98l3lzF6bWlUCoGUd4T2E2cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411578; c=relaxed/simple;
	bh=gaYFeWTvczsm9MvsWKI5N0WEcsESizB7deR/ULKyjJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6kSw4El/cDNmByFnkmeycQD7e/V6FIyLBjjywbL730Lr4M/PexyNeOeVuzJwljlk45NGQaQXuQQd3j0Vvy3Mzi7jxrYvRtzfydyY7hxrIefYjGozBr77DAtLKU0yKCo7zPjyIGF8ki1+dJ8cRajV26PHnztAmeErxrPzr80HN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Q80XyUR3; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uBBcQYwDiT4tVInZH9UKePcl/hGJD4iRjsioBTZGro4=; b=Q80XyUR3zL6rjXkYDQ6MsGU6e1
	vNtwptStwW9B3XoiKv5MLxcVbignMRzdjR7JHBtqLqT15OywMj+OmCkbriwJVBTt/JSGl5do6howi
	51WxbT/9fXrhoe5ZVYMkxo3fGdMwsxEbSTQH2QPXV3JOTZ747KhI79YC3oyNUCQhw0hr/ziRhbP0L
	rKSfL7rbrQ5oLevm5u5+qD5art3l7T4/Nhdkrc1FCt6GPU4g9f8/Ih6eDBIO5NJFZrb7HaxuWZQ9v
	vMJDqcZzwdzjdNwc0vlcMrfmvnaytN7rriJHpXjf5fb90wGxKSqiNFUUi/qDcvm6TSdmblXXc0i29
	VTHt/NGQ==;
Received: from 44.249.197.178.dynamic.cust.swisscom.net ([178.197.249.44] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tmaYK-000PL5-21;
	Mon, 24 Feb 2025 16:39:28 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/2] geneve, specs: Add port range to rt_link specification
Date: Mon, 24 Feb 2025 16:39:27 +0100
Message-ID: <20250224153927.50684-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224153927.50684-1-daniel@iogearbox.net>
References: <20250224153927.50684-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27559/Mon Feb 24 10:44:14 2025)

Add the port range to rt_link, example:

  # tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
    --do getlink --json '{"ifname": "geneve1"}' --output-json | jq
  {
    "ifname": "geneve1",
    [...]
    "linkinfo": {
      "kind": "geneve",
      "data": {
        "id": 1000,
        "remote": "147.28.227.100",
        "udp-csum": 0,
        "ttl": 0,
        "tos": 0,
        "label": 0,
        "df": 0,
        "port": 49431,
        "udp-zero-csum6-rx": 1,
        "ttl-inherit": 0,
        "port-range": {
          "low": 4000,
          "high": 5000
        }
      }
    },
    [...]
  }

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 Documentation/netlink/specs/rt_link.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 0d492500c7e5..de07c8ba2df4 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -770,6 +770,16 @@ definitions:
       -
         name: to
         type: u32
+  -
+    name: ifla-geneve-port-range
+    type: struct
+    members:
+      -
+        name: low
+        type: u16
+      -
+        name: high
+        type: u16
   -
     name: ifla-vf-mac
     type: struct
@@ -1915,6 +1925,10 @@ attribute-sets:
       -
         name: inner-proto-inherit
         type: flag
+      -
+        name: port-range
+        type: binary
+        struct: ifla-geneve-port-range
   -
     name: linkinfo-iptun-attrs
     name-prefix: ifla-iptun-
-- 
2.43.0


