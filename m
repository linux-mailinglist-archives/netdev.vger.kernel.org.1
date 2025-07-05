Return-Path: <netdev+bounces-204307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A5CAFA073
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 16:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498ED1C2693F
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 14:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20781CAA65;
	Sat,  5 Jul 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSmLw/Lh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86CA19B5A7;
	Sat,  5 Jul 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751725363; cv=none; b=VcLy57NZCwskeuVk6GlDD5lkoRRWs+R5Cz7nx3cclC7tXQo54eJOVk34mkyTH266jzCYuKtoWmTgZWlyd4c347d7jR/aLdXi7jRx9htJs5WdbC24udO/Lzr4uYdndzpfBfFa8GcjNBmjdjD1q+zF+vw9VWdXFyxn/MFoz44Onxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751725363; c=relaxed/simple;
	bh=EKnvJSsHM8ulrLq2cUyRJJRTRCaqjDuz6/x0xf/Ok1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCCgJVW2bvdOwIU9HxAcmKGQjjts7IHpDVTy3QhmaGZFS4M6aEPoAjVFpZclcQZXviCBPIb/6nTgB8Cm7BdUB0ZXB1nquMy839G9W1uatHKE9pgCOr8pvfN11B4HxuCRDWGsvBDRjzKzkBYIm4tQsd4DlzSOeMJ2s6pHdmsuBK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSmLw/Lh; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b3c292bb4so15112831fa.1;
        Sat, 05 Jul 2025 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751725360; x=1752330160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKnvJSsHM8ulrLq2cUyRJJRTRCaqjDuz6/x0xf/Ok1o=;
        b=NSmLw/Lh3f60MDGShQYUtxyOWFovFtSkDvQjX8roPslfPRLJZwSiTrHoDYLorLrG/J
         hwluXnqjb2fOUbPQCD4InHZ5LYpYfQavtmAqQl5kg/8PalqomplDjJdt3R7MXljuI/vL
         Tj9Z2EpN8yBs3oJjpJxRvA8i+lB/Hq3k/d/uAlVX0JjQ61sC0NDIOcAEi7YrYanAUI8k
         +5vq+uTsFyfiNHJr+cF+OmFIXfITu65e3JW/6dKWqJiFC4PTg+CbNSFowVV61qkKbsab
         lD585FjqovDgtDhXcFy+54WnsVmsGQTw9ctSgJKke/DNXg3YCIkbu3LYK4YLBiydaDwH
         IA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751725360; x=1752330160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKnvJSsHM8ulrLq2cUyRJJRTRCaqjDuz6/x0xf/Ok1o=;
        b=YxRnS6NR+SF/DrCHIgNBFpw/IFSRY6ioTpVUSwRG7HkJLZqd+Kug8JyYcStF3/ndSh
         5GgWvYRU8l2fong+6hDYvt/SmuJL6vS2BMZ1/WoDtNSN2IkNSJ0hWK7hYAXpq1RUtwHd
         ZXggXix93Hz6bUrTZxpPZv2kt6J5hMQBg5ghR+Ignbeu1g9zwCTsxtGGiBrzmSf/qX8O
         taS7PSSkIqsfPb5EKsTEj7MqMIxepH96+kOW85umBj68rn3f4uG1xN5xl8JuP+Y3ZoKC
         PhKYZ/VGFdvd7rGMGtU3RKd4TZG03U4QS0prsayVK6micDyTt53TNBBl6Pd/horlH64E
         79kw==
X-Forwarded-Encrypted: i=1; AJvYcCUEtE5mmYRUHhAovZVdXnbjkR7OZ1GklhPzi2Jc882J+b0xiMIW6sdSw2Gkw9fk7aFTFHCDNSM7@vger.kernel.org, AJvYcCVFAVocGMeEm38Es0WEg4XMcQNtw5lT2XeMoNfBVhyDPIGsb/xn0zEJKy2tSVNROOtJZvSZFpaRyHjQ0bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhpzTrEsPEIVZegXoWH9Mv/Bjt7TqWg27mjoEvs1kE3Zc8K/UP
	jqB/1k/tgCAmiQYwFuSGv9f7otEdB6gG/AkkwiUFQ2p/l+NP7oCWIK7r0w0E5+n5yb/D58shXkw
	Lo+TrrtcI8uQUuMGHHfKvEAkzHHlRS4Z8QV48lXM=
X-Gm-Gg: ASbGncsXIVq8RJXNqCgbbfqJLOx9K0tLLRt5A2YX7+Ex00dkVY4Mf12B7wlKE06F/Pp
	6oX0TuQ8gvRdwC6O/jjk+HqyfxlLkZb5/8KPIfqXv9oxUH9yhlNNUGktqejfF8FAMxg5DOJEgGJ
	KzVF8xMHuqHWenR01mH9M9fGOQU9awGh3KoEPi+JU2GO5dFLTXuiQwo2iJgrGvevdMuOHc4bNu8
	bAX
X-Google-Smtp-Source: AGHT+IGuIQlSO3797vvLGrll9LAZKYQKZplapMq9u69AfgtSc7RATXdK57f65U7ENb+iG1b1TyqYhaomusbYbquohcc=
X-Received: by 2002:a05:651c:889:b0:32b:3ca0:dbe3 with SMTP id
 38308e7fff4ca-32f199c75f9mr4452501fa.15.1751725359675; Sat, 05 Jul 2025
 07:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612114859.2163-1-pranav.tyagi03@gmail.com> <20250613181624.5684fc0b@kernel.org>
In-Reply-To: <20250613181624.5684fc0b@kernel.org>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Sat, 5 Jul 2025 19:52:28 +0530
X-Gm-Features: Ac12FXym_sLRKnvpL4ehI5Xa8tsBnF156fVik9VwPt420tw7zcBjXtJXW6zf9Q8
Message-ID: <CAH4c4jJHiacPDWSS_S17WpAqkRNKBi7P=9f_QJdc8Cs=A4Zhhw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net: ipconfig: replace strncpy with strscpy
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, skhan@linuxfoundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 6:46=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 12 Jun 2025 17:18:59 +0530 Pranav Tyagi wrote:
> > Replace the deprecated strncpy() with strscpy() as the destination
> > buffer is NUL-terminated and does not require any
> > trailing NUL-padding. Also increase the length to 252
> > as NUL-termination is guaranteed.
>
> Petr is making functional changes to this code:
> https://lore.kernel.org/all/20250610143504.731114-1-petr.zejdl@cern.ch/
> Please repost once his work is merged to avoid unnecessary conflicts
> --
> pw-bot: defer

Hi,

I hope you're doing well.

I noticed that Petr=E2=80=99s patch has not seen any updates for some time =
now.
I wanted to kindly ask if it would be appropriate to repost my patch
at this point
or if I should continue to wait until his changes are merged.

Thank you for your time and guidance.

Regards
Pranav Tyagi

