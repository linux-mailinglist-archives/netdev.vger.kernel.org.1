Return-Path: <netdev+bounces-192350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D922FABF8C6
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 17:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8CEA22817
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 15:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DB721578F;
	Wed, 21 May 2025 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4ok8kMb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4033121D3E2
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839379; cv=none; b=LTPMrDsXHjkJ7MIH1i0aAwZo9r4lot9HuL9yZDrqw7BySCsei4+yYGkLQ/v0LlYhNdiVgg+W4AxXKw5BZ+6hyspqL7COobwNlvqPPKkUAelDWYuRNtMPRiCYK7B+TP2LmaAFZzhiy27jX6uwVe/psrvmvyRVS4HXVHZUcENfng0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839379; c=relaxed/simple;
	bh=4+Wj4hxdaXN96SjUIAfwiVesd+p9hyy1LELAnrGN8UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C38o7iMPfX+B+LoWgw7WhV6j0F5XKV0TcC5TxTUJm7QzVD9Oq+sVyfrVgiG9aByxLsaJwglXKzkmkxin6WarZxJk+XzfjoX3zxRU/uAI9o5W/tdIJreUiJRE+78YFGRTEL9KFzJUTf68/fDJ9RyGqE+FNX7asW0v90Nqv4ZglpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4ok8kMb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747839377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JSCBFcNuY0Goh2S9d5LToDFwcxHuL80JaO8Gh+v1hTQ=;
	b=Z4ok8kMbqYfNmgLVlMcdUXsC841s18DPkXoA7VRrwciooIk81EgWrz0dH+Hf3lzsHGtF+/
	Zf9kxXZclokOxjhNqyGkaskSirtsTPct0JRKK+e4Nbp9WUjOF2u5/w+kcd90uzfMDNHmhf
	HQV58JAxbf+t0zD0I+wC9NpEddY8adI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-HlZ3e3s6Ppu-hNBD_PsEjw-1; Wed, 21 May 2025 10:56:15 -0400
X-MC-Unique: HlZ3e3s6Ppu-hNBD_PsEjw-1
X-Mimecast-MFC-AGG-ID: HlZ3e3s6Ppu-hNBD_PsEjw_1747839374
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ad5669ab33bso344924666b.3
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 07:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747839374; x=1748444174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSCBFcNuY0Goh2S9d5LToDFwcxHuL80JaO8Gh+v1hTQ=;
        b=JDDwOHA0WejCUvDiebS7njSk3HvTPxsBRMODSvmf2Cfo8RW7g9s6wMInDsuRvPvOMR
         Gz+sGXpWbhFuJA8xhH5d+PR0XP3izHxEYJOI/gILvanPD6ZnGwT2fAZ3LS/BDlnfcJEv
         RxHXBR/iz+k6yVT4+gloDNO0e1KkvVtwS6QJw232izauuSqWYnbzQqZuU4cdhCULFE8b
         LnqLWOWmhkkfRgfkuMlE2TUfGs4ty3MpMpyST8UO3r/q6SPIYs1IYlJdYE3wjFimDQ17
         FT1Wnm20Gp9tLy1L1WMISaRH0kjHB0ZSZ5ThgGyA3GvWCKzJ+7YgVt1+TuDTekwNQDHI
         AHqg==
X-Forwarded-Encrypted: i=1; AJvYcCU9wuGouYs3z7vborB3uA3Mx6aqPABK+VRu9XfgczbSaVRH/+r5jamcClkKq+h7cF4ykyQEXoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAUhMhxuGSX86H3RUrK932wyFSJ1dOMvns3CV8/dTc5XBe9zGm
	4KujechavL037vajjxAgkKViJH4j8r/c44OC6POAbWEe3NkC3gGSqBIlkRG2FsocR5KD5/phR/i
	U3IV5Vd5192WXhDNtrqYhwihROuFp3ZAtHfx+5miy2Lc2IjeJA9+xU8FKig==
