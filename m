Return-Path: <netdev+bounces-161980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02F5A24ED5
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 16:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4771A3A4C30
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 15:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7BC1D8A10;
	Sun,  2 Feb 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHtnCroD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314D0182D7
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738511447; cv=none; b=VMLXpnrA4dgFkiON4vZZII71SD2dUzbFGFPHuhvzZjF7Tg7ubJVbjY9yuPiusjl3b/b2esmoJmj+BqEgtax6IZBj92AZS00vkU8HychfnOCmd1Tp0GxVVh4dC7Fm4h3QpsbaPyCHAmdslwYC8PUhHInc5H90t5rnnq4D28L6iSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738511447; c=relaxed/simple;
	bh=2FlktBqIItlRMsNVIoFZhMDgOWGiaAQp2bpCfqyFgQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVoW+T0nGmvOi+nhdtWD/8zDeHrJRVx/iGX8IchCIgEXU/9cKoBHstVvhua6ppcM1j3YuhsEUTOm93HR11ZfzRkXBz+Y99QfM4KCSWORIsVqrXXj9S4tLnDu486vCMQjiZkAEbRDnJcZXZ8ht8zAoRZYnmITheL2fj9dJzj0zVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHtnCroD; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ddcff5a823so26413356d6.0
        for <netdev@vger.kernel.org>; Sun, 02 Feb 2025 07:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738511445; x=1739116245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2FlktBqIItlRMsNVIoFZhMDgOWGiaAQp2bpCfqyFgQ0=;
        b=NHtnCroDJC7lYF9tOI1e4Ng4DTsDKOnTINiL3b2TOmPvJKDAxiGYHPYjDqzPGObExt
         yAn4WweP/Y6ob5KUZxiVG8idgSmSBMY6PrLtMt1NQAchC+P9PRutrGb5/s8A4GQkP6yt
         VM9IMnJoJ9WnSeFFOIVYFmEIXw9ek7BfV3cN/OUKGmNNTVpHCQj22VHESkXmhFUOTIhu
         cWe8OyEgSjOQs1A51ChRq58WmTvBXqpfXkVG0FOXJlt8PIil7C933eONO3dfWqCcom1e
         fpy9g6MUVNpfiZQvw9fXMuOZt58070u7Vusz6AUcfoni1MpDnsmS+YR7X+n/mYYRoCY7
         cSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738511445; x=1739116245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2FlktBqIItlRMsNVIoFZhMDgOWGiaAQp2bpCfqyFgQ0=;
        b=RwYO6gFXsTxR0B6JmIjyVJqZF6adcI0FB7Ks+4nZiREaoD0y8nFvrRJh4XWLy5485Y
         5XdYzUSk/0w3C+v0Uu9gsBPI9oEP++gQg8bTqDdXi2dTwttd2hsixJJTo6KDzkTOqcYB
         +tkoE/mKbg4R8zKqdylTLj2wxHQ2JOM6bMQVGLkiDVonrbnJMrHFU4D7ktGBWMVNTuxD
         AZrJhZghEeQQEv0u8PSnX6hbz61Tm6tJJLwVCNJDGYg7cjLibAOtc5B2/U7iSl7+WrsW
         gTsEmpdUqnkz9Lmv7y8WzeQtWsqBOj1z7Q6b8ubngepgPbZoJPH36KmtaGst233JkPQ7
         3pLA==
X-Forwarded-Encrypted: i=1; AJvYcCVSFfRGXjwg7gGltHuQC3Yysfb9dnHAlnlU8UZZnz4yPE8awA9sqaxGF2IpNNfyAiStSWtUkT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUVfDuXCmPcdbNezMlNayu6vZiH41MjtnPGyBAC7Yjwo58Vkns
	40fWWnuSjB/QjU0hPUMInij3+4Fc6z4SCYpgz1kQNw2pmsqFWOKbwHD8ZsqLEtlxSEBlO6oW2qj
	WFUVwXqIeE/pGz0jTJGFQyiUVlJE=
X-Gm-Gg: ASbGncvhkfKQ+jOOjgs2wmIAaaFAXC0Pzlv6wo738tc6BhowsQWVjKe4SAzLPa4O7A/
	wL2j2/NprB3tPS1mcOStcdceD3CYzxLEs8VuNg5+cwa52fakbKh7TIdrhZ92g3pLC6WwwHWk=
X-Google-Smtp-Source: AGHT+IHiGMQEwhRtko4AXBdno5MhSrHIkrbgdMRT1lpvfgNgFIw4nzm3IcZCeCYNXX7HEZjWT9kZ/lHyOKA2bsq3yOM=
X-Received: by 2002:ad4:5d66:0:b0:6e1:7223:19a8 with SMTP id
 6a1803df08f44-6e243c9492bmr322935606d6.31.1738511444813; Sun, 02 Feb 2025
 07:50:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z54XRR9DE7MIc0Sk@lore-desk> <20250201155009.GA211663@kernel.org>
In-Reply-To: <20250201155009.GA211663@kernel.org>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Sun, 2 Feb 2025 16:50:33 +0100
X-Gm-Features: AWEUYZkz05-oOrLyIPHlblslbnn0hOew45ZN-fgptb2aqXW83T4VZJlBvPZHNi8
Message-ID: <CA+_ehUwFTa2VvfqeTPyedFDWBHj3PeUem=ASMrrh1h3++yLc_A@mail.gmail.com>
Subject: Re: Move airoha in a dedicated folder
To: Simon Horman <horms@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	nbd@nbd.name, sean.wang@mediatek.com, upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"

Il giorno sab 1 feb 2025 alle ore 16:50 Simon Horman
<horms@kernel.org> ha scritto:
>
> On Sat, Feb 01, 2025 at 01:44:53PM +0100, Lorenzo Bianconi wrote:
> > Hi all,
> >
> > Since more features are on the way for airoha_eth driver (support for flowtable
> > hw offloading, 10g phy support, ..), I was wondering if it is neater to move
> > the driver in a dedicated folder (e.g. drivers/net/ethernet/airoha or
> > drivers/net/ethernet/mediatek/airoha) or if you prefer to keep current
> > approach. Thanks.
>
> <2c>
>
> Hi Lorenzo,
>
> There already seem drivers to be drivers under drivers/net/ethernet/mediatek/
> which are built from more than once .c file. So I think it is fine
> to leave Airoha's source there. But, OTOH, I do think it would
> be neater to move it into it's own directory. Which is to say,
> I for one am happy either way.
>
> If you do chose to go for a new directory, I would suggest
> drivers/net/ethernet/mediatek/airoha assuming as it is a Mediatek device.
>

Hi,
may I push for a dedicated Airoha directory? (/net/ethernet/airoha ?)

With new SoC it seems Airoha is progressively detaching from Mediatek.

There are some similarities but for example for the PPE only the logical entry
table is similar but rest of the stuff is handled by a coprocessor
with dedicated
firmware. My big concern is that we will start to bloat the mediatek directory
with very different kind of code.

Putting stuff in ethernet/mediatek/airoha would imply starting to use
format like
#include "../stuff.h" and maybe we would start to import stuff from
mediatek that
should not be used by airoha.

Keeping the 2 thing split might make the similarities even more
evident and easier
to handle as we will have to rework the header to use the generic include/linux.

Hope all of this makes sense, it's really to prevent situation and keep things
organized from the start.

