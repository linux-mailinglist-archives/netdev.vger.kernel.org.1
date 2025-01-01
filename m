Return-Path: <netdev+bounces-154646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA689FF2B3
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 02:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB0A161B56
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 01:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E810746E;
	Wed,  1 Jan 2025 01:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZRjNZMq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6579E1
	for <netdev@vger.kernel.org>; Wed,  1 Jan 2025 01:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735696398; cv=none; b=qrvE22B3DFTqpmAFpsl3taSNTdVI2aoYqf7+iu7g7BrS10Ae0OfhMRiLVGb1fVineHkKWXaEMaP9oTk/giFjE7mTaZMRDgmozK4MzetuiTMAyN83UuoW5RNEm2qFmGEbBhXQg586+ndQk4cxAS27lCPwwa12C2ubthpPoZzLj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735696398; c=relaxed/simple;
	bh=V7rv3443SaLb4s4uFyIG+ps1lL2bb1vImPmxOku2k9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCZ9Q66em+UI9+5CLwRH3yE9RxjBz9L5CRV0AepoUjph8ubzNGchwigdQTvsoSHWHragrIp3KKH7cjoVjTqn21r59kDQ4+3mO+O/qT2XfHrpqrkWcHjA7d4PUh6ODZkDhMIPClvOZjmdERJsa6i9i4ARp8HgY0tjH00YCLhTTMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZRjNZMq; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a813899384so39619265ab.1
        for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 17:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735696396; x=1736301196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A43/VJutXTQSFmucF3kQxfY5xbHwgQPwHCgRWNBpNoM=;
        b=HZRjNZMqyeY9mYnz/mxpZnSSzUnVLGptDd5IMjQKiBQvqC2j9BQqOknC98MnkxtqFA
         nHrOPdty585S9GIvSs9VmZme4/MYNXu91yRXJdJtQW8r9uhhmTz5ueAgikqXTx19b/6b
         wkz7aQUubUWKcwp4Pe5HMYghkbxBZSjEhdEVfJT/P5g887faL1gcvBoHYnIUo7epU2Zg
         TBwTjBFyUuFrOyJ0+pZp09eEwiwWQufvcu5qFD9ZFTj3JaV+EpuY6BldT7FcYNbDvezC
         a3ziVtFo6CW5zdt0UccOWtsAXdg+jxsmhg7PvgkNJ+oy9+gpHenmOJmaWqYboI+lDrpS
         e2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735696396; x=1736301196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A43/VJutXTQSFmucF3kQxfY5xbHwgQPwHCgRWNBpNoM=;
        b=OLQuId9vixINz+7YMCa2eK9EYmSFmu1hRcBxC7p0qEuJ/WKD+YL22sHtlFx9YBrvrz
         ZR1eOX7AEiLKJ74V8gb0IgonUc204Y8EV6EusHOfVwm8lZmIBpS0nPs6e4ILTlTGnZHt
         XLPjsPs3tJBX48XtzV9UJJOf58b5E86eDxoKYIJSYPtBKTZ8Fnx6xd3s+iY/FCCruATT
         43PNtLFF3qGl5+1IgvL8TF3ATONpKd2uNwVjQQedNf/l/nvR1fNjrNU0oWz3TuTTc+7x
         R0hAioeQ7g6ESULVpUolvfaqOyKq1ri2Mlel3vQsd5CjKHH0p91dPwu7oKW3PFl6tPpn
         kFsg==
X-Gm-Message-State: AOJu0Yy4Wq1K/ktr+8qSNFE9CfkFUc73HWS9bz/7KFLHieI4WylOKxqq
	3qrty8La2gl3maCRph6OW2eiuzid/LcQcjVu9hQErVH7JK4So2LeU7fZgIkPH04afdDEde5WFiD
	9JB8/Nevvu8qzNb7d98VlyQtaMhwnEigjZcA=
X-Gm-Gg: ASbGncvG9css+DgbXfy2Gkbe5c0WqgyptaPbeeNcnmNVklf4bFL+4E7SPfi1KwieHXv
	TeGWnSTE/MCQL2bLQhqS/vcUGUmWdJ5litP5W
X-Google-Smtp-Source: AGHT+IE6IWdePg2TDEgxt0gLLO4crnYWBGLu0NxE8n8YqyOqmgfYU3RJfrtmlvr8yzKmC503GB3IL0Q+i/Tg844piFM=
X-Received: by 2002:a05:6e02:219c:b0:3ab:4bea:df97 with SMTP id
 e9e14a558f8ab-3c2d591a3b4mr394007165ab.23.1735696395757; Tue, 31 Dec 2024
 17:53:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFmV8Nc758FDNK3FNSLQui4RmE3-TQr7d2tM_tOM6bC=OfEDwQ@mail.gmail.com>
In-Reply-To: <CAFmV8Nc758FDNK3FNSLQui4RmE3-TQr7d2tM_tOM6bC=OfEDwQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 1 Jan 2025 09:52:39 +0800
X-Gm-Features: AbW1kvZKbEtZ27Wgte1a-ioSxzGWh3m-7BM9QyliVtged-Uov-yBYiokoDhiP34
Message-ID: <CAL+tcoCWmJLQBL+O-GEEaDj8bDDrbjCcrKK3ky9+BJetWNOt5A@mail.gmail.com>
Subject: Re: perhaps inet_csk_reqsk_queue_is_full should also allow zero backlog
To: Zhongqiu Duan <dzq.aishenghu0@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 4:24=E2=80=AFPM Zhongqiu Duan <dzq.aishenghu0@gmail=
.com> wrote:
>
> Hi all,
>
> We use a proprietary library in our product, it passes hardcoded zero
> as the backlog of listen().
> It works fine when syncookies is enabled, but when we disable syncookies
> by business requirement, no connection can be made.

I'm not that sure that the problem you encountered is the same as
mine. I manage to reproduce it locally after noticing your report:
1) write the simplest c code with passing 0 as the backlog
2) adjust the value of net.ipv4.tcp_syncookies to see the different results

When net.ipv4.tcp_syncookies is set zero only, the connection will not
be established.

>
> After some investigation, the problem is focused on the
> inet_csk_reqsk_queue_is_full().
>
> static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
> {
>         return inet_csk_reqsk_queue_len(sk) >=3D
> READ_ONCE(sk->sk_max_ack_backlog);
> }
>
> I noticed that the stories happened to sk_acceptq_is_full() about this
> in the past, like
> the commit c609e6a (Revert "net: correct sk_acceptq_is_full()").
>
> Perhaps we can also avoid the problem by using ">" in the decision
> condition like
> `inet_csk_reqsk_queue_len(sk) > READ_ONCE(sk->sk_max_ack_backlog)`.

According to the experiment I conducted, I agree the above triggers
the drop in tcp_conn_request(). When that sysctl is set to zero, the
return value of tcp_syn_flood_action() is false, which leads to an
immediate drop.

Your changes in tcp_conn_request() can solve this issue, but you're
solving a not that valid issue which can be handled in a decent way as
below [1]. I can't see any good reason for passing zero as a backlog
value in listen() since the sk_max_ack_backlog would be zero for sure.

[1]
I would also suggest trying the following two steps first like other people=
 do:
1) pass a larger backlog number when calling listen().
2) adjust the sysctl net.core.somaxconn, say, a much larger one, like 40960

Thanks,
Jason

