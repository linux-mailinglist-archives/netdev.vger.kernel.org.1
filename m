Return-Path: <netdev+bounces-307425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0Xl9ECMVVmqtywAAu9opvQ
	(envelope-from <netdev+bounces-307425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 12:53:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA627539A4
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 12:53:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=HpRM+MuZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307425-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307425-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A781330414A4
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0692363C6F;
	Tue, 14 Jul 2026 10:53:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A99363086
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 10:53:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026400; cv=none; b=rqR+1oVoeIk0FLMoUOoPAhcK+3P4nU2GsVK3o5yo7wbDlMYXJEoEnsgKv69nx5uRGwxyPzlDPPJhDMCsG3hDoGwOhIxJT7PEw8TgxFhEmKU6ED5JU3nwLuBDf5/rxPwF6Q8ohBqTJrqr6fpIY/eHmac8xoKLIK0svXzq2/BwNMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026400; c=relaxed/simple;
	bh=S+1MPPNKIwzCE/1Zxp+P763AKiNVERmLYQadrGphsRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VGeKHzPuUPjka1EB2+2PAZ+suiE0CYUdQK9Em2IOslumrWJgvQds1QDmwdAr33NhNSltSGegpSf6LY9A6PybbKeZbRyYk31/5Jox3i8g4xh/0aKYAV2nz2nZGhT+D0Qzz6bmQPYTzJONE3fRFqgdAo3qZYMANDNQ0ebofusGvYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpRM+MuZ; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784026398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XDZToKYFd+l8j2f1c5w++2EBFj7CdeWFjoikYK4QjZc=;
	b=HpRM+MuZe1cH8HWIljkpoq/ekIC6on4g//ntUTOjewjN8mzzN1zpM5TuRO7b7OIB6OQ1IO
	ZCXonJq7mlQqvsUji3mEU4rCaS9ZZnXn2Uz7d+U3r0uE/be2EoiYa3Un0WIPkgfm2DSCYm
	f7lulYauLxG7G4N3fvfOEcszll+rETE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-Squy93U7OVGap3oBv_cuew-1; Tue,
 14 Jul 2026 06:53:14 -0400
X-MC-Unique: Squy93U7OVGap3oBv_cuew-1
X-Mimecast-MFC-AGG-ID: Squy93U7OVGap3oBv_cuew_1784026392
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE9AA18004D2;
	Tue, 14 Jul 2026 10:53:11 +0000 (UTC)
Received: from thinkpad.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 076D21956089;
	Tue, 14 Jul 2026 10:53:05 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: bigeasy@linutronix.de,
	fmancera@suse.de,
	liuhangbin@gmail.com,
	luka.gejak@linux.dev,
	xiaoliang.yang_1@nxp.com,
	kexinsun@smail.nju.edu.cn,
	ssrane_b23@ee.vjti.ac.in,
	michael.bommarito@gmail.com,
	2022090917019@std.uestc.edu.cn,
	yury.norov@gmail.com,
	jvaclav@redhat.com,
	maoyixie.tju@gmail.com
Subject: [RFC net-next 0/2] hsr: Use only one MAC address per node
Date: Tue, 14 Jul 2026 12:52:41 +0200
Message-ID: <cover.1784024900.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linutronix.de,suse.de,gmail.com,linux.dev,nxp.com,smail.nju.edu.cn,ee.vjti.ac.in,std.uestc.edu.cn,redhat.com];
	TAGGED_FROM(0.00)[bounces-307425-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bigeasy@linutronix.de,m:fmancera@suse.de,m:liuhangbin@gmail.com,m:luka.gejak@linux.dev,m:xiaoliang.yang_1@nxp.com,m:kexinsun@smail.nju.edu.cn,m:ssrane_b23@ee.vjti.ac.in,m:michael.bommarito@gmail.com,m:2022090917019@std.uestc.edu.cn,m:yury.norov@gmail.com,m:jvaclav@redhat.com,m:maoyixie.tju@gmail.com,m:michaelbommarito@gmail.com,m:yurynorov@gmail.com,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,linutronix.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DA627539A4

Many places in the hsr module assumed that a single node could be using
multiple MAC addresses to communicate in the network. The standard is
explicit that PRP nodes should use the same MAC for frames on both
ports and commit b65999e7238e ("net: hsr: sync hw addr of slave2
according to slave1 hw addr on PRP") made this clear. For HSR, the
standard is less explicit. But after quite some discussions and reading
standards, Fernando, Sebastian, and I concluded that it never mentions
different MAC addresses for HSR either and instead often suggests using
equal addresses for both ports and this should be what hsr interfaces
do.

A short history of how this assumption formed in the kernel supports
this as well: the original HSRv0 code implemented IEC 62439-3:2010 where
node tables had two MAC addresses per node. It was an optional feature
to support an unspecified address substitution mechanism for _PRP_, also
referred to as PICS_SUBS. Note that we never even supported PRPv0 from
the :2010 standard. In IEC 62439-3:2012, the feature was explicitly
removed. But with two addresses per node in the node table and selftests
setting different addresses for both interfaces, the assumption emerged
that all nodes can have two addresses. In :2010, this was optional and
the standard is written so that a node not supporting PICS_SUBS could
just ignore it. Since 2012:, nodes must use the same address for both
ports in the ring.

To prevent misconfiguration and simplify the hsr code, this patchset
removes the notion of two different MAC addresses for one node in the
network entirely. The first patch sets equal addresses on both ports so
that we are not running in invalid configurations. I also updates the
selftest to not use/expect different addresses on the two ports. The
second patch removes MAC address B from the node table and thereby
eliminates a lot of code, including the node merging.

I am posting as an RFC for now mostly for two reasons: First, I want to
make sure it's generally accepted to have only a single MAC address per
node and give everyone the chance to speak up against this.

Second, I adapted the PRP address handling to HSR as well, i.e., to copy
the address from port A to port B and master, mostly because it is low
effort. I am not sure though if this is the best approach now that we
touch this part of the code anyways. I have two alternative ideas how
addresses should be handled:

1) Make the master control the port MAC addresses: when the hsr
   interface is created, generate a MAC address and assign it to both
   ports. Changing the address afterwards would also only go through the
   hsr interface which would update both ports.
2) Don't change the MAC addresses of the port interfaces at all. Instead
   behave similar to bridge where the ports keep their addresses and
   traffic from the bridge/master gets its own MAC address assigned.

What do you think? Do you prefer any of these approaches?

Thanks,
   Felix


Cc: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Felix Maurer (2):
  hsr: Set equal MAC addresses on port A and B for HSR
  hsr: Remove second MAC address from node table

 net/hsr/hsr_debugfs.c                         |   9 +-
 net/hsr/hsr_device.c                          |  23 +-
 net/hsr/hsr_forward.c                         |   8 +-
 net/hsr/hsr_framereg.c                        | 250 ++----------------
 net/hsr/hsr_framereg.h                        |  14 +-
 net/hsr/hsr_main.c                            |  18 +-
 net/hsr/hsr_main.h                            |   5 +-
 net/hsr/hsr_netlink.c                         |  18 +-
 tools/testing/selftests/net/hsr/hsr_ping.sh   |  33 +--
 tools/testing/selftests/net/hsr/hsr_redbox.sh |  13 +-
 .../testing/selftests/net/hsr/link_faults.sh  |  26 --
 11 files changed, 62 insertions(+), 355 deletions(-)


base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
--
2.55.0


