Return-Path: <netdev+bounces-168903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD5BA41612
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 08:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5F43A4D63
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 07:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB461C863D;
	Mon, 24 Feb 2025 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="APteWDir"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3032C155747;
	Mon, 24 Feb 2025 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740381358; cv=none; b=Q40UC5GDcPAExt9zCJxA9XqXJjW7sQiuIRbURkF0nNNbSjbBfFsihrgQ8lOCp/yLrhxKz9yEG99MUG/PnQfQHly11wImUh++IHFW3FDdWxzKvf8y+LHMNB/DQeBpZpAO8qhxXzMla2rGNJByzEdWLA+bJdWqUbcG6qvmuP1pFGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740381358; c=relaxed/simple;
	bh=LA91jSsheMxR4yC/e7jbT3VZ1jyx/nEH3cVwjan9ivs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=q666mwewvLixZAJ7KQAMhzfuxNOWyWFJezyDFg96Hh0kKxVHiopG211wJbudKM0C+U9zamUbkG/qWs0/OfJk5dy9hrzmRgBXnbbLQ6pyqvxFyFAHEp79tA8HwM+x9ktnys0t8mwdKAex8ZJLjMDjg6+IXt6S6Y6IQV3+XSw/7Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=APteWDir; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=APteWDir;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10de:2e00:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 51O7DMHp962698
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 07:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1740381202; bh=Qo7e4pHJOv6pCynpF4eYP+eH0PAvvJnROAiF5yvl18E=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=APteWDira/AXiyCs1XJGdVNQe0uORaD7fKVMZsPgRho24EY8j0hRfDA9xKEhWdcCd
	 Pt13IlQACmkp6BeE++HlBME+psh/mEZ/TX/uyw6UWFwEik6KyHkdCAqq+8jz6jVHhL
	 j9IWqvAACBD658BiBsuIlePq50N5Z27/l2raZw5I=
Received: from miraculix.mork.no ([IPv6:2a01:799:10de:2e0a:149a:2079:3a3a:3457])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 51O7DMxE2373751
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 08:13:22 +0100
Received: (nullmailer pid 997267 invoked by uid 1000);
	Mon, 24 Feb 2025 07:13:22 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?utf-8?Q?K=C3=B6ry?= Maincent <kory.maincent@bootlin.com>,
        Simon Horman <horms@kernel.org>,
        Romain Gantois <romain.gantois@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Organization: m
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
	<87r03otsmm.fsf@miraculix.mork.no>
	<Z7uFhc1EiPpWHGfa@shell.armlinux.org.uk>
	<3c6b7b3f-04a2-48ce-b3a9-2ea71041c6d2@lunn.ch>
Date: Mon, 24 Feb 2025 08:13:22 +0100
In-Reply-To: <3c6b7b3f-04a2-48ce-b3a9-2ea71041c6d2@lunn.ch> (Andrew Lunn's
	message of "Mon, 24 Feb 2025 04:32:29 +0100")
Message-ID: <87ikozu86l.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.7 at canardo.mork.no
X-Virus-Status: Clean

Andrew Lunn <andrew@lunn.ch> writes:

>> So, not only do I think that hwmon should be disabled if using SMBus,
>> but I also think that the kernel should print a warning that SMBus is
>> being used and therefore e.g. copper modules will be unreliable. We
>> don't know how the various firmwares in various microprocessors that
>> convert I2C to MDIO will behave when faced with SMBus transfers.
>
> I agree, hwmon should be disabled, and that the kernel should printing
> a warning that the hardware is broken and that networking is not
> guaranteed to be reliable.

What do you think will be the effect of such a warning?  Who is the
target audience?

You can obviously add it, and I don't really care.  But I believe the
result will be an endless stream of end users worrying about this scary
warning and wanting to know what they can do about it.  What will be
your answer?

No SoC/phy designer will ever see the warning.  They finished designing
these chips decades ago.  The switch designers might see it. But
probably not. They're not worried about running mainline Linux at all.
They have they're vendor SDK.  Linux based of course, but it's never
going to have that warning no matter what you do.  Firmware developers?
Same as switch designers really.

The hardware exists. It's not perfect. We agree so far.  But I do not
understand your way of dealing with that.

If your intention is detecting this hardware problem in bug reports etc,
then it makes more sense to me.  But I believe a more subtle method will
be more effeicient than a standalone and scary warning. Like embedding
"smbus" or similar in existing debug/warning/error messages, e.g by
making it part of the mdio bus name.


Bj=C3=B8rn

