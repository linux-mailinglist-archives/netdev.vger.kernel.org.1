Return-Path: <netdev+bounces-111191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFFD930343
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 04:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF5A283671
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 02:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8641744C9B;
	Sat, 13 Jul 2024 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="kXGOWUI2"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84871DDF8;
	Sat, 13 Jul 2024 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720837167; cv=none; b=IGJaxlvqfrNZwR9ieFXNV5R9q+6TgGVZhDyc4OnfdtufiVtAxoNEoGTC3AB0VNlA/cq+gkEIWO8hNc+DklwzyQYsIw1wINNqkCIbKN7zXyWDQlHtO8BPFqWkfTE0859cM0xK457RozNUOqFGYBu8qX7cLE5aZa9lfQhbmflN28Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720837167; c=relaxed/simple;
	bh=llMUWHdeum9yJZfRx0fxi7KhtITZMOALBJSdilj0JYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rh7ClCJaFw7dm+ojW8SVLKRg4Xr9e5Jv1G0vuOFKf5V9wsbqBXcYvY2JpRi0XwfygNM1P6FlLjTbqERRMvSGS2usPwuYj5HMXlRIRNxNUrOCLkZgh88souguHaMcALcJvBu50nqUaxmUwZDsUJFULaisRrOF6tWKyJ3EJ+a6JP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=kXGOWUI2; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720837159;
	bh=llMUWHdeum9yJZfRx0fxi7KhtITZMOALBJSdilj0JYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kXGOWUI2M4r97F+GTo4ys14A8Jy/iW12f10T6UdOtZC8x5gLEEzabZE9BmCtkwoxu
	 qZQHiQLcMTSDcXWK4zG8Wb1DbEFBOxIYB7o4ZIsvFAvkxyo6+76GAhQKEikVL4HUPq
	 0c09N9DSxLtRjXW9T5SfyaDAcAWbJeBUPTumdVRXs0COpnu3eMHiSco45ztG5OAbRq
	 jexlMk7exKwq+1D4KWBtbnlB3kUY4zTXoMHm1ply44gfhLi4hxGC3ihPiQlZSZYHdP
	 JLuMotTUGFjFEqBfAEX+WZ/EhG7/lkPDS2nb5yCEG5kV4nmeCetfgWzVSjKnACVdSr
	 ShZabB/ctq79Q==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8146760099;
	Sat, 13 Jul 2024 02:19:19 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 57DF2202266; Sat, 13 Jul 2024 02:19:11 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Davide Caratti <dcaratti@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 02/13] doc: netlink: specs: tc: describe flower control flags
Date: Sat, 13 Jul 2024 02:18:59 +0000
Message-ID: <20240713021911.1631517-3-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713021911.1631517-1-ast@fiberby.net>
References: <20240713021911.1631517-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Describe the flower control flags, and use them
for key-flags and key-flags-mask.

The flag names have been taken from iproute2.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/tc.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 8c01e4e131954..fbbc928647fa3 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -41,6 +41,12 @@ definitions:
       - in-hw
       - not-in-nw
       - verbose
+  -
+    name: tc-flower-key-ctrl-flags
+    type: flags
+    entries:
+      - frag
+      - firstfrag
   -
     name: tc-stats
     type: struct
@@ -2536,10 +2542,14 @@ attribute-sets:
         name: key-flags
         type: u32
         byte-order: big-endian
+        enum: tc-flower-key-ctrl-flags
+        enum-as-flags: true
       -
         name: key-flags-mask
         type: u32
         byte-order: big-endian
+        enum: tc-flower-key-ctrl-flags
+        enum-as-flags: true
       -
         name: key-icmpv4-code
         type: u8
-- 
2.45.2


