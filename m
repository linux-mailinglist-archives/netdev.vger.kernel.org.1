Return-Path: <netdev+bounces-138872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B19AF444
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 23:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD48B21279
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9542010FA;
	Thu, 24 Oct 2024 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuSON4Kg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1D14A62A;
	Thu, 24 Oct 2024 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804054; cv=none; b=myPrLA20QUzS43liDcYJ2CgGy/NKiM01kXxRMFmCbujbjC4lddfwVLwhhzdXDaDFSfd7QcfM33ovxxVkRPHAGJ5tUdgenFOjgpqpBkdGgFBl+Hna7d1Z/BIK0r+OV3QEYzN8wCizTNs2upGIYH+Jz0ZsMhv857MY7Jmw2tafN8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804054; c=relaxed/simple;
	bh=VGsLDn+4py/KxlX157ZWRDRIyDbArKgYhD0nCtBTc80=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I1+b9yNo1OR2W8i+uPeWJXrRGV9xonEmJzO7r0mIQ3hDyJ6ZRuOr9H8xOFwScIl3m/r69/xTLvYXmqMdcf7a8MrvHpwI6LWhMRzTIqd8PH6hjhw8x15ciXIUVcXfj9e1ykHwrWWpo2AfilFYf/pn7WdxIpX7OHMiS+I1hfVa0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuSON4Kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DA2C4CEC7;
	Thu, 24 Oct 2024 21:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729804053;
	bh=VGsLDn+4py/KxlX157ZWRDRIyDbArKgYhD0nCtBTc80=;
	h=Date:From:To:Cc:Subject:From;
	b=TuSON4Kg8qKIceqlDlhuHD4FLjFG1JDAa4W4P8wEiad/fRBBu6i8I2FD+zUYv7g+O
	 rhenzJo/6kxYlQMuZmMbO6efmH+IZo3FoIYb9URIbT20nDkEis3o9ky7wxSOsoM8tK
	 +Y3zN8eBRJMzORrFT8iWWTNOBroZLL/5Inpo+x3rEhQaWETp7mLgHvlsuJHLs3YJr5
	 NDzTd8fE2azI6Mnp6L51XSfiiawByOYYLWrpaSr/A9yI5YLczqg1T+C42v8NUbD4nK
	 HI0hYdMDMC1/CL2iYS0VmOGFLpUTQsu9JJV1XS3v86nyejsrpYUG80muK89WHQmIoU
	 PQfP/LZPDjGVA==
Date: Thu, 24 Oct 2024 15:07:27 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [PATCH v2 0/4][next] net: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <cover.1729802213.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series aims to resolve thousands of -Wflex-array-member-not-at-end
warnings by introducing `struct sockaddr_legacy`. The intention is to use
it to replace the type of several struct members in the middle of composite
structures, currently of type `struct sockaddr`.

These middle struct members are currently causing thousands of warnings
because `struct sockaddr` contains a flexible-array member, introduced
by commit b5f0de6df6dce ("net: dev: Convert sa_data to flexible array in
struct sockaddR").

The new `struct sockaddr_legacy` doesn't include a flexible-array
member, making it suitable for use as the type of middle members
in composite structs that don't really require the flexible-array
member in `struct sockaddr`, thus avoiding -Wflex-array-member-not-at-end
warnings.

As this new struct will live in UAPI, to avoid breaking user-space code
that expects `struct sockaddr`, the `__kernel_sockaddr_legacy` macro is
introduced. This macro allows us to use either `struct sockaddr` or
`struct sockaddr_legacy` depending on the context in which the code is
used: kernel-space or user-space.

Changes in v2
 - Drop nfsd patch.
 - Move `struct sockaddr_legacy` to include/uapi/linux/socket.h
 - Introduce `__kernel_sockaddr_legacy` macro (Kees)

v1:
 Link: https://lore.kernel.org/linux-hardening/cover.1729037131.git.gustavoars@kernel.org/

Gustavo A. R. Silva (4):
  uapi: socket: Introduce struct sockaddr_legacy
  uapi: wireless: Avoid -Wflex-array-member-not-at-end warnings
  uapi: net: arp: Avoid -Wflex-array-member-not-at-end warnings
  uapi: net: Avoid -Wflex-array-member-not-at-end warnings

 include/net/compat.h          | 30 +++++++++----------
 include/uapi/linux/if_arp.h   | 18 +++++------
 include/uapi/linux/route.h    | 28 +++++++++---------
 include/uapi/linux/socket.h   | 28 ++++++++++++++++++
 include/uapi/linux/wireless.h | 56 +++++++++++++++++------------------
 net/appletalk/ddp.c           |  2 +-
 net/ipv4/af_inet.c            |  2 +-
 net/ipv4/arp.c                |  2 +-
 net/ipv4/fib_frontend.c       |  2 +-
 9 files changed, 98 insertions(+), 70 deletions(-)

-- 
2.34.1


