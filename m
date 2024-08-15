Return-Path: <netdev+bounces-118883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94778953688
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5BB1C2420B
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3C61A4F22;
	Thu, 15 Aug 2024 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM+++QTe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12F19DF9C;
	Thu, 15 Aug 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734224; cv=none; b=swpdrSrt/U4jN69w2EeTeCnxWMGBqSHPZAwycBDMeI+Mp2h6bHB38h7eDoylra/E2F+0zXq9hz5eN+R5XlaHYffek54o0JoWMVhaZkzZPEVnfmW4iaPIeOEtVLClGi+RO83D/JVIh8lsoL3wB/lxrTwdye/6WF9aEI3pICX1BEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734224; c=relaxed/simple;
	bh=ll9i0hiVP/9ZCwrJhJvqHFiSi1UJFhdxc+hSASADtCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGFjO6MIzp0GljtBwHurX+GpM1vE91Fabk9NpUJ8+ldSx6It+aqi1xaqVnLGOO7LKlZ7Eg5ZeCq8GZOQT3J7L8cEKYoxNqMn8a/aCeLA/1+2ZTn6J7oC8/5YGylQSoluPtRRmbTJOycHelbLxti5jazH9jxni7trHegLjaVwbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM+++QTe; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-81fe38c7255so71645039f.1;
        Thu, 15 Aug 2024 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723734222; x=1724339022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZXwLHTlCyIaiylFLFXU+7bWu80DR5kxOILvCPmJec0=;
        b=VM+++QTeBsQgs26KUJZVF2yI2IBAk3ptOWaHvuuKkh6oN8Hs4Q5ExCvmP41vk5+MQF
         UQxd6Fkh+W6PMzQlmhzHYe0l2Tw1eQWHQhfzlaklyS52q4LS6QeZrNZ8B+vfU6t1nzfn
         Yq76qaTfiZOmhy0fH6fjrQDaWo2v3HFl/bh5gxYkhRUe00zQPc6pq407MKWaY1RLLu9i
         S7wji9gREOpLwMtvHohjlhBcs4rjfWLutQDELpYZQWZOIobnxzrsILNMl7611qjHcT+p
         LuUJGbqm4wY2kwlhCY7ZK56UXkvlMr5EolMeY5KCDPQySjFDPaLUpZLVY9MH26YvCNCj
         wgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723734222; x=1724339022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZXwLHTlCyIaiylFLFXU+7bWu80DR5kxOILvCPmJec0=;
        b=VrQ4VAoTXXbvVyBzCrBPWWdPYSgnKVhxg1Hl2ZCROi3Ci+Gu+t2URM9cZrLiH0hTEC
         D0CdRdSiNU95n5WsVF5uXhx4BIEJ0nbr9PFdDtrgbrgh8bFMeAQ8gISwhnzuAy0LQSye
         z4l0PXWKI2/vmX+tCWM4LmL6QTvznLmyWzRR+qGKEwjnUnfsynDq6gtA2OXLJgnBjotv
         +AfmKsuNhsCqkHvWT75pAuCHPxnokbx7w/DHWra2+HcDDS+CCvNDh7arzMQV6dqKSd4t
         O3SWMj5PeFsJYimTHYIPYEoXoCheWWsLTlVYrc8JuHWxmHOwdzMHdab9SY0lMU/b6mzO
         RMmg==
X-Forwarded-Encrypted: i=1; AJvYcCXeXDOwPfjJ8RfQV2JQYy+a1AdbN6fBFvUZA9p7wR0QJ/RGtrJoAuL9MOCCHd1cuF5ehvBreAZmjc4TXzSB8GximiVgDGWn7XvRmo0ytomy2aW2mRQ6vAHjWKivTZ2eOeK1CFXH
X-Gm-Message-State: AOJu0YwOrM3ZXW5Uu/hSf44R3J5Z3Ml5h/21evqbCMQcYxbJnxUAtb6J
	sCsB68BKbBmexrvSSiwSPMyrViR+csmTd9ezl41ki/o60aSZDtUJrh5mNXKnd2ktkJQ5FHZNnAy
	YuhdSmwo2TcdP8DLnfI/dw8TZUiU=
