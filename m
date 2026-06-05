Return-Path: <netdev+bounces-295738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Iz9aHguYImqjagEAu9opvQ
	(envelope-from <netdev+bounces-295738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:34:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BA5646E2D
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:34:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K7FJSRgI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295738-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295738-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67AB23009169
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA85C4183BD;
	Fri,  5 Jun 2026 09:22:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9322B4183B2;
	Fri,  5 Jun 2026 09:21:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651320; cv=none; b=PBsmtZuPmQDU9PAZKz29f9/AvSGTsk2JLas4zHdvdd+tqtuCCjTU6ej8+05sO1XpWf4auK1zj0LTP0E7JPGtwoV4zrzOQR6e8jzqIS11zi8u77ZPLNmTqZ3evD8z+MZW3RLNVa94N6FyV/oyVwUtw0l0UIU+2DyurPk6D0972A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651320; c=relaxed/simple;
	bh=IQyGWGwxWlD4QOFS/o2hb+N2aTIisuaPW48hlU9kOXY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fjHH5TiTQ0Nn7ruK9oCydDpOAJ9mEy0Xd4MwFBDmKWggnEecwUNMzzjQRxJY9kOG00TSKZ0InCt4OKK+Tx6FJD7dYd2kzKZKvygzKpUas8Q56DhNuPyyCc2sBfoKrKEj9jkymS/udjvLPSHx7JEReI9xhdmPP049bv+YkZU+3Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7FJSRgI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1461F00893;
	Fri,  5 Jun 2026 09:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780651319;
	bh=E37SG+AdDpLtO2UiYqyM2celFi2dDo+IX/sJvSqiS0g=;
	h=From:Subject:Date:To:Cc;
	b=K7FJSRgIkbKOSXyuCF/I/SBcnK3b6lTE1GnPO5bzr40ncTSgucRQ7qRDvzaAFXSeL
	 ap70Tln730AvqJku4kzoEl0zA6AW3FZE28rcc1TtmZOBdfVn/UL8LdSEFuePkdonM2
	 oTGO+EByVt0o010+2WOb/9r13i74pGf4pHlIwbEB11GEKrv8RTlDHrUxo8SY/eIiXd
	 Nr2U6xO4uJ4vDWfKgjiUZMyPc6ZFMGVnkKiw0lV+nC92oBwZS5yAz2QMrUS14/SkwP
	 ib6XEyrSsD9m58ZFdBjtwSrqrGGvAJFexyafvDGMrVD2qzOFDwj88nfEnSX65YMrT2
	 ++SX5u20HQkHg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next v2 00/15] mptcp: pm: drop TCP TS with ADD_ADDRv6 +
 port
Date: Fri, 05 Jun 2026 19:21:44 +1000
Message-Id: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OzQ6CMBCEX4Xs2TWlwUo8+R6GA7ZbqD+02VaCI
 by7BePdwxwmszPfzhCJHUU4FTMwjS46P2QjdwXovh06QmeyBymkEkqUOFDKmhI+Q9IBW2NWscL
 gOWGKWAlTm2NlapIC8kxgsm7aEBf4taH5JvF1vZFOK2G97V1Mnt/bN2O5Nf4HjyUKrKyWB2PJK
 knnO/FAj73nDpplWT5l+Psm7QAAAA==
X-Change-ID: 20260601-net-next-mptcp-add-addr6-port-ts-40d8d74d8e20
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Shuah Khan <shuah@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3494; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=IQyGWGwxWlD4QOFS/o2hb+N2aTIisuaPW48hlU9kOXY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqIpUx2f0IX99W1PY9D+gbsqujaUgkjKZerLa7T
 TG2DpvWXXeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaiKVMQAKCRD2t4JPQmmg
 c9ipD/9fWgJIhFNDkqqNTpH439b3QTG/1h72fPvW/5LO+X8Ua2yKBrm2VNF556zbcZS5UVVzAeS
 MrlX6N9WTtUReXPyZxs93F3c+WCUPk5LcBtdK5REzUeGrQ0AU8q0jIs7AErAYKh+SXonkdPEQbT
 vpsgrVyvwGTpDl/W9Hn3+fD9WWjpHI3fBO4Kxc/dKb1nRBYA2709iJi/OVwj3oBzK183OomqLq3
 0yXzKW0xgpcAqJdCyvNfj+zG3Kwiv+6T8qI66nBkj2DyKFPlkzQR2OtsdkteQvb3/6uaFpgctrW
 Vxg5Bf0qT+xxHCkUUADKsrkYONaphFtHX24lRx5pe4zLDUwqXedfk3M7/6vElFsEQW6FbTbJKj0
 iszHQk40eyr73S/8VCsP2ZNtn0/XVKJJbr7+hQ18Ftmoy5rB3gjUXQ2IliKXtTJ2wbnyteDhttJ
 nGiQrAtadrUg96URJ1Rjk+9GTnv+wEZBew28g/Pj3i1Eif8QxsvvqWrw0/DQ8/beq0EhSd0gOpk
 n5zFR5sADYUX3M7S6fdkWn3I7kNnrWYMOwjjBzBurZuYMvVPepDSbs2hNiuOoK4xOagukcrh0H1
 zTK8ytHHB47v7lXc1aYa1tp0uPEoiR618ApegH0IzHkr7TuePDGFTcjj7qAFlwtJvbCMq+1VJ1s
 kKBVPX5CEVfAK7g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:matttbe@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:shuah@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-295738-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15BA5646E2D

