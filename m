Return-Path: <netdev+bounces-222128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CE6B53365
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3FEA1CC07F8
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6721322DAC;
	Thu, 11 Sep 2025 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="spibFGlQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB20322DC5
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596504; cv=none; b=eu1ku9L7VvKf3Bby/VSrlkqMXtIlxK9AI2OutcpL+66Ynwh4GFyvNjPUwmEZppRyEnXR40AgdCRH4L0LO8aXz8pzz6aqJ5nTpU9gQETEI0aSKp2hSnrm0d5YUDncrPzMK60jA9HCpbwx0cmq0GIonKciWn6C5kupCPVmkBJgdhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596504; c=relaxed/simple;
	bh=x1Ibz1Ro2+nP+d06nbtfG9UfdciPBYtybc/DZr0g6OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3OwTxz4xpUKV6zOWx7jKQdzkrecExB7rZW3T7v4ndBiMGLhY70Xdvv6wCxH/J+5rTDSWqOz7hNsS32ZaEA0Ghx+rlukANZb4zfSh6OnytbBW6bUl1n+qEKfXEZ43Fuu1BhdSrnqL44jbbSoIoIW5+e/E1qiP1kRUbdAu2lD9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=spibFGlQ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b5e4fc9b4fso6614121cf.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 06:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757596502; x=1758201302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m89lThiGHpcn4DUoXeNLI6soHQXzWM/QJgRk2t7Qa7M=;
        b=spibFGlQ16o8UipR6OnZfXW9NpIg+mkvTyfX89ZyRn4J9jjq1itbq/VV4DHIflPd/X
         M16qYNzYXa+dLd80GT/FluOFS4mue4iynZnWL7HoAsIbjGg4mAenh1hf1hc1/tmji5Em
         KrdD8/VainiB2U8WAnZ+A/OQhRasWRCBTYPBHrg+X38CV8z5tNiHB0eBDiCzU8yrUNvx
         8p0ar8MvL5Ev5Fh/mWb5ym+TBb8n1I72uNXe95uByrdHb3+xfSLuhTlwbhHzzUKxcD/a
         yahuT7+8qZet65bvg/5ktTsz72DLJtm2Tq2YTkybmyq5X5invgoXOF+O55fU+nEwaUdM
         ibuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757596502; x=1758201302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m89lThiGHpcn4DUoXeNLI6soHQXzWM/QJgRk2t7Qa7M=;
        b=VN/1CG7Gzpmys6JxAbV1oZEfA/EgLPkl3LZpgHztjh/iiY0KATtnxDt+QRlfAnkQ0g
         L7pglUFLhHmt20X8JL7/XxfNf6XpfeEt1vB3CoVdM/hXYr3mX5LFLTGR1hA7bAIStjiq
         uO0+0rdMrzJ4cOxaj3CuPAAiJbyQhXYNN8RX7hW9+H6poeYbHa5jQv836QMgSk0+xq95
         TlGO00EmHh8/WqcRvPbkeTon3ysuwNRUab3xuQZMECuFcPSuSskufxYz/GEfTesCVLtr
         5l/73ZhrtyXIi+dUVZ3i6uhXD21yla3O9S6T6Gfv7WV2C82JwH8AOgjnd4PK8fvi0bQA
         h0iA==
X-Forwarded-Encrypted: i=1; AJvYcCW3wLITJsx9CfyeiWNT3ak7iU3Sy4b/IfBwSAcQoPwosKPht0G6foWjngCg004AMBAaqoAqoOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqdHg/2PmXqqa+KcdkDY/95B6gSEcnyowWo6Z1EtDxz1TpS+qj
	k5T98vQ5kBoBbpVIZ1S8EvnJTLVNz9EdoBex0q+By0Z2SLtMQxIyP9lfqfp2SrCdJ7TKBcpT4wa
	NlsxnMJ2fLsg0ha6y5EKOO/W3gDvH3G1Y6Y/KXGGV
X-Gm-Gg: ASbGnctx6S0MOcVEi1uxp8vVFG0b8ui6vpmAFIVTvNvCDkx/Dn0HA+WIq7xCZXdfIqy
	rgum0ZU+RMp4whlZJV55Km+tlexvYRPSh29i0s+sQnEa8xDJzak836lSYiWyS1VRzMJNtUIghSA
	LORbYEVut+5QemnPJcUDp4YgYPNAxfSEUuPnPTeUIW52TDjp79liMGJodVcR1w4AWz9uzuSPiIK
	o3xlfiaSpk4ytpePclGS2el
X-Google-Smtp-Source: AGHT+IGIFHagHDSkEorcDOmHFA0hr15/XcJBaSlOhnPlKEK6spa+aRn1vk32LO8prgZjy2sfuW+qceEq4tHAHByM7ls=
X-Received: by 2002:a05:622a:55:b0:4b2:8ac5:25a3 with SMTP id
 d75a77b69052e-4b5f84b5754mr252983901cf.76.1757596500594; Thu, 11 Sep 2025
 06:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911034337.43331-2-anderson@allelesecurity.com>
In-Reply-To: <20250911034337.43331-2-anderson@allelesecurity.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Sep 2025 06:14:49 -0700
X-Gm-Features: Ac12FXyGkA7EfDNm73LKWj5ZRtRA_sD8e4Ox-VzRGuY9LKyWNf3W4me3uIIm1UU
Message-ID: <CANn89iKUKof727RDZkbfA-Q3pbV0U-pTH19L-kSvhhhtkKYGTA@mail.gmail.com>
Subject: Re: [PATCH v2] net/tcp: Fix a NULL pointer dereference when using
 TCP-AO with TCP_REPAIR.
To: Anderson Nascimento <anderson@allelesecurity.com>, Dmitry Safonov <0x7f454c46@gmail.com>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 8:49=E2=80=AFPM Anderson Nascimento
<anderson@allelesecurity.com> wrote:
>
> A NULL pointer dereference can occur in tcp_ao_finish_connect() during a
> connect() system call on a socket with a TCP-AO key added and TCP_REPAIR
> enabled.
>
> The function is called with skb being NULL and attempts to dereference it
> on tcp_hdr(skb)->seq without a prior skb validation.
>
> Fix this by checking if skb is NULL before dereferencing it. If skb is
> not NULL, the ao->risn is set to tcp_hdr(skb)->seq. If skb is NULL,
> ao->risn is set to 0 to keep compatibility with calls made from
> tcp_rcv_synsent_state_process().
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
>         setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tcp_ao,
>         sizeof(tcp_ao));
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
> BUG: kernel NULL pointer dereference, address: 00000000000000b6
>

CC Dmitry Safonov <0x7f454c46@gmail.com>

<cut many useless details>

Really I do not think you need to include the crash in the changelog.

Just mentioning a possible NULL deref should be enough, it seems
obvious skb can be NULL here
now you mention it.

Real question is : can a TCP-AO socket be fully checkpointed/restored
with TCP_REPAIR ?

If not, we should just reject the attempt much earlier, and add needed
socket options to support it in the future if there is interest.

