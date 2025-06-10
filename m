Return-Path: <netdev+bounces-195913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E861EAD2ADC
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 02:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5A6188FD77
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 00:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB517736;
	Tue, 10 Jun 2025 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWchU1Jt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0135722338
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749514755; cv=none; b=N6Ni59T/W32YVdCojJ5WGxxPRI1Jrt6bIH5lkJoAbLJdGmFdZMHVAOJfkuDIeuXlcvozDqfqDplZnB2q5w+Ps+OE9BbHjcTAZ8hkf2ACaO+DqHXVhszsPtyH1XnWhczMhIqYJNGAIQoQuu1g4YrjJqSfE9Isn56WbukUCRKMUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749514755; c=relaxed/simple;
	bh=xfRLloP880sgsyg09fmAhOtVKkoEENYd1eGdvm0a5yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDSLLUNanJxJuSl6B3wTBkEDLkBO8YmLEYhN5/4JoT1sPICwxKyV6/GBCcSh4/BdhTEzp7VMziuq0Y4882PgBGK3eyDPNbUr3FTvTZyIZKz/em70Xc2jgS4JWwrDf26fMVRCjs1vxkD9bMmetTN/oJ4enydfh8nsRRxsQ0bZkXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWchU1Jt; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ddd68aeb4fso26566965ab.2
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 17:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749514753; x=1750119553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfRLloP880sgsyg09fmAhOtVKkoEENYd1eGdvm0a5yw=;
        b=AWchU1Jt+a3B47f8GKFw+xtbmzw9ZujZ9lLknVL6h04xM8LyxC8YUM7KoOi2PG+wWL
         NWxibq1cffHyWQZ1xZGe771EH+uHH0fcSjZFxnjnfL/QAJlr7UwmdDnT9v5pFGJxGBJl
         ie2VrBwKNKe8kMNSlY68yl0A9InSBIla94xpC79k7gh6OO5mtJZfQtY4F+R1HwFunPsI
         f0+k7QZtDZQdNBLyY8XXc83Y7lyKWFodQwUfPzm+7qpsNWZR8NTEh0mbhnWtI1G6b+kl
         kNlJVlAqpDtFmY4wCnk1eJtjCCON8zZ5UYtgJES1lyFbjeCFIIXG4pjj+IEHu4ag/E18
         VKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749514753; x=1750119553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfRLloP880sgsyg09fmAhOtVKkoEENYd1eGdvm0a5yw=;
        b=rQzgP0jqs+LsJoNjS25kCpAh4W/HQOpZbtbyoLZiEUZqzMNzWyjHRN3Eyh/I0drzhJ
         M6Wv+p4LPdXi/o38ZDlPuWtDAWiPawBMI4rqta4Mj255Z20Zq7UY8tirfFKG+r2KanHe
         RMqXremFzfcCvwE4llS1LiMw3ETVow1sZIXL0zkPCavxuz1fUOvsHeHQp4amviCgwuox
         ghCoevNRXMqamsSGuc2Uy4W0oUONxbCzmq7vW5VvuLIpONutK9/J+uViGLjgYqEYS/te
         szmh/L01VeRp4lVk9+r4D1hmycjviarbOy3TINEIjnSx7DT68FR12QdW6jpPP0PQT8gm
         NefQ==
X-Gm-Message-State: AOJu0YxKXqcKzmH0yH5hn1bhi/0SL6m9ON3WQAuZzVNNzs5Kesc84czJ
	8zmK2h/XWwQblq9T6ycl4rglN18r6GE45FFM9ixjLSvFR4so1ps0xgZ7Js/CfcKItrxpxWEf/RF
	GTlidKwns35YGC/fsNdHbcYvvx2tnLIE=
X-Gm-Gg: ASbGnctwwpH81G5ZlHE2TrLOsLJKSsnQgxNUokS82yy92anmpLFwJDIxCi+OCFMXL+g
	9T9H3sQkbFugEVxErLLfiX70xDGReNIu/QszozVwqtHUu3hCf6/fvYHR7bzGDsZEhcz1lfHf515
	1gWZH5sPoBiPqy39OMNkguGCrLUOXoiNDmKQ/T12uDXpA=
X-Google-Smtp-Source: AGHT+IHSAZLZt34TqaHtGlRoqwi1iVjJ2lN/IwM1lZG5cs+i/GyoCkR+WZpMIgDNpLNTqYGTKR+PVZ6Bv/Cxg++G6HU=
X-Received: by 2002:a05:6e02:1689:b0:3dd:d6c0:cccd with SMTP id
 e9e14a558f8ab-3ddeddc65d6mr4885215ab.13.1749514753085; Mon, 09 Jun 2025
 17:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609153254.3504909-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250609153254.3504909-1-willemdebruijn.kernel@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 10 Jun 2025 08:18:37 +0800
X-Gm-Features: AX0GCFuHrllGzfVaiqrUoeY5Gu8bfFe2Ikt84jkb4KJMINdsKlX2Yb00hbbVuQA
Message-ID: <CAL+tcoAUMA3oSvhXREKr95BN_LXV-N+t6K7ipoP2pEEbPX8AUg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: remove unused sock_enable_timestamps
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	kernelxing@tencent.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 11:33=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> This function was introduced in commit 783da70e8396 ("net: add
> sock_enable_timestamps"), with one caller in rxrpc.
>
> That only caller was removed in commit 7903d4438b3f ("rxrpc: Don't use
> received skbuff timestamps").
>
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

