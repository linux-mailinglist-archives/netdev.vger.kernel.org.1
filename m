Return-Path: <netdev+bounces-101264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A4E8FDE66
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 07:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B35C1C23EFC
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 05:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8C03A1A8;
	Thu,  6 Jun 2024 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgC91G2C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5C628376;
	Thu,  6 Jun 2024 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717653423; cv=none; b=nDotJJ6jDf7GNhMpfjM78aJbE22mJC5jYyggDs8mSWsr9FLcJjlg3RhMXHEJWUZZR50sGMwjnsi1StrrIVzNzAgW9e4dlIu+jytwKfVxoUplS5ba0xk5kpr2OqI8jkKBCYI8zGIoxL+UK+/w3BJDZRMo5WL9eLq1knLLYvJkizk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717653423; c=relaxed/simple;
	bh=/t3HMt63rItxc4gjrIQ2pDjEkGz9nwhITQHO3zrMkGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGiBSfVI1V3FyldkGzOb83U0EEROhMyZQpEeZxWJX2h2fbHfu0yfgJdYdAIFe1FtSQ9NdI96sxVbmUdGkilsCzbnZfS7fFnyLmEsXxClzlnOyke7NUAPh3pJ71V79cOPVXo+ITh7qzhAzzaV+5y6aUVcIyFWYeJ5IoLBCpt+Ffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgC91G2C; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35e573c0334so951701f8f.1;
        Wed, 05 Jun 2024 22:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717653420; x=1718258220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67dVbFD/2DQF9usMWt43fKDwppvEBt20ndKl7bU0GFw=;
        b=lgC91G2Cg7YWV9X2MYIWinhCJPCYTebabnCpiFaWxkcGDO7midUsv2j/UO4AFzvUIq
         5DuOVGGPxjwEtCSubpqbP4mr6naoCe8zspeVaaeL6Sqdk3J1n63ITapFKBQZ8V1RLHwZ
         2sJuPmH95VcOHfNcCjDYKTOrG/H4XrXx9DIYqLQgB5lta9DSee5ijcf1aOIkbAAH7oVj
         /CfZLD3gSRM7w8BH6gB9iSjrdZAfrlwESoP5KvJUvntmKA4gSJCFOKMPEOw+M5IOnwCT
         GN4MGnw1wqa3S6jslYczIoD2BEb1zL7fkAzaRcJF62Dr0Md4gVvKMmmqmVSTfvPmtp25
         8SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717653420; x=1718258220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67dVbFD/2DQF9usMWt43fKDwppvEBt20ndKl7bU0GFw=;
        b=DD0mGrYk722cDaSzOSAwO1n7+Ywhxolt+7uOHvRFWFHY2LYZmntLtmqNqrLoIIm+XS
         zN9ggZ3/h/HzWVy+UXcHAvaFs7awPkXx/Efv+42t6CPyguIZWJCjdxE/fQ1b8cOj7uZb
         ArOEe4tbQ7H6kx6HUkoKCpp7zRF3u7yq3EM/CximEKi7SN7pCn6+oSi6AaArIGSjgSo+
         nY3+77vmYqDqeAbAJrfK9RLvpi+CfKMyPv6tPrSu1HhAmrypLYrPmlRnKBN0b9Nz2ffJ
         I1hLvnPkEq2mlyvuSJr/XyvpaJPjxO4KQNSHpfyWJdSETJhF9j43fReFrR6UlnrIlIJk
         mxmw==
X-Forwarded-Encrypted: i=1; AJvYcCVqtZUqPkA0RhnbMAUI23CKXtwBAarqqIgIhAQq/sqhHDozxhjugVdSKvHjQxx0X4KvBpQD2NyIDypsHgaegkI9lYMzNFUw2Ig0ELKZxi/KI+EJT5V/jn3D42IFEW9lO+ckrO2o
X-Gm-Message-State: AOJu0YzncbuPzLcE9zwiEewbY/cSrP3krrEXOY63aAqAIWK2bJVoT72+
	Me7M7KKzBQ8l3KSLQj+vGeOodauLunUxgIHfvJjtcWn2O4uAwDzdhODWgpqkmx76eA52jJTqupD
	k0lhRLbd/ZGSo3jY8JYtOdDDjbeU=
X-Google-Smtp-Source: AGHT+IFZepq3sEeQBCy5kZ48sBUfqe66PfQjpcYWZc5zSawvex/dg7mlw4aaY3fS0I9FAoKhuEtTLa3Rp4N1ejUG898=
X-Received: by 2002:a5d:58ce:0:b0:35e:61b9:3037 with SMTP id
 ffacd0b85a97d-35ef0c7281amr1250796f8f.7.1717653420153; Wed, 05 Jun 2024
 22:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602173247.12651-1-eladwf@gmail.com> <20240605194305.194286d8@kernel.org>
In-Reply-To: <20240605194305.194286d8@kernel.org>
From: Elad Yifee <eladwf@gmail.com>
Date: Thu, 6 Jun 2024 08:56:49 +0300
Message-ID: <CA+SN3soxVEUUWZHMFX7OeMj56wEw7p9Q=eXXNJwiYz6Bh=pb7Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5] net: ethernet: mtk_eth_soc: ppe: add support
 for multiple PPEs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:43=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sun,  2 Jun 2024 20:32:40 +0300 Elad Yifee wrote:
> >  struct mtk_mac {
> >       int                             id;
> > +     u8                              ppe_idx;
>
> I thought Daniel's suggestion was to remove this field.
> I don't see your rebuke to that point or how it's addressed in the code.
> Also it would be good if you CCed Daniel, always CC people who gave you
> feedback.
I talked to Daniel in private, I should have done that publicly.
Relying solely on ifindex%ppe_num could potentially lead to more than
one GMAC assigned to the same PPE.
Since the ingress device could be a non mtk type, I added that sanity check=
.
I think the additional field is a small price to keep things clear and simp=
le.
(sorry for the previous HTML tags)

