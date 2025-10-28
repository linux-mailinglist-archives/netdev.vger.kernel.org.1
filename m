Return-Path: <netdev+bounces-233344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 551BAC122BD
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D92C3353700
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 00:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FF419755B;
	Tue, 28 Oct 2025 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VTMdbrzN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8BE571
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 00:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761611549; cv=none; b=fIXJ0E9FUfehSbIgMylvLHLOmeDkOFs8E1R5UNKMx8TnQg6uxv/OKgAwmNtUfYolEBn6UX4BVnEp9BTt/IEqPHva14iJKXVvsCgr47O8ZjyKoOnOswhwhw3cB5916Rovu65kMeH+kWM5FyEtwN6tH0fsfCrD2ltt/r7fat37hfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761611549; c=relaxed/simple;
	bh=sZliMbiRU5IJnJ0zaE4gY5+HIkp6n6SZ0ixcB4Cdxy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMtZJEsnBGP8IHrUrLz9Q+lXxwkwfzM2afOQiS8jvsiF8+h/x6aGSXjSKcMtXXR1TZz77G0bCha1IAgjlHaU+eIUYG71ppFqZXwKZ3um1TsNAk1BnBPFR+Ha7AdCKP1wzqRDkGOeB8eMaA3GtxYbYIRNsLsQioXw1EW78fJVyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VTMdbrzN; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ecfafb92bcso105311cf.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761611547; x=1762216347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDGupZg9RAC3q75DNbAlYNiWKv+uKA1nO+SLuFhCPek=;
        b=VTMdbrzNhUyPF1yP4r9pK1vMwOutK7CyNY/DmCq3AW4O3Jw7hPNJX5nz+33PFbXdWj
         SOuuXhzrU0bXso5b+IJ5As0/cCSkmojkWEExqPT/Lh3+hd54rAIse21ZFrnoNOU+Z4CI
         rr/vzgeIINRpsi/u9L1/QV4jKugGikR+4p10GtPZCHpgiilta7MNMQmSY7XPc9VdfoLw
         1ARFzDD/UxG4yVrbd+PMyT/Ew2dc49yTZ7fateieKpa6WbEr9x+1WGTaEc0rzXwNrdam
         zJVBhlnbFEgbDSD5r4ld1b+/ZPeI9vZ/zgorFEBhAu4TloKXNPh8aHNCVxDzeDGwy5YD
         8g9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761611547; x=1762216347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDGupZg9RAC3q75DNbAlYNiWKv+uKA1nO+SLuFhCPek=;
        b=efK0Eks4wZFHxm46AUj/BfMJCY4VnD21I/9AW2LsplvCeXEEkFQtKlEW258CrbEIk4
         D0GkSJsR5jQ4vSkJ+vLZ4Gz9nQ37V1iXx42wYhQ30tHPBVMyzGcUxOnriP+mylQjUlpB
         CSh2MtKAcGiYkPT/FcuMmiY6jo6TccysKUZ+NQhyJT5lZ3cF6pkddVZ+Eh3q7FQMzw53
         QEIG2qU5Q7hPnm6e6kQhpWExfHESZtSaJjgESTeNsIYL60kymN4auxTZXLTYQh58ojcz
         M/vzamgqsyIsy91GpqWMjJKeVxcDWH4KiRaNL2mZL1xVplKk5pimSOyWNnjjBbHo8xZF
         fYXg==
X-Forwarded-Encrypted: i=1; AJvYcCVA/kV2rwrSeC1LhX3O92epHVtWWaD49K2F8Ys/mVRFuoQfZt1s/UKg7SA43Zo3Pf/5AjACiEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlofipf7d+df4JWcxTekqDuTTiiABFYodFjOU3/iZ7SUNJ67TT
	GPwtaqgviLdjdKQuXXNWiylOyTGafxyW4EQ6M6JiKIPqcc1zt/uS+JeWTe8zZl6wEdzUqD00hbp
	qBsIv0hIdjQnbuBYZwkh8JvrNMOseaRIeomEN9ybM
X-Gm-Gg: ASbGncswHgo98IPlNkNbTaCzlGR5nY014CUkUMIzHszsU134sgPpyRkB1kZK/3RRBa4
	ua+aehL/jALY2yrbYMIOVHiddIbjWuhZDArWwQ2IJuvUE/qmrRSRJ5sPpz7GVTR+wLToX5fKvlw
	Gxv6SVr9StLq0pay2uQ2RD+katTDWB8rnUGFRxYm7pNfHFlbx21Mpg3osJ5Tp8WzmF+L6P0znZv
	x9aQTWEyjKQNGzrsR1VnLBp/sdmUzELfiyDFpx+idfcyAfRYISPgcIYxJdZ
X-Google-Smtp-Source: AGHT+IGhbJ+GHyeWlSzN6ycqAXLoxb1EC+qLGQ2vsQUvm5izxjzksoM3aqy/R23b67xhbshxeno45TIc7lJlqTr+JaM=
X-Received: by 2002:a05:622a:17c5:b0:4e5:8707:d31 with SMTP id
 d75a77b69052e-4ed09f4b74amr1602631cf.7.1761611546407; Mon, 27 Oct 2025
 17:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024-b4-devmem-remove-niov-max-v1-1-ba72c68bc869@meta.com>
In-Reply-To: <20251024-b4-devmem-remove-niov-max-v1-1-ba72c68bc869@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 27 Oct 2025 17:32:12 -0700
X-Gm-Features: AWmQ_bmC9jAN48RJAgN8fH5cjcodcmrZUz535l1EvetlKGHj2iyHZZuQ7umrKFs
Message-ID: <CAHS8izN0nXPxpNDB=b=3dLMuf5KjGq_AswHsJ-XQDhMi7Y3WYQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: netmem: remove NET_IOV_MAX from
 net_iov_type enum
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Byungchul Park <byungchul@sk.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:03=E2=80=AFAM Bobby Eshleman <bobbyeshleman@gmai=
l.com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Remove the NET_IOV_MAX workaround from the net_iov_type enum. This entry
> was previously added to force the enum size to unsigned long to satisfy
> the NET_IOV_ASSERT_OFFSET static assertions.
>
> After commit f3d85c9ee510 ("netmem: introduce struct netmem_desc
> mirroring struct page") this approach became unnecessary by placing the
> net_iov_type after the netmem_desc. Placing the net_iov_type after
> netmem_desc results in the net_iov_type size having no effect on the
> position or layout of the fields that mirror the struct page.
>
> The layout before this patch:
>
> struct net_iov {
>         union {
>                 struct netmem_desc desc;                 /*     0    48 *=
/
>                 struct {
>                         long unsigned int _flags;        /*     0     8 *=
/
>                         long unsigned int pp_magic;      /*     8     8 *=
/
>                         struct page_pool * pp;           /*    16     8 *=
/
>                         long unsigned int _pp_mapping_pad; /*    24     8=
 */
>                         long unsigned int dma_addr;      /*    32     8 *=
/
>                         atomic_long_t pp_ref_count;      /*    40     8 *=
/
>                 };                                       /*     0    48 *=
/
>         };                                               /*     0    48 *=
/
>         struct net_iov_area *      owner;                /*    48     8 *=
/
>         enum net_iov_type          type;                 /*    56     8 *=
/
>
>         /* size: 64, cachelines: 1, members: 3 */
> };
>
> The layout after this patch:
>
> struct net_iov {
>         union {
>                 struct netmem_desc desc;                 /*     0    48 *=
/
>                 struct {
>                         long unsigned int _flags;        /*     0     8 *=
/
>                         long unsigned int pp_magic;      /*     8     8 *=
/
>                         struct page_pool * pp;           /*    16     8 *=
/
>                         long unsigned int _pp_mapping_pad; /*    24     8=
 */
>                         long unsigned int dma_addr;      /*    32     8 *=
/
>                         atomic_long_t pp_ref_count;      /*    40     8 *=
/
>                 };                                       /*     0    48 *=
/
>         };                                               /*     0    48 *=
/
>         struct net_iov_area *      owner;                /*    48     8 *=
/
>         enum net_iov_type          type;                 /*    56     4 *=
/
>
>         /* size: 64, cachelines: 1, members: 3 */
>         /* padding: 4 */
> };
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

