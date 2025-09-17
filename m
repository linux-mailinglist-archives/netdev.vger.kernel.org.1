Return-Path: <netdev+bounces-224048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CE9B7FF51
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0BC7222DA
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FA72D7DFB;
	Wed, 17 Sep 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HasjjyFT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D7F285C80
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118475; cv=none; b=iBj3nWogTvKaB+4SuSPMNjAYyfiK8CobYAO2agD12sOh/scUSr9QZ9xE3+u2FSFpJzbyAVRdbAmykw57koOpm/O6CNlyktTjbFxo6WBsYy0Gl29ONJasnUD5j9WJE9Rz959CvXATjktNKDpNAkIKTS/4OSH4SGeIFwDLCkAfaag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118475; c=relaxed/simple;
	bh=hcDVZ3XXrXOKCZXhHTox1JgUCt8ATLeI8pLdLY7Nylk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FiHcTB/OCS+HjFVcfUEmum0mdvtiX21UGve5VnXKP/kyvEnS5k0yU6WnbJD5+/LjxJI9HzT0k1WNQV6FK4nYvDIhKKRWLw0smDL2Ps+8wB6mGxKoemzt2z9zIroXc4hws6a7LBFDry5/MsHeQsPffXD6K6mUFDezHNf82sR5dE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HasjjyFT; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-80e4cb9d7ceso868519585a.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758118472; x=1758723272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcDVZ3XXrXOKCZXhHTox1JgUCt8ATLeI8pLdLY7Nylk=;
        b=HasjjyFTh7Tq2qxvlGEuNn++2Q8M6MwKC24j1uPsd+Tf48bETCWhBCeJcoa+5OCLFo
         cOQt/TONmMPTsjc/3B2mVYEXSFFrq60wG5bWTDzWEIqCuvu6hwb1sKRmFv47gmEK4chK
         lVmAfAjzZ8swurjM0OjxfOLMYt6twSqWi2tvC8sHHsBsfCwMo4zTV9qkQjlyQErsv+PL
         y67Q0Oum8mtTkW6clWmGjLd+ofTi/el4W+5J1DCG+zwpiFOOaSMPgZKf6415rJwn/ccA
         qBhTS/HpoM5zlf+AZ/tUA9dYT4wCuv0zI8KC5pQO6q9ZY8Y9WeyUxBgirDqRoHnHdfjf
         exNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118472; x=1758723272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcDVZ3XXrXOKCZXhHTox1JgUCt8ATLeI8pLdLY7Nylk=;
        b=r3CWmyVN62+WfNawX5NeKEDT8ONsi+vuGFTtmwPcINpKuicrgAx7THqq28LQfd/LnE
         7fo+6IvoUspHzWbZYq08GTvxFaioiCNKDeqnF0QpgPwWEhT+7c6suVBvz+D17cKw5sty
         EYUib1Vy++s41FmcXE98VgQ+R5QKiCd7SekVNsM7vJnxX4B3dP6CsxrDRMhcrGw1+Zd1
         JwNNC6DwOF20fPQ+R9CS+Evlpz2Wd+ZPBhgYf76EbSOiymyi0ZbnDB7gvCpdvgpZ2U4k
         SCg7yjjcjJFMK/8yxD+Nj9fuHLSW72miP8PXoOtTJpoLPuMpuQUF1SHJ6LfF7zDveOX/
         8Rgw==
X-Forwarded-Encrypted: i=1; AJvYcCU4WlMJrmd/bDqoCZyrymnwGWVS9IrYVitlDmRFPZZOcLVDGetuE6p9O7+xX9xY1jARlrmrzKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfhlxe+6RbhEpcWzN/U0uQaD0deBRgwKktubqSA748bGQhN+Sl
	dgBr0W6q1fkglNB6D6aIR89PltOzKhv8p2fijoLvhun4y8WBN1+GZtz5uD2zmVDpI7RqIYMKDTC
	cSOEYPZ3oxsw34OU24zxa1rNSEPFyyM1cdJDHfGVK
X-Gm-Gg: ASbGnctcdyP6p4ItfSxomzuux4G5uH8MftdyCIaPCNRenKdjwWPTQKh/a4iCTZ1DSii
	/cOVUClsh0QM9qea9HRIwlvar7tfx/wneLO4a2MqWg4Iu+Bt9RHL6rmxYY/7KLpyBzi9xjvDXC5
	DGzURLssOwMk2cuRP4WB/+yITLv6gh4m/ABuYbrYiIaCSEaHB6oO46evcO90KT1bGM6MFSyiHr9
	ny+BFafH6ln
X-Google-Smtp-Source: AGHT+IEIu3b9EZ0mZdFIbzxdXqBUvRMuDs/NJ4veMrfUAmLsNf8z9DHDhUd535rGX4Sal7suqjzbrWcLephWe/ZtrVQ=
X-Received: by 2002:a05:620a:f0c:b0:815:81bb:f92b with SMTP id
 af79cd13be357-83106eb4690mr237257485a.13.1758118471108; Wed, 17 Sep 2025
 07:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916214758.650211-1-kuniyu@google.com> <20250916214758.650211-6-kuniyu@google.com>
In-Reply-To: <20250916214758.650211-6-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 07:14:20 -0700
X-Gm-Features: AS18NWA1dFLhpvsJlZEV-rUMWsPJwvSK2vUMNN9mASWJqMc7JeK1lwq7sIqdfDM
Message-ID: <CANn89iKQ3FFiDAUCrcNQD+J27FPpiPR7bLkA3WQjLD5P7jZcRQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 5/7] tls: Use __sk_dst_get() and dst_dev_rcu()
 in get_netdev_for_sock().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Ilya Lesokhin <ilyal@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:48=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> get_netdev_for_sock() is called during setsockopt(),
> so not under RCU.
>
> Using sk_dst_get(sk)->dev could trigger UAF.
>
> Let's use __sk_dst_get() and dst_dev_rcu().
>
> Note that the only ->ndo_sk_get_lower_dev() user is
> bond_sk_get_lower_dev(), which uses RCU.
>
> Fixes: e8f69799810c ("net/tls: Add generic NIC offload infrastructure")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

