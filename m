Return-Path: <netdev+bounces-141924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA859BCA9B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B1C1F21B84
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932341D14EC;
	Tue,  5 Nov 2024 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NAy73WNk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF85E2EB1F
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803044; cv=none; b=INXf1NZs/ZHmCUH0bwp3vXJa8ISK/ACF+9aRUbMbltH+20O1It5FkcrB09KldtYJH3K0iVbBdK1OsYMbTpwJnra/exMrJRVBLc0LOPFAE9q94G4H3WnKne/B6+ClJaQZhGmhx7yY7muMydCOFlt3VniCfjLuXgAierrjA1agSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803044; c=relaxed/simple;
	bh=NdjzSwqfafhQlpN/PcuPcYfDIfEo6J3F7W9Rb59149g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HG12pUIWUc1arM887qk3RkLpoEwg7A8ZioQbKaWrOCrsB5rtU5hUi4GDDg8EbN03G+ktHV57S+LdfBen/hPxhFox39e2JxWuqU74yxDV2ZCuDIUiXPQ79R7wiRnaWAYg/ipSc7W13+QOUs2edEzjeTA4S9QjbzuyI1ZglHYynww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NAy73WNk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso9732035a12.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 02:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730803041; x=1731407841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdjzSwqfafhQlpN/PcuPcYfDIfEo6J3F7W9Rb59149g=;
        b=NAy73WNkR635vA9Q94YfXOshbwg9WbEfZfkgCqon0pplVUqG/g9IIYX24MF8X9d24X
         ggcCPxRQlRqdLghu5G6aXcgbR+hK0l/OUXmNXT3RCsVKyHpnAxPSYs1gATYN+V82h7kg
         9Dw3FgutZsa8wSyu6J0JIShy24/9OGWrmdaBr+4jCOfvmQG60PvB6CwvR7ttb9dqXCbF
         yR5hq/79XYjEkaKZdgerjaV7ajWuvlJAAU6Ppj3BdE6Ew6/V/VejNu2P1gsQ51Q5aa36
         XMd5T2BycrAe8oCG4Tf4MUym6fTI6MlZcznMXRnRKo3wD5wonOPui5poNqaK9/G8FiJd
         V/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730803041; x=1731407841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdjzSwqfafhQlpN/PcuPcYfDIfEo6J3F7W9Rb59149g=;
        b=ql+l9Avga2WjnBeBQdIGP5OcZQQC8FvWwIjlE26pu23t2f4poB4AvA7jt9rqHtJ6mW
         kxtT5fZWF00YZaiU2NDXYCMA1+GbkKUoF2uC9P6i85086bTi3Zf0q/f79KUqQw5NAt8r
         29yPpOXdZSa48nAlYpv2zDxNQYwt+UHRqIiqZuUFQH2zJIJghJnzd4EAj0I1McTseuXa
         RpojA7Qx0MKqp0g4E+JMIl0sIMkHpJ0FHIR+3B9qCgy3n9FzIvUwKpjNeC0eqLK9EDph
         dMvM7MbXJux5Z6QjlUqBPMLFAO+cfzrp1P4xXHWUhvJXDOIdCu5fFKp6sIDWsASacSEp
         teaA==
X-Forwarded-Encrypted: i=1; AJvYcCVQAbzq/iS8cJBtcLzU6yU5nRoVm4ktnmsTQdfiunLFZo0P4IhX8fyWoDWroOsEQ2LXS/Opelk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVJCUi4bVp8Vrg6g4aC+MzC1IOwbyZkgVsYbbb8aFKWHHSy4C6
	xFdA5IMQYOkGDIeC1iXst8BEVipIAyTe6kmsuqtUW6HLLRr7/iA+R19JNSTh1nxaHM/QPPtApw0
	ku5cySieMoNM7FsTPVlqypMX1bAClt/6IlOjV
X-Google-Smtp-Source: AGHT+IFKsv9oP7aqZSuiQs2YxQ2RG1Fyevc9h1rTp/VXsVXWZsrRLXT/a3j+TsgZSPfZslyoH4oL5nfZlQ1YJp69AIA=
X-Received: by 2002:a05:6402:26d4:b0:5ca:1598:195b with SMTP id
 4fb4d7f45d1cf-5cea971b9dfmr16045080a12.28.1730803040997; Tue, 05 Nov 2024
 02:37:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105020514.41963-1-kuniyu@amazon.com> <20241105020514.41963-6-kuniyu@amazon.com>
In-Reply-To: <20241105020514.41963-6-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 11:37:09 +0100
Message-ID: <CANn89iJXGHXucKA7MzSsGEKkDOic6zhTio7i5Q6yo7KMzEUw4w@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 5/8] vxcan: Set VXCAN_INFO_PEER to vxcan_link_ops.peer_type.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Daniel Borkmann <daniel@iogearbox.net>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:07=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> For per-netns RTNL, we need to prefetch the peer device's netns.
>
> Let's set rtnl_link_ops.peer_type and accordingly remove duplicated
> validation in ->newlink().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

 Reviewed-by: Eric Dumazet <edumazet@google.com>

