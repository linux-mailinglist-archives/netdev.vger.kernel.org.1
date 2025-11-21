Return-Path: <netdev+bounces-240892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8F3C7BC87
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 22:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9736C4E063E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 21:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4CF13A3F7;
	Fri, 21 Nov 2025 21:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fuzy.me header.i=@fuzy.me header.b="HV/DljPp"
X-Original-To: netdev@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47C336D505
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 21:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763761669; cv=none; b=p7N+JxWSSbgPHPUjtu0a2O6tkTueOknl9eUDGCaJuSPi6ImzzkeAipedQ4WhIygARRzvk5U4je4m1TKqhuMKsM+OF26ZRPX8HhLMfQZF8qf/d7cEm+SLGD/YqXLrbVlnmEsb9QgKZ0qQJEeS4zD1vnXjo8XGKqzFZjAEUz+2sJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763761669; c=relaxed/simple;
	bh=vlpFereIj9/6J6gcKu+uHWd+LyMQRH0c59bHkwUKZWE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fNTONWYoDsXS+4Z1mAO70hZi8fUXLTGi2vAQZyrEoxwjQ0aXcJCFHPsZiDlQ8UlVBxcRLV/rB0m6cW6/VtqbR9w2ZDH3YqLJFaKKY0jZ7d56e4nW35v4hR6nspBH67Y1N4mdlAX14tgQQkMq9pYmLT3UOkgcodK9lSb6bNfFros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fuzy.me; spf=pass smtp.mailfrom=fuzy.me; dkim=pass (2048-bit key) header.d=fuzy.me header.i=@fuzy.me header.b=HV/DljPp; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fuzy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fuzy.me
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 30AE65895B8
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 04:26:21 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9293442EA
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 04:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fuzy.me; s=gm1;
	t=1763699173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9X6+K14lYjjO+0Tm6fxshl1S7qAwXANfjhN/ihHqnEI=;
	b=HV/DljPpd0E2rPSXqabXqjMBN8ROEskJRc02GyGg8XLDMnKW94z5DMJlZHOwLe2Mch2ooI
	+MLF1v+1NTSUOPzxgOfIUnedEmkTzlbb8lAt4K4pOm13wk7e6tI+H+j73z6ngifC72md1N
	7ORsoN4uDVCgP0cmFQAvW4MQ4iUHDYqaezjLsYwohGadZnMfuQuurobhdlN4comzUdK/j5
	0VUlbRxFqpXV81NDn53jUpjk1e3Ro8YrUj+xfSKtolLL1wCT6S5vmubLES0y1V5ztCfSyb
	+zNGciy8L0pJAW1gkeMOWOC3QzBSvB4HTjKP+7ZUoB4Zgkv+r2awqhezdIFWPA==
From: Zhengyi Fu <i@fuzy.me>
To: netdev@vger.kernel.org
Subject: [BUG] iproute2 - ip -d -j tuntap outputs malformed JSON
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 21 Nov 2025 12:25:41 +0800
Message-ID: <87jyzkvwoq.fsf@fuzy.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdeltddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufgffffkgggtgfesthhqredttderjeenucfhrhhomhepkghhvghnghihihcuhfhuuceoihesfhhuiiihrdhmvgeqnecuggftrfgrthhtvghrnhepgefgjefggfevvdfhvefgveetiefffeehheehtefggfehvdegieeiieehgfeutdfhnecukfhppeduledvrdehiedrleelrdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelvddrheeirdelledrjedphhgvlhhopehtieeitdhjrghmvghspdhmrghilhhfrhhomhepihesfhhuiiihrdhmvgdpnhgspghrtghpthhtohepuddprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: id@fuzy.me

Hi iproute2 maintainers,

    $ sudo ip -d -j tuntap
    [{"ifname":"tun0","flags":["tun","persist"],"processes":["name":"ssh","=
pid":86812]}]

The =E2=80=9Cprocesses=E2=80=9D value looks like it should be an array of o=
bjects, so
the inner braces seem to be missing:

    [{"ifname":"tun0","flags":["tun","persist"],"processes":[{"name":"ssh",=
"pid":86812}]}]

Could you confirm whether this is a formatting bug or if the output is
intentionally flattened?

Thanks!

