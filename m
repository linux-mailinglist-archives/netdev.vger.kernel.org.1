Return-Path: <netdev+bounces-307147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lTJZDg/eVGpUgAAAu9opvQ
	(envelope-from <netdev+bounces-307147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:46:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C1E74B0FD
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:46:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307147-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307147-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8F4830011AC
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07DD40E8D3;
	Mon, 13 Jul 2026 12:46:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAA8385D7C
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 12:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946761; cv=none; b=qhFXVE5Jvn9aCUex8cbXERBWioqs0VY7pPXR2KXQoxNU8mP3x+asZCGE1hGlkHty2XhZSOsttVv708CSq168S/CSNA50TKLFnAG6V83k9N+pUUMstEebK+cRY8BqM/DiuAsRO00KpDGk/+JrdwT09X6df+LDQt3ClEsylzLoPrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946761; c=relaxed/simple;
	bh=pWm0ChJyB8PHmvDlDUj89RkzlTNGHzp95bKBeqNbe+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hyg5XR8vSt8blxXmJngo5MY0mxtcMIedvTpr0XbZKwJa3RksnrjRr5zmpRC10u6cV+429WZ25Q9VkthXZQkvgGpLys8SNBBlrqtAuL3GhZxNLFIQeQ8XVq7VhjjL+pJXsfROhKNwxw2TqhdDG6a3nX+JvxawYw2t3lSTFB4vub4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Received: from [2a07:2ec0:2185:8e:f1c9:c246:22b4:8471] (helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjG2j-00000001VUh-0q6p;
	Mon, 13 Jul 2026 14:45:53 +0200
Received: from equinox by alea with local (Exim 4.99.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjG2h-00000001wUs-2y04;
	Mon, 13 Jul 2026 14:45:51 +0200
From: David 'equinox' Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [RFC net-next] llc: jumbo frame support
Date: Mon, 13 Jul 2026 14:43:37 +0200
Message-ID: <20260713124545.462790-1-equinox@diac24.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[diac24.net];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-307147-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,diac24.net:from_mime,diac24.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89C1E74B0FD

Hi all,


this is a somewhat random stab at 802.1AC / jumbo frame support for LLC.
It kinda fell out as a side effect from poking at FRRouting's IS-IS
socket use.  Unfortunately even if this gets picked up right now, it'll
be quite a bit of time before we can even consider using it there.  (And
it's not clear that it'll go that way.)

Regardless, it's a tiny change & my messing around with things
effectively got me the selftest too.

The fact that AF_LLC can't be used in a network namespace is a bit of a
problem though (haven't looked at how much work that would be, unlike
the jumbo frame support this didn't fall out "for free"), and so is the
fact that AF_LLC is on limited maintenance...

It's an RFC.  Comments appreciated.

Cheers,


equi (David)

(waves from netdevconf in Rome)


