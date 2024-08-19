Return-Path: <netdev+bounces-119569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E08956430
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664842812F3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADD2156F41;
	Mon, 19 Aug 2024 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xFWklHQk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A58915699E
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051625; cv=none; b=HIPf4cvbHrARU12XsiXkCw2GBwwg5HLnAOM2sd69a1A49ySz3qMF9Gb4tYC23v4p0joCqsjYPCyRBcbQOTk5NIGD9sgXJufB9QB0DCYU1tQQFGgFXoyk+1x7ecXu2QKPKdu5ZnxS5x2ckxw2/JqAAmM7Ly3BVyf9mnWXL96tEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051625; c=relaxed/simple;
	bh=cLwbxRkJ+8dJkhrnF8y9I54oCup0wd8+kTk7wuDk/6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsQeH7nI60JKgq0NF9uk7TzIlwfFQoPkZ7rLpc3DBs1iHy2QU1VLJ+xPPiLwxdKbORAlfTT2YV/hQ9MIsG7LeGRXkfbDr1Wnxkl7uo6Mz6S+VljADV8xrB7yFOwtjrpKJIu+rYAqxXYL0wERfowR9lBY3nAbH5hDvV6VfbyQOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xFWklHQk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bed83489c3so2341340a12.3
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 00:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724051622; x=1724656422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyZeI1PmQ5XFAeRTl6ZL7Lix8GszT5OtnYqACX58x4w=;
        b=xFWklHQkct36FRghD98Z1PrRFRW8GVWcFHxxcROPYk53G9YPa81NAMqKLYNkanfrsO
         tAIklre1GtYZXwoeLPFUHvYtC+DM+o7WMzc8lQSgvWnINZiQVYEyqJSUWU37rNBPgAFO
         jvwE4q3aJ5EJKGlJsjlHeCxoFAbPT4ZmCWC6xkiXlV8Gn5vTvOnQxZrE/ej0pjPcCD7K
         OGalPpDdkfeY1Y0mHHw+hF4DKY2MvdfSn8Cp9SVGQBi7ODaK5hV7PZn6v1UyIe2XLCQa
         552WeXgUcrw49YImHfFW9mLRDGZzuZnADHxH0G+3/eti/Cvyt/qTsWh+sPHl1g1PZcaD
         w72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724051622; x=1724656422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyZeI1PmQ5XFAeRTl6ZL7Lix8GszT5OtnYqACX58x4w=;
        b=XHW7upa0PGE3o+cvoolK3GV3uV6+26K5qwguAUW26ZHchMi3/Abw9OAu/mepu41Se6
         Nrvuv4wE31A50lWPWEJ69XTPl1kdYiCivmJdPYQ6yWfb2saJaQ0dDmvJ7K12mIx/EC9Z
         S5V7r0fwgCD54mEl9tvlWGvOcBxFotQQnb0W1GJhzDjNIMq3nOwUuT2++pyEVvnoHFl7
         NUZKPXGd1qrEmRZ7lHEl3b8Vff6R3kn2jFVqA7WOmlmMYJdl/IbnWsNbYy1NBHpqhBy1
         zfjJ59SppUTF+dvDv1ijE60ENfq0JKKbwgo8DhLPbK8VBOCw4svPO1Yv9k1gfcAFnd2f
         arTA==
X-Forwarded-Encrypted: i=1; AJvYcCVoYzbMKMz6pa8digl0BUJXbjqpBrd6oPrXJ5QhyaXP9JM1n0POnaUYrlNdoQvk3WT00lKV46nFQUiU7OBQzmNfSNelzVr/
X-Gm-Message-State: AOJu0YxABcpFo0v4KFF4yX88TRmEEyDuVXPBUFhsr+So3NTHaHgyToTL
	2tYeJMUmeRYeZwZvpaCBIsOc+U6mSy64LS7zuw5z6nzX50QPZ1H2wn165UeiKEg94pmSpozeS7/
	EV2B5RL8o5GAIIctEYHpgDFCe6cbwzE09Bb9B
X-Google-Smtp-Source: AGHT+IG/hg3PrANuDcYlFWGiTHq4+oKP2rAMb3acvgYbnb3UmuUxj+D7gM5FcKy+GIdEowHmzjBtwD5KkTj30XM0zKE=
X-Received: by 2002:a05:6402:50d3:b0:5be:fe84:cc4a with SMTP id
 4fb4d7f45d1cf-5befe84ccffmr721748a12.38.1724051621348; Mon, 19 Aug 2024
 00:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKrymDQ48QK5Wu5n1NJK8TouqA0cmg1ZkiALCM+W8KHFxraWgg@mail.gmail.com>
In-Reply-To: <CAKrymDQ48QK5Wu5n1NJK8TouqA0cmg1ZkiALCM+W8KHFxraWgg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 09:13:28 +0200
Message-ID: <CANn89iKkeM7s-ZbPR+d7P8PNZn_x3n15-e0Mvto7z-+5CWJSGA@mail.gmail.com>
Subject: Re: general protection fault in qdisc_reset
To: =?UTF-8?B?6rmA66+87ISx?= <ii4gsp@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, kuba@kernel.org, jiri@resnulli.us, 
	linux-kernel@vger.kernel.org, davem@davemloft.net, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 9:11=E2=80=AFAM =EA=B9=80=EB=AF=BC=EC=84=B1 <ii4gsp=
@gmail.com> wrote:
>
> Hi,
>
> I have been fuzzing Linux 6.10.0-rc3 with Syzkaller and found.
>
> kernel config: https://github.com/ii4gsp/etc/blob/main/200767fee68b8d90c9=
cf284390e34fa9b17542c9/config_v6.10.0_rc3
> C repro: https://github.com/ii4gsp/etc/blob/main/200767fee68b8d90c9cf2843=
90e34fa9b17542c9/repro.cprog
> repro syscall steps:
> https://github.com/ii4gsp/etc/blob/main/200767fee68b8d90c9cf284390e34fa9b=
17542c9/repro.prog

Please do not fuzz old rc kernels, this will avoid finding issues that
were already fixed.

For instance, this problem has been fixed two months ago

commit bab4923132feb3e439ae45962979c5d9d5c7c1f1
Author: Yunseong Kim <yskelg@gmail.com>
Date:   Tue Jun 25 02:33:23 2024 +0900

    tracing/net_sched: NULL pointer dereference in perf_trace_qdisc_reset()

