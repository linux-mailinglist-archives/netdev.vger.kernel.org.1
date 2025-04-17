Return-Path: <netdev+bounces-183748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B428A91D42
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C5F5A76D8
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C880F24A04B;
	Thu, 17 Apr 2025 13:03:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9FF2475C7;
	Thu, 17 Apr 2025 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895023; cv=none; b=cbdRyU3ZtFZllA+vt6NQMbUQ4bFbqOJKFjMQTSHcEZLRj2KTOtA7hfHxrpMza0mTf69CKg1hKfr/gg/qeCGgzlKhmUczkOw5eVoAaKmvAEm2h6cBedJFxj9CCdjJJLRdqT9jfvXDP6PnWlJ4f0aGyx1At3Myce1PRqp/OZ6PyUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895023; c=relaxed/simple;
	bh=gHW6P2QpI4eEpDjW2tdunMsPSxMg/QdbH4OoYBTuEoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V3r2UZ2R4PUCdlGJZdUtaFD3KOj5oXqe9OQB5iYgA/RS+NiD4c+bwSXeSjcFMGmfyuvyGhCW2w4dqRZmmimuPH7RNK72SeinEbRzNS2YcH/cad6NwwscsImdA46Gu4CPQcTJRVIj+hXuue312Kt/W8HiYRymZ9eIjwdmxjI5/Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso1406877a12.3;
        Thu, 17 Apr 2025 06:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744895020; x=1745499820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AutvC+U3QHOO+X197OHtCyJb0BVhDeo5m3JbUAKORWo=;
        b=qpOoQIHaYsFgv54J8d1il4c9JPDjU16v16VNjghea1ywu4FsudinOzf6QHSBerDDIm
         KhcFsylz/04sielEvdpMXb3qCa2ACSHFEGvjQhmeX7P8O8Xlz8ZTtn9FcNwSBPHvDhN/
         Z7vnU9IO7TzFIKwRIazsFhl59m6KECTlhppCSV8CZlvi9lG/HN/tY1wiXOYSfWgd5Ffe
         yg5Z8i5KxYSgzdE8qNWuO2bOKBX1UogP4vxrBsVCE9iMt/t5vbXYUv0VhgwINTbcNnVk
         aBhQbIbbYyWiS7UxhqLxmYHCDBg4x2B6208Eu/xKZk9oSe1XWcsURT+vlE6Qsdyu1KEk
         HRvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOoq7uPyxQ4mQRqaKXJP3/b/mQBLW0oi87d9oJvqVPdsOe3+cYoxhElM+l/5TMXasAGtxnGCW6+ytkWlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhGhgFgm0p4f01TpX7epUKKPgVFVoIEhq4sa9mt1/ow+QsUQUq
	pxN02ifN9uz1bXRtY/xpwWVoxhLaFfauJdDXs+eA73yLLUgq3vqp
X-Gm-Gg: ASbGncs1Dz8slDT3wJyNXwBASxJ+y3b/fqQWbkLLkZCAHHmKOLDshuDdJUHSwteu5sv
	DtRqgjHrelmr0uFSaS+cZJpkVm1TPse5htJK7bilgoAN8ohu+7nMl+u216jBjoFmKifOMZV8nA6
	nMoA7qvn/1BeGx+7nliUyvfUF6pm1QGiNLQlZi4JVsITDzdn5ueWjIGiz5gAVu1ZGKygEiXSnGu
	yOcpxYOS6PA9GjlooFE8Q/HKBI6Z7ocGoRF+oh9Jjm5rhC9KqTaGmnWaH5N03QTMjOG7ZypI1IV
	HFafWM9z30H5KLLM3S6sxTFqK9PXWWyrSQLU8x6aug==
X-Google-Smtp-Source: AGHT+IET++hQzwpLiSXA7X7cR7lGATwouvwe+ipToYpgvPnBvdl+4Lk57vihhbCnYPGP/ljH713DuQ==
X-Received: by 2002:a17:907:3cd5:b0:ac8:179a:42f5 with SMTP id a640c23a62f3a-acb428f0f9emr496144266b.14.1744895019752;
        Thu, 17 Apr 2025 06:03:39 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3cd636adsm293548166b.14.2025.04.17.06.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 06:03:39 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 17 Apr 2025 06:03:08 -0700
