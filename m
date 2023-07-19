Return-Path: <netdev+bounces-19131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97AD759D49
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 20:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0EB2819C9
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B001FB26;
	Wed, 19 Jul 2023 18:30:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897EA1BB3F
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 18:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA761C433C8;
	Wed, 19 Jul 2023 18:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689791458;
	bh=FwXbpy3BEeOukDhH/s2twzM3UvZGSRfcKPf/pt9FrkQ=;
	h=Subject:From:To:Cc:Date:From;
	b=VQwx6BpgYlvWvOHuW2Oh1fpazczpviL+LUbkSBb/fMvu0ZlG0qJkUFUhm0c7J/fDn
	 WKCDF68OLtyH2fc8r2gv2MCsIl0LsJmmpvSPJCJFdGbmXoXzVQGTM8O4yDswy+VSO5
	 k/EYhYNC+i3QUk+IYhPD+eCucIhr3+wv9u1S/9kwv6tmrXfhAHAzXogXc/madYhPDf
	 GIjbz3MbgkbECc7kthqpm1vY7U5KIMlTra/6eqPG6biP2NZWC1PeL5NdNieJybEX6W
	 NKDjDNXTs1yI0sfVxzx+kNFe1MUSq4X8AtNfz4L+wCxq27evKY5OcJ06Iqrix1P5lA
	 11imlZ93FLzQA==
Subject: [PATCH v3 0/5] Send RPC-on-TCP with one sock_sendmsg() call
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, David Howells <dhowells@redhat.com>,
 dhowells@redhat.com
Date: Wed, 19 Jul 2023 14:30:56 -0400
Message-ID: 
 <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
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

Initial performance benchmark results show 5-10% throughput gains
with a fast link layer and a tmpfs export. I've added some other
ideas to this series for further discussion -- these have also shown
performance benefits in my testing.


Changes since v2:
* Keep rq_bvec instead of switching to a per-transport bio_vec array
* Remove the cork/uncork logic in svc_tcp_sendto
* Attempt to mitigate wake-up storms when receiving large RPC messages

Changes since RFC:
* Moved xdr_buf-to-bio_vec array helper to generic XDR code
* Added bio_vec array bounds-checking
* Re-ordered patches

---

Chuck Lever (5):
      SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly
      SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call
      SUNRPC: Convert svc_udp_sendto() to use the per-socket bio_vec array
      SUNRPC: Revert e0a912e8ddba
      SUNRPC: Reduce thread wake-up rate when receiving large RPC messages


 include/linux/sunrpc/svcsock.h |   4 +-
 include/linux/sunrpc/xdr.h     |   2 +
 net/sunrpc/svcsock.c           | 127 +++++++++++++++------------------
 net/sunrpc/xdr.c               |  50 +++++++++++++
 4 files changed, 112 insertions(+), 71 deletions(-)

--
Chuck Lever


