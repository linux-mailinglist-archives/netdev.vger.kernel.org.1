Return-Path: <netdev+bounces-204031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5F3AF880B
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C981C4745A
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB7325F989;
	Fri,  4 Jul 2025 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gwra00Ve"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E925A2C8
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751610760; cv=none; b=FieDk5xELjMdOqlHm+mkph0EaqkHpQlXUyjaohPXixC3zRfWLGVvDB6wQV6qFb0ojbShRjxzuLmAp6ajfZQsvfXoxvCwkYA8UARicC/a2peHbFnO32qNPGBtpL5SGs8fPO1Q+7gp6fcosi8EWA9rG/vBahs2XsDgoc/RuCkvqD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751610760; c=relaxed/simple;
	bh=bW38HoOG8BJ8/lcEADwqe31KzLD4Xuz2XljmttWHZwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXqW+Wy+BPvd8HflSqKHHuIqvAcCKisLuKDHSEKb3ewtkU10UYAGFh01ma4YkgiGxhv1esSSxCz/248TYKZpxJ32OgDterEvmWKJfP3Ypu4CMs9mZNVDLA5XwqeOMZ5RmQVAUvoEDPfunZDMt1nQlwPdWNALTa+T/Jtng0tBX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gwra00Ve; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23636167afeso6739345ad.3
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 23:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751610757; x=1752215557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bW38HoOG8BJ8/lcEADwqe31KzLD4Xuz2XljmttWHZwY=;
        b=Gwra00Ve2WpbFkfA3MHjfRAb+2hYV0wcKLZxGedQOLR0sInb7pKV2CAQ/e0zGJI9EF
         swPykQfUKBsF2RO6c7aIzjQ6IlybgmBUik0U5KJxvkt1ivJnbdhi5Xzqie23H1gNupqW
         Gnx+ciMvchigN5R2IFq35CsinRUVFV+Z8mFFlTdxXv7oRaY/xyf+nGEwyR9aHTBnjoOL
         iRGl0IfimuHwft36xJqbrXzbrobgQsAvMSXKSpYywZ/uokE5jR443r47fD3g8JTNz9Dm
         rRNUiiZ32ejfa5DEbDeRhi+pZyb5U7YjKItQ40gKC0t4cakA7Ec+1IYPd8vHXeB4EdQH
         bH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751610757; x=1752215557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bW38HoOG8BJ8/lcEADwqe31KzLD4Xuz2XljmttWHZwY=;
        b=NDCwxq8xUyyuIxyl3r3JX7xZ6FnsS/ErKIGPpkxrGtbNpBdsIALuI2QvySPbfvaKyj
         crf3LVR2UGNaXT1H0pkE/gGDyrKlamS3ERwqOeG/4tY8JVEChjgmCDG/nCtYm61Qq3sQ
         p/zG4234TgC1zVdyozPF4fPa2vDN4SRHsI0W86m+yRvHEfUjxLbm54srDDMD21gKW1Wl
         EVrqF1vIB0YKx9pjZS6O04YbkY8BESRhGod2+Hl0NWHV1ilOmL4pnzycN3vwK50QoS5D
         2amkcYsF1aVYOLdnY+xnk/kLztEQ0kJ46o14EdISfLgdgL8g5VYSH08b7774YMviNUAO
         MbLw==
X-Forwarded-Encrypted: i=1; AJvYcCU8Cpqeqmnuv9iPHyD6ERMxmDJ6cnCLGuD4H/wC0VLYV3gdXzlG3S5l+zAG0gPhsqjGZZh0pwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUb56naaIIVqRav/FnslmGf0AwVDTb9tqRs2yOXvwjZUk4Rv+x
	jqrRHO66jxnL1jTzk6pEpD3Co4JTSUzE5l3SiR7eRadh7S7Ym1X9iNQQz/yh6e2Vkm/87yDJaAM
	VPcvDngpVR+1+Pscs1jROZ+vamT84BroYe3AjLJAi
X-Gm-Gg: ASbGncvGpAUQ0M0fvI4YzN/+tWMFmH5owTceYgh7EBw7VpnU6JwkS0CS7rYxPrKikoU
	iZ07MgFIVyQvSuK1tl9zGbrwhHNeOisxPNNngStBkj3I4fMCdeIxPTpyF5ncqaktwM+Tvaz9532
	rOrvxgAxGjB2XC5JzSmuLYQ9bH8nUpxtLFNytkTeJEKFd00jzzbZRAl9tUCSQ5pmnE2hve8jJ8/
	Q==
X-Google-Smtp-Source: AGHT+IFlijuScf5GueouIoSdy88ZOExg3BGfGXdnU6iWiUuGJdQ2+xVWlfMMrPj+fBM2GhpLJI1c/WPx7/X7ynDsFLM=
X-Received: by 2002:a17:90b:3c0c:b0:312:2bb:aa89 with SMTP id
 98e67ed59e1d1-31aadda369bmr1398712a91.20.1751610757304; Thu, 03 Jul 2025
 23:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com> <20250703222314.309967-2-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20250703222314.309967-2-aleksandr.mikhalitsyn@canonical.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 3 Jul 2025 23:32:25 -0700
X-Gm-Features: Ac12FXzzwNLoSRxnyRclSXtaCVD4LfgoskTv8fLUOj3llCpKrCJ4FQuvzqJiyKw
Message-ID: <CAAVpQUB9UMXorFPUKV969NQHont6EM2RYz3xUmT-nNqVATmTFw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/7] af_unix: rework unix_maybe_add_creds() to
 allow sleep
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	Lennart Poettering <mzxreary@0pointer.de>, Luca Boccassi <bluca@debian.org>, 
	David Rheinsberg <david@readahead.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 3:23=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> As a preparation for the next patches we need to allow sleeping
> in unix_maybe_add_creds() and also return err. Currently, we can't do
> that as unix_maybe_add_creds() is being called under unix_state_lock().
> There is no need for this, really. So let's move call sites of
> this helper a bit and do necessary function signature changes.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: David Rheinsberg <david@readahead.eu>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

