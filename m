Return-Path: <netdev+bounces-191378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7CFABB47C
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 07:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F99189524C
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 05:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4955D1EF382;
	Mon, 19 May 2025 05:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GvdEAU8m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A12A35957
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 05:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747633175; cv=none; b=aKoemeVLzVkLp/b+n6KmwwdT8q51Bblz2pbZUAC3HWjpEriuCfQSeXcyQLufCEd7vnn0bD3+DNeDOCfAFM3yf50+cNrIDQbvWKxWvXPKKrTgt9NWuSkCtDLxocTi+3v8PrOpiei5F0LUB3JIGD28VSVRYN8CG2WqcaeH8E3MZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747633175; c=relaxed/simple;
	bh=Liv1CjjsZCCItQrb4U2dyx/MOrW22L0q0KUypI8sZ0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdQbI0pwpEgXLHjYKPiVf2xYVqGSn8sYTvCkc0opbTbXTvc57QU9izxHm69pjEogjwQg9xl8HuEkTqnA6RLbvN64ToemcfCbp1o0ybXkyNQcE0mwMGrSfMzSdz8RC8w+SthmKHMAYKILoq3EKrmMFdOG9wl31/rKSps3JIuqKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GvdEAU8m; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-708b31650ffso32932137b3.0
        for <netdev@vger.kernel.org>; Sun, 18 May 2025 22:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747633172; x=1748237972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gf1iSdBR5QF+BZyxWcLzEf9mLA8wNNuZF5EMnQHO5Ck=;
        b=GvdEAU8mNJpSucIfOVHDjg6cVouI5ufMZuGIKGzMvbdqWiAEs/ADjYntYDX42H18zt
         +/yhZ23TgeWWTU2RSzf0vNs17iDZvptuSuIR9tfL6/86dP63IyNSsW5qAZkPbXIaEJji
         o3YaB6qHVXKhnXxhgowNNIPF1TJE83zXT4/MtIXlfygmP+jRAqZLwaBCSG06GROmSK70
         nQxpqeEPdU2X5RXr2QJkEWOR4A/wyv+SlTBY7BZwvz1ThR2dS9NVaKTix3Z28C2TtdrD
         OhmYrikDv3EYt31mXKVqm0iqB5vFL7sAYEMVxMyMs4uuFRSNfloLTLSwToBlIg8iK8Cy
         oFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747633172; x=1748237972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gf1iSdBR5QF+BZyxWcLzEf9mLA8wNNuZF5EMnQHO5Ck=;
        b=SC2wk414gm/3aL5IE3Kozl+MKKFNnzYvLhDZrGwI7UiQQsYxAh7z8KgHIqgKQYZmcN
         /FG+IVE+kzhNg8TAI+u21L9Gf2eYhtOKlTjnjQmTYIkoboOn93jJz398mGYanNGmIszD
         yOkFHw7jC890eRqYPW9/R8PFyGRAQnrPpvj5fOnGB5KW76GuwZ3f8Sj9DiHHpHd6RChi
         lEle3L5Mn3js6BGjbXaopfMrk/CCqpATB30XlYpgn02e5hic8RT6Q+FrlO97uWeMQdHo
         jDhNLST7LI7rtaxwTvJK47B79Ir82UlsUqfH3G0z+JCAQdBElYtF3t9J3RWyEv57Y8Y7
         MLJw==
X-Forwarded-Encrypted: i=1; AJvYcCWlnE98emKO8LnzSBa6L4uI1sCOLYvTLZbfVC3787DMO3rhgtFWTkr8WcLlRI8IRNmclXav+YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxymhE0tK4G+sISCC822LqMTeKZ3jf1xd9VPJR0Wv4SKqVcMxli
	u4Sm0tDLV1Nf/JJOpvilWN22YkqkXVyyzPLvpxCTSYkrwBf55W79yReFjskzmgn0tXh+6sV3RkH
	/xNH7eceJR3HYR9YxHGRUBwajZ+jwkFyECqkcS+ihNA==
