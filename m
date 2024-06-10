Return-Path: <netdev+bounces-102272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBFC90229A
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 15:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261A41F22BC1
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65A982866;
	Mon, 10 Jun 2024 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K4GIgXvo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA2B824B3
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718025788; cv=fail; b=TrfXYUWBul4QVtgU8jc7W1x+Yb2ABQLZOYIC1vc5156KzIL0yW726wl96tdBhr3CRkrOEN2yFZ1svROtg6NA7JsChzfUlsoB/0XCrP1RSmLPsf0PG0yVWHEtRX2m/2eFsvewFcqjK3DjWicwggYT0M9Hf38UuMZU/3jjx4l7Sso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718025788; c=relaxed/simple;
	bh=6dSiSU/tp6fFYXWBYUUJ+5U7/yeTqfQntu0UhC1mAGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mAjrMzxHkk4QvAEYWEf6DoaDQemZc5U7RvD7DXrJrXo2prKQCxWTOLLAsSqbZM8zJ/D46yiYW+QlqiwgM9VTE4TWOExpd5CIbSZNTAw+5y/bF39gERLftH2W9s7zEZ+MHFYRSW3FDrz9cLQDdugGnbxYa9yZ8ZiHCyOoBryf2RE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K4GIgXvo; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO+wSLJNzLVP7+0BqmwcYnnzIRg532Wxrv/Pqig3jj5EPW5AHgbWVU1Bqgm8JwStrA6xzCREmDiIyvEqn8rNkUz4nKtJVBK4SF49dnfnNlOmfVwn4AfUF6aug+Dtwvu7Y59HoYgGMRQtbIVgQPo3sEN32hzsvXyzUzKhwjpJvFrh/8bdroi2kNt5r+5sxwpt5jX0yzHL6mgYz/rYkZOkFWZOGdaq0GpkMm2Hj2Z1Cc38lTynTFfERUgqgU8UYKX/o4eKT81w6vRZ1p5T0Lwpg8UXJwCsTgVBYsGB38kQXPbHTbdOv6tSDwhvgwrJG+WV6g7dAOLevhasDlFsz1Zedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dSiSU/tp6fFYXWBYUUJ+5U7/yeTqfQntu0UhC1mAGI=;
 b=LTlypSrSYsaDIadgEaKkN1YWyOTl/dWRaIDispPZ0t8p7lt+El4/Qj9ox7SqXwAJmcFX0U0tPRl68yqnLRJheNcFYSkM7zi42WFmjgLenGgnXdcuZRYdrxq73q2hXDmHC2tF2esQbWoLub0/Mzs765jlmE4cy2+FEcdJ5w6dqNK87o7kx2HQ4RxGIkvqYRwNFi4PX3YZYuxznVXbn6ioET0O+i1X0yUyt4LqHh8Lz9t5xtTtjyxwXo8LO+2CxGcYmHRPWJ7mlMuuUP1dNRiQ0ub08eDWrgsx6LD/xk6MhLtKHOekCZNWEu7ur1sTzPl+XxUREHZN6YYoipavO8QTjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dSiSU/tp6fFYXWBYUUJ+5U7/yeTqfQntu0UhC1mAGI=;
 b=K4GIgXvoymY3EAexBohgIN5wkfm6rM02U7aOSKglk1RKbnUc2Egx17D7ENwRemFdHK7JcB08qCZLw9kMUl/2pmIW4ihwAwefk5X4SCGe0uOEjFGYqS7bVyj0ajPKbQeYcnWNedp/heM0SDBSTSCeoqQ2qYlKzyRtbZRfCzi53CnkAAW4cpBwzM+XJ3kAxUo+7t2kLNxXyQsJbWEIEp1Gz4PaVPJ5flqTKHUnIAru6RHhTlRCPKuJ4OLSIWeBq6NRucCA6CPs338lndQcNe3xNu+eoXwki0qpOyKY3ck2M7Tk8nO1uWh+ocUenWxj9pcNb9csjx0Xass5aVhmJxmJUw==
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 13:23:02 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%7]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 13:23:02 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Jakub Kicinski <kuba@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "hch@lst.de" <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, "davem@davemloft.net"
	<davem@davemloft.net>
