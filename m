Return-Path: <netdev+bounces-141919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A5D9BCA67
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5F71F249A7
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CA41D2226;
	Tue,  5 Nov 2024 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="riv+4i00"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAFF1D172E
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802296; cv=none; b=tA/CFdMEnZBXN+rW252wj0OqLz7v/RNUSaWDoH1QEWLzHtEH7KAFGKSke07BilagfqqANrmVjoVHx1xoBwinpqjl9lMPcJ/OMJCD80AOodPvGiemnDDMq4I+B/GwsAsZpp5krj03cOgNg4NuQHegOdxvJF/hjB7S4/sqeJQS4R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802296; c=relaxed/simple;
	bh=xVRP5kM93l81haHwJVkwvHgGgEn4zKQtikbGrBnvmqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQSSCz21y++ECh5UD/zOUX8+f/BUj2XuF8NcsLJE4HP3xN2ZrLaxqrQ0iDf5jdctm7sqgOe5UbOB9SqOBE4wBtmNx8sdBOB5b/ECckYz6QLmRl5pK8bXxaNleRZk6TBQTHMaQgmOixp1EF0lnnCl44BA5SzLeGe+Q/M3jFxioMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=riv+4i00; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c948c41edeso6658421a12.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 02:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730802293; x=1731407093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVRP5kM93l81haHwJVkwvHgGgEn4zKQtikbGrBnvmqE=;
        b=riv+4i00/0bDSC6zzcdPpw9k5iC1ujrewIBwz/uHcNYrvnja6cMX+OlHPsv+w+O0a5
         p2CscOhk+mVevFY5ZsGkwbYRee5OJ1jKZiGLtNCcQu/jy264k+BRxZ+maNjCkygh2fJN
         myyqG2tZu8bwd9lc8/zrU//vbpzmSB6Goxd4Fv+MrnRyfz6Kx8wyPdFjqWLbJR3AwZ5q
         QtnRQkLUDkRHz0xFeWA2slANx0fv7BqAfVZK8vVcFjOZ1h65Zla7pXiCRgelLy5Ulybj
         1WdTiUS4RnP33SVNTKOlK54bqkD+Qie6Sy6Oq11Q7zlm8dNatF2VXPGfsftXkszBXCRA
         /XyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730802293; x=1731407093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVRP5kM93l81haHwJVkwvHgGgEn4zKQtikbGrBnvmqE=;
        b=cI33MkOe3qnmxk4MgSQa2+EDvm4TAk+PcLUZQuO1W5gruz8BJDvvhsd51A/XkHQ0y0
         0+AdsKDQhxNyFdfqXJD7Tx9AW61YmveyV7BwYqRT7TCoHBKy41Cb38bwEl3gAZzllAK5
         mBFWwoscyvGaAboTP/tMj95CqlzlB9xilELSi2R36WrPvFYntKkx0Xev30Ckg6Jk80yr
         pBdoLnpiq71iet/S6lBpFPgSGPnwERJoInKDnruPsaPBSk51dhOFopzKB9NmLy9YjVc1
         Unh0+ivCZ7Exyz43QEMeak+nBfNvd74spS+gc6jTzoFeAF2kalsjy8XteLHNQQj1ID4D
         +Zqg==
X-Forwarded-Encrypted: i=1; AJvYcCVMP+OerHzY3Gtboyw96PffIuYYyhyeycaWJ3djFP/UpVL5AS+o/aVlymU9+/LCMLuWxxiTXgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd6luO0aobpDkiaW088/YghbE/srVxHW8uO0YN/At6QFJtlmyB
	RSoBRlYH8aR5Cu2nQAgCrSlZr+l0q0BJ53Nllk9lntAiKKGHEyuFuwUT+7kQbtSoVnHeBguHHdn
	hpBmorgQWTImhBbB5lLM1lIhxODZJNcE8xbBY
X-Google-Smtp-Source: AGHT+IGav+01LLzLPgUlbsXGKFN5KU0TonGBI6XXL5wW0UOS3XdwCA/HzMmqccgAIsCgcXFcW2Nhvo6hErWPp6uYNXs=
X-Received: by 2002:a05:6402:84f:b0:5ce:d43c:70a8 with SMTP id
 4fb4d7f45d1cf-5ced43c71a5mr5347172a12.25.1730802293391; Tue, 05 Nov 2024
 02:24:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105020514.41963-1-kuniyu@amazon.com> <20241105020514.41963-5-kuniyu@amazon.com>
In-Reply-To: <20241105020514.41963-5-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 11:24:42 +0100
Message-ID: <CANn89iJqXG6se6tZZCEg1Wfk+pC8HBi_KhRBJo_zmCPTK7qeZw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 4/8] veth: Set VETH_INFO_PEER to veth_link_ops.peer_type.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Daniel Borkmann <daniel@iogearbox.net>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:06=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> For per-netns RTNL, we need to prefetch the peer device's netns.
>
> Let's set rtnl_link_ops.peer_type and accordingly remove duplicated
> validation in ->newlink().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

 Reviewed-by: Eric Dumazet <edumazet@google.com>

