Return-Path: <netdev+bounces-209550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DB9B0FD3B
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 01:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B76968132
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 23:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C04926C3BE;
	Wed, 23 Jul 2025 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjpFl0l4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B08A95C
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312766; cv=none; b=Vk1G/E3Hd1RhtXmIKJ3MSY74JJSOQad0WdDbSTMu5hX2ZFRQFJg4+lK8F1dJS/jGY12aRKzevzoNrWDRaHFFlQX9SosH/TxLVejBcCziAxDVLYV22XorX8zfbJEkvkdyfeVzAFdgE9y1AhmpJ0bNSwKxHn2OVixQCWX9ypXuzoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312766; c=relaxed/simple;
	bh=ZyzirJh2YHdHfr8ZO3cTwhmuIpqiNW/lQtb1WaKD29o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aqG7RL5T3POnGnIayJH9RmhbrxeMlP+2OHpTDIsO+2jB2Bup8DZQTEYGplqyutkcH94aswWfScDFoCnPS1DM8D+b9MgZXcy88CzuST+7F1/av4OaeU7qQ5t2TPK3neVo9N0KP7HcAkaHUi+sp+tR39N6LZVwHXkQ9VZl9OusVq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjpFl0l4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B2AC4CEE7;
	Wed, 23 Jul 2025 23:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753312765;
	bh=ZyzirJh2YHdHfr8ZO3cTwhmuIpqiNW/lQtb1WaKD29o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UjpFl0l4xj+ShGwFBOwmnuvr0T55x0ABathnJI5cgjHIpsNmpC1KoB8vNBm2soITx
	 BcQ6Mqudn2Hyd/0XO6eWPWV1MJN72RAuqtQUKu7n0QDuf9fGpn+zkvRUEqUQ6gqtcD
	 jZrO1FcHHd6txvMdbi6PNIE7SLafS0hGmoIF9OVaIEOvpZjsY7Tp1GWhpLsgDPu+xm
	 B13C8rZv8KD5DNSZaK8L5Lt27uVW4wexUvNA0qPaYcpaaHalYnOHKXBDpWi5Q80d0B
	 C2NvgG6QtHh/a0fyVE1qLUqrt/SynAWFpXJxXm4I6E7B4CtpFzuqK+rzyeRLElik0+
	 90XcHpNkCoh7w==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org
Subject: [PATCH 1/6 net-next] net: uapi: Add __kernel_sockaddr_unspec for sockaddr of unknown length
Date: Wed, 23 Jul 2025 16:19:08 -0700
Message-Id: <20250723231921.2293685-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723230354.work.571-kees@kernel.org>
References: <20250723230354.work.571-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2006; i=kees@kernel.org; h=from:subject; bh=ZyzirJh2YHdHfr8ZO3cTwhmuIpqiNW/lQtb1WaKD29o=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmNue9lo9N6Lx/KXD/Zl+nIuRuPpsWs6Oa8I6H5O3uJb Z5xOUdxRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwESEIhgZPi2frXP8pMr/rki9 S8VmUcutGD/eMWh5y5xqOyO+9d+V64wMr5MWHXd/Z+GYmBWXc1Fk/0xnoc2mdgs+Nq0tKXvO3iT ADQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add flexible sockaddr structure to support addresses longer than the
traditional 14-byte struct sockaddr::sa_data limitation. This allows the
network APIs to pass around a pointer to an object that isn't lying to
the compiler about how big it is.

I added this to UAPI in the hopes that it could also be used for any
future "arbitrarily sized" sockaddr needs. But it may be better to
use a different UAPI with an explicit size member:

struct sockaddr_unspec {
	u16 sa_data_len;
	u16 sa_family;
	u8  sa_data[] __counted_by(sa_data_len);
};

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/net.h         |  2 ++
 include/uapi/linux/socket.h | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/net.h b/include/linux/net.h
index ec09620f40f7..77de581bdd56 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -26,6 +26,8 @@
 
 #include <uapi/linux/net.h>
 
+#define sockaddr_unspec __kernel_sockaddr_unspec
+
 struct poll_table_struct;
 struct pipe_inode_info;
 struct inode;
diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
index d3fcd3b5ec53..2667dd64fd0f 100644
--- a/include/uapi/linux/socket.h
+++ b/include/uapi/linux/socket.h
@@ -26,6 +26,21 @@ struct __kernel_sockaddr_storage {
 	};
 };
 
+/**
+ * struct __kernel_sockaddr_unspec - Unspecified size sockaddr for callbacks
+ * @sa_family: Address family (AF_UNIX, AF_INET, AF_INET6, etc.)
+ * @sa_data: Flexible array for address data
+ *
+ * This structure is designed for callback interfaces where the
+ * total size is known via the sockaddr_len parameter. Unlike struct
+ * sockaddr which has a fixed 14-byte sa_data limit, this structure
+ * can accommodate addresses of any size.
+ */
+struct __kernel_sockaddr_unspec {
+	__kernel_sa_family_t	sa_family;	/* address family, AF_xxx */
+	char			sa_data[];	/* flexible address data */
+};
+
 #define SOCK_SNDBUF_LOCK	1
 #define SOCK_RCVBUF_LOCK	2
 
-- 
2.34.1


