Return-Path: <netdev+bounces-215658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12218B2FCE8
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B479AE4DA7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E28F285063;
	Thu, 21 Aug 2025 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vdmWnqB8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C0928506B
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786527; cv=none; b=ODPa5a6E/fXm0cFqP1DBBTgSMOz1eqLMKYc+h9QS/9tCaLX3iVHft1g2syB9KypaeHI1ZUwX4wNFnX8KrxMXo8Kf/BAR7x+u8L0SmvtefPPsbdDxOqX6tLbUFs3Uw7i7TrrczV7ketqY3lsMDevzeJquKqtZcAWqxRSH9RGICHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786527; c=relaxed/simple;
	bh=w4LeU3j+LRZbtAuUIJO0Q9eD8kGLjRvAnp5ZueDXgXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnBbmfTNbPLj5wcrbEpVj+8lb+6z8ylHM241Hlh+HGe5POoc9IFRBsmmotXPn63gSNKqsJ81DiHZWGvlpP2ScszFFmWvtWb2wX7h68oTpuY1gN0AL3O6Q34LxHgS9GkXhIq6djyh9GDyt7AEkR92c+ALAsMENbHcRxBC+LAt/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vdmWnqB8; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b0bd88ab8fso312571cf.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755786524; x=1756391324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4LeU3j+LRZbtAuUIJO0Q9eD8kGLjRvAnp5ZueDXgXY=;
        b=vdmWnqB8cG5BY5y2FV94UY2WuuSBFhTgocpmFcKjVlDQZZcCxy+A1dm6whFEky40Us
         LzlTOggmU9Og0fAkiqfCPp2dJLuUz9WS3odk36Tk74IhzTt8j8YkAznZ6QM0RKxKW2Tt
         9JNixk6WwAoK6+JhqkTTDL7or9nWQHg1FlC5MqvzWafd0/E0ENOfKCwSVBm4YK1eY8CT
         rnGvnM7p/G5l9l+D7v2Q1cpGWPNhp1lMIpcJVAoZBUC449lgh+Nk6ffA5UQFQ5M4uNXV
         Ew9TDTlfldtElqLuGiKAqflKUG3QR947TSFkknMaPWV7I5CBJvK10h7CUEHKiQubi5z1
         hABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755786524; x=1756391324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4LeU3j+LRZbtAuUIJO0Q9eD8kGLjRvAnp5ZueDXgXY=;
        b=NP1mMBuxm9GVjD2lCcBAXEkNeUun0nY1TalJDdS2pdhb3uDL9UFW1tLjXC6AMKCHQA
         W+3ieG/drAt/QNgCnGS9CN9drrwNbFWzU0RwBAzE+5bBUkM7I+kLJwUJ8724A+sseTrZ
         cuMWzZHTU66f/QSo8h1/NOjXqHzkdOaHnYw61dsQrzoMcl0tM8/XIff2cYDZgmOADx7s
         sn/3aM2LRbJnaTQyWJx7t1u3t+laUUGevbg9fN1KOv0Ih4TS97YuhDaquMwXMjoTC8uv
         eFNdoWjkOCX1CBXay/kxLiO/yhoQB7452cQ+PZNgcrKEaz2gRnZdJOVwRtUd6NU/j7uV
         BIpw==
X-Forwarded-Encrypted: i=1; AJvYcCWam4wo/7ExMWz1YMHjoC/o7mIGZDbKyL3i4pHcvj9UyVu5sH5mciuny/JVB4VcUarLGi2kK+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0pBCVsrbXrWoCG/AzWRJFpKlbc5ZFaGylfJFMAr88wP2eCZjx
	fvu2W//7XUJ+2fZyr1AKib+SvdiaecWB5lOFhs64nGnTXU14H90jASssi9z6AUboM7NASjZ4gvt
	U3ieDGPUFT4MArC17ye/H565Po6a75aTF+gR2ay3t
X-Gm-Gg: ASbGncuVyzORzuqNHYq3KbpbNAhf67JmbJp5/oa6lsEHI06chMs21kyW2gHZjICIozC
	wzIfQhqdG0rJP6ri/S6d9tErlndsW5K+82uyyDScegTaW0jSlxYsiD3YC+9VEKHaomH3aYqJxfY
	iCpB5n+q6LXEtLH9kiXeNSUAuh1F7KVMcle8PNqj08E5WeAlaXpxEfXrP52gcDjyq5XJYeUh0o5
	jfOCnUlQQTldrdfrx1tMYND
X-Google-Smtp-Source: AGHT+IHnxU/1WSo0sDL+N+B7J+qZ3ECkL3ZnzX7Po3nQtec6vHUyusIcThDfjzBSVQQMnyQvzETQ5KrT1HoynEkMmMU=
X-Received: by 2002:a05:622a:1aaa:b0:4b2:939c:9c1a with SMTP id
 d75a77b69052e-4b29fa207ecmr4259481cf.13.1755786523955; Thu, 21 Aug 2025
 07:28:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821141901.18839-1-edumazet@google.com> <20250821141901.18839-3-edumazet@google.com>
In-Reply-To: <20250821141901.18839-3-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 21 Aug 2025 10:28:26 -0400
X-Gm-Features: Ac12FXwGQ-krwHXghdF-o17TdG6yzctR6t2ZYSP5TDQehPTOCJPm0e_zkEc9G40
Message-ID: <CADVnQy=imcM6=M+hOwsbtOTChZxkbqqkKZcR_L-pLuJDWNuBbw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: lockless TCP_MAXSEG option
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 10:19=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> setsockopt(TCP_MAXSEG) writes over a field that does not need
> socket lock protection anymore.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

