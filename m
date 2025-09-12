Return-Path: <netdev+bounces-222439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CD7B54369
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7213A445805
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 07:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CC823D7CA;
	Fri, 12 Sep 2025 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+JvqXb0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00328689C
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757660662; cv=none; b=umRmtkO7YWt4BHrZe39t3yzC9dQjVTtEH9gkqNOV+y7xek5oE8bSbjXXb/W8oPz/jbP6twrCXm+QonVehBE1tbqVlYqL68D7pb1SvPjJtb1g55Vx+H2k9mnKGtvkmZQ/xadDpCCwFafzG019lvuyGEcszWuJRby0Uky578KaDx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757660662; c=relaxed/simple;
	bh=q/3azkhASRepTVItgM865PhVwehLOoknq13jGplyT2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oV9inTLUFX3IS1dPSGXO/7N0kq3MGVw4lUCvpsmXIqDE0GQTILTW5Hb0d8B//yJEI4TiLwqbpaOpq8caFyoRXqKThF8ZLwq6FSO2vP2L82xFUShwffF9MLvp2ylmkTisv9aflx8c+3wr6cdjrcB/zEzV/UfNDzOpPgJ93WO5FOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H+JvqXb0; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b48eabaef3so15489381cf.1
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 00:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757660660; x=1758265460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/3azkhASRepTVItgM865PhVwehLOoknq13jGplyT2c=;
        b=H+JvqXb0NTY2ziR0DYc9iXXDLkN8PxZJeA27/OMeSJvWepEJy0Wp/qqpG3P/h0zK5b
         1/UyUpMLtjd7x4jR8qaR3HENViubXEgR1JLVutMG0IHUTu7yegsxxlFKITm/yw+Kv8Yk
         9E8MIErhYLOAYb35PcLzX0e38aM3S8CCaZj6BxpnpzoLj1iSdCgongschHnFNr2EWDrL
         QWuO8Bpp9KFGmjebYDErULrUMTT/yiGpmDSfvXypMNpZP5WkM5gSjoCguwGMYnFYLGFq
         U1aWXtbz6kTKXQA10dufjq0dPu2vugkVgtSsf82WYd4on0iEb6ShvnR7qvpQydFy3/df
         mgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757660660; x=1758265460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/3azkhASRepTVItgM865PhVwehLOoknq13jGplyT2c=;
        b=klBYWUSSqqlUVvysyq76lmkmn51mrLD+IYM0CVtuW6SfOfmwVXEMA3FVwIhxclCLAZ
         5xF0o5NdF4Troqv91wcAUO+jnicYjsaWqQkMAqYBdpw+ZHPiJFBlNth7LYw3Q+fyu6VI
         fbypcisUWCM6lrM6tf/kV5tW6nMbKnCphdDzoK80DsE68vaIOU0bK0iWn7mXWN0MPoLd
         r4vxzlv7o2tf2TcKCikJAR0bPusTKkXcyJcq1WnlNt09yMQV8Dp8J9U7FUeirSz0/6DG
         NClVCTJLesN/chNS0yazBa669OUJCRDnznjD2WJc5IoGPKbX+teWw/wJQnnCMzcwAeTy
         qaRA==
X-Forwarded-Encrypted: i=1; AJvYcCVjDXf4dY11gUYAgXYAtwaYd3/ZLM+ZQKA7WGnGuc1lDXCEEkTB0sobNGaHw/TWPBliJJ8PsIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqTz+Zqdz81ZQ0VRO4hHTNpasFzMQ6syixjkyXf1A4ESfwlKPf
	VGk8bmsUwe2wGVO25OZbqcA/ra8tCQ68dAn3nYZR/zgAWSHbWo5fsH+xbdAxiq0VviTMT4INhgL
	0LDBWmsss3XMnQnxWgsZmhW/b6AqOUUomdrC0cc4z
X-Gm-Gg: ASbGncsMMp4MA/rwXW+CskYhPw8O6a6Mous0hy6q495c39eh+F44i6kJzrNWAKfjcWZ
	5JMXvUuMjgk5AeMMsrOLw2mKmLOUH5HR8E5RZFq33Dog2L8NK08oZIUnqeBxYa9lbD3ol6Ji1Jg
	3NQYYwEQklfYMhmeuF/NzpZwU4eFjONt5eMzbHBarGeN+FuH+wkDhehUN5Ml5e4rHUhTz4ZwM47
	pGJLJu69sh4W0sSm2m85Q==
X-Google-Smtp-Source: AGHT+IHgWpsGKQ730X4wPp2YJnGKAlEQTxGeuAX55Bp6TeDYnQIZhudmoMoA+b7dxsgyn8zLKB8Su+Ge7eawJWqcabc=
X-Received: by 2002:ac8:5882:0:b0:4b6:33e6:bc04 with SMTP id
 d75a77b69052e-4b77d05a075mr20716431cf.60.1757660659500; Fri, 12 Sep 2025
 00:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911230743.2551-3-anderson@allelesecurity.com> <CAJwJo6bsZg-arM6GAQM8Lv3DivWUERu0VyFQgi4DA+SxRrZypw@mail.gmail.com>
In-Reply-To: <CAJwJo6bsZg-arM6GAQM8Lv3DivWUERu0VyFQgi4DA+SxRrZypw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 12 Sep 2025 00:04:07 -0700
X-Gm-Features: Ac12FXy4bKErw1s13GarDS8xoicxXKEJIYUhfNSFduEdoTfv6TSJEbr9zbXNqeY
Message-ID: <CANn89i+MPuFReHcGsp6B=40N7kvkDjZipY7ZFZXTkv+erzk8OQ@mail.gmail.com>
Subject: Re: [PATCH v3] net/tcp: Fix a NULL pointer dereference when using
 TCP-AO with TCP_REPAIR
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Anderson Nascimento <anderson@allelesecurity.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Salam Noureddine <noureddine@arista.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 4:27=E2=80=AFPM Dmitry Safonov <0x7f454c46@gmail.co=
m> wrote:
>
> On Fri, 12 Sept 2025 at 00:23, Anderson Nascimento

> LGTM, thanks for your fix!
>
> Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

Same, thanks for the fix.

Reviewed-by: Eric Dumazet <edumazet@google.com>

