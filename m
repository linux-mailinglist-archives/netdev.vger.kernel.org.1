Return-Path: <netdev+bounces-231049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6139BBF435F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 02:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D053B3669
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 00:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC31C2472BC;
	Tue, 21 Oct 2025 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="7Mo9Mo5q"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023117.outbound.protection.outlook.com [40.93.196.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B7621A436;
	Tue, 21 Oct 2025 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761008062; cv=fail; b=hGbRcBMmFDPqVTiKI+7FBdF5QN4uH25SfMxtJQJpFd8VzXmO84uozTdkTsYx5fHTHBhVt7sQQ+hBMbMXU3aZaA+l5KHj6LeiojFXnb/H1aVUoDwGzvk1Roz86oLl56A50c4mxwHkT5uzjttHncmJbOdMTHe3MhjccfoDBvIsaYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761008062; c=relaxed/simple;
	bh=zwpA8oTxDB84PzZkXAyqivarh4JSNJ5VhKRyqrk0Sow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sFy5y/1q9Hk+OuOhY3G2HC75Csv53GsOPGM0VwxmWVb84nri0lZEUR+g5ouuOhE6I1fNoRpAtuunDNtd08R/hH3TqxerQbFLToM6CY7A8HUFzahlsHvyaQC53kzGzLMBITQK26vALRAB+6tBIxAphaj25Gu+t5Tj/cUeQCaPUGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=7Mo9Mo5q reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.196.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gr6DEMtqI+f0hjo+MbIJ0ocQ/kxlzy9+9nBQUmUitNqOF33uC7m0hxKsNvKCvJXJY0tBEqOmwhBEoa0CmWpu99bdNJYDBsHMuGNInTH0ttYMHaODZ/ugqO2uJwG0XthU9mh9kuPhUhWvxKcpMNVT0YRRavJpHEjeG3i2qxoZyJEEbGuQ8Eodg/Dt0BUIDW5uYz4BFCBUv1fxTFsRaTW3cvejHIkT43MEILbo+eAOSZDPRTxe6YBlMANyHzN4tLI2xA09wiwZq8BQmNvaKBtFuFdcyRH5veBu34i9BrJZh03UqqSRARU82YegWtLhCsd0Yb5JcoMjLD4VfZf3KqA4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/V9Q4y5oCFeXYiy8dMH1co25a3HlS4916XfF1mcPHyo=;
 b=u/qIc+EwfkmDsogxeMGxGqVn45lDsrGNuQrASlIcuY4vuWV/GjFdeSICfzmyasaLwRcJUa+P8McXvx3fki5elo74aBgHLzxBLBA93FzohX99I2wfUWlu4Ov0pcDXndUXtOis8BcQ0izSCc8R9n9+NQgFxAptMsC8VIoJZhdZdGaO04VTN4/A78T94oc+J6HPIKWUydW5VHhRPfLZK/3V1m43XAxgdcKRlIG04m0VGZbzdXIy875mHQ9FlVRWFl+PkerBdK3rq77kOvfsFfTsne5XKhY5BSLX/RrM+hcSK5WizRTKTDQOiWVw3Hxl/7M69A+Z95MhWGBF6YY29/kZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V9Q4y5oCFeXYiy8dMH1co25a3HlS4916XfF1mcPHyo=;
 b=7Mo9Mo5qs+L5uf5rkiaeq97litAZF74+Wf6h5MTLs1yI49Wj0V76hXg7IOxmvbkFJntl4UajRmN3KixeYmmzgrtJj8DA2c9OmmUop6rwFbT6h0F33i/j5qeWgnC/4xS1OOpDnvLhHgkuRRiLGsBMycNWMleo5w81ickkQirYm0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ2PR01MB7956.prod.exchangelabs.com (2603:10b6:a03:4cf::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Tue, 21 Oct 2025 00:54:16 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 00:54:16 +0000
Message-ID: <88c33cde-6572-43d1-9713-bc63d1faaa68@amperemail.onmicrosoft.com>
Date: Mon, 20 Oct 2025 20:54:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v30 3/3] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
 <20251016210225.612639-4-admiyo@os.amperecomputing.com>
 <90fd9080c34ab6fdfae0a450e78b509b5a444aff.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <90fd9080c34ab6fdfae0a450e78b509b5a444aff.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:930:6b::12) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ2PR01MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 622f6bd6-b8c3-4e43-2be5-08de103c5be6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1Nsb2pJcXFra01ENmpDYkpXeS9PZjZIK0hsYnpGTFROakpVMmg3cUh0dTBK?=
 =?utf-8?B?V3VHK3E3WW1DcUdRQWhKRlNsU1R3YnJkOStFZWt3T3RYT3ZvanhRVnFuRVFy?=
 =?utf-8?B?bjl1dVU3VzFwREo3cDE2V05BeEQ2UDNRaUN3a0N0c3dML1lQZTB4MlpHdWJl?=
 =?utf-8?B?b1YxbUgydGtBR1hWZ0tBTHRNZWRHQmo1WDI5TTlSNEVQUmg2SVBHZm45N2Nx?=
 =?utf-8?B?dUdWRjcyL004Qkh0NUhDWlNoZ25wOXJuT0tFdXErYTNwOE5ycmxtRkFlb0RP?=
 =?utf-8?B?cGNBUUowMEZBNkZ1YWJkMSsvSVorUEtVbHIvelExeEZtSXBBMS9FOUM2Ukh6?=
 =?utf-8?B?UEY2TlBDOThqQjZKZ3g0MTdhNDArNHE4ZmlaVTlPY1d5aHFMeWxBVzd0YXNv?=
 =?utf-8?B?Ni80cExiWC9jYk91RDExMlE0YUk4VFc5VWZrb3FiYlJFdnRtaWY4Y3k1RWVG?=
 =?utf-8?B?NnQ4dXhWUFRsazQ5ZUpRckZXdXRoelFZTnRsTkRsbmM4NnRScTUwcmNEQzJP?=
 =?utf-8?B?TFhCYVRLZlBzM1lIN21CME8vZlRtQjBweWxGVDNIVHdYSGZveHJPMFVLL1Jw?=
 =?utf-8?B?Q25wYnVrQnhqZXZGL1hMMEkzQWNjTFRReVJ4MVBOYVk2dEZIVENZckRNS29D?=
 =?utf-8?B?aGU4d1U3UjhFRW92RlcyL2ozcTdtVmFtdVljcUthRWpWT1NkMHpKVzZjVnNs?=
 =?utf-8?B?aGFMWVJOejgxcENmTVplTnoybDFZYzBOelhsOENsQjVaaDJxZXA2WUp0ZTBP?=
 =?utf-8?B?VldPbFJLMjc2SURNVTdhd0tuMlNDaDlRWXp3ckVqRXJyUXJNdytnNHZoM3Fh?=
 =?utf-8?B?Zk45a2tncHRISWFxVExEbm9ORm95UnpNOVovbEhRdzcvbHpBQTFGTjg2UkVy?=
 =?utf-8?B?SEUra3dseWlDUlByTlNTL0QxdGNoK3c5VStvcUNYRkVOeGkrdWxFcVpONE1o?=
 =?utf-8?B?NXk2S3BHdkw5d1dtTlV2elM4UFVrenFPS0pjZGVmYUhlQUJ5dmVvVTV1WWY5?=
 =?utf-8?B?eUE5ZDZuMTFmUWRhREZMVU55UURtbEh6WHBUdW90dWxVajVtQnZhc2xCWm5h?=
 =?utf-8?B?c3FLUHZaV216cDRjcW5aL3N4Vk9YaVJJWUdyK3FvSFM4dnJQaVpzWEJCMDYy?=
 =?utf-8?B?cEl2cVFKdmxnaFhtVDNtYytlYm4rc2ZxUmJLallacklVcVpWRnhPUTZwVDR3?=
 =?utf-8?B?UWdXR0dJT05tZDBqZmdWbFU2ZUNKajNaTC9pcHhEN2JrdThReTZ5c0NpNEha?=
 =?utf-8?B?eHFvUFVERUdINWtWcDVXREh4VTJnTFBScUljclh2TWVjVEM0WE1BNXh5Tkdt?=
 =?utf-8?B?UjE4cW81TTlhYW5jYndBSU9SR3VOWjBpUUZhbWxWTXhlWGt2d2Y0eHRSUHBT?=
 =?utf-8?B?T255M1gyNnB2cnF6bWJaWTNscDcrUEYxRTZJNDc4Mmc3RzJ3VFBlSTgzWkV3?=
 =?utf-8?B?cTIrb0RyaWNRM1F5YmhzMWJiamR2YnFYQURSR0NZdENDQjFHaDFuT1QwRUNw?=
 =?utf-8?B?QWhBNnBrdVorMlpTUTdrSGFlNWNTY1IrdmZ4eXpUd3ZaR2hkcWRwWktUeTVk?=
 =?utf-8?B?SWlUVnQ5bmQvWjNEYkNuRUtwcS90cVk5R094eWlnUEJ0Y2hGcXZSVzNxYUJa?=
 =?utf-8?B?V1pEODVhZld6ZWlXS3Qvb0xDd3ZjMi9PZ1B4ZStVZFRHc1NZcHZmU05vczlR?=
 =?utf-8?B?bkhxTzhlZkpveXNCY2tBeHNUR1VzbEk4MFBZbTNYS1daaGVVakZydDU2bmlj?=
 =?utf-8?B?UjhhYVJYeFRFYk5ZejBwbmlXai82WFc5NTN3OVRIQU95MkFkRDZvbmhKRFly?=
 =?utf-8?B?c1BNNG5QdzZlNVFXYmlad1kwa2RWUU9UTUFxakNQZlFPMGNBNlpqK0RPTXVR?=
 =?utf-8?B?SU1aU2EwTER0d0hLTjliTzFNYlhoejY0bmtIRklEeXF4ZnpkRFNjR0tVRDM3?=
 =?utf-8?B?TGhlN2o4YlQ5T0lXQndWaDErSGV2WVVPWUhIRllqVzlUdEhSOVVNdmJuRjBv?=
 =?utf-8?B?VFRsU3BiczFBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N05zbGdydDNaVDBSL05VQ3ZBWXZoSWVIeTBmaXlyYlN3V1VOOGt1WlAxNzUr?=
 =?utf-8?B?REFKMndmT2krQWZUdlRoakROeHA4cGxwbXhnWXl0eFRaT0tDWUl2dFVIY2Rj?=
 =?utf-8?B?TU4xSFFGUDFPQm54QXNBaXJCRkZNY3hEUW5KbTBYMVhHMGd5Y3NGVVpzMThh?=
 =?utf-8?B?MmlRcElSZnVJMzFxTzQzaDdMdDNoczRxcGYvNmpIaG0zT2h6QXFPL0tHd3U0?=
 =?utf-8?B?eVBFUXRmeHBPTjJWOHJJZER6b1VIcEVaajVISzQrekJNeGRhdS9pUUxWbXpp?=
 =?utf-8?B?VU9EZUZoajg3dExxUDZxRmc3b1daaVdTNWt4MUUwZEI1R1JBMzZSNlRvcGhz?=
 =?utf-8?B?cFNoR0E4K0hXZHl2M0pkcStwdldOVjB0NTBobnRzWWhIVUFZTTE4ajBaQzFs?=
 =?utf-8?B?a2F4Q3ZrVnlTNU1wd01Hald5V2c2THZ5NU5nZDAwK0xsVFNsbFFiM0w2cmto?=
 =?utf-8?B?NWNXODFCaFBkRVdwVy9EakxmZ3FMTVl1dzBoVTdhQXlBNWdEMnlPZWNkSkRv?=
 =?utf-8?B?Mk1uS2krOTBYV211dENydDJheEs5emtwNDkwL3g4VGZ6Q0xtdEw4RGlYRzNL?=
 =?utf-8?B?OUtwQ3NFQ0o5MW9YQ3k2c3BwNm85NUI0L0Z1eGVhOVhueVBBZjNBSGJyMytu?=
 =?utf-8?B?NWk1V25Qc3BHOGJJRG84UEhRMW5tOVlzU2NEMk80U0w4elN3bTlLRXZDTyt6?=
 =?utf-8?B?N2ZWYVRma3kybjBQRW5XUHRleWJaWnIzcmFwK091R2U1NXBwd2NiYWp4ZEpv?=
 =?utf-8?B?bFg0ZkdWWW82MndEYlNRdTA2bXlHenBadjQzY2tkblVoamF2SjNLK0w1VFYy?=
 =?utf-8?B?T3JzNVFKRXVFSHFDOFlzZjJJYTh2T0hhVmdHUk8vdXpsSkZFNEordlViL21m?=
 =?utf-8?B?TDVBcFpTa2x6Si9EMlFSdlZ1bDlvalFpblZwY1pVcDJJZDNGdmlYZmFvUWtr?=
 =?utf-8?B?Yyt5OE9hdGVjOXNwaTdKNmQyUEJ4bWUrNlpGc2VVNTlyTzhzVjdrbk96cXhr?=
 =?utf-8?B?YWFhbWk4ZG1LSWJTMU4wVUQyZmsyYTdXNTBxbms3RmtITUhEaDlNSjJyV2Fl?=
 =?utf-8?B?TDQyMkVsQWdEbk93YW9Pd3hDRkFBb3VmUGRGMGloQTluVFBuQjFJV00xQmdl?=
 =?utf-8?B?OSs1TURoVDcrQ3VVamVHeHRMc1p6OThmeFRJSUNEQXhkMHBQUjdwNmFKTFI4?=
 =?utf-8?B?MFVQS0tGSUFSRjdUWjJndWEwZFEzTUJ4aFlTVE8waDdTRjNEd1QrTjBObGdJ?=
 =?utf-8?B?bnU1cC80cmt2amNCZDZMTWpQdW9Gd3YxRyt1cHlEOVZ2QlJaeStESGhpYzYr?=
 =?utf-8?B?ZDh3U2lmaEFkOGh1TnFpUDJmdVplR1ZzSHJMUXM5YklQZmxGRGZLMTY0MXR1?=
 =?utf-8?B?Rk5SUGc4N1o4N0h3OFZCLytqM2gzeGh4b2l4WkVjbnBQTks1a0JYc0NWeWwx?=
 =?utf-8?B?UnFUK1lVMDJhQktxRC81OHJJZzZtQjIzWXBnM25HTUlZTlQ0NlRvM281S3NZ?=
 =?utf-8?B?a1FmenExdUN2R0pNN0RIQll1dkxHb1J2R2NvZCtYZzgwdGtpamdzSTVnYmw3?=
 =?utf-8?B?TnZ0czl5Nnl3TEIzcStpNFdKak5xK2pUTElya1JLd1FzWjFSL1pwdGZBQytz?=
 =?utf-8?B?UHMwUHRqbVF0Vmc3U1Q4WklQbDB6MERyYlVEMUYveTI0TlpKQVEydHlFcURp?=
 =?utf-8?B?Rzd1Z2FlelZJVnoxOStiakJPbjc1MW11YzlWNllyMkdPUWU1R051V3NxT1ZZ?=
 =?utf-8?B?RkZnbldnVktubDNIcjZHMGRHYjNzVEQ0aGtPRXl0aTlvYUFnekloeWV5TnU1?=
 =?utf-8?B?YTQ5cFA2cTdkM2JuZHBONWJ1MFRsWHZQYjQ3NHExVE13SXFCR1BOUzI3QU5p?=
 =?utf-8?B?a05SZVF0eDZEclhqYm9vQlNxS3BBZ2N3U2U2ay9aSUsxbjRRNlVmYUIzUU41?=
 =?utf-8?B?bTZaMU90SldIcG1uTFFma1dpNnVSd2F0UUdFMHRpdGVzT3IrQXhCKzZGMGFl?=
 =?utf-8?B?ZTk2Z0FYMnNqMU9ZY3FpQUpDWGNoTlgzN1hVWWQ4dmJ6c01GUWFTN0VpOTBL?=
 =?utf-8?B?VWJqeTJCSlhkZ1c3K0lHalZZTG15L0RZN0NHaHFsc2ZEa3pMTVJMTzJ0clVZ?=
 =?utf-8?B?YXNKTk1aTTdhYXBDNEdRNmxPR2lxS2dUWmloTXYyVkpQSG1DNjVLcjNzSnZu?=
 =?utf-8?B?QWJ3dldXbkt0VjNINGQxaVpnQlJrZkltSHRyenZqKzh3akNHMjBoNThpeHIw?=
 =?utf-8?Q?QKM8HKhtat/vs/tVP4ELzMBThheyfmyjtQ6QRDpZyU=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622f6bd6-b8c3-4e43-2be5-08de103c5be6
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 00:54:16.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQF2dYf9V8qkgISdb+SQx8yOjZeasCsazjXofAcjg/s1LhaBMwk/V9qXeS+knNEDDI43mobltNz8yo5YTbq2GdtXWPwgUfJBNf3hZjqus9O4zyHnuLZ/vMHBpbhlgu7n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB7956


