Return-Path: <netdev+bounces-134385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15AF9991C6
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 21:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA7E1C23BFA
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AB31E9091;
	Thu, 10 Oct 2024 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Av4sQORl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD561CCB2A
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728586754; cv=none; b=FUhj+ieiapIVJeUoKYIiw/y+Rf1vVzc1N7lOqvrXvtv8FytYirR80zqgfg7V4rKT9+LhstafEMrtKihnyTlo6FhGjfneiyLpZIPRj8kSte0Q1em3q08vggm3UStMzLxdnDmFxETIZGYYgudffzA+POpkwo1+0ClG6xHSGnR1/d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728586754; c=relaxed/simple;
	bh=LtXutq5M8uwCGtzmBYPd3IwYgx1M1XOSV4kWLz6XI58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVwV0Ork7lVy07GRA/KWKYLK8GibBSQ8pcm6xXueArQBov40aHTfv+0gQqBZxmM3VQ0U8/woO4/LS18inoLjaT49qd3oLLvRJMZgiUZC0IemRLR/ouAnqfiXvdU2kq/ejD+5VLP8BwxYxdheFIBZukZfGw560mmYDAM683uwf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Av4sQORl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99791e4defso91905166b.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728586751; x=1729191551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeu0iqduL12+cE/Y5C7q8kuFMBuFw+am3uGF9rmwuL0=;
        b=Av4sQORlWGiwUDJs8/HxET+nGOPbmMtqpo5lI07PdjL5wYiUU/FUh/7YJoORpW4gTL
         epHoN2JiBE4J5T8rEP5weeTEbV8Y5Mt9aVjqxq4Odspku5ScUvT046Xwmj0c1/xxuFJm
         /wokw7PvP9Wwx2Iq9haVDBTnfr5V1NHE94aZG1/m9tWYuecFjGw+Rb78jU0MtCzPgl3E
         cTKz+9fsKIsUSMbyNa4AJuxagsckHu2+wKpWGbxu5KeRe7klOgqi4u9lNKBAP0AYCUeJ
         oam6OLi5lSnsCrrVEspe2fZL2L2SNRZKyhJjsd1IvOr8PpkSxuCBOL9A+00XPsh1ALJr
         lb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728586751; x=1729191551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeu0iqduL12+cE/Y5C7q8kuFMBuFw+am3uGF9rmwuL0=;
        b=OqjKaREu6piMmzoYcFWU87tg+GJ8x9SQjqtGvtGTMk5/+J2lF02fOU97sGVm8QJCPd
         2AEVZhGSgmegaU32HRsV682O290Q3wFol3qgI13q93TPh/iiD18XzrRFD2mSb+e7akEX
         058gwki0BRL5K3po49FbHcj1HFHC9vcB46/1Zppg+1uOYJbajju0bGZgDNC/49oh3JRm
         mESrYJjabEEyN084pj32TGcyZpVLtc0wesvzY1V4kehDgnms0bLwan3gMZSTonMrfy0a
         0UAec6U7DeXyPn4SCkMilCcDWreIF9OIt/KaEY7byOVfT8w2iv/YYPJqzr5tmUssUrOI
         cc4g==
X-Gm-Message-State: AOJu0YxcfWoNaX2fas9OGTm/FE7HFGnU6HVnFkQzAM7rQWhv3KR3QZo9
	YFhYT4an+MX4g7g2Ym5Xh9F9Cz8dPzpJ80GKLA3dukipWskZDvURR4vTb2QI1er/PPEStdzIcPN
	cPW/fg8KBImtLBimp+1VBCICivLoodC45WP5I
X-Google-Smtp-Source: AGHT+IHsUzmya4ONG///odZM2DbxpJmypjkPC0dvHy/ESfgn4fn+cchKNt3BNeGR/Bw757CAzU94y27mC+rMqwv9LYA=
X-Received: by 2002:a05:6402:210e:b0:5c5:b9bb:c341 with SMTP id
 4fb4d7f45d1cf-5c91d623839mr9068055a12.26.1728586750591; Thu, 10 Oct 2024
 11:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3000792d45ca44e16c785ebe2b092e610e5b3df1.1728499633.git.lucien.xin@gmail.com>
In-Reply-To: <3000792d45ca44e16c785ebe2b092e610e5b3df1.1728499633.git.lucien.xin@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 20:58:57 +0200
Message-ID: <CANn89i+tyfVMZ0nuX5cYt6_iH1F1PLdDpQoqK66fhkyR8NWQHQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: give an IPv4 dev to blackhole_netdev
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, davem@davemloft.net, kuba@kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 8:47=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wrot=
e:
>
> After commit 8d7017fd621d ("blackhole_netdev: use blackhole_netdev to
> invalidate dst entries"), blackhole_netdev was introduced to invalidate
> dst cache entries on the TX path whenever the cache times out or is
> flushed.
>
> When two UDP sockets (sk1 and sk2) send messages to the same destination
> simultaneously, they are using the same dst cache. If the dst cache is
> invalidated on one path (sk2) while the other (sk1) is still transmitting=
,
> sk1 may try to use the invalid dst entry.
>
>          CPU1                   CPU2
>
>       udp_sendmsg(sk1)       udp_sendmsg(sk2)
>       udp_send_skb()
>       ip_output()
>                                              <--- dst timeout or flushed
>                              dst_dev_put()
>       ip_finish_output2()
>       ip_neigh_for_gw()
>
> This results in a scenario where ip_neigh_for_gw() returns -EINVAL becaus=
e
> blackhole_dev lacks an in_dev, which is needed to initialize the neigh in
> arp_constructor(). This error is then propagated back to userspace,
> breaking the UDP application.
>
> The patch fixes this issue by assigning an in_dev to blackhole_dev for
> IPv4, similar to what was done for IPv6 in commit e5f80fcf869a ("ipv6:
> give an IPv6 dev to blackhole_netdev"). This ensures that even when the
> dst entry is invalidated with blackhole_dev, it will not fail to create
> the neigh entry.
>
> As devinet_init() is called ealier than blackhole_netdev_init() in system
> booting, it can not assign the in_dev to blackhole_dev in devinet_init().
> As Paolo suggested, add a separate late_initcall() in devinet.c to ensure
> inet_blackhole_dev_init() is called after blackhole_netdev_init().
>
> Fixes: 8d7017fd621d ("blackhole_netdev: use blackhole_netdev to invalidat=
e dst entries")
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

