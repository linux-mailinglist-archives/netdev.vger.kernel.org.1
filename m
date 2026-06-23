Return-Path: <netdev+bounces-301516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oSMGLHcUO2qzQAgAu9opvQ
	(envelope-from <netdev+bounces-301516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 01:19:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 307A76BA938
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 01:19:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=IabuqfW4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301516-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301516-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA1CA306A363
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 23:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7EC3ACF02;
	Tue, 23 Jun 2026 23:18:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC5376A08
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 23:18:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782256724; cv=none; b=WorVXRODCRCIqkIjg/p/tJXL/mgJXozH0YGC9tLdxV/ZOl7qx1k97Zw88ZDKt4Obukw9ZBQ+BzjP16fGO8AhBhiOf3Wg3IIuKf/Hw9bMiPMT64kRnzxHiXcMYNAof9W8ZkL5oJ0wRNQ0cIwd1BpWYRzE1PaiV5aPo5Y+/5XzHT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782256724; c=relaxed/simple;
	bh=5n/QXvZJMGPIUw6mar8KB9fVldpShIPxMrK3iYCi6nw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=FUt2wKcNUaMzTt8aXQx2hcQovWjCSiP5nVQgADaYNxr20IF1SyPdZ2yhzBUgVuleK0dgl9Y+apO7w5AhgLviEeLuu44rs1tYSN90eqBjQ+aFtEqKIK0KCuN4SpgTcS7T/iL7qPw4qKjAIC6wnk37nNfOENyA3eFu1SQhRnu1224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=IabuqfW4; arc=none smtp.client-ip=74.125.82.48
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-139aaba3522so378931c88.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 16:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782256721; x=1782861521; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYJtv+c85w7+pZmkL6Nw0woUwIf8pgennhXzWDFmEds=;
        b=IabuqfW4ABncEl0qceaPOc1Q+/LQ1E9sLvsD8nLnYWecJPACMgN29DMCBkT7VbvV+D
         kgnq2QlZcLcHLIbImNoS9CjqNjPySD3nm/pOO6UWRDoXJ53jw/6wOvucKqWomAjpQePG
         /VlmdxKZVkpmMM310nWZS4Bf2iyi8Q8lZezCazKb1RqSR5ICzUdAqj7Fg1h7b0+P9X+2
         iYaADsj1Ks6d75kji52oB+KC0gp3XAZIBpkvUExl/954cO5VIIKTElZxxq4WJAxdAphJ
         rdztnP5E3g6jiTIdJXkvxzF0/UKlXbSLIsoQoZ6EGquaPOyO0zynOLbAOP+PObHFxH1e
         KT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782256721; x=1782861521;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TYJtv+c85w7+pZmkL6Nw0woUwIf8pgennhXzWDFmEds=;
        b=lpiWhs+UBu108zIJK2PI3hvqDT3o8Rb6MPNMSe8hC1xL/CHSrmFF/Y3TZDaPB5YK96
         nGkbArijASPQJIokptXzXMqDbrd4HePo4A96LrZ7qiBxmn0r6zCEodod6Cri5zGIIjxF
         aOcY6SDZ83mlzGweXixgLBEdlEvXo0QPBNEHZb8E4tSImirQq35Azliaw7ElmE/ItLbB
         McUtASkXh0LOr4gJr7FVRMvY/EQV4/kfNh/bQYPDmfK6OwQVPlLOte/i71FwAIsIIYU0
         ABaNxc/0zpJr3sNMyc+CmSOYWf9WNZ43RrPDd80C4faSvy4q9GZq9FUEZEyuEqdIacXa
         sk+A==
X-Gm-Message-State: AOJu0Ywr17eIO0KwVzfKXP+V7FxStiT2ice1h3JigrWa7Okvo3sQ7Zl1
	ogKShaSWHGU0DfsbJR4kzw/xPe8lZ5W98zPIDMPX+EmXHrnB/K1JSwD7d7hPMeGZECg=
X-Gm-Gg: AfdE7cnikHa7eYElojxtFWk1XLq0c8/tPf8wqjG/nfbJ290AHzjSFZnNurK0YntD/3O
	Xv7hq4X4dD9UdKclYIxJ82j2EPe6eDvDfCGGwvh+d1vKBHZrEDRkHqZhzdyzhoLmu6KnkRb81BL
	97jTEbSUysi1dDdntV8LbOzmyaNxcwtwC4bluanWrGtBHrQp+/LtYrWj21XpLNANBmVQ0Z4pkTZ
	g2DR9OPuula9hSvIf4sX/Ntn5Ng1QWnAc3jBDO2qxLvg7hmWjCnhwT8z+d5eSp6eGSTr3cKN+Ej
	7Ag6/ZcyHth5E/XzTEFHU2l/GQJjuWagyBPRxlInHLoPmYvD20Sw0EPf+dL3GhJJ7n3sEQ8iU2u
	AFrO5yF9TRa4Dk5VTZcmwgrlwBUOSKZUM2u53SJhKH5LTjhNwqxBfCKQ35sVjKueVHfVffgZZ/L
	CVjm+u
X-Received: by 2002:a05:7022:f9b:b0:138:5049:cb88 with SMTP id a92af1059eb24-139c3c1f687mr4353186c88.8.1782256721278;
        Tue, 23 Jun 2026 16:18:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::2526])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be4b24esm18814840eec.27.2026.06.23.16.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 16:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 19:18:38 -0400
