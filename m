Return-Path: <netdev+bounces-306215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9uoWN8aXT2rCkQIAu9opvQ
	(envelope-from <netdev+bounces-306215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:44:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6DF731249
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:44:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eJnm6eQH;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306215-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306215-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F82930D6F2A
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A5B422546;
	Thu,  9 Jul 2026 12:39:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987BD1BD9C9
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 12:39:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600754; cv=pass; b=IVDeDWV5K1WYPVKabOHXSFgJNfB3ue1twG8+pWj68XIH5he3dYjEoa3gjZXyfXO92BrHI4Xvysu+bln+MP00oyqOnwKQCQbRygAtgpXspVObL0XtQwQqzYhzsosrr3NNnwpqe9MPk6rLqRr5nZPWY8RdomkgduLuezQEDc/mOJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600754; c=relaxed/simple;
	bh=Xl9PbSXbschCuJYzks46Urc8XGsA9GGrNgmJ8oWnohY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMIsa13tes3dUIl2LdBk4eAptjsOkhwHUvtiOm9F4+LlSdopNxWYsEAeUvPuS2ryXAgCf9oivVnlf7yamYibD6NJenFLFURzSZv74XUWm2hd95k14hsXszcRyOx0p59RiVfbjoFoos0JkvTn7Gp9lN65A3uW1IAleJ3LngGvhhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJnm6eQH; arc=pass smtp.client-ip=209.85.218.50
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15b509c323so104781166b.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 05:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783600751; cv=none;
        d=google.com; s=arc-20260327;
        b=o5DIPT0yaPOfMx0SWc49xRJ4SFsCCtySgxrPfDo2ILy6VuLxzsxP6eV5Jp67AZKYak
         o/UApNmePbF6T6f2QNudUMJtLwaLSxa7VBs5nnZYr8iFJKZbdT1BBORTmiHlTwmiSm2Z
         PJe8f9ssew+awWOZLAwjdNxbkr7J84BLU6HA5nqDjJ0hexY37Lqrd4wAGNcSxSG1MZcC
         zDphAAczszrMjme/cDxnbTDVCLl16toARUjrzlBYE45bk1moeWCq8xEtXTh3gWdAFVEI
         sLqBsTytY+NHYgerGfUaHtSSEdaniV2QHE4unvizuzUSYvYz7HrQaZGiwwFPTWBV8OEt
         rY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xl9PbSXbschCuJYzks46Urc8XGsA9GGrNgmJ8oWnohY=;
        fh=xUUQ3lsbv3DTvKdt/3+IHztWHOYXD70ym7pg/8QqFsY=;
        b=eITwFcDbYYnPCflTvs6uqqP9ilGVx4qadpgZtE0XeoTWJns5hqRSpsl5Higl0R8pun
         wCYAlFrjPgsdffHfh4tmsmkoxohrhl0GFE7OKHkOKX2dQhWWBchWP2ZRmoYhZDvuTpVh
         DNt/ZzY0otmXHCtxgUfUlxzd692no1pmOSzeUhvoL19JT3L0DJ2x49P4Qjg22aB8A9Of
         sh0+VdZl8qAeJpfbuSB+I7EHWGk3ISj03ij7/OZLVv0T7MRDEX5r4ARKtYA+Ltb+z0km
         i8jawM2SGZaUzAIjkGOlfVXv9265DQEZaI1sYKKjQfunE6hhI7adgaBXbn34OMic94+a
         N0lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783600751; x=1784205551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xl9PbSXbschCuJYzks46Urc8XGsA9GGrNgmJ8oWnohY=;
        b=eJnm6eQHfFlt2rdQI3xo7xAzeOmjFTHpkVA17rMwzRJ6hkNiY5c3x/I/8zDX4auA/d
         nkSpdIF+qbWFUcX1ip3R/Vy+33sJREkKUhjrl//5QDgO7rOInoo6OT1dp+UgkOOu7DwS
         TClCCZpva3RRp4EiPcKt8tvCezP7NNnsR87liioMsSVHQjVTl4LPJVPUZdGh9ZjN5P0G
         ykA9wl6tWzZ4FFtJ9BRLa7jKTSsbBbeAqKa7m8di6ORGrY3p8OINcshy6XJQHp3le0jH
         dkisisnnwihkjr1vqytCFc8XGtbKSi0/1AhDEPPlh2U06mAe/W92EXj4UnfLIUE1V1Bg
         CA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600751; x=1784205551;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xl9PbSXbschCuJYzks46Urc8XGsA9GGrNgmJ8oWnohY=;
        b=ZYKorxe/NgeBAS5i7EkbUBVxwjlMlOnUpq4DWArpxaMQC5ytFJ0DtOd9Xmz/uFeLZq
         vwFBKFiu987JYcJKgtQs+ISQ6MVabt7nPIRETFWH5gExRYGZZhXfNjh8uIaK6RwJsI3v
         I9xKKk7ZhxWF9dw0aD1sZSIPLORwMbqMFgaSJGyj6t7vWn8qaBjSqjpYfL3KBxjopk1a
         0xVj12Rr0iTw1RmYufc1Y9eeZJ6uQ35o3PWRwMErwyYVeUfuakeWhXbSUNSyUcUpflGe
         +6cGv0tvAJG/XQmE2ttNKkzH5bkJUzI3To4E3MHElkdLDIBDS4jBRiw9wZo2RsgRPm11
         zUtA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2vLhdZEwsiQR1nT5H2g8v/QzHyLuUC/zy0K6dEuoDkNHtCKur7bfYnM2uO4og58pBQ+o1dTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLCQpb4WwfHPz24Z6hF+CkUSIpeThisYuXMZG6ldXqv4IZNU35
	jodckEzYZmAj4eeqrOOMljb4kSreR2ln5n/R6eWcyhohRZxh7zwwvMP63REtR30iR1LL7CEB+7t
	PT9pGvcw5Y/HYBoqwFkWFFXGyHg5Df4s=
X-Gm-Gg: AfdE7clspj/d1e/szX/uke1e+GqA9nVW0jagiMZDcBTQAOzavtnIf7EDF0a+1VZM7+v
	ND3iE6H1jSvvkeM3nJ1KAoO4Ux9j+edNQWpjYcHCfm+lYQzvTTxvuDmIG0D6ItttXTjZd81Xg8N
	UTHRZUg9GjYhdh/XzLpDhzINBEYBDW0FGsX1JsUMA5OE47oYiNEYNLSzch4DsifMoblH0ucz+QR
	9Pnrcw7jBOEkrErioKTq843hMnihVeGNdpFuCnzp/fzjlHuhXhL6wG1OOz88GYWC1rnKgI=
X-Received: by 2002:a17:907:e153:b0:c12:6ed1:a7bc with SMTP id
 a640c23a62f3a-c15cdfe9b54mr217106766b.7.1783600750745; Thu, 09 Jul 2026
 05:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE2MWknz4X_gcNo6jkR87Lg8F0zfubkOc4Ujr57CS3aBMWrjEA@mail.gmail.com>
 <20260625054005.0016.bridge-mcast@kernel.org> <CAE2MWkn=azz3gUKGBYc1jjvVnLxDHuHk9M7wAJHdAW8v=dP5GA@mail.gmail.com>
 <CAE2MWkkON7HuB+Szc1VhaPL8ZTYMAyfzmPM_7FkXvOPnjnF5rQ@mail.gmail.com> <2026063019-crummy-mosaic-d9bb@gregkh>
In-Reply-To: <2026063019-crummy-mosaic-d9bb@gregkh>
From: Ujjal Roy <royujjal@gmail.com>
Date: Thu, 9 Jul 2026 18:08:58 +0530
X-Gm-Features: AVVi8CeeSy9sOe-nDvJ2FgnZIaGmm16MJR8SeE21mrKCu6quf0TcNIj4Rs8oCSQ
Message-ID: <CAE2MWk=SXVZRmOnnWs0AYWLWqLipo0PTND9UCQw6noDBoJ5CdA@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to stable kernels
To: Greg KH <greg@kroah.com>
Cc: Sasha Levin <sashal@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, stable@vger.kernel.org, 
	Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, Kernel <netdev@vger.kernel.org>, 
	Kernel <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:greg@kroah.com,m:sashal@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:shuah@kernel.org,m:aroulin@nvidia.com,m:yongwang@nvidia.com,m:petrm@nvidia.com,m:stable@vger.kernel.org,m:ujjal@alumnux.com,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306215-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kroah.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F6DF731249

On Wed, Jul 1, 2026 at 2:00=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> On Wed, Jul 01, 2026 at 01:33:07AM +0530, Ujjal Roy wrote:
> > On Thu, Jun 25, 2026 at 8:20=E2=80=AFPM Ujjal Roy <royujjal@gmail.com> =
wrote:
> > >
> > > On Thu, Jun 25, 2026 at 4:12=E2=80=AFPM Sasha Levin <sashal@kernel.or=
g> wrote:
> > > >
> > > > > Please backport the 5-patch bridge multicast exponential field
> > > > > encoding series (726fa7da2d8c, 12cfb4ecc471, 95bfd196f0dc,
> > > > > e51560f4220a, 529dbe762de0) to the stable kernels.
> > > >
> > > > I tried, but it doesn't apply to 7.1. Could you provide a backport =
please?
> > > >
> > > > --
> > > > Thanks,
> > > > Sasha
> > >
> > > I will create patches on top of 7.1. But tell me what about all other
> > > stable releases? I have to create patches to all stables and how to
> > > share the patches to you? Via this email or any other process? I am a
> > > fresh on backporting my changes to all stables.
> >
> > I have prepared the patches for stable releases mentioned in kernel.org=
.
> >
> > And I am waiting for your response so that I can send you the patchset.
>
> Please just send the patches :)

I just sent another email with the subject "Please backport bridge
multicast exponential field encoding fix series to
6.1.y/6.6.y/6.12.y/6.18.y/7.0.y", please accept that for direct
cherry-picking. Infact 5.15.y also cherry-picked cleanly, except for
the selftest commit which is not needed here, will send another email
regarding this.

I will send a separate patchset after resolving conflicts on 5.10.y and 7.1=
.y

