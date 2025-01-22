Return-Path: <netdev+bounces-160307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F7CA19363
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 15:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB72718819FC
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EE3213E7B;
	Wed, 22 Jan 2025 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFzum6mz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DDF211A3D
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555037; cv=none; b=t/H9loEYn5oEK3FZK+id0VUbmFL/4bIy8blulNHG+nh08EofbbcnCFvLIHtEAyH9EkPwjaFKWwbdfoGrY2kl1dOz6hYiI0LFLRit44UmWOWz6nF3HnC/UxSlHoPqUGbWj+W6dR7IGLAWX49ER5II+rNLVQpHTRkhmvaqK28w7lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555037; c=relaxed/simple;
	bh=6TJ5VnTqM5pyJvoiZqGAu7NcBiQnT7SazTezEKHorkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFcyjWLkzb2CMPAX7+zHsJrWnFw9hSJhsid2liBpaLbqNq5loH7OQ18LgDgQscKzZLDYq8uS4urhyRiw/3/LoWFGxt9dP9tjU7eXVlceMV609oR3zDkTgSqsw6dm8l+Q16/nJObRqCPntlDAjaE8hT7UYQyWXFI9RLR9noHufeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFzum6mz; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso10494446a12.3
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 06:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737555034; x=1738159834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TJ5VnTqM5pyJvoiZqGAu7NcBiQnT7SazTezEKHorkk=;
        b=bFzum6mzeby12VmAhwHZlsNiMviBUvztz+dARoPW0Y+xWB+mCT4PSkEID1ghbR9vQe
         IigXjEU4HXz5GPoO3MsuUVoR1uY/Zbzx6XjxIH2fBrU9bNY7srCt5ZMjtqEbiZOqvlIl
         wEWPyFnWwUq7mDwpUa106IqLN3Td9syWkjJucyF/xIRj3WYcLFqi9291lvRKdQ0G/Ilg
         QCFJVlrXzv84BRguSTGPhlTb91wqa4aQJSSjbxm3wkQVDbAYbgPvlb9EKJAKo/3CsGhe
         AQ08O5DwFjwJ9ZzVE/N8b4jRK57x5jviB4ZdZVaCX6ecf9yc72FOPMzqJbQHBvAXvIFY
         b54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737555034; x=1738159834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TJ5VnTqM5pyJvoiZqGAu7NcBiQnT7SazTezEKHorkk=;
        b=exgiOvRKmiMoFW1dlVzuXpXTphYJtKk8ERPwd+MDG+pSS0BmRFcMHFjhz3b95jahR8
         fgfHegNk+spwhxg2mh0p3QYU2JodFC3EmEos4bH6gsFD5kzv4ETeyTyZmyU6jIKpQlcO
         0/bPtAmJeIVORgZrKToZu76BeR6tNKht7nEhB9b26mDuU5ZPqcoq50bGN2J2RLMmPJl0
         y7yCg3SwagMxsm4lC2q2I5HWo98ix35zfCFXMj2vUPrjBT1YNjxPk1tXWchxbeWroiph
         aRskwjjr9A85Wyriju3eT9qLIFLNJtnDg7MzdgAjObj6qqaIroR6t5HanxaduNwZ/zFH
         02MA==
X-Forwarded-Encrypted: i=1; AJvYcCUQJVw8HGuA+Yi6pMrvRznxRYBLtc8oM+k2BFVLWiEv21fcb8O/i819FGokJYeT14wEUqOw8M0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweupwi4MI4+9S9CqWKSPe7wRJvNdTxN8ys89QY222xWovArCk6
	raoXkgERjmesVhdwNLkmKSES11GoCKUhlHCAowNFDlnGQTZuq8PRbTKmqKH+G/N60+6hVZvQlp5
	8t+9D+10P8XpvVM2DFzjarGQYPeg0m/emCiRAT+jqYGPw386xBw==
X-Gm-Gg: ASbGncuxHxyUrLRqJaGfywiucxsSTnXLpGrW1uH5P6qzNOtieFwy2+qWZATwCCbWNY7
	vlcttELhNsvPb2R1ZGWdfXFi0fJEmQlwlvz0igDYImY9ZG4Vj6A==
X-Google-Smtp-Source: AGHT+IFfOFMkpFjYviXe0YqCSfFhFwVbLFodgDNBaqGoabqPQ2tadfiZb7twFaAwo1kc9n9xtmLXAMOTFhmNJ/ta3T0=
X-Received: by 2002:a50:954b:0:b0:5d3:cf08:d64d with SMTP id
 4fb4d7f45d1cf-5db7db2bfcemr15436774a12.32.1737555033615; Wed, 22 Jan 2025
 06:10:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121221519.392014-1-kuba@kernel.org> <20250121221519.392014-2-kuba@kernel.org>
In-Reply-To: <20250121221519.392014-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Jan 2025 15:10:22 +0100
X-Gm-Features: AbW1kvYlJ-M6C3qGLQrz_lj377rWYAvf_wb7SLb4AGIf4ag06YgMTwgD-WgMKmE
Message-ID: <CANn89iLFr48RWMz4ikX=O0qPyuJmwLjpiwXMDtS8Zg4HqWoCYg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/7] eth: tg3: fix calling napi_enable() in
 atomic context
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, dan.carpenter@linaro.org, 
	pavan.chebbi@broadcom.com, mchan@broadcom.com, kuniyu@amazon.com, 
	romieu@fr.zoreil.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 11:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> tg3 has a spin lock protecting most of the config,
> switch to taking netdev_lock() explicitly on enable/start
> paths. Disable/stop paths seem to not be under the spin
> lock (since napi_disable() already couldn't sleep),
> so leave that side as is.
>
> tg3_restart_hw() releases and re-takes the spin lock,
> we need to do the same because dev_close() needs to
> take netdev_lock().
>
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanle=
y.mountain
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

