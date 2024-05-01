Return-Path: <netdev+bounces-92806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5FD8B8EB5
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 19:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9171C22832
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 17:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E79134B1;
	Wed,  1 May 2024 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HLXb7g7q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D318037
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582911; cv=none; b=n+cSba8nHBomOBDrbpDp60x9DjS6Y5OpwmVpC311nXF6odM5FKpC8trLVtvHlqG6DAAGMLmnR2jvCefdIpVziRtzCpwGzICDZqJlq8cHtlwMZ08sHjgh//NZnWsS8pICD4owkqHG3iewAysgeN9FcFnSuIEHDOZSbYBKP1tA4s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582911; c=relaxed/simple;
	bh=WlmcPfRwRLtOxQ8W76AyPApESCK7Jxnff0rr4O1v8jE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+ojqpvJKy0dFVlLVZQQfL5CGAizGEVU00abHc1zCn5VxWYkORXSxhOZOIyWBBJzdJMOKxJXeMz6DdZD0HJgfLCiTz9VqszfpxuCG5gDzmycg9M/9IPNKSp+VTKWCrSz3HDgmgnyPegbW2/uSLmoyRMTYFnhwHEKc57h3r+qJnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HLXb7g7q; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso532a12.0
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714582908; x=1715187708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlmcPfRwRLtOxQ8W76AyPApESCK7Jxnff0rr4O1v8jE=;
        b=HLXb7g7qKmrUq7mMidvbZF0NeLgYjoJ+vlv0zkG3RTByxMeU3VlEYQXw82d4TzJgKm
         8Ius+hBSz+SBXGDqQ2XRs4gPGw52cWOLjYvv7gcebUQLoFd4kR1B48a6PR22b1eBJqsQ
         v2k88P6/JRiwIuHox9sm9VoCheiU55cnJcUsujVZgXfOp6Qx9lQynvjV7nO/EZgQ4Iu1
         80fXqGcK5/8PZrZ7WAVPKwcg+ryJD0ERSyY6ylqlfH2eGIuM1k5FDnqHLqbuU2y6JGf4
         3ZPn2leX5GC6gwZbU9dl6y2Pfh20F83x7rzMde+HhMPK+kZy6K2LYZ/rVDmfI8SQoOiO
         9gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714582908; x=1715187708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlmcPfRwRLtOxQ8W76AyPApESCK7Jxnff0rr4O1v8jE=;
        b=dYXHILz/B3/LOgVDCIs1ii8G8LDF51lRM+kEWlGeNxSAZ/RQX/W4UNNDZHAUZH/+8D
         SAh4H5VX05wUBm4A+BwFb9E1zw7zOyUH2SiliumUDOkFDlomDJ92jPFnyprSHv04WW9K
         CvWb2NcLXgB0Mv+aD92SB/+rStn46JyrDiOc+Atf1EhJGQQq491CmM0Xnezni5RwF51I
         f7FtJS3EWJEWeKe5DB2oxuaouPndmxpPvDp0//04KI0AIU6+LVCYiTSRzLV4EL8Tbtks
         Tas7EckzncwxVqmpmGegnKZsShJF2ZavII4sDqG7AYNATuYNAoOhAjYD64WEtOJWseV4
         VDyA==
X-Forwarded-Encrypted: i=1; AJvYcCUJB6IBDIFS0XuBEi3Q0C7ei4r6B8fCaMWgcKILMCV0sYhhJRXT0gTjNGxqHm5c02uREj5PZfP5yl4Qd8ixpUM4lb/+Wc/4
X-Gm-Message-State: AOJu0YwHLwTbMpapzvhyyRsIuSfov1WWx92mP1IDpVAjQLNtd7S20HOq
	4MJ0R8001KvNWw7z8Mkdwf9e9bxKiBZSVkMJzLTCpqYKewejG2XKg5Uv9yLB23/LHVfGC5q9l4H
	TdFpa2FMsbQugKEeMsGVndHoY2ZoR3DOdxC/VUVGLQJNmillvIg==
X-Google-Smtp-Source: AGHT+IHYLBLJol+1IyUroTZpaj9zo1IXno/+UvyqAttwYj4I0SDg5g28gse/3ZML9xuvTQnCx1ewm0gw7YN91U6gvXo=
X-Received: by 2002:a05:6402:22b2:b0:572:25e4:26eb with SMTP id
 cx18-20020a05640222b200b0057225e426ebmr128454edb.7.1714582907810; Wed, 01 May
 2024 10:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJk5RJR=ex6t3-hzpo=08_+RMQJD5NL3-RzTyK_FutAMQ@mail.gmail.com>
 <20240501165233.24657-1-kuniyu@amazon.com>
In-Reply-To: <20240501165233.24657-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 May 2024 19:01:35 +0200
Message-ID: <CANn89iLSg8dwgbY6jAKUFyg7SbCcbmWOby3+evN3-5ONrMWEZw@mail.gmail.com>
Subject: Re: use-after-free warnings in tcp_v4_connect() due to
 inet_twsk_hashdance() inserting the object into ehash table without
 initializing its reference counter
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: anderson@allelesecurity.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 6:52=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> This looks good to me.
>

Is it ok if you submit an official patch ? This is getting late here in Fra=
nce.

Thanks !

