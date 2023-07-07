Return-Path: <netdev+bounces-16164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE1274BA17
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 01:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0848428198A
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 23:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F280417FF4;
	Fri,  7 Jul 2023 23:46:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25BF17FE0
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 23:46:17 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADED2108
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 16:46:15 -0700 (PDT)
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 367NjpnU016662;
	Sat, 8 Jul 2023 08:45:51 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Sat, 08 Jul 2023 08:45:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 367NjpqY016659
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 8 Jul 2023 08:45:51 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b9b17f87-007f-3ef9-d9e3-3080749cf01f@I-love.SAKURA.ne.jp>
Date: Sat, 8 Jul 2023 08:45:50 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: David Howells <dhowells@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Network Development <netdev@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [possible regression in 6.5-rc1] sendmsg()/splice() returns EBADMSG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

(Branched from https://lkml.kernel.org/r/63006262-f808-50ab-97b8-c2193c7a9ba1@I-love.SAKURA.ne.jp .)

I found that the following program started returning EBADMSG. Bisection for sendmsg() reached
commit c5c37af6ecad ("tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES") and bisection
for splice() reached commit 2dc334f1a63a ("splice, net: Use sendmsg(MSG_SPLICE_PAGES) rather
than ->sendpage()"). Is this program doing something wrong?

  6.4.0-rc5-00892-g2dc334f1a63a-dirty    argc==1 ? splice()=EBADMSG, sendmsg()=EBADMSG : sendmsg()=success, splice()=EBADMSG
  6.4.0-rc5-00891-g81840b3b91aa-dirty    argc==1 ? splice()=success, sendmsg()=EBADMSG : sendmsg()=success, splice()=success

  6.4.0-rc2-00520-gc5c37af6ecad-dirty    argc==1 ? splice()=success, sendmsg()=EBADMSG : sendmsg()=success, splice()=success
  6.4.0-rc2-00519-g270a1c3de47e-dirty    argc==1 ? splice()=success, sendmsg()=success : sendmsg()=success, splice()=success

----------------------------------------
#define _GNU_SOURCE
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#define SOL_TCP 6
#define TCP_REPAIR 19
#define TCP_ULP 31
#define TLS_TX 1

int main(int argc, char *argv[])
{
	struct iovec iov = {
		.iov_base = "@@@@@@@@@@@@@@@@",
		.iov_len = 16
	};
	struct msghdr hdr = {
		.msg_iov = &iov,
		.msg_iovlen = 1,
		.msg_flags = MSG_FASTOPEN
	};
	const struct sockaddr_in6 addr = { .sin6_family = AF_INET6, .sin6_addr = in6addr_loopback };
	const int one = 1;
	int ret_ignored = 0;
	const int fd = socket(PF_INET6, SOCK_STREAM, IPPROTO_IP);
	int pipe_fds[2] = { -1, -1 };
	static char buf[32768] = { };

	ret_ignored += pipe(pipe_fds);
	setsockopt(fd, SOL_TCP, TCP_REPAIR, &one, sizeof(one));
	connect(fd, (struct sockaddr *) &addr, sizeof(addr));
	setsockopt(fd, SOL_TCP, TCP_ULP, "tls", 4);
	setsockopt(fd, SOL_TLS, TLS_TX,"\3\0035\0%T\244\205\333\f0\362B\221\243\234\206\216\220\243u\347\342P|1\24}Q@\377\227\353\222B\354\264u[\346", 40);
	ret_ignored += write(pipe_fds[1], buf, 2432);
	ret_ignored += write(pipe_fds[1], buf, 10676);
	ret_ignored += write(pipe_fds[1], buf, 17996);
	if (argc == 1) {
		ret_ignored += splice(pipe_fds[0], NULL, fd, NULL, 1048576, SPLICE_F_MORE);
		ret_ignored += sendmsg(fd, &hdr, MSG_DONTWAIT | MSG_MORE);
	} else {
		ret_ignored += sendmsg(fd, &hdr, MSG_DONTWAIT | MSG_MORE);
		ret_ignored += splice(pipe_fds[0], NULL, fd, NULL, 1048576, SPLICE_F_MORE);
	}
	return ret_ignored * 0;
}
----------------------------------------

