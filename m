Return-Path: <netdev+bounces-114798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D67F944217
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 05:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A8B283A42
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 03:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841C213E02D;
	Thu,  1 Aug 2024 03:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMIR2LZl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDEA13D285;
	Thu,  1 Aug 2024 03:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722484417; cv=none; b=NXKK3V1bHEoayZ8qgZqznmO/ZX0syuSee9FZH2ofZ/EbNPNyWeFwrCcIYYVHk7t7269BKWa/47qAxUG3af+69TNlYrIr2BpT3Q2ghOaK8L/YQeemJdPBv/UIbkZuJFwnkR50V+IDbqsTCaR7WJ0AgPJRf5ByTAUHhgosRXLcPdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722484417; c=relaxed/simple;
	bh=TlyRKcLPmQI/GuMlXIqsUsFwwg15w/4JZugy36RWLbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjQ9fZ93dhu+6yIkiBfKYEXtMschtIt27xI8hF0zlBQ9Hb/U52mRopGmDQ0qIB26YBf2FIEhMBBJW4A5GAydYxVNtMVIUS5avUZLjmcXUvHxJhr1m3ozwjka6W7kcX0yaGIjmGMVF/J2Ljvx2u4A3OyQ7brSOrAf1ibFNYSYrVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMIR2LZl; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3685b3dbcdcso3596042f8f.3;
        Wed, 31 Jul 2024 20:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722484414; x=1723089214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlyRKcLPmQI/GuMlXIqsUsFwwg15w/4JZugy36RWLbA=;
        b=KMIR2LZlqRD+1tSFXpnKVrTPDxZiRdo5VDDjI3PBuiXltMZe1yLNYosI9snNpy/JXu
         DMCyCY0P0FSevhgC3JFvcgCGRjOFDkE3V4Qm8ZnTA1spsC0vOO6TqdpWWKKfOJTkdsy3
         89Ja1/fg4uLsqDnBq0OlrB0aXMfp5T+gfGw5N9srJSPnlYDiCIuXRo0kIoJ7V9ixsytt
         /2uMABo3c4vkvZ08YxfIgnLc5Ee/0O9wC511DKBWnGbYuvRChPD+x8bZzims0+nDtOUf
         ncq+Tw3XzYrhkCIwNtrcK74+zucch/3Uue5NVuLo8vC970FpaB8N68wl6qQvvLpzykGc
         MxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722484414; x=1723089214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlyRKcLPmQI/GuMlXIqsUsFwwg15w/4JZugy36RWLbA=;
        b=KwmxAptxgPYAGJGn/9rHqYvp5f+p3/jPMtircU4f43k+DK+vXB5t1zkBHLlXcCI82v
         6ywdjmVpNx35geD54IQbtt95blOi2ZtcYxOszfE+12iTHjXCC0voL8VNJ2R/gV/J5gwO
         LHfbDeZR64wPMg27AV+HK2WeZJ0hRutq4KlKrUJ0ubHa8JbnYTdZe+Geg1B/BdscdNJx
         4un4n2x+JRoogIlAj1Ug+yCS3zFeKC9GSXNmcvfkfP11T01UVYDtiwfNaq5+ZKO+czCP
         jxgXBL63QYKNMalgryAGYDdlKNTE6no6ru4dvLrrDMMNSE1e62bb3uQRqcSIfEJksq3R
         vTEw==
X-Forwarded-Encrypted: i=1; AJvYcCUqggAR3ldn/OdPFZMGhmBhFaOZvA3cuq5sdP8Wp1TnlWeTwKZIIgvYsYRNxUlG2khf3xonQifrraae4VaMWD+XGeBU3dB+OoDsuxJOEvIGmXU/zi7i2s1UNpjqQSC2gIdiOlYt
X-Gm-Message-State: AOJu0Yx/77AvsgyVPS4fm9utHYiUB+gddUsM7sne6HtAbk8Joh328vkX
	AGzhPKFcvk/1R+dqTA4kTE2mDLWzEqJQmJxENtYUT/QX/wj9AbnDPau15aTOYm149Q4TRAUVK+T
	RU4sHOgwIPxLKTYdN6GmLqu0ulUk=
X-Google-Smtp-Source: AGHT+IEs0THMbA0sF4obneu0+dmcKI40YGhrl7j05k/acZ3+a8Pia7WokWkm4hxOH6DCTgtLunHntz23diVKez52CcY=
X-Received: by 2002:a05:6000:cca:b0:367:89fd:1e06 with SMTP id
 ffacd0b85a97d-36baaddd1admr769970f8f.36.1722484413831; Wed, 31 Jul 2024
 20:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729183038.1959-1-eladwf@gmail.com> <ZqfpGVhBe3zt0x-K@lore-desk>
 <CA+SN3soFwyPs2YhvY+x33B6WsHHahu6hbKM-0TpdkquJwzD7Gw@mail.gmail.com> <20240731183718.1278048e@kernel.org>
In-Reply-To: <20240731183718.1278048e@kernel.org>
From: Elad Yifee <eladwf@gmail.com>
Date: Thu, 1 Aug 2024 06:53:22 +0300
Message-ID: <CA+SN3srMPLcmQ4h_iNst71OkQPFcCYxBRL0Q9hR=7LjJ86TFFA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] net: ethernet: mtk_eth_soc: improve RX performance
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>, 
	Joe Damato <jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 4:37=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 30 Jul 2024 08:29:58 +0300 Elad Yifee wrote:
> > Since it's probably the reason for the performance hit,
> > allocating full pages every time, I think your suggestion would improve=
 the
> > performance and probably match it with the napi_alloc_frag path.
> > I'll give it a try when I have time.
>
> This is a better direction than disabling PP.
> Feel free to repost patch 1 separately.
> --
> pw-bot: cr
In this driver, the existence of PP is the condition to execute all
XDP-related operations which aren't necessary
on this hot path, so we anyway wouldn't want that. on XDP program
setup the rings are reallocated and the PP
would be created.
Other than that, for HWLRO we need contiguous pages of different order
than the PP, so the creation of PP
basically prevents the use of HWLRO.
So we solve this LRO problem and get a performance boost with this
simple change.

Lorenzo's suggestion would probably improve the performance of the XDP
path and we should try that nonetheless.

