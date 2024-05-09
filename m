Return-Path: <netdev+bounces-95039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F94A8C1488
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B396B2265D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 18:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3980770F3;
	Thu,  9 May 2024 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9MbYTTF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843287441A;
	Thu,  9 May 2024 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278219; cv=none; b=dVVg5DXKetbkou484oNHvke5Pnsk8MFrGbwo7bdZABkF9R5MPE++E+b2tt9eFaIrBzPqnw1ld2cMjlkoyBD0GQlK+AoyN2mnoALyXRH9kNYmRUAm7xL5uL6cz0ve0cXipjzLVu9bidGFOT0b5QYVMmbHRBctj5oqeCjQXSwE13Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278219; c=relaxed/simple;
	bh=ctuxZ5xzegbDMWt/UaaV+pBht5W3fywwZ7y4ABCMIgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H2d8HORPZ9ak9GF6KUGUwILOlo69VjP4LSB1p2aRg0zFbHlWkXT1mBGyUfGu11364pEhKy05eluP4NKOTT90nSUNL9vVME8gP+p+AVBmvVxEDynwbz6aYQsl4eR/sq0BQqkV58w+UulVV2T4TWQYmQhqQtdpOe0yN6SSb+x/+OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9MbYTTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B134DC116B1;
	Thu,  9 May 2024 18:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715278219;
	bh=ctuxZ5xzegbDMWt/UaaV+pBht5W3fywwZ7y4ABCMIgg=;
	h=From:Date:Subject:To:Cc:From;
	b=c9MbYTTFDDXnKl6ot7bibdq0fboAinwL6xf1EJHU818IeEbDaOjFwJZGj4oZNVjx8
	 tE7FlE0g1DFiH7wVUcFT5bE75a6vbodIC7l35E5kiWgIqtx3ZOgQ/MNIO0iC7euk2l
	 O3Jg/9E+bFo4kSrBZN2woC876CouwkOYtV+q2zE+G+qm5+Ng/effQWebCC+hR2MYbn
	 X8gtuQiPebEBY+YEzdtRbgBttMplsfRLnSvkoje8spXXq+X7AcxiYSCqR8hLx37Fqy
	 tXUpkVN1iDiPDkPlRIpb6xZtVLikY+ZUv/Cngp3HbsZ62o2/MS9XCJ+PECzxjHIvwq
	 WgD9c0rl/7oDA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 May 2024 20:10:10 +0200
Subject: [PATCH net-next] tcp: socket option to check for MPTCP fallback to
 TCP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-upstream-net-next-20240509-mptcp-tcp_is_mptcp-v1-1-f846df999202@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIERPWYC/z2NQQqDMBBFryKzdiCGVEivIiIhHessTEMmFkG8e
 4cWu3iLx4f3DxAqTAL35oBCbxZ+JZWubSAuIT0J+aEO1lhnbsbjlqUWCismqspe8T+tucaMysQ
 y/cRb412IvXOzBW3mQjPv378BrgKM5/kBp+rfjokAAAA=
