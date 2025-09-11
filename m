Return-Path: <netdev+bounces-222341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7668B53F15
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 01:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78318587CEF
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A42F5488;
	Thu, 11 Sep 2025 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8QYzpAg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8E42DF15F
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757633232; cv=none; b=e/ahmtB+8UXFEKBh1Svofd7zbZUkLO/fbU33sWqKi+n/HJ/u2Yxqi2c4501WtlbZYGonL/mnzltpTFQp4rLNfBvP9WzRQCbentavjnATGco8KLSQFwFK3VL+bc8ErE7qa5uuQYGfbcO7kMtrHUnEx/AonFqTc9saNPfzCTmKUOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757633232; c=relaxed/simple;
	bh=Sa7WDnqLcy0CN0xtgRlLc+G3Cv06aA8NxV+g4ljiLlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kc7YyNSCsVzypg3EJXYD5F8gLQfmS7tGMBGJ8+X6R2FbdJdkoIiift7AXtq/IaTkuSwynDTce/++EGMK2s1kukXeT/eZwISyOa3356hFW1FQPUPRO1f/TBWaHeQYs41oNj5/XE+R0cD/xxs0g4GlZ6rISb6M0EsUQJG90PBmI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8QYzpAg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-25d44908648so3335965ad.0
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 16:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757633231; x=1758238031; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bexJF6Inyy6LnxM3Eg/whEIjho9dF6M6YFDRESWcxkk=;
        b=Q8QYzpAg/bAFaVhL5SgIRCG3dMOoTdQAvlXjrbve7bZ/wBE/P5bD8cQeuSKozangPD
         0vZDtCH25oFJzJlfe3J/Z+Bzgt7uvxXeNKs52VNimvpn8jMQLExEHjc5nVjzofUN3XXi
         QwmchyRol2h5HN+0M9sWDZwZPbxYQf/ESQ1PEKfgA+fkLOPHd6+9HSRQi7Ssxgjb0bMq
         pqtPqxQ57O38ptVhE2dzRl4cd2h1y2ThZtm7bgc50CaSOsmFFYRuCpAgxCqyLe/T57U+
         GHObpDUKzjskKiyvuZQrb3G4Dfn16GWggmEJXy2TLtVNp0sVM4e5J0DrKex/w0UF9xrJ
         TLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757633231; x=1758238031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bexJF6Inyy6LnxM3Eg/whEIjho9dF6M6YFDRESWcxkk=;
        b=flmeCiJ7pvDH4gDwfnk/IcCECp/04R+0aHvph5D47MjkkBkfgHWxmOM3v0XVOlTVpz
         ic+jmiL5DTPHNIY0FE+udl4xKgjNWUsxwSlBNtMf0/J692l1KJXrc6uY3DIxrIJXeQ3G
         6/4FfCMsIc61h5b08hlve6RJU+X6dSGgAbDifu/OVyGJVA7yHkeh6N462aKHvNrlSTZ/
         z1XLzi/C9MJDKForBYk7uJDowdrapyvVGTEeG8ttJKF4IKdGMAKfOpxsyJZaA9CXeCxe
         Fn7UeIA3CE+96SDcWHSLrbFfQUQQ2+7uCDO+58uV/oz1a/ojQVpdJvZ3YBHQ3wVjTyXo
         8oYg==
X-Forwarded-Encrypted: i=1; AJvYcCUGUzAn5QGMd0AwBoeo8k/JwlHqKbFsRPxz4+GdNvVG84hflRuVcBh0jpqw04JrfuVWxo8QGSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwouE9YpH1Bbz5tb3csbHBq7x81vcNFHAxC4f4QtEwTU/dyblwO
	Xt54g3jYu2tIEpNPv9W95fWvi1uzXfoVZ0jT4XX+v1c554ERWilV8/caB6bPColwMsuU4xznzhE
	Q71nLKGRlIRl5UZGqD51B/7B3GIBMYCo=
