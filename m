Return-Path: <netdev+bounces-238503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD304C5A06C
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 21:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 667A9344FAE
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 20:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F4C3218A6;
	Thu, 13 Nov 2025 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWNof0G7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B4C2FC875
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763067398; cv=none; b=jVcAA9c8h0WMXSRiHJxb3Hl1mwYFbybhhaKhje6AE7cpHdYxBVQ2CSLdbjOk4MoV7mDrhn7HEMm4BERuLZemzg0BsEzV60OLX6xy2v/1RR4vbMOzElWappjXLqrIYIyqdI1yujyaamhtU88Nrf732E3aAZpTg/ZvBQ9SgEIShIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763067398; c=relaxed/simple;
	bh=xcx51CpZDC2fkjH4LJIQFa9yOLzN8e25KFGSYzDpG1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stUsqAkPyEg7Um46jiGe38CzgEfxKvnOfAfLJwXd/jVadD+GzFvbOWCiteNZlw+yCbw4+r63AyY/66SU40wrPlMWFVFHLUib8HkhGzzJBUEE6iRVH1S9I8P8Ufh26Cv7oBvtHm9ndW3uN1rcsWhUncifHH5O8pZoNgt5zuV3ihQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWNof0G7; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5de0c1fa660so437662137.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 12:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763067396; x=1763672196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fE6wkTka36l+WuIbH6rtyhnrc4czYANuD5KWow4y1eY=;
        b=PWNof0G7520PnJBc9SLS9M4LZwwtleoViibd/qNGRIjkF88VkCpTkp0aF/G0EhRIBG
         jCpUEKpeZVJ5/oUlS0tnkBtRxYEXHeH9mu4WCXv6Y4Zm2sBsw3ieCRXxv8E4LdCwrAwZ
         ky4YP0nSxw36pN3CoKpA+Pl93jz0PlSkHQjQhPa7nR0MqAzO+JdaNDGvDeiFb9rq/anV
         3j12fp0IWezn1a9bD9SYBSros2to+Hq8JqrKZMBaGX6LyU2W+eDi+pOhOoUvyhTDXyPQ
         8WF+tyEc4ffkvrNLM6UXlCOs1kVJXffKRmQ6Tmd5ndfVtgcgpzNIy+/ldb/rR1r5fpao
         6/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763067396; x=1763672196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fE6wkTka36l+WuIbH6rtyhnrc4czYANuD5KWow4y1eY=;
        b=RTuvePn956H1O3j+NXar2IsIkN2R8Vfd2c9CXbN1YY+3V270iOIKAtwy+qbQrL0KMU
         TDG/FIabWMp68PQdf5Qamm8ESuJytbqch2T0hTku3uGfe7ELi573VJSg7EJKW5ZYuL8H
         Mi2k5higAzxFGeTE8isbkSruGfsH/rs5nBYbyCYRhR1wL666DMMRByTd2SEwwuzRgIox
         j0VXB94KPF9N5PwmBwvhcZ3/Wy0WeCFNF4y/+IUwzMyWxhqzZkvJUMh3j3q475cAPLog
         0QxN8t5rV9ZvzeY9ln2vukVsw5xbLmihR+hgW/DYh9gXnNAi/O39M4nrwX6OC1U71ZQA
         WKzg==
X-Forwarded-Encrypted: i=1; AJvYcCUZjFpF4IGlqUbYTn6yu5vARHPcrgbKcKaVjsmiqqWNKKFJzzPzWhRBGUjt1t+P5+GjYiT5DQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3qt9QWsFUyocBJPycOJAvXTJakJVjwJKNt9gJh5QfnsBDLmd5
	8RKZ6D9q06Plk3B1dy0Tvqv8EsMvkSvkX9/68Ldma/3iwDLgOlNg3TGRW62Mgd9SRtC4rjp2/ZA
	FegE6uJ5xq1dFTRofyfQrSdd2m3iV8x0=
X-Gm-Gg: ASbGnctrAU99MLChEvUc2Gczq0tlPRJWOwkJ3LGSBDYpFKLwTSQQrZi1GkybutFzfO2
	byJsO4i+bGmXKJInSo+fCZ9cHfQ2PhE3K8gGxD6wo6YCwtK26WXm/oWn2F8ZMXZgVlKmRoHrYZn
	TaOo0idpbfDHOjPxgePsbvq/07sAZKOYBVtweDAMHaT0Q8Ni19wWTQ0jCEDdAD8jHbCWoq0c+w4
	8sqZj9fQAltQZ5UTORk3roA+MRL8uNJMoVfpfn02MAFoOnxE8DiYRaYwcUs7GAW8Rr5y1kQo2/c
	cdWlhQJZHmsi
X-Google-Smtp-Source: AGHT+IEuYuAEqPYTSWSN+h426W33ZgMvr8eWHUjqHTxueXAXxSuhXsQmmawhbdxIne3/JUPA9fdkujcoOKj+toV5PfU=
X-Received: by 2002:a05:6102:5808:b0:5dd:b288:e780 with SMTP id
 ada2fe7eead31-5dfc533e040mr691137137.0.1763067396190; Thu, 13 Nov 2025
 12:56:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113092606.91406-1-scott_mitchell@apple.com>
 <CANn89iJAH0-6FiK-wnA=WUS8ddyQ-q2e7vfK=7-Yrqgi_HrXAQ@mail.gmail.com> <20251113194029.5d4cf9d7@pumpkin>
In-Reply-To: <20251113194029.5d4cf9d7@pumpkin>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Thu, 13 Nov 2025 12:56:25 -0800
X-Gm-Features: AWmQ_bm47bkPDEkq2SO3eRLRbarp-giqb4Vz8j4DJ-oKOw0iNgI_m1DRXDEzE84
Message-ID: <CAFn2buD7QWb42nVaG8yMhEA6+6VtTndk61E+_tZvydLm0Gs3qg@mail.gmail.com>
Subject: Re: [PATCH v2] netfilter: nfnetlink_queue: optimize verdict lookup
 with hash table
To: David Laight <david.laight.linux@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, pablo@netfilter.org, kadlec@netfilter.org, 
	fw@strlen.de, phil@nwl.cc, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Scott Mitchell <scott_mitchell@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:40=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu, 13 Nov 2025 02:25:24 -0800
> Eric Dumazet <edumazet@google.com> wrote:
>
> > On Thu, Nov 13, 2025 at 1:26=E2=80=AFAM Scott Mitchell <scott.k.mitch1@=
gmail.com> wrote:
> ....
> > I do not think this is an efficient hash function.
> >
> > queue->id_sequence is monotonically increasing (controlled by the
> > kernel : __nfqnl_enqueue_packet(), not user space).
>
> If id_sequence is allocated by the kernel, is there any requirement
> that the values be sequential rather than just unique?

I will defer to maintainers for the authoritative answer, but
NFQNL_MSG_VERDICT_BATCH API semantics rely on sequential IDs
(nfqnl_recv_verdict_batch applies same verdict to all IDs <=3D max id).
New options could be added to opt-in to different ID generation
behavior (e.g. user acknowledging NFQNL_MSG_VERDICT_BATCH isn't used),
but not clear this would always be beneficial as "unique for all
packets" depends on size of map relative to number of un-verdicted
packets. Packets can be verdicted out-of-order which would require
additional tracking/searching to get "next unused ID".

>
> If they don't need to be sequential then the kernel can pick an 'id' valu=
e
> such that 'id & mask' is unique for all 'live' id values.
> Then the hash becomes 'perfect' and degenerates into a simple array looku=
p.
> Just needs a bit of housekeeping...
>
>         David

