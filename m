Return-Path: <netdev+bounces-241169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06A4C80EBA
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 15:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F943A21AD
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 14:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B393E30E0E0;
	Mon, 24 Nov 2025 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZh+T7ML"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173FA2DC76F
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763993353; cv=none; b=nGchcoAaryjJP6/88wWbirBg4tsuvYY3/jaNxL5/NzmC0JAOInQR4B9pUTIjXuvIEULWFhIzNbEwrqmkGYV+Hl2pyLhlQZIfAegsdPCKwqkyP7eSp0/q4CkSxAT04Et6t9LYI0vrLWNeqNUGKDzb3/SnwxIknlnjiLhMgDR5zcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763993353; c=relaxed/simple;
	bh=2ubGt4PSnb7HiATYEIATb86xU9b0IGjx1asDg4uc+8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8GMgmNqHZbTjjjn8PDiRQfBtsynKwUGwi3jfAnIvY68WYsRurJR0UH7YlniF3ZK+fJYq1BQLHw+LwOylotzLVhqJGsvUj2gXV7C7W61vK7alb3xWRN/C2qkqi/rzTRdE5HYWmGwim3Xux0jGwpujpppHNwGgxsVNvi8tpKb3/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZh+T7ML; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-640d8b78608so3059094d50.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 06:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763993351; x=1764598151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ubGt4PSnb7HiATYEIATb86xU9b0IGjx1asDg4uc+8w=;
        b=lZh+T7MLGNHh7wCs8fQiK4v3MkiCSgGGQ+2+gVik9JYo9GWxq0PrA2KGSQiFtHoOSQ
         uLp33xqotrzdkGXxmICLYET8UkiuagT8BHHSAkPR8rNQIP147/Qh4KcGzRP+RMKeKw9u
         47UhwXM7o/FYInlrW3l4Vkwwx7Qyn6zw84h+oG5yPSDgtOtBZF/PjG3zji8Akzvpb/ky
         sFjZk0XzD+Q/y1TUrjPFfmRMN1AIZlqwaRof+4Qs5wOGl41xSAE0y1LjU293KokAyrEl
         9T9sp28icA6+I4Wx1A+GzI2SOhlN+1dIBXWMSGLciGfjHaJKm49LaDQpaereaODnSPVK
         0TyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763993351; x=1764598151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ubGt4PSnb7HiATYEIATb86xU9b0IGjx1asDg4uc+8w=;
        b=c2rBSsFocILCRUKk0OIpKsx7J9nHN7EZrdSEBLYw7Z+SOJB0/oo5uaYVz4Vpz7Og4w
         e8hYdxPOqw/rdmetRfFj3yFFp0J4JMcEudrrYTlgDeKbOjJGQtCkvwfsvnovK2G562si
         FxR0ogBRnbvIhMOVei8zjofiscXWWevZkx5WmHgZREgda0CXp2LsVsZHJrMwl46pAeTd
         pWw+wYZ1uJKnx6vyn7g80rHm5ihXZm9ZYP9HMxTRXgh4IqTZLU0aPQdqSnCUsjJnq8lc
         wB3Q5uJmiRJjXE5rku1MStlX+k26FUrgDjQpqtaUYHpO5qX91a87VinwlZ7RhPdInHiA
         OdUQ==
X-Gm-Message-State: AOJu0YwAQZeQG+ALbOWUDJ7z14BPawztmAooPlXNa69AaqEGKjw0czat
	aojvxkBaGRZxVBehshNUS+0L/39fTjoavH3SWUL5JCmuejJ5BSsS8mgPUCwPVXsZRGFNp8126fS
	MlC8P3Vd6qAh88h+kEprR5x7nEtBXyww=
X-Gm-Gg: ASbGncuUjB99ERwszqeAUIhRureCNa1Zv1PkzAoGQrMdDSWP0huDVMYq5WJsvXhkeng
	O+iikrKCboN4Y3t+nSrHEwRfYWF+vkqzl65k/7q9r99wIggXsPBzdi3mzBMLwfRqf+cCZQ3l84y
	qN0DDe80HIqmkm9Zs4sRsjZ7+2SynL1Z3zgfYCGXVbxIlCaRiWfkgFn45ZqymbmzUivblWdD+xF
	ZsdjZCcWpj/oEG435kGyf9BIe2xVg1akn1vf0IBbX0hlvc691027NlgmeeCwdSxl3Rp7NH+h7KA
	K5/oddE=
X-Google-Smtp-Source: AGHT+IFmzfNqf1hrJ4xNsn7KTVDhoVIsvY/BUNksR6ZH5oS4CQsP+6UI6CF4Avd1UVzrsq+SeFKtF82KGx0DpRkZyEg=
X-Received: by 2002:a05:690e:408c:b0:63f:ac1c:a375 with SMTP id
 956f58d0204a3-64302a48552mr8521088d50.25.1763993351030; Mon, 24 Nov 2025
 06:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118070402.56150-1-jiefeng.z.zhang@gmail.com>
 <20251118122430.65cc5738@kernel.org> <CADEc0q4sEACJY03CYxOWPPvPrB=n7==2KqHz57AY+CR6gSJjAw@mail.gmail.com>
 <20251119190333.398954bf@kernel.org> <CADEc0q5unWeMYznB_gJEUSRTy1HyCZO_8aNHhVpKPy9k0-j8Qg@mail.gmail.com>
 <CADEc0q53dNkcfk+0ZKMRrqX99OfB-KonrZ8eO2r1EC-KLkfXgA@mail.gmail.com> <20251121180152.562f3361@kernel.org>
In-Reply-To: <20251121180152.562f3361@kernel.org>
From: Jiefeng <jiefeng.z.zhang@gmail.com>
Date: Mon, 24 Nov 2025 22:08:59 +0800
X-Gm-Features: AWmQ_bn2iH2YbfHebtVx7PbaZkrTHtBfJcxCO7B7IwajkuUJqGSjTgxXPe3UZrk
Message-ID: <CADEc0q4nyCeQ=PxGksEDn1dwKxTxC_=hu654PgfkNTDmi+zOXQ@mail.gmail.com>
Subject: Re: [PATCH net] net: atlantic: fix fragment overflow handling in RX path
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, edumazet@google.com, linux-kernel@vger.kernel.org, 
	irusskikh@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 10:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sat, 22 Nov 2025 09:36:29 +0800 Jiefeng wrote:
> > > Thank you for the feedback! I've updated the patch to v2 based on you=
r
> > > suggestion to skip extracting the zeroth fragment when frag_cnt =3D=
=3D
> > > MAX_SKB_FRAGS.
> > > This approach is simpler and aligns with your comment that extracting=
 the
> > > zeroth fragment is just a performance optimization, not necessary for
> > > correctness.
> > >
> > > I've also included the stack trace from production (without timestamp=
s) in
> > > the commit message:
> > >
> > > The fix adds a check to skip extracting the zeroth fragment when
> > > frag_cnt =3D=3D MAX_SKB_FRAGS, preventing the fragment overflow.
> > >
> > > Please review the v2 patch.
> >
> > Hi, I've reconsidered the two approaches and I
> > think fixing the existing check (assuming there will be an extra frag i=
f
> > buff->len > AQ_CFG_RX_HDR_SIZE) makes more sense. This approach:
> >
> > 1. Prevents the overflow earlier in the code path
> > 2. Ensures data completeness (all fragments are accounted for)
> > 3. Avoids potential data loss from skipping the zeroth fragment
> >
> > If you agree, I'll submit a v3 patch based on this approach. The fix
> > will modify the existing check to include the potential zeroth
> > fragment in the fragment count calculation.
> >
> > Please let me know if this approach is acceptable.
>
> Right, v2 is not correct. You'd need to calculate hdr_len earlier,
> already taking into account whether there is space for the zeroth
> frag. And if not - you can just allocate napi_alloc_skb() with enough
> space, and copy the full buf. This would avoid the data loss.

Thank you for your feedback! Based on your first suggestion to "fix the
existing check (assume there will be an extra frag if buff->len >
AQ_CFG_RX_HDR_SIZE)", I've implemented the changes and submitted the v3
version of the patch.

The v3 patch is ready for review. Please let me know if you have any
suggestions for improvement.

Thank you!

