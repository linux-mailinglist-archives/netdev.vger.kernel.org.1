Return-Path: <netdev+bounces-94774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0448C09E1
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 04:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C818283B1B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 02:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1735146A94;
	Thu,  9 May 2024 02:41:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00E146A7C;
	Thu,  9 May 2024 02:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715222504; cv=fail; b=chCjrSc5UC0XGCpIXGTe9L6GlBnezvaqGOLJ8eLYwZpDX1dRaz5ZpXUSJgNup8AQMKyv3D+E9tShSrEdobVq3EXbMDECR0waDr4DFbkw4KYmwRPfS+Y2si0lg1RDw/YJZEOKbtH42nUj9ljTiiE+U3GGLxenI/99NxsUs2e1QUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715222504; c=relaxed/simple;
	bh=5RZbAEW2TApNywP8Sxgm00fbrG8xUmzeKhYXuQdVlYY=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sBBJBXlfLdyMCKz9dZOyArDT+MWyMEO0urWGZXznoe/WymSO0RaCwe2OReo5HqDEkVyBO8n0mJIf8CTq4o1zLDI5yaPtDMGp+0CecA0kA7ToWVZ5ciTMKgXGcxdwrcXrKBW5iHgRDeZlkmvcp9mGllgvqfqxXSwI6Ih0e+VTfhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4491es3j023501;
	Thu, 9 May 2024 02:41:21 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xysjxscph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 02:41:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8Ohhrg4qTvON96xi0s9Y7tGh9XCOjWIvW9ny0NXRu04ZSiiBL1+Usp1ZsK2QrrByPu26lhlaQmyYfihnDWGNPaWSnVaXXrnILLurs7W1I83+RL5YqGWJSwnET6pclV9VQccZVV2QiAna37V24S1m9oiDisuifaraKVyxEDouL2LX+10ftmyrVD+poxLuEw43sq9mJob1NBjtAarhp4ao3g6NrF6XPsJKh7UhxS77C0qc360m3wi39FhvjugnogYEbHubP4/0orvOjoZfY6OeBJS7GYOM+QazRYb4pwW3wNg2ssHbs9u42TmlmQ9DtR7ov6CIMeywk1h3XcS5f2xvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTJoAA1iHryTeYpkuy3SVkoWUVDwT7J/ZbAPsMTm/BE=;
 b=lY9fUPZAlpDL1mngHux4TfMxIqnrcLZTdUUXUR1ZqYwAAi3HRC/87iLZAZLqzNaDf9ORpgwqlPbpuZCxyNePq4drfFQwx+Ze3e8prDFv8TXIG6L8pzmUuUjYRly+n2Ipwn1/1jqsNKsaBJuP+okRUK9L7L94VYCBNf9fiprQ1TJLWlaOGBmBDhlvtq4m+gHGkrEusV6GnCS+GLEm6CGFhZhwk0T2G4sNBPjHabKXX4CPB/4vV/B4RK5TMK9Juh6/i2ajhKn9a3gBC+aCI9orSt6hKtSWEK6+f12cu3I7aZx+kaeRZajSWUf0GtaoZW880i+lIBXH1vdsCbFzNonPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by PH7PR11MB6008.namprd11.prod.outlook.com (2603:10b6:510:1d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 02:41:16 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%4]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 02:41:16 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net PATCH] net/sched: Get stab before calling ops->change()
