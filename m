Return-Path: <netdev+bounces-227897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3777ABBCBF0
	for <lists+netdev@lfdr.de>; Sun, 05 Oct 2025 22:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C123B8184
	for <lists+netdev@lfdr.de>; Sun,  5 Oct 2025 20:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5318E1C9DE5;
	Sun,  5 Oct 2025 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrPGqShQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF5A15278E;
	Sun,  5 Oct 2025 20:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759697402; cv=none; b=I+aDe/7D2I1U+UtuNHbRFMHVWQOk5TpwpUifRkIog/ivmYeSeMCymrgmf1rWPNL8kUlnmooxzPlRi+Ph8t7uuV8rEFol80rs/dncIN8xr986Yyd85VhCHFk+6I9o/TX52+IM8HMK3EVwtr8SylTK+MabxRAOPpZEAdduZJ5ldqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759697402; c=relaxed/simple;
	bh=ii/b/N0pyaKHk1vR0CgpnUKy0VbgXf4hwNRuqSJlj8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WWxiyNONDEd0RSFYiR1sly+nWXFeIbq7sJ5E7F639nyL+Ljrlzoh5pcn0CodFjn4XZDdAORPR07XBr/DmRaJ+iXQx64YV+jYP3Omrj5DhAjKya9jxBcK9AwKcDNupkzpZFspkbdzzfcAHj7Hb08x927GVd8/KXGqINZMoAnulc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrPGqShQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1DA6C4CEF4;
	Sun,  5 Oct 2025 20:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759697401;
	bh=ii/b/N0pyaKHk1vR0CgpnUKy0VbgXf4hwNRuqSJlj8k=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=YrPGqShQyIqIxWRotBBTBsaF0+YwklAl8UeQU+MhX8e/a9/SAeot5jtYuBhoC90Fy
	 JD6L/OZYj+pXhoI4fBGrUwyVzs38jXnVVqtcuNYcNmG2jfWowKEkXHmGKJ/ObBq3yT
	 lpnJez2Z12AFItnBw+qurdWs/wxqB+7YAW/c2tGN5Q7T33PsP4WgEi8zjStVOXVikE
	 F0fCDTc6sKkx8wqGhybsTUeMAytIn1jPJMIXqMgky/b8KGN+dAluEd0MXdfsx2g0e0
	 wGIlVl1yiba6I3bRqJxt175Ruxx2DL9USwNYgmpXpE50pTvtzhNDrsLgOsCJUFinfu
	 UFobtrTTlgpFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A841CCAC5BB;
	Sun,  5 Oct 2025 20:50:01 +0000 (UTC)
From: Dmitry Z via B4 Relay <devnull+demetriousz.proton.me@kernel.org>
Date: Sun, 05 Oct 2025 20:49:55 +0000
Subject: [PATCH net-next] net: ipv6: respect route prfsrc and fill empty
 saddr before ECMP hash
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-ipv6-set-saddr-to-prefsrc-before-hash-to-stabilize-ecmp-v1-1-d43b6ef00035@proton.me>
X-B4-Tracking: v=1; b=H4sIAPLZ4mgC/x2N0QqDMAxFf0XyvEAVLWy/MvYQ27gGNluSImPiv
 6/u8Vw49+xgrMIGt24H5U1M8tqgv3QQEq1PRomNYXDD1Ds3oZTNo3FFoxgVa8aivJgGnHnJypj
 I0jlbpVle8mXk8C7oox89h6unMEJ7Py35/Mv3x3H8AMKaMEqJAAAA
X-Change-ID: 20251005-ipv6-set-saddr-to-prefsrc-before-hash-to-stabilize-ecmp-6d646ec96ac4
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Z <demetriousz@proton.me>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759697400; l=2514;
 i=demetriousz@proton.me; s=20251005; h=from:subject:message-id;
 bh=Q5DqKSargyVXQTeREzV5I/pr1+JM/qzQfXDb4tGgDBk=;
 b=ihGZGTTzr9NFIqg3X4sSMWINglKgJwkN3Pvt9E+HJQHj8nPqg8IAWN/fGi+N9VJkCwkOLqlP2
 IsmNoEOBUaZD3yPBTcdARNtX9LXiA/+tgeXAOmtowrjE4A9KdBPbzfj
X-Developer-Key: i=demetriousz@proton.me; a=ed25519;
 pk=nWboVZwVR0spU+aAye5eVMrueLsmKdku1q3+u6mbJew=
X-Endpoint-Received: by B4 Relay for demetriousz@proton.me/20251005 with
 auth_id=537
X-Original-From: Dmitry Z <demetriousz@proton.me>
Reply-To: demetriousz@proton.me

From: Dmitry Z <demetriousz@proton.me>

In an IPv6 ECMP scenario, if a multi-homed host initiates a connection,
`saddr` may remain empty during the initial call to `rt6_multipath_hash()`.
It gets filled later, once the outgoing interface (OIF) is determined and
`ipv6_dev_get_saddr()` (RFC 6724) selects the proper source address.

In some cases, this can cause the flow to switch paths: the first packets
go via one link, while the rest of the flow is routed over another.

A practical example is a Git-over-SSH session. When running `git fetch`,
the initial control traffic uses TOS 0x48, but data transfer switches to
TOS 0x20. This triggers a new hash computation, and at that time `saddr`
is already populated. As a result, packets with TOS 0x20 may be sent via
a different OIF, because `rt6_multipath_hash()` now produces a different
result.

This issue can happen even if the matched IPv6 route specifies a `src`
(preferred source) address. The actual impact depends on the network
topology. In my setup, the flow was redirected to a different switch and
reached another host, leading to TCP RSTs from the host where the session
was never established.

Possible workarounds:
1. Use netfilter to normalize the DSCP field before route lookup.
   (breaks DSCP/TOS assignment set by the socket)
2. Exclude the source address from the ECMP hash via sysctl knobs.
   (excludes an important part from hash computation)

This patch uses the `fib6_prefsrc.addr` value from the selected route to
populate `saddr` before ECMP hash computation, ensuring consistent path
selection across the flow.

Signed-off-by: Dmitry Z <demetriousz@proton.me>
---
 net/ipv6/route.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 3299cfa12e21c96ecb5c4dea5f305d5f7ce16084..d2ecf16417a6f0fc6956f0ebff3d8dea593da059 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2270,6 +2270,11 @@ struct rt6_info *ip6_pol_route(struct net *net, struct fib6_table *table,
 	if (res.f6i == net->ipv6.fib6_null_entry)
 		goto out;
 
+	if (ipv6_addr_any(&fl6->saddr) &&
+	    !ipv6_addr_any(&res.f6i->fib6_prefsrc.addr)) {
+		fl6->saddr = res.f6i->fib6_prefsrc.addr;
+	}
+
 	fib6_select_path(net, &res, fl6, oif, false, skb, strict);
 
 	/*Search through exception table */

---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20251005-ipv6-set-saddr-to-prefsrc-before-hash-to-stabilize-ecmp-6d646ec96ac4

Best regards,
-- 
Dmitry Z <demetriousz@proton.me>