On 10/16/25 23:01, Jeremy Kerr wrote:
> Hi Adam,
>
> Looking pretty good, a few things inline:
>
>> diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
>> new file mode 100644
>> index 000000000000..927a525c1121
>> --- /dev/null
>> +++ b/drivers/net/mctp/mctp-pcc.c
>> @@ -0,0 +1,319 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * mctp-pcc.c - Driver for MCTP over PCC.
>> + * Copyright (c) 2024-2025, Ampere Computing LLC
>> + *
>> + */
>> +
>> +/* Implementation of MCTP over PCC DMTF Specification DSP0256
>> + * https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/hrtimer.h>
>> +#include <linux/if_arp.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/module.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/skbuff.h>
>> +#include <linux/string.h>
>> +
>> +#include <acpi/acpi_bus.h>
>> +#include <acpi/acpi_drivers.h>
>> +#include <acpi/acrestyp.h>
>> +#include <acpi/actbl.h>
>> +#include <acpi/pcc.h>
>> +#include <net/mctp.h>
>> +#include <net/mctpdevice.h>
>> +
>> +#define MCTP_SIGNATURE          "MCTP"
>> +#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
>> +#define MCTP_MIN_MTU            68
>> +#define PCC_DWORD_TYPE          0x0c
>> +
>> +struct mctp_pcc_mailbox {
>> +       u32 index;
>> +       struct pcc_mbox_chan *chan;
>> +       struct mbox_client client;
>> +};
>> +
>> +/* The netdev structure. One of these per PCC adapter. */
>> +struct mctp_pcc_ndev {
>> +       struct net_device *ndev;
>> +       struct acpi_device *acpi_device;
>> +       struct mctp_pcc_mailbox inbox;
>> +       struct mctp_pcc_mailbox outbox;
>> +};
>> +
>> +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
>> +{
>> +       struct pcc_extended_header pcc_header;
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +       struct mctp_pcc_mailbox *inbox;
>> +       struct mctp_skb_cb *cb;
>> +       struct sk_buff *skb;
>> +       int size;
>> +
>> +       mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
>> +       inbox = &mctp_pcc_ndev->inbox;
>> +       size = pcc_mbox_query_bytes_available(inbox->chan);
>> +       if (size == 0)
>> +               return;
>> +       skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
>> +       if (!skb) {
>> +               dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
>> +               return;
>> +       }
>> +       skb_put(skb, size);
>> +       skb->protocol = htons(ETH_P_MCTP);
>> +       pcc_mbox_read_from_buffer(inbox->chan, size, skb->data);
>> +       dev_dstats_rx_add(mctp_pcc_ndev->ndev, skb->len);
>> +       skb_reset_mac_header(skb);
>> +       skb_pull(skb, sizeof(pcc_header));
>> +       skb_reset_network_header(skb);
>> +       cb = __mctp_cb(skb);
>> +       cb->halen = 0;
>> +       netif_rx(skb);
>> +}
>> +
>> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
>> +{
>> +       struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
>> +       struct pcc_extended_header *pcc_header;
>> +       int len = skb->len;
>> +       int rc;
>> +
>> +       rc = skb_cow_head(skb, sizeof(*pcc_header));
>> +       if (rc) {
>> +               dev_dstats_tx_dropped(ndev);
>> +               kfree_skb(skb);
>> +               return NETDEV_TX_OK;
>> +       }
>> +
>> +       pcc_header = skb_push(skb, sizeof(*pcc_header));
>> +       pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
>> +       pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
>> +       memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
>> +       pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
>> +       rc = mbox_send_message(mpnd->outbox.chan->mchan, skb);
>> +
>> +       if (rc < 0) {
>> +               netif_stop_queue(ndev);
>> +               return NETDEV_TX_BUSY;
>> +       }
> super minor: the grouping here (and a couple of other places) is a bit
> strange; try and keep the rc handler together with where rc is set, and
> the setup and send distinct. I'd typically do this as:
>
>         pcc_header = skb_push(skb, sizeof(*pcc_header));
>         pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
>         pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
>         memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
>         pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
>
>         rc = mbox_send_message(mpnd->outbox.chan->mchan, skb);
>         if (rc < 0) {
>                 netif_stop_queue(ndev);
>                 return NETDEV_TX_BUSY;
>         }

OK I can see  the rationale.  I do find that easier to read.


>
>> +
>> +       dev_dstats_tx_add(ndev, len);
>> +       return NETDEV_TX_OK;
>> +}
>> +
>> +static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +       struct mctp_pcc_mailbox *outbox;
>> +       struct sk_buff *skb = mssg;
>> +       int len_sent;
>> +
>> +       mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, outbox.client);
>> +       outbox = &mctp_pcc_ndev->outbox;
>> +
>> +       if (!skb)
>> +               return;
>> +
>> +       len_sent = pcc_mbox_write_to_buffer(outbox->chan, skb->len, skb->data);
>> +       if (len_sent == 0)
>> +               pr_info("packet dropped");
> You probably don't want a bare pr_info() in the failure path here;
> either something debug level, or ratelimited.
>
> and probably use a netdev-specific log function (netdev_dbg() perhaps),
> so you get the device information too.
>
> I'm not super clear on this failure mode, do you need to update the
> tx statistics on the drop here? In which case, you may not need the
> _dbg/_info message at all.

