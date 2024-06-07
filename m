Return-Path: <netdev+bounces-101825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 954029003BA
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E47282E65
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EAE1922D2;
	Fri,  7 Jun 2024 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bO5P9QAu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D57961FDD
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763824; cv=fail; b=BTjob/YQ8ehxepVRthiPA9Q1dLhHQUJVhRn843TeZ0YMImVQBBCJj2H8FA2JChtpcltwyAdLgDOm7pt+aQeSKSx7xzRDCizgHU4fHbr7d0hQLaOI8UHWEVNK6BxcdhKVGN0MmuJu5AdFvdVqq27D4zaj0BbdyfDqzm6jFIU5nP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763824; c=relaxed/simple;
	bh=s+3ZUniTmHQMqkqoig+wdLep5e1D4k+9nvqQiJ3OJKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R/v4vmjNSqdaQJ+Iq7oXqzMFgwTZjUh0+rJw/XwpkENPUFw5/EVComAQgVlJcaTEIWDeHeksbXkTZmw/LAxGJB5e/kPYO+yJaWl7fMd1eZq3E19BN2weos/+cm7jDb2W3R/dkJhCpdluYhxtIhF40QuwXP9dR9YsmHfdHqYersk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bO5P9QAu; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alIRy+MhjQbK+7M7ZEiXebZ963Yq+KXorvNBO1zzqrRj3BaV5QncGVejl5NBt1+eA2uq/yu1YW2OVlmz+yvP8GVMOVTZVSvLSsadbxdoRpKjEH2Gzj4lBzXImN8Gj/aVXjU0MeUUzQcs2PP34b81kG0uA0FyLtyLWAAcNNmHiP1Ih+IiUPiHdNbmKYqKmif4KUVEamBMWOLETzi33qECKJO5B3v/zl1UH2R+4/chaJ6bgJN+OVWHanwYIQ6XIkoiZhepD3hwkjIyTuo2wBi0yNuE9NzanEG44LhNNtgCnphrwM0+F4SNQ882RCsx4ZYGZqrRPYrWIr8sLH/QRgrOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+3ZUniTmHQMqkqoig+wdLep5e1D4k+9nvqQiJ3OJKw=;
 b=b1hpS6cFaQmJVKVLEwF0jzNiWXVq2psMmG2cGuuZUlLi5djG+CXn91oLRpYQPo/cS6VT8y1C6/SqIYKPMvvLi7z+ET22iL9SLqUVvoKtq/wc4C2jl9qYbpjckUbY3SVpZ3y126uBkFqXktApUX2c6OIFZDZ4BBTmttzo25ZyyMYDNaEx0m3Y+J3x8YNTOBRFg823q8awhfL5Zq5gpx1k9i7d1potNmasbV8NuzsE3UzrTb3SeCi3f8aKrQTrth8sfYXGzY6HHF730ZEXHr3UQhMhI580J/xmeat372NgarV4wMSGNJMK4gMHzUBCJFOlBbUTZcTbcAD9X76usVQ/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+3ZUniTmHQMqkqoig+wdLep5e1D4k+9nvqQiJ3OJKw=;
 b=bO5P9QAupiNMq7PFtkAXe8XyEx7TPMuemaxG3vJT3l9xEAlYzt01UJ++uIht449V+TemVoiGBHN3i84qn9jdWOzWH4fX9DABfUGvVZ8Bg6QWu7/6dNZ0Spl1MWJvnPiz/X7Qj3/awb0uv1LkgtiM/Dgtme1O1Lp+FOfDAeu20AIaCL9nayIsfAJqN/4Lh9wXUMREgBe75kPmYbOZzxyNw4fd5S7Qk+AihvfG9pHcEB+0ofkc97kBeD/FueTXn3TsiHB7KD0DWyH4JYfrCkNAifnPUZixroZFWTOecxt6B5LOlMxwFry2vmexDP9laEpUeGsLLUZQqxcDAbY4VZ2b2g==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by CY8PR12MB7563.namprd12.prod.outlook.com (2603:10b6:930:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 12:36:59 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4%4]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 12:36:58 +0000
