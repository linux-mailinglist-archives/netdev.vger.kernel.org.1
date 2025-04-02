Return-Path: <netdev+bounces-178713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1C4A785FF
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 03:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B932116DE12
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 01:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4BFC8E0;
	Wed,  2 Apr 2025 01:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwxqSsMY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5D1B667
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 01:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743555783; cv=none; b=gUyoDF3pwuc0+t3b8RbiRbOA3VqJFj2eSPFfsmjmcQkE+KfcIG7NIR5hzDFGwjn/kL8BKXS8nbMpUVQhCigEVdPlX/ICUN76ew3sQdcOblomNcsG8KwkU39pwOC2YzaqRGgb/PfXT0Mw7la/HZFvjwpcUm08DUbi0zgglIPidwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743555783; c=relaxed/simple;
	bh=OMOL5bQFTGfWhFWFhUtxL2WmYlqfQjT39v3xfoUbjl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlxN/R6JNebJ1AP9HyKr8M501JLcD6zDeJvJCPazsQpM5FE2rGcuTFsnnw54YKYe/d3rVaNNpkn72tgs3oIP0Xons7l1s6Oswmu3QaqKF5NO3dbuX0L7BvFY2R7fw9kKXRbTh+jqeJHEPUrKnGvGAo2fqei/4zdmQtZ4ENca2bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwxqSsMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ED2C4CEE9;
	Wed,  2 Apr 2025 01:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743555783;
	bh=OMOL5bQFTGfWhFWFhUtxL2WmYlqfQjT39v3xfoUbjl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwxqSsMYVH9o68m1EmUmKNcNVVvcDHg/wFxndfPDiul7OweqChzvOIs2pHikQCITC
	 0+eIw4uuuUllpGueo4fmEpt4D4UPVQro7K2oFy+HK2Jf3k4ynAyehV8/DResqK57FM
	 u8vnfOIQA9vrrfYJL0vN5ZucxSgfjMHLgPIJynRDmqAqn/VcCtBi1tck+hF3Odas2Y
	 6yvHqmGyPj4pJX5wN3F/OwgXh1rMIQSUmsEBil3C0Iyfoy/m/m8RKshKUbFmJPo/xn
	 yF3AzjHS5gaFar3VaUgalaY7pcsTT1wX0pFy+bz/aV5vNs51cjNiBXze0lJVF1qRrJ
	 JfgTU4aFWUXGQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	yuyanghuang@google.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 1/3] netlink: specs: rt_addr: fix the spec format / schema failures
Date: Tue,  1 Apr 2025 18:02:58 -0700
Message-ID: <20250402010300.2399363-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402010300.2399363-1-kuba@kernel.org>
References: <20250402010300.2399363-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spec is mis-formatted, schema validation says:

  Failed validating 'type' in schema['properties']['operations']['properties']['list']['items']['properties']['dump']['properties']['request']['properties']['value']:
    {'minimum': 0, 'type': 'integer'}

  On instance['operations']['list'][3]['dump']['request']['value']:
    '58 - ifa-family'

The ifa-family clearly wants to be part of an attribute list.

Reviewed-by: Yuyang Huang <yuyanghuang@google.com>
Fixes: 4f280376e531 ("selftests/net: Add selftest for IPv4 RTM_GETMULTICAST support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: yuyanghuang@google.com
CC: jacob.e.keller@intel.com
---
 Documentation/netlink/specs/rt_addr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/netlink/specs/rt_addr.yaml
index 5dd5469044c7..3bc9b6f9087e 100644
--- a/Documentation/netlink/specs/rt_addr.yaml
+++ b/Documentation/netlink/specs/rt_addr.yaml
@@ -187,6 +187,7 @@ protonum: 0
       dump:
         request:
           value: 58
+          attributes:
             - ifa-family
         reply:
           value: 58
-- 
2.49.0


