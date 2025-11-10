Return-Path: <netdev+bounces-237201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C887C4755E
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4D31884C3B
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 14:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2625E23BD1B;
	Mon, 10 Nov 2025 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVhVg1d/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Soy6QYUL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680DB23C4FF
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786181; cv=none; b=c3DTjp5UL7Lm7Hcs94/AzoFQDzqGaJXe5hz11cLyjrUyAd/F0/KxrpnXZSxsPNXvb1fL3+eEaNSS/N6ypJuI6GxViLkuFGnTPSNCoQs0crz5qTDYZDpGnSSgyU5IyAFNXLG3K6hP42+iKRHKaSpKxYjNXg7Uu/LKAwiO9XsOLsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786181; c=relaxed/simple;
	bh=WZaF9AyMRcLVxeVA2D/RT6fCDlCfnLckHbGYaPx4mIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SjsNo9q3zYlHobTJ/pBHTEE5l05lAb0PapT+9E0/pqLh1gf2PCI9D4r0X7aMvut9w7XpQWIo9bNaWMxGzkj+m3GiRQh5lEmKD/8l4KDi1DigsA14Un2dcpgonCcVZoal9xLwW0s/Ml2aN6i2O/l+UvmD1i7iElaiW/4Fo7XzS9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVhVg1d/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Soy6QYUL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762786178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZaF9AyMRcLVxeVA2D/RT6fCDlCfnLckHbGYaPx4mIs=;
	b=NVhVg1d/iFO59tNqSjsqf/ucjanWD2T/Ds9JJz767X3IttbZnb8Js8NK2DbjsaSsb+RCFc
	+FxtFhe+l+pv+PYKqGOcpUcSbMxoNNVd4Y0pp6TDmaS1aP+/TZvIpBs1JuvXgWkG5EBhJW
	3SuN54BQ+uMgH9WAg1/iUeTN1Qi5sgI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-dj16-QqUPUG1KTTqMVD8qw-1; Mon, 10 Nov 2025 09:49:35 -0500
X-MC-Unique: dj16-QqUPUG1KTTqMVD8qw-1
X-Mimecast-MFC-AGG-ID: dj16-QqUPUG1KTTqMVD8qw_1762786174
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b70be4f20e0so213652566b.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 06:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762786174; x=1763390974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZaF9AyMRcLVxeVA2D/RT6fCDlCfnLckHbGYaPx4mIs=;
        b=Soy6QYULy8A/CBEmOdw9XQ06OSYEgUQVCPLHLv6/FYPpkoKus84N13d/dzT1GqR5Kg
         MYX0tbbRMOW1L+eZdr+qF0WhzvvgByUYSd4SZnE4/4s3aKBw6mhLHgGGauRmfILNfwLa
         q4QT33OuG18uOQsVmuN5Pzat3jXwpzeoG6SDFTLVc5kuou24aENxZJMetRgGOgZ2rWI5
         A+0P8eTP7in/B/aw3p6SgeG6jkM2y4CTzgWaqzOoHkICUqC1IlcJ1q7LdziKubwmQs02
         Kbxs8RefiNmUf0Fy6SRE1iqv6dGDdRhXPcI8ICO1dBj5W5Oa8THz8LM4jADEDIrEde4I
         K7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786174; x=1763390974;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WZaF9AyMRcLVxeVA2D/RT6fCDlCfnLckHbGYaPx4mIs=;
        b=T+3DMqEJ/cJyBbFA61ieaIqNrNL9BjWe53fVj+zNni61c/s5YFsn4wksKdzwrWrMp2
         37l2Mk4uGQureZockqKiV0ir13s9pOFensrCotxH87ynrwm6v+/pvZ3jrOA+DMnXT2uf
         NsF5mjoFlC0oUOroBw1DV6NE8gjrDG/YAhs6eO/kGlOl4u/9/L2YibGBdXprUOodsyVc
         raFzJdcnbcUzclBgIcZPeWGhUKULUdTU+Jo3kxQ1O04gKjUrPtLbN42CfS1ygX6IUocq
         ZkLSLL1PRhtgAaqGcS0GYo37agbdpIhh0XQ2zYRgz7MKOkqokhBRpQioGMOAn0oiRRyN
         SvjA==
X-Forwarded-Encrypted: i=1; AJvYcCWkcf1Ktwj9+7hXtZtY1DRZeU71DBz/sEeFCRnMPp80D7WGs6Mz4JN28ySBmC8JJe+uX5aLPOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKOOdHlqQgnmbbpIHkLj/L7tx8VQ8g+B8WRPxCtVJ/mnyHOZMo
	WRw22EmvoWrZM67olHLaV4ecA4ufW52VlBvdq6IzgbCzE876ZuJElH0HKwrfb9pBVROhw+kucWS
	q9cah+EpEoUi82UiB2i4DUpkoiHaMpE2gXRxW8GSuCPJTeNhg+QTE+jtufg==
X-Gm-Gg: ASbGncvXO65frpLupgaMAhe1aPRYFwOv/Opn6xx+PJ8Mp4bmGLuf3ZYGzSykU5SLyST
	AsCz/CUXxrkoGAHGgp1+UKJ7d4xXwGVKwuFxA4xGEuBVEZDfQ44vfLCSUfvKFQHFIbNEdVNGEwo
	m5vknRQ4M764GvWfBTYry6OznbghC8tC5ud9Jw5j59x8YWkitLw6pofMqiFTuWmcm/VtlQt1NKR
	sRLRFpKEcenoIe3iPZvxsex7FTW8cz8k/c5VSD2YZ0Rmz8zG6JCp+rKWT1ZNyjS6kdTHFXeOWPB
	Qu04Zugw00A/3XAu6U7rQes01K/VCqPZRqywHQPMnq+6wmZhu6H2LExqaHGy2V+SbT+1XoF4hE3
	n+SksnMX7KQDrTxBZCYnwNt4=
