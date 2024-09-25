Return-Path: <netdev+bounces-129635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C47EF984F72
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 02:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB9D1F23F2A
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 00:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB141849;
	Wed, 25 Sep 2024 00:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="YBrP35Nn"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CDD79F0
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727223779; cv=none; b=prgzZjjRC/O52tzBeB17I3XghnmbQQGTmK04VCCodaeG5DBWtITy8whnfx13bXEipKmd3QMRsLNY2vJSQtGs5xK39GRoBjl+PtZ0NhFsK0PBpWXua6pG9HwYV5Mv1DvAmn6QNsRUU1XuMb6zqXNZyFKfi53S7zJpj/OKX8Zxzd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727223779; c=relaxed/simple;
	bh=0jXLrafJtwIXAd8BxCyimdleDmsJ9bnEXMXVDYluXEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsaHPs299mheZoqMvvQE76X5wrkff0IHxMzy5dNGpz8Eg5LIRkiyiA4tW8daTBsFn1A8uX++80290bGOPN8NfGD22HWQgr42or/j1bMcJVfIrjEx9RWL6Mfd+ZeS3UyqqZZ2PlVC+43CE6ERuQIumrqq3C71TKbxyx+vtq1k6Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=YBrP35Nn; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1stFnv-003DNN-6D; Wed, 25 Sep 2024 02:22:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=zZVOnhwTG9BSe3DJfoVD/ExKy78VboL31oJ9UPzhnOc=; b=YBrP35NnbBvbQOeLyeLOBucBD+
	jCJb/7h6bJHXkUza323NJP+YD9gM5SXJtRcV+FIMuefbL1Hq40yoCOwFaPTylouRg1twYG3oTw4pd
	Tsm9b9i/nB6rTwbypn1+hSe0YTfw0kwbQxVFCy9VsG50DQR2mXWPCOQZkPsFhiuU5YOEq0h1QQZnI
	E6cn3u5Z3x1lO05NWxhdK2oMxuCYdpEBxH34s5u44pObpXJwK4Ynx0YG2ZrYFgMUvZ+3Jkde43ifh
	Asarz6PAEILF6B/G2NVupFvePQqtSeKccBgsj/kmEZV5OuOfezcGesE7YOvj1+GZiIS0WdzQN6E2B
	cKocVdlg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1stFnu-0005x8-3c; Wed, 25 Sep 2024 02:22:50 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1stFnl-005h1u-4i; Wed, 25 Sep 2024 02:22:41 +0200
Message-ID: <08ffafc3-ddbb-48a4-99f7-d5694184f686@rbox.co>
Date: Wed, 25 Sep 2024 02:22:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: sockmap: avoid race between
 sock_map_destroy() and sk_psock_put()
To: Paolo Abeni <pabeni@redhat.com>, Dmitry Antipov <dmantipov@yandex.ru>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com,
 Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20240910114354.14283-1-dmantipov@yandex.ru>
 <1940b2ab-2678-45cf-bac8-9e8858a7b2ee@redhat.com>
 <b9ff79ae-e42b-4f9c-b32f-a86b1e48f0cd@yandex.ru>
 <80a295b9-8528-4f37-981c-29dc07d3053f@redhat.com>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
Autocrypt: addr=regenrecht@o2.pl; keydata=
 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
In-Reply-To: <80a295b9-8528-4f37-981c-29dc07d3053f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/24 10:23, Paolo Abeni wrote:
> ...
> I guess that the main point in Cong's feedback is that a sockmap update 
> is not supposed to race with sock_map_destroy() (???) @Cong, @John, 
> @JakubS: any comments on that?

In somewhat related news: sock_map_unhash() races with the update, hitting
WARN_ON_ONCE(saved_unhash == sock_map_unhash).

CPU0					CPU1
====					====

BPF_MAP_DELETE_ELEM
  sk_psock_drop()
    sk_psock_restore_proto
    rcu_assign_sk_user_data(NULL)
    					shutdown()
					  sock_map_unhash()
					    psock = sk_psock(sk)
					    if (unlikely(!psock)) {
BPF_MAP_UPDATE_ELEM
  sock_map_init_proto()
    sock_replace_proto
					      saved_unhash = READ_ONCE(sk->sk_prot)->unhash;
					    }
					    if (WARN_ON_ONCE(saved_unhash == sock_map_unhash))
					      return;

