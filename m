Return-Path: <netdev+bounces-221956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F428B526A3
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 04:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2804F480EDD
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 02:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FC222157E;
	Thu, 11 Sep 2025 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XVIJFv55"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB8D2135CE
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757558671; cv=none; b=VDGDY7xTche7Ev6DgDPUf7JFOaYaBza76Q84xexbD23aJ0ldy2BSBGslXXm1Nohxn7buTs5zzds9u+47NbfonsH24BrCZPf68K8ktrzM+aUjYrotwPGhnrbnwQ2cqDfDeEB2d8Ghke7yYq/Zxg+ifEvx+qdVfb1GjDS13dXz3B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757558671; c=relaxed/simple;
	bh=RH/lKNWxB+jYL9Tts/+toOUQozWus/JszyD4wS05wgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjdPyhvugUXOeoSvAA6uOYo7DlpzAFg533h46woVppU5tmWMTKMTj1lhqmBq1balgjI5Z3MUeG4CJ+ix6BNs97uc3g42JGYad0YkZ213DnCwelkIuzvQJYW1i4qCfpXKIOy37qfg93f91fxZtgBM5b2I6sdjogHcODiFm17lHfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XVIJFv55; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso197745a12.1
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 19:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757558669; x=1758163469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbwrj9MCxkMdgb4OFtqE5AwLZMYq2qhd8B6juxSX8l8=;
        b=XVIJFv551C429ayZ1emor3JSE2hrYLwLSfUS98VacfoqUuCvmUQeJfXFeSrNfMPnGL
         DbUgOSPqNnF8qEIU9a9yELa+w9DXbSQltb45p+7xc9rrtM18Q1N8Jfq6orjkmPPJ/jZf
         2DerwLgVi/ZGH3bebzZpxEXcaqXU/0zBUKPlbu9nAr5RIk71mdoECxRnfJVHG7y2OyLR
         SEtXfU9L11w4iZkxVJnjCldsAG918j23rNEGC5Q6ID7FUMgXJVORh3mo6w7AmEX5Jg1B
         xCrxsPgA8XuNZv7UneE6Jbxye8E2khCfTrtVGXdYwM8cPG5CsUZu/BcX68Swb9jEqHGO
         YR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757558669; x=1758163469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbwrj9MCxkMdgb4OFtqE5AwLZMYq2qhd8B6juxSX8l8=;
        b=OB8WCJugjm1YiCV2bKk9Qp5QgNOP29jRhfGpsX0rtBbCrcWyZQlixM4ZNc7nl56ZWt
         4T0y5SDupBy7lJ+zZWnEQs1OV4F0nr0Erd9vZGwanEr2+xcJqaySnN+m++GzlK+vCcRs
         WcCP/DmMEs2oGnZpkP5avPmAerH+0S4J87PbTLTC/zt+kutbsBrvUHOJFLe3IySZujg+
         st5XJe/GyUgDaAJjtlQxFKZDtxSnRo/qv7Ieo/aOKbJ5+fcuIIKQly35/mt1sP9Ggm9n
         uxpNxRi3icwn5iKh6qHqgPrh123SEZN1jKGlVt560RWuXXc2v59NqE5436FMIVrz/Xdg
         qEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1udA6KZA1ohBXVYApkn0kJzmyNUGPHxt8O52tk+c7GQUabuUVqVIIiY9tQhn+Z22u6SCeB2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqhB0zATyLm0Kl7rGWaaBmjmonaxZYRcnyo7sfZdo/eflUP7r5
	mo07QHOfZC+rPAP3U9MjTxZKWG6Sv/i5EtaOFuq08uQfcPmG+HBYUe+6UsRHUXkUC8wYLcz9AQB
	5rwMcGUM7vlZBdXBQVXjFdHpJ4FBHWHLSkxsgWVod
X-Gm-Gg: ASbGncs7a1P2FNMdEJcdfKXcyor3IMvkGImTn+047N3Ui5ZgUNqwa17c7btAE/AD+Fr
	T1bfR5nTOqczC8nU4xbw9Z7JA4XOGx7UDYXbxzcQlEucGudCFGx/5wObawjzhULjWszedO9oTXZ
	HAO24mVa1Sxj4RZak/sQzH2Ljjm1C690Jsn/euiT12INx6pyc2YqhMC1TCQEw7BYoyGY3ZiqcBz
	yEzElugxeV0lSrwQ6OVimtlwTdZphAcRPz2EFrBi8hWhMEcyZ27imKW9A==
X-Google-Smtp-Source: AGHT+IHrKxy9g6rBS4o6e1tYQEA5wZNBsvI3ufN2vHAn6MqDAkniz9SsxcxDERH5dE5CRS5+X3a0rZ33jBsa8xcSqkk=
X-Received: by 2002:a17:903:38cf:b0:245:f7f3:6760 with SMTP id
 d9443c01a7336-25175f72ac4mr219280335ad.55.1757558668973; Wed, 10 Sep 2025
 19:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911013052.2233-1-anderson@allelesecurity.com>
