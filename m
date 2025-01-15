Return-Path: <netdev+bounces-158587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36981A12957
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 18:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9FC3A2A0B
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8EF18CC0B;
	Wed, 15 Jan 2025 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjs4tukj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB6F155C96
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736960509; cv=none; b=uNk0MJBZFME8giw+2xi1zPVWQmjem5rK5vfiCXX33pnrXx0cIoL35c0iFguLdvHyiMHYe+daTd0l4rekYjcrwjKGF6UPiUiWQUnc4vVczSSysK5TC9RXwy6SOsLbPwhqi+j9uAYAKv+V3RJK4BmnKeZIb47n5JSNqyJHx9Pprx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736960509; c=relaxed/simple;
	bh=k9Ld4PEpduao8ENQxflHqu16x+gRt7Kbj4PKChT/c+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=De9S+y4Gr336scNySthX7TFtBc2OQZwDhnnLCK8mV1foth7tPQ5k2RkBPHZCnsHWeNW1ExPJPDwTOQ+aTVYPeQ9D6pz2WrBFN1KYsVswYyIRtCR4+Sh7ZbMMvb2z22T+FxgX+D7WW+lO9cioblVSaB7M3wraFUbxmoAKL7wP+E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjs4tukj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2163affd184so361645ad.1
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736960507; x=1737565307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9Ld4PEpduao8ENQxflHqu16x+gRt7Kbj4PKChT/c+o=;
        b=tjs4tukjgfXY7IpkHNciVur+R+izTRUmAU72cPSiTqLH3j76JHYauhbREB2/lWa5D5
         9WP8tpyAIin07Z3ylKBTncwvrMTh2I79jmRDtSnRjqa+IR9KLb5ajoXQoI9zZrWfSvTZ
         UvSDffpE8ZoCnYqn81IOHactr9/gadSz+g92TJ1irO2qCH36LJWcfkmVo2oQls5osxvL
         JUy6AohIijEC5Z9QteHjnC3CZSpbsLYRnbhJ9+/dzMzduqtaInZBb62Hqxi5YIHVY6mU
         ugIA/WbA4qtX4h96SjQrctFXJGv/9nw/fEYpL5aIKykB1qf60Y1Zphlcp1Wvz7Kyew3v
         YVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736960507; x=1737565307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9Ld4PEpduao8ENQxflHqu16x+gRt7Kbj4PKChT/c+o=;
        b=dmOLtRHIZj1geZxM1ESGnvnlrArax1tV4CYOhUvL8adbVXRYJdVRh37CyZKUZRaVPi
         iM+yPv5hFSxzlEQR1YuxOmb9sWbb9LWeObB1nKZVVYtpGNLJC4K5joc5EIwUl5qyZpB8
         NmUosQsLsX2nPjn434qORgKW7uDqEJqpAlLQArWP+WvK/5XTw+apBWffJpt2y/uGdWpU
         f+HIBAKRCzGYKIk01CzHlfUqw55CeRGfbRzLSwJK6ZKPxjYG8614bGNooWB/f/0R7+0D
         M5YEADFZVB19oKmFPiOLoLgNdwwi8inwSTZM9k+9mmAnUN5uwGDD/zI15oDFOZN09HxF
         ImvA==
X-Forwarded-Encrypted: i=1; AJvYcCUnQOmIjpZQnIDO4z8nTPnlL4171YSgx5FLA++qDIRBdVaEEO3dJ1lCoNVzISuwZ0eu6masHjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMN9x2vRec3Tm+8SVYj1P85+lozkNYrnG3Frb27N/RiWTb0oWv
	GADNzGqpS+NdEHNoxuDIchr1JBzlnOzRS28mlv953ww0bOepq+XMG3JE1rvEzN6PBMuSQobKjn8
	M8ezPIu2hkEkg557lq7dWgnqs0Tnl2WgOuNWV
X-Gm-Gg: ASbGncvRk+4GdKWoJ8xT7IsoCZ7JVpktg0bUaJqIruGfArYBGKy6zzP3u/NeI6YnZkW
	NOXUCo3iqyCXPof8qu7/dnyISv4jOJKcAJ/Ih5g==
X-Google-Smtp-Source: AGHT+IFhLwpdBUHSjwS1TYPRZ1kWv3B82vk21NkidIFm5cuFIMnG0zX1ellLMugn5vCH813NgJFn+9GYLYY3cQulbJM=
X-Received: by 2002:a17:903:260a:b0:216:405e:8e2 with SMTP id
 d9443c01a7336-21bf42c9dd2mr2297265ad.27.1736960506964; Wed, 15 Jan 2025
 09:01:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115161436.648646-1-kuba@kernel.org>
In-Reply-To: <20250115161436.648646-1-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 15 Jan 2025 09:01:34 -0800
X-Gm-Features: AbW1kvZOn0Yov8lRATZu2z4DKvOfFUTpukAu5rekJ8DdAEdf-rmVdXIgzdpwz4Y
Message-ID: <CAHS8izOYYe2yrPia2_X-8qxznpurhKz-XOsdZ0tjGBFoEOcg8Q@mail.gmail.com>
Subject: Re: [PATCH net] netdev: avoid CFI problems with sock priv helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	Li Li <dualli@chromium.org>, donald.hunter@gmail.com, sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 8:14=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Li Li reports that casting away callback type may cause issues
> for CFI. Let's generate a small wrapper for each callback,
> to make sure compiler sees the anticipated types.
>
> Reported-by: Li Li <dualli@chromium.org>
> Link: https://lore.kernel.org/CANBPYPjQVqmzZ4J=3DrVQX87a9iuwmaetULwbK_5_3=
YWk2eGzkaA@mail.gmail.com
> Fixes: 170aafe35cb9 ("netdev: support binding dma-buf to netdevice")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks Jakub,

Reviewed-by: Mina Almasry <almasrymina@google.com>

