Return-Path: <netdev+bounces-145101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 919C29C962B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 00:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29172B22951
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA291B652B;
	Thu, 14 Nov 2024 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="EHexBvrz"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE331B3926;
	Thu, 14 Nov 2024 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627213; cv=none; b=CVWBUtvAG401ikW2Lb9BUJh+1xJa5kDF4S8C54kya+2GLDQKmvC93Lo/4rRQZjKBU/A8n9/7SBhCvtHg9lPUYPbB8zOp2DIWU5J1jmMbfUdV09wLwzxuZPjnx39aNroLgZutbqmYKjXtd11VQ1McW1mOTNBWg8iDBdnzbWK4L7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627213; c=relaxed/simple;
	bh=pcSF3r0Xnb8b++okrlCE3Ouh7HXBN/stkb1R5yymVug=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CXBxgVi10YJYQUOlAzYj3lKdoKt9DjtddiNm9rnf4AByswHTdySrYMsbOYjhiIFAC++SCX8zb/wV1kryu2crVsZE2ninc3Ay07dSdwPQGk2/G1deTrXbBVK+f+dvy5FlYxbOgvtXFx33nvC1Rw5nRqwqDIJmZsHK1FpEptyP7MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=EHexBvrz; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tBjKm-0066Ok-9w; Fri, 15 Nov 2024 00:33:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=gGT1nK2qyfbvCaMiTzhiUzJdb1/qiwY28p26tECcJ2g=
	; b=EHexBvrzYDqmXWDBXznjbqKWY/LSEM6PdQYPmoN6+/7VsGGfAZmqGlSAOq+3FpX0Qwwb1ESNh
	6yrQpilhPygreFau9eET0FFkX3ps94lRqwnpa/KRVPBqAdjzT586u47r3jDy2f+Heywr5+F0ZvabN
	Vb6zw66Uz+iDaH2SL9Q+hWO5R+S8weoVPx3HenKwBY5gYdYnh4xG9aACD8TVI/JIEZ/Saezd+y0yh
	atRun9WkQIU3cPTNRhBOgxPF3QgModDEQBLiaT0opBDbUxLUhP5h3N+IQGNiwROGAsoHRqlxpDyzc
	04v4B1Yl1MjpDnflRDsah/IdwQxz6iDewWtB1Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tBjKe-0005m5-1O; Fri, 15 Nov 2024 00:33:01 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tBjKO-008nXm-U2; Fri, 15 Nov 2024 00:32:44 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net 0/4] net: Fix some callers of copy_from_sockptr()
Date: Fri, 15 Nov 2024 00:27:23 +0100
Message-Id: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFuHNmcC/x3LwQqDMAyA4VeRnBcwrgfrq8gOocs0CG1pZExK3
 92y48fPX8GkqBgsQ4UiXzVNsYMeA4Sd4yao726YxskRkUNL4chnwZDyhR/9ieHTey/MMzET9DE
 X+Yf+rRDlhFdrN+n9RJNpAAAA
X-Change-ID: 20241114-sockptr-copy-fixes-3999eaa81aa1
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Some callers misinterpret copy_from_sockptr()'s return value. The function
follows copy_from_user(), i.e. returns 0 for success, or the number of
bytes not copied on error. Simply returning the result in a non-zero case
isn't usually what was intended.

Compile tested with CONFIG_LLC, CONFIG_AF_RXRPC, CONFIG_BT enabled.

Last patch probably belongs more to net-next, if any. Here as a RFC.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (4):
      bluetooth: Improve setsockopt() handling of malformed user input
      llc: Improve setsockopt() handling of malformed user input
      rxrpc: Improve setsockopt() handling of malformed user input
      net: Comment copy_from_sockptr() explaining its behaviour

 include/linux/sockptr.h           |  2 ++
 include/net/bluetooth/bluetooth.h |  9 ---------
 net/bluetooth/hci_sock.c          | 14 +++++++-------
 net/bluetooth/iso.c               | 10 +++++-----
 net/bluetooth/l2cap_sock.c        | 20 +++++++++++---------
 net/bluetooth/rfcomm/sock.c       |  9 ++++-----
 net/bluetooth/sco.c               | 11 ++++++-----
 net/llc/af_llc.c                  | 15 ++++++++-------
 net/rxrpc/af_rxrpc.c              |  8 ++++----
 9 files changed, 47 insertions(+), 51 deletions(-)
---
base-commit: cfaaa7d010d1fc58f9717fcc8591201e741d2d49
change-id: 20241114-sockptr-copy-fixes-3999eaa81aa1

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


