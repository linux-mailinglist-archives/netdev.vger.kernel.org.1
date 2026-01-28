Return-Path: <netdev+bounces-254306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PtzN1Ahemmv2wEAu9opvQ
	(envelope-from <netdev+bounces-254306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:46:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 633FEA310B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C464430031F7
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6746361DBC;
	Wed, 28 Jan 2026 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="WhkXGyqH"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D48361DA7;
	Wed, 28 Jan 2026 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611491; cv=fail; b=ljrdkZGDonC/EW4jmh/DaPnoQYbNd1vLJUQ+XNYF9Uw5rDd9pzzyGL1U8zTpX0hbR05S7JGEsMHoCryAzakgcI876NrMGFFeWur7LfttjIe2qt7euc+I1rxBToz/IGaYuCCv1cVPI8adSLJ6rjo7q32d0e8b5UBt1XhdRWk1Lcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611491; c=relaxed/simple;
	bh=KVqH9baNfJcxxOKBmrhVwBsytfdkub67wQ/rnwUxTto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzRcNj9BF4GZVUdse4PFiIMVSSL+BA76MmePRATjulSbLdbYzV15C8kQNSBThJK5kEcyjYcIVN1rpaN63X+jE62Mk6zMZYWxQktpd7Nf5o9mgTOJbhnDPzuBCnjTzcNeelMrvG9u1SHN8adVv0e0UgZ5062y3l5OGgGpdsR+kZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=WhkXGyqH; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=linVsnboBUWLj/9ne85PgBwvZEsoPqa+yCLwCeVJLHYpOATwm/5dM7VrLejCvplQTKdMQKI+lw7zphQp/kZkrH7PzkyykLR/WGBX4GWxGC/KDBK6AyINZj2qSMYfjdbnfHHsyOruxptt0faJ/lQL6Hu07dG6iJWdClpKiDmbLUPmOoWgCWXFuxj6Vs+v3sZURFW/s5pfo7p10O5rECaD9Zz63tl1chn/kDHTpelp2tghT1kpL9y225g38eTKaUJzsorTkV+a7NzTyQGd9V1YexaGbjMP7jANAdyv1XHqRdMqP/VktM6wJ5a/romnCGWjqqXiIuyrjDrkfh60WLAMXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+RXSyAkgIraAhc/97tVhNHajm+iZ3GOhMi5SV4phUE=;
 b=ynbN9ygjtLNOj4ZvizhfQ1TxUilj2SRNbIec2Uuy7p3O1XBuZ380TaGKEDGlUVckMBvUcXaKLXuXGpkcGH+1r1ajQLSLmDVuKccbFyfiGEfbxBm8THwHfVbAybxJFJPMgb6UwxZ07/Zt6p7w8CgJA/so5BzUffTVYBoyu0kZuCDAtChfmIz+zdlfXTfQxTQI1UpKwuQhne38I7IqxYZ/AdXnMrPguB4P76sU+Agjkiw5nKhPoTsPrJs2d6DAjqKsg7y1nwhXYRDveg+jVXutCSmro82bbkzrALg9jyXeOYOsrzGp2DZZtGzhDEyz7JQ+CWSSaGOSKVq7cRvK9WW3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+RXSyAkgIraAhc/97tVhNHajm+iZ3GOhMi5SV4phUE=;
 b=WhkXGyqHaIMSknUU582or5AzryUUhlZtQ/a7NsAwsZvgYxec4S05nJloT/VkRiWw2V48QPb277QJU5KtmcGzTcDlCpS0/l2BbePX29k3S6mF49QGcsz6+Z5Pstx+KHQPBjAeBz9zmvxqKKBJxqiC6otodQ0vjHaqvjN/CelDEM/6jkf/9rxWXJASu80R7ffVwXSJWWw+3y3zN7S5dyKLJecFq8aGVpIWh7R2qh1+rbuOwvqV0a12dDqD4I4aMtpKf5iX5aIP4gNeHPaXkpYymena6kia78tLx7xyfwKfJOkkhpkBP50mMvPMqq3tWfGymZtnB2n1aMZy9dRfM3D9Pg==
Received: from AM0PR02CA0120.eurprd02.prod.outlook.com (2603:10a6:20b:28c::17)
 by VI0PR07MB11578.eurprd07.prod.outlook.com (2603:10a6:800:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 14:44:39 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:20b:28c:cafe::d2) by AM0PR02CA0120.outlook.office365.com
 (2603:10a6:20b:28c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 14:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:44:38 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 18E8A203D6;
	Wed, 28 Jan 2026 16:44:37 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v1 net-next 3/3] virtio_net: Accurate ECN flag in virtio_net_hdr
Date: Wed, 28 Jan 2026 15:44:26 +0100
Message-Id: <20260128144426.15870-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128144426.15870-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260128144426.15870-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AE:EE_|VI0PR07MB11578:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2d22aa25-0361-4692-123f-08de5e7bc377
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?qU3Eh1sR5UoCYNqZjpwdKqd6e71f0rtF0eA47S666yN4dla0TGhbdjxO5p+B?=
 =?us-ascii?Q?lsGHykDDqIh8TAds4z49SpfpYYvsXuKI0lEU6yVCk8BwKGLnQDEXpHImN9ST?=
 =?us-ascii?Q?LHWhwjBP8IHSfGyGG20o1E+kJeML3Wk3bI/6up4Quk5rVxJn5SV6bYEQtuIB?=
 =?us-ascii?Q?PvlHjvhNONBKWDCLlf6Lm8u3PDhSXNppdyqN3y0xL+kfNeDcbYSs+d4b5XQe?=
 =?us-ascii?Q?b9kKmX2QrGsyO/bPyFM2Hpxcxc8Om1yJiPfDO1TwcOYgNRD/caTVpkzdafGX?=
 =?us-ascii?Q?n5zNwHgxFdEYevY9bk5Y8Bpc8CAY9PjRVhrfJ2Gcr7ZM4KSTm25PV6cZLB7J?=
 =?us-ascii?Q?WUhn1kvlR2FVUr9kxp3KHRB8hpQVMjmrqYfaR9j8gllDwI/YaR/AVvYBP5Gp?=
 =?us-ascii?Q?1ols00rsirKYaYqRXpYr2KYmSQ7bSkrmcSj4HpwJKUBCKFSF3S2smSTRi0VH?=
 =?us-ascii?Q?wocaUqRkfxnBIoukKfW8PXH7ILleI1OwThFCJoSScAu2/uDZqN1TpxxvmG2r?=
 =?us-ascii?Q?hIlTiN24NEgE8Fy5Rkd8BbvrhE5gXLFyJFkY2dwXOyOzHAIBOixDBfi8w8cs?=
 =?us-ascii?Q?vdTRPwN/kE0m1W2a+IXjakajgdrsq1plgqA8hBbqkMrlify38Gs0ekdHdeoO?=
 =?us-ascii?Q?26Hto5NGDo6cONWsPJOV7OzpVMz5oKn5WBIfz6JPI+zRPDzHSF1PTbdP17El?=
 =?us-ascii?Q?3wwPBoQArUpGTzWFmJviP/0JtwrIIKIg4Pxn8xd4O865HHRY8lp2I4xPe0Ky?=
 =?us-ascii?Q?pDn26jb4xQckDWqo6oycrF6Duv+M6XE1/tSHInv0IA4BlRk2Iy1vDCWCevpN?=
 =?us-ascii?Q?1yUmqkav0a2kBN0878Q2wy9t4UUogVOdkZCcPCY1o3XhzF30/lZXQi0Et4sr?=
 =?us-ascii?Q?rVxkYBpnqrO3vQuLSCZn+bux69EHdDUmPRmipD/5cXSn/ZQBScSKKjsdgY/Y?=
 =?us-ascii?Q?hEX0VzmI9uueCYkKz8etST1PseWEtJt5BnfzlGpb0t39aFHmawx+LoKL64N5?=
 =?us-ascii?Q?9KDla0yVlGDrfibQoqkizh0A95IySHim2xZ6MTs2fqGRkinn1ompySMRZmkp?=
 =?us-ascii?Q?cw8y4+OFC1BUCNiD+lN+OjsWmGKwsrxFqrSPr4QZlAr0vawJOjjThK5lK0+f?=
 =?us-ascii?Q?dnD7UFmKbc2Dyla++f9c1RFc8xQ8eXx7IENhrWwClfn+iw+7HtutR4a+hde3?=
 =?us-ascii?Q?CVCGl2PlDOyUuqu1765IVU6xqP99DYyw6uNCTPTlwWSs9Oucqa2kSzcHEI0o?=
 =?us-ascii?Q?35udL9d9Rpi+TjkvPZpwzIKPGe+Vq5WKsrotJiO60GpBlNfwpQ0OHyTaP4ou?=
 =?us-ascii?Q?D2jHPD7uTV0u0JiX3ZhEiJxUoSboA39eYY6GnZD5DHZc/oV6Osf6IDhTG4vG?=
 =?us-ascii?Q?2hZZgbfv7RFGPVjOAaFXjAWPIC2bxs+2ZlLcctdAcuExj117KnL8x00NKWWy?=
 =?us-ascii?Q?PWTkZJ/ksbN1vbuH4EeIduXUcTwou7Vybl/6XpoF1guZCLwiYkOSgzyqDK7I?=
 =?us-ascii?Q?aV+1ipTR6HhnF+3wRo+rlzRWr6DpXVOukvLi/yHbfertNX6kk/ZVk80+fUL6?=
 =?us-ascii?Q?rLqPjoj8+ARGY0aYEx7KvX97GaaNO6bTqNqOQLEP/w3Zg7lx7+2nAxB1fZ3b?=
 =?us-ascii?Q?1Iy0ugYffPypY0QYArxAUhAw6oOUbuG3Kno7IOWEVxLW1rQqpZaMy84CBZ0e?=
 =?us-ascii?Q?BSiis3K9P9iKw2BqcHfdx/f7go4=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 G0FADuej1NBs9IiTBMNj0QUh4CAq7Kg4G3+m8vjB5p0R6wNd2i7XjMMiK0cuXVEn8i98ELceknPcghtdDUYo+iUxsZxNCxXl1J6Wl8QX33nnM7RXY36F1bXcdTb2GxuNMcJNwqYvSigBNGphD6t0hZNupbyunPxUovTzC77/GTEwLA4H1nqR4phcZwEfznNqXtEoDoriDpbqWqz+UdvwzgSVPOZR5LVbPKUvYpfkWrXvbKBT0DW5D3sfrrq7IB7jkvQcentoUW8F/DJiKn6LCQofBt+wTcutftB8vYo9YyZiYGr3fJVNsRYsqYPKIgPJu4QInuB770wE94HXQRgHCvrrubyl4eEY3Oj97IHjptc1X23YVjrmJCWWhczL8Lnmr/LP9l5dPaNanXCiw0LJSi6Y2U0rrg70/QwzVXs8XzT85Zky8iFPBr/QBhcqOcfT
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:44:38.5811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d22aa25-0361-4692-123f-08de5e7bc377
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11578
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254306-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 633FEA310B
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Unlike RFC 3168 ECN, accurate ECN uses the CWR flag as part of the ACE
field to count new packets with CE mark; however, it will be corrupted
by the RFC 3168 ECN-aware TSO. Therefore, fallback shall be applied by
seting NETIF_F_GSO_ACCECN to ensure that the CWR flag should not be
changed within a super-skb.

To apply the aforementieond new AccECN GSO for virtio, new featue bits
for host and guest are added for feature negotiation between driver and
device. And the translation of Accurate ECN GSO flag between
virtio_net_hdr and skb header for NETIF_F_GSO_ACCECN is also added to
avoid CWR flag corruption due to RFC3168 ECN TSO.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 drivers/net/virtio_net.c        | 14 +++++++++++---
 drivers/vdpa/pds/debugfs.c      |  6 ++++++
 include/linux/virtio_net.h      | 16 ++++++++++------
 include/uapi/linux/virtio_net.h |  5 +++++
 4 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index db88dcaefb20..103fb87c690e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -75,6 +75,7 @@ static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_TSO4,
 	VIRTIO_NET_F_GUEST_TSO6,
 	VIRTIO_NET_F_GUEST_ECN,
+	VIRTIO_NET_F_GUEST_ACCECN,
 	VIRTIO_NET_F_GUEST_UFO,
 	VIRTIO_NET_F_GUEST_CSUM,
 	VIRTIO_NET_F_GUEST_USO4,
@@ -87,6 +88,7 @@ static const unsigned long guest_offloads[] = {
 #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
 			(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
 			(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
+			(1ULL << VIRTIO_NET_F_GUEST_ACCECN) | \
 			(1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
 			(1ULL << VIRTIO_NET_F_GUEST_USO4) | \
 			(1ULL << VIRTIO_NET_F_GUEST_USO6) | \
@@ -5976,6 +5978,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	    && (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ACCECN) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) ||
@@ -6635,6 +6638,7 @@ static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
 	return virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
+		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ACCECN) ||
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
 		(virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) &&
 		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO6));
@@ -6749,6 +6753,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 			dev->hw_features |= NETIF_F_TSO6;
 		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_ECN))
 			dev->hw_features |= NETIF_F_TSO_ECN;