X-Google-Smtp-Source: AGHT+IGLRHQYeWXj0j7/ZV40l4ciGGeC1xdOuHkqvrjkiRy1+5DC/smoDGxg1GO+HbjcaLxwlPzyecJugp7XOOXemes=
X-Received: by 2002:a92:cd82:0:b0:39b:3387:515b with SMTP id
 e9e14a558f8ab-39d26cdf7ccmr1031665ab.1.1723734222041; Thu, 15 Aug 2024
 08:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-8-linyunsheng@huawei.com> <0002cde37fcead62813006ab9516c5b2fdbf113a.camel@gmail.com>
 <a036abc3-76a0-450c-afea-2db3c10f0ed5@huawei.com>
In-Reply-To: <a036abc3-76a0-450c-afea-2db3c10f0ed5@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 15 Aug 2024 08:03:04 -0700
Message-ID: <CAKgT0UfUVJ6FmVgFWv+uCV9Q7eX8s+Mf6cPVCLyHwk5TxtuKgg@mail.gmail.com>
Subject: Re: [PATCH net-next v13 07/14] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 8:10=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/8/15 0:13, Alexander H Duyck wrote:
> > On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
> >> Currently there is one 'struct page_frag' for every 'struct
> >> sock' and 'struct task_struct', we are about to replace the
> >> 'struct page_frag' with 'struct page_frag_cache' for them.
> >> Before begin the replacing, we need to ensure the size of
> >> 'struct page_frag_cache' is not bigger than the size of
> >> 'struct page_frag', as there may be tens of thousands of
> >> 'struct sock' and 'struct task_struct' instances in the
> >> system.
> >>
> >> By or'ing the page order & pfmemalloc with lower bits of
> >> 'va' instead of using 'u16' or 'u32' for page size and 'u8'
> >> for pfmemalloc, we are able to avoid 3 or 5 bytes space waste.
> >> And page address & pfmemalloc & order is unchanged for the
> >> same page in the same 'page_frag_cache' instance, it makes
> >> sense to fit them together.
> >>
> >> After this patch, the size of 'struct page_frag_cache' should be
> >> the same as the size of 'struct page_frag'.
> >>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> ---
> >>  include/linux/mm_types_task.h   | 16 +++++-----
> >>  include/linux/page_frag_cache.h | 52 +++++++++++++++++++++++++++++++-=
-
> >>  mm/page_frag_cache.c            | 49 +++++++++++++++++--------------
> >>  3 files changed, 85 insertions(+), 32 deletions(-)
> >>
> >> diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_ta=
sk.h
> >> index b1c54b2b9308..f2610112a642 100644
> >> --- a/include/linux/mm_types_task.h
> >> +++ b/include/linux/mm_types_task.h
> >> @@ -50,18 +50,18 @@ struct page_frag {
> >>  #define PAGE_FRAG_CACHE_MAX_SIZE    __ALIGN_MASK(32768, ~PAGE_MASK)
> >>  #define PAGE_FRAG_CACHE_MAX_ORDER   get_order(PAGE_FRAG_CACHE_MAX_SIZ=
E)
> >>  struct page_frag_cache {
> >> -    void *va;
> >> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >> +    /* encoded_va consists of the virtual address, pfmemalloc bit and=
 order
> >> +     * of a page.
> >> +     */
> >> +    unsigned long encoded_va;
> >> +
> >
> > Rather than calling this an "encoded_va" we might want to call this an
> > "encoded_page" as that would be closer to what we are actually working
> > with. We are just using the virtual address as the page pointer instead
> > of the page struct itself since we need quicker access to the virtual
> > address than we do the page struct.
>
> Calling it "encoded_page" seems confusing enough when calling virt_to_pag=
e()
> with "encoded_page" when virt_to_page() is expecting a 'va', no?

It makes about as much sense as calling it an "encoded_va". What you
have is essentially a packed page struct that contains the virtual
address, pfmemalloc flag, and order. So if you want you could call it
"packed_page" too I suppose. Basically this isn't a valid virtual
address it is a page pointer with some extra metadata packed in.

