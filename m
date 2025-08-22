Return-Path: <netdev+bounces-216024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6A2B31955
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD251603D2
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 13:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6CC2FE574;
	Fri, 22 Aug 2025 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z1cke+Om"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831372FB993
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868841; cv=none; b=lhET2sYlf+Vz6fg+E7ulvtQTc+/FV3IKCAAMrjKZ573qrZy0LXurzCYghkKV3329Chb+ocmZW6MRTalZXW4DLKwz/+Vkp53uo6DF2Oq50S9RqAZz3OCF7JVwd96aPRUVXVFCvjmZT/FY5twCNctcEBAEvOvgl7TVZI4YS+5enzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868841; c=relaxed/simple;
	bh=UEA0I0OBek4RMYqNfE6NC8kYNpRUAS+tTluqow4AcGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPAhboYP85+ZhqorrPAm3JFH7svNeWNP1k2P5zZIwgV91ttoWqnSfz/kh8lI9v/LoZgdTx/JNh6bUrB7MRkEvjgMgoD7JNELnfvuTY99EK4Vnd6F+0Rg5nBgNtFrNj+Shc4b2X+KwIZ9rRpaoLQz4E2lwaBu6oaP9WAO8/HmVp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z1cke+Om; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b297962b9cso21007871cf.2
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 06:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755868838; x=1756473638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xETFehANMGWaAVgPe3RiL9S32v2mzS8mdqrngoJu4aM=;
        b=z1cke+OmpnqKXYIyOX0t8maWENSG0DJxnvi5gtkRAFX/feK6i0/1LdjL5o88eiy+Ow
         v/PUUQm83hJ14O8vrGi4pdGvN2+Bt3ZTgkLiMUWiSJgeofZTqLeOgcNMvCAil5dy02gx
         uETaJOIcXIoPszSTqRqi1fAuKPCmwwEzeTistDJ3DWxTwut0nlA9Jym0fJNi9CHw7EZR
         UhJPs6gO0EUw+m40s2o3o5nRxa96uFBocqiWoPkkJJ8kK3BuaFYXvKKf2nys+0Mg+/7d
         duFvh9snZueoutn7BLcPoOU+bu+nD/BQD8rUamYmkPltia3Tr9743dwnievP+UIMt+DS
         9uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755868838; x=1756473638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xETFehANMGWaAVgPe3RiL9S32v2mzS8mdqrngoJu4aM=;
        b=Hg5Pz0bApvEgKHE8uUqizmwsWEKSMDPAEIFDVcV+vKu4jeM1nzUw5RAOLDs8XDXNYU
         fYEfT9Xe5UhBtRepjaW/zd5AsEZVjUiY6pS/fLD8DU/jkmvDfU1N3e5AG1VDB4xqisdO
         rQId3mDJLP50EM6rfUeztN3TMW7VECI4wCX0UhpR6i5nudArwcQpFCqYg+FgK9yj2AqM
         iZLFbrReQMpbNbFiARi8vvv1LapxBQnJK3i9AdxCW2pUzG8abF+acypbA+yt5+X7MnBJ
         hgqTXQ7n3edbvewZCAhowuEq0xWAfkmAaDiBGKyHBvJw9hGfT/Ftw+6KvbgKMmQiURF9
         8w5A==
X-Gm-Message-State: AOJu0Yx1X80xl14hwJGo9wriyiy6MzmGtIFftN4dBvmDluxASYV8AGYx
	V5WvBuFMScYAzwN0kXVDkbj90Xtq/MACQHikxDNBYK76kyVw+KJixcnENlkC7VJGS4wzNYZk4sL
	MD2yedGpN0Sn4dbg0VN3qVB8lJp/glZpkmUg+gllnCaoQyB18hQtZEWCjMoU=
X-Gm-Gg: ASbGncut7MAWQF5YRfzzNzXWomihfHh1rDzX2YfgORyUT9/8pTbE+u3+DTZyJmPcJya
	GG08yQwnoY7WvlbEUGWGAi7D5rhcTtfegGvhCWJKksxiDf/x6Bl2IQkmX+1L5hKh5gzwWjk5R7o
	qOiArZUg6gtRLZlnbN02C2V5bLYgYjzZe0bB2LY1QcNaGcBl4HXZx9zBhxjDyMLYeIbBMr+kITc
	3lvy4l1KqA6g8Y=
X-Google-Smtp-Source: AGHT+IHs9rx9/zkamqK89P1S4FuJPEcW2Dda5ow0is/c7/qWci0ER7SJoxQjWeHAVtUhnpX1+K66vUhCrAogHd+zq10=
X-Received: by 2002:a05:622a:181e:b0:4b0:c1c0:158b with SMTP id
 d75a77b69052e-4b2aaa3c6abmr32297411cf.29.1755868837718; Fri, 22 Aug 2025
 06:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKgnLcw6yzq78CIP@bzorp3> <CANn89iLy4znFBLK2bENWMfhPyjTc_gkLRswAf92uV7KY3bTdYg@mail.gmail.com>
 <aKg1Qgtw-QyE8bLx@bzorp3> <CANn89i+GMqF91FkjxfGp3KGJ-dC6-Snu3DoBdGuxZqrq=iOOcQ@mail.gmail.com>
 <aKho5v5VwxdNstYy@bzorp3> <CANn89i+S1hyPbo5io2khLk_UTfoQgEtnjYUUJTzreYufmbii+A@mail.gmail.com>
In-Reply-To: <CANn89i+S1hyPbo5io2khLk_UTfoQgEtnjYUUJTzreYufmbii+A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Aug 2025 06:20:25 -0700
X-Gm-Features: Ac12FXyXl-pdAzKDjifHwg8N2t9NT0oNpueGbuFDgpPnESaDQC2CMnxh26WfmPE
Message-ID: <CANn89iJ-Xqb2uOZwyatq-6gMHPVt0xga_dypiF_X8Z_L0eao4w@mail.gmail.com>
Subject: Re: [RFC, RESEND] UDP receive path batching improvement
To: Balazs Scheidler <bazsi77@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 6:10=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>

>
> Can you post
>
> ss -aum src :1000  <replace 1000 with your UDP source port>
>
> We will check the dXXXX output (number of drops), per socket.

Small experiment :

otrv5:/home/edumazet# ./super_netperf 10 -t UDP_STREAM -H otrv6 -l10
-- -n -P,1000 -m 1200
   4304

If I remove the problematic sk_drops update :

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index efd742279289fc13aec9369d0f01a3be3aa73151..8976399d4e52f21058f74fde13d=
46e35c7617deb
100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1575,7 +1575,8 @@ int __udp_enqueue_schedule_skb(struct sock *sk,
struct sk_buff *skb)
        atomic_sub(skb->truesize, &sk->sk_rmem_alloc);

 drop:
-       atomic_inc(&sk->sk_drops);
+// Find a better way to make this operation not too expensive.
+//     atomic_inc(&sk->sk_drops);
        busylock_release(busy);
        return err;
 }

otrv5:/home/edumazet# ./super_netperf 10 -t UDP_STREAM -H otrv6 -l10
-- -n -P,1000 -m 1200
   6076

So there is definitely room for a big improvement here.

