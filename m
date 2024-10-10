Return-Path: <netdev+bounces-134146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC6B9982A8
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5DB1C27891
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAD51BC092;
	Thu, 10 Oct 2024 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yOvtG6VW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156EC10E6
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553462; cv=none; b=LXhZUtAKrVTFwGTJFzuUj9mzPh8t7j9AYu50SjwzBzcs3xAF1gnItx3GqkoaEkdrmOe7XZZQ4i1XGUEt+eQnw0v7PGef2M6ofPTm24yX40Z0WUi1+GAL7ywe+R3b3KtkK+30xNrlA9n0ADLs2Ta/Tyb89LyPpD0Gb7cIfMIAsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553462; c=relaxed/simple;
	bh=ioOMtgF4iRI7DJEO9ScpS4HVBi6d8Xp39Nb6BgI6UIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URhImbT4gLmWCzWzHO1iWVCc+TycPHrLTPE5KwM+cFrNIAp+h67nhoxObBygAIB8452gzkZ6Vnr00k4FtwgEyc/9IacYaCePE+CbeAA4pIvi2222kK9/0KMaR9JmL7fQYMU1Zl4ahtoIfnd1VX5UAxugW7hsc7EhSHI/b85JlvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yOvtG6VW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c91a7141b8so847765a12.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 02:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728553459; x=1729158259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioOMtgF4iRI7DJEO9ScpS4HVBi6d8Xp39Nb6BgI6UIo=;
        b=yOvtG6VWlva/noDj7EIcxgnIfPe+EAnxdpdJAtDaiou/AA5f6eKHWk5BA9b/fiXOaO
         tNm8curTAbBeTfVx7qNieJilyp9I7KlYsU8SSatVoFrI+76wVrnWE+KA4WZ48AdNy1Nd
         ZNzGti9CemvDNmjZpLx41OOtd9xO+Lzbd/RmeYAHIlfEEWSqGZIkl5mp/SXhUeYdKhb5
         uYOXjk38cyJBCDNc+yFF1hsEfZPCzPH+BmilsFC6Mn7O2ILVwb+E6maIcqh3yjW2RteD
         2lo+J2xUofc/1xvdIpiOotyw4R5uh/fbJksZPtqwpBeYHSeoZ+KDqrfwyWm47Fo03CeK
         qWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728553459; x=1729158259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioOMtgF4iRI7DJEO9ScpS4HVBi6d8Xp39Nb6BgI6UIo=;
        b=Dc8iHtstfb/CUvt/QSOKdNVbHelw0ifqqWGB183N+6hx1W7A9oIzjW5yu3dNCzJZsy
         lazyO3nMctf6vwZIRqM9vCX5HJPk+hgNgi+7yYne2YnSlw07FYsK60qT+mRM7v3UAM0w
         2yDy1C+beYMxzdXR2ZjqeRIkUzDbOoxZJnZFFz4AaTs4wqri0nh8IVujLbaNVH9AXCGK
         rVIef6wFzFTmw5NvpDym9O21K0bw+XPZIxm556//2vPr+kIODpKbscGBsBLhezLCFZQQ
         z+oQxJIAcQF0eWSt+U+L3AsKhtvZ+8ColdNjCTL9xYekxfYHbV63q9WuUH+SYw4M7UH3
         igKA==
X-Forwarded-Encrypted: i=1; AJvYcCU0++V1k0CR+SVHSY+vo+cB1EG2h7FCOD1dwdCncKj1NQIqdwhpwiNLwmwGRjqotvs0+G7tYts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwW12r1A2a9bC2Zjpqm2wZaMELgCRRfh4+NBj3UgGonZXNQncA
	PQOmVCbrOhYKRVMma1RtBLrOFJVYVZUjH48Tsna9B7n24c5ntt1EhqNFkCH3kw+UWq1FF2sBKP2
	CL+scyCi0y0YCLH6xNWooU0Rhg0ThnrxfqUWv
X-Google-Smtp-Source: AGHT+IEtGHUFXdjcX5FmSUcZp19tFsE0t1MwX7eQeiJ84hlJ9ecPyWglaG09vGiwOoqx+QQ2V4mBgMjaV2LtxAbhX84=
X-Received: by 2002:a05:6402:2801:b0:5c2:6343:827a with SMTP id
 4fb4d7f45d1cf-5c91d6a198emr4161593a12.32.1728553459146; Thu, 10 Oct 2024
 02:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010090741.1980100-2-stefan.wiehler@nokia.com>
In-Reply-To: <20241010090741.1980100-2-stefan.wiehler@nokia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 11:44:06 +0200
Message-ID: <CANn89iJo-MamXmHi-cZ3m8UwmBzatdaKp-8aMRurH9fBOsQRVw@mail.gmail.com>
Subject: Re: [PATCH net v3 1/4] ip6mr: Lock RCU before ip6mr_get_table() call
 in ip6mr_vif_seq_start()
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:11=E2=80=AFAM Stefan Wiehler
<stefan.wiehler@nokia.com> wrote:
>
> When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
> must be done under RCU or RTNL lock.

Could you add in the changelog that ip6mr_vif_seq_stop() would be called
in the (currently not possible) case ip6mr_vif_seq_start() returns an error=
 ?

>
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