Honestly, this is a pretty bad case, unlike, say, a UDP packet drop, 
this implies that something in the system is very much not aligned with 
the users expectations.  I can go with a netdev specific, but I think 
this should be info level at least.


>
>> +}
>> +
>> +static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +       struct mctp_pcc_mailbox *outbox;
>> +       struct sk_buff *skb = mssg;
> Nice, no more list lookups.
Yep.
>
>> +
>> +       mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
>> +       outbox = container_of(c, struct mctp_pcc_mailbox, client);
>> +       if (skb)
>> +               dev_consume_skb_any(skb);
> minor: dev_consume_skb_any() will tolerate a null argument, you can
> leave out the conditional here.
OK
>
>> +       netif_wake_queue(mctp_pcc_ndev->ndev);
>> +}
>> +
>> +static int mctp_pcc_ndo_open(struct net_device *ndev)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
>> +       struct mctp_pcc_mailbox *outbox, *inbox;
>> +
>> +       outbox = &mctp_pcc_ndev->outbox;
>> +       inbox = &mctp_pcc_ndev->inbox;
>> +
>> +       outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
>> +       if (IS_ERR(outbox->chan))
>> +               return PTR_ERR(outbox->chan);
>> +
>> +       inbox->client.rx_callback = mctp_pcc_client_rx_callback;
>> +       inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
>> +       if (IS_ERR(inbox->chan)) {
>> +               pcc_mbox_free_channel(outbox->chan);
>> +               return PTR_ERR(inbox->chan);
>> +       }
>> +       return 0;
>> +}
> Having the channels fully set-up before calling request_channel looks
> much safer now :)

