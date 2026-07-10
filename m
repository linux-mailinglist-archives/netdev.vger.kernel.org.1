Return-Path: <netdev+bounces-306645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w4gCFqo0UWoJAwMAu9opvQ
	(envelope-from <netdev+bounces-306645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:06:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C014B73D32C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:06:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="oPzV+/FG";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306645-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306645-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A48FE303EEA2
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE1637CD48;
	Fri, 10 Jul 2026 18:05:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F39B37DAA6;
	Fri, 10 Jul 2026 18:05:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706726; cv=none; b=VXXBDUhObhD08zUIk06BD1tyNax99f3eMuvH4tKsYaX4/CWJFVsCMuVYTQgCCZ7V3DnFWD+3T+NR4+Y23+QwRBDrBp0Uw2cCVVvE0RxHiI/IM5YuL/cdqEBq2Z5+WrWfWPSCmqGAtubA0PQwtIjY2WSiFaVWy6xa///Mbr7DmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706726; c=relaxed/simple;
	bh=Vgt3l6ylLl4JMfzCQmww08pBU0tyACAzZn0QXBpMFjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TRa1r7oZR8REMFjIAMPb/UY8GOqbcPIic8Su7xXI52TJvETSv/MkmKEnnoHYHtDtq/Y4fxqN4AVW6KtNkTfQghmf/+z8eSNPxt4n7bg1z35l4hJ3hDAuiXECQCUpjzxCLtqEm3szBJDxpeqnD9uv4IOc+wFcauEsk6vR+wewoQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPzV+/FG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA04A1F000E9;
	Fri, 10 Jul 2026 18:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783706724;
	bh=ufULc8b5oYsXRLSxsnf76uKMhDIXgOrRA+K0wyBHYLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oPzV+/FGRoUshiu15OBssHuBeP0T1FbfiT1qvOyEWTE5Z/AIg+koxVs6G6YqyY7qh
	 XsBCIyupCAr3vSvU6oqUIoPuzWlqe/Vx1qO3/nYz/0ZJoAUjJr5Jfs/EFMM3zMXBcz
	 5ba+227b0CKDU8V5ARuU22c4QyTPE5A8yaR/voMaad/OmIZHulTBDwZwkXeRjVTvfW
	 zR1PEMyOgZlT/iF6qCbddwfY97UKthNI45QC25HGyRjvVA3y3taBKSfRoMQHjThVz0
	 wi3i2+Yl4E63VvQAhNHtQGP9foVg6fMxBjTHejnVVTyHQVZn5ygZs7Kku+DGSa5uh5
	 blilNWV+q/jQQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Jul 2026 20:04:42 +0200
Subject: [PATCH net 2/7] selftests: openvswitch: add config file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-net-sft-fix-containers-v1-2-a2915c294ef5@kernel.org>
References: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org>
In-Reply-To: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, dev@openvswitch.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Vgt3l6ylLl4JMfzCQmww08pBU0tyACAzZn0QXBpMFjI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLICTcI696zec1RH2K33cZ/23ggGlSuTllifUurflhUTN
 1/wY4hARykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERO6DH8FdjgqSiuu2uxJZde
 Vf3n++tvbXsizbB9Y4zj53sHgz0i7wJVFB5sKnnnYvVx1+T5Nbc35rNlfWLNDjYsSr9V+vb6xq1
 8AA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:matttbe@kernel.org,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:dev@openvswitch.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-306645-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ovn.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C014B73D32C

The kselftests doc mentions that a config file should be present "if a
test needs specific kernel config options enabled". This selftest
requires some kernel config, but no config file was provided.

We could say that a sub-target could use the parent's config file, but
the kselftests doc doesn't mention anything about that. Plus the
net/openvswitch target is the only net target without a config file.

Here is a new config file, which is a trimmed version of the net one,
with hopefully the minimal required kconfig on top of 'make defconfig'.

The Fixes tag points to the introduction of the net/openvswitch target,
just to help validating this target on stable kernels.

Fixes: 25f16c873fb1 ("selftests: add openvswitch selftest suite")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Aaron Conole <aconole@redhat.com>
To: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: dev@openvswitch.org
---
 tools/testing/selftests/net/openvswitch/config | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/config b/tools/testing/selftests/net/openvswitch/config
new file mode 100644
index 000000000000..c659749cd086
--- /dev/null
+++ b/tools/testing/selftests/net/openvswitch/config
@@ -0,0 +1,16 @@
+CONFIG_GENEVE=m
+CONFIG_INET_DIAG=y
+CONFIG_IPV6=y
+CONFIG_NETFILTER=y
+CONFIG_NET_IPGRE=m
+CONFIG_NET_IPGRE_DEMUX=m
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_CONNTRACK_OVS=y
+CONFIG_OPENVSWITCH=m
+CONFIG_OPENVSWITCH_GENEVE=m
+CONFIG_OPENVSWITCH_GRE=m
+CONFIG_OPENVSWITCH_VXLAN=m
+CONFIG_PSAMPLE=m
+CONFIG_VETH=y
+CONFIG_VLAN_8021Q=y
+CONFIG_VXLAN=m

-- 
2.53.0


