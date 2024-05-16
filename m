Return-Path: <netdev+bounces-96763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C068C7A55
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 18:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E227B21A8D
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 16:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A02814D702;
	Thu, 16 May 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=paloaltonetworks.com header.i=@paloaltonetworks.com header.b="wodsk4YD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00169c01.pphosted.com (mx0a-00169c01.pphosted.com [67.231.148.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18A22421A
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876880; cv=none; b=DJtmX7mKlEH4x7FSXfHHgCAdNUO8PseMghX3ZQkFei4yWFIwdUv80tR63BYqnW49fB/+rw4tlFIWmHKiH+LHDHOX9KnPCLWBtBgYpyu+RmV1zDUF+tT4JA4NyMg2FAcjssB+NyRmLg05KZgIO9fsqxLpMWhhKdUu7qiqBTJfvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876880; c=relaxed/simple;
	bh=XMD6zcMvQ5PDI85paw/a5UwxdAl+pN8IudMoa8gDHyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jy88/y/N8puvirqkmEfBs15fWtdw9bMOu2hyZ8rdx0/CUJaxEjun0nMlmZuna6WniY6pGptc8KE6v+QUbpqHHioijqCL8UsqKqIAOcDtCuQtvhn3Bq73lX/9bG+MkCXpKcwrEftYcKHF56kpy6UNRDiwi+GihjajBI/5tp0sZaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paloaltonetworks.com; spf=pass smtp.mailfrom=paloaltonetworks.com; dkim=fail (0-bit key) header.d=paloaltonetworks.com header.i=@paloaltonetworks.com header.b=wodsk4YD reason="key not found in DNS"; arc=none smtp.client-ip=67.231.148.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paloaltonetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paloaltonetworks.com
Received: from pps.filterd (m0045114.ppops.net [127.0.0.1])
	by mx0a-00169c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44GFGsUG014768;
	Thu, 16 May 2024 08:43:32 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00169c01.pphosted.com (PPS) with ESMTPS id 3y5dy6j22c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 08:43:32 -0700 (PDT)
Received: from m0045114.ppops.net (m0045114.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 44GFgQc3005705;
	Thu, 16 May 2024 08:43:32 -0700
Received: from webmail.paloaltonetworks.com (webmail.paloaltonetworks.com [199.167.52.51] (may be forged))
	by mx0a-00169c01.pphosted.com (PPS) with ESMTPS id 3y5dy6j228-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 May 2024 08:43:32 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.47.176.16])
	by webmail.paloaltonetworks.com (Postfix) with ESMTPA id 343277F587;
	Thu, 16 May 2024 08:43:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 webmail.paloaltonetworks.com 343277F587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paloaltonetworks.com; s=mail; t=1715874211;
	bh=pA4THMeyayzEIhoj9kBfG6FZCUxQfpFSAI6nwg6OH9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wodsk4YDMD8W5UZ0tCeuD/zv1fWT2sjo2K3vNNtHK83z1WfKLbfuw/tTYG7TXZQPx
	 InV/aq3uSKv7HWW/MB7iqHXNkPKHiS7YJOvzl+BauDHjtrMmVI5wvNaNJhnMKLhZeN
	 gVNfwS/H86/qUZvsaYMREB/7pizX5EBSu1lslvOk=
From: Roded Zats <rzats@paloaltonetworks.com>
To: benve@cisco.com, satishkh@cisco.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: orcohen@paloaltonetworks.com, rzats@paloaltonetworks.com,
        netdev@vger.kernel.org
Subject: [PATCH net] enic: Validate length of nl attributes in enic_set_vf_port
Date: Thu, 16 May 2024 18:42:48 +0300
Message-Id: <20240516154248.33134-1-rzats@paloaltonetworks.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240516065755.6bce136f@kernel.org>
References: <20240516065755.6bce136f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

enic_set_vf_port assumes that the nl attribute IFLA_PORT_PROFILE
is of length PORT_PROFILE_MAX and that the nl attributes
IFLA_PORT_INSTANCE_UUID, IFLA_PORT_HOST_UUID are of length PORT_UUID_MAX.
These attributes are validated (in the function do_setlink in rtnetlink.c)
using the nla_policy ifla_port_policy. The policy defines IFLA_PORT_PROFILE
as NLA_STRING, IFLA_PORT_INSTANCE_UUID as NLA_BINARY and
IFLA_PORT_HOST_UUID as NLA_STRING. That means that the length validation
using the policy is for the max size of the attributes and not on exact
size so the length of these attributes might be less than the sizes that
enic_set_vf_port expects. This might cause an out of bands
read access in the memcpys of the data of these
attributes in enic_set_vf_port.

Fixes: f8bd909183ac ("net: Add ndo_{set|get}_vf_port support for enic dynamic vnics")
Signed-off-by: Roded Zats <rzats@paloaltonetworks.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index f604119efc80..4179c6f9580d 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1117,18 +1117,30 @@ static int enic_set_vf_port(struct net_device *netdev, int vf,
 	pp->request = nla_get_u8(port[IFLA_PORT_REQUEST]);
 
 	if (port[IFLA_PORT_PROFILE]) {
+		if (nla_len(port[IFLA_PORT_PROFILE]) != PORT_PROFILE_MAX) {
+			memcpy(pp, &prev_pp, sizeof(*pp));
+			return -EOPNOTSUPP;
+		}
 		pp->set |= ENIC_SET_NAME;
 		memcpy(pp->name, nla_data(port[IFLA_PORT_PROFILE]),
 			PORT_PROFILE_MAX);
 	}
 
 	if (port[IFLA_PORT_INSTANCE_UUID]) {
+		if (nla_len(port[IFLA_PORT_INSTANCE_UUID]) != PORT_UUID_MAX) {
+			memcpy(pp, &prev_pp, sizeof(*pp));
+			return -EOPNOTSUPP;
+		}
 		pp->set |= ENIC_SET_INSTANCE;
 		memcpy(pp->instance_uuid,
 			nla_data(port[IFLA_PORT_INSTANCE_UUID]), PORT_UUID_MAX);
 	}
 
 	if (port[IFLA_PORT_HOST_UUID]) {
+		if (nla_len(port[IFLA_PORT_HOST_UUID]) != PORT_UUID_MAX) {
+			memcpy(pp, &prev_pp, sizeof(*pp));
+			return -EOPNOTSUPP;
+		}
 		pp->set |= ENIC_SET_HOST;
 		memcpy(pp->host_uuid,
 			nla_data(port[IFLA_PORT_HOST_UUID]), PORT_UUID_MAX);
-- 
2.39.3 (Apple Git-146)