This actually showed that the same problem would have happened in 
setting MTU.  It is why we need and accessor to the shared buffer size.


>
>> +
>> +static int mctp_pcc_ndo_stop(struct net_device *ndev)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
>> +
>> +       pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
>> +       pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
>> +       return 0;
>> +}
>> +
>> +static const struct net_device_ops mctp_pcc_netdev_ops = {
>> +       .ndo_open = mctp_pcc_ndo_open,
>> +       .ndo_stop = mctp_pcc_ndo_stop,
>> +       .ndo_start_xmit = mctp_pcc_tx,
>> +};
>> +
>> +static void mctp_pcc_setup(struct net_device *ndev)
>> +{
>> +       ndev->type = ARPHRD_MCTP;
>> +       ndev->hard_header_len = 0;
> Isn't this sizeof(struct pcc_extended_header) ?
Yes it is.
>
>> +       ndev->tx_queue_len = 0;
>> +       ndev->flags = IFF_NOARP;
>> +       ndev->netdev_ops = &mctp_pcc_netdev_ops;
>> +       ndev->needs_free_netdev = true;
>> +       ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
>> +}
>> +
>> +struct mctp_pcc_lookup_context {
>> +       int index;
>> +       u32 inbox_index;
>> +       u32 outbox_index;
>> +};
>> +
>> +static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
>> +                                      void *context)
>> +{
>> +       struct mctp_pcc_lookup_context *luc = context;
>> +       struct acpi_resource_address32 *addr;
>> +
>> +       if (ares->type != PCC_DWORD_TYPE)
>> +               return AE_OK;
>> +
>> +       addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
>> +       switch (luc->index) {
>> +       case 0:
>> +               luc->outbox_index = addr[0].address.minimum;
>> +               break;
>> +       case 1:
>> +               luc->inbox_index = addr[0].address.minimum;
>> +               break;
>> +       }
>> +       luc->index++;
>> +       return AE_OK;
>> +}
>> +
>> +static void mctp_cleanup_netdev(void *data)
>> +{
>> +       struct net_device *ndev = data;
>> +
>> +       mctp_unregister_netdev(ndev);
>> +}
>> +
>> +static int initialize_MTU(struct net_device *ndev)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
>> +       struct mctp_pcc_mailbox *outbox;
>> +       int mctp_pcc_mtu;
>> +
>> +       outbox = &mctp_pcc_ndev->outbox;
>> +       mctp_pcc_mtu = pcc_mbox_buffer_size(outbox->index);
>> +       if (mctp_pcc_mtu == -1)
>> +               return -1;
> You may want to check that this is at least
> sizeof(struct pcc_extended_header), to avoid an underflow below, and
> possibly at least MCTP_MIN_MTU after subtracting the header size (as
> this would be less than the MCTP BTU)

