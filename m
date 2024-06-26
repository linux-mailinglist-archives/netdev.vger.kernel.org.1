Return-Path: <netdev+bounces-106805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA519917B31
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BBA288DB0
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 08:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9301616131C;
	Wed, 26 Jun 2024 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wjjo6chC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10C815D5DE
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391433; cv=none; b=UE6DBF9/CqPR8TAJq23CLHJdL+KE2m5OLVT4EUeppDG6VDDYgwvC7zEH/K4fMszPocU3GJG5CI5EWMyKoVP6ymmFGXzPhCObiBZYwGuFkAM5dc5ELaRuD2eWxr56QCejU+Y3URVzLwqdfy++UNXAr+gAvsrhUalBzmgYkne7SCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391433; c=relaxed/simple;
	bh=qyM/pBiUedyCLh7GYSGiX1g/z0dYDe9+wq98MwlZxZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2dGWt1II7nAD0ZfO/maukrZXlbzw6CRdwbvd2t9lJVZu8Fyf5X2pgugGD9WsUIOqyc5PkWHeNKLlN0O/CRpsT23vaW2YEmJ5n+g/81QfV1qmM+ojv17y8DeW5uKyltMhj5c5SWbVQrx6Hf56geZXjYrnrRtBBjOi2Slrz5PgJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wjjo6chC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d119fddd9so7435a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719391430; x=1719996230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyM/pBiUedyCLh7GYSGiX1g/z0dYDe9+wq98MwlZxZI=;
        b=wjjo6chC2Z+0vRhg1ejDSOLcDGgRzqcKtS1fD2w9T0PnY7d2mueoqrfa8t3K7kyrau
         t1qiqSzUkOMHGorPjBE13+GH8RlI6tkd2dt7c6sUBG+edJEYIHmvCatY7jBKR67IRP63
         TlwgRDztkSRZ20azg7oIo0eNiPd8FNf5wKv54gN/Rj7mfxBhzk2DWHjHdbrrF5xoo7j7
         rOxNmGApLKb6iW9MExtBCKmbrWaPqwrPfGtMnxam1zY6b3DXRTiSKJuFn9LOWYFKowjK
         Ou4xmZSPWj3Zpe890C4ybsMq/Ey0QRHoxN9R0LtGrJXFBeENeptbwhD2gIj1hV+vVwDZ
         umAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719391430; x=1719996230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyM/pBiUedyCLh7GYSGiX1g/z0dYDe9+wq98MwlZxZI=;
        b=Wltp8ZoPnTfFXArsMKy1aFlAKzAbhhuaGqf0zPmoo2oFdi+91kCnbwtYj90Q/oDqIO
         jtVPP5CpcuGnKkkTMqOGaHyZCfGURR62ANOI/XRmmTZ9p+1a3HlqFYCVHrEfXL/3JW/3
         kicWU7iR7VHBtsfdKjQyr1dFPqWm8pzDwaJo1kklpAY8bMtokEqrcM/DqIFHZyQF0O0Q
         sQYyzcNlbhIL1gsUeH0gm9Go5hFk35P32500PHpUAkKsjbdSa0Mvi5HIEqDRkL7o/y0e
         vJhtgxvsCIlCq8yv5RoysYFR6JOZ2rQ3qJ+ZsRJKIEC4K3Dj4oAuZCsdACbxJMbcCnVC
         ikNQ==
X-Gm-Message-State: AOJu0YxVHvJ0XpMKhPP93QvbF6AeRBon/UmVuWMvWHmWS4N73hr63GwI
	35cAqhL7QYXCpEmYyFvnDh1AXYQbQIuh4ylMI9OQ+sKCGUzyKilpwaEP59oNw8l0g/XCJXbiVNW
	+Pb75ixO2/SGSJknzLMrx6xzE3THoQ4GFBCzV
X-Google-Smtp-Source: AGHT+IHS4XsQbrJXsxGKa86YDjCMrAN9c93K+qMBXYKVBto5NeIPFRsx8NZS2nCm7bZxoctzWMVygSGRTaelSEO5tA8=
X-Received: by 2002:a05:6402:5203:b0:57c:b3c3:32bb with SMTP id
 4fb4d7f45d1cf-58358b7509cmr118380a12.1.1719391429864; Wed, 26 Jun 2024
 01:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626070037.758538-1-sagi@grimberg.me> <CANn89iLA-0Vo=9b4SSJP=9BhnLOTKz2khdq6TG+tJpey8DpKCg@mail.gmail.com>
 <a1b5edbd-29a4-493d-9aed-4bddfbf95c66@grimberg.me>
In-Reply-To: <a1b5edbd-29a4-493d-9aed-4bddfbf95c66@grimberg.me>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Jun 2024 10:43:38 +0200
Message-ID: <CANn89iJ=Lvs3JR_nKhqD=-URfZBmLDchUysph6dAymb2+umoeA@mail.gmail.com>
Subject: Re: [PATCH net v3] net: allow skb_datagram_iter to be called from any context
To: Sagi Grimberg <sagi@grimberg.me>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 10:23=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> w=
rote:
>
>
>
> On 26/06/2024 10:40, Eric Dumazet wrote:
> > On Wed, Jun 26, 2024 at 9:00=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me=
> wrote:
> >> We only use the mapping in a single context, so kmap_local is sufficie=
nt
> >> and cheaper. Make sure to use skb_frag_foreach_page as skb frags may
> >> contain highmem compound pages and we need to map page by page.
> >>
> >> Reported-by: kernel test robot <oliver.sang@intel.com>
> >> Closes: https://lore.kernel.org/oe-lkp/202406161539.b5ff7b20-oliver.sa=
ng@intel.com
> >> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > Thanks for working on this !
> >
> > A patch targeting net tree would need a Fixes: tag, so that stable
> > teams do not have
> > to do archeological digging to find which trees need this fix.
>
> The BUG complaint was exposed by the reverted patch in net-next.
>
> TBH, its hard to tell when this actually was introduced, could skb_frags
> always
> have contained high-order pages? or was this introduced with the
> introduction
> of skb_copy_datagram_iter? or did it originate in the base implementation=
 it
> was copied from skb_copy_datagram_const_iovec?

OK, I will therefore suggest something like this (even if the older
bug might be exposed
by a more recent patch), to cover all kernels after 5.0

This was the commit adding __skb_datagram_iter(), not the bug.

Fixes: 950fcaecd5cc ("datagram: consolidate datagram copy to iter helpers")

I suspect high-order highmem pages were not used in older kernels anyway.

