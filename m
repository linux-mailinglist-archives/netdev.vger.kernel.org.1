Return-Path: <netdev+bounces-195090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B20BACDE61
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 14:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E073A6920
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 12:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60DC28F943;
	Wed,  4 Jun 2025 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFrFBXUc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497F1D5CC4
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749041770; cv=none; b=RKQknEU2Nuos4hYHjFAgmmVz59SBhTdaymz3b3E2O8rxMikEIqgetKNUUb+FWVBcKU1lx+JKkxkBiseRWqnugEXU3i8sHkgbD4m4nIa02L0JdxTE8WG5Z3wM0GoSS6d2ZAbwjA2S0grfpHhR7LcGTvGGxo2bb0ChfGb4SkxkhTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749041770; c=relaxed/simple;
	bh=w3fxiq+iwV3pIjcBXMWH0MErnTw8kpcB5r77rQHGdwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBDl1+6W50WerWoiXwVLOnpGbfoU67euON4FhjF6GUnpj5TMds3dm342cz0SIlVNpJWaobhkps00K/I2VwJ2ChZAdGc7Vhk4NZXqm/wnN0BqTOqpYRIBGOqkB5l2wPGGz8CzP32FtfDEfVBr0drzqUJjynkMYtSwWWlOeMR6E0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AFrFBXUc; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a58ebece05so33906721cf.1
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749041768; x=1749646568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3fxiq+iwV3pIjcBXMWH0MErnTw8kpcB5r77rQHGdwA=;
        b=AFrFBXUcdy2LDGItwu2ecTZvUf8oRnaXQ8C0IkwwEF4RD85TQdcPDwY0W9bQhMMbgT
         86PuWSE79ribm7dcEb135BS8Jkd3gg8Rml31l6qA1yg5YTvCkZ+Sv6DjoUoUBLCq5kTI
         h4Sem/zcJcdogmBkMu91g0OURzjO7JGjAIIQF6QuCxQF4Ze7YR5vwMPSUnZBL/zVxIv3
         phK729yqqsh3wWQAK+p8QQS3rmzt4pj4AU39zhhEIZyxRSQ7CM5S5weC/01cmkPW2u3a
         7KUaXibRkfn0+SBMrdg/DVGuI9/aueNQY/MFjlcTJEhWAUZuX3tWQd+ZNL/NdWQX6YPD
         vONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749041768; x=1749646568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3fxiq+iwV3pIjcBXMWH0MErnTw8kpcB5r77rQHGdwA=;
        b=OP2qPh9JMP2F2RAMMlDXRB7kcOLmagWp+ccv4OrSTtvVBnZEXQCTvCP8F7yTG6jdUm
         WcMffCrYiGsSAUjke43yl+Y8wbqUejSTvQC1WmXRm/AeY14ia+mqFasKDRkSo4nvIktd
         suD9RWF3gYK8PxfHUiPaiDTHJ0JpOe1jylB2s8wdp0GogYpOIF4jUJzt3IpkIoQBY0ku
         7tWh4zh3vRXXEaOEIKh3yAtVjEzrGec4SiZkF5TqitlT8A5tvGN9cBOFaczwAwt9/cvg
         erTT7i4C08tQHc82u40ogyCpCyeMj35n09SaHbg5nhYosarYEAmqWLsyZoy1st8MJzOR
         glpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaO6Rjzy7Me3cH3tMgvfQuv/7f+CaovQsjROpEeonZm2zhJs196Imrv9W1mxYMORhJEfb2Qxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pX912Aeg+ROuRpBG5svXxGPKhVBeHqND3vV9dYIaSzHBPJKc
	6kWHpaYnDsyQNT3TqastLfnzfeWJpMuP3poCC18gj1JSVroQDdbuWq2V4rBRTbLeK9s9M/fNElr
	wVb4t8NIcGVf47LqeLBJX7nIqMfRUEVfaProy0eCw
X-Gm-Gg: ASbGncspxQkTwd9ZRcfrXv7zXmft68WQ6ORdLKEWcvOqlW8PbKdzlLwQjFEpbwjWuKT
	DPT5zQfYfUIEROtYp2EaGF/26ldKhp6FqlD3KKJTC77ztffdXqed8cUp55mGeW7BWT0guBOeAFB
	hxn7cYHuzdnI2EO1jJySSPoZDXekSeLlqlHZjB7aLg1TU=
X-Google-Smtp-Source: AGHT+IE788UnxluCRBSR+LAkQBjc506hu3vvFW7EuLgv04oUX6C7yoDlYedRbU67Gy6R8Q9Tggh1VoL6gfTWOrjz4HM=
X-Received: by 2002:a05:622a:2c7:b0:4a5:a5df:d1f9 with SMTP id
 d75a77b69052e-4a5a5dfdc42mr42174421cf.43.1749041767672; Wed, 04 Jun 2025
 05:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430085741.5108-1-aaptel@nvidia.com> <20250430085741.5108-2-aaptel@nvidia.com>
 <CANn89iLW86_BsB97jZw0joPwne_K79iiqwogCYFA7U9dZa3jhQ@mail.gmail.com>
 <2537c2gzk6x.fsf@nvidia.com> <CANn89iJa+fWdR4jUqeJyhgwHMa5ujZ96WR6jv6iVFUhOXC+jhA@mail.gmail.com>
 <2531psgzo2n.fsf@nvidia.com> <253y0u7y9cj.fsf@nvidia.com>
In-Reply-To: <253y0u7y9cj.fsf@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Jun 2025 05:55:56 -0700
X-Gm-Features: AX0GCFshygdM5kPCn2cK1pkv93U_-omBbSINFfT-gL4d4TszBj6-pmrtv8ACoXY
Message-ID: <CANn89iJ6HROtg3m3z8Ac61e0Ex5HvgOTNavfG_W0j97B0XMZkw@mail.gmail.com>
Subject: Re: [PATCH v28 01/20] net: Introduce direct data placement tcp offload
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org, sagi@grimberg.me, 
	hch@lst.de, kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, 
	davem@davemloft.net, kuba@kernel.org, Boris Pismenny <borisp@nvidia.com>, 
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com, 
	ogerlitz@nvidia.com, yorayz@nvidia.com, galshalom@nvidia.com, 
	mgurtovoy@nvidia.com, tariqt@nvidia.com, gus@collabora.com, pabeni@redhat.com, 
	dsahern@kernel.org, ast@kernel.org, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 5:33=E2=80=AFAM Aurelien Aptel <aaptel@nvidia.com> w=
rote:
>
> Hi Eric,
>
> Any comments on this? Maybe I can clear up something?

Adding one bit in all skbs for such a narrow case is not very convincing to=
 me.

I would prefer a disable/enable bit in the receiving socket, or a
global static key.

