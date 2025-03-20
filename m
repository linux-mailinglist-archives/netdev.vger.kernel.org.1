Return-Path: <netdev+bounces-176449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130BEA6A651
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3033C1712D2
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 12:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BC61DF259;
	Thu, 20 Mar 2025 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="IYJDlksZ"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCB71DE3B1
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742474020; cv=none; b=SxhnjjflV8JiRR3AgsfaogPAPbMCdmxgGFgV3uyt3TC1PiiTBjCj3NmQwIJzM1ZRSf0nNWXq7qg78j2C+LfakJDmQA2elwBVeEhnwsVndchnyysdzSceLfqzFULxUg4LeP0A4H29oCcQLE6cS1Ew7WP913Sjfmv1oKjSCxe7L5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742474020; c=relaxed/simple;
	bh=m9r0AbXxI3hD3b/IDRiy8UewvP2qrBQybEza6MCZe80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dd1Ycb96BAcNOHDvVTXwto9yu5IBfZHHZ+krOlCqKFlNT/H8iOtCfiTuRf3vh4rkYJIPbFpZj2zDDI30yjCygOpxe8FICYX6PmocTEdBN+ae9spIFjm6nBamYBKu/J/v0ImW4i1fKTREBOtUPfdD2zBjNXjBNOhU3iSeyvV7pyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=IYJDlksZ; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tvF5N-0067IS-Uf; Thu, 20 Mar 2025 13:33:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=yXhMsCE0agUhqpYyGmOJUSGwpFIxlvTbhSiqHGBblFw=; b=IYJDlksZnXDwSzUWEpVLM0T2xz
	amE/duVv1f4Vdb5t54txFNX9uGSb7XxG1cWw/Xiqe+t3pxffQ0gJJm/sfgdA661+bbSYqEhAR5SWh
	jvL1xOqNj2zQIYacwkqUW+V6FpkeDqWrKoyChxTMgfX7QnEuHOzKmWWQXffZ1XcpqSESraZyBVq0x
	8ygPZSFYH7BPHUuoO4PhoU51X6nH2Q8QhLT+ySJb/5VZk/x3fpq20gKnLRbt8CJ237TuK83U5IvUQ
	FRT2uV2689hYsvXt94TQ47rulbG2nABYpf9QmW4DYAjmBAktoCjOoqB4jhV5fZvFlG2ga74lO3LPf
	YRfAXJkQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tvF5H-0006Hf-NK; Thu, 20 Mar 2025 13:33:15 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tvF4x-00HH1a-O0; Thu, 20 Mar 2025 13:32:55 +0100
Message-ID: <1e8c8e7a-23d9-4ed3-902a-8a4ba06f1f69@rbox.co>
Date: Thu, 20 Mar 2025 13:32:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/3] bpf, sockmap: avoid using sk_socket after
 free when sending
To: Jiayuan Chen <jiayuan.chen@linux.dev>, xiyou.wangcong@gmail.com,
 john.fastabend@gmail.com, jakub@cloudflare.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 sgarzare@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250317092257.68760-1-jiayuan.chen@linux.dev>
 <20250317092257.68760-2-jiayuan.chen@linux.dev>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <20250317092257.68760-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/25 10:22, Jiayuan Chen wrote:
> The sk->sk_socket is not locked or referenced, and during the call to
> skb_send_sock(), there is a race condition with the release of sk_socket.
> All types of sockets(tcp/udp/unix/vsock) will be affected.
> ...
> Some approach I tried
> ...
> 2. Increased the reference of sk_socket->file:
>    - If the user calls close(fd), we will do nothing because the reference
>      count is not set to 0. It's unexpected.

Have you considered bumping file's refcnt only for the time of
send/callback? Along the lines of:

static struct file *sock_get_file(struct sock *sk)
{
	struct file *file = NULL;
	struct socket *sock;

	rcu_read_lock();
	sock = sk->sk_socket;
	if (sock)
		file = get_file_active(&sock->file);
	rcu_read_unlock();

	return file;
}

static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
			       u32 off, u32 len, bool ingress)
{
	int err;

	if (!ingress) {
		struct sock *sk = psock->sk;
		struct file *file;
		...

		file = sock_get_file(sk);
		if (!file)
			return -EIO;

		err = skb_send_sock(sk, skb, off, len);
		fput(file);
		return err;
	}
	...
}

static void sk_psock_verdict_data_ready(struct sock *sk)
{
	struct file *file;
	...

	file = sock_get_file(sk);
	if (!file)
		return;

	copied = sk->sk_socket->ops->read_skb(sk, sk_psock_verdict_recv);
	fput(file);
	...
}


