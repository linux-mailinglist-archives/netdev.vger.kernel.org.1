Return-Path: <netdev+bounces-120180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB60958811
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93912824E3
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EEA18FDD0;
	Tue, 20 Aug 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WjV+UP6D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C642418A6D1
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161022; cv=none; b=PMyWAoIJKevIeAqupLFlIf3qRYfF96kegi1WMPvNN1U9O0MoqP2sxW1/4wAbi279JrAfhyeC9VzKP7E3eki1sUnRwE9gLqdMOr01moa4oOIyv35Pisn5auehmY74l7MYqmOsD3jQuhiKV+IOOi2WJxP3dy6ppO8I7v/i45VaAiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161022; c=relaxed/simple;
	bh=JwfZ3dO5//EIH0Z7LPjYPuhrt7OHpRqI/6XxsjYKDt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnnS30b7CDuLgoQQ0EFFYw/nkwJDoYRyENeB7fcrJXr+SPJDnXsO8WX619iDFih4iC1K5h4llxOed5dzDqOkDGgrGCPI15YGp8JyfNFHjzsWbIsN+bUrhlCv4TUuorDItlhJb6EE1GvhIBlYqulGF3B7cz8oUVCS+23KwSJKaJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WjV+UP6D; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a86412d696cso143182166b.2
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724161019; x=1724765819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RlVnc0o1/OnWyz4BKHc28R1UWiq/NHOMsWRG8ChrMA=;
        b=WjV+UP6DUt13cI7a5/8hPV4OQKnGO+x35e7/cxDiUY8OJWkRnk8wwiyuVpIcZoscX3
         35nFlp0OzH0SIzzZScwjKVoSUNe+CzueiLs3+Upj3rYGnj2aztpYlIFhArrVgXSKocc9
         txKt6WoeOEopQoHe/6oFDhJ29BKLQkVl0UWeeLfSIQ8SFLcirEtW7J/iU4oQvrPZOOvd
         JQ4usOWh0p6u+3xKIImZ/x9TWpJ+z8gFCAI0djDuPcm1ijUAbgx989p0YAMKVCCBhLwb
         rvvJHNDDjZ1OCcrl9XKvmjflt9vdKfErz9vINLuamS01GUKuU7zcrEFwB9n4zXdFCoXA
         1oug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724161019; x=1724765819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RlVnc0o1/OnWyz4BKHc28R1UWiq/NHOMsWRG8ChrMA=;
        b=Bfbn8qAIMlRyPCAALCXQDBm/3Kv0XB3BXo9hOfAk0flnKTZTMQWej2UUqoVmGKRkXs
         bKvtjjHvP41Gm8B8z9WEF57fusrQ0stCYlmeVeLVIvxnvBEC6096y8FrCPpD5a1+dtjg
         njku2HSy8UwRSterdqg4KuJZDjy2ly3M2ksYzb1uEge3gt+R5dnMitkx1Q1nWFONy4zB
         0gtXgxvr+AQli4+7NEpW9QM1PujzGIxO8nc/TJxtN/nl1AngYAKmAN7XrH9yR9K0YBs5
         zRJK6zfE1IAeSuPBeJwG1Ic2jQcKeDCIW5mfPqQrQubA3pLTfhYrjyWV1Su83CKJa/mK
         HGuA==
X-Forwarded-Encrypted: i=1; AJvYcCUtOZZo5t+0DRat+eHnqDUrDS3EDqIRDhW1RABEqcVCN/Tn7ddhbmWplfCoDX67t4jtTBrdgI7oQt0b1OkUUXn2L82o7NCR
X-Gm-Message-State: AOJu0YwjU7lNFLQMo0Bkbqg8acbB2nauIGvIURUxx8Q+sz1D7TuB+rga
	3xloa4Oi2ygJYc/DmZ0L1kLnnEUbQuY/FOrmhvYd8Ocmctzh1W5QgnPxn4QsTnX8GwEu0jEn6BM
	Ho+3guqtUJvhY6mz1jaPw31rJ/YfmgrnfIOtC
