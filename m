Return-Path: <netdev+bounces-156369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D54A062B3
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1933A712F
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04161FF608;
	Wed,  8 Jan 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HhMBRRlb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FC117E900
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355287; cv=none; b=lOz3C9DC1EeAW1VyKNoqXaCqY71bGjuZqhQz4hwJlU58JK3ZFeyaPMriwgKpW20+NaA8J0gR7x8Qrg8OpHhJ+V5I3YJWBz54bVLt6AiagKdWqEOpo5l70ksab/DwJErjJ03V/oEYvzTbNrvibdpnF0R7n5b2cLcsjUJtk6mUvtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355287; c=relaxed/simple;
	bh=x7dE37fkKpX6hi3jlj1vK13wo7M70WhaYm3f6piV3oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RALu2v0+jbuilQ8eTkWu0kf39kgLq9EReAPp3cpNwm9Zx+o4qhCcHhYzjoyl3WifXS5jHf4SL9GwFnJvwHV1poOjRwvi3QUdar0//pI0JycJE/LC2q/B7HTuOuw5KXLF/Jl3bbmEuWxFRjeT8qDqiQUCdyaPPQMPCaNZ4HGDL6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HhMBRRlb; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3e9a88793so5215405a12.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 08:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736355284; x=1736960084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7dE37fkKpX6hi3jlj1vK13wo7M70WhaYm3f6piV3oo=;
        b=HhMBRRlb6SDsb2zeS+yZ/xryS8ut8Mmv/e75dSux3sDqLmTfKoIAWBfoAf6An/WQGc
         2hvb7YGafTCGud55KTiWGSX2ieA1aM8tIF5zEul4GW2HfqghqfWeE4ZSC5aQYOTx9Xln
         Jc+HsekhG9TeFDRI4gNXB3CgWSj4drd6vdc6FpoMJLOySet8naa3VmFA1tbbbXp2jwZT
         NtzY+m51u6tZt8NIJ9DizJHuIoOin8YnhU02PpyHz7n5aW704nRM8mlNIk8gULNoPc+2
         TuuRr/ZdL22eoDQmjGtFNdwHRxgsy2JOLGMfuCDECDQjGsi+69Wanwt4De2vatvTixbN
         bzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736355284; x=1736960084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7dE37fkKpX6hi3jlj1vK13wo7M70WhaYm3f6piV3oo=;
        b=DqA9BJG9maxRYM+fBoeHMJjHXnRufwJkqr7fyRy8QtBdbjC/AhhCQb8Lm0N56FeLiC
         B9mO7zQQzq/E6TyalFvu07UOfH/VMxkB40YvqpY7Fow0zFCc02Pv8WM7DM6DlDSuXgYt
         LzH4n8FPLgzZYqmlf6NtQbP6uWQFzo6UkIx/FCHZ4s8MHwPsE1j6SLViVaJTZS3iiTyh
         rkj/kfnYFMpsxLI3iB3auY6Ve61q/fCvD0Aim8L3rzgVGzyALwGDNok8DxabufzD3EvC
         TaxrIztkmsZ1f3HIxZuKKlpLRqYobTBa2a/axw4ZnvI+O+7y64uY271t9/w2AIa5yV+d
         uSuw==
X-Gm-Message-State: AOJu0YxXFGgJi3NXVWxFCs7WqwGXU8Yf6Ib3Jyxs8O0c8YfUEbreBFqe
	yaY0ATGmtDQVi5KAWij/y6oK1hE67Rmg1jDVdHa290mWbnDbhN0+svHsNxTWkQVmIxbi9CPvbU7
	ucqKQ+2cdbUu+NyVKTHdfF0uXMtPfUIM3l64N
X-Gm-Gg: ASbGnctcvzAE3Eeiir8fXTDafpSbptnnGNp01rQKWTN1hkpRvtB7fo6IcqdzdhjBLM+
	/pp0fkk8h5Pvm2ZsLFs4mDZH8mrT6sc6zGD2ijiI=
X-Google-Smtp-Source: AGHT+IEK/QwC5fqd5ndlWWDbi2YKraaJ0pAfVqZxjEQNo9dvOXZufRs833E/PT8xSeZVPd7ho1YIaS4xCETdwYJYxzk=
X-Received: by 2002:a05:6402:3205:b0:5d9:a55:42ef with SMTP id
 4fb4d7f45d1cf-5d972e167a6mr3204223a12.17.1736355284173; Wed, 08 Jan 2025
 08:54:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108162255.1306392-1-edumazet@google.com>
In-Reply-To: <20250108162255.1306392-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Jan 2025 17:54:33 +0100
X-Gm-Features: AbW1kvaEzfQNNaQKfjLQpHuj-_EQQBSjYMkHGrWOTH41W6Pu8iBLZ-J5KWJ6W-Y
Message-ID: <CANn89iLPNdGsFUFdeJh3d-4P3bcOSoddz1L-L54+8WKsriMReA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/4] net: reduce RTNL pressure in unregister_netdevice()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 5:22=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> One major source of RTNL contention resides in unregister_netdevice()
>
> Due to RCU protection of various network structures, and
> unregister_netdevice() being a synchronous function,
> it is calling potentially slow functions while holding RTNL.
>
> I think we can release RTNL in two points, so that three
> slow functions are called while RTNL can be used
> by other threads.
>
> v2: Only temporarily release RTNL from cleanup_net()
> v1: https://lore.kernel.org/netdev/20250107130906.098fc8d6@kernel.org/T/#=
m398c95f5778e1ff70938e079d3c4c43c050ad2a6

Hmmm. more work is needed, because __rtnl_unlock() might see a

 WARN_ON(!list_empty(&net_todo_list));

I will send a v3 later.

