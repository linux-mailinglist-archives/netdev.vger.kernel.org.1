Return-Path: <netdev+bounces-106460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5681E91670A
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA2B6B21050
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9467214D45E;
	Tue, 25 Jun 2024 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="vJ5y5Epj";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="if+svA0k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TsAaYBMf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED7D14A092
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317525; cv=fail; b=RnKvF9DoDMzI0jmZzZ6UC5d+S/uCvs7Q3l6dxc6p7Vyn+zO+y50I6rywi9RUwHAiYhKhKFZLRpBuo5mn/8zzKCohcdQjL7BTDLq5adQ+Q3cB1cpaDz9AWpYL8HUAHUu59Oh9xOVuXUGFymV4cPGg+reG3zNGPZPVFbltsxafmgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317525; c=relaxed/simple;
	bh=/Lm40Ge/Pk7S7QpHSF2lVtNy4IzIs9lv0KDCQGtpN3w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NsWCRLCx7oyZOz8LgiJRpNrmxzmayD1lmFFgRUWANDk6ZfQGWY/YaKHGAFn4f/a7nGF14nm/jgSLDf5BwdqMYgmPNiy6cEJW1qvSPpOqdYgfFAD90LtJYXBXY4RxD92YPVxqBszyz9YqoGhWThjeRBS7SDFLShu7smAyTLdLXg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=vJ5y5Epj; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=if+svA0k; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TsAaYBMf reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P85YxG008399;
	Tue, 25 Jun 2024 05:11:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=/Lm40Ge/Pk7S7QpHSF2lVtNy4IzIs9lv0KDCQGtpN3w=; b=vJ5y5Epj1X0x
	lhdBoroKK1X1aXqC2yDjhlAVhQkP9aOljZeCsqTSGorGzNfFtdcKyKOTm4sO//l+
	tfDxNfTmCbGoE9LFWT+kX2OjJVZdM0wnpcHrvc2+E7/FH7Or/xq5OdqKGwmhV2MB
	6U7RcbZYeq9Q9oa/Q96AHzbGQmSSvIJWNK1drvTJe+0qfO04szXUGnMUpZKE7iph
	YZh6PXaBtaNW6aJ1lyqKmFNkMRpds9MQD8sViXSBS9HxwfY3dYcVldFz5EOmaVM8
	VZdpVWi06DtXhar90PW8zdajiOCMhe6SNR8ZlQjaO6XpH3PLqGqdQNqIZIw+1II8
	uSZ4d1Khog==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ywwv4avq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 05:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1719317504; bh=/Lm40Ge/Pk7S7QpHSF2lVtNy4IzIs9lv0KDCQGtpN3w=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=if+svA0kQnIY0mARTSzket/0F79FZgXc5D/UrU9xamvxkXsV/G1pLKKj6FbjyNFdG
	 v3MsFTP+UbKIIpx0lGZFdmRozeBCq+aVpEnwDlRFGmyr6p73vjxeEk2z045Ua7sd8h
	 fHrGJE1qwLwLmcla6elqbkB/d02DaEfRzevAOknQ1UNMKxDzKN5/5hbsgnxbAXcpNA
	 W40xZsljGc4EI/H2zuwKx+Lv2tCXlWrdLXDEsn1n24S3bfFn4VECxgjSZUTEGqnnbo
	 v9Vj8SxmsbjUb9K+PS3JfBk8BBZsRPYeJSvtrCu2dFb89GsY7spAVcadl/6bKtE5Vh
	 zN2v3seIvzpQA==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 95B18400A2;
	Tue, 25 Jun 2024 12:11:44 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 50338A0091;
	Tue, 25 Jun 2024 12:11:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=TsAaYBMf;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8EF9040352;
	Tue, 25 Jun 2024 12:11:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEIiyEg/hDE1nA764PVRsrEUrghfcwMc7O2R8IPUZxOEkxwyxNN0b6Pm5a3DVoavxUGshz+mOPfhv8VfKRtgGjHqhUz3J5I/8cB61JHtKA/BliNV0hjYq/pK8ZyPTXFE45ooCz37u0vbz6pYMVgVhU16c9JlRQ6kBARg48D8fAWHjLEAUhsBLZWHrgydfMHjpxAEftum13Jn44fplS4riPjpjiuuq1di+M3VGuSP+hy6HTw3fQMY0fxuGfEprHx3pZtPYYG8lehwVgGZs6ZEM9JpNmERRLO/eEcVvA+NPA6dgOf9p6M86Mbyieki/m2UcEmtiOl0uj1o87FpAK4W6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Lm40Ge/Pk7S7QpHSF2lVtNy4IzIs9lv0KDCQGtpN3w=;
 b=R/z52KDWQ0JSe63Xiyy2Lbm19DViCNO/Pv+feBzIF5GetNQ/QTAYVMsHPFmwWCh7L9cEZU11jFXW8NVuYd2oG2s+iNj4qkZr7g6oN7jGtGH6xVOEnE+Wv6epLwbwPzLAb73g6RYF9TG2VXpu3n5HdxErpEjImGUQ/MM1Ksp3AcYjFmXNrKHflHqpZ0tZZix7uhS+LHx/XES6/t0abVvwqv+sN6xlNnWy3CteGNDHfxuf5KdOlnKg9WVmcY2+vQC0O9YyZw4KmYTcd+WvX3n5YgGgLO1ti9x9NkLzMa/2rE0QMs7FOVKZlICuagG9hZwLKCNN1JaDdKr2DsrLCGn+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Lm40Ge/Pk7S7QpHSF2lVtNy4IzIs9lv0KDCQGtpN3w=;
 b=TsAaYBMfzzs3h8xzHJ3GwoKvEvVCFehQv1MWrFVXLuyymxTmjpH62FuQ473n0koZ6aGqbV0O/QwAoRESAvwZ/Ph9Ew6FN2P3GXXpO7/fXC4mTEF9T/P3GgXDn87zr3/H6SPkU5cwl1uOMKqXAQPuQ8GCl9bn2yMTji3LNl51JFY=
