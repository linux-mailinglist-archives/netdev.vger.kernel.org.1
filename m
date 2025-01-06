Return-Path: <netdev+bounces-155389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF13EA021F8
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 10:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FA63A411D
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB291D63D6;
	Mon,  6 Jan 2025 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CT9daXND"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78562CA8
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736156124; cv=none; b=TdvVqqSpk7QYjR2O61Y1mUXNtpCHwA62k4ZOix1Ii+ZvzC14Oeo8VS+PB9XWIeD4hhFlqzC0KdysOCsj3ED+tEGXjATeKOQBwGw9fa8p6y1+414G4RecVOslN+vmqPBNwYKgh2F2Gb8AhJz1lD4wOsozExAhjgksR5fx+EPGyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736156124; c=relaxed/simple;
	bh=bpcL5OLv4ox8BQllyi2DsUW34N4mZc1qT+Srpf5qVdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJyc4hqXhsTlxQr9GIdpJfFGLO0dDcU3eUBEV256fHKMehKX9qf6NBs13pQcVjFcl+SIygkDc7A8IH6q+IHA/x6vOTrQ7PWYHasbuZ2g9ixsWzfwnhWJmF+XAhHu49CzLwIGJLvSI+G7L9bTUyYkenCPW7mWmekjlPFDiFKXM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CT9daXND; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso6290153a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 01:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736156121; x=1736760921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpcL5OLv4ox8BQllyi2DsUW34N4mZc1qT+Srpf5qVdw=;
        b=CT9daXNDfy+I/HUPeCuLXMuvUWl0cZ1a59cy/mOcwiaS621DMbwJKZ7pvd8fhxpc2U
         IhFvAieS40Gx3SuzDvDAH8k5TVHgI+56hx8brOMdNKJ+tyThAsMbM5ZrZQ0IVcxjC4lE
         r8AehRCPXrCQJ3IeH4mWte1TpbuZFaUqBUUeD2lJEWVFsJWiVm8iAAcEV1Eo/11ITkbc
         jmzmel73+nS3Kffdh48U0ZVTvsVxJlYU+P+RkLsXj9MZ68hRGopcJXs4V50IDi06XXO7
         2Vo/iUU5wDtidZ020FlYAyEVxDGBu/jN+gCsa564lCTAfr9zCp0eJ06DBrsC3Y/OS7W1
         NTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736156121; x=1736760921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpcL5OLv4ox8BQllyi2DsUW34N4mZc1qT+Srpf5qVdw=;
        b=XFTAfaby5bZrduqrVN1joyBn1v0CrWML4hwSNOdk8lr6BxeC6jM8orbzQjAcYrCZFj
         iXjJ+SpjS3KK6/pAfqlH+o3INC0AqwwbYAwLuAsKEtwh2GY4JpUuZOlFc1V1H2BgEVyY
         D92S7OoYHrc14qJtr06Ef3vcaRJf5Nc6OWZyUTKKz1kBDPp5HQsr4j939VYyBJgZIr2n
         cXgwkhq/NRGAbqDNnj/8hvDhDopW0FGHceALhBCFd3f4jSdhiDjT+OYP7KNz2iaNC9Qn
         MHDJTBlpk4liMa/yeHNF2HiFr2IvOGEphmCONi+b9mpq5aPlZkJLydl+mTmZhXhKOMAl
         HbDw==
X-Forwarded-Encrypted: i=1; AJvYcCX8/VmIVJaNcJCF2bR5T427djDHFB5WP/G0mnrVojHyDu/VFefvPQEwgp4IHaaBLTxoySUXIaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEnJlGGV8pcj5iHe5lVtpYMEkRjl7qiukG7cGPeQ//bAz90AM+
	MsO1MPL3NaAbn9UVM/lxhmjM+pac/iCIhwIPY6WcQFMBNkEffSMfW713/Hx0uxlKyFgm8dOXoF7
	z9eFRrbc2Jx0wDXDJ8unb6v4cjyXhtvL40TFi
X-Gm-Gg: ASbGncuSi7/SIOznGPP/u09SaTEsXbuqwiFaojEncBOuTD8O+zoHNI5ioPb3dzLfOKV
	IQpKaDFqKXGPjC8u1940aG1tYWkm1Q/RqMXOUkA==
X-Google-Smtp-Source: AGHT+IFfPWu0p0264dJQ7XPoFSUseo4ZOQb9MwYclNVToeZfEnPYW2t5cW8/czEi69Hxt/jUKxvazz3PK3HZznqJI7g=
X-Received: by 2002:a05:6402:5243:b0:5d0:bde9:2992 with SMTP id
 4fb4d7f45d1cf-5d81ddfbd83mr52046405a12.26.1736156120855; Mon, 06 Jan 2025
 01:35:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103185954.1236510-1-kuba@kernel.org> <20250103185954.1236510-2-kuba@kernel.org>
In-Reply-To: <20250103185954.1236510-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 6 Jan 2025 10:35:09 +0100
Message-ID: <CANn89iJyuomh=K2_3yFBky+N89STR1RVXMf4ry0VRDpW0X6nHg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] net: make sure we retain NAPI ordering on netdev->napi_list
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	dw@davidwei.uk, almasrymina@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 8:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Netlink code depends on NAPI instances being sorted by ID on
> the netdev list for dump continuation. We need to be able to
> find the position on the list where we left off if dump does
> not fit in a single skb, and in the meantime NAPI instances
> can come and go.
>
> This was trivially true when we were assigning a new ID to every
> new NAPI instance. Since we added the NAPI config API, we try
> to retain the ID previously used for the same queue, but still
> add the new NAPI instance at the start of the list.
>
> This is fine if we reset the entire netdev and all NAPIs get
> removed and added back. If driver replaces a NAPI instance
> during an operation like DEVMEM queue reset, or recreates
> a subset of NAPI instances in other ways we may end up with
> broken ordering, and therefore Netlink dumps with either
> missing or duplicated entries.
>
> At this stage the problem is theoretical. Only two drivers
> support queue API, bnxt and gve. gve recreates NAPIs during
> queue reset, but it doesn't support NAPI config.
> bnxt supports NAPI config but doesn't recreate instances
> during reset.
>
> We need to save the ID in the config as soon as it is assigned
> because otherwise the new NAPI will not know what ID it will
> get at enable time, at the time it is being added.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

