Return-Path: <netdev+bounces-221723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F7CB51ABB
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76488A042B9
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBAF34DCC1;
	Wed, 10 Sep 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M9cWjNDF"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010055.outbound.protection.outlook.com [52.101.84.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46E3375D0
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515721; cv=fail; b=FSs+1duj/ZrhookQtGEdq/zvJUU6C8xDQekx5TJv1wVIKVkRV8M630PZy8iAX+uTKsiKxu5+Dtas7BmlOlCI9h6jfdqQVsJ7fSFKgI3sB/hmN5kgbYkhUFpUtj2ghT8MCXmhGiUkpsjXpZgXgr7ys7FRTmJ4lNhyTXWhHiDI/7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515721; c=relaxed/simple;
	bh=M6KRCAJ3PaQ2GvE2Gy+CANy999JuL7YJQeGEr2OAonc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=L3o91rmA3QuRTJvIQD5W+/Fox68UtdXQzcEUWt+9juVah4DpYyg8ogCuzARRMSzMxaVv2gBuQ38rOjFqWSi4OaYZCE8AX95a1v3aKM4fWEgJ3Stowc7UNwiQoq+TM3Js8NbTrsZTQFPJQl+ekv47k+d1Mu7HmXsZHFF6NvsW67I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M9cWjNDF; arc=fail smtp.client-ip=52.101.84.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+9D90/hp3BMpEODVZo5ApcmYx6LEwU2Ge3SO/67fsGnuq5UXiTwsHPsCY216rh9vcARJRW1O6E7W5Qjezon7pp/HOZB8FKd17z4QACHie9IfJ2PvmaWKUysfM6Nfdl/0qUNpmT8NllKvQrW7Sirm8rK61/6xi9beLuHUt15iNx29ZOf5shLRdBG/ZKfjtylo/wG1pVoB88IeO6b66ZrjqE8XfKzUoGrNrEqN29cjuzUi6Umb2ry8lJhdOApl+TtDfV0NpEwkT3aSJHGqe9SIo/bMhvOiBZbkC+Tdx4+b1Gdfl+3YhbWfD24iq7QdhhOJdP7w5H0kKG0PYctpnM37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgQIHYEgfM6PUjm7IqGWUNXXDnq7ChhuyQ9Op33rcqY=;
 b=xksrnkLum0l3sE2B3B2j21YMdhDQtaS0lYjZSylxhN0NYxyvBM7Hosp7KYLpq2LqUo0yDCvYmWGvn/mfuBkRaloqjPXaOBPMFr2uaLA8+SPvrEusqPo0SuNcbTUXVD/+xzo+xbWRi+7X7bE+Y0nYywsnN1bN6PwBAXAPId50N9Hi/0fHlvmIJWSJroCaWWaVXqUyD3QmHLs3aO9/xiUuhMXmgMeR2oNCVV+6JG9x6IcG9d65bOKDaZ94tIJJWC6oLGrnu1AXqgAH0UXVvQ8UYKdRk6Za1EyEFrRNQBcsXSpiFGPXYNog5BSq+dGYko17yQ4oIpCqogpBrhbyXukgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgQIHYEgfM6PUjm7IqGWUNXXDnq7ChhuyQ9Op33rcqY=;
 b=M9cWjNDFAzWxkj6I6kq4gWscSYJna8K49d9+KJ/lhhr7nZqXC1syNUKHCUpCxFVt/vIyCWuwRhHVC27sIcgVkf4uTTN35ZfMRutpATMI3J03VvIH/KoPRZdwoVWtAL6WB5M6C6hBCfwizP+szZ5y+QtYOsIkcXTk5sB2kOw/Xd5R1XQPBHh22q6qA+qrBzn8PtVUiKtk9ECsE3NCi6WEHKtOQd7SpXAfeMonJwyNs8gWvNrnws6av3AAELL1JnDZW02lY/OGFcRHw986vNoAeiwJ97NMXqkI51s+LPvAFnjV2AI6qQ65ysEFQFO1ceTfz5Vwo1KGwAHJDI+g5gQj6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by VI2PR04MB10641.eurprd04.prod.outlook.com (2603:10a6:800:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Wed, 10 Sep
 2025 14:48:35 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b7fe:6ce2:5e14:27dc]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b7fe:6ce2:5e14:27dc%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 14:48:35 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: vladimir.oltean@nxp.com
