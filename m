Return-Path: <netdev+bounces-73138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0EE85B200
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 05:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BCC283D41
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 04:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185E0481B3;
	Tue, 20 Feb 2024 04:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="cXsthoVA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D5A42A90
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708404719; cv=fail; b=ahnbkA8dyzXenG278SfUM+CPXZprmeDMtkLv78Fm3k9AxsqT8uw874WINKGXVXw3gkGQGqXbou6q2VXQiMEqSGwtXMMhotjTrK7mIvrX5X07WMZUXilFlZxE1bUo+ea5/h4C1fJy/BpkEWWoY0MR1PlLf0oU0teIxIg1kgXgepQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708404719; c=relaxed/simple;
	bh=c7odLWNxblK1vWDu7cXt4ALqeY5SRRWI8MuIQ9VQqeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W1JDRmmi9k0VDiAsDvK4skQyf3oCRtVoSV/3QDMQeVthx+tj/OKbL/1cV+985Da5Ut7UNFGbKzdPJ3BShWSDXICNhy0ejMmTQk+w0tFiQoTJxz/q9mh0qtWLChB35UpCkSs3TLHONGClGNfa/tmLEESDvLroj9fwCjoQMxVTr2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=cXsthoVA; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41K1LgqT010746;
	Mon, 19 Feb 2024 23:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=VR7fB4flwau9Bnb05Q4iwwMv/ndmv7GA9c9ISS6NdZE=;
 b=cXsthoVA6kI9vDKlW9V8V6gPAwSF90oFupbU5LcKot2lJc0cXKgpqAxpq0SS3Mb+9bIS
 jgXAyoXNuR5665wxzrbpElt6rvvo8VezW+9LO1E5moYINIH4LJhY1Pnuh685NWWqmq+g
 zvlqAgx82uPZ3UdcLbX7UCJDJnDFiP7QDY42vQH3LIfwnHTWeXwc2/gFyzW3nJ9Jyzq9
 zXH/0VohP1R6M5u5Ol0aQHrxhZ1dQsGblIoTOHJxAhKmNcQ5n32tGPRDohI9+c30CiyF
 ygAu4V1AAAf46rwx8DwWCH6WmuD0ycXBo8HeYwexE4rqSMjBqhR8tWTKVvk3jj3JfWoY 4A== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3waspqb01m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 23:51:27 -0500
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41K3VnKa010021;
	Mon, 19 Feb 2024 23:51:27 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3wcm8ggqva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 23:51:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqgRXvVb0YyqEt8F46rXHHQC02Wwi0ShVbeQnT6b3bUWKDYKJ0OKGvD5xeV3qVG2NLrGdH1gSEcWaIjDTZNB2TJAJAPtJMdtU/3OQIyB0ZihVJzNx5b36kxJkPHlT11jYn59IWG0WYuVhjtSe+sCA11G9dwrHhg04cupjK3acCxbvXqKfdjW+dviJFsQOGFTEspHLE7CM8PAs1V975wTtxy/gdTSAE1Foy2Wq6sT7EjN6nQul4gsZ+Bqqv9RPjq14+iCdC0Kv6aZDjqg84RRFY/dU6aUAIfboSCRtuBEvgeldOkdn7AIAWeVfUkpeR3KNy0R1x8rAenwsASGPNKvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VR7fB4flwau9Bnb05Q4iwwMv/ndmv7GA9c9ISS6NdZE=;
 b=FrqAgwgKQbTAmSWalCGhkFQq5R3IY1VIkVxJTBxp88SOw09+t0BHA210ZrpHCPAo9UQ742MeCGfcg+T2uEuncQcwVP5m5Nde0lO9+cy/Yhcw3gcTwv0aaQL1nh3zO9zHOC+MbfIlpaj4nlp3rah7wld0BuCzvfqCaPoXLjEQTJpvmjKpQBgEncqOk5a+gr26A9X5ozGKqM819N8tiOFP2V/4+mm8e0PN58pVWYNpLWNC94TF1z171KmPxegGPOeNf9RZvac/lsAHbEIWMi0kVT8EpfjZOtNXFDtIispi8rYk2eHPo2UZ0sRbyFiOlmw50mTJ7fbhQ93F7Xgz/6cpQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4415.namprd19.prod.outlook.com (2603:10b6:a03:286::17)
 by MN2PR19MB3917.namprd19.prod.outlook.com (2603:10b6:208:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 04:51:23 +0000
Received: from SJ0PR19MB4415.namprd19.prod.outlook.com
 ([fe80::5707:d1a7:932a:1f45]) by SJ0PR19MB4415.namprd19.prod.outlook.com
 ([fe80::5707:d1a7:932a:1f45%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 04:51:23 +0000
From: "Ramaiah, DharmaBhushan" <Dharma.Ramaiah@dell.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "matt@codeconstruct.com.au"
	<matt@codeconstruct.com.au>
CC: "Rahiman, Shinose" <Shinose.Rahiman@dell.com>
Subject: RE: MCTP - Socket Queue Behavior
Thread-Topic: MCTP - Socket Queue Behavior
Thread-Index: AdpjPln1K8p7U6IuQcSvYKsg8BomjQAZRv2AAAG16IA=
Date: Tue, 20 Feb 2024 04:51:23 +0000
Message-ID: 
 <SJ0PR19MB4415EA14FC114942FC79953587502@SJ0PR19MB4415.namprd19.prod.outlook.com>
References: 
 <SJ0PR19MB4415F935BD23A6D96794ABE687512@SJ0PR19MB4415.namprd19.prod.outlook.com>
 <202197c5a0b755c155828ef406d6250611815678.camel@codeconstruct.com.au>
In-Reply-To: 
 <202197c5a0b755c155828ef406d6250611815678.camel@codeconstruct.com.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=e1cb5420-f23b-4591-84a7-f0ac7fbae0f0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-02-20T03:10:05Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4415:EE_|MN2PR19MB3917:EE_
x-ms-office365-filtering-correlation-id: 9df4b427-c88b-4cb2-1811-08dc31cf966d
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 kQIa6kk9YLrfUj4U1o+7gcfKEVetl5ssHlrunXtyevNNkr4qBk7JL9vTHVGIVoIqY8vgEyvaKDGDnQEt6gicJZKiqqy852DljW0Fig39G7x2HJ64d8Jc/uQtuYH1WIGQ57TMyuAAkHbcYL3CtjsNJgx0ccAd39z9j+y68CxhZBF3PUFSxjQTR//5hkOLcfb4sc0XDbwIFgVOgEcNHQPCGEM+Haey2zHha1JRx32CUb534UhGLZCXv+7BlT2MIX00A8NNLRsk4jEmEPx8333xCrcMmB0OuH49xI5yQN3TeWIXr7HUggHfxkjWJX0DvhcwhICXPmEbXb2paKkitiaqqGHOuQTORx7xcEEtzCfJyJzNd4wqnHPSFtxRQkIZB5zS2NgGGhF+u0MEVQGTUl+lMuWpRxmfDCJUzB9YSFh+Wkd8eoeXeL/wB4ASTspkEgzdOCGyf6jw09vdioX5NgBE3LSKHOSiHfsVhdIQsz1A06yc21SDFcRCO0MJjJdH8iZ5uHNUl/YwV02RNVjgQ/X9McbVe6YyceVkf82xrR+WFq6iUg24enb0XLBe4oc8OU/d1Zis7uiIAQENldZGyI9//do6oxEjDlU1xdc1H69OWEuUTyc3W3twJ7XlS5KIBnJu
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4415.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-7?B?elM1QWdRbnA5dWZQNGVKbXNuaGlMdWw1QzMyaDVrcTFUSW94Zk9kUmczZmdU?=
 =?utf-7?B?MEVMVENJQ0FKZE5uUEpUL2NlTm0wT3grLUladSstOVRYaXdTS2l1YkhBRkRJ?=
 =?utf-7?B?QWV4cHFlS2FRaFA3Zm8zU3dkUGNTaWFFTGx1cXpJUHFtY1ZFeUYzaWhmKy1q?=
 =?utf-7?B?TEhKKy05QnRLT0Q0S2xEMDZtMGZ1RkY0amlLTE0zZUdhZFRMVWZlc3VmclRL?=
 =?utf-7?B?WlB6aTlGWEVpWUNUV3BBSDVpV2c4Tk1qcFZiMWVQVFoxbWVLSzllRDkzQUVx?=
 =?utf-7?B?d1YxQXFLS1R1cWF1RlhFbVdjVnpKTGRLREdVWjJxWHAweUlFUW5xN2NTeFBn?=
 =?utf-7?B?ZklHKy1LcnZESm5UY080MnNQcm1FTXlYc09aRjdoVSstRDNFT3ZYSlNuRFVa?=
 =?utf-7?B?aXRKa082aFZvSjNyYkVMS0FhbW9SKy1mNUFtT08xU1ZCKy1YUmt1UWN6UkN5?=
 =?utf-7?B?TUJvVFNUN2Roek53UGx5blF5S0cySXY5d0t0MEZub0xmTDE0WVhvUXBsR1dO?=
 =?utf-7?B?VWZKajBpei8xVGJsaU1MTUdPYTV4cDF2Zlh6dUMrLWFpcWw4a3FTZlIya0pH?=
 =?utf-7?B?Nk9tS1BXZSstTjBjbUZlelU4OU41TkV6TDVEc0tCRjg5alZzbHpUbE1UV2F3?=
 =?utf-7?B?bW5YOFRFaUJ6dHdVV3Y5aFB5ck1WQVpZT0EyZ2hHYUkyTSstQXk4OS9KV2k0?=
 =?utf-7?B?cE81b2dGM0d1aW5XTTRhKy1kTjFKMSstNmZMQTA3UFNrSXhwMmxGKy11TE8x?=
 =?utf-7?B?WVZPbEFqcW5JdlpsNHVkVjVpdEZDdTdUaCstbDRacEx4emIzQ044ZW9HRSst?=
 =?utf-7?B?eXA4eHYzREV4WVV4eU9oS1VYdGVWL2YxZjAxaHQ2RHpRT2dSbVpMcDViTHhh?=
 =?utf-7?B?UnpuL25uUjRyeGhwQkJEcEdlaU4zUE42aEJPQzNJdENyZUZwQnNnR3VMSjZt?=
 =?utf-7?B?bWh3Ky01Ky1DSU5laFBkb2txZTZMU25QazFneTZKUGwyc0xKKy1ld0lVcjhM?=
 =?utf-7?B?eEhhMVE3TjFGcW9RblA5UVlkcTdIY2Nab09uSUxtWXFVL3BRWlM4ZldzcjFP?=
 =?utf-7?B?b0xYUjBRNVNZcUkwbmZPOUNMSElTc1BDUERTbVh2N0lnc0tjUFNlY2lkWlI5?=
 =?utf-7?B?dnUrLWd1eEYrLUR0eXZnVkVjQmdYSWFFa0FGUkZLNjVTZTQzdzBCNnV1U0FI?=
 =?utf-7?B?Tko4NEV1TVpJN2hlOHBIc054V3hZUU1qNmJpc2pMSTREYVQ5S3d2YWY1ZG5I?=
 =?utf-7?B?L1dSVzlobkh1RmZiKy1NZnNvMXdoQWZSajFwaEV1WGZrWDdzN1BsKy12eWow?=
 =?utf-7?B?cUVMMWhLaHBvU3V3Q2JzcHQ2bTBoMnVzVDd2Y3dka1pKQ2FGNndwUystNzQx?=
 =?utf-7?B?ak1PVzNWR1Z1STg0dkh4S1lsS3NtVFBVUVRFRklCZkt4ampRS2J3NVhqUXRO?=
 =?utf-7?B?aDMxSk5hL254SkZHSHVBaXVjUDRoVDNBUE4rLVA2M3RjTmJrVkc5MUhRQ3p5?=
 =?utf-7?B?T1lQeDNtb3hIeUR5c21LdFc0Qlk0bFVJQ3RwWHAxa01PMkF1L1ZETEM4MnpT?=
 =?utf-7?B?MHplUDlZY1lDU3F4WDlPdEcvYXdLSGNXNTVZNllqbHlTdjdqWG5LSXZHSjNi?=
 =?utf-7?B?U3FmS0RHdzJmcTNPUmZ0eE5jTVNvUDIvQzBtb29ZV2F6OFcwTU1sQkd2cERm?=
 =?utf-7?B?bnF5MW9LdlBGcW85cFNrWjgzYystTzI0SFM4WmRWcGE0VTF2MzJLRGVaWnVK?=
 =?utf-7?B?WVpDbTJPMUlLejJmdXo5ZVp1Wk1ncVc2VkpDVlBOZEw0L0VTUDVNU3E2a21i?=
 =?utf-7?B?cktqWm5xSTVxR3ZFQUpPVlJZVExPRDRtNm01dlk0b2hnTHFJVTZXbVVZaEoz?=
 =?utf-7?B?WWdjRExiVE8xMHdjTU9pcU5GNzhYcG4rLTFzeEd6ankweWhsNVZzNXRJakhX?=
 =?utf-7?B?czRDRVJ5TmlJWmxOTmpUTmluWFVrTHhmWGZ1dGRaZjN3aGtSWE1MRGh0Ky1S?=
 =?utf-7?B?Sk9CRjJpR3ppMzRHeFJMbHlSNDdxSlhKTzA2dTZOWUs1TkFIL3lCZmVKUTR1?=
 =?utf-7?B?VHdTWjF4WDFLdzhBUnVZNUZyUWVadmZ2M2pUbUw2bXllWEpYdU5ONlVXeEdC?=
 =?utf-7?B?U21PYkI2R0VBeTYxVzdrNWs4WVNoQ0t3a1VHNUR5ejdUcE1Qd0tPZW9kWkI=?=
 =?utf-7?B?Ky0wQkpoRms5MQ==?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4415.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df4b427-c88b-4cb2-1811-08dc31cf966d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 04:51:23.1380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hluNbNaSFKQL9ZLqJWRZHyqnF1oKBSBGSvDRpuBtUNSRxT6Xfgg5YGej3KubDF5j+jopni/6DHdhFQPIibFQZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_03,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200031
X-Proofpoint-ORIG-GUID: X0eZT-oZsRLxxr800qWimkwc8xuBYNVY
X-Proofpoint-GUID: X0eZT-oZsRLxxr800qWimkwc8xuBYNVY
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 spamscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402200031

Hi Jeremy,

Thanks for the reply. I have few additional queries.


Internal Use - Confidential
+AD4- -----Original Message-----
+AD4- From: Jeremy Kerr +ADw-jk+AEA-codeconstruct.com.au+AD4-
+AD4- Sent: 20 February 2024 07:51
+AD4- To: Ramaiah, DharmaBhushan +ADw-Dharma+AF8-Ramaiah+AEA-Dell.com+AD4AO=
w-
+AD4- netdev+AEA-vger.kernel.org+ADs- matt+AEA-codeconstruct.com.au
+AD4- Subject: Re: MCTP - Socket Queue Behavior
+AD4-
+AD4-
+AD4- +AFs-EXTERNAL EMAIL+AF0-
+AD4-
+AD4- Hi Dharma,
+AD4-
+AD4- +AD4- Linux implementation of MCTP uses socket for communication with=
 MCTP
+AD4- +AD4- capable EP's. Socket calls can be made ASYNC by using fcntl. I =
have a
+AD4- +AD4- query based on ASYNC properties of the MCTP socket.
+AD4-
+AD4- Some of your questions aren't really specific to non-blocking sockets=
+ADs- it seems
+AD4- like you're assuming that the blocking send case will wait for a resp=
onse before
+AD4- returning+ADs- that's not the case, as sendmsg() will complete once t=
he outgoing
+AD4- message is queued (more on what that means below).
+AD4-
+AD4- So, you still have the following case, still using a blocking socket:
+AD4-
+AD4-   sendmsg(message1)
+AD4-   sendmsg(message2)
+AD4-
+AD4-   recvmsg() -+AD4- reply 1
+AD4-   recvmsg() -+AD4- reply 2
+AD4-
+AD4- - as it's entirely possible to have multiple messages in flight - eit=
her
+AD4-   as queued skbs, or having being sent to the remote endpoint.
+AD4-
+AD4- +AD4- 1. Does kernel internally maintain queue, for the ASYNC request=
s?
+AD4-
+AD4- There is no difference between blocking or non-blocking mode in the q=
ueueing
+AD4- implementation. There is no MCTP-protocol-specific queue for sent mes=
sages.
+AD4-
+AD4- (the blocking/nonblocking mode may affect how we wait to allocate a s=
kb, but
+AD4- it doesn't sound like that's what you're asking here)
+AD4-
+AD4- However, once a message is packetised (possibly being fragmented into
+AD4- multiple packets), those those +ACo-packets+ACo- may be queued to the=
 device by the
+AD4- netdev core. The transport device driver may have its own queues as w=
ell.
+AD4-
+AD4- In the case where you have multiple concurrent sendmsg() calls (typic=
ally
+AD4- through separate threads, and either on one or multiple sockets), it =
may be
+AD4- possible for packets belonging to two messages to be interleaved on t=
he wire.
+AD4- That scenario is well-supported by the MCTP protocol through the pack=
et tag
+AD4- mechanism.
+AD4-
+AD4- +AD4- a. If so, what is the queue depth (can one send multiple reques=
ts
+AD4- +AD4- without waiting for the response
+AD4-
+AD4- The device queue depth depends on a few things, but has no impact on
+AD4- ordering of requests to responses. It's certainly possible to have mu=
ltiple
+AD4- requests in flight at any one time: just call sendmsg() multiple time=
s, even in
+AD4- blocking mode.
+AD4-
+AD4- (the practical limit for pending messages is 8, limited by the number=
 of MCTP
+AD4- tag values for any (remote-EID, local-EID, tag) tuple)
+AD4-
+AD4- +AD4- and expect reply in order of requests)?
+AD4-
+AD4- We have no control over reply ordering. It's entirely possible that r=
eplies are
+AD4- sent out of sequence by the remote endpoint:
+AD4-
+AD4-   local application          remote endpoint
+AD4-
+AD4-   sendmsg(message 1)
+AD4-   sendmsg(message 2)
+AD4-                              receives message 1
+AD4-                              receives message 2
+AD4-                              sends a reply 2 to message 2
+AD4-                              sends a reply 1 to message 1
+AD4-   recvmsg() -+AD4- reply 2
+AD4-   recvmsg() -+AD4- reply 1
+AD4-

Based on the above explanation I understand that the sendto allocates the s=
kb (based on the blocking/nonblocking mode). mctp+AF8-i2c+AF8-tx+AF8-thread=
, dequeues the skb and transmits the message. And also sendto can interleav=
e the messages on the wire with different message tag. My query here regard=
ing the bus lock.

1. Is the bus lock taken for the entire duration of sendto and revcfrom (as=
 indicated in one of the previous threads).  Assume a case where we have a =
two EP's (x and y) on I2C bus +ACM-1 and these EP's are on different segmen=
ts. In this case, shoudn't the bus be locked for the entire duration till w=
e receive the reply or else remote EP might drop the packet as the MUX is s=
witched.

                         Local application                                 =
                   remote endpoint

                Userspace                             Kernel Space

sendmsg(msg1)+ADw-ep - x, i2cbus -1, seg1+AD4-
sendmsg(msg2)+ADw-ep -y, i2cbus - 1, seg2+AD4-

                                               lock(bus)
                                                                           =
    send(msg1)
                                                                receive(msg=
1)
                                                                           =
                                         sendreply(msg1)
                                                                           =
    unlock(bus)
recvmsg(msg1)  +ADw-- Reply                                    lockbus(bus)
                                                                           =
     send(msg1)
                                                                receive(msg=
1)
                                                                           =
                                         sendreply(msg1)
                                                                           =
    unlock(bus)
recvmsg(msg2)  +ADw-- Reply

Also today, MCTP provides no mechanism to advertise if the remote EP can ha=
ndle more than one request at a time. Ability to handle multiple messages i=
s purely based on the device capability. In these cases shouldn't Kernel pr=
ovide a way to lock the bus till the response is obtained?
Please let me know if I am missing something.

+AD4- So if a userspace application sends multiple messages concurrently, i=
t must
+AD4- have some mechanism to correlate the incoming replies with the origin=
al
+AD4- request state. All of the upper-layer protocols that I have seen have=
 facilities
+AD4- for this (Instance ID in MCTP Control protocol, Command Slot Index in=
 NVMe-
+AD4- MI, Instance ID in PLDM, ...)
+AD4-
+AD4- (You could also use the MCTP tags to achieve this correlation, but th=
ere are
+AD4- very likely better ways in the upper-layer protocol)
+AD4-


+AD4- +AD4- b. Does the Kernel maintain queue per socket connection?
+AD4-
+AD4- MCTP is datagram-oriented, there is no +ACI-connection+ACI-.
+AD4-
+AD4- In terms of per-socket queues: there is the incoming socket queue tha=
t holds
+AD4- received messages that are waiting for userspace to dequeue via recvm=
sg() (or
+AD4- similar). However, there is nothing MCTP-specific about this, it's al=
l generic
+AD4- socket code.
+AD4-
+AD4- +AD4- 2. Is FASYNC a mechanism for handling asynchronous events assoc=
iated
+AD4- +AD4- with a file descriptor and it doesn't provide parallelism for m=
ultiple
+AD4- +AD4- send operation?
+AD4-
+AD4- The non-blocking socket interfaces (FASYNC, O+AF8-NONBLOCK, MSG+AF8-D=
ONTWAIT)
+AD4- are mostly unrelated to whether your application sends multiple messa=
ges at
+AD4- once. It's entirely possible to have multiple messages in flight whil=
e using the
+AD4- blocking interfaces.
+AD4-
+AD4- Cheers,
+AD4-
+AD4-
+AD4- Jeremy

