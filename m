Return-Path: <netdev+bounces-299480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nAq3DMQIMGrCMAUAu9opvQ
	(envelope-from <netdev+bounces-299480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:14:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AED58686FF8
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:14:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=or1c+1i6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299480-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299480-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9978C3045031
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F693F8225;
	Mon, 15 Jun 2026 14:13:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E883F65EC
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 14:13:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532794; cv=none; b=Fw7C/i4HOTCGZlmV0mmZ2D8CKB5X3wuAz5iBBNRtvs8rkS7fnGRzV/MtJs7iLBTGyLKIphPxVAe1R6y57Mda6bvup4t94NFXkESeAxP0n74XIVUsrGt9S9yviF5nvasXg/UiaMWTkX7RSh5RNiFVCeQvikvvW7BqXjz7PE9M3MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532794; c=relaxed/simple;
	bh=z1Pf0308GIXx35y7zNiQ26Q7XW1IEbgheztWcG9jfRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rW6/MVQa6QE4ZjbmPO8DPfkjx/xxwnvXD/lCAhOQFkFNbxCseoYqz1EVCzeYsJ6GKlzsQnLg7wbnAdoLfuh4AElPbjdopvXxHpzKYlvXYpxg1ohyj3pqfxBvmDlZiBIXTVujZN6uxBb4X4nU1UOTbix5Jb3atHauvkxKqyraD08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=or1c+1i6; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef1198766so1800280f8f.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781532791; x=1782137591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TE4i6DUnxedcuW81EIQxjbJU+HuCPuqKLHr71bT1zRk=;
        b=or1c+1i66zFnNks4yOGzwjjIlIA/Nc33hvxyznbmaE6X/+v5vzOJ7jVHPUtilgbgyr
         4xgKXGTlvq9+fhvD4TkKRISuFSdjOvzObnsFn7EImpw+Wn9/g1s7vEsItxaT/26u3Oze
         4tPiZiY8i3EQYeGRu+2K9oEzaWCFs8XKv1dA9O141SgqD+fL3ygJ2DB8shDuF8CdjAkb
         dZ233RjnnMwQ+TpmnceCn4oOzfHB35M2T3/vW+UID9NCMFdK2sFqGS+g45Ejes72lUXT
         e03GuYVY21FxAeCZfUPSkcrr12FCw+1n19gf+DhBa1JAU4ekVpLK2QBQ2ko0SW8A9Ap3
         6O7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781532791; x=1782137591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TE4i6DUnxedcuW81EIQxjbJU+HuCPuqKLHr71bT1zRk=;
        b=HFbk9mv5I33/Slf9T8Gq5S1KfRi1R7d5rUU7mw7I9+DTuNxxoq62E3Q0mYEMB81D+I
         g1Ys3AQgMySgPWtcKg2alJBuTLprqhdL/+LeqlmqQbr3FsKtysqW6XiOSX1vSSkjQDF9
         avkNWf8u23+jM2QAVApkf71MmcYnxBJl/tAnjkS8fb8jAloc9LeGbQjQ3TTyf2Cdue+Z
         2OKoZt4Fwoq5RzhXCNACRDqb3ZHXwVqJRrtZdEInZLS9L5Olm5fnvUAaQ45Fil6CzGbM
         GSdnJlruJ7M8DXehI3mqg0OeTYriSd92nvuwo3YXTNUHw3Kg49UXbKLzB0tZ4/XX4xgE
         HKMw==
X-Forwarded-Encrypted: i=1; AFNElJ8dkzO28VaNH29Qjd7ewuS8m8ImIkKcx+tNCRR74r0KDQQdGFrd5fz81e3HDtp0RC2ODz2X05s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrcdHjbOtv4jFY0nWJFEnlRYxcSqcV/WGodQurN2+yVWb5egnz
	crWdc5HC9BP14/hxqPnx0VNebeGWk5Mw2oIklKuoVYkED5+NopeYl0vHkSTCjFVA
X-Gm-Gg: Acq92OH66KKOXCmKPixGepd/FK6+UrkGPwOzspONiGgAMnj/fTtNwNSS0sid6jrhOop
	Fi+xPzvm89qBqaWbg9xWaJbbg6jI8cLPhyqdEmA2Yes2spFyI/q4z0JblrX4zsA9XJmHo8QsEoR
	7dr0HU188974HqxyYArIuoBdhRmlXKN79NtSlqe73bd/+b7gFGZu7pK4vsIkwzOfrT0WJ5jmQk7
	vxu3dDYb5KSvR2LzCgsxAaK7RkfOK24KgZJJVegbTo99QyhfjRtAU3L2WavQ1gCHXziQTbz9UBF
	G8ikqGYQKSPX33XNmz2DlFeY6lWomA5RZRhZLqV/byGddUmD+qQH0SJhOh5fzm0FpPEtMJ/3Gbn
	O4qyGSLK/svGuQ6SRYXBHvN4J6oOGw7Lnt0xeNYyBJuy6axnLyaRejkxKy1SeZfxI17CgtZUMo3
	mF5SpjSz2lA2M/oMckUYKsjP9Eg+0pmseuAiFAxe3DYTMebXAHnkj+ztUvO2KmdiHDDPkTowjc5
	Utj0BMYzvy2UbAIZ5Q7kZYY2pk/rkIcDoIThHK0xQheEx1Ete3LrRKA2gjMdixzsEem8yJTLxVu
	bze0aamTu1C/SA+Bylrl9maJocnB41aODuj/E4+3bSY=
X-Received: by 2002:a05:6000:41e5:b0:45e:8edc:dacc with SMTP id ffacd0b85a97d-4606d03bf34mr18432871f8f.27.1781532790867;
        Mon, 15 Jun 2026 07:13:10 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e009a0d3db09e2f2ffb.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:9a0d:3db0:9e2f:2ffb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f20e77asm36900828f8f.0.2026.06.15.07.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:13:10 -0700 (PDT)
Date: Mon, 15 Jun 2026 16:13:08 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	shuah@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Cover partial copy of non-linear
 skb test_run output
Message-ID: <ajAIdJHvvIH9ZSrM@mail.gmail.com>
References: <20260615073856.152479-1-sun.jian.kdev@gmail.com>
 <20260615073856.152479-3-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615073856.152479-3-sun.jian.kdev@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,sea.lore.kernel.org:server fail,mail.gmail.com:server fail];
	FORGED_RECIPIENTS(0.00)[m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299480-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AED58686FF8

On Mon, Jun 15, 2026 at 03:38:56PM +0800, Sun Jian wrote:
> Add a test case for BPF_PROG_TEST_RUN with a non-linear skb and a short
> data_out buffer.
> 
> The test verifies that test_run returns -ENOSPC, reports the full packet
> length through data_size_out, and copies the packet prefix into data_out.
> The test uses a 100-byte data_out buffer with a 64-byte linear head, so the
> expected output spans both the skb head and the first fragment.
> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/skb_load_bytes.c | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c b/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
> index d7f83c0a40a5..134be0ea8ed7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
> +++ b/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
> @@ -3,6 +3,39 @@
>  #include <network_helpers.h>
>  #include "skb_load_bytes.skel.h"
>  
> +#define NONLINEAR_PKT_LEN 9000
> +#define NONLINEAR_HEAD_LEN 64
> +#define SHORT_OUT_LEN 100
> +
> +static void test_nonlinear_data_out_partial(int prog_fd)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, tattr);
> +	__u8 pkt[NONLINEAR_PKT_LEN];
> +	__u8 out[SHORT_OUT_LEN];
> +	struct __sk_buff skb = {};
> +	int err, i;
> +
> +	for (i = 0; i < sizeof(pkt); i++)
> +		pkt[i] = i & 0xff;
> +
> +	memset(out, 0xa5, sizeof(out));
> +
> +	skb.data_end = NONLINEAR_HEAD_LEN;
> +
> +	tattr.data_in = pkt;
> +	tattr.data_size_in = sizeof(pkt);
> +	tattr.data_out = out;
> +	tattr.data_size_out = sizeof(out);
> +	tattr.ctx_in = &skb;
> +	tattr.ctx_size_in = sizeof(skb);
> +
> +	err = bpf_prog_test_run_opts(prog_fd, &tattr);
> +
> +	ASSERT_EQ(err, -ENOSPC, "nonlinear_partial_err");
> +	ASSERT_EQ(tattr.data_size_out, sizeof(pkt), "nonlinear_partial_data_size_out");
> +	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "nonlinear_partial_data_out");
> +}
> +
>  void test_skb_load_bytes(void)
>  {
>  	struct skb_load_bytes *skel;
> @@ -40,6 +73,8 @@ void test_skb_load_bytes(void)
>  	if (!ASSERT_EQ(test_result, 0, "offset 10"))
>  		goto out;
>  
> +	test_nonlinear_data_out_partial(prog_fd);
> +

Maybe prog_tests/prog_run_opts.c would be a better place to cover this?
test_skb_load_bytes() is meant to cover the bpf_skb_load_bytes helper.

>  out:
>  	skb_load_bytes__destroy(skel);
>  }
> -- 
> 2.43.0
> 

