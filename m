Return-Path: <netdev+bounces-193395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0664AC3C5E
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076AD1892203
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724EE1E51EA;
	Mon, 26 May 2025 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="UuhNRbFu"
X-Original-To: netdev@vger.kernel.org
Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [178.154.239.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14641F09BD
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748250453; cv=none; b=MO0+BxbMJRqXz3QJl8VyZJEG0tJvUMbwtiBKEOjNHStqSdP+uX1J66J6233SBNYoWoE+hc4bhNzWRfrEYDt+d3ovUO2ahBnNe+mfenh64ifLTewoVHZyARNH3EQ71Gyyntr3yDrlfRObEKilQculaQ1YBPlxKq25LbrgJif9y3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748250453; c=relaxed/simple;
	bh=ycQ+lOIJ79Z7JT+FWACl4MSQvUOdy7Y52TArxqIOXtE=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=jxmQ4+OypZb4q9TQbezGNwSGKoyRm0PUZC7EpBtlQZAD3KJN4qKK5kWG9i+W1sonSiZz/DqK5WnbpnR6PtkEfmtKdGDPOKZe2CwVLOU7Pdd4Gw3Wzib7nDKkRzEl7LioPC2sXhznozuZPW8CU65jEsjQCuNpQGVVW8+j3DfCzMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=UuhNRbFu; arc=none smtp.client-ip=178.154.239.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward203b.mail.yandex.net (Yandex) with ESMTPS id C85656395B
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 12:02:11 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c28:7d5:0:640:285a:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 5C88160BFA
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 12:02:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 22PYFHkLjiE0-BIhlT0vK;
	Mon, 26 May 2025 12:02:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1748250123; bh=ycQ+lOIJ79Z7JT+FWACl4MSQvUOdy7Y52TArxqIOXtE=;
	h=Date:To:From:Subject:Message-ID;
	b=UuhNRbFuxdajxZKAvi+bHiksGvNR38RTpLJ4wACfkH57XYvtvyCTjBNAFE1cH1JvD
	 8jOFCebStUGD+gLQaFjeoiGfXxq20eRLHrrupk3EVXy0CHpZvnrOz2h+jMbaPQKZtp
	 sx5y8kpOSTfu5rl4vntlq9c1ibma9qaa1JxI8m5g=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <985e79fa5c4ea841cb361458cdcf0114050bfb62.camel@yandex.ru>
Subject: Does "TCP Fast Open": not work on 6.14.7?
From: Konstantin Kharlamov <Hi-Angel@yandex.ru>
To: netdev@vger.kernel.org
Date: Mon, 26 May 2025 12:02:02 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello, I may be missing something, but something seems off.

`/proc/net/netstat` contains TCP Fast Open counters. They are
undocumented, but `networking/snmp_counter.rst` says for
`TcpExtTCPFastOpenPassive` it's amount of times fast open connection
was made, which I presume pertains to `TCPFastOpenPassive` as well.

So, I

1. Have set `net.ipv4.tcp_fastopen =3D 3` (enables it for both incoming
and outgoing connections).
2. Launch "server" `nc -vkl 8080`
3. Connect to it with `nc -v localhost 8080`
4. Check "fast open" counters via `cat /proc/net/netstat | column -t |
less -Si`

Expected: at least some of the counters increased.
Actual: every "fast open" counter is 0 (zero).

That is on Archlinux, kernel 6.14.7. WDYDW?

P.S. pls keep me in CC, i'm not subscribed.
P.P.S. slightly offtopic, but am I correct to understand one-liners
like `cat =E2=80=A6 | column =E2=80=A6` are the only way to read these coun=
ters? I've
searched far and wide, and from what I understand none of networking
utilities (at least not ss, netstat, ntstat) show them.

