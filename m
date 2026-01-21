Return-Path: <netdev+bounces-251831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBPAKnWjcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:59:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7D254CCB
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C218882C12
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CEC47DF8C;
	Wed, 21 Jan 2026 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Zww76dWI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A207347DD5B
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988726; cv=none; b=mwx5gQSZ+t8R+2/cwIoXJyOYcv56hguyBn8nH0VD3AIbAfculRxpq0IfNPamQab13/0IogGSfqPOv/fiT7TYNa2i2gYQ6rIceaxERIh97FmTR7CUQUO1oRrgo+KrGga9UjRscdCQKT/SLoGvsFfO8LJ7qDtmI4xvbTG55UNpk4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988726; c=relaxed/simple;
	bh=LQCZKDYAPVWTL1hfa0m9GqkDC4+oPqHsCFMnnvfMmS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s8wRedn43SzirabIdb2DXLJLMTxY2QBUSxBphMeZ4MD0wXE++Yml1+ihkFOIiIoT0KE301Jv24sYGYShphdPYAH8Yi/bseY6lHocpmK3/hshf66DDbLIIi/Q4MG2ndsoAWqW5ZQmwpSzMjB1BYOBb/NAAvUePXrcgkK/1E6UY+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Zww76dWI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b874c00a39fso122587466b.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768988723; x=1769593523; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qJ5Xi6Zzr4VTOfswDmjNXoozec/PpuCDq08QJw3b/Ms=;
        b=Zww76dWIJuUUBg27f1wT2NfDrOQVADca67E2F7S3mw9ipRbEBsckDcHsfeCMNjBez9
         YdcFQfVo0rWkYInTS8xClC2HMZ9vtQEjgIktw659+fQogGJ4ZrYy86fyny55ZKmH1zL6
         +JAgi/MbJRRhzIwyoimoKB8cbeLTsnFWvKchpXaTW7imHFdVpUNPIuOpbq/V971GDqbO
         QLM/Z4OCvMUYaXm5zFk4EvaGzNijgXt1sY5N2re25EkmaOoGI6Ln2wy2ynn2edpdXoP9
         C2/p7cUiLmT184PDKbM7cqk3iQPMFJGb9OHmhrwR/yFuVz4g/reqaaHpQ6QfgzmvuKZp
         KRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988723; x=1769593523;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJ5Xi6Zzr4VTOfswDmjNXoozec/PpuCDq08QJw3b/Ms=;
        b=ZE5E+dDoDDVjm0qAuJcl+kbq3laJUIMbFDzScajLD2PjG8wyF2Qr7ySkFntVDEJAbh
         XSXHWZ0JfdivRw8qQJS9GwXAqH4YPj2vyT95bzSEuQ+/DIjUonNmy73VT0SH1v2ph/Hr
         No4uHoCqE36p03zHMxM2uBhF98P6x+nO//REw+KjgZ+vl4P39e1dXXBks1ErlerkCAfb
         AeVbEADIBevfVb2o2/74OHnNgg4WlGw1p/wrJk235643ExT0x6JlTKlpnpAO9HiwlY2S
         pXfVrFw7qLyUiG8XotJTezU2fnKpDZjCEoPV1wuZHe0ACPKKMQwFfl7UlH36u2ko4B4u
         Wt5w==
X-Forwarded-Encrypted: i=1; AJvYcCVEu6pcmLNitz/0MA6nVP0Dovclf0eWMJZvGdnKyQR2hRmiIagRY/ld4niFADF8D6cxkCW6xjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9T8xSyCPCkF1ehL+Wx7gNTiRCOudCByHj32i7iNHOsX8/V5AM
	meDWGb3TlIkQHTmmYBzl+t/VSmC/sSADe9/x/z6frxj2AU1Ove6Gxehq7VsBJ5qtUcU=
X-Gm-Gg: AZuq6aIP0KnkOHzU5h61tn7uRSrt4NA5O41LsY8CG9wGlMJN7N4CzUUKZn52O64QC3Q
	lydJYr2ULdUCsRutwHRGzTIvP46UCSEho2rdMxIb4u/mPf2AnrNVbvawiqN2zlgQkRxMSCbAj5B
	rylIu5OOET0OFfVHLhBsVW60IogiXLOg/el4eqItY4nkM7xaMSeDoJpoEwPUtwJ0KpPTuksReAU
	aAyifECVkF9cnjbXGD7jq+gXgzQdkNGI7F1V2XfIsoyHN2MzH5uCQA1f8EtImdTSWG90fMNr2cT
	+QnGw4BUyB8fyE+1otGN+HQybyQKDS46JA91WRgqrQdUMqlwPzvNzn3Ufu5xMO7FEz01robQbnW
	90sk4tSicr5n89VsWzLM3bZ5DyThbLH/ddW4ZExI3v8tNvR4QbHbAzYKGQ+z1ERdckx5lq4pL+3
	YegA==