Subject: [PATCH net-next 2/2] net: Use nlmsg_payload in rtnetlink file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-nlmsg_v3-v1-2-9b09d9d7e61d@debian.org>
References: <20250417-nlmsg_v3-v1-0-9b09d9d7e61d@debian.org>
In-Reply-To: <20250417-nlmsg_v3-v1-0-9b09d9d7e61d@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 kuniyu@amazon.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3917; i=leitao@debian.org;
 h=from:subject:message-id; bh=gHW6P2QpI4eEpDjW2tdunMsPSxMg/QdbH4OoYBTuEoM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoAPwmkQqcPiPmwEcyf55VbWBttQqqnW30qGVfm
 yoobs8PSaiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaAD8JgAKCRA1o5Of/Hh3
 bU6tEACm5bflh9wPvPRjiZ/rRpkuMoJ1cVWxIao4FikcVT10lbSS48bC8UKirwv/N/NO4IBKAoF
 8mmx/Owj1x57EHbxZ8oTdd2sgfmArWrfrMBMRijpftdJCNvkRWdzIlcfHBZ3GhygTQ3YPMgd8pB
 li2WZRQS3YZpEQdiWm3TRZjVkVLiejWYlBQ505LXoOVhZWj4Nu9znlshLtJNCZsU45WzVdvcCX1
 8s9zrWKXCWr2GN+cN/kyakYP8P6c+yK4LpUAdtR0Mv6ZQIYbrBJWoiDDk+Zr0HkeU+tXD8qn733
 8YdGn7IAfYZsa1wbzhHKvvJOsh4koGEE1NwE44Bkfae3GkqcBVkdlcOrHN6W8CgzXmeEq4piSKb
 9zyNx+J5UwDbaUDwRLK55B6IsWHtJhbLNGzBrcThLbf4cxq0df1y1Cwsao3PswF0KxWFTjYvZ1S
 XcD/zTpoq8fgIXAHyGmgXROCeEe8XQPd0y6RyVlnJeRtjQVE//5SpNi2eMqb4aqRSLiuy/SjT14
 5wcp4klGdEQfT1N1tKbf/8qIoOSSOl9LERGai/W5C+By8FXNXF2gGDiToSLSUUK0IbW3+hmrt5u
 trSn1gNMA/0NV7Btrup/rwadfJzsLPnti7ooZn3z1mUmThfcB5CXP2W0Lclsqo/VVmj4RWsEcn6
 gXQWubbAIcS03Rw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/rtnetlink.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f5c018090efc3..3becb79a97c69 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2390,12 +2390,12 @@ static int rtnl_valid_dump_ifinfo_req(const struct nlmsghdr *nlh,
 	if (strict_check) {
 		struct ifinfomsg *ifm;
 
-		if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ifm))) {
+		ifm = nlmsg_payload(nlh, sizeof(*ifm));
+		if (!ifm) {
 			NL_SET_ERR_MSG(extack, "Invalid header for link dump");
 			return -EINVAL;
 		}
 
-		ifm = nlmsg_data(nlh);
 		if (ifm->__ifi_pad || ifm->ifi_type || ifm->ifi_flags ||
 		    ifm->ifi_change) {
 			NL_SET_ERR_MSG(extack, "Invalid values in header for link dump request");
@@ -4087,7 +4087,8 @@ static int rtnl_valid_getlink_req(struct sk_buff *skb,
 	struct ifinfomsg *ifm;
 	int i, err;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ifm))) {
+	ifm = nlmsg_payload(nlh, sizeof(*ifm));
+	if (!ifm) {
 		NL_SET_ERR_MSG(extack, "Invalid header for get link");
 		return -EINVAL;
 	}
@@ -4096,7 +4097,6 @@ static int rtnl_valid_getlink_req(struct sk_buff *skb,
 		return nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFLA_MAX,
 					      ifla_policy, extack);
 
-	ifm = nlmsg_data(nlh);
 	if (ifm->__ifi_pad || ifm->ifi_type || ifm->ifi_flags ||
 	    ifm->ifi_change) {
 		NL_SET_ERR_MSG(extack, "Invalid values in header for get link request");
@@ -5055,12 +5055,12 @@ static int valid_fdb_get_strict(const struct nlmsghdr *nlh,
 	struct ndmsg *ndm;
 	int err, i;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ndm))) {
+	ndm = nlmsg_payload(nlh, sizeof(*ndm));
+	if (!ndm) {
 		NL_SET_ERR_MSG(extack, "Invalid header for fdb get request");
 		return -EINVAL;
 	}
 
-	ndm = nlmsg_data(nlh);
 	if (ndm->ndm_pad1  || ndm->ndm_pad2  || ndm->ndm_state ||
 	    ndm->ndm_type) {
 		NL_SET_ERR_MSG(extack, "Invalid values in header for fdb get request");
@@ -5327,12 +5327,12 @@ static int valid_bridge_getlink_req(const struct nlmsghdr *nlh,
 	if (strict_check) {
 		struct ifinfomsg *ifm;
 
-		if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ifm))) {
+		ifm = nlmsg_payload(nlh, sizeof(*ifm));
+		if (!ifm) {
 			NL_SET_ERR_MSG(extack, "Invalid header for bridge link dump");
 			return -EINVAL;
 		}
 
-		ifm = nlmsg_data(nlh);
 		if (ifm->__ifi_pad || ifm->ifi_type || ifm->ifi_flags ||
 		    ifm->ifi_change || ifm->ifi_index) {
 			NL_SET_ERR_MSG(extack, "Invalid values in header for bridge link dump request");
@@ -6224,7 +6224,8 @@ static int rtnl_valid_stats_req(const struct nlmsghdr *nlh, bool strict_check,
 {
 	struct if_stats_msg *ifsm;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ifsm))) {
+	ifsm = nlmsg_payload(nlh, sizeof(*ifsm));
+	if (!ifsm) {
 		NL_SET_ERR_MSG(extack, "Invalid header for stats dump");
 		return -EINVAL;
 	}
@@ -6232,8 +6233,6 @@ static int rtnl_valid_stats_req(const struct nlmsghdr *nlh, bool strict_check,
 	if (!strict_check)
 		return 0;
 
-	ifsm = nlmsg_data(nlh);
-
 	/* only requests using strict checks can pass data to influence
 	 * the dump. The legacy exception is filter_mask.
 	 */
@@ -6461,12 +6460,12 @@ static int rtnl_mdb_valid_dump_req(const struct nlmsghdr *nlh,
 {
 	struct br_port_msg *bpm;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*bpm))) {
+	bpm = nlmsg_payload(nlh, sizeof(*bpm));
+	if (!bpm) {
 		NL_SET_ERR_MSG(extack, "Invalid header for mdb dump request");
 		return -EINVAL;
 	}
 
-	bpm = nlmsg_data(nlh);
 	if (bpm->ifindex) {
 		NL_SET_ERR_MSG(extack, "Filtering by device index is not supported for mdb dump request");
 		return -EINVAL;

-- 
2.47.1


