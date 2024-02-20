Return-Path: <netdev+bounces-73334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904AC85BF24
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 15:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CBF1C21B8D
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F5E6F063;
	Tue, 20 Feb 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="k44zarbN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D866BB50
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440813; cv=none; b=pLQjWSuT8HYYqSLbfhQ493EgXSjrbdHqSKvLV9tKu8B4GWx+YJjfJI/ctptbT3fokklA9CuITAs4P/D6clrLXM9d5DXnoiBJ3i4Qt25tqyZkPGGNZ+b4Elsq648E/vBzILp/UNrST5eqAfrMg2qeBbO26z9+u4n/geynodH78Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440813; c=relaxed/simple;
	bh=qPK5yX6YiHi74I0GmlEPx3bW+1Oco/V/tweMunF44TY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uADlMRSrspMmKtLdjpUI9ZEP4WEhUHG5YMU0AdGvRso+RCgS6X6dTO8jdSb+QqCOXN5LclKCB0h+YOX2LjbQ2yvet4vEAZvCNvLjfkxrjXzf1gEgN0tsZe6sdL/sgYSYfZODznZndxQRPztcw254tq55cL//xVNBzjXaOHGerXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=k44zarbN; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-607c5679842so54713207b3.2
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 06:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708440811; x=1709045611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5N8Sd86Zb8qIhq/p/NPfISEZSFULoOsvI0F4vRL3uK4=;
        b=k44zarbNa4ShBIwFqVAmyfpRq6MxUZaRk8SJGSR/2uhOX9ZeoGwRbFHrBz/12FOVnG
         Kw009dvxI6+k0AGamPiQqWE0xj1m0ksVcf75+RJOqH0vk3LZWxYXd6mUQpdDlhheXXdg
         YRaOaxzXYsKVWlAuDijs/NOMu44N1E3+uL8z04OGuRhMh0a24dA/t6CAfKPkhRhw19Rt
         nRAw20Yztn44vpRK9vWJxtK5zB0DwLiQqZ8Fb6bMaColyCmusqOjc+XQEnPmtFC3di13
         qTM0NvlrBf74KBdXejCuFm/WQym8E/yUXzjIfkB0WKMuaIuXcOLtxZCalBCi4NeRuy1q
         ef+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708440811; x=1709045611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5N8Sd86Zb8qIhq/p/NPfISEZSFULoOsvI0F4vRL3uK4=;
        b=MxSlavhyXMssVa10/PcPDZGkYqgc0TS3TB8o4Xsbkij9eaDDj7Af3CKp57HHTY0ks4
         mfyVQyYyl4l7qXbQqUypFuAwuMyLgi3kHsB7ahCVan1dzqlKPEpQ5zlxn03i/GB7t1c2
         0Rbtev/GMkaM4I4h0QFQ0hXI91jQaVsaNiHMVG9UkzFK5u5mxmzZDbcLN3lR3hCKiDRE
         nz3NqksudMvApSQH+eihVhjyfumdM9YuP6SgnPhorEB59kCd8zoaGUas2jTWwMNT0IAw
         iic6FxWEyg7StKs1aP5w+6vi8YTUm073sQSkXyAiuJB/NReCmjjsFgHREgvY5rr9NC+/
         kRfw==
X-Forwarded-Encrypted: i=1; AJvYcCUsG6K0P0E7hGdukfMUpALTcTiH/pWfGTt50e8JqBwJNBumN66dkCJdWPj/NK5yX1X2N/XMGEqz1JdsDJN/oR5Ny1BJ+OPd
X-Gm-Message-State: AOJu0YwhAcsOsp4ebATA/ABAcHN7g2U9jedbDsuA7WtuZftZWoHDGdAG
	9NdHw8WvVxerMeyaC4uwU0XwqZ/FEFvxw0pPBifNG0wbyZmyl4NKIYPtBCrSljqqpBS8lWLOx4a
	OtQVFCSVs/jnIaU8i/nME2s4vjrFdFCWGUfz5
X-Google-Smtp-Source: AGHT+IG2IfNRY1QA119wE9gZLc7xRiNx6+ppH2Va66OteJ/puDW28raREU8Z2frthwby1LISWLlP/aAOOxKai95loJY=
X-Received: by 2002:a81:994b:0:b0:607:a0ab:c238 with SMTP id
 q72-20020a81994b000000b00607a0abc238mr15195101ywg.8.1708440811015; Tue, 20
 Feb 2024 06:53:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220085928.9161-1-jianbol@nvidia.com> <ZdRuJuUKALW1Xe9Q@nanopsycho>
In-Reply-To: <ZdRuJuUKALW1Xe9Q@nanopsycho>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 20 Feb 2024 09:53:19 -0500
Message-ID: <CAM0EoMkYFtP4UTTQOwhz=mfzVbVuwo0Ra1zSv6bqG8M4tzVzSg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: flower: Add lock protection when remove
 filter handle
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jianbo Liu <jianbol@nvidia.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	Cosmin Ratiu <cratiu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Paul Blakey <paulb@nvidia.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 4:17=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Tue, Feb 20, 2024 at 09:59:28AM CET, jianbol@nvidia.com wrote:
> >As IDR can't protect itself from the concurrent modification, place
> >idr_remove() under the protection of tp->lock.
> >
> >Fixes: 08a0063df3ae ("net/sched: flower: Move filter handle initializati=
on earlier")
> >Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> >Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> >Reviewed-by: Gal Pressman <gal@nvidia.com>
>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

Jianbo,  do you have a new test case that caught this that we can use?
Just curious why it hasnt been caught earlier (it's been there for
about a year).

cheers,
jamal

