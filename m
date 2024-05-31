Return-Path: <netdev+bounces-99677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315088D5CEF
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A911C23513
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EC8150996;
	Fri, 31 May 2024 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vDq17FC5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F474150989
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144760; cv=none; b=PuSCz+7CZ241YrnbErxZ3ZtpwJm+p9aWPvN2kYPoMr7XGUVLDx8tcTeQ7p2uq3AYA6/GNE9NuM2SlHlE2xlbqIt0LtE7TbiNZxfymo77b0oMggs7ZiIextQsfVSQ4OMAb4myOg91oSO016YT7zt4tg+Ww7QNULuBTluIFe4QBh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144760; c=relaxed/simple;
	bh=llsTeOa6Zi5pY6gaSeR1zkK4Y5MZtBCC9QXLk6auZoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmfjc0c52iIBJxdn3Dkgq4i0D+H0r5n4qkr7c/xrIZGoKjcB4xXGP0Lm86e/wDenwwZKsYyrVI37OpF9zFC1ajkDJBrkvL2EToXY6A1XZd5T5VdykElX5Em6LufKvOODdh6sV5SbdSM4v5tK9J44Ox5+3LxPcgP5jH1S+1MqtlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vDq17FC5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso12522a12.0
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 01:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717144757; x=1717749557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llsTeOa6Zi5pY6gaSeR1zkK4Y5MZtBCC9QXLk6auZoY=;
        b=vDq17FC5UweKDi3QvYSTSBYtDEFOdGy9R/snEYoxnOMvQHLNwa3FdMlQQpNOBruNUN
         1exi17VV7QW+sGM9ltcf5SRIWPj3gcOFwY1MEfQuGLlPmSbRSbneVHTpbxacc/+pzB/E
         lGAp/kdk+ABE64BUWnejjiGdHd5WGQTLN0W0tKzsFno3Y3REOZs5of5/cLXhirnvU3QX
         D907THadg41Hx7W/6dRDJ9R+C1tE76E97BN8ZeITJTl73omkT2unAODpJ0gJdYJMgZC2
         G2tVnHlxE/iYHncIsRXkZf9mXRoLCAMBsOh4848NrsbJ4PcaqbjMGcnaQBFv3oUBQp0R
         9ojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717144757; x=1717749557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llsTeOa6Zi5pY6gaSeR1zkK4Y5MZtBCC9QXLk6auZoY=;
        b=oA6FmOsq/IMM63w37oPcUI2Pac0gQJaWDOoWOm8d8gXqOmp/qCCUrYA23RE5ja6SLB
         aLL9IB624arJdiTsnJmKnJ4AOhSBzDcWC1R2py/Gc5fSiN2ad2yJvFQ5W2HbJFejteX8
         00VlGl0Sot/rWQud1TrMNgj2fwGs2oMlQ8aonvJmQ60qKW45Bd8LWpWvVy88coetRpLz
         SBd2dXoy1D4z3EWLqF9GwELrKtlATqLqXHU26G22s44/pIK7gTyB3StMMJA5VIZyr2Su
         KD/s34NcTOIY4dM7tAJRFI/1Eyz7RKV34SwqOo6DycRMZMRHBWA5O0WcOHfX6WTy1/Xs
         QhIA==
X-Forwarded-Encrypted: i=1; AJvYcCUVhd+iHmdHF57QGtmxZJi9Qmt67daQPV0uIuDoT1W7qTZuwSJs7JayP40UpHaOEQVUC0KvjXdhmtwOc0JnfZTX/7anvrZ7
X-Gm-Message-State: AOJu0YxmUzyLycgxKPMTRfHvgSX9DC94adZUaInfhWBySRI98JVWh3Oj
	UdQWML+WRse2YOVga1rI7SiWlguah9c3D/jfpR9Qlq2uIIxCM7QDPvs8z+ZbKKLJeBKAv4qmEEI
	TCB9bIODV36Z30i56opRMtjMBcCgAxsJew5rZ
X-Google-Smtp-Source: AGHT+IE9sqKACR/zHG48C2o3CJUqL0ykYteHHRPY3wtzNnCz1ewFWTGBr72XKL6NSwYPoB7UZ1O/siU7K0HM6PEPfZs=
X-Received: by 2002:a05:6402:3112:b0:57a:2276:2a86 with SMTP id
 4fb4d7f45d1cf-57a33c7b7f2mr98341a12.4.1717144757163; Fri, 31 May 2024
 01:39:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530233616.85897-1-kuba@kernel.org> <20240530233616.85897-2-kuba@kernel.org>
In-Reply-To: <20240530233616.85897-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 10:39:06 +0200
Message-ID: <CANn89iJtm8h8wCYVO6ht_TkxeJQu5dvSSJ=LUq+J0sbVKd9fQw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] tcp: wrap mptcp and decrypted checks into tcp_skb_can_collapse_rx()
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org, 
	borisp@nvidia.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 1:36=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> tcp_skb_can_collapse() checks for conditions which don't make
> sense on input. Because of this we ended up sprinkling a few
> pairs of mptcp_skb_can_collapse() and skb_cmp_decrypted() calls
> on the input path. Group them in a new helper. This should make
> it less likely that someone will check mptcp and not decrypted
> or vice versa when adding new code.
>
> This implicitly adds a decrypted check early in tcp_collapse().
> AFAIU this will very slightly increase our ability to collapse
> packets under memory pressure, not a real bug.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

