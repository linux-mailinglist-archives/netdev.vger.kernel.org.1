Return-Path: <netdev+bounces-144599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C21439C7E5E
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86956287375
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 22:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4720A18BC15;
	Wed, 13 Nov 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpETqUIk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945D33CFC;
	Wed, 13 Nov 2024 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731537877; cv=none; b=prq/E3PqNKK94Mp31o5IqdOzxYjyeGtLDP/APxXszdtriLoXjYMZgBaOSMo9Y0Rd5wZS7N7llB2+9JsfRzivOGgliy6aDBT5WdDe+2eBkX+aahCIkZQS1VP8j2WHhcNkFwbDFklECvZM6mfljdwlRTbRGYLakYbtmwRdgTqcN+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731537877; c=relaxed/simple;
	bh=N58P4q4lCdVrf6TQYPmaD0lMDPBedKa/hu3WuH9XNYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o1t8kapEQHXsk01KwmO8PhakJNY4d6UFIedLfmX9rc3SLrePzH0II1UsE4z2IBeeUQFeN3TUVLlJiJOlelN8x29WLqNgA5MK+gPkPKih18hxJIL0KFdksG3xgJ3dN0PaZEWjaTyaMIQK2O1+g6EKfO1Gfk+zL8ylDMUQUo9M8e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpETqUIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86B5AC4CEC3;
	Wed, 13 Nov 2024 22:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731537876;
	bh=N58P4q4lCdVrf6TQYPmaD0lMDPBedKa/hu3WuH9XNYc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=GpETqUIkijgVkNs5+eV6wu0wfbgf9wOy0lXiEXAEphg0PiQnNVNTW12DxBPr3A3Jz
	 B4Y9Eno9NgkSixNIBOQCTMDiTnGNdxqpdqvyNyT4vOlhIO0wcTT/cH0ZonR0lPx6eu
	 CkoVkZBUdplIu9pERqlxsyodfX5cO8ce/NONPTayXBNVS1ER+86qKUkCkYygZrtC4g
	 OWCoGoqKdcQn/aLxXYFjjcDn1FUeyEXG+mjCA2tp63OtPa7qJG0xPhfY9ExNGlLpdB
	 bNkiZ3w4XqHFVg1YXJz/a9IEluJidcNPuNiCEsET9K8JbcraPgiZgEhkgkxdo6+p2D
	 oHE5fTyFXq/6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76381D637B2;
	Wed, 13 Nov 2024 22:44:36 +0000 (UTC)
From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Thu, 14 Nov 2024 04:14:25 +0530
Subject: [PATCH] Add string check in netlink_ack_tlv_fill
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-fix-netlink_ack_tlv_fill-v1-1-47798af4ac96@iiitd.ac.in>
X-B4-Tracking: v=1; b=H4sIAMgrNWcC/x2MQQqAIBAAvxJ7TmjNOvSVCLFca0ksVCKI/p50H
 JiZBxJFpgRD9UCkixMfoQDWFSybCSsJtoVBNlIhohKObxEoew67Nsuus7+0Y+8FKju3be9shx2
 U/IxU3H89Tu/7ATWBNE5qAAAA
X-Change-ID: 20241114-fix-netlink_ack_tlv_fill-14db336fd515
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Anup Sharma <anupnewsmail@gmail.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com, 
 Manas <manas18244@iiitd.ac.in>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731537875; l=1252;
 i=manas18244@iiitd.ac.in; s=20240813; h=from:subject:message-id;
 bh=55t/60GTBCQ0um8FTkqO5lX7EGbdb4Ol8yhNWltdE64=;
 b=Dutv3+0ZVkkyixd98LfdaPQEUh3KmgL6tLg6uXmbTzGITq+LHuULss4o3k+J93nbqDZa3kCHY
 iBwnWQ0I9BCCuEPQX0vSxMaQLil+0fYwkpdds4/SALQSJiB4SXIWfeS
X-Developer-Key: i=manas18244@iiitd.ac.in; a=ed25519;
 pk=pXNEDKd3qTkQe9vsJtBGT9hrfOR7Dph1rfX5ig2AAoM=
X-Endpoint-Received: by B4 Relay for manas18244@iiitd.ac.in/20240813 with
 auth_id=196
X-Original-From: Manas <manas18244@iiitd.ac.in>
Reply-To: manas18244@iiitd.ac.in

From: Manas <manas18244@iiitd.ac.in>

netlink_ack_tlv_fill crashes when in_skb->data is an empty string. This
adds a check to prevent it.

Reported-by: syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d4373fa8042c06cefa84
Signed-off-by: Manas <manas18244@iiitd.ac.in>
---
netlink_ack_tlv_fill crashes when in_skb->data is an empty string. This
adds a check to prevent it.
---
 net/netlink/af_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 0a9287fadb47a2afaf0babe675738bc43051c5a7..ea205a4f81e9755a229d46a7e617ce0c090fe5e3 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2205,7 +2205,7 @@ netlink_ack_tlv_fill(struct sk_buff *in_skb, struct sk_buff *skb,
 	if (!err)
 		return;
 
-	if (extack->bad_attr &&
+	if (extack->bad_attr && strlen(in_skb->data) &&
 	    !WARN_ON((u8 *)extack->bad_attr < in_skb->data ||
 		     (u8 *)extack->bad_attr >= in_skb->data + in_skb->len))
 		WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_OFFS,

---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20241114-fix-netlink_ack_tlv_fill-14db336fd515

Best regards,
-- 
Manas <manas18244@iiitd.ac.in>



