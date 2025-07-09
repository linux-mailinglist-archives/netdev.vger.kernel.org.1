Return-Path: <netdev+bounces-205564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BEBAFF482
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 00:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24813A3D0A
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 22:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5809821B9F1;
	Wed,  9 Jul 2025 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V56V4EqP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9D82185B1
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099353; cv=none; b=cXFReV3+qb0p3covg4ct2WOghH8P9IgWmYNrx1Ey7YPIo1yf08Ll3ZG+Ztx/Iw9cWbfwt35B81e3JQlIj8rKHSkOPc4lnnsy3BEj7LXNe0mOO4Tn3J14apqqp0nieG4YmINaVOuSSXaF37XtHUZAJl6wcjK9pvgEbjKczbZYx0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099353; c=relaxed/simple;
	bh=grPvT3YzMCHSO9t0p7JSSc2hNvgVv+DKmbpDzFcwfuI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Uj0G6A9UocTNuOAolu3+WQSjes6jy6lvyKx7YJP2jhFhF+/xYMGlbEF+yTOf1Q21QomcGlQ404ink2ubuNbOPu7oFQ1xv3rpehYuK1dTpB321PYY7jn04h7T1PeRrdNFOgYKBa3lS6s4xExXyMxbWU8NpVB9wi7h0MKSU7Xjevo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V56V4EqP; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70e23e9aeefso3410947b3.2
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 15:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752099351; x=1752704151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dFfU8FBCer22+uWVhMsnh+ZVwVV+zhWqbVHnRflfcU=;
        b=V56V4EqP2xFhnUV9z2C/T9G6ZLCjeZmKL//oLZ0ALvbbP/CeZWs3JGs9yL2Fkqe85I
         YBCTXtD0+SnKF2krR06J6WC3kGz5b9hvrUJTDVtH2MoUuFzZjCJYpYhlb64zaYwniSnW
         KKlMXvzCveXckJbu4X6m2ttWGR01h9Zhw5l3CKYZ7xy8wRe9Yx4JLuk45t5to5iF/XlX
         4c513IRE7nrPdjXd1HrBDxG4ybGRxIORKLlfbeQW3v5Q+OIWWcAarlurrANLuCPb/FS2
         DDKoiPRm+xkLo50ZsySBNwfCQORaotsmPEYgczJ5a3FeUZZCrBpojomMMOcvkNdh2tI3
         /uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752099351; x=1752704151;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6dFfU8FBCer22+uWVhMsnh+ZVwVV+zhWqbVHnRflfcU=;
        b=Ogcph74XhsWfA03JBKG/A1qwAqPSqB8PRXbDvoodjgrop5XmadWCUpsflpt0SiOA2p
         DBVzNceNohFaovoFVtOrYsEJhfHGrtFULqLeNnyAaYrG/qa3SdyViGttQgeepOemQp0F
         LochHFO8oeA2KtvlEC0mcuQFlxZyM+rDy/d/2vGBoG65C5y2PfSZM9zyAy249O9LZce7
         7hvQ0A+D75e+fIzsub35QW6hybWenLlH22OlN2+jDjKxsJCCaUlqrJVjseAjg2k2d/Zt
         9F0UFsZXZyAWKObMeuihROd5BY9oSBXP+hbxfALG0WcuLJPYt6zADaSECflm/Xo1r9+Z
         z+Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVoVVnxc49DlW33kAuOiNNA3tkweyDf6Aba2oJ68I98SbKIGHnHBG0Z0ItG91Zx++cLwDVP+GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDUDQM2lg0Z8a7cfBH3YlKXXnktozXGRfo6vfCCpJKSaA9boDw
	qo+F+cJDoyFLle/uYIXaUBH9ywC+s1QI5b2RnZjky8blXXw9Vg6va/wa
X-Gm-Gg: ASbGncv+OtzupRe8Bbhmv5I1oQkjcHVPc5kExCuDWrvQAf0JFiWBgJ90W6RiSVbIZTL
	eNWv18UMfELgE1Y3GNRKtWVcqylRgbTxkf+o163CH27lgvN5Ddr40ajVsby6nFG41OdoJiGXsRw
	R3liLDL7rWmPKJeKWN+eN0u8DQzs2oEJ+2gLFIAO1MkfdZTTgTVmrXHcLwOjTAOZn8++EbHL3IZ
	+VuINdljT3X7k0wMKhHy5ZdPmBhKL5QSg+izDr4PNcWQzA2DDtlwa6D/JKNA4ozzBxj+2yGlQfs
	YJxes4idW8uJFGsz82m9sc7gSnNaGToB/LIwCXlX1mhkK7kz7i25IXulgQttuMckHfsoJt1sD4R
	txbZUTNK4TxlNnmNnCFWOYbj6RHOzxVTB/4aydxc=
X-Google-Smtp-Source: AGHT+IFp/dFcnM8TPBnRcBVtlYjJbyecRh3wwfQm/kmyGkv+wiA9Vn4BJuZfuxvjZS+xV00j0GEgHQ==
X-Received: by 2002:a05:690c:3581:b0:714:250:833a with SMTP id 00721157ae682-717c175796bmr20499427b3.27.1752099350754;
        Wed, 09 Jul 2025 15:15:50 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-717c5d4f882sm205787b3.20.2025.07.09.15.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:15:50 -0700 (PDT)
Date: Wed, 09 Jul 2025 18:15:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 willemb@google.com, 
 Joe Damato <joe@dama.to>
Cc: Samiullah Khawaja <skhawaja@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 almasrymina@google.com, 
 mkarsten@uwaterloo.ca, 
 netdev@vger.kernel.org
Message-ID: <686eea15af0d8_c722b29467@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250624165039.5bf4b3d9@kernel.org>
References: <20250623175316.2034885-1-skhawaja@google.com>
 <20250624165039.5bf4b3d9@kernel.org>
Subject: Re: [PATCH net-next v9] Add support to set NAPI threaded for
 individual NAPI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> [swapping Joe's email for a working one]
> 
> On Mon, 23 Jun 2025 17:53:16 +0000 Samiullah Khawaja wrote:
> > A net device has a threaded sysctl that can be used to enable threaded
> > NAPI polling on all of the NAPI contexts under that device. Allow
> > enabling threaded NAPI polling at individual NAPI level using netlink.
> > 
> > Extend the netlink operation `napi-set` and allow setting the threaded
> > attribute of a NAPI. This will enable the threaded polling on a NAPI
> > context.
> > 
> > Add a test in `nl_netdev.py` that verifies various cases of threaded
> > NAPI being set at NAPI and at device level.
> 
> LGTM, but as we discussed many version ago my subjective preference
> would be for the per-queue setting to be tri-state (unset=follow the
> device setting, enabled, disabled). Rather than have the device level
> act as an override when written. It sounded like Willem and Joe thought
> that's too complicated and diverges from the existing behavior.
> Which is fine by me. But I'd like to see some review tags from them
> now :)
> 
> Gentlemen?

Missed that earlier, sorry.

Reviewed-by: Willem de Bruijn <willemb@google.com>