Up to this series, it was possible to add a "signal" MPTCP endpoint with
an IPv6 address and a port, or to directly request to send an ADD_ADDR
with a v6 address and a port, but the expected ADD_ADDR wasn't sent when
TCP timestamps was used for the connection.

In fact, such signalling option cannot be sent when TCP timestamps is
used due to a lack of option space: the limit is at 40 bytes, and, with
padding, TCP timestamps is taking 12 bytes, while an ADD_ADDR IPv6 +
port is taking 30 bytes. The selected solution here is to simply drop
the TCP timestamps option when such ADD_ADDR of 30 bytes needs to be
sent.

- Patches 1-3: small cleanups to avoid computing ADD/RM_ADDR twice.

- Patches 4-7: the new feature, controlled by a new sysctl knob.

- Patch 8: extra checks in the MPTCP Join selftests.

- Patches 9-15: A bunch of refactoring: renamed confusing helpers and
  variables, and prevent future misused functions.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Rebased: some diff caused by commit a02a765bd5c2 ("mptcp: change
  mptcp_established_options() to return opt_size") and commit
  bd34fa025726 ("mptcp: add-addr: always drop other suboptions")
- Patch 4: Use READ_ONCE() to read sysctl data. (Eric)
- Patches 5-6: Avoid passing local variables' addresses to
  mptcp_established_options not to force the compiler to use a stack
  canary in this hot function, even for non-MPTCP flows. (Eric)
- Replaced previous patches 9-11 modifying selftests by a bunch of
  pm related refactoring: patches 9-15.
- Link to v1: https://patch.msgid.link/20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org

---
Matthieu Baerts (NGI0) (15):
      mptcp: options: suboptions sizes can be negative
      mptcp: pm: avoid computing rm_addr size twice
      mptcp: pm: avoid computing add_addr size twice
      mptcp: introduce add_addr_v6_port_drop_ts sysctl knob
      tcp: allow mptcp to drop TS for some packets
      mptcp: pm: drop TCP TS with ADD_ADDRv6 + port
      selftests: mptcp: validate ADD_ADDRv6 + TS + port
      selftests: mptcp: always check sent/dropped ADD_ADDRs
      mptcp: pm: use for_each_subflow helper
      mptcp: pm: rename add_entry structure to add_addr
      mptcp: pm: uniform announced addresses helpers
      mptcp: pm: remove add_ prefix from timer
      mptcp: pm: make mptcp_pm_add_addr_send_ack static
      mptcp: pm: avoid using del_timer directly
      mptcp: options: rst: drop unused skb parameter

 Documentation/networking/mptcp-sysctl.rst       |  13 ++
 include/net/mptcp.h                             |  13 +-
 net/ipv4/tcp_output.c                           |  10 +-
 net/mptcp/ctrl.c                                |  18 ++-
 net/mptcp/options.c                             |  68 +++------
 net/mptcp/pm.c                                  | 191 ++++++++++++++----------
 net/mptcp/pm_kernel.c                           |  22 +--
 net/mptcp/pm_userspace.c                        |   6 +-
 net/mptcp/protocol.h                            |  48 ++----
 net/mptcp/subflow.c                             |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  83 +++++-----
 11 files changed, 248 insertions(+), 228 deletions(-)
---
base-commit: bfa3d89cc15c09f7d1581c834a5ed725189ec19f
change-id: 20260601-net-next-mptcp-add-addr6-port-ts-40d8d74d8e20

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


