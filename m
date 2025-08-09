Return-Path: <netdev+bounces-212316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D595EB1F2D4
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 09:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62C61C20609
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 07:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338E727A462;
	Sat,  9 Aug 2025 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stegemann.de header.i=@stegemann.de header.b="uHXr39Y3"
X-Original-To: netdev@vger.kernel.org
Received: from dd41718.kasserver.com (dd41718.kasserver.com [85.13.145.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3164C221540;
	Sat,  9 Aug 2025 07:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.145.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754724356; cv=none; b=pEWRIN+4RvSXpF7PioNM/VDOP2hpyW6UjPXTXzIYgDG5XRTWzbVklA5fT6B1gTGpPftbPJdlGvnQEJQIfdZnxKobJmAYkSc1tE/tYQ7hy4eMJdqWLZfc7vKmrBbAjg6iSveHJGw/xKOt7N52xuX2wwjC3VGGoQ3UHLxh8/ViKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754724356; c=relaxed/simple;
	bh=RxuIOBCjvO/UXxbAKUoOPD5/4IaAF1vEoM9n+mnX3fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYl5LzbshFXN9siQHaZ8lqf4F+QKNaZWRE55444ihIzWTwzSvVZnhc62uFDupQbG38laGJWAXoI62TwiuQIf347+SMaelPTkO/3BlBarp691iZHqKG81BMYaCT1ZKhXMBbpLOF9Ga3Ty6hltWFTSQA+YVF7wA+k27spHgiwYyHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stegemann.de; spf=pass smtp.mailfrom=stegemann.de; dkim=pass (2048-bit key) header.d=stegemann.de header.i=@stegemann.de header.b=uHXr39Y3; arc=none smtp.client-ip=85.13.145.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stegemann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stegemann.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stegemann.de;
	s=kas202307141421; t=1754724351;
	bh=JVhQ6FpaYhcYh1B5Dqp+lxrApOz1+N+0h1r94kD842M=;
	h=Date:Subject:To:Cc:From:In-Reply-To:From;
	b=uHXr39Y3neogEEW30LsJybXwPVBno1vVwYoXFlmMnYiQuoiiJmmgtrcJrQ5WhlCNI
	 4n0Ysd0iq5mtiD7mlGSj6dXmshKOm3F3Qt+dbrAOzZq0Vw2lfajOFEtuXxjPl3JwE+
	 UhfDVs1ZaVXm4oH0Xn2mTaeAYxx2lVeZV5Ibzi6dDJEB0e/6Y3Lv6phYISnioNvAte
	 r0X92K2wCV7wGYr9hafGb4568cbqQI8UjBFKa/edDMBufpD5ZRcHnzVCdzAEb+Ye1Q
	 7PZUxbDKx3vlz+VG9IhFvu4IUM9tUuspfmMLP10jYwA2rhSB21KgUEOlRY4THlklXH
	 Q8di0FjMigT5Q==
Received: from [10.144.2.19] (p5b2eae0a.dip0.t-ipconnect.de [91.46.174.10])
	by dd41718.kasserver.com (Postfix) with ESMTPSA id CC55055E038E;
	Sat,  9 Aug 2025 09:25:50 +0200 (CEST)
Message-ID: <c1a23c4d-3ef2-45bd-ad9a-616528e22635@stegemann.de>
Date: Sat, 9 Aug 2025 09:25:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: kcm: Fix race condition in kcm_unattach()
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+e62c9db591c30e174662@syzkaller.appspotmail.com,
 syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com
References: <20250809063622.117420-1-sven@stegemann.de>
From: Sven Stegemann <sven@stegemann.de>
Autocrypt: addr=sven@stegemann.de; keydata=
 xjMEZrXtmhYJKwYBBAHaRw8BAQdA3Ejzsjqv+hzfA59byjISoS/VehggsxakHVtgwKSoA9PN
 IlN2ZW4gU3RlZ2VtYW5uIDxzdmVuQHN0ZWdlbWFubi5kZT7CjwQTFggANxYhBHSSwIIEOMdM
 COsZe4gToYAVM3dwBQJmte2aBQkHhM4AAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQiBOhgBUz
 d3Dq2wEA3Y7BLtU/NzbpTu+ZnEIIVc0DuTfrinsv8qnSAEF3zjoBAOiCC+pZdO06qat8VL/O
 BUalGs5fNIVGA+udw/opviIMzjgEZrXtmhIKKwYBBAGXVQEFAQEHQGNHDhm0CMpuUnwzlf6Q
 MA34IVeba8HZ3dD1tHjsmNJjAwEIB8J+BBgWCAAmFiEEdJLAggQ4x0wI6xl7iBOhgBUzd3AF
 Ama17ZoFCQeEzgACGwwACgkQiBOhgBUzd3A7yQD/bq9BjmEfA5aRi+jPGGKccfqjo/h1cgCg
 Jhc6fNUaCgIA/1SOhP2plCGFj8xPLvhY/FfFWeE38DbrETpOLdl+NysO
In-Reply-To: <20250809063622.117420-1-sven@stegemann.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +

On 8/9/2025 8:36 AM, Sven Stegemann wrote:
> syzbot found a race condition when kcm_unattach(psock)
> and kcm_release(kcm) are executed at the same time.
> 
> kcm_unattach is missing a check of the flag
> kcm->tx_stopped before calling queue_work().
> 
> If the kcm has a reserved psock, kcm_unattach() might get executed
> between cancel_work_sync() and unreserve_psock() in kcm_release(),
> requeuing kcm->tx_work right before kcm gets freed in kcm_done().
> 
> Remove kcm->tx_stopped and replace it by the less
> error-prone disable_work().

I made a mistake in the subject line. It is supposed to say "[PATCH net]"
instead of "[PATCH net-next".

Also some information about the testing I have done:

I patched msleep() calls into the race windows and wrote a reproducer in C
that reliably triggers a KASAN use-after-free read at the beginning of kcm_tx_work
if run against that kernel build.

With the proposed patch the reproducer does not trigger any crashes or warnings.
The syscalls also return non-negative values.

These are the files I used for debugging:

- Kernel patch:

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index a4971e6fa943..df61f4715747 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -446,6 +446,8 @@ static struct kcm_psock *reserve_psock(struct kcm_sock *kcm)
 	struct kcm_mux *mux = kcm->mux;
 	struct kcm_psock *psock;
 
+	printk("reserve_psock: call function");
+
 	psock = kcm->tx_psock;
 
 	smp_rmb(); /* Must read tx_psock before tx_wait */
@@ -527,6 +529,8 @@ static void unreserve_psock(struct kcm_sock *kcm)
 	struct kcm_psock *psock;
 	struct kcm_mux *mux = kcm->mux;
 
+	printk("unreserve_psock: call function");
+
 	spin_lock_bh(&mux->lock);
 
 	psock = kcm->tx_psock;
@@ -715,6 +719,10 @@ static void kcm_tx_work(struct work_struct *w)
 	struct sock *sk = &kcm->sk;
 	int err;
 
+	printk("kcm_tx_work: entered function");
+
+	msleep(200);
+
 	lock_sock(sk);
 
 	/* Primarily for SOCK_DGRAM sockets, also handle asynchronous tx
@@ -737,6 +745,9 @@ static void kcm_tx_work(struct work_struct *w)
 
 out:
 	release_sock(sk);
+
+	printk("kcm_tx_work: exiting function");
+
 }
 
 static void kcm_push(struct kcm_sock *kcm)
@@ -1357,6 +1368,8 @@ static void kcm_unattach(struct kcm_psock *psock)
 	struct sock *csk = psock->sk;
 	struct kcm_mux *mux = psock->mux;
 
+	printk("kcm_unattach: entered function");
+
 	lock_sock(csk);
 
 	/* Stop getting callbacks from TCP socket. After this there should
@@ -1419,6 +1432,9 @@ static void kcm_unattach(struct kcm_psock *psock)
 		 */
 		kcm_abort_tx_psock(psock, EPIPE, false);
 
+		printk("kcm_unattach: sleeping before queue_work");
+		msleep(100);
+
 		spin_lock_bh(&mux->lock);
 		if (!psock->tx_kcm) {
 			/* psock now unreserved in window mux was unlocked */
@@ -1429,6 +1445,8 @@ static void kcm_unattach(struct kcm_psock *psock)
 		/* Commit done before queuing work to process it */
 		smp_mb();
 
+		printk("kcm_unattach: queueing tx_work");
+
 		/* Queue tx work to make sure psock->done is handled */
 		queue_work(kcm_wq, &psock->tx_kcm->tx_work);
 		spin_unlock_bh(&mux->lock);
@@ -1446,6 +1464,8 @@ static void kcm_unattach(struct kcm_psock *psock)
 	}
 
 	release_sock(csk);
+
+	printk("kcm_unattach: exiting function");
 }
 
 static int kcm_unattach_ioctl(struct socket *sock, struct kcm_unattach *info)
@@ -1677,6 +1697,8 @@ static int kcm_release(struct socket *sock)
 	struct kcm_mux *mux;
 	struct kcm_psock *psock;
 
+	printk("kcm_release: entered function");
+
 	if (!sk)
 		return 0;
 
@@ -1716,6 +1738,9 @@ static int kcm_release(struct socket *sock)
 	 */
 	cancel_work_sync(&kcm->tx_work);
 
+	printk("kcm_release: sleeping after cancel_work_sync");
+	msleep(150);
+
 	lock_sock(sk);
 	psock = kcm->tx_psock;
 	if (psock) {
@@ -1733,8 +1758,12 @@ static int kcm_release(struct socket *sock)
 
 	sock->sk = NULL;
 
+	printk("kcm_release: freeing kcm");
+
 	kcm_done(kcm);
 
+	printk("kcm_release: exiting function");
+
 	return 0;
 }
--

- Reproducer:

#include <arpa/inet.h>
#include <linux/bpf.h>
#include <linux/socket.h>
#include <linux/in.h>
#include <linux/kcm.h>
#include <linux/bpf_common.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <sys/wait.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int check_error(int ret, const char *err_message)
{
    if(ret < 0) {
        perror(err_message);
        exit(ret);
    }

    return ret;
}

int main()
{
    // system("busybox ip l set lo up");

    union bpf_attr prog = {
        .prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
        .insn_cnt = 2,
        .insns = (uint64_t)(struct bpf_insn[]){
            {.code=BPF_ALU64|BPF_MOV|BPF_K, .dst_reg=BPF_REG_0, .imm=0},
            {.code=BPF_JMP|BPF_EXIT},
        },
        .license = (__u64) "",
    };

    int tcp_fd, listen_fd, accept_fd, bpf_fd, kcm_fd, mux_fd;

    struct sockaddr_in addr = {
        .sin_family = AF_INET,
        .sin_port = htons(3270),
        .sin_addr.s_addr = inet_addr("127.0.0.1")
    };
    
    check_error( listen_fd = socket(AF_INET, SOCK_STREAM, 0), "socket(tcp)" );
    check_error( bind(listen_fd, (void *)&addr, sizeof(addr)), "bind" ); 
    check_error( listen(listen_fd, 1), "listen" );
    
    check_error( tcp_fd = socket(AF_INET, SOCK_STREAM, 0), "socket(tcp)" );
    check_error( connect(tcp_fd, (void *)&addr, sizeof(addr)), "connect" ); 

    check_error( bpf_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &prog, 48), "bpf" );
    check_error( mux_fd = socket(AF_KCM, SOCK_SEQPACKET, 0), "socket(mux)" );

    check_error( ioctl(mux_fd, SIOCKCMCLONE, &kcm_fd), "clone" );

    struct kcm_attach attach = {tcp_fd, bpf_fd};
    check_error( ioctl(mux_fd, SIOCKCMATTACH, &attach), "attach" );

    size_t msg_len = (1<<24);
    struct iovec iov = {
        .iov_base = mmap(NULL, msg_len, PROT_READ, MAP_SHARED | MAP_ANONYMOUS, -1, 0),
        .iov_len = msg_len,
    };

    struct msghdr msg = {
        .msg_name = "R",
        .msg_namelen = 1,
        .msg_iov = &iov,
        .msg_iovlen = 1,
        0
    };

    check_error( sendmsg(kcm_fd, &msg, MSG_EOR), "sendmsg" );

    printf("Wait 30s for worker threads to finish\n");
    sleep(30);

    if (fork() == 0) {
        sleep(1);
        printf("Calling close from child\n");
        check_error( close(kcm_fd), "close(kcm) (child)" );   

        printf("Child done\n");
    } else {
        check_error( close(kcm_fd), "close(kcm) (parent)" );

        sleep(1);

        printf("Calling unattach from parent\n");
        struct kcm_unattach unattach = {tcp_fd};    
        check_error( ioctl(mux_fd, SIOCKCMUNATTACH, &unattach), "unattach" );

        printf("Parent done\n");
        int wstatus;
        wait(&wstatus);
    }
}