Date: Thu,  9 May 2024 10:40:43 +0800
Message-Id: <20240509024043.3532677-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:404:42::15) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|PH7PR11MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: c251eb92-a31d-490e-3faf-08dc6fd17fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|1800799015|52116005|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?GYNlEh1Mq+psrdlQfnieBPwaMh/ZuUvg6TQhjSIIyvW+Oddn1BNrQ0592TmU?=
 =?us-ascii?Q?swqguiEuhp50tYTki00y6jZz3CbE90LeGyytGpo+QaRzNVxCZBli6uX9IEew?=
 =?us-ascii?Q?mlvokxR83CEdjjg7FD3VR8EoYby2dQ/SkxqWPwgr3IipKyZQ0GULD3RyRhWK?=
 =?us-ascii?Q?VyC7aa/LMyc3imdVjxqYRwN7hJHqHGN+REqzy1qLonu6G7ZdOJl6aMrrcY7D?=
 =?us-ascii?Q?wCn3rivDPT4hmzqkkc/N8KqVpQyB2N21e1+HnZtOullg2GIdkKO2MbBdmqAS?=
 =?us-ascii?Q?qfjjkl5S3jkBeRFyT2EzkaMqnFEu5V9NgnRJjwzSpv4bJ/nWCombPIv8NpjH?=
 =?us-ascii?Q?XyBX66BbPhGxeklEUTrdhU51C/BsSMFDHN0n8r6VAEhwNbwpTCaxSrmShzLU?=
 =?us-ascii?Q?AxDehOGMOc//9NQ8usWlY0RN9AxsWTbYiNpsOFLg/ichxJodDciGFj1ty32h?=
 =?us-ascii?Q?0soCi02wZ2d6GoqahosFs1VH8sIroRL9BNl1Q3WJu8HPd/beAkRNRUF8g6LW?=
 =?us-ascii?Q?/VeNif230aBi5M2QAxj6FBPeAiZFZ3LugFec8Eh84ApGpSjNd7t3IqHN3a5L?=
 =?us-ascii?Q?hFXBKAy2FgfY/7Cz4meNT6l1z4Ltyfks9t468c8eU9zq/bSKTMZ0V8qIjZu5?=
 =?us-ascii?Q?YSVA80HIkCCJbydXY6G9J8ap8QEwE7AOtrNvaOYJ4Au6D1tNea5qCvwpRCtA?=
 =?us-ascii?Q?DzOFLBQ60ap0GECP9YcBYBGRAUHHE2+qJyQxtaRjo7Hc7uY3T8k4QbVRidxv?=
 =?us-ascii?Q?e9fjsjWFLywxeRUtDaUV+o4HFwJ+4bqaACKsp74lsUjvfe4775y/TCLN8QuP?=
 =?us-ascii?Q?4x5cPo3eo5qVYNEuhU3c/MWC+EqsbTvd7Gwf5Y8fCaE/0i1khXcOdUmiwE2i?=
 =?us-ascii?Q?+7sr+cRVi8S2f2dUgOMR1QjGjIv0YkXFXiG5BKRWViR96dnCqJtrmWuE9r3q?=
 =?us-ascii?Q?RDXuwu0nxpmx3q9l+vvCN/8qYJmWl3VwVKDYy2ExHNsF1096mAQO35KG4AUt?=
 =?us-ascii?Q?yZQmfTinzufxj9B2gQLnLEDx1rgr1/tiJ3z08ImpW7Bx4+mTO0PgThgj8azV?=
 =?us-ascii?Q?NcOTZPEwxHRdjN1Rc/H69d0myQUfjKJYBTsztiRRXSgdGttsjoi/Hpy5v7lP?=
 =?us-ascii?Q?z5drc2EHiDDqepxHfc3/J+W8JwJX8r4ntlLjVEplefjulYBaEQfpJxpYU10Y?=
 =?us-ascii?Q?rvXfaxtCwKFNPYgdzOhMwkEDFd2EsT9cEzrhdnUMXIb3OxeABg4UTSdR41r9?=
 =?us-ascii?Q?Ms6TTP62MPCytTHP2j5OAU9UnAJibUa1i4r8yKpzZmy5Hi3vqGdS23Ubi0CY?=
 =?us-ascii?Q?Z8R/nNTVlfQ8JoqFGSHOqrn06JQTyRVK1ssou+FOlpEKBw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FP232DKsSvrQff+KKXYdM2JNtMs1QNuNPlZVMJHFYXmzyrplJ8Occsj5grGC?=
 =?us-ascii?Q?blOXIaVbehXt4thw4l1GiO9TU4UjpQ4JEeMw8FqULMu1ufMFHMYzSxkhO6Ep?=
 =?us-ascii?Q?HRyQKGA5kThDpnhCWUTi3VJUBfG/eXK67xxOeWMcp4GaKgsnE31Ag4RSUXLi?=
 =?us-ascii?Q?WJYjei/wb2KFkJF9QtSkdqHwkQsGeDJdXRQR08uhc7w+vVgWmV+Puz6icwBv?=
 =?us-ascii?Q?euNPy9t//VVCFpB+s5YoKCxbojzN+zK0LMLrQtlnbZ13Wx7jB26cBKMPxvCm?=
 =?us-ascii?Q?TIldtFh84MezUdFsOz9USTYQoUqjs42HFVVlen0jahkclPzIrhBxIF62hl3T?=
 =?us-ascii?Q?685r1eaNCGSm83+2YbqkQsjMZZ8cJS/gQrsfziIUi72Jo2xSZWOzuva290RL?=
 =?us-ascii?Q?Xzwdn/nCouKFan2wQ2RA+5OsIZyiEyqW6b4QlkL/WOqar9FKQJr4EV2qLqIX?=
 =?us-ascii?Q?ib9QNvBDCFLfviY/L72wdXZqv7ubpzBMumnWLQhq9wNQPG4LhmJBF47Co5yF?=
 =?us-ascii?Q?jnZrx91oGoTZbUjUVbDTN9u7dUbbBIaZcEaCOsLyze0yZ2Y7Y0DAT8LtFPio?=
 =?us-ascii?Q?Wa2NZF9OlCPF0Y1J699oZUYK69J3HBR+8b7OXhB+NR4WwoYqxXVNog2QvWPD?=
 =?us-ascii?Q?xSPxuPxj22GjGcVB9RRKyJx3HN25Q+LN3DC5BGRybd1Y7ci5ZP55RsFz/H+Z?=
 =?us-ascii?Q?GtV/pDfULE7TGx+SdIgu5Hdvwl66u5rhhwPbvBecdOoOg9WzIgBXcmvjkvYU?=
 =?us-ascii?Q?gjc7MuumrBgF5diheQGxvDytMeW/q42xGi4Cr3ELHT4B3P5Cghc6Eng0SHKx?=
 =?us-ascii?Q?HJYKQezMEckkaURI3LtsJp3on6qQBZ1hZMXqA2QQRlH1vKOaT5GpeeF+4SV4?=
 =?us-ascii?Q?kPwZWq9gmZx3NX8dbgz7bUMGACUz+aYUsB/UvgqGKQ/KM0ZDTXDcxC3Tp6d4?=
 =?us-ascii?Q?mTlwZfIKvEWGafKJNR6Y0pgVsT/BU1cALm+J763qfUn8hCD1DCMdo9FdBRW+?=
 =?us-ascii?Q?EDVFeASiwfts7eFlS7o06Kt4NNIPecCY589zEVA2tLidCYiOG9WgtnCTP97Y?=
 =?us-ascii?Q?LQnmaG7xv+6GD5RzDuLSuxJ9ld1cmfi3AmuoQTK4T+kFAec4zbt7/8CgcDWU?=
 =?us-ascii?Q?NVsDJ7ke/aBVqNAO4f79ir6bCL7yS89UmSBf5ituMiVSmeI+8wFV93C/NsXO?=
 =?us-ascii?Q?rZEJSb8H5wcq0KrrYbUKPBgK4lgLggbMS4f+67ofceZ4oMHszaP1yfb0rhGT?=
 =?us-ascii?Q?PdsMLD7Ll+3sGBl5IoFtQaM4WXv5rl2FszQQ8vmPZ4AWn9iGiA6QRgfpPYCB?=
 =?us-ascii?Q?vqQMORcJahOPKlbvhnR/fRtXVlgQ1dQJCvsdApMuiC1NkzsAfrvwKi1ErTf/?=
 =?us-ascii?Q?NdenmE2VmaVI+3joEkTLgJ0bFPIXlaYW0RzhHCQyftO6Y2Gj+wY0JcjKt6Vo?=
 =?us-ascii?Q?DGRd6uYKYD7WUMZhbMpz1m3DBWHHeuehHXmQlHpyqfJPtTxe4+4n+ndHXoQO?=
 =?us-ascii?Q?61UBI3EVrxbHcDsu6vvXxhOWAAvKPfMz3GfReEV/c3FHUOEjhbpHOPLH8D8v?=
 =?us-ascii?Q?n6t4XUVg1cJwy6SayBRmvW6YO4tQtfginP6O1qQ+OHYccgZb35C+41iKjHJo?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c251eb92-a31d-490e-3faf-08dc6fd17fd5
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 02:41:16.5135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/phlYBRqVGXbNklSMiId5SNz/GYgcuHEUDqcGbjzuJVuKgYEQa+hUqFTZXVW/8SHZh1F+CdSIK/UQ0ewvMV9J+ptpLs9tPtvz/KWM1leZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6008
X-Proofpoint-GUID: -1UMtEHhzojMh_bfToiCNpRsBWYBm7oQ
X-Proofpoint-ORIG-GUID: -1UMtEHhzojMh_bfToiCNpRsBWYBm7oQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_10,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=903 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405090018

