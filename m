Return-Path: <netdev+bounces-215414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 426F0B2E878
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8866B5E0B0C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 23:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95DA2C21EA;
	Wed, 20 Aug 2025 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A5v9YISR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE891F4192
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755731526; cv=none; b=WsUDzx/kahslbGyXo5CmjhPwrAnDyEpfySkYy91V7Nr0uXmOcyzn8mjYDD8JAw9A+m/sN6uWdaGGzsMMAH/D21saS2MftouLv8xHPBAzXaQ5eVjpRb1ICeWefkezoWxeEEyKWUffXKjc1VST5OA+fIGFWAjQuP1LX4YhOvRCuiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755731526; c=relaxed/simple;
	bh=n/84RdokVTRag+ji1v92k++4Pzf6tkdSQ8B9HCGW8cY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVV1Olemcf8kV0T1H3oSAmBfChTkTIsgvoX3Fi4dhxUzqDfmxjSEiMksKsdMHwNqwpjidrKyz27d5Kj8YbN7SgXm0RBb0IX6Qm3strGYR6NPWg/e+7sQbEYLZPur6p0b33S6lNGUR0ltZpCFqKIgAKO5agVs6eqYLBTumRsSBYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A5v9YISR; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55cef2f624fso1731e87.1
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 16:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755731523; x=1756336323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/84RdokVTRag+ji1v92k++4Pzf6tkdSQ8B9HCGW8cY=;
        b=A5v9YISRhti9E9ooHYrNQmL/RC8w7/lQISwez9SflD29Uc4fe5gQMdD2119VDFOPCx
         Rh2JbgvLQFZLQT+7QJhTC+aya8rTXrNyyp7dovGHNlW5Hp86rzMt0tNsKcLtaXRbu4Dx
         v3qz8CnZB46hHuDk8h2hWFBitRr7gGtvSz4jVO5D7oKpX6KBRowClUIjZQ+Oy7jc1Il3
         O2CXBN64J0cIncx4R51xjnh8fxd4yhShZ6Dixvw5ADJznsN+FzmBtKzETHarcb8G+VOR
         xCyzq/CaTR/sGOc5V+CubT/hXOZmNkudatfkBOWVsXc35+AuKsxtqWxqTeqpcsCAaSjx
         q4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755731523; x=1756336323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/84RdokVTRag+ji1v92k++4Pzf6tkdSQ8B9HCGW8cY=;
        b=UzzYp/FTwSK0PZHLopoUE6bvpDuBCednGh5Of2QV8PU7X8K25m1O9AbJ8FM4say6dt
         zjHRuWMMseeT/9ycbE6XswZhb7U72Fn6axsC3uwyq16pdk45du+Zcf/k8KVcwdcnISia
         FYjKiam54Eeb+gul4V1MUva6SPd52v0E2d56J0NfCZ3Ip9cw34Hzz0FUOzQ3W5Jhx1Fq
         EQpunlBA2gcXe/gAm9VgCK8sQEYDXJgDvu8CEz95I7xSXUD4Aq4TiJxRwkzZJDnBdgGu
         il/6Rds9Ui4aagYdKsJMAxnmds5XU7pQKFPN5KZwXJeiNPu5GFcBe8vzh0+u1fFR4jxf
         AEmw==
X-Forwarded-Encrypted: i=1; AJvYcCV545MY6FTLbu4OGzmK+8KNtn/l+zzdNMyw0t49sMZCQ0Dc2XlUKDPCXMHFkFEu55ur7roDKhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGYNwHtIvYUmMYEtBOGEMlrJbnFBnxSjTNblmllw7uRmRKIKCP
	uOCMLhk0EwFlieUEjCPP4EV/ZUmGyvucky4fUZ6guPcWYKql2Yj+kUKy9k200kXTQIQ36Yfq4is
	hgltpqJ2kk9troxKfjPUjI+7VlNvG5O/F96tzINq6
X-Gm-Gg: ASbGncvQZRALzsFTvvXbbO4V40AfyXQ9Nv4UhoJEhobHpgv/bFpJxYOejGvtFpciLud
	3seS0l2jGGKeuWOcATXP6ID1KOmq4bqBJ6Ba32vDjvUrLesWRij8TqaNa8TflnQutOn7RGqfOze
	h/DyCnVw7TPMqwwHACMKVWKlO0+GUtyy70nBbz2I+0VlpsHJK9FXliAC2w+PK9PWJ+Nw/+2cunE
	RzHO6njk7/lBwC4+AepYv2VTlOG9g/gkErUlObxLVcY
X-Google-Smtp-Source: AGHT+IE/+mpwBjcOFpWLGVPanPFrtXvF7krbJHMpm2OEbiA3PHC1LH9z05AlTMZ9NMVsIITKLfWP5rImlM2FnUNJKCM=
X-Received: by 2002:a05:6512:63d1:20b0:55c:f078:44b4 with SMTP id
 2adb3069b0e04-55e0d7f2e03mr34671e87.4.1755731522980; Wed, 20 Aug 2025
 16:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820025704.166248-1-kuba@kernel.org> <20250820025704.166248-2-kuba@kernel.org>
In-Reply-To: <20250820025704.166248-2-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 20 Aug 2025 16:11:51 -0700
X-Gm-Features: Ac12FXy6hw0mIFHjsgcsduvVsajHhs8x8RKgJ5r_oxMV_0s8pw38tAfjVPoSboU
Message-ID: <CAHS8izMCYAc=wJe7cx863DCPM5mAup2JCOchA0R88usS7QKcLA@mail.gmail.com>
Subject: Re: [PATCH net-next 01/15] net: page_pool: add page_pool_get()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, tariqt@nvidia.com, dtatulea@nvidia.com, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, alexanderduyck@fb.com, 
	sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 7:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> There is a page_pool_put() function but no get equivalent.
> Having multiple references to a page pool is quite useful.
> It avoids branching in create / destroy paths in drivers
> which support memory providers.
>
> Use the new helper in bnxt.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

