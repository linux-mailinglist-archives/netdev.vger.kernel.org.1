Return-Path: <netdev+bounces-93068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA188B9E81
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 18:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4CD284AEE
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 16:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E5915B559;
	Thu,  2 May 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=paloaltonetworks.com header.i=@paloaltonetworks.com header.b="GMKQkT08"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00169c01.pphosted.com (mx0a-00169c01.pphosted.com [67.231.148.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20F815CD40
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667107; cv=none; b=s8KtNJgt82ZN67kQm4AciMFwFw/sgpIwYrjAkLT9IHA8K76Mj6lDCJN3q1C7eTFe93LaXyi68FAkq1/o0c71iLoWgfUYYRd7lzwcIIGlK6aEMVlSqdJvGI8MfFHpbOuqvMxG1KdxFJungipitslNNDpUo1oqBLJ5q8DUFTL/++I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667107; c=relaxed/simple;
	bh=mUvgMqaJ60A8brdvJl3yWx+HCM674YlQqgjYokl7iyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S6OYETybKxp2z8GWKJhJwGVQEGAxgqCXarq8LEzQp419GJVQxqJ0JfMBl5oxGztBZHORnMen3P80qcmlg05zFT/+6RtmXkWVQxgDNJKnOIqF51oXZzGTqvzx+nRYl9gRT/c9iu0RCQKrt6ZRG1KeMxpdRVirDd5+QoBkzOu1W7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paloaltonetworks.com; spf=pass smtp.mailfrom=paloaltonetworks.com; dkim=fail (0-bit key) header.d=paloaltonetworks.com header.i=@paloaltonetworks.com header.b=GMKQkT08 reason="key not found in DNS"; arc=none smtp.client-ip=67.231.148.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paloaltonetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paloaltonetworks.com
Received: from pps.filterd (m0281123.ppops.net [127.0.0.1])
	by mx0b-00169c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 442BQHbf005239;
	Thu, 2 May 2024 09:01:10 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00169c01.pphosted.com (PPS) with ESMTPS id 3xu34tm9h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 09:01:10 -0700 (PDT)
Received: from m0281123.ppops.net (m0281123.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 442G19Mu002569;
	Thu, 2 May 2024 09:01:09 -0700
Received: from webmail.paloaltonetworks.com (webmail.paloaltonetworks.com [199.167.52.51] (may be forged))
	by mx0b-00169c01.pphosted.com (PPS) with ESMTPS id 3xu34tm9gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 09:01:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.47.128.233])
	by webmail.paloaltonetworks.com (Postfix) with ESMTPA id F25FB7F5CE;
	Thu,  2 May 2024 09:01:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 webmail.paloaltonetworks.com F25FB7F5CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paloaltonetworks.com; s=mail; t=1714665668;
	bh=q72EdBxkSW6srP86SETdwliTd4Nie4IqxsOE7zkLRjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMKQkT08wQgufhAkmO7UujLXtStDoSLmcp4leD0jP2R7Tgiw4WvIsEVM8GvGvN5xQ
	 TyQiBRBPce3vjVDNVjGNuZEI+ULdcho9BATf+CYpksVrR9ixBj1w6W5PvV/3IohoTA
	 1tEv/7FibefqjJV2XjaGNXxu4m7wQmtrNG/404ow=
From: Roded Zats <rzats@paloaltonetworks.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: orcohen@paloaltonetworks.com, rzats@paloaltonetworks.com,
        netdev@vger.kernel.org
Subject: [PATCH net] rtnetlink: Correct nested IFLA_VF_VLAN_LIST attribute validation
Date: Thu,  2 May 2024 18:57:51 +0300
Message-Id: <20240502155751.75705-1-rzats@paloaltonetworks.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240502064226.633cd9de@kernel.org>
References: <20240502064226.633cd9de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each attribute inside a nested IFLA_VF_VLAN_LIST is assumed to be a
struct ifla_vf_vlan_info so the size of such attribute needs to be at least
of sizeof(struct ifla_vf_vlan_info) which is 14 bytes.
The current size validation in do_setvfinfo is against NLA_HDRLEN (4 bytes)
which is less than sizeof(struct ifla_vf_vlan_info) so this validation
is not enough and a too small attribute might be cast to a
struct ifla_vf_vlan_info, this might result in an out of bands
read access when accessing the saved (casted) entry in ivvl.

Fixes: 79aab093a0b5 ("net: Update API for VF vlan protocol 802.1ad support")
Signed-off-by: Roded Zats <rzats@paloaltonetworks.com>
---
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a3d7847ce69d..8ba6a4e4be26 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2530,7 +2530,7 @@ static int do_setvfinfo(struct net_device *dev, struct nlattr **tb)
 
 		nla_for_each_nested(attr, tb[IFLA_VF_VLAN_LIST], rem) {
 			if (nla_type(attr) != IFLA_VF_VLAN_INFO ||
-			    nla_len(attr) < NLA_HDRLEN) {
+			    nla_len(attr) < sizeof(struct ifla_vf_vlan_info)) {
 				return -EINVAL;
 			}
 			if (len >= MAX_VLAN_LIST_LEN)
-- 
2.39.3 (Apple Git-146)


