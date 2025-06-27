Return-Path: <netdev+bounces-201980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EA8AEBCDF
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 18:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C06B87A631F
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ABA2E1C7A;
	Fri, 27 Jun 2025 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ST7iSzkW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12BA19A288
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751040636; cv=none; b=drxyL7eUjFrhqBd9+7lEq3VrdroKdl8O/EO5vHEIVxSZAO4vOI1vp7CkQCZai1J8BG1J6LPHTKN4yYMRP4d6NikqxR1XRjHzniMfLnduUhkvUrI3YzQYk0L9bE6APqj5de78CrA9fqQW0LzOFBAT5NtB5pWgTkZJFR36//e3j1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751040636; c=relaxed/simple;
	bh=KjiesiOLTJuJUiI4ZuBnTQtJZJtt8CUCC3JATDX1tEw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SS+ZlAiggIDijhAjvJ3jOSTcgMBKGUYw8XxMp/+RBsv3W0yt+Jp7mfYDl2NAm3xGZcLxmxwNO57ON9maxSF7KXFM623IPd9OefksL2pMJzgmXmU3hhwF/txEYnzii4l4DVEa9z1pX81p3rIih/KtN5gMdYJEg+yqD41vjr95N3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ST7iSzkW; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e819aa98e7aso2121273276.2
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751040634; x=1751645434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgiwzzA1R3KYrVtZLzbdtWojSRr/7TuPYyNSR9ly9Us=;
        b=ST7iSzkWxoX68AaMVE+lgzI1hgvdW52ZmqndHDW4g2nB2h7+b84hJxuAINKdkBX+OE
         cdxcyHBymQuKiTeMz5JPhHS8gB74cu2JpxNHjshdVTfoPmsQjAW22Y8TXDo0UllyD6XB
         BtzqUi5LnlpV8SZDW7wQDb3jCIrqYdPaWFm3TlEUPk81KFPUfffkQ1PEt1vvkYhhSfs/
         h/nypeEyqC2+YKEtUlV5Rc/tAdySli4yxifzNWyQYHZngKWRLRMchPO/mE/DaOAVlWAP
         3B/ji042OVcpfED9gCIic7UccO1iSPiMbLXzDn4dgPyIpD/SJemox87WKJcqUbZ/3O0u
         4rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751040634; x=1751645434;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jgiwzzA1R3KYrVtZLzbdtWojSRr/7TuPYyNSR9ly9Us=;
        b=Z1LT5+4NwikyPqqFR50I/8KDdesQuaRUrBIepL0i9ACk28e5pc6C1/Zth09li5ipEo
         fb00dSMD3Ldc4dUsdMcDlJvkVb2G7JCyyA1U+LVDgJgTq8lCD+00/rAE0HkRT4ynLNUM
         wv8Bn+wyatMKLYcRmYNcN31TLZmvZoN1CyfL0UxoCwgzcvG9q8YWRfdpK+QJmDoT04FJ
         giBASKTEgnWyQ1kQZCvztf+Z1RR6ed91PMiKd5yB36ParlBL/KvpimhE9WbRXCAFFz67
         KdFA/OiL6c6siIMb0ZCM6uPxEOfK7i691tjw8AsxLpesLeu0YUMUvuO8mQj/yoKPRbzj
         hRtA==
X-Forwarded-Encrypted: i=1; AJvYcCUmrOVgkazBAJtT1vDIoiZVXUKMRj2SF573zCRYN50iFwGe0KK7MyDYvHAXm7QHUzPx2MtgU08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW/zMspSiN5GuWLHMMfEpt8ufCHVEcuMFeDOq09yS5YmY73BeY
	JIUHq9QA4/Qik7JjPX0nekEBo4vXG3JYq2S9a17pjyxl3qA9lbso8lUb
X-Gm-Gg: ASbGncuWPJGPXAAGFgeubWuxN9vg+7gE74teNwUB8nwNoCPqjyr3E7pxgP1HNC9fx97
	g0roNO74IXxMIJ3vjH0LEMJqSGDM8Y3c3RDWw0HrvbV9Wpf8e/EiV/dwEvGxdYUHL84qeoAJCQq
	fN911rSblrxPJzgtqnlqUheCQ3aRGfClrAxUPxPq1bSS6ZFNzgsXmjJZZCFn+E7CFEblDNPS0nF
	T89VVqRn/R0tMJHQ1Ds3RbsINDoLH72rBpjjIAD2Hisdu1RsKbtKelSP6TGiOLmBMzFnEn2uRoU
	HMYI5ZrO116waw9mecOjPYXkCzcuqTaEnqYTcD2oF1ODXvQ/Db5SS6ew8HeylBzIFPh+JealTos
	Cw9rtUBCvn65q/WDLWtLIubfdZFbnLs3+LrfxWx0=
X-Google-Smtp-Source: AGHT+IEYLfClkercBc4Tn0hab9hoerKp3xVPT/64DfP5qyI2loCpVoWgG77QA6BGdRjIEVtftFaHFQ==
X-Received: by 2002:a05:690c:30b:b0:710:e4c4:a92f with SMTP id 00721157ae682-71517154687mr54294707b3.5.1751040633567;
        Fri, 27 Jun 2025 09:10:33 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71515c0581bsm4762947b3.41.2025.06.27.09.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 09:10:32 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:10:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <685ec277b82b2_4f1ca2948d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250626165703.0d03f415@kernel.org>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
 <20250625135210.2975231-3-daniel.zahka@gmail.com>
 <685c8c553072b_2a5da429429@willemb.c.googlers.com.notmuch>
 <20250626070047.6567609c@kernel.org>
 <685d5847a57d7_2de3952949b@willemb.c.googlers.com.notmuch>
 <20250626081156.475c14d2@kernel.org>
 <685d816dd20ff_2eacd529452@willemb.c.googlers.com.notmuch>
 <20250626165703.0d03f415@kernel.org>
Subject: Re: [PATCH v2 02/17] psp: base PSP device support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu, 26 Jun 2025 13:20:45 -0400 Willem de Bruijn wrote:
> > > > IDPF does support multiple "vports" (num_alloc_vports), and with that
> > > > struct net_device, from a single BDF.  
> > > 
> > > Upstream? If yes then I'm very bad at reviewing code :D  
> > 
> > I then don't think I want to focus your attention on this, but..
> > 
> > See use num_alloc_ports in idpf_init_task. Which keeps requeueing
> > itself until num_default_vports is reached. Which is a variable
> > received from the device in VIRTCHNL2_OP_GET_CAPS.
> 
> That's not too bad, one of the older drivers had a sysfs interface
> for creating the sub-interfaces IIRC :/
> 
> We should be able to share one psp_dev if the implementation shares PSP
> between blocks.

Great.

> I was trying to write the code so that it'd be possible
> to attach the psp_dev to veth / netkit
> IIRC the main_netdev was supposed to be special in terms of
> permissions, the admin in the netns where main_netdev sits is
> the admin of the device (for rotations and config).
> But I was planning to add a secondary list of "attached devices"
> which have access to non-privileged operations. 

That makes sense. I like how this approach enables support for such
devices without having to explicitly pipe through net_device_ops
(what legacy Google PSP implementation had to do for each of ipvlan,
bonding, etc).

