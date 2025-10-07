Return-Path: <netdev+bounces-228075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA21BC0DB9
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 11:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A8918964AD
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 09:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5B2D47F4;
	Tue,  7 Oct 2025 09:29:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36BC154BF5;
	Tue,  7 Oct 2025 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829353; cv=none; b=hlzpDy5Plcp2vSEwfFikvIr8EXHOvc3QvNI5a2lSSuszlcX0gKYUERnsnddTxw9PcHzO/o3QoAHuf6BkRP04Qt8AQad+EvvZg3YVEihOQcrUXoB07rAgnH3AKVtawGZDJAKzYUUXEuJPtbQDCUIBa6VMBmIA7yW+RBKCJH6TvVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829353; c=relaxed/simple;
	bh=fWqIweYDp0uOOqzStY2LwbqOGthMNkDoqqwc9tDtfek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s4mF2xn/yFT16swJ5Dlvdpf9v7u9OOKwgpwJ69yVLMX2e5gZU0Z3ENWnKBFiYpOoAAvtX+ukMuTk4APuXgldRpKvo45b1hrntzcKJCyWmOxI+EdlSLkbIr4ePVIizzf9kmzqKbAYUoDmIFRNR9tugNMe94cAu4H/KbLIIDZHA5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id 5C2EBC3EEACD;
	Tue,  7 Oct 2025 11:28:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 5C2EBC3EEACD
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kriish Sharma <kriish.sharma2006@gmail.com>,  khc@pm.waw.pl,
  andrew+netdev@lunn.ch,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
In-Reply-To: <d8fb2384-66bb-473a-a020-1bd816b5766c@redhat.com> (Paolo Abeni's
	message of "Tue, 7 Oct 2025 10:41:45 +0200")
References: <20251002180541.1375151-1-kriish.sharma2006@gmail.com>
	<m3o6qotrxi.fsf@t19.piap.pl>
	<CAL4kbROGfCnLhYLCptND6Ni2PGJfgZzM+2kjtBhVcvy3jLHtfQ@mail.gmail.com>
	<d8fb2384-66bb-473a-a020-1bd816b5766c@redhat.com>
Sender: khalasa@piap.pl
Date: Tue, 07 Oct 2025 11:28:59 +0200
Message-ID: <m37bx7t604.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paolo,

Paolo Abeni <pabeni@redhat.com> writes:

> If v2 is not ready yet, I think it would be better returning "unknown"
> instead of "LCP" when the protocol id is actually unknown.
>
> In the current code base, such case is unexpected/impossible, but the
> compiler force us to handle it anyway. I think we should avoid hiding
> the unexpected event.
>
> Assuming all the code paths calling proto_name() ensure the pid is a
> valid one, you should possibly add a WARN_ONCE() on the default case.

Look, this is really simple code. Do we need additional bloat
everywhere?

The compiler doesn't force us to anything. We define that, as far as
get_proto() is concerned, PID_IPCP is "IPCP", PID_IPV6CP is "IPV6CP",
and all other values mean "LCP". Then we construct the switch statement
accordingly. Well, it seems I failed it slightly originally, most
probably due to copy & paste from get_proto(). Now Kriish has noticed it
and agreed to make it perfect.

Do you really think we should now change semantics of this 20 years old
code (most probably never working incorrectly), adding some "unknown"
(yet impossible) case, and WARNing about a condition which is excluded
at the start of the whole RX parser?

Well, maybe gcc would identify and remove these new unneeded operations.
Maybe. I think we don't need more bloat at the source level either,
though.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa

