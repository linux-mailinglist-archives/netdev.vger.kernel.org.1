Return-Path: <netdev+bounces-137068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CA19A440E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87A6CB22512
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615F72036F2;
	Fri, 18 Oct 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVFYlpZM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B59956B81;
	Fri, 18 Oct 2024 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269862; cv=none; b=q6DbNS3s2NB8G5cEzk28BOPzhQSsj/06E5Osg6vVBca9eMgsRf9vJ4QylNgUUIV0ahVb7+uyOfL6Sno5OnlFxxLwQ+WG8db/05N5RIVN/b38OEtULab04v1JXi7DyzyiBhu23M6ur62bLx15iJbq+akKwccf94XiYv9uC+vQ/Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269862; c=relaxed/simple;
	bh=zkwxfCqjFMGxqd4RbEodHr0vbWJRU6/6kcKoFSMNj2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjR/JtGSjNkeVvzJRUFlIpCxQWy2BHbVO2PoY7DezVQrOOUCFWifIYd7Hy4gPKHQvqekQDNHEQguWIH2sa7SMS+XDQWVAs6IN9lPUSHYwERxfyAqcAwFt1j3+D1aWcPLOd2Px9NXXXXjuLS+ZU+62tJPUbmoXLlLtJ9y6KhNb38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVFYlpZM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so2096513f8f.3;
        Fri, 18 Oct 2024 09:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729269856; x=1729874656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWl4vwvAh8HLD6ILzYh/UBNdyFdrLz+RA3DAXkRuzZQ=;
        b=BVFYlpZMXLe9ezJ6ocCkTJiLIjFRiWrSqc/xdLwV3/ay22itf2Op9kdCBTALnnKosv
         rhnDgnpkkRl2C4V4GAwDN1xyH39sROTj2nY4+cQHcQEZYMnaM4cW8OAowaNOfU8zCEcK
         aFedZvqVbGE5fHQMVjQ77ZnOEsnkNxBUqbfW0ZkryM6lDTOmeZzAa1TkTVgQB5mlx2sM
         E62fONObNH86h/G9fPCEY1G2Cvnh8+Ujm2+OG4tHjTqD3dpX4fyP9lG0l4KsRCJc3Jlu
         QT7GdhUCufGvnZyMHDnywgn9kbSK42ZpbX4jy/aKN0+239GI2r9w9Qq37igGyBk3NLlr
         tTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729269856; x=1729874656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWl4vwvAh8HLD6ILzYh/UBNdyFdrLz+RA3DAXkRuzZQ=;
        b=A7MUmlz+r1EuLiNczZJP0hp8rbHRUEBtVKOPezdKM6CQA24HfsZusxFyFPDmrZOIBj
         z7Jd4ydKu7/nlSW6W/FrgkF2raDvtoLi0skMESdj1uGEM9dNVC0SU5nccObjJXnotqKp
         QRMPA628Mwb4lAedmkARAX+h8YJ+GRapEv9hAOpyjwag/wmK6Iwamz+7G2yW3JJMl9ob
         AQtCe4nm5+GcvEKIfay5xQevAnjuihZghNenq53xNhjTXM9g1fpLuwtAmioOrnxLCSGA
         j1yLhaZskiADF9h5aloxQrBo50hInWXCs3YNZh30MOtVSUoI95zp5GK9yeoen+Was9yk
         AMAg==
X-Forwarded-Encrypted: i=1; AJvYcCWdaORJv1wFFLw+/11QRZwdcfRMVSQJLGs+7okdLs/BLxDpLRYSHAIoiXIKTkCwLF4UBQKmuWIWBgE4eW4=@vger.kernel.org, AJvYcCWhamzT3PxpnD3PCHwQkM0jiTUrKiJLG7Vv2Twk+xWenndkArzj/FuLyhm9YpMvEA9U6sKDNIkd@vger.kernel.org
X-Gm-Message-State: AOJu0YxkjA6zyHLE217lXORRGzD5Yue+Vop/uTJuGsZFhbIc5pmEoQw2
	plc35NjmquUk0M3oZutJfxG3Sq4u7wbqTLQ+zBv2FSwlBVW0FQUnTaI5YOb5c8ygaJJcuE2A8Jm
	i2DtYXulvtKMlUpnrHJmb7IlVsCk=
X-Google-Smtp-Source: AGHT+IFf2G5spSchWpeavSmG/OnsSCNtNLpcSFQVXAbkWUbwyMeD0amC4cgYpYz31441HLo2GOpOQu/F+++241WYfN8=
X-Received: by 2002:a5d:5234:0:b0:37c:c832:cf95 with SMTP id
 ffacd0b85a97d-37eb47688b9mr3247595f8f.50.1729269856270; Fri, 18 Oct 2024
 09:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105351.1960345-1-linyunsheng@huawei.com> <20241018105351.1960345-7-linyunsheng@huawei.com>
In-Reply-To: <20241018105351.1960345-7-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 18 Oct 2024 09:43:39 -0700
Message-ID: <CAKgT0UeMbASOkxNpa68PXDALW5oT5PqPHTXKMKc1TKxFVVPkjA@mail.gmail.com>
Subject: Re: [PATCH net-next v22 06/14] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 4:00=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> Currently there is one 'struct page_frag' for every 'struct
> sock' and 'struct task_struct', we are about to replace the
> 'struct page_frag' with 'struct page_frag_cache' for them.
> Before begin the replacing, we need to ensure the size of
> 'struct page_frag_cache' is not bigger than the size of
> 'struct page_frag', as there may be tens of thousands of
> 'struct sock' and 'struct task_struct' instances in the
> system.
>
> By or'ing the page order & pfmemalloc with lower bits of
> 'va' instead of using 'u16' or 'u32' for page size and 'u8'
> for pfmemalloc, we are able to avoid 3 or 5 bytes space waste.
> And page address & pfmemalloc & order is unchanged for the
> same page in the same 'page_frag_cache' instance, it makes
> sense to fit them together.
>
> After this patch, the size of 'struct page_frag_cache' should be
> the same as the size of 'struct page_frag'.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  include/linux/mm_types_task.h   | 19 +++++----
>  include/linux/page_frag_cache.h | 24 ++++++++++-
>  mm/page_frag_cache.c            | 70 ++++++++++++++++++++++-----------
>  3 files changed, 81 insertions(+), 32 deletions(-)
>

LGTM

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

