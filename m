Return-Path: <netdev+bounces-171917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C98A4F5DC
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 05:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFE11891111
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 04:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAB419C55E;
	Wed,  5 Mar 2025 04:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FHX/fpNQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94E19258E
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 04:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741147289; cv=none; b=Y8FMXsUUDfAXKgrLpiEA84bUxX94sj4GsAj+wKBgzP4VtxqLhp0xXDaY8z8vbBa0qJZUzi5/LScNRxqk6Fq8eG0DcwllPEWKspeosqOtHgZKZEcilg1jHSX7xdgFJ/h1qWbn16DRYiL4qAKnkuXyinWfxj0nsg2FdudDHzWtPBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741147289; c=relaxed/simple;
	bh=ACiHqTIXefZtMso1lc0GrMbaE4VyikOHpfiIXIEQYeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pETQlbQK6a0qGTVr1buMWTiPPa/tohptQSOjsnTEWY6BMURhhXOdU99g3JsuBno0eZ7nccN0H7m7dtOzvCnnAT/4/eM450p8QTYUQRPzVZYWOzQdjVfGuTM7w4jBm0bMEMnSvi/A0hesC5h9atgGcZUvIwesSZBQLsewM0z9PGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FHX/fpNQ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46c8474d8daso56472701cf.3
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 20:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741147287; x=1741752087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACiHqTIXefZtMso1lc0GrMbaE4VyikOHpfiIXIEQYeM=;
        b=FHX/fpNQ1EoTos4K6o61mjSSxFs55S9ii4w6qdx82BmH5/2y4km9SI2lIvOX44jyGE
         MF20PBO+JcTOZHftcZzzbAHD6VegpAsloiZ/RpekYN0GGl5zBmlGEnuHNUl4rXzY8AuX
         GRRkx8AMar9oIC3lFuMBZpu6MyRsj4TQOaNZB5iYZWDt4I6E9GmMsRGfDqDffOeiL9LS
         Q4/IMuXRSnow+lQZXoN+E7a7Gov3AlR8PPVtusvm+ZyhSEwOrxsbtLCH8xaIyPMol/3z
         VJ7clDQTpKYqC9SmIfP8IVYwOtzJtYi413SBiH9GEcb+Qdu7WhFtmvcrH1KDz3PqX7q0
         jb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741147287; x=1741752087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACiHqTIXefZtMso1lc0GrMbaE4VyikOHpfiIXIEQYeM=;
        b=YGlKX25/9WTxDKhRgPy6OVUQyl4vWoAzRJO5WtMK0feEJUxqSg/zjsy4SviJes65M7
         6iMIhpopwdMzCpFWfB7Cbfa+BFmFynclF1Nk09x+8Ex+M4PI23ZOthI00/qzadVwmvG6
         Vhj9sV1kKBXUo8GliK56M68gkS2x9IByw7ah9yhYS7Xy4vbgbzxf/nxX+xDeA9/iLnyH
         h1mXMc+w7aGK8YF85HgEzQYB8RLC6eRUtsrDLydxldVHhd3JkUf744mUUmVk3MltXCFx
         J49r5hK9DTZfJ+jxJYXg2M0svFv1BFDyIULOJdrz8Sw1HGhve8mDOV8+qNkFCIyTOX9w
         aNvw==
X-Forwarded-Encrypted: i=1; AJvYcCWmlWiISu5PnuE5WWRQ82UUca0xp+wPVDNrI5OD4AJjv4oNleVqmqhUrhxldNZaUFlrngJtX3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47qifmi2b+OeOIMfdYlSOwXQPElRHNsoo364+5t+4txHCqi/L
	1IlwsS8OP6lvfFGeC9GJ12LZTa5Pag2DAJhko3uLMYte71Dr27VtyGiJVp5qxxLdMl0AuyxZxcA
	pirnfarIMM4AchM00lB5MR5dUzFNDKroXVUt0
X-Gm-Gg: ASbGncvikE6R2lAQvnM9XT9SWZKxVNKK0wwpah2t+7wFPT7KP27ZCeA2ExL6BjawghN
	sdnOwUUlTZKfryC/BSFdroeJXpN1dwr2Ym0vqo53bE/S5co56N87tUIphtnEpASSUaOGCWlzolP
	ajaFgRm7Nvcer9Xw0AR3oJ31Wx+zk=
X-Google-Smtp-Source: AGHT+IEM39CsVwkH3SkFkZ5GOJp15NPESlZCKmhs4z6TvPSi0GIs895hvjrJlgOXqfQ9HBZeW9HMkADmDtyVMdaBY98=
X-Received: by 2002:ac8:7f55:0:b0:472:133f:93b3 with SMTP id
 d75a77b69052e-4750b4e2ea0mr24572121cf.47.1741147286890; Tue, 04 Mar 2025
 20:01:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305034550.879255-1-edumazet@google.com>
In-Reply-To: <20250305034550.879255-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Mar 2025 05:01:16 +0100
X-Gm-Features: AQ5f1JqTgvBT-M1ZglSEkGH9lDDv1-uul62cA0nIryO1PvHr0TDY-8SuHrtCdOg
Message-ID: <CANn89i+ReWhfrZ14H0psRK1WfSZKm2v1fo9wq6f7jb847qWVaw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] tcp: even faster connect() under stress
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Jason Xing <kernelxing@tencent.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 4:45=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> This is a followup on the prior series, "tcp: scale connect() under press=
ure"
>
> Now spinlocks are no longer in the picture, we see a very high cost
> of the inet6_ehashfn() function.
>
> In this series (of 2), I change how lport contributes to inet6_ehashfn()
> to ensure better cache locality and call inet6_ehashfn()
> only once per connect() system call.
>
> This brings an additional 229 % increase of performance

This is 129 % additional QPS (going from 139866.80 to 320677.21)

Sorry for the confusion :)

