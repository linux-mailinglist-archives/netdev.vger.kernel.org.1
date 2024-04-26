Return-Path: <netdev+bounces-91758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0AA8B3C51
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2982E1C229D5
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 16:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B603214D2BC;
	Fri, 26 Apr 2024 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y7UMIZuw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAC114F125
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147379; cv=none; b=h3h6gI4fB/1nupkvZlnM3xMS3B2tbgP2EVJwHWdZZFM7TZLO690xLW8fdJYNTPB01qAoEApptA9ZydILfBZdh4XHGBhIHrQPNztOt4VzZdxoz7sm2b4K57xbBKBoymtj4sGk/pJwqwya3mBsmohOHArYdMRN+TPduk8ICaCtsYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147379; c=relaxed/simple;
	bh=k7AljuFrApyTa8ww9MHZnaxrqs3qjeeqHGzJ5S16Yz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJpjTURonUpkYiFhbhse7RA8IwCI6892sWeFRVGC0udSws/nQxF/dCgZ1fgzApPBPLWyc2cVdUwQh0D7ckyRrxNN6uRM2V7MKf+9hZDfLN6Wt6ziIqbJaUqBjRQnFjlgWszoSRp26+vFnGEo7kajhVbAOv9X2OJDmlSeAuGpGWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y7UMIZuw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so12687a12.1
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 09:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714147376; x=1714752176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7AljuFrApyTa8ww9MHZnaxrqs3qjeeqHGzJ5S16Yz4=;
        b=y7UMIZuwXfiKEbZ2Sta9lIq3iNfyY9fc1BT/afROPHanCGz5b/gx9RY4gFQFqH4NxC
         JqBAC5n+AKHZNyJampzr4vxbFWusTbLKjRPDsHp1zhAfDdsy2S1i7bw0UxzGOXRGVaGb
         nrcRPzC1R+czC6GO7nxTuoRqh1i+VY5L7bYO2WnYX2Uk0IABvnjJMYUSFmHERWAR/7qZ
         rmZA4OxSI6TSrKfcAG2p9fG9cYZOxUD8G0/WxZ11WlryjayfAt1VQSwpl5bNAO53vUVi
         bb/1hT+8WDiPMSNwwNBglbqTimQkQdtPGgvQGuVTKFc4TAr/7i8ookTaFobi4qp3rOzH
         abTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714147376; x=1714752176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7AljuFrApyTa8ww9MHZnaxrqs3qjeeqHGzJ5S16Yz4=;
        b=Smtb1TkFCbTRLfl850lsER1sn9EXsznJ4Ey75fZ11ij97PbeD6oZrMHqEw1svg7Sx5
         qq3w110dsHXkatwy+hqC06Mwsmto4ojW5N/eEe9Bq/9VC2ILAHjF6v+H0x/tTyjkIR+x
         99FTaqURBn3MGIb+QMfk8CNKBoevZJOs2jy1QKcV4dMwa4eSgT5NXXDTQVvIdTImjg3u
         5G8JzKjlV9kqlh/Koc95QszlI4xusEGZpQyNY20u8TAFeLgHD/glK48NJ1kZJd89hLlt
         6rExXkfiDDmar7RY6etT9WexdyZ7SS4su6rnItsRD4nVZxeWJEI3umHIWn80938JsbAB
         Z0qQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2mYHA4Fxz6oq4MhNcPUxrxu1B1ePmvoTKu6w2/06H2dWNsYjC/laGOnDPgfR7gy5A67feUI1lq0nHbNea8cm+pPhgiCmN
X-Gm-Message-State: AOJu0Yx05970wy3/6iZ7+GUvN3LCP/yhssU98T6rVtK3W9PedstTHhE+
	2valM4YGlePYhwWyEu2muSEXQlWXofKeppLLnhOdiz7g9RkBPr9nRZdHBr43Pvy7PqkHFv4q3EY
	xuI/T7BGwEn6EVuBefNcle/eJKwTh4CuU/XBc
X-Google-Smtp-Source: AGHT+IHIAMuNikWPfBDl4N/DTwTnfz10CVFQMo8z2v9ltMJesmcjBxArp5RuHaNK5cyR0xn/NZV5Q8DnnZvwpi3wqtE=
X-Received: by 2002:a05:6402:2899:b0:572:fae:7f96 with SMTP id
 eg25-20020a056402289900b005720fae7f96mr181020edb.6.1714147376143; Fri, 26 Apr
 2024 09:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714144439.git.gnault@redhat.com> <ee4f5622d105ba9e0c7762acae7c73a7cce05b29.1714144439.git.gnault@redhat.com>
In-Reply-To: <ee4f5622d105ba9e0c7762acae7c73a7cce05b29.1714144439.git.gnault@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 18:02:45 +0200
Message-ID: <CANn89iLYS9QXG7YVJ=DSCedQ5670Kps6dUuh1duaeZuYamM_Rw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] vxlan: Fix racy device stats updates.
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Jiri Benc <jbenc@redhat.com>, Breno Leitao <leitao@debian.org>, 
	Roopa Prabhu <roopa@nvidia.com>, stephen hemminger <shemminger@vyatta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:27=E2=80=AFPM Guillaume Nault <gnault@redhat.com>=
 wrote:
>
> VXLAN devices update their stats locklessly. Therefore these counters
> should either be stored in per-cpu data structures or the updates
> should be done using atomic increments.
>
> Since the net_device_core_stats infrastructure is already used in
> vxlan_rcv(), use it for the other rx_dropped and tx_dropped counter
> updates. Update the other counters atomically using DEV_STATS_INC().
>
> Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

