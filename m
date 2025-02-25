Return-Path: <netdev+bounces-169563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE5FA449EC
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF23864ADD
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8994A19CC06;
	Tue, 25 Feb 2025 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="oDlD88+F"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F4D19993B;
	Tue, 25 Feb 2025 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506895; cv=none; b=hGhIUgfrSvx9BUfSjZ0gLUhyar2TW/ujcsVZ5ym2c4G2/XOonC/m9fuMIjttIfbq1XrH0eyHFYfWOKl8GhGd4X6sOzlJyZnAWZKaoq6Kx5S0wo9zlTwgqftqVSB8a1HaeOeLqUoFfkVU6PYJqpD04Gzt4D+wJwmOZTWqMGiqYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506895; c=relaxed/simple;
	bh=wefH7Rpmq54N4YPB2U8jXbjMtX7IaHJ1punDFwYSoxE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MRC2vXpA6DTCc4vKthSoihf1EpwWZNfmcX+aKQD/ijWYnlJksVTzWeIEfq2KMcZjX2X0Yh2QSS3gf10EyRHv99BB5q//amhNsoG60LIXmahUoC4dfiZJwc4JR/eyXhyDsiAv0nj6WuoaVnnejUdQ7vdR43dBWEUTlTFDg9/+UcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=oDlD88+F; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=oDlD88+F;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10de:2e00:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 51PI7fID1055590
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 18:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1740506861; bh=XJFMpaLBtjREdFMRnck4vJ5NSVGA7jW7HlBTjc+VhXU=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=oDlD88+FsB93ZAgzk6Lr3ZECuDwCk9p+FZJ+VjSy9NZ3oezLp85OGFJ+7x6+hZcZb
	 bQTk2o0p6lH09pNpwsY1i//T0LsgUb29tFp5zBGds++qh/5PIIOXF7M2sjv+zqi1uN
	 cooA24KToIp6100WGut3zSE6/LU6JzGZUL19Tyvg=
Received: from miraculix.mork.no ([IPv6:2a01:799:10de:2e0a:149a:2079:3a3a:3457])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 51PI7fao3242724
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 19:07:41 +0100
Received: (nullmailer pid 1167981 invoked by uid 1000);
	Tue, 25 Feb 2025 18:07:41 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
	<Z7tdlaGfVHuaWPaG@shell.armlinux.org.uk>
	<87o6yqrygp.fsf@miraculix.mork.no>
	<Z736uAVe5MqRn7Se@shell.armlinux.org.uk>
Date: Tue, 25 Feb 2025 19:07:41 +0100
In-Reply-To: <Z736uAVe5MqRn7Se@shell.armlinux.org.uk> (Russell King's message
	of "Tue, 25 Feb 2025 17:15:36 +0000")
Message-ID: <87h64hsxsi.fsf@miraculix.mork.no>
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

"Russell King (Oracle)" <linux@armlinux.org.uk> writes:

>> I believe you are reading more into the spec than what's actually there.
>
> So I'm making up the quote above from SFF-8472.  Okay, if that's where
> this discussion is going, I'm done here.

No, not at all.  That was not what I meant.  Please accept my apologies.
This came out wrong. You are absolutely correct about reading the 16bit
diagnostic registers you quoted. I would never doubt that. I have an
extreme respect for you and your knowledge of these standards and the
practical hardware implications.

It was the conclusion that this fact prevents SMBus hosts I wanted to
question.  I still don't see that.  Some SMBus hosts might be able do 2
byte reads.  And if they can't, then I believe they can safely ignore
these registers without being out of spec.  Like the proposed solution.

I'll shut up now, to avoid confusing the discussion of Maxime's patches
further.


Bj=C3=B8rn



