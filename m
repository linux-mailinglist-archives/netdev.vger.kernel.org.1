Return-Path: <netdev+bounces-179189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406CFA7B18C
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05168166CEE
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086EB2E62D4;
	Thu,  3 Apr 2025 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZnD0IHS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772C82E62D1
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 21:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743716239; cv=none; b=kvIvAOeVl2MDVf5pvDPwCNHxshxP98P/rKr8xFqWMK2WeILDF8uaX8Xksa6xHRX9ehyMJ2O4VR2whMp6X40hXBOps3pXaOIJOcGWNCYJgamZBpb3fhhqp8yyURZ3YbepTh8DFvyFAJQI+fI6LxuBhljaVRsEULKMNKVyyZbKSz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743716239; c=relaxed/simple;
	bh=HznU2GvROfv8QZzDmC+Mmrn+G5ZtXiweKsgAZpCZyjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxcYeeBvJgEjAniUIoPoAT/Qoc/FGia8r6IZ0F435aizXjcvCIObvw+mD6M6UV/Eh8r35WWuYKfOUieUOMLyeI+3NM6E6FnuT1apymSCML2CnLYi/BuGWE5Z7cZ37YxjlG8+pVbebiC07klkofK7pkJNwMYk/ZI0Au4GR7eAiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RZnD0IHS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2263428c8baso23895ad.1
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 14:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743716236; x=1744321036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HznU2GvROfv8QZzDmC+Mmrn+G5ZtXiweKsgAZpCZyjA=;
        b=RZnD0IHSo/DTYwUrYl+XgAsQWNr77mI9+1pc3TFHZHeHvNBqwmRb5QEAs1OQiqyxa2
         dUJRZTyNznJvtiD6CbmvR71Zmrq7fLZRNplEBuDUg5F2mb4JBl1OFVhFLYhXtnzaIh+Y
         lsBVI7XqoFuehDgKmds7AWygGnoOZUmEIK8hTX4U3LB7PTPdl81gbthAVkXRGf+ZEGjT
         e2lsDPmuKj6EVbi0+SddJWuB39yH394H4DyWzczIEWVR6YVxNg2fLsGTxO++jVIyhYXo
         1V2Izp89HMgX1y4gXdHOvfbIkcuNO3gA9rVZkaDUs/4HWthfoYS+ZFoyGRKJT+vujI5l
         P0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743716236; x=1744321036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HznU2GvROfv8QZzDmC+Mmrn+G5ZtXiweKsgAZpCZyjA=;
        b=bO+phizYWKZNtblimxmj+2ZS+vTIUrA375eCcfxn1oMpjAsKtGSD77juFAxPxkpFA+
         sXjYmzWiQ+QvDhp7MOU4BW1/hLRDXhbkmDeaE1FbVZQFVPVWcZJcMwMt9DPZPRkuX5PJ
         ijILNGZkh8nVaU+u0ovQtLe/arRUCY83PrHIA+YV34QkLtyVvdfN4oUnoUVvRZKkumps
         9qKgFyhII+lY7z8Km6+UN5a1esgJbCGT1zUVQMd+UOM5HT9DdDZQAyMqJvxaJoQdaM89
         +xGlns3GucNCoUdLRM6eSVjj78rVCZne72Htx3Z/4BggNNJF0DjER5C7xeja9WU+/jaz
         9tSg==
X-Forwarded-Encrypted: i=1; AJvYcCVekyG+i2Oex/tYB+nuVgIVR+3Dn/OJA/VZx4f52T6VjSh+mqVt7BxVQmF6WWVLbJBorjHY61k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEuaE9gwXExGrZywkZFhEPoGqvtp6mkvFY0VRZkWpC3mg5uKC8
	qmJn+kWgxjoUl5uUE64mBbcYPbT2hEGY24Sg9ZOEoj5VuKm2msTiZ5kheawmuba3XwZKSbeL4yh
	GljvpaXQWiunKq8HfH0+02tY18X55gLKMOQck
X-Gm-Gg: ASbGncsRjEFnB2xMIYTjMKJFiXkB9Gv36miJeYqUKW/NNA+bw7MeMI4mbsxwtrS/ftr
	DMYTfhglU7i5objsjQXYODXL/+DtOtfwqyaqE5BjXCWgRGqQzkAOxfnxznagJh84OF8tbE1E2tR
	9ThcE/WSyDDvNZ6OB9GUoJYeozUgo=
X-Google-Smtp-Source: AGHT+IF9qdWdZdNDYcnoPMoIQPWx/wQQBbu4UxvHdb60YczBh75+qmP3izyYfoZDR0c5YV8d4T9M7/ePz11hLRMrN44=
X-Received: by 2002:a17:903:198c:b0:216:201e:1b63 with SMTP id
 d9443c01a7336-22a8b7229f1mr304735ad.11.1743716236242; Thu, 03 Apr 2025
 14:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403013405.2827250-1-kuba@kernel.org> <20250403013405.2827250-3-kuba@kernel.org>
In-Reply-To: <20250403013405.2827250-3-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Apr 2025 14:37:01 -0700
X-Gm-Features: AQ5f1JqyuJSARvD5kmJL6zuHdnz6Sig0kxEuq3Wl4pybvTrOdWOo1UnoaZYbZPY
Message-ID: <CAHS8izMrFPh+WotdB1AJdmJE9=XACJmW6jZAaO0my+bao042Jw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net: avoid false positive warnings in __net_mp_close_rxq()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	ap420073@gmail.com, asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 6:34=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Commit under Fixes solved the problem of spurious warnings when we
> uninstall an MP from a device while its down. The __net_mp_close_rxq()
> which is used by io_uring was not fixed. Move the fix over and reuse
> __net_mp_close_rxq() in the devmem path.
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Fixes: a70f891e0fa0 ("net: devmem: do not WARN conditionally after netdev=
_rx_queue_restart()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