X-Received: by 2002:a17:906:34c2:b0:b72:fd32:a463 with SMTP id a640c23a62f3a-b72fd32bb3dmr347481266b.23.1762786172064;
        Mon, 10 Nov 2025 06:49:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1/gqZIZKN8gRF6fgnGg0Q4SSIu1Uvf7eOpJYc3Lu5gTdkaxKk3RTLfQNcPZ2aW05rsvJNMw==
X-Received: by 2002:a17:906:34c2:b0:b72:fd32:a463 with SMTP id a640c23a62f3a-b72fd32bb3dmr347478266b.23.1762786171562;
        Mon, 10 Nov 2025 06:49:31 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf723172sm1092551466b.32.2025.11.10.06.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:49:30 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BD485329237; Mon, 10 Nov 2025 15:49:29 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Jonas =?utf-8?Q?K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, "David S .
 Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de
 Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Subject: Re: [PATCH v1 net-next 5/5] net: dev_queue_xmit() llist adoption
In-Reply-To: <CANn89iLWsYDErNJNVhTOk7PfmMjV53kLa720RYXOBCu3gjvS=w@mail.gmail.com>
References: <20251013145416.829707-1-edumazet@google.com>
 <20251013145416.829707-6-edumazet@google.com> <877bw1ooa7.fsf@toke.dk>
 <CANn89iJ70QW5v2NnnuH=td0NimgEaQgdxiof0_=yPS1AnZRggg@mail.gmail.com>
 <CANn89iKY7uMX41aLZA6cFXbjR49Z+WCSd7DgZDkTqXxfeqnXmg@mail.gmail.com>
 <CANn89iLQ3G6ffTN+=98+DDRhOzw8TNDqFd_YmYn168Qxyi4ucA@mail.gmail.com>
 <CANn89iLqUtGkgXj0BgrXJD8ckqrHkMriapKpwHNcMP06V_fAGQ@mail.gmail.com>
 <871pm7np2w.fsf@toke.dk>
 <ef601e55-16a0-4d3e-bd0d-536ed9dd29cd@tu-berlin.de>
 <CANn89iKDx52BnKZhw=hpCCG1dHtXOGx8pbynDoFRE0h_+a7JhQ@mail.gmail.com>
 <CANn89iKhPJZGWUBD0-szseVyU6-UpLWP11ZG0=bmqtpgVGpQaw@mail.gmail.com>
 <CANn89iL9XR=NA=_Bm-CkQh7KqOgC4f+pjCp+AiZ8B7zeiczcsA@mail.gmail.com>
 <87seemm8eb.fsf@toke.dk>
 <CANn89iLWsYDErNJNVhTOk7PfmMjV53kLa720RYXOBCu3gjvS=w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 10 Nov 2025 15:49:29 +0100
Message-ID: <87ms4ulz7q.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> On Mon, Nov 10, 2025 at 3:31=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> Eric Dumazet <edumazet@google.com> writes:
>>
>> > On Sun, Nov 9, 2025 at 12:18=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
>> >>
>> >
>> >> I think the issue is really about TCQ_F_ONETXQUEUE :
>> >
>> > dequeue_skb() can only dequeue 8 packets at a time, then has to
>> > release the qdisc spinlock.
>>
>> So after looking at this a bit more, I think I understand more or less
>> what's going on in the interaction between cake and your llist patch:
>>
>> Basically, the llist patch moves the bottleneck from qdisc enqueue to
>> qdisc dequeue (in this setup that we're testing where the actual link
>> speed is not itself a bottleneck). Before, enqueue contends with dequeue
>> on the qdisc lock, meaning dequeue has no trouble keeping up, and the
>> qdisc never fills up.
>>
>> With the llist patch, suddenly we're enqueueing a whole batch of packets
>> every time we take the lock, which means that dequeue can no longer keep
>> up, making it the bottleneck.
>>
>> The complete collapse in throughput comes from the way cake deals with
>> unresponsive flows once the qdisc fills up: the BLUE part of its AQM
>> will drive up its drop probability to 1, where it will stay until the
>> flow responds (which, in this case, it never does).
>>
>> Turning off the BLUE algorithm prevents the throughput collapse; there's
>> still a delta compared to a stock 6.17 kernel, which I think is because
>> cake is simply quite inefficient at dropping packets in an overload
>> situation. I'll experiment with a variant of the bulk dropping you
>> introduced to fq_codel and see if that helps. We should probably also
>> cap the drop probability of BLUE to something lower than 1.
>>
>> The patch you sent (below) does not in itself help anything, but
>> lowering the constant to to 8 instead of 256 does help. I'm not sure
>> we want something that low, though; probably better to fix the behaviour
>> of cake, no?
>
> Presumably codel has a similar issue ?

Not directly, because codel is sojourn time based. Which means it
triggers only when packets stay in the queue for an extended period of
time; so as long as there's some progress being made, codel will get out
of its drop state (or not get into it in the first place). Whereas BLUE
is based solely on the fact that the queue is overflowing, and it
doesn't back off until the queue is completely empty.

BLUE was added as a mechanism to aggressively punish unresponsive flows;
I guess it's succeeding in this case? :P

> We can add to dequeue() a mechanism to queue skbs that need to be dropped
> after the spinlock and running bit are released.
>
> We did something similar in 2016 for the enqueue part [1]
>
> In 2025 this might be a bit more challenging because of eBPF qdisc.
>
> Instead of adding a new parameter, perhaps add in 'struct Qdisc' a
> *tofree pointer.
>
> I can work on a patch today.

This sounds like an excellent idea in any case - thanks! :)

-Toke


