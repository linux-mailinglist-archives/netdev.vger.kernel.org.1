Return-Path: <netdev+bounces-163601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A95CA2AE38
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD9F3A4FF7
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 16:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5611624E9;
	Thu,  6 Feb 2025 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZdVhJfb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE94923537F
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738860878; cv=none; b=iZPlslEFdmEvhb/XNQYdyjXIu1bGUE2ss4N9gsxwfM+mYoqJi+BrbaYYZ1lcEbJRBFY3omFyKCpu0DZpAkm3YLhAhBGCp0O8R8+ziz1oZfF9iAnfY64li3VSnlc/PW02PrRJC7XS6YD7D2ZLPcfqGDow9kcmxAC81HaYSXg3Zo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738860878; c=relaxed/simple;
	bh=3ZZUQukPMQhDSn6JUeVKKpej9i1kOO3tGVWwO1oxg2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0UuMmd2+KqNhBS+xuQcrEGyrkys7SA8h6AXfT2ETgzqh05PEDDkgLxHnffYJteeVGK7m5p+Y7+VZvEVn07iYmjzHw3l1ofdcAtkGVE11A+XO3IOgf7Jz+8G6emqDaaf/EdRBBBVhWE2tR9YjGeNmjR15kAXczNEl8ZkEt8EKW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OZdVhJfb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f032484d4so37665ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 08:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738860876; x=1739465676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTi6XQsJ5RIwztDyjcq4PDuI/5/RV6XdKp/ZtUfpYp0=;
        b=OZdVhJfbJN4rA0Ge2vuLq0ZQPPrPBocmWtbJ3ZqjhvOvklb5o3RmVLtSkV3vSQL7qz
         axfizU76aeAhPqrrRkWJmVToXMOAJV3bf3f+Jndeb+gi0Z7rGxHLBlIQcbyhMica23Yy
         Bo6mRZLyX+C59j2+eUG5AD3iKhCuvn+b6efdOFRvd6ISycCBZxNpi5AUThzlImzhzmdo
         l8akDZinu1771IrPedYR4xJqo7GHeg9wqgrOXqyUEix0d6zp6kGOmC/0mqr2Zo1De53D
         BTGkNLWMe9BYFtTLdym0NWA+G8DU8d8GKqVgigg3V7gGAtdeeQIytzYICekR00Fn+VHL
         67Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738860876; x=1739465676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTi6XQsJ5RIwztDyjcq4PDuI/5/RV6XdKp/ZtUfpYp0=;
        b=dj0cx20llRLhpb3OVcvsWnJrLasr1GRrL1005jLizoUaWOmFpg+4mNTeCh0+Bo+zrF
         9YdvN+4hWz+QqFMhWHvb7QCZUayBxc+O1H3UWuziHSPnUsKAGCgtK8sNBGEc93vkUYcl
         GMqMYrifUEVQmBlgBznU0M+wS/VVi3bAISFtA4aLlFZrghChBOVTPHVjGQF5+MYYumf/
         JS5cnS2NkxCLY24s8Gf544Wk9bd2lNkcuaJe4M3zqSEKUs9+MMX9BNLnsHjiiWMcHRrA
         Yy8d+oX41HL4xfqk5NfEhIVe/Pe4nf2NqKVvBZlbt6aPK+tXGhAxod0/WZFIU/z7MZ25
         2OJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVjuLnyCT7mJBpsKb1+aCamWRZpNp/vxcAb2J20bs5RTfKmeLi+oI4Q3B5EbKSllSlblHyR6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Ec4CaU4TTSdwgyrVJvhW/XiOKze1ChPo/dbaHdruyomYguJx
	06HjlAMJ/LsPXbDV4+JQwTzyzpdya2itRnx+6R7CAW/T7GJP9jCCLN8L7T0er9GQ+oJ4gkopja4
	6smGBROAhECDiqbIiYkF4Cd+zXB/zLTkvYXgs
X-Gm-Gg: ASbGncu2uWx0lNQ6Kd8pd8hGAO3x2cwpVP0V5NWOIGHxLSAeTVQk+XFiKuCbZKJbdNI
	aR97zBrMS+vE2FVc0qafAFTJYI6XyYMO8yHYOgOufov5gycK/aUR/TQQBaH1A+tIDtr2A5+81
X-Google-Smtp-Source: AGHT+IHzryBnDyIuG4kua5nqFv0t3CUZetv5VWZDEVSBd2Q6xKHftpMfzmT/4FNKDJh9y7JmfSRCt/+KPeHBMGILBJ4=
X-Received: by 2002:a17:902:ef4c:b0:21f:2ded:bfa0 with SMTP id
 d9443c01a7336-21f4c50aef0mr178385ad.25.1738860875702; Thu, 06 Feb 2025
 08:54:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127025734.3406167-1-linyunsheng@huawei.com>
 <20250127025734.3406167-4-linyunsheng@huawei.com> <Z5h1OMgcHuPSMaHM@infradead.org>
 <c4b8f494-1928-4cf6-afe2-61ab1ac7e641@gmail.com>
In-Reply-To: <c4b8f494-1928-4cf6-afe2-61ab1ac7e641@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 6 Feb 2025 08:54:23 -0800
X-Gm-Features: AWEUYZkAfsd2D0WA6s0xLr-HWyLjnZliAFrvM7gs-k38rOzilGMV9dLNA263rHA
Message-ID: <CAHS8izO5_=w4x8rhnHujCWQn7nhEDzaNGgJSrcZEwOQ+dN_o3w@mail.gmail.com>
Subject: Re: [RFC v8 3/5] page_pool: fix IOMMU crash when driver has already unbound
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, zhangkun09@huawei.com, 
	liuyonglong@huawei.com, fanghaiqing@huawei.com, 
	Robin Murphy <robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, 
	IOMMU <iommu@lists.linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 6:23=E2=80=AFAM Yunsheng Lin <yunshenglin0825@gmail.=
com> wrote:
>
> On 1/28/2025 2:12 PM, Christoph Hellwig wrote:
> > On Mon, Jan 27, 2025 at 10:57:32AM +0800, Yunsheng Lin wrote:
> >> Note, the devmem patchset seems to make the bug harder to fix,
> >> and may make backporting harder too. As there is no actual user
> >> for the devmem and the fixing for devmem is unclear for now,
> >> this patch does not consider fixing the case for devmem yet.
> >
> > Is there another outstanding patchet?  Or do you mean the existing
> > devmem code already merged?  If that isn't actually used it should
> > be removed, but otherwise you need to fix it.
>
> The last time I checked, only the code for networking stack supporting
> the devmem had been merged.
>
> The first driver suppporting seems to be bnxt, which seems to be under
> review:
> https://lore.kernel.org/all/20241022162359.2713094-1-ap420073@gmail.com/
>
> As my understanding, this should work for the devmem too if the devmem

From a quick look at this patch, it looks like you're handling
netmem/net_iovs in the implementation, so this implementation is
indeed considering netmem. I think the paragraph in the commit message
that Christoph is responding to should be deleted, because in recent
iterations you're handling netmem.

> provide a ops to do the per-netmem dma unmapping
> It would be good that devmem people can have a look at it and see if
> this fix works for the specific page_pool mp provider.
>

We set pool->dma_map=3D=3Dfalse for memory providers that do not need
mapping/unmapping, which you are checking in
__page_pool_release_page_dma.

--=20
Thanks,
Mina