From: Dan Jurgens <danielj@nvidia.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH net-next] virtio_net: Add TX stop and wake counters
Thread-Topic: [PATCH net-next] virtio_net: Add TX stop and wake counters
Thread-Index:
 AQHaU4g6jvRyzH1tPUCIs6q7Q9im2rDycmwAgAAGRTCAAAXXAIAAAcJwgAABlYCAABui0IAAnRGAgAM82ACAACpvgIAAmT0AgAAG2fCAxY2mgIAAN5ew
Date: Fri, 7 Jun 2024 12:36:58 +0000
Message-ID:
 <CH0PR12MB85804D451A889448D3427132C9FB2@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240130142521.18593-1-danielj@nvidia.com>
 <20240130095645-mutt-send-email-mst@kernel.org>
 <CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130104107-mutt-send-email-mst@kernel.org>
 <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130105246-mutt-send-email-mst@kernel.org>
 <CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
 <20240201202106.25d6dc93@kernel.org>
 <CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
 <20240202080126.72598eef@kernel.org>
 <CH0PR12MB858044D0E5AB3AC651AE0987C9422@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoBXB97rCp2ghvVGkZAuC+2a4mnMnjsywRLK+nL0+n+s2A@mail.gmail.com>
In-Reply-To:
 <CAL+tcoBXB97rCp2ghvVGkZAuC+2a4mnMnjsywRLK+nL0+n+s2A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|CY8PR12MB7563:EE_
