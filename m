Return-Path: <netdev+bounces-24018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A85F876E787
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3792820F1
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD731ED44;
	Thu,  3 Aug 2023 11:57:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB041DDF6
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:57:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DFC3AB6
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTXYP7JihFKTKEMR8M7PuMsviPsSqExcRftSiIkSltzGY1ZJL65dEFhRS+q+1Ch7sN7jq2t/pbR5VHWhZJq4rorGPElWd8zGv0u3emIV0pQXPWzhuRDkxC1mYaA5Sbxo+eQ50njhmvU3MX0vwANRiE8xAl6qeGMI6h49JSOM/fDtwM0x3hKMOuRzAfKtcK1UP7SwyplBdFB09d4R9FfgPUy216GQ0+BHsdR1Mel/GWBCs1/aLDof1xvZcr7XQdM9+IMaxxJkLAE9H4cSuLFODDtIvo2aRgjntnOiVxsIy/IqP8hrJHurpoMMZJ2CAS7hwFWYDhxKS6nN50clMsDUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ru3D9IaloVsjsrJSCdIpEDMAzqdQ+IG3B8T6ig53QAU=;
 b=TU3tHC4GxGDl1PS5Ca+roZ5bYwHBoXNzLxCKov2phoQcqUaBWLc1DyPIQ2IZuIotlzYK8sB8j1UPfUsuvCBsSsZprtkH7qWPUrQgy388ot7zsbXifM3B0fw6tR+pZnpse5ZO7A71WjhsdKzufz4FodG9X1FMcjY+G96kIfwmTp80Hr66rhpyuhHemVeGALyzBmOCv/qyT0OIMouO2Kea37Lxq/NGUT/vFNX3ZgWHrtRgSt53lDoo5xzPBVqM0DnQsgXsPYrivNFqd4AxAvNYWl4YIGNAfpYAJcamcjlKZg+ojTqSbvql/hzfo1a4aWtKNiHO7vzEqUKRwT+IoXDHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru3D9IaloVsjsrJSCdIpEDMAzqdQ+IG3B8T6ig53QAU=;
 b=xDiuoTG8aJE4o/O+TWXJb9Khl08a6VhfVIMErVEvaknf1g8ns03jhjrBQUYHmtpn/cTXoheo5JJDZAISTECT+8RdOKgnMyNkIu2mOLovS8/r1IZnRCR1cqfwuDnyAxUP6DDFHgzpBuOuHL9HjNmRI1/b3HdUseqEZDzBrI+k/+o=
Received: from MW4PR04CA0104.namprd04.prod.outlook.com (2603:10b6:303:83::19)
 by BL3PR12MB6572.namprd12.prod.outlook.com (2603:10b6:208:38f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 11:57:34 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::fc) by MW4PR04CA0104.outlook.office365.com
 (2603:10b6:303:83::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 11:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 11:57:33 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 06:57:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 04:57:31 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 3 Aug 2023 06:57:30 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH net-next 3/7] sfc: functions to insert/remove conntrack entries to MAE hardware
