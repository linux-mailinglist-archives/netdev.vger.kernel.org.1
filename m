Return-Path: <netdev+bounces-22785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2377693D5
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 12:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BCD1C20BD3
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 10:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEEE17FE0;
	Mon, 31 Jul 2023 10:57:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB0717ADA
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 10:57:38 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C546710D0;
	Mon, 31 Jul 2023 03:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4aNyO6NMve6sMt2IuYn/DVnczgPJCEikXQkrGHAcJ6mQEpZAYjUm5NMbnehymj89wVvOGvTzge20UBS4fUxrWriHYcuJhOjv8xbaRTLJYcOGNZb+A1LItUs+jiGoKDOxtqq35hotvHbUDsvkTXilvBOlntNTINLhZHDJIhfbmITgFHtcztJY/77ulmBwdEl7ZxLJ+heGCyF7dogMhrueWEJZ6HdwLFl/CdMM5wv/aSx0FJ8Ba8EhD+kv9xaQO+ZQX72k/duO2tObtMdVyz6MbQkiRgg4KRmUgBXwsM2P4AFdJMRzCoMNsAHQ/0RbiJHImaONzQwNSZ+PTfB79572A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TM8KNyYt98lV32zZI2ADB6ym0vK7VLBB4pmG21Li4I0=;
 b=iKuAbo1mx2iSzYUlwQLujATjBAJU++PgMI/wvucDbPKF6880AZT8lZCDYz8ga9bkkIuN8CYfZZbvSOHajt+5b5UW6b9rlqoHKBzEFsqpvWB4MpaDa9IwS/65Vb8ZZLZlvMZwIJeES8OWwSBvnc/aTbDx9gPi5PmMRoPWsJlU40v4GpHQlCUcm5GBdCRU/d7MPgjHt7Bin8ASpmQIT4hIICPiu+6+C6RutGTC/LWBs7uJJeRTgtott8N8fR/PdmEc35IQrE7hA6EzcPVva9l8Muoo/3tsGhl6x6E4LEqcpQtp3LbzPiGeu1LCSu1z4JvrCAP2deZ3wKnSDa+wkUnyTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM8KNyYt98lV32zZI2ADB6ym0vK7VLBB4pmG21Li4I0=;
 b=48VpznQH0C7+C807j/oBmuWrjAnOPGFtIB2MC7hzIPPvcFp5MvC+7hj1QrnUcLCLVnncGKkJSa+XoMZkMZrTx55/x2pxyUAkcvPagZHKW0RY24TdI7dhYU3x5TzHHEfLD1MXOpbpOD6Zdu0P6McYNP2LWjul/9BNE6noF6rqass=