In-Reply-To: <20250911013052.2233-1-anderson@allelesecurity.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 10 Sep 2025 19:44:17 -0700
X-Gm-Features: Ac12FXxfHhvQkAVyEXp7XmpClh4AmHOVNOOZbMkwFinVGbnJRgZPSR36H3GxaYg
Message-ID: <CAAVpQUBoCPervZLc+-bWF5+hXX8yj0SwUcU3MiUQ514xi-F6uA@mail.gmail.com>
Subject: Re: [PATCH] net/tcp: Fix a NULL pointer dereference when using TCP-AO
 with TCP_REPAIR.
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 6:32=E2=80=AFPM Anderson Nascimento
<anderson@allelesecurity.com> wrote:
>
> A NULL pointer dereference can occur in tcp_ao_finish_connect() during a =
connect() system call on a socket with a TCP-AO key added and TCP_REPAIR en=
abled.

Thanks for the patch, the change looks good.

Could you wrap the description at 75 columns ?

See this doc for other guidelines:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-=
canonical-patch-format


>
> The function is called with skb being NULL and attempts to dereference it=
 on tcp_hdr(skb)->seq without a prior skb validation.
>
> Fix this by checking if skb is NULL before dereferencing it. If skb is no=
t NULL, the ao->risn is set to tcp_hdr(skb)->seq to keep compatibility with=
 the call made from tcp_rcv_synsent_state_process(). If skb is NULL, ao->ri=
sn is set to 0.
>
> The commentary is taken from bpf_skops_established(), which is also calle=
d in the same flow. Unlike the function being patched, bpf_skops_establishe=
d() validates the skb before dereferencing it.
>
> int main(void){
>         struct sockaddr_in sockaddr;
>         struct tcp_ao_add tcp_ao;
>         int sk;
>         int one =3D 1;
>
>         memset(&sockaddr,'\0',sizeof(sockaddr));
>         memset(&tcp_ao,'\0',sizeof(tcp_ao));
>
>         sk =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
>
>         sockaddr.sin_family =3D AF_INET;
>
>         memcpy(tcp_ao.alg_name,"cmac(aes128)",12);
>         memcpy(tcp_ao.key,"ABCDEFGHABCDEFGH",16);
>         tcp_ao.keylen =3D 16;
>
>         memcpy(&tcp_ao.addr,&sockaddr,sizeof(sockaddr));
>
>         setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tcp_ao, sizeof(tcp_a=
o));
>         setsockopt(sk, IPPROTO_TCP, TCP_REPAIR, &one, sizeof(one));
>
>         sockaddr.sin_family =3D AF_INET;
>         sockaddr.sin_port =3D htobe16(123);
>
>         inet_aton("127.0.0.1", &sockaddr.sin_addr);
>
>         connect(sk,(struct sockaddr *)&sockaddr,sizeof(sockaddr));
>
> return 0;
> }
>
> $ gcc tcp-ao-nullptr.c -o tcp-ao-nullptr -Wall
> $ unshare -Urn
> # ip addr add 127.0.0.1 dev lo
> # ./tcp-ao-nullptr
>
> [   72.414850] BUG: kernel NULL pointer dereference, address: 00000000000=
000b6
> [   72.414863] #PF: supervisor read access in kernel mode
> [   72.414869] #PF: error_code(0x0000) - not-present page
> [   72.414873] PGD 116af4067 P4D 116af4067 PUD 117043067 PMD 0
> [   72.414880] Oops: Oops: 0000 [#1] SMP NOPTI
> [   72.414887] CPU: 2 UID: 1000 PID: 1558 Comm: tcp-ao-nullptr Not tainte=
d 6.16.3-200.fc42.x86_64 #1 PREEMPT(lazy)
> [   72.414896] Hardware name: VMware, Inc. VMware Virtual Platform/440BX =
Desktop Reference Platform, BIOS 6.00 11/12/2020
> [   72.414905] RIP: 0010:tcp_ao_finish_connect+0x19/0x60

Full decoded stack trace without timestamps would be nicer.

How to decode stack trace:
cat trace.txt | ./scripts/decode_stacktrace.sh vmlinux

>
> Fixes: 7c2ffaf ("net/tcp: Calculate TCP-AO traffic keys")
> Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
> ---
>  net/ipv4/tcp_ao.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index bbb8d5f0eae7..abe913de8652 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -1178,7 +1178,11 @@ void tcp_ao_finish_connect(struct sock *sk, struct=
 sk_buff *skb)
>         if (!ao)
>                 return;
>
> -       WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
> +       /* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect =
*/
> +       if (skb)
> +               WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
> +       else
> +               WRITE_ONCE(ao->risn, 0);
>         ao->rcv_sne =3D 0;
>
>         hlist_for_each_entry_rcu(key, &ao->head, node, lockdep_sock_is_he=
ld(sk))
> --
> 2.51.0
>

