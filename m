Return-Path: <netdev+bounces-203720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9F5AF6E3B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FEC3B2569
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3869E2D3A63;
	Thu,  3 Jul 2025 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="NG7MA683"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9B42D0C88
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533931; cv=none; b=pk6ilgWp6U6fyZvnKHEmrF6Z0mkRQU+GA8LInclzKqfjIlPbJTS/qJ70Hn/37jF/YAGhhxTEcUR6mp3Rb5zlDgXHsBeWCoRGwjTTvyD2iFkJDkK2rkoASV773Fspwwa8KAdyWQ0cb12OPzW6CuExcwOPXhXBFMArYyf47/mC3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533931; c=relaxed/simple;
	bh=blCu2+3QJ83kDKgRcgp1vZ53G1j7devUtkoFRCbS5a0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JlrkK0NQRJDG4FIXytYxW3Oi4H3buXyqxF8wuVajMoy6dFWPEsaxxftK6GHLYI0nql8bYkNsvW/38uCWoWdtTQBtFQbjJaD8SjTmz/1vmkTqur9QrJqJ+nNPIc89eQjQLtlhYt98R4vXO94SU4quhAoItxUtO+XUw2TFg7MujWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=NG7MA683; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751533921;
	bh=PxQyGqdPaYJ5cnTK+mddIENGAyjoJmCx1oksBhQXT/Q=;
	h=From:Subject:Date:To:Cc;
	b=NG7MA683zc+9FhCaqYOC3AvFaPZK86wLoIOA/U6ojZNEt0k3+kRNQITcQgUUTvyUm
	 Aoul5aRhg/4GA07G1ZFeNJq+0KgRN8Qu8Bpqi2WcqJISpVR+Ei0dvJHc7zN/j/Ri4J
	 szCdLq/SjIpDFlgxHdayJUXtBTtb5P1pqOsefuulhdcJVz0NQul/+wl7/2QA1vyLtQ
	 3DoXxhBRcuTZqDPyk7t5gKZl9rt2tgWxZPR7bu3eFmCWTvX/SkXbqVzOd439/ZSsqu
	 HiIm27cc6tlgLgFyyX9TyS/h2bt3B68y1DEm1qPk16/8OXIH10MqrhnrZBMDrVPT3D
	 QBPcHPkO/61lw==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 405876A8D5; Thu,  3 Jul 2025 17:12:01 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Subject: [PATCH net-next 0/7] net: mctp: Improved bind handling
Date: Thu, 03 Jul 2025 17:11:47 +0800
Message-Id: <20250703-mctp-bind-v1-0-bb7e97c24613@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFNJZmgC/x3MTQqAIBBA4avErBtQo9+rRIvKsWbRFCohRHdPW
 n7weA8E8kwBhuIBTzcHPiVDlwWs+ywbIdtsMMrUqjIajzVeuLBYpLbtm87pTjkLub88OU7/awS
 hiEIpwvS+H/BiQl9lAAAA
X-Change-ID: 20250321-mctp-bind-e77968f180fd
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751533920; l=2111;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=blCu2+3QJ83kDKgRcgp1vZ53G1j7devUtkoFRCbS5a0=;
 b=r425MAPILpIcflOfcovVwce+XzPl9IRSo5ZmlNQ8/NH7cp9oagdxQwv8t9S+2VmXCzClLw2Je
 Y4W7PpqIaYNA5Hfm1w7T4dfUxsGjrMSbvix+6WSyITiJXNGFjgmr3MA
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

This series improves a couple of aspects of MCTP bind() handling.

MCTP wasn't checking whether the same MCTP type was bound by multiple
sockets. That would result in messages being received by an arbitrary
socket, which isn't useful behaviour. Instead it makes more sense to
have the duplicate binds fail, the same as other network protocols.
An exception is made for more-specific binds to particular MCTP
addresses.

It is also useful to be able to limit a bind to only receive incoming
request messages (MCTP TO bit set) from a specific peer+type, so that
individual processes can communicate with separate MCTP peers. One
example is PLDM firmware update responder, which will initiate
communication with a device, and then the device will connect back to the
responder process. 

These limited binds are implemented by a connect() call on the socket
prior to bind. connect() isn't used in the general case for MCTP, since
a plain send() wouldn't provide the required MCTP tag argument for
addressing.

route-test.c will have non-trivial conflicts with Jeremy's in-review
"net: mctp: Add support for gateway routing" series - I'll post an
updated series once that lands.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
Matt Johnston (7):
      net: mctp: Prevent duplicate binds
      net: mctp: Treat MCTP_NET_ANY specially in bind()
      net: mctp: Add test for conflicting bind()s
      net: mctp: Use hashtable for binds
      net: mctp: Allow limiting binds to a peer address
      net: mctp: Test conflicts of connect() with bind()
      net: mctp: Add bind lookup test

 include/net/mctp.h         |   5 +-
 include/net/netns/mctp.h   |  15 +-
 net/mctp/af_mctp.c         | 145 +++++++++++++++--
 net/mctp/route.c           |  80 ++++++++--
 net/mctp/test/route-test.c | 391 ++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 606 insertions(+), 30 deletions(-)
---
base-commit: 8b98f34ce1d8c520403362cb785231f9898eb3ff
change-id: 20250321-mctp-bind-e77968f180fd

Best regards,
-- 
Matt Johnston <matt@codeconstruct.com.au>


