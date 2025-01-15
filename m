Return-Path: <netdev+bounces-158457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7529A11F23
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E993A02C8
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E0720DD66;
	Wed, 15 Jan 2025 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BgwzrYQu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0611EEA42
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736936570; cv=none; b=osuRC9RXc4Ptfls8SGhNmIXuWekag0k6xGSWiei2/QbbpU0x8S396vnt0TNYyz6o+gUeJ7N6BEJyLFuN90WCfIcRZJA9rw8ngmNyZLzGj/Mi+Y8zYsBKPfNMFTl+NDeLKNa4GEj9XUAotv8aSG0LhPEckilUFkB/TjyuBet13NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736936570; c=relaxed/simple;
	bh=iDFV3ScO9PRQs7DbHFoXMevXS/FxYBfMVDreWNXqyog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nB3s032tRh95rXkNsQYk5jET9hlGKNe+MMD4MZFP+yCORm5MGLEI5lwqmS53KyDEYopdE8ZCXbp6rh3j2N40h+t7CkvE+komq5dH0WzmcaIQepOW50FjDeHa7AfptL+s27ZW3RVxp0W+HPvhmfSS5UZ6cWkd38Doj/LM1nQxhlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BgwzrYQu; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5da12190e75so864838a12.1
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 02:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736936566; x=1737541366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDFV3ScO9PRQs7DbHFoXMevXS/FxYBfMVDreWNXqyog=;
        b=BgwzrYQupmx4UNc53p5VvDJf7K8BTAIM+EIsis29pIqLw/L49UttjL1bO/+8tY8WvJ
         AHFwH9PlX43yisadl1sza63yega/2OGdXyk8ZfxtlojT8RGFK4DiHmkuGZuMVvglWi4a
         N98zYCjljfo2VKSCQTVaXosY9rvEwJqFXGjZ5atkdt5A0GWKta5jp8kTsCgt78CE03XZ
         tYUEqvxxDdLtRIphnPtLUp9PHt6HYyA1yyx3OVz09PMKkJ6CxDXGlSBAj9V1ro+1iwLX
         GhNO8dyEFP99rbM+p1onaDCMUE/QfG1AKQ7aMRq2sROuC/VjVU0KorpKvbiGLC3JhZ3Y
         Rqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736936566; x=1737541366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDFV3ScO9PRQs7DbHFoXMevXS/FxYBfMVDreWNXqyog=;
        b=MwJAgmjbIKAC+r3Xwd4FANJiu6K2TMkFI+oxha04G4z9nneSR0zUj935RttIoC5Dsv
         VIuRg5kaAmSL2uCKveY4hl5bKOUsUwnLu9s9yjOi3amr7rBkaDdBX5Dv8oEWu+L7aqnf
         HDesGth8DT8uyq6azSB+M/Bvu6Nek9cK2kBPhXMsqu0JojYoILofJyOxklML3OyWWTb+
         40yZprjMtdJUrYyDZxBcWBKL1A1EO4ELv8z+ojzc9RJRNKJowncycYDoA9y5yw83DDbM
         EVy5XKJZpuuZQCp/BIRKn1sA5N6oC01lgnX3/NiTsjg/hSRzfadkwpJFXx5VfoDMR9Mr
         A5xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqw72qGFiyg+S4RBrAu589R2yX2adVgI1LehAhOxs7WPlXcFV6oTsl9odEo4h2eJmdlMFHAxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQcb27NeG+n1pcAfer2m3gvyVcPNmhv3HeL6q/7tE3WqrM/bp
	cL06cLnH7hD1Xi5rgyTHXE8vEM87wFtvGG2w4U3zCTmVIpuJ1wegUY//rXq0RzofrRSxF4LpAAG
	Dq6HgEaWgziq+RPES/krp0tMC7AIu0DOk7105
X-Gm-Gg: ASbGnctyC9CnQnyK8iNm8DaX+3pJZ2AV1yRmKUEnPhQTQMS7GBEjA3pnHn4OYXv9hlj
	CM2dMmLKOhH+GBE3TlNVwaw/vVdTpSoPKWpyq8Q==
X-Google-Smtp-Source: AGHT+IFzeCh97T3Gh/c3tgRvnzouxYqcchCbQyiVEa142/kAufiEICHjS6sfqmG6xG2PlUI1aSLWzYOQPE8dLbxPQnQ=
X-Received: by 2002:a05:6402:4407:b0:5cf:e894:8de9 with SMTP id
 4fb4d7f45d1cf-5d972e0013emr25748840a12.3.1736936566372; Wed, 15 Jan 2025
 02:22:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115095545.52709-1-kuniyu@amazon.com> <20250115095545.52709-2-kuniyu@amazon.com>
In-Reply-To: <20250115095545.52709-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Jan 2025 11:22:34 +0100
X-Gm-Features: AbW1kvbPMHkK4lnqs5APWtC_FlDwpADYcJU9K9ERw8UYqnBHoR8HnTif6oAgV_U
Message-ID: <CANn89iJpFs3NkW+6=PYZdV-YmFp3rz=w=-OPZJKQYB2VomFNNg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/3] dev: Acquire netdev_rename_lock before
 restoring dev->name in dev_change_name().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 10:56=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> The cited commit forgot to add netdev_rename_lock in one of the
> error paths in dev_change_name().
>
> Let's hold netdev_rename_lock before restoring the old dev->name.
>
> Fixes: 0840556e5a3a ("net: Protect dev->name by seqlock.")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

