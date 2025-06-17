Return-Path: <netdev+bounces-198698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA1AADD10E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576C81644C5
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7A62E8894;
	Tue, 17 Jun 2025 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmUTNzQA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810071CDA2E
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750173018; cv=none; b=XWcoHfRqG9WiFRqtYJnq6+f0AcRPnWWyfhQOdEblPUxLeSAM8Vo3DTA363j4xidT/q9L5oonRzM5qqexIRJJD4D3+plz4c6A+rQ7qhcR+O8I9Re7Rr5EX8rnBHw7IlAmY79dNsung+HZPcIjpkTDNDqmFss4ZQ1KnlVkzIAYi2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750173018; c=relaxed/simple;
	bh=Q4vV3HbVxFLXV1EBL2EoQ/+XT0Mzn4sSeRk874/9McE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FSX2rJcNtoQC+FIkZ+eCrQKgl94h0/x8ZJhCGUxfqDhoOQYCsOovKKYTKh9PAa66MRw2eVoDJd5Xp8NmsmLijpsBNWvV+47Rn6jh1TWVs/BpIZBa6rMsbXG75ABnWf3Pp74O9XRLMJfEYbCJbV88Ff5k9lLKk0Q1J7uwjm403+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmUTNzQA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750173015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4vV3HbVxFLXV1EBL2EoQ/+XT0Mzn4sSeRk874/9McE=;
	b=KmUTNzQAGMXb69iSC4ozxvo383jJAmOxrD8p5Y44MR/j4C+/NDP4cEbQWlWxBkptdGKXdf
	rfilfoJlyTBtmEFhSFGeVUQTqOSKXfybKt0ICtxsGKcFQzYv8DMMum+kkm6uqxi8I7GxvJ
	IwYS3Nrcvj4ZfF0gDnU7spJN7JVxM5o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-EJ4Lp_Y7PqiX6HeYVSo2Vw-1; Tue, 17 Jun 2025 11:10:13 -0400
X-MC-Unique: EJ4Lp_Y7PqiX6HeYVSo2Vw-1
X-Mimecast-MFC-AGG-ID: EJ4Lp_Y7PqiX6HeYVSo2Vw_1750173008
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ade32b5771bso73109966b.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 08:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750173008; x=1750777808;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4vV3HbVxFLXV1EBL2EoQ/+XT0Mzn4sSeRk874/9McE=;
        b=MHzRylnyjLTjFbE5+VCa5eVvXLtSK7a4Jbcopiy0sDm7w7BKkyW7gOFNVf6c+jw5FP
         HsXEU6G5PbHCQyuQgGAhEoWq9aP9/JyHq/coDxKB0YIr3Pn6Cr1Zwkkeg5kuSg7afBMz
         zCTQ1ESOb7If3mLQnrhWmzsns2pU0J58qHSYIvJ5UF98IjYuMuRBGUzJ8qJ+aDCqET0D
         QlO66hTH5LQcEMGUZAifHvdcC++HfRpA0P7MS3DAONA+xjpSRrcvG9FSIUETUwPS4htJ
         TBYm26sNABD5KCeGZDk3SxJCWLnaLkTea1lidv61NA8lGKD4xYb+oQxroz9IGESr819s
         kdjw==
X-Forwarded-Encrypted: i=1; AJvYcCXFvJnmDTthyAOGr2s8KOjHb3HruFJaLro8EReKOHZffHU3z0fh1N59+hOQY4d0mFUOq9Nvm8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9YQWiOy725/FIJ269757XB/fvW2iVLBsAgCthXxq60npywrGt
	ORcWN0nWqk160sNOiio3adYCX2L0k+c7s/ROuQKQBM7eQYHaR/Q0uHtIRrAMM5hkFCZVaFUEsQt
	J51UhpMBkF0okfQv4KAIakHrmhlMzz2BtDkwpClq0fbPTN4BVPlTi7VmXcg==
X-Gm-Gg: ASbGncsffM84TFVYa8IXUvHjNLpqcWKtJlepmLHQ9fHjK2SoxzD7Uhea9B187F0ZIs1
	NHPLpuQ50k1zi6R1CD1VMEIqc4UZBy0Le3i4lnkFlemzgFq254qDc2Vq9FjIWBjfYVc1SJpy4Mu
	gBS/KgOB8mefac5ZU8kygEIlaA1pDPNe+/SC1Bp9adu5mIHe3suHXMekH3INqQ9pbLbYTpGVCea
	Q/S8cNmDuJoW1iMpSXr/H81Kl5KzRpM9zt1L0PAOiEXjW6I415vNtSxPcjsaLIdKQ/gH+fyVUqn
	XXeXKTGxkuHtfBLFAtg=
X-Received: by 2002:a17:907:2da9:b0:ad9:16c8:9ff4 with SMTP id a640c23a62f3a-adfad2773b1mr1287012066b.11.1750173007733;
        Tue, 17 Jun 2025 08:10:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHum6NSFVGaMZlyajlBzCyusq5rsMbr/f1X+qSV8BcuCBxgvXcCVTF1LKybETNjy2yXeASF3A==
X-Received: by 2002:a17:907:2da9:b0:ad9:16c8:9ff4 with SMTP id a640c23a62f3a-adfad2773b1mr1287007966b.11.1750173007348;
        Tue, 17 Jun 2025 08:10:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88fe907sm888000966b.93.2025.06.17.08.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 08:10:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 717EE1AF7182; Tue, 17 Jun 2025 17:10:05 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
 kernel-team@cloudflare.com, arthur@arthurfabre.com, jakub@cloudflare.com,
 Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Performance impact of disabling VLAN offload [was: Re: [PATCH
 bpf-next V1 7/7] net: xdp: update documentation for xdp-rx-metadata.rst]
In-Reply-To: <76a5330e-dc52-41ea-89c2-ddcde4b414bd@kernel.org>
References: <174897271826.1677018.9096866882347745168.stgit@firesoul>
 <174897279518.1677018.5982630277641723936.stgit@firesoul>
 <aEJWTPdaVmlIYyKC@mini-arch>
 <bf7209aa-8775-448d-a12e-3a30451dad22@iogearbox.net>
 <87plfbcq4m.fsf@toke.dk> <aEixEV-nZxb1yjyk@lore-rh-laptop>
 <aEj6nqH85uBe2IlW@mini-arch> <aFAQJKQ5wM-htTWN@lore-desk>
 <aFA8BzkbzHDQgDVD@mini-arch> <aFBI6msJQn4-LZsH@lore-desk>
 <87h60e4meo.fsf@toke.dk> <76a5330e-dc52-41ea-89c2-ddcde4b414bd@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 17 Jun 2025 17:10:05 +0200
Message-ID: <875xgu4d6a.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> Later we will look at using the vlan tag. Today we have disabled HW
> vlan-offloading, because XDP originally didn't support accessing HW vlan
> tags.

Side note (with changed subject to disambiguate): Do you have any data
on the performance impact of disabling VLAN offload that you can share?
I've been sort of wondering whether saving those couple of bytes has any
measurable impact on real workloads (where you end up looking at the
headers anyway, so saving the cache miss doesn't matter so much)?

-Toke