+		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_ACCECN))
+			dev->hw_features |= NETIF_F_GSO_ACCECN;
 		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_USO))
 			dev->hw_features |= NETIF_F_GSO_UDP_L4;
 
@@ -7169,9 +7175,11 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_CSUM, VIRTIO_NET_F_GUEST_CSUM, \
 	VIRTIO_NET_F_MAC, \
 	VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_UFO, VIRTIO_NET_F_HOST_TSO6, \
-	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, \
-	VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_UFO, \
-	VIRTIO_NET_F_HOST_USO, VIRTIO_NET_F_GUEST_USO4, VIRTIO_NET_F_GUEST_USO6, \
+	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_HOST_ACCECN, \
+	VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, \
+	VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_ACCECN, \
+	VIRTIO_NET_F_GUEST_UFO, VIRTIO_NET_F_HOST_USO, \
+	VIRTIO_NET_F_GUEST_USO4, VIRTIO_NET_F_GUEST_USO6, \
 	VIRTIO_NET_F_MRG_RXBUF, VIRTIO_NET_F_STATUS, VIRTIO_NET_F_CTRL_VQ, \
 	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
diff --git a/drivers/vdpa/pds/debugfs.c b/drivers/vdpa/pds/debugfs.c
index c328e694f6e7..90bd95db0245 100644
--- a/drivers/vdpa/pds/debugfs.c
+++ b/drivers/vdpa/pds/debugfs.c
@@ -78,6 +78,9 @@ static void print_feature_bits_all(struct seq_file *seq, u64 features)
 		case BIT_ULL(VIRTIO_NET_F_GUEST_ECN):
 			seq_puts(seq, " VIRTIO_NET_F_GUEST_ECN");
 			break;
