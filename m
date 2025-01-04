Return-Path: <netdev+bounces-155133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D55A01342
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 09:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A738B1884D26
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 08:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345A214A639;
	Sat,  4 Jan 2025 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aoJiDAzo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8155414A0A4
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735978664; cv=none; b=HjZGITS2h/h7vXl/Tx2blvszR+LXSAK084HJEIJtpTY0neoh4I9FT5ccUJjUHJWVR4gA2i9oRyZHSolerx6k6mujZGh5dWV0ZTK7eYIM71cSM/00brZyIjjsAF/JnIFhEdelQEWs+Jm/DnwnkLIRsMo87sFedScCOGiuSoE/r20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735978664; c=relaxed/simple;
	bh=fJmy6+OdBKu96okZfe0z5Ep4NFQpHMt4wicWf/ty8M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0mhkGZZsV4JcCNldAH/br6zgpQcJ9n1xw1WBqa03mEiahVKy7a1ddIVKpHPdR+cyT//fSJ1moqwvH/OwH5dHxAXTX1EmDEsdQJdXxgiRCiRLx9JsNmjprqk0XZYn0liIhXef8pW6YU88Jbpx+nX1Syqwc+0/sGmC9YuJqeRxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aoJiDAzo; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8dd1so22266794a12.2
        for <netdev@vger.kernel.org>; Sat, 04 Jan 2025 00:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735978661; x=1736583461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJmy6+OdBKu96okZfe0z5Ep4NFQpHMt4wicWf/ty8M8=;
        b=aoJiDAzosEPNQlL5hu9OKY5s2Ed4rIfuCoaeVucChwOs1XZUZMmM9D4Oz+ZZPugU9i
         wnYq2aVrmLTEtztuG6rxYyEBbOL2TH/tP/o8/kYBeHS8MUUlWYJXfyGcU/iNnLHzejfb
         rsCdatq7yZNMIVoJ+UUFnVWrP1hFEnDOAHcGWBxBC8FlkCv3KMUZdkY6F1Ns4xoLvf0M
         RTCG2XqZdPugRgk9JiVDyP46PYxRsPGcTXeKCtHYXEvX7KIH1BRVasHOcM4gV0zv4/tO
         JlTTjVDpBJaszO65JUXz5ZZ79QoeD0t8A0pDkmmhktv4/V0ro5FHktZ0Vchx/8bBRNoZ
         MWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735978661; x=1736583461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJmy6+OdBKu96okZfe0z5Ep4NFQpHMt4wicWf/ty8M8=;
        b=MqYMpjxVU8nrRijPmn2l1D/umn0LmtehNV/6wmhoEwYAJXN6v5MOrUd2qlz2qb6nDX
         EpElxzao9935mLefJm8S5vE6XytrI7UsxLHYY3NKHdIzglfnIU9Iqcl3tCqpZOPt50RI
         vsiWr8aEda0Ko9+SsFx7+zktSY1Vk6H3vdhhv0bvEO6HttuX+RcDnHIU2mv/e/QNHi93
         fFj0f6SqRnJ1YsIvDq0pYsqUfN/RG22aF4CJsILqQQJmmDjdJcq45+An4RoJXasmhmia
         lYZFhGEj2L/S8qioVJFEevKY3MYRsEcCVfZHF1IW57KeAVvOoA78vJmHzP5dWIPXbc3F
         7k0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXQHMor48wwMebHgsln482cYZxl0Gy/PNYluPXVhXGwEGZJ+cW9bn/H/6emHaJI2E8sGUtM9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4D/KYW80Iyyv5qqtclnu3zBFmJ3gms7OH42xrWsUjPZyUI5KT
	gJZpVhtsTuzCmDZZhFONLcq56aBym55kjE2SPFJoYBQTqIriZm80R9AGgDcYRjPJXjSIp6U5zYv
	1r15gk6qGxevmyIP9qOCPG2w6iKkOHxXHl4E4
X-Gm-Gg: ASbGnct8Nz2/r2vMUfkAPXCklk+4i0GXlUNm5bV3reWo+qm7XHCPVZMWuAyk0rGrgtP
	CL5IqegsK9m7+MqW5BjDU6Crh3/WQk0f+Fwd1yvc=
X-Google-Smtp-Source: AGHT+IGpmpQqsqR7A4GGxVGhIsME6ZZimyk4Sy1FCbPhmv5tVTAoXcH/eOrWdGCfxxyutW4sCGaNNyhy9re2Hiar1FA=
X-Received: by 2002:a05:6402:2809:b0:5d1:2677:b047 with SMTP id
 4fb4d7f45d1cf-5d81de2dc3emr54185575a12.28.1735978660250; Sat, 04 Jan 2025
 00:17:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103210514.87290-1-edumazet@google.com> <20250104065911.39876-1-kuniyu@amazon.com>
In-Reply-To: <20250104065911.39876-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 4 Jan 2025 09:17:29 +0100
Message-ID: <CANn89i+tdqN-e7pQRy0p8VWz5oiyThRMZ=ik4y86UmeX+sXTJQ@mail.gmail.com>
Subject: Re: [PATCH net-next] ax25: rcu protect dev->ax25_ptr
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, eric.dumazet@gmail.com, horms@kernel.org, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 7:59=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:

> Not sure if net-next is intentional, but whichever is fine to me :)

This was intentional, it will reach stable trees soon enough.

>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

