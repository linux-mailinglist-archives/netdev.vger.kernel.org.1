Return-Path: <netdev+bounces-195062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D29CACDB65
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 11:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F807188B0B8
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A2528CF7E;
	Wed,  4 Jun 2025 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P27gMl+k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB5E23958A
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749030553; cv=none; b=R+oP16sHhZoV0JA5edkw59JDMybLFa3alEXWp1fWLEeEliCy/It56zR6tKPIo8mzuaBErC8XRUfzc/qRdiBK1WOqBjUisXMyNhXo5rPOKJWFfRHmaJBXNib2Bt2HCb1R6o7LTJvKnKQiwjKTiGlpvY3AC7mvYyjMecXULwv6PME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749030553; c=relaxed/simple;
	bh=wqcF6LeA2dGBJlPtwSOZvgjcnfgzBDtxEp/PBD0u1Rg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=CJ6oiQ+q40Ws040klqL+UTsoEeGm7RIdYlR0TqYdPHcAPAuFotI5NQ09hnsL4mRLIh0DepQFJ8+Sf5j+FGu3FrU/NrKNaSu1zXHDvmpIEA+44QS5lPO0I+EgU0xVTcUbJwxojMJLJw07se/CGY/d8HJHrYdNvHvywJSjufLFG2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P27gMl+k; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-441ab63a415so72299455e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 02:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749030550; x=1749635350; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wqcF6LeA2dGBJlPtwSOZvgjcnfgzBDtxEp/PBD0u1Rg=;
        b=P27gMl+kw2qKPbePiWJaKaEdsYIMoauTx5YwuI758VT8aZ5+uvrC+1uHLECGilmBU8
         sJXQi176Pzwn8qu8Zs07RNYDdvmxccCfkXVpZQrlJQq5oJqjLnk33THbKssj6QwV+6Zl
         E88sbF8gQ1ScX3JEKGJ8lKxS3oZBE9IQIYOVomHuoDxFpYfczKfF6IC7NyWkla6zL94k
         4dkW9Vx9b57Vc2AQwVQ4lS9ilAv7885DtXDjT9Qcl1bXxK259qepyCNO3JK1cZ/e5UaH
         a4rFUFoEvHhq3TRotY29O1cCTkkdJzykdjudkEouf9UQQT904IP/exHPwrOg55a/TOOd
         8vOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749030550; x=1749635350;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqcF6LeA2dGBJlPtwSOZvgjcnfgzBDtxEp/PBD0u1Rg=;
        b=V4J6mZgATwCrX/BGGx5jMApB78oIn9yQ3TDH3G8zKS46k5dhtXYSHT/d9HqUkXWw+o
         DG8iXYjRT5P4XYD3egiiGVYyFuracmyDI/+8JCEJK4PgfhrMbBNzX+AXTDFVMVPB3abC
         9Ub3Qr/TguHbbOfQFAllbUiLvgXgcVvwXkXZgWFvnoIlKERRS1UXz1k1R3X9+pHNiFyr
         tPLQrh0A2pO7AzlQRX1DcvdjIDguD19vvu4pKzuZFuYU41FvO+Yxt4xOdIVNp2NPRHLh
         2C4gnjGE1WsyJXCDptl6OxBBxBYYjWkUYNOrX0NYMSzqNCorZKArdR3Vvx/jesPp9zVL
         bRXg==
X-Forwarded-Encrypted: i=1; AJvYcCUB5FxHE1h2nIxpOrI3mI1irmv7upyyGa6Jtz75kMK2WcgptBW9TEJTwCrBkI32fQOXdLH5uag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Dqn88xcijkl7iTyX/23W0r1rTWlxvdxBTfb1HDFclEs4BMWd
	47SVMZpVoAnPRXtcOj69QD8KIfR9PH8twNpkXOpL+7xmAbyogR9Tok1Z
X-Gm-Gg: ASbGnctqwxQ3lWAoGChQ+1De957OCmCJuFHM+pbTSe7WtM7RHbSgivLzvmIqHFADG9c
	TiI2cp/6VDE5B3p5dIjJaNrAdRxoaOQgKqjvhOfiDBmrL8miL6Mr9YK8S3ThVNuVn5h0O2ES2qy
	gY5SQ0DhiERf5hPcFnEHwMa8ggx/AZ7quwqGP/UxhAOki/h39J8G+zhdlkjiPzCFSoh7I1bIbGi
	wc1SubdRYf01Yjdgj0T13EKeYIyj49ZuafTk/mxj67FpmBJHmdCcEMqQjgxNGZR7nJxjTgRCvxF
	tSUnG4RU6DQ9BCJXbGNLVZt5gr0VXhmNhD7xWcr68ZMDcg8G6um1/mpuksVxb5z24oP/hKwp4+Q
	=
X-Google-Smtp-Source: AGHT+IEIMUUrUilwGZLnsnG0wfDpE7VCJOCq38j8V3GZbjRknPvXY82a103JUF6Bg3a9ZTwUjmFNpg==
X-Received: by 2002:a05:600c:3e07:b0:442:cd13:f15d with SMTP id 5b1f17b1804b1-451f0b2c13fmr17038925e9.29.1749030550353;
        Wed, 04 Jun 2025 02:49:10 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:3176:4b1c:8227:69ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f167fe4fsm18432075e9.12.2025.06.04.02.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 02:49:09 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  sdf@fomichev.me,  willemb@google.com
Subject: Re: [PATCH net 2/2] netlink: specs: rt-link: decode ip6gre
In-Reply-To: <20250603135357.502626-3-kuba@kernel.org>
Date: Wed, 04 Jun 2025 09:58:10 +0100
Message-ID: <m2plfjvq71.fsf@gmail.com>
References: <20250603135357.502626-1-kuba@kernel.org>
	<20250603135357.502626-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Driver tests now require GRE tunnels, while we don't configure
> them with YNL, YNL will complain when it sees link types it
> doesn't recognize. Teach it decoding ip6gre tunnels. The attrs
> are largely the same as IPv4 GRE.
>
> Correct the type of encap-limit, but note that this attr is
> only used in ip6gre, so the mistake didn't matter until now.
>
> Fixes: 0d0f4174f6c8 ("selftests: drv-net: add a simple TSO test")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

