Return-Path: <netdev+bounces-168228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31BCA3E2A4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77C7420927
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BA2212D68;
	Thu, 20 Feb 2025 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cP4N5vD2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863032116E1
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073073; cv=none; b=Que6IiCHgkT7OvJNKgQbLdzNhPGakq8J792tDM8P88gEBNPCubLqJxQbl0JF9F6wCu5bCe89BmmmXZzjYLeOXs66YPP0I1UyHkWd4cJy/ZiwyYLvN4Oq4VM+PKCXGkGHkp3Y0arHxm0/eF+kQBiZThqzqrjK/GJv+Sh6j13PkKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073073; c=relaxed/simple;
	bh=Tqg+uCu9OY9/+2XU6+LurqVonaEeduchlfwApG8p0Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqv9+FhSX4Lsufh+r8Nw90V4fFJFHt1XIbfdZvbjPWbBBaHgU8SCVFhn9RBHyfsEK0biU5V2DXXq0pBw7Xil4yaS+7tq+QoizjAhYWgLvcGK+uIGFjJ0pNv0Thrh8z1aYSBuuaPhyBstS3wginZ9Cl46H0D9gp6/hCyZCjN1emQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cP4N5vD2; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f6ca9a3425so10521127b3.2
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740073070; x=1740677870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6PVa1O8aVWNHWzO0xnoru6dOjPsSU9GhIPgYbJ4Bds=;
        b=cP4N5vD289Fhm0Q+U99LTchmhfsQYZUzbKbb8FZWBOIWI5lyh4gUaKQp/b+6/+Bp6N
         QbNQzs1KpiUEQJ6jKEbjNLKx7c7Kkh/lt6saMp48nkmNskguUZNPD/h6jl7eBZrbpip0
         NWXyL0lbSpff7bjP9ZTkkqNA1kfpv0le9ZHL+F09Z3I0c9oG9h/zihxhnYc/kHAU0fuN
         9Ys+ob93oE+EfKfhjmbX21bnYh0T9UpeTRiE3eaJ3cEbq4G79Bqs+s3/BWwbiyWc0jqE
         /6NVKvlfBnvh8AvOzdRA7pkqaOIL55atowoaLPX1/hLhltm2IpAnEOUnFCo4Two6Qtqi
         rj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073070; x=1740677870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6PVa1O8aVWNHWzO0xnoru6dOjPsSU9GhIPgYbJ4Bds=;
        b=vsL2JJXngrMlWNFvyM5OOpCoiVV1i+5KfOTtaaP1cI4kO/ee766AR6P5x2vHC9IHfQ
         caL4z7A9HJXJ2rGj+0bdMp00XD+C6rlew9buueU/sK+NCSuau1F4ao5cqtRbztw/zNfZ
         cVN5YuKMRi5kSrjO3LIPw3pD1cbGo75x/7lV8IqkNz4gzKsO/JQ3lV39E5fvP6xG39K6
         OSttClXGobZVRl7vQ+QsoErPEuAWMADDiSzg0QqeCtCJfmhvxaTu+JAVnYmIgLbaVaVM
         9ML6UBHN1+A4ENl5TsDyGR7XU4ad2csgC54dHCBxioaeppthkzkclpJvWOHhRBt4+L/g
         WLTA==
X-Forwarded-Encrypted: i=1; AJvYcCUBAnxAljFx0WsOL1rNm5pk10fHdxY09w8GJ0cO3+fMNF1PLLkf5MSTNpRD1k0bW3cAn2STFXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Gi/s/erBYOwBcjo7NrXADeV+z0Rg0M0t+V4LT5yTJgkauazq
	ev0Ebhkept2ZYIyD+B8bM9XyL84GZCtino+/gzeMUHTkNtTyAoo5SjXHUfQWAy3ysI7PmnrFPoc
	jYhFwxSdaWqiXQh5Y+zgfvyw3oj0tEGfIC7WD
X-Gm-Gg: ASbGncuabRrCQgcF9a6zE9E0qcnmZdG97K6/oVp3HxMY2f/3CeGhF9k8KavV/elsIS9
	TK1TtmUxa14SotNilzYUj5j0S8z9eXlvYGDNmpKHNUzQSfNXGEoO4t2Y/kf8ZWdxvUYAGkbur
X-Google-Smtp-Source: AGHT+IHFMkQrusRFEf4Tw4VekF+AIsgxYwXaxaEjAX9HRIIozJEdd2vqlItFLbnJ2Go/YAZl6HaJXWj7dhPJwzNW30k=
X-Received: by 2002:a05:690c:19:b0:6f6:c937:2cf4 with SMTP id
 00721157ae682-6fb5831bd8dmr192225577b3.23.1740073070461; Thu, 20 Feb 2025
 09:37:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220140808.71674-1-linux@treblig.org> <aa6c6f4c-7d46-4e7e-bafc-f042436f47b6@schaufler-ca.com>
 <Z7dcxAYj_jsG9WL6@gallifrey> <91cc89cd-a9c0-4936-8449-1b9ac6273dfc@schaufler-ca.com>
In-Reply-To: <91cc89cd-a9c0-4936-8449-1b9ac6273dfc@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Feb 2025 12:37:39 -0500
X-Gm-Features: AWEUYZmoO9GgVv8BQLTsASUy6ZDHMLvKtEDBfJgzz0FBmvpbeTk-VYGzCkfDJf8
Message-ID: <CAHC9VhQzV9nY4AOZn=WnQcr5Q6a+ozfyLBNNoHU9oyk6MQUBZg@mail.gmail.com>
Subject: Re: [PATCH net-next] netlabel: Remove unused cfg_calipso funcs
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 12:03=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 2/20/2025 8:48 AM, Dr. David Alan Gilbert wrote:
> > * Casey Schaufler (casey@schaufler-ca.com) wrote:
> >> On 2/20/2025 6:08 AM, linux@treblig.org wrote:
> >>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >>>
> >>> netlbl_cfg_calipso_map_add(), netlbl_cfg_calipso_add() and
> >>> netlbl_cfg_calipso_del() were added in 2016 as part of
> >>> commit 3f09354ac84c ("netlabel: Implement CALIPSO config functions fo=
r
> >>> SMACK.")
> >>>
> >>> Remove them.
> >> Please don't. The Smack CALIPSO implementation has been delayed
> >> for a number of reasons, some better than others, but is still on
> >> the roadmap.
> > Hmm OK.
> > If it makes it to 10 years next year then perhaps it should hold
> > a birthday party!
>
> The difference between network and security developers is that a
> network developer thinks 10 microseconds is a long time, while a
> security developer thinks 10 years is no time at all.

 :)

There are also far more devs interested in working on the network
stack than there are those interested in working on access control
mechanisms.  Sadly those of us playing in the access control space
often have to make hard choice about what things to work on, and
somethings get delayed far more than we would like.

--=20
paul-moore.com

