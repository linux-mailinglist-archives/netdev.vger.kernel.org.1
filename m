Return-Path: <netdev+bounces-120681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7694F95A32A
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 18:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AAF11F24DD8
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97D719995D;
	Wed, 21 Aug 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HF54EQzJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D3139597
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259019; cv=none; b=KxC0IoYNUiO5WIcyIEqcwJT5pogyPB9+DisSDQR6FIPS4PEPr6L4tldt8jKjHIHL5DSEg8LkHqAq1alqCm2vcqg1mu66CK6z0ZrklD8uORxTPHuHV6HP985FtRkwbF84hj2LafC051UlSSy1ZdsKjC+Bjwhxjw8KnpFKCNap0dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259019; c=relaxed/simple;
	bh=0kVY1oV287jCseyCWC/1hEdI8AU8MwdYoInIdn6qdok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCQ/2wXSh1TjKNVMMT1F498cYujQ6Lnz0ibrH8n1a/tl2/8H607IyncDgeWqosetxA+zYBantHqAbPlI17MYriB6ZiuoWGfvWVaYXkcvNQAyyz0GmPQ07CpkgjcxZ3EO3iUttdT9UkI0soPDDBF7X0v3ZcWftZoBEJnSO1nf2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HF54EQzJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724259017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0kVY1oV287jCseyCWC/1hEdI8AU8MwdYoInIdn6qdok=;
	b=HF54EQzJVSPEaG1SxJglRqmeMx2Cz6Pt7yPPg6dNcIdz43fi4igIDZhmd/zevOuwyk0A8m
	Gyh/NsUVLkhUqLbqf6tI47P69KfRG4RixItSZxKgvrjpsUIpf4w4O6e3sP/pgu5EbwJaDI
	6lja4AIjiuZ1Ioh3eYcZXsSK+aikAsc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-GSrHEwUbOZK1gdMSF6OCHg-1; Wed, 21 Aug 2024 12:50:15 -0400
X-MC-Unique: GSrHEwUbOZK1gdMSF6OCHg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428076fef5dso58083925e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 09:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724259014; x=1724863814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kVY1oV287jCseyCWC/1hEdI8AU8MwdYoInIdn6qdok=;
        b=GUUhaIrDOWSWrmQ/5zLFKFViQeBobT/ay1ybjfaVoNmyu/EITjSJuzVWl3SvW01r5T
         3rN10Jsg3aM0vl7URUuMsC11AGhwLnqW7UpU6ny08LS/4/slroYCugYVMafVHwndlD+G
         5lIeNX2dSTQhyIo+5t0rHpw8pRmp2A00RwJqKq5/PjULmLyh++VSZNbf6aahfFst+Xz2
         S6TRsh0tI1DaXVW2sznxCncCgn97Cc/HqmM7d7NupVsqqhQQ74L4K5LTpHNHIQnR3Ahv
         27Or5r1GWJCGOhlVJLTXS9+8EhK/OkaQ2lEnLzqa/bQ3kHuszNfHU/Xr0kPcMAn+Ckfv
         gYUA==
X-Gm-Message-State: AOJu0Yxd0CmF287hTfxh/m9kvzXBE2lXwyZCviZKMzFRMPJGRigjTfO+
	LxgoYmnA268RmsPjy99X02C+EGUWMXLyuGHyBbXM841DD1WMywl9demstncAQg5uuv6Q7onTtT+
	ioCDKfFsSf0JhiKL2lGfhp4o9uvPQAHnuZOYN/rfJeGseyJb0iu/P0w==
X-Received: by 2002:a05:600c:1c90:b0:428:2e9:6573 with SMTP id 5b1f17b1804b1-42abf05ae37mr18604875e9.17.1724259014591;
        Wed, 21 Aug 2024 09:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpdYw76zuZe0YDI3B1kYguVY6tpjojxF2XLFri0Dx6C52Xr5OcnHJXIat12lugoEB31B+ySw==
X-Received: by 2002:a05:600c:1c90:b0:428:2e9:6573 with SMTP id 5b1f17b1804b1-42abf05ae37mr18604395e9.17.1724259013301;
        Wed, 21 Aug 2024 09:50:13 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee86f23sm30360345e9.20.2024.08.21.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:50:12 -0700 (PDT)
Date: Wed, 21 Aug 2024 18:50:10 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 12/12] ipv4: Unmask upper DSCP bits when using
 hints
Message-ID: <ZsYawgBS7HuvFmMR@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-13-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-13-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:51PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when performing source validation and routing
> a packet using the same route from a previously processed packet (hint).
> In the future, this will allow us to perform the FIB lookup that is
> performed as part of source validation according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


