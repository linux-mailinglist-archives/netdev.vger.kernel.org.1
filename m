Return-Path: <netdev+bounces-119737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C632956C79
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EC52837E3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55DF16CD2B;
	Mon, 19 Aug 2024 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FplZeLKk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE615B54B
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724075696; cv=none; b=RBLaVXKjv7jPLoeUZyPcnVAjdF6nXmkwVA/a0i22tho+k/gyrvoy6Imksekkfl+EbtXdwq0dxF7emOQasU//bwVR8NHxLLddH5kcbOScuqyUAn1sUUu/vUxUt7bnNR0PdCusoz7C0Ao9kOO96aJd3loR5ytIRwT3Uvx+WCTPWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724075696; c=relaxed/simple;
	bh=/5m2wGscLtBKYMLTg6x5IJIwQOGmUJEXUzxI77/61O8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fRnmpxXMzrpmXYdLmZ74B0WJWCg/kTlLdvBvXDYgM+gsQPBjun8ovDUf9gXFWLeVAI6yYHWLBFE8ws5t7pAkV3nCNdGfdBqhoeTES1OXr84kw8IO9WBf7K7fM8fodGx1TuOnFRaUaCgkNZAg9MiDl/ZGHqCL4QzxGLCqjrndeXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FplZeLKk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a9a369055so423720066b.3
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 06:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1724075693; x=1724680493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1sQZq7h8JEhQCMUCc9igU9dyrgZmRltpw4GrN/sJe8=;
        b=FplZeLKkTPsISCrnJZJ4j+elL0TBNvZjEi8MDR3pOh7lrtD4oAlN/D3+a/s3vA3pIs
         Y5Bmv9MQRka8ZAzibo5+v1oIyQi0xo/X+m97RDK30QCz7fd8PJDmlCA9YqVvF2akfDd6
         Phc0DTIZnWiUhY1sLYrxbZ+1wJvenwwwqhBTcIKx+5WBnxeQ784cmQkGdWwCzy5R8434
         PncmLkgLb154Zn1bd3vwaWQCqmT+P77Zk8/k/F9JH15gM6NY3RRDes38cHLZZg7/7+wY
         ovx6UHBIjc+BmY7j6zM6om2jNUWGJZX/NM5wL4Z/CNKwDzvy5VmrOOxJcoWZoQV8+R8v
         pb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724075693; x=1724680493;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b1sQZq7h8JEhQCMUCc9igU9dyrgZmRltpw4GrN/sJe8=;
        b=lIceUyDvnFlOFEWDLdQzMq0AWOcpfZG4QLuv3SSxitSIBVhShNHfiS7/4I3ALtfCuz
         wx3BmCeGf3nDt+NIOlXIIiFNPRu1tDPBSzGCa/UR8nEOy/bHHPVah/e9pdG2OwVcyZvV
         80qO/oLy2RJcRw7QD4zMBML0AlSJncs3R0Levb4XixaSo0U0dP0mMY2k0ghOz4Wak+1E
         qIkpMJqq6dP4jN8GnLB+AChAOufLpOEVamPig9lp3ogHq+m8Ak1B+Tp861mYy+ZulsmY
         FqnwatnngUe+bHrpvrMyG4oQ3CAoHdWk3rI4D8gMAJcOugAwrb+77wqd9CR1+fEp9jn1
         XT2Q==
X-Gm-Message-State: AOJu0Ywotd+SAowEz+DZGQAn6ngNm8n15rzHCU3uZMR9z0NI+GgcZEsi
	qlPMIwdnnUyjHSd50m5lws6Ax4seTHmAhoqzxbTqfZobTVUmD0ZG7F57/SySnP2pMIv+wDrHkOg
	Q
X-Google-Smtp-Source: AGHT+IExekH6uadw+M4Bd61SA6D9LmMT2UgJm1o2n8vPpLc++Mje+fQ8tR+0+mzEKpzSUY/cH6f1tA==
X-Received: by 2002:a17:907:9491:b0:a7a:b620:aa2f with SMTP id a640c23a62f3a-a83a9fec190mr465036766b.15.1724075692666;
        Mon, 19 Aug 2024 06:54:52 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838eee8bsm642018066b.92.2024.08.19.06.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 06:54:52 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org,  Eric Dumazet <edumazet@google.com>,
  kernel-team@cloudflare.com
Subject: Re: [PATCH RFC net-next] tcp: Allow TIME-WAIT reuse after 1
 millisecond
In-Reply-To: <CAL+tcoD9BA_Y26dSz+rkvi2_ZEc6D29zVEBhSQ5++OtOqJ3Xvw@mail.gmail.com>
	(Jason Xing's message of "Mon, 19 Aug 2024 20:27:11 +0800")
References: <20240819-jakub-krn-909-poc-msec-tw-tstamp-v1-1-6567b5006fbe@cloudflare.com>
	<CAL+tcoD9BA_Y26dSz+rkvi2_ZEc6D29zVEBhSQ5++OtOqJ3Xvw@mail.gmail.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 19 Aug 2024 15:54:50 +0200
Message-ID: <87ed6kr51x.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Mon, Aug 19, 2024 at 08:27 PM +08, Jason Xing wrote:
> On Mon, Aug 19, 2024 at 7:31=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:

[...]

>> --- a/net/ipv4/tcp_ipv4.c
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -116,7 +116,7 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sk=
tw, void *twp)
>>         const struct inet_timewait_sock *tw =3D inet_twsk(sktw);
>>         const struct tcp_timewait_sock *tcptw =3D tcp_twsk(sktw);
>>         struct tcp_sock *tp =3D tcp_sk(sk);
>> -       int ts_recent_stamp;
>> +       u32 ts_recent_stamp;
>>
>>         if (reuse =3D=3D 2) {
>>                 /* Still does not detect *everything* that goes through
>> @@ -157,8 +157,7 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sk=
tw, void *twp)
>>          */
>>         ts_recent_stamp =3D READ_ONCE(tcptw->tw_ts_recent_stamp);
>>         if (ts_recent_stamp &&
>> -           (!twp || (reuse && time_after32(ktime_get_seconds(),
>> -                                           ts_recent_stamp)))) {
>> +           (!twp || (reuse && (u32)tcp_clock_ms() !=3D ts_recent_stamp)=
)) {
>
> At first glance, I wonder whether 1 ms is really too short, especially
> for most cases? If the rtt is 2-3 ms which is quite often seen in
> production, we may lose our opportunity to change the sub-state of
> timewait socket and finish the work that should be done as expected.

Good point about TW state management. Haven't thought of that.

> One second is safe for most cases, of course, since I obscurely
> remember I've read one paper (tuning the initial window to 10) saying
> in Google the cases exceeding 100ms rtt is rare but exists. So I still
> feel a fixed short value is not that appropriate...
>
> Like you said, how about converting the fixed value into a tunable one
> and keeping 1 second as the default value?

I'm also leaning toward a tunable. The adoption could then be based on
an opt-in model. We don't want to break any existing setups, naturally.

> After you submit the next version, I think I can try it and test it
> locally :) It's interesting!

Thanks for feedback,
(the other) Jakub

