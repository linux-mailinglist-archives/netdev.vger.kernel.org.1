Return-Path: <netdev+bounces-87105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33A88A1CE9
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 19:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B039B31C73
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 17:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D044736AEF;
	Thu, 11 Apr 2024 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b="WW+IU5wx"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nohats.ca (mx.nohats.ca [193.110.157.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61EE175B6
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852454; cv=none; b=RWM8LyG+1SReZHab+8dYhQT3/ykkrvdTE2038pAAnZ8xruwqBXOSrf4WGNyGtMhKwi9C0t7jvrSWuQMoxxkR+6iK9GWrzJV0FaSLRxpk//0e6obkONoFxDH9HhT3uAr6mz1bTN2dPzdpAZQY1usvZdRLJPC/Z6IN5Id3ajUlJuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852454; c=relaxed/simple;
	bh=9A5Kt3JaTTlB0W+Lqgm6RYMLUuSleRo2gV2nVdIewr4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=gAIKU41/4+1MSavPL/Cl4iEpVr7VjB+xFm/aGQ1rMO00BVIGvfx2Ixqmjo59L8RR9nlomyqlr3yXSFwHTvVBWONGRjhS4UC5xxfuCUQCV+LHgOS75d2lYzvU4NaWJeaPJfpXCc4o/B5TX4+MEviV35QZzrUt3WLp5yztgLMrwCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nohats.ca; spf=fail smtp.mailfrom=nohats.ca; dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b=WW+IU5wx; arc=none smtp.client-ip=193.110.157.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nohats.ca
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nohats.ca
Received: from localhost (localhost [IPv6:::1])
	by mx.nohats.ca (Postfix) with ESMTP id 4VFlL35BxLz3Qn;
	Thu, 11 Apr 2024 18:20:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nohats.ca;
	s=default; t=1712852443;
	bh=9A5Kt3JaTTlB0W+Lqgm6RYMLUuSleRo2gV2nVdIewr4=;
	h=From:Subject:Date:References:Cc:In-Reply-To:To;
	b=WW+IU5wxQVgC6MnP4xmcdWIb44SRTqxmmtjgK1xBMk3ks9BvJUvyuukHKzihttfhF
	 cOD9n6dj8MWElbAAVuCuJP1S2CczRL4lBcJm6KFP0LB5Z+XmpWDF2ozdiLeepFDaxR
	 pludsSc9sdAFi9x8OfwPqKUNYQT+Kvjyem+ehnCE=
X-Virus-Scanned: amavisd-new at mx.nohats.ca
X-Spam-Flag: NO
X-Spam-Score: 0.566
X-Spam-Level:
Received: from mx.nohats.ca ([IPv6:::1])
	by localhost (mx.nohats.ca [IPv6:::1]) (amavisd-new, port 10024)
	with ESMTP id wwQ2xJoDFpWx; Thu, 11 Apr 2024 18:20:42 +0200 (CEST)
Received: from bofh.nohats.ca (bofh.nohats.ca [193.110.157.194])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.nohats.ca (Postfix) with ESMTPS;
	Thu, 11 Apr 2024 18:20:42 +0200 (CEST)
Received: from smtpclient.apple (unknown [193.110.157.208])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by bofh.nohats.ca (Postfix) with ESMTPSA id B834211BF5AA;
	Thu, 11 Apr 2024 12:20:41 -0400 (EDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Paul Wouters <paul@nohats.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [devel-ipsec] [PATCH ipsec-next v10 1/3] xfrm: Add Direction to the SA in or out
Date: Thu, 11 Apr 2024 12:20:31 -0400
Message-Id: <549D487E-8B20-439C-93EB-85E0B3C9A2D7@nohats.ca>
References: <20240411114132.GO4195@unreal>
Cc: Antony Antony <antony.antony@secunet.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, devel@linux-ipsec.org,
 Eyal Birger <eyal.birger@gmail.com>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 Sabrina Dubroca <sd@queasysnail.net>
In-Reply-To: <20240411114132.GO4195@unreal>
To: Leon Romanovsky <leon@kernel.org>
X-Mailer: iPhone Mail (21E236)

On Apr 11, 2024, at 07:41, Leon Romanovsky via Devel <devel@linux-ipsec.org>=
 wrote:
>=20
>=20
> I asked it on one of the previous versions, but why do we need this limita=
tion?
> Update SA is actually add and delete, so if user wants to update
> direction, it should be allowed.

An SA can never change direction without dealing with updated SPIs. Logicall=
y, it makes no sense. Sure, if you treat SA=E2=80=99s as Linux lego bricks t=
hat can be turned into anything, then yeah why not. Why not turn the SA into=
 block device or magic flute?

If you keep to the RFC, an SA is uni directional. More things might apply to=
o, eg the mode (transport vs tunnel) should not change, sequence numbers can=
 only increase, etc.

Paul


