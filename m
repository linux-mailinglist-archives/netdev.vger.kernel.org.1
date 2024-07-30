Return-Path: <netdev+bounces-114269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7469F941FD1
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 20:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D6CB23748
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B451AA3EA;
	Tue, 30 Jul 2024 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSdHA+uj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73AC1AA3E5;
	Tue, 30 Jul 2024 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364523; cv=none; b=MG6QNK0BE3MTr0UMoSgmPVtufERyW2Itk+zru7n9O5FZrb4j0YT4xESx1UjXqtWxL9DH2YieWOxmpyAdKEN3qxGSDiJMDfVt8z45Z1bCGqDJZNCnHM7Tpw7fxbuLNOgXgWR+G5t3mq8B225CnjK0lSIOXurXYR+b9uWWnfIwv+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364523; c=relaxed/simple;
	bh=a9zVeYZyd9wID53krBAydEjTEwQDpq7/DntshAZDSIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPyXPkgSbIGHZT+nfHcv3JtBr9vCSdaCNyj9PiESCJN+e1TqkXuMOyYUqk3/hD2J+CaW4RcTAnJsmx++t5gyKSBgiNCxCK9kVT1seQ/MPy6PgI4QzAa5tOJjmRJMZ5V2tRO7ffDLfuvGmB/JZHPJkzscWM+Lnu7JQBpuh+3/bbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSdHA+uj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3684407b2deso2375469f8f.1;
        Tue, 30 Jul 2024 11:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722364520; x=1722969320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrUl/QqE0nKjd66nMZZSf0qwwi0vmfglBhqvBDkOk1w=;
        b=dSdHA+ujkGu7p/77M8J//D1ivf5y5hBUhE4POhfn6wL3ktiYfVaBQN4pjpqr0ep04y
         jHYZ0pYhovL+uLy0g+WzjmAG8fJLyPWdia/D4jKNB+GaYVMwbI7MwtBGPvTjgTRXd+kv
         vZ5/BDOlntx7SyfZn4dq+xHidU+PIAgIbe/3lcEzQBI7yC88W4xQsDUmRVNzNNRv1vHI
         LzooPop3eRJ0t7rqvQrP0be3lII2W4G4GYR2fY7GtHP921K0kBBf+PLQqi36uSm0hADv
         kR5MOXjyznt6zzW0W6m/T+iN026b/c/ilIx3iLCQbSLSucGU/r4MsabfM+z1ZGXsDLGF
         XRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364520; x=1722969320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrUl/QqE0nKjd66nMZZSf0qwwi0vmfglBhqvBDkOk1w=;
        b=XnKj6AdIHTmEcKVuFDjSe+8Gez2JTAGVg2ulsbhi1cSWIV0M3+Ew9Xpy9wmyqen+Km
         F7ISeAyBzhvRY11c+IsUUkdTn5VJ/L/xNAymZLy14YspmQj5bl0UddE57m7VZaN1cJtA
         xuxP7wX+7qPYdjmvDIfDs/ZA76dD2FPH8+TAGjheSHYPuSRpu2SM2Gj4zrCquwr8WUnv
         zQ+QF9hsAgfMqIxAR6CLqiKVdlcjaCTKBHwHtuZztPzfqQ0FqDZM5T7gG2i+3rmE/kvZ
         gCORWIuQU9OgQlKWw8rNnGnbxMF+pwty/7qfk22nDfzx3fezEW3s7lc5uwBveKWlvn17
         eN9w==
X-Forwarded-Encrypted: i=1; AJvYcCUk5pBJZvQakTZ9bf6w8UfVfeFW8w1s7n2rpU9xkpQo32lHdQHSAvk7+3xTaoOG0uhmA1ljzrKr2hFdGQLAI97qXCgQ/OeaO6rqsu94ppxi04MTZpA29p0qLit0nuyIacGAL7Xa
X-Gm-Message-State: AOJu0YwaGWYbGuV2HQFYXYItx+zUBRzuG0cjNd1WSW6QXfyl2Dmmlb0J
	+dcIId18fXiJGOwPUcktIDs7lSNAg8zTaL4wfAIGfW0MCXUJK+cVvElGfJfR3rI7MtVgNZ9gruX
	IBzWZRE7B0R4HzQqIgGn1tnYBMBI=
X-Google-Smtp-Source: AGHT+IGUMs3KJS+FkWbup/9qo//aVW8oevFDm36CcNuXhST2ddPZ2LgWixjb4GV1XYV/LixtZssTKYD7kfUBQo+vK48=
X-Received: by 2002:adf:fbcc:0:b0:369:f664:ff4a with SMTP id
 ffacd0b85a97d-36b5d073da8mr8311007f8f.38.1722364519826; Tue, 30 Jul 2024
 11:35:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729183038.1959-1-eladwf@gmail.com> <20240729183038.1959-2-eladwf@gmail.com>
 <ZqirVSHTM42983Qr@LQ3V64L9R2>
In-Reply-To: <ZqirVSHTM42983Qr@LQ3V64L9R2>
From: Elad Yifee <eladwf@gmail.com>
Date: Tue, 30 Jul 2024 21:35:08 +0300
Message-ID: <CA+SN3soUmtYfM_qVQ7L1gHMSLYe2bDm=6U9UwFLvj35odT0Feg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: ethernet: mtk_eth_soc: use prefetch methods
To: Joe Damato <jdamato@fastly.com>, Elad Yifee <eladwf@gmail.com>, Felix Fietkau <nbd@nbd.name>, 
	Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>
Cc: Stefan Roese <sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 11:59=E2=80=AFAM Joe Damato <jdamato@fastly.com> wr=
ote:
>
> Based on the code in mtk_probe, I am guessing that only
> MTK_SOC_MT7628 can DMA to unaligned addresses, because for
> everything else eth->ip_align would be 0.
>
> Is that right?
>
> I am asking because the documentation in
> Documentation/core-api/unaligned-memory-access.rst refers to the
> case you mention, NET_IP_ALIGN =3D 0, suggesting that this is
> intentional for performance reasons on powerpc:
>
>   One notable exception here is powerpc which defines NET_IP_ALIGN to
>   0 because DMA to unaligned addresses can be very expensive and dwarf
>   the cost of unaligned loads.
>
> It goes on to explain that some devices cannot DMA to unaligned
> addresses and I assume that for your driver that is everything which
> is not MTK_SOC_MT7628 ?

I have no explanation for this partial use of 'eth->ip_align', it
could be a mistake
or maybe I'm missing something.
Perhaps Stefan Roese, who wrote this part, has an explanation.
(adding Stefan to CC)

