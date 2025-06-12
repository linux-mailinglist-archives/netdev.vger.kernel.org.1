Return-Path: <netdev+bounces-196795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2E5AD661C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 05:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D103AA047
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 03:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584C01C7008;
	Thu, 12 Jun 2025 03:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XhnLrgCZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD07FBE5E
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749698497; cv=none; b=K20h+Q8IzQ5wU0Mp7XsY+IceAJQEzYDT8IHruWsRBnIjulIQLsfTnMRgW+rkDulAudHpEZYdbyPu62RI7LdBZnEScWvhhXJVxWMJFiIkHynPN0k6hEI7oAGeCGqJ5FqWWJQJo00YikFVQq55LYf/C1BcPFsH1kDbkWBmoPO7+Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749698497; c=relaxed/simple;
	bh=0oT8ICEZDyuaFV3Gs6epgpIarPK6ywwWn9cTmfGVz3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amn8hCJtHtXrfUqqhwuX7rzn+1Ubcbj3l7dy9zUcKUriouIJNuOQojIaPn1t+Fcc6ZSyyvvGnH0jUaJvbr63PBsRFBMhifIlhbGLSOksF3jZwKX37CgwR3xUyhr22GohPBTx3WHzteeK/eFRCfiUpT61usQho/IIqpeo6LXoHz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XhnLrgCZ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47e9fea29easo137171cf.1
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 20:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749698494; x=1750303294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oT8ICEZDyuaFV3Gs6epgpIarPK6ywwWn9cTmfGVz3o=;
        b=XhnLrgCZ5fN7vQnGbTndDZkB16UqZ8Rp6cVz3PyVw5v0cljHzTkFSfKD5Nm6KNURuG
         Gm1yeFhhoCDyNUy2Pj++ktttW0goNCUNd4YJ9chirJhm+2cEUNGXhKlQ2/w35/c2dbHw
         UT6d3DWQ9p6ht/WL+X6LF3/pvTOGM01i6Ah61RYlqFkUXXL6mAeEmneNV+K42/72ANCa
         DbLeaEaEpLiL+MAfpFM3dxRhLdSUMGabIsD7TXHA8Ps/v7njQ+0+7Pu+0zwKeqn28EhY
         Zem4plHeftRRAvjsuETyV3b/3fWKvUoCl/xTFJ4SFYxpV3/Hyp+Q3E4FsG9rrPfq+StI
         z9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749698494; x=1750303294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oT8ICEZDyuaFV3Gs6epgpIarPK6ywwWn9cTmfGVz3o=;
        b=SFmd6pA3Lj9QJ9PBnpEDvpD180wt+ckr7i1+nMylAdjF7h+qdx87bDuDAfQmAkIxMe
         XXNFOrVC6MENn0Ge90HiCs7jW3A+A0Z9UGF074plVpTxwObT0mwsZcXQ+zffIrdg3Ivy
         8OjujTb+mdx2NfETwV4MdE679Sas1qT3SHjRC0wcwMWbTAKZkD6FAHj87MPZbB/gk76a
         HjZxVvbz0LKQvv5kzvk5+gM/2O7RYkssPxuDeu/l8j2Z1kCZLmqvHjOXbnwIzlPAu/AH
         5sPUPo7Wb/M/G4kxNPuksPfBilVKOxyL2wWsPWEpwzqyybfVQLKAoj+PjJoGprVcj3/i
         k2Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVE5zCTURgPK3vv/vc9y97CTfvJiacYQpMUg+2UHpFnW0urSZwQf7cuiu4JbD1efPRv/ShwljM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFNNGMDq96+CdKnsCBtjH+DzTuoqtis6XAT50Od677bkKBqZ0N
	pWEDw5uMWt2fKYyfZaWOhcHe4TfsyJgxYu9vq1YzuurIVUekR5bLJcD4zomDUuhBCmk0wCpaAEI
	r4D8+bxGS7PCJvS/Bb7+flyJE9CspZAJB2b/FneLL
X-Gm-Gg: ASbGncv6Kte+N3GQWKY9eUEavFXhm+uSt4xKFXQpjSBTdzW8v7R07WQJoyAVFbzACF2
	WXRjcz6cRNHYI8B41PUhmHKOq1Y/Bqb6M/ARU3L5SzN8vP8n2qkF2zodOPA1JJhlJp9t6CT/Y9a
	ByyfPhuxzMxjTKdDtqmPe+M4x4HALsAlRkrPnluHmS1p4183sRDmhuP547LbY6YaxsOoTwuNm4w
	melx/e/dPBZ2vI=
X-Google-Smtp-Source: AGHT+IFTFAeR5DweikR85SvKQ0yampLLkgKQuEHbUhwrf7J7YQRymnSFvEKiFY2/+IYxL4hvO7Pd4jjhNljl9km1obQ=
X-Received: by 2002:a05:622a:1903:b0:494:b641:4851 with SMTP id
 d75a77b69052e-4a7262f7244mr1022011cf.27.1749698494316; Wed, 11 Jun 2025
 20:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611145949.2674086-1-kuba@kernel.org> <20250611145949.2674086-6-kuba@kernel.org>
In-Reply-To: <20250611145949.2674086-6-kuba@kernel.org>
From: Ziwei Xiao <ziweixiao@google.com>
Date: Wed, 11 Jun 2025 20:21:23 -0700
X-Gm-Features: AX0GCFuwweCGCwS4rFpL4JiYAufwFGOoXAg-m_uppYfj1eXA-5ipYHKAtGAClu0
Message-ID: <CAG-FcCNrHh=Xr0wfG8F65=D+Rdx-SDz-sqjx=Dntts3wdRzZmw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/9] eth: remove empty RXFH handling from drivers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	ecree.xilinx@gmail.com, jeroendb@google.com, hramamurthy@google.com, 
	marcin.s.wojtas@gmail.com, willemb@google.com, pkaligineedi@google.com, 
	joshwash@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 7:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> We're migrating RXFH config to new callbacks.
> Remove RXFH handling from drivers where it does nothing.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jeroendb@google.com
> CC: hramamurthy@google.com
> CC: marcin.s.wojtas@gmail.com
> CC: willemb@google.com
> CC: pkaligineedi@google.com
> CC: joshwash@google.com
> CC: ziweixiao@google.com
> ---

Reviewed-by: Ziwei Xiao <ziweixiao@google.com>

