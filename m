Return-Path: <netdev+bounces-293542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPKYGaAXHWrFVgkAu9opvQ
	(envelope-from <netdev+bounces-293542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:24:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F02F0619A05
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8BC530059A7
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 05:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45F1334C3D;
	Mon,  1 Jun 2026 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6gsa/B3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6EB1F0991;
	Mon,  1 Jun 2026 05:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291482; cv=none; b=QvANGBlt6h7H1B8V9o2onoboiO1b/UHNAnHgq9SqXEJDDaJjyGy0DgrD7yWAeZdaFjg28XhlXyeDSYlevEiJq5Ljrsa66wDlQyWZHb/e2gAb600Le37dceBeBa30SJf9aIcCpfOEWL5wgWjIiQ1uSPTaWPmQh5nGv1uUvvNvrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291482; c=relaxed/simple;
	bh=HahcD1u1+FojtaEhXSSKdWBmlAsj5fU+MU7PgwzYArE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hBpsPwgrAVLEs1vNRSyATuvObOx3fO8F6MUGJvlLLgxHvtZqaFwMHN60n3nYH5bUCYw5VocjFZruaDGEpLWmzj4Otmdp3paA8iv9dZ3peR3FIg0A9SLMuucgVCyLxGUlWNVHifl5maeRrWvpY5kS12A9JMOZIQ+WljsKkbXSxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6gsa/B3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C5E1F00893;
	Mon,  1 Jun 2026 05:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780291481;
	bh=RNBCl095uTrDn/8o8UiadOiayG3gB724BCnI+j/g8pY=;
	h=From:Subject:Date:To:Cc;
	b=X6gsa/B3KeGw4TcoWfvdwjFBDcdMSRqMYfaSfXDcEjV9iPGPuT7t01ZKpAPem1SqM
	 q/KSICCKW9qzS2UvL96USjSZWqTOLwFOKy5JKjFE/9qPMz0yKwreULpw0KRI29Yo4W
	 8/xQMcIrR3AHoBK6D+qqZKK+5rOj+95hwfDUgtG925GZeSzvUShxXykq2RgVQVVG3x
	 F7NpFmeFkojkNJw4zNVhEVHJsOYonuYLNl349czAkyZ+HuW/6NF+4OVWyijFtWd8vx
	 6OR/LnYMvBpmhroyHC2GyWvnV16zzXG0l4Dzv/pxSPjsmmw+t8yHXmbVCukRbO0C8p
	 Dltf6t0TmMeJg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 00/11] mptcp: pm: drop TCP TS with ADD_ADDRv6 +
 port
Date: Mon, 01 Jun 2026 15:22:07 +1000
Message-Id: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWNwQrCMBBEf6Xs2YVtKLH4K+KhZte6gmlItlIo/
 XdTpYc5PIaZt0KRrFLg0qyQ5aNFp1ihPTUQnkMcBZUrgyPnyVOLUaxmMXwnCwkH5j3ZY5qyoRX
 siHs+d9yLI6g3KctDl5/iCscabv+mzPeXBNsNsG1fihrAkY4AAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2531; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HahcD1u1+FojtaEhXSSKdWBmlAsj5fU+MU7PgwzYArE=;
 b=kA0DAAgB9reCT0JpoHMByyZiAGodF5KixVMUi7zgzg5pDB4kpR979DGvbvj1bLpWbETBtMreQ
 IkCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJqHReSAAoJEPa3gk9CaaBzp1wQAN2J
 cXW6VW0+fHcK/4T5kxA4BU08U/53LNs5nUgJp6JdixiQxuqHKMLtf5vhdaQQPKsHDp1RXeuEdPB
 eQSo15caInFbDw/C+9DlJ2PEyYhM2PsJg9nqRgEfH5GxgZgfV1g/ePmJcI6edQd1BEbv5VBr5rC
 guLyHvy/4WG0Tg8BBVTj+sarKErPkzL0019V55LWzZyjyz4x63WAlIlBx4+eH7QcFLyBcyOhDT2
 pCTn8CbYXqGBQx2JHbxA/H5tNkOxTvXWbSQ29vMQbiRSvkXcpIJLi5VkaBHej61gEzgDfi3awPd
 TAo9IEo4wFJNcAFPa7lwVmiWf0T32lkJTyGAgpaXZAoqAAPWtBiih7OD6Tok0cdkAU5HkvSIpHO
 5YvTZhVvKl1+j38the3CNbAgc3N+Kj75UqO5SWT0XlWzo7iKa/PjNXpmjd0XRfQVrbiizZtV3EP
 ZHRKe4/oku9Z8IXfKd3n50nPD0yY9MmCL1NmF4Nz7fJjqQnp8SfvIKfl0ek3sGaVCHFWzE6x1rX
 8Ih/tJiuPbOzGgK0i0oK0FdZ/duoqhjzhad9uqeGCr2Qb8f/FZaOsgJ1oVWai+J0xESmHF6R2WZ
 MnKlLKXq+uILk/nAmY+YGQxTaJn8BR8dA+6BjsHZJmM05QpBquwVc0l78ku0Gj4gLD55G1oReLH
 /9HCN
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293542-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F02F0619A05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

- Patches 9-11: small pcap-related improvements in the selftests.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (11):
      mptcp: options: suboptions sizes can be negative
      mptcp: pm: avoid computing rm_addr size twice
      mptcp: pm: avoid computing add_addr size twice
      mptcp: introduce add_addr_v6_port_drop_ts sysctl knob
      tcp: allow mptcp to drop TS for some packets
      mptcp: pm: drop TCP TS with ADD_ADDRv6 + port
      selftests: mptcp: validate ADD_ADDRv6 + TS + port
      selftests: mptcp: always check sent/dropped ADD_ADDRs
      selftests: mptcp: connect: test name in pcap file
      selftests: mptcp: simult_flow: test name in pcap file
      selftests: mptcp: pcap: drop most of the payload

 Documentation/networking/mptcp-sysctl.rst          | 13 ++++
 include/net/mptcp.h                                |  3 +-
 net/ipv4/tcp_output.c                              |  6 +-
 net/mptcp/ctrl.c                                   | 18 ++++-
 net/mptcp/options.c                                | 64 ++++++----------
 net/mptcp/pm.c                                     | 49 +++++++++++--
 net/mptcp/protocol.h                               | 30 +-------
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  8 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 85 ++++++++++------------
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 11 ++-
 10 files changed, 159 insertions(+), 128 deletions(-)
---
base-commit: 8415598365503ced2e3d019491b0a2756c85c494
change-id: 20260601-net-next-mptcp-add-addr6-port-ts-40d8d74d8e20

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


