Return-Path: <netdev+bounces-225444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7E4B93AA4
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 02:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1571900ED6
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C8011CBA;
	Tue, 23 Sep 2025 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IooB4Wmd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520928FD
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758586134; cv=none; b=f512fpMY3AmdFd/16rUjcBL25ejtCkd1vA8X5iiKeJccUHUeSdqqeJeHot/ftpIi/9w80Hbt23rlL22QkZsnDh2ZbUa+L6N7flKolIRl17rIMzE/9r7YPK1pTm5eWhdgnO+rQlI9lZkirS4tLzYQZXTJu1rAl/lw841Ag6PCzXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758586134; c=relaxed/simple;
	bh=T3tfzrvL+yR5hU8L33UqYjiY+h/ckbH8o0FoFlUcvlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FA68Kth85XkQ8CrnknIATVTTbD2vl0UJYI2wF6sO+Ai6WxQ5oxw9mg2sj8KquVGZHHcN7GKp0W5iXuvP0LBesIIlg/fWbL666v6Qern70NJuSXQVOTvTfdW+Kvk/NWoGJPjn0rjAbWqjY+r8ZquT8xR5ZW+t3wnz4n7wWKHi3E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IooB4Wmd; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3306d93e562so4326601a91.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 17:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758586132; x=1759190932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3tfzrvL+yR5hU8L33UqYjiY+h/ckbH8o0FoFlUcvlw=;
        b=IooB4WmdkywJfya94OVX7zQOqwYmMYi0e6Pl4zBNXviey8EzTxJx7xwVG2JRjEwPLv
         mHPEUphO2ULz4h6ab28df3LNgkYcAIbOmULmdWZfgBKEFVKdQ9xRh2EnSHxXDAvhYQl5
         PM/4Cr/CfgxsHHd5r03mHNM4CO/XwImNFE5OvPZBdOUXEJXo5cQNsokUbF0D+TDqZ4xY
         T8wZ1gznYU0RgWOf0HY2/H5Hccop7uAmf70w/PGHyGOLcsrMsapnrJRMNMbe5Ebo/Ss6
         f4OF3ckEt0eaB3+mJEkHfxa5yc1UmHQ0dt24Opi03l9NoMxWBgQWDDDGLI1wj1yP9sCL
         wiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758586132; x=1759190932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3tfzrvL+yR5hU8L33UqYjiY+h/ckbH8o0FoFlUcvlw=;
        b=BRhK5LO+cvFfn1HCgTMkvmWQw+2hUO2bRX8IJWDJ3hIdZRngh3ZnF+HLUsX2ZNHcqu
         A4AmF309X/HiwR2SJrJw0IhS6KT2t9tMNSh0uHCo8heRjS4sQsPG7yxhLNnvLUIETbIU
         hL+vQj0EoFX6n/nRPDyGDgrVkoGVJ/KC6CuDnb6Qgep1cY3pituynmw1Hlwdg4w1e1Sq
         FfIpxwJRULZT8QTl86sJigD/usdJpsU7aoXAP1WwnQeBI2wOXc5K9ZXDc9T3sYsKms7y
         KpHrJ5Ocgx4caA+KpDhAMELlHmNLAk60LnydtRwLfXej8zZHNBC1NwJu+UmMxyYnB5F9
         nvFg==
X-Forwarded-Encrypted: i=1; AJvYcCULd1wMqTeCHQWhZt6YzR7e+AFYGlRV5xSjWOU3MUCNgv2PT8PO+p/945/uJOuhATma7ztbWsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqMiOovpJDTOUBeRlAwEU4xCyvpbIY0VwhrGC1GBEOsHkz1mBM
	OAAQKL1kQ4p+7mtht+SSQYh4T/gLrtnIsBcCoP/rXLnC3EPxIS60/BqA9OV2c/4q31XFFZi8wZW
	fkHjDu98+77hgre1YTlAPfUU+/nar8HR1w2SVcfIa
X-Gm-Gg: ASbGncsbNH1TpjuyhN2NLO5l1Re800zII7iI4GO0eynkh0A7KUBwXOCaaJ24ZOMH6ho
	HOliciryLELczo7bGvQdodGcMZS1bVSvbR2PDKYAeXpLf4VhForyjrK6D3hu6ZV2sY+OiAAt87D
	WsrAKmIgfryEqMyfT0tLW0V6U52w645KoI1MhvUoqgluU/dUbBMUIg13GcRxlcrB/XFI1qesMgt
	eG1Fv9DdLYi/GfYX3OxdUnGaaPPM4W9dlnwtw==
X-Google-Smtp-Source: AGHT+IEngouwf2Zg5ZEgzTy1GZwTR77+N/vakUjVPcHpjgDJMsO7qdDlVfRDD+bpszaF+drVEdBe/2dKOukhsQoUzSg=
X-Received: by 2002:a17:90b:4c45:b0:32e:a59f:b25d with SMTP id
 98e67ed59e1d1-332a9705e25mr918799a91.30.1758586132119; Mon, 22 Sep 2025
 17:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919204856.2977245-1-edumazet@google.com> <20250919204856.2977245-8-edumazet@google.com>
In-Reply-To: <20250919204856.2977245-8-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 22 Sep 2025 17:08:40 -0700
X-Gm-Features: AS18NWAstoRBkgvuBrv4vJpAEUqQ8QkpKll_gM4H1HVoIO9D1CrS3yy_vCZiJAA
Message-ID: <CAAVpQUDoFW6O0MWtd5dJC2gokGJsas3aW=3JeCZdSZ6hbRcjQw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 7/8] tcp: move mtu_info to remove two 32bit holes
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This removes 8bytes waste on 64bit builds.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

