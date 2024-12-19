Return-Path: <netdev+bounces-153153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6C89F7157
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2919F1890A09
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 00:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02E379C0;
	Thu, 19 Dec 2024 00:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="KIgwTA8i"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B529380;
	Thu, 19 Dec 2024 00:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734567965; cv=none; b=Nm87uNOpCP92aBktAk1ztWnG2Rlc5Ie2GUrSoG4gHQarMTXutVh8uCOcLtTspgLyRQeUMLhrlcmVacRqrMKVqWVlWfuD8KQKPakEhDYs3HQDKDEkXSua13jc6trJ5f1Mo/F9qcRCK7sk78vfsNXQMcqaW0WwOQo9uqyW5tB0n8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734567965; c=relaxed/simple;
	bh=Ik7Gh9XllpXEehIMUzBreugnNnoWolK+VcZLUNIvmQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWQpaj8U76HA1hJt6TDM/t+ww1LLWjOnb3Qair4Q9Aruii6UFwO3zCsTkwwqQG7kyMn6Oo67Jk5sZVsvhgHyKPF4iLceugowOtvsRKx8yFYHWzG4AU0cf5HcyxSwxpr9D5tKDMsLtcxLCYsyuG9Cf37187nPw/bksGpCCnHLT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=KIgwTA8i; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tO4MQ-006Eqz-5Z; Thu, 19 Dec 2024 01:25:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=k+DJS2pgh+FJsAXhHPOasPWju3JjAyGK9qdWeo88ra8=; b=KIgwTA8iLKwO5ZnrF4EDth0xW3
	Xnk1G7Cs7qZN85DkaIBk00PouzzctH70/cHsSGXxokzEHv8srZBoetjAQg7wDs6ppt2om2HXHTNy9
	D5TLPrZdFpM2zXD/i90crMovqHR2SEWDTeYUfmRCElfyY6Dbv3JNyE4pOEhc7FWc28FkCt0pb3tVM
	DKe7dMAh3jXngJhuST2r2SEFtCON6E5j1uB+C2oQSITCVtY3chZHQPWBpv3PH54Br2cuHpFgjFG7S
	/jSgMhU6FF1dTyEC/6PBVG6IpEBfyUFTHMJYlv3163SC+yEnr2V9mtLK4pZVXd7tDrbqkSZ4rSBmZ
	XQMA0Z7Q==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tO4MO-0001Xh-Uw; Thu, 19 Dec 2024 01:25:49 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tO4MC-00AgrT-34; Thu, 19 Dec 2024 01:25:36 +0100
Message-ID: <5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co>
Date: Thu, 19 Dec 2024 01:25:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
To: Hyunwoo Kim <v4bel@theori.io>, Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, qwerty@theori.io,
 imv4bel@gmail.com
References: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>
 <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>
 <Z2LZ3HK05RH8OfP5@v4bel-B760M-AORUS-ELITE-AX>
 <s2k74f6zvjm7uexqfyej6txvoqgf6lkaa47igo2eh4pq55d4n2@wnrrcr6aa6lk>
 <f7a3rlgpc36wk75grqeg6ndqmlprvilznlsesyruqfb7m5vrp7@myil7ex4f62n>
 <Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
Autocrypt: addr=regenrecht@o2.pl; keydata=
 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
In-Reply-To: <Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/18/24 16:51, Hyunwoo Kim wrote:
> On Wed, Dec 18, 2024 at 04:31:03PM +0100, Stefano Garzarella wrote:
>> On Wed, Dec 18, 2024 at 03:40:40PM +0100, Stefano Garzarella wrote:
>>> On Wed, Dec 18, 2024 at 09:19:08AM -0500, Hyunwoo Kim wrote:
>>>> At least for vsock_loopback.c, this change doesn’t seem to introduce any
>>>> particular issues.
>>>
>>> But was it working for you? because the check was wrong, this one should
>>> work, but still, I didn't have time to test it properly, I'll do later.
>>>
>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>> index 9acc13ab3f82..ddecf6e430d6 100644
>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>> @@ -1628,8 +1628,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>>>        lock_sock(sk);
>>> -       /* Check if sk has been closed before lock_sock */
>>> -       if (sock_flag(sk, SOCK_DONE)) {
>>> +       /* Check if sk has been closed or assigned to another transport before
>>> +        * lock_sock
>>> +        */
>>> +       if (sock_flag(sk, SOCK_DONE) || vsk->transport != &t->transport) {
>>>                (void)virtio_transport_reset_no_sock(t, skb);
>>>                release_sock(sk);
>>>                sock_put(sk);

Hi, I got curious about this race, my 2 cents:

Your patch seems to fix the reported issue, but there's also a variant (as
in: transport going null unexpectedly) involving BPF:

/*
$ gcc vsock-transport.c && sudo ./a.out

BUG: kernel NULL pointer dereference, address: 00000000000000a0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 12faf8067 P4D 12faf8067 PUD 113670067 PMD 0
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 15 UID: 0 PID: 1198 Comm: a.out Not tainted 6.13.0-rc2+
RIP: 0010:vsock_connectible_has_data+0x1f/0x40
Call Trace:
 vsock_bpf_recvmsg+0xca/0x5e0
 sock_recvmsg+0xb9/0xc0
 __sys_recvfrom+0xb3/0x130
 __x64_sys_recvfrom+0x20/0x30
 do_syscall_64+0x93/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
*/

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <linux/bpf.h>
#include <linux/vm_sockets.h>

static void die(const char *msg)
{
	perror(msg);
	exit(-1);
}

static int create_sockmap(void)
{
	union bpf_attr attr = {
		.map_type = BPF_MAP_TYPE_SOCKMAP,
		.key_size = sizeof(int),
		.value_size = sizeof(int),
		.max_entries = 1
	};
	int map;

	map = syscall(SYS_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
	if (map < 0)
		die("create_sockmap");

	return map;
}

static void map_update_elem(int fd, int key, int value)
{
	union bpf_attr attr = {
		.map_fd = fd,
		.key = (uint64_t)&key,
		.value = (uint64_t)&value,
		.flags = BPF_ANY
	};

	if (syscall(SYS_bpf, BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr)))
		die("map_update_elem");
}

int main(void)
{
	struct sockaddr_vm addr = {
		.svm_family = AF_VSOCK,
		.svm_port = VMADDR_PORT_ANY,
		.svm_cid = VMADDR_CID_LOCAL
	};
	socklen_t alen = sizeof(addr);
	int map, s;

	map = create_sockmap();

	s = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
	if (s < 0)
		die("socket");

	if (!connect(s, (struct sockaddr *)&addr, alen))
		die("connect #1");
	perror("ok, connect #1 failed; transport set");

	map_update_elem(map, 0, s);

	addr.svm_cid = 42;
	if (!connect(s, (struct sockaddr *)&addr, alen))
		die("connect #2");
	perror("ok, connect #2 failed; transport unset");

	recv(s, NULL, 0, 0);
	return 0;
}


