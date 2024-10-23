Return-Path: <netdev+bounces-138306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F18A9ACEC5
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8E42884A0
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26911CACDD;
	Wed, 23 Oct 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qI4tA5+8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60111C243C
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697265; cv=none; b=efjjw0FY0+zTgrKAo04XBlLYYtsrvQ9g+PbdyWsNWxwFgKTg9FzK5PYh6bmy6/JNuZvZU9N9ezrTEEgJCkx73dgznqBQGiXxn8o7AMYZRe9Q8h21q85NnjZ9DXwpc9+yemDeXoB9gkhLyJgD+yTEEoZrmn40KETSedTIfuuVfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697265; c=relaxed/simple;
	bh=d0iT68A8RoT4VphEfTY1GWk3y5O3IwEokqbwYIbO1Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6a9YYP36CVDsoGGstwc24H3jYzEN7TUwl5hRRlz8S7BP1Br0E74eyPmU1lMgp8cz7GonVCw4VgTI5iTOQCzg29bSCV2E70h7mPd2LxJRX/7S8OXnILR8G45RTypK1tVRzUMwxoYNbC9y7RC2g8sphttYmSA+oSIa5C60THvmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qI4tA5+8; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so8103026e87.1
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729697262; x=1730302062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0iT68A8RoT4VphEfTY1GWk3y5O3IwEokqbwYIbO1Z4=;
        b=qI4tA5+808ri3bTSrgHaifDIzQu7xF99H+6tHYekQBQ8bD/dX1E2PXI+Tk1aLljLb6
         5wbPhx4wdIjdkC0D+bvWnrEx9NKRN3VKQ+kOfs6xXlxwRkwMHENtEfKwEeFzANoibsjb
         rzEZHkW0tX06U9WKp2b07cGSruvIXXdQ1EHfMvP/OtZuNsV1vNvJcTgvJV9YBdJpdg9c
         OmSdgCrj6h5cccrGBlEPPcp9w5Ly2A2b3QZl+h2PaJqqT7Yd1JlHVYCpkTdRXHwEOe+m
         D8OIpIHjrGl+SrJqh+OB564Y8bSdFk8Ix+Er1vaJ+uMia84sl6CFT+xvXgsvB2E+9/2K
         LLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697262; x=1730302062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0iT68A8RoT4VphEfTY1GWk3y5O3IwEokqbwYIbO1Z4=;
        b=qvlid09EzjBX5liB6YRwZWyn3g4zj+cP0vppSKCggyMLn/x7hhy1Z9nW03ysFtwxhr
         U/TK04j7DAWNbqVS+rVHNUdBImsXrI8R3/oHBl3R92n6QctR7IHeLwSGkAxQ+ik93T65
         wL1NkR/PZ9PGvPJHVVLb4W/c74FbbrgBIOerLlJLVy1etq23MEOeoUBErmT8bh0JnHc3
         Qi9F/e/52gp4JyKS82n3I3Z8OH7Gr1KJBOBJ1JGQhXNYC4NtIrTNkUNFdwRO7CH42lv5
         9toW88TSh1KuVawI1fnhyS/5U/QnJePGKq54rvFtdQdeW5SFDCxOoUNEsxZBKlZw+6dx
         /Nug==
X-Forwarded-Encrypted: i=1; AJvYcCXpKmowcq0CoOTSyKtzGmMHwbBLZmP8/euFHDEbDT4BrYogPoAg35H3ACwzchjSAd2pM56B+Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz64a141InF6Ns/GlOS0KfV9jfFWuZ4FvW8mbp+8Vy70qs57dVV
	57A6bgaA6DFleImIZdUEbjMYlcCOo+hGM/iz0pIKob037C+FT2ubXhLpxClemrrN6wxaW36hoDa
	TKTH6sBodEd8jrjOIuT2XrBEhCFZWPAcSMS6Q
X-Google-Smtp-Source: AGHT+IFgu7kMknEjLuKf2k3FXF7Ft6kH9tj1SEzjHxDHhcyZBbjMS3dYLUzrinjnWaysSZblFdNODNeTWpL7UZxpoQI=
X-Received: by 2002:a05:6512:3e0d:b0:52e:9fe0:bee4 with SMTP id
 2adb3069b0e04-53b1a2fe533mr1821786e87.9.1729697261799; Wed, 23 Oct 2024
 08:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017183140.43028-1-kuniyu@amazon.com> <20241017183140.43028-5-kuniyu@amazon.com>
In-Reply-To: <20241017183140.43028-5-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Oct 2024 17:27:30 +0200
Message-ID: <CANn89i+4r32wWZt-+A-Z1k=6G7VNqnrFMk41PCLWuax9w1zB3A@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 4/9] phonet: Don't hold RTNL for addr_doit().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 8:33=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Now only __dev_get_by_index() depends on RTNL in addr_doit().
>
> Let's use dev_get_by_index_rcu() and register addr_doit() with
> RTNL_FLAG_DOIT_UNLOCKED.
>
> While at it, I changed phonet_rtnl_msg_handlers[]'s init to C99
> style like other core networking code.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