X-Gm-Gg: ASbGncsgTMhO6VIy22+OGXk9pH0DabW9g8AWwq1mD7c664dsoNoiQrA34MjGEWFeVZs
	BKEZbtjAMH3RMxo3zVs7TvT96R2TJrvci/Mpb0ZewKr15PimCPoHqcDR8d/O1YR79C5YY6XBrep
	MtWKXaREkHrlJF9/XDwRggw2WVZMAjIs/ZyzZBgkOgQlr6SFNAHkqws4vcUATKTQLEv6ZiPGRqg
	gNkfsoJQvqXwCk5jUrWah7AhJLxAGqUy1mZdElpwOPuB4014qdVLuIDIpKPIdo2HtzkMDEAFzGk
	g9Slp0/RkK30CyEyNk1jukp+Vr33wKRabgs=
X-Google-Smtp-Source: AGHT+IGujgGcgPAa+13BFpZEmdBxHGerGsT/LM+wOldoflldHKwYPuPT2TQsekyBMM2wJPjlCNcYBs98sRTQj2j3Bl8=
X-Received: by 2002:a17:902:f546:b0:248:c96e:f46 with SMTP id
 d9443c01a7336-25d27d1d5f5mr8778235ad.60.1757633230551; Thu, 11 Sep 2025
 16:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911230743.2551-3-anderson@allelesecurity.com>
In-Reply-To: <20250911230743.2551-3-anderson@allelesecurity.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 12 Sep 2025 00:26:59 +0100
X-Gm-Features: AS18NWB-oWd0_mfy48ldKTLmBLDxrqKiLYL0me1BpAcMtw_1UvQhMF1AnAAP0gM
Message-ID: <CAJwJo6bsZg-arM6GAQM8Lv3DivWUERu0VyFQgi4DA+SxRrZypw@mail.gmail.com>
Subject: Re: [PATCH v3] net/tcp: Fix a NULL pointer dereference when using
 TCP-AO with TCP_REPAIR
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Salam Noureddine <noureddine@arista.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Sept 2025 at 00:23, Anderson Nascimento
<anderson@allelesecurity.com> wrote:
>
> A NULL pointer dereference can occur in tcp_ao_finish_connect() during a
> connect() system call on a socket with a TCP-AO key added and TCP_REPAIR
> enabled.
>
> The function is called with skb being NULL and attempts to dereference it
> on tcp_hdr(skb)->seq without a prior skb validation.
>
> Fix this by checking if skb is NULL before dereferencing it.
>
> The commentary is taken from bpf_skops_established(), which is also called
> in the same flow. Unlike the function being patched,
> bpf_skops_established() validates the skb before dereferencing it.
>
> int main(void){
>         struct sockaddr_in sockaddr;
>         struct tcp_ao_add tcp_ao;
>         int sk;
>         int one = 1;
>
>         memset(&sockaddr,'\0',sizeof(sockaddr));
>         memset(&tcp_ao,'\0',sizeof(tcp_ao));
>
>         sk = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
>
>         sockaddr.sin_family = AF_INET;
>
>         memcpy(tcp_ao.alg_name,"cmac(aes128)",12);
>         memcpy(tcp_ao.key,"ABCDEFGHABCDEFGH",16);
>         tcp_ao.keylen = 16;
>
>         memcpy(&tcp_ao.addr,&sockaddr,sizeof(sockaddr));
>
>         setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tcp_ao,
>         sizeof(tcp_ao));
>         setsockopt(sk, IPPROTO_TCP, TCP_REPAIR, &one, sizeof(one));
>
>         sockaddr.sin_family = AF_INET;
>         sockaddr.sin_port = htobe16(123);
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
> BUG: kernel NULL pointer dereference, address: 00000000000000b6
> PGD 1f648d067 P4D 1f648d067 PUD 1982e8067 PMD 0
> Oops: Oops: 0000 [#1] SMP NOPTI
> Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop
> Reference Platform, BIOS 6.00 11/12/2020
> RIP: 0010:tcp_ao_finish_connect (net/ipv4/tcp_ao.c:1182)
>
> Fixes: 7c2ffaf ("net/tcp: Calculate TCP-AO traffic keys")
> Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>

LGTM, thanks for your fix!

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

Thanks,
             Dmitry

