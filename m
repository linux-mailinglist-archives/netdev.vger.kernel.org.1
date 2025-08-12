Return-Path: <netdev+bounces-213045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E851B22E7B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A96189C0DF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BECD2FAC03;
	Tue, 12 Aug 2025 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cn+Sse2v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8527F2F549B
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018025; cv=none; b=kffLeM7jP68F4erPxzd1wRwgQZuIMPv3LODNkQQP8TjPPl0U10ZNrovOOY/tH11xizzOd06vsK5etvYyDLgSAy3t8djXFFpozOM4CA728PMejYDTxeSH5l7knmDitNk2fMJdNiujIUXUDogDLrRFCnPHdSr/n3Y7/JS5sKu+jBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018025; c=relaxed/simple;
	bh=g+xnwDkX5ngCL07XyKRVEFBFnuHLjAvKsgHBvXMtb3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhjG+VJ1ByqYPL67/OP01J/MCbmvft9oemDgnzJdoYX2hJQJNqK2UklU5d+JGJddmuFtDs1REfnx8NPIZkVLjFmGFscqIYv2ppTu077ST+AjUNI43oSZ+YU/kCKfJJTeJdhXTYZ+JyV81R7wQoSk05eJq5i04uTZ3mGaSIbwwYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cn+Sse2v; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55cd07a28e0so577e87.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755018022; x=1755622822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+xnwDkX5ngCL07XyKRVEFBFnuHLjAvKsgHBvXMtb3A=;
        b=cn+Sse2vQYYSTXa8Uk/+ng2UExnV40XNGXOXyUHm6U6CVhqh5mjDF7JcI2v+sm5xN8
         ZfY+vhoS+NT3r6wJsYkMTDwdb4SYS2qNrUVzbycHGxfXzqPFTBey+v9X16UHu0WTOhUf
         Ysgfqyship5w9gJsontSXHJHLsPehRho4HUj0vnS28fC9uCUgeGgBfyA7ui4D9uidWOY
         8+QHibXXxuSaMTSYPLXF3w/MKOuGSAFbILefc7bxUh5X+fryGgGl09eAljou0nFNi/z6
         qrL+wIxbt4o9siXXFOJ8og0N+ufwWWf57tcsLzpgJTWpWAoTIO3y0xBAZ6r8tx4NDS8Q
         PU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018022; x=1755622822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+xnwDkX5ngCL07XyKRVEFBFnuHLjAvKsgHBvXMtb3A=;
        b=Usn8utoZkBtNfVScwR3BrG77HlVIlvFzSHmfsqEFQThLkO4vnCBzs0yuKIV5nxHcZj
         AZJkSHT2cRZshtO8FpHLLD0hdmsP6UODuYR6S+AmpUP9KpVLRc4MjC7R5dmC5nBnNvt4
         JKAg7yMNCZbaicnJITB3DLVbk12CD83WI3SXztlgbEUTMXXZkRUXVWzC/beNKypX8SLb
         gbpC3zo/cQDhcUALPJzKzHr1Lmv/MqAmkvaKerZkDyuvJVzAu47xzFYdOvcjZLjl/0wT
         tfspc9QxmwUMSwpH1LQi+Ld1eBafTcX0c0RndfoOTqvI4GUuvti/1ZZqql/leoFY0JU0
         hTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvWHcA4Ws6zeFmSh9rTnYS8yBiAE0eRwgGF6C7F1RZx4yG+7rd/vdayC7wX0viwTmeBJCfc1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ291iW7nRUy346WQkecI3DjPOGBk6fJmBt0NkvvxQJUkF6Xwz
	BbvedVBMPLX1gfC0LuA72Z2TvZNRFSgaRrzUVH+QFrvtpMKsyBvLuaC0hjJU8yzwLvohfKqvecc
	yz2uMHQ/HhEIfIMMUkMZUlKgQr2WKZiGlXzjn9CN8
X-Gm-Gg: ASbGncsFY1ClEQea4m2U3/fWzvYo+yAmdmnaZ+bfGM73gOjWRv0zOy+GnD50HB4DBxQ
	oilUGadUA0eaZfiWmqZOkUVPhmv/INiz4Zu2/3BH407eHR/zgHGnihVuuOa+nqq6XaPyoRlzRJr
	zGuL1msplgyHcKjuzWf8Ke0D5RLZ3ZbkPtBlyivNwM9c5Ne5j8TijAce/VxzGGngr9zFB1fojZi
	MHC6yGUA04ukfnwxeFQG6PY4dgJvDD2B9MOKQ==
X-Google-Smtp-Source: AGHT+IGsm+bamhT29td+SwHGDqIrSinbu6HW1fTMkiRm3PCRaVm11QVRWbd5T45tIE+/NfYE+AaeEgGPepfjyo6/j/Q=
X-Received: by 2002:a05:6512:33d6:b0:55b:7c73:c5f0 with SMTP id
 2adb3069b0e04-55cd934255emr412363e87.2.1755018021029; Tue, 12 Aug 2025
 10:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811231334.561137-1-kuba@kernel.org> <20250811231334.561137-4-kuba@kernel.org>
In-Reply-To: <20250811231334.561137-4-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Aug 2025 10:00:09 -0700
X-Gm-Features: Ac12FXyDGk6XAUlBJwbNHP01ld7E2h4F-F2d8KqPQRtX-nKG5NcUnDuUe0iPPMU
Message-ID: <CAHS8izOzh_vvGBCreeMvETO=m3Rsqf8t9ABwXsgzAQre=iO6Bg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] selftests: drv-net: devmem: add / correct
 the IPv6 support
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	sdf@fomichev.me, noren@nvidia.com, linux-kselftest@vger.kernel.org, 
	ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> We need to use bracketed IPv6 addresses for socat.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

