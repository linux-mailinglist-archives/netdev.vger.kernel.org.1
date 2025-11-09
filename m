Return-Path: <netdev+bounces-237061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0007C4426A
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 17:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E7294E2032
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 16:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C0F301711;
	Sun,  9 Nov 2025 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEeYp6wv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dzraf+F8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDBF19D07E
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762705999; cv=none; b=eoIL5dE6km2I0OqZR/E/UVhs01kFArOCUJGY9CvRcCKMlhtmDim1MJkQDj2rI4Wti9Y3L4dzQG/8YCRlzk19x0kxGXQBvqJqyupsBzhHbsI/aZoQZCHv0wSfD+kZ4NCwDnLwMD6beHj7sD1Qf2h8q38hwDRjkXbnRVlzDDmCzxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762705999; c=relaxed/simple;
	bh=6mby0tTceTh73d0xV1r3g9zwwq7U21RB+2vHlHFCJf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RNnZTf1IHzlP2Yo3ogXeigQr391K/bg2k7XqC10iyXAMITQvTuBsLGljz6xUsEfHP1eElbICnAzYB1XA8K56tVee9/HL0IDbphWS0n8cyCoChn2ZGEB4tvdDl++ulpDdrUd35p5VqVmHFD2mJFLFikPxvglpZcRQlY/3x8uHIIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cEeYp6wv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dzraf+F8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762705996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwqb86zprFPoUkAqQwPbboUofDVFyVZsLxwd2Yk+C4Y=;
	b=cEeYp6wvIwSF2/NeCf9L43dch26576eQ1QqT3QXs5h78Lz5SJsLtW0JjVFSmCe7WWkOSZG
	2Dw4mVHmLbH5dQ7wjNyY7KheftAZhT28bJlrgq330Bk0Pmt5IcA7LwaBk2/2UKC8CpymB+
	YaWq1TNgpn7+D5aAwLJXl/0+W1Ug7ZI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-HNt0f8GENNKv89KOhLmpcg-1; Sun, 09 Nov 2025 11:33:15 -0500
X-MC-Unique: HNt0f8GENNKv89KOhLmpcg-1
X-Mimecast-MFC-AGG-ID: HNt0f8GENNKv89KOhLmpcg_1762705994
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b721aa1dac9so238217666b.0
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 08:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762705994; x=1763310794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwqb86zprFPoUkAqQwPbboUofDVFyVZsLxwd2Yk+C4Y=;
        b=Dzraf+F8MB8Tf5RgDthh5Ay+k/otXRgr24f5nu/uFk7jLwQoFCaEctbTp6/37WhufI
         HUFtnAVFgOMBeq40AVBsx7ycF1QOEXTE8vWo7WQ5ftEwaBpeVWUBQRAOOslqu2RYPZOf
         rr6iW8+7y+2TYBk6Jad48l0xNAzgB0zBM6qEOwEYPnN/sfYBieNi8U6DX2IW5pvHPO5L
         2tebvTOBIPlDe1cD9DS7xMd3rLMHSUpsGCMOutllRCXQu+VFUY3tEumhmu4AopxEKwMV
         B+11B3QmYuZypwpCQFxUFdjGjyUOSueMQLp4YcE1jFbq+WIG0kgOQXO7C7RLnq87w9tz
         udZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762705994; x=1763310794;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rwqb86zprFPoUkAqQwPbboUofDVFyVZsLxwd2Yk+C4Y=;
        b=vqzRCbU+wGq+aCmnIgjLBG+S13kHRanbkG5710kHEcXsRCBTc4MslEbpbiVAiW3h4w
         0pUHoGhrWlArMxYuQV3/k3RKy/K32itoh32HMCJLDIBjRArILGBHBl77jevgDgnvIWxn
         QEHxw/eviGACdYXnHGqE0KGY5fIATyvjX7NqHjnPXnD897+jVSidhyYIK87RhK6OjFS8
         Q4++q7lKTF+meYfE9gYvxlXXszAtNceIFQxv7wZ4qt+47hbvwrEtITaS1FdsuKqG9B8t
         jascAMxNneNf3QXtP5H4DlD1SCr0qsKRFq4ITBPfl59Tx8b1ELpyyrj5dysi0hR4pabb
         W5kw==
X-Forwarded-Encrypted: i=1; AJvYcCWb868uzeHb8uivAE+7S7sVeU5uEkfKpJUWV9V7Jjhrn08os68U2UVn0WukRbgIoBUNbzRK0r8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6yG2lJV5X+YuN4gKBcJqNaVuPq7/yb9ethtwtz11G0Ecd7MG/
	BD6VphDF3JJLkU7u/MhmblIM6RRuTQ0v8Pty7pW7T3cBnWXRtrhHSHRKpgdqf/eDg7y1Xx+iGxr
	OaV9TH2VIPVPrzoYF/xYNHthc7YOKKK0xSbZv1FqI1wllYexpwrTSeXXm4w==
X-Gm-Gg: ASbGncvEEA7n8GPTbfpNoan+Fi13bC1Bbcun3r975lUD9tgAb673oE3V+F/sDYGLOyk
	I3YxtNXZlocUMMn5V60um+SolsCE7hapq+pmxQDplKtLTo7BVIHyupoCe9wSX/odgyeU2302yYU
	Cyn5G9rejwg2MoiuL+ekUyoawyiZ9eQgXJxDnVKJemNXEDxXQ76ZBN87aPMlIk56DxpNdFUCUmG
	/U0sRgAvRa0Fl5OQEbgUBDhoGgYu/hivtGATHWQnWua1NZMYcGurx5tD+wNwvuaav+fAie6KyVg
	yCnVSOfiYesCcXVlnNrdXoqIv/tCI0+zo95iaY8AmFXVhpj/sP8nUe6dD88JXjsl4JIwk6uhJRk
	/9sIZBaMnTC0A65XHN5ZzP5j4vw==