Subject: [PATCH net] dpaa2-switch: fix buffer pool seeding for control traffic
Date: Wed, 10 Sep 2025 17:48:25 +0300
Message-Id: <20250910144825.2416019-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0023.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::28) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|VI2PR04MB10641:EE_
X-MS-Office365-Filtering-Correlation-Id: f13a1a9f-6975-41f9-1a00-08ddf0791e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|19092799006|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mn4hpTJV5SrnNfmi11jqM47RzXrbJm3xfEA3pNzKRKAQySX0YZDCU2dH3i94?=
 =?us-ascii?Q?ZI02vUik1PAzWaKFZ7iMrl4ssaCmKELb0xdMpOshtVRYg0FEXeE7e7slx7yr?=
 =?us-ascii?Q?7ZVgM7wGtY8EPYdLkUVLYyvUR5shoowN/84+4Fnk1KkE5lEuoHQlGL2hzOyt?=
 =?us-ascii?Q?tOoXIEAUxfHiW7/2ha1b0N1CJnZPEbD5yi6Jk1aKaHkUJWfrJMhcTUWIRmyI?=
 =?us-ascii?Q?gMYNBm1qEdA7clNpYdtykbvDZIgBLArK7o3LwKmWY81rSg1xVbi08NDE3RSZ?=
 =?us-ascii?Q?UxbtcdwNTB5rh6uuT/1Um8bGzAjfBz9FBNGRVYuonEosDW7SizTiqs4/cIeJ?=
 =?us-ascii?Q?npBkgj0v7b51ZPIQEyN3Eg/8A8R5IdPAA1rnEjpLYU/MbanvGqytzrPgMJpH?=
 =?us-ascii?Q?igoWjIy/0LxnKVe9uOwoaCnkbahrYw+Mdg/5eEoxca5d3qZ28VeWanbUzUuq?=
 =?us-ascii?Q?mTGV90/IsqL3b/WAHSihp0PtlUN1YRkWPDk5f119V4qvbIeNvWEhRqKS6XPi?=
 =?us-ascii?Q?77Ve8h3nz7dDz1HGI/Tmtk/E3snKpBXrPqoxmW4Hj4Qm6uWAFQm83ki7h5+y?=
 =?us-ascii?Q?CVv4yYtZLhSkBeT5uWOR6cvVwwS06JBAWtomBseQASBitifAj/QSGzwC6P0Q?=
 =?us-ascii?Q?wIRsu2Kn2nWUzJBySCqkOKDtwVGzQSOtQo+t2uJfGq161kamH3fOGnsGllHC?=
 =?us-ascii?Q?taalrXUomtK7Qd3XlR/s3nkhrTRY9oa5UDyuzNw+1N5CXFdu0ocWkjs3w9jb?=
 =?us-ascii?Q?Dp4Obv5oRIM83Jp+Fk4cQVU9/HzbfpDYdotWXtXSXRHakWrhIvpSSmFDtyqx?=
 =?us-ascii?Q?kUqP5iW0cUcOkplfIK14fYjmktvxNwBQ24L2j8R3FwiVBECJnxXiuE+cg70s?=
 =?us-ascii?Q?BhymfnGem8G+fzWxAyIqZnBzIjLw10rn1m1JVGl2XXfiCTN6M4Ririns/MGJ?=
 =?us-ascii?Q?5/u/MuXeRm48C47YXiPnB3mFomExGUU0Sb1jvNTLEh+R1KWcYgeoiL/gIuTd?=
 =?us-ascii?Q?tjkQY22zKCJsgnXP+wfkb8a7iH34dkyc+rpd/RtAiSGT3N4mmQeU8T25nel5?=
 =?us-ascii?Q?f+XGNS7Mbvfma8mvUZVQNgf3Q2+Gy/b/2TkJ5eWYsd6BHc1tsKdc6eLvJ46S?=
 =?us-ascii?Q?XlbbxtcOBgeAO33Ce2CkInukQUs7p+0JNkmVtZ9cOINJE6DZVcQ7nug3+qQn?=
 =?us-ascii?Q?xf8IJMm3DsteMuH+usYnVCIj7tpC7ra9ifSe4XZIf8eZAyPZuGJglpRQi/Yq?=
 =?us-ascii?Q?zY/0xogGti6KwSeHPUOwFwXyr71Y/QlJ5nFfDIVBxC1rynzUYVEEylP/af0y?=
 =?us-ascii?Q?e/KBMIo4Rd0JimA7qcvYWMd3cdpf7M133oZJlFseSGP0QoKO3Zirdq2dUZTB?=
 =?us-ascii?Q?izRn1VN8LocpC3lK8YgQYYv7D6ciR3l4HfyGz7aAPh6taKQb4kzHTCMshcpa?=
 =?us-ascii?Q?cwSwH70blJ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZS6HwFmn8R8VQwXrFxkFMuMB5hFzahq0396fAQSDN5vby5hSf+e0yjK3ugoS?=
 =?us-ascii?Q?eNf3np9aAr0ke53rUqxULWBA1UKJNv8k727qzPdZKfx7MGernmdA2hmEkesH?=
 =?us-ascii?Q?2hsut52cp7qv9FaCi/dXi3yw1QZJ4mIStAIyiy1cSbF+TUq9jBHXX64Pbd5l?=
 =?us-ascii?Q?4HoyK5XDMxWqh4dpQrTeo0t69AHs94VdP064/9cVTgLME43f3QLYOyKNfbn8?=
 =?us-ascii?Q?3TxWVhKHBeIotlyF6btmVhuEXtVUHIFiveX8/c+O7ZQXswxDeXxZkcFXddar?=
 =?us-ascii?Q?ziRYJOQfYnUsSft3HM0EYH+KPx8wBlhLqnfp6PS7wPuksU3fJyQFNh0bq1qj?=
 =?us-ascii?Q?haB/+D0ffhYnZiTyIQTd2iZHjcNxprgLgNUMxV3PrJKI73Gk4MSH3EqHmVTm?=
 =?us-ascii?Q?Uw78uURd0+sj+pogyKRwiprw0hUngC26OjcVEImIZRXuPaBuCH01kaZCyceI?=
 =?us-ascii?Q?BmfNtsK52uL0eavLArADgBUG0EdjF8wu7Z8fq3W/YedSHOKoLpHi7S65XA3v?=
 =?us-ascii?Q?eW/CV18BdwO6Gj5BCrstujew3D1syWU/tvVBxcHsAAzB/xCobrPCeRG5z4al?=
 =?us-ascii?Q?POhwOdTGwYKl5Yr0g26Ml+R2fI8q881momdZOOhtfhaqU//8NxGbnhcB/Es4?=
 =?us-ascii?Q?XvLlVXok6cfMtZLkJ2i7XP+5uOjHCAvvsl6HQ0/y9z8tuntka2bSgYASoohu?=
 =?us-ascii?Q?zMUM9nsfr6kSUva4fN/GjeH1IFY1n3rzfQ2hVF5D6LZaYdRhHCtU5H0+qxmy?=
 =?us-ascii?Q?g95KKAUkpxQm4ZNgtTeBkeEWt6GhOPS4kee89idWtilma7DEJtgm5WCThcLi?=
 =?us-ascii?Q?Lju9HdwBQU22+TyxyV2FMlSIFsyjrmSzj9N14EVVqLsIA2BWxXHijBA8WVml?=
 =?us-ascii?Q?2nwQLjTmXCIffRfWgotpbwHp2lDXepGfmxOlPmg4hJ3YWGrlLGntUVzHMyDN?=
 =?us-ascii?Q?0ZjOUYwi027KF7h4a8lc82RCmtTZiLqnratHfrMoePzcX2s0iA+/DhLUMShY?=
 =?us-ascii?Q?38IG22Wni2hOJiYRblAEpyLrTSYH3iRcOLlv6ULjQ6ITCzxcKsDRUqebZ0Co?=
 =?us-ascii?Q?b60OohfL8MyiUJLVRrwCaxrVHoG5rRqBLj5qCjTWjl2xov+R43JO6Lug24Ha?=
 =?us-ascii?Q?1mH9vAexArGidYeTTO/GfTSI2gNhhtl+xsJVcRIiQlRn57QiZhs8uPn3vxaW?=
 =?us-ascii?Q?TyO+GQW87BJgE2S7xct/Aesyp/L+VHRC6zQXzyo0U+QyxU+6kEaaLHycOack?=
 =?us-ascii?Q?FU7aZC2z85L1G0cUjJ5M6RQnvrhLtUt1Tw8IuqHEmR502TzwFMcbM50BFgMK?=
 =?us-ascii?Q?3MdZKhoobRqndJFwQkbl8QdVcX/+IwWJWDzqw1wqn25NfMcunpor8IhzPdQp?=
 =?us-ascii?Q?2/4EN2DmcJZ6JZUS1nLBO0DXMFHGVGPBIrqtvu3XlkkCzDSEV23P6l/+uwyh?=
 =?us-ascii?Q?LDq+3SsYGPAWl1P5v1o5qwIL35WyuBrsjj3ONo1ZmUHSopst0EaRW1WZ1i95?=
 =?us-ascii?Q?4aBXo0op8VsR33ahMwqVkq/oP37wy9djyErd3uznEy2xY3bBg9qeC2A/q4NB?=
 =?us-ascii?Q?NvTOcNLybKIrSkIFvNqPGRGvJIeAgP4z1h4OzvhD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13a1a9f-6975-41f9-1a00-08ddf0791e89
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:48:35.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Fm+evzorWBjkXAYIpsPPeZzbiqaaAX8iOtuuh0lcevLiu2N4U08mdDx20b7nJxsppajFPQzp4SIz/nn+PKh4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10641

