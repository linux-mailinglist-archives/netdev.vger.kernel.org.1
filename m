Return-Path: <netdev+bounces-44482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB44C7D83B1
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 15:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B18E281EED
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 13:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C659E2E3E8;
	Thu, 26 Oct 2023 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orange.com header.i=@orange.com header.b="jV8+GOW6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA04F13AF8
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 13:36:23 +0000 (UTC)
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 06:36:21 PDT
Received: from smtp-out.orange.com (smtp-out.orange.com [80.12.210.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5F618A
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 06:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=orange.com; i=@orange.com; q=dns/txt; s=orange002;
  t=1698327381; x=1729863381;
  h=to:subject:date:message-id:references:in-reply-to:
   mime-version:content-transfer-encoding:from;
  bh=f4TH/ThRBRtiJAfwr6PR5gDQe71/39MaC91yl56AG2s=;
  b=jV8+GOW6exbuSQzz9HdLRJSShBSu5qQQw4ApgtGdHTgLfg2tr8UeC9vL
   l2b0zkmuqWnKIyxmeES7MwcS2OQ098YB3xGFFwl63Vl/hgAoTMLNEgUOw
   jTRhbU4JghlLlEtvhpT6MIcW6HdP3B/sCmTfB+yj9+P06+V+mMlQeYpKD
   GmrQZsLh4pmlUkWmtGvVMM49P/hv/g6Y6ZippU7VHyXFF1kOcDn6wGLlQ
   gH5tZrMrH76krLrDzCe2cHG8Frr4e1XGU/qOCj5cCyVSnl02z1XYG5w2r
   4EWMRMCWzbuHLVdPg1EmiilDA0u4bnjeXlxtHhD6UVJ5qFB273QuTNWpW
   w==;
Received: from unknown (HELO opfedv1rlp0h.nor.fr.ftgroup) ([x.x.x.x]) by
 smtp-out.orange.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 15:35:15 +0200
Received: from unknown (HELO opzinddimail7.si.fr.intraorange) ([x.x.x.x]) by
 opfedv1rlp0h.nor.fr.ftgroup with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 15:35:15 +0200
Received: from opzinddimail7.si.fr.intraorange (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id CA00522AF87
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 15:35:14 +0200 (CEST)
Received: from opzinddimail7.si.fr.intraorange (unknown [127.0.0.1])
	by DDEI (Postfix) with ESMTP id B23F222AF98
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 15:35:14 +0200 (CEST)
Received: from smtp-out365.orange.com (unknown [x.x.x.x])	by
 opzinddimail7.si.fr.intraorange (Postfix) with ESMTPS	for
 <netdev@vger.kernel.org>; Thu, 26 Oct 2023 15:35:14 +0200 (CEST)
Received: from mail-vi1eur02lp2040.outbound.protection.outlook.com (HELO EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.40])
  by smtp-out365.orange.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 15:35:09 +0200
Received: from DBBPR02MB10463.eurprd02.prod.outlook.com (2603:10a6:10:52d::20)
 by VI1PR02MB6239.eurprd02.prod.outlook.com (2603:10a6:800:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 13:35:09 +0000
Received: from DBBPR02MB10463.eurprd02.prod.outlook.com
 ([fe80::1f03:16d3:54f2:9bf6]) by DBBPR02MB10463.eurprd02.prod.outlook.com
 ([fe80::1f03:16d3:54f2:9bf6%5]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 13:35:09 +0000
From: peter.gasparovic@orange.com
X-TM-AS-ERS: 10.218.35.130-127.5.254.253
X-TM-AS-SMTP: 1.0 c210cC1vdXQzNjUub3JhbmdlLmNvbQ== cGV0ZXIuZ2FzcGFyb3ZpY0Bvc
	mFuZ2UuY29t
X-DDEI-TLS-USAGE: Used
Authentication-Results: smtp-out365.orange.com; dkim=none (message not signed) header.i=none; spf=Fail smtp.mailfrom=peter.gasparovic@orange.com; spf=Pass smtp.helo=postmaster@EUR02-VI1-obe.outbound.protection.outlook.com
Received-SPF: Fail (smtp-in365b.orange.com: domain of
  peter.gasparovic@orange.com does not designate 104.47.11.40
  as permitted sender) identity=mailfrom;
  client-ip=104.47.11.40; receiver=smtp-in365b.orange.com;
  envelope-from="peter.gasparovic@orange.com";
  x-sender="peter.gasparovic@orange.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 include:spfa.orange.com
  include:spfb.orange.com include:spfc.orange.com
  include:spfd.orange.com include:spfe.orange.com
  include:spff.orange.com include:spf6a.orange.com
  include:spffed-ip.orange.com include:spffed-mm.orange.com
  -all"
Received-SPF: Pass (smtp-in365b.orange.com: domain of
  postmaster@EUR02-VI1-obe.outbound.protection.outlook.com
  designates 104.47.11.40 as permitted sender) identity=helo;
  client-ip=104.47.11.40; receiver=smtp-in365b.orange.com;
  envelope-from="peter.gasparovic@orange.com";
  x-sender="postmaster@EUR02-VI1-obe.outbound.protection.outlook.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:40.92.0.0/15 ip4:40.107.0.0/16
  ip4:52.100.0.0/14 ip4:104.47.0.0/17 ip6:2a01:111:f400::/48
  ip6:2a01:111:f403::/49 ip6:2a01:111:f403:8000::/50
  ip6:2a01:111:f403:c000::/51 ip6:2a01:111:f403:f000::/52 -all"
IronPort-Data: A9a23:obk6KKuciRPyiHEoNxnmheXcy+fnVFdZMUV32f8akzHdYApBsoF/q
 tZmKWCHa6zYZTfyeognO42x8BgGupSBn9cyHAI/qn02HiMR9ZOVVN+UEBz9bniYRiHhoOOLz
 Cm8hv3odp1coqr0/0/1WlTZhSAgk/vOH9IQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YuaT/b3Zhn9gFaYDkpOs/jY8Us14qyr0N8llgdWic5j7Qa2e0Y9XMp3yZGZdxPQXoRSF+imc
 OfPpJnRErTxpkpF5nuNy94XQ2VSKlLgFVHmZkl+AsBOtiN/Shkaic7XAha+hXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0aBuoNf6zXaDXcO70m+ZXV/qn+9SLVAMYo5BwrsvJlpLz
 KlNQNwNRkjra+Oe7Y+BErMpuOV6ac7hMcUYp21qyizfAbA+W5ffTq7W5NhemjAtmsRJGvWYb
 M0cAdZtRE2YP1sTZRFOUdRixI9EhVGnG9FcgEqYuactpWfa1xR4yr/zMdH9fcaDQ8pY2E2fo
 woq+kygXk1EbYHAmVJp9Frw2bTDhDnJSLgXDZSj5/FMkGaIyXQqXUh+uVyT+qDi0RbnAbqzM
 Xc8/CcyoaUs3FKkQ8O7XBCipnOA+BkGVLJt//YS7QiMzu/K4l+UG3JcFDpZMoR67IkxWCAg0
 UKPk5XxHztzvbaJSHWbsLCJsTe1PitTJmgHDcMZcecby8TB/68XiE7VcvdyKvG21+WoQRbLx
 gnf+UDSmI4vpcIM0qy6+3XOjDStuoXFQ2YJCuP/DzrNAuRRNdbNWmC41bTIxaoQdt7FHjFtq
 FBdxZPAsrlm4YSlznTlfQkbIF2+z9+5WNE2qWBuEp8n/lxBEFb6JdkIiN2SDHloP8ACcFfUj
 KL7vApQ4NpNPSKncLUvOYapUZx2le7nCMjvUe3SYpxWeJ9teQSb/SZoI0mNw2Tql0tqmqY6U
 Xt6TSpOJSZBYUiE5GPtLwv47VPN7n5hrY80bc6mpylLKZLEOBaopU4taTNilNwR4qKeuxny+
 N1CLcaMwBg3eLSgM3mNrN5NcQtQdSRT6XXKRyp/J7frzu1OSTlJNhMt6el/E2CYt/gFyL6Zp
 SDkMqOm4ACv2iWddW1mlUyPmJu0BM0k9SthVcDdFVOp0GIkeoGh8O8WZYYtcNEaGB9LnJZJo
 w0+U5zYWJxnE2yZkxxENMWVhNI4KHyD21nVVwL7O2dXQnKVb1eVkjMSVlCyrHVm4+venZdWn
 oBMISuBEMpcGlk8U5aNAB9tpnvo1UUgdCtJdxOgCrFulI/EqdECx/DZ5hP2Hy0NFfkH7han7
 V7MRCk5/KzKqYJz98TVj6eZqYvvC/F5AkdRA2jc6/CxKDXe+W2gh4RHVY5kuBjDAXjs9vzKi
 fp9lpnB3D8vxD6mcLaQ155s16s46NaprLhfpuihNGuedEylU9uMPVHatfRyWnVx+4Jk
IronPort-HdrOrdr: A9a23:JJWIsqBnl05AOtvlHegmsceALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPEfP+U8ssQIb6Ki90c67MDvhHP9OkMAs1NiZLWzbUQeTQr2KqLGSpQEIeBeOvdK1t5
 0QF5SWYeeYZTQUsS+52njeLz9K+rm6GdWT9IXjJgBWPGJXgs9bjjtRO0K+KAlbVQNGDZ02GN
 63/cxcvQetfnwRc4CSGmQFd/KrnayHqLvWJTo9QzI34giHij2lrJTgFQKD4xsYWzRThZ8/7G
 n+lRDj7KnLiYD29vac7R6d031loqqh9jJxPr3NtiHTEESutu+cXvUuZ1RFhkF2nAjg0idurD
 CGmWZaAy060QKqQojym2qm5+Co6kdT15fvpGXo/EfLsIj3Qik3BNFGgp8cehzF61A4tNU5y6
 5T2XmF3qAneS8osR6NleQgbSsa43acsD4ni6oennZfWYwRZPtYqpEe5lpcFNMFEDjh4I4qHe
 FyBIWEjcwmB2+yfjTcpC1i0dasVnM8ElOPRVUDoNWc13xTkGpix0UVycQDljML9Y47SZND++
 PYW54Y441mX4sTd+ZwFe0BScy4BijERg/NKnubJRD9GKQOKxv22u3KCXUOlZGXkbAzveoPcc
 76ISxlXEYJCjzTNfE=
X-Talos-CUID: 9a23:WUsyDmGs6XvX1TJqqmJ61hE6PsZ5aEH83U2PIBaAVD5Oc7isHAo=
X-Talos-MUID: 9a23:zfHHjgWVDeeTWerq/GOz3z17LvV42aG3IVscnrMWgNKLLRUlbg==
X-IronPort-AV: E=Sophos;i="6.03,253,1694728800"; 
   d="scan'208";a="14461578"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+4unxtjai/jWLu5tuej3Ukp44qhvPJ/Yhap6hG24/QABU7+uyq7QHgvf2sSOxmtNyIIzIeyv7o4iwndbPkjFerHkY6g4be/AwPuPLu+m8OBntq3XECBEenpkaiacDAS5avsnBuYnFApI/jyuE61/mGuH9tTl8cU1aCNYgc1IbcuZXUCxWfAEc+CCV6xiNcT/NW1R6Ny43DbovD6jnyGjmVl/aX8EthpTVouYyFTF1iz3ppiA4l9g/OZvUvBfGq9IyVqAKOAUcfnzKyGPzNcqzlVqspx2S9chKuppTj2OGF0pR5iQjN/Tz08yjTqRHt9ZR42CaxQpVtnLSLlFZf/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTqy7A+ZFtokDFaaeWgOu0lpM7X+9cMsewcBQvGPkFM=;
 b=K+SwG8oB4lTWLitPD5lEHuA2NW1OERWW2K2UaYaGhChtN9e1v3BS/xKHN1NV7KrKpU3FBVwtTihGgJqQLhymymQD5TTChQgr2HBKnoJ6F+Q06yFF5p1/IXUAMv2YuMeT71rWo01Gz4clqoVLmy400SJi/4dM8nM1szYRfCSMImJlR9VdOFmfM6LEJykUBPiaj05c5EZ+hxHsm7tYSpgcumki+g37/t0tXZXsAMxxwJeb7Xa91wghyU+2enZwq2ECi8sGpeIwscgNnTTQ09j/adqV8AAOed2/UYZdTcqDytjzX5sahYPbIQ6nDxWQbUyjgOPVe/mk3gfwqxb9+Be84A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=orange.com; dmarc=pass action=none header.from=orange.com;
 dkim=pass header.d=orange.com; arc=none
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Failing ARP relay net -> Linux bridge -> veth port --> NS veth port
Thread-Topic: Failing ARP relay net -> Linux bridge -> veth port --> NS veth
 port
Thread-Index: AdoIC3wHcGg+TVBATj6DY4A37XUwPAABWDhg
Date: Thu, 26 Oct 2023 13:35:08 +0000
Message-ID:  <DBBPR02MB1046348F8268D662710176873F8DDA@DBBPR02MB10463.eurprd02.prod.outlook.com>
References:  <DBBPR02MB1046314BA5152FC3DF60775D9F8DDA@DBBPR02MB10463.eurprd02.prod.outlook.com>
In-Reply-To:  <DBBPR02MB1046314BA5152FC3DF60775D9F8DDA@DBBPR02MB10463.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels:  MSIP_Label_e6c818a6-e1a0-4a6e-a969-20d857c5dc62_ActionId=966cc1f0-da45-4d58-8bb9-33f620295bf4;MSIP_Label_e6c818a6-e1a0-4a6e-a969-20d857c5dc62_ContentBits=2;MSIP_Label_e6c818a6-e1a0-4a6e-a969-20d857c5dc62_Enabled=true;MSIP_Label_e6c818a6-e1a0-4a6e-a969-20d857c5dc62_Method=Standard;MSIP_Label_e6c818a6-e1a0-4a6e-a969-20d857c5dc62_Name=Orange_restricted_internal.2;MSIP_Label_e6c818a6-e1a0-4a6e-a969-20d857c5dc62_SetDate=2023-10-26T12:53:07Z;MSIP_Label_e6c818a6-e1a0-4a6e-a969-20d857c5dc62_SiteId=90c7a20a-f34b-40bf-bc48-b9253b6f5d20;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR02MB10463:EE_|VI1PR02MB6239:EE_
x-ms-office365-filtering-correlation-id: 83773f66-f909-4875-62f5-08dbd6285f60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  IL3NNZZfZbp9Gqk6OaGOp5+F6cBHtHT+WKChg9g/6SVyNfUM7KAc4n7na+I2l63QlPfjRX5sZKz+HL1CcHyNEZ2r8OT/8Xd5G5ThNJMyQqb8IYyUSuRR8VUXKV/2rdiF02QMgkYWeb7VDrAqr7BsVC8fi7H57lh3nxjCvXHq8XSqyi3CsvxzvgOEHjYveW4h6mTYeNUJI/sQZ4X2FYCDUlwtIJj4Ft6D57qvoxmus25kPTGpyP8GIwB+l7g4R5z2hKAKfmuMbxqCYytDpKscI2lvEcbzFB3P5CEU8Cxb6Gj6fQ6Es3igfLh/g48nldWiAKU3eCQg8KTxXso5YtDlti+ulbYzWab1S8p3tbNWYwFuV8ABaV4bA2dJ9d9JbGyY8gBZ9BHIdIR7rvW2k3Y65pvIOu5tBc2faGEeQolPXmddTy/KpMgmMYBDhVlnvVopiHr6zkrUvSW8ACH7n8XfqriM8z1MNp1X7piQVopGogYdSca7FghZw3plYDEKRDNOd7DzJspfiM6bZ3B7iA2SlLpmeZIFB5wQRPfTU+P6UBpclA/xZQo7Tv9nFCTrQepNiyOctj6HAYb60PJAlauZkt7OqnBpLV9wb86lU0smIt0=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR02MB10463.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(55016003)(2906002)(41300700001)(38100700002)(122000001)(478600001)(2940100002)(66556008)(66946007)(76116006)(64756008)(7696005)(71200400001)(6506007)(66446008)(316002)(6916009)(966005)(9686003)(66476007)(83380400001)(86362001)(52536014)(5660300002)(33656002)(8676002)(8936002)(26005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dWZuK01IVlQ0MDBEeGZHT3lmVERVN1MxTDFEVHhSQUVuLytxQ0NVZFBFMEZ6?=
 =?utf-8?B?UENrNFBXcUdVdHJMWW9mNThPUmdDQ2pJZllydkZNK01NL1NaOGVLU0NlMjho?=
 =?utf-8?B?UlgyVWFkSEE0ZWYrTTZUMFg4S0pyWGFxdXhYTExYMjlrbVVneVY3aFZOYk83?=
 =?utf-8?B?OHkwNUxYdkJzV3RDcDh1MWExU0lsV0Yycmw0YXRkV0dCYk0zWU9yQmZZSEpn?=
 =?utf-8?B?ZkVGRHIvbURjWGRWVU8vc0YyL3FUcTFpQU1sSCtJRUFEazhqTW12QWFGK1po?=
 =?utf-8?B?T04vUzZuc1Q2aExUWWJNeGM3TjZsRGF5ZktzWFFjODh1aWZtZGJkSDA4UnBH?=
 =?utf-8?B?bHRkcnZxaXdkWWgzbzdwVjlJdkVoZjRZRWV1ZWpxR1h5VXZIS0pDV1h0WU93?=
 =?utf-8?B?a1RENHN2VjdTTklsMFdBL3dBUzdPSW9ycXQwK3crZDNDQmhMbE1FTFdQTG5W?=
 =?utf-8?B?UXhaMlM1a3lMMWlkU1ZtSG02bXFPcEplYjVMSmtoS0lZYU1SSWxGd3Z2ZGxi?=
 =?utf-8?B?bStrdTNPRWxncE11SkVwU29UQm93cnZDZkpxYXBhcGRiRmNYZVhZQ2VlRzMx?=
 =?utf-8?B?cG14VFh1Q3dpWk9oKzN1OC8xUVl5a1RLMDRpVWF6MVBCellvTjZucnp2UjRs?=
 =?utf-8?B?NHU4L01zSE1VVitYMkEvY0pXZkVGSDRPM1I0OHE2TjQrUHZkTk81U1NCZ3I0?=
 =?utf-8?B?cmIrTFlwb0k2ZWd2UzdQbnphN1Iwc0VLY0hGQjB4aFoybjFMNlhFYVhudkpG?=
 =?utf-8?B?TEowZElkKzNPenlWdHUyalFQSFZPWDBtS01JblR2Q0dvY0JwYjZydjV4M250?=
 =?utf-8?B?OUFTNXZ3UHZJRExLNDFLc3R2cktOU0VlLzNBL0t5dXJobkVqeXdDQXJxTFU3?=
 =?utf-8?B?Qk4rN2tjd0lMYlRtSkFZY3ZTWFNsdStuaE01WWpNczdEdDhsKzVwMjVDeGdF?=
 =?utf-8?B?SVFKWGFtSVdYMUZLWWpKWklhVXphME9RRENTQStTamZpMnlYK1FVN2ZRNitQ?=
 =?utf-8?B?YVMzNGhXNUtYM2V6UWxsSmlNaDFSdTBla2QwekRTa1VzS0RjdTRjUFVtSDFo?=
 =?utf-8?B?Y1plRWRnSzhvTEcrOXBOWkVodzdiYTA5STF2eGVtaW1ma0p3L0cyck5ndVdj?=
 =?utf-8?B?V0pTSnEyMGZqaXlLaUtmQ2R6bGh6aDVlV3dvZVlNNk0ycDJWVHVoWmxyN08v?=
 =?utf-8?B?SHZ2aEtOTEdzdUtNWHlHTU9PU1M3d2gvUE9qdTNoNk1IMjZ6RHliVWhQSFgz?=
 =?utf-8?B?ZkZGTXZLTmo3aXk5WExDeTdjZUZDeTJxRzhxZ1BUaTQzTHpQdXhrU2g2bmlS?=
 =?utf-8?B?OUNJRmUwTXV1Y2o4WWdFeUJ4Rkc2bmdFSGxpV0ZkVVN3S3UzQnNoNGVFMUlV?=
 =?utf-8?B?RXN5RFEzVUxOVUpxL1lQancrSnhlVjFwZ1I0ek5wVllnUmdSUDFKUVVxbUgx?=
 =?utf-8?B?czQ1dVp5dk0wMWx2cWtzeEk2MzNOVjhGdVdKdGZVZGphYllJcVp2RmJEOTZq?=
 =?utf-8?B?cVRhc3FuL1ZjRmcyVmVDQzRuU0VteG1kNFJkOFlFYmkweGRJU29OSmEzbE10?=
 =?utf-8?B?UkNCWEhpK1NYRVhEVjJtTzVzeGE5dFNncEFVRG9vbkt0NjYyUjNKZERPMS8r?=
 =?utf-8?B?N2xMcHAwMFlTMGVLRER5NndRa3NtbWF3Tnlwdy96dUFhM000UUQ5WjhoQ3Na?=
 =?utf-8?B?VkhBbWdKcGZRYTdqQ001Wm82WE1tRGtsQUl0U1pMTy9oUVJGSDFPT0FPY1d6?=
 =?utf-8?B?aTlUUzlwWFBSLzY4MVpyOXliTTlTcHdKZHdReUdWakN6dlhFdnJQcmZVT0U5?=
 =?utf-8?B?YjlIMWFyRVJPLzBZd0tOV2NFayt3UXEvbi9vL0dXMnE0M1g1eUxvVUxTSUMz?=
 =?utf-8?B?MjU2eUNNcmNTWk5XY3J6VHJRSDNQN3hxek4zTUl1NUJneEJvZ2crR2VjUllh?=
 =?utf-8?B?OExpTklIMzIvejJta1dDMXZ3STNHRWJNRXk4aU00OHp3d0lPUmNuSlpWc2VV?=
 =?utf-8?B?QllHcmJVYXkyR2JDVFRTNHRKUzF4a2xwYmhQWmdEcThrd2hxUlg2Qmk3T2ZB?=
 =?utf-8?B?U0VwVmx5eTBJY2g4M29IcUtnM2QxZlQwcDVqNkQyRkM4d1UrakRMVVFQSXVx?=
 =?utf-8?Q?XjZ1EBqnGkG0oI7Lz5M1qWSWC?=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: orange.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR02MB10463.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83773f66-f909-4875-62f5-08dbd6285f60
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 13:35:08.9868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 90c7a20a-f34b-40bf-bc48-b9253b6f5d20
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95WvSEbQFwTtcvopZmbqi/3zDFmQ0Rbnsh3Wl5FXuLk1AbeY9jrvdEA7IXoVhN6Q/F5Qgl4h31JvYQiRdhTkbgJSVx3HLYFGUsbLpj51gxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6239
X-TM-AS-ERS: 10.218.35.130-127.5.254.253
X-TM-AS-SMTP: 1.0 c210cC1vdXQzNjUub3JhbmdlLmNvbQ== cGV0ZXIuZ2FzcGFyb3ZpY0Bvc
	mFuZ2UuY29t
X-TMASE-Version: DDEI-5.1-9.0.1002-27960.000
X-TMASE-Result: 10--10.127800-10.000000
X-TMASE-MatchedRID: Wki5Ti/f7I0b7cS6uOapvUlyMZ48GKwUNZEftOVQtYYH2Q+J/X2RzY93
	WUsgC0XiEaIcSv1MGe8zd+tJEfcx1NTC3UH57x8TrNKxm3nhqPuqs/0W54MkmbsxaV++Bs1rOcY
	/jkDGKiJ4tGXFFtaaO4kUIvLNLSdCO5k/PxBAvv7x5KZMlKYS/ZpHQFN7rLyrL31P64kiV5FvXF
	TtvgJmGrkdO5xssgStBIKot66hHGMIaofrtSGke99JA2lmQRNU9v33UW8WNYDQ7/SkjInfUYQpG
	uv2TA71lbFreknxe5YiE0+hui10xcSdkLSeYG0/SHCU59h5KrH+LcfLTUZWxYpLyz8UyqY4/1fe
	vH+3vkFXE0UqF5V5vI/XVyVWWjdhudhhzm2RbGcFxov+3JYvYzAnAH1MqYlYtwi3bXRtaAhuvyB
	makZ0Gy2WBzJ7x01t8PUdvACDy0gcc/3hS3HVLV5hVZTm4dD8vO61PPXizykYdZqQlzVQvMxhaZ
	r7zvzSEtWb48OavuwOQRICRRZucpH0YXYnbGozwFfgh7LT1PhVvetmPD9unBTJFL84IP3F+ZL5o
	+vRV7wDpAZ2/B/BlgP5zT0d393cOwBXM346/+xnc22teOWNrk0Dxwg/lBIgVyEVF8NlwDRND0DB
	ZwqbeENz5ZZ5+UcA
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 2b360fbe-d1e3-4d61-b51a-8e2e30f8c92b-0-0-200-0
Content-Transfer-Encoding: base64

SGVsbG8gS2VybmVsIHRlYW0sDQoNCkkgd291bGQgbGlrZSB0byByZXBvcnQgcHJvYmxlbSB3aGlj
aCBwb3NzaWJseSBoYXMgdG8gZG8gd2l0aCBJUFJPVVRFMiBwYWNrYWdlLCBJ4oCZbSBleHBlcmll
bmNpbmcgaXQgYm90aCBEZWJpYW4gMTAgYW5kIDEyIGFuZCBkb27igJl0IGtub3cgaXQgdGhpcyBp
cyBpbmR1c3RyeSB3aWRlIHNvIHVzaW5nIHlvdXIgY29udGFjdCBwZXIg4oCcaXDigJ0gbWFuLXBh
Z2UuIEkgcmVhbGx5IGNhbuKAmXQgYXBwcmVjaWF0ZSBlbm91Z2ggdGhlIHdob2xlIG5ldHdvcmsg
a2VybmVsIGV2b2x1dGlvbiBoYXMgY29udmVyZ2VkIHRvIOKAnGlw4oCdIHRvb2xzIGFuZCBjb21m
b3J0IHdpdGggaXQgaW4gZ2VuZXJhbC4gSSByZWFsbHkgZGlkIG15IGJlc3QgcmV2aWV3aW5nIGF0
IGxlYXN0IDcgc3RhY2stZXhjaGFuZ2UgKGFuZCBsaWtlKSBzdG9yaWVzIGFuZCBJ4oCZbSBhdCBt
eSB3aXTigJlzIGVuZCwgd29uZGVyaW5nIHdoeSB0aGlzIGlzIHBvc3NpYmx5IG5vdCBmaXhlZCBp
biAyMDIzIHNlZWluZyBkZWJhdGVzIGdvIGJhY2sgaW50byBsaWtlIDIwMTQuLg0KDQpTbyBpdOKA
mXMgcGxhaW4gc2ltcGxlIHRvIHdhbnQgdG8gbWFrZSBtdWx0aXBsZSBuYW1lc3BhY2VzIGFibGUg
dG8gY29tbXVuaWNhdGUgdmlhIGNvbW1vbiBob3N0IGJyaWRnZSB0byBleHRlcm5hbCBuZXR3b3Jr
LiBWRVRIIHRlY2ggaXMgYWxsIHRpbWUgZG9jdW1lbnRlZCBhcyBzb2x1dGlvbiB0byB0aGlzLiBU
aGUgcHJvYmxlbSBvbiBnaXZlbiBwYXRoIGluIHN1YmplY3QgaXMgdGhpczoNCg0KTlMgdmV0aCBJ
UEAgPSAuMjUxDQooQnJpZGdlKSB2ZXRoIElQQCA9IC40NA0KQnJpZGdlIElQQCA9IC4yNTQNCkV4
dGVybmFsIElQQCA9IC5vdGhlcg0KDQoxKSBXaGVuIEkgaW5pdGlhbGx5IHNldCB1cCBwbGFpbiDi
gJx2ZXRoIHBvcnQgLS0+IE5TIHZldGggcG9ydOKAnSwgd2l0aCBJUEAgYXQgZWFjaCBlbmQsIGl0
4oCZcyBhbGwgc2VhbWxlc3MsIEFSUCBhbmQgcGluZ3MuLg0KPj09IDIpIE9uY2UgSSBlbnNsYXZl
IHZldGggcG9ydCB0byBicmlkZ2UsIEkgY2Fu4oCZdCByZWFjaCBleHRlcm5hbCBuZXR3b3JrIDw9
PT0NCjMpIFZldGggYWxzbyBkb2VzIG5vdCB3b3JrIG9uIElQIGxldmVsIGFueW1vcmUsIGFsbCB0
aGUgdGltZSB3aXRoIElDTVAgZWNob8KgIGZyb20gTlMgc3BhY2UgaXQgcnVucyBBUlAgZmlyc3Qs
IHRob3VnaCBib3RoIOKAnGlwIG5laeKAnSBhcmUgcG9wdWxhdGVkIHdpdGggbXV0dWFsIE1BQyBy
ZWNvcmRzLiBUaGUgZm9sbG93aW5nIGdvZXMgaW4gbG9vcC4uDQpwZXRlcmdAZGViaWFuOn4kIHN1
ZG8gdGNwZHVtcCAtbmkgdmluZXQtYnJwDQp0Y3BkdW1wOiB2ZXJib3NlIG91dHB1dCBzdXBwcmVz
c2VkLCB1c2UgLXYgb3IgLXZ2IGZvciBmdWxsIHByb3RvY29sIGRlY29kZQ0KbGlzdGVuaW5nIG9u
IHZpbmV0LWJycCwgbGluay10eXBlIEVOMTBNQiAoRXRoZXJuZXQpLCBjYXB0dXJlIHNpemUgMjYy
MTQ0IGJ5dGVzDQoxMToxODoxMi45NjY5NTUgSVAgNzAuMC4wLjI1MSA+IDcwLjAuMC40NDogSUNN
UCBlY2hvIHJlcXVlc3QsIGlkIDIzMzMsIHNlcSAwLCBsZW5ndGggNjQNCjExOjE4OjEyLjk2Njk4
NCBBUlAsIFJlcXVlc3Qgd2hvLWhhcyA3MC4wLjAuMjUxIHRlbGwgNzAuMC4wLjQ0LCBsZW5ndGgg
MjgNCjExOjE4OjEyLjk2Njk4OSBBUlAsIFJlcGx5IDcwLjAuMC4yNTEgaXMtYXQgMGU6NjE6NzI6
OTc6YWE6ZmYsIGxlbmd0aCAyOA0KMTE6MTg6MTMuOTY3OTk0IElQIDcwLjAuMC4yNTEgPiA3MC4w
LjAuNDQ6IElDTVAgZWNobyByZXF1ZXN0LCBpZCAyMzMzLCBzZXEgMSwgbGVuZ3RoIA0KNCkgT25j
ZSBJIGNvbmZpZ3VyZSBicmlkZ2UgaWZhY2Ugd2l0aCBzb21lIElQIGFkZHJlc3Mgb2Ygc2FtZSBz
dWJuZXQgLzI0IGxpa2UgdmV0aCBhbmQgTlMgdmV0aCAoYWxzbyBleHRlcm5hbHMpIHVzZSDihpIg
dGhlIE5TIG5laSBjYW4gc2hvdyBjaGFuZ2luZyBNQUMgYWRkcmVzcyDCoGZvciBicmlkZ2UgdmV0
aCBpZmFjZQ0KMTE6MzA6MjcuODYwOTA3IEFSUCwgUmVwbHkgNzAuMC4wLjI1MSBpcy1hdCAwZTo2
MTo3Mjo5NzphYTpmZiwgbGVuZ3RoIDI4DQoxMTozMDoyOC44NDgyNTEgSVAgNzAuMC4wLjI1MSA+
IDcwLjAuMC40NDogSUNNUCBlY2hvIHJlcXVlc3QsIGlkIDIzNTIsIHNlcSAxNCwgbGVuZ3RoIDY0
DQoxMTozMDoyOC44ODQ4OTIgQVJQLCBSZXF1ZXN0IHdoby1oYXMgNzAuMC4wLjI1MSB0ZWxsIDcw
LjAuMC40NCwgbGVuZ3RoIDI4DQoxMTozMDoyOC44ODQ5MDggQVJQLCBSZXBseSA3MC4wLjAuMjUx
IGlzLWF0IDBlOjYxOjcyOjk3OmFhOmZmLCBsZW5ndGggMjgNCjExOjMwOjI4Ljk4MDg5MCBBUlAs
IFJlcXVlc3Qgd2hvLWhhcyA3MC4wLjAuNDQgdGVsbCA3MC4wLjAuMjUxLCBsZW5ndGggMjgNCjEx
OjMwOjI4Ljk4MDkwOSBBUlAsIFJlcGx5IDcwLjAuMC40NCBpcy1hdCAwMDo1MDo1NjowMTowMTow
MiwgbGVuZ3RoIDI4CTwtLS0NCg0KaW5ldF9iYXNoID4+IGlwIG5laQ0KNzAuMC4wLjEgZGV2IHZp
bmV0wqAgRkFJTEVEDQo3MC4wLjAuNDQgZGV2IHZpbmV0IGxsYWRkciBjZToxODoxNjo0YjowYzpj
MiBERUxBWQk8LS0tDQoNCjUpIFRoZSBicmlkZ2UgdnMgTlMgdmV0aCBwaW5naW5nIHdvcmtzDQo2
KSBUaGUgYnJpZGdlIHJlbGF5cyBBUlAgaW50byBleHRlcm5hbCBuZXR3b3JrIGFuZCBiYWNrIChj
aGVja2VkIG9uIENpc2NvIHN3aXRjaCksIGxlYXJucyBvZiBleHRlcm5hbCBNQUNAcyANCj09PT4g
NykgRXh0ZXJuYWwgTUFDQCBkb2VzIG5vdCBtYWtlIGl0IHRvIE5TIHNwYWNlIGJ5IEFSUCAgICA8
PT09DQo4KSBJIGRvbuKAmXQgYWltIHRvIGRlcGxveSBJUEAgd2l0aCBicmlkZ2UgYW5kIGJyaWRn
ZSB2ZXRoIGlmYWNlcyDihpIgdGhpcyBpcyBqdXN0IHRvIGNoZWNrIGhvdyBpdCB3b3Jrcw0KOSkg
VGhpcyBibG9nIHdhcyBxdWl0ZSBzdXJwcmlzaW5nIHN0YXRpbmcgdGhhdCBicmlkZ2Ugd2l0aG91
dCBJUEAgY2FuIGFmZmVjdCByb3V0aW5nIGluIGdsb2JhbCBuYW1lc3BhY2UsIGZldyAvc3lzIGtl
cm5lbCB0d2Vha3Mg4oaSIG5vIGhlbHANCmh0dHBzOi8vdW5peC5zdGFja2V4Y2hhbmdlLmNvbS9x
dWVzdGlvbnMvNjU1NjAyL3doeS10d28tYnJpZGdlZC12ZXRoLWNhbm5vdC1waW5nLWVhY2gtb3Ro
ZXIvNjc0NjIxIzY3NDYyMQ0KMTApIEV2ZW4gdHJpZWQgdG8gc3RvcCBkZWZhdWx0IE1BQyBsZWFy
bmluZyBvbiBicmlkZ2UgdmV0aCBpZmFjZSBieSDigJxpcCBsaW5rIHNldCBkZXYgdmluZXQtYnJw
IHR5cGUgYnJpZGdlX3NsYXZlIGxlYXJuaW5nIG9mZuKAnSDih5IgZGlkIG5vdCB3b3JrLCBuZWln
aCBmbHVzaGVkIGFuZCBwaW5naW5nIC4yNTEgdnMgLjI1NCBqdXN0IHdvcmtlZC4NCg0KU28gSSBi
ZWxpZXZlIHRoYXQgYnJpZGdlIHZldGggaWZhY2UgaXMgYnJva2VuIGluIGl0cyBlc3NlbnRpYWwg
ZnVuY3Rpb25hbGl0eSB1c2luZyBkZWZhdWx0IOKAnGxlYXJuaW5nL2Zsb29kaW5nIG9u4oCdIHNl
dHRpbmdzLg0KDQpUaGFua3MgZm9yIHlvdXIgdGltZSAgdG8gbG9vayBhdCB0aGlzIGFuZCBnaXZl
IGhvcGUgb3IgZGVueSB0aGlzIHNvIEkgbmVlZCB0byBjcmVhdGUgZXh0cmEgcG9ydHMgaW4gbXkg
aG9zdCB0byBnZXQgd2hhdCBJIHdhbnQgdG8uDQpCUg0KUGV0ZXINCjxicj48ZGl2IHN0eWxlPSd0
ZXh0LWFsaWduOiBDZW50ZXI7Zm9udC1mYW1pbHk6IEhlbHZldGljYSA3NSBCb2xkO2NvbG9yOiAj
RUQ3RDMxO2ZvbnQtc2l6ZTogOHB0O21hcmdpbjogNXB0Oyc+T3JhbmdlIFJlc3RyaWN0ZWQ8L2Rp
dj4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
Q2UgbWVzc2FnZSBldCBzZXMgcGllY2VzIGpvaW50ZXMgcGV1dmVudCBjb250ZW5pciBkZXMgaW5m
b3JtYXRpb25zIGNvbmZpZGVudGllbGxlcyBvdSBwcml2aWxlZ2llZXMgZXQgbmUgZG9pdmVudCBk
b25jDQpwYXMgZXRyZSBkaWZmdXNlcywgZXhwbG9pdGVzIG91IGNvcGllcyBzYW5zIGF1dG9yaXNh
dGlvbi4gU2kgdm91cyBhdmV6IHJlY3UgY2UgbWVzc2FnZSBwYXIgZXJyZXVyLCB2ZXVpbGxleiBs
ZSBzaWduYWxlcg0KYSBsJ2V4cGVkaXRldXIgZXQgbGUgZGV0cnVpcmUgYWluc2kgcXVlIGxlcyBw
aWVjZXMgam9pbnRlcy4gTGVzIG1lc3NhZ2VzIGVsZWN0cm9uaXF1ZXMgZXRhbnQgc3VzY2VwdGli
bGVzIGQnYWx0ZXJhdGlvbiwNCk9yYW5nZSBkZWNsaW5lIHRvdXRlIHJlc3BvbnNhYmlsaXRlIHNp
IGNlIG1lc3NhZ2UgYSBldGUgYWx0ZXJlLCBkZWZvcm1lIG91IGZhbHNpZmllLiBNZXJjaS4NCg0K
VGhpcyBtZXNzYWdlIGFuZCBpdHMgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFs
IG9yIHByaXZpbGVnZWQgaW5mb3JtYXRpb24gdGhhdCBtYXkgYmUgcHJvdGVjdGVkIGJ5IGxhdzsN
CnRoZXkgc2hvdWxkIG5vdCBiZSBkaXN0cmlidXRlZCwgdXNlZCBvciBjb3BpZWQgd2l0aG91dCBh
dXRob3Jpc2F0aW9uLg0KSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciwg
cGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGFuZCBkZWxldGUgdGhpcyBtZXNzYWdlIGFuZCBpdHMg
YXR0YWNobWVudHMuDQpBcyBlbWFpbHMgbWF5IGJlIGFsdGVyZWQsIE9yYW5nZSBpcyBub3QgbGlh
YmxlIGZvciBtZXNzYWdlcyB0aGF0IGhhdmUgYmVlbiBtb2RpZmllZCwgY2hhbmdlZCBvciBmYWxz
aWZpZWQuDQpUaGFuayB5b3UuCg==


