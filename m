Return-Path: <netdev+bounces-219665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ED5B428AE
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00651890F83
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B49F29E11B;
	Wed,  3 Sep 2025 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4PHeePXh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F791624C0
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924259; cv=none; b=foz2FQNdcEtoQh3wOqaXFzdoFDXCc6XJcpLyv5uvJHf9oZIoF6w3qCXk/J9NkdH08mPsV01Z//tGra1bCYzb0tWayTmp/NF41WTB0WL18JbuPfr9+IxvypHNhtNufYE6UmvTyjx2oAsgQ3oYGLovW6pfVgCV2aani3eRE4xVbdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924259; c=relaxed/simple;
	bh=zLpvGXFcIOMN9u53D97LhLpkwH9jAP3DSRcZrFXwoiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMstc5dkKB4kuG9w9Lwsy29bDdBBzKy+9eooQtM+yz+Byec2pSB5+l8fVQV3QicC6ts9w/pB8e8D0eZo6mONCJBZtug84g4rgp+IuXipp7/Qh95Dz7ABhqqWRvBaHj+taqr0Kc236C9ZvndGod3sLMpHxW9Q/C1Nyj3JUfqQR9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4PHeePXh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2445806e03cso3504945ad.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756924257; x=1757529057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLpvGXFcIOMN9u53D97LhLpkwH9jAP3DSRcZrFXwoiI=;
        b=4PHeePXhqFGzd8JlKGgJ1+02IsAqoxIzzDJpfFTWPGtIYD4Oy8IDiC4mE+gaGyGsjF
         u8/edwD3zhNhYIztHvjcVBevbG5G8oCcbnvq4CzVJPPyfNwqEONhyi93ARDN4Pp8eMTX
         QeVLIBhyeSThQuBYHqoWQBE0HRlZsBYnPbe+et8L0Mnk1YY2WjuBVxD+AER54Bnn5cnC
         OYk1dMEtLItJqM9C3C5bg4PWa4VKGG5+XZMjLZy7nZJnmAiunf8wl95LsbmV8uWG0Fqq
         GezVqpSHT7JWxS2CeJGTHvqLLBFVXjYlsFmEJ8xpDhId0trPGDcZoPuic1pA+d460j5N
         Tjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756924257; x=1757529057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLpvGXFcIOMN9u53D97LhLpkwH9jAP3DSRcZrFXwoiI=;
        b=T9Fgl7HNmuiL59efsknogjx5JRtRN+fwcDN4T4Q0N27Y2vlrSrNHPhWBgFHl83b0Ai
         SMLSLikD8LaGk++CNSRbVe6VlNNph/F8M3aBoYNEfHYO9++/eYwUTCKfZ5XW7oAa0CwK
         h5zxOzrQL4RxMfB5W6H0HWasBUAurmx00QfjIF/nUP/jq3XzFdCGf5uwu8SYvkN3PuEE
         boZsR58+vq6PGobalzx/5m7HbS0yStIV+zEpaji4MmDKGSBdi4ZzhIunqCW7cVHtI+fA
         PsjemmiDn0p25xplFmZZuF2RG9PxjTAeen2aXCe35oL7m2MfUh6Z+zRCp/WmjjOTz3i0
         8pbA==
X-Forwarded-Encrypted: i=1; AJvYcCVsFYIW8D00Yxdv1zt4NOYFDR8EpQVZfxHd/6RiyQfvQnRuE6JozugIhwF+zEg1hI6LStGCYh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz74wLswXmJlg5pv513yqRv0tL6R9SZhMazIglR8Cij0n+5EUOZ
	zrmCqEmvsOnXvX4/QppsQ1WvCRWuT5PfpKY9cjtpnP2UslbysAePKvKehHjj8Cc8OCt6dfwsrNY
	1LeBox0A28+Hgj4MF8/U1RHs16nuvKipPzM/kaMOR
X-Gm-Gg: ASbGncty/ZynTvC/l4JfKm/NnfQMo67jkL5ODGYTAmTHmHV4uH3AQJZrA/yaJbLa52e
	tsZsxhsZ1T3YX+scJyTIAdKPT/20KdEmVLNO2fF7ahT1DmgwXVHD+4TIbePIY9w3UDwUmCq9tWA
	JUhN3UHqZAZ3FIXwKlzfPSds3V4FETTSaXhnP8nwkGwQzcDH8wJq1NoyqOXlttHKhvCs8ngCaqx
	RhG1ODo4qkhxHEt1bhujI0iTAe6l5ByGWHdScts+Pwy+BrPBDT2Wp3EM0JF/CFt7HhIdgEEKWIs
X-Google-Smtp-Source: AGHT+IGXwwtdwHkGzuEcioj/XqmU7m2+uPoc0sq16Edy2usFHYEvAdIqzq+ITOGK/eLpnmrJCNFKmhz8L0+3npiXLEI=
X-Received: by 2002:a17:903:283:b0:249:2cef:1cfe with SMTP id
 d9443c01a7336-24944880455mr232785635ad.6.1756924257118; Wed, 03 Sep 2025
 11:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903084720.1168904-1-edumazet@google.com> <20250903084720.1168904-4-edumazet@google.com>
 <CADVnQymopx3uxsn1vCts0mDKEOZWT9==X2VE-oC3rzg_AEdFAA@mail.gmail.com>
In-Reply-To: <CADVnQymopx3uxsn1vCts0mDKEOZWT9==X2VE-oC3rzg_AEdFAA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 3 Sep 2025 11:30:44 -0700
X-Gm-Features: Ac12FXyjopOXeOvpsu9JWFNAQMRNSHRUtytRkgphe8EMi5uN3KuDeX57uqVfVe4
Message-ID: <CAAVpQUChQhHSEh_ekiRHcXZ49ye-4kzW8ZmR4u_UKsKM2XHT0Q@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] tcp: use tcp_eat_recv_skb in __tcp_close()
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 8:09=E2=80=AFAM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Wed, Sep 3, 2025 at 4:47=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > Small change to use tcp_eat_recv_skb() instead
> > of __kfree_skb(). This can help if an application
> > under attack has to close many sockets with unread data.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
>
> Reviewed-by: Neal Cardwell <ncardwell@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

