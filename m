Return-Path: <netdev+bounces-150267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7A09E9B2D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF68162551
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 16:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D861369B4;
	Mon,  9 Dec 2024 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQM42HIS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312C2224D4;
	Mon,  9 Dec 2024 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760271; cv=none; b=eYrh5Si8RWFwxHDghFe17MmtLoPPcrwzh948CApIkNV+G81jEUO+PODdDJmJ/Ls33D/jNZ5e0F0LjZu/0TkPm2Cjx1DnqMquDu1rVofgWvoh38qm1p4DwTXxWu6JzyTgMRLUAYW7ULu61QTCpnw/46SWNAOANUsoS0UITmHZBY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760271; c=relaxed/simple;
	bh=HXMJxNxK1a6X0z285aZIc9o9KAuzSJKJ4Q4dpisi/Ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWWyjpRkwR+q0Lfs8g7kvXqd6IArqcenx0lFBlw+jmYpi8yYpt9gz0NBWPlHMQuwVLIqZodhk5EnaS9UIW/36lgRxwy51OE192s5XSDuzdIgPyGe22LSJSMG3Ygk7NcayW7vBLMCa/MK3S9OHFo0GeMUzw+oEZLtEn2Qj20/qvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQM42HIS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso2127596f8f.0;
        Mon, 09 Dec 2024 08:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733760268; x=1734365068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLxaRfd7eSIeEGyg5kxtHxj9382euiBv+DNQTz5cePY=;
        b=KQM42HISgFg2bicYxVpCGmdBn9iyv72/zyWpbuk8XoTt4SCB+DvY9+6TsPtU/u/UrM
         R0dE6DgTviwo7MzXP+KghAUYGId5vVDBQbLXEpUfwjBH4MqeFadiOM1jQZMAyfEvSRMm
         zZUv01ZSA1tJ+SiydrodBxvgnQJZuruOWQi3JBCNFXBXSgsn096eMCRywsxKYEzYDuXG
         P2jAmQdQCbJLAaUtMr0tenBf2JDiHGFtrqXLaZeUmuWfeIpw5vWfLvQsAkw01BBgdWnt
         NSscpSK8sl31gVUXySwtZK0GaMIilOq1q3TRI4vGSQWK8jMlovSAEq0zBhSNP4BMIe7d
         7Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733760268; x=1734365068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLxaRfd7eSIeEGyg5kxtHxj9382euiBv+DNQTz5cePY=;
        b=oj7woviYxoXuaGXsldVD4/bDItYFdFRw0sASoSGDsU/phiA7ceftbg3ZU0bTGkZ0Xl
         /z5jeGnUYSiM5fkmeAZdaTn8wi9d5/31boYG/szJh+7Hw3BDKYNdnkz3wQdWXFOASRkW
         LVpclaOrV+Hn5uysTJx82id/PyF9ETxb5tkBSmkBNQfGFjL+Usu+4EIk/DDJSC5y7FOk
         2g8yVCpJhvXzBFr6lWyZEtsxVJc6qX2ABpUuC7FJme4etg4O4grTyYbNJhjxtEibN8M4
         ZmEMU9d5xewfTDCw3TDTlqXg63yggMLG2GxIoFWLgTs7F5zvk7JQHtmCyTfRnl7KbUvV
         +ulA==
X-Forwarded-Encrypted: i=1; AJvYcCVskHgHi5/m2BwPaFZF89X+eUiJev2IpPUwgkZ5lvZTAYT4Et9y3y5jQe0pqQS7IF6xCeG+K3tlRuezvak=@vger.kernel.org, AJvYcCWIQS86Lutx70lKwxSsnNHVBiATQ5SM2X9s7REmHg2b61dSO5q6HaQ0efeF8N6a4uTK7sHQsE72@vger.kernel.org
X-Gm-Message-State: AOJu0YzM47sG6mviyRG77SNy1vf4wMoqtprxBZpE7HHosEyFVdNAcrMh
	spkmM80wEV6+FBVuf2lRqImqwunuTd77XddCcVMHM02Y5K2rdVReGGMGOp8SSsRz+WB+CV6Cie+
	KAwqOmX0HDaW+nrGnwc0HDejl1TU=
X-Gm-Gg: ASbGncteKOKUB2Ns+JEj5UyTJ11xSsjCb9TK56iszXqiOVOzXEwdEzuQysU0rxs5X0j
	5VJ042sifVTctf5O5Gm/dMmbX38OM5RawzNRnv1DwvgGtKtICX7ZAwTiTBddPl3d3
