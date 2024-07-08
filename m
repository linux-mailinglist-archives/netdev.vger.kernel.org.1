Return-Path: <netdev+bounces-109929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE1192A4B7
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619751F22063
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B049D13DDDA;
	Mon,  8 Jul 2024 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/WkP3UJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0621B38DC3;
	Mon,  8 Jul 2024 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449070; cv=none; b=JULVPhK9tjfwapraOYHM2xuJJlf+YKHGSCb5icZr5Eb8t/5ZQ9NAWK6Abi0pWBc/EvCh5lPgMd1LfHTgzRvWSxBD1WrJu6MO4TtYVg/ygmDpnYZKMzHf3zDfBGYlMV+CyxFxcaqG0+hmb7iQEyNGiFTVQm8mQy3SCztH6YPwHAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449070; c=relaxed/simple;
	bh=UUtLVatZrv02Lzew8iQgrph1Pi3wQhH9u7SbiMLiv1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlJ4xFZIiS4kUaZS+EiLqSqX2BEVO4PS/wB8sEFVotNW8pKbnuekEe5U7CakHLMX4FdIcgdXV0aDq9I2AIwkG9/WIdHRqfxXlYygP02ypaUWEBUwBznM/R/U8ywGP9AFTpo+R8EEw9Tg6Yy/NKWtGyVAFrtyLkR38DvxVP7oT44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/WkP3UJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3679f806223so2326596f8f.0;
        Mon, 08 Jul 2024 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720449067; x=1721053867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=praCejWfnL4tvn8vRf99MQxNtfzrDObizyuJfLk1AHM=;
        b=H/WkP3UJ/Ut7Wg6D2JCWme74/Iyq68hArKHcheqGBOX2Sttwr9Ad2Vp58NVBaFGmkC
         8P4c+RtPeLCbNv+3v4Hg5wLiiUj2XngxG6VqAiW08Cco0Ari1QxSeShdQfHYMP2MwvLR
         Z0qxERhLcNYfKsx1kY4PxbaKWv4LIBhEjx7Gv71V+TrgY+DBkoG+lQWrmMwonXEJCQ9l
         R8rKnzZzmqmxTjcX4r99mCAa3rWHXUIZfWyJ16/w4ODpRz3sw3CJ+E2x2MqwKVfZ+3+R
         dq5RUAkBiEO+uCzOkkwYTIc8RmnFLNMQITzq1ac4JohcqPEIcw9max+5UyjYpKdQlOOm
         OeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720449067; x=1721053867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=praCejWfnL4tvn8vRf99MQxNtfzrDObizyuJfLk1AHM=;
        b=paD66D9nFWYIrd5657RCDbERtmEeUmO+WtDV+VEKYfxs2XByiI3OS6I99eJR8Ekn4f
         1NNPdzl7brxrNjsNFWjoWyI0shiirdNAZV3RjPsC5j6d6DuZ7kqZMEzw0IS3dwHzdYoh
         AyGK7sLA2W6DEjM79082qnnAb9yhKo1IK3MjwyiOSaYGal6UJb5EUBlH7yGUeBWpiR4x
         EcROdyYSRATfR23kJeunbC7xyB8surjOUJ+/PZmU9dhR6Rei8MqwRhPzcERqLQun1Vy5
         5iWiCgj67TbRioQpEXYipRG6lUJ7JyclC0/09+wTsQgIBBVAxwA09oNadRlmhd2PRlMO
         q/ng==
X-Forwarded-Encrypted: i=1; AJvYcCVKSETKqugTBDsjBoz099Su31IcLYJUms0LoJren42rB6OotZKJI/y6pyofAMRKRbmLMadCuIFypB1Dvu3A4KAOdtN1CTZbpDceO8L++edFqLymCGe8nnJKk5LSHVo3iTTLWL2V
X-Gm-Message-State: AOJu0Yy0w4ImWCddysKU/sV2L5zYwemZNCZSggLawO6lRQjUhmH9VpaG
	S6k/a1AiFoGp6+TXfFLA1hgq9Y+NYZdA2u8JqHUdRe2KQTMr2aZly+PCqOQMpp/wTmLdTZ3KpmS
	P59DtXDkR2WAwNA1jMcvC1upvm6g=
