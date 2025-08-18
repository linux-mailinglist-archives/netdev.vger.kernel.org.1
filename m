Return-Path: <netdev+bounces-214713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3399B2AFEB
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 20:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1CA62A7FBB
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F9425D533;
	Mon, 18 Aug 2025 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TR7pTsKC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C7A258ED7;
	Mon, 18 Aug 2025 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540245; cv=none; b=FuFx1IuF6BQqO4WiKOIeLYtp2WazFoPmlASQxdgkrmXwc92Q+fdzmPyYNp3q+e3hxpH1x8GFZa+fk0tadsqreSMutW+hA1nULDWeM77CWS1+MkAwK/yNyGuhDYe1W+Cx7JE3qLrSOAVfoY5hmQHr8XVA7KSvTaNpCQiaQjZvufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540245; c=relaxed/simple;
	bh=uh386kcAciOXGh7Qn4qCjKbKDm8DUQdvzybYZgQVinU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A71f4rMTJd6hklX++dROjOirBnt1pQCDs4gCRLI1+fJhrY/wXKFs8Cs4aPzH9qZNIROZdGHm6py+YZnUGxSx935wTgfXyeNCgwIABaUNf34vJqJ9eop6hHvTJkvbYiRmV3iCspO+qr68PrZ8et1S86HCEldJ1qnQTLvSJxEDan0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TR7pTsKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE81C4CEEB;
	Mon, 18 Aug 2025 18:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755540244;
	bh=uh386kcAciOXGh7Qn4qCjKbKDm8DUQdvzybYZgQVinU=;
	h=From:To:Cc:Subject:Date:From;
	b=TR7pTsKCNgQ+2AsLDRAyavDlal3rJmYGxuQWHQA1fzM4dx+fsJCU8xOoJM8WiAS0C
	 SqcFe+lUwdB6pHRjpkgcWwhGh8PZ3MVnzeVXZuXe2i+7503ATSyw4nnkQ7VyYJpLxC
	 62ZzhVBDZHoDknqwQMeN74Fe4oYCYOemu6rC12SIxC31A5TTSe+Qt38WvKgX+V8pPB
	 Dbxpg80JtguE5xzvpnm53CXjDr5P5oiVE+tSkMShQ1ASwfchsXVpRkm+FkQZvVJMNN
	 ucYdvSeBoeTgOAnJ6xLfQdVxVL7bYrXuve1k2eyyEbMGGorD3STrvLaTEU93u35ih2
	 COnglGAtWDknw==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Hillf Danton <hdanton@sina.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 0/2] Fix vsock error-handling regression introduced in v6.17-rc1
Date: Mon, 18 Aug 2025 19:03:53 +0100
Message-Id: <20250818180355.29275-1-will@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Here are a couple of patches fixing the vsock error-handling regression
found by syzbot [1] that I introduced during the recent merge window.

Cheers,

Will

[1] https://lore.kernel.org/all/689a3d92.050a0220.7f033.00ff.GAE@google.com/

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>

--->8

Will Deacon (2):
  net: Introduce skb_copy_datagram_from_iter_full()
  vsock/virtio: Fix message iterator handling on transmit path

 include/linux/skbuff.h                  |  2 ++
 net/core/datagram.c                     | 14 ++++++++++++++
 net/vmw_vsock/virtio_transport_common.c |  8 +++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.51.0.rc1.167.g924127e9c0-goog


