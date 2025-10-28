Return-Path: <netdev+bounces-233492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2B5C14620
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169FC4688C8
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F6B30DEA2;
	Tue, 28 Oct 2025 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5gZQ4j0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E423081B0
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651039; cv=none; b=P6gddORo3fCMgIe11jMIHfXFVQWJ/qAgPVTH3okgwE9eQUStMW4DnSBdW5z0OCmqct40q/qAHU3QeeHJc4qUchIdKn1COruDAZFvPj4LWe08D0CSLV+fXraj7atdXjRstJyYhg0/IHiBnXXSner32anAai8C62oaJ44GDPyfG9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651039; c=relaxed/simple;
	bh=uLz1nCOc13P72Z9cLqgJATuBA1im88R9TxqI9YQCXBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=co7yjDbkaH/D/qqgDeyclaM3H4g6jdjYtqVnWIJo+rUHcxwDYKFvT7LuRNlFoY5GZP0Q9Om6mcH1RMvtG6HJ02Ese4J5FbU5Jre2zT7wbJn2++UN2/89jetw6VKX2wAvgoLlwDPtsXPecNq9tYUao/k6GKOKX8Mf960XDtaRk1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5gZQ4j0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761651034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wj7YAztZrM6wj1+S+3q5JHWOPj4KIXwKeK9N2bqLfU=;
	b=A5gZQ4j0xLIsGcgO2HUNkY0U3Ui72riAn6/pLfsfJd7vhw4IgnyBoh2JVae9HT6iOgOwoJ
	uVgnFuqWFL97Ame9GmTrOYjQ87bSePLcY3PN9MgPT014WDkm7JiVKr7Uh4Lx3s00auQPUV
	rOJPnxtTyj+5Q5dRTbHvP5VcPmJ8v5M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-NUa5F8TtMq6c5ZLRyiw9BA-1; Tue, 28 Oct 2025 07:30:32 -0400
X-MC-Unique: NUa5F8TtMq6c5ZLRyiw9BA-1
X-Mimecast-MFC-AGG-ID: NUa5F8TtMq6c5ZLRyiw9BA_1761651032
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-475ddd57999so27020875e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 04:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761651032; x=1762255832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wj7YAztZrM6wj1+S+3q5JHWOPj4KIXwKeK9N2bqLfU=;
        b=nC0PZ83aetqyQ2nSti8Kw2aqqskJ1gEpkEnrXpGqldyLtyey2uifJMzvr0ox3RNKoj
         EsxCjJwEgziollpwdATEjTHiLa0qXRprCOOK1Xc/I+ar9cG0ZQHgOkL4TfaDOSMf558t
         FU1c0B/RqVEJoVoJYpIQi6wDMCt2NOOgmUZ4T+WuuQ9Z4idT2557IePh4ntWAqBpqWJa
         tcZCTRouGjzzrIDOLG/Oe+xhyHHTM/Ob6q2itKzvyE+atge24a1bi2w7+zBBI+NCUXT6
         MRy3NJTiA6i24GFNq98gVVUnzA/dRiKfPhaXXMg32xMkOFSzAkBHnH7ZgZhYdcG3SBKY
         qgZA==
X-Forwarded-Encrypted: i=1; AJvYcCVvM/ETxoKeqaEPeT1uKF7A/fgbBd0yPjtaP8JA/XUEYaKCZSs2DT8FjD8jyahvDVrwlXRkjf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEA2ve+186eCT4zp/XECH2XaphrlSiG8vUhY0yucrGAfPWvZrJ
	wcA8ZhVuz+rRhkVdFPOaHEHHO6BvVBQfwpa7h9QJ1Lo3iTUtlE2cbpcy8GGS4MXUI1+I37Cap5y
	6UwbWrM1x4vb1uyDHh0wlD36gS34xOSUY1C+juCepoRSxpzUPQRGdZYHHIA==
X-Gm-Gg: ASbGncvBqSiz6Pkc5LnbkiSleRe11q9V7ehaXDWYVClUKCixcf+MEUuww+dI2ByAOh2
	0jdLdJ0Fd8SPAmomuEiOO3BLGOAMMrhk7ICIYyJ0q0tgbDMvTCIZNoQIPUVbWymcczE5vZu5LJx
	NfOuP/PbSwcsin3lzb9P84ZS0WTGLdbLOpCQQyIh5CEcLOeog5ujed+OxUi5LW8/nnM98gzM4NB
	qebN+fjZmvmlZVU5N5q07Pk37wE1ojknVFvScNLcI1vguRORIs9+6PNOx39Mx5quqtilME5jn33
	r6kW0Ay+inFPPxkaC1rgoX5jKbYAuD6wIRyP5EjLqBugNC+gZ0ZZ6+ti2QtixWGthrX6rA1gM5p
	nkJDzLmyH9K1WBGnKBo9GR/xDDs8eDnyT/hXMEa7P2BywoZw=
X-Received: by 2002:a05:600c:4446:b0:475:da13:2566 with SMTP id 5b1f17b1804b1-47717e6095fmr25034845e9.35.1761651031654;
        Tue, 28 Oct 2025 04:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1UoWkDkAxEnPYbIqlYF36LNiS1od7f4r/oylsQ8lGjLYMkIaaEI5SdiPojR2VWZlNQPGbIA==
X-Received: by 2002:a05:600c:4446:b0:475:da13:2566 with SMTP id 5b1f17b1804b1-47717e6095fmr25034235e9.35.1761651031148;
        Tue, 28 Oct 2025 04:30:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd489fa4sm187152685e9.16.2025.10.28.04.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:30:30 -0700 (PDT)
Message-ID: <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
Date: Tue, 28 Oct 2025 12:30:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net,mptcp: fix proto fallback detection with
 BPF sockmap
To: Jiayuan Chen <jiayuan.chen@linux.dev>, mptcp@lists.linux.dev
Cc: stable@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <20251023125450.105859-2-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251023125450.105859-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 2:54 PM, Jiayuan Chen wrote:
> When the server has MPTCP enabled but receives a non-MP-capable request
> from a client, it calls mptcp_fallback_tcp_ops().
> 
> Since non-MPTCP connections are allowed to use sockmap, which replaces
> sk->sk_prot, using sk->sk_prot to determine the IP version in
> mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assigning
> incorrect ops to sk->sk_socket->ops.

I don't see how sockmap could modify the to-be-accepted socket sk_prot
before mptcp_fallback_tcp_ops(), as such call happens before the fd is
installed, and AFAICS sockmap can only fetch sockets via fds.

Is this patch needed?

/P


