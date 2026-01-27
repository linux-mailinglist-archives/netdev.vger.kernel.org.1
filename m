Return-Path: <netdev+bounces-254032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6I9qImlCeWmAwAEAu9opvQ
	(envelope-from <netdev+bounces-254032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:55:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA169B446
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42B64309A347
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C492EC0AE;
	Tue, 27 Jan 2026 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="epVa14ju"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E2B2F83AE;
	Tue, 27 Jan 2026 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769554330; cv=none; b=Wx9281JMabPFfjwJnNzdXLr3RtKViyGrc57A+yGxzzFz6h9XvVHRL763+TCaWoRgOPohU8xlYw2WImclt9j+7SAg42/dsCw0qV5InjzyiGQF6VKFA1nsq4qakzQCltK/EZaCDZ066Ir2PGiXaeEWH7T2y0FNwxVxzCdEQAi6mMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769554330; c=relaxed/simple;
	bh=NipXyq8Olunpd4nLlWBIUAlNUcuzVjyuhISS0mQU4mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxseKASudE6i4PL6dH5L5sfbsKKxbZQJ7wx+5wWSa5PnzAc8GF9QPulzCGApTUNDA5yh8ELVHnq0FWA+wBt8ippybbnD/K8xgYV6cTBm5lmdXw+DvkCwzv0MHy11bnN0cIKJKLaDaOyvlmkc2f1W81Gff94qY9IST62vNY1QtH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=epVa14ju; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=IpUU4MbJSN8PkPmUt1IzIbg/Bcu1M7gnSljEdtG9dlo=; b=epVa14juOxon
	6hVjVE5o7agp+flakrjkFSJPAaApTmD0AFs1CYu7WJeId080+UhL5f+v8SVy/uf7faJbgJj1U2x+6
	AwA12R4r0CRkfNVvNTnUhlg5FvDo9T9Az/sH5zh1W6VWEkp/JGF27cYMWONG6TyIcE/bk+ORCsnDz
	bqm3qjpNwPW5N9IckRJvk94kTha0xMtq9ggIzeDdfs7aqF4vRdN10PsbrXEpuFsyYny2GIIX47LwZ
	EST0UMsWY625396PxlPFfad4gvknxbHsroCxUQiyKgPO4xhPybTSA6cOBZCDZ0jXJNhizo6BsPW7N
	hJ8Ed3+HajKYlK9cp9uxhw==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vkru2-0080TH-07;
	Tue, 27 Jan 2026 23:51:48 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 60RMpvmJ304391
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 22:51:57 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 60RMpv2S304390;
	Tue, 27 Jan 2026 22:51:57 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH v2 2/5] selftests: net: make ovs-dpctl.py fail when pyroute2 is unsupported
Date: Tue, 27 Jan 2026 22:51:31 +0000
Message-ID: <20260127225134.304362-3-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127225134.304362-1-aleksey.oladko@virtuozzo.com>
References: <20260127225134.304362-1-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254032-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pmtu.sh:url,virtuozzo.com:email,virtuozzo.com:dkim,virtuozzo.com:mid,ovs-dpctl.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEA169B446
X-Rspamd-Action: no action

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

Fixes: 962e8a01eab9 ("selftests: openvswitch: Add version check for pyroute2")
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


