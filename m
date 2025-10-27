Return-Path: <netdev+bounces-233178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 875FBC0D993
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 13:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29E93BE73C
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 12:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CD530E0E7;
	Mon, 27 Oct 2025 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OFMt15Oj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C5E2FC017
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568197; cv=none; b=PU+fZU4Hs5/oAPrGf9CEuEi8pE03J7rKutXgspZonhYirdEqtAmxhmtQQrR5Xub6hs8vC0Gz32GYUER6QZ1avtD2Y+KGPVqoTvFq4RCJ47PMMSvUEoIcEoiomzyq9VzGmkKD/N1YR/72cSPYYnNjY5udBwePTHxqnqGx/v4G0QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568197; c=relaxed/simple;
	bh=ucRUjaFUh4wuCN79M3qC1TeCIQU45MZBzHlpsc3ZQE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rAJlJQErEI2XrMlGVKxyo+8Pu+6rl7Txuw+xc6JijDWZCziU/hFCDBqML55KDiSOXCqBIJTiHI+rw69+DFdgnxKRkf7hG5pdDXzZPJrClB7FxN1Vq+hymvU9zoiqnwOrNDx8NiDENB0aj+dZWbhb9+IkJeurJAe7rq5aGkj1x8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OFMt15Oj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d345d7ff7so865266166b.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 05:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761568194; x=1762172994; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IN/kv8APfQMa2huCv3Xk01i+/7i6hyVUYtFQPNtwkSI=;
        b=OFMt15OjqowuiNXi4nDo4EXBx7ZaPuhvTYsjC15/s0FubVr89xlb5BDuo+/+edvQVx
         yO+g10hzKWmcPBzKAICk+ZCzf+lT0y75vmutWXaZyixgidgpSeq5J8anmMxNqS5RdLce
         F74U8M9lJi2Q7spXRMy+dC9VJu45wo0PZ2EJCNdCg2slIE4Cd8rBcbkE8OENPjSAdcGi
         E8iiWL2T7wXJiyaUBsnRrPsc3G8NMtJV3xg7HuhIJFgqQCvMKw8VM7dhvVFYJ+PI9eeM
         0sF0qwCxOIw0dEENJxGBQ0x1eNeKYfsjuNMkeRPIIQ/9jMf10tgw4yJkQPSq2o+oTbLb
         mpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761568194; x=1762172994;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IN/kv8APfQMa2huCv3Xk01i+/7i6hyVUYtFQPNtwkSI=;
        b=VF28lOEvU6QlYr8MpljZ/uHewQKiWWsCk0i8vqWE8eDtlosDKI6nhtYMugDdTb7LWt
         /6UYZek9AeXyB92tG+g6DYVwuYot5OxYD5HwsYwVKMflr9gehvkt42Nn8npw4NDn4lpU
         c5Upj4nhT2ObF+rZQ3TXOsc1NFGyCww+N/6ebWRl1Z2WvFhG60lNYmYi4goTldyGkbsn
         226jGBYRbl7z3vS714XVtwXUbCLdrUFIhZzSYB+ROVOiLKVY1sVbAd6Des1OtXd0eNen
         M1sB0va0BnLL6LmDB4wDWPFlb+u2NJ/6c29V+8TyGVNNzVVZ/wO9Vf5H9iyGD+QtrT63
         2QKg==
X-Forwarded-Encrypted: i=1; AJvYcCXy6qw3CMepFw7r/Ljlm7uF3fGNPbyV99CVCKSG4Y/cY6r09sHlMpw/W9MordvFuAs13JPDggo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww6bo3rUcwwQI1PQVrI4PJhiQGtkin8rceZmgMx6oA78GQA8VE
	ZbzA171Dzam2q7FOv2XknfRDkWk8L7ENmIm9dZx/yUv1hUeLlU95+7Hz4mZSyXa3oYc=