X-Gm-Gg: ASbGncsT3RI9MewE9IUk0GTy7QKPwjP4bNRr/RlKHrJRHTW5MYh3GgejUh/cpWlPSxZ
	/WwWVwp3PthcEEggkzUwd2ecD943HAgfEqjJbxL/wAnCdU6rdMc9uvpr5HQrhQXs9A0ZMRB5ekq
	BzEgy2fRi0GYshwj2cf80RN67okombZJeDeQ==
X-Google-Smtp-Source: AGHT+IEbYc+4S5SR2VuN6dHgpiMYP2OjzGQER1NiI1iefPsAH+wNn3K2+G95ErnxaSqP75RCwC6IjiRQYZ5GzLKv/98=
X-Received: by 2002:a05:690c:14:b0:708:bfc6:c7cd with SMTP id
 00721157ae682-70ca797c8f2mr141952157b3.6.1747633172467; Sun, 18 May 2025
 22:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414013627.GA9161@system.software.com> <20250414015207.GA50437@system.software.com>
 <20250414163002.166d1a36@kernel.org> <CAC_iWjKr-Jd7DsAameimUYPUPgu8vBrsFb0cDJiNSBLEwqKF1A@mail.gmail.com>
 <c744c40b-2b38-4911-977d-61786de73791@lunn.ch>
In-Reply-To: <c744c40b-2b38-4911-977d-61786de73791@lunn.ch>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 19 May 2025 08:38:55 +0300
X-Gm-Features: AX0GCFtOseuh1Qwexh3KTJNyXVhGEQU8_Vhw9OLuXa7HCysaP70bT9gQlbbQ9Ig
Message-ID: <CAC_iWjLsXp1eeR9U+VD+wXCxgCXYUrxbcNU-Pc+pqMLHn5wR7A@mail.gmail.com>
Subject: Re: [RFC] shrinking struct page (part of page pool)
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Byungchul Park <byungchul@sk.com>, willy@infradead.org, 
	almasrymina@google.com, kernel_team@skhynix.com, 42.hyeyoo@gmail.com, 
	linux-mm@kvack.org, hawk@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew

Apologies for the late reply,

On Sat, 10 May 2025 at 16:53, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, May 10, 2025 at 10:02:59AM +0300, Ilias Apalodimas wrote:
> > Hi Jakub
> >
> > [...]
> >
> > > > >
> > > > >    struct bump {
> > > > >     unsigned long _page_flags;
> > > > >     unsigned long bump_magic;
> > > > >     struct page_pool *bump_pp;
> > > > >     unsigned long _pp_mapping_pad;
> > > > >     unsigned long dma_addr;
> > > > >     atomic_long_t bump_ref_count;
> > > > >     unsigned int _page_type;
> > > > >     atomic_t _refcount;
> > > > >    };
> > > > >
> > > > > To netwrok guys, any thoughts on it?
> > > > > To Willy, do I understand correctly your direction?
> > > > >
> > > > > Plus, it's a quite another issue but I'm curious, that is, what do you
> > > > > guys think about moving the bump allocator(= page pool) code from
> > > > > network to mm?  I'd like to start on the work once gathering opinion
> > > > > from both Willy and network guys.
> > >
> > > I don't see any benefit from moving page pool to MM. It is quite
> > > networking specific. But we can discuss this later. Moving code
> > > is trivial, it should not be the initial focus.
> >
> > Random thoughts here until I look at the patches.
> > The concept of devices doing DMA + recycling the used buffer
> > transcends networking.
>
> Do you know of any other subsystem which takes a page, splits it into
> two, and then uses each half independently for DMA and recycling. A
> typical packet is 1514 octets, so you can get two in a page.

No, but OTOH the recycling is not somehow bound to having multiple
fragments of a page. So I assumed more subsystems would benefit from
not constantly re-allocating and re-mapping pages

Thanks
/Ilias
>
>         Andrew

