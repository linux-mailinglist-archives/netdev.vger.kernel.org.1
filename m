Return-Path: <netdev+bounces-93504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BFE8BC190
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 17:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DFA41C20958
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 15:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3F72C6A3;
	Sun,  5 May 2024 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ya+VOpcM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A204A26AE8
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714921228; cv=none; b=BKCt6z2DzGfbgny83HHcuLiez3MoZglcyu9twRXosgtEC/XdPJi0c2Ft9qBtnCEogZXCoD77aZuEha9cw3jdRdT18bGWYiSt4amiM+g0dBkDJ8SXSuQJNG/Dw/Ghjdmq9wGFF9kAwSFBlxHC/NvxmRD9iWFTQJaXByqRoNNitmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714921228; c=relaxed/simple;
	bh=Uv9qGUUu8dXSXLV/7rHF2BMXbC762cy0DswRI2iM5MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCO1SDDdknKPef/OCH+//k2W//7A8jCxwQ/4ET+ndX2N/fM5RSotoQKRmI8Rj70gPDM+kQ2+ur36OoQR3019axnXfcBc+IqPRtDx6lp4FxBD/YYTmPBBJbEqQaiMX1idcQW96KDr1ue7IY73kzoEEcj/6SpU0ZW9/U0HYeaDMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ya+VOpcM; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso6108a12.1
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714921225; x=1715526025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctSsHOSH7S6Ml62GvHA1tURuT3OeqBGKU7pXgD03KCo=;
        b=ya+VOpcM3SY4YjNxXIJYlj0qorx+mIhntBqxY5lbiC7VRNFg25w196P5biPRt6IIj4
         Zu0Uv4Ov9LUsLiDawPFFei4xFYbXy0MvR3cJL2l3SoWGgeR7VBwXTSVMbt10110iXv/x
         vgxv9os0GqHoB32sc20eGH8O4VCroTQFf/HWE5EGGR43ERUh7jU3PrbntLaKMmLHeG0U
         1GLs5ubw0lqBA/Tj6XhS6sowcfkED9u3Q7uhKF8qsJdDuU4xcDe7NMiXqPq+belxHnLT
         9iyN0iiUCsYKUdEgfqfIfoYlO0W1QY6jvNAgiXqSyo10vXwVd7TKYOfODHS5GOpiVh+y
         sYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714921225; x=1715526025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctSsHOSH7S6Ml62GvHA1tURuT3OeqBGKU7pXgD03KCo=;
        b=JdxVFanXGYR+6cZHMdA0ZBLPQ+7n6j1kK5QSfkdkjQ/YrO6ay8x6+/vx5oHE8647gK
         SpSYT4YpExoDs4p14tYpJBKwm92CE8G82U0ieePetXo3eKmBUw20dNZ9T9XJSt9LBlEI
         V6+lsYsyQcpcJHXUfpVW41/6pOlYcuYLEMFzw4iy7i4qVIKiBcXQem+W0eORAplFdlXt
         YFgAgaDGvc8EunjGlyqmbxca6EvEDzIm2zjgGeQhZsX7iZD25W9AKyA6PbrhRCylNymW
         oN/6iIUqCoGFsCL9zTRI3wiLjE6oTw44wzKqQWrQXMAeJKJ7XpEfIG3sZ8943PY8WKLu
         Wutg==
X-Forwarded-Encrypted: i=1; AJvYcCWnhqSm0PbkFkgnU5I2N6YoyF8nbpTDw4oWrgn8qrA+pgYMKQ8I7gWIjtrwOZI31ebRfTacdbyGT0z97vty5yqvSkza4UCm
X-Gm-Message-State: AOJu0Yzzzb2HVs/q6Y5WWikQVlTGrX23bQt4p3XzFuo3Aen+TMtWZkVW
	sDl7dMCh2j9QtrENxrIcPM8BP2PglqOH04tAJ4Fk37T7BQteUxUK5ir79E9JL/qeKKsLVXoaTUg
	YMh5HfM30bGMzPFxHEVDf7boST/lm7XXD1p/P
X-Google-Smtp-Source: AGHT+IHh0qd/GW4hcdpnglnisytvDwCZnxzJnPYZs+xWNg1iD9TeTN55yTWvMDnB/vVMAwhdbNG1tFFysJsMYxc/IwE=
X-Received: by 2002:a05:6402:1bcc:b0:572:a1b1:1f97 with SMTP id
 4fb4d7f45d1cf-572e26945c5mr144555a12.1.1714921224537; Sun, 05 May 2024
 08:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503192059.3884225-1-edumazet@google.com> <20240503192059.3884225-6-edumazet@google.com>
 <20240505144608.GB67882@kernel.org>
In-Reply-To: <20240505144608.GB67882@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 5 May 2024 17:00:10 +0200
Message-ID: <CANn89i+ZKZrbmqxKU33XgN_ZyqqkFa7+BqAqFWCYdj3He1Xy8g@mail.gmail.com>
Subject: Re: [PATCH net-next 5/8] rtnetlink: do not depend on RTNL for many attributes
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 4:47=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Fri, May 03, 2024 at 07:20:56PM +0000, Eric Dumazet wrote:
> > Following device fields can be read locklessly
> > in rtnl_fill_ifinfo() :
> >
> > type, ifindex, operstate, link_mode, mtu, min_mtu, max_mtu, group,
> > promiscuity, allmulti, num_tx_queues, gso_max_segs, gso_max_size,
> > gro_max_size, gso_ipv4_max_size, gro_ipv4_max_size, tso_max_size,
> > tso_max_segs, num_rx_queues.
>
> Hi Eric,
>
> * Regarding mtu, as the comment you added to sruct net_device
>   some time ago mentions, mtu is written in many places.
>
>   I'm wondering if, in particular wrt ndo_change_mtu implementations,
>   if some it is appropriate to add WRITE_ONCE() annotations.

Sure thing. I called for these changes in commit
501a90c94510 ("inet: protect against too small mtu values.")
when I said "Hopefully we will add the missing ones in followup patches."


>
> * Likewise, is it appropriate to add WRITE_ONCE() to dev_set_group() ?

In general, a lot of write sides would need to be changed.

In practice, most compilers will not perform store tearing, this would
be quite expensive.

Also, adding WRITE_ONCE() will not prevent a reader from reading some
temporary values,
take a look at dev_change_tx_queue_len() for instance.

