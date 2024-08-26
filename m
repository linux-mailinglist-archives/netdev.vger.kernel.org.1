Return-Path: <netdev+bounces-122001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A245495F876
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E21028362D
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0825C198A35;
	Mon, 26 Aug 2024 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dB8k/zzj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EDF198E84
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694263; cv=none; b=IaeGxnXx4xfD929IImAfFbpVtdrBIrDGcsZszNJ6feyqCaGwCo0oZhAqnodSQgyuOaUqZ71W9EPyNnbskQTdTqYxqD9e/VDkTChnKFeyWvWqJfbZi2D8TR6VQuGYm65KO+uRWuOECMpYdP0VMmsL8CJVKFrchZwLNmJ7CUmfz9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694263; c=relaxed/simple;
	bh=9PvgO9q1h/7D5jostK0u5lFyjCTvJr3Lx1ClGmA8R+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/BTMvmsy53erEgX2defVi9rpOFp2dKCulbkM0pkApotkHJ4dzCjJ6aZ9p5CvG531K8HSTWsiMl22QR41N8DBWN6oFtdb/uPo4alfvw+Q0zzIlePUGZ0f+Z3o6r9lMIMja9Cv/l5WOv1uq7PRT4nqJyJcqwU45EAFEr0Ohz9TsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dB8k/zzj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86910caf9cso745451466b.1
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724694260; x=1725299060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PvgO9q1h/7D5jostK0u5lFyjCTvJr3Lx1ClGmA8R+E=;
        b=dB8k/zzjYu7htPgPlSMTKcPAvuSbkkLbvNq+SWtgiUNoNQwY0XXQJTLaOEs1lW6N+C
         emaoWy47AJHkO7ys6SVraEpZLDathSJNnuXc8pdDOaKk7jVuZyupdBjFJ3hIh1wI52Qh
         cf9ahNH6Lcgg4e5sTnur7e8zxoHx0jzWX1xSmBn6Xl+cjyVzULMkLVhsIz6TaJoQyxXy
         TDlffmqTc1GUo6GBeK4fIQ2m/BMTYF87JxXnzmaeldZcz5rCXvNSoxsrQ7II30w3vRYQ
         v9YzTzA+r3MQT0hGgfoBZHU6KvyLdhGStM0UkftOM3mDiCkzGLfSd8nFiLwgMZRhgFmB
         4muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724694260; x=1725299060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PvgO9q1h/7D5jostK0u5lFyjCTvJr3Lx1ClGmA8R+E=;
        b=q6n06mdAgIb/k7kEm9QreNQgS5aM5GTKXtgmMSGr+S00FU+0dFZlvcjj8KmKeO4m8C
         usFyAbJZJ53sLqVHhK87wAhEvgMqHR5+dETIlHhvwbL3wSBeezgn/JQLx3WsOl0H8O3T
         UoVJ0zHZLpoV3ki1FBuTB/HWYW4EheRLctKvaAWixbIgV0IW11w7+U6IA3x/Ip3ChTur
         +L4e/cmHE2QC0wQ5GE2Rxqdq9y5vGeVgN/JIrlarQh2vkkddLJpasC7Jy79p/MAOmZld
         sQjWNq/h4n2K5teCDM/fwmvLS6ln9yuJfk/PukbZs0z/gWu9MciAG0M6iCRUkZS6LK1B
         ep/A==
X-Forwarded-Encrypted: i=1; AJvYcCVdYl1w8B9Kj+5OSxWIpivTI26AwNOKxfjl8I11HU3p/pPrIo4GY+uHLeepxRHvHt3895QF3XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnU+8iTcVXz871x6h+Lwu4B0ASKBm4OHUrVSN5zRYbw1Se37b6
	+Guqlv3heLv6GLYZhbxc5z84F52C1/tuhNFa6efwHL8HESdVPvZNIb1nN76IYNl0uaj7ZUGoTPH
	a8xxruUYSkIiEmurzAFnT+tcXP8fOxht6vhPp
X-Google-Smtp-Source: AGHT+IFF9vUS8OxBejSqqMSUmmF5xUfZGKqgaHuFma/jZA9cpi9bityrwEAFiYr+xuprhQpb+9vHN3wTjTTS6P4Q7F0=
X-Received: by 2002:a17:907:a46:b0:a86:9fac:6939 with SMTP id
 a640c23a62f3a-a86e2a22b2bmr46796366b.30.1724694259798; Mon, 26 Aug 2024
 10:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826130712.91391-1-djahchankoike@gmail.com> <20240826173913.7763-1-djahchankoike@gmail.com>
In-Reply-To: <20240826173913.7763-1-djahchankoike@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Aug 2024 19:44:08 +0200
Message-ID: <CANn89iJ0qNYP8zMz6jDtP2=n23emnue4m2tyJkE64QL_xiwc9Q@mail.gmail.com>
Subject: Re: [patch net-next v3] net: ethtool: fix unheld rtnl lock
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 7:39=E2=80=AFPM Diogo Jahchan Koike
<djahchankoike@gmail.com> wrote:
>
> ethnl_req_get_phydev should be called with rtnl lock held.
>
> Reported-by: syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dec369e6d58e210135f71
> Fixes: 31748765bed3 ("net: ethtool: pse-pd: Target the command to the req=
uested PHY")
> Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>

Quoting Documentation/process/maintainer-netdev.rst

Resending after review
~~~~~~~~~~~~~~~~~~~~~~

Allow at least 24 hours to pass between postings. This will ensure reviewer=
s
from all geographical locations have a chance to chime in. Do not wait
too long (weeks) between postings either as it will make it harder for revi=
ewers
to recall all the context.

Make sure you address all the feedback in your new posting. Do not post a n=
ew
version of the code if the discussion about the previous version is still
ongoing, unless directly instructed by a reviewer.

The new version of patches should be posted as a separate thread,
not as a reply to the previous posting. Change log should include a link
to the previous posting (see :ref:`Changes requested`).


Thank you.

