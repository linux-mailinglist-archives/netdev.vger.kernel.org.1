Return-Path: <netdev+bounces-148857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F9E9E347B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E66282FA2
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A601A1A3A95;
	Wed,  4 Dec 2024 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0JR8QhdL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1E319066D
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298501; cv=none; b=YWJo9kzP24DWssQ58lzT1jpUy51nLcxYJ9384LlpSQW1Bkh13/AgqMX+IJt8xp6olenDmeK5rUAXE9ZC918OZRTCWRfmR7DG6L38thZaMk7UXOlCVjlR4qbEQwyjQS0GZZaH+NqD52QT0VoTejF6kH9baQ6r3xY83BOFol8JyM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298501; c=relaxed/simple;
	bh=dCC4lB1YF7XwicHffKdhMDtE8E2lvydXB4VvzNPKShs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYzbn/DlPPAMcb7YB/0Mg3AdzMSvQlxaq3l1hyJ/HmMql0xJLcVZO+Btf5bFYRPhWea1Lzs9sOVu8BD4xlgAGivhw3jQOBoWtg+lo58qY8e74hhQZBp48LqRCMC6sYbfa7LMJby+sKRnFT0GcXqGqQxUBQkSSlTJnxoeJR6gfDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0JR8QhdL; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa503cced42so941407966b.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 23:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733298496; x=1733903296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDC0JfCTaWHQxPCjq/twJLGp/3pBkHXOb7oNgd1NSAo=;
        b=0JR8QhdLDHWwnF27Cnk9ZcqOOFSZW5KmCZDeihGaB46WrHl9BMKU61+fxC5pUOmcwz
         V+Z01P9j+esSAYaMtfjCSSkI8Bt5lEuB7L1NCHaywiAn6yjknGmrXj7cNMIupeC/unjv
         oQHnnXAmj8NAlq2BFS7YEu2p30XQ3sDdI9TKoV+SbF3fe311/ojhmnVKs0wKer9dQSis
         OoQk04NJ/OSKFYVrw0IWlyuyu1Fq5zhA9p0TITAZUxHB3BfKeFBCMaNdsoiaUmtFlvj2
         1qD9IFOTYMQ2zfLjatOgZ1OtckPTD3Nhz0eCtlicuJ0TInlY2DYRa+BFbR1sm/T9wdY+
         HL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733298496; x=1733903296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDC0JfCTaWHQxPCjq/twJLGp/3pBkHXOb7oNgd1NSAo=;
        b=YFfaGBn3uBRo3zUAVrs2EwtzPWnd97ABPXp0KgLdt9gQIWm5nXE/KvZWj+ozNOSvUq
         ccLDdUKVDDVfFO6bCmMtoO95hpxBlO+/Nik0Cs/dPfytXsDZFt0ieSjhupNTB3s/yjGu
         uiYAz2QDlCENMOdo4qH83EgRMU6LW7oC7m83bOeOdVegh/7/2rw75DWxdhN5AvHaZ86f
         +4uAnGCUft5mtmSR1MaaXv2yIuq+amfIVnbq+d72L7VbZXzkS4x8vpU5CPju7BBPgYdl
         Q8KBCfba5ODU5HrZwJ/gi1HKkbvjWpca9kTAqWUcmFFeF+ir994dnxhdwjIvc/d9W4Y1
         bjdA==
X-Forwarded-Encrypted: i=1; AJvYcCXAi2/iNNTfke8VNZnAPEVie3Hu9aAQZOLnO5/I8Yxeo/mSTqQ90dTDJRU6snXGOmr5TEZ7Z+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBGI8sELKhWEeCBawayuAEOlpLZGwl5pcFr5m680odrV1/Q7ou
	J39IqBMY1L7tOh394mmjA0wN2S45jqRWZPEU0TcRk14YJEyI6NNaT9s5Fj/aBVYPOAEUmhojmL6
	sGQGwNud60U5eYQ8d6aI10nXvvDgyhicISY+z
X-Gm-Gg: ASbGncuVb9ITQtDkbtHDhtSkVy/2orRBH5eIc6Bl8KGNeFY05FgswBgn20gvP9hjlbQ
	haKWu5zcLZW5K3aAzJrue1xqrhUps/6Dg
X-Google-Smtp-Source: AGHT+IGF1iuSQAGuz4ZP2EbRPgNVR9NlUxUP1pACmV/18hBYDPczlk4/HSJNuiQNCWyh+E82bRfPCw56MPU8Npl4KuI=
X-Received: by 2002:a17:906:1baa:b0:aa5:427e:6af4 with SMTP id
 a640c23a62f3a-aa5f7f0affamr405472766b.47.1733298496184; Tue, 03 Dec 2024
 23:48:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204030520.2084663-1-tavip@google.com> <20241204030520.2084663-2-tavip@google.com>
In-Reply-To: <20241204030520.2084663-2-tavip@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 08:48:05 +0100
Message-ID: <CANn89iJqs_C267y=2RQdWvdvoLdpoqaB7EjgnxPw3cn77gpG3w@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net_sched: sch_sfq: don't allow 1 packet limit
To: Octavian Purdila <tavip@google.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, netdev@vger.kernel.org, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 4:06=E2=80=AFAM Octavian Purdila <tavip@google.com> =
wrote:
>
> The current implementation does not work correctly with a limit of
> 1. iproute2 actually checks for this and this patch adds the check in
> kernel as well.
>
> This fixes the following syzkaller reported crash:
>

> The crash can be also be reproduced with the following (with a tc
> recompiled to allow for sfq limits of 1):
>
> tc qdisc add dev dummy0 handle 1: root tbf rate 1Kbit burst 100b lat 1s
> ../iproute2-6.9.0/tc/tc qdisc add dev dummy0 handle 2: parent 1:10 sfq li=
mit 1
> ifconfig dummy0 up
> ping -I dummy0 -f -c2 -W0.1 8.8.8.8
> sleep 1
>
> Scenario that triggers the crash:
>
> * the first packet is sent and queued in TBF and SFQ; qdisc qlen is 1
>
> * TBF dequeues: it peeks from SFQ which moves the packet to the
>   gso_skb list and keeps qdisc qlen set to 1. TBF is out of tokens so
>   it schedules itself for later.
>
> * the second packet is sent and TBF tries to queues it to SFQ. qdisc
>   qlen is now 2 and because the SFQ limit is 1 the packet is dropped
>   by SFQ. At this point qlen is 1, and all of the SFQ slots are empty,
>   however q->tail is not NULL.
>
> At this point, assuming no more packets are queued, when sch_dequeue
> runs again it will decrement the qlen for the current empty slot
> causing an underflow and the subsequent out of bounds access.
>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Octavian Purdila <tavip@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

