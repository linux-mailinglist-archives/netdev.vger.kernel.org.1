Return-Path: <netdev+bounces-138310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC719ACEDE
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F631F23D48
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE541BFE06;
	Wed, 23 Oct 2024 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EEXfP4ml"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D991ACDE8
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697634; cv=none; b=oPR2GkNGhU0XLVs8EpQtLN2SAe+I1cd/LycZHoiD7fSMQDePsceK1nnN1Yb8kXRnSV7bZuxflJXEolwm0VC/3ggxFrZ/JJG5e1ADTQVhQr9g4KldOdpKSk81fkkn7A6zRbjCSecQlZtspddDPuESA9rC1eFehC2lUkHTeAsrPfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697634; c=relaxed/simple;
	bh=Q+2VoM/MLo8O96SOQEqsI0cR/1hHy3l67xFHvQiE93k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzgptJzR6DoX2LlcBaEyhy/hUimgw65MYDPXs5Z1RQw43vep+q8L+1oq4JCSyEIS8w0Xcn7MxIL3KUFN3WT0tD5CWF9OXkJahbOquxrxxu5Kcl2HoKzkQdoCoknVP4FiHsRVXZbth+3zmxLpZBfw+RwJw0cZgd7L5a8J/Q65TVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EEXfP4ml; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a156513a1so946938266b.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729697631; x=1730302431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+2VoM/MLo8O96SOQEqsI0cR/1hHy3l67xFHvQiE93k=;
        b=EEXfP4mlGPMPOzxhMs9zf1QTL+lW3EG8vO/beDQRQhpoFTUKG+OdnHaaJL8VG7tQC5
         ZTTCt3B/0077fTQBWkzKgbJYzBxA6BsvHTevh60W4Avyk6tB/w2sKYz/QBTrzZjZzDCp
         5IXbL77sUCSQzm1VbRX5gsHiO6kjEDQjuAzp+Ey42FCjLTAuoYCUAF1vM4tVXFcK5Ziu
         LGcFXquYxzGUpxy9hXo4o5BUKWBypa1c4WUHIgXJs1f0Gb7LG5EzUlw35OCifIHWC+L4
         J4uM62/WL/HkMnZsSn7hPVEbYwopDJJcMQFFFn/OJSX9ilLMarOHhr0aJ3H5nH6huIN9
         5ayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697631; x=1730302431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+2VoM/MLo8O96SOQEqsI0cR/1hHy3l67xFHvQiE93k=;
        b=GQ7ku50uwWjoHCQ3BWMWZO7TMjYJ2hGPbxkSeMzs5pZQTHbvOBZgkJ1LpXQBRL0amb
         68GAxMRdo/Q0UYUmvIfbJ32xvIH1HsvenJBIKy1/RxDwR9zEwrXkX4Shh/pPxWFrw4lJ
         JAUxiHUOkaKB2r+krmBJo5/LTH0rfNyPsO9r9/G0OTBFmYLK7KoNFSqm2XpbqxTYMMed
         ulk9mHa4cZbMxKIZLeV+8jWSv7UqI54mpvIiJWP2gaVU/VtSGoqbf0utwM7p+qDaKf+Y
         Ys8B1SEpNM3QQny2fHK29S9Tnk5KYZ2brRdb92CiR5M36Y3HsNPoTgBeIkrxj/+Cn/cd
         nHxw==
X-Forwarded-Encrypted: i=1; AJvYcCVrQtZk5rpW5eZj8E++6XeDA6KbBidCkHfzgJxqYu/Bph6FELENEfIi4tuzFvNiH+RPAic0SHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBVVwAq694i/07jWYWChyvLR8j1SUwyE+eZRHVhzf9mAVz1p9f
	u17XzEovM9YuTT4WANQ3KHbbnYmnT72+2Od2zN5QYryQu7X8AoVLIyGbEelsKvS12+p006rkpEl
	55hkFUrpyQZh17WFOqv6ottp3818gUwpDIVzL
X-Google-Smtp-Source: AGHT+IGq/+GJvX5+IGL6V6RMrmEnmPtq/nN0ndF4s1FB5ujU8pfj+iYO1mDC0PG4hPesfEbf/zM2DDcgpCtTQCEetTo=
X-Received: by 2002:a17:907:7d94:b0:a9a:1fd2:f668 with SMTP id
 a640c23a62f3a-a9abf874591mr268583266b.19.1729697630857; Wed, 23 Oct 2024
 08:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017183140.43028-1-kuniyu@amazon.com> <20241017183140.43028-9-kuniyu@amazon.com>
In-Reply-To: <20241017183140.43028-9-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Oct 2024 17:33:39 +0200
Message-ID: <CANn89iK+O_Mx8n6yU0cOzq+WV4+Hv4vGQ0gYgWc48hRP+Tgwqg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 8/9] phonet: Convert phonet_routes.lock to spinlock_t.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 8:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> route_doit() calls phonet_route_add() or phonet_route_del()
> for RTM_NEWROUTE or RTM_DELROUTE, respectively.
>
> Both functions only touch phonet_pernet(dev_net(dev))->routes,
> which is currently protected by RTNL and its dedicated mutex,
> phonet_routes.lock.
>
> We will convert route_doit() to RCU and cannot use mutex inside RCU.
>
> Let's convert the mutex to spinlock_t.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