ops->change() depends on stab, there is such a situation
When no parameters are passed in for the first time, stab
is omitted, as in configuration 1 below. At this time, a
warning "Warning: sch_taprio: Size table not specified, frame
length estimates may be inaccurate" will be received. When
stab is added for the second time, parameters, like configuration
2 below, because the stab is still empty when ops->change()
is running, you will also receive the above warning.

1. tc qdisc replace dev eth1 parent root handle 100 taprio \
  num_tc 5 map 0 1 2 3 4 queues 1@0 1@1 1@2 1@3 1@4 base-time 0 \
  sched-entry S 1 100000 \
  sched-entry S 2 100000 \
  sched-entry S 4 100000 \
  max-sdu 0 0 0 0 0 0 0 200 \
  flags 2

  2. tc qdisc replace dev eth1 parent root overhead 24 handle 100 taprio \
  num_tc 5 map 0 1 2 3 4 queues 1@0 1@1 1@2 1@3 1@4 base-time 0 \
  sched-entry S 1 100000 \
  sched-entry S 2 100000 \
  sched-entry S 4 100000 \
  max-sdu 0 0 0 0 0 0 0 200 \
  flags 2

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 net/sched/sch_api.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 60239378d43f..fec358f497d5 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1404,6 +1404,16 @@ static int qdisc_change(struct Qdisc *sch, struct nlattr **tca,
 	struct qdisc_size_table *ostab, *stab = NULL;
 	int err = 0;
 
+	if (tca[TCA_STAB]) {
+		stab = qdisc_get_stab(tca[TCA_STAB], extack);
+		if (IS_ERR(stab))
+			return PTR_ERR(stab);
+	}
+
+	ostab = rtnl_dereference(sch->stab);
+	rcu_assign_pointer(sch->stab, stab);
+	qdisc_put_stab(ostab);
+
 	if (tca[TCA_OPTIONS]) {
 		if (!sch->ops->change) {
 			NL_SET_ERR_MSG(extack, "Change operation not supported by specified qdisc");
@@ -1418,16 +1428,6 @@ static int qdisc_change(struct Qdisc *sch, struct nlattr **tca,
 			return err;
 	}
 
-	if (tca[TCA_STAB]) {
-		stab = qdisc_get_stab(tca[TCA_STAB], extack);
-		if (IS_ERR(stab))
-			return PTR_ERR(stab);
-	}
-
-	ostab = rtnl_dereference(sch->stab);
-	rcu_assign_pointer(sch->stab, stab);
-	qdisc_put_stab(ostab);
-
 	if (tca[TCA_RATE]) {
 		/* NB: ignores errors from replace_estimator
 		   because change can't be undone. */
-- 
2.25.1


