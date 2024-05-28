Return-Path: <netdev+bounces-98682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1818D20F0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185532893E0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4AB16B756;
	Tue, 28 May 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kq5oc8LU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FEB171675
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911907; cv=none; b=YcSJgeyS/9KWS1Hqn97D8j3uKoPBWaCVZ/86NFkX4bQytJC7MBwO3znuEoByze0va33FLMD+71NHx72dMHsptlgKzaYYgBPYcavC8ptRDdjOkG0MagM/NfY3djk3mstmpXsLFSvuLPsL76IDy7QjD0VcFcB2WBF9dLJGNiBPDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911907; c=relaxed/simple;
	bh=9TCUXjliQvkmA4cQRGdZcfize1GI1Y0x2h6NYAJexHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzC1bCBtaj6U4V14zcEl4LNobIz7dY4gUqQeCCCz52fwjfv4taf8DcGuSlIDAv4DK+MrCq5F+BaXD/VfxJwrlJsJSj9se/e/j/6fn1PsuYRxJHwvlpNZi31pw8G+ZYjqhbIjwnDE9VsbsWHluaZ4me+nAL3RAp07rIHF4tNqVpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kq5oc8LU; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-48a39d9989dso287010137.2
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716911903; x=1717516703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TCUXjliQvkmA4cQRGdZcfize1GI1Y0x2h6NYAJexHY=;
        b=kq5oc8LUnWGTFF4HX4P5UinF6NeBHDoDq9kCCLPg93HXEBWajyUJDpLixAW9YVPKBR
         c2bnj7xJuqU7tGVQuAaKB4mJeICkpSxwOhXrE/UTIATCSGWipnNxsKd/xCWfnFiNxlsk
         6C9q5yRXuyOYLRp9zCCsCKqCIKND9MHNFrBwKAAACpjxf2TeucDp0VGubGd6CV8iRuVK
         2SONt4vT6MU/RpZY4DoyUuD4izGNp38lOsaqQcQ4LYBLT7/x7/TYf0Ljj3bpPsmx1nP+
         Rz68Ni2zeNIYZr8CY/yR8iNKKDUyLDGa0ZbaCTQxFfZAk2MZ8NpJYnuNn7gjFWj6DTBR
         93Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716911903; x=1717516703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TCUXjliQvkmA4cQRGdZcfize1GI1Y0x2h6NYAJexHY=;
        b=WvgXRGFDuJkwmXhvw4FYUpeC1Jt8pG6Uoivj190S5gw9iE4yX0ZiBYPEIY5beYkTrk
         jA3otCvSn4C+U6a2M/+Aslbe8Fg4zTdYs94Vbefjez1sHD+MGwgGaYEG9Dkx7+4b90bn
         7p8XRbqQDY4qQiBApowWfPJieQf8MSX0jbfUGN85uhLHQ2/7zRB22/NHg/v205GdIVbB
         /0auC34FXOAABIrdy/lkP66fEFUDa0G0TqH+9tZJIGTR1/jBOHitVuarWg7KSSl5pUDU
         FbelAEvdg2WOzo4yWuK4K3Aan6HHOmO8C0GKsBxZonsvDhunGFzVKofTNwXxiHnpbjLc
         YfLw==
X-Forwarded-Encrypted: i=1; AJvYcCUu0zFbZxdqkYjiXp5pUzXTme3+Q5GTEXu4EO42dmvQpdDiJzeo6/YLOc1k1nEi+xw/JkHZbMcfeuMzVGHO0vpjIhrtZhqV
X-Gm-Message-State: AOJu0YwZoE37eA+DOjL0xnmwABnA6HV5OSOUNOMtD/sCHpT05IHaMopm
	BcqfC0RxKTmiRgbNu/IkfVOnmmGR0TldTBe109kV9yq7SGXWigv3UGZH5ff+KPjHgsbcqAgTqLS
	vzv7talG9lc9Zch4u8Dx8w4DZy+IGwWuD+MJL
X-Google-Smtp-Source: AGHT+IHzbhdxKxhNaQy5NdznOWM4lTLHdKBb+NGX1DL8ug10MMdJXxskw+2tTY0roOu5sJFJH1oPcKDo0R3oVjn62fU=
X-Received: by 2002:a67:f541:0:b0:48a:36b0:878b with SMTP id
 ada2fe7eead31-48a386a931fmr11217402137.26.1716911901946; Tue, 28 May 2024
 08:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528125253.1966136-1-edumazet@google.com> <20240528125253.1966136-4-edumazet@google.com>
In-Reply-To: <20240528125253.1966136-4-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 28 May 2024 11:58:06 -0400
Message-ID: <CADVnQyn0dqBTw7M7qEjndXZLYyaDBk9AVpGWqkuycgAPs2_62A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/4] tcp: fix races in tcp_abort()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Laight <David.Laight@aculab.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 8:53=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcp_abort() has the same issue than the one fixed in the prior patch
> in tcp_write_err().
>
> In order to get consistent results from tcp_poll(), we must call
> sk_error_report() after tcp_done().
>
> We can use tcp_done_with_error() to centralize this logic.
>
> Fixes: c1e64e298b8c ("net: diag: Support destroying TCP sockets.")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Acked-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