Message-Id: <DJGTA190PW77.1GCDO0XHPPZZX@etsalapatis.com>
Subject: Re: [PATCH bpf v4] selftests/bpf: Cover partial copy of non-linear
 test_run output
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Sun Jian" <sun.jian.kdev@gmail.com>, <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <martin.lau@linux.dev>, <paul.chaignon@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260623014027.402820-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260623014027.402820-1-sun.jian.kdev@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301516-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:paul.chaignon@gmail.com,m:sunjiankdev@gmail.com,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[etsalapatis.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,etsalapatis-com.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,ctx.data:url,etsalapatis.com:email,etsalapatis.com:mid,etsalapatis.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 307A76BA938

On Mon Jun 22, 2026 at 9:40 PM EDT, Sun Jian wrote:
> prog_run_opts already verifies that BPF_PROG_TEST_RUN returns -ENOSPC
> for a short data_out buffer while still reporting the full output size
> through data_size_out.
>
> Add the same coverage for non-linear test_run output. Use pass-through
> TC and XDP programs with a 9000-byte packet, a 64-byte linear data area,
> and a 100-byte data_out buffer. The expected output spans both the linear
> data and the first fragment.
>
> Verify that test_run returns -ENOSPC, reports the full packet length
> through data_size_out, and copies the packet prefix into data_out for
> both non-linear skb and XDP frags paths.
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>
> v4:
> - Send only the selftest patch; the fix patch has been applied to bpf/mas=
ter.
> - Initialize data_out buffers to avoid reading uninitialized stack memory=
 if