[   20.860668] WARNING: CPU: 1 PID: 1238 at net/core/sock_map.c:1641 sock_map_unhash+0xa1/0x220
[   20.860686] CPU: 1 UID: 0 PID: 1238 Comm: a.out Not tainted 6.11.0+ #59
[   20.860688] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[   20.860705] Call Trace:
[   20.860706]  <TASK>
[   20.860725]  unix_shutdown+0xb0/0x470
[   20.860728]  __sys_shutdown+0x7a/0xa0
[   20.860731]  __x64_sys_shutdown+0x10/0x20
[   20.860733]  do_syscall_64+0x93/0x180
[   20.860788]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Under VM it takes about 10 minutes to trigger the splat:

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/un.h>
#include <sys/syscall.h>
#include <sys/socket.h>
#include <linux/bpf.h>

int s[2], sockmap;

static void die(char *msg)
{
	perror(msg);
	exit(-1);
}

static int create_sockmap(int key_size, int value_size, int max_entries)
{
	union bpf_attr attr = {
		.map_type = BPF_MAP_TYPE_SOCKMAP,
		.key_size = key_size,
		.value_size = value_size,
		.max_entries = max_entries
	};

	int map = syscall(SYS_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
	if (map < 0)
		die("bpf_create_map");

	return map;
}

static void map_update_elem(int map_fd, int key, void *value, uint64_t flags)
{
	union bpf_attr attr = {
		.map_fd = map_fd,
		.key = (uint64_t)&key,
		.value = (uint64_t)value,
		.flags = flags
	};

	syscall(SYS_bpf, BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr));
}

static void map_del_elem(int map_fd, int key)
{
	union bpf_attr attr = {
		.map_fd = map_fd,
		.key = (uint64_t)&key
	};

	syscall(SYS_bpf, BPF_MAP_DELETE_ELEM, &attr, sizeof(attr));
}

static void *racer_del(void *unused)
{
	for (;;)
		map_del_elem(sockmap, 0);

	return NULL;
}
static void *racer_update(void *unused)
{
	for (;;)
		map_update_elem(sockmap, 0, &s[0], BPF_ANY);

	return NULL;
}

int main(void)
{
	pthread_t t0, t1;

	if (pthread_create(&t0, NULL, racer_del, NULL))
		die("pthread_create");

	if (pthread_create(&t1, NULL, racer_update, NULL))
		die("pthread_create");

	sockmap = create_sockmap(sizeof(int), sizeof(int), 1);

	for (;;) {
		if (socketpair(AF_UNIX, SOCK_STREAM, 0, s) < 0)
			die("socketpair");

		map_update_elem(sockmap, 0, &s[0], BPF_ANY);
		shutdown(s[1], 0);

		close(s[0]);
		close(s[1]);
	}
}

With mdelay(1) it's a matter of seconds:

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 724b6856fcc3..98a964399813 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1631,6 +1631,7 @@ void sock_map_unhash(struct sock *sk)
 	psock = sk_psock(sk);
 	if (unlikely(!psock)) {
 		rcu_read_unlock();
+		mdelay(1);
 		saved_unhash = READ_ONCE(sk->sk_prot)->unhash;
 	} else {
 		saved_unhash = psock->saved_unhash;

I've tried the patch below and it seems to do the trick

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 724b6856fcc3..a384771a66e8 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1627,6 +1627,7 @@ void sock_map_unhash(struct sock *sk)
 	void (*saved_unhash)(struct sock *sk);
 	struct sk_psock *psock;
 
+	lock_sock(sk);
 	rcu_read_lock();
 	psock = sk_psock(sk);
 	if (unlikely(!psock)) {
@@ -1637,6 +1638,7 @@ void sock_map_unhash(struct sock *sk)
 		sock_map_remove_links(sk, psock);
 		rcu_read_unlock();
 	}
+	release_sock(sk);
 	if (WARN_ON_ONCE(saved_unhash == sock_map_unhash))
 		return;
 	if (saved_unhash)

but perhaps what needs to be fixed instead is af_unix shutdown()?
CCing Kuniyuki.

thanks,
Michal


