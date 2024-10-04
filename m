Return-Path: <netdev+bounces-132004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C6E9901E8
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9D61F2535E
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FCE15B0FF;
	Fri,  4 Oct 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvUzS6Vn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB45146D78
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728040504; cv=none; b=e3lDYV3kHZHK8O6rIuA/XFpbsJGAJgDfK8elAY2+O7SzE752HIWiiYssTf2IyhmCDj9wGIXLmDHnhUN2bgZnYb+mLSrTh8h173sG6ghDWOLry4zZ/yNxH+vTLvyImXn4qRszs0KfktQb5nxtm2MeD1EP0DqHInS2q7axo5xOsl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728040504; c=relaxed/simple;
	bh=l1a2GmaL3RJtR4Y+hExJn1jkiXpan+vhOMl2XedLK48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QT2Fjy1VC99ipe5EqQmLpfZFLc048IkujmwZF/IEV+mW1UwTOPhjBFr8hvzmkwkAOGFJ8LGLlu0SiavNxr5E5irn16k/RERu1y1b8mFE2ANLZxz+hpRt2mOeaqzAy+psawD0azbQ9L2AZ/8axnkTva7lMyFw0ZZWrDk0lzA4mbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvUzS6Vn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c88e45f467so3324570a12.1
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 04:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728040500; x=1728645300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1a2GmaL3RJtR4Y+hExJn1jkiXpan+vhOMl2XedLK48=;
        b=EvUzS6Vnp9Nj7t3cAMUcpoKp4vTvxmN628MIRD1wclppqTcYnOQTidf13YRGXezWwi
         qJMcjFjFC1UVK5SGmHQ0I+iMJZGbEsDH2p0NRgUTvqjcKuZAozXNtX7pGGQSFJLHhxKq
         zLaxQ+1qGwpDpWBHcB/krGRG29px6eYOeYR16s7zobdHlEU5VYVpoZKhzNgkZBknK8nw
         hG096IaAmYn7V6M//b2ipaXx2MFxjHbZ8DeTFPI7H39jza6IDAYoGqoXTAjXQvzhhler
         CZet8HPFe9DMQAgD3ZmliotUKbF3HemWr8GFqqz1PdyTcfkgHZku6yWd1N3F5cJQh85T
         wtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728040500; x=1728645300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1a2GmaL3RJtR4Y+hExJn1jkiXpan+vhOMl2XedLK48=;
        b=V0O0Sw6cTOi4QLh1ZV4IZL9snB/TXEpbLsgcNnRMhFuPa4rsj4dzVRrnNLCeZu9cO8
         8aZHcQcEq8LKYl/vX+OG9yS8fmnunBGEhZ+v9ZXnT9wkfo7i5/PkVP7suhCtvFZCabU2
         ujelqbbwrRKXA111nj23ePXVb9u9ZwL5lP5F5Q67OLTqxpcPwHwBvmhOES35PoXopcNg
         52qIfCp1DdxbINWitAmu9ubs3oV6kgXfVH2lWorCmicK8JcbyVUNwbFSu6wlRFwB8gnE
         Id50EAqMhlkkmterdEUdca7Ezja+Ct0YBNxM3oBdUnj6wWLmOuJsny7svWKT8JdPAv8f
         xA8A==
X-Forwarded-Encrypted: i=1; AJvYcCWGrAzleKcsalSDWt9OJL5OkCm9C1PERBpjfBNJdj8f4kpGNtYSi7OXz4nEVuP8k+mhR8tVlpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsxvO1BiIEJMuFaOIDAzNaedvLbzwS/Y+u8DLpaz3SIO56VKIQ
	j1wH3YkgHsXACSwccZeUXQO0LtvegepMhkwFG8gFXzF9AEFqKYus4HNCWleCmcVFEGnRoIKnp3x
	jdDgwQN2GrHLTNmEFb4tPuodeIInF8gI+66XR
X-Google-Smtp-Source: AGHT+IEhsuAPZ2vlWl9gCeEXW1J1tRRex3xO+gnhXDuLMQ8W4AfUg2ERc/qswsJMM796g83PKClIaISTJ8oedJVFdNM=
X-Received: by 2002:a05:6402:2551:b0:5c4:2d5d:b25f with SMTP id
 4fb4d7f45d1cf-5c8c0a65941mr6200928a12.13.1728040500364; Fri, 04 Oct 2024
 04:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002151240.49813-1-kuniyu@amazon.com> <20241002151240.49813-5-kuniyu@amazon.com>
In-Reply-To: <20241002151240.49813-5-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Oct 2024 13:14:49 +0200
Message-ID: <CANn89iK2sHq0shF5opO4EiJtLTB8rpD-rUW4yCWHAT0WXBep-A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/4] rtnetlink: Add ASSERT_RTNL_NET()
 placeholder for netdev notifier.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 5:14=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> The global and per-netns netdev notifier depend on RTNL, and its
> dependency is not so clear due to nested calls.
>
> Let's add a placeholder to place ASSERT_RTNL_NET() for each event.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

