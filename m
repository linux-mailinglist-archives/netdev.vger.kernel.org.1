Return-Path: <netdev+bounces-206024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60246B010FA
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D91517AE5D5
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEBE188907;
	Fri, 11 Jul 2025 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLFt61md"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFC31684AC
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 01:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752198823; cv=none; b=IlQVqQJChlrjEI1HHlfuQIMJSvHRJ0qXwxfbzzgd0Kg61eDDEzGEvtx9C2KbHL+2Ac11mXrNu9gt+WZJjDUY0VgR0ftOLviw5atgpkdxRKe12UiUnNsv+mRFyh/eABiuE9fEhb4zP/h7gc7Vqmz2dm+2SVrLyahjMd1Mdl8X9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752198823; c=relaxed/simple;
	bh=VX+YA+NIyzzBWGSTpbZ/i2lQMh6BfiFanH7ukGlxUJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PERAsLrBoaKMIXydi2jj8PHoHf2Wo7yVBnnxOsnSzaLCVh1waekkoVaL378asr8+NTEJDfKl6pE9eCLuCqR48RbpUQ1DE9bkEYORC9OT6oBFmwyZMZQwsb2kRA2kQHU4bw90LWDeLCmpmbYm+J7cegh4biHJxJRZAhtjIWyMueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLFt61md; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D9DC4CEF6;
	Fri, 11 Jul 2025 01:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752198822;
	bh=VX+YA+NIyzzBWGSTpbZ/i2lQMh6BfiFanH7ukGlxUJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dLFt61mdS4qtRwvyyWoWCWadLYgXmT1UUJLgwa3mFZG757/awSX/nFUElsswZgtqM
	 eHOFu9AjttVDwgfUq67tbPL5MjVgxqHsDNbOLnFLmk3CpFTcrLiQLur7iO0/4ZK3hz
	 ewJrZkl62exvNOSpqnOM9jt7z2JzQFTt7G57CsrvbvdNjOZuL7QvC6Htp3OP0sRMTT
	 UajQlR3dYFbPFFXQ6wK7GPVb7Ic17EUDd3uR6n+qH0jtIl3gMcD9Ss7QD0gdOSHOyL
	 Ay61J8Bi+USUH0l3CArkwGgJDl72HpG3v0YOXTvdnQaqZCUw6wAyJUtH+XMpW477TW
	 qEjvqZyhl6XrQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 08/11] netlink: specs: define input-xfrm enum in the spec
Date: Thu, 10 Jul 2025 18:53:00 -0700
Message-ID: <20250711015303.3688717-9-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250711015303.3688717-1-kuba@kernel.org>
References: <20250711015303.3688717-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Help YNL decode the values for input-xfrm by defining
the possible values in the spec. Don't define "no change"
as it's an IOCTL artifact with no use in Netlink.

With this change on mlx5 input-xfrm gets decoded:

 # ynl --family ethtool --dump rss-get
 [{'header': {'dev-index': 2, 'dev-name': 'eth0'},
   'hfunc': 1,
   'hkey': b'V\xa8\xf9\x9 ...',
   'indir': [0, 1, ... ],
   'input-xfrm': 'sym-or-xor',                         <<<
   'flow-hash': {'ah4': {'ip-dst', 'ip-src'},
                 'ah6': {'ip-dst', 'ip-src'},
                 'esp4': {'ip-dst', 'ip-src'},
                 'esp6': {'ip-dst', 'ip-src'},
                 'ip4': {'ip-dst', 'ip-src'},
                 'ip6': {'ip-dst', 'ip-src'},
                 'tcp4': {'l4-b-0-1', 'ip-dst', 'l4-b-2-3', 'ip-src'},
                 'tcp6': {'l4-b-0-1', 'ip-dst', 'l4-b-2-3', 'ip-src'},
                 'udp4': {'l4-b-0-1', 'ip-dst', 'l4-b-2-3', 'ip-src'},
                 'udp6': {'l4-b-0-1', 'ip-dst', 'l4-b-2-3', 'ip-src'}}
 }]

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index aa55fc9068e1..3a0453a92300 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -158,6 +158,28 @@ c-version-name: ethtool-genl-version
       -
         name: pse-event-sw-pw-control-error
         doc: PSE faced an error managing the power control from software
+  -
+    name: input-xfrm
+    doc: RSS hash function transformations.
+    type: enum
+    enum-name:
+    name-prefix: rxh-xfrm-
+    header: linux/ethtool.h
+    entries:
+      -
+        name: sym-xor
+        value: 1
+        doc: >-
+          XOR the corresponding source and destination fields of each specified
+          protocol. Both copies of the XOR'ed fields are fed into the RSS and
+          RXHASH calculation. Note that this XORing reduces the input set
+          entropy and could be exploited to reduce the RSS queue spread.
+      -
+        name: sym-or-xor
+        value: 2
+        doc: >-
+          Similar to SYM_XOR, except that one copy of the XOR'ed fields is
+          replaced by an OR of the same fields.
   -
     name: rxfh-fields
     name-prefix: rxh-
@@ -1621,6 +1643,7 @@ c-version-name: ethtool-genl-version
       -
         name: input-xfrm
         type: u32
+        enum: input-xfrm
       -
         name: start-context
         type: u32
-- 
2.50.1


