Return-Path: <netdev+bounces-118235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE6950FB8
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 00:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B482827F5
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 22:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442D51AB501;
	Tue, 13 Aug 2024 22:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wmnF8SiS";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MU5OmhXe"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DCD49658;
	Tue, 13 Aug 2024 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587907; cv=fail; b=EamGsE3WukK5SzioEqZ1ZXJqjnHYvXb6dYE8hh9uqsL1NBFnTeSQOlKZpPDqwT/OWvmDe4Dz4WPbuYT2Xp1XClqPhADdl7JQbm7CfzvNZpz4FaGDsOfZcKVciQhq85crsW2rEdtgz16jz+jBuEIrxnP0L0NiEecXD4wjXqrnBMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587907; c=relaxed/simple;
	bh=n3jzvQq5GvyQpYVDwQqhFJqPLV5JsnE3DJ9doaUYGRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BV4uEyJAcsLSiBfdZNU4yFtj71tlzbr65+aqaA9MWSRfN+kR1NjdcekNshbnEIzCFDRmr4OC/GUT0462tPuLlyiY+pGtD7k5oBg4+iGnilVVDFO8Umd8FlwaZadoBS3CiqPDMeRZb7xQKQTfprN99ZlM7Xy2jLuRR27YaOtbyZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wmnF8SiS; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MU5OmhXe; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723587905; x=1755123905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n3jzvQq5GvyQpYVDwQqhFJqPLV5JsnE3DJ9doaUYGRw=;
  b=wmnF8SiS4k/P2PkLoJl8u8NSfayxJTxWS3XqnpQvn/hVfdCZHcQTUm7c
   5MzhO2JVS9Qpr2s3b2zmvJ+I7vApioxv+1LVsky3GgLWnM3ScU0dAyFka
   W6VKSz2jHr2HioOBIQ5JvvnaOOm713+IpXVJeLUu5H+S5zVBHSmURRDiF
   peqUsKQYUoXenMi1axpSmsqJdI90oV3mkZhcs7GMVa/McQYxx/ffUvvfV
   2dCKw3irVlLmQk00nsEyXDxGksbytx+YYYK804kgynX0+Jsb45fpjhBql
   qrd3XZtfDEJhNloYXLnb6dfQ58FGRi8e+a6wLEI4jJ2cswIcDWz+1g+lv
   w==;
X-CSE-ConnectionGUID: zC3x/8P1RQSlUTn/km3DzA==
X-CSE-MsgGUID: 0Uko6FPQSZuy4dbMPu0BOg==
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="33385771"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2024 15:25:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Aug 2024 15:24:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Aug 2024 15:24:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfW+wi7Naxi9v+SGdzw1/Pcdz8A569YMQXGgV8VJoVVQxuaNHuhjQi4GlrDYW/nyc91819zidhw8326wincuQ5UXHMvSmAE2eZT+jqrh+5xkEPv/7+RDV0nan6FQEiyjvCrdDgIJPZEmhYBIUU7Eslz7qbah//ffwik8VORReNr4CtJgMaWv1CHHSiUgo1I9L1oNkLFGFMqg5xXq9SjNpgVUeFJndC0uizoTfjB5WsMGsiP7PQEDGkl0enq1d6lpk3qR0zB3qDyUiQmHMT/0jiIZDRj9ntO0ufQ2m+5EjLbhW1tQOVVWp4fkqhH8Q8TBJFy/ccri++hhPr03zjlFsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8JqWYsC7OlpN9NizGoVyA2V9ZUd3XckOS6YF7LSHQs=;
 b=ZeCY4XsTOCagQOymS8sHyoa8xWwuaC71u08sL+EtW/BCxg48ChXKU53Jszh32tTk/+ucFBfAXAOOisCwwXDtDBNyNvyPSLscWfWeB68vav8gI6uMyTqWZikJhlFcC2zVaN/ls2rWaD+JkfO0Nw8vh7prRZYjbV0FNu3PrGiR88X9lIEPZIFhMro8ERMwfOOycNwGIcdkv5TNqt3h6ieK/DikD6N+lnQ426tubYCzaXk7UFPKIqKw1S98WeCRR/Qzw116t45rZHtpsLpDkKkSLpgJcDZBBm6/aNGWnfVB+5+aZa68XgOal5D3rfJK04fr4PFNIlTwIFkS8eys5B7gXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8JqWYsC7OlpN9NizGoVyA2V9ZUd3XckOS6YF7LSHQs=;
 b=MU5OmhXeIt4htAqnUeaYvOSjjunx2AFkSRR+KyaG7KEwpwv7yyoRxSZi5PDJApEBFLp6zWoPb5kVJfc7qqe3ybN8y4dZCmhnWNzuQpHb9U50CX/JEI7IF9X/zkjQcBovMbxVCfy8R0Ucj7C4nMmWfc4WoMTbZxFrUwKUIBBZjRB5TFtO2PgPaGnC5KuMEqdVKV+7Tk9JYATX+8B1zrmv7kjApw35sDCHZm7b24C4mNHxrua5waxcT6m6q1XSFHJwGuA0Ar0gqu6EG/7nB/Nw5JdlrPQc0fqQ3JHsgoGjV/9AdQAm0qcUhydx3DlGn2tc8P72V9YbSL6WHJUGOiy56A==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by SA1PR11MB6805.namprd11.prod.outlook.com (2603:10b6:806:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Tue, 13 Aug
 2024 22:24:52 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%7]) with mapi id 15.20.7828.023; Tue, 13 Aug 2024
 22:24:52 +0000
