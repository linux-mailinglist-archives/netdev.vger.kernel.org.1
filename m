Return-Path: <netdev+bounces-18008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC9775424B
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 20:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436F62821D8
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2687D15AC8;
	Fri, 14 Jul 2023 18:10:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA75715AC0
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 18:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEB3C433C8;
	Fri, 14 Jul 2023 18:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689358232;
	bh=tCSyUkciooppcZwDR0Q7o35bPDL9xjwwyAUn+D0Uoi4=;
	h=Subject:From:To:Cc:Date:From;
	b=p0ugFphLvI45UrVhJZWH9bZaavDTyRYwIznSY3XFJ6RTTQ9rlgNq7lasm26oSt/pk
	 vmJXmoDiOoDhrwNeBwJ9EXmo5+YujPri169UoqCdazjF4/4wZG0gn9q7ggoXPzgf9T
	 mnbkNfi2zpVPy82Pn9WartxtMi1BDblHAVqXUT1Je6QJ5HanOlW4JECvCBVHeZz4RB
	 aulsAJrA/Nq/aBdZSQmiaoppC/EYnOL4R6J588qOtugaQIA15hBLLejNkONLjfCNwi
	 dtGas1JZTKJ3On2v3R89C5lMeD3WfSwsBEr3pCQm5nkEdss8d2SqCV1o66gIGKNHuo
	 lA1M3sknRWuEA==
Subject: [PATCH v2 0/4] Send RPC-on-TCP with one sock_sendmsg() call
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, David Howells <dhowells@redhat.com>,
 dhowells@redhat.com
Date: Fri, 14 Jul 2023 14:10:31 -0400
Message-ID: 
 <168935791041.1984.13295336680505732841.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

After some discussion with David Howells at LSF/MM 2023, we arrived
at a plan to use a single sock_sendmsg() call for transmitting an
RPC message on socket-based transports. This is an initial part of
the transition to support handling folios with file content, but it
has scalability benefits as well.

This series passes the usual set of NFS-based tests. I've found no
behavior regressions so far. From the netdev folks, I'm interested
to know if this approach is sensible. The next step is performance
benchmarking.


Changes since RFC:
* Moved xdr_buf-to-bio_vec array helper to generic XDR code
* Added bio_vec array bounds-checking
* Re-ordered patches

---

Chuck Lever (4):
      SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly
      SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call
      SUNRPC: Convert svc_udp_sendto() to use the per-socket bio_vec array
      SUNRPC: Use a per-transport receive bio_vec array


 include/linux/sunrpc/svc.h     |   1 -
 include/linux/sunrpc/svcsock.h |   7 +++
 include/linux/sunrpc/xdr.h     |   2 +
 net/sunrpc/svcsock.c           | 111 ++++++++++++++-------------------
 net/sunrpc/xdr.c               |  50 +++++++++++++++
 5 files changed, 107 insertions(+), 64 deletions(-)

--
Chuck Lever


