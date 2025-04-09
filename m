Return-Path: <netdev+bounces-180656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7186FA820B4
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3CDA7AF070
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBD625A2D7;
	Wed,  9 Apr 2025 09:07:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8219D156F3C;
	Wed,  9 Apr 2025 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744189640; cv=none; b=oeiul+k9++IZDWvoen67XB/uMVBiuwhGJ8iT38/lKWpOZaFH1X2hZ7t0O7hOoGevCRjWuup0RpwCtnjbrhVxJRb0anK3xPRCHv9aaOeAeO8aRAEe6KWzQQH6/hZfOPTdCa5KL8nKhyyabx61saUH5XPoPQPn2uzQxHk39qLvRQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744189640; c=relaxed/simple;
	bh=7u3xlUo9x5oyreo14yCxLm/kfAQS4T/NFYVqqKxt7No=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PY9uRJzKWrQ7PIgvmWbNxnwTy4SvLD2LFGD6EvE+kpiu96xxa4nzmQqo8xUy0JPC8vkHt1VNWdILbIdhlhkTkHdwHMkXEMzuobSmUJLe8DfMyGHku6gdKUy9Y2z0BUhSCwyi/kJWqpNIXUrBy6DXfGpLhrqr4cBembH+Jg3giOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id 6E259C3F2A52;
	Wed,  9 Apr 2025 11:07:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 6E259C3F2A52
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev <netdev@vger.kernel.org>,  Oliver Neukum <oneukum@suse.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  linux-usb@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Jose Ignacio Tornos Martinez
 <jtornosm@redhat.com>,  Ming Lei <ming.lei@redhat.com>,  Oleksij Rempel
 <o.rempel@pengutronix.de>
Subject: Re: [PATCH REPOST] usbnet: asix: leave the carrier control to phylink
In-Reply-To: <d5e03a72-bff3-4df1-91ed-6916abaaa0ec@redhat.com> (Paolo Abeni's
	message of "Tue, 8 Apr 2025 15:29:14 +0200")
References: <m35xjgdvih.fsf@t19.piap.pl>
	<d5e03a72-bff3-4df1-91ed-6916abaaa0ec@redhat.com>
Sender: khalasa@piap.pl
Date: Wed, 09 Apr 2025 11:07:07 +0200
Message-ID: <m3ecy1d7pg.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> writes:

> Does not build:
>
> ../drivers/net/usb/asix_devices.c:1396:19: error: =E2=80=98asix_status=E2=
=80=99
> undeclared here (not in a function); did you mean =E2=80=98si_status=E2=
=80=99?
>  1396 |         .status =3D asix_status,

Right, thanks - somehow I didn't realize the recent addition in net-next
will break it. Should have been obvious.

Not a factor in v2, though.
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa

