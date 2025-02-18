Return-Path: <netdev+bounces-167243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303FDA39656
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 10:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F113A7840
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 08:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEEE22F147;
	Tue, 18 Feb 2025 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inZgeTAE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFF22E002
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868734; cv=none; b=amqYls6AgqyV5/MMsJvorGKzNv/tnRuEeQQRZByyRomnoq4SToupja4ammH2rgtm+u4eCRYBEOmZE+olS2qk8y4jBMptBH+SKFu78hQP8QFkYKNBq4voKWoBEeE940eFqr7vVV3OyOFAjhKJCjbShKjsGXx1Pq/BXQN7/oecG+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868734; c=relaxed/simple;
	bh=qImDM2Aoz3Snnaan8A7pazPLk5kgxVW4GXVujSQsLH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIpNw9pUGgfMfV6/+s3pQJVNa+N96Y5uzKj5SBfHwIRREE9nIavmveCEqHcFjTILt02YWyadD/hxswB/T9JbKSEFh0n+dT2PMuApgtioruiB1FYAiKoDkqrHoGYK0vvT3OpSNS4aSR8EWFTnTvMwTdgbGpGj8uQyAQ1hBNB397U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inZgeTAE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739868731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/40cidM9GqDVrc7T4DzVHlbImaecKAWNvPg5rw21iA8=;
	b=inZgeTAEkAgB3k+Nq6TemODsnVHFOqFJWDfwqldJeVmF/0zE0abz0PqhwRjlCNbhstr2uk
	rO91FF9yGC3TwPlgucl6c0TMlIDn3eeAgMccBZIU92pbzqItXDgG9uG8gRgQ/mwt0juqce
	C8/hga2CD4sNAs6WB79fionVU0MeMv8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-E4uLx68LP12ffZbvm6dUAw-1; Tue, 18 Feb 2025 03:52:09 -0500
X-MC-Unique: E4uLx68LP12ffZbvm6dUAw-1
X-Mimecast-MFC-AGG-ID: E4uLx68LP12ffZbvm6dUAw_1739868728
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f44be93a8so1009284f8f.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 00:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868728; x=1740473528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/40cidM9GqDVrc7T4DzVHlbImaecKAWNvPg5rw21iA8=;
        b=j0TE0/uJW7Z0I83gHjoo+9gj9wImnWtQukuL9u4n1altaDkeeIYX1RQerBYe1uxoWO
         Q5LoRa9ExpzUVY8z+E57SGMObTUQFiA219Yxdm80ncU3Vr4XWgVIyMFl0xvRa09yS6WR
         Dbk8pFwrjNocSlKBx7nKrysQZ0JZrz+brs1QQGYM70r022UUrVh/YTZsbe0rdddGT/u5
         ZtWWsYH1dNNYJYfO05vbYC+uMa17b8NyqolCJY9m4TMlupoPgDZuNjp7qYEhfDhd9T1X
         W1IWC3vhOum3lhyc+A45BCy05A8EdC3bA0HtGK6ykv3+MSYuSkxG+j2z0fXe65MB17Yo
         1C7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJvm9RCNFmllcce8AGeenZ5EwGZAftiqvVKBHKhyygFmmxsCX+uky+rEPnERzQvBMz0+QNrI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHdAv83v0ey0LjbxOkqDRRsoHcX9SCg4Tru0o1yU48Qi1FB2FE
	Sn7UaESQUuF8qz0ywMxzpnykwwi9CWEmhP5HFyL2K9mWJ7poO6FvWE9mQJ7+3maBO3SG7v2v7VX
	D3RZ6gwtJLUlf7XB84NKXmvKvbA578VZVq3xknLaioFgpWxsR1dJAMg==
X-Gm-Gg: ASbGnctv43cdu96mkQ/w+DEV372qT9xhkA+p1ZsHspoihB80EjE4YNDzKACZyLTTu7w
	/uhb6pJLMyQcjYskgpcU84Sr8ODB0Vpo39ZOAHDU4zEGiBpMZak4FoX967S1V4p4K0jusEcNOpF
	SfumwoS0JBWqiHQ2TCxyVoMz4deBlQ+SgCZ14hUmZUFZ9990dRhMNv6Y5iCMKifYM0KhZqBvX1m
	7IMMmZDZBbqTICxdWQFnheSzAn7wNEtWOxplZkq3lvKhEuiU97lsYRf/KaPqddb8PqmmjPIfFtw
	lrOQ7s093olfVHhpWEniyE2jdLsx4WVCWTTIrAqfirvqxRn+AhabiQ==
X-Received: by 2002:a05:6000:4023:b0:38f:483f:8319 with SMTP id ffacd0b85a97d-38f483f873emr5435482f8f.51.1739868728431;
        Tue, 18 Feb 2025 00:52:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC8X151MW+xEw5lnrOeLO/RfeyoGSXgW9uEKgZVTfGtKVJttz9myB5BqQJ3iioFx+lN1s7Ag==
X-Received: by 2002:a05:6000:4023:b0:38f:483f:8319 with SMTP id ffacd0b85a97d-38f483f873emr5435418f8f.51.1739868727721;
        Tue, 18 Feb 2025 00:52:07 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65bcsm14463188f8f.65.2025.02.18.00.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:52:07 -0800 (PST)
Date: Tue, 18 Feb 2025 09:52:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 1/4] sockmap, vsock: For connectible sockets allow
 only connected
Message-ID: <yc5vdkuwpyrr7mfjp6ohqf4fzq4avgjh5pwrmox7rhipwnh7nk@26cyegopbks2>
References: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
 <20250213-vsock-listen-sockmap-nullptr-v1-1-994b7cd2f16b@rbox.co>
 <251be392-7cd5-4c69-bc02-12c794ea18a1@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <251be392-7cd5-4c69-bc02-12c794ea18a1@rbox.co>

On Fri, Feb 14, 2025 at 02:11:48PM +0100, Michal Luczaj wrote:
>> ...
>> Another design detail is that listening vsocks are not supposed to have any
>> transport assigned at all. Which implies they are not supported by the
>> sockmap. But this is complicated by the fact that a socket, before
>> switching to TCP_LISTEN, may have had some transport assigned during a
>> failed connect() attempt. Hence, we may end up with a listening vsock in a
>> sockmap, which blows up quickly:
>>
>> KASAN: null-ptr-deref in range [0x0000000000000120-0x0000000000000127]
>> CPU: 7 UID: 0 PID: 56 Comm: kworker/7:0 Not tainted 6.14.0-rc1+
>> Workqueue: vsock-loopback vsock_loopback_work
>> RIP: 0010:vsock_read_skb+0x4b/0x90
>> Call Trace:
>>  sk_psock_verdict_data_ready+0xa4/0x2e0
>>  virtio_transport_recv_pkt+0x1ca8/0x2acc
>>  vsock_loopback_work+0x27d/0x3f0
>>  process_one_work+0x846/0x1420
>>  worker_thread+0x5b3/0xf80
>>  kthread+0x35a/0x700
>>  ret_from_fork+0x2d/0x70
>>  ret_from_fork_asm+0x1a/0x30
>
>Perhaps I should have expanded more on the null-ptr-deref itself.
>
>The idea is: force a vsock into assigning a transport and add it to the
>sockmap (with a verdict program), but keep it unconnected. Then, drop
>the transport and set the vsock to TCP_LISTEN. The moment a new
>connection is established:
>
>virtio_transport_recv_pkt()
>  virtio_transport_recv_listen()
>    sk->sk_data_ready(sk)            i.e. sk_psock_verdict_data_ready()
>      ops->read_skb()                i.e. vsock_read_skb()
>        vsk->transport->read_skb()   vsk->transport is NULL, boom
>

Yes I agree, it's a little clearer with this, but I think it was also 
clear the concept before. So with or without:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


>Here's a stand-alone repro:
>
>/*
> * # modprobe -a vsock_loopback vhost_vsock
> * # gcc test.c && ./a.out
> */
>#include <stdio.h>
>#include <stdint.h>
>#include <stdlib.h>
>#include <unistd.h>
>#include <errno.h>
>#include <sys/socket.h>
>#include <sys/syscall.h>
>#include <linux/bpf.h>
>#include <linux/vm_sockets.h>
>
>static void die(const char *msg)
>{
>	perror(msg);
>	exit(-1);
>}
>
>static int sockmap_create(void)
>{
>	union bpf_attr attr = {
>		.map_type = BPF_MAP_TYPE_SOCKMAP,
>		.key_size = sizeof(int),
>		.value_size = sizeof(int),
>		.max_entries = 1
>	};
>	int map;
>
>	map = syscall(SYS_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
>	if (map < 0)
>		die("map_create");
>
>	return map;
>}
>
>static void map_update_elem(int fd, int key, int value)
>{
>	union bpf_attr attr = {
>		.map_fd = fd,
>		.key = (uint64_t)&key,
>		.value = (uint64_t)&value,
>		.flags = BPF_ANY
>	};
>
>	if (syscall(SYS_bpf, BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr)))
>		die("map_update_elem");
>}
>
>static int prog_load(void)
>{
>	/* mov %r0, 1; exit */
>	struct bpf_insn insns[] = {
>		{ .code = BPF_ALU64 | BPF_MOV | BPF_K, .dst_reg = 0, .imm = 1 },
>		{ .code = BPF_JMP | BPF_EXIT }
>	};
>	union bpf_attr attr = {
>		.prog_type = BPF_PROG_TYPE_SK_SKB,
>		.insn_cnt = sizeof(insns)/sizeof(insns[0]),
>		.insns = (long)insns,
>		.license = (long)"",
>	};
>	
>	int prog = syscall(SYS_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
>	if (prog < 0)
>		die("prog_load");
>
>	return prog;
>}
>
>static void link_create(int prog_fd, int target_fd)
>{
>	union bpf_attr attr = {
>		.link_create = {
>			.prog_fd = prog_fd,
>			.target_fd = target_fd,
>			.attach_type = BPF_SK_SKB_VERDICT
>		}
>	};
>
>	if (syscall(SYS_bpf, BPF_LINK_CREATE, &attr, sizeof(attr)) < 0)
>		die("link_create");
>}
>
>int main(void)
>{
>	struct sockaddr_vm addr = {
>		.svm_family = AF_VSOCK,
>		.svm_cid = VMADDR_CID_LOCAL,
>		.svm_port = VMADDR_PORT_ANY
>	};
>	socklen_t alen = sizeof(addr);
>	int s, map, prog, c;
>
>	s = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
>	if (s < 0)
>		die("socket");
>
>	if (bind(s, (struct sockaddr *)&addr, alen))
>		die("bind");
>
>	if (!connect(s, (struct sockaddr *)&addr, alen) || errno != ECONNRESET)
>		die("connect #1");
>
>	map = sockmap_create();
>	prog = prog_load();
>	link_create(prog, map);
>	map_update_elem(map, 0, s);
>
>	addr.svm_cid = 0x42424242; /* non-existing */
>	if (!connect(s, (struct sockaddr *)&addr, alen) || errno != ESOCKTNOSUPPORT)
>		die("connect #2");
>
>	if (listen(s, 1))
>		die("listen");
>
>	if (getsockname(s, (struct sockaddr *)&addr, &alen))
>		die("getsockname");
>
>	c = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
>	if (c < 0)
>		die("socket c");
>
>	if (connect(c, (struct sockaddr *)&addr, alen))
>		die("connect #3");
>
>	return 0;
>}
>


