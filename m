Return-Path: <netdev+bounces-230542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCE5BEAD76
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 18:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8FDA435F154
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADEE2E1EEC;
	Fri, 17 Oct 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtF4GmSK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E103F2DF6F7
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719534; cv=none; b=VADbcSOl7hx76ARDKk1stps5wlHNOORoCpf41cCcegmCUsb+CNFh2ztmLN/ZSRMB/i8OufBUSv7w3A5OwKot0xQinhR35KqbYlX9vbbdLJhhwS0dGuDTZMJK1UFSAbIAJnHmAuqDumTGT97rO/Ex+O7PDEBENx/zeifql23waIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719534; c=relaxed/simple;
	bh=AbqV4MOKnTV9h2J9aQMq2DtsM+47tbkdQ5UeEZ1ahRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QqE3mZUhXxHf8cB+YwU0TkBkrGx+giTpRrLajUqvHSRfVU87s3KSnPkUgbsikWNzUu/cQvYIya3fmYwVvAlHa0tpXAcM16mfIt8Ivlh51dPztU2slMuHPriURZZVuzpo+FeKHUdfWTAffaF3cRxcevU49RLna6MkFKsQcaW0O94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XtF4GmSK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760719532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AbqV4MOKnTV9h2J9aQMq2DtsM+47tbkdQ5UeEZ1ahRM=;
	b=XtF4GmSKzLOzqQcbz8dZGFfhfCNHKQXXtlJAam0Y7JyWEMZqYPBHwJBwsqHq64l9lQBr5H
	6h/su9Rw+VmMM/A5LnO0nPtCmygYEr4rUFXkvDwLKcmYGh9obVNyJMgO7uy982ez3wEqvJ
	m3YH2RSCP5LzkZDK19iQrmSZAI60Y7c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-CkWOzRNrN5mVqQYsFl5vWw-1; Fri, 17 Oct 2025 12:45:30 -0400
X-MC-Unique: CkWOzRNrN5mVqQYsFl5vWw-1
X-Mimecast-MFC-AGG-ID: CkWOzRNrN5mVqQYsFl5vWw_1760719529
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b548c516b79so272022966b.3
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 09:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719529; x=1761324329;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbqV4MOKnTV9h2J9aQMq2DtsM+47tbkdQ5UeEZ1ahRM=;
        b=CCAPDEgmGSeUqTcQX6WelzKYoiym0k3VV5qvb0nQX+YoTGANCiOAKqd4BAKR2FzvdQ
         GlygflzdbtTGWM4arv3bjLDs2tYTa3ibcrDNRmNbOmd6XAee3qSkyXbY8BiZeqefSVX3
         NqDo+5/zdQ16IlLinaGzDXWP/Et0YAwfPRvuj+HM8yhSARjWT5WW6c9GpMHjczMxpweM
         xvzamDsOtWNHyd8cn5f3MsKcCHf0m/UiDrm8pvFijhByc0TRxNIXmhpLrCScrfGxlQoP
         /RR+HXaoOhm1XnIoKYbC7qwbzAvBl9pYXDbgLQZOuxqRjBlC6+FmWt11ldTDtCN/HjVd
         zrIQ==
X-Gm-Message-State: AOJu0YxI4zI6JNDsM5xQ6emv1CiEzYlrz0UNYtn0lE+MfPA3aisn67rb
	DPq2HgA58dqTJOAEaCqbtUwl7nt52LzE87kjN/1D+/hl4h8bfFY084PIeWHG7OyDRFvEAYlGeIg
	TxTncuayc9V9DHV4nmSlMG5MGUTxbY4MghktBjyyAy93EzH88tRyY7hEErg==
X-Gm-Gg: ASbGnctGhQ54kO/TCYz0ogKihI3KLaC+hTYWjEZChdiynoYlBGk8dn6JV7vl/K5J97a
	luT6Xwblu+Q2Pqm4tzQzJ+NT6ipZPPCFtRvnsKQaAWgLffAF7bsblVNFxXXSJIdYEb8Q8SGk34t
	c/jmGcIPAwdJ7PLaLNeJ6DYwPjZ9EGQWtlcxydwIh0obUfmWopsASCj+SeVAktu35YOdagdPejT
	ogzQhTYDPScT3be2W2UJCaurxruxGTV9y4Elv8jwYzIy9zpLq/VAxdsCtu3ko8gckXtG2AAvErB
	dozZCq97MPZP+vT4V5y7uwiX7cYTgiSNh69CbHjCNI9KfYKeFDAmjb0zZIVUCE8GoxNcgWcyqLj
	IqQggfx/+dKA/KT8a0yi3T0Y=
X-Received: by 2002:a17:907:7e99:b0:b3c:a161:683b with SMTP id a640c23a62f3a-b647570ad28mr460572666b.60.1760719529090;
        Fri, 17 Oct 2025 09:45:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpSLAaT/919pl3FWbNozPx+BdCBNSjS+97fA0qey9ry3dwzkhQOHKnWfeAeDRBMUwtGkbT6A==
X-Received: by 2002:a17:907:7e99:b0:b3c:a161:683b with SMTP id a640c23a62f3a-b647570ad28mr460568766b.60.1760719528567;
        Fri, 17 Oct 2025 09:45:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c49430272sm124745a12.23.2025.10.17.09.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:45:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 32BEF2E9D23; Fri, 17 Oct 2025 18:45:27 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 ilias.apalodimas@linaro.org, lorenzo@kernel.org, kuba@kernel.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, andrii@kernel.org,
 stfomichev@gmail.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>,
 syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v2 bpf 1/2] xdp: update xdp_rxq_info's mem type in XDP
 generic hook
In-Reply-To: <20251017143103.2620164-2-maciej.fijalkowski@intel.com>
References: <20251017143103.2620164-1-maciej.fijalkowski@intel.com>
 <20251017143103.2620164-2-maciej.fijalkowski@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Oct 2025 18:45:27 +0200
Message-ID: <875xcdiijc.fsf@toke.dk>
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


