Return-Path: <netdev+bounces-114839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E866944612
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 10:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7F4B21486
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4D31662F1;
	Thu,  1 Aug 2024 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xyw+iU1C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F85158A1E;
	Thu,  1 Aug 2024 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499316; cv=none; b=kB4j3oWWYJ3W+STTU/3FaWSWGWaJlMA48h7WYGFZNJmC8oAAMV6JkZSDjl4cRwIJpz3stfcLkOIMGR/BxbduFJCE3jqCqah6QFQZ60pbpGQg8+vdQ+Sxhir7wbTb8iRogvPB07qdzi4ayEebbW2nexfsa68OMDyouWCP/Pl9IOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499316; c=relaxed/simple;
	bh=pss0ZUVkQ9llcafFVFt33upaXuS98JMtSIUAnIUxRGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzak+eMLUCwrIme+Z0lkXHwxn0d5zgUgS2+FkmC9fHnw+e9ViIw/tZlucqt3ocpcVnsAKi2oJs34xh4n6LyQ+K80irug57diFHCOUzYigtELVoRyJwsmticiVBfzpJczjKBlgzbaMMeHhTHBZBoZYAKno1IW3r2Evxy1XYh3ess=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xyw+iU1C; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36865a516f1so4649785f8f.0;
        Thu, 01 Aug 2024 01:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722499313; x=1723104113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pss0ZUVkQ9llcafFVFt33upaXuS98JMtSIUAnIUxRGo=;
        b=Xyw+iU1Cc6vLwAbhv79zPd6zC3RDBw5J77ynq4xnGfmtDFWxHqkK3FVmKGMRA7SpIa
         T9J4bTA3ewNrC7gecehliAtBUKajizaSDe1Ja65pYWh1TttPzqe5cvVmqCmbb3JW/yzx
         VjJyJ/PAcIx3BzJePFleOmtnKCCzv+SUuf9tk7o9gTR0/VtgP3iUixaxjC/j28cqR1Xt
         RDeuz6E1HJg4mQYJb6QnemxHN28fKp2T+SkFnnNCSwAKFMsnpBPdIh/mXik/nUcX2P4s
         HhNDzMfg3/gjvgKxKjnFCYqTXThkna8kRn1iJ8vd2elcEqUR6LBrwhvh5XJyhfaanIlj
         55kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722499313; x=1723104113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pss0ZUVkQ9llcafFVFt33upaXuS98JMtSIUAnIUxRGo=;
        b=IX5Jms0ZulY4Pe/TRjuYI6/fzfasHtXW43bYzVeIffQJVyVhefSJob2fScJGHvUe5u
         X8/66kDtA23O1L1jEM/mQc1iru5n48RS+r7Re2jy/ilIXPk4MU3JrUm4Fw/POf7vfRr1
         MiMSlo3KJACCOlUAmvnl3h+JSI6DoJt2as+JsVVuLJv0LjO9SrXf7kSmRyLrXyNwWELH
         tjdHdt3E9c2Zcgi/rTnwXNBLhYq2+qfos7WdrD77WdqwtAnbxAv+gqxd0IxWYw8G60Ep
         j3t05cXl/99pOEcGUlfaPB2JFZneXa0fdo9NxIyw8TJy6VKxYeihAyTGV7/OZyJLOsv6
         HQ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0P6JqoKengu/3VanK58sunVTjWzllDA9jLd0g3dv8YbXayCV1rLZOwL5QXCkMO2ibIZn270hN@vger.kernel.org, AJvYcCXeWmpdfYn1ZEgOWMi3nrddOyzd2+63hc7bNohLfso51yPXnym0ErqCTu/2cAQC9cidjlZzpWJ+Rk8yhh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVbNksA7KdGoB/JhqSOVCZrqwOtDJ+TT5etbgJDZamPpgYKgge
	5cZwvIjmMjCWJDPgz7XThTCmrczB2hf+H+Xe3cHDmpYcP6S37FP9SeWD3XMdfZdo+ASMvLzZvHN
	kSsJwSp6WW1uYRUUjS5R90MUY3FM=
X-Google-Smtp-Source: AGHT+IGzDGxYPAK57oqfHSlsGd9K7iuasFxGLFx2h2cYTdeTQgCLNXKoUee/un1WO6hbM0z6aFcsf6cq/8chOwD4G2I=
X-Received: by 2002:adf:ffd0:0:b0:368:4910:8f43 with SMTP id
 ffacd0b85a97d-36baacbcfcamr1417384f8f.3.1722499312787; Thu, 01 Aug 2024
 01:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729183038.1959-1-eladwf@gmail.com> <ZqfpGVhBe3zt0x-K@lore-desk>
 <CA+SN3soFwyPs2YhvY+x33B6WsHHahu6hbKM-0TpdkquJwzD7Gw@mail.gmail.com>
 <20240731183718.1278048e@kernel.org> <CA+SN3srMPLcmQ4h_iNst71OkQPFcCYxBRL0Q9hR=7LjJ86TFFA@mail.gmail.com>
 <Zqs5hcFMx1g42Zrd@lore-desk>
In-Reply-To: <Zqs5hcFMx1g42Zrd@lore-desk>
From: Elad Yifee <eladwf@gmail.com>
Date: Thu, 1 Aug 2024 11:01:43 +0300
Message-ID: <CA+SN3spwT1hrXQRmk8TkDOfBwp66WWqEAczvNCS7QaTe_eM=Vg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] net: ethernet: mtk_eth_soc: improve RX performance
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>, 
	Joe Damato <jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 10:30=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> nope, I added page_pool support even for non-XDP mode for hw that does
> not support HW-LRO. I guess mtk folks can correct me if I am wrong but
> IIRC there were some hw limirations on mt7986/mt7988 for HW-LRO, so I am
> not sure if it can be supported.
I know, but if we want to add support for HWLRO alongside XDP on NETSYS2/3,
we need to prevent the PP use (for HWLRO allocations) and enable it
only when there's
an XDP program.
I've been told HWLRO works on the MTK SDK version.

> > Other than that, for HWLRO we need contiguous pages of different order
> > than the PP, so the creation of PP
> > basically prevents the use of HWLRO.
> > So we solve this LRO problem and get a performance boost with this
> > simple change.
> >
> > Lorenzo's suggestion would probably improve the performance of the XDP
> > path and we should try that nonetheless.
>
> nope, I mean to improve peformances even for non-XDP case with page_pool =
frag
> APIs.
>
> Regards,
> Lorenzo
Yes of course it would improve it for non-XDP case if we still use PP
for non-XDP,
but my point is we shouldn't, mainly because of HWLRO, but also the
extra unnecessary code.

