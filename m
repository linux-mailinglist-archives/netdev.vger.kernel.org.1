Return-Path: <netdev+bounces-233209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8035CC0E7EF
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A553F4630F9
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4081030C609;
	Mon, 27 Oct 2025 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fc6buVKA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7313C30C34A
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575508; cv=none; b=uxMVg43TZenU1d/yG+l5uQ7THOpZxeqij6MqJgYQpSwxvtK/Na9ACct21l2YyGAnGnqaLy1tY7lRHrxs/By4a5hYF3gMs0FFyAgUt9891pyG2HwWVngt41cm4/t5uqRM5fBZepdx8hVuJUM/bFLtCOLhHdPCweSVSFls0HLMK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575508; c=relaxed/simple;
	bh=QZcXiRDkn2CEe1SMwdiavm/3yNEraVw6q51WtyZeWZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VRT/qJj8xh7HnKXLurPQK2iJLr2BSX39ySdKW9X5vFrx346ZUufv8FRWr+6Ei1N8yGbW9LGRjHRl55pa4q0f9CpeZyvoql8lMxy6OkrpZORxAPMI4M3NODuTQX9QtnE9fATwaok6wISKGvUwJyBLb9GvpnTJvXZ9ctO3ZbYR1NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fc6buVKA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761575505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZcXiRDkn2CEe1SMwdiavm/3yNEraVw6q51WtyZeWZQ=;
	b=Fc6buVKAWYwMdo8ogfExP8O5WZ9kJrgy82/Pv8lf9xZlIpJz5bAN/sa+xfEVHBTwXK4FNw
	MC8rKheUsK7kG4O8hRDaS7WR0AWhgI7vEPlzJFJVBf0TD8cH/yxvgDy8DlQx8UDmyQTpKv
	Qf728AqlTjiGpPNzOdbjWkbLgsCuxtQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-hx8X-FvBOe2m_UpRHNVnDA-1; Mon, 27 Oct 2025 10:31:41 -0400
X-MC-Unique: hx8X-FvBOe2m_UpRHNVnDA-1
X-Mimecast-MFC-AGG-ID: hx8X-FvBOe2m_UpRHNVnDA_1761575500
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b6d58291413so543925166b.2
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 07:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761575500; x=1762180300;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZcXiRDkn2CEe1SMwdiavm/3yNEraVw6q51WtyZeWZQ=;
        b=RFQ5uQaNrhHo2NMdbC2W6vEoHhM1MXj3o7cSejGMrvvczi+1StMTGt9uU0lupTFGWE
         16nBUOWPl4OlNcJ2sQ3uaIKYpOf8qNDxXqKuEOs84BujUGeGEriCe6cnnha6fsOYLT0R
         sLhotSBQV0qsJPgLwFgAhzXsz227qjwIVYtJPvNXHX65yRnGLQPwjEci0yJmcdVRoxIm
         uEilMrspPG/kJboP/uFJPda+mvR9alvQWQawT+usXP+r6vd4R50a0l16fV9TJL8xwsmz
         nBY5Yeji6ZZYdvG/Xo5jsNyWjOrZkt6PPFo+TdBy37Z3SeNU2EHdRrMcSO+ZqY4cHY+U
         Xmvg==
X-Gm-Message-State: AOJu0YwovWpLFqSM6lA8sEeTGZrp5XyCD+5GqNSAFvU5LbU9HaQaKGiO
	qs3bSEfwg/vkgQlOh0GSFhLrVTwDuCFZHOp6zxD/bXOUJ3rDJnZ4uO0bckme8qavRICefG5mf7k
	s2tqxPnLDMpIVholfuZE3KrHxfmzQVcJvkdTu+xBIAIckPtJQ8KAyxdH/Jg==
X-Gm-Gg: ASbGncs5nV/+P1rCbpAOf6by08cXZFKkuhroe9E3qGX9N+85eMYiT4SIHHjDRmDrT4E
	LdC5jBogv4J7H1dUBwkX/kw3o4SzcJfpPiS4CS8/L02giDkIfvzPMgaeB2kjP3cli3XHVL8cdpL
	4TVtNWAdhuY+YawL69Rb3dqfF1A6Ymwaw5MrWXr+rah9UL1jR423whsz3NDt7huWXqPHMfFriap
	5S3Hoy6bvj5dpdJ5wmMH4eJNLhDa27bPhfYj/Re1JSJiMwCIeVIPCos2fCUXxEe5uiojY4/xutN
	QYLluF0JWvXvBI6QrQhU1TvqMBuN71pekFNDg36F9l/mLMgrylelQ381/1doGUxXqFZAnwXJlMu
	4+frGlnSW8Dhze+LxKIuzwCC1Ng==
X-Received: by 2002:a17:907:d1b:b0:b04:1249:2b24 with SMTP id a640c23a62f3a-b6dba56f908mr12496166b.37.1761575499793;
        Mon, 27 Oct 2025 07:31:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGeKsYcRiyTwP3GVGgGDXvdfH25i6VHJvBBM4RcMH9DWuG1+VcBzYhWvawsrB9fT9lMDQtdQ==
X-Received: by 2002:a17:907:d1b:b0:b04:1249:2b24 with SMTP id a640c23a62f3a-b6dba56f908mr12493766b.37.1761575499306;
        Mon, 27 Oct 2025 07:31:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d854430dbsm775630866b.63.2025.10.27.07.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:31:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A52272EAA5E; Mon, 27 Oct 2025 15:31:37 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com,
 aleksander.lobakin@intel.com, ilias.apalodimas@linaro.org,
 lorenzo@kernel.org, kuba@kernel.org, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>,
 syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v4 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
In-Reply-To: <20251027121318.2679226-2-maciej.fijalkowski@intel.com>
References: <20251027121318.2679226-1-maciej.fijalkowski@intel.com>
 <20251027121318.2679226-2-maciej.fijalkowski@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 27 Oct 2025 15:31:37 +0100
Message-ID: <87pla8e7qu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Currently, generic XDP hook uses xdp_rxq_info from netstack Rx queues
> which do not have its XDP memory model registered. There is a case when
> XDP program calls bpf_xdp_adjust_tail() BPF helper, which in turn
> releases underlying memory. This happens when it consumes enough amount
> of bytes and when XDP buffer has fragments. For this action the memory
> model knowledge passed to XDP program is crucial so that core can call
> suitable function for freeing/recycling the page.
>
> For netstack queues it defaults to MEM_TYPE_PAGE_SHARED (0) due to lack
> of mem model registration. The problem we're fixing here is when kernel
> copied the skb to new buffer backed by system's page_pool and XDP buffer
> is built around it. Then when bpf_xdp_adjust_tail() calls
> __xdp_return(), it acts incorrectly due to mem type not being set to
> MEM_TYPE_PAGE_POOL and causes a page leak.
>
> Pull out the existing code from bpf_prog_run_generic_xdp() that
> init/prepares xdp_buff onto new helper xdp_convert_skb_to_buff() and
> embed there rxq's mem_type initialization that is assigned to xdp_buff.
> Make it agnostic to current skb->data position.
>
> This problem was triggered by syzbot as well as AF_XDP test suite which
> is about to be integrated to BPF CI.
>
> Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.GAE@g=
oogle.com/
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in gene=
ric mode")
> Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Co-developed-by: Octavian Purdila <tavip@google.com>
> Signed-off-by: Octavian Purdila <tavip@google.com> # whole analysis, test=
ing, initiating a fix
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # commit=
 msg and proposed more robust fix


Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


