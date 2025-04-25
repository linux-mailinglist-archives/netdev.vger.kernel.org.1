Return-Path: <netdev+bounces-185958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A293FA9C50E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 12:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131151B8041B
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 10:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C5B23A564;
	Fri, 25 Apr 2025 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMNqFTbn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507A522156E;
	Fri, 25 Apr 2025 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576248; cv=none; b=EBWTBSGNvt5sqZTGz82TuMjPNNyfR3r9XXItBxHqNM645vuT12zdd1qgaV/oOEEt2+6R//tQzt4CHvGo5bRDjrWF82hTC9HUMJmfp9McB9ufV/+T6wxjkpL5gTW+HLoi4yBQYZvIKwRD+dQ4IiYJkpCSykQMY7ImeNNbYKuTHpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576248; c=relaxed/simple;
	bh=yxEWwgS6mqTatarLhuSCwRAm7Heme/ytzkkDRHWbBsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0z6ymR+g//HyrprsGzbODkQYSzs3VgMTNl+eFX0X+KJh0ZBxeIXPEpwBp0xwtrWjdh8q5ZOWQ8H5OPlH7fmMef2XKgje2jp7Y2Yx01lPrSbiWJPzJbPPG1Ec60J6kf48nAjXSPvc46Bd5Lcg0aR+UDziwzj+OOHhlIZ7MJVUek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMNqFTbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FF8C4CEEB;
	Fri, 25 Apr 2025 10:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745576247;
	bh=yxEWwgS6mqTatarLhuSCwRAm7Heme/ytzkkDRHWbBsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMNqFTbn0pcwzwTpG//tMyarxkDSrafqDkGHNAFK41OMKRv35a0g2j3f4dJSkzxsz
	 Zgg+BQzy0JSvKrRZQL+DEoPFGbdxROvAQlk6r/4SmYigjqQczzTj+k62kSJBc+cNtm
	 85av9+415uloWQTSw9ElNLlXot1pxaEukH7OX3tsTg/ynDIQhhwSQY5VvQOrsc/IMh
	 7IxgTT0ac4ypeYwpGPrsb3Ou6agvJK++zLes+iFEWSy/si2uSwOHVcAqFj30C8r0Xw
	 wUpkLD3+7c2R/mHnDkAb8KJTRFizuSuTZ0/4Y02uJZx+8s7X90TTkFlNCHrcCI0T3l
	 syCyxX2QiweXg==
Date: Fri, 25 Apr 2025 11:17:21 +0100
From: Lee Jones <lee@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
Message-ID: <20250425101721.GC1567507@google.com>
References: <20250424154722.534284-1-ivecera@redhat.com>
 <20250424154722.534284-6-ivecera@redhat.com>
 <5094e051-5504-48a5-b411-ed1a0d949eeb@lunn.ch>
 <bd645425-b9cb-454d-8971-646501704697@redhat.com>
 <d36c34f8-f67a-40ac-a317-3b4e717724ce@lunn.ch>
 <458254c7-da05-4b27-870d-08458eb89ba6@redhat.com>
 <98ae9365-423c-4c7e-8b76-dcea3762ce79@lunn.ch>
 <7d96b3a4-9098-4ffa-be51-4ce5dd64a112@redhat.com>
 <20250425065558.GP8734@google.com>
 <98e471cc-ec66-4c89-af9a-57625c0c2873@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98e471cc-ec66-4c89-af9a-57625c0c2873@redhat.com>

On Fri, 25 Apr 2025, Ivan Vecera wrote:

> 
> 
> On 25. 04. 25 8:55 dop., Lee Jones wrote:
> > On Thu, 24 Apr 2025, Ivan Vecera wrote:
> > 
> > > 
> > > 
> > > On 24. 04. 25 9:29 odp., Andrew Lunn wrote:
> > > > > Yes, PHC (PTP) sub-driver is using mailboxes as well. Gpio as well for some
> > > > > initial configuration.
> > > > 
> > > > O.K, so the mailbox code needs sharing. The question is, where do you
> > > > put it.
> > > 
> > > This is crucial question... If I put the MB API into DPLL sub-driver
> > > then PTP sub-driver will depend on it. Potential GPIO sub-driver as
> > > well.
> > > 
> > > There could be some special library module to provide this for
> > > sub-drivers but is this what we want? And if so where to put it?
> > 
> > MFD is designed to take potentially large, monolithic devices and split
> > them up into smaller, more organised chunks, then Linusify them.  This
> > way, area experts (subsystem maintainers) get to concern themselves only
> > with the remit to which they are most specialised / knowledgable.  MFD
> > will handle how each of these areas are divided up and create all of the
> > shared resources for them.  On the odd occasion it will also provide a
> > _small_ API that the children can use to talk to the parent device.
> > 
> > However .... some devices, like yours, demand an API which is too
> > complex to reside in the MFD subsystem itself.  This is not the first
> > time this has happened and I doubt it will be the last.  My first
> > recommendation is usually to place all of the comms in drivers/platform,
> > since, at least in my own mind, if a complex API is required, then the
> > device has become almost platform-like.  There are lots of examples of
> > H/W comm APIs in there already for you to peruse.
> 
> OK, I will do it differently... Will drop MB API at all from MFD and
> just expose the additional mutex from MFD for multi-op access.
> Mailboxes will be handled directly by sub-devices.
> 
> Short description:
> MFD exposes:
> zl3073x_{read,write}_u{8,16,32,48}() & zl3073x_poll_u8()
> - to read/write/poll registers
> - they checks that multiop_lock is taken when caller is accessing
>   registers from Page 10 and above
> 
> zl3073x_multiop_{lock,unlock}()
> - to protect operation where multiple reads, writes and poll is required
>   to be done atomically

Looks sensible.  If this is aligned with the discussions that have been
taking place between you and Andrew.  Let's see the code before we make
any binding agreements.  =:)

-- 
Lee Jones [李琼斯]

