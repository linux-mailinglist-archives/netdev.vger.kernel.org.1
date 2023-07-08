Return-Path: <netdev+bounces-16170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CBE74BAE2
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 03:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F69E1C2110C
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 01:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4892310EB;
	Sat,  8 Jul 2023 01:09:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F17F
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 01:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D605AC433C7;
	Sat,  8 Jul 2023 01:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688778543;
	bh=Xc/GyF8wG7SCEWxNkNX0FKLBYnK3yRSwOwLPvedznMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LmN557GgBdTaDYb0Nkbeg+p31t3jotwq4Y7pO0i/83nvKs5gk0DPsVwKm//Emd3Ii
	 ujBsk5qs/5oWKHc11vkhenpo7GG2a0obheK/AMi2oF3yIede/HqNAxs0MvAx6rq2x2
	 DX56d1GNhAqOWu52pwYRoZxkx6TnI4+/Nmk8Zb6XKKPKVFqGh92fU4c5SIpQ5VCkDg
	 jN1V4ZCPFFyltqpZIawFORJDKyoxuqofIVX2Oa8CQ1PK5AtPaBFDmNZHEycKpu28I/
	 ZHX4xvAmj7A/AduakTOgdPyAhYS5lb5y5QaTOL52HaKHcPvA6ru6G3y5JhtyP3vt3q
	 cJ8VIE7b8LBog==
Date: Fri, 7 Jul 2023 18:09:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: David Howells <dhowells@redhat.com>, David Ahern <dsahern@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>, Network
 Development <netdev@vger.kernel.org>
Subject: Re: [possible regression in 6.5-rc1] sendmsg()/splice() returns
 EBADMSG
Message-ID: <20230707180901.34c17465@kernel.org>
In-Reply-To: <b9b17f87-007f-3ef9-d9e3-3080749cf01f@I-love.SAKURA.ne.jp>
References: <b9b17f87-007f-3ef9-d9e3-3080749cf01f@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Jul 2023 08:45:50 +0900 Tetsuo Handa wrote:
> (Branched from https://lkml.kernel.org/r/63006262-f808-50ab-97b8-c2193c7a9ba1@I-love.SAKURA.ne.jp .)
> 
> I found that the following program started returning EBADMSG. Bisection for sendmsg() reached
> commit c5c37af6ecad ("tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES") and bisection
> for splice() reached commit 2dc334f1a63a ("splice, net: Use sendmsg(MSG_SPLICE_PAGES) rather
> than ->sendpage()"). Is this program doing something wrong?
> 
>   6.4.0-rc5-00892-g2dc334f1a63a-dirty    argc==1 ? splice()=EBADMSG, sendmsg()=EBADMSG : sendmsg()=success, splice()=EBADMSG
>   6.4.0-rc5-00891-g81840b3b91aa-dirty    argc==1 ? splice()=success, sendmsg()=EBADMSG : sendmsg()=success, splice()=success
> 
>   6.4.0-rc2-00520-gc5c37af6ecad-dirty    argc==1 ? splice()=success, sendmsg()=EBADMSG : sendmsg()=success, splice()=success
>   6.4.0-rc2-00519-g270a1c3de47e-dirty    argc==1 ? splice()=success, sendmsg()=success : sendmsg()=success, splice()=success

> 	setsockopt(fd, SOL_TCP, TCP_REPAIR, &one, sizeof(one));

I think it's just because the repro puts the socket in repair mode, 
and the current code doesn't want to play with repair mode as nicely.

I added:
	// needs #include <linux/tcp.h>
        int val = TCP_SEND_QUEUE;                                                   
        setsockopt(fd, SOL_TCP, TCP_REPAIR_QUEUE, &val, sizeof(val)); 

here (i.e. after putting the socket in repair mode), and I don't get 
the EBADMSG any more. Both sendmsg and splice succeed.

Can you check if we're back to the KMSAN problem with those lines added?


FWIW you can also try to repro with real tls sockets (not in repair
mode) by adding cases to tools/testing/selftests/net/tls.c for example:

TEST_F(tls, bla_bla)
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
	int pipe_fds[2] = { -1, -1 };
	static char buf[32768] = { };
	int ret;

	ret = pipe(pipe_fds);
	ASSERT_EQ(ret, 0);

	EXPECT_EQ(write(pipe_fds[1], buf, 2432), 2432);
	EXPECT_EQ(write(pipe_fds[1], buf, 10676), 10676);
	EXPECT_EQ(write(pipe_fds[1], buf, 17996), 17996);

	EXPECT_EQ(splice(pipe_fds[0], NULL, self->fd, NULL, 1048576,
			 SPLICE_F_MORE), 17996 + 10676 + 2432);
	EXPECT_EQ(sendmsg(self->fd, &hdr, MSG_DONTWAIT | MSG_MORE), 16);
}

Then compiling:

make -C tools/testing/selftests/net/

And running:

tools/testing/selftests/net/tls -r tls.13_aes_gcm_256.bla_bla