Starting with commit c50e7475961c ("dpaa2-switch: Fix error checking in
dpaa2_switch_seed_bp()"), the probing of a second DPSW object errors out
like below.

fsl_dpaa2_switch dpsw.1: fsl_mc_driver_probe failed: -12
fsl_dpaa2_switch dpsw.1: probe with driver fsl_dpaa2_switch failed with error -12

The aforementioned commit brought to the surface the fact that seeding
buffers into the buffer pool destined for control traffic is not
successful and an access violation recoverable error can be seen in the
MC firmware log:

[E, qbman_rec_isr:391, QBMAN]  QBMAN recoverable event 0x1000000

This happens because the driver incorrectly used the ID of the DPBP
object instead of the hardware buffer pool ID when trying to release
buffers into it.

This is because any DPSW object uses two buffer pools, one managed by
the Linux driver and destined for control traffic packet buffers and the
other one managed by the MC firmware and destined only for offloaded
traffic. And since the buffer pool managed by the MC firmware does not
have an external facing DPBP equivalent, any subsequent DPBP objects
created after the first DPSW will have a DPBP id different to the
underlying hardware buffer ID.

The issue was not caught earlier because these two numbers can be
identical when all DPBP objects are created before the DPSW objects are.
This is the case when the DPL file is used to describe the entire DPAA2
object layout and objects are created at boot time and it's also true
for the first DPSW being created dynamically using ls-addsw.

Fix this by using the buffer pool ID instead of the DPBP id when
releasing buffers into the pool.

Fixes: 2877e4f7e189 ("staging: dpaa2-switch: setup buffer pool and RX path rings")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 4643a3380618..b1e1ad9e4b48 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2736,7 +2736,7 @@ static int dpaa2_switch_setup_dpbp(struct ethsw_core *ethsw)
 		dev_err(dev, "dpsw_ctrl_if_set_pools() failed\n");
 		goto err_get_attr;
 	}
-	ethsw->bpid = dpbp_attrs.id;
+	ethsw->bpid = dpbp_attrs.bpid;
 
 	return 0;
 
-- 
2.25.1


