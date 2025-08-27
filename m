Return-Path: <netdev+bounces-217370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB74DB38791
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F00B3AC04E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4716B352090;
	Wed, 27 Aug 2025 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sxxYMjWV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60FF350852
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311144; cv=none; b=J2o2NgZjDV7KvjjzNl9YcqairNfyg3UKNcsqK0JAVD+A7IbvwzFEfY5WUGz5pKEiazdsW5fxMDC+cnMNcX5TedxhHeSfXpcono7U3sURhaZKjmC6DLB57OPfdudvwYLRT+oCYTSPYOmZxjkgpXwJMdnNL2oOEW5d3dGWslBB5sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311144; c=relaxed/simple;
	bh=IUdqkkL+FqmZnQ5cV2Tj1y+ulywJNbs4f9RW9hniOY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WobQmNKhC8QFVVNKm/z4ixQovT/nPDFWSvpi1y7bOF10/oOQ3P7Ti8TiDM4/wGyJxffgIQKDpp+bgvp/KePhTz0YO8oQzcx7eW1uFSztb+szU+QtxYDbQQFWAOACvFQJ3XT5sKV3uWfIY8hAvDt7aYb2OcGKNKGXEm769wDK6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sxxYMjWV; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7f8ea864d68so9735185a.0
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 09:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756311141; x=1756915941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sWCxzZAAFSLpgy4vYbOgl/Xp28Y6qUVGYsyNTB2z28=;
        b=sxxYMjWViaISw0GwKsEsBqmhUbB+4r4HnqEJ29Gx5NAxmI+2DkDGFqs3C4MxCrgZV6
         YNVPKYQvuKcHHgip6Fssc9BjdiICLOvdPNH9HdcY4gk2n3FFeZSXxPJYwxtXs8VwNYzR
         d5ZtAOKV/n2ynX+9dNwHkR8VlgxtUf/NX4aFFy2tvUQnqK0ZGvZc7BMiYODYHMCeGwhn
         VouRga/aAtw69CfY7lWSqIv0dAmVAA44AmZFKZuCKrZjR9AvzoBRrNBNP8JaRX1ELvq8
         eDNML74hf26qKF6EZCk+ZhdWresofaL+bUm8JUIjhHz5rmPs3MXuhIK1HodRacTAaTB7
         jJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756311141; x=1756915941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sWCxzZAAFSLpgy4vYbOgl/Xp28Y6qUVGYsyNTB2z28=;
        b=lvbQ9Nm5IvekG1U52T9sZw7IKCE9Rc4Sf3T2o2EBl6qeYBOGgppa3TGvxMbATJfBpM
         HOjFfQkO+qnh5mbX6vyriGOrxhQIXZ7v+AXGlg9CAqjx0OBM/OGtMM4iphzoG7BNsy4v
         IXrfWiJQ1nNVV3gvjlP2/o0C5E7mF5Ja+DwOG/qXJYQ8hB4kb8cl6kfu4k4A/eWklBhb
         Ab2Ro3Uat8jxq4OigFLyZjOMm9Ww+kvgtrX4LN2MjbkkI88JUQpz1FeFNTPswCh+CyLY
         XqecTaiSyKhDBj96YlOrNpumwiQLU2qKFxr/Fr6pYAP5W75sdaifaNDi+v6r2jpgOiqQ
         /3zA==
X-Forwarded-Encrypted: i=1; AJvYcCW3fAlqpEHUn3vf793VTbvV3Ix5J6HjtHCC4vFHbAsCgMIZzo22tRcBX2R8x6ivftrlAEbVigY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh1eEmJxcHwxycgIMWlbhprX88MKRTcVC+hGWCbRW0lB+yURa+
	kGQqUMQnacSBBm/SD8m5XdVmJZDN+A5a+q86bVtUSyxftAChsY8iZ0F17WeoLQEIUu7W/EUwALo
	YPrWeLfm1hz7cZGtZ4TFjOmhfP1nd6zHKYQW7yCrS
X-Gm-Gg: ASbGncteSLLkxVOQ57aVyI3firWj/xFSOLHwC4NnGARXNIENzIUyLaedq1phIXtWRVr
	X9066wixcxvwapshgV5P8y34NsVPbo7yjcb3raZny53wir8MIK35hFjXcgozqoNwWkWuBW1y4C3
	ytuiX2bXn2O1mGL5Wvfvda8EKw3yf0thhZdH23rvKLzzIQr6bfR+mt9Mi3I1916qDJSpv6vL2n0
	GQhrOGGxir8BvA=
X-Google-Smtp-Source: AGHT+IFfDl0QtGAhABzZAxOiqRGAAui91INmTBPHKOkkwqnN+a2UlV7wcjKCOvP1sNO5osgtZEbLgaoNgIL4ajWs7yc=
X-Received: by 2002:a05:620a:7084:b0:7f9:882c:6e98 with SMTP id
 af79cd13be357-7f9882c6f42mr23878685a.67.1756311140451; Wed, 27 Aug 2025
 09:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827120503.3299990-1-edumazet@google.com> <20250827120503.3299990-2-edumazet@google.com>
 <b6013a6b-5423-4cfd-9b19-94ee26b95028@kernel.org>
In-Reply-To: <b6013a6b-5423-4cfd-9b19-94ee26b95028@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 27 Aug 2025 09:12:09 -0700
X-Gm-Features: Ac12FXz-O0M7mTvn40FIy-G8eFGhddWKlzYxRWKLNHOmdR-p_oBDWOezmaluXy8
Message-ID: <CANn89iKF+DFQQyNJoYA2U-wf4QDPOUG2yNOd8fSu45hQ+TxJ5Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] inet: ping: check sock_net() in ping_get_port()
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 7:50=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 8/27/25 6:05 AM, Eric Dumazet wrote:
> > We need to check socket netns before considering them in ping_get_port(=
).
> > Otherwise, one malicious netns could 'consume' all ports.
> >
> > Fixes: c319b4d76b9e ("net: ipv4: add IPPROTO_ICMP socket kind")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/ipv4/ping.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
>
> Reviewed-by: David Ahern <dsahern@kernel.org>

I will add in V2 this part as well, and will retain your tag.

diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index accfc249f6ceb29805e3bbec25d0721d2563cb4f..b6b336dac961bbabbc30f7f7fb5=
fe41d2ee54125
100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -181,6 +181,8 @@ static struct sock *ping_lookup(struct net *net,
struct sk_buff *skb, u16 ident)
        }

        sk_for_each_rcu(sk, hslot) {
+               if (!net_eq(sock_net(sk), net))
+                       continue;
                isk =3D inet_sk(sk);

                pr_debug("iterate\n");

