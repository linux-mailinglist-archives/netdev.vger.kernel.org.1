Return-Path: <netdev+bounces-184222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80B9A93EFC
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC34445570
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 20:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B96A22D7A4;
	Fri, 18 Apr 2025 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="karTDHnY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D377521CA16
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745008711; cv=none; b=fSONc8JkXowMsXjgZVRygBHCT+MbzjoWkj+eV/2qYxVy9WC2pPXw6rui2dx9smx7DJpLg02SCK88/RZQo0AMMXjmpCRVXtSbm7pzJrWjatdS8snvHv0z4sT8XauDq3VQY8TPJIjU+BBscw9ndUMrR5mwrWsf6wuJrCssosm3o4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745008711; c=relaxed/simple;
	bh=aIrmqHa5CI0Ak9z+4Zu/VK+4ldcvqolXGgSo1dvYUnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jj9iNJ+f6XpBKn/RP0YJL9BsXderAtOGSlq4Pi/3XsJMlAHTHguGlWTd2ORUeRCcyEa1bKAs/t4aQREk7bsufIY0aikPhw1ESORyybLPsv0tZWg5/winXpEsMc/ln9QaCG+93AIN8Ue/CzpnvZ/kSq5ciB78CRrpKXZxq2dkzLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=karTDHnY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2264c9d0295so233475ad.0
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 13:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745008709; x=1745613509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIrmqHa5CI0Ak9z+4Zu/VK+4ldcvqolXGgSo1dvYUnI=;
        b=karTDHnYkEQPYXOKtu0PYNi9H/uJqHT1JoFxi8baVtVM3w59sa6XqQhJiFCC/fv74G
         gK4abuF68r6c+hWWipvN6rvwL9WRfXAp1tKZC7jdzaszQ2RLCAIB+dscJDWagHzZe8I0
         e9EH7BbVDyex42oqb0Ds69U/4S5I+/uUmLmY3/a0BNECctiYhAjvtmNuZ2BE8zJuP0Aq
         RjzcX8qk2DKybpkpfAGVHq0YfAU9uWzaBu7lWwAvMjAR2ZP8FshKtTVeMV6d+m5mvaEU
         ENRZBIMcj6bXyQOYYOD33p8lDRg0tuKW1YAoiLO7rJKyLSw6M1Fv6YE4JkrkiljuUCmi
         hx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745008709; x=1745613509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIrmqHa5CI0Ak9z+4Zu/VK+4ldcvqolXGgSo1dvYUnI=;
        b=luHKkhV5wouOIzKCfbKJX3B/P9xh7/jbWAk6Enc8h4AGUZvs3Qe1Ib4KstmtVE2HAt
         7zGahlRHh72XXwd6U69MxtU9R+lwuHQw22AzISJw4Hud3MhkGVZg25nObPMslI5aqt4I
         pIQcpXc2VeOZLREipOGsWJvT1I5+TfeRGAog7dD0F3GRSdPmXczcu0N9KHTvaTjHFRS9
         waBoAsu9zN4Tu8Q4kUHJXXn01tIg567YNq+kW5L0OR+xBle9vz8AHDNOkpHRSmqvzKHw
         /HAliyeyvkZJnwSGQOEJjfJuhbKvr7JuGyoH7h4Dvy/1vknBKOt1uisdz0Pdi/JOlsW0
         WX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8RoHFLzN58GWY3/uYhMFpczmVPYVHIm5tOlsn4Ypc6+8iPcYyfa7vZIktL6M+thMBYlqFUvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa/F2hSEOT8U/z0JhEg9oyL3Zl+BDUQVZeDFbnOjcdYYoUjF8e
	lPB37nV5S7zQkLSSz0uBFgq3TG0Icf+yEJdPq9F2Q9L23QFCcf9KJoED0mBLZuhG7ad2wjSK+Vj
	n/7Pv7NMcTokXZBO7pnanHnZibJ4cdBG/FciW
X-Gm-Gg: ASbGnctHR1P+4CJDMdZH1DZX13adwjqR16WQ9HiQ+8o0tEYH6lQ59mrpnvUYwfCPx9f
	88xLrXt3l56lu9I2q9Ds/tCjRcNTqn7FYQOxyGQvBQh7zQZ1FCx7OtCuEg5vRMcULfbRX2oMmIT
	g+D4kK3Tw2zPxdkPsfFZNcf1AfG1epI/WVKo8tOXRuZPx02/K9uYg=
X-Google-Smtp-Source: AGHT+IH1klYyCkFXcPaZVue5xKy10d/vSkMRXSKUHfpo3tJxot4DP+QJE3PeUYfZOOoO25RRiZsfdJYuQJBw3s+VdK4=
X-Received: by 2002:a17:903:3ba4:b0:215:f0c6:4dbf with SMTP id
 d9443c01a7336-22c52a0c583mr3412795ad.14.1745008708836; Fri, 18 Apr 2025
 13:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418015317.1954107-1-kuba@kernel.org> <CAHS8izMnK0C0sQpK+5NoL-ETNjJ+6BUhx_Bgq9drViUaic+W1A@mail.gmail.com>
 <aAJeMtRlBIMGfdN2@mini-arch>
In-Reply-To: <aAJeMtRlBIMGfdN2@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 18 Apr 2025 13:38:14 -0700
X-Gm-Features: ATxdqUHxUhBGMDh3dY4v_VrEW1qW8O-QvzLH8aAvyID5oHvtvm_cIwqSY5ihJRs
Message-ID: <CAHS8izMw=Rfa+AT-xCaUspb-GYvhsE1iugPM=_c-FFD+2KBE7A@mail.gmail.com>
Subject: Re: [PATCH net] net: fix the missing unlock for detached devices
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, jdamato@fastly.com, sdf@fomichev.me, ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 7:14=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 04/18, Mina Almasry wrote:
> > On Thu, Apr 17, 2025 at 6:53=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > The combined condition was left as is when we converted
> > > from __dev_get_by_index() to netdev_get_by_index_lock().
> > > There was no need to undo anything with the former, for
> > > the latter we need an unlock.
> > >
> > > Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> >
> > Reviewed-by: Mina Almasry <almasrymina@google.com>
>
> Mina, the same (unlock netedev on !present) needs to happen for
> https://lore.kernel.org/netdev/20250417231540.2780723-5-almasrymina@googl=
e.com/
>
> Presumably you'll do another repost at some point?

Yes, and there is also a lot going on in that series outside of this
locking point. If the rest of the series looks good and is merged I
can also look into porting this fix to the tx path as a follow up, if
acceptable.

--=20
Thanks,
Mina