To: mptcp@lists.linux.dev, Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3433; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ctuxZ5xzegbDMWt/UaaV+pBht5W3fywwZ7y4ABCMIgg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmPRGIGwCcL+jFEmBYou88PqOEmd7YAZsmkuIcU
 S5YfsAjMjCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZj0RiAAKCRD2t4JPQmmg
 c9UjD/95bCCXh1GK0EDkVH1CPf8A6Cyyk9P2/2GHON56dqWbwTLd4gTnjMDwDweGi80kz/2wT+e
 tzmKxgqstGPYd+Go2xrkToXj6n2hQ4BRFvXk/S+Xdzj5UkeGBQKNWTVd6JTCFGdtd5NRFp1u4Xz
 cC1s900nH7RZhB9QU0rhnFEXCTtTSXjoBzJKEYzRYFhkrL6u0xkWeYgLw5NeY6SsIIP5A3bgkpB
 FLOH6TcEN836vYo99AbDy4/7XEIpXsW1IAm02WoR0e9xEnfmdL6h83+j7d7aV/ek66uigH/gaU5
 QYMXta6RnemTPjjQcBWMa5bJX5nv7iynAkYVQB7k9e3ELbfCnkPVLUTrkPLttWosa7wa8EHNFa/
 ED3B4Fla4B6KrWDcc4sVdU4UyhOy1G6zD4HUusAJWURETFmVDWKBsgC1Ffvx49Ms7mu91Jtsg6m
 Mjcj1KJpK3OxzaYg/zsck5M0ozh3N+GGcBcJMpsf3QS+xiFWI+iy6gakeaLoMbhJ/ok74advF7p
 BHpasVPXGPNE8E5tHFPanh8cZ8MacdOT4lQKQbDlXag1wi+rD453sT5H42OUm8e251ARhXP/AlG
 bpn576bX9qiim1TkAoJFxwI16syZVYT/aWj04k3LGIsN/UARgOwLZqYJw5f0an6VWLpE9jjbY1W
 jRntXWae/zYsLyw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A way for an application to know if an MPTCP connection fell back to TCP
is to use getsockopt(MPTCP_INFO) and look for errors. The issue with
this technique is that the same errors -- EOPNOTSUPP (IPv4) and
ENOPROTOOPT (IPv6) -- are returned if there was a fallback, *or* if the
kernel doesn't support this socket option. The userspace then has to
look at the kernel version to understand what the errors mean.

It is not clean, and it doesn't take into account older kernels where
the socket option has been backported. A cleaner way would be to expose
this info to the TCP socket level. In case of MPTCP socket where no
fallback happened, the socket options for the TCP level will be handled
in MPTCP code, in mptcp_getsockopt_sol_tcp(). If not, that will be in
TCP code, in do_tcp_getsockopt(). So MPTCP simply has to set the value
1, while TCP has to set 0.

If the socket option is not supported, one of these two errors will be
reported:
- EOPNOTSUPP (95 - Operation not supported) for MPTCP sockets
- ENOPROTOOPT (92 - Protocol not available) for TCP sockets, e.g. on the
  socket received after an 'accept()', when the client didn't request to
  use MPTCP: this socket will be a TCP one, even if the listen socket
  was an MPTCP one.

With this new option, the kernel can return a clear answer to both "Is
this kernel new enough to tell me the fallback status?" and "If it is
new enough, is it currently a TCP or MPTCP socket?" questions, while not
breaking the previous method.

Acked-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - We are open to other techniques if they are others that are simple
   and clear to use for the userspace.
---
 include/uapi/linux/tcp.h | 2 ++
 net/ipv4/tcp.c           | 3 +++
 net/mptcp/sockopt.c      | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index c07e9f90c084..dbf896f3146c 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -135,6 +135,8 @@ enum {
 #define TCP_AO_GET_KEYS		41	/* List MKT(s) */
 #define TCP_AO_REPAIR		42	/* Get/Set SNEs and ISNs */
 
+#define TCP_IS_MPTCP		43	/* Is MPTCP being used? */
+
 #define TCP_REPAIR_ON		1
 #define TCP_REPAIR_OFF		0
 #define TCP_REPAIR_OFF_NO_WP	-1	/* Turn off without window probes */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e1f0efbb29d6..231ff63ba81d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4363,6 +4363,9 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 
 		return err;
 	}
+	case TCP_IS_MPTCP:
+		val = 0;
+		break;
 	default:
 		return -ENOPROTOOPT;
 	}
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1fea43f5b6f3..eaa3b79651a4 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1348,6 +1348,8 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->nodelay);
 	case TCP_NOTSENT_LOWAT:
 		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
+	case TCP_IS_MPTCP:
+		return mptcp_put_int_option(msk, optval, optlen, 1);
 	}
 	return -EOPNOTSUPP;
 }

---
base-commit: 628bc3e5a1beae395b5b515998396c60559ed3a9
change-id: 20240509-upstream-net-next-20240509-mptcp-tcp_is_mptcp-92094ac644f2

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


