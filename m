Return-Path: <netdev+bounces-217166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C3EB37ABB
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2B01B617AB
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CF52F60B6;
	Wed, 27 Aug 2025 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSwaYiQH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D5218AB4
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277284; cv=none; b=fBhTB7pkJ7aI7YzL+YmA3kRrofDVhakpS43UgdVaC2W++x4VeF+SPMthAw3oHS7qWYmawhlPEeFYxBQUVm02vYnrQld00LLiqEup8LDKikZuiUV8Ai96h7Npf6pc38YioP8snfVLtbuunQhwhWctb6deY0AmZRseZTCJRuvPK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277284; c=relaxed/simple;
	bh=TNLR1UwgZ9zZ2aYedKNHrYcjRTY3Nev2evOuNBDYGr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlTI+3IBrL0oEqR84vOl/6SKNomFCOhKwuJ5qtnQ3dSp0NCdEPqcQ++yaat2XXDKo4nZkasxE04248kQ98CzcdNmjxbrLLvskhzTwF6Wof7oQC0n8vYyNVISQ+RLCXG9rJ97W14VwGvij6BruWATajmIP7mykKLllW9IZFdeXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vSwaYiQH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-248a61a27acso982865ad.1
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 23:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756277283; x=1756882083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNLR1UwgZ9zZ2aYedKNHrYcjRTY3Nev2evOuNBDYGr8=;
        b=vSwaYiQHlE1mO9Y20Gqw9FnEt+Sy1875ty4HTBMFe3xoMEbVSn/wztMWfvS4Yd/toF
         UarI9+pBqJPJ+8jnicgjY4middk1tSh+SAXzn7baauo/lSP9JIDIU9GweuUJ6Kkvkkx5
         urZNq8qBXv3WFaU5o1bo03y4WYsretvsVoqFlOn9BUpe3+G6JdST5UEwtvarR3WWd8Tl
         88lmT3qwXceITQfIBlROKF1XYN8TDzHi6Qgri15z1SONgvff1mqGi39mnChT+XmcAbSJ
         dX6Ht9AWpiQoue3DfO0OvdbAyK+8fYgJk1EMcs3EUoiAcw/bWOEv0KBDyuQWfqdc2BsU
         Yjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756277283; x=1756882083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNLR1UwgZ9zZ2aYedKNHrYcjRTY3Nev2evOuNBDYGr8=;
        b=B8qktbELC9I1A29wwyIjWpPO1gcoGPjYdwPjVsl2NTSnKWTQ0Gt7WkKnRGqSaV2Xct
         TE8q5V26XhFdTNjDpwl2kzT3lNud4nM3cF7I282ceCo3tkTNzEifNzqj2MabJTzkNyND
         t2n+M7LK5i5c/qXgDE1rrs8R1OBVX4YShV+E/dOXKMDl9Kh5BOOqdO9xunQLDoDH2xPF
         l3T0z0w+tKLQ5XE1mv+AydMe4Ivf68pA2UnmyPc3S+v5khx7zkfzFdEgjTaiE2wAj8XJ
         EP06A9V/ziudocbKYMERjhvrvKQg0q8ou2TpxcQIcAy016Ys7vj2rA3paei0yDk33IAK
         wSBw==
X-Forwarded-Encrypted: i=1; AJvYcCXLsABRSjFldqJHmo8G5/FaQHPWWTEPvcaZy0Mg5SJQmQ9DWujhqa6fx+w+CZgtxsnJ12EBdNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0HGKPjx09Euvk2iZkMyJKjhTAsuRb7e36QCCAsrmkG5USSGAE
	tOH4YiHwtPXnyXnlme5XOWioytBEe7uvkZDw7267nDKhPUnOPDY2m6cSx5QGI9SfG7afK0/BOiN
	bnr34ZABNI/4ZWfnPXuYzmqZLrjIxfkcRzsdNUW8x
X-Gm-Gg: ASbGnctFSHzv8QPkacQi9ebZojGidqQezTmIDVo19O+eklJngWaEcb1YGN97KVjoLK9
	lPIEwHafE66kSxXdmLhnk+dxV2yVyFokxtzybA+1qdCe8UjzKm+/+lMh42bw3tvtdJ6hF5gyVtA
	UNC+1TukX/4hq6a2XoG1Q0DMMkcr3HKYfaqyvnm4Wqh/YtDXNT+RHyc9OQgCpgnWG/n1GWGab+X
	Os3gcjII/SSK+WfenDPtesQoYtrlGM+tTVAiSv+wC16h0TM7JjBsfhcLblMtOjoC//BnjHoXZCl
	ICmSOSKLb4s6nw==
X-Google-Smtp-Source: AGHT+IGjFafqOYf9+cCklsM5gzmxNHkLV8I4T6yawhjbD6jh1HYN3Ub47zpb/sh3aycQqpO7kpYW4nWdVmWVBeWYQaQ=
X-Received: by 2002:a17:903:1a6f:b0:246:ecce:544 with SMTP id
 d9443c01a7336-248753a2642mr57116535ad.12.1756277282374; Tue, 26 Aug 2025
 23:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823085857.47674-1-takamitz@amazon.co.jp> <20250823085857.47674-3-takamitz@amazon.co.jp>
In-Reply-To: <20250823085857.47674-3-takamitz@amazon.co.jp>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 Aug 2025 23:47:51 -0700
X-Gm-Features: Ac12FXxnK3iILmw9b5MTakhawEP4I3D_OlE5LCy1ARWUBLMb5CfJbzFCcMS4_YE
Message-ID: <CAAVpQUCAPchBjAr3_S03ieKHvGBQmW+c2g7+QyeSCSEEvxW8XQ@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/3] net: rose: convert 'use' field to refcount_t
To: Takamitsu Iwai <takamitz@amazon.co.jp>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kohei Enju <enjuk@amazon.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 2:01=E2=80=AFAM Takamitsu Iwai <takamitz@amazon.co.=
jp> wrote:
>
> The 'use' field in struct rose_neigh is used as a reference counter but
> lacks atomicity. This can lead to race conditions where a rose_neigh
> structure is freed while still being referenced by other code paths.
>
> For example, when rose_neigh->use becomes zero during an ioctl operation
> via rose_rt_ioctl(), the structure may be removed while its timer is
> still active, potentially causing use-after-free issues.
>
> This patch changes the type of 'use' from unsigned short to refcount_t an=
d
> updates all code paths to use rose_neigh_hold() and rose_neigh_put() whic=
h
> operate reference counts atomically.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Takamitsu Iwai <takamitz@amazon.co.jp>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