X-Received: by 2002:a17:907:a893:b0:b6d:6650:c3cd with SMTP id a640c23a62f3a-b72d0ad7c60mr836357566b.21.1762705993672;
        Sun, 09 Nov 2025 08:33:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRjAmI7QUcosr5b14yCJeocyGVgfMoBMBfTqzTrJMRwxWc3o41zijk1puQcpOB6FoZK0yTEQ==
X-Received: by 2002:a17:907:a893:b0:b6d:6650:c3cd with SMTP id a640c23a62f3a-b72d0ad7c60mr836355266b.21.1762705993293;
        Sun, 09 Nov 2025 08:33:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbcea81sm831855666b.13.2025.11.09.08.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 08:33:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4BAE4328E09; Sun, 09 Nov 2025 17:33:11 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Kuniyuki
 Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v1 net-next 5/5] net: dev_queue_xmit() llist adoption
In-Reply-To: <CANn89iLqUtGkgXj0BgrXJD8ckqrHkMriapKpwHNcMP06V_fAGQ@mail.gmail.com>
References: <20251013145416.829707-1-edumazet@google.com>
 <20251013145416.829707-6-edumazet@google.com> <877bw1ooa7.fsf@toke.dk>
 <CANn89iJ70QW5v2NnnuH=td0NimgEaQgdxiof0_=yPS1AnZRggg@mail.gmail.com>
 <CANn89iKY7uMX41aLZA6cFXbjR49Z+WCSd7DgZDkTqXxfeqnXmg@mail.gmail.com>
 <CANn89iLQ3G6ffTN+=98+DDRhOzw8TNDqFd_YmYn168Qxyi4ucA@mail.gmail.com>
 <CANn89iLqUtGkgXj0BgrXJD8ckqrHkMriapKpwHNcMP06V_fAGQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sun, 09 Nov 2025 17:33:11 +0100
Message-ID: <871pm7np2w.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> On Sun, Nov 9, 2025 at 2:09=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>>
>>
>> This might be something related to XDP, because I ran the following
>> test (IDPF, 32 TX queues)
>>
>> tc qd replace dev eth1 root cake
>> ./super_netperf 16 -H tjbp27 -t UDP_STREAM -l 1000 -- -m 64 -Nn &
>>
>> Before my series : ~360 Kpps
>> After my series : ~550 Kpps
>
> Or ... being faster uncovered an old qdisc bug.
>
> I mentioned the 'requeues' because I have seen this counter lately,
> and was wondering if this could
> be a driver bug.
>
> It seems the bug is in generic qdisc code: try_bulk_dequeue_skb() is
> trusting BQL, but can not see the driver might block before BQL.
>
>  I am testing the following patch, it would be great if this solution
> works for you.

That does not seem to make any difference. I am not really seeing any
requeues either, just a whole bunch of drops:

qdisc cake 8001: dev ice0p1 root refcnt 37 bandwidth unlimited diffserv3 tr=
iple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead 0=
=20
 Sent 9633155852 bytes 13658545 pkt (dropped 36165260, overlimits 0 requeue=
s 42)=20

Tried with 16 netperf UDP_STREAMs instead of xdp-trafficgen, and with
that it's even worse (down to less than 100 PPS). A single netperf
instance gets me back to the ~600k PPS range, so definitely something to
do with contention.

The drops seem to come from mainly two places:

# dropwatch -l kas
Initializing kallsyms db
dropwatch> start
Enabling monitoring...
Kernel monitoring activated.
Issue Ctrl-C to stop monitoring
1 drops at __netif_receive_skb_core.constprop.0+160 (0xffffffff87272de0) [s=
oftware]
2132 drops at __dev_xmit_skb+3f5 (0xffffffff8726d475) [software]
1 drops at skb_queue_purge_reason+100 (0xffffffff8724e130) [software]
52901 drops at __dev_xmit_skb+3f5 (0xffffffff8726d475) [software]
153583 drops at __dev_xmit_skb+13c (0xffffffff8726d1bc) [software]
1 drops at __netif_receive_skb_core.constprop.0+160 (0xffffffff87272de0) [s=
oftware]
93968 drops at __dev_xmit_skb+3f5 (0xffffffff8726d475) [software]
212982 drops at __dev_xmit_skb+13c (0xffffffff8726d1bc) [software]
239359 drops at __dev_xmit_skb+13c (0xffffffff8726d1bc) [software]
108219 drops at __dev_xmit_skb+3f5 (0xffffffff8726d475) [software]
191163 drops at __dev_xmit_skb+13c (0xffffffff8726d1bc) [software]
93300 drops at __dev_xmit_skb+3f5 (0xffffffff8726d475) [software]
131201 drops at __dev_xmit_skb+13c (0xffffffff8726d1bc) [software]

+13c corresponds to the defer_count check in your patch:

			defer_count =3D atomic_long_inc_return(&q->defer_count);
			if (unlikely(defer_count > q->limit)) {
				kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);
				return NET_XMIT_DROP;
			}

and +3f5 is the to_free drop at the end of the function:

unlock:
	spin_unlock(root_lock);
	if (unlikely(to_free))
		kfree_skb_list_reason(to_free,
				      tcf_get_drop_reason(to_free));

Not sure why there's this difference between your setup or mine; some
.config or hardware difference related to the use of atomics? Any other
ideas?

-Toke