Received: from DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) by
 CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.29; Tue, 25 Jun 2024 12:11:40 +0000
Received: from DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::f02d:bb07:127e:8849]) by DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::f02d:bb07:127e:8849%7]) with mapi id 15.20.7587.035; Tue, 25 Jun 2024
 12:11:39 +0000
X-SNPS-Relay: synopsys.com
From: Jose Abreu <Jose.Abreu@synopsys.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        netdev <netdev@vger.kernel.org>, Jose Abreu <Jose.Abreu@synopsys.com>
Subject: RE: STMMAC driver CPU stall warning
Thread-Topic: STMMAC driver CPU stall warning
Thread-Index: AQHaxhiNJUV7nkEVGE6MRUK8gdfZU7HYMypQgAAFVYCAACzNUA==
Date: Tue, 25 Jun 2024 12:11:39 +0000
Message-ID: 
 <DM4PR12MB50886C5A72024A6F5D990F86D3D52@DM4PR12MB5088.namprd12.prod.outlook.com>
References: 
 <CA+V-a8s6TmgM4=J-3=zt3ZbNdLtwn5sfBP6FdZVNg09t634P_w@mail.gmail.com>
 <DM4PR12MB5088D67A5362E50C67793FE1D3D52@DM4PR12MB5088.namprd12.prod.outlook.com>
 <CA+V-a8vOJmwbK6Oauv4=2nRXZcOVR2GDH8_FBQQ1dpE8298LKQ@mail.gmail.com>
In-Reply-To: 
 <CA+V-a8vOJmwbK6Oauv4=2nRXZcOVR2GDH8_FBQQ1dpE8298LKQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcam9hYnJldVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLTEyNmM2YWEzLTMyZWMtMTFlZi04NjY4LTNjMjE5Y2RkNzFiNFxhbWUtdGVzdFwxMjZjNmFhNS0zMmVjLTExZWYtODY2OC0zYzIxOWNkZDcxYjRib2R5LnR4dCIgc3o9Ijc2NSIgdD0iMTMzNjM3OTEwOTg0Njk2MDY3IiBoPSJDQ2FwdW9nYTZNdHFNWkw5QU5OVDZzenlvclE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5088:EE_|CYXPR12MB9279:EE_