x-ms-office365-filtering-correlation-id: 16ac6974-8edb-4443-f4c7-08dc86ee85fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnRpOURRdmZPTEkrTUgrWkgyZC9zaE4yZ25VdEVxeHFJd1RpMVVpMzB1V3pa?=
 =?utf-8?B?U210bVY3aWZsZ0w1Nk1qS0ZmWnlOcDFqY0h2bGprVFNjNGVHUldkSWVSWXdn?=
 =?utf-8?B?N1lXRTNYMU9iMWpJS3hMWXMzTnUxTkwzYnB2MnBXY1h0WEMzRmJqSURkT1Ey?=
 =?utf-8?B?bURwZE5XQWNtRGE4RTFxVXc0MFFvKytZdlB6dHliS0taeHJYOVBIbFE0QStx?=
 =?utf-8?B?bHQvMTEzTndUNWhFWEFVTlRDdFhUQ21SMUt2UG5ZZDcvLzBuazRSaUVTRHMx?=
 =?utf-8?B?U21WWW5uRUJ6ZFBXTUtZVFB4KzJaNkRSTXFvUmVtY21BbVJnb1VaNDM2Szdv?=
 =?utf-8?B?eGNvaVRZMkRkc3F2VEY2MU9XNE9yUWkrcU1XVENnUXRCUXpvU3Fac2U3aEZK?=
 =?utf-8?B?bjdyS0pTVGRqUkdOWENST25YYS92V2xPQkpMWlBBSnlvYzlGZTcxQWdwYmRj?=
 =?utf-8?B?em95cXErMmk3cnptWDQ2VGprdE1TSVI0bnNiMSt4ZzBleUZ5QU10d0lycUtC?=
 =?utf-8?B?MzU5T2pOeXVzdWVVSzdTeStQbWF4WVdKeTdZODlmQ1dYOTZ5aXBmN1NlNzFZ?=
 =?utf-8?B?TmtZcE1KbXhYcSswc1VzbTVUTmovMWFKVE5pNVl2QnE4bE9GS284cW8zbUQ4?=
 =?utf-8?B?VVhRSVFFWXdrRkJJWEtIakZUVWE2QUIrZ1FlVkU2Y1RLRnUvRzdsU0t2NnRP?=
 =?utf-8?B?djAzMUJiYnlMOGk4YkwrYmJaVmxQSGVCR0kreEQvWjRDREhhbWViNUxxbFZ2?=
 =?utf-8?B?MXZUWHNBSTdBd3dNZncwaDN3Yk9ZM0VVZjJjZDZFT29UMUNrUTlwTzR6c052?=
 =?utf-8?B?T1F1cnhJdXdCR2R5SVk3SEdpTHR4UU5rU3YreXFYNGhhclhDUTNIemFBSEts?=
 =?utf-8?B?dW1CclVEdzh1TmMyNTArY205d3FIZmM5WTRka0ZjV0MyTE0wMnF0T2xvRlZB?=
 =?utf-8?B?TEovOVhCdUI5aVpuRjhXdlZWZkw3L3p4akJENnFiSTVtaldseC80MGU0dU1j?=
 =?utf-8?B?ZnVkTVNrMVVEdldNbkhFeFdjemZxVUg5MldSMWtrcGxOUFA1Q2NMcHJjWGtZ?=
 =?utf-8?B?WCtXNHRERnBSSUkrU1lDcklxMnA4R25ObUpGSVdNVlU2N1hnTHEzM3hnT0d1?=
 =?utf-8?B?cHhDZGRtSW1nNTgweEZVaWFuKzNvbkp1bTZtZnB0UjN6cVlDWXpXcE9jTVF6?=
 =?utf-8?B?SDdYUVVpVTY3UzZVT1JCb3dvVUZwcFMyQlY1NVBaRlpoVkdPNVFGVDcwOXJB?=
 =?utf-8?B?TTdLWXo3UG1KUnZBSytIb1Y5Rmg2R2VwOU0xTCtWVDhGcm10bjBRc0NyT0VL?=
 =?utf-8?B?MzR3YytUVXRaYnJMaSs5ZkNzaUVNcjBOVmZDZVVZNEFJdVpWZ2xUVHB5c3lu?=
 =?utf-8?B?Z2o3cGNYbVVYSjVaZGw2ZERBaUdBZDNGVHV1dGVWK3VmeVJVQTZyclhtK0py?=
 =?utf-8?B?Z0J0N2x6NWwra3dnaS9oRXBzU1NQcGdyS1VESjhkZitQb1Z2Ry9SZHk5eXlL?=
 =?utf-8?B?cWNhMDFNSGNidGk2MGtNMC9rd0phclV6RFZFK2ZtUDFEK3BPTjVqbmFpWnJ3?=
 =?utf-8?B?eFNPei8wUkxRU01zSDNNTk1uZ1RXRXB2aVphQjN5dWlxck9GY3hTK2twa29Z?=
 =?utf-8?B?ZTVPaVJPa3QvRG1aT3BEeU11WlpzTEF0TWlPVDVYemgwRDFvWVpHcEY2YnhO?=
 =?utf-8?B?Q1pNTkppTTJES0RGMjE0WFRxWEpnQUlscXB0NFgrMlZtZ2V6dUFRdHhpeHJH?=
 =?utf-8?B?RUpyOEZGbC9acmFKSWp4VmFudGM0bWRiTWlGcC83R1hwcE5ORTlMLzkrQ3N0?=
 =?utf-8?Q?Zc9nVyXCKyKMGL9Atk/LoG/0n3r4fEA3TKrRA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmJZQVYvVGhvMXcvZDQyMlVUTGg1Qk1uVnI1U0trTEVCbzBpcW1rNlBya1JL?=
 =?utf-8?B?RXlrZTVZT0Eya1p3bWJIdzhiQkg1bFduNy9VVFZDZmhHRVdyMVVLMkREV3dY?=
 =?utf-8?B?cU9UYXRhZGhwT01zdXQvcHJhWkxXT0s0LytkbFRnclNUQ3J1TVVaQWRiUU8v?=
 =?utf-8?B?TU9DNU8wZGJ5ejdiTHFiRnp0akVueFdwYzZpbmlhSVlhM2srUUJzelIwc0VQ?=
 =?utf-8?B?YXc2WjlkSlpuYW5sd1NFY0VselRCYTVpSkduRW1vTStaZHZ0M0VtUFFQVXhZ?=
 =?utf-8?B?dkl0OTluUzB4cnZ6dmNvckZjQ3pBem5SUTBsOFdmalE3dVB4NVlmN3BNQk1j?=
 =?utf-8?B?dmdkWlc2bEVhdFFuOWYxbzBBY2ptOXF1SUhqSmJ6WmsvdWFQblVxUGx1TWZG?=
 =?utf-8?B?R2hLOE9LR1V5UUozZy9QbjBHaUFFYmZTckw5dTdZM2VmamJ2SU8vU28wZTZl?=
 =?utf-8?B?S0JjaS9zQXQyd1Q1aXd1eG5tY0U2WlFldHB0Y25GOFlwd0lrb3llc0JYanZD?=
 =?utf-8?B?bHl2V2tFTE1ON2c4ZmZIOVUyZFQrZVFsTlppL29TTEpGQzJMWUpEdjBqdFBa?=
 =?utf-8?B?dzdxekxnWjZKSmYyejhRSzl2eHFSWWdHKzlDVjdqK0I2NEhpNkhna2JGb1do?=
 =?utf-8?B?cjd1WmVHK0dlczlUcXpYSTQ2MzBDRUNSL0IxdFlvRDRwYnpHL2lQbytsTXpP?=
 =?utf-8?B?TkZrWjkxaEI4TWpkYkJlN1oyVms4OTRQdlRuUGxITjFXSXFCdDJHdHFlSnEx?=
 =?utf-8?B?aS8wTUd6Y0RTRVRsbTcwZGZ6V25ycDFmU2RkVkRJNUd3d1R2UWVraldwZllD?=
 =?utf-8?B?T2YxNk5TVzFhNjUxZXZBTStnZ0NWdkFPc216NHJsamc2bXF5T29JT2pmNUtD?=
 =?utf-8?B?cnNJVE0xL05FUGc0NUtObHRpV3RsTXlJZytBRk0rT21UMEkzN0gvVDF4MzZ4?=
 =?utf-8?B?WVpCQlRGdktSRysxTXpnQ2l4bk1uS1B2bUVSV3ZyRzZzSnE0WnZWeUtxZ3Mw?=
 =?utf-8?B?VTRVWDA1OXRqOGhMRGl5eFo2SHpQK1I3dm5MUTdqN2RGTFlXYi9RRXpNTE9M?=
 =?utf-8?B?cWthdC9PdDF3YlNRdC9IbHdpWElRbHVCUTVqQXQzTU5jL0VleHBWWVJCc2Fu?=
 =?utf-8?B?SWRXVTlZL3diZzQwWEtmVGpoU1Q4Y2J3bDNUaWNjeElGVklKRkdSVUF2UXRz?=
 =?utf-8?B?YTduczVqYUp3TmFtaWRKVUs2Rzhxc3RMTWt0RExkc1RiUUt4TnNKNnMyOGtN?=
 =?utf-8?B?a1JNaHN3VTJGL3NuRmpuOStJWGlHayt0UnkveFhhNExDWW9LWDRpNUtwQ1dO?=
 =?utf-8?B?Zzh4REpzQnRybmpEZTk2MmQ4Qmorb2drSHZ1M2xqMDFhby9Zd2lXbDhiK1kz?=
 =?utf-8?B?ZVNUZ1JMR1FtSU91YVdObmNXRGF6aVN1SElGVHNHeVg4NlJrbWo4VytyYXZr?=
 =?utf-8?B?T3VHMjl0SFJkaUloNGh1djUwbGVONXJ2ZGFXNUk3WFVXdTBMSDg5dW9GaUpz?=
 =?utf-8?B?YlR2QnZHMnZCTnpEZUZpUXlFRjh3R1BUZmNYdDdIUjJKdVg3UytsM0FJWmw3?=
 =?utf-8?B?ZFo4S2RWZlJURmxKS2hyZERjRUJZc0Q1UDh0ckRoaW5aRFZRenVyUnV3bmF2?=
 =?utf-8?B?TlhPTTZqdU5qcnFpSlNtOVBuQjN5bGYvTE5qVVZ0U3c0TUNsdXphb05sMkh0?=
 =?utf-8?B?emRDeFZxeENZby9Rc2wwbzI5V3hlRWxxOFJkeC9KWWU2ZkJYZU5VSnZKbmpI?=
 =?utf-8?B?RXMvVFZaQlh4MGRMQlVsRExVcnBmbTNIWXVxdC9RblVaUzVSRG1ZSmVsR1Vh?=
 =?utf-8?B?ZVd3S3ZvZ2xmVi93SGZsZWQxYkMwWWRUbUxXRU1haVd1N2hoQzFhSCtoSGxN?=
 =?utf-8?B?dENCb0p5WVE3K25KZktIM3grRHVWVDI1MFB6TlY1Z2VZTlR5bU9Tb1JkbVpl?=
 =?utf-8?B?MzlFOTVPOS9oeExCTHhTVDFpdWlCdjZxd0pLYk9jVHF1Mks1d0hxeHJpM1ZE?=
 =?utf-8?B?Z3dVQzQ1NlJBeHFHb3hrZXdrcGtuNDRJTmwwa2ZCQm1PRTc0OHpGTkVDUU01?=
 =?utf-8?B?d0xjSmMrK0VTa3RrcWtmRjhTcWdtUTRRellRYWphS2dLMjBxb0x4QW1SeHY3?=
 =?utf-8?Q?RX92GvEqXSP781cNxx1DS+Xxy?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ac6974-8edb-4443-f4c7-08dc86ee85fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 12:36:58.7958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2cmOtGVxKasbbLSjw1IGX7vrul3mecdREdvd967FDc8i33tSY2yarHMDbkLQ7kBfCtaAWshMYg3jXIH3qK+qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7563

