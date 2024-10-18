Return-Path: <netdev+bounces-137014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538EC9A4068
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813861C20A81
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892A3433B5;
	Fri, 18 Oct 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZ4/rGI0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750E0134AC
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259488; cv=none; b=lujZm/aNyF7EIHwaaKshA1MoG1W1rxk9FewnsBM2dzVaEJVXOiEz1+e0obJNWMZ72k4Knn90Kj6dVXSFL6nKiuUgw8Bg4JEpbydWcRKzz/fSicRYiWFYMA52sUns48YSZfISWqo3PApQrNy8QF0fMcgu5c0Z/VLJq+LSBwhk6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259488; c=relaxed/simple;
	bh=exv1BTy98sa1y/lvuA8F2fs9zUiP0rkkEeMaJqR9BE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDkrPtiV+Oe4cR1FaS/Q4QdwEkDbYd8r/rNQBAGQQxnl7WUsdqKZ1RM/8yIkiyuNAuP5RE4FtWqcnfUIHWD7KKfous6boEyzGYeNkpq1QNrMNnz4hYgUI3cx69hQPIUkcRhWGNP3a4o+nnF+xLXMlaYELCuSrgZrDWJNqLoaQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eZ4/rGI0; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb5638dd57so24997051fa.0
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729259484; x=1729864284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oGOELg0HkqjvEjXJZWT8W42hTSmZ6DSm6t/xkBqV7U=;
        b=eZ4/rGI0TQ3p1pbJFB2QG94QsPvvpKcazaabaW8KF9+EldLSDNlix1CMHdTX6jy2Nz
         8zl54gviJSr74+bqCbGRVgIdLXn07/yXdznTgF5gFa2efxDqljTr+TKTl/uoDRm5DXdz
         3ohgI/jYRjG6QM18m4Az321abkiNTxpRMAOi/KAiIptRTxUlEH+dQ4LA+cLfnBS6lrp+
         gLjyjMlthZ51N6bRyShsycxX6YHuLkE77dyJZhKvQAJXcGgUG46gRLUfbOxE2rEU2ApO
         nsmMMLt5A6A5LeqnhemkFbpniYoT1pfzzjw1VRgd3Cie3q3EpdOZvu6/wHgqlrF0hjhO
         eDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729259484; x=1729864284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oGOELg0HkqjvEjXJZWT8W42hTSmZ6DSm6t/xkBqV7U=;
        b=Tx/EFFgGIQNRCz40SDEUS+hBip17pE6SapF8pAMn5pCbDbZ01/HlsLEHYBrjXd0eU1
         tehzg4Q6dNk8hWTqHx9OuFidUpc+Y+zuziKKjxTh2ycnOpeTwYYBCC0Vl8wfy6orqyj/
         hLF9hh7m9/hBQXkv6soV3CNhjgFLele4ECy4wUK1jgb4vbmxqS9yMhstAelAf/lYgRAQ
         D7n58A4dsDCNXBQUITGcTUeqlf6qycXmAsP3Bcul8oGJ8d+jZHehhmMzQZIVLT5p5BoE
         p56Bz3t/xiauB+ZE4Kl0M9CBSl3x0BmJK0WyDoXKydsJWXWNUWqaNn9SBmQ8/1FcMEy9
         8Gxw==
X-Forwarded-Encrypted: i=1; AJvYcCW94DeMhMRn6Y5gf/Y7pfsSIcMVEib5CSI0ASm6MP8ZPjO7wGb/AFrvFKhp3php9vAtnDWwD3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1hxv4TESSkEHB6p1PHKFd38hKTMEyJlK/DQQPgzX1gR+IrZLK
	47/dyfJTc4vMxT2OlGZNWFDkaWbXbT9I0YY48jt073xuA2RXVN+qZkZkUtsTNc/Y6DQaxcEPFIW
	rCXcv8LhSXrnsv8WpNyly9dJj8hSG/QiLQyZZ
X-Google-Smtp-Source: AGHT+IE5VAn6ABOKKaNwRCen6TFqgIVntGzwdu/403lclJv6MfpiI8yEO/nJ4AVGwvWgJDpOqacKOh27eOWHupEwysU=
X-Received: by 2002:a2e:a987:0:b0:2fa:ddb5:77f4 with SMTP id
 38308e7fff4ca-2fb832221e7mr11369641fa.38.1729259484252; Fri, 18 Oct 2024
 06:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018012225.90409-1-kuniyu@amazon.com> <20241018012225.90409-4-kuniyu@amazon.com>
In-Reply-To: <20241018012225.90409-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 18 Oct 2024 15:51:12 +0200
Message-ID: <CANn89iJjVwaHOUXDVyaPOHjpkpY+EowKHcVubzbCT=T6ZBvMcw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 03/11] ipv4: Don't allocate ifa for 0.0.0.0 in inet_rtm_newaddr().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:23=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> When we pass 0.0.0.0 to __inet_insert_ifa(), it frees ifa and returns 0.
>
> We can do this check much earlier for RTM_NEWADDR even before allocating
> struct in_ifaddr.
>
> Let's move the validation to
>
>   1. inet_insert_ifa() for ioctl()
>   2. inet_rtm_newaddr() for RTM_NEWADDR
>
> Now, we can remove the same check in find_matching_ifa().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