>   bpf_prog_test_run_opts() fails unexpectedly.
>
>  .../selftests/bpf/prog_tests/prog_run_opts.c  | 70 +++++++++++++++++++
>  .../selftests/bpf/progs/test_pkt_access.c     | 12 ++++
>  2 files changed, 82 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/too=
ls/testing/selftests/bpf/prog_tests/prog_run_opts.c
> index 01f1d1b6715a..beb6fa78fd94 100644
> --- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> +++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> @@ -4,6 +4,10 @@
> =20
>  #include "test_pkt_access.skel.h"
> =20
> +#define NONLINEAR_PKT_LEN 9000
> +#define NONLINEAR_LINEAR_DATA_LEN 64
> +#define SHORT_OUT_LEN 100
> +
>  static const __u32 duration;
> =20
>  static void check_run_cnt(int prog_fd, __u64 run_cnt)
> @@ -20,6 +24,69 @@ static void check_run_cnt(int prog_fd, __u64 run_cnt)
>  	      "incorrect number of repetitions, want %llu have %llu\n", run_cnt=
, info.run_cnt);
>  }
> =20
> +static void init_pkt(__u8 *pkt, size_t len)
> +{
> +	size_t i;
> +
> +	for (i =3D 0; i < len; i++)
> +		pkt[i] =3D i & 0xff;
> +}
> +
> +static void test_skb_nonlinear_data_out_partial(struct test_pkt_access *=
skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	__u8 pkt[NONLINEAR_PKT_LEN];
> +	__u8 out[SHORT_OUT_LEN] =3D {};
> +	struct __sk_buff skb =3D {};
> +	int prog_fd, err;
> +
> +	init_pkt(pkt, sizeof(pkt));
> +
> +	skb.data_end =3D NONLINEAR_LINEAR_DATA_LEN;
> +
> +	topts.data_in =3D pkt;
> +	topts.data_size_in =3D sizeof(pkt);
> +	topts.data_out =3D out;
> +	topts.data_size_out =3D sizeof(out);
> +	topts.ctx_in =3D &skb;
> +	topts.ctx_size_in =3D sizeof(skb);
> +
> +	prog_fd =3D bpf_program__fd(skel->progs.tc_pass_prog);
> +	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +
> +	ASSERT_EQ(err, -ENOSPC, "skb_partial_err");
> +	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "skb_partial_size");
> +	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "skb_partial_data");
> +}
> +
> +static void test_xdp_nonlinear_data_out_partial(struct test_pkt_access *=
skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	__u8 pkt[NONLINEAR_PKT_LEN];
> +	__u8 out[SHORT_OUT_LEN] =3D {};
> +	struct xdp_md ctx =3D {};
> +	int prog_fd, err;
> +
> +	init_pkt(pkt, sizeof(pkt));
> +
> +	ctx.data =3D 0;
> +	ctx.data_end =3D NONLINEAR_LINEAR_DATA_LEN;
> +
> +	topts.data_in =3D pkt;
> +	topts.data_size_in =3D sizeof(pkt);
> +	topts.data_out =3D out;
> +	topts.data_size_out =3D sizeof(out);
> +	topts.ctx_in =3D &ctx;
> +	topts.ctx_size_in =3D sizeof(ctx);
> +
> +	prog_fd =3D bpf_program__fd(skel->progs.xdp_frags_pass_prog);
> +	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +
> +	ASSERT_EQ(err, -ENOSPC, "xdp_partial_err");
> +	ASSERT_EQ(topts.data_size_out, sizeof(pkt), "xdp_partial_size");
> +	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "xdp_partial_data");
> +}
> +
>  void test_prog_run_opts(void)
>  {
>  	struct test_pkt_access *skel;
> @@ -69,6 +136,9 @@ void test_prog_run_opts(void)
>  	run_cnt +=3D topts.repeat;
>  	check_run_cnt(prog_fd, run_cnt);
> =20
> +	test_skb_nonlinear_data_out_partial(skel);
> +	test_xdp_nonlinear_data_out_partial(skel);
> +
>  cleanup:
>  	if (skel)
>  		test_pkt_access__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/=
testing/selftests/bpf/progs/test_pkt_access.c
> index bce7173152c6..cd284401eebd 100644
> --- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
> +++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
> @@ -150,3 +150,15 @@ int test_pkt_access(struct __sk_buff *skb)
> =20
>  	return TC_ACT_UNSPEC;
>  }
> +
> +SEC("tc")
> +int tc_pass_prog(struct __sk_buff *skb)
> +{
> +	return TC_ACT_OK;
> +}
> +
> +SEC("xdp.frags")
> +int xdp_frags_pass_prog(struct xdp_md *ctx)
> +{
> +	return XDP_PASS;
> +}


