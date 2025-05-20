Return-Path: <netdev+bounces-191964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F5FABE07A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25A997B7D4D
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC42927FB04;
	Tue, 20 May 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGTd6G9b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EBF27F194
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757970; cv=none; b=YIoMQvMPDCmRduHZl0mHUPirbwmpqFc66ftccOSw+JJjvvrpgPVVSsx62PewZNSyhb9ugqgUhh67Hl84HA7yO9wW/ASnQKjAspm3mkq/kjOg7HA3q17KqScSAXg1fSo6UkbJ1lmKpIXw8ZzEq0vL7S3XiqIMr2/m0sUr/6hBIQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757970; c=relaxed/simple;
	bh=RKDsQHAXpTkIBql6Vo4j+FeWblVRcMZeVz45R3aMlJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdtI1Mi9f3ujiMnUPo1s5wyGPY14bewRbGzHUHOywYfInY06dVgTvcfNzjsDzD8kz01WcKOffXECr7mdBHt6mslp9lwozxp1ug5fvEJ1gVuv/wQINBnjCJXFjuKqNnlC6JVOsT6FoEiSdqmnr7KeZrIIE9zED84g6OjWuAd+9is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGTd6G9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23D4C4CEE9;
	Tue, 20 May 2025 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747757970;
	bh=RKDsQHAXpTkIBql6Vo4j+FeWblVRcMZeVz45R3aMlJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGTd6G9b0pjtiFHyCUhHPVLyx9sO5DsRG7BzViMTWbk3yqre73xJQP7b6pS4taFDH
	 01D+qbmBQ7eNkjzJIe7DpKwLf4p4porJ6SkcYMvFwfdaleQztUTSgQe/r1ALB+DbRq
	 XrvalRaeGiIM9xaEAS8DNl4YqlsxN0WBPOsCXdgu849/DGZrxur3NWgdwYNMlGhQkU
	 DbPMGE2IBlE+/6ImBv0aGD+X6pMMlqJtw9TVDcqnBaPzXaw+3q5+2Z9tPodRWIK9eQ
	 yLhG0hMYDht1JIEJK+sgBKn4n8dyu/LHJMvGmjvkbsZn1kvqebgEOYaoRyTdee3+KW
	 9dxnLXLv/cqJg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	jstancek@redhat.com,
	kory.maincent@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 11/12] netlink: specs: tc: add qdisc dump to TC spec
Date: Tue, 20 May 2025 09:19:15 -0700
Message-ID: <20250520161916.413298-12-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520161916.413298-1-kuba@kernel.org>
References: <20250520161916.413298-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hook TC qdisc dump in the TC qdisc get, it only supported doit
until now and dumping will be used by the sample code.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/tc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 6e8db7adde3c..cb7ea7d62e56 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -3929,7 +3929,7 @@ protonum: 0
       doc: Get / dump tc qdisc information.
       attribute-set: attrs
       fixed-header: tcmsg
-      do:
+      do: &getqdisc-do
         request:
           value: 38
           attributes:
@@ -3948,6 +3948,7 @@ protonum: 0
             - chain
             - ingress-block
             - egress-block
+      dump: *getqdisc-do
     -
       name: newtclass
       doc: Get / dump tc traffic class information.
-- 
2.49.0


