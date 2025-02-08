Return-Path: <netdev+bounces-164293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9C9A2D41A
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 06:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52E4188DB20
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 05:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9044A155A52;
	Sat,  8 Feb 2025 05:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P07g3G3+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1649817BA6
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 05:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738992703; cv=none; b=RpEsrjamWh1Jh97n1aBwqsDXI6DqFz7gfCc3P3DnO9WcpfSnf72CCaGAFtgXzFytD1YFayBaD0X9qNxX/B5VSw3dQwqYtC0Y51biGjur8vUyw5KurirQ/DE2Ab1t/7dBo897UxMK893dXKA7VhiHrL6qJSuJ8+nLfj0DgUWYMuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738992703; c=relaxed/simple;
	bh=D0j9KNP/JprTrWVrRkkC/Rk5z4hiUCsS28FTDhbgNYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jivz2Dze/9N776zUeuJLxVU+hEvKALy1cncCD51wTDRLeKtTRIsZvJ0T+VPNwAQnsOP+quEOJyN/0RQ+b94rSu0GnM7xmi40Tq1t3LDOwLY3cHcrhBvmB1Jcw95ccQPS2BurjxrVa32sI9vGT92N8zdruegyJOrWKhgAaeBvrPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P07g3G3+; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3cfe17f75dfso23694895ab.2
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 21:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738992701; x=1739597501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0j9KNP/JprTrWVrRkkC/Rk5z4hiUCsS28FTDhbgNYQ=;
        b=P07g3G3+hTFYH3TN8dgRdeb5lg7KpYwOH++OujOKxYs+ZnD92sj2H0bhyw2Jx2KTJi
         9y9QaxyNcC0G62pSmzTVzIq651G2QZ1hTNAH+ojib9IYvBzlpTn2zjWSiEPGRqhEn16Y
         mM4MKRwJKFvNy7PumK77/HsLgcR03+bzBvHCcpkn8omgLTwLvWPDD3O3fSIzO4JYFgMH
         HrehiUuSLoMZxx5tVmtdigL2q08quwGLsXtLH+TYf82MY+BhR6urec1374kHrT2nI12q
         2ozELXbPmLE5WDGjBc18eKWlsuJhQD4MDVds5BdYz9jVRHbVt9peKyQqtv4773FgqpCj
         T6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738992701; x=1739597501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0j9KNP/JprTrWVrRkkC/Rk5z4hiUCsS28FTDhbgNYQ=;
        b=jcZmqK213JnQ5KROHea6JLSFq4BQd5O48Z715jNJ6Hs3fc+8zpoXaWvNsajiYIuNDM
         EWxPqIAWSywpHCQ8ZRPB96sAyFyOEhj6QTAO5xRqWsmo74QsnQMSTvBvnEiFgGOhdidj
         WPpUTxq7IGQFbh8xoiAygMo/6Xn9CIVw1v+Gs6lodtvib6XMxsxO0czDVlR9BicvU7XH
         sofwcFJG3jN22Ih+HwA3n2H5GCc0geDKS8GIKg40FFmic+wIK7PAgyBWIZK6FIlHmN5D
         I0WfLpyi2ppZQYimq0OafivQdnBzQd/ZZDTE7XhfGI7UOmRyOVfIOGpId685Z5j6cY3Q
         LQCA==
X-Forwarded-Encrypted: i=1; AJvYcCVLfSeR0vN9scR60RtJkJSbfaq1XH/CKyCsIsJPtjR/vytsLMkEuyRyUJZ7b7K9U9sPp8OujlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCMc/70AQKBhkZ92qLYiSo7Rh4vCKXiobr6DNYK++glwNIZU7L
	K2fiZc5GD1HnY2j5+yaRSuJM7zolPp9k59KHozKUPnqHYnKtB/0gnR9UbC5noUU5jKb85vGJjiQ
	WAbDKg+j6T9oQjLozifWwV8+M62I=
X-Gm-Gg: ASbGncuOAXFmvz9RMJr0ynDrXXN1NRTe3ZachaCUKrO2/Lj+t1zPK8aPLmBsQtbJxGD
	nJhLl+0kguR76GhJcdn/yG1HSpsjKZ3fW9p+T1lzOM6pMXxMibLWbE7aSUQRT9cGuiq/t6KY=
X-Google-Smtp-Source: AGHT+IE0tb8pZrq/xLtFFSLnJpqOvmxg8FGSx51DhHT1Xz0bYZ/8I7tpIBkgjmlzf3kMQV2b3EKa+hUjRMwKzNPSBxQ=
X-Received: by 2002:a05:6e02:310c:b0:3d0:101e:45e7 with SMTP id
 e9e14a558f8ab-3d13df6ad30mr52853295ab.19.1738992701211; Fri, 07 Feb 2025
 21:31:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207152830.2527578-1-edumazet@google.com> <20250207152830.2527578-3-edumazet@google.com>
In-Reply-To: <20250207152830.2527578-3-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 8 Feb 2025 13:31:05 +0800
X-Gm-Features: AWEUYZntZj4VV8p_H9pxH-7l5iuDBgZBC-jK14nmScHcVmIHvxso_Ys5GOKq6RA
Message-ID: <CAL+tcoBo3Sa76KDwJ1tjB+kPmmC0HyfLKXLCH7FmvTwxO34U9w@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] tcp: add a @pace_delay parameter to tcp_reset_xmit_timer()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Jason Xing <kernelxing@tencent.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 11:30=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> We want to factorize calls to inet_csk_reset_xmit_timer(),
> to ease TCP_RTO_MAX change.
>
> Current users want to add tcp_pacing_delay(sk)
> to the timeout.
>
> Remaining calls to inet_csk_reset_xmit_timer()
> do not add the pacing delay. Following patch
> will convert them, passing false for @pace_delay.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

