Return-Path: <netdev+bounces-164868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E76E5A2F7B9
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97DA4163B19
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 18:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C6025E441;
	Mon, 10 Feb 2025 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdC6QlkQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40E68F58
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739213233; cv=none; b=jTRgDmJbyfGiOGeZXe69jzDtfXg4I7iWJe85ZP7X2E5DyWXta3uUqmozHHCgG3RmHUPya4uI+yguGWE6kzlPgCWiKz4ilN53v6yAkfJ82aJBh1vCz2e3O7F+dZPZzUZecx8BG2H0927dgThcfUCJ7NLtj1ULEnBPShjD5Zmf05I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739213233; c=relaxed/simple;
	bh=L/4X1QVHdPJnAgQn8Zmsmi7Pq/GURTFwuXIZWt6jh+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPV4NBnVr7j8RtReGCRcmOa1Z2nE/yen4VCDDPqpSsrcVxynQqaOO3Y21/5hjDVeF0+GfiDlZaZO5btVpzr7tN4YV4f0jNyv5Azs26s63O1aJZ0YkuKdT8vw3UlCthF2cvixoCNvt+sX/FcZzr5guWcrICF2bjPPWj3lDQsCD2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jdC6QlkQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab795ebaa02so552590366b.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739213230; x=1739818030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aa7IoWJm/gaUOCIuNUD+cXQBSdBbiOOIYgRungz4zk=;
        b=jdC6QlkQCZgXXRAj4q2Te9DEDWDrsu/I9e1ft5fzmUDw/ruc6khXFZgBfl5mhEDbzl
         Mj+ZiZWhU0jp+f+9mqLi9kSdFrRH0eqQz9YKk0wJ/qAj0S5IIzXQiD7oxcbsbyoW3EWH
         ZqZWWntolT9OyoANEz3hWXo25bB22dLRhP2QBs6SebhWnIw0HPcRvwHztSANuTgKjyDA
         ztIF1VQVqgL2xhTOyETjQyNrC+vCCA+s0NE5NBhcBbukSGhfJ3VowGerj+B+DcrbQWD3
         O9F4q6HdvyJbGrbn2DiaQCHrA7qBdBA4rX4a/A2kmtrtinw1czWqL7JYM99bOX5xwbID
         MMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739213230; x=1739818030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aa7IoWJm/gaUOCIuNUD+cXQBSdBbiOOIYgRungz4zk=;
        b=IMu+j/YdQcGYFqAIhl6f5mGq1lzlqs0PtSC5CZo/JdvVgHSLggJk4cdo64k1XSglEz
         Zn/o+BTDpYD2mL/ABQxeM95wmZBerElEujUW+A+K9IZVruG/pZWuJRgnLithmmmKi9i3
         77aKYI+lN71J7q/xLyW/H8vhauSha4UHjhcIfZn628/7XKnULE7THlBFmXDWbDnGUbnb
         CfxHfz7vL0BKa3qKClLxOOQCIbkFt98Vgqwbywy7965qJLT2NYx4eMLJVprcBiLlIGAD
         J1ocBKpgR5YZHwc/5WCZfjK1vVxGdGGiiQ2EFLT96XO5W7/SkhwIZe7nB7ATGvTZgxZX
         DXng==
X-Forwarded-Encrypted: i=1; AJvYcCXSbbSwaqtnZEx7f2kxFh3WiNj8XPhtJxT4uaDY7r1xfdISheIsypJg91jFao0VqrgIPNFkaaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/I58DsG/xg1nOqO2t1RpgZoCbV326mLs8ASos0gv0DQ1t5Lg
	hs4BIBWybttMl0iX423XQGyArLoxRx1u5HkUITqxvBVRvo6ualAWCaaiyAGVN8jb73N1JKrc6/V
	swNspjLtAVMfoO4v6Qrb4av3l3kxRSsEBrJ4V
X-Gm-Gg: ASbGncukuMwPic3J5zBgWEUXGWFojfOz4zGvUW+yPiwBaoLs8yZ3FWAyhKeAQHYvu8x
	pVrFA+dYOdn07x7y4lp71pMPRGYzXXcX4PP35lHmGwQoLFVzrt9IW9ht0Mc1fu3eAzNehC4Dr
X-Google-Smtp-Source: AGHT+IG9KwbznIrKFncpdwXRWmqzo7LnNoNKAdJPcW11cFlCm6ouF9CZsvbD0qxqZfzypsUf+FjvCbRQZ/vhbqZVIPU=
X-Received: by 2002:a17:907:d1f:b0:aa6:9461:a186 with SMTP id
 a640c23a62f3a-ab789c5179bmr1616884766b.46.1739213229783; Mon, 10 Feb 2025
 10:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210082805.465241-1-edumazet@google.com> <67aa467cdb521_6ea2129452@willemb.c.googlers.com.notmuch>
In-Reply-To: <67aa467cdb521_6ea2129452@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Feb 2025 19:46:58 +0100
X-Gm-Features: AWEUYZmr2_gsw8RuHezNj4nEXtu-1Cl2GsbLOWP2J9_Gq2Dgw3quJcjtzxVT8G0
Message-ID: <CANn89iJGffSLbmh=9_df10y680S1WRJjnLbt5ddZQM9-okpkgQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] net: add EXPORT_IPV6_MOD()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 7:33=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > In this series I am adding EXPORT_IPV6_MOD and EXPORT_IPV6_MOD_GPL()
> > so that we can replace some EXPORT_SYMBOL() when IPV6 is
> > not modular.
> >
> > This is making all the selected symbols internal to core
> > linux networking.
>
> Is the goal to avoid use by external code, similar to the recent
> addition of namespacified internal network exports with
> EXPORT_SYMBOL_NS_GPL( , "NETDEV_INTERNAL")?

Goals are :

1) Documentation purpose :
     This symbol is privately exported, and might not be exported
under some conditions.
      Effectively this makes these symbols unavailable to modules.

      I thought of using _GPL even for EXPORT_IPV6_MOD() indeed.

2) Remove three lines in /proc/kallsyms per symbol, eg :

ffffffff8b94433c r __ksymtab_tcp_sockets_allocated
ffffffff8b96fa75 r __kstrtabns_tcp_sockets_allocated
ffffffff8b99adf0 r __kstrtab_tcp_sockets_allocated