X-Received: by 2002:a17:907:9496:b0:b76:3472:52df with SMTP id a640c23a62f3a-b879388d7c0mr1760882666b.10.1768988722803;
        Wed, 21 Jan 2026 01:45:22 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959fc273sm1526702066b.54.2026.01.21.01.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:45:22 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  John Fastabend <john.fastabend@gmail.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Neal Cardwell <ncardwell@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  David Ahern <dsahern@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Stefano Garzarella <sgarzare@redhat.com>,  Michal
 Luczaj <mhal@rbox.co>,  Cong Wang <cong.wang@bytedance.com>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 3/3] bpf, selftest: Add tests for FIONREAD
 and copied_seq
In-Reply-To: <20260113025121.197535-4-jiayuan.chen@linux.dev> (Jiayuan Chen's
	message of "Tue, 13 Jan 2026 10:50:51 +0800")
References: <20260113025121.197535-1-jiayuan.chen@linux.dev>
	<20260113025121.197535-4-jiayuan.chen@linux.dev>
Date: Wed, 21 Jan 2026 10:45:20 +0100
Message-ID: <87sebzti33.fsf@cloudflare.com>
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
	RCPT_COUNT_TWELVE(0.00)[29];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	DMARC_POLICY_ALLOW(0.00)[cloudflare.com,reject];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,fomichev.me,rbox.co,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251831-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,cloudflare.com:mid,cloudflare.com:dkim]
X-Rspamd-Queue-Id: 4E7D254CCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 13, 2026 at 10:50 AM +08, Jiayuan Chen wrote:
> +/* it is used to send data to via native stack and BPF redirecting */
> +static void test_sockmap_multi_channels(int sotype)
> +{
> +	int map, err, sent, recvd, zero = 0, one = 1, avail = 0;
> +	struct test_sockmap_pass_prog *skel = NULL;
> +	int c0 = -1, p0 = -1, c1 = -1, p1 = -1;
> +	char buf[10] = "0123456789", rcv[11];
> +	struct bpf_program *prog;
> +
> +	skel = test_sockmap_pass_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +
> +	err = create_socket_pairs(AF_INET, sotype, &c0, &c1, &p0, &p1);
> +	if (err)
> +		goto end;
> +
> +	prog = skel->progs.prog_skb_verdict_ingress;
> +	map = bpf_map__fd(skel->maps.sock_map_rx);
> +
> +	err = bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_SKB_STREAM_VERDICT, 0);
> +	if (!ASSERT_OK(err, "bpf_prog_attach verdict"))
> +		goto end;
> +
> +	err = bpf_map_update_elem(map, &zero, &p0, BPF_ANY);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem(p0)"))
> +		goto end;
> +
> +	err = bpf_map_update_elem(map, &one, &p1, BPF_ANY);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem"))
> +		goto end;
> +
> +	/* send data to p1 via native stack */
> +	sent = xsend(c1, buf, 2, 0);
> +	if (!ASSERT_EQ(sent, 2, "xsend(2)"))
> +		goto end;
> +
> +	sleep(1);
> +	err = ioctl(p1, FIONREAD, &avail);
> +	ASSERT_OK(err, "ioctl(FIONREAD) partial call");
> +	ASSERT_EQ(avail, 2, "ioctl(FIONREAD) partial return");
> +
> +	/* send data to p1 via bpf redirecting */
> +	sent = xsend(c0, buf + 2, sizeof(buf) - 2, 0);
> +	if (!ASSERT_EQ(sent, sizeof(buf) - 2, "xsend(remain-data)"))
> +		goto end;
> +
> +	sleep(1);
> +	err = ioctl(p1, FIONREAD, &avail);
> +	ASSERT_OK(err, "ioctl(FIONREAD) full call");
> +	ASSERT_EQ(avail, sotype == SOCK_DGRAM ? 2 : sizeof(buf), "ioctl(FIONREAD) full return");
> +
> +	recvd = recv_timeout(p1, rcv, sizeof(rcv), MSG_DONTWAIT, 1);
> +	if (!ASSERT_EQ(recvd, sizeof(buf), "recv_timeout(p1)") ||
> +	    !ASSERT_OK(memcmp(buf, rcv, recvd), "data mismatch"))
> +		goto end;
> +end:
> +	if (c0 >= 0)
> +		close(c0);
> +	if (p0 >= 0)
> +		close(p0);
> +	if (c1 >= 0)
> +		close(c1);
> +	if (p1 >= 0)
> +		close(p1);
> +	test_sockmap_pass_prog__destroy(skel);
> +}
> +
>  void test_sockmap_basic(void)
>  {
>  	if (test__start_subtest("sockmap create_update_free"))

Can you replace sleep(1) with poll_read(fd, IO_TIMEOUT_SEC)?