Date: Thu, 3 Aug 2023 12:56:19 +0100
Message-ID: <01659b7841b486f18fcd7e7a52b4db70bbb1fe8b.1691063676.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1691063675.git.ecree.xilinx@gmail.com>
References: <cover.1691063675.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|BL3PR12MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: a4492b30-ff2b-4e65-9843-08db9418d292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NZj9T/SpzCUbtDWWxqkk6yga9Rs6jM7OV9MsXWWuuSxsYrDnIZssQhttXifO3p6tSXQ3mTv0Zh+H/JENyCAQ3+3eKhyWPr8HCykj46nshabjQWtYc0teetCV7o/voug9aCyaH27WJ++6HYK9mW09Xmx5eEkJrPq67AmeUtfEzQzU0AAiwh4E/WKpPMExf27dzhPgjI9sXGygmGejrOzNrEQkcP7WL3w9rau/yylEXylLr90XL/u3j1w+kbNqi0ttIgeJTjqM8a7bN06SIwNgSYn8vVcGcCKuA+LTGkpmZwlquUeA7fluT/uiWyHDtyuIZR9UUoQyx+bSM5zznbxqsqB1bqFCcd8r9eV9ZL3GN+WqKdTQscwd/hdcO8kZx4HJefpFD6LL2xvg4r+3XRhL8Hygs/BIW2dlXoXJMJqtlz//ox1zTWc8xdtBCu7utwzaY53VO4dvg3px9LkdknLwdjJyohtKqBLot60ewkpXulKseAHrywpZodZHnMzRYDInN8qDqoIejbPgMdJw2aFbzHJ4XAm7QIuegBKyS4Pwlj6updn150D6nrJeBTF1hyez68Ae5mffdWZNIQUthsVVLZrCvN4Ho2wVuZuut59+EucxBbN+j9p9+G6TOYGwskFXbKADL91wK/6b+WfPj1lPAAo2Olwcnjwbh6sH1AgRaCWrjZ1LEJ/lgypBlviLAyB6qJUlkkiiBJnQRprLDxcepfE+JemCLYi7vk4ZOAZxH0X9JykguMh1mx0klhbwvH0zRq4Zo9U/rPF65PR+UvYVKg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(36756003)(82740400003)(86362001)(55446002)(40460700003)(40480700001)(54906003)(110136005)(478600001)(356005)(81166007)(47076005)(83380400001)(41300700001)(186003)(336012)(426003)(26005)(36860700001)(8936002)(8676002)(9686003)(6666004)(30864003)(5660300002)(316002)(70586007)(4326008)(2906002)(2876002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 11:57:33.4443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4492b30-ff2b-4e65-9843-08db9418d292
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6572
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Translate from software struct efx_tc_ct_entry objects to the key
 and response bitstrings, and implement insertion and removal of
 these entries from the hardware table.
Callers of these functions will be added in subsequent patches.

Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/mae.c          | 257 ++++++++++++++++++++++++
 drivers/net/ethernet/sfc/mae.h          |   3 +
 drivers/net/ethernet/sfc/tc_conntrack.h |  14 ++
 3 files changed, 274 insertions(+)

diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index 33ae2c852b44..8ebf71a54bf9 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -16,6 +16,7 @@
 #include "mcdi_pcol.h"
 #include "mcdi_pcol_mae.h"
 #include "tc_encap_actions.h"
