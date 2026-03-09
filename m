Return-Path: <netdev+bounces-265590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJBTB/LnrmlRKAIAu9opvQ
	(envelope-from <netdev+bounces-265590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:32:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9561A23BB83
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 16:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 915C23069DDE
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 15:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4D53DEACB;
	Mon,  9 Mar 2026 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KBJf2MHW"
X-Original-To: netdev@vger.kernel.org
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277E83D34BE;
	Mon,  9 Mar 2026 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069640; cv=none; b=c7Hb6LkFsTP9LlSGRg3kPLwE9/vNQ8TWfqYIVCYZKzPa9kn9mkssCWujogy/1WibYzPkASD/UqFUHqoVhTncgIZoK7up7CFZTJP3VB//JhcePxSxanqytS9hqa2osBoBHVrZZPbOxHk6gKQA/8MMNJO13ql9d2b1MoEhoTdPhHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069640; c=relaxed/simple;
	bh=NipXyq8Olunpd4nLlWBIUAlNUcuzVjyuhISS0mQU4mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m62IzFfkcpaHtj7Ll5E7ZFK6XL4bXyqxwi71LO5IsIvkqoggc9aXT9t8eLPkHlXkzz7DdhCE84BPJRTL2AvaD6T+s1qRmJ8ELsqZd7KQIAHzIsDH4zzthH9koXS6YdNlxyUrXSrlbU3LeX1c5zAHvUXz3veKoM1xd4VEigZ5868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=KBJf2MHW; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=IpUU4MbJSN8PkPmUt1IzIbg/Bcu1M7gnSljEdtG9dlo=; b=KBJf2MHW9U+O
	n6hLcOlgSybHJY3wYHsWcBTEqbzV2ktazTZkn3wfZ1GiwY9pAI5C252b5NMhnSMtC+SIOMiZ7ZKZa
	2QzKbAHF4c/4yiBMTDYjwjPsansN0IgXLFmFPESf1zrvJYbNhFrSmocANc23esUg0jGwtR3/NAo/w
	6kuBeR1l63tpfakY1CjjenxlAynqeSninSLMe6BMGOw5xhg9nhLQQ5T+Uk67roYZhc1yn4I0HVn03
	Tei8Bh2PrhkH8R4sZqz29HgtBh3/a/23WvVaDTdvgKsNyoH6WqAP2MCmNDA78cPielSKXDpbY97iT
	iK1b35KAjbZouzyXgu+zyA==;
Received: from [130.117.225.5] (helo=dev004.aci.vzint.dev)
	by relay.virtuozzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aleksey.oladko@virtuozzo.com>)
	id 1vzcNT-006Tev-26;
	Mon, 09 Mar 2026 16:20:10 +0100
Received: from dev004.aci.vzint.dev (localhost [127.0.0.1])
	by dev004.aci.vzint.dev (8.16.1/8.16.1) with ESMTPS id 629FKI05565241
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 9 Mar 2026 15:20:18 GMT
Received: (from root@localhost)
	by dev004.aci.vzint.dev (8.16.1/8.16.1/Submit) id 629FKHsZ565240;
	Mon, 9 Mar 2026 15:20:17 GMT
From: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Aaron Conole <aconole@redhat.com>,
        Ilya Maximets <imaximet@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Stefano Brivio <sbrivio@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev@openvswitch.org,
        Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Subject: [PATCH net v4 1/5] selftests: net: make ovs-dpctl.py fail when pyroute2 is unsupported
Date: Mon,  9 Mar 2026 15:20:09 +0000
Message-ID: <20260309152013.565216-2-aleksey.oladko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309152013.565216-1-aleksey.oladko@virtuozzo.com>
References: <20260309152013.565216-1-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9561A23BB83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=relay];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265590-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksey.oladko@virtuozzo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovs-dpctl.py:url,virtuozzo.com:dkim,virtuozzo.com:email,virtuozzo.com:mid,pmtu.sh:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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


