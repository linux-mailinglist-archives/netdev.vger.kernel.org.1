Return-Path: <netdev+bounces-300757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U6sBI3GsNWoG3AYAu9opvQ
	(envelope-from <netdev+bounces-300757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 22:54:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A8F6A7BB3
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 22:54:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300757-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300757-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DF9B302A4C2
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 20:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3353BFE40;
	Fri, 19 Jun 2026 20:54:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D43290DB;
	Fri, 19 Jun 2026 20:54:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902444; cv=none; b=iDZhcPDoJT9qROCE4Acceyfjze/rGWRTE06I0cCQqP6FAaIMC7btMOgJ3IIo7sa7SjWXZnzbZmIfIXm593qmCp/A9DPSPHfP0srz876lGt676AacZ3ydcReqK6ppUkxmj55Nq96ZAbTxIy5uKbZLgQPZHu5tNRz4D0gI44J3OF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902444; c=relaxed/simple;
	bh=wsKYov9ueDn1RiY/wif6+y1wha8dgovGnU5G9dpRfQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hm+SIZ/k+ukw9GRFsaI8i9qIsfoU3DcADI9f3TInIfJ5Bnpteh+tpaMCVeJMebHgA7daa+9rgxVwOijK3ASafOrr5BbcS/nrVw3LNkz/4PBtkXCuk2W/pUBrw1eVCdCosG9HolodgKvvDvHNJjsChOFoWSdvW1lmQHvQI5Y32v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; arc=none smtp.client-ip=78.47.171.185
Received: from work.datenfreihafen.local (unknown [46.253.254.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@sostec.de)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 04A05C0A83;
	Fri, 19 Jun 2026 22:54:00 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
To: syzkaller-bugs@googlegroups.com,
	Alexander Aring <alex.aring@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-wpan@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	syzbot <syzbot@kernel.org>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot@lists.linux.dev
Subject: Re: [PATCH] ieee802154: fix kernel-infoleak in dgram_recvmsg()
Date: Fri, 19 Jun 2026 22:53:55 +0200
Message-ID: <178190240273.821068.5734846071151495833.b4-ty@datenfreihafen.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <62795fd9-fc0c-48eb-bb82-05ffc5a57104@mail.kernel.org>
References: <62795fd9-fc0c-48eb-bb82-05ffc5a57104@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300757-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[datenfreihafen.org];
	FORGED_RECIPIENTS(0.00)[m:syzkaller-bugs@googlegroups.com,m:alex.aring@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-wpan@vger.kernel.org,m:miquel.raynal@bootlin.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzbot@kernel.org,m:stefan@datenfreihafen.org,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot@lists.linux.dev,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[stefan@datenfreihafen.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[googlegroups.com,gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org,bootlin.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,tor.lore.kernel.org:server fail,datenfreihafen.org:server fail];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefan@datenfreihafen.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,datenfreihafen.org:mid,datenfreihafen.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8A8F6A7BB3

Hello syzbot.

On Wed, 27 May 2026 20:18:18 +0000, syzbot wrote:
> KMSAN reported a kernel-infoleak in move_addr_to_user():
> 
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user
> include/linux/instrumented.h:131 [inline]
> BUG: KMSAN: kernel-infoleak in _inline_copy_to_user
> include/linux/uaccess.h:205 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_user+0xcc/0x120
> lib/usercopy.c:26
>  instrument_copy_to_user include/linux/instrumented.h:131 [inline]
>  _inline_copy_to_user include/linux/uaccess.h:205 [inline]
>  _copy_to_user+0xcc/0x120 lib/usercopy.c:26
>  copy_to_user include/linux/uaccess.h:236 [inline]
>  move_addr_to_user+0x2e7/0x440 net/socket.c:302
>  ____sys_recvmsg+0x232/0x610 net/socket.c:2925
>  ...
>  Uninit was stored to memory at:
>  ieee802154_addr_to_sa include/net/ieee802154_netdev.h:369 [inline]
>  dgram_recvmsg+0xa09/0xbe0 net/ieee802154/socket.c:739
> 
> [...]

Applied to wpan/wpan-next.git, thanks!

[1/1] ieee802154: fix kernel-infoleak in dgram_recvmsg()
      https://git.kernel.org/wpan/wpan-next/c/4db86f8ab11b

regards,
Stefan Schmidt

