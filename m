Return-Path: <netdev+bounces-126608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D519B972050
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825301F24423
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4126C170853;
	Mon,  9 Sep 2024 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N1Tyz1gs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D2B16DC3C
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902460; cv=none; b=iq+v+vNE+13Z2gl6o42cSLINdOp50QQrrF41L+fs+G4qDkss4uK88hRylD60D42k4eTCs5KsSkI2SYZ3Hhjg+0GVFUAeejMsAiVaTd61tuHZzbIyIkmbdNlFY2K7cTH3P9ZNmdo0R5ENuMKycCs9wwD/rBpGuCj41M9gdBjDZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902460; c=relaxed/simple;
	bh=CFGndf6+Xj/OcozYle3EJLLaDe3XNlSVsUPxx6tiLjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjdvAY45g6AdElp3xWw+mu/rbPa9g/aPjcLFhtdz3vBK3an5BaMc+V4CciYr1LOZRYeZcFKhswO9DzbTMVPxf4Dt7ptzYV2brT7x9bdqeOL9d3KaxE7OjeXH5e1GdlVaQiFE/MfSf76cTw+wg0ak0v4mj4+y4P8/6J1bX4iJmzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N1Tyz1gs; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so4800815a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 10:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725902457; x=1726507257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFGndf6+Xj/OcozYle3EJLLaDe3XNlSVsUPxx6tiLjI=;
        b=N1Tyz1gsYTR+RD4N6oP9E3fWeqETO/xWc6Sn1arnbuAL2Z8uvvJ5sfTOcnldIoDLS7
         jCuqpm4dCm6ejuR+JPLUyKP0JB7Ano9juJeTkBxOZYFGQGDxEdFoZXHH1Fahb4248RRL
         wB4CKHtrAmffSSe3KFjgdyo251RqCEqMS2k/h+9+b1MHskLjpeiGaN2f+fRd3e+xJDNs
         Z0UIUMpQBf+yVigkQ1JagBdRqdX8YG3mYNrmm2U6nhCdUcgfZB491jLcf0SOl67O4Rr+
         kgKy+s3aToc6cAHh8LO8OVSwUAP9V5w31+m/x2WNj3rxHLKZVGiY8RWeFYvnc5YyhtyY
         LJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725902457; x=1726507257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFGndf6+Xj/OcozYle3EJLLaDe3XNlSVsUPxx6tiLjI=;
        b=KUIdPHvSiw91tdSpyF6eFpy8yqRZNLf1Ge80+uPLTbUpcXICbujJWqQR8QdHtj1E51
         zJV7gk1r8P0iz+rUYYFsZyCYzCp6gRuBl+7qQOCGfKT7xRwXx28/LzsmI4NpRaqEXvPo
         zjJ9LUJ36ULsUEsyxPtIELXOXXqEaRXJrweyIrJvkG/j+n9n9cpc3Ag8GGdVny9upvkX
         hrdiDoX8N1knhYq5VpGmAfFA1vRJ0Hph6pVUdP87byCREPEg/cycIfUYPozDZiLSi1go
         AGTDY5k6+qIQutAdf5kOuq8NJJuGTd8wiL1lpyCS07AmyL7l2kdAbcijzuuuaZv5W0vg
         rpPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI/pFN141jTBmsoCb2H194wv77KL4JcmCCvTW2vPDG4+xf79VqFzANndzA8b6MQ+2PvyF3yH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlCC187uNc8GyDm/OHiEWrtkjEprij4q8AC76STseVLViKF3RG
	qEti4l/i9eL75uW5E+Fj22TzJS4TK72cKolD6NJDLVnOqw6GbO+scJ50wsId6O1nH0Fca7Rdlrl
	gkm3yle/eau1q12AxHZpnY8hdAoNx4QUzLSco
X-Google-Smtp-Source: AGHT+IHEMkXRi8Qojfd5ZuTkY9ul6MC80RogKg7lfulxwokHMBECv3XZL6XRA4yYXJEOQGWoOekFvGU/bnyKPClSXW4=
X-Received: by 2002:a17:907:1c23:b0:a8d:2e3a:5303 with SMTP id
 a640c23a62f3a-a8d2e3a54c6mr540762566b.39.1725902456088; Mon, 09 Sep 2024
 10:20:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905173422.1565480-1-shakeel.butt@linux.dev>
 <CAJD7tkbWLYG7-G9G7MNkcA98gmGDHd3DgS38uF6r5o60H293rQ@mail.gmail.com>
 <qk3437v2as6pz2zxu4uaniqfhpxqd3qzop52zkbxwbnzgssi5v@br2hglnirrgx>
 <572688a7-8719-4f94-a5cd-e726486c757d@suse.cz> <CAJD7tkZ+PYqvq6oUHtrtq1JE670A+kUBcOAbtRVudp1JBPkCwA@mail.gmail.com>
 <e7ec0800-f551-4b32-ad26-f625f88962f1@suse.cz> <CAJD7tkZNGETjvuA97=PGy-MfmF--n6GdSfOCHboScP+wN1gTag@mail.gmail.com>
 <bda30291-ab04-4b72-89c1-b4cb4373cfce@suse.cz>
In-Reply-To: <bda30291-ab04-4b72-89c1-b4cb4373cfce@suse.cz>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 9 Sep 2024 10:20:18 -0700
Message-ID: <CAJD7tkZpbS-ArHC16sfysKcWjM0BwQCuNoKAQhRoPA-OV5Mv1A@mail.gmail.com>
Subject: Re: [PATCH v4] memcg: add charging of already allocated slab objects
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 12:59=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 9/6/24 19:38, Yosry Ahmed wrote:
> >> But in case of kmalloc() the allocation must have been still attempted=
 with
> >> __GFP_ACCOUNT so a kmalloc-cg cache is used even if the charging fails=
.
> >
> > It is still possible that the initial allocation did not have
> > __GFP_ACCOUNT, but not from a KMALLOC_NORMAL cache (e.g. KMALLOC_DMA
> > or KMALLOC_RECLAIM). In this case kmem_cache_charge() should still
> > work, right?
>
> Yeah it would work, but that's rather a corner case implementation detail=
 so
> it's better to just require __GFP_ACCOUNT for kmalloc() in the comment.

Fair enough, thanks!

