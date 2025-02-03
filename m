Return-Path: <netdev+bounces-162210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F118A2634D
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D005318837A7
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 19:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783541D54E2;
	Mon,  3 Feb 2025 19:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsc3vGnU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8E1192B74
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609755; cv=none; b=U73A0pq3v3r4Sh6H4Dp5i76GKBqPcAXqz/657EXr12+Uw11eqSKMFO7aYw2hcfWu49V7PdidQcLrdEVPzjP/c2QXUkYGL6G3QTU/JKRX/Tn1glAXsYITX6VTnJtxTpfEfmD+7Zk9AQNzRIlcqrLUOmBv3Ah3nEjuUJjJiORiR7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609755; c=relaxed/simple;
	bh=ZjK74YNbZOKeEc9DattBh/8nhipSihzWQ3Am6C3D2zo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hTHh3Qwy/2RU7iKRV1OifLOCx+oC345zdM8YT8CH+NQFuWL53XCeqOXs3gCkTj7GUkizB0imvtIT4GVUp2K/N2NkIxsuc8WbUMR2jXZ2hZK91PwISXVJYO4SqfGMmpnT+/Ln623I4/oOsREKirHC2HZff7JRd8Q7UUI3mzpgQ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsc3vGnU; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-51873e55d27so2853564e0c.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 11:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738609752; x=1739214552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjK74YNbZOKeEc9DattBh/8nhipSihzWQ3Am6C3D2zo=;
        b=hsc3vGnU3h9NRruwMtLuh7mrTIxndged97RjDiIutr6VZfhgwcnYyrkAlG4Au4gawl
         QDcR485IXeA2rGl5kNbKIxCJI31FZQTp3SLGAwG7ID6b7KKZAqzPUj8RgO+mROvm6D3w
         MSXwdj6YBr3JeyVmWiBZGi5RvCtOfTCHJLwOvTcdOpSs6a8NRFr8BW9nfflVEdwsAaV3
         jf0bLmrJhAzEzzjbmC0iWTMopTNd5MCVLzrvYnUcFxBw5iq0TkncUc46Y//RKKvY2oxU
         9stcKLOMZR1F3QDwJhBM9qfHmfv9whZZ1ZU8l63bx03Uxrm0fjSYLy1FLVVva/HhGQLk
         A+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738609752; x=1739214552;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZjK74YNbZOKeEc9DattBh/8nhipSihzWQ3Am6C3D2zo=;
        b=ITTcYsr8hRrMwpLYx16hhkG6H8iM3BxmrbM8f7ET0lf3McC8ae0YJcHiX5NsyEzYsX
         rCQLqUOXiM2A5boxf12+u+HNNN/Ct8G8BuUv7w2YumXWHAloGa+l2e0IGqiSSaW4kU/C
         lRE2DqDjSZPFdpSbmmdxVAZ3XH75Nai2ZOXnhCkPMBwiJKNEfRFh2fj+y5j2Ue2ctBQT
         +vh11XvnywY0UaMgohr5s+xQ42yY+gQqIIk9XfKYI6wo3t7CTeCOKKTuBDnJO7mKR7p7
         NVlN7h3Fm77B3VDo/8pzlYQ5xfvTbROYi29lnIV5F0ZSTGNo4DC4h4AyKk1csTj6XdK6
         EnZA==
X-Forwarded-Encrypted: i=1; AJvYcCVU/Im46F0vQCadfqNblmOgemoPetCyuBJUjZHmFOV++Q6URmzMjFJJ+8OQU8GICp75Z8y1Cg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNDfnSv1tPod9ESNB/BByhsG+LnOz5G0hcxUzeRJ+vLEsYZqBS
	Ia4KvYaHSANoaEenfOuFw+cHbqw4t6j15HllVrB2FJLWLTNm+uFR
