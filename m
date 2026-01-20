Return-Path: <netdev+bounces-251647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFqkLmcRcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:36:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFA24DE71
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27F5EB2D3C7
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E6C40B6C7;
	Tue, 20 Jan 2026 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eUyqsVAE"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB8B33A9D0;
	Tue, 20 Jan 2026 23:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950379; cv=none; b=guxzmEH4BYpiYzcpihHMUdufO0Xct14111G4Z05xCploj4rbZjAiwA4HKLs8eL58bSyu7qjeedGBb2frc/O6ReMwS/g5dzZMvxvTFoPADIxVjh/HuHEy4MlHxwH7EWEtdWvrD+EpYyHIgPdz/3wO677TlacyWHoY3+6yGa8u4tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950379; c=relaxed/simple;
	bh=PYt5Mke4qdl7AY/Bq6eopSHaK8Yv2ImgE6fasnT9WZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFVpI6k06sAk5OMhPDMXLnluMj1FLLBYJgm1LXc4bzFXnH7L0bMaD3vz48rMiYkeRgnmm9nZ/WIZkWgjpgsINaptbcwGhBe+RFyMk3MzQFuMAyapbzIFd1hww7TxPfm0KYztTz0yIEVbr1VxAlDqJUynJwFYZ+7WADC4a3yUxoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=eUyqsVAE; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=zDznKs8Ffi8fgQGVRkdCZeupx/TlrbfK+5Yc7AYTcyc=; b=eUyqsVAEWtY5
	yydDqOgCRQbV2gY2JZdmdo0Xbga1C+td4R4m8XR3IdZwuHX8O/Xo/EZVhV3CLDT8E4KWF/KdYhFl2
	56Lymrl676WQsM/3Um2P3bVEhiB4Jt3wJ1yB6zJDmP20OD5MGE5uuC2HmyRxUPjK2MWYqDiJqAfVW
	s3+DConPmvsWytxtoD0vQxgwTqsyUhuZGx0yG5PdDWHO/S5IuyBqlx0hpb3+7y9cDo8iJCyJlmdKa
	Vq0tiFGfFN88OPdCaKxjo/WwQa+ZEvCnPXc/bIKavQSHaB364N4AoKetKizkToa5DUdbZZZQgjJa+
	OF+4biHAvYB0rw2apieh/A==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1viKn9-00Fnsq-0f;
	Wed, 21 Jan 2026 00:06:03 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 60KN6CKp328458
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 23:06:12 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 60KN6C3h328457;
	Tue, 20 Jan 2026 23:06:12 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH 2/5] selftests: net: make ovs-dpctl.py fail when pyroute2 is unsupported
Date: Tue, 20 Jan 2026 23:05:55 +0000
Message-ID: <20260120230558.328423-3-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120230558.328423-1-aleksey.oladko@virtuozzo.com>
References: <20260120230558.328423-1-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	TAGGED_FROM(0.00)[bounces-251647-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[virtuozzo.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ovs-dpctl.py:url,pmtu.sh:url,virtuozzo.com:email,virtuozzo.com:dkim,virtuozzo.com:mid]
X-Rspamd-Queue-Id: 3CFA24DE71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pmtu.sh kselftest configures OVS using ovs-dpctl.py and falls back
to ovs-vsctl only when ovs-dpctl.py fails. However, ovs-dpctl.py exits
with a success status when the installed pyroute2 package version is
lower than 0.6, even though the OVS datapath is not configured.

As a result, pmtu.sh assumes that the setup was successful and
continues running the test, which later fails due to the missing
OVS configuration.

Fix the exit code handling in ovs-dpctl.py so that pmtu.sh can detect
that the setup did not complete successfully and fall back to
ovs-vsctl.

Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
---
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index b521e0dea506..848f61fdcee0 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -2583,7 +2583,7 @@ def main(argv):
     prverscheck = pyroute2.__version__.split(".")
     if int(prverscheck[0]) == 0 and int(prverscheck[1]) < 6:
         print("Need to upgrade the python pyroute2 package to >= 0.6.")
-        sys.exit(0)
+        sys.exit(1)
 
     parser = argparse.ArgumentParser()
     parser.add_argument(
-- 
2.43.0


