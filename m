Return-Path: <netdev+bounces-211192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D99E9B171AE
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 15:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F861AA60B8
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F192C15BE;
	Thu, 31 Jul 2025 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NLcpojFu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF872BFC8F
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966920; cv=none; b=RTbIka+Wl1ZO8N9yF+IxEMYYi1ZAc+6Xb2rxa1F2L+Ml4gzDy7bkTf3SqweP2ghhA1IKXLSFBQrJdsTyiyuSbNBxCseX7zfT8xpYKfcEUmE+jNg0/JKQjoJ5WsUveIT3dOm+vCdebHg7P5WrK1IxH/3oRM36icQ6gWtguCGD+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966920; c=relaxed/simple;
	bh=wbrWiEhfPScCVolNfyyjt22cIB4PfoD6ZusxuW+Alzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLetwRE2Kj+eu1KuIYezcx/hWbYfMyyLhQOQeXUf6PZTF282XTSsJIFTFVRSk+5olVmkIfYcIDGI2htExCrO3A0kRQXnppblnQojQUth1nuJHlG1h2yAyN8Ik4dxBN1wYGBChQ+NKdD9begVT4Obc/7mVyuSajjHnovYG4wBbaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NLcpojFu; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71b4b36cf83so9576057b3.0
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753966918; x=1754571718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76yABaBlU6UDoYWb5i2vJYe7/HG6gZqjh5DtuXEh0wE=;
        b=NLcpojFuFw8S/OG/15nv1iVIWYN3JlD4dc2+ppR+dH4lnbLWw5yfvKUijDlN8mdWKB
         KPCwc1xlgalprjWM8coJuan/v0vb5lkh2gTv6gYaGnxOGozx2PWRYe91F5nXR+D/nOQF
         V90dUnvsJB3FvYjDKgdmSbnSlllK6h02hNJ1jpooHyQ7nSVbSwl+xv2Nu/T6BOAXILSo
         suatKbnIWwW+P8dHIvtEpMzj3Me57fFqxWckLgbqpXEhle47zBcqvFQkIlnx3f6sLX4Q
         h8F7YhJvFhDy7SgDgZqV2lS/KnM/oA26J4gUk6pi9tn8N6+Vxtg6l7nNIqk7u1Q+QPta
         /u4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753966918; x=1754571718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76yABaBlU6UDoYWb5i2vJYe7/HG6gZqjh5DtuXEh0wE=;
        b=PDCsMrwX//UJzMJlIYtxll2oFX3DYDDK0IkV2gRkifx2Dl6J24Thi5ZtzRStXz0LWJ
         oKoavMFjJR1rr4C2Pw4ztCrb0tJk8pMejwM+hFvMjUKQhEx0g5Dng3nGgS+l/d/rZVsy
         5LIJZz6jkuwRehZVBwmxp1zvagft3C+II9oZO5J5SBC3kFbeWAxz229UtnFHl1e9MGUP
         doHMehCE4jY6LLtkszhVXIWS7P4WYAK9gGs/KSOGC6KX/MODjtrAhQv6wRQz72ITXLTe
         9OJ3C+oaYRtFMoDRVYC/idJsNJuezcElbgrKo3zwQoHBcbfJpFuZR23orEd3Ppd6INL/
         i/HA==
X-Forwarded-Encrypted: i=1; AJvYcCWP8UsJIZt3ZEmn2y0mERL+rakADamJVPewzeE0zX7OStw6XpkqmncUQIjNXpmOxxqAe6MvKqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp9uUNSnf0Wqu/MyXmQHP5Z8DIZ/r29NOGZB4ODsJTgt2JXGBx
	8RKigB/RKZmkHxATrQCP5yn+EqX4jBscRUKxUbFu2114+jpONGdeltLIzFbYX/L/3ORxzedfftB
	aiaXOpumNp332+0FJ5v3x913kJJ91+8K0MDXGC6Tx
X-Gm-Gg: ASbGnctuMN4QWyqzgWHa8tkILLl4IXbTlspvbBa4KomKLGxn2bW0Wkl8QNduAxzNsny
	3P+x94kkHVpon8kWfmtoF3iVKFaGJyKPzpr/L2bUwENMxJ7wt4avRcunwY6hewTn8o7fzvB0CDz
	k0Qh9tsCzwml/1ajlmSfdW5L/Y4poQ8UibEQ0rrCmV4fP5LYhDiDimETjTL0YHnMUQTvo48NRLD
	Qt6Rg==
X-Google-Smtp-Source: AGHT+IFHsQKKy19b+mkI6T4bmaLpNZ271aXwL3PfIOVfg50ihjyeftIyzuwnKyjumfnAE6VOghd4+JlOFr33u9sCgpQ=
X-Received: by 2002:a05:690c:a84:b0:71a:3484:abfe with SMTP id
 00721157ae682-71a466ea559mr100356227b3.38.1753966917367; Thu, 31 Jul 2025
 06:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731123309.184496-1-dongml2@chinatelecom.cn>
In-Reply-To: <20250731123309.184496-1-dongml2@chinatelecom.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 31 Jul 2025 06:01:46 -0700
X-Gm-Features: Ac12FXxSBgXO3zoKmReetkU124ejSczJm6Q2NNCXYd_q6u_vkqdJE5hWUIcIcf4
Message-ID: <CANn89iKRkHyg4nZFwiSWPXsVEyVTSouDcfvULbge4BvOGPEPog@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ip: lookup the best matched listen socket
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 5:33=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> For now, the socket lookup will terminate if the socket is reuse port in
> inet_lhash2_lookup(), which makes the socket is not the best match.
>
> For example, we have socket1 and socket2 both listen on "0.0.0.0:1234",
> but socket1 bind on "eth0". We create socket1 first, and then socket2.
> Then, all connections will goto socket2, which is not expected, as socket=
1
> has higher priority.
>
> This can cause unexpected behavior if TCP MD5 keys is used, as described
> in Documentation/networking/vrf.rst -> Applications.
>
> Therefor, we lookup the best matched socket first, and then do the reuse
> port logic. This can increase some overhead if there are many reuse port
> socket :/
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

I do not think net-next is open yet ?

It seems this would be net material.

Any way you could provide a test ?

Please CC Martin KaFai Lau <kafai@fb.com>, as this was added in :

commit 61b7c691c7317529375f90f0a81a331990b1ec1b
Author: Martin KaFai Lau <kafai@fb.com>
Date:   Fri Dec 1 12:52:31 2017 -0800

    inet: Add a 2nd listener hashtable (port+addr)

