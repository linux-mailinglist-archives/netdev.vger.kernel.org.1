Return-Path: <netdev+bounces-53266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D48801D83
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 16:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4541CB20C94
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3156199D1;
	Sat,  2 Dec 2023 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="pc9d1gBB"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B80BB;
	Sat,  2 Dec 2023 07:41:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701531672; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=b07VKVp3Y6KFSvXCq5WtA/wgwkIQOH2fLg1vVgZoMkH3HaksMyW+xK7FyB7G7iVqTfeXjkXSeRqiz3seB36GTmulhDVkWA2JvV+b1BoCIaxe/myU36N/WxQQkcFP7oO+NaC2+xBu1n0o3qIfZUSd5gf6b11N2xMU7+1sFH/I1WI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1701531672; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8NY9bd//Bp+IVrU4lm9lUah8k6STVPOlOeGkQeycAEQ=; 
	b=NKsepZb6PWTkl3BMgX9JB7p3BDFRx6JmmMCJ3+57Zmn9vXAeIK/SC2qPbPW19UkIvwvD+6hsfMzApzELzOURnAdwE5cuKk7c7M9n+pM89TKcyBwMj0kTXDeXc0dMipx4AOwc86q7w8GarsP82H8jI56nGk7e5nq6CIoCZZS2zWs=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701531672;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8NY9bd//Bp+IVrU4lm9lUah8k6STVPOlOeGkQeycAEQ=;
	b=pc9d1gBBtKz3gEWE+aU6f8Cne2i7KvNB7gJFhomdsLE5nIeQXQz2j/KsNIBv9uVa
	pNCs/xQPAYwzTvEkIvShBN8VCHNdRfqM1wK1iwERTmHuFxUFjh0v6oecJLT9qdIDgNj
	QmCqlu5FRabYEpIik7tu4O6UeJg/JE/jjUfJaBWw=
Received: from kampyooter.. (122.170.35.155 [122.170.35.155]) by mx.zoho.in
	with SMTPS id 1701531670973749.3078715470447; Sat, 2 Dec 2023 21:11:10 +0530 (IST)
From: Siddh Raman Pant <code@siddh.me>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH net-next v2 0/2] nfc: Fix UAF during datagram sending caused by missing refcounting
Date: Sat,  2 Dec 2023 21:10:57 +0530
Message-ID: <cover.1701530776.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

For connectionless transmission, llcp_sock_sendmsg() codepath will
eventually call nfc_alloc_send_skb() which takes in an nfc_dev as
an argument for calculating the total size for skb allocation.

virtual_ncidev_close() codepath eventually releases socket by calling
nfc_llcp_socket_release() (which sets the sk->sk_state to LLCP_CLOSED)
and afterwards the nfc_dev will be eventually freed.

When an ndev gets freed, llcp_sock_sendmsg() will result in an
use-after-free as it

(1) doesn't have any checks in place for avoiding the datagram sending.

(2) calls nfc_llcp_send_ui_frame(), which also has a do-while loop
    which can race with freeing. This loop contains the call to
    nfc_alloc_send_skb() where we dereference the nfc_dev pointer.

nfc_dev is being freed because we do not hold a reference to it when
we hold a reference to llcp_local. Thus, virtual_ncidev_close()
eventually calls nfc_release() due to refcount going to 0.

Since state has to be LLCP_BOUND for datagram sending, we can bail out
early in llcp_sock_sendmsg().

Please review and let me know if any errors are there, and hopefully
this gets accepted.

Thanks,
Siddh

Changes in v2:
- Add net-next in patch subject.
- Removed unnecessary extra lock and hold nfc_dev ref when holding llcp_sock.
- Remove last formatting patch.
- Picked up r-b from Krzysztof for LLCP_BOUND patch.

Siddh Raman Pant (2):
  nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to
    llcp_local
  nfc: Do not send datagram if socket state isn't LLCP_BOUND

 net/nfc/llcp_core.c | 21 +++++++++++++++++++--
 net/nfc/llcp_sock.c |  5 +++++
 2 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.42.0