x-ms-office365-filtering-correlation-id: c086c828-05e2-4876-15f7-08dc950ff810
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dEl2RWRvT0d1ek1CY1lyejBCb21FbjV6K2QwVVhBMHAxcHAwNS9UVTdEQjU3?=
 =?utf-8?B?b1BzSVRUb0Zsak9LcjhzbFg3eGlQbkRqaytDdjlDTXFKWTN6dEpKNE9OREg5?=
 =?utf-8?B?YWNETUxMelhXOXRyZFBISGRUMVNPc291V3hDREFZZG1IdFNlcW5RSEpESUxB?=
 =?utf-8?B?L1g3OUZ6bjYrbDc2NlYrRjhpckhxVUdZbmZxV3BieFdiN0h6VHJydnJpcWZN?=
 =?utf-8?B?aUFqK3NaRjZCVVRvSWlRWld0NUxLcGY1ZzBBOHpRRHhkTk5Xa3hDWjdqYlZC?=
 =?utf-8?B?c1ZPQVRyN1hRN0VsZllBVUdxSFFTckVSMFNwZmtaMmJIT0V6eFhmaThlU2Y5?=
 =?utf-8?B?T3ZXdWxPL2hFWElkaUlLZWxMVWo4T3MrTkxzektOaE5EVkt3YlhSOVpOZHls?=
 =?utf-8?B?bmYyd1I1cUhPbUFZTlZzV2lLMVpRZEdMRkN2QzE0YXN5TXRvU3NPQjM2cW90?=
 =?utf-8?B?aWRLNWk2cUFMR1dpQjZpQlJkZjlRNXorVHMvNVFhL3N3ODBSUGtSUlU2dkdX?=
 =?utf-8?B?NTFBNmJZMFpkdDh5aERQZW53UXVNZTBzcUp1VDdqRW5NZjBkUnppTW1iTHJU?=
 =?utf-8?B?N3BkV29jK1d0RHNLVGo4TmZuRWhITU1EdTkyVEpjUW9CNHRxd05udmZlTnpZ?=
 =?utf-8?B?c3FzaE56Q1BhTHBNdVNjV1NvWi9JWG1KeHJ6VXRSdVRNRzY1MEtmdjhTWGxq?=
 =?utf-8?B?V0MvbzUycmNhaU0yU2hxVU14K04rVW5xNGRweC8zK29LYzF6MXBQeDBkUEQ1?=
 =?utf-8?B?YzMrcm1XTHpXTUF0K3YvNkl5OStoUEtrQytETzFqMnpFUXlrcS8yTWZoUis0?=
 =?utf-8?B?S2F5RHRDbStJajFBUDNkWDVSNVc5c1R5U2I3R1NtUDI0SjlWcWVHTXNzYzVs?=
 =?utf-8?B?Z0I5UStLWG1vQ0dvWWk4Yk1GZC9MVndDNWkwQXVDVHhaVVdNVkV3QndQNmk1?=
 =?utf-8?B?cnlYRzRYeEN5aGRXMmYrUG5LSU96dkNpaTlvU1d6ZTJhTUkvZ0xRVS95MkVB?=
 =?utf-8?B?bk56ZXFleHRHdmlmUE1CSFpkblBrbE1McXdCNldtZUtLcGhYWTlnUnd3U2Uz?=
 =?utf-8?B?bER1cHl5am43Q3c1UmZtZ29qa0pvSGZGOUdmeHN0WlRqb3FJcnkvN1pYK1B1?=
 =?utf-8?B?SDllZ090RGxRd2pjOVVXV2lxbmxyS1VvZUpyYUtwR3NOKzMzWFhWVmVxdi92?=
 =?utf-8?B?VDVaVU0xd3gvdG9zeGJWaU9VeFJ3WlE1Z0RoTHE2WldEblZvYk5JcFZvNmdQ?=
 =?utf-8?B?c2VYWkREaWpMOUJKMXZhaHA4Nk80U2kwTDdyWXF4RlpkUi9NVUhZVG5zY0Ft?=
 =?utf-8?B?M2ZyOFNaSWtZanAyTUpPT2IzTzdLWWx4ZDVEVnhXdzVPc0I0TUk4aitjUWRz?=
 =?utf-8?B?eEZpOVBQbVB4Nk9wRUpRNEFKelIxWTNpNUZpNTltZDlWVTNZZzd3U1NKNGda?=
 =?utf-8?B?dm5YWnNsZXhEbDFKNjBUWVRjYXpnbnl0U2dtUnVGSDBMVS9GUmx5RlU1WXlD?=
 =?utf-8?B?bXp3dW1ZWU02L1laeitNa1FFci9paXlTSVJXVUlocHRRVitKMFhvd0diZmd6?=
 =?utf-8?B?WmlyQmhGa3lOQUluQnpob1Vva2Y1WUNFM0V2a1RZdTlId0J1RmlSWFl2cndV?=
 =?utf-8?B?dzRRM2U2S0RJZlZLSGNtWlR5V0dUMmt2SXh4VkFXZUNJWVFoYzFtU1pTSDFy?=
 =?utf-8?B?U1BMbHBscmFydU1BcFhLNkRsZU9JSmVMVkhmbEZKUFBkcjlxbGxGWUJIbmxX?=
 =?utf-8?B?TzZxa0dhMTJDdXFSOUxMNUxzVTNJZWFubzZlUjZuOTNJM2tEa3JRdmkrK2kv?=
 =?utf-8?Q?dV4PYHYH42ancgCXI+qxcU3uXWX/Esosd1hLw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5088.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?amJJMnFOY3lQZmVPYU5XR2VFaDg4Y3NyZ3YwZlhocFpVN3REcTIxd1lleUNo?=
 =?utf-8?B?ejltcnlkN0U4dDJGSFNSSmxZY3MzRVRwWDd0dGR2RmkxbXd0MWUwNGw2VmF5?=
 =?utf-8?B?TVZjYStNWTBPeXBpT1AyZTYyWlMyRFJWZUVINnA0YTN3RG90QVVZMTZ5L21n?=
 =?utf-8?B?VmNqVml2VHpJb1NsNE5LN0FYanR0SGNoVnRsUFJyWkxkNHM4WDZMN2h6Rmkw?=
 =?utf-8?B?UlBkbFVxdHRRNWp5a1I4OEo1SWJ6NE5KT0xHcVdUenp1SFllQ3NmTUVmanp3?=
 =?utf-8?B?RHRPSXlCVHNYWmpZOXBTd0hRenhMREJoK2lBUGxRNW95cndmQVkxaFdKWDFp?=
 =?utf-8?B?cit2M3NiQVFzb3V6NGcvcGxJUkJCRzFlUVYyRGNFYTJIcTFCUEdZQmNrR05s?=
 =?utf-8?B?SkkwY1UrUFpTcTJTc2pDeVpmUUFmV1dVU1ZVMFFCaHJyTFRFdUF6bysvMWlj?=
 =?utf-8?B?L2dUQWZvZjlMRG1XWDFvK3dzeUNCNmp1K0hJL1pWODZ4S1dZaVlwanA2bmdS?=
 =?utf-8?B?aXcyU1Zpemc5aTVIeW15YlJLV3pTVVUxNHRSZ2c5ajFZTHNEdWI2WHVseXpj?=
 =?utf-8?B?M2dSU2lrdDMrQkNUSm1RcFg3LzVyUWdBcnExWWs3d0xZNEFFTG03aWxYWVBK?=
 =?utf-8?B?U3ozbDNjWTVIbHovaGJmQWtKRlJVNVAwb3NLL2Rzb1VkRlhqSlRWWWFwQ3RF?=
 =?utf-8?B?dUNQQ01xZUZhK3NaU2kvcjBjYkRwWWtuVll4MEVkcUJoQ1I5Q0dDRVJ0clZG?=
 =?utf-8?B?dWVyZFAwQm1nc05wc2JqYThzVklwL1NoS2NDUTVnSkx5TTI0OG9jc3VZZmR5?=
 =?utf-8?B?emZ5TkprcFN3QU1NUDhKbUZ6QVNNaGVmOVJ4WlFtaTJzWDZpMlJFcE81WDZj?=
 =?utf-8?B?R3RUaVl4K3gzSEo0K25iN0FOcW9ya1VNT2VoSGN1QzVDRmo1UzNXTERtLzVN?=
 =?utf-8?B?SlJvbnVzbjR5ZElGY3FWRldnekVaaWVOWE1Wb1QxSVZtb1p4ZTVxRGxLbXFO?=
 =?utf-8?B?MEZid0lSVlcza1RUbnVtbDkrZWRjRTlUdnBHREZScHRvOGxTZCsrRzNBUFpJ?=
 =?utf-8?B?VHF0WnZrak1hY2JyQVdDNFlJMVN6b1FiOUJmZzBUUFY1MVhKbFQxb3dIMXp0?=
 =?utf-8?B?RG1JRis2TkkxdlBOa1BkcVo1VjVIZjVEM1plNlhwcUplQzh4K0JpaThocGRW?=
 =?utf-8?B?V3J0c1VoczNmTkR6M2djTllEcUtER0NmRzRvOURleElWN3JqZ29PWVI2N29q?=
 =?utf-8?B?TVZ1cFNsbXFPamp0ZDk3UzA4T1Voa2pIb2tsNXV2bk5pL1ZxSHdudDdVekNt?=
 =?utf-8?B?TmxhdFM0ZnpMUkxjUlp6Uy80bmtHZzdBOUt0cEZlemxXeCtsMm1xNE04S1o1?=
 =?utf-8?B?UmFwZG1DMFRmVnJMMWhmd3ZUTUJ0T3FkSkhZcmZRZUx0WXRvT1MyQWVDb3dv?=
 =?utf-8?B?RFQzMmVuSWdscmJHaUtQM1pJN3pNSG4xb0FVaXBnd3E4c1VTei9pVVBMcUFM?=
 =?utf-8?B?SUtJK25Ib0tnclB6MHlWTmRkV0MvK01ETFFlN201R01EbW9idElHMGpmenVp?=
 =?utf-8?B?RHFXczhYNm00RGFUMVFIM21VUmYydXZTRzZXdG9YYWZPS2RjeTdlSENCQmtY?=
 =?utf-8?B?aVdwbytmRGxKS2NnYlVOMFpidkEzVjNFU0djOU5sRk5aczB6WXJzYVR1L1Ns?=
 =?utf-8?B?RmZvVjR0cGxuN0twdXNibUtIcmxkUlJDRm5pVFZraEREbTAxWmV1dS9wYU1l?=
 =?utf-8?B?ckZ4dlgxWlFBdWlYMlNsem5kYlRSWWxDNmtYZFc0dCtTZE9RemtiWkx3Q3gx?=
 =?utf-8?B?SUs2L0F0ZWRmSFVFN3RKOHNmemZRSTMxSXdaQWtBb25rM2tCRlR2UTBKSVg5?=
 =?utf-8?B?cDM2NS9xdFhwSHZ0b2hlMWNSQ290cjVqSkQ2QkVLeGlieUNOZjlkS1ArZHFs?=
 =?utf-8?B?eitPS2lxR1R0Mk9GVjFsQnJndDJ4RXBiWXhyYmJ4UVk2VGdkai9QWTAxelo0?=
 =?utf-8?B?UE9rTzQwYmV1OVRGUCtvMlljVmdwOXA1dDNzbjVOWldVK2pCQndOUXVFRjRE?=
 =?utf-8?B?Y3hZaHUzeXRYWGZxZkc1dk85cjIyakZ1N1VocE9Sc2ZEeFZLVy9pbW0yVEgz?=
 =?utf-8?Q?qhA+EaHS964DCkLKiHo6R56ST?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vZbkAak1V0bjK35KAGXdQPLvZ+x256oDTnxgx5rgn6zC/1BKuMbZaXDm9dSqQKC8bGqNDKcGAp26bRLFHEePm3Is66l7buXYj2ZCpN0PgGwvOunoEp8nwUGQZ1wikq8nR/Uk80++fXvF8N0zI25udGBEgfuxHlw4DlhZ+JCdGcaqxGG1k9ZWDpibKSYyDqGH0K2/tSpccPA7w+MHcR+wzGdJyV7rKmGzsQ6O2pko/Yn4zTwc/Wf5K9dWIGpqUvC4nXPw8i0tAs67KolaNbJGxbYjc1E/swK+Ucl9MdWcB+9U3S4WBzlorfSjmQ+LEnheD73i+k9i3GH4SHyOrh5tz23nh7V1BuUOU8Quo5De0QA6LZuUePUSPpUSfBd7r6VuLjJCZDskMgM7AfUlqatG242pXDtE9ehKm303Abiut7JAU1J2vLJzZkhcyZsK2ZhyX9svRsr6USLVaFjBWPGhVi+j9hQBFtZ+sOENbRANYVLbh4fjkYGzi88WafKmS2gfzBmY1TZSKZuLzH//4+ZhpDwuQUpOFKIc10u5lUqsbp2dVHYuYW3HEtZ1APgtrOMhypBezLQStPtnGkMeq/E6krxvIXPKTC4/xQHbVXPZt2EICe/WglejddcjrJwJRqPl/6X1siiQbmrUsa/G0TNWeg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c086c828-05e2-4876-15f7-08dc950ff810
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 12:11:39.8530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /KI+9Dzgcw+zbELQY15HWPmDF17sY+tmB4AcUWkCmnbX8ZLRBHlploNmYsI5h1AM8FY/Y/3ZmxgG3ZfNl7WnQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279
X-Proofpoint-ORIG-GUID: 4KcgbiSxuQnW6um5nJOGW51cNnQiLjnt
X-Proofpoint-GUID: 4KcgbiSxuQnW6um5nJOGW51cNnQiLjnt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=802
 adultscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406250090