Subject: RE: [PATCH v25 00/20] nvme-tcp receive offloads
Thread-Topic: [PATCH v25 00/20] nvme-tcp receive offloads
Thread-Index: AQHaseFldF5s/ysj0kexkNBsBF8Mh7GwkuMAgBBFaYCAADZkMA==
Date: Mon, 10 Jun 2024 13:23:02 +0000
Message-ID:
 <SJ1PR12MB60759C892F32A1E4F3A36CCEA5C62@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
 <20240530183906.4534c029@kernel.org>
 <9ed2275c-7887-4ce1-9b1d-3b51e9f47174@grimberg.me>
In-Reply-To: <9ed2275c-7887-4ce1-9b1d-3b51e9f47174@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6075:EE_|MN2PR12MB4240:EE_
x-ms-office365-filtering-correlation-id: 662a54ac-3065-4b2c-0e90-08dc8950746d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?dEdqYUJOVy9IRjY3aUNvRHBxbXJNbUZmMlpJcDBaSElkbGs4K1oydHZkQU9h?=
 =?utf-8?B?d0d3TU5zTGZSN0Z4SVpCcVdnMFUwY01UZ0RGYXlPNFpyQXhFL3crME41VG80?=
 =?utf-8?B?TEIxbGs4NUdWbVgvSjVNUUgwQ1p1UzE2Z0owY1BDSXlXUytWVmNBSktwajdk?=
 =?utf-8?B?YnNCRTVwOGJxcXdXQkdpaUJEaVVZNDRTdDZpLzA0dDl5MWhXcW9HNTVrdENM?=
 =?utf-8?B?ZUROV1gxYnpFZGM3SVdhb1JOak9admU5OTZxaGVTOUN1SlJPblp4NFZnZm9m?=
 =?utf-8?B?aGJjVGdTdDdzRXNFMklCT1NGT240RFhUZm9iZW1vRHpqRVp0ZnllejRmL2dx?=
 =?utf-8?B?cEFKKy9DazduamVzTktIWGZ1SXJFY1hpeERwTU5kUVVJeFVzY2ljcWpKQ1hG?=
 =?utf-8?B?TzN1UFMwdTV4UkJQRWorMjQ4U2E5L1NlMGlBZGM1dEw3c2N5OE5ob3h1eDA4?=
 =?utf-8?B?amZNSGxjcWdWTktSVjhBd3FNTC9jNzRRZjhOZnkyb2dGUllqcGlBZUk2REk3?=
 =?utf-8?B?bDVCcmQ1MzJBNlFlYnN6emlpSFh3WExXYVRob2xxUVM0TmtpcDBlSDFjYnhO?=
 =?utf-8?B?bmYvWkxUa2g3Q2ZuQWhJWXVOR3RKamhoVE5LYWxkYW9xYTZxTlNkd3JSSGlw?=
 =?utf-8?B?TzZXT0MzS3pORm9hZWJ3d2x5NTQwa3dpSmpxRktGQy9iODZtUXlrMGVxcU5o?=
 =?utf-8?B?TDlzcGcrVExnTnNIV2sycVBERjZLT3hBT3VvVG5DZXQ4NXFudGdiTVpHRnNI?=
 =?utf-8?B?ODhrbE1qWThwdjdJYXBpaEdlNmtUVXd5UHpoaUg4eDdISkI1bkdIWUJJcmR1?=
 =?utf-8?B?R2RDbU85RElIZTRsMldBZ2t2Y1JFYlQxMi9hVmg3MnN5NWgxYWtOYXZ5R0hw?=
 =?utf-8?B?Y1psMi9GbGVzbEx0aTlWNlRzekpucnMwZ2d4WWVZcmxaVVZ3bHZXaVZKRk1w?=
 =?utf-8?B?dis4by80QmRBd2p1WE1zTGNiRCtoNUcxZkE1aW5oNmRhMFFISDZ0dXRmN2RP?=
 =?utf-8?B?Rjh3dk80d1hxUXBMTEJFcEI4dkRzMVd2bFNQMEd6SmhnUmJCTk9jT1RGd0xZ?=
 =?utf-8?B?dE5zYVFRZ0RLU0UwMG02YXhnZk15UFdsZkxZMUV2STJJK1d3dHhwOWhZVHJG?=
 =?utf-8?B?NnlDSkhCT0FpckF2a1R1QndDVXUrQmJsMVZ3UzdkNUt0VUF4Zk5QOW9vTCtn?=
 =?utf-8?B?UjJMNW9zcnYxenlWME5QR3p5NGtnZWlUUDM4VkI1c0ZrRVYydUZTNmEzUEtR?=
 =?utf-8?B?R2xxYWhGZS9aS3kvNmU0MnZXbmcySjlncTJBcU0zNkhuZ2xrMTZqZXJNVUpW?=
 =?utf-8?B?UDFIMy9RMy9WWWhNVi9RK1cxRk5sMXRpQUM2aVNtbVRQVXhNb0ZmKzVVRFBn?=
 =?utf-8?B?SE5BQTdoY0o1eVdHUVN5M0FZcHRPcnIrZnl6R2QxTE9kbDhPdG5hQUk4ODNC?=
 =?utf-8?B?OEsvenExVjF2VCtOUDVVaktWekU0UGZ1YjJwWGdvT2hGQ3RSOFVpUFJLNXVV?=
 =?utf-8?B?STcrclQ0OEliRkFkZjRzUE9IelN2OFU0QkQ4dG0vMVJtVHBUcG1VdmIwRGU2?=
 =?utf-8?B?dnVqMlFIaVZ4Umd0dnh2VDQ0VGp4dUtjeUJqOUtXSWhWNFF1WmkyNzlnS0xp?=
 =?utf-8?B?Y1A3MVFibzNFL1dreFUyQ2xCS1FTSGlselZNQmxaQ0x0eENFQ2dwVHpYQTBM?=
 =?utf-8?B?VjdNQThxMnVMM3N6c3R6eVlxV0p2eVJIUVJLQ2dPMGh4OUdPM3k0QUZ6TXpp?=
 =?utf-8?B?M2JWSHd2S211TnE4MkdzTlBsaUR1TmwwU0wrSkVHWTF0alY5YTN2aXlKcHN1?=
 =?utf-8?Q?mXKCk8vhTKbD3UGrgfvOsTMJNwtZMuUX1THEk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFRsSXh3dlBIamxDaEhoWmlNVVc3WkdRdkMxamhhei9jc0NEYldzQkZ6WlJF?=
 =?utf-8?B?aWNFNkIzVWREOWg3ZWdFdzUwdG42VjhiRDNDNS8yWkRKUUtHaTYvdUJTdHBa?=
 =?utf-8?B?RkFuR1NjRWFydHA4TFd2NHlUK1pjNDJHSGVLdFllUmFHem9qRXgrOXN0bS93?=
 =?utf-8?B?QTdKcDdVRDVHSnZML2NLNlFySmlGTkQvdnRld0ZiMFVzc2VJbUJrcitoQUM3?=
 =?utf-8?B?cXdGNU1ZYzc5eUZKYW4rQjl5cFNEc2ZZZFJrZFdNbTloWHVtQXZSd2xHZjJF?=
 =?utf-8?B?dldaRnpWb1EyeUZRbjV6R1puM3VINVhNY1V5UjU1UllXUXJJdmdyc1FWZTZZ?=
 =?utf-8?B?aXNDRlZYMzdtcVJOMGdGczVSSDU1NDZycGFkRVVOSXVVSlJrd1ZZYlg0OVA4?=
 =?utf-8?B?dlRJYURxSldEaFFvMlUwOHZGT0p0elExcmkydS9POFN4dDU0bURIQTFCUmZS?=
 =?utf-8?B?K1hQSmdwUGVDdnhKUUVRc29UZGVCRGIzb2pkeGc0dVBPMkZnKzRoTzltbWZE?=
 =?utf-8?B?WVhqaFJmTHlTdHlhSGthWkxINTdpcUkrZWd6YVk2d1B2UC9keCtYblhmSVBM?=
 =?utf-8?B?MjlpdnFnWWFmVVFOYUJTMkR5TVcwSXZYN1RSenBaeGpIaDlFdVpPMlNta29X?=
 =?utf-8?B?KzZPdlR5QXVITDlKMFRUZE1JbElLNVlXSU5RZUl2dUg5bG5WZTJ6NjJia1lQ?=
 =?utf-8?B?VG45TkxHWFhvK2JJVDdWeDdvZ3kyRUdyZXlXTG1yK2JaRmhHRm5yMjRwbC9y?=
 =?utf-8?B?Z0NoK3JUQTZkY2MzUlFTb3o1QklCVm9vMGtkaDhDa0RQaGIwTERHQTdKN1p6?=
 =?utf-8?B?dXVtbndMenE1QVRCVG5LTEdZMGJPK0RRK3lkRmY1YlVVRTZQWi91ZTZCUE9j?=
 =?utf-8?B?c21nUnZpc3h5SG9YS1RkNkY3aVVsK1Q0OCtnVkdXNGk0RlBTNE1uVUxnYnRx?=
 =?utf-8?B?TDhkbyszeDlWNGVaanNlLzZnTHk1cU56WWVuZHgvcko3eFhHQnYzSHVTNHFv?=
 =?utf-8?B?LzFteEdtT3dlVFI5NXE3dUJZcUM1ZFhqQjVHNmdGd1pkeUxpN093ZWdUbWM0?=
 =?utf-8?B?UWo5bk9IeXhrMklPWFhDYTVSdHdkWm5mSEFMOU1GNVFLV0poT1J6bVU4ak1a?=
 =?utf-8?B?bWtuTFN6VkgwVnZ2SmpVcS9uaWRuNjYwNmQ0Y2hRR1JmeFlGUUhTbURGWnhv?=
 =?utf-8?B?YTNvZ3YranpXdzdUYUdkK1FxMkM0WkYvVlkzdWJSTENzYlNmZ3JwU3Rxc3VX?=
 =?utf-8?B?eXRXL2h4TU85YXB2RkQrY3ZkOTc0SHpGREl0K2Qwc3Boa2tvaFhhRnpXYm1C?=
 =?utf-8?B?QzRpZnN0S3p1MGVhOXZMRDdtaGx2aEFDM1prSjFtSzFpbUZtNklUdnA5dktB?=
 =?utf-8?B?M1RPNEw4ZXllcEdVQzhQNnZ3dlRneWF0eDhYZUluWWtTQlV0QnE1ZW5xNERN?=
 =?utf-8?B?Wi92Q2NsZjRvQ1lKTmpsMGxITWljSHhjQkJsKzJaOHJvRVM3RVB1NUVhZHBM?=
 =?utf-8?B?UFIrVkVIbWlzQUZIZVpnOXFrdEFYOEo2RHdiMW5IMW9UWlBxRUx2WkVTMVYx?=
 =?utf-8?B?c083RXo0UVd5clRjSGRmWXRJdTVqNGdJQWFiVTJUV3A3THZqanVubTRlZ05E?=
 =?utf-8?B?UDhFc0R2NFJYV21IUWVNaGtLcDRNdzRZdHVXN1ZvV3M5MGEveGxXNko0bDZv?=
 =?utf-8?B?WFhWMy94OWRiQzk4Tnp6blZocU9VVnZpU1BoS3VIMjFwbmZqYVlFME1Vb3BD?=
 =?utf-8?B?b1pmVi9mbmJLUzcvSTI1QlA5MW5VSmh6MnRiZ1MwTnFQYVFpQm11TDZvQmt1?=
 =?utf-8?B?eEl3VXFxaktsMnV3cHBzQllzbkdjVGg2MHRLQ1B0ak5uYlZtUnMzMmNwazV1?=
 =?utf-8?B?T1RaR0swdFdOMjB5cG8xWFU1RU5JQVQraDgzOFh6OWdxZU5SUEFJSGFGV0pn?=
 =?utf-8?B?dmNJTmgwbDRSenFlYjV5MU1uS080TW5TVFVQZnpabVlqN0hmMExIZXdsdU5m?=
 =?utf-8?B?Y0ZHMW91b0Z2alU2ZVRjclVKZ21lMGZaT2IwQ3h1L2RURitIa0diZTVUVDNt?=
 =?utf-8?B?enVJQVlyc3hCRGJvU3RPdzl3TTRzVGx4T1dTWENNcHlwSTc3MlVHNFF5ZmYr?=
 =?utf-8?Q?zTUE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662a54ac-3065-4b2c-0e90-08dc8950746d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 13:23:02.3305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5cME6gB/Sk7Hlu2+iQ5oPJkeByh32WIORjd4yZGt+08QAyYV2siZQ4ac4ftcs90rUqfuTxlPaeXn59NTM/8uIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240

PiBJcyB0aGVyZSBhbnkgcGxhbnMgdG8gYWRkcmVzcyB0aGUgdGVzdGluZyBjb25jZXJucyBoZXJl
Pw0KDQpZZXMuIFdlIGFyZSBzdGlsbCBkaXNjdXNzaW5nIGl0IGludGVybmFsbHkuDQoNCg==

