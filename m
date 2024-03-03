Return-Path: <netdev+bounces-76900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E8786F536
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 14:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7481B1C20821
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 13:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4863659B6F;
	Sun,  3 Mar 2024 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f3V8RTm6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8C859B53
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709473869; cv=none; b=OW1EsDrvUat+luXeetTifh4bI7fGfXJybQuFCwFvSYVaRIIYj0PkBG7bZRO7/WoZYTYDJS/PeNUpXK5yL6RyxUdlKh+rVog+ScFE0Wlh4Vhv34TU55lOjW0eSUVluB9CmXo1F5qo5QN56dgiogN+sit15jzgRGyJiDp86DzLKWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709473869; c=relaxed/simple;
	bh=lL2qls7bRLi7Da91QZT/lNPcO4L4EAuIQsq3JAQG2UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WELQY95R+g1zxyIj+Q8QcpsAPt1broIIfosK+oaILMPi08TfHOgG7lMSooUXfNwyfUx/QgKFiU8R+YQcAcNs6o+d4vg90dBh8TC4I3tzrpBneTeyPidhrabW3IGLNpDKfBosG5F93wtrNQb6CJ/eY+3Z4qtOXHHeImEN7pOS1CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f3V8RTm6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412dd723af4so12835e9.0
        for <netdev@vger.kernel.org>; Sun, 03 Mar 2024 05:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709473865; x=1710078665; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lL2qls7bRLi7Da91QZT/lNPcO4L4EAuIQsq3JAQG2UU=;
        b=f3V8RTm6uolAfQpMgN0jnzHm9axSX9ITsznJlwL+ziMzH20Gr3/DiL1fEaLzsdfOoD
         hr2JcdbpjiUCGto7XUPo2UtvAIl8O6lbtzNUelYsy/19XOjEz70wfmwAXo/Hnk9k84l/
         2wy+vvjCqKElwn+b7qqtIuxpX3ZVrcsbhGXkqApWL5PH12hR4dml7Ho/WiUG7ZFwSM2J
         4RlvSpd/W4OP409bXua8iitf17pg7Wd+1L10eAj6dOcrUIqOaR9YLXBkyNh3jVT2AUub
         QtievqdCUHX9gORpleFXkdJsp5beNhlTFyRQDD1UXXgou8vuDoQJJfdP9HMftviN7d7B
         26Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709473865; x=1710078665;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lL2qls7bRLi7Da91QZT/lNPcO4L4EAuIQsq3JAQG2UU=;
        b=Qi/KUNX6z084d++by6ofn3Bd6ZBnuSxIE6Voxercrm/ygy5KUGaA9+LjZI9Wj7JVPH
         FRCXYCcA8imGAIkkxtP724dkushu0V8oNaW9l2uCnRE80Vce5lnzFmsgL8cD/Cm8l32v
         RO4MxYbmKXVouNe5Mz8BUKKGp0Ypu2ICE4PQJtWX1haPn4SXPVX60elyYCGyyKIELF7M
         n35+DxWRoC+kC8xP53W3kamNRYfaCFNAsD1zqqwbhX+sSEiX8C2qpzmEwKEBghduok0S
         QNtN6CP9hdhvnVyyrTp2HluhtZcJmotmuJ2gM+kySf+gHPbXDaAt1iq64ucAhSmfwXvq
         n5MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN4lW5uvgIh0RwhdIgVkA/mHb6fWqohaV9HHlJBl3SEA47HcwbFIui1taJN0efZXAgCqgeOSv6ZrUS0Jf1nWyH57gugUUn
X-Gm-Message-State: AOJu0YwF/cw1Zvf1iQVFOE3xhkLup9R3HkdU8JUbqZSCa69LJSpIL48B
	+PKGyWtDvortJJNC7ZH/MoOdRSnHPgqOxUodOo5vdxTOdw/iJ/o1jaWwwTcF4Kii/KtKr3oq9oB
	tviRHQVydy48RpQjIEBjFagW33lKwCt8hv/Rz
X-Google-Smtp-Source: AGHT+IEfuw6JENjiAQWpyQP9ZMPz7f8jMXoehxOJumvczLSkxyl9hPnL90dGK9hnHpcKLJLq9h/s+RZHsG2FNwScQhk=
X-Received: by 2002:a05:600c:a386:b0:412:aa80:bdd9 with SMTP id
 hn6-20020a05600ca38600b00412aa80bdd9mr356023wmb.2.1709473864533; Sun, 03 Mar
 2024 05:51:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303114139.GA11018@didi-ThinkCentre-M920t-N000>
In-Reply-To: <20240303114139.GA11018@didi-ThinkCentre-M920t-N000>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 3 Mar 2024 14:50:50 +0100
Message-ID: <CANn89iJKe-J1v6WeDVf-bb+bAGXDVg60pqwUJgm34EoLuwC6+w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/nlmon: Cancel setting the fields of
 statistics to zero.
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	fuyuanli@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 12:42=E2=80=AFPM fuyuanli <fuyuanli@didiglobal.com> =
wrote:
>
> Since fields of rtnl_link_stats64 have been set to zero in the previous
> dev_get_stats function, there is no need to set them again in the
> ndo_get_stats64 function.
>
> Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
> Link: https://lore.kernel.org/netdev/20240302105224.GA7223@didi-ThinkCent=
re-M920t-N000/
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

