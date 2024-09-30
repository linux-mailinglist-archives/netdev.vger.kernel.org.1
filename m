Return-Path: <netdev+bounces-130546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C09698AC37
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51491C2195D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEF3192D82;
	Mon, 30 Sep 2024 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+KK0Grg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9A19AD6C
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727721414; cv=none; b=CyjXOVtxDjYl2wo3N6NW0IIQ8i+wb7cvuXdYzuPzm9X6ZTrApoxZuBSN609ny0fzAHLlvOZYWHHx0h2ATUPYfY7jvLdG7L/hy3TVrOCMB7AxOj8mRN/3Rw5pRs7dnJULfd6bmbqvNutlh7WtYyQR/fcSuByegmibIvlmqMZLaRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727721414; c=relaxed/simple;
	bh=Oy0ALxEmUyYWBTbtoXiU53SHPD1lj0MJBkrnL4gUafY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Z6OvoMMxmgJ6v//gO4nTZGz4TYJ0Es/kgYkh2NtoMCh2PP/+9FAU+FdEPdbHbDszgYy5dcWLzbrCJ6V+KLFwCvTayzUaF029TBt8OTIXWdqaFNBsjDb80rpQBqmKaoEVY3tLOzfK1pGe02lnJ7H6N5hCuVBY+jWaUyfTAPuozAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+KK0Grg; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e25d405f238so3959505276.3
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727721411; x=1728326211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIUfPOTofXtzMvM18mpE5QXgpk7HTHoVsL+aDE9xMOo=;
        b=W+KK0Grghx7Il7F6Fu4tjkJ47Q/7Nc3mRYqfrAaWtEz8qM0N7+tW58+DMBCp/XccNO
         4ZMRUWeOT64eISdvxn23kajAuZW0CLn2L8BrGW7B0xsoGhEhVjURMtVuAcLKJM3R5rfV
         ME4+80oTJ7PbwkRbqPyaxSU2tqtEKZpcqqiZmJ2d2a3Ykx+xtNpLxK5MZC46/vnYz0EN
         0pdQhoTBXutru/Xc1pwPma0lM+tQVvHvl8DAit7aTWyad4uv0l0RmF35/qJ5avuOC9mC
         AfLt0url8YQdW3D80d1GMzLKd0JfisDnSNECJCKLfsJ1roxxy6er/Lt0ZxBd/ykuC95u
         3DYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727721411; x=1728326211;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PIUfPOTofXtzMvM18mpE5QXgpk7HTHoVsL+aDE9xMOo=;
        b=jFAxRY7oloO4yWb4pNzay6oP8ZYiKGi4V2HoKMCQhFRREnxjeSdWvSO9Wh4G8lzTiu
         tjRmfqVfu6fLs5+Cx6n3BiQwMl3Pfm+2QnVgcwjtZVI5wRAVigxVAMsSPYmHR1gHjYIl
         7mXSPZJYS7aPkfYn7qjs8iE6eMve2kCY5MHsDoaUx70l+qWF2Aj0TiAw8yCSko+t/gcR
         qLNNU303LhlfOT74/YhirJkuOTBcb0yVIL6ALPyauwpTp+qnZDbsjt1XRl1O3Jiim5Ug
         YDOVssqIqxAiI8OEhu3oAbmrBa4HG1H341dgBbtwqLpG1nAJ1pIJp8UQVyswwf9fyvqO
         CgjA==
X-Forwarded-Encrypted: i=1; AJvYcCWT+tzZnzhkdei5ilPgZ4cLhdDTDxY1mBMHwpqWgPQrMgbXnud1KT8G2KZUgUINvmeat7MNZyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YygG6HP2xreo0qCJibHdKsS9s4AlW0svvu5AUVdbkqXb69Fkvzd
	Jbt3XJ0kssmu0sD/jtmpnKB5YkIToQMTaWnpDb5Cpl7Y+fN2V72P
X-Google-Smtp-Source: AGHT+IE9ROLXVosW03F6YsTwWq8Ds00Y4XQJT+SgSyRdH3S114xNZbv4IbP+3mLvKD3UCvx41xd1Tw==
X-Received: by 2002:a05:6902:2b05:b0:e25:cfc9:489d with SMTP id 3f1490d57ef6-e2604b5306bmr10268711276.34.1727721411636;
        Mon, 30 Sep 2024 11:36:51 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b68d808sm42257246d6.130.2024.09.30.11.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:36:51 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:36:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 Jeffrey Ji <jeffreyji@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <66faefc2d2802_18b995294fe@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240930152304.472767-2-edumazet@google.com>
References: <20240930152304.472767-1-edumazet@google.com>
 <20240930152304.472767-2-edumazet@google.com>
Subject: Re: [PATCH net-next 1/2] net: add IFLA_MAX_PACING_OFFLOAD_HORIZON
 device attribute
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> Some network devices have the ability to offload EDT (Earliest
> Departure Time) which is the model used for TCP pacing and FQ
> packet scheduler.
> 
> Some of them implement the timing wheel mechanism described in
> https://saeed.github.io/files/carousel-sigcomm17.pdf
> with an associated 'timing wheel horizon'.
> 
> This patch adds dev->max_pacing_offload_horizon expressing
> this timing wheel horizon in nsec units.
> 
> This is a read-only attribute.
> 
> Unless a driver sets it, dev->max_pacing_offload_horizon
> is zero.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> @@ -2030,6 +2034,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
>  	[IFLA_ALLMULTI]		= { .type = NLA_REJECT },
>  	[IFLA_GSO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
>  	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
> +	[IFLA_MAX_PACING_OFFLOAD_HORIZON]= { .type = NLA_REJECT },

nit: checkpatch does not like the lack of whitespace before assignment
in such C99 designated initializers. Probably just stylistic.