And if it is?  I think that is a sign of a hardware problem, beyond the 
scope of what we can fix here.  No matter what, the interface will be 
unusable.



>
>> +
>> +       mctp_pcc_mtu = mctp_pcc_mtu - sizeof(struct pcc_extended_header);
>> +       mctp_pcc_ndev = netdev_priv(ndev);
> unneeded?
Yep, and gone....
>
>> +       ndev->mtu = MCTP_MIN_MTU;
>> +       ndev->max_mtu = mctp_pcc_mtu;
>> +       ndev->min_mtu = MCTP_MIN_MTU;
>> +
>> +       return 0;
>> +}
> Now that the initialize_MTU implementation is simpler, you may want to
> reinstate it inline in driver_add(), but also fine as-is.
>
>> +
>> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
>> +{
>> +       struct mctp_pcc_lookup_context context = {0};
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev;
>> +       struct device *dev = &acpi_dev->dev;
>> +       struct net_device *ndev;
>> +       acpi_handle dev_handle;
>> +       acpi_status status;
>> +       char name[32];
>> +       int rc;
>> +
>> +       dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
>> +               acpi_device_hid(acpi_dev));
>> +       dev_handle = acpi_device_handle(acpi_dev);
>> +       status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
>> +                                    &context);
>> +       if (!ACPI_SUCCESS(status)) {
>> +               dev_err(dev, "FAILED to lookup PCC indexes from CRS\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       snprintf(name, sizeof(name), "mctppcc%d", context.inbox_index);
>> +       ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
>> +                           mctp_pcc_setup);
>> +       if (!ndev)
>> +               return -ENOMEM;
>> +
>> +       mctp_pcc_ndev = netdev_priv(ndev);
>> +
>> +       mctp_pcc_ndev->inbox.index = context.inbox_index;
>> +       mctp_pcc_ndev->inbox.client.dev = dev;
>> +       mctp_pcc_ndev->outbox.index = context.outbox_index;
>> +       mctp_pcc_ndev->outbox.client.dev = dev;
>> +
>> +       mctp_pcc_ndev->outbox.client.tx_prepare = mctp_pcc_tx_prepare;
>> +       mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
>> +       mctp_pcc_ndev->acpi_device = acpi_dev;
>> +       mctp_pcc_ndev->ndev = ndev;
>> +       acpi_dev->driver_data = mctp_pcc_ndev;
>> +
>> +       rc = initialize_MTU(ndev);
>> +       if (rc)
>> +               goto free_netdev;
>> +
>> +       rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
>> +       if (rc)
>> +               goto free_netdev;
>> +
>> +       return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
>> +free_netdev:
>> +       free_netdev(ndev);
>> +       return rc;
>> +}
>> +
>> +static const struct acpi_device_id mctp_pcc_device_ids[] = {
>> +       { "DMT0001" },
>> +       {}
>> +};
>> +
>> +static struct acpi_driver mctp_pcc_driver = {
>> +       .name = "mctp_pcc",
>> +       .class = "Unknown",
>> +       .ids = mctp_pcc_device_ids,
>> +       .ops = {
>> +               .add = mctp_pcc_driver_add,
>> +       },
>> +};
>> +
>> +module_acpi_driver(mctp_pcc_driver);
>> +
>> +MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
>> +
>> +MODULE_DESCRIPTION("MCTP PCC ACPI device");
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
> Cheers,
>
>
> Jeremy