From: <Tristram.Ha@microchip.com>
To: <andrew@lunn.ch>
CC: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 3/4] net: dsa: microchip: handle most interrupts
 in KSZ9477/KSZ9893 switch families
Thread-Topic: [PATCH net-next 3/4] net: dsa: microchip: handle most interrupts
 in KSZ9477/KSZ9893 switch families
Thread-Index: AQHa6rVcFRrm35N53kCqztaSs7g9LbIgxFsAgAUE27A=
Date: Tue, 13 Aug 2024 22:24:52 +0000
Message-ID: <BYAPR11MB3558DD354E8162D02E1FCC21EC862@BYAPR11MB3558.namprd11.prod.outlook.com>
References: <20240809233840.59953-1-Tristram.Ha@microchip.com>
 <20240809233840.59953-4-Tristram.Ha@microchip.com>
 <301c5f90-0307-4c23-b867-6677d41dce47@lunn.ch>
In-Reply-To: <301c5f90-0307-4c23-b867-6677d41dce47@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|SA1PR11MB6805:EE_
x-ms-office365-filtering-correlation-id: 1e77b791-c865-4422-f11e-08dcbbe6c06c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?FOCqDNeCBHg0zaPLX04tHhPryjSmH6oWPsgF0uAPEvdIZzfRZzfDKdYnItOu?=
 =?us-ascii?Q?rQVnV3/XrJUdIsuspuAATBncsQfqRvN9n8ggzUtocXCMbAyi+18rgNRvZtaa?=
 =?us-ascii?Q?1EHABD+TigIkEJ+GDc+A5oTOiYciOG8Rxy48ZdgLIBZJ6Q5s9Yq0n5GeFoeC?=
 =?us-ascii?Q?1hWY+9kE3kM7EV50jMYfAeSQCXPqt1uJXLbQq+s6n5lNL2dLotU8u+8O0Z1P?=
 =?us-ascii?Q?u7XP++N4G0SMCWECpjasm9zDc3LbeNdAIZJeRfJu6M30S1q0rY5QhG4O/NO5?=
 =?us-ascii?Q?YaOdTdnKKhNI0JVdQVx45Xa2gK78YuubRYENgx8yTQPqRUPhjdZ27MPyrbNO?=
 =?us-ascii?Q?3xiHoqIdiVGPCwocrhC/8wmdP6AKXz71NHndn1zYObmEMv4oR2OSul14C+KY?=
 =?us-ascii?Q?99KtEUg7TkGbcuEMvELSEBTOy+cA8lpslxH5c3JQkFLlDZHsYvw5yIWdo2/w?=
 =?us-ascii?Q?cTeTSf5e2Yj7SZn/1hHF84C7rfDhaTKrsWO1mKHssiamzOUlKHCRd0s9lPKW?=
 =?us-ascii?Q?8xJMY6at8z0lYSqtdZCsQhQ+2Zf04G4/yS7XaveLxVh2wE6Cwoa6GTsmfLLk?=
 =?us-ascii?Q?Tti1xKABg7R6z8HpBdShjVOp3uCRNPL37Bdc44tvINUTxxlBUOJIikWnTbb8?=
 =?us-ascii?Q?KCCBYt0pgdtcbxHQogmoectrvaHKwbIDXD5kVYyOpvGyLKZharewJzM+kleO?=
 =?us-ascii?Q?eH7BX1p9e/2meSO1O3r4MOyoL9Ewk5ldv6XCv5BLf/uMPyfrZ8y481iW1Nls?=
 =?us-ascii?Q?D5vTaSzjU1JWkH2ieOXwN2FG6ZHgIwFXqzKoflweWoHM+5F1g9ZCDhCfDzxC?=
 =?us-ascii?Q?7dVoVUyTWgUOLKujUc7RZutHDPWkCGXYY29uxSd/k+hLWK3ToQsySYS1AIpJ?=
 =?us-ascii?Q?K0K0mDpyzWG/hf2/9cacex4MavJdy7Xkeu7ItgaFMTxVq1x1Rg46LTTqMzW5?=
 =?us-ascii?Q?3PkCrbNh3PlJIJA9sub3J5LrJkvo0Bkpw7Ab6lSw4hC4zcP8MpL2W+Sbz7KK?=
 =?us-ascii?Q?aAG/El4Dqmrm5WV20ghOuhHLYy4BLkHMYmSZ3BcD4w6VL7xGc0ZaTKdWsKLR?=
 =?us-ascii?Q?CSVulfGwRRlB7vZ9+nVipjBGGON5qi8LoZ+AbNbax2fqKhJmddsBJkQafbkf?=
 =?us-ascii?Q?jOX4XsM82f82so4ydSbzeyPg82qxIVsH4GaNq2VjIjXdZDuGkrxekX2cEkEa?=
 =?us-ascii?Q?B05Wzy6V27gKy8alIJHEUYi2AA4ehSi7nVfHUzcG221b22fkT4rG4bEQ/X4P?=
 =?us-ascii?Q?Plm1YjPEUnf2D0tIQj+23TI//59Qy4UEZLjVZrmRs7EPMPoOKJzaoPvrpgi8?=
 =?us-ascii?Q?KnXmFnyTas/76iNoNgmEwWfbO93rUfBlY+tZSNs4K0b4tJ3TAOFwmuEwhG4H?=
 =?us-ascii?Q?0I4fQD4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aEJtiKybgQYzSXkLsyauAWMLd6Rs26yxSfb8NGKQocFLKbVRJTc+/8nY1wpn?=
 =?us-ascii?Q?YpU4iSvYkCUVstDf275ZfB4TtmPMm1/ECFzK3kr/pfRVGn5cStAHf4GaDq6x?=
 =?us-ascii?Q?DCCX1oh74HZPvRTM5140wxCgyCwxNuzYaaH/Y60VYGjTjlANj74ZhBZ7VAHI?=
 =?us-ascii?Q?zfQTiKYVrKTiOkl0lloeQm+JYtOAkMegBpchn/LLH9C0jd3m54hu01X71/Xc?=
 =?us-ascii?Q?jD9dobUHHduiRSLukWYOj9GTP+tdAh67vM3445dJ4WXWvE49X83J0ALtkcWY?=
 =?us-ascii?Q?v2B3A/UzQ7SY7oK59iwkljEOT7l/j5uI8mwuHQu9V5z89kV2l5PvlSCyug4Z?=
 =?us-ascii?Q?Zra+0ET/cbP76ZJ1UFhhqRwMU90cCyNkbHKIet7xcBwFXquIJ9BOh02q6Bhg?=
 =?us-ascii?Q?M63qfO2aZPq4OMotmRSCBQP7cCriIGiUkPytJdvUDvgVqCHo5mZsbNgS0Fog?=
 =?us-ascii?Q?l7QrFxnjwh21Ozx5mk9F4WArCB8kdAy+EFEqJoozsxK9B7sNBTOykVmBnAsN?=
 =?us-ascii?Q?f4sYMLysBHzQXJd5QuGzRX0ORtS6NUfchMwtW20pioAzg723WLHCxDLocJiP?=
 =?us-ascii?Q?e1hVcks34Y6nSMUn1rg+Ve3+8SsrPrSSvPeOBmX5+G/6r6wRyPWQK/xBFDou?=
 =?us-ascii?Q?k+31BwIP6fbqc8z3u2EKn5+51SKqmu23jghXY28vIZdzhFs750BLlYiG+DmL?=
 =?us-ascii?Q?z6VZ7glI5o5kHUc8vXktRYYTzRkmsZMFQN3NwGR7ALOX4UQmroFD2fladMpQ?=
 =?us-ascii?Q?t5hax4SH7+Vult3ZsxZNMUKUo7/bfYF0fEmTN/sfJmGh4rI0lRBjd091IlSS?=
 =?us-ascii?Q?Czz/VsJb6Wny5xtmjlMG/w0mn/B+IFpCl3yslj499Ddii4aSooQIS1uBXMba?=
 =?us-ascii?Q?SfYOWBZBEkgtDODw9DZWaocrRqlW9hqguQ+D06ECZEf6Edk+WS95pTQG2O9B?=
 =?us-ascii?Q?47TBkkW5qJOKOtROa0BX37bUPBRHHfwh9LKtFvY1vSkaLh3f7OblCzvVj7pf?=
 =?us-ascii?Q?mrGaaljqMOBctq9gASNoZuzJFDDQTB7J4vkVPWKaJP9bxw/zS14FKnpeg4ir?=
 =?us-ascii?Q?8CHNUvleUMbpeGEa4eyR03M6ZceGnx9HUd09RdOHH5q6AG67/DFZm/eY2HBp?=
 =?us-ascii?Q?oSs0icELss++WJxgJsdpvMUogcu2pH1Z8KEJIfdSqKGvw8UlUb+DCbywznMK?=
 =?us-ascii?Q?+tPJS995clbuVcQqueVWO5DgXU+9HxTiL44eXci06599iYkW+erTVsk4wsRD?=
 =?us-ascii?Q?eF7wEoQIr5xu16fwySipjkDhZWP91Tdq/OQSvxRkckr2gL8shCJpyOYi+bvh?=
 =?us-ascii?Q?iZHu5pXdTt6CeSunUoqnmRLT4oHLDqEQvJZ1KaAsSkvs64ulPngWbtvwofcZ?=
 =?us-ascii?Q?g9xX3oUAjflczpJs7FkbxDKxIOY5zJqReCuDQoAlRANmF7UlfNST5U0COl/b?=
 =?us-ascii?Q?u8U9ays7cQOEJ5Mus3bgFwPKxwjAL9FF8vlDOPwCoXZfFeNM0v9d3zw5u2dc?=
 =?us-ascii?Q?af77ZgNAphAQ6DffKZTkbGoxCRTJaggG+y+O4r8E6UQnSk31pwnr1AtVT6mZ?=
 =?us-ascii?Q?WwCjaIdjCeuciBZOAMTKcZE0z2ORDmQHn3fUlcYT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e77b791-c865-4422-f11e-08dcbbe6c06c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 22:24:52.4909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3DxBoPk3FuGePy5puCpZ9nBMZbKEOQmm4dmorBX5TZXO8r+0hcYIc2DZ8iFNidV4sIxSvxk5tsjLLSQjWzYDNQG37S+UiXLOiyDZpojmug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6805