+#include "tc_conntrack.h"
 
 int efx_mae_allocate_mport(struct efx_nic *efx, u32 *id, u32 *label)
 {
@@ -1403,6 +1404,262 @@ int efx_mae_unregister_encap_match(struct efx_nic *efx,
 	return 0;
 }
 
+/* Populating is done by taking each byte of @value in turn and storing
+ * it in the appropriate bits of @row.  @value must be big-endian; we
+ * convert it to little-endianness as we go.
+ */
+static int efx_mae_table_populate(struct efx_tc_table_field_fmt field,
+				  __le32 *row, size_t row_bits,
+				  void *value, size_t value_size)
+{
+	unsigned int i;
+
+	/* For now only scheme 0 is supported for any field, so we check here
+	 * (rather than, say, in calling code, which knows the semantics and
+	 * could in principle encode for other schemes).
+	 */
+	if (field.scheme)
+		return -EOPNOTSUPP;
+	if (DIV_ROUND_UP(field.width, 8) != value_size)
+		return -EINVAL;
+	if (field.lbn + field.width > row_bits)
+		return -EINVAL;
+	for (i = 0; i < value_size; i++) {
+		unsigned int bn = field.lbn + i * 8;
+		unsigned int wn = bn / 32;
+		u64 v;
+
+		v = ((u8 *)value)[value_size - i - 1];
+		v <<= (bn % 32);
+		row[wn] |= cpu_to_le32(v & 0xffffffff);
+		if (wn * 32 < row_bits)
+			row[wn + 1] |= cpu_to_le32(v >> 32);
+	}
+	return 0;
+}
+
+static int efx_mae_table_populate_bool(struct efx_tc_table_field_fmt field,
+				       __le32 *row, size_t row_bits, bool value)
+{
+	u8 v = value ? 1 : 0;
+
+	if (field.width != 1)
+		return -EINVAL;
+	return efx_mae_table_populate(field, row, row_bits, &v, 1);
+}
+
+static int efx_mae_table_populate_ipv4(struct efx_tc_table_field_fmt field,
+				       __le32 *row, size_t row_bits, __be32 value)
+{
+	/* IPv4 is placed in the first 4 bytes of an IPv6-sized field */
+	struct in6_addr v = {};
+
+	if (field.width != 128)
+		return -EINVAL;
+	v.s6_addr32[0] = value;
+	return efx_mae_table_populate(field, row, row_bits, &v, sizeof(v));
+}
+
+static int efx_mae_table_populate_u24(struct efx_tc_table_field_fmt field,
+				      __le32 *row, size_t row_bits, u32 value)
+{
+	__be32 v = cpu_to_be32(value);
+
+	/* We adjust value_size here since just 3 bytes will be copied, and
+	 * the pointer to the value is set discarding the first byte which is
+	 * the most significant byte for a big-endian 4-bytes value.
+	 */
+	return efx_mae_table_populate(field, row, row_bits, ((void *)&v) + 1,
+				      sizeof(v) - 1);
+}
+
+#define _TABLE_POPULATE(dst, dw, _field, _value) ({	\
+	typeof(_value) _v = _value;			\
+							\
+	(_field.width == sizeof(_value) * 8) ?		\
+	 efx_mae_table_populate(_field, dst, dw, &_v,	\
+				sizeof(_v)) : -EINVAL;	\
+})
+#define TABLE_POPULATE_KEY_IPV4(dst, _table, _field, _value)		       \
+	efx_mae_table_populate_ipv4(efx->tc->meta_##_table.desc.keys	       \
+				    [efx->tc->meta_##_table.keys._field##_idx],\
+				    dst, efx->tc->meta_##_table.desc.key_width,\
+				    _value)
+#define TABLE_POPULATE_KEY(dst, _table, _field, _value)			\
+	_TABLE_POPULATE(dst, efx->tc->meta_##_table.desc.key_width,	\
+			efx->tc->meta_##_table.desc.keys		\
+			[efx->tc->meta_##_table.keys._field##_idx],	\
+			_value)
+
+#define TABLE_POPULATE_RESP_BOOL(dst, _table, _field, _value)			\
+	efx_mae_table_populate_bool(efx->tc->meta_##_table.desc.resps		\
+				    [efx->tc->meta_##_table.resps._field##_idx],\
+				    dst, efx->tc->meta_##_table.desc.resp_width,\
+				    _value)
+#define TABLE_POPULATE_RESP(dst, _table, _field, _value)		\
+	_TABLE_POPULATE(dst, efx->tc->meta_##_table.desc.resp_width,	\
+			efx->tc->meta_##_table.desc.resps		\
+			[efx->tc->meta_##_table.resps._field##_idx],	\
+			_value)
+
+#define TABLE_POPULATE_RESP_U24(dst, _table, _field, _value)		       \
+	efx_mae_table_populate_u24(efx->tc->meta_##_table.desc.resps	       \
+				   [efx->tc->meta_##_table.resps._field##_idx],\
+				   dst, efx->tc->meta_##_table.desc.resp_width,\
+				   _value)
+
+static int efx_mae_populate_ct_key(struct efx_nic *efx, __le32 *key, size_t kw,
+				   struct efx_tc_ct_entry *conn)
+{
+	bool ipv6 = conn->eth_proto == htons(ETH_P_IPV6);
+	int rc;
+
+	rc = TABLE_POPULATE_KEY(key, ct, eth_proto, conn->eth_proto);
+	if (rc)
+		return rc;
+	rc = TABLE_POPULATE_KEY(key, ct, ip_proto, conn->ip_proto);
+	if (rc)
+		return rc;
+	if (ipv6)
+		rc = TABLE_POPULATE_KEY(key, ct, src_ip, conn->src_ip6);
+	else
+		rc = TABLE_POPULATE_KEY_IPV4(key, ct, src_ip, conn->src_ip);
+	if (rc)
+		return rc;
+	if (ipv6)
+		rc = TABLE_POPULATE_KEY(key, ct, dst_ip, conn->dst_ip6);
+	else
+		rc = TABLE_POPULATE_KEY_IPV4(key, ct, dst_ip, conn->dst_ip);
+	if (rc)
+		return rc;
+	rc = TABLE_POPULATE_KEY(key, ct, l4_sport, conn->l4_sport);
+	if (rc)
+		return rc;
+	rc = TABLE_POPULATE_KEY(key, ct, l4_dport, conn->l4_dport);
+	if (rc)
+		return rc;
+	return TABLE_POPULATE_KEY(key, ct, zone, cpu_to_be16(conn->zone->zone));
+}
+
+int efx_mae_insert_ct(struct efx_nic *efx, struct efx_tc_ct_entry *conn)
+{
+	bool ipv6 = conn->eth_proto == htons(ETH_P_IPV6);
+	__le32 *key = NULL, *resp = NULL;
+	size_t inlen, kw, rw;
+	efx_dword_t *inbuf;
+	int rc = -ENOMEM;
+
+	/* Check table access is supported */
+	if (!efx->tc->meta_ct.hooked)
+		return -EOPNOTSUPP;
+
+	/* key/resp widths are in bits; convert to dwords for IN_LEN */
+	kw = DIV_ROUND_UP(efx->tc->meta_ct.desc.key_width, 32);
+	rw = DIV_ROUND_UP(efx->tc->meta_ct.desc.resp_width, 32);
+	BUILD_BUG_ON(sizeof(__le32) != MC_CMD_TABLE_INSERT_IN_DATA_LEN);
+	inlen = MC_CMD_TABLE_INSERT_IN_LEN(kw + rw);
+	if (inlen > MC_CMD_TABLE_INSERT_IN_LENMAX_MCDI2)
+		return -E2BIG;
+	inbuf = kzalloc(inlen, GFP_KERNEL);
+	if (!inbuf)
+		return -ENOMEM;
+
+	key = kcalloc(kw, sizeof(__le32), GFP_KERNEL);
+	if (!key)
+		goto out_free;
+	resp = kcalloc(rw, sizeof(__le32), GFP_KERNEL);
+	if (!resp)
+		goto out_free;
+
+	rc = efx_mae_populate_ct_key(efx, key, kw, conn);
+	if (rc)
+		goto out_free;
+
+	rc = TABLE_POPULATE_RESP_BOOL(resp, ct, dnat, conn->dnat);
+	if (rc)
+		goto out_free;
+	/* No support in hw for IPv6 NAT; field is only 32 bits */
+	if (!ipv6)
+		rc = TABLE_POPULATE_RESP(resp, ct, nat_ip, conn->nat_ip);
+	if (rc)
+		goto out_free;
+	rc = TABLE_POPULATE_RESP(resp, ct, l4_natport, conn->l4_natport);
+	if (rc)
+		goto out_free;
+	rc = TABLE_POPULATE_RESP(resp, ct, mark, cpu_to_be32(conn->mark));
+	if (rc)
+		goto out_free;
+	rc = TABLE_POPULATE_RESP_U24(resp, ct, counter_id, conn->cnt->fw_id);
+	if (rc)
+		goto out_free;
+
+	MCDI_SET_DWORD(inbuf, TABLE_INSERT_IN_TABLE_ID, TABLE_ID_CONNTRACK_TABLE);
+	MCDI_SET_WORD(inbuf, TABLE_INSERT_IN_KEY_WIDTH,
+		      efx->tc->meta_ct.desc.key_width);
+	/* MASK_WIDTH is zero as CT is a BCAM */
+	MCDI_SET_WORD(inbuf, TABLE_INSERT_IN_RESP_WIDTH,
+		      efx->tc->meta_ct.desc.resp_width);
+	memcpy(MCDI_PTR(inbuf, TABLE_INSERT_IN_DATA), key, kw * sizeof(__le32));
+	memcpy(MCDI_PTR(inbuf, TABLE_INSERT_IN_DATA) + kw * sizeof(__le32),
+	       resp, rw * sizeof(__le32));
+
+	BUILD_BUG_ON(MC_CMD_TABLE_INSERT_OUT_LEN);
+
+	rc = efx_mcdi_rpc(efx, MC_CMD_TABLE_INSERT, inbuf, inlen, NULL, 0, NULL);
+
+out_free:
+	kfree(resp);
+	kfree(key);
+	kfree(inbuf);
+	return rc;
+}
+
+int efx_mae_remove_ct(struct efx_nic *efx, struct efx_tc_ct_entry *conn)
+{
+	__le32 *key = NULL;
+	efx_dword_t *inbuf;
+	size_t inlen, kw;
+	int rc = -ENOMEM;
+
+	/* Check table access is supported */
+	if (!efx->tc->meta_ct.hooked)
+		return -EOPNOTSUPP;
+
+	/* key width is in bits; convert to dwords for IN_LEN */
+	kw = DIV_ROUND_UP(efx->tc->meta_ct.desc.key_width, 32);
+	BUILD_BUG_ON(sizeof(__le32) != MC_CMD_TABLE_DELETE_IN_DATA_LEN);
+	inlen = MC_CMD_TABLE_DELETE_IN_LEN(kw);
+	if (inlen > MC_CMD_TABLE_DELETE_IN_LENMAX_MCDI2)
+		return -E2BIG;
+	inbuf = kzalloc(inlen, GFP_KERNEL);
+	if (!inbuf)
+		return -ENOMEM;
+
+	key = kcalloc(kw, sizeof(__le32), GFP_KERNEL);
+	if (!key)
+		goto out_free;
+
+	rc = efx_mae_populate_ct_key(efx, key, kw, conn);
+	if (rc)
+		goto out_free;
+
+	MCDI_SET_DWORD(inbuf, TABLE_DELETE_IN_TABLE_ID, TABLE_ID_CONNTRACK_TABLE);
+	MCDI_SET_WORD(inbuf, TABLE_DELETE_IN_KEY_WIDTH,
+		      efx->tc->meta_ct.desc.key_width);
+	/* MASK_WIDTH is zero as CT is a BCAM */
+	/* RESP_WIDTH is zero for DELETE */
+	memcpy(MCDI_PTR(inbuf, TABLE_DELETE_IN_DATA), key, kw * sizeof(__le32));
+
+	BUILD_BUG_ON(MC_CMD_TABLE_DELETE_OUT_LEN);
+
+	rc = efx_mcdi_rpc(efx, MC_CMD_TABLE_DELETE, inbuf, inlen, NULL, 0, NULL);
+
+out_free:
+	kfree(key);
+	kfree(inbuf);
+	return rc;
+}
+
 static int efx_mae_populate_match_criteria(MCDI_DECLARE_STRUCT_PTR(match_crit),
 					   const struct efx_tc_match *match)
 {
diff --git a/drivers/net/ethernet/sfc/mae.h b/drivers/net/ethernet/sfc/mae.h
index afdf738254b2..24f29a4fc0e1 100644
--- a/drivers/net/ethernet/sfc/mae.h
+++ b/drivers/net/ethernet/sfc/mae.h
@@ -112,6 +112,9 @@ int efx_mae_register_encap_match(struct efx_nic *efx,
 				 struct efx_tc_encap_match *encap);
 int efx_mae_unregister_encap_match(struct efx_nic *efx,
 				   struct efx_tc_encap_match *encap);
+struct efx_tc_ct_entry; /* see tc_conntrack.h */
+int efx_mae_insert_ct(struct efx_nic *efx, struct efx_tc_ct_entry *conn);
+int efx_mae_remove_ct(struct efx_nic *efx, struct efx_tc_ct_entry *conn);
 
 int efx_mae_insert_rule(struct efx_nic *efx, const struct efx_tc_match *match,
 			u32 prio, u32 acts_id, u32 *id);
diff --git a/drivers/net/ethernet/sfc/tc_conntrack.h b/drivers/net/ethernet/sfc/tc_conntrack.h
index f1e5fb74a73f..a3e518344cbc 100644
--- a/drivers/net/ethernet/sfc/tc_conntrack.h
+++ b/drivers/net/ethernet/sfc/tc_conntrack.h
@@ -33,5 +33,19 @@ struct efx_tc_ct_zone *efx_tc_ct_register_zone(struct efx_nic *efx, u16 zone,
 void efx_tc_ct_unregister_zone(struct efx_nic *efx,
 			       struct efx_tc_ct_zone *ct_zone);
 
+struct efx_tc_ct_entry {
+	unsigned long cookie;
+	struct rhash_head linkage;
+	__be16 eth_proto;
+	u8 ip_proto;
+	bool dnat;
+	__be32 src_ip, dst_ip, nat_ip;
+	struct in6_addr src_ip6, dst_ip6;
+	__be16 l4_sport, l4_dport, l4_natport; /* Ports (UDP, TCP) */
+	struct efx_tc_ct_zone *zone;
+	u32 mark;
+	struct efx_tc_counter *cnt;
+};
+
 #endif /* CONFIG_SFC_SRIOV */
 #endif /* EFX_TC_CONNTRACK_H */

