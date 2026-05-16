Return-Path: <netdev+bounces-288562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI/RARHbB2oALwMAu9opvQ
	(envelope-from <netdev+bounces-288562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 04:48:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 651DB559F3D
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 04:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CFEE304DEBF
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 02:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D55D2BE057;
	Sat, 16 May 2026 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d9+62y7k"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013067.outbound.protection.outlook.com [40.93.196.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45E129898B;
	Sat, 16 May 2026 02:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778899471; cv=fail; b=SB39ZOfx0NL1E9GvomhYO/JSljLAC4h096rHqi5EgmFaOEj4w+URhFrzcSH5tR/76aw3gt3EuRa3043a9FC6DmRZ+/oTuh7QOwdXU+nSGH7otmx1aWMpLb1aFeFgMuMnNCzlvukm4ve+zK4GrVHEMJy92U2zivsnxZmDOkY5VrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778899471; c=relaxed/simple;
	bh=WG1zdlA3s8xLJwiRovbsWehXKIBAlS/DRtALdCp/Ofg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TWu+iGC5SIvAfKDxITOOkqnbBVWmMfBDIrPklRjoxJG1IoMDNEGoZ3m4/hKf7tpID3An07Bx26kT0wHGd9TJvDrmMybxkRRQjV+lvw6SfUZpAqxE06D8we4UQyZHMFqtZJ5d6tEH0cni+oEgB6F51OZqmqOmXVRwT5vhhnKeTdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d9+62y7k; arc=fail smtp.client-ip=40.93.196.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzyuHmhjoXgjP0wq5XWqPhqy6ZWWy7CDh0FqjUTvjIWcb9ZGON5QM8sZm3/J6LBNBe1H9gH/gJ48ADiLFF4BnEZpjsYTzI9lhvzNu5fDRHaEoIShwkTAZXeRrEHSAn4Hc4kogpSN+f+CrB/rE2HKCok19I4OxdpSbTrw2gBYlc44Mpm2X4ZfH8O7PyI59mmMVQ8QnhqpBxjb6NDpPvukJkQ0QjXs5O8mlw/nDVViuxpAHD4CcQlFljDlUQSsnYr0aqZTUHrVOQixBVAIWfNqPOWDScX4FacE8zAlSD7TDgQPw6j57e0cirAnMhkL8XbyWLNTdTG8cywmyhYzOQGjOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiTsp7yPIz+LnTFiL9fToEQG8KEKg8MEpnPMJ3LUIm4=;
 b=iYMGxyLuwordlAJ5JodFGTmUiPa8ungO2UbD7BiHOHRUEl83PXKTw9gmIEHqBW/qK5OynCwoW8nJabBAG0C5nqtLuq2qG9m+saRxDYpeHs6yYHd7TPMz1zmxE8K5JvBnCP0aIfss0P/X/P/PFhX+lw8G6TUQhc5Q4ApG/JCbnmunddG4Ea3xEYP45s/p61RddYslzEUDfdbFD4oNYz/FCOsR5J+ISWKlpcoB5miJEzklIbUeWQu9fi0fzwgbbkHIHeM7yI/kZoTR+Uxief9ixDjCGSpy29AigFgSGj+77AI6becAUrVSd+v5adL9tTlDfz9sQI85tuUyqw/IfMFfAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiTsp7yPIz+LnTFiL9fToEQG8KEKg8MEpnPMJ3LUIm4=;
 b=d9+62y7kDrO5y7eqS7gxmdevbr1rjJWlOVp7t+ifN4Ge2vcQrqp3h6wnbI1HOyVMIseQUHTW0DAmF0CE2dFHT1w5N5Xzh7cX9WVnorqiNbpVOq/o1ReIsxTwu2rZezvL8vZ16bofPiXz/daYqtLULyFxxPR9yQu0oZo62yNyqio=
Received: from BN9PR03CA0227.namprd03.prod.outlook.com (2603:10b6:408:f8::22)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Sat, 16 May
 2026 02:44:17 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::b5) by BN9PR03CA0227.outlook.office365.com
 (2603:10b6:408:f8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.14 via Frontend Transport; Sat,
 16 May 2026 02:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sat, 16 May 2026 02:44:17 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 21:44:16 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Sat, 16 May 2026 02:42:40 +0000
Subject: [PATCH net-next v2 6/6] pds_core: add debugfs support for host
 backed memory
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260516-upstream_v2_clean-v2-6-7e0d66bf4020@amd.com>
References: <20260516-upstream_v2_clean-v2-0-7e0d66bf4020@amd.com>
In-Reply-To: <20260516-upstream_v2_clean-v2-0-7e0d66bf4020@amd.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Eric Joyner
	<eric.joyner@amd.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>, Vamsi Atluri
	<Vamsi.Atluri@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b24e2ce-68b8-4b00-6a5c-08deb2f50649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	clvJptVaskTEpVU6jl8KVXpksNRNmRaVQlhr8yqfZFo3rieFLpO+fY+P8NlCEPd0OHBtt9cckSqSJgSzMgEWL0/9wNnuEop6+mL9oj84FpzePCnaH1dELAhJw4mCSy1K9BsdQaY0BQi3XZ0ddrB9z6+Bs8qowqwRl/zpiNhAzf9sajsaF+UnuhRaRu2WOfuDH7w0qm/Ny/YKpVn2/YjB4OSRvTLzX08/esMWeGXZvtWGtrdf69YGD7KcYXIgjRBbG7aB6Ez++u2EIF8M9suTMiz2AUnoOSoz7doCITyxxiehw5m706gnFUgWfOtFyxrBcG8ilMrhW17vyWJBqtJsHLiMOU8ZtflRdT8qpbKZvv0GO8KvmCXEK7PB1FCEUQYKGojdVLD89+ggDPKcmzitpxbqfNfsmOeRMVIxKAtNgSe2iBc9vCoCSGCG59pH3jaeKXIRZca/TiF5w48pMGp8TxX6LxUjyFnsT42RV9mLa9yWNQDo0vyxK4uJu4/pZ2m8CyvQ9zEuiJ5TqiM/t34iZ1oDGPDXU37WNQHspEx3Bq0P1FLO3miO5g72JmDH6u2HLfuK2oHmrWR5G0ei1bwDbAZV+fBK4b4/dXUVxsC/jLCAu35lAzr9Tz8q9beDoFobbIUpFZXVmBGay5yjcBEoMN/GUDEaj3Cgjen5Mh0dGRdpFvekr0YRCCAfiZ4xsvm4CRm9QmXBrn/nFtLdMR6FjCwfHM3jCk8/YqZaJ13Zs8A=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LPDezWPS9L5ulk2GJXU0H7CF4aFmfW5q+x+nAUD1lecXPxg1vk/gSqKVIpf+HZZS3ctTuybpX1VbnE+auaOTeeV1ciP/WKQD99lKK37SoZxtdVIAMh4oyXemL3jcc8kslwl0/DLpriPgu58OHlBKYjrYfePMx3JfmV9ghPe/tpjvQ2v8kJnfYLRHZTSuPWoCHQtp8lT3QLfAR4vf8Vcv6wbdPmTGq/Zk/Xc4NsCTsveAaPq9t4kd7YIzzxKkHIK21mOcB5AsP1GWSqkmQ1wU9Nc+N6MU2dv6lAVNYdIm+Tsr4WJPzHlW7t26fzSxXsmAhA4UQ6AvAnfSQLRtcoPPO91/JAuK0Htgb+Gfb3mrcMm95fxt3RWshdjAdLBfriw8F3ONnq5E+zCVmJPsRipK0XAY/QMkFYpkDF1w7flRDfrD3d/ifM8aqg7C1jQSt6JK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 02:44:17.4990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b24e2ce-68b8-4b00-6a5c-08deb2f50649
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812
X-Rspamd-Queue-Id: 651DB559F3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288562-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Vamsi Atluri <Vamsi.Atluri@amd.com>

Add debugfs file to display host memory allocations including tag,
size, order, and physical address for each memory request.

Signed-off-by: Vamsi Atluri <Vamsi.Atluri@amd.com>
---
 drivers/net/ethernet/amd/pds_core/debugfs.c | 50 +++++++++++++++++++++++++++++
 drivers/net/ethernet/amd/pds_core/main.c    |  2 ++
 2 files changed, 52 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
index 04c5e3abd8d7..058071f6f17e 100644
--- a/drivers/net/ethernet/amd/pds_core/debugfs.c
+++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
@@ -173,3 +173,53 @@ void pdsc_debugfs_del_qcq(struct pdsc_qcq *qcq)
 	debugfs_remove_recursive(qcq->dentry);
 	qcq->dentry = NULL;
 }
