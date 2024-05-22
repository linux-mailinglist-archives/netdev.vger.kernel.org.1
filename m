Return-Path: <netdev+bounces-97502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99B98CBC14
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 09:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F221FB21028
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 07:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7BC770E4;
	Wed, 22 May 2024 07:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=paloaltonetworks.com header.i=@paloaltonetworks.com header.b="Gl8uFERd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00169c01.pphosted.com (mx0a-00169c01.pphosted.com [67.231.148.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2F113FF9
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716363104; cv=none; b=Po+T2mHELd1+DdqiG4xum/f2BajsyhtcpV19424MMkUplIroo72upeYQoYzj0hamNbrAeZXSqBnKkjkytUbkFaSkXxBESQowaI08PvrVCjJ4/l1ws9KfyFLV3RjyqHYmi31CCJgeRQMXSnOf20MfTkl9up+pR/1eEZzjDwPCOOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716363104; c=relaxed/simple;
	bh=HMhKu2Zjmnj2Xd/DKZgooJ7r37CEB9DNShLdFSu/K/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XRnTyDK+5MsXBaJ/TkTMGEPaWVA5HhwdY6EGsxisD/RtEd5o6oJ+BYCuUqA7xhmxPoYqA5o6Hzzyp7W74Cg5B/ldqMl94lc/n8fnz9oQv7N7CwFaW5Slg5vkRR09Ih28eDhvvduTvo3hNeBOFDt69Hye+X7IG2E7Lv1gsmIKGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paloaltonetworks.com; spf=pass smtp.mailfrom=paloaltonetworks.com; dkim=fail (0-bit key) header.d=paloaltonetworks.com header.i=@paloaltonetworks.com header.b=Gl8uFERd reason="key not found in DNS"; arc=none smtp.client-ip=67.231.148.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paloaltonetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paloaltonetworks.com
Received: from pps.filterd (m0281123.ppops.net [127.0.0.1])
	by mx0b-00169c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44M1UtLJ010920;
	Wed, 22 May 2024 00:31:19 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00169c01.pphosted.com (PPS) with ESMTPS id 3y8sw6dw2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 00:31:19 -0700 (PDT)
Received: from m0281123.ppops.net (m0281123.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 44M7PUHd010877;
	Wed, 22 May 2024 00:31:18 -0700
Received: from webmail.paloaltonetworks.com (webmail.paloaltonetworks.com [199.167.52.51] (may be forged))
	by mx0b-00169c01.pphosted.com (PPS) with ESMTPS id 3y8sw6dw2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 00:31:18 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.196.72.55])
	by webmail.paloaltonetworks.com (Postfix) with ESMTPA id 35E2E7F5A7;
	Wed, 22 May 2024 00:31:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 webmail.paloaltonetworks.com 35E2E7F5A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paloaltonetworks.com; s=mail; t=1716363077;
	bh=1XvVZHpaN4/AVvZbPKq9OUb8euwGn7/+2aMNkZ73CnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gl8uFERdToxXOzUHqvrDGGZb99lVYD+A3iK+v+1bqQwQpHdYVLFLm03XOvZeczEzf
	 MeS4xVFWff2SKhkNmvmGmV8Cc4gEQB30xL2QjvjYcrXQm1wGjeJQTtgJXm8LLWSazo
	 wbUkAvUjDgWwrnb7byQsgRlk6Y8x+A4Cw9MZbs8M=
From: Roded Zats <rzats@paloaltonetworks.com>
To: benve@cisco.com, satishkh@cisco.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: orcohen@paloaltonetworks.com, rzats@paloaltonetworks.com,
        netdev@vger.kernel.org
Subject: [PATCH net v2] enic: Validate length of nl attributes in enic_set_vf_port
Date: Wed, 22 May 2024 10:30:44 +0300
Message-Id: <20240522073044.33519-1-rzats@paloaltonetworks.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <81d39fab6a85981b28329a67b454ca92e7e377f8.camel@redhat.com>
References: <81d39fab6a85981b28329a67b454ca92e7e377f8.camel@redhat.com>
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
index f604119efc80..5f26fc3ad655 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1117,18 +1117,30 @@ static int enic_set_vf_port(struct net_device *netdev, int vf,
 	pp->request = nla_get_u8(port[IFLA_PORT_REQUEST]);
 
 	if (port[IFLA_PORT_PROFILE]) {
+		if (nla_len(port[IFLA_PORT_PROFILE]) != PORT_PROFILE_MAX) {
+			memcpy(pp, &prev_pp, sizeof(*pp));
+			return -EINVAL;
+		}
 		pp->set |= ENIC_SET_NAME;
 		memcpy(pp->name, nla_data(port[IFLA_PORT_PROFILE]),
 			PORT_PROFILE_MAX);
 	}
 
 	if (port[IFLA_PORT_INSTANCE_UUID]) {
+		if (nla_len(port[IFLA_PORT_INSTANCE_UUID]) != PORT_UUID_MAX) {
+			memcpy(pp, &prev_pp, sizeof(*pp));
+			return -EINVAL;
+		}
 		pp->set |= ENIC_SET_INSTANCE;
 		memcpy(pp->instance_uuid,
 			nla_data(port[IFLA_PORT_INSTANCE_UUID]), PORT_UUID_MAX);
 	}
 
 	if (port[IFLA_PORT_HOST_UUID]) {
+		if (nla_len(port[IFLA_PORT_HOST_UUID]) != PORT_UUID_MAX) {
+			memcpy(pp, &prev_pp, sizeof(*pp));
+			return -EINVAL;
+		}
 		pp->set |= ENIC_SET_HOST;
 		memcpy(pp->host_uuid,
 			nla_data(port[IFLA_PORT_HOST_UUID]), PORT_UUID_MAX);
-- 
2.39.3 (Apple Git-146)