RnJvbTogTGFkLCBQcmFiaGFrYXIgPHByYWJoYWthci5jc2VuZ2dAZ21haWwuY29tPg0KRGF0ZTog
VHVlLCBKdW4gMjUsIDIwMjQgYXQgMTA6MzA6NDENCg0KPiAgICAgbXRsX3R4X3NldHVwMDogdHgt
cXVldWVzLWNvbmZpZyB7DQo+ICAgICAgICAgc25wcyx0eC1xdWV1ZXMtdG8tdXNlID0gPDQ+Ow0K
PiAgICAgICAgIHNucHMsdHgtc2NoZWQtc3A7DQo+IA0KPiAgICAgICAgIHF1ZXVlMCB7DQo+ICAg
ICAgICAgICAgIHNucHMsZGNiLWFsZ29yaXRobTsNCj4gICAgICAgICAgICAgc25wcyxwcmlvcml0
eSA9IDwweDE+Ow0KPiAgICAgICAgIH07DQo+IA0KPiAgICAgICAgIHF1ZXVlMSB7DQo+ICAgICAg
ICAgICAgIHNucHMsZGNiLWFsZ29yaXRobTsNCj4gICAgICAgICAgICAgc25wcyxwcmlvcml0eSA9
IDwweDI+Ow0KPiAgICAgICAgIH07DQo+IA0KPiAgICAgICAgIHF1ZXVlMiB7DQo+ICAgICAgICAg
ICAgIHNucHMsZGNiLWFsZ29yaXRobTsNCj4gICAgICAgICAgICAgc25wcyxwcmlvcml0eSA9IDww
eDQ+Ow0KPiAgICAgICAgIH07DQo+IA0KPiAgICAgICAgIHF1ZXVlMyB7DQo+ICAgICAgICAgICAg
IHNucHMsZGNiLWFsZ29yaXRobTsNCj4gICAgICAgICAgICAgc25wcyxwcmlvcml0eSA9IDwweDE+
Ow0KPiAgICAgICAgIH07DQo+ICAgICB9Ow0KDQpDYW4geW91IHRyeSB0aGlzIHF1ZXVlMyB3aXRo
IHByaW9yaXR5IDB4OD8NCg==