+
+static int host_mem_show(struct seq_file *seq, void *v)
+{
+	struct pdsc *pdsc = seq->private;
+	struct pdsc_host_mem *hm;
+	int i;
+
+	if (!pdsc->host_mem_reqs || pdsc->num_host_mem_reqs == 0) {
+		seq_puts(seq, "No host memory allocated\n");
+		return 0;
+	}
+
+	seq_printf(seq, "Host memory requests: %d\n\n",
+		   pdsc->num_host_mem_reqs);
+	seq_puts(seq, "Tag    Size         Order  PA\n");
+	seq_puts(seq, "---    ----         -----  --\n");
+
+	for (i = 0; i < pdsc->num_host_mem_reqs; i++) {
+		hm = &pdsc->host_mem_reqs[i];
+
+		if (!hm->pg)
+			continue;
+
+		seq_printf(seq, "%-6d %-12u %-6d 0x%llx\n",
+			   hm->tag, hm->size, hm->order,
+			   (unsigned long long)hm->pa);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(host_mem);
+
+void pdsc_debugfs_add_host_mem(struct pdsc *pdsc)
+{
+	struct dentry *dentry;
+
+	if (!(pdsc->dev_ident.capabilities &
+	     cpu_to_le64(PDS_CORE_DEV_CAP_HOST_MEM)))
+		return;
+
+	/* Check if file already exists (e.g., during reset recovery) */
+	dentry = debugfs_lookup("host_mem", pdsc->dentry);
+	if (!IS_ERR_OR_NULL(dentry)) {
+		dput(dentry);
+		return;
+	}
+
+	debugfs_create_file("host_mem", 0400, pdsc->dentry,
+			    pdsc, &host_mem_fops);
+}
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 58b4d77f6eca..aa7b5ce6f623 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -266,6 +266,8 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 
 	mutex_unlock(&pdsc->config_lock);
 
+	pdsc_debugfs_add_host_mem(pdsc);
+
 	err = pdsc_auxbus_dev_add(pdsc, pdsc, PDS_DEV_TYPE_FWCTL, &pdsc->padev);
 	if (err)
 		goto err_out_stop;

-- 
2.43.0


