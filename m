Return-Path: <netdev+bounces-142403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A699BEE3E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 14:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9601F24CCF
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5261E1036;
	Wed,  6 Nov 2024 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBFY7e31"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5161DFE33
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898898; cv=none; b=KkNe4LZYwUqp4HuDTP8wOkdtvxwj2eFaVOJ7I2cb7BN7mqoMfFBzmVkic6I8kCfSQhUvYt+vk2Z9fV427mIYO+Hcp8KOioQt5KPAosz3xzLCsN7PL182QTYTA738MGxcYOURXtlzsySGvcRZepFBbpeDZxBqkougQbZJqaRV0Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898898; c=relaxed/simple;
	bh=AcUeTOfXcYXdal083VHbJsj/JuTtEm0BnKUu4VSjIQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jc5AzMMaBDCGqbjw4el9IA//z/MVmxJS2xJWKtkiYnEa4tgxidUSTQv404UbD2eHWDH7uMne8NDBjU9OpK+JJej3JskDBUL84u7lEGEI8Qo8qplH6jdqKAwbbiXBWwaqfbb935eBBoCwEm3JZvRZWiD4tKXIWLbU9sDkWMpUMRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBFY7e31; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so8997008a12.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 05:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730898895; x=1731503695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPm+mOfOO9zfbvx9w+2hHMK/7azZZy7nuKIv8Xr1yHY=;
        b=NBFY7e31NpBbRaRGFDmwNtEa6lSYWDdUCDQRlQirCLfJAXb7bGSCHnsIZ7KDJ0n4If
         QykfexuDNDEyRPHy9EKkooLTls5ylIZ8MZcPtZpNWEu2g5AxHmTvApeUWMFPyuhJLYKR
         ECNLcc9ZsTCd5Nz5bYk2ALyzMYATAgOp17t6xlU5VxbIUrjlolsJT89Z68mVU91Nieys
         ZBx/2838Z2CzDOyjXcLmbz89rVRDPlcgfPOFwJpoOet8NQYaAy0YFOXSuUy3TJeLOBBh
         rJ4aAdP6JPinGSmgJMI5qmthimm/A+YD2bPx2Pb6nCr9i4v0jZkKdt1859ZbF1Zae8rH
         hNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730898895; x=1731503695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPm+mOfOO9zfbvx9w+2hHMK/7azZZy7nuKIv8Xr1yHY=;
        b=EJYT545Djjj3qX3zMpbXaeHmIMuWAar7v+Iq+4ZGKUw6g287QAWRkgjih+6BTde/v2
         rA28cqU8EfEeQiOQkx3M2XPhDwUCbsN2cre81w0r2l9guhCJHkQCCcbaNDldqSd+oUz+
         K98Wt7+xwBKK1uyy/rHOYoU3x9Ma6pDeOJ8yzUbiHceAPDubngRXiRhHLsHJhED49vKu
         6zAWJVjLCQG336j2HZUAASVkVToFLdG3+JWuh2QDYBdExzXOqrKR12JDaLqikwZ19MMi
         HIso08ccTO/dpauhKJVB/R1ZCBf9eQMNmRTxGFqBslEEeECqfVz08ejjEp/eOli3PTwK
         295g==
X-Forwarded-Encrypted: i=1; AJvYcCWw7G2pQLyj5++Rp8y6UvDlaAa9LcxGqlccmKrScf6wlmR6c9e6pVgBxeg8mw0g6twBqq29nZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7yb9PEZX+pNKgOG6HmU3ATlDaHH4SnnohrM4SDQZ8Xy45NhTp
	YTxjKF294hF47T7Gc1Z7MEiSejWbIFS009hwGlU3QpDL9AzE7W7FsWgjZMxlJQOL+OX9OXSEJ+4
	dHQA+DfvwaBJ2UxdQXF1GGuu+1T/dudozQbdMuyUaNRCQU4+RHDmq
X-Google-Smtp-Source: AGHT+IH6oFDv1Rd00SIWlZiKvMqIB7P7tTUCd0NAdKJ0OALzzPRaCTzASlsKHN862R5S8POfwtC4BNQlGtp8eRd9XP0=
X-Received: by 2002:a05:6402:2755:b0:5ce:e5fa:12d3 with SMTP id
 4fb4d7f45d1cf-5cee5fa1482mr5514349a12.25.1730898894764; Wed, 06 Nov 2024
 05:14:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105132645.654244-1-edumazet@google.com> <20241105182552.072b72b7@kernel.org>
In-Reply-To: <20241105182552.072b72b7@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Nov 2024 14:14:43 +0100
Message-ID: <CANn89iLiTgz4jYu9qq61N4GkbsZ1e8vNqFB_zogC=p_GtoWu-w@mail.gmail.com>
Subject: Re: [PATCH v2 net] phonet: do not call synchronize_rcu() from phonet_route_del()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Remi Denis-Courmont <courmisch@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 3:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  5 Nov 2024 13:26:45 +0000 Eric Dumazet wrote:
> > Calling synchronize_rcu() while holding rcu_read_lock() is not
> > permitted [1]
>
> Doesn't apply to net, looks like it diverged in net-next
> --
> pw-bot: cr

V1 was properly sent to net-next, but for some reason I sent v2 with
the wrong 'net' annotation.

