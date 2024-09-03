Return-Path: <netdev+bounces-124724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C02596A940
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 22:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01032852E3
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 20:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E9B1E631C;
	Tue,  3 Sep 2024 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIuSkO78"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB9D1E630C
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396383; cv=none; b=Mn28mqfel0LO8EQ/J5/ji6nGNxxQtJMzVDTZcPQgn1g48BFmzDLuxAknaUNDBzVNeFEQRKvq51KipiWUVBTMlwt5qUO1+PColJBGiAjb9pHi0ZQhWYiz2G6x6/hpdsn60muSiB5gqLw4c9aZPXlw/KU91N+2haPYRBvmM7xkz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396383; c=relaxed/simple;
	bh=dwcskGgZ8YiVO0BZdZCn7/dqMAqVjTQhhcBAmjBD/x0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DFvSp9G8V30T2qABAC+0/DdJk9EUuSgLFf3R5O+bPdmjCwAZGicrP8EZfr5JCwUe0I39D1pS+aoLC7HtsQVw8cOIO6b85zDFRcNRjfnbOGJYkmOVq3VSpOzjk2zW4R1eU8QfvHqTmKaStIe/K22xy2oAg5wdYsrB5Wt6O8kRltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIuSkO78; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a966f0ac8aso173173285a.2
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725396380; x=1726001180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwcskGgZ8YiVO0BZdZCn7/dqMAqVjTQhhcBAmjBD/x0=;
        b=jIuSkO78nxOY2xymmfxfUm9d9Wqq1t+MaYCb2QecUxnn3/8eZeq37Qatj3WDfEHkEX
         UuSoD7BE1+IUbvYqQZRtUcXG+KQtDEreWimj/X7lUpUBzygx48ZLE2CFacxQZ0d89aYa
         3N9pylksHlb5Inzm/jSvVoOgLxXG+SPecSq7hHbLulO7UXqmdX8LgV0weAhruIi17jBX
         66j+NWqLn7nga8ndQ/PnWWzVfjI7IOvWC2lsSzP1wlIYvP7ErRZ3kFCBd6IzGV2stOMC
         xSGNeVXWMH+VNO9zoAQC9GmB/gJ9BEAE7J2HSk1rnc92BXBRkfAeBoihusRzPzJfOi15
         GHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725396380; x=1726001180;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dwcskGgZ8YiVO0BZdZCn7/dqMAqVjTQhhcBAmjBD/x0=;
        b=WAbwepPEgw3F++NKADoUPlNwdQjTyqr3nEwVZWLszjRFADKmXwGjmCOE4vAIJweSSF
         zsLWHHyq8eJHSrSP6/Qg5N7v9Gz7ND+DhvI/OGNoV6+wtJDhNZDhNjLaGDwkM1PYTjnD
         Ssfk8FfUqyUOfYwrRBG2/8aey3tGWKDXLla2m9KTQzMab8kjhnV1CtJYH48yd0XUNDto
         8m6NLL6NrhYLSCWJ7Nxi4ogX3qYevVRLmlxGNRkYklmgchlS844cvE3eFgBPhR/2/08D
         qC0ZaRoGyZxv9tQ/VicGFfm1uWWlBM0/vzrNSzwBGUbGOBS+Ax6d2KPMz0IFXOQxWk/u
         feGw==
X-Forwarded-Encrypted: i=1; AJvYcCVlQoqqNTO7H1vgdibjCC5NG1bzwStoL9OfzWkOYzxWCeGwTYI7LHnJ6dHQeICSaAQm5bGGkd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnuuTqmFScaU5Q+iNYCtatFGUz/W0m6+xzokvt/kjKsaIlHjxh
	137oaVQzw5mC/yDW4YB0j4YaBWS95c5H8C6DaKHtFLxSKkxFgj1t
X-Google-Smtp-Source: AGHT+IH2932BGa8G0zej/cCHNWtEDRHWFEa69FGyAxh59BRVGdmpdLjvXDznxf32n5qPC/y8USsCUg==
X-Received: by 2002:a05:620a:1725:b0:7a1:c40d:7573 with SMTP id af79cd13be357-7a902f29e21mr1626027185a.49.1725396380458;
        Tue, 03 Sep 2024 13:46:20 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d5f673sm558532885a.113.2024.09.03.13.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 13:46:19 -0700 (PDT)
Date: Tue, 03 Sep 2024 16:46:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <66d7759ba35b0_ce32f294db@willemb.c.googlers.com.notmuch>
In-Reply-To: <a5b2ebea-b509-4241-9367-1ef4e41cb004@linux.dev>
References: <20240902130937.457115-1-vadfed@meta.com>
 <CAL+tcoDgai2bLqnU0KtspTu1nn=qb_23TQNUf7u=-VOhnitaOA@mail.gmail.com>
 <66d5def0ca56_66cf629420@willemb.c.googlers.com.notmuch>
 <a5b2ebea-b509-4241-9367-1ef4e41cb004@linux.dev>
Subject: Re: [PATCH net-next v2 1/2] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Vadim Fedorenko wrote:
> On 02/09/2024 16:51, Willem de Bruijn wrote:
> > Jason Xing wrote:
> >> On Mon, Sep 2, 2024 at 9:09=E2=80=AFPM Vadim Fedorenko <vadfed@meta.=
com> wrote:
> >>>
> >>> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate=
 TX
> >>> timestamps and packets sent via socket. Unfortunately, there is no =
way
> >>> to reliably predict socket timestamp ID value in case of error retu=
rned
> >>> by sendmsg. For UDP sockets it's impossible because of lockless
> >>> nature of UDP transmit, several threads may send packets in paralle=
l. In
> >>> case of RAW sockets MSG_MORE option makes things complicated. More
> >>> details are in the conversation [1].
> >>> This patch adds new control message type to give user-space
> >>> software an opportunity to control the mapping between packets and
> >>> values by providing ID with each sendmsg. This works fine for UDP
> >>> sockets only, and explicit check is added to control message parser=
.
> >>>
> >>> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr=
1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
> >>>
> >>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

> There is one more issue here. sk_tsflags is u32 as well as
> sockcm_cookie::tsflags. But sock_tx_timestamp receives __u16 tsflags,
> usually filled with sockc.tsflags. It works now because
> SOF_TIMESTAMPING_OPT_ID_TCP is not checked in these functions, but it's=

> wrong in general. Should I fix it in this series or it's better to do i=
n
> a seperate one?

Good find!

I overlooked that when expanding sk_tsflags when adding the 17th flag,
SOF_TIMESTAMPING_OPT_ID_TCP, and increasing sk_tsflags from 16 to 32b,
in commit b534dc46c8ae.

Passing sockc instead of sockc.ts_flags in all cases will address
this.

This does mean that up until now SOF_TIMESTAMPING_OPT_ID_TCP could not
be passed as a sock cookie. We did not notice that, because it is
benign: the option selects which tcp field to use as base for tskey,
and is only active on setsockopt.




