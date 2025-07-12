Return-Path: <netdev+bounces-206379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5694DB02CF9
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81CE01AA56C5
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7839A220698;
	Sat, 12 Jul 2025 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XykuiLKA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EB02AE99
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752353716; cv=none; b=Lz65wBNiVeiJgq/RfHTU5X9bKD+aRX15fYkNpUSvavQrU3O7DgYWb2RqX5VfJapKf8/w/Ox08pm1d6KYVqAIN/a07MVR7Vhh0cg1Nna4hwCmjxdNBLgZJgjkaKxhyHiNcFBg0Ah8X1joysScu+YUnAw02+oL/TxupdYRMR9DaQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752353716; c=relaxed/simple;
	bh=7X1MN4te04iDp5U8ut2UFRVxRn7UJtMy7oJlUOvzgOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7z2n96OxbJkDn+GytzdRhZB322j4bID8VEf5mqrND1qwVS2JhOACKn0+T4I/tx6oQd+2MJUqnS2CNY17LC7xtPkLtPpi7NPY04PMjKqsEAAFkgIF++gRQi84uwG1Lvi013ZDSMmWfEuJLfZu2ilwb0wId9o550OdKsN6QkrzuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XykuiLKA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso2632850a91.1
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752353714; x=1752958514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X1MN4te04iDp5U8ut2UFRVxRn7UJtMy7oJlUOvzgOY=;
        b=XykuiLKAJ36Kssoa5ORbqdWbKx6KjOKLbcNXMh1rLb8AeOflHdXbmwLa/PSRagvIin
         qoX0XrpMjXFQfgD0GLCe8vMVypB1WOt+hfewTzGbwsum48NcYx+cAkSTH+CBg6kfkr0f
         fFVFHvtzPC7LW40NGPtaG38MF6UXZE5nLBycO9HaS6OoJXFxhXKea914M0wYzvok1mb9
         L47sABObpkMS6X2Bn5FzYYwf1JjYPxmaaH76vTfhabHqUTCc006sHqia61l8Pxth+0dA
         aDZg2W5DQnW7KLLiFV1tHy9qAByRSJ894raJ4QLRjOHeF2T611p8qDf8niJA+lpnc7pe
         HR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752353714; x=1752958514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7X1MN4te04iDp5U8ut2UFRVxRn7UJtMy7oJlUOvzgOY=;
        b=UpP/uSsGiTOFjmfWVfbjdB0pqlklOi1pw6QckyPFsJMxQz/LP7glDr71YVP2MF5FfC
         zAZw4i9Rwc7oOiORLcNnsz9QUYNa2kzTVcCji9Q5xv7nDNxTU4Tm5jRN6vwm/xVd0p5V
         GBdaxE+xUY48OEuBmktKq+bwxgkVGaE5cTgdpfMM+iAnbi76czjmNm26bqPd3DyNZn8/
         yUGdI2AhcGfvL/ahOj8ryLCzEFdx3ztPmA7AYGcmYi/76j7UopSQXASm7bYYJmBEvPay
         PGE2U21Scdrnlsqi4oIDJgqBdAkgkKMsf7RjCzlw23SkEt0H4NwTumm6kaiewsUYt4/o
         5n2w==
X-Forwarded-Encrypted: i=1; AJvYcCWd8rt0dYIXkMUOAytxkPjdwTrnjVXloIxsT6O7HwWa7EctlODfocEMgpvhD1bt+nakyiA68gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhZByl9SaGUnyApo/hBf1hA3OP5Ec58l7Z0XMJr/vGTjxQ224X
	9VT9021QYDrfIS0nE5b6sP7n2yrsJ7qapgnmHq/aIIbwQ32V6hfc3aeq/ZXPJp4aWhhLDHWmzOH
	S5UxJPUsqbMgOb9eAy/fVx3jzDv7TDUwx9ia7lhIo
X-Gm-Gg: ASbGncuGzqjy9h1c1S2IdP52+K5h0eWVglk+NP+Lh+Vyq7ufqsAsDxhT6S8K1C3HJmt
	tc7Xm52AqDnDGLCV70zq9GR8zvwe1i+yPOsTsh6VF2IXdmJ757Jqpec18b0QTZbRjrtdT3lMmOj
	qWQwAw9YDvp+JwI9nJAv92vj7PqchXGKpSSm9WmPhwCLC0ApA4BYwHJ4aIjEqcyrnYobyKagW+X
	0Xj0C27UuF0qmdJx9jPy8f2vCWP0fOVUQQUtu9h
X-Google-Smtp-Source: AGHT+IF+rj/dEJSDhVNV2RUde/zmvs8TqPsmNOZqIj6kRcJHy0FDp0+3/bZeNks2g33kkRhnH3ja3c3MkHt9lUvwlmA=
X-Received: by 2002:a17:90b:4c4a:b0:311:eb85:96f0 with SMTP id
 98e67ed59e1d1-31c4cda5bdbmr11565271a91.29.1752353714283; Sat, 12 Jul 2025
 13:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com> <20250711114006.480026-3-edumazet@google.com>
In-Reply-To: <20250711114006.480026-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 12 Jul 2025 13:55:02 -0700
X-Gm-Features: Ac12FXzknsufV0r2U4X2pwzSjXN5lRM6PPydSjoh0GdpWqHUv3yPfqE_FUElmEE
Message-ID: <CAAVpQUD6vtxOvNS77mKbBWCzqATOa7oLHsG4bWF9huUq+bVh1Q@mail.gmail.com>
Subject: Re: [PATCH net-next 2/8] tcp: add LINUX_MIB_BEYOND_WINDOW
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 4:40=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Add a new SNMP MIB : LINUX_MIB_BEYOND_WINDOW
>
> Incremented when an incoming packet is received beyond the
> receiver window.
>
> nstat -az | grep TcpExtBeyondWindow
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

