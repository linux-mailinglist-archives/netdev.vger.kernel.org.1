Return-Path: <netdev+bounces-149573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5599E645F
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 03:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15F61881DF8
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C360190063;
	Fri,  6 Dec 2024 02:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1QppQU/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815CF18E373
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 02:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733452964; cv=none; b=IcQiFIgMY3ieIEDzzRYAknl/EDcQUNCFOoMDRQCxI4j2S0O5tRN1Hn8a+lpMmUBAd9TzJyz0KCjZUaZpPpAZMrAsfR12GOWLSLT6Bs+s3/AJ+3Mm4aneDqno12AUcrR+YR+NK1cvd27GE9F0OcETOu0UnjdE0zY5WrNO6qh6wno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733452964; c=relaxed/simple;
	bh=VapI9BO8bDoxLf+txhz8n6Uf6jhZ1jCyATxFGisXxN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqOPQi8oMG/1280aQUDsS97kYx9FK4AVQxo06Oe7pR/40P1WYnVuI1jiiErL6LeBwnIq1VeK8NcImn2e+2z09eNQnA2CqKi7HWI/tht3w6WqYIE0i4W3yYkjtAZFj5oj2ZKoD+5ZVNRHa9Nh4NDPHEn+Dg5/cjJUE4h9CjlOgcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V1QppQU/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733452960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VapI9BO8bDoxLf+txhz8n6Uf6jhZ1jCyATxFGisXxN4=;
	b=V1QppQU/iKUDc5MYBPyTSCNsBmAI6XrkZZ/6qYAjbRM9r5piJKNLOMVF3S3yqFxw7pPBxv
	K+P+7xL8Nto8zJnhPGCHBIkZLsNuJEuglfbCWXREjQ+U7sKquKG4Wihov8tzsFGa5aMQbO
	k1NRm1ShqpzUA9qB2xkXP37qNI6z7w4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-NQk-3ugBMjWM_SZUkoeigw-1; Thu, 05 Dec 2024 21:42:36 -0500
X-MC-Unique: NQk-3ugBMjWM_SZUkoeigw-1
X-Mimecast-MFC-AGG-ID: NQk-3ugBMjWM_SZUkoeigw
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ee4b1a1057so2626713a91.1
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 18:42:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733452956; x=1734057756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VapI9BO8bDoxLf+txhz8n6Uf6jhZ1jCyATxFGisXxN4=;
        b=h6C2Z6gIVcbqK0Y4n5cRX9l+HuxClsNksPV/dsCK5sAWICU5DKb19LPvNbv6FfnGSz
         DDPpCJljzCwTrozZLudxiEREJu+fp8NygsEudfdJaXpT9hSRRzZyrN8d/Vq+cG8C8mrR
         xKgVYCLX2NuMjmIRllJ0LodmXvbEe5aEyiT9P5rEUtOtP31ezL9bSfg7w0Ra7TSivL5L
         8qO1esxiuSQ6zIHi4Lz6RZD5g+KiJ0eoGIch8xI3cFgYC9HTA+SkTiBDRXb+gYh4X5a2
         Z8OHDE+0qTtvNN7mujUguw9eT5Va0yplqxaIYkcClX/k2Jom6UWY2rY8YRaEevm90cQ2
         Fepw==
X-Forwarded-Encrypted: i=1; AJvYcCXy2gp6wbnYjORaxRyLexR1+ggi+5Y3S41Hrowzzz1fUEtqAKbyba9NKtVzXFJONnWlKKuzBlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIWwFiWatBzW/H5Q2/NEup3kUjKTZLIEvCYEEauBBf7Ya7/JNv
	DkE5l02oYUh9ty+CVtGQb16j14gwaS+khVufApZbBz36GbtjTIEcbpv2YyyosTwCsUrxGpAnM75
	qxHXUeUHR/YLgKKJL8+hFW6XusHQ3WpCCUSuyUGkc4+JZVpmaBgwvefwe3iMEQl3HENL95uz++r
	fYzFFHyUXf3V8kaWW6AaRadPgILXYb
X-Gm-Gg: ASbGnctrGoxlTPdX9wqOT1WFs0uHHqOoai5TxtI56JJc5nQ6GW7U6x6FQ+brLxhj4hj
	n6KyHeu4XC/9E/PYZ/q2ofDmnufyO/wPwew==
X-Received: by 2002:a17:90b:4c84:b0:2ee:d63f:d77 with SMTP id 98e67ed59e1d1-2ef69e121d2mr2499909a91.9.1733452955991;
        Thu, 05 Dec 2024 18:42:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXC1PaZ/v1xzGb9UHzuP48eKxe8R8L0M0pU/SFP7iOc+J8n98g8ZduoEmx31sFn2mMYoCCNI12FCuwzw5Vn5M=
X-Received: by 2002:a17:90b:4c84:b0:2ee:d63f:d77 with SMTP id
 98e67ed59e1d1-2ef69e121d2mr2499880a91.9.1733452955619; Thu, 05 Dec 2024
 18:42:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205073614.294773-1-stsp2@yandex.ru> <6751d9e5254ac_119ae629486@willemb.c.googlers.com.notmuch>
In-Reply-To: <6751d9e5254ac_119ae629486@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 6 Dec 2024 10:42:23 +0800
Message-ID: <CACGkMEswqwz_EG0onQcOZdt6pkcaJ7zHsVpm=c2HUkyqdOMTVg@mail.gmail.com>
Subject: Re: [PATCH net-next] tun: fix group permission check
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stas Sergeev <stsp2@yandex.ru>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 12:50=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Stas Sergeev wrote:
> > Currently tun checks the group permission even if the user have matched=
.
> > Besides going against the usual permission semantic, this has a
> > very interesting implication: if the tun group is not among the
> > supplementary groups of the tun user, then effectively no one can
> > access the tun device. CAP_SYS_ADMIN still can, but its the same as
> > not setting the tun ownership.
> >
> > This patch relaxes the group checking so that either the user match
> > or the group match is enough. This avoids the situation when no one
> > can access the device even though the ownership is properly set.
> >
> > Also I simplified the logic by removing the redundant inversions:
> > tun_not_capable() --> !tun_capable()
> >
> > Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> >
> > CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > CC: Jason Wang <jasowang@redhat.com>
> > CC: Andrew Lunn <andrew+netdev@lunn.ch>
> > CC: "David S. Miller" <davem@davemloft.net>
> > CC: Eric Dumazet <edumazet@google.com>
> > CC: Jakub Kicinski <kuba@kernel.org>
> > CC: Paolo Abeni <pabeni@redhat.com>
> > CC: netdev@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> A lot more readable this way too.
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