> > +static irqreturn_t ksz9477_handle_port_irq(struct ksz_device *dev, u8 =
port,
> > +                                        u8 *data)
> > +{
> > +     struct dsa_switch *ds =3D dev->ds;
> > +     struct phy_device *phydev;
> > +     int cnt =3D 0;
> > +
> > +     phydev =3D mdiobus_get_phy(ds->user_mii_bus, port);
> > +     if (*data & PORT_PHY_INT) {
> > +             /* Handle the interrupt if there is no PHY device or its
> > +              * interrupt is not registered yet.
> > +              */
> > +             if (!phydev || phydev->interrupts !=3D PHY_INTERRUPT_ENAB=
LED) {
> > +                     u8 phy_status;
> > +
> > +                     ksz_pread8(dev, port, REG_PORT_PHY_INT_STATUS,
> > +                                &phy_status);
> > +                     if (phydev)
> > +                             phy_trigger_machine(phydev);
> > +                     ++cnt;
> > +                     *data &=3D ~PORT_PHY_INT;
> > +             }
> > +     }
>=20
> This looks like a layering violation. Why is this needed? An interrupt
> controller generally has no idea what the individual interrupt is
> about. It just calls into the interrupt core to get the handler
> called, and then clears the interrupt. Why does that not work here?
>=20
> What other DSA drivers do if they need to handle some of the
> interrupts is just request the interrupt like any other driver:
>=20
> https://elixir.bootlin.com/linux/v6.10.3/source/drivers/net/dsa/mv88e6xxx=
/pcs-
> 639x.c#L95

The PHY and ACL interrupt handling can be removed, but the SGMII
interrupt handling cannot as the SGMII port is simulated as having an
internal PHY but the regular PHY interrupt processing will not clear the
interrupt.

Furthermore, there will be a situation where the SGMII interrupt is
triggered before the PHY interrupt handling function is registered.

