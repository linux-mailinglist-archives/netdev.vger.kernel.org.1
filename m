Return-Path: <netdev+bounces-47286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058697E9666
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 05:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3472280C4C
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 04:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D129C2CD;
	Mon, 13 Nov 2023 04:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F2E8F42
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 04:58:04 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4507171B;
	Sun, 12 Nov 2023 20:58:01 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VwC2BlG_1699851478;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VwC2BlG_1699851478)
          by smtp.aliyun-inc.com;
          Mon, 13 Nov 2023 12:57:59 +0800
Date: Mon, 13 Nov 2023 12:57:58 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net/smc: Introduce IPPROTO_SMC for smc
Message-ID: <20231113045758.GB121324@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <1699442703-25015-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1699442703-25015-1-git-send-email-alibuda@linux.alibaba.com>

On Wed, Nov 08, 2023 at 07:25:03PM +0800, D. Wythe wrote:
>From: "D. Wythe" <alibuda@linux.alibaba.com>
>
>This patch attempts to initiate a discussion on creating smc socket
>via AF_INET, similar to the following code snippet:
>
>/* create v4 smc sock */
>v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
>
>/* create v6 smc sock */
>v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
>
>As we all know, the way we currently create an SMC socket as
>follows.
>
>/* create v4 smc sock */
>v4 = socket(AF_SMC, SOCK_STREAM, SMCPROTO_SMC);
>
>/* create v6 smc sock */
>v6 = socket(AF_SMC, SOCK_STREAM, SMCPROTO_SMC6);
>
>Note: This is not to suggest removing the SMC path, but rather to propose
>adding a new path (inet path).
>
>There are several reasons why we believe it is much better than AF_SMC:
>
>Semantics:
>
>SMC extends the TCP protocol and switches it's data path to RDMA path if
>RDMA link is ready. Otherwise, SMC should always try its best to degrade to
>TCP. From this perspective, SMC is a protocol derived from TCP and can also
>fallback to TCP, It should be considered as part of the same protocol
>family as TCP (AF_INET and AF_INET6).
>
>Compatibility & Scalability:
>
>Due to the presence of fallback, we needs to handle it very carefully to
>keep the consistent with the TCP sockets. SMC has done a lot of work to
>ensure that, but still, there are quite a few issues left, such as:
>
>1. The "ss" command cannot display the process name and ID associated with
>the fallback socket.
>
>2. The linger option is ineffective when user try’s to close the fallback
>socket.
>
>3. Some eBPF attach points related to INET_SOCK are ineffective under
>fallback socket, such as BPF_CGROUP_INET_SOCK_RELEASE.
>
>4. SO_PEEK_OFF is a un-supported sock option for fallback sockets, while
>it’s of course supported for tcp sockets.
>
>Of course, we can fix each issue one by one, but it is not a fundamental
>solution. Any changes on the inet path may require re-synchronization,
>including bug fixes, security fixes, tracing, new features and more. For
>example, there is a commit which we think is very valueable:
>
>commit 0dd061a6a115 ("bpf: Add update_socket_protocol hook")
>
>This commit allows users to modify dynamically the protocol before socket
>created through eBPF programs, which provides a more flexible approach
>than smc_run (LP_PRELOAD). It does not require the process restart
>and allows for controlling replacement at the connection level, whereas
>smc_run operates at the process level.
>
>However, to benefit from it under the SMC path requires additional
>code submission while nothing changes requires to do under inet path.
>
>I'm not saying that these issues cannot be fixed under smc path, however,
>the solution for these issues often involves duplicating work that already
>done on inet path. Thats to say, if we can be under the inet path, we can
>easily reuse the existing infrastructure.
>
>Performance:
>
>In order to ensure consistency between fallback sockets and TCP sockets,
>SMC creates an additional TCP socket. This introduces additional overhead
>of approximately 15%-20% for the establishment and destruction of fallback
>sockets. In fact, for the users we have contacted who have shown interest
>in SMC, ensuring consistency in performance between fallback and TCP has
>always been their top priority. Since no one can guarantee the
>availability of RDMA links, support for SMC on both sides, or if the
>user's environment is 100% suitable for SMC. Fallback is the only way to
>address those issues, but the additional performance overhead is
>unacceptable, as fallback cannot provide the benefits of RDMA and only
>brings burden right now.
>
>In inet path, we can embed TCP sock into SMC sock, when fallback occurs,
>the socket behaves exactly like a TCP socket. In our POC, the performance
>of fallback socket under inet path is almost indistinguishable from of
>tcp socket, with less than 1% loss. Additionally, and more importantly,
>it has full feature compatibility with TCP socket.
>
>Of course, it is also possible under smc path, but in that way, it
>would require a significant amount of work to ensure compatibility with
>tcp sockets, which most of them has already been done in inet path.
>And still, any changes in inet path may require re-synchronization.
>
>I also noticed that there have been some discussions on this issue before.
>
>Link: https://lore.kernel.org/stable/4a873ea1-ba83-1506-9172-e955d5f9ae16@redhat.com/
>
>And I saw some supportive opinions here, maybe it is time to continue
>discussing this matter now.
>
>Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>---
> include/uapi/linux/in.h | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
>index e682ab6..0c6322b 100644
>--- a/include/uapi/linux/in.h
>+++ b/include/uapi/linux/in.h
>@@ -83,6 +83,8 @@ enum {
> #define IPPROTO_RAW		IPPROTO_RAW
>   IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
> #define IPPROTO_MPTCP		IPPROTO_MPTCP
>+  IPPROTO_SMC = 263,		/* Shared Memory Communications		*/
>+#define IPPROTO_SMC		IPPROTO_SMC

I think adding a new IPPROTO_SMC protocol is good, but we need to make
sure this won't break AF_SMC.


Best regards,
Dust



>   IPPROTO_MAX
> };
> #endif
>-- 
>1.8.3.1

