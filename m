Return-Path: <netdev+bounces-65056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA43839041
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 14:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B341C212EF
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 13:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F3E5EE93;
	Tue, 23 Jan 2024 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b="ncmBtmG1"
X-Original-To: netdev@vger.kernel.org
Received: from egress-ip43b.ess.de.barracuda.com (egress-ip43b.ess.de.barracuda.com [18.185.115.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B755DF0E
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.185.115.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016911; cv=none; b=OiIDxRHp+HgU4aH+bykKoCuSigrjUFdjq0m89VWDp1zotWgZBj/zSco964Nc79kxIuN509LNxhdgbfNRLXdjXD0E+L/I3SP85kXnxh7nxGQfZ1P9+VQmXtHdBYUCRi3ayh715ohusMKa6+EeuIfhIBM4+6rHl/cc4q8ldOim5GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016911; c=relaxed/simple;
	bh=3PJCUSi7n6f2UbuGQuKqReyCeyvOBrR0/m+fDaClDug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6gC/rY8C7DlZn2avXxvLPpl3PmIqRssmJoufAnJyvinabXFf7TvQqNv7wxXbTa5XnuPVeFH7XEab4GUNcZbSCxIYhoRFw5rK1C3oUKZTXU9pTcJDMtNHBri038X50jWxglX6V2LuJQ2scg0PO58fxZ58/5bLG9h1yLg6dQlcSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com; spf=pass smtp.mailfrom=mistralsolutions.com; dkim=pass (1024-bit key) header.d=mistralsolutions.com header.i=@mistralsolutions.com header.b=ncmBtmG1; arc=none smtp.client-ip=18.185.115.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mistralsolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mistralsolutions.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71]) by mx-outbound21-238.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 23 Jan 2024 13:35:02 +0000
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5100b0ef08aso286203e87.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 05:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google; t=1706016901; x=1706621701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmOPTWMYJA/QBvOvWEGKNnjBvA70vnXmrySk2qIeTms=;
        b=ncmBtmG1UFN8gAXJBnjT9Rz4F+bjlYQfsF9ZSOVzyEAVA15CULylvPYQpuvz2Ahmiy
         6oEghz0sf9BYZIW3kZ/DoXVf8X0ID5ljVFG8FqtJq5stV2RodAeuOr4Lr39ZMmKlOyBA
         VsCEDvTiT6JSenkFukaFQ05VTSxNp1SlWicMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706016901; x=1706621701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmOPTWMYJA/QBvOvWEGKNnjBvA70vnXmrySk2qIeTms=;
        b=i+hPafdnRROOUuci1oww5QXQ0Kf5FPpeR6VWAL6IuaSvQcaonMaoGF+P56zpIV54XL
         hGMycOdjZqMW8DKNufF+nm8tdgNAfo3bc2jU+tHfeE4jRgRG+eKNN4M1JgcsABox4Njj
         g1m0Hr1rLRl9+X5aGYA2zy/A+VxeSMArNuD237TEYFZx0lZPRvlbRM/D3XfxdoaTC8JJ
         IA3Ly1RQHI5qiNGGbA5rw9cbrOMSAfJQwC7A+WYg7MdoE1NgkZeaart7ucKaYtafL/ri
         RIsDsjHTZFxI4lJjGZecV9/Wd64owUAI+SNfouAYeczsgTAynNQ2fytxVPMIPFdJ/2lO
         cfEQ==
X-Gm-Message-State: AOJu0Ywh8N7+CSYTgHIW9oC1S8KLy+v2qdE/aCooqKn9MdsObe9EramM
	lc0cZhtzuU1mFU3h8crJoG2N5lMHBbVZO9ZeAlSUVwpHl3/3vyDHKptzgGUmEK2zww8qO2+Tt8T
	p1A6BElYCyE/rQGh8CFdqm8d+mXeXwEw2TQSUgKgCYJItEDbuxqHySWyuAkWgCQCYZHR6ECXvgo
	95Y/OvPifBwk9Dac/ZULEOnA2Ri+cGPUDXIJXR+ROqLz5vS+jYflgwtahBRI7J5T0=
X-Received: by 2002:ac2:514c:0:b0:510:527:631f with SMTP id q12-20020ac2514c000000b005100527631fmr636853lfd.84.1706016901725;
        Tue, 23 Jan 2024 05:35:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1w380VW6lKfPtMuzJDKCrsa+PmueCUzs84mTO9nKXv1J+XTP9BVvagcS+kTMajoitIOLadRqeeXEPBp+u0+g=
X-Received: by 2002:ac2:514c:0:b0:510:527:631f with SMTP id
 q12-20020ac2514c000000b005100527631fmr636846lfd.84.1706016901420; Tue, 23 Jan
 2024 05:35:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122093326.7618-1-sinthu.raja@ti.com> <5e7f5cf2e13e36d9ad4b1d4c546c6f596c2dc8f6.camel@redhat.com>