X-Google-Smtp-Source: AGHT+IFoh68HLd0TMS0+kGGf5MwuNOwxGvMq4ZWjbXeoBxd9S6ujGKoBgyoOGLXMik21GVdPzCHmonPJZKz88mSGP0Q=
X-Received: by 2002:adf:e790:0:b0:360:9500:9bbb with SMTP id
 ffacd0b85a97d-3679f6eff1dmr12024136f8f.12.1720449067049; Mon, 08 Jul 2024
 07:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-11-linyunsheng@huawei.com> <33c3c7fc00d2385e741dc6c9be0eade26c30bd12.camel@gmail.com>
 <38da183b-92ba-ce9d-5472-def199854563@huawei.com> <CAKgT0Ueg1u2S5LJuo0Ecs9dAPPDujtJ0GLcm8BTsfDx9LpJZVg@mail.gmail.com>
 <0a80e362-1eb7-40b0-b1b9-07ec5a6506ea@gmail.com> <CAKgT0UcRbpT6UFCSq0Wd9OHrCqOGR=BQ063-zNBZ4cVNmduZGw@mail.gmail.com>
 <15623dac-9358-4597-b3ee-3694a5956920@gmail.com> <200ee8ff-557f-e17b-e71f-645267a49831@huawei.com>
 <CAKgT0UcpLBtkX9qrngJAtpnnxT-YRqLFc+J4oMMVnTCPG5sMug@mail.gmail.com> <83cf5a36-055a-f590-9d41-59c45f93e7c5@huawei.com>
In-Reply-To: <83cf5a36-055a-f590-9d41-59c45f93e7c5@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 8 Jul 2024 07:30:30 -0700
Message-ID: <CAKgT0UdH1yD=LSCXFJ=YM_aiA4OomD-2wXykO42bizaWMt_HOA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 10/13] mm: page_frag: introduce
 prepare/probe/commit API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Yunsheng Lin <yunshenglin0825@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:58=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/7/8 1:12, Alexander Duyck wrote:
>
> ...
>
> > The issue is the dependency mess that has been created with patch 11
> > in the set. Again you are conflating patches which makes this really
> > hard to debug or discuss as I make suggestions on one patch and you
> > claim it breaks things that are really due to issues in another patch.
> > So the issue is you included this header into include/linux/sched.h
> > which is included in linux/mm_types.h. So what happens then is that
> > you have to include page_frag_cache.h *before* you can include the
> > bits from mm_types.h
> >
> > What might make more sense to solve this is to look at just moving the
> > page_frag_cache into mm_types_task.h and then having it replace the
> > page_frag struct there since mm_types.h will pull that in anyway. That
> > way sched.h can avoid having to pull in page_frag_cache.h.
>
> It seems the above didn't work either, as asm-offsets.c does depend on
> mm_types_task.h too.
>
> In file included from ./include/linux/mm.h:16,
>                  from ./include/linux/page_frag_cache.h:10,
>                  from ./include/linux/mm_types_task.h:11,
>                  from ./include/linux/mm_types.h:5,
>                  from ./include/linux/mmzone.h:22,
>                  from ./include/linux/gfp.h:7,
>                  from ./include/linux/slab.h:16,
>                  from ./include/linux/resource_ext.h:11,
>                  from ./include/linux/acpi.h:13,
>                  from ./include/acpi/apei.h:9,
>                  from ./include/acpi/ghes.h:5,
>                  from ./include/linux/arm_sdei.h:8,
>                  from arch/arm64/kernel/asm-offsets.c:10:
> ./include/linux/mmap_lock.h: In function =E2=80=98mmap_assert_locked=E2=
=80=99:
> ./include/linux/mmap_lock.h:65:23: error: invalid use of undefined type =
=E2=80=98const struct mm_struct=E2=80=99
>    65 |  rwsem_assert_held(&mm->mmap_lock);

Do not include page_frag_cache.h in mm_types_task.h. Just move the
struct page_frag_cache there to replace struct page_frag.