X-Google-Smtp-Source: AGHT+IH/rJZy6k+rb2FhCa1jLDG0uwBUrZTrzBgSBlVT9TK80NHJMNT5UflArk1pRWJ7IiGv4Bw4+ODzBg5cAQQEqMY=
X-Received: by 2002:a17:907:d85d:b0:a77:dd1c:6274 with SMTP id
 a640c23a62f3a-a8392a497e0mr975786566b.69.1724161018386; Tue, 20 Aug 2024
 06:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820034920.77419-1-takamitz@amazon.co.jp> <20240820034920.77419-3-takamitz@amazon.co.jp>
In-Reply-To: <20240820034920.77419-3-takamitz@amazon.co.jp>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Aug 2024 15:36:47 +0200
Message-ID: <CANn89i+cLhi8t04=+3LYh_8qDQA3fYZmKyGBuqitX+==KOvLLQ@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/2] tcp: Don't recv() OOB twice.
To: Takamitsu Iwai <takamitz@amazon.co.jp>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 5:51=E2=80=AFAM Takamitsu Iwai <takamitz@amazon.co.=
jp> wrote:
>
> commit 36893ef0b661 ("af_unix: Don't stop recv() at consumed ex-OOB
> skb.") finds a bug that TCP reads OOB which has been already recv()ed.
>
> This bug is caused because current TCP code does not have a process to
> check and skip consumed OOB data. So OOB exists until it is recv()ed
> even if it is already consumed through recv() with MSG_OOB option.
>
> We add code to check and skip consumed OOB when reading skbs.
>
> In this patch, we introduce urg_skb in tcp_sock to keep track of skbs
> containing consumed OOB. We make tcp_try_coalesce() avoid coalescing skb =
to
> urg_skb to locate OOB data at the last byte of urg_skb.
>
> I tried not to modify tcp_try_coalesce() by decrementing end_seq when
> OOB data is recv()ed. But this hack does not work when OOB data is at
> the middle of skb by coalescing OOB and normal skbs. Also, when the
> next OOB data comes in, we=E2=80=99ll lose the seq# of the consumed OOB t=
o
> skip during the normal recv().
>
> Consequently, the code to prevent coalescing is now located within
> tcp_try_coalesce().
>
> This patch enables TCP to pass msg_oob selftests when removing
> tcp_incompliant braces in inline_oob_ahead_break and
> ex_oob_ahead_break tests.
>
>  #  RUN           msg_oob.no_peek.ex_oob_ahead_break ...
>  #            OK  msg_oob.no_peek.ex_oob_ahead_break
>  ok 11 msg_oob.no_peek.ex_oob_ahead_break
>  #  RUN           msg_oob.no_peek.inline_oob_ahead_break ...
>  #            OK  msg_oob.no_peek.inline_oob_ahead_break
>  ok 15 msg_oob.no_peek.inline_oob_ahead_break
>
> We will rewrite existing other code to use urg_skb and remove urg_data
> and urg_seq, which have the same functionality as urg_skb
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Takamitsu Iwai <takamitz@amazon.co.jp>
> ---
>  include/linux/tcp.h                           |  1 +
>  include/net/tcp.h                             |  3 ++-
>  net/ipv4/tcp.c                                | 15 ++++++++++-----
>  net/ipv4/tcp_input.c                          |  5 +++++
>  tools/testing/selftests/net/af_unix/msg_oob.c | 10 ++--------
>  5 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 6a5e08b937b3..63234e8680e3 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -243,6 +243,7 @@ struct tcp_sock {
>         struct  minmax rtt_min;
>         /* OOO segments go in this rbtree. Socket lock must be held. */
>         struct rb_root  out_of_order_queue;
> +       struct sk_buff *urg_skb;
>         u32     snd_ssthresh;   /* Slow start size threshold            *=
/
>         u8      recvmsg_inq : 1;/* Indicate # of bytes in queue upon recv=
msg */
>         __cacheline_group_end(tcp_sock_read_rx);

NACK, sorry, we will not change URG behavior, add yet another
dangerous dangling pointer.

We should not give users the impression this is maintained, useful,
and works as intended on various OS/kernels.

