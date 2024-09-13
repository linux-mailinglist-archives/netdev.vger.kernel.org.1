Return-Path: <netdev+bounces-128216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70A597884D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 21:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9076AB251F4
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FEA13B59E;
	Fri, 13 Sep 2024 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rysH3xKb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03F783CD6
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726254000; cv=none; b=dzT3IdcpS9Z82anMtQltylb+JyMuS+hRDn5mDqaEmPa96OtRhuE1FH5otIBhFhQqnSNlyce7Ppo1ZmNCgcZ4auTfgzZ4rjrilcEq0qpTv89zeX+2bNQfXcxs+0pJnQbI9bk/ftIoMmobIK1FpR6cn69aLyHQxsObguwwRFKr8i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726254000; c=relaxed/simple;
	bh=wpbv/Ypn1S1uipLA2hFz9FfiEnh9Vqi4qgnntowCZ2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JD52fGgpOZ9BikJH6TU5IOU+35fIx1WFVJuoTfwfuvKhHrROY5vzh5tihbfyGbChm0cGkusfxRuE7CC8k/u0/0EJMmzRoU3ukgAG6yZBatb+Hr/WytOKA/BK0xbt+xaoJXl7/DsBienMPJYjJoTve0CERLV/RaaThH+qzsi0IEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rysH3xKb; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EACE23F5DE
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 18:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726253995;
	bh=wpbv/Ypn1S1uipLA2hFz9FfiEnh9Vqi4qgnntowCZ2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=rysH3xKbByvPFkV+sgXBVeTwDcWnDD+mEqiEXd08BOkg1P6ZFewzSmm71rXR7cHVX
	 BFKS03oRXvhyb8LI0t1HnS0maht0qQiMYRSVSjXj4t66uPXWP+iSkIxpGx4kKlPgRH
	 loKxJObUHWTrp7gjC4OrJfvKWAREfmmPBqsIDQwuONhLPgqIZVr7PrBU+9eTLfjP3a
	 t29rHkfvcnNsuPQnaCthwEux18H0r3+sQ1rQartmws63cQQVKL0g2BjO9kLAuL/fkP
	 PgO0Uyc85zlleVA4DXGTsohOIR3kZsYK1fHtTI3WU6dKC2PitQYRad5gDdNxFTxfTw
	 F4V5U2Hk0pMbw==
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f74d4423d2so19896731fa.3
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 11:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726253995; x=1726858795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpbv/Ypn1S1uipLA2hFz9FfiEnh9Vqi4qgnntowCZ2Y=;
        b=asxDfhkq+egfpsbIyMFFXSN+fAQoFqQ5CqJ0bqkmGR6aVxoUS4xxwNJNRcTF7xcQ2a
         PJgXdkaT+zFMVw5C3duokksH+MKFcQ+6ypj1V+FSX2c9AbbShGotQEbBfluEnTIqsU5K
         zuq8jclhIlNHjlkAIYkDkNCHvvllYKGDJ3LDmI90WShm3nL9A8/mSTjZ2qFuIcW1JIrJ
         e62bx0puOTMVkYQVKdkmuRUC2sUGuwZLZNbLgRu1lapXYgc5oWwDtJBhOBLzo4KKZPRU
         NM7UE6qQizT8B7Hl00gerp+ObXlM7IxEooo+F79phQkexmB00hmKr/WEIYEMfDFhxz09
         AWDw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0pMdTFF593QUYwxLMYbzOUPqztSu3hwPUVSSDQEEApez9fcF3HryGMc4zwinnu32nB3t0w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeQuubEVHWIoYYXPOH7ObWctJjR4QDCL8u2thCDJ+vj3KTwg3I
	0Zt6+9sTOfysSAtLOpBZpOxfYsjCh9onIDqCuw4A38+F4ZAqoTIV9+PLjdEbenxe/cTAb2tkZJn
	uWL4ZUoKTTsS4+NjwURhz6t7s3vvKk766OIyPGD5WGVVgxLWITmXQ7bUdVYxK8Gw2YJOob4bicZ
	R5484OZAKsQweuBZSfE/rr4VqgIEML79rxvIzfNn+vYD/G
X-Received: by 2002:a2e:b8ca:0:b0:2f6:484d:cd61 with SMTP id 38308e7fff4ca-2f787f508aemr42687701fa.43.1726253995199;
        Fri, 13 Sep 2024 11:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLGUYMl89leAKfovfViroUdG1wecKCCAwr+u+OV4SS3394qQeK3Zw8qJCRvMCI/rodniz94xbgppjljrQqRg0=
X-Received: by 2002:a2e:b8ca:0:b0:2f6:484d:cd61 with SMTP id
 38308e7fff4ca-2f787f508aemr42687431fa.43.1726253994147; Fri, 13 Sep 2024
 11:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uZDaJ-71o+bo8a96TV4ck-8niimztQFaa=QoeNdUm-9wg@mail.gmail.com>
 <20240912191306.0cf81ce3@kernel.org> <CAHTA-uZvLg4aW7hMXMxkVwar7a3vL+yR=YOznW3Yresaq3Yd+A@mail.gmail.com>
 <20240913115124.2011ed88@kernel.org>
In-Reply-To: <20240913115124.2011ed88@kernel.org>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Fri, 13 Sep 2024 13:59:43 -0500
Message-ID: <CAHTA-uYC2nw+BWq5f35yyfekZ6S8iRt=EYq4YaJSSPsTBbztzw@mail.gmail.com>
Subject: Re: Namespaced network devices not cleaned up properly after
 execution of pmtu.sh kernel selftest
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jacob Martin <jacob.martin@canonical.com>, dann frazier <dann.frazier@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Sorry, I missed that you identified the test case.

All good!

I will still plan to turn the reproducer for this bug into its own
regression test. I think there would still be value in having an
individual case that can more reliably trigger this specific issue.

Thanks,

On Fri, Sep 13, 2024 at 1:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 13 Sep 2024 08:45:22 -0500 Mitchell Augustin wrote:
> > Executing ./pmtu.sh pmtu_ipv6_ipv6_exception manually will only
> > trigger the pmtu_ipv6_ipv6_exception sub-case
>
> Sorry, I missed that you identified the test case.
> The split of the test is quite tangential, then.



--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering
Email:mitchell.augustin@canonical.com
Location:Illinois, United States of America


canonical.com
ubuntu.com