+		case BIT_ULL(VIRTIO_NET_F_GUEST_ACCECN):
+			seq_puts(seq, " VIRTIO_NET_F_GUEST_ACCECN");
+			break;
 		case BIT_ULL(VIRTIO_NET_F_GUEST_UFO):
 			seq_puts(seq, " VIRTIO_NET_F_GUEST_UFO");
 			break;
@@ -90,6 +93,9 @@ static void print_feature_bits_all(struct seq_file *seq, u64 features)
 		case BIT_ULL(VIRTIO_NET_F_HOST_ECN):
 			seq_puts(seq, " VIRTIO_NET_F_HOST_ECN");
 			break;
+		case BIT_ULL(VIRTIO_NET_F_HOST_ACCECN):
+			seq_puts(seq, " VIRTIO_NET_F_HOST_ACCECN");
+			break;
 		case BIT_ULL(VIRTIO_NET_F_HOST_UFO):
 			seq_puts(seq, " VIRTIO_NET_F_HOST_UFO");
 			break;
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 75dabb763c65..bbf6fc212259 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -11,7 +11,7 @@
 
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
 {
-	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN_FLAGS) {
 	case VIRTIO_NET_HDR_GSO_TCPV4:
 		return protocol == cpu_to_be16(ETH_P_IP);
 	case VIRTIO_NET_HDR_GSO_TCPV6:
@@ -31,7 +31,7 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	if (skb->protocol)
 		return 0;
 
-	switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+	switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN_FLAGS) {
 	case VIRTIO_NET_HDR_GSO_TCPV4:
 	case VIRTIO_NET_HDR_GSO_UDP:
 	case VIRTIO_NET_HDR_GSO_UDP_L4:
@@ -58,7 +58,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 	unsigned int ip_proto;
 
 	if (hdr_gso_type != VIRTIO_NET_HDR_GSO_NONE) {
-		switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+		switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN_FLAGS) {
 		case VIRTIO_NET_HDR_GSO_TCPV4:
 			gso_type = SKB_GSO_TCPV4;
 			ip_proto = IPPROTO_TCP;
@@ -84,7 +84,9 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 			return -EINVAL;
 		}
 
-		if (hdr_gso_type & VIRTIO_NET_HDR_GSO_ECN)
+		if (hdr_gso_type & VIRTIO_NET_HDR_GSO_ACCECN)
+			gso_type |= SKB_GSO_TCP_ACCECN;
+		else if (hdr_gso_type & VIRTIO_NET_HDR_GSO_ECN)
 			gso_type |= SKB_GSO_TCP_ECN;
 
 		if (hdr->gso_size == 0)
@@ -159,7 +161,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
 		unsigned int nh_off = p_off;
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
-		switch (gso_type & ~SKB_GSO_TCP_ECN) {
+		switch (gso_type & ~(SKB_GSO_TCP_ECN | SKB_GSO_TCP_ACCECN)) {
 		case SKB_GSO_UDP:
 			/* UFO may not include transport header in gso_size. */
 			nh_off -= thlen;
@@ -231,7 +233,9 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
 		else
 			return -EINVAL;
-		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
+		if (sinfo->gso_type & SKB_GSO_TCP_ACCECN)
+			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ACCECN;
+		else if (sinfo->gso_type & SKB_GSO_TCP_ECN)
 			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
 	} else
 		hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 1db45b01532b..af5bfe45aa1f 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,6 +56,8 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
+#define VIRTIO_NET_F_HOST_ACCECN 25	/* Host can handle GSO of AccECN */
+#define VIRTIO_NET_F_GUEST_ACCECN 26	/* Guest can handle GSO of AccECN */
 #define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level statistics. */
 #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
 #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
@@ -165,6 +167,9 @@ struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_GSO_UDP_TUNNEL (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 | \
 				       VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6)
 #define VIRTIO_NET_HDR_GSO_ECN		0x80	/* TCP has ECN set */
+#define VIRTIO_NET_HDR_GSO_ACCECN	0x10	/* TCP AccECN segmentation */
+#define VIRTIO_NET_HDR_GSO_ECN_FLAGS	(VIRTIO_NET_HDR_GSO_ECN | \
+					 VIRTIO_NET_HDR_GSO_ACCECN)
 	__u8 gso_type;
 	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
 	__virtio16 gso_size;	/* Bytes to append to hdr_len per frame */
-- 
2.34.1


