Return-Path: <netdev+bounces-160962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5187A1C77C
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 12:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3D316684A
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 11:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4042C7603F;
	Sun, 26 Jan 2025 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="lyWo9VV6"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C999B524B0;
	Sun, 26 Jan 2025 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737890429; cv=none; b=WsGMNV/TvuwIacyv8jtA9nynzUQmi8psfM5Y3tbU4D0ckIPrzgUCxs2ZrsuvCB5+jYiqpL2F+VOH8JwSgk5yc1AAewneOznC99iwepxkoL9V1CqooSoGEx7dZKeQfrsG9NvYgVJi1pUxUUln+IWGg0sk2krDhFENOvwQ07rl+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737890429; c=relaxed/simple;
	bh=8kQE/V6VpQ7199P66+4X8sY8WCLa+Kp9JKxZUSIjdCI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ty+eyIIE842zvFurgo1EfE6dduc0Kp9utF124CP06GJOmTdQQWXZuBPaL95mLqeBE9RByv+2Z0c8y8wgchpbSel+ltyK1rC7/pVjgQtF+cFS68c4z7K9hD2OVi2hp7X29VtB83OqlWJoJlF0SvZUr/9NVjF0iNCktF6A9V25TO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=lyWo9VV6; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=lyWo9VV6;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10de:2e00:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 50QBJcC3994221
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 26 Jan 2025 11:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1737890378; bh=wFgJq6MyvblYh2GqzxyYIpNdji5daNI8RFGAvmVGv80=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=lyWo9VV6+MnxutqYfDALp7DeQlkWba/Lk5Qe8j1V3eBO0ezhutJ15lIXCnWCPnVwd
	 jZigy/QnNSLCDyQGKX3Z2FVQ5hklwnpJhnYeo+vUvB/Fndm7tqZIqe88dV5dtoafSi
	 pGk6f8Ev6/wsNuaQRl3EiJXtnbxA45zuisIkA2dI=
Received: from miraculix.mork.no ([IPv6:2a01:799:10de:2e0a:149a:2079:3a3a:3457])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 50QBJc5Z3125914
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 26 Jan 2025 12:19:38 +0100
Received: (nullmailer pid 1570054 invoked by uid 1000);
	Sun, 26 Jan 2025 11:19:38 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Foster Snowhill <forst@pen.gy>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Georgi Valkov <gvalkov@gmail.com>,
        Simon Horman <horms@kernel.org>, Oliver Neukum <oneukum@suse.com>,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH net v5 0/7] usbnet: ipheth: prevent OoB reads of NDP16
Organization: m
References: <20250125235409.3106594-1-forst@pen.gy>
Date: Sun, 26 Jan 2025 12:19:38 +0100
In-Reply-To: <20250125235409.3106594-1-forst@pen.gy> (Foster Snowhill's
	message of "Sun, 26 Jan 2025 00:54:02 +0100")
Message-ID: <87r04pzut1.fsf@miraculix.mork.no>
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

Foster Snowhill <forst@pen.gy> writes:

> As the regular tethering implementation of iOS devices isn't compliant
> with CDC NCM, it's not possible to use the `cdc_ncm` driver to handle
> this functionality. Furthermore, while the logic required to properly
> parse URBs with NCM-encapsulated frames is already part of said driver,
> I haven't found a nice way to reuse the existing code without messing
> with the `cdc_ncm` driver itself.

Sorry for taking this up at such a late stage, and it might already been
discussed, but I'm not convinced that you shouldn't "mess" with the
`cdc_ncm` driver.  We did a lot of that when prepping it for cdc_mbim
reuse. Some of it, like supporting multiple NDPs, is completely useless
for NCM.  We still added code to cdc_ncm just to be able to share it
with cdc_mbim. I think the generalized solutions still adds value to
cdc_ncm by making the shared code targeted by more developers and users.

And the huawei_cdc_ncm driver demonstrates that cdc_ncm can be reused
for non-compliant vendor-specific protocols, so that's not a real
problem.

I don't really see the assymmetric TX/RX protocols as a big problem
either.  Reusing only the RX code from cdc_ncm should be fine.

What I can understand is that you don't want to build on the current
cdc_ncm code because you don't like the implementation and want to
improve it.  But this is also the main reason why I think code sharing
would be good.  The cdc_ncm code could certainly do with more developers
looking at it and improving stuff.  Like any other drivers, really.

Yes, I know I'm saying this much too late for code that's ready for
merging.  And, of course, I don't expect you to start all over at this
point. I just wanted to comment on that "messing with" because it's so
wrong, and I remember feeling that way too.  Messing with existing code
is never a problem in Linux!  Existing code and (internal) interfaces
can always be changed to accommodate whatever needs you have.  This is
one of may ways the Linux development model wins over everything else.


Bj=C3=B8rn



