Return-Path: <netdev+bounces-236433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9D6C3C325
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28B9188AB11
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ABF34402B;
	Thu,  6 Nov 2025 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="frUZZgOk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D7233FE33
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444600; cv=none; b=dp8U3ILZv5MruMSUi0FTXXCkDL1yZITvRJr85JEuDOjCxfTjN6GB8h4MkQNd2W6sQnmP9ATHUAQqQyK5Cj6vMU681qIC/YFY8LNvWbqdbII9g+ngGvpPAKs1F9f9udFPvjUbHbonuE1/FavvGopuHEcmnt8bpsvmjvaFUm4SXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444600; c=relaxed/simple;
	bh=g8AiCJd4Rj9tTeUeL23ATTkGx3PrApL+7L6hu7WWpoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vz/aQhJFFr/GNR8qsWPzdx9Mjsp9GMiR7GkZepdmORNPONFlKBaGZzwdT35Jwor5NN/tOSRiVPQ1U0doivbWdZBuMp76g1ue5tWSYN6yCcqIHhXs2HAOYcL6+qPdiEULxOIT7zihTdyIrbUgBDrnRq0j+AvMlziLK29yh7CuqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=frUZZgOk; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ed65fa5e50so5777171cf.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 07:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762444598; x=1763049398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQlLDOZhUGamhqd3pMIsaftaQsZqtWwuBy/4wJVp4cg=;
        b=frUZZgOk0zqHgq5YjIV+PYbVIM6+6FKzxZ1Yb3Bu2o/X+OS7eCyGPk4eoN7pQZiGvW
         4zvQukqASsoa0f5di2T9OBesm+xPVY12GDOHAGqyrbchbxRvB77AftCEQPJVtyVo+xGt
         gLu5PpYXo2bXY1SAHvQDJcrgLFDATrNnodTVUiK4HdrhFcBIlh7fXHjTJM7PGmeysi8j
         Ul+1J85vVFQ1wuQJz2MLV26vOWzejZs5Rx0ctgtbHTB/jkbztgk3TCKdqhqkAAoIsOKz
         Y9FPA/Y7fLyCllFuODy2kdlpcYZVn+ELCtUAidg1ZySqgTl6mGxhLoLBzeFltVSIghrC
         do4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444598; x=1763049398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQlLDOZhUGamhqd3pMIsaftaQsZqtWwuBy/4wJVp4cg=;
        b=HIzEv791tFSoocKq0Oe0roiMXkFwqCJJMDKyInlmJkySkYsjX7QohNj70yj/sU3+Sg
         IkOuuuuzBJyCo9UM04BAHS1I0nl+g3aGZhqM/64L3yltTEgmcCa6GenVBlxO2z53WPow
         SaN06VOyZjOCs6pLwlmt0BUWvQPOQ+IdJyT52LgYxQEkKARefa2f9+t244YT8ocITIae
         Z7qUXT20Xd2cO8XhOUGo6zWEeGkSlB5FybahZw//4ZdB0Uc3zcR6Edomcc+w6Ay4b44L
         7BkAbXAHsyqxVaL9S2CQF+jEV4iXWTXO2VE9WeVuYEOZgLz4N0i1xLYGpKSqV5J91xXJ
         Ffcw==
X-Gm-Message-State: AOJu0YzdfneGgSYRUg4vV7V9nRUB+yNJb1sgMmISEbb4etAIcCG0Cd3v
	A6gPg2QEoZY59EcZHxCcx06KX7zz2Tblo9OaYex95cFQtoGrygaqWKnPpnavkWqg80F5DqYAAPJ
	3/bAXPeVClpqbgY/BNPQVf6pVi2P8SnVxtvphGZ3v
X-Gm-Gg: ASbGncsau9z3zCd/v0osNPgseuCokcYBsQweZ8T97R5/ISY0wkhOWr8EitiL6QxtZhu
	hbqFU8tqbVHvFvZupYh2nIWDYBtSrMDD66myFb8PE1/PfsSf9YdgXCwKxYN6cjdFlMAjYvNao/O
	Y0v0PdHz8uVzVGDwj+4y1sc3+UMpLmqwnQNLzViGmUnnEu58yFoSJigcnQ2HcgdW2HQyBVwZ2Tg
	VL4R+Ns042dpNZkpR8Bi1dJIhEHthMpdodrC41Uw7Gm8jPLhaV7KB2cz9Z9TvMqqAxwQpwShTNk
	7bKPUw==
X-Google-Smtp-Source: AGHT+IEDLiI0USlA6fWy7LXOe/FGCyS4xbZAtGDW6hpAUv6II51smQOaRiksVrgxmmMZQlDyNd16tiLeCvJWicKtn/o=
X-Received: by 2002:a05:622a:180f:b0:4ed:20f4:15fd with SMTP id
 d75a77b69052e-4ed7265194amr84326701cf.81.1762444597688; Thu, 06 Nov 2025
 07:56:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105161450.1730216-1-skorodumov.dmitry@huawei.com>
 <20251105161450.1730216-7-skorodumov.dmitry@huawei.com> <CANn89i+iq3PVz6_maSeGJT4DxcYfP8sN0_v=DTkin+AMhV-BNA@mail.gmail.com>
 <dfad18c7-0721-486a-bd6e-75107bb54920@huawei.com> <bd0da59d-153f-4930-851a-68117dbcc2de@huawei.com>
In-Reply-To: <bd0da59d-153f-4930-851a-68117dbcc2de@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Nov 2025 07:56:26 -0800
X-Gm-Features: AWmQ_bkf1ZUvgOuppHfnD41rLgZ8c-GgzZsFLM8wiRXDADFT697UgcSJHOFdUeY
Message-ID: <CANn89iKioXqA3vdKdpL9iZYVU0qOPGCKxYiStc=WNWQ3+ARP_w@mail.gmail.com>
Subject: Re: [PATCH net-next 06/14] ipvlan: Support GSO for port -> ipvlan
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	andrey.bokhanko@huawei.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 7:41=E2=80=AFAM Dmitry Skorodumov
<skorodumov.dmitry@huawei.com> wrote:
>
>
> On 05.11.2025 19:58, Dmitry Skorodumov wrote:
> > On 05.11.2025 19:29, Eric Dumazet wrote:
> >> On Wed, Nov 5, 2025 at 8:15=E2=80=AFAM Dmitry Skorodumov
> >> <skorodumov.dmitry@huawei.com> wrote:
> >>> If main port interface supports GSO, we need manually segment
> >>> the skb before forwarding it to ipvlan interface.
> >> Why ?
>
> Hm, really, this patch is not needed at all. tap_handle_frame() already d=
oes everything needed. Looks like I had another trouble and this patch was =
an attempt to fix it.
>
> >> Also I do not see any tests, for the whole series ?
> > Ok, If modules like this have some kind of unit-tests, I should study i=
t and provide it. I haven't seen this as a common practice for most of the =
modules here. So far all testing is made manually (likely this should be de=
scribed anyway)
>
> I see that currently there is no any tests for this ipvlan module (may be=
 I missed something).. Do you have any ideas about tests? I'm a bit  confus=
ed at the moment: designing tests from scratch - this might be a bit tricky=
.
>
> Or it is enough just describe test-cases I checked manually (in some of t=
he patches of the series)?

I have some hard time to figure out why you are changing ipvlan, with
some features that seem quite unrelated.

ipvlan is heavily used by Google, I am quite reluctant to see a huge
chunk of changes that I do not understand, without spending hours on
it.

The MAC-NAT keyword seems more related to a bridge.

