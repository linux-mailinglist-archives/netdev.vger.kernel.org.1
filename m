Return-Path: <netdev+bounces-117858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F7B94F8FE
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 23:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12927B21D66
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 21:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B358D19412F;
	Mon, 12 Aug 2024 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJp7xeNI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AA554759;
	Mon, 12 Aug 2024 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723498558; cv=none; b=MRsle7qjuf+rFfjVapTtNLRU8uOgsEGm54ZpqmA+HFtNYcnLdMXln4Vnco8ssmHsdhzsejNayH+nBJWbBj1YKQti4MGsj782nABjFiHzfJOYXmfK7HdIYj31acJkNirdS1f32Q7w+zuoghQxbXbTUnSAQc9fLoL3lMYT/fdWubA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723498558; c=relaxed/simple;
	bh=oiZO958/g3pd92ag8eOblYST6tGatkKx7ddT1zWe6FQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RE1P6jXX0QqHPp4Icaymj7tzJWL23YBKpX6K0Ew1/bUYhGR3bPBKs91DqQk7DB8tuO9om00eX0qXXV2V+vpVqYeJBHyJB1xwEL5trY8V7IVIGYp7+15zmAL4VCfbhLN4l+4FMcR7nlGy+2hFi4jfCk5hfokdOM8icH6pviWwnoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJp7xeNI; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0bf677e0feso5059088276.1;
        Mon, 12 Aug 2024 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723498556; x=1724103356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zCOHIkKa9MOs4it64LjArTuPJu/6oyaZeNfL7hns58=;
        b=OJp7xeNIHhGA1ZDyOIzcsaat0NTT10MIDTVnAsKuc/s0+CMHg5R9pkeSr78UXsxm8s
         54Lnt3cvC8TlNADIiSKnVQETCbg7k/wQvwTpFEfBmcoF26ZdtX/DxnNH8IKlz/BpQakM
         HwFsB/uwXLK93ccPqp4eo8wKdURJnZQ7esA8bWxxcBe/T6UJqjZ4Qxpnfbf8sAtgLqcU
         cjIp3L92jiut1HRmiWCO0uhA5xXR90vGMQtSB7naxyM9J50ApHHLKofNH7rDLONHqbYE
         ONr8kIYWcgHXr9C3D53RY5fIdyvYsRZ+SRjf+FQDO7U45Kvuk5/2ONmSAhNeoifO45zR
         FsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723498556; x=1724103356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zCOHIkKa9MOs4it64LjArTuPJu/6oyaZeNfL7hns58=;
        b=sw+XyH2lw9FC/TipQ8vCiHXAPwHb0RY+yj+muijV2yF1jK54K/wqZr/jSxJPdDepkU
         oLH6OKcdJDo/L99p2Q9oWTsaw13/Mfdb2VOvU2rdW394woswiEjNESD4RJDEcvA/unKX
         +dt1tTDXhbds3YgJwQCQLJ3XV2KzhCegS+FbjFxyNs342cU2lvbXba21OKvgrmMmobOz
         rm80rN7D0wccrREfepHXsD77dY7F4aL+kA0wDklQ++DjkPpVKvfSyA1lw0VrpAAV+IqJ
         3V1gQZ7JTWfH/BbXMLf9K+DmtdHlALCJDHYD1O4C+5NlnxC+C9ow9rN50Mv36u0oLSqf
         LhEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvEb5MjOJn1X6E2SnvXgQsH0bXM93kaL/4yHGAicDFG07SArXcbpoebCKBL73kl33Nzo/2cOBmmKo+hyU1lH4IzjsfLAoNb/Xu5UmA
X-Gm-Message-State: AOJu0YydywqIlr21wzy7yHm1WY9LW2THiot5RDaIsN6tAddChhr9/7Ry
	Ewm+wCLhA62qCIVCe3JcohbgKfV20DxCLgzVrWf4hcbVcN3KIUZtZuIRi42eIWvr6ha1DdcZwvn
	s8UrHWuBU4AQG7Hr0p9nktpo2/c0=
X-Google-Smtp-Source: AGHT+IGZg2RafmXivgjBbCMFkIfGdPJ8YZKp7cPwYB/Cn0z9Bv3a0oQ0yF0T+2EoDqVEt4aWUHo+7u+ZncBU4VNxEd0=
X-Received: by 2002:a05:6902:1688:b0:e03:6085:33e9 with SMTP id
 3f1490d57ef6-e113ce6fe08mr1752190276.2.1723498556062; Mon, 12 Aug 2024
 14:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812190700.14270-1-rosenp@gmail.com> <20240812190700.14270-3-rosenp@gmail.com>
 <ae818694-e697-41cc-a731-73cd50dd7d99@lunn.ch>
In-Reply-To: <ae818694-e697-41cc-a731-73cd50dd7d99@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 12 Aug 2024 14:35:45 -0700
Message-ID: <CAKxU2N9p4DrbREqHuagmVS=evjK48SWE5NM3RbD5zF6D-H93kA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: ag71xx: use devm for of_mdiobus_register
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 2:28=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Aug 12, 2024 at 12:06:52PM -0700, Rosen Penev wrote:
> > Allows removing ag71xx_mdio_remove.
> >
> > Removed local mii_bus variable and assign struct members directly.
> > Easier to reason about.
>
> This mixes up two different things, making the patch harder to
> review. Ideally you want lots of little patches, each doing one thing,
> and being obviously correct.
>
> Is ag->mii_bus actually used anywhere, outside of ag71xx_mdio_probe()?
> Often swapping to devm_ means the driver does not need to keep hold of
> the resources. So i actually think you can remove ag->mii_bus. This
> might of been more obvious if you had first swapped to
> devm_of_mdiobus_register() without the other changes mixed in.
not sure I follow. mdiobus_unregister would need to be called in
remove without devm. That would need a private mii_bus of some kind.
So with devm this is unneeded?
>
>     Andrew
>
> ---
> pw-bot: cr

