Return-Path: <netdev+bounces-161394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49928A20E9F
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 17:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B54217A2FCA
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8058C1DE2CB;
	Tue, 28 Jan 2025 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xyen8+KX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6768199E8D;
	Tue, 28 Jan 2025 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738081943; cv=none; b=d1C1kdUdHB98N0nx6PgBfKIT6FdCZ4o2bybY6+a2B+Wet4e2Ru+WvEuf/LZSe90E7bO/dW31s8Ataj14DAzlDpQGTdp2390MkhwT37q/DvATfc+R9Cqo84hdGFdTX0InyHGfwkGk1ClMLbK3CwYXKhOCbMBBYZal6mFSV6CBmdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738081943; c=relaxed/simple;
	bh=JKPRQNGo6c05mOEmhP70KvkTAwaDPBWMaGDQBYo3ZRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXquVtfsAWMn1zxOzV/1kgbFCGJ0CcfG2/geQXHkBJ2ZbDIZLwagb3bkTLOQz/Il3NJBkMikphZCmB9GrcdjQmT5epZBj8hCvT9HHChZ3Ldej8E3H8cl4AW2CfXIj+GzaxUXDFI70d/6irZ5eUjYfzUpBp457vg6yxjlxeNx4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xyen8+KX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43616bf3358so9301045e9.3;
        Tue, 28 Jan 2025 08:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738081939; x=1738686739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SbISzZ/bYtDhpiUav/h8xTZnz5VMDjY6HJC4K2tyU3o=;
        b=Xyen8+KXDrNuxt28vng1g2G7zmqTY6r143wy59PtWskNlSJzvw6o+tisvSRG0W4L7K
         7bWl6lEb7UWR8QwYxEvyAQlw/p9a57o9DUvUL176liPX+6HXrloDPO2BOZ3zqbIfw5U2
         jHObk8E+6cQl5bL9P+/Wz1JydBt8SYwzygMqDXWf9kvsl4NFsAhva++2tJKU78cl0Vkx
         0EursLtHE2znm1BcM7WBzkcVOCfUwLmogA5BhJybmN3jtBlQSFV6sSNFDv4sewMXPavS
         ToGC7S7904FPsrxVnrzMm+gDJSgrAmNrnkW+U+euvXsyB+IPTQv1v1Ygk1Qf9VE+xrRe
         0E4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738081939; x=1738686739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbISzZ/bYtDhpiUav/h8xTZnz5VMDjY6HJC4K2tyU3o=;
        b=LqmrEJHE5/De50eBES0LP4AcZRSdCZ2HXN3N0/0/cbFQeSkP8Z0Y3hMV+wxec11i1P
         RFYcgHcIbJXmIRuvjN7jLssp34T86hoazD/ldys/IbcUMKDiJiVV10HM3Ef2Eqwmi/UQ
         u5UnRLp3CrPuq0j6Ysx+QLJPBSlMOyoNLjCM88uGodQj3dVtN8wxZlgBB3hfEltIRp9h
         ntsCa3h1BJbKPGkTOdeKpbJHtFOrNys2P2mBD3coDRqRXg/G/UYyHWBmA8o7xZ/40V7V
         MtH2b0wVah6bzZkUlSL08CsZbXipckuEUAiwky3rMn/MX95XXFLIDoTGy3kjSsthL4Yw
         FxaA==
X-Forwarded-Encrypted: i=1; AJvYcCVRb7dgLZvCc104Hq0mNTLor9L0vfv10NWL1KqmS7pAsmgOwghZ/qjpWjTREdmcKnQFfAccnjUS@vger.kernel.org, AJvYcCXbzNe+noflVo02zeSnGAWl6/+8XfEk/E0EPMedW1xp1+70oERft3SsQYaGF2v7krhePP35S8h5KAOzgCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5rSaGS0LC1VQVtTfulhmmeiIYwJmf/Vm3uej8fzsB55YJTuJP
	sUK90/8vHcbE+UcIMvzIeI8EqS9V4qgQMrVv8zeGbXENFhfuUSjO
X-Gm-Gg: ASbGncub1oGUVdxJ1uTJXx+gvAEqXoENTg+uLKdc8mBmRK+EnKxtvj7yeTynpyiaZtJ
	DAtzMifw/LH7weWqBW47wG6ciBjzbmMuhh0BE+GcHXS3U9wfz/r6iLNb6UCOySDHoDgjYboMBPG
	2LHjcqNE0o9sh7F78SQFdROedXgAmyJxrNk9jnja57EPn2ai6hSuWx7RIec2RbHKt/FAP/57A5Z
	HYK9BbCGRfqUd1kEGzCg4OSFR1lyKvPfcw8jpmlmLyzIelOoO72MgAGVH5e0mhWdXNgnot3kbOU
	aaI=
X-Google-Smtp-Source: AGHT+IFltqlhR556R2ZjnbCvfwmfPzvxxBlkD0aWPYrGciZhaW9rfiS9WTDOkrDeIogbDkCsdRWjwA==
X-Received: by 2002:a05:6000:4582:b0:38c:28d0:7517 with SMTP id ffacd0b85a97d-38c28d0756dmr5142286f8f.6.1738081938778;
        Tue, 28 Jan 2025 08:32:18 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d7a7sm14904105f8f.32.2025.01.28.08.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:32:18 -0800 (PST)
Date: Tue, 28 Jan 2025 18:32:15 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Elliot Ayrey <Elliot.Ayrey@alliedtelesis.co.nz>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netdev@kapio-technology.com" <netdev@kapio-technology.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Fix switchdev error code
Message-ID: <20250128163215.4yyf6xo5bd6kr6ns@skbuf>
References: <20241217043930.260536-1-elliot.ayrey@alliedtelesis.co.nz>
 <ab85afaf-bd9d-416a-b54c-9c85062f3f3f@lunn.ch>
 <e546520005bfbdb09e66d7b9e823af1da796aae6.camel@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e546520005bfbdb09e66d7b9e823af1da796aae6.camel@alliedtelesis.co.nz>

On Sun, Jan 26, 2025 at 10:07:26PM +0000, Elliot Ayrey wrote:
> On Tue, 2024-12-17 at 10:54 +0100, Andrew Lunn wrote:
> > I just had a quick look at other users of call_switchdev_notifiers()
> > and all but vxlan_core.c and this one discarded the return
> > value. Would that be a better fix, making the code more uniform?
> > 
> > 	Andrew
> 
> Hi Andrew, I am hesitant to remove this error as it was very helpful
> during development and helped to diagnose some subtle issues that would
> have otherwise been very hard to notice.

Can you give more details about how you encountered this issue?
One could similarly argue that a call_switchdev_notifiers() error was
ignored until now, and maybe the system still did something reasonable
and thus, properly handling the error now risks introducing a regression
for them. No way to really know except if the commit author (you) makes
a reasonable analysis in the commit message leading to the conclusion
that the patch is worthy of backporting to stable kernels (i.e. fixes a
user-visible incorrect behavior).

