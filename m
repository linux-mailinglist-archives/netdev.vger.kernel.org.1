Return-Path: <netdev+bounces-138081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7945D9ABCF1
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 06:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07121C22285
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 04:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EC539ACC;
	Wed, 23 Oct 2024 04:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBkZIgnJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217735672
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 04:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729658205; cv=none; b=VpBnwH9sxVXRp8wjzO/s6jYr3HGyTNxNoUD66h3HkDnxjMlgSGob7gfPlbMFskmftktmZLnRYTRxLwzExKVBxs7ldl3sI57wTxFw2qRPkMw3leMcah5g7FqAjMcAQVfAuGm8Kxgl0idPq6LaHgVysHGnKeMNO3z5SmvlBGRQfyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729658205; c=relaxed/simple;
	bh=1s96UQL4dzFEC06TKL9rHCv7n+bHwByvuPgQD1qAkNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXke5tCg58FayuToQUmCyXX+fi218/BneJI/fNitq2TGQ2qI7a+JZeuyylST9w38/sj+oiSLK5YwlqAjObEmZ99EkliRlNhYMiuRWIhTC2Tk5XFhgYFHssdu2qROrUtDNJWPo1j5r8mTJ9GboyMbcKu1/o5QCPlG5W0Pb1yxieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBkZIgnJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d43a9bc03so4454512f8f.2
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 21:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729658202; x=1730263002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1nN4jNGDhXW9fyYV6l0F0/m9x/pZ1v3ah0R6EnZnUc=;
        b=aBkZIgnJbKSaYttLIQq+Xg2nx/GQgQIVl8F4VwS6Yz5l29Lpiqh7u0+wkhSUWUH0qb
         +a4BqAEPY+VXSM5KewAF7U3+pcX2RdPK/F1EsXHiUpnz49AKUQ8oY7gCrn16hGqovKvK
         ZFZnda9p1pg3t/KYNvAKLNznI8EQudQWoAcS8BGOmlLkdQ71Ml7N9sBllHTiMS5/oYTG
         1pfU/j1mGfo2mRzDuZxRQuWLky8BWeJehdcti+934ke0Vzylu0WClcqRFm9OZO/YQeva
         SpXtJERdbzIJQVCK0qD9gqztWWq/AE+kuxmttBAqpAeBJfWKyQU2bUgOWvQmbYbmemX5
         WRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729658202; x=1730263002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1nN4jNGDhXW9fyYV6l0F0/m9x/pZ1v3ah0R6EnZnUc=;
        b=Azt/6wFOPzAz1+6+yVVvqcWzxJaDqekdip/SHPxiAhbEuWr0NCy2sF+eUg+10liCKl
         rlhDGQUFV+HcHtffPytF3vKG5m0arqx1K4Brv3YIFcfLB0eBg6W1oEVhQjZK+Vt5HSVD
         VgJp8QO3scVt1W4VSF7ELYQAi5M5xUEuBzqS16y3EVFZ78sJMh0YzCXLAiZ08jmUySEa
         ns5p+kWnsIqYJlb366G+dGc9r4qsVR5Z4Nc4d+NBsvMSscK9MIjvgJMvezKT7JCvIgsR
         M1rXHP09H4Zkrg+x2EJI3MX5nBUSwHrc/To4dPNdwkIIW34g9B8TaAqSoT0SiQXCSfEW
         Os5g==
X-Forwarded-Encrypted: i=1; AJvYcCUt8Z1iysiUbC5hB2KwtrdkTXNd3tpgy2MxOQVCEejs2hHkjTsbjENtH7/6Zj+0gheAlRQMH9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl6jybMCs22XxBQck6LjFaqsjCaVK4QKaMZ1HAbNGFRQQiAJfs
	gLfsBA9akDtDCT+hfPrI/qQkU/Csq/6iNZMuwsVEbxif5V1Jluk5R7p5TiMgI+Ao9MbP6NlD50s
	gUytMt2l2YjQ4y0obexNn3f0hi8E=
X-Google-Smtp-Source: AGHT+IGyaKHK6w0aZTd2Ei2poyxYR1lyylEvCr0a/0V521+XtY6wEQ0sd0Vi5nrRogYJbKxBNGW2Fl7vM8w5tL6dM4g=
X-Received: by 2002:adf:f04e:0:b0:37d:4e74:689 with SMTP id
 ffacd0b85a97d-37efcf84943mr667181f8f.47.1729658200880; Tue, 22 Oct 2024
 21:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023023146.372653-3-shaw.leon@gmail.com> <20241023040316.28273-1-kuniyu@amazon.com>
In-Reply-To: <20241023040316.28273-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 23 Oct 2024 12:36:04 +0800
Message-ID: <CABAhCORyjkagq=PBy2YOXSwF8yu9dT5bFGKkgGaNikqVSHxDjQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] rtnetlink: Add netns_atomic flag in rtnl_link_ops
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	idosch@nvidia.com, kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 12:03=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Xiao Liang <shaw.leon@gmail.com>
> Date: Wed, 23 Oct 2024 10:31:43 +0800
> > Currently these two steps are needed to create a net device with
> > IFLA_LINK_NETNSID attr:
> >
> >  1. create and setup the netdev in the link netns with
> >     rtnl_create_link()
> >  2. move it to the target netns with dev_change_net_namespace()
>
> IIRC, this is to send the notification in the link netns.
>

Yes. This patch changes this behavior only when the new flag is set.

I doubt if it's really necessary to send link create/delete notifications
to link-netns. Also the current behavior is somewhat inconsistent, say

    1) ip link add netns n1 link-netns n2 link eth0 mac0 type macvlan
    2) ip -n n2 link add netns n1 link eth0 mac0 type macvlan

Intuitively, the two commands are equivalent. But notification is sent
only for 1.