X-Gm-Gg: ASbGncsXTC71Kpj0Ce6GB/hgizkNOskrcyRzLNCvD/5mN5Hl7e+GZOiaAfz5WeDiVuR
	M4WQZTB4EnGkkZAtzoR9uG1AcN2oNL+AhovuB98xV/Waj6b/Okg2qPbNvbMR/TOdRG/OWelBZIs
	qu9Bj7Sa00I+ZjfMYUAl1CnhB8r59ebyBCkDXfbe/HilRXQ9dI00BCRnwKo7T01SvjomqlH0dye
	xClBnHSMoJsuoDBRIXu0++MnAW3b0wvyHRcw/JhLU/NaHEQ2aVxw5BaN0tU4o4pqbnCs+XpMbe6
	GXtPepdpUYbJ/p/E+7hG1a/bGkXxLPR1aJLxK4mdTLoRs/w7uZUHAdS8Y1UylCGqS693GUMqjpQ
	4aIgDmrnVz81I23FUaeMHyJz0QXS2SS4Y05PACy3r6NDJYY4fW9gRhv8aPSRRzXtayhnA
X-Google-Smtp-Source: AGHT+IEaRROLfwzsAXjkPAqbXfJjDsjm8F0/yEVZdxDCagl9W47A6AQtHXtH2xvL+W66nksNqD+7Cw==
X-Received: by 2002:a17:906:ee89:b0:b6d:595b:f54d with SMTP id a640c23a62f3a-b6d6ba8f860mr1225636766b.7.1761568194340;
        Mon, 27 Oct 2025 05:29:54 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:c9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6db1c84813sm113256866b.19.2025.10.27.05.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:29:53 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Daniel Borkmann <daniel@iogearbox.net>,  John
 Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  Alexei Starovoitov <ast@kernel.org>,  Andrii Nakryiko
 <andrii@kernel.org>,  Eduard Zingerman <eddyz87@gmail.com>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP Singh
 <kpsingh@kernel.org>,  Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,  Jesper
 Dangaard Brouer <hawk@kernel.org>,  netdev@vger.kernel.org,
  kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v3 11/16] selftests/bpf: Dump skb metadata on
 verification failure
In-Reply-To: <20251026-skb-meta-rx-path-v3-11-37cceebb95d3@cloudflare.com>
	(Jakub Sitnicki's message of "Sun, 26 Oct 2025 15:18:31 +0100")
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
	<20251026-skb-meta-rx-path-v3-11-37cceebb95d3@cloudflare.com>
Date: Mon, 27 Oct 2025 13:29:53 +0100
Message-ID: <871pmottmm.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Oct 26, 2025 at 03:18 PM +01, Jakub Sitnicki wrote:
> Add diagnostic output when metadata verification fails to help with
> troubleshooting test failures. Introduce a check_metadata() helper that
> prints both expected and received metadata to the BPF program's stderr
> stream on mismatch. The userspace test reads and dumps this stream on
> failure.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

[...]

> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
> index 11288b20f56c..74d7e2aab2ef 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
> @@ -27,6 +27,23 @@ static const __u8 meta_want[META_SIZE] = {
>  	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
>  };
>  
> +static bool check_metadata(const char *file, int line, __u8 *meta_have)
> +{
> +	if (!__builtin_memcmp(meta_have, meta_want, META_SIZE))
> +		return true;
> +
> +	bpf_stream_printk(BPF_STREAM_STDERR,
> +			  "FAIL:%s:%d: metadata mismatch\n"
> +			  "  have:\n    %pI6\n    %pI6\n"
> +			  "  want:\n    %pI6\n    %pI6\n",
> +			  file, line,
> +			  &meta_have[0x00], &meta_have[0x10],
> +			  &meta_want[0x00], &meta_have[0x10]);
                                             ^^^^^^^^^

FYI: AI review pointed to a copy-paste bug here.

> +	return false;
> +}
> +
> +#define check_metadata(meta_have) check_metadata(__FILE__, __LINE__, meta_have)
> +
>  SEC("tc")
>  int ing_cls(struct __sk_buff *ctx)
>  {

[...]

