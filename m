Return-Path: <netdev+bounces-204714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4253AFBDD5
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0286C3BB6C1
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155CB220F2C;
	Mon,  7 Jul 2025 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9mk9Id3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B9D1BF37
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924910; cv=none; b=RKjJLmCw82XDhAs6qUVjIuhPVJC7r+HMdZ7r/5zG5ugRns0zvY92s4aVJ8yYg93nYbQAk6df0m1TDy+CCNTDeItPaPHgbYkJEH4RtF1yPDb357kmWfckQRde88UJs/DS/OQpHRycTP40xZGVzsXlrRs9VKqefYVNKUrx3LLgM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924910; c=relaxed/simple;
	bh=AYvYI4t0voEToB5Cygwxm1DHXe48X6tenkA6FMtOrLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mb9niBtx/LnjkSSmL9oBsAr3xR+SXl+ns/BhP6Rar8VEjcAitxPetCQqnYDHE4KtqoG1074CIdZfplS+NB3UyF8MsmvDYz1/TexDeNcE0fjEbtWdbHlr3cnPdyowyQv29HwwXEn92+ajgEQKOrc7IvjSUog9RSkZhJ+94Y1vHFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9mk9Id3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB0EC4CEE3;
	Mon,  7 Jul 2025 21:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751924909;
	bh=AYvYI4t0voEToB5Cygwxm1DHXe48X6tenkA6FMtOrLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c9mk9Id32GttP5XmxsBn93dK89H/7SttS0ijR025oIeNiILxMy/GTgC+NGKyubNch
	 iNtcQhYXUT5Pu7v8gFDpP/AjsBLCWOPGD7o3qrmvwYDhlJlJc/mib+f3X2gqnaM3pn
	 MSKaLPSIwyp+LmSuTniN6tDgTbgmzh8m/D2BhQCWCRHPHtKxuLn5943xdPOYUJMAzM
	 WAcDPadXXiaoCjztBYJ1WtshBobP5ULsnVRh4SDbQen8TFaHSEnibrmptjyNl5jy25
	 TyIbABUuJctiaptEnLjaJy6HB4ReXtAwFfkQayYTzClMbZxKk6tpZpeWcB/eWfkdpm
	 vCdRZrHE089cA==
Date: Mon, 7 Jul 2025 14:48:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Donald Hunter <donald.hunter@gmail.com>, Antonio Quartulli
 <antonio@openvpn.net>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ralf Lici <ralf@mandelbit.com>
Subject: Re: [PATCH net 2/3] ovpn: explicitly reject netlink attr
 PEER_LOCAL_PORT in CMD_PEER_NEW/SET
Message-ID: <20250707144828.75f33945@kernel.org>
In-Reply-To: <aGaApy-muPmgfGtR@krikkit>
References: <20250703114513.18071-1-antonio@openvpn.net>
	<20250703114513.18071-3-antonio@openvpn.net>
	<aGaApy-muPmgfGtR@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 15:07:51 +0200 Sabrina Dubroca wrote:
> > The OVPN_A_PEER_LOCAL_PORT is designed to be a read-only attribute
> > that ovpn sends back to userspace to show the local port being used
> > to talk to that specific peer.  
> 
> Seems like we'd want NLA_REJECT in the nla_policy instead of
> NLA_POLICY_MIN, but my quick grepping in ynl and specs doesn't show
> anything like that. Donald/Jakub, does it already exist? If not, does
> it seem possible to extend the specs and ynl with something like:
> 
> name: local-port
> type: reject(u16)
> 
> or maybe:
> 
> name: local-port
> type: u16
> checks:
>   reject: true

There's no way to explicitly reject, because we expect that only what's
needed will be listed (IOW we depend on NLA_UNSPEC rather than
NLA_REJECT). It gets complicated at times but I think it should work
here. Key mechanism is to define subsets of the nests:

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index 17e5e9b7f5a5..15309201e7ca 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -160,6 +160,36 @@ doc: Netlink protocol to control OpenVPN network devices
         name: link-tx-packets
         type: uint
         doc: Number of packets transmitted at the transport level
+  -
+    name: peer-input
+    subset-of: peer
+    attributes:
+      -
+        name: id
+      -
+        name: remote-ipv4
+      -
+        name: remote-ipv6
+      -
+        name: remote-ipv6-scope-id
+      -
+        name: remote-port
+      -
+        name: socket
+      -
+        name: socket-netnsid
+      -
+        name: vpn-ipv4
+      -
+        name: vpn-ipv6
+      -
+        name: local-ipv4
+      -
+        name: local-ipv6
+      -
+        name: keepalive-interval
+      -
+        name: keepalive-timeout
   -
     name: keyconf
     attributes:
@@ -235,12 +265,21 @@ doc: Netlink protocol to control OpenVPN network devices
         type: nest
         doc: Peer specific cipher configuration
         nested-attributes: keyconf
+  -
+    name: ovpn-peer-input
+    subset-of: ovpn
+    attributes:
+      -
+        name: ifindex
+      -
+        name: peer
+        nested-attributes: peer-input
 
 operations:
   list:
     -
       name: peer-new
-      attribute-set: ovpn
+      attribute-set: ovpn-peer-input
       flags: [admin-perm]
       doc: Add a remote peer
       do:
@@ -252,7 +291,7 @@ doc: Netlink protocol to control OpenVPN network devices
             - peer
     -
       name: peer-set
-      attribute-set: ovpn
+      attribute-set: ovpn-peer-input
       flags: [admin-perm]
       doc: modify a remote peer
       do:

