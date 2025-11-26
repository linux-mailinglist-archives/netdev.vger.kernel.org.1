Return-Path: <netdev+bounces-241950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6500CC8AF62
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5680B343EF8
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E4F33D6EF;
	Wed, 26 Nov 2025 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="25/7WbJj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08D811CA0
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174422; cv=none; b=JB56XfHHtPNXbQYZjLg+8a/rn7tXdRpFNtjGXKYGtdDUciut5MR1BKQrXvXIluT427uGMDkzbnQ+1lIqJ609DdQ6UOSF42ZauN5gB3/1KWFKCz/NhCFI/x5lVxBRwq6d2gOol85SPzxUp2MT96C7ybyZ7mjeqw8ifXAt6newL/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174422; c=relaxed/simple;
	bh=FSCQnRadzyMAy0i8hqTI7dfBVtaUwg/D5IWZT0LL0sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKHO3+lQSyuLm+GLv1onwo/H1DtnFDuclkAspNbcZypeRtdqC69NiptI/mZe+N+njX1JD++Zk75EE+7Dek10kt8iT94ucvyq2Tr2v6zKZwAmrC8dk6BHGlA75AM65mX50n+zFuk+izfWZi5IHw2ElKxY/ts62ruNSYRIkQZHgwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=25/7WbJj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2984dfae0acso108018605ad.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 08:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1764174419; x=1764779219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EukrxXINznHTd3zx5CB98mHu0Pahi2LIFlxBVs+XON4=;
        b=25/7WbJjmK7MTP3r4gcEYSrozWU4G3CYInFxb9SnVWr35m6/knqHUYF6pBAaOJbL19
         1o32uQCYLwu7ivPIhMd2J1GLPnf8YROR5oM1FHrwMahKRT2cmKOkFZmLbzK0eiGHy6JY
         aBqenX+vnm6xgwenpD1sq0eMvSZo6xib02ZCjT2/hW4RnqIWmv1tKZ46y/x/jXzE/Gfb
         Pt/jvwyFihcasQc3JoFcuu6elEQmJCDtYhaL+XflnZMH4XgWb8qOuxHmCW1IooUK50PN
         gt3JSlxTiUSuiwqx21w+F4gGXECUghHlzz2S325sqWYEArBq6ZSNayBllXqzAfYWlm6v
         vqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764174419; x=1764779219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EukrxXINznHTd3zx5CB98mHu0Pahi2LIFlxBVs+XON4=;
        b=J8jF5hKQTvFdIbbGIeHJsHqVLyz6pzO34b4NkQJun8qzEL2F2bv+5VyTjJ6c7h1SeA
         o6/chHQ4m4PoNEli6ICK7jNqiNETZXFeyFP2+S2BRSyiNoFVrnJIaRlc4YhnWNHD4VMF
         5MW3sFjFAn4cygjhmMvNNu6phgZLUHbiYGuha3NWamFkvMxb1yH+zvrdcR+waS//DnkX
         UGF/6gORAHQbJ30lblhgOWgw9wbLZPcvS+3otc+QEy34602k9+u+uVwyDyxWPNklHp06
         CMr0PvvEQbi9383q3PkDRRCwvORRTEf7IpZPTjvxN7XS+JufBIMOizW/Q+qGMmwQA5Vg
         Ij7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUN3nzrzLhje8Ap0cF0q86j5rIBXOiGmp4hrO9PwSRiT4h0oPzLmQx0/FKZOOkHdlkE6ZZ2ZS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDO9VfQBH7ob939S8lOCL1BFTOVC0vCKTEhj0bOyh4n84AFp/Q
	URmfDIxJWq8k2UDARdd+XtbayP5ckFR+2TaWu2NT8sCIHG2K3wO4q+ifVfggaOOJ/PRKDEnMog1
	7xZmy8e0HKDVZxtecfKlXoX2T4YRKMhAGc47ZxIfd
X-Gm-Gg: ASbGncsDrJdyNDP4acSqmbtEz+Zs6MBlF9X3d0NGTHzqwW+BjrRV0WhFGaql98XGZgu
	WxnngsMFNEdj55UWFm0KC/4Ape+LtLtF8/7zyHa36MP4ePTJ6ri4krSy8LH3P1+adWmyelodqe/
	HH6iBj0bWOoyUb9eFhjoA/j0iY/rt/YfzjjSKaiePhpBj5ps7gi5jtbhMN/IGVM0jYj0JD6KK/M
	bfqhdno4SXU/9H3IhyS10WJHof0ZK5DtZK2lIHPsHGC3Cwhsarkynd1UMcTzPHLpuBfsf//8RHo
	7PQ=
X-Google-Smtp-Source: AGHT+IG2K/nlziINGgDfjVdzs8wLXg7gBLQvwSc1iScJttD2kJWSiMYK10+tkQicbY3WbJzUkTJ5uyJAllFrTbIfovE=
X-Received: by 2002:a17:902:fc84:b0:295:6513:2475 with SMTP id
 d9443c01a7336-29baafb7eaemr91502245ad.27.1764174418973; Wed, 26 Nov 2025
 08:26:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124200825.241037-1-jhs@mojatatu.com> <20251124145115.30c01882@kernel.org>
 <CAM0EoM=jDt_CeCop82aH=Fch+4M9QawX4aQdKdiUCsdFzuC2rQ@mail.gmail.com>
In-Reply-To: <CAM0EoM=jDt_CeCop82aH=Fch+4M9QawX4aQdKdiUCsdFzuC2rQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 26 Nov 2025 11:26:47 -0500
X-Gm-Features: AWmQ_bmiWzAyj2LhJs6J44P7ujY0Abx3quM2RpTsJsUYMrrABibgHpnxnAqqKI0
Message-ID: <CAM0EoM=Rci1sfLFzenP9KyGhWNuLsprRZu0jS5pg2Wh35--4wg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: act_mirred: Fix infinite loop
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org, 
	dcaratti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 11:20=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Mon, Nov 24, 2025 at 5:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 24 Nov 2025 15:08:24 -0500 Jamal Hadi Salim wrote:
> > > When doing multiport mirroring we dont detect infinite loops.
> > >
> > > Example (see the first accompanying tdc test):
> > > packet showing up on port0 ingress mirred redirect --> port1 egress
> > > packet showing up on port1 egress mirred redirect --> port0 ingress
> > >
> > > Example 2 (see the second accompanying tdc test)
> > > port0 egress --> port1 ingress --> port0 egress
> > >
> > > Fix this by remembering the source dev where mirred ran as opposed to
> > > destination/target dev
> > >
> > > Fixes: fe946a751d9b ("net/sched: act_mirred: add loop detection")
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >
> > Hm, this breaks net/fib_tests.sh:
> >
> > # 23.80 [+0.00] IPv4 rp_filter tests
> > # 25.63 [+1.84]     TEST: rp_filter passes local packets               =
                 [FAIL]
> > # 26.65 [+1.02]     TEST: rp_filter passes loopback packets            =
                 [FAIL]
> >
> > https://netdev-3.bots.linux.dev/vmksft-net/results/400301/10-fib-tests-=
sh/stdout
> >
> > Not making a statement on whether the fix itself is acceptable
> > but if it is we gotta fix that test too..
>
> Sigh. I will look into it later.
> Note: Fixing this (and the netem loop issue) would have been trivial
> if we had those two skb ttl fields that were taken away.
> The human hours spent trying to detect and prevent infinite loops!
>

Ok, I spent time on this and frankly cant find a way to fix the
infinite loop that avoids adding _a lot more_ complexity.
We need loop state to be associated with the skb. I will restore the
two skb bits and test. From inspection, i see one bit free but i may
be able to steal a bit from somewhere. I will post an RFC and at
minimal that will start a discussion and maybe someone will come up
with a better way of solving this.

Eric, there's another issue as well involving example
port0:egress->port0:egress  - I have a patch but will post it later
after some testing.

cheers,
jamal

