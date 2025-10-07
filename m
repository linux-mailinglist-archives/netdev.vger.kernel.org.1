Return-Path: <netdev+bounces-228090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61653BC13D7
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 13:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976273BB264
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 11:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F2A2D9EC2;
	Tue,  7 Oct 2025 11:38:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F0F2D94A0;
	Tue,  7 Oct 2025 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759837129; cv=none; b=my8Aikm5CG9iKIW3f8iBvgVkM3hUqLJjmpTP8N6osZh6n6nDH0oluocMoIkXKUGl5C/bhpBJbalu2CWzg2MPndu09jW4QhCr+bYzsiTiMhYywOY0yv0x+nluK2CyhcA1t1mDiFi7HjFSTeTzC/jIZUGcItFs39Vm8yYkCry7BYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759837129; c=relaxed/simple;
	bh=1URF72m1lATigHhO2pMVHKHVaVTWDTZD1ODkXoQBR7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZwJsaXyrHj8eyEHEDaFsAOXlKLabjM3NutNjoPuWLN2axsDrtnRleaRfKArMCQFptUk5hg/eF6BDt6KxjrlLb3Inc9YKzS6zG5AXmVMGR0VvE73OGIuliGsYJAej4Ur/V9X2/6FNRZseauEa8NEtQtT8OBkTspB7wBjmGLIH/r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id E8F32C3EEAC9;
	Tue,  7 Oct 2025 13:38:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl E8F32C3EEAC9
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kriish Sharma <kriish.sharma2006@gmail.com>,  khc@pm.waw.pl,
  andrew+netdev@lunn.ch,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
In-Reply-To: <71dda358-c1f7-46ab-a241-dffc3c1c065d@redhat.com> (Paolo Abeni's
	message of "Tue, 7 Oct 2025 12:46:02 +0200")
References: <20251002180541.1375151-1-kriish.sharma2006@gmail.com>
	<m3o6qotrxi.fsf@t19.piap.pl>
	<CAL4kbROGfCnLhYLCptND6Ni2PGJfgZzM+2kjtBhVcvy3jLHtfQ@mail.gmail.com>
	<d8fb2384-66bb-473a-a020-1bd816b5766c@redhat.com>
	<m37bx7t604.fsf@t19.piap.pl>
	<71dda358-c1f7-46ab-a241-dffc3c1c065d@redhat.com>
Sender: khalasa@piap.pl
Date: Tue, 07 Oct 2025 13:38:42 +0200
Message-ID: <m3347vszzx.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> writes:

> Note that the suggested change is not going to change any semantic, just
> make it clear for future changes that such case is not really
> expected.

But there is no "other case", any numeric argument this function is
called with is expected. This is not a hdlc-ppp-wide function. Such
a function was simply not needed. That the function returned NULL in an
impossible case is just, I guess, my coding deficiency. Not my worst,
though :-)

Would you rather like #define proto_name(x) ((x) =3D=3D PID_LCP ? "LCP" : (=
x)
=3D=3D PID_IPCP ? "IPCP" : "IPV6CP")? Or maybe you would like the "unknown"
case there as well?

This function is for only those 3 protocols, all of them being "control
protocols": IP control protocol, IPv6 control protocol, and link control
protocol. Think of it as of

enum control_protocols {LCP, IP, IPV6};

proto_name(enum control_protocols)
...

You must not call this function in any other context, e.g. it's not OK
to call it with PID_IP nor PID_IPV6 (which are otherwise perfectly valid
PIDs in this very file).

If the function's name is misleading, perhaps it could be extended to
control_proto_name(). Not that I find such changes entertaining, but it
would be technically correct after all.

HTH,
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa

