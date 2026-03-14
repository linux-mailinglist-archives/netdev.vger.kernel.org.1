Return-Path: <netdev+bounces-267843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAAsMIO8tWlD4QAAu9opvQ
	(envelope-from <netdev+bounces-267843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:52:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E88D28EACD
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EBEE302BA58
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C5A37F727;
	Sat, 14 Mar 2026 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FwfNWQce"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A534D4D2
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773517894; cv=none; b=JUd+ObP2xJxvNNS/QzeaYYg1kOd7Akb0dCaz/PnpDp13ast6N3tkNraJQNXTRsvvknjwS6y6DN5CRUgyvAZlPT3SzSj195WJQTTCx6eERgsDkqdrytHY07cQ7B/dl0rbR25sAh4zVlLCPZZGQ31MAsS0+GH6E4wvns+jsNnnbzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773517894; c=relaxed/simple;
	bh=OZ9OFmbP6TuS9LH8ItorPkelJsuPf6A9rFHE2B/4++w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GunkqVhixYqK6FzjUwbYvLVvH3q7URWrpLeA76zWwjTrHdJguDuGJVF+yq5tbsZBK2O0UUizJRFuxokHb28W4PnbvlCrD5FDiSPHbYFXcdJOlexiifiNBkuJctXJYQ7pSHd1EbQTTPPvfOOHjvc+9QXV5iGb9TJN1WfPCvVYFww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FwfNWQce; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62EJl7v82386939;
	Sat, 14 Mar 2026 19:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=+Bm3WQs61NBk2odbiUk+GUajtdIC1
	6elXxbzY6aHLxo=; b=FwfNWQceJLbFwQhyHm4YW3KkHdx5uRL9m8wK5HaD/HLII
	5sDK1ZSB1s/Ilsn4qBP/ARpHq0e2564VK0jT+Gn2M4B4SQP5kUnGlWOsXiasO3UE
	pzJDPSHV0DjDOcI5XKoyzV2mLPlOekO+jOaXdpDSgFI5eOBR/QI+LiJeC+ibrceN
	sgHg/RI9lC4Thw8ajQV6jsJefbdJUOHg+UT2MkU+Tb43vGxzGUMI9oARq5xZX5jT
	mhWXGdCZHKsRpe2o63ryEttDKbsJqFTtR7uoiGhdQQOyK/5w8IA9hWfHRVdNKK4K
	3efIcVwLdDwi0w7vuTxi8VKQ6w1ISP1W0veJleuug==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk88e7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Mar 2026 19:51:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62EDREg9013988;
	Sat, 14 Mar 2026 19:51:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4785fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Mar 2026 19:51:12 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62EJpBKP012188;
	Sat, 14 Mar 2026 19:51:11 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cvx4785f3-1;
	Sat, 14 Mar 2026 19:51:11 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: linux-afs@lists.infradead.org, marc.dionne@auristor.com,
        dhowells@redhat.com, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org
Cc: alok.a.tiwari@oracle.com, netdev@vger.kernel.org
Subject: [PATCH net-next] rxrpc: Correct rack timer warning to report unexpected mode
Date: Sat, 14 Mar 2026 12:51:00 -0700
Message-ID: <20260314195109.3867287-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_06,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603140155
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDE1NSBTYWx0ZWRfX29ho9eviCWyI
 fDcr6nKsgcS4kPgfZrAF3EkiBP3OExX0xCkN2phRAtszm0xY/a42P0mgZtG6HnE+pY9xFetvL5I
 6EFDlNwPP45FGA4bU2CaCEzLafe1LdldLJ9rZp0xs3TdBE67OcHmSVtUo0jHE3NdDgV1zkPwMSS
 1E3AJ/d0AHrw6eZGLoldQgFqXwY7qlJENKldODs6LHs58WbM6gEJkNpXCn+3bK3lXGB1hS/H/W3
 iGlaYLjgEsyvlnyJaB4xeBAoAMad4SCK6fYajsMNrBNalxY7VD8lS5mkLuAMYOMCT0ne+ofEfuT
 0x7QbIA9SoK50INyH5Pro0FqzUafYfpPwGYp3zlvMgnwLUrjJznC7WQgScliBbmP6tTZf1xtin+
 IUNg0VZxNxh1z+IQckIiMQ4ZPV5GJo8GU28keQotolqjIxY5SruiKeVz/nRJvRo/rKmx3KG3DeN
 56B0jjPiQ4TSFIS92yA==
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69b5bc31 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=agrZ4vOEPjAMkMzM_KgA:9
X-Proofpoint-GUID: SgdAnQxKcFqrmPFdoDoUQN2F-lWodJ3M
X-Proofpoint-ORIG-GUID: SgdAnQxKcFqrmPFdoDoUQN2F-lWodJ3M
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_SEVEN(0.00)[9];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-267843-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: 3E88D28EACD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rxrpc_rack_timer_expired() clears call->rack_timer_mode to OFF before
the switch. The default case warning therefore always prints OFF and
doesn't identify the unexpected timer mode.

Log the saved mode value instead so the warning reports the actual
unexpected rack timer mode.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 net/rxrpc/input_rack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
index 13c371261e0a..9eb109ffba56 100644
--- a/net/rxrpc/input_rack.c
+++ b/net/rxrpc/input_rack.c
@@ -413,6 +413,6 @@ void rxrpc_rack_timer_expired(struct rxrpc_call *call, ktime_t overran_by)
 		break;
 	//case RXRPC_CALL_RACKTIMER_ZEROWIN:
 	default:
-		pr_warn("Unexpected rack timer %u", call->rack_timer_mode);
+		pr_warn("Unexpected rack timer %u", mode);
 	}
 }
-- 
2.50.1


