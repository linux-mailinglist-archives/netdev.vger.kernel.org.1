Return-Path: <netdev+bounces-165131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C712A309B1
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 12:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C0B188B77E
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12D1F9406;
	Tue, 11 Feb 2025 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3jPZYLO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B771F8921
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272536; cv=none; b=dGiMzi9EXuGmc1ke+2eDVP4I1HPILfGXbvkdWQwqXCUy86QRlqtRdUdt+uFNfq3J52N8fM39JJMoXGDmY4Bt30cOh6Z5TQj5S+VTYJs7b3kHdkjNh+sNt09M1dqAtlXbnWecOPGecot++B9VxWZSqDSAnqCNzU0E4/Evnuwhoww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272536; c=relaxed/simple;
	bh=8l8FP7dj+1NJWawu0WDpUgtCnN886pFUV0K1G2Xj/d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1V2LN7XMVi77Py+o83ut3RJEhhvVLGW5QwSKkbe2ngE6d6or22/UqQ9uyLW3lLemXTKtp+bUmzECR054FBOGsXlFfzo3xFhBwNXRJin7wRbq4fndOskDKpfHLIcr7sOdCrni+mV2QzElruKaAxPSzYTR+BtSkNZKv4iHm9/voI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3jPZYLO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739272533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTT52xz0DA74wg1Fq9YWmZolWlBYBYiMJjpLvmR40n8=;
	b=T3jPZYLOik450CzKiVWSpb1ATI197riEyExPNJtv5TNFkeLUR/A5yEoSXDtfjzr+tZhibe
	BYBvkGqMXwidLYiuOh7cPdyWbJUjxXp6qNtVo6BpsQGfwRcZztDabco4oUzHczOXBWzyIM
	py1rO94Nm4xGy3Ib5tbKMuASpWXVs+Y=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-Ugn2AIL9NNu5ygJHZL3FzQ-1; Tue, 11 Feb 2025 06:15:31 -0500
X-MC-Unique: Ugn2AIL9NNu5ygJHZL3FzQ-1
X-Mimecast-MFC-AGG-ID: Ugn2AIL9NNu5ygJHZL3FzQ
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6f6d40a61e7so65850347b3.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 03:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739272530; x=1739877330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTT52xz0DA74wg1Fq9YWmZolWlBYBYiMJjpLvmR40n8=;
        b=CJ5VUR0ihjSgx3UOVkbw0ih/Ffw1kzfL7SlAZXaD5QSAByzSGZU1jcD982gH56+y4N
         DjDiIWVlmVyTmGH2l+pNmitCsaCtj39UMwuNOnt30ZAZu4VEOsN9kp/7e3xjmJ2Fji/T
         vs8WJeubeb3XSVEp85eRoDvIeapQ7+dn0ynZ7K2pjjJLnHZUDt9+XZmhK0IDLbjBUZDK
         p0fEhEisFU3EC/RHi/bx4sfZVpVomRIl3H34njYYAhMifTCCA70ZBCKcGURf1lI1TJ66
         wut/i+/uCDnxivv1VZcxPV7/RB15h+O62K+kg/ejVx0qbexA287DkMm81YXYSFlQIjj/
         aHGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt+aiplYp3qcjuRV1OgFUZQ3lt+jV/tmPYOC7lqEcDQkmDprhdDXqFIJK7N8o0Z/f4U4ncyiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfrxDAdcA0UGmQsUyeCXzxhZBxKN7x6/LsMC2hL1RNcgE7AgY/
	06ggLXxe7MACdNCcWMOjK/i1UvBaq4PJLiG/g8bQKIM8gtqFGQI7Wd7bvGKNKG+OF73Ya5uvz9I
	ibwJ373PXE9ZdOTx8ISBZEDnn6obHRam6vnrSy7CC1Ta93Gcxdt4LwQHhsOC+0MQHIh4ZsWhL45
	hPbCxxOLc11YFL5NikvxWLAsTCHw2X
X-Gm-Gg: ASbGnctYiDlC9zOE3S28zX6qeD0Uk2wt5mc5ao1/AVKGVO3vuhsDF6ehenjpKGMUSgt
	+FPm3Syz1rZ3/aRlsHLhlIlEZqENp93+p5vN5TDz497r0JCqeqA38KDkkCGj3pijD5urFqSaY9L
	OEyk8YebYChFlyptNV
X-Received: by 2002:a05:690c:62c1:b0:6ef:5013:bfd9 with SMTP id 00721157ae682-6f9b2848b45mr165172317b3.10.1739272530407;
        Tue, 11 Feb 2025 03:15:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNF6T2I8g7g0eCN2cY1s9w09QLGZQ32g2apXNz7Z6C1M9fCo1UadwH6c2YV8TO6JEjik4xnO/AMPiw7BaFxTE=
X-Received: by 2002:a05:690c:62c1:b0:6ef:5013:bfd9 with SMTP id
 00721157ae682-6f9b2848b45mr165172257b3.10.1739272530161; Tue, 11 Feb 2025
 03:15:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207121507.94221-1-donald.hunter@gmail.com>
 <20250207121507.94221-11-donald.hunter@gmail.com> <599a281f-d468-4b92-8b15-6f1292888dd9@redhat.com>
In-Reply-To: <599a281f-d468-4b92-8b15-6f1292888dd9@redhat.com>
From: Donald Hunter <donald.hunter@redhat.com>
Date: Tue, 11 Feb 2025 11:15:17 +0000
X-Gm-Features: AWEUYZlorL5Ekx5ZkbVkyzU115bFfmicFvXWD4bbSdvoDWFeQqMhOAs-Co6t8ok
Message-ID: <CAAf2ycnV42g0YHMU9Jdv47J-5p44m2bgj6rjkpxBnXUUrWROzw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 10/10] netlink: specs: wireless: add a spec
 for nl80211
To: Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 10:59, Paolo Abeni <pabeni@redhat.com> wrote:
>
> On 2/7/25 1:15 PM, Donald Hunter wrote:
> > +        type: binary
> > +  -
> > +    name: nl80211-iftype-attrs
>
> I'm unsure if a respin is worth, but the above yields a strange looking
> c-struct name in generated/nl80211-user.h:
>
> struct nl80211_nl80211_iftype_attrs { //...
>
> All the cross-references looks correct, but replacing the above with:
>
> name: iftype-attrs
>
> AFAICS will also generate correct cross-reference and a more usual:
>
> struct nl80211_iftype_attrs { // ...

Yes, well spotted. I'll spin a v5. I've been making the same comment
on other reviews so I definitely need to heed the same advice.

> Also waiting for some explicit ack from wireless.
>
> Cheers,
>
> Paolo
>