X-Gm-Gg: ASbGncsrzRfu9z/O8hQ/vXevmGcVfX/l5ZRHJhsbjVzzh7FmwI93WN5pbm5k0W3heRm
	3gaa+dBbL1YwcBVBSi0JhEF53l1G0GyLUXXwpPd8E4hwXDylkkuIeeaDxkc+uPc6TiWeEZLxxMc
	cD9tnonZ6IjHn3S/1CK8hZB8520C+UvBr90LaV434DXcMSg6YoLenARVfpo6TQu1QgZue+g4fLq
	rtZ1oA0YOyUbQpv5aP8eNqoWqaHm3gZNECaTVwbV6u4jWoWAP5WchGUJfSihnugk8i9ZmLcZIzj
	eKGpX6FFOs8xVNIH7m35yykO85Bnqt51vyrr9OR55GM0rz3OumM+l2L2KiRg
X-Received: by 2002:a17:907:9495:b0:ace:d710:a8d1 with SMTP id a640c23a62f3a-ad52d4dae84mr1752074966b.24.1747839374460;
        Wed, 21 May 2025 07:56:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpoMMbzNscVWDbJ9f7DsJa/QwbA0pdV/T5aW3r3Yle27irZapU6e/PHt7khHjWn7nACqdpnQ==
X-Received: by 2002:a17:907:9495:b0:ace:d710:a8d1 with SMTP id a640c23a62f3a-ad52d4dae84mr1752071266b.24.1747839373682;
        Wed, 21 May 2025 07:56:13 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d278290sm905573266b.78.2025.05.21.07.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 07:56:13 -0700 (PDT)
Date: Wed, 21 May 2025 16:56:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v5 5/5] vsock/test: Add test for an unexpectedly
 lingering close()
Message-ID: <edtepfqev6exbkfdnyzgkdkczif5wnn4oz4t5sxkl6sz64kcaf@f6yztxryvmlq>
References: <20250521-vsock-linger-v5-0-94827860d1d6@rbox.co>
 <20250521-vsock-linger-v5-5-94827860d1d6@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250521-vsock-linger-v5-5-94827860d1d6@rbox.co>

On Wed, May 21, 2025 at 12:55:23AM +0200, Michal Luczaj wrote:
>There was an issue with SO_LINGER: instead of blocking until all queued
>messages for the socket have been successfully sent (or the linger timeout
>has been reached), close() would block until packets were handled by the
>peer.
>
>Add a test to alert on close() lingering when it should not.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 49 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 49 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f401c6a79495bc7fda97012e5bfeabec7dbfb60a..1040503333cf315e52592c876f2c1809b36fdfdb 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1839,6 +1839,50 @@ static void test_stream_linger_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void test_stream_nolinger_client(const struct test_opts *opts)
>+{
>+	bool nowait;
>+	time_t ns;
>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	enable_so_linger(fd);

If we use a parameter for the linger timeout, IMO will be easy to 
understand this test, defining the timeout in this test, set it and 
check the value, without defining LINGER_TIMEOUT in util.h.

>+	send_byte(fd, 1, 0); /* Left unread to expose incorrect behaviour. */
>+	nowait = vsock_wait_sent(fd);
>+
>+	ns = current_nsec();
>+	close(fd);
>+	ns = current_nsec() - ns;
>+
>+	if (nowait) {
>+		fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
>+	} else if ((ns + NSEC_PER_SEC - 1) / NSEC_PER_SEC >= LINGER_TIMEOUT) {

Should we define a macro for this conversion?

Or just use DIV_ROUND_UP:

--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1831,7 +1831,7 @@ static void test_stream_nolinger_client(const struct test_opts *opts)

         if (nowait) {
                 fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
-       } else if ((ns + NSEC_PER_SEC - 1) / NSEC_PER_SEC >= LINGER_TIMEOUT) {
+       } else if (DIV_ROUND_UP(ns, NSEC_PER_SEC) >= LINGER_TIMEOUT) {
                 fprintf(stderr, "Unexpected lingering\n");
                 exit(EXIT_FAILURE);
         }

The rest LGTM.

Thanks,
Stefano

>+		fprintf(stderr, "Unexpected lingering\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("DONE");
>+}
>+
>+static void test_stream_nolinger_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("DONE");
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1999,6 +2043,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_linger_client,
> 		.run_server = test_stream_linger_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM SO_LINGER close() on unread",
>+		.run_client = test_stream_nolinger_client,
>+		.run_server = test_stream_nolinger_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.49.0
>


