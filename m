Return-Path: <netdev+bounces-202047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB76FAEC1A4
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD83560D90
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D375C283FE5;
	Fri, 27 Jun 2025 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCg2zKeZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F1C1F37D3
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751058108; cv=none; b=LBbcHu803buvrs4M21aEar3PWUualQjZaOTD/v62jLklRnxJe4QvUuzp9bhbuR4LzwcycL7zfqcJ2b9wx22h93gdwK2EZ13/uV8C1wO5L6UoKtEB2K+PaYNbQy/H3Z/sfpnFtIN25cdfwxUh2rH9JmFFQLe/hmS8k85lMIMStKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751058108; c=relaxed/simple;
	bh=jVkiLoW+WhEvJVFsVSCdFiMn0yOGk/qRboufIllpA7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8CRPlCJzlppXRVRVp550PsxruCdG6mLU+BEwP0ks9STQIl2EbmYYI6/2F/Rri81/0BQBvO/zJ7LvwUZOz7N6K3HoJ354jwHcjEz1+bBY5WVl7IhqqAi77EuJCBeiT+aIpujM7qr9Nq9Ckn1FcUerIn9SD/BWfXN7QE3FouOs38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wCg2zKeZ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31393526d0dso1482506a91.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 14:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751058107; x=1751662907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVkiLoW+WhEvJVFsVSCdFiMn0yOGk/qRboufIllpA7k=;
        b=wCg2zKeZiF4YkIIT/yPUkLHbYTjiyZKiYNbc9/wHxDRvfVxqSggfaqc7RaxqNgOHzc
         N+2WW17xez2/hIRCeGhi5ovAKc9lhLY14Xs9HOKDwPuDOeC1nXwcrqNHbEWAAqzjJuui
         0oRUZgIvl4uQkZH2FaQd3YMo8KrV3PwVOdJSIE/8lcgpUkNVRsxM5jm1vuzLZeIIL/uQ
         HlTEJX+X7j/DYZxf38mECMctw3vvua/E+8Zrl0jztuGlotlXm6avBLsToEr1YCnkp9V3
         YRrzoODxjKmq0Oyz4O47Z+VmwvVmjxQdcw6etOZY0qhZTYubnLnfwptiDH2QQy8Dxb+b
         fnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751058107; x=1751662907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVkiLoW+WhEvJVFsVSCdFiMn0yOGk/qRboufIllpA7k=;
        b=USF8IdZuueSxltSlbG9CvL01BFRjC5F5TZ/jnD40tjlsSRH8jBeT1wobkJGmuRb95a
         0XNeTMJ4rXcl1G/gdPHO8KOSbTeZEMqdcQOFUe+u3TbPdH2zaK24PRIC5UJCVqzlCQGd
         Wuu5xBwqcmDyckfOGmyts+Rrc3zqeWGOKkLL7WtV3vUIngSBhqzZMxZrjoOkjbdw2UMD
         TjVfsmRA58ylRGFgr8o4dgEstGtAQQ1v4FuJ11vWA9IKTG8Cpca0JoeBHsmbn9kDTTKl
         7liS5bAGW48JNBJk8cVpomyJ2/5XbRCJSDj7zsF9Qsb0335F1jDifUWvWjPdOeBquSsk
         vwZw==
X-Forwarded-Encrypted: i=1; AJvYcCW+CkG++5H4A4e7NGJblpTo/IKyLvSw39QguDmPZPleF0RfCA8j0aD5t+YL0bLST4774thhH6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKN5aYklX1uwZ7VT1C70F1mwJwT1NTjoFTGCGzusRWKUayIG/d
	57VZhWoupiIt6y+aJjS+rlaFy8worGWLfy5A4a5RtY3SvHJ0JfXSxEcozdDXlQYW47eUuFyv9FC
	2hvBYo8I7xALxDDvSRUIbvVISYUKIoNWBGF0jFlmP
X-Gm-Gg: ASbGncvENqypD+0/FxhIR7nWslogMCguES8ERDIX8NFNBCRhxzcd5OZWSpo7Qjz/8dk
	CoY/W2oJe9EaJs6PC8fykfbEmDKvdpY+5mmdBYoGmgNZB6VCaS+JoUyW318Xj2ojTcgj62atZ6e
	d6dAZrfqqxoQl5N40jeaLc9EZJOF3TaVdEKHMhHuaRgNeoeMw2IC4qOc3oAFMiqoT8gM/mzYASX
	2kQ
X-Google-Smtp-Source: AGHT+IGIlZszV+vD8LgZ11KMtgBmK6kBgah+hnTkdROAwpbWn9N27Q6Q1+Bkqd++xx7UoTXpR5xVaXltH+m4Qkjkoj0=
X-Received: by 2002:a17:90b:1e51:b0:311:a314:c2dc with SMTP id
 98e67ed59e1d1-318c921f566mr7186788a91.14.1751058106438; Fri, 27 Jun 2025
 14:01:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com> <20250627112526.3615031-8-edumazet@google.com>
In-Reply-To: <20250627112526.3615031-8-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Jun 2025 14:01:34 -0700
X-Gm-Features: Ac12FXzmJhlib0R4ButGMb-KarMIZCXueXEIr19YgIGr2LGzHyMF84sH66CzHxc
Message-ID: <CAAVpQUBDODbqyRh4uh+Kwz219K_8SDHr-RQP5AYLW27PzvZuyw@mail.gmail.com>
Subject: Re: [PATCH net-next 07/10] ipv4: adopt dst_dev, skb_dst_dev and skb_dst_dev_net[_rcu]
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 4:25=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Use the new helpers as a first step to deal with
> potential dst->dev races.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

