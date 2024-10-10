Return-Path: <netdev+bounces-134229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C68C998743
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE831F24AC7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D081C8FC7;
	Thu, 10 Oct 2024 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qqI0jh5C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67D31C8FD2
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565911; cv=none; b=QpkvSPtTv5zF0uaZJ3FOhLvHV+kXKzoTeXlcSoXl2Jmpd4AwEDQDTjOxEXVf+UIv/og2Z1GdJzGB7JreGYUuHePX7o0A+B+X/KUuKI7sJVM4sY9uDfgQPhXOuz+E268MCtOVAWlEU/kUtbcmzzB1hGcdJrxIs5kQPKDy1UzHVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565911; c=relaxed/simple;
	bh=ZQ1RyjMBqULNdGtDpxmOq+QP+bWW+3BAqmk44xXNKmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2FmQCM1cEmxlVdA/1OuV4cmrZI3IrgcL48k4DNH1NP4f3y+73j7BZClz90EoESRfueK1x6xufFwLPYmuPbpJ+LjHUR+/JBqjcz6IoM75otE+vH8XhuMSARpwbEgN4/KoHACzf5zB2Re0yHusiKw9BNx3rBIBUUlxUqwx9rGQDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qqI0jh5C; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c91c8b868bso570049a12.2
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 06:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728565908; x=1729170708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQ1RyjMBqULNdGtDpxmOq+QP+bWW+3BAqmk44xXNKmY=;
        b=qqI0jh5Ckq43p3iEU5rBw/lXjpvTP8roNx47rwkrtaophsddIQt0cPasehoB5KNh+3
         CI/fWINA2TYCjCALAEASUnPuSjs7twa4fCkGlVZPtS91HM1H70LQMCO2/JMP/kckkJp3
         DT0bvWZCanijX6kjv4UvJZU+sktWZl7TmRKS7KbB8RBCqmPjEvruCgOsWjv1d0Wf/Yb7
         YI9M82/Bv7+gI4wPcXgJquFzNg4zdrGo7wEjhwOx0tjp9ZtVrYuW3l0qNWieO0YjqTmu
         HhYdaaue1GZIOHml76smmJjtjQepdeaynCLoaY60F/W/+T69qIdVWE8OsC4SZiYjXm4u
         YCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565908; x=1729170708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQ1RyjMBqULNdGtDpxmOq+QP+bWW+3BAqmk44xXNKmY=;
        b=FMaOUCGQIuCgkGOBTHj3dZ/UbO9rQskOPALk9s0yUQy9BaHqqODR5kLdjMegpKTpHH
         ZOCVNyJJh30aSHSRtm4iv5wgzD478ROPf7yhMq0/7wTZu4a5CZyq96mGt8Bs2jhGLgBQ
         FN33KQeyUYhgU9ubj1kh13yHATHTLSsY5p1gW6wR10Os1QK8c3O3A3Gm+rTSn9TrDWM4
         Y/WL9BDxLxeHZgJxZfiQOVpvRCQeygpL7B+lN3t2QArX5Fz2yF/IIKclt+8Wl8qE4YCi
         TQJBFJagN7C1VKQ2Ulws+Vbj6CppxCkKFvb9c+bhWN7vjQxxIQklhQTIqvJAwiccvqpu
         +ALA==
X-Forwarded-Encrypted: i=1; AJvYcCVuY0vLPeDk8CfuOm82FQcvTypREUM6CMDvscQUoYSjY3891Wf3j31pgGCupoSEyuFGDjZ4geA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKwIVjoV+RCV+f2rqYKDkZbLnb2WhY1P98WCvjnbdfBxV7/yVt
	3semOqR4aQ84DqXOYjOPWwa7v4expQq6Aylc5kX3qQtlloG6mr3OwV2+IoqehXnf3UPfPdVKtIp
	dG85Y1PoZkSb/l3bhv3/YQJdvNV0766/lfD9z
X-Google-Smtp-Source: AGHT+IGvozO9QPimRMgm0evh2lgkqgSUKXnK/Kcoa2QCalNU33BqzdbygG93V6oVN4aa81rxjwz7XyssEoKGzHtQo9Q=
X-Received: by 2002:a05:6402:2790:b0:5c9:44bc:f9b3 with SMTP id
 4fb4d7f45d1cf-5c944bcffd9mr95474a12.11.1728565907748; Thu, 10 Oct 2024
 06:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009231656.57830-1-kuniyu@amazon.com> <20241009231656.57830-12-kuniyu@amazon.com>
In-Reply-To: <20241009231656.57830-12-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 15:11:36 +0200
Message-ID: <CANn89iJEuH5n=Okh+szQxcQU6+CyJiQD-AjmUE6M+-GiAh2ihQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 11/13] rtnetlink: Clean up rtnl_setlink().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:20=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will push RTNL down to rtnl_setlink().
>
> Let's unify the error path to make it easy to place rtnl_net_lock().
>
> While at it, keep the variables in reverse xmas order.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