PiBGcm9tOiBKYXNvbiBYaW5nIDxrZXJuZWxqYXNvbnhpbmdAZ21haWwuY29tPg0KPiBTZW50OiBG
cmlkYXksIEp1bmUgNywgMjAyNCA0OjE2IEFNDQo+IFRvOiBEYW4gSnVyZ2VucyA8ZGFuaWVsakBu
dmlkaWEuY29tPg0KPiBDYzogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IE1pY2hh
ZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Ow0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3Jn
OyBqYXNvd2FuZ0ByZWRoYXQuY29tOw0KPiB4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbTsgdmly
dHVhbGl6YXRpb25AbGlzdHMubGludXguZGV2Ow0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVt
YXpldEBnb29nbGUuY29tOyBhYmVuaUByZWRoYXQuY29tOyBQYXJhdg0KPiBQYW5kaXQgPHBhcmF2
QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHRdIHZpcnRpb19uZXQ6
IEFkZCBUWCBzdG9wIGFuZCB3YWtlIGNvdW50ZXJzDQo+IA0KPiBPbiBTYXQsIEZlYiAzLCAyMDI0
IGF0IDEyOjQ24oCvQU0gRGFuaWVsIEp1cmdlbnMgPGRhbmllbGpAbnZpZGlhLmNvbT4gd3JvdGU6
DQo+ID4NCj4gPiA+IEZyb206IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+DQo+ID4g
PiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDIsIDIwMjQgMTA6MDEgQU0NCj4gPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggbmV0LW5leHRdIHZpcnRpb19uZXQ6IEFkZCBUWCBzdG9wIGFuZCB3YWtlDQo+
ID4gPiBjb3VudGVycw0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgMiBGZWIgMjAyNCAxNDo1Mjo1OSAr
MDgwMCBKYXNvbiBYaW5nIHdyb3RlOg0KPiA+ID4gPiA+IENhbiB5b3Ugc2F5IG1vcmU/IEknbSBj
dXJpb3VzIHdoYXQncyB5b3VyIHVzZSBjYXNlLg0KPiA+ID4gPg0KPiA+ID4gPiBJJ20gbm90IHdv
cmtpbmcgYXQgTnZpZGlhLCBzbyBteSBwb2ludCBvZiB2aWV3IG1heSBkaWZmZXIgZnJvbSB0aGVp
cnMuDQo+ID4gPiA+IEZyb20gd2hhdCBJIGNhbiB0ZWxsIGlzIHRoYXQgdGhvc2UgdHdvIGNvdW50
ZXJzIGhlbHAgbWUgbmFycm93DQo+ID4gPiA+IGRvd24gdGhlIHJhbmdlIGlmIEkgaGF2ZSB0byBk
aWFnbm9zZS9kZWJ1ZyBzb21lIGlzc3Vlcy4NCj4gPiA+DQo+ID4gPiByaWdodCwgaSdtIGFza2lu
ZyB0byBjb2xsZWN0IHVzZWZ1bCBkZWJ1Z2dpbmcgdHJpY2tzLCBub3RoaW5nDQo+ID4gPiBhZ2Fp
bnN0IHRoZSBwYXRjaCBpdHNlbGYgOikNCj4gPiA+DQo+ID4gPiA+IDEpIEkgc29tZXRpbWVzIG5v
dGljZSB0aGF0IGlmIHNvbWUgaXJxIGlzIGhlbGQgdG9vIGxvbmcgKHNheSwgb25lDQo+ID4gPiA+
IHNpbXBsZSBjYXNlOiBvdXRwdXQgb2YgcHJpbnRrIHByaW50ZWQgdG8gdGhlIGNvbnNvbGUpLCB0
aG9zZSB0d28NCj4gPiA+ID4gY291bnRlcnMgY2FuIHJlZmxlY3QgdGhlIGlzc3VlLg0KPiA+ID4g
PiAyKSBTaW1pbGFybHkgaW4gdmlydGlvIG5ldCwgcmVjZW50bHkgSSB0cmFjZWQgc3VjaCBjb3Vu
dGVycyB0aGUNCj4gPiA+ID4gY3VycmVudCBrZXJuZWwgZG9lcyBub3QgaGF2ZSBhbmQgaXQgdHVy
bmVkIG91dCB0aGF0IG9uZSBvZiB0aGUNCj4gPiA+ID4gb3V0cHV0IHF1ZXVlcyBpbiB0aGUgYmFj
a2VuZCBiZWhhdmVzIGJhZGx5Lg0KPiA+ID4gPiAuLi4NCj4gPiA+ID4NCj4gPiA+ID4gU3RvcC93
YWtlIHF1ZXVlIGNvdW50ZXJzIG1heSBub3Qgc2hvdyBkaXJlY3RseSB0aGUgcm9vdCBjYXVzZSBv
Zg0KPiA+ID4gPiB0aGUgaXNzdWUsIGJ1dCBoZWxwIHVzICdndWVzcycgdG8gc29tZSBleHRlbnQu
DQo+ID4gPg0KPiA+ID4gSSdtIHN1cnByaXNlZCB5b3Ugc2F5IHlvdSBjYW4gZGV0ZWN0IHN0YWxs
LXJlbGF0ZWQgaXNzdWVzIHdpdGggdGhpcy4NCj4gPiA+IEkgZ3Vlc3MgdmlydGlvIGRvZXNuJ3Qg
aGF2ZSBCUUwgc3VwcG9ydCwgd2hpY2ggbWFrZXMgaXQgc3BlY2lhbC4NCj4gPiA+IE5vcm1hbCBI
VyBkcml2ZXJzIHdpdGggQlFMIGFsbW9zdCBuZXZlciBzdG9wIHRoZSBxdWV1ZSBieSB0aGVtc2Vs
dmVzLg0KPiA+ID4gSSBtZWFuIC0gaWYgdGhleSBkbywgYW5kIEJRTCBpcyBhY3RpdmUsIHRoZW4g
dGhlIHN5c3RlbSBpcyBwcm9iYWJseQ0KPiA+ID4gbWlzY29uZmlndXJlZCAocXVldWUgaXMgdG9v
IHNob3J0KS4gVGhpcyBpcyB3aGF0IHdlIHVzZSBhdCBNZXRhIHRvDQo+ID4gPiBkZXRlY3Qgc3Rh
bGxzIGluIGRyaXZlcnMgd2l0aCBCUUw6DQo+ID4gPg0KPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjQwMTMxMTAyMTUwLjcyODk2MC0zLWxlaXRhb0BkZWJpYW4ub3INCj4gPiA+
IGcvDQo+ID4gPg0KPiA+ID4gRGFuaWVsLCBJIHRoaW5rIHRoaXMgbWF5IGJlIGEgZ29vZCBlbm91
Z2ggZXhjdXNlIHRvIGFkZCBwZXItcXVldWUNCj4gPiA+IHN0YXRzIHRvIHRoZSBuZXRkZXYgZ2Vu
bCBmYW1pbHksIGlmIHlvdSdyZSB1cCBmb3IgdGhhdC4gTE1LIGlmIHlvdQ0KPiA+ID4gd2FudCBt
b3JlIGluZm8sIG90aGVyd2lzZSBJIGd1ZXNzIGV0aHRvb2wgLVMgaXMgZmluZSBmb3Igbm93Lg0K
PiA+DQo+ID4gRm9yIG5vdywgSSB3b3VsZCBsaWtlIHRvIGdvIHdpdGggZXRodG9vbCAtUy4gQnV0
IEkgY2FuIHRha2Ugb24gdGhlIG5ldGRldg0KPiBsZXZlbCBhcyBhIGJhY2tncm91bmQgdGFzay4g
QXJlIHlvdSBzdWdnZXN0aW5nIGFkZGluZyB0aGVtIHRvDQo+IHJ0bmxfbGlua19zdGF0czY0Pw0K
PiANCj4gSGVsbG8gRGFuaWVsLCBKYWt1YiwNCj4gDQo+IFNvcnJ5IHRvIHJldml2ZSB0aGlzIHRo
cmVhZC4gSSB3b25kZXIgd2h5IG5vdCB1c2UgdGhpcyBwYXRjaCBsaWtlIG1sbnggZHJpdmVyDQo+
IGRvZXMgaW5zdGVhZCBvZiBhZGRpbmcgc3RhdGlzdGljcyBpbnRvIHRoZSB5YW1sIGZpbGU/IEFy
ZSB3ZSBncmFkdWFsbHkgdXNpbmcgb3INCj4gYWRkaW5nIG1vcmUgZmllbGRzIGludG8gdGhlIHlh
bWwgZmlsZSB0byByZXBsYWNlIHRoZSAnZXRodG9vbCAtUycgY29tbWFuZD8NCj4gDQoNCkl0J3Mg
dHJpdmlhbCB0byBoYXZlIHRoZSBzdGF0cyBpbiBldGh0b29sIGFzIHdlbGwuIEJ1dCBJIG5vdGlj
ZWQgdGhlIHN0YXRzIHNlcmllcyBpbnRlbnRpb25hbGx5IHJlbW92ZWQgc29tZSBzdGF0cyBmcm9t
IGV0aHRvb2wuIFNvIEkgZGlkbid0IHB1dCBpdCBib3RoIHBsYWNlcy4NCg0KPiBUaGFua3MsDQo+
IEphc29uDQo=

