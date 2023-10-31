Return-Path: <netdev+bounces-45480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56E77DD705
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 21:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0733F28140C
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 20:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DD7225A2;
	Tue, 31 Oct 2023 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5sH2Uci"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4EC2231F;
	Tue, 31 Oct 2023 20:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC330C433C7;
	Tue, 31 Oct 2023 20:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698783833;
	bh=kWiaXu3zrQZh2hYqfEmW4X7fxyTTU9Vm8/7Xl0jbDBA=;
	h=From:Date:Subject:To:Cc:From;
	b=s5sH2Uci1k2u4vWV23OrrzgnwwQKx+y5oaE0RpqzJ6Twf7lV29B/bkx2x9CbcHhgn
	 Hfd01CAIq4EtfvIWkc1Z1uGI+U2bw5mIEmczPNeG9ThqFF59TgRArd+ZG48aTt/xQO
	 8YhKl5stfQntyVPcWA/n+sG96SC7KQ+v4r6KyyjP65sVayY4vxc7OtPoNZZG33e5Rq
	 seCYRCmchOws3UuX2GEynHkpSlssIUm2Xt5uwMQyf8S/Ad1tvFFudq5lDlcboCi0+T
	 YEbawG7N7XeSujIVQIduOldpcybF3VriG1dlAyZU6iS+kx1M2qvC6MmTR7NSgZBFbt
	 Eex9Tbeiqjthg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 31 Oct 2023 13:23:35 -0700
Subject: [PATCH net] tcp: Fix -Wc23-extensions in tcp_options_write()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231031-tcp-ao-fix-label-in-compound-statement-warning-v1-1-c9731d115f17@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEdiQWUC/x2NywqDMBAAf0X23AWjxZr+SvGwJlu7oJuQpA8Q/
 73B4xxmZofMSTjDvdkh8UeyBK1gLg24F+nCKL4ydG3Xm7Y3WFxECviUH64084qi6MIWw1s95kK
 FN9aCX0oquiDPfnDW3sarHaFGY+KqnsMHKBeYjuMPgHtvwIUAAAA=
To: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, 
 kuba@kernel.org, pabeni@redhat.com
Cc: ndesaulniers@google.com, trix@redhat.com, 0x7f454c46@gmail.com, 
 fruggeri@arista.com, noureddine@arista.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1514; i=nathan@kernel.org;
 h=from:subject:message-id; bh=kWiaXu3zrQZh2hYqfEmW4X7fxyTTU9Vm8/7Xl0jbDBA=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKmOSREXvu1tr+8+bHVSuOeh38onXBunXjs4y4cn7rHcg
 Za26s9POkpZGMQ4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBErl9gZNh04/vrW5sNPmfM
 aXzGUKT2ZEVGzo5L0ccv7ubqSViXlHqUkWGt9YUSyxlBEl+f7VFIuhPVxS8b+8PzTKPVTYYTk//
 lC/ADAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Clang warns (or errors with CONFIG_WERROR=y) when CONFIG_TCP_AO is set:

  net/ipv4/tcp_output.c:663:2: error: label at end of compound statement is a C23 extension [-Werror,-Wc23-extensions]
    663 |         }
        |         ^
  1 error generated.

On earlier releases (such as clang-11, the current minimum supported
version for building the kernel) that do not support C23, this was a
hard error unconditionally:

  net/ipv4/tcp_output.c:663:2: error: expected statement
          }
          ^
  1 error generated.

Add a semicolon after the label to create an empty statement, which
resolves the warning or error for all compilers.

Closes: https://github.com/ClangBuiltLinux/linux/issues/1953
Fixes: 1e03d32bea8e ("net/tcp: Add TCP-AO sign to outgoing packets")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index f558c054cf6e..6064895daece 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -658,7 +658,7 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			memset(ptr, TCPOPT_NOP, sizeof(*ptr));
 			ptr++;
 		}
-out_ao:
+out_ao:;
 #endif
 	}
 	if (unlikely(opts->mss)) {

---
base-commit: 55c900477f5b3897d9038446f72a281cae0efd86
change-id: 20231031-tcp-ao-fix-label-in-compound-statement-warning-ebd6c9978498

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


