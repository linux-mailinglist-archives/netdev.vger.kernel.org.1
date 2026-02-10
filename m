Return-Path: <netdev+bounces-258147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I5sFVF+i2kzUwAAu9opvQ
	(envelope-from <netdev+bounces-258147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 19:52:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B6911E6B5
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 19:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 928A8304BC0C
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAA138B99D;
	Tue, 10 Feb 2026 18:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PZlwPz3w"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09038B7C7;
	Tue, 10 Feb 2026 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770749514; cv=none; b=ZvPA6o0USl/4sTHX9U8huGB+ZcL7e3PGjRrq9IAUyLXftilUnnK8e83RPMeOnpLo/1hvEmELNBY+PpZxoX5H1bYq0Edp3iQmK1oH1wbvrbAhiwr42Vf46CXG8KhZJkfSJyj5csVOL3tSO7rfEYItvR84TyRa7/fCty1/C4tE5+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770749514; c=relaxed/simple;
	bh=G7cX29D8QcLZjtL/pzMzC6d65K3q2ndWEsgHuXtW/n4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GAKU/STiBbUolzHt8xQ8fIU1pGWH/fY3nrr5pokDvC+kILBb75HlNTD7UIs0bg8lo8pWypb9U8fkD07VEFbzhOb4F9ruLrDOwzMZ0RIxe7zrZ78/ifVXv1iawJ5/CdurtNnxoP16gFlVOmiC2i0ts5uGW8EMWLePhjjNgDpIXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=PZlwPz3w; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-ID:Date:Subject
	:From; bh=ZKUbiyo/WJt3LVGjEqWPdJ60gNGtjVCkYtfmvI9e74c=; b=PZlwPz3wCH/QdJceDkw
	jjBy2BHxGXLzBNZ5GjyGW2PaTD/kGzmp0e1QFe0WGSbkMAaRurQ/WhsKHFbIU2peUandCSZB+9vX6
	PGt1pZuv2rT1ekX+8Bmsx/RTCDvBUlz9qPhQzvgJI6MX3uXLSnesaf2dMa4M+OrI1J1LOClq66JX/
	OZWBAcDdu3s+8R2S331TmnadG5F31ALXii+UyFVTtOTA2hL04oswRq2UfOgFs0c5GSSqc08lYofpX
	0vwdmI5pUcfw26xKCLANF18lLKJ6KggVv4cQmEj+RqIzH4Zfo/2LtokKIsl4hsxJ6uW8sYT5Kteo7
	bJS3gHAApcyZ1jA==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vpsou-00DI8q-1q;
	Tue, 10 Feb 2026 19:51:35 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 61AIphbo480032
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 18:51:44 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 61AIpgA2480031;
	Tue, 10 Feb 2026 18:51:42 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH 0/3] selftests: forwarding: fix br_netfilter related test failures
Date: Tue, 10 Feb 2026 18:51:26 +0000
Message-ID: <20260210185129.480015-1-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,virtuozzo.com:mid,virtuozzo.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258147-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[virtuozzo.com:+]
X-Rspamd-Queue-Id: B4B6911E6B5
X-Rspamd-Action: no action

Hello

This patch series fixes kselftests that fail when the br_nefilter
module is loaded. The failures occur because the tests generate
packets that are either modified or encapsulated, but their IP
headers are not fully correct for sanity checks performed by
be_netfilter.

Aleksei Oladko (3):
  selftests: forwarding: vxlan_bridge_1d: fix test failure with
    br_netfilter enabled
  selftests: forwarding: vxlan_bridge_1d_ipv6: fix test failure with
    br_netfilter enabled
  selftests: forwarding: fix pedit tests failure with br_netfilter
    enabled

 .../selftests/net/forwarding/pedit_dsfield.sh |  5 ++--
 .../selftests/net/forwarding/pedit_ip.sh      |  2 +-
 .../net/forwarding/vxlan_bridge_1d.sh         | 26 ++++++++++++-------
 .../net/forwarding/vxlan_bridge_1d_ipv6.sh    |  2 +-
 4 files changed, 21 insertions(+), 14 deletions(-)

-- 
2.43.0