Received: from BYAPR12MB4773.namprd12.prod.outlook.com (2603:10b6:a03:109::17)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 10:57:32 +0000
Received: from BYAPR12MB4773.namprd12.prod.outlook.com
 ([fe80::f440:1885:f3ad:3a17]) by BYAPR12MB4773.namprd12.prod.outlook.com
 ([fe80::f440:1885:f3ad:3a17%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 10:57:32 +0000
From: "Katakam, Harini" <harini.katakam@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Esben Haabendal
	<esben@geanix.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Simek, Michal" <michal.simek@amd.com>, Haoyue Xu
	<xuhaoyue1@hisilicon.com>, huangjunxian <huangjunxian6@hisilicon.com>, Yang
 Yingliang <yangyingliang@huawei.com>, Rob Herring <robh@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH net] net: ll_temac: fix error checking of
 irq_of_parse_and_map()
Thread-Topic: [PATCH net] net: ll_temac: fix error checking of
 irq_of_parse_and_map()
Thread-Index: AQHZw4KW1H8QiE0b7EaAkjTGh0PxIa/TtE8A
Date: Mon, 31 Jul 2023 10:57:31 +0000
Message-ID:
 <BYAPR12MB4773D13A8899C2F47CA66C049E05A@BYAPR12MB4773.namprd12.prod.outlook.com>
References: <3d0aef75-06e0-45a5-a2a6-2cc4738d4143@moroto.mountain>
In-Reply-To: <3d0aef75-06e0-45a5-a2a6-2cc4738d4143@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4773:EE_|BL1PR12MB5852:EE_
x-ms-office365-filtering-correlation-id: e4cdacec-f9e2-4f0d-b0b6-08db91b4f0a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aVKzfAvTsZGOE+x0ArZ+jXHwZ745Sq8465jgPWVWpnEdxRZqlCaF9OzblusSHabUkULZ1mKLiiLMk+E3vPRhEXt7E+SWbXX+C5OC7QJdkJ/s93dIJcLTJ0y1wc9WSnoH80uiBqtsP/gap7T3uaZ3dwTt38AS3ByEg3tQtTpnXA9LRLyxC8B8lExZua1A3Ttnw/Da8oQa/rcx7ThYCnRqJutOjaG/10lX9VbpHDQecbI+tG9tdnVl85x500KlxViL0rG3IoBKD56vR5euVFL6Fqy5vHecnteMGb0HrCyHfX7ja+LtKjUqZki0kkXyCTt9tRDxCZHqOsN/eLFxwZjZUvhn6CmTIDE7rZFw9iXYF7iwbhtwnYkcJj6YNb/+qsDM8UVG5L/3rEGHwQJMygAcfaK5MVy5GzYGHqU4BgYtRDnRTSLZchISNNeflWeyaCl8UT2el1G17zG/mnI8I8Dk2kg3hMpJE/RaRAJlitimhHn21i+d3eXgwMseyiGSRjq6ATENQZsiAMjpvfqbw/njOLYcoKcA1IcHi46nfyyhHP0BOuJeKXkrMjebTldVIWgtYDGmujGWIz4EGP1BAEboXMt8XkRCiv3FUiphk2eTugqbfIDc65idKJfOX8KwjXM9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4773.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(41300700001)(5660300002)(66946007)(76116006)(8936002)(8676002)(55016003)(52536014)(54906003)(110136005)(4326008)(478600001)(64756008)(316002)(7416002)(66556008)(66476007)(2906002)(66446008)(4744005)(7696005)(9686003)(71200400001)(38100700002)(53546011)(6506007)(26005)(186003)(83380400001)(33656002)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?seJp9Fd4UyZMH9/qLF+7xZ3S5sxqCFyXLSr617LBBLuC4pXGaArUY83LI5Bs?=
 =?us-ascii?Q?V6yAIEhS27n4VaMVeatWpXufPTOTpyfjyT+JntELDn/kF3KRpV/TEZjGghl/?=
 =?us-ascii?Q?bkKyrhffBG/D640ve5Fqs6DMectxIk68jlWMrqWKwqaid/mma7y9BNiaqqOW?=
 =?us-ascii?Q?cxmrPgaG5Wm3nvnX0epsWLodwBL6DUw531KcRINcC5NlQfSHZCxo8bUWf0OY?=
 =?us-ascii?Q?h7JXdBas4DR5rH7EIoJMECU3QvqV39pRNNtmET9UdKI5qivlyDsSuYWmbq9V?=
 =?us-ascii?Q?+oHIhOUUdlcqA5DNaMfbt1aqYxFdGO7hdaqC+XbM3VUNyrQ5NNgyGDv3J3UX?=
 =?us-ascii?Q?uwG9Zn7bNDHpgkb6aiHPbvxN9JE7ND66dLfMS/0jqwaBZiodPBkQPGMaJtzN?=
 =?us-ascii?Q?pZJVqsdgKDR9LM+pIbW7lyVrwbZ5+9wH62pGV+HzDv2p4/VtvxsOTCshXRIF?=
 =?us-ascii?Q?iSy0zrWU+pDdW9TNlquAi6Bd4gcWhJA5wg4mxLyNd3VUki5I6/Lx+ED1Yh/r?=
 =?us-ascii?Q?M/3wyvvj/oIfTbgNrQLoi7boCS5twzNXfBZ43k5RpiRuvDVs1IxUyXyKH3pm?=
 =?us-ascii?Q?Fuqq4TEs9i4rRUQTQQt7jDutuxfKhFqXhOd5eDwwdqPA3WRAH3W2S1oTkIBK?=
 =?us-ascii?Q?xWulejdyOoXzJrR9aOyhVmVkx0Rp7jCwX01e9LgcTJ8ODPJBlhsmmIOLWHNv?=
 =?us-ascii?Q?I7rmpxxZddgnVERtpJHsDnAXRGNWSzZ1F4jtkXFQFoT5Qf0tRQKNO3BdMUgg?=
 =?us-ascii?Q?FWkoWh8NfNoG15mMYSEz85drlxWJ2j4MENnxwA8cffY0wjy1EcY+6XKf2nEj?=
 =?us-ascii?Q?fVDkL3G4O1jsjeqCvjKg/F1RRC0KaVM2OZOqtYbIMG7WKh6gLjZgR/G0vNa/?=
 =?us-ascii?Q?Xv6VF0S85sd5Tnc/6Bn3geYmwiNFjTWNCmcFP9fyqcJXQzwfImu9b8wCWfp7?=
 =?us-ascii?Q?ZKELqfoPR6fgkY3EA1DtmGEbzGrfxnZMt5jKzEmqPulubYzpqphQSmX5Orof?=
 =?us-ascii?Q?E3aFtX70kqY/Qv5UPQU4oBrT4t28nL8V1ryvOXpc47XMf2W5OX8CNXuhIIiX?=
 =?us-ascii?Q?o0Q3eUSGn+VHIMNr9pcrOzniGtkJhoIh/na1bCD4ebeQkNyaVs57wW5iSB1Z?=
 =?us-ascii?Q?FP8dsCna0oac+BAJglx4XdADChwdcpeu/NvpHAW9iNpHB2Tmy20qO7g71qjn?=
 =?us-ascii?Q?yev1DRdlU3RdfVXFlXor61IXzulyE4B0irNiM7bLlq59vLIjHSG+pyA+sp3P?=
 =?us-ascii?Q?t9zxlepjFN3LGqwE4wvB50rpgzYHeFdi0uxo/GRQbSs7dnI8vyXhjgMvX4Wj?=
 =?us-ascii?Q?2esrcdQ/a5C7GT6YBr8xSDb0CHRW3yHcMSNRlNwWxZJscHQgM4dznYDOLJYC?=
 =?us-ascii?Q?iXdAoi4SdctggJFprRe1XNgf0XmxRe2o4yPhYi4yThYLwtFTsHkljwAAQo5m?=
 =?us-ascii?Q?G7X/C6zOfttzaXKuEDyeTXr//VY5AQajc8lQLsqfEjyFmUlMMAcpq2wb1e0E?=
 =?us-ascii?Q?FOxk6B2rqFD44871przau67FaXYW+JAvpZC99eTCDmZYqtMbjB8NZNuPtnxi?=
 =?us-ascii?Q?/Ctf+WrehxE0bT6eW8A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cdacec-f9e2-4f0d-b0b6-08db91b4f0a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 10:57:32.0044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgGE9AX10Eqz6/MA540phv6acDeQJTqEWIuFp5fON9Wv+ZbWBE6/7BXGIfawnGL1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Monday, July 31, 2023 1:13 PM
> To: Esben Haabendal <esben@geanix.com>
> Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Simek, Michal <michal.simek@amd.com>; Katakam,
> Harini <harini.katakam@amd.com>; Haoyue Xu <xuhaoyue1@hisilicon.com>;
> huangjunxian <huangjunxian6@hisilicon.com>; Yang Yingliang
> <yangyingliang@huawei.com>; Rob Herring <robh@kernel.org>;
> netdev@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH net] net: ll_temac: fix error checking of
> irq_of_parse_and_map()
>=20
> Most kernel functions return negative error codes but some irq functions
> return zero on error.  In this code irq_of_parse_and_map(), returns zero
> and platform_get_irq() returns negative error codes.  We need to handle
> both cases appropriately.
>=20
> Fixes: 8425c41d1ef7 ("net: ll_temac: Extend support to non-device-tree
> platforms")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks,
Reviewed-by: Harini Katakam <harini.katakam@amd.com>

Regards,
Harini