X-Gm-Gg: ASbGncumK2DIxNTyaQ68EJDghFiMJh2ho0D2TK7qQCmHBMZE3VUqK3mRshc7/X1ZIhL
	3FDlhWSPU9SAUoO/YJnHFXr511TDBfoKxT/9Y0oFKADkrOnKGzUFzgH5EjlibShYoMRaFNRlUnA
	Zq0U6fLqZaevjTMNKafakI0cMRVV/saurY5U4d57SUX1kgup36CBtBSk1bHvXkfzQLiM0v/Tc/A
	WwodUDpG7KRbqYwAFDY7mOTdg+YkXKrOZIDB+1K3uc58qX7d0Gmf83bMAfyC8kH1hQs5PMeRsd+
	s7oNyyjoBlIseGtKHjFJnPrTYcyVBhrOxfeqxjIJXn0/u/aFo5iP3lRO70zRNGE=
X-Google-Smtp-Source: AGHT+IE23oWtqz0kTJ0f7I+X4OkxEevAZIVOQaTdJBW6WPvOQq8syqkwxoY0a8Sf5xd2K2vqwVKJqA==
X-Received: by 2002:a05:6122:8c6:b0:515:20e6:7861 with SMTP id 71dfb90a1353d-51ef966291bmr724855e0c.2.1738609752521;
        Mon, 03 Feb 2025 11:09:12 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51eb1c3d0bfsm1446616e0c.27.2025.02.03.11.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 11:09:11 -0800 (PST)
Date: Mon, 03 Feb 2025 14:09:11 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: stsp <stsp2@yandex.ru>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 jasowang@redhat.com, 
 Willem de Bruijn <willemb@google.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>
Message-ID: <67a114574eee7_2f0e52948e@willemb.c.googlers.com.notmuch>
In-Reply-To: <48edf7d4-0c1f-4980-b22f-967d203a403d@yandex.ru>
References: <20250203150615.96810-1-willemdebruijn.kernel@gmail.com>
 <48edf7d4-0c1f-4980-b22f-967d203a403d@yandex.ru>
Subject: Re: [PATCH net] tun: revert fix group permission check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

stsp wrote:
> 03.02.2025 18:05, Willem de Bruijn =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > From: Willem de Bruijn <willemb@google.com>
> >
> > This reverts commit 3ca459eaba1bf96a8c7878de84fa8872259a01e3.
> >
> > The blamed commit caused a regression when neither tun->owner nor
> > tun->group is set. This is intended to be allowed, but now requires
> > CAP_NET_ADMIN.
> >
> > Discussion in the referenced thread pointed out that the original
> > issue that prompted this patch can be resolved in userspace.
> =

> The point of the patch was
> not to fix userspace, but this
> bug: when you have owner set,
> then adding group either changes
> nothing at all, or removes all
> access. I.e. there is no valid case
> for adding group when owner
> already set.

As long as no existing users are affected, no need to relax this after
all these years.

It is up to users to not choose an overly restrictive setting, similar
to how they should not set chmod a-rwx on a file.

A user will immediately find out if they mess up this configuration,
and it takes extra steps (ioctls) to reach it, so is unlikely to be
reached by accident.

> During the discussion it became
> obvious that simpler fixes may
> exist (like eg either-or semantic),
> so why not to revert based on
> that?

We did not define either-or in detail. Do you mean failing the
TUNSETOWNER or TUNSETGROUP ioctl if the other is already set? That
could break existing users that set both.

> > The relaxed access control may now make a device accessible when it
> > previously wasn't, while existing users may depend on it to not be.
> >
> > Since the fix is not critical and introduces security risk, revert,
> Well, I don't agree with that justification.
> My patch introduced the usability
> problem, but not a security risk.
> I don't want to be attributed with
> the security risk when this wasn't
> the case (to the very least, you
> still need the perms to open /dev/net/tun),
> so could you please remove that part?
> I don't think you need to exaggerate
> anything: it introduces the usability
> regression, which should be enough
> for any instant revert.

This is not intended to cast blame, of course.

That said, I can adjust the wording.

The access control that we relaxed is when a process is not allowed
to access a device until the administrator adds it to the right group.
Is this used? I doubt it. But we cannot be sure.

