Return-Path: <netdev+bounces-251823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO4rMxShcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:49:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B96F54AB1
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90A0D56ADB7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CCF423A78;
	Wed, 21 Jan 2026 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GXKrljIB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C273C1964
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988175; cv=none; b=tBuV3SnNgI2KESiwiMcHMn7+U08NcHZPvVqrGZ+Hu8fxZEzbxuPCh/FGWEFTyHratVHw7FfWLtIYGT4Uo4Cs0tf49OmTse6XoUx+3PB7qUM1JR/87J2eWiuGHjKDuF9cZyPviKJk+hyoMXgttUfXwVeBsnM5JgSV5vt8kJewoJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988175; c=relaxed/simple;
	bh=VePwZWQjyG/lkPhMD1doEoS8+SnaSICnkySCxMdC+eY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FrA8+EYsC5MbbnzSqD5heo0ZeUMFZB7vzP26o6DNGeNwx9v43382shvlEPDqAkTQmqkHKEC8yS8Sa9dTIyQIxi37O8LtSQhWqxi1ZZn5vq2sLmDn1I3UmDml/QsBMM+InSyGKPDa4GJMall5OyHLPZf0dT7RugVpT0XzXAJFPcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GXKrljIB; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b870cbd1e52so904785166b.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768988171; x=1769592971; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFiYtaE993SXtVFhxzqlZeFKLdnPF4/n1BfwiEy+DPc=;
        b=GXKrljIBTT1sJWJysykALAO2h+4+wWWolgRcQRxh1nKk9IYjZPeB+Yb+7ODE+US+Tx
         M1d7uBiv6jg56zM6FrtQQf/pqGY+cywC9P1vMIuGtEBAh3PLgfHPH2KcrzFtIscflHHf
         fDXNeBSFSrYKZRLKBkJc2ROKS8YdJiwGdDjTSIO4F0FpOAkjSQNj9nCSMlWdHLR/NRTK
         M7lAnUDeWs1UAKsVgUy7osW/vVwWRsSlQzVq2H82NukpK3m9do82M1ViQrCI7DKk76ri
         FstzaccecQC/7JSvN1hvTTpDO/49QtMTJiGEN7pyVarTgJqObl75ziNCI24W19vyCjzF
         ADHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988171; x=1769592971;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFiYtaE993SXtVFhxzqlZeFKLdnPF4/n1BfwiEy+DPc=;
        b=d+2172o3C+vzrlLUwqbOzrgItjsEdKaWgy9RJwVOp8dHQ6Ehbv5+11lUcpCpzAgIPx
         Er/z+RirfQ7MQSkNOCC47mBtX++w/T5E55OwVFeLjMjvNfejij7B78s3GST4l7GC9/DO
         Hhluqykt4fMjPFYrxYgTU8aW2jq22Zfv3LdNpEJcb4pfl1cww9bbjXWT+L0o83dIHFgy
         HGP4Ya9ieHGS5J70f2zqbp3tuy8CtiPk7ZcKV7OaaGShm4U7Fwyx1t5T/mMLxjt31Sk1
         3IWJUO6Kv0Dapfg7D17t/ZDbazAHQUjvEkRcfpxEb9ZpWVFtStJ4TVoTdH2VKZh1Q/ww
         /RLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRFy3Fk9FDr4BBtTLz04Fj3GsR1vyVCmC7WJysHDb/JGatG4MphUz1/vAD+5GFBr5eOEYHsOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4rpSy0ic3innQp5AO44Ph12n8Fx+g49cL5mSPFBgeOSwtqsdU
	VpMuttyWtUeFVl0fCzvBLnXf4vb8yU6GeSttejQBQnQNLtzcPPXWqEOTqhJVm68jlg0=
X-Gm-Gg: AZuq6aLmVe3aeSXH8xvO4osMWNN4ppRzfBtlld+f3DZs53Qvby+Ry6v6yh8CpohaP+t
	ASdCs+rsTSc8kZyrxTwUrUrpXyu8KWuIcfZC5sWwhAHML611G+/Q8dnZS3Id6fTwBoqds2txgy/
	sm7N6Uh6mvbQ1hhtbx8fSn0FytUyISMJMUUYeURJ/16CFikDJcbZwAY2R7pTKd0xv7KNrwP1R9H
	IkkBw+YL6QF/v1GI9+HSYJppF36Q0+maNU/YdixhUNuxbvmByHG/vJjombS+AnJHFfELQfBZgQt
	Ce0X8gADQYZmWS35kCPAhuuetmLQtTCXOvTGi6DxF9RG+SCjjfAmj4ghqB8RRl2P3D/S4VDWPU3
	J8xv/2Bwrp42jcV3njcEv+K45UHa1zJhZleDT9Oo2M7oP1zQ/uDgyU+cw5adhmOnuOFMKoB8SW0
	aYaw==
X-Received: by 2002:a17:907:a08:b0:b87:6b9c:6386 with SMTP id a640c23a62f3a-b88003930cfmr401546966b.56.1768988171029;
        Wed, 21 Jan 2026 01:36:11 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879513e72asm1561568766b.11.2026.01.21.01.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:36:10 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  John Fastabend <john.fastabend@gmail.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Neal Cardwell <ncardwell@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  David Ahern <dsahern@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Michal Luczaj <mhal@rbox.co>,  Cong Wang
 <cong.wang@bytedance.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 2/3] bpf, sockmap: Fix FIONREAD for sockmap
In-Reply-To: <87a4y8uy67.fsf@cloudflare.com> (Jakub Sitnicki's message of
	"Tue, 20 Jan 2026 16:00:16 +0100")
References: <20260113025121.197535-1-jiayuan.chen@linux.dev>
	<20260113025121.197535-3-jiayuan.chen@linux.dev>
	<87a4y8uy67.fsf@cloudflare.com>
Date: Wed, 21 Jan 2026 10:36:09 +0100
Message-ID: <871pjjux2u.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-6.96 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	DMARC_POLICY_ALLOW(0.00)[cloudflare.com,reject];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,fomichev.me,rbox.co,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251823-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,cloudflare.com:mid,cloudflare.com:dkim]
X-Rspamd-Queue-Id: 8B96F54AB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 04:00 PM +01, Jakub Sitnicki wrote:
> On Tue, Jan 13, 2026 at 10:50 AM +08, Jiayuan Chen wrote:

[...]

>> diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
>> index 0735d820e413..91233e37cd97 100644
>> --- a/net/ipv4/udp_bpf.c
>> +++ b/net/ipv4/udp_bpf.c
>> @@ -5,6 +5,7 @@
>>  #include <net/sock.h>
>>  #include <net/udp.h>
>>  #include <net/inet_common.h>
>> +#include <asm/ioctls.h>
>>  
>>  #include "udp_impl.h"
>>  
>> @@ -111,12 +112,26 @@ enum {
>>  static DEFINE_SPINLOCK(udpv6_prot_lock);
>>  static struct proto udp_bpf_prots[UDP_BPF_NUM_PROTS];
>>  
>> +static int udp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
>> +{
>> +	if (cmd != SIOCINQ)
>> +		return udp_ioctl(sk, cmd, karg);
>> +
>> +	/* Since we don't hold a lock, sk_receive_queue may contain data.
>> +	 * BPF might only be processing this data at the moment. We only
>> +	 * care about the data in the ingress_msg here.
>> +	 */
>
> I think we should strive for a design where FIONREAD does not go down
> after you add your socket to sockmap, if there was no recvmsg call in
> between. To show what I mean, I added this test that's currently failing
> for udp:
>
> ---8<---
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 1f1289f5a8c2..123c96fcaef0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -1229,6 +1229,66 @@ static void test_sockmap_copied_seq(bool strp)
>  	test_sockmap_pass_prog__destroy(skel);
>  }
>  
> +/* Test FIONREAD when data exists in sk_receive_queue before sockmap insertion */
> +static void test_sockmap_fionread_pre_insert(int sotype)
> +{
> +	int map, err, sent, recvd, zero = 0, avail = 0;
> +	struct test_sockmap_pass_prog *skel = NULL;
> +	int c = -1, p = -1;
> +	char buf[10] = "0123456789", rcv[11];
> +	struct bpf_program *prog;
> +
> +	skel = test_sockmap_pass_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	prog = skel->progs.prog_skb_verdict;
> +	map = bpf_map__fd(skel->maps.sock_map_rx);
> +
> +	err = bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_SKB_STREAM_VERDICT, 0);
> +	if (!ASSERT_OK(err, "bpf_prog_attach verdict"))
> +		goto end;
> +
> +	err = create_pair(AF_INET, sotype, &c, &p);
> +	if (!ASSERT_OK(err, "create_pair"))
> +		goto end;
> +
> +	/* Step 1: Send data BEFORE sockmap insertion - lands in sk_receive_queue */
> +	sent = xsend(p, buf, sizeof(buf), 0);
> +	if (!ASSERT_EQ(sent, sizeof(buf), "xsend pre-insert"))
> +		goto end;
> +
> +	/* Step 2: Verify FIONREAD reports data in sk_receive_queue */
> +	err = poll_read(c, IO_TIMEOUT_SEC);
> +	if (!ASSERT_OK(err, "poll_read pre-insert"))
> +		goto end;
> +	err = ioctl(c, FIONREAD, &avail);
> +	ASSERT_OK(err, "ioctl(FIONREAD) pre-insert error");
> +	ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD) pre-insert");
> +
> +	/* Step 3: Insert socket into sockmap */
> +	err = bpf_map_update_elem(map, &zero, &c, BPF_ANY);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem(c)"))
> +		goto end;
> +
> +	/* Step 4: FIONREAD should still report the data in sk_receive_queue */
> +	err = ioctl(c, FIONREAD, &avail);
> +	ASSERT_OK(err, "ioctl(FIONREAD) post-insert error");
> +	ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD) post-insert");
> +
> +	/* Verify we can still read the data */
> +	recvd = recv_timeout(c, rcv, sizeof(rcv), MSG_DONTWAIT, IO_TIMEOUT_SEC);
> +	ASSERT_EQ(recvd, sizeof(buf), "recv post-insert");
> +	ASSERT_OK(memcmp(buf, rcv, recvd), "data mismatch");
> +
> +end:
> +	if (c >= 0)
> +		close(c);
> +	if (p >= 0)
> +		close(p);
> +	test_sockmap_pass_prog__destroy(skel);
> +}
> +
>  /* it is used to send data to via native stack and BPF redirecting */
>  static void test_sockmap_multi_channels(int sotype)
>  {
> @@ -1373,4 +1433,8 @@ void test_sockmap_basic(void)
>  		test_sockmap_multi_channels(SOCK_STREAM);
>  	if (test__start_subtest("sockmap udp multi channels"))
>  		test_sockmap_multi_channels(SOCK_DGRAM);
> +	if (test__start_subtest("sockmap tcp fionread pre-insert"))
> +		test_sockmap_fionread_pre_insert(SOCK_STREAM);
> +	if (test__start_subtest("sockmap udp fionread pre-insert"))
> +		test_sockmap_fionread_pre_insert(SOCK_DGRAM);
>  }
> --->8---
>
>
>> +	*karg = sk_msg_first_len(sk);
>> +	return 0;
>> +}
>> +

I've been thinking about this some more and came to the conclusion that
this udp_bpf_ioctl implementation is actually what we want, while
tcp_bpf_ioctl *should not* be checking if the sk_receive_queue is
non-empty.

Why? Because the verdict prog might redirect or drop the skbs from
sk_receive_queue once it actually runs. The messages might never appear
on the msg_ingress queue.

What I think we should be doing, in the end, is kicking the
sk_receive_queue processing on bpf_map_update_elem, if there's data
ready.

The API semantics I'm proposing is:

1. ioctl(FIONREAD)              -> reports N bytes
2. bpf_map_update_elem(sk)      -> socket inserted into sockmap
3. poll() for POLLIN            -> wait for socket to be ready to read
5. ioctl(FIONREAD)              -> report N bytes if verdict prog didn't
                                   redirect or drop it

We don't have to add the the queue kick on map update in this series.

If you decide to leave it for later, can I ask that you open an issue at
our GH project [1]?

I don't want it to fall through the cracks. And I sometimes have people
asking what they could help with in sockmap.

Thanks,
-jkbs

[1] https://github.com/sockmap-project/sockmap-project/issues



