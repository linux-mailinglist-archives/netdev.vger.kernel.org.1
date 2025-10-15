Return-Path: <netdev+bounces-229458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E135BBDC986
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67D03C7892
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 05:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD1F30217C;
	Wed, 15 Oct 2025 05:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vnOilEDt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922D3019AB
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 05:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760505978; cv=none; b=KScWin8pGiJDfgKvg0cQqiuCHkWvK1IybDlw0g/3n4nPaazcno9KGwSgN9xDkC8X92zs2DxXqOdBgxyg6u/9qSNCvONNPyVMr408BCJGsHsL++ubERuw88wrr+gIASlkO0w77TTO/WEFQNr3xAowl8gLrcnsVFSwhfKS2Y7a3Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760505978; c=relaxed/simple;
	bh=LYdTZeSkHmXK/UfVBmL7CF2CAYNY3YXTMRjnfinIcdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHUwvBCZ4rX8tlWg349iYKwMKhxZ7m4K7VC+ZzOmAgHPp6KuOCWi38GeUrmKzyxHBqHZqCxrFW+84B0wZ0NQWOHsqyeZKAGOmraGwpNdlUDSwRRAxwtaXOB8DxWnQB/s5gfldqk2BZN2dUDPvkxXOHv7Hu72d4DEy3qrqykaJro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vnOilEDt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2698e4795ebso59857045ad.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 22:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760505977; x=1761110777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYdTZeSkHmXK/UfVBmL7CF2CAYNY3YXTMRjnfinIcdY=;
        b=vnOilEDtbv+1zHVKmNMcGH55vvyEMSvtwGJo+3k1pRlL9i46pswrkOFFxxNoR9aOJC
         lFX6RMobXeEJ4/A/EZ3JQAQ71Jk84GhcnVLXXtOYG82jLw16iW2KUmCGnyyVzWas1Hdb
         dZ4hO4mPpGyq5p++DrwFOv9BYgy17SyjW7G32X+HhIgfd3B3eda44d8aptxqR+HMWE13
         qnnAXsZ9NPevtjYdBMlJUgDCtDzOuSlA2T43cfmwx0rRssJrsQNyLSVp16gLDlSHuhLP
         xRk0MuWo2gKJGU7k331uAPywkxVIloChEGNa10WyKSmzcqc8eubxhsSNMpGaw6QWQRi7
         9jZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760505977; x=1761110777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYdTZeSkHmXK/UfVBmL7CF2CAYNY3YXTMRjnfinIcdY=;
        b=ATA3WKG/l8r8m+ECI151IkAyxWwQWO8+C8PIoJ+w6/7O1l9ZKHrNZOZEOBEIvECKW9
         Nab6gxdlC3cAGxteSoWVKg7W30MZphB/ACjvvUmP08P87yOz+g1NVQgGV3drgSPUawm2
         a1gHF7vH78hTOmPZc/j+Xx9l0UZ7Jj/jxIP+d2Qsjjh9Qmce6jZNwoI/HtUQy+pAEln1
         sjVeus2Hs2WqLbwLh6zdIK65zflw6zoMe9tJkAQvY2SwrwOZjH0YJ5QOLMrBUbqavKOS
         Ea3iturqKFfBI1JBkhB8RAbfilvjW6j7VWF6P637dkMa47V9XAbTUUqJbLIwfr3NsbIk
         Kinw==
X-Forwarded-Encrypted: i=1; AJvYcCWm+RvKp2YGaOMcSpJ+aO/8nJ9bD8ih7bzK1QNEmUkbE2i9x+ijFjkpoT9NWb6YfYhdkrIx32M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdcmSUhTeJqP7Ef8RRYBYwRO5znEaHG7v3q/TYHUolQe6tBDqW
	R+tMcOjZmupLQjSPp80tGRpxqWiT1WRGTBcQuRuu5y9zWmGq5S9b5plv485KoCc0mUSV/3Khsdg
	a4pxCdohAPmxhZw3sZucw5RPgHoZRyfNz3YINO7j5
X-Gm-Gg: ASbGncs1AWgIodJ4N0Hm/C9joxGb0J0L0jlFyn8uUrrB7HkHS583vfTWeY5ODt+Srx4
	G8SFxg75JRuVZ4qOb5xJ5PgyOFuM3GnHeJ6rRXiblEi1eVifKyMK6Ckae5/uyEDq+4tpN3F1tEa
	iTu+YYkNiBPpO0QyefdgipRgihKmYyYQ50dXJ8MmkBSKMgit+RWNgUtxw9nTsO8QSreejFkZqW9
	NpxG9qmch45/iDyA5y3Xbs/BZNoV9XinFdwDNVXHUEvQ2PjcuY15WRCTBvFZGP/bWYyyHOFQkw=
X-Google-Smtp-Source: AGHT+IHKPpzKquVV+RWDvGbtkQV8PZmp8ee/oS2SffryLHtqifkTb2YfiM0T/CKyjRYiH0Xq6rAAt9f2zU5sk6Fn05U=
X-Received: by 2002:a17:902:ec83:b0:267:d2f9:2327 with SMTP id
 d9443c01a7336-2902739b36dmr394913485ad.27.1760505976387; Tue, 14 Oct 2025
 22:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com> <20251014171907.3554413-5-edumazet@google.com>
In-Reply-To: <20251014171907.3554413-5-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Oct 2025 22:26:04 -0700
X-Gm-Features: AS18NWACJUk2yHmTtUcH6RdKmuvlyawNW6fYko4v4VOw7badTGu4x46Xxd9wsWw
Message-ID: <CAAVpQUCZ7sFa=w4htZ0_1mj9ZBW6-rzqXewGvsMei_vxxY4r+Q@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/6] Revert "net/sched: Fix mirred deadlock on
 device recursion"
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:19=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> This reverts commits 0f022d32c3eca477fbf79a205243a6123ed0fe11
> and 44180feaccf266d9b0b28cc4ceaac019817deb5c.
>
> Prior patch in this series implemented loop detection
> in act_mirred, we can remove q->owner to save some cycles
> in the fast path.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

