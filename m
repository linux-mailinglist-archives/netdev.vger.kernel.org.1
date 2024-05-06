Return-Path: <netdev+bounces-93823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEFE8BD4C9
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 20:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24871F21AC2
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 18:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0760815821F;
	Mon,  6 May 2024 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSVx0xSt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9918494
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021118; cv=none; b=bp2VUwN9Hc6Auuy9PsfEkyydgDkfYOKFhSlQh7rogxgfOqj84WW4tAq6m0RvQ12rTdPdD9Y3c5fuEgvHCTSKd64ExMejBKJ5viLodJbtQjvI/1y+mAGWT38SpGPnerwLZsQgQXXq20epnDdQJHi/Je37NVmBoYVwkdvn/eIcEm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021118; c=relaxed/simple;
	bh=RfsMGZxNZzCq/FjnQHFkFWEdcof2/HFVL5ZrGe+zgEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=locTw5Swg3D3THklGIJq4C9uYDWbhwRC3l75USwv3bTSLuiuXK89c6xoxPGkwqO7Kc6M8TCJIKZrSE6NWR/MeUcKLqs6iAbTC8tysMzunEF1lzSIuR/8WF+J5iSpeJlXCvPM9KmHmFQVCCjWXNkxAeXVHQ9CJbpoYO8o32fcgec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XSVx0xSt; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso2125a12.1
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 11:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715021116; x=1715625916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLNW39OCVUrAniOYU7zowvy6Z/UCiMOvd8SriY5kE0M=;
        b=XSVx0xStolq+J3Uok0+NKORnIjPpqJ7/0nLkn8q/yrm/Miz7MtzVdJ2sghyTXQT1Li
         fp+oD93fMM5DBSCRvz7X3aq694H+T4iwCXJ20o8aHiNkvaNPnRn0CveHkhUFy8J+vwOt
         sD7VnxqdNNqlnXVhyGH8oNHFB+yWvsSskjpnKJsqCZwG+djp2D6nf6hQYiOSOBhzDPNa
         k3WwAqv5QvM4TfI5n5UZLnI4awNEUao4z5o+mXmzNKgMoTbOCi7K6q2zFVd4ypqtovwN
         Ro1hPapDFgfjFpySWxH149VlvbpBeYQg0N9PGuKaEfAwYN8oO2Lyr4zid04orcgk+5g/
         nMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715021116; x=1715625916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLNW39OCVUrAniOYU7zowvy6Z/UCiMOvd8SriY5kE0M=;
        b=W1qe9KyMwsr0srk4jLJAb2ZZjLgdYLnKwE05/+RCbdx6LnGkUnGsFVk7a7viUYHkdo
         0svFO8kzb9anh6FSt0OYnzeA5G1aRlYfO8Ml5q4mzzCl3SspREiHzbNe0toCX+xGVDmN
         ws3Zbr/w0+3KklsE55FjcCvDbbQPN8FfxQZNXVvH4XkoDtbb2fYZwmOe/jHI6kr/oDDb
         bT3IHA7YVTYarj08RdERnUk/w5yQ8RMELSsl2Y+AlIQWmn8uxtMKt4XXzz2dis0M648I
         J6mGEbem6OdhXYFxaxByzpsrlXeZNjHehlPkdcDwhmuVlZtKH4vfDYzzcPz5k8wlV9eT
         lKKg==
X-Forwarded-Encrypted: i=1; AJvYcCUg+QaS377yNCa6OEpWgxkjQXqI8BBdEznxd/yWyPRKSEfQ2SS+82+PImpEQnSeClAZzEFfQe45/GLjPIRQcj6yaa3tCkRI
X-Gm-Message-State: AOJu0Yz7/0bKOBNQte6rygwsjMGt2ttQwnH1XS4FFssFwbuEgnMmE8po
	J553IopWKUpEC0NojqnqyGFjDyZKvjki5sDl+adTt07rI+Sd1yRSe4i/Uh2HcMrUcqs1esyl1qA
	mevblgODQPNhPI882NmYxFYmK+h7r9g5/fyHK
X-Google-Smtp-Source: AGHT+IGgAoB3lvUhdfj2l6TP1Kb3glhU9M5XRKVk2t2/jTasgsDzs+a4jndqKqUBuVmWfKVBFsGcXsyOCVQnZUtuQF8=
X-Received: by 2002:a05:6402:51cc:b0:572:a33d:437f with SMTP id
 4fb4d7f45d1cf-57311d75bd6mr41198a12.2.1715021115498; Mon, 06 May 2024
 11:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506121156.3180991-1-edumazet@google.com> <20240506112643.43c63b69@kernel.org>
In-Reply-To: <20240506112643.43c63b69@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 6 May 2024 20:45:01 +0200
Message-ID: <CANn89iKXNk0jgrRrgtnRQ=pLMjkGqLXLEvoAOvk97ZF14A56xw@mail.gmail.com>
Subject: Re: [PATCH net-next] phonet: no longer hold RTNL in route_dumpit()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Remi Denis-Courmont <courmisch@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 8:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  6 May 2024 12:11:56 +0000 Eric Dumazet wrote:
> > +             if (err < 0)
> > +                     break;;
>
> coccicheck says:
>
> net/phonet/pn_netlink.c:280:9-10: Unneeded semicolon

Nice, thanks ! I will send a V2.

