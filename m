Return-Path: <netdev+bounces-180274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F601A80DD0
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3CD1B6187F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F61D1E5713;
	Tue,  8 Apr 2025 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V9T0IYEE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F651E493C
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122068; cv=none; b=u3lPJaNqEGxyCf+gsNtvaTGH+fiQF0FVBvqCicAb69uTa8HvKbQZkMSp3i02VGBk/39IMNdEoabzsnZgmjKW30Pvc04fCH2+6X4RVSYxZFHprumck3GvB044tAy+6Z4WURbxZpnAEjmdh1D4RQLKmzZaN0fKt4YcQ+c8PB/qwu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122068; c=relaxed/simple;
	bh=9LUiR7PTDvwrWg9rxE99SiAC7XkyUDcQQ79rs37XpYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNQx2dkNH6aqhzynY8EIyXcXq6fljCoaG4WGaD9ABmDGc1OMkaBNEhz7FXCy/P1DxTtxecPArs2JgixcRgRf/SWqpZHgVKzD1rAhkU3ql2T0MX3Tl30p6r3slgeWyJHZQa4rycy2SP5Y/xrgKOVSkOpsOfLkv+QGMNXsE7o5Uik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V9T0IYEE; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-476b4c9faa2so65493991cf.3
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 07:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744122066; x=1744726866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LUiR7PTDvwrWg9rxE99SiAC7XkyUDcQQ79rs37XpYY=;
        b=V9T0IYEE3qVTY6mmuXij78lr1MdVVDdorwT8L6dOA9QSgdQpIMGH8P/OfYjvmHU6MZ
         Ye2uIoVp0K5PxC3TJkPgWlE4+wJ9mp/IWFgyoClxvCllSIGk2eO0KC9DO6cX+pYtXUUO
         SZpl29OS3vBmX9kwPBdvy894epxri89W7/Ww0lpcUaGj5/e2FgcJFlrAEz+pGBfqPu8h
         dlX5c8OYbDrw5B1OJw64PAxk+V+WD4vmT3E6gi6eM/LW8uTZ8wHX1QV+IZdg0DlzBhlX
         Df8GYKxFOFCxv8K2sQDFUdhUJv4B1Xyaz0Ujz4p3JoHVxgmVFHHbTnBiqTtCQqvuDYFt
         ZyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122066; x=1744726866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LUiR7PTDvwrWg9rxE99SiAC7XkyUDcQQ79rs37XpYY=;
        b=juRL6MZQWj5m8EsgWcQdqRMbieoBRBFAAo/igJqJI520ikR4qE2IjhH43QSsE2SQ5F
         8gsFnMWvZQQbXRW0zknTOUg9ymWl5HJ/UgSHn5dCYS3RpIub20a8SeupD0nvVfFDAc8Z
         ilaFMMlE8v/kDumdrPSXE2jF46sdKR7rMNAR8nVr5MZlRiHKd0FbJHpHrxICvZmuQWdj
         TTARCF5DKyLJdw6MQPn5Ox1LhybrJXm2KZtJKRaSvctbCZonBPooGy9N48HxcHyteFIP
         BRWRFAYFbyrFgUaL7jDIHAMKAHTYD54dSk2rIlBbU3FGjAZ/MJfR9cp51xskqoCoGqKh
         8rlA==
X-Forwarded-Encrypted: i=1; AJvYcCXpDiX2xs08n5HO2+QOCNFT1l4SAFk6QshlgEMGt21rDGpj/z4c7lFKsOfRoBvYSTJLhHSPp/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVl3Q75JGUgiSx1CczQXjnGC9dx0tAxxCiF28Pw6aEdtJv77G/
	cQZ8NN8pRQ96WQmWiPT4lDCWYL6p8LJ687O+9qxggRnN0IZ7OvcSr0qeS8lQtvb3kgwbWndCz8G
	Av4V7ng1rwgGm7oGBT+O/3iEDS95MEvkOpbcB
X-Gm-Gg: ASbGncsSBV3YdVfdMyU/LZLU6PyIxlDrTHvlDDOY1dLACOPvxQjJmaY2V2McClKMp3D
	cGWKOGnmq3EWKrMPb6Nio1MWUh4GCrrZaHXF7NDhsJwymC+T8hc9fLrS/nAYfTT1NicyBFIOIC4
	9qHzZQO/S7YIsDZj9398A5VNQUrrs=
X-Google-Smtp-Source: AGHT+IHe0hj3kpMdODzPEab+0hnyLxRp3lwRaBDWBtyUVJnvgjIFRxw2OHX8Wu13fIGiVvbcI5UawKfjdnv+PSgzq0Y=
X-Received: by 2002:a05:622a:50f:b0:477:1eeb:3f79 with SMTP id
 d75a77b69052e-4792593079amr167695771cf.10.1744122065465; Tue, 08 Apr 2025
 07:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407-tcpsendmsg-v2-0-9f0ea843ef99@debian.org> <20250407-tcpsendmsg-v2-1-9f0ea843ef99@debian.org>
In-Reply-To: <20250407-tcpsendmsg-v2-1-9f0ea843ef99@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Apr 2025 16:20:54 +0200
X-Gm-Features: ATxdqUG59MLSRiNhWQPkOOa9OdWbQyDElShn-Wt3VcaJs3Il64-B--EKQXDitB8
Message-ID: <CANn89i+7DUKF4uH_NxBq4xb+7qanF4bQC=FTj5A4OODU8reghQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: pass const to msg_data_left()
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 3:40=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> The msg_data_left() function doesn't modify the struct msghdr parameter,
> so mark it as const. This allows the function to be used with const
> references, improving type safety and making the API more flexible.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

