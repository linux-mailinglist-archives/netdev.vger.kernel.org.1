Return-Path: <netdev+bounces-299852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TvPgNkNRMWqFggUAu9opvQ
	(envelope-from <netdev+bounces-299852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:36:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE50868FFAA
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:36:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YvWGwxAz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299852-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299852-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EAC7318B5DB
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF922BEFED;
	Tue, 16 Jun 2026 13:33:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C69229BDBB
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:33:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616807; cv=none; b=iG/OuLRysD/XIXSGa5elvi5pXDQsRW9/WRXgYUSAkoUSj5pz629FBWaomzBYVzlOkzZ81yXHvtSW/nef64t0FRcbWRsqc0lkjT95tSl96asLWCnTJB87hyrZo6kKKrIDJLD/UJ6SJ9b6+DN4pye7VaayYKNzJvvwM0pwSi5ZMgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616807; c=relaxed/simple;
	bh=B7NbYePpMBTbPqHaNwnxJI8ZJynMBXUdmZ7DUrQWcqk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Yoctjf9F70bxZUR09Zr/bsj8ihBF3teboYTqI4iuVfLjEPpE87aZlS9VGVADcbPX8GILSJNoXYNG4JHIWcMS6oKXJSoCpPfqwh9hy6BgSg0ecJbTnOOvyD3cQFeSCPKNnQm2vUThw/PbSDerJYN+rPj134kSUCfbOCxZr0BlnSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvWGwxAz; arc=none smtp.client-ip=74.125.82.48
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-137335bc3caso5449614c88.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781616806; x=1782221606; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDAJKGFq1CTjHcbBfhvZCsmuboGZqYSCpkYBIaMjxQ0=;
        b=YvWGwxAzOUNsnY80mtWDUpDM+NGXXJIaJ0q/PKpq7yhulETtA+fkWiuM3epGvTbULC
         CHtCpBbBdObZMDXfVQY0lQN7/q9MT2PjDL7KQ+/zlmOOGWyC+5oA0NbDyBIhvGjs2eD0
         +jZAzKRECGRixpqW9/txR8W8V3mzR4D6nfHWAAMjGE5+9bsvwf578BLqQ9jbR9adD/+q
         5XkzV/xG5QCQp0D3ppttrlaKl10lUvfTCavoMq/jmTdiLuuROXo1cO9CZVxmI3IMeKP+
         PnFubrlVobxKTtGx5Ms55Jye2upMXOsBIRd4k4g+Bm5SvdDXsxPMTN/XVl/Hr3wXtnkE
         Fl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616806; x=1782221606;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDAJKGFq1CTjHcbBfhvZCsmuboGZqYSCpkYBIaMjxQ0=;
        b=OUobPYXaOiqokM4M+xWMf3RKLikqGHgD/tHb+Fdvj9teDPzs4W8Ej7uA8zzfB2XjTx
         h3zJPLp/36fh5SOri+jTsWaZB+D4Sk5kbgk7vwl8O9+fOJS/I4xDPMIBI07y4ML15yxa
         Rb7fVzyyWCEEojLldTf1RbhL4/EppxBs/Xe9Oj5A4+Vrny9UfpWp9ecWqd7pLjqdQtjY
         ns+rPyVaffKiMmKbdPg45P5Y3CKXQe8PybGUqBFq3tWav5J+wo0lxPaiHAl9j9O0f8xV
         EhQYd4McFIu1Bcq8bsQubgYswUmfaelUoPyqLRqDE5aZoPHbomhUD0VbHaJoB2jpofEE
         OgxA==
X-Gm-Message-State: AOJu0YxEeFLh6H10j/9GXd813py0P+kFiLjmz0hVzdBE7rncZAwUlQuh
	u2EJQMf1BrGUyQTqCBWLC27qUMZ/28jV+y9vtdpcnTNLtBndmBdb+Fkzp5uVQsSWevY=
X-Gm-Gg: Acq92OGleIKP83kHe05yvIEd6ELfbhyQK3+X29I8/3V95J2Q/kcd/daAiZiPF+WQYL5
	U/KeyXXmK67rfGuqtqkIxm5uv9doYuXcFQgEdTQC5yb7rQT/Dh3ppvgJodaYltHrQMFDb3Dwndp
	3fB4Oz4ifM267MOGNb0ud+DsjkNVi/+ijhfyQioqgTFN+mYI8FwTjOo44fbM8p/ORy1Zr+ryLYl
	qnvxShT0TCS7r0Pd6DXs8P4mPmDwDNCKvxDNE1Ty6JTKm4aysAI+KPKJy7p6xP4uXeI5Mjj5f0+
	p+u3GmYpR167J8MgHwuI0nLRq+54cfv2M16TapkCnDi2z8T0Ut1gOw+ORp8rlvQnNZBHKLsFQE+
	/i3sr5tIPKrMHqPbLoCu9E8Bjq7EQwBF5xR6rTOT72/OerrjurND5AWlUj9zZnNsKoGC8SCebGT
	9UVKOv/qCQrQabtdk4dbH5hLsay1NssAjnaKtXaMSumCT4
X-Received: by 2002:a05:7022:ea32:b0:138:51c:c5aa with SMTP id a92af1059eb24-13985f33af4mr1724772c88.27.1781616805276;
        Tue, 16 Jun 2026 06:33:25 -0700 (PDT)
Received: from DESKTOP-19IMU7U.localdomain ([125.242.148.221])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b964862sm13746986c88.10.2026.06.16.06.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:33:24 -0700 (PDT)
Date: Tue, 16 Jun 2026 22:33:19 +0900
From: Wongi Lee <qw3rtyp0@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, asml.silence@gmail.com,
	dhowells@redhat.com, willemb@google.com,
	Jungwoo Lee <jwlee2217@gmail.com>
Subject: [PATCH net v4 0/2] ipv4/ipv6: account for fraggap on paged
 allocation paths
Message-ID: <ajFQn6yh43eDeQm9@DESKTOP-19IMU7U.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299852-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:asml.silence@gmail.com,m:dhowells@redhat.com,m:willemb@google.com,m:jwlee2217@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[qw3rtyp0@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qw3rtyp0@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,DESKTOP-19IMU7U.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE50868FFAA

Fix fraggap accounting in the paged-allocation paths of IPv4 and IPv6.

The IPv6 patch is the v4 update of the previously posted patch. The IPv4
patch handles the same code pattern (by Ido).

v3->v4
- Remove the MSG_SPLICE_PAGES exception from the IPv6 negative copy check.
- Clarify where the fraggap bytes are copied in the commit messages.
- Add Reviewed-by tags.

v2->v3
- Add the IPv4 counterpart.
- Mention that the IPv6 corruption became triggerable after ce650a166335.
- Remove the stale comments about copy becoming -fraggap when pagedlen > 0.
- Add missing Cc entries.

v1->v2:
- Fix mail format.

v3: https://lore.kernel.org/netdev/aiq3f7UZGFp0F3MV@DESKTOP-19IMU7U.localdomain/
v2: https://lore.kernel.org/netdev/aigx83czv+UJZA0d@DESKTOP-19IMU7U.localdomain/
v1: https://lore.kernel.org/netdev/aibiIYMAwUErTw5U@DESKTOP-19IMU7U.localdomain/

Wongi Lee (2):
  ipv4: account for fraggap on the paged allocation path
  ipv6: account for fraggap on the paged allocation path

 net/ipv4/ip_output.c  | 7 ++-----
 net/ipv6/ip6_output.c | 9 +++------
 2 files changed, 5 insertions(+), 11 deletions(-)

-- 
2.34.1

