Return-Path: <netdev+bounces-160308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B488A1936B
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 15:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B066E169E40
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305BE2135DB;
	Wed, 22 Jan 2025 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b82AfAJa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B5211A3D
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555158; cv=none; b=SWBQH3DzVCwpfJB/BUCwn8xUoE/w215FfzxPH+mjuj3vPV+zMw6MkDzqUnJSdpabmg+Ca0SRvHmjTgo3fWYubIaV7eSqa0zP+JKowAZ4aOnSr3tL0UAh6v5VZEbp39I9UBpQ9dx3+Om09yPqin9JIMqEYnppI+4XI4vpkOT2PGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555158; c=relaxed/simple;
	bh=dDS/SDqhcfA0lnJz6d+2NEp+PwW+d1annRtLdt+AUDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbdPkmex0VxtT7aaEoxMXvFI+iFYVYlYW9uLM+IQ2nhdQoG6eKCOHd6Xml6O+kxr49LvHwpX9XWMfAoJIMv5i3VUfI1ZbEvfb4osG482VZxcvjJiaDNVNL//LNyDxj300bh5P1PZw3oUFMyGWnqw+L/wUU1hcOtvGFjs0HxcbDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b82AfAJa; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so4584439a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 06:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737555155; x=1738159955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDS/SDqhcfA0lnJz6d+2NEp+PwW+d1annRtLdt+AUDI=;
        b=b82AfAJaKvkTt1AJGFJpZ+/abTAIQzjIWcMCs+gYJEhxJDVapqFWRKhW2ckMz4koyT
         DLHpySYj+n0xzJC8m8rzB/hz5Xzl6Fo2k4BXc7ZabD22ciOHiM5KCtG8NvxkQ9srjGC6
         SBJtE7/FKQ2svntmYwvcBC6nzclDdSPFex+z82394KJ9wEPRewIU9WaOcbKc5B9Y1BlB
         HO/5xHrhZ3Wz+/KtarmCGhfKXgsT46YvE30Mdp3Uf3dstSMBZzsuIuaVr8JABm7ZMS8g
         JDM75O9wdaxPpcg6tSfwNWTXDChuc05ptOHt/HhRrjBp/bDDYV3w4uZBVQ92yr8U9Xsl
         60Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737555155; x=1738159955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDS/SDqhcfA0lnJz6d+2NEp+PwW+d1annRtLdt+AUDI=;
        b=ZfWciiaaq5V00edgTv1bSqfoNxdosK/Apc/0pjAJHwnJEF2TTipiEYXMqr0LkTySjF
         IsixMNyp4TNcOm5nRiROi/X1yDAFL4cxkIHiR3p40xwgIRMQO30jWRMYyLxIWsosoPIS
         r7X0PLEUx43//ELB+i188/7R76PnwIUq8kpyI0glQzdOPiVOHLM4ti18ksxcYfjYwswj
         rO8F2aaK2BtQ+u5TO+qG9tTNTv8VOJihcrz+y68vgZcSxzwKnrLN7NCNew1194zFBOcL
         vfQjeQMxExWX72kc6iCyYz4Plja/qcYJPqIoYZ8PXDFwokOhh0Xzyhp0EwuAB8Ro6qYb
         0uyw==
X-Forwarded-Encrypted: i=1; AJvYcCUQGwkGDQKJOxxAk7o6If0L5DQ2OsCEJihWrWmXhzKI/nRspGy4MttY0H6hRcZJBXCcGbmi9NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQHMM+JAipeexppWNKMiXv67wvP/AIgmXJyIO0T7VMkNAgUeve
	yxIlMmmHBP2WRrzijcy4JpOEDOMVmtcL4BvojAk7MeQGSXmKmTyXLI6VtQ5dkuY+XdDMPl5pejZ
	2HbMmO+Sevsy6VR8C+SD3j8IOpuuP7T+z3ZIFzztgbm3X1Ed4lg==
X-Gm-Gg: ASbGnctZcISS77VXJrn7hUxE8ZgldrjthoU6xftocgWzukYvXST+pjPFrcjbvq5ORMk
	cUJQfnKia2cWFFPzbIlazFKLEdsjjXOZKErkWVTiMl2z9KhU7Zw==
X-Google-Smtp-Source: AGHT+IGl75hBXd7Ltqx93ygoqn1dF70pIe1XSduh8IQ3KDc7ROLMBMfTVQv3IcDPdZbgsS62arQCK+tBmvgc2nwOg/8=
X-Received: by 2002:a17:907:72d0:b0:aa6:7cae:dba7 with SMTP id
 a640c23a62f3a-ab38b1e1dfcmr2147033466b.4.1737555154551; Wed, 22 Jan 2025
 06:12:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121221519.392014-1-kuba@kernel.org> <20250121221519.392014-5-kuba@kernel.org>
In-Reply-To: <20250121221519.392014-5-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Jan 2025 15:12:23 +0100
X-Gm-Features: AbW1kva5xoVW8uVQEuZuSZlqVx3jURevwWxjSZ9LFqv64T0DVpZ9rVD78dA9jjI
Message-ID: <CANn89iKGh=M6r80FjZxsx1k7YwbTtPQwKOq=JDusDNB4LDS08g@mail.gmail.com>
Subject: Re: [PATCH net-next 4/7] eth: 8139too: fix calling napi_enable() in
 atomic context
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, dan.carpenter@linaro.org, 
	romieu@fr.zoreil.com, kuniyu@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 11:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> napi_enable() may sleep now, take netdev_lock() before tp->lock and
> tp->rx_lock.
>
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanle=
y.mountain
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

