Return-Path: <netdev+bounces-115343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D86D8945EBF
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868001F2323E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3651E3CA2;
	Fri,  2 Aug 2024 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnVlFVUn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2B9A31
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722605648; cv=none; b=UJvn4gooIaZi7s7QonEDaJRJdXnI2dTnmNrap7yXdRFCeu1wuvzSE7JKhR1rbx5E2qaMKxekpFdETY2YhQXwEUZaP0qaeI+tBqFl9kAZj9ScGB/Ci3NRJsfUH+ipJRTb/cwrRYw6JYriqIt6+fZ27TKRRUzPIG41ksWp1DRbvz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722605648; c=relaxed/simple;
	bh=bsnvUrRuGytk/8RPv+UQMhB2kEg5AdkKS6WN2MvbXZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRnGlw+iRtFL7Jw22BzRaqZIwufYgjtiqKNXX6Z+3MBZWOolXSDEQsOLcDkpoVrnqh9gEvZacj+ArLxqW0TG0BG6kvkPSOkUwP+zoXbWfCptuqxS29dO8RoyCf+hy8ffrHLtNYm09+q88uvMgIYzgDcGduIsaC0NGdMse4wnnqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SnVlFVUn; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52fc14aa5f5so11034e87.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 06:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722605645; x=1723210445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsnvUrRuGytk/8RPv+UQMhB2kEg5AdkKS6WN2MvbXZA=;
        b=SnVlFVUn377X3/JCRTVlSgCzjBrwVS6kq9MxvToLII6zpo3fIEyNQpG9J5UKYQuPBQ
         QgLJ+SL9GHwT5P8HlOIw03sjRbBtfo7ux+BE7+0cEFai9ECYsdX6CuSAMbZlz6D9v9Z0
         UFBvIWj3T9BOJN9bydULs/ePs3qKfX4e4z3ZamXMdBHOF6TV0aRvIk9gGE1wPnKfBmVc
         Vy2Sxp8nCrBUEJJam0tugd/xL59tX3/Zwh8uy49zQu2/rHnUv9g0nenOE2ztgzAOdz6v
         +Mmesa483R2PiCrPUBdAzNmnM5GzjQEfPaUAnnGstlL33o0wIXvyN/HUlz9/siEVAKsx
         xu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722605645; x=1723210445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsnvUrRuGytk/8RPv+UQMhB2kEg5AdkKS6WN2MvbXZA=;
        b=v5KTJFVeozVpx3133GTNEjdJlsBDndnTRoHmtbVzFjMR2fiEqHplYHAGQYSRWXtX+4
         T5wuw03SSACwN0qsvtraxxBIYdIEeK36PDZ2+LwAtAGUyscjJTB3X96JGhiNqjjLJqjv
         fpR5uKcg7L/2wqQmesYbqnKTuHfG9HLMbIhrGNbN1xABBQk8tQD6WdPYiP+LIX2TeSJO
         SY0dy7PlL40fO0CvhdtY+MvUrYJWBrCb5rzy+TFyYG/6DSd/A33T3zzjZB5G0AmU1Wnr
         OMsWlN5594AQMoa/gvrDVrTcRVFomE8MHPMx4iKdcXJWxfVnMOAUfW0XhDzjuAF4mLfR
         gBSA==
X-Forwarded-Encrypted: i=1; AJvYcCX0w7fpD5GDULQ/09igS6p25Z6S36Afw3eoLP4eIFVbbvjXMTR9PHrKBPTvtZe9YH2vkfyJ3SMM9+hAFhcxh46kXQwCWbVW
X-Gm-Message-State: AOJu0YwigifYiXot+Jx2vyuqQfVF4h2MfSTL6RtUlXMmIfWmtWmO7lBx
	/RdKKFcj0rR67/36dth1Z4PgMMBsO0XpZqSOh4QBizVRF+Dp/XFE9igIYWODylTI5pwQ6TrqQCI
	Fjfg+bwPI8MJ+rXkgRhq0BKygVdZpAmJPZm/0
X-Google-Smtp-Source: AGHT+IHSAuM4VJ0iOGcoeIy8So89gEvV2H+c2BtPyUyRIHmzjQSaVvel0xJSNbKsopdkVdd3iCct1UFdfAbF0pa4EZM=
X-Received: by 2002:a05:6512:ba8:b0:52c:ea5c:fb8c with SMTP id
 2adb3069b0e04-530bd0f32ebmr98312e87.2.1722605644552; Fri, 02 Aug 2024
 06:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731172332.683815-1-tom@herbertland.com> <20240731172332.683815-2-tom@herbertland.com>
In-Reply-To: <20240731172332.683815-2-tom@herbertland.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Aug 2024 15:33:50 +0200
Message-ID: <CANn89i+N2TGk=WjyUyWj=gEZoYe2K2xYPw+Nn2jb-uDf3cu=MQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] skbuff: Unconstantify struct net argument in
 flowdis functions
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	felipe@sipanda.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 7:23=E2=80=AFPM Tom Herbert <tom@herbertland.com> w=
rote:
>
> We want __skb_flow_dissect to be able to call functions that
> take a non-constant struct net argument (UDP socket lookup
> functions for instance). Change the net argument of flow dissector
> functions to not be const
>
> Signed-off-by: Tom Herbert <tom@herbertland.com>


Hmm... let me send a patch series doing the opposite, ie add const
qualifiers to lookup functions.