X-Google-Smtp-Source: AGHT+IE/foTR9XbHPA/D4dvTG6jAXDW+4BspSWdackj4H16YrQChx4tRmqYqiXd2i+id0opxw63az3rqj+njLLJ8+1E=
X-Received: by 2002:a05:6000:2aa:b0:386:1cd3:8a09 with SMTP id
 ffacd0b85a97d-386453c5f5dmr881732f8f.1.1733760268007; Mon, 09 Dec 2024
 08:04:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206122533.3589947-1-linyunsheng@huawei.com>
 <CAKgT0UeXcsB-HOyeA7kYKHmEUM+d_mbTQJRhXfaiFBg_HcWV0w@mail.gmail.com> <3de1b8a3-ae4f-492f-969d-bc6f2c145d09@huawei.com>
In-Reply-To: <3de1b8a3-ae4f-492f-969d-bc6f2c145d09@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 9 Dec 2024 08:03:51 -0800
Message-ID: <CAKgT0Uc5A_mtN_qxR6w5zqDbx87SUdCTFOBxVWCarnryRvhqHA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/10] Replace page_frag with page_frag_cache (Part-2)
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 3:42=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/12/9 5:34, Alexander Duyck wrote:
>
> ...
>
> >>
> >> Performance validation for part2:
> >> 1. Using micro-benchmark ko added in patch 1 to test aligned and
> >>    non-aligned API performance impact for the existing users, there
> >>    seems to be about 20% performance degradation for refactoring
> >>    page_frag to support the new API, which seems to nullify most of
> >>    the performance gain in [3] of part1.
> >
> > So if I am understanding correctly then this is showing a 20%
> > performance degradation with this patchset. I would argue that it is
> > significant enough that it would be a blocking factor for this patch
> > set. I would suggest bisecting the patch set to identify where the
> > performance degradation has been added and see what we can do to
> > resolve it, and if nothing else document it in that patch so we can
> > identify the root cause for the slowdown.
>
> The only patch in this patchset affecting the performance of existing API
> seems to be patch 1, only including patch 1 does show ~20% performance
> degradation as including the whole patchset does:
> mm: page_frag: some minor refactoring before adding new API
>
> And the cause seems to be about the binary increasing as below, as the
> performance degradation didn't seems to change much when I tried inlining
> the __page_frag_cache_commit_noref() by moving it to the header file:
>
> ./scripts/bloat-o-meter vmlinux_orig vmlinux
> add/remove: 3/2 grow/shrink: 5/0 up/down: 920/-500 (420)
> Function                                     old     new   delta
> __page_frag_cache_prepare                      -     500    +500
> __napi_alloc_frag_align                       68     180    +112
> __netdev_alloc_skb                           488     596    +108
> napi_alloc_skb                               556     624     +68
> __netdev_alloc_frag_align                    196     252     +56
> svc_tcp_sendmsg                              340     376     +36
> __page_frag_cache_commit_noref                 -      32     +32
> e843419@09a6_0000bd47_30                       -       8      +8
> e843419@0369_000044ee_684                      8       -      -8
> __page_frag_alloc_align                      492       -    -492
> Total: Before=3D34719207, After=3D34719627, chg +0.00%
>
> ./scripts/bloat-o-meter page_frag_test_orig.ko page_frag_test.ko
> add/remove: 0/0 grow/shrink: 2/0 up/down: 78/0 (78)
> Function                                     old     new   delta
> page_frag_push_thread                        508     580     +72
> __UNIQUE_ID_vermagic367                       67      73      +6
> Total: Before=3D4582, After=3D4660, chg +1.70%

Other than code size have you tried using perf to profile the
benchmark before and after. I suspect that would be telling about
which code changes are the most likely to be causing the issues.
Overall I don't think the size has increased all that much. I suspect
most of this is the fact that you are inlining more of the
functionality.

> Patch 1 is about refactoring common codes from __page_frag_alloc_va_align=
()
> to __page_frag_cache_prepare() and __page_frag_cache_commit(), so that th=
e
> new API can make use of them as much as possible.
>
> Any better idea to reuse common codes as much as possible while avoiding
> the performance degradation as much as possible?
>
> >
> >> 2. Use the below netcat test case, there seems to be some minor
> >>    performance gain for replacing 'page_frag' with 'page_frag_cache'
> >>    using the new page_frag API after this patchset.
> >>    server: taskset -c 32 nc -l -k 1234 > /dev/null
> >>    client: perf stat -r 200 -- taskset -c 0 head -c 20G /dev/zero | ta=
skset -c 1 nc 127.0.0.1 1234
> >
> > This test would barely touch the page pool. The fact is most of the
>
> I am guessing you meant page_frag here?
>
> > overhead for this would likely be things like TCP latency and data
> > copy much more than the page allocation. As such fluctuations here are
> > likely not related to your changes.
>
> But it does tell us something that the replacing does not seems to
> cause obvious regression, right?

Not really. The fragment allocator is such a small portion of this
test that we could probably double the cost for it and it would still
be negligible.

> I tried using a smaller MTU to amplify the impact of page allocation,
> it seemed to have a similar result.

Not surprising. However the network is likely only a small part of
this. I suspect if you ran a profile it would likely show the same.

