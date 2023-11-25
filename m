Return-Path: <netdev+bounces-51069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406E77F8EA2
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 21:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5F11C20AD8
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 20:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF5C3066C;
	Sat, 25 Nov 2023 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="N4+oBPJm"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A02810D;
	Sat, 25 Nov 2023 12:27:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700943995; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=B8Iqj+BQjBKJDp9O1R0QQqjD2yLh/iboelD27OwSguFeSY0c8rxTET3w34hERF7MYR1XcSwk6Ei34s5zTan3kPEVrJ8wY+tHZU30w3Li3ND52cX0yBImJ772yztdzrs9JXtrxUyik+VDCBe3j8StdppzkYluPZWb8d3sW7HjIr8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1700943995; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8fzgFKnrdV1ajhUYFpyl+tyr4D7cXS4mqi6t0uH4pTI=; 
	b=feXXwkRk9R5Q8MUm53qVOFCPUWmPwiyeRSk9mIOduFl4dvyxPbMI7vCJvABiEPsdKg3orP+uFXilsfs5+62EEDx+Jmp3C9YJI4j2ajjZ+SNsCB+t/mQ33O8Vq0k2ClVZ+BJftdmC2PHlBwbpTRs1c6RUwJSh6aVpUHgMAIllvyE=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1700943995;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8fzgFKnrdV1ajhUYFpyl+tyr4D7cXS4mqi6t0uH4pTI=;
	b=N4+oBPJmzSAtLk9xTgZS6j2WuVO2RTQ6ZqEQXMCu0vEWKyWi4dL1aKtoeLyva4XU
	mSY/Lkm/VfJXefahoONSXcb9rWI+6i0W3mLOM+7ny3hTk6mq33MT08GUhu+FShdE/+z
	r0Z6WLRn3ecNaH4zn76F+Q4jZG1eSXySNwX8Wr+Y=
Received: from kampyooter.. (110.226.61.26 [110.226.61.26]) by mx.zoho.in
	with SMTPS id 1700943993929600.5063004964155; Sun, 26 Nov 2023 01:56:33 +0530 (IST)
From: Siddh Raman Pant <code@siddh.me>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Fix UAF caused by racing datagram sending and freeing of nfc_dev
Date: Sun, 26 Nov 2023 01:56:15 +0530
Message-ID: <cover.1700943019.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

(This patchset should be applied in order as changes are dependent.)

For connectionless transmission, llcp_sock_sendmsg() codepath will
eventually call nfc_alloc_send_skb() which takes in an nfc_dev as
an argument for calculating the total size for skb allocation.

virtual_ncidev_close() codepath eventually releases socket by calling
nfc_llcp_socket_release() (which sets the sk->sk_state to LLCP_CLOSED)
and afterwards the nfc_dev will be eventually freed.

When an ndev gets freed, llcp_sock_sendmsg() will result in an
use-after-free as it

(1) doesn't have any checks in place for avoiding the datagram sending.

(2) calls nfc_llcp_send_ui_frame(), which also has a do-while loop which
    can race with freeing (a msg with size of 4096 is sent in chunks of
    128 in this repro). This loop contains the call to nfc_alloc_send_skb().

Thus, I extracted nfc_dev access from nfc_alloc_send_skb() to the caller,
and used a spinlock (rwlock) to protect/serialize access to the nfc_dev to
avoid the UAF. Tested with syzkaller.

Since state has to be LLCP_BOUND for datagram sending, we can bail out early
in llcp_sock_sendmsg().

The last patch is just a code reformat. As the datagram sending is a bigger
chunk of the code, we can reduce unnecessary indentation.

Please review and let me know if any errors are there, and hopefully this
gets accepted.

Thanks,
Siddh

Siddh Raman Pant (4):
  nfc: Extract nfc_dev access from nfc_alloc_send_skb() into the callers
  nfc: Protect access to nfc_dev in an llcp_sock with a rwlock
  nfc: Do not send datagram if socket state isn't LLCP_BOUND
  nfc: llcp_sock_sendmsg: Reformat code to make the smaller block
    indented

 include/net/nfc/nfc.h   |  6 +++---
 net/nfc/core.c          | 14 +++++++-------
 net/nfc/llcp.h          |  1 +
 net/nfc/llcp_commands.c | 41 +++++++++++++++++++++++++++++++++++------
 net/nfc/llcp_core.c     | 31 +++++++++++++++++++------------
 net/nfc/llcp_sock.c     | 31 ++++++++++++++++++-------------
 net/nfc/rawsock.c       |  8 ++++++--
 7 files changed, 89 insertions(+), 43 deletions(-)

-- 
2.42.0


