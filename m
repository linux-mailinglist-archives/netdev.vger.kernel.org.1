Return-Path: <netdev+bounces-244393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1BBCB631B
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 15:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEE26302951F
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 14:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F383A313E27;
	Thu, 11 Dec 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz68JOSC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F1313E1C
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765463085; cv=none; b=KAeI1bw/5yKQU68YNhsxkrajWusamFTYcg4izUFF4S7pGoV9KVVHdyb371cfN+7EjGhm5oX5MsGE7gQ04PdEs3S/WwPhjLz9dFTK8jinYjZ9JcMl6A9uwHWgqgdx0DnKngovV5aEc2UaOlQdlDNIIkx5T3cDoZjdGuBi56+Tc2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765463085; c=relaxed/simple;
	bh=zUD6LA0bua7hKvr5ewBpbls2mSvgWra/2d1IHId67ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkUEJcOrJxonSSnLHtyyJUNPKBcL/iWTHDC2hhVquhUzeS0VUstSG7kBuKL4Qp+Qk5eWSmwio3o39UkvUEJ6jV8PeroJShoSrsmOdslUT/72aNUhwAxc7pd+zS3Q+h3HqvkKJp4VArzuhNfteZIzs3ZLuMidONCk884dvq+pCWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dz68JOSC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so142126b3a.0
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 06:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765463084; x=1766067884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTbqAbpX2i660Tkp2CTPGcx74UKbcfaWWggt71fBPLk=;
        b=Dz68JOSChfIILNFJTEQfVVy0WC6fCTQOIZifVokDdAD7aMgjCR/fxsLdIzK7Tz4m3j
         0vpXVLnePvZVxqTixlfc4dKc9VpMx+lbEumV5ssazqDdUtcNMMSxTlpEK1MGesknVTPU
         PtiqIFHlYFR8/lHIgFcQsiWn01AYQNkqjr1YIz8kBjPxInD3f9LCfAq4h6IR4LjRdJjI
         VrVK3SrhRT8rOaxncZve7iF74RO9+xNKU0zs93kul0sqIisO34o+pZUspeED1qca5mCL
         Iu5kXg2XHfReluFLVJKdrwmqcKj6yIE2uzmxRsl7qBFkHuHIxYJwCvW9/UVO+SKTTx6a
         onsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765463084; x=1766067884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oTbqAbpX2i660Tkp2CTPGcx74UKbcfaWWggt71fBPLk=;
        b=owt3IwVdL2yS0ppGghcMC1yfbuYHQXq22kDRsf9ARPEPH0TJ+6P3+xE8kZSWIP8Fws
         WcUgt77TMrFuo/qjGn6VL1NdzvsIU0rAj1/23/6DCjGv85VZDGJZXXzAEGQSNr4VnEud
         BI5AlhDJMEp0rVieCsROBKfFP0hmZEHuL6QxXd33m6n+4T43n6GN8pmezISiLO2rL2KG
         BntvOGypF80aKXdKCxAmUpYZp+J9JyQ8nJOm72mbbrRAGjOWvZXAaLb3W+TY7gr3iuge
         rNm2H4BO792nXGo0KLISj3BcxV64yMUvnul7hp98vrbHQS5GNAkNb5C+TBGx6rFuz2Ok
         ubPw==
X-Forwarded-Encrypted: i=1; AJvYcCXJtwBhuixBDfB15KdepSE/S3Gx1Dh3pO4Usyb+SFL2oelR2NDSSVyWk3KXC0TCRfe7fFm/kzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDTdIJKnISMtKC4h7F0ZDZ6yNX/ALKpCxjJ4zdCK5WLuDJL9AQ
	XBQpr+NwleWC6CBXE6vO9nytMAsvi56EREll04qDV2U8OmRD+l+NhR+2Y4dynxd77zBIdpK1l/g
	wtBBA80wNId0mxE9PIBAP8iTsCmqqI6o=
X-Gm-Gg: AY/fxX4qVNLOuRPcvfpDKyV6ieWc1Z6ZoaXbcoCQtW2KRn/g36YuyguVLxakKvPGR/K
	XafvPhqcJVMLY60jyDQ5zjybdT4vMdA110NWYK8Kx3qDeficdpyAjJiS7IZvT+DMxBmEFaDQ3b8
	p6wVcFxzzk/QK1Ud0jJAtLwGTJc4PwMOkrdF+pasjUsJMyogrN0c5wWzAva4+/+AsbKKWRy9ldf
	zuWXxf0ujReLcsdM3H4OEcmE045hEYbL9ks5qBvF6hxDDtvi9D5LCXUeW2sk9XOZ9Mb3YE=
X-Google-Smtp-Source: AGHT+IEYwzCJXORePfSiy9K99nWaJEN38X3XUvXrxqEQPw5DPBD4oBHvnP5gkZM8pKqazv1koKEhjS78daPlsbwMq/s=
X-Received: by 2002:a05:6a20:3c8d:b0:366:14af:9bd2 with SMTP id
 adf61e73a8af0-366e31ac1a3mr5953025637.72.1765463083790; Thu, 11 Dec 2025
 06:24:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210081206.1141086-1-kuniyu@google.com>
In-Reply-To: <20251210081206.1141086-1-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 11 Dec 2025 09:24:32 -0500
X-Gm-Features: AQt7F2p4dZt8tsmdfGWJC9UIDaHNz2hwjoWR_9qZfyBAjA1XCYyL5ie0JnIqRAw
Message-ID: <CADvbK_fjBmqwsBXOSJ6pUbrwLjGU891FqZRUppDSHdmgAe+ypg@mail.gmail.com>
Subject: Re: [PATCH v2 net 0/2] sctp: Fix two issues in sctp_clone_sock().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 3:12=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> syzbot reported two issues in sctp_clone_sock().
>
> This series fixes the issues.
>
>
> Changes:
>   v2:
>     Patch 2: Clear inet_opt instead of pktoptions and rxpmtu
>
>   v1: https://lore.kernel.org/netdev/20251208133728.157648-1-kuniyu@googl=
e.com/
>
>
> Kuniyuki Iwashima (2):
>   sctp: Fetch inet6_sk() after setting ->pinet6 in sctp_clone_sock().
>   sctp: Clear inet_opt in sctp_v6_copy_ip_options().
>
>  net/sctp/ipv6.c   | 2 ++
>  net/sctp/socket.c | 7 ++++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> --
> 2.52.0.223.gf5cc29aaa4-goog
>
Acked-by: Xin Long <lucien.xin@gmail.com>