In-Reply-To: <5e7f5cf2e13e36d9ad4b1d4c546c6f596c2dc8f6.camel@redhat.com>
From: Sinthu Raja M <sinthu.raja@mistralsolutions.com>
Date: Tue, 23 Jan 2024 19:04:49 +0530
Message-ID: <CAEd-yTRWUyED0aab9yfup7CBaX9ekJYpWf9W57u0x+PRV6JNGA@mail.gmail.com>
Subject: Re: [PATCH V2] net: ethernet: ti: cpsw_new: enable mac_managed_pm to
 fix mdio
To: Paolo Abeni <pabeni@redhat.com>
Cc: Denis Kirjanov <dkirjanov@suse.de>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>, linux-omap@vger.kernel.org, 
	netdev@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BESS-ID: 1706016901-305614-12421-1818-1
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 209.85.167.71
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaWZhZAVgZQ0MAg0Sw1zSQx1S
	zJyMLC0jQt2Tw5MdEg2czAJC3J2MJEqTYWAEqoWrRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253703 [from 
	cloudscan11-151.eu-central-1a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

On Tue, Jan 23, 2024 at 6:13=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Mon, 2024-01-22 at 15:03 +0530, Sinthu Raja wrote:
> > From: Sinthu Raja <sinthu.raja@ti.com>
>
> Please respect the 24h grace period before posting a new version:
>
> https://linkprotect.cudasvc.com/url?a=3Dhttps%3a%2f%2felixir.bootlin.com%=
2flinux%2flatest%2fsource%2fDocumentation%2fprocess%2fmaintainer-netdev.rst=
%23L399&c=3DE,1,NjWZnS_W5KYuQampSneJ5dh5x0uA13rTVQCXH1ka9fcz6_gt5qqQqy8nFt1=
bkXrtBPCbPgvmb2aoYD7elUmB6B3NBMuMochpC4P4ihN9CXTTm5hpP9gZ&typo=3D1
>
> Also please keep a consistent revision numbering scheme. This v2
> apparently come after v3 ?!?
My bad, it was a typo error in the subject line, the previous version
was supposed to be V1 and the next version will be V3. I believe it is
fine to post the next version as V3.

>
> > The below commit  introduced a WARN when phy state is not in the states=
:
> > PHY_HALTED, PHY_READY and PHY_UP.
> > commit 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resum=
e() state")
> >
> > When cpsw_new resumes, there have port in PHY_NOLINK state, so the belo=
w
> > warning comes out. Set mac_managed_pm be true to tell mdio that the phy
> > resume/suspend is managed by the mac, to fix the following warning:
> >
> > WARNING: CPU: 0 PID: 965 at drivers/net/phy/phy_device.c:326 mdio_bus_p=
hy_resume+0x140/0x144
> > CPU: 0 PID: 965 Comm: sh Tainted: G           O       6.1.46-g247b2535b=
2 #1
> > Hardware name: Generic AM33XX (Flattened Device Tree)
> >  unwind_backtrace from show_stack+0x18/0x1c
> >  show_stack from dump_stack_lvl+0x24/0x2c
> >  dump_stack_lvl from __warn+0x84/0x15c
> >  __warn from warn_slowpath_fmt+0x1a8/0x1c8
> >  warn_slowpath_fmt from mdio_bus_phy_resume+0x140/0x144
> >  mdio_bus_phy_resume from dpm_run_callback+0x3c/0x140
> >  dpm_run_callback from device_resume+0xb8/0x2b8
> >  device_resume from dpm_resume+0x144/0x314
> >  dpm_resume from dpm_resume_end+0x14/0x20
> >  dpm_resume_end from suspend_devices_and_enter+0xd0/0x924
> >  suspend_devices_and_enter from pm_suspend+0x2e0/0x33c
> >  pm_suspend from state_store+0x74/0xd0
> >  state_store from kernfs_fop_write_iter+0x104/0x1ec
> >  kernfs_fop_write_iter from vfs_write+0x1b8/0x358
> >  vfs_write from ksys_write+0x78/0xf8
> >  ksys_write from ret_fast_syscall+0x0/0x54
> > Exception stack(0xe094dfa8 to 0xe094dff0)
> > dfa0:                   00000004 005c3fb8 00000001 005c3fb8 00000004 00=
000001
> > dfc0: 00000004 005c3fb8 b6f6bba0 00000004 00000004 0059edb8 00000000 00=
000000
> > dfe0: 00000004 bed918f0 b6f09bd3 b6e89a66
> >
> > Fixes: 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resum=
e() state")
>
> I think the real issue was introduced somewhere else in the TI driver.
> The above commit just report the inconsistent state.
>
> Note that you probably will a small series of 2 separate patches to
> address the issue bot in cpsw_new.c and cpsw.c, as mentioned by Roger.
>
> Cheers,
>
> Paolo
>


--
With Regards
Sinthu Raja

