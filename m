Return-Path: <netdev+bounces-89513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9478AA822
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 07:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E4F1C20BD8
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 05:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EDCC127;
	Fri, 19 Apr 2024 05:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="giCnJtqX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409DE883D
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506331; cv=none; b=e4BV15tniiqUkMigQDtZT/Zk9cgxW5vs0j2w7GaiFGhRsFtzM0EQdiyEs93MFA+hBgMB01XcyH5JRGyJXn7omqvT4HmthT/tgkyIN9Ab6wuv5+AAYe7kwZwUo5kRGroJlY0YYsVrPd1mPyJy32OSKe3SFA5P1OuTnwxAM9JT3mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506331; c=relaxed/simple;
	bh=2jNXHlq4/okXlIv5SlbTqp0ZxVYk6lWgVySxPIU7q9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLv6zKMXu5HCRMnMUBkQvt5XpRozS7mXv2V7Awn7hpIsDb4vLVmoVPmhevd53mbnnLe6DXRhGc1ECil0K53XQyymAx8PsGNPtsJDTiWc6DpBxpyLFR8RvnLkIEKLB6bit695f5S4AzfTWoWONhS1rqLuzl6YBU7nnQYn86p3Cgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=giCnJtqX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so5995a12.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 22:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713506328; x=1714111128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jNXHlq4/okXlIv5SlbTqp0ZxVYk6lWgVySxPIU7q9Y=;
        b=giCnJtqXXc4pt0fDLJJ98OS+L27reuIYrBgebfP0HNGRUAczIZY+whHio/px2MEEs/
         dEP9+GJ19kzGXZZ/XTw2Mtt+fMVq9uhZlA2CUSLyz1Hn7eBQag1zEbx/3juWseutREAi
         7oIYA8Z0K3Q4OLch26U+Z4+EGPI1VIMGYNdHa0xKgzcEBqtfV+BX+5ZUkRf+IFlGNQcn
         LfR3FRy5Oi5AjBD9uMoaHsdmuVzrzIl/wGXBSbzE9c8/eRanORS/QgTJy87u7KbSLpDc
         CrNOTozVp/SyixfLJIkbQaykD95kBkxMJLWurExOpN/IQOt609HVLws1OXefhxA7taRu
         CEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713506328; x=1714111128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jNXHlq4/okXlIv5SlbTqp0ZxVYk6lWgVySxPIU7q9Y=;
        b=gdeVAXXupKmNPWCnM+8byf1cGmm6ELomlIC8SPC21R3UIAMmULDd/wEgv61tmK4rgw
         dwV5JY+U8EE96yckHalvuKCGhkAlR4AI632RJ8BSbXSlA2lJsE7VY8JinO0ry/KIh5IA
         n0Gp8fC+GJivKYUlt2ojp/ikRWerMdvoqPeUgMBqa1xn+AnEnO7igJwPVg5M7iUjtkU1
         sF57sWerQrnlRgXbmYd40QXPINJXB0cBKigVCvPZ8iJcTGTi9hA0IwTP7i5kKr0mgyrk
         LumuswJ5zAUGT+Ns0dRh0s6sctNWWRMa1IXWxElkKB2fZrlfukS0iXzeIxC+DuLkiXWS
         d95w==
X-Forwarded-Encrypted: i=1; AJvYcCWxmH4tkClopuTPeULb3PWHY3P1mAF4DEzJSTXE0E9ofw1EHGOjFkk284B+9sEtA+LVP/A+Oq4A73+W1kk/jpm5pXUsEhpe
X-Gm-Message-State: AOJu0YxbvEmJNPePy6KF7NtMu+rjdIwqB7VEqOC+vMCqQfs78McV0TOF
	f/0SXLB4sZrZoSiBTSJl7tUk3a6AGzIqUYKZi8Zw65IMMb1eED/blTjDkMibOZf/BnUnW7+rY/5
	FgVodGVO08qs7JJswbSLpsIflDh/RxKDTjnob
X-Google-Smtp-Source: AGHT+IGWc3Nsdf6cYpI9+4gz3LZgAdDXNi8Z+p/gE9VaQ8poQ6W9NqGZNxYL4qrsf5EPbPpqQqWRVaxXbuLY/WQZJB0=
X-Received: by 2002:aa7:c41a:0:b0:570:4467:ded7 with SMTP id
 j26-20020aa7c41a000000b005704467ded7mr68265edq.7.1713506328355; Thu, 18 Apr
 2024 22:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418073603.99336-1-kerneljasonxing@gmail.com> <20240418073603.99336-4-kerneljasonxing@gmail.com>
In-Reply-To: <20240418073603.99336-4-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Apr 2024 07:58:37 +0200
Message-ID: <CANn89i+=gmQOd_vNTBKyoKUpKMnGP50yJLS68ry1yUOPXTK0Yg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: rps: locklessly access rflow->cpu
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 9:36=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> This is the last member in struct rps_dev_flow which should be
> protected locklessly. So finish it.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

