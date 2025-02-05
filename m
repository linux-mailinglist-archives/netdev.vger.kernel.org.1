Return-Path: <netdev+bounces-163247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77DEA29B2E
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 21:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E44963A392E
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5563213E7E;
	Wed,  5 Feb 2025 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a9f2qhzD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575C2213252
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738787282; cv=none; b=O0wMKoRM0i7p3n9iIms5rduXnXJdDQsLzocQCIysPy44gCdY+kJ4WZ6AFQvI0ZqiXKpeMATgBOy/SFqIvdXPiIKb2FmUFD1+BELuxk9HBUiuTx56DNyfODE5qWC6toMY9NPcfkHyZ55W2QvXGa+QlwcDMmvlkdmqLFghsdDu1sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738787282; c=relaxed/simple;
	bh=uHBN7rzMxlsl7bSwSOCbyKw+RBrAj/TiplxJYAjCq7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dzfly1A5NDe/+pH7ce7AwVTFt+3+wTsrp3POOb1pByyV7vMy+dETzFlWHSueyg9Z22RY88pUZSGGzrQxrZ1imqwkQkSmKmwO46xOBJ7i1ozsn6qCMYreAtVmuPZ6Ky5DQG1rHnWJsBTb0SfKDpDFt8IeiIUcy3yVXTSQbg2QSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a9f2qhzD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21625b4f978so29915ad.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 12:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738787280; x=1739392080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHBN7rzMxlsl7bSwSOCbyKw+RBrAj/TiplxJYAjCq7k=;
        b=a9f2qhzDmH9ZwhQ3Y6Dbnlxk3+BXl8qe9RoWvb4hslpQOFrIdEfupR/ZTa+iaSpdXG
         Fts+vK4Ybu4J71Vst1w4uK2owP/vvGClQIPBHO+z1QOTdBHqVcGUMqhKCGwozc9CCZA4
         NdIdC2m36nTPJux1MjV1unWyT/gVL3Gy9/7TWlgEA/uMxDQwhIrt4GJdefcNvq/SCXuV
         9vYwd9r3dGP7F51/zWxME+feX3rcR9dNzQISGUS0qq7WDzIRA/8eK+1XQsK10YPaJqz1
         wOZvsWlbd73pYC2r+cDjWUQABXIghy1VgirwX1tdlhbLzbpTfzlO/NI1zABquA4A7Jip
         TmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738787280; x=1739392080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHBN7rzMxlsl7bSwSOCbyKw+RBrAj/TiplxJYAjCq7k=;
        b=mL2idMlQwZ5kU5MEP/uUqHzhDf24HbzWRJPUypV6UvVqDSyQ8dQAiMY/YRf2ZsTWNS
         y2S9Gqw6efRbFw1+tZp306hZpy05E60o3llZOsgZmwphWUte6Ez9Gdx5TKn/o6ZT425j
         S8ovc8/r3VMdDjms4cr5tP8jX9m05EkvxzDNOXTC6sD7Th/kLHb8RL6aopWqFWvc9xnG
         MtrEcoPj8wEolUB5nCZi4em3f6dAsSdtvYjCEORkRFYGqFTDXonjeS5ZRDSBCvFcj3Cw
         nolw8SJ7dFsKi5DM3fjgmtJclqyQ58Ro6BlDG61qgdG7OKMMP58RC16Tc0AgCXUnOI4s
         AH3g==
X-Forwarded-Encrypted: i=1; AJvYcCUIreELlVtvncWDkYchNWnI9x4u7mUsLopbeT82FNzP/MXwdv1EBd4N/SdcKnDJum/S9HLGRmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZXxL9YFLc74DLzVIZscTjEaTVmzmUmDZrTgr7EXWUdGnZiBe
	2BdeikFGFJzSiYXxNEOyHwWqtEDQe58vLbX/yEOcHwGsvf/1FWG1dZdZEmQt4GyAvxSMq2sXM/r
	WFavHi+D9f92+zBZPHrozCalh1M92K4yl822mOqrV5jfadxsR2Or5
X-Gm-Gg: ASbGncuivBIsfRrPzhfLaXiJgNGKgYjThzlQ7VuiEfRxVgDM0xjRkTrPnsBlmLFJHXi
	TCyX2eekYAw4QZ9raSa4PibdM7Yah2fJP1wSERlc4XsT1Na7gyNMyGEFkPRV5GFbAKlHbXAYe
X-Google-Smtp-Source: AGHT+IH3CvRS2TMGTnQuRVbxteuKT4DnaNi9BD7sIh8nSeg7CXivL9x+kwk8sCGnKsFJaGsi+biBSRkyYnQIjRrE1nY=
X-Received: by 2002:a17:902:a9c3:b0:21a:87e8:3897 with SMTP id
 d9443c01a7336-21f3022831bmr446055ad.4.1738787280313; Wed, 05 Feb 2025
 12:28:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205190131.564456-1-kuba@kernel.org> <20250205190131.564456-2-kuba@kernel.org>
In-Reply-To: <20250205190131.564456-2-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Feb 2025 12:27:47 -0800
X-Gm-Features: AWEUYZnEQ7Heen-hi3zJVrQHHzIs81AoWAJDPiGoj44iS1F1sctvFo0b60cfJoo
Message-ID: <CAHS8izOakHLbD42MRrs9cUhYOpdvo-C-Z7p7eYGdbtmt=QFmMg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: refactor netdev_rx_queue_restart() to
 use local qops
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 11:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Shorten the lines by storing dev->queue_mgmt_ops in a temp variable.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

