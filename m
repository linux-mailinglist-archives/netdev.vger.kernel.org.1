Return-Path: <netdev+bounces-168086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC3AA3D4FF
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B29A189C0A1
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04D21F03C8;
	Thu, 20 Feb 2025 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IgTvZ7sl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C181B87EE
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044532; cv=none; b=ES+ZmcM1MyKdL097ATlOZ1WZDpr0PLwbX9aPPQ5wloixJSmOIVryCWShUqridtcyKVseslhrMXN0wDSpKrdCnBS0lzTYIY2nWP52Q0gezGZ9BZ/3BVQ4YovyPwyyu9GHmURmPWsKHmsHEPUm+zO2KZ71GzjvzFXv148EruLtrEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044532; c=relaxed/simple;
	bh=kGOp7r7qaO9d5n2ynJ6o5uKVD5/JNQGcQFcsPgTpCjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfF2McCOa60FXU3NmQpILcCN3vxd0HuytHw3jHWqu0F5f6VWj0KB1sj8Oaf8uM9oRhGb636xKnKlvWP7QaGJ3TUrpPsFv19uWKL5QihOzMHBg1lZNU/vB7ZMKOIJpgW+oWQtzNWw8sUNedhcLkTAbVAShrjNgi7iu6C0x+0q9gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IgTvZ7sl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e0452f859cso1065992a12.2
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 01:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740044529; x=1740649329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGOp7r7qaO9d5n2ynJ6o5uKVD5/JNQGcQFcsPgTpCjE=;
        b=IgTvZ7slMmbyivB9kiSWuq49cCQHzcXstSOflhkvBBUQ8rK+r83g42ZHck6ugFWOwK
         VNSdKlCIl0yknLyU94F3eHlwTq0ji4U70Qf+eL813bmo8lCcO0t4okej8a51SoqNPTIa
         YTu7M++g50G1skj7ie7AupveYtiynTcm1dmuExz2GM8IjLMFJ1Cvwm0UzoPx4E4bmUuO
         jLaCD83Aze/CVXg+UyBae4SNn3cBxF/fjU7o1/kHnuuYLq9uxuC50NZg7lojNx4HJDp/
         NhjccnURyz3ZtPTv8F/ox73zKB9EhtJ1PQtTcfZ7w3oNYNolvvcvFjlNPkrwzhWgVDvZ
         hozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740044529; x=1740649329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGOp7r7qaO9d5n2ynJ6o5uKVD5/JNQGcQFcsPgTpCjE=;
        b=R0GVEMo/uPxZ2sLsJ+r2m4KWKUcP1CkkrmdSmcOufaDr5fqbIursftpyBI39SnPHgS
         Kvi75my7mSOT3cnSGLzg2y89cftBid+gQd7h6lqtnVVIpLpGOQZcRIobI0OwF6k0KKDI
         mnwztkI7sWx316t21BDTQdIjUSN6705oPz/9L79lr1CFovQF7wI3+QKBwt2KEDdx2ZUL
         Pv5C7FxoRxAeO/g3qaqYjdHEJV89fnq33jteVY0qjF7IQhTPOH/gcKaC1E8GdxKn4Qw/
         ey2jTEqdfwao040Za8n0QcRoTJ5bdKYZ+c5bjmXtzHAMrgmhF3lkIEgWFpeYdUu77dzS
         ZCqg==
X-Gm-Message-State: AOJu0YxTxUR4MODO62mXR/oP9OswrMUkbsZ1rgxShJBmjfjFA6ohKP2y
	XlTuPnM/qaEInPzxkesK1qtPV9rQIqso/+w3Cg3acvwgx1kJAesivaPL/YCBr/NHxrSQgwWI3eq
	MEfplTzSqm5DRY4SBiT+DIQnvC6C/673YIYdL
X-Gm-Gg: ASbGnctzUo9D2bwIrhgtA0DCfSFi/ZuwA4QFUHAig3nYsw2GqCoewt7PSpqeBvY6Tje
	4+N8JNBVbHISCh1mlc5uYj5Y5Itwa4CrFZ/u1Ui/m1n6R8CrKOy0kUJ8PQyuvQqNwkbZX9dk++g
	kNTFsIrPB5nsXnBvp3rFHQnG21EWTVDQ==
X-Google-Smtp-Source: AGHT+IECVPV5JkVsZniYUc/jrbCqi/190XB3I72JqU8u2iNfB1b6JYpnI6vTbP3JzN1hdNJIXxt3RB6TzXJU84CFnw8=
X-Received: by 2002:a05:6402:1ec8:b0:5de:5718:296 with SMTP id
 4fb4d7f45d1cf-5e089522ff8mr6196623a12.13.1740044528906; Thu, 20 Feb 2025
 01:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739899357.git.pabeni@redhat.com> <fc3a8b034ba2a0ce03c5d0f93cc033a8c66821ad.1739899357.git.pabeni@redhat.com>
In-Reply-To: <fc3a8b034ba2a0ce03c5d0f93cc033a8c66821ad.1739899357.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Feb 2025 10:41:57 +0100
X-Gm-Features: AWEUYZnIy6YuDMOxrDbbJnEWJHB6DG0r5fRU4G_Cx3l_L1gpI4RTUEL8dBLB1Dw
Message-ID: <CANn89iLVy7d8m0KAEHprhv2y2QjdLcYAHCZxYmg8RbyiZEYvZA@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/2] Revert "net: skb: introduce and use a single
 page frag cache"
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Alexander Duyck <alexanderduyck@fb.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 7:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> After the previous commit is finally safe to revert commit dbae2b062824
> ("net: skb: introduce and use a single page frag cache"): do it here.
>
> The intended goal of such change was to counter a performance regression
> introduced by commit 3226b158e67c ("net: avoid 32 x truesize
> under-estimation for tiny skbs").
>
> Unfortunately, the blamed commit introduces another regression for the
> virtio_net driver. Such a driver calls napi_alloc_skb() with a tiny
> size, so that the whole head frag could fit a 512-byte block.
>
> The single page frag cache uses a 1K fragment for such allocation, and
> the additional overhead, under small UDP packets flood, makes the page
> allocator a bottleneck.
>
> Thanks to commit bf9f1baa279f ("net: add dedicated kmem_cache for
> typical/small skb->head"), this revert does not re-introduce the
> original regression. Actually, in the relevant test on top of this
> revert, I measure a small but noticeable positive delta, just above
> noise level.
>
> The revert itself required some additional mangling due to recent updates
> in the affected code.
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Fixes: dbae2b062824 ("net: skb: introduce and use a single page frag cach=
e")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

