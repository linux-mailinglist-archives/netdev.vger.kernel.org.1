Return-Path: <netdev+bounces-152880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505B99F637B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C65167F8B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEB7192B95;
	Wed, 18 Dec 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNek/v9Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EF850276
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734518418; cv=none; b=qyd4Ath/xVoLdm3gvm5e+5kngg5paYcUbeTYR+OP0lOJC7ORyChxjWe7+COUy1p85InTiPMu9q66ldV/4Ffose39ZYzL4NFWac/7P0IhPr4mJEsQQ7evm3xt4FwtaoAwVShg+x16Dsn/pOSgZ/Fy/LHv/J47T0ZLJz5AyNsDXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734518418; c=relaxed/simple;
	bh=iFlZJXADlKZO9ko2EMF/pds1i5J8WsLM1wePVOEtHuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyz7aC5Dh+BW31uvcHAF7j4cJmzZSQ2S0aeNlsHUaNIIl1JwHDtcid/mrmclUpgh97F78ilVXR8k2HFrsDwsm9zEYDthTiyKN+cO6itjaV0cfwrdYKQEBRlk5vRq1l24yuc51gvVgZFY3ybHPlmeiLIF5GMOo6tJJ2HbPHNuNgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNek/v9Z; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so10071206a12.3
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734518415; x=1735123215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFlZJXADlKZO9ko2EMF/pds1i5J8WsLM1wePVOEtHuw=;
        b=CNek/v9Z0gkPFjembUNzc7lFxccWkSOIC4XAx+0MKx2xdYEG1HLjnpLF9dHqPaOSNa
         QZEK7/CALNffDacJHMo+OKQI3lJRRCUUuBsL1/F626RuhqiqyTfS2D/ypbIkn868wzOV
         sEAL/TL1Tr67i//6ZwsYwHuqpkP8v5pV28QCo/yya8z7RrWQ3pThbuyAFZLo78MqjHpR
         kZArOYakkNLaaCWYZrY8z97/cQjEepZX9DIcMh72EIre4pwMPdFW+pvvywYMBz2jiJ+E
         nEBNcmpaOxCkIn3AsrM2+HIWkfsYx0lgQdDViL8NzPSVLxqtMH3tP6pMI/W04mVDbat3
         tUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734518415; x=1735123215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFlZJXADlKZO9ko2EMF/pds1i5J8WsLM1wePVOEtHuw=;
        b=l2oYUFudnGIo8Fd5LPde3PRsG42plp0+8te0uvBFHqF8fs3xTDmPOK3YyN1wk1tyHA
         N7qunr+kPa81VGXnOMbHaQeEXcjgVQAmRJrKAwhjj0V8BSBhKZiColJ3uGwvZw/C8qnf
         ooj7Ui1KGwyzTyt6XNDKy+J+ujaFpN3+zHraPp4Y00DwcOlRK9y9myU6XHolI9Mz1RTE
         tyWhKW6JXxHQ1EnM7VJJsJlo8asxxwx8mzVSpb5eqrB24gbGB95wlg2X01lU9GZ0z+F5
         /BwLWDu3NoT/tBFJ1WoOKBlcYvDuEphbEvNhwpcE9bhVA5T1czkcuKdCKZUF3Z3PDjWG
         TsoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvo9RKb3JbbOxHctjFKfPWp4gfRoAEQVuj90lrqwvoLcv610XBiraE03zSTj9XZQ+7CwMThpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztOoiSE8MPa33E/9G2jrgtYdsW6TF9AqiSoiTKw0YEUZ4crtqe
	Nx9/0VFaVIeHllqtJ6NtMtmu4yOm7EjdBmJyDfhPHdsgUsAQFr2jL3KX+qdADajbNJs8pggQrQ9
	jiC5qoU9RdaxeNbV5LElSRYiTWqYKdqDzCZSu
X-Gm-Gg: ASbGnctjcKTQ/s/Tn4PttA9ftmyYuHqiGhNazYVwSbM01buSczXOB2IASOAyypvbgzB
	0Vgyc/Z/7onOsthuZxiXMyUI4UXUa7WEpQXp75FGdWGZSywj3JRRQANpOGkduEbyafcijuNs=
X-Google-Smtp-Source: AGHT+IHg054hzIRVZwplfdoKxsI+MzpwWsE0JhQuaJxEZxz8LzOFGQAbaaj3MZ4DprcWl7Rlyt+UlJuBUD+8zJM4S74=
X-Received: by 2002:a05:6402:34cb:b0:5d0:e826:f0da with SMTP id
 4fb4d7f45d1cf-5d7ee3b4ce0mr2004094a12.16.1734518415198; Wed, 18 Dec 2024
 02:40:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218024400.824355-1-kuba@kernel.org>
In-Reply-To: <20241218024400.824355-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Dec 2024 11:40:04 +0100
Message-ID: <CANn89i+KkT2nzdb4R=gfvKWw3oqnBZQx+umAT+5zFsUrLvZQoA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: netlink: catch attempts to send empty messages
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 3:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> syzbot can figure out a way to redirect a netlink message to a tap.
> Sending empty skbs to devices is not valid and we end up hitting
> a skb_assert_len() in __dev_queue_xmit().
>
> Make catching these mistakes easier, assert the skb size directly
> in netlink core.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

