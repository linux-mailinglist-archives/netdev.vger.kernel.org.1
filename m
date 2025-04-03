Return-Path: <netdev+bounces-178950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC23A799C2
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 03:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130663AC00D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E709113D531;
	Thu,  3 Apr 2025 01:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZmXMuOQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38BE13AA2D
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 01:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743644242; cv=none; b=ZzklCPf3q8CqPMsohFWVSufDdkvr4WE1B4r9fn6cTapXOurKNkN0/yRy+4GTpluvjZEJ9bxDaFq9bzs6ZOx3v7N1ZtWV+wWCX0T3l+gBUR2rc7EiQMcGPsoiLabV2cwzFKz5+i55IS4KlR+h4jAhen2eTxH72Tw8NvXexxvFMwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743644242; c=relaxed/simple;
	bh=g0QopiSPhA8DWJv4rtbKskhDsY4FcA8NJnDPzUNwDfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9yxK1da29RyNyObabtKXwnY2SIpWFstb8GeY/9f6HTdsxIcQUvEON+9DZyOFnrn7dv4GCQ+miZRiVUy/KQ0sT3TnUzY/YuYK9a7eUyUhubLfwuspwFOcUmRAotwW3P5p+2lC9+YVyeDLXUV1Xjk+/vNyrH0kEnwsQmKHoOBPVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZmXMuOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D88C4CEEB;
	Thu,  3 Apr 2025 01:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743644242;
	bh=g0QopiSPhA8DWJv4rtbKskhDsY4FcA8NJnDPzUNwDfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZmXMuOQaL1XROfo1ya11WVfCG4KD5YCndZY5cki1RNlHkxfHzt1bN9N3rsKoN56D
	 0STZ6FoMGgwV+q6o9RcdmLT+R23QOqbmYGXz9KXkzZBpjp8QhWNUkiHoh5fhaB9pIS
	 RZFm7uZq5dFI+FhBmlsEfuK227qQmzTJ4IusJdaj8N1qmvWjqHbd5Bz7xMwZgBRIOj
	 LKcjC7k2ZacwE57Iq95uxWMdTXUbw9OtLYTQRrYLSchU5oCAOjL6zlO3d2KQfu3gr5
	 JLjwTK/xHU0FU/xpW4klTupi/HP96q6EyohFYJ8B4MWxghyXUTBnYpJ3YnF/VhPkpO
	 Y63R9JY/yBZUQ==
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
Subject: [PATCH net v3 1/4] netlink: specs: rt_addr: fix the spec format / schema failures
Date: Wed,  2 Apr 2025 18:37:03 -0700
Message-ID: <20250403013706.2828322-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403013706.2828322-1-kuba@kernel.org>
References: <20250403013706.2828322-1-kuba@kernel.org>
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

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
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


