Return-Path: <netdev+bounces-207103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7ACB05C8F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37FC56764B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E49C2E3380;
	Tue, 15 Jul 2025 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mVw88Vy3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B7C2E3382
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586092; cv=fail; b=u7F8NoWyhBHfVnvEReZxN1VTN9IxLMFjHywGoHfFJ+DCHTt+N98HiQ1AgzhCfXRrPAaF9d7VSXQCG5xKU8QJ9UPzsASawkIs26ljanFwk7YQcnQm0oc+/Jy/ZypFtYgFvQuKzhmBU+sb+eILymnC4ZdB3s78hBMTLJdcEb6mF6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586092; c=relaxed/simple;
	bh=eCQZ0LDsBSw5o6bm2anMKRDrPLiKk1OT323kyY66x70=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YonOklG0FjAEnlk5AA1U8v7zruO6Calj4C+Lr2lYgJrjbELN7qlw1xpE8tXEfw/hSUSH+e8S2V0QeGVbYeRvLnyazav6AcPqzbKCw2Vg8lsg0WB6BrMskYOASLEhpMCEiCo9LJxx+Ly2EvFgBg1+hdpNPh2+VyIeSnJ5o7XqQ0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mVw88Vy3; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ao0n8RXVE6XL3F0QyHMHV09xpwLu7X9MzSnD2JkkTsCDsXHfTmD8yARZfDu4gKFyim/Len6obHg9wPmDah/EtyRJBgAeIulSENr+5phHhnrlczobf8mz+D6+8AALWY1GwnbTdZOHHw62uCx3AXCucygFfKHYKfOmbCEUJRW3lgQYSQI96uRDAASQw5oxbr9QXIK1449ZZ6r5xKI7GjxqN3UaynjDkEGwMCtRZpFAOaCwd9ju9L9V6l+JGifDfYUQlISNt4jtdyYPO7KpO3BhfshblWQ5NOwNXuTzACF/ubdwug7OZPmuy+io144bV3t+DHkPpGswM26EZI5+LsWLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFzLfm/5E/dI+4Z8tyjwtRrzeH7UR/zDdHY0J/cxZoA=;
 b=HkqFDP7Q1jGlom3EThFQ6PEEiBwwtFA+8QegaP/q02aWlsmNeR1ZtlPwUZZFA1K2ny6f7+yLZigvB3nEhMOIaaY/B3nqlNRUYuAymTw9dkKqLs7Y8G0MA7fouzKTAo40zfwUWiOVWVtWTTeLYP8ffeOUuiJYs7DeDxN6rBTIgcFUGdinScxH8P0VF7gF31xGjnU9YcVNXqsUghPaWgmo6/JNjV9axPmznRXq83B4t/PyhtbEYnMhKNqMKZEH/oR8XMoPRmEoQRfR5z8oMVCYM5WlL2SNTjjfglg133OSPIxGF/EfZtUlU+IYPyJXtJziqqnI40VcqcKQuehUsV+WZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFzLfm/5E/dI+4Z8tyjwtRrzeH7UR/zDdHY0J/cxZoA=;
 b=mVw88Vy3L9ao76lvEDlS3NHhRGURbyJ9hD5BibutVq8CXuusC+sF/QzQpJ0i5c9JHFX0uDxerGKt+psDyRZpHtH1Ob1UJGgWauJ3+e/X5nMuL1Ir8Pvc4yJvAwJYBj0emDA7694ijG6T/aewMnhEWNDp1Quj9dSQZfXZ7wJAaBOx8F3+jOzrMD69261tPwILE/hCcU1AWjQQ2g4Nkx/s6HNW7vgMLNNx6qEuQu7eUQAB2VxcY4ThhfR36tg7K03oJI8h9Nt2DEiukbQ8yEFRyX2A0rYIh+P5cIbwqIFEb4Azpnms7fVZNqTtYeUm6rKzvfjG5qfWNWcmGnvjfNVsLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8657.namprd12.prod.outlook.com (2603:10b6:610:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 13:28:04 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:28:04 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com,
	edumazet@google.com
Subject: [PATCH v30 00/20] nvme-tcp receive offloads
Date: Tue, 15 Jul 2025 13:27:29 +0000
Message-Id: <20250715132750.9619-1-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f06ea9c-7aa8-47bf-1d5e-08ddc3a36d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azJRZ0dYb1dkUkNsblJjVEg4MUFFcGZoV0hWcTB6NjJpY2pmWUtFMDNQVEll?=
 =?utf-8?B?eUdQUk0rellFYjZ1dGZCbCticnl2YVh0Z2NHWnVlWFc1VTVScUo0YllaZWRp?=
 =?utf-8?B?TGRmUGh3ekd6bGdnMkNJNy8wd1hidGM5MVRYZjVxR3kvSDczelFGU2htNlov?=
 =?utf-8?B?c2ZMdG41Ymh3ZDA4Yld0WGg1K0RTd21wamp5Wk12dEh6dlVNMzQ0SjVpSHhJ?=
 =?utf-8?B?bXJ2OW1LMTB0S3NkZVMvVlFqU3NmRG1GZjgwNFJZbzg5ZlJpNlYzVUZDaXM0?=
 =?utf-8?B?cXppaTJ5NkJuZUVDQWg5MnU0NFh2V3BubkdRNldwSnREeDIzNTJQMFNwVUZH?=
 =?utf-8?B?U2lDNlZZK05LN2RSWStWWDhKb1BZQ0ZxenRJMEZEU21CYVVmQVdGbjFWYk9I?=
 =?utf-8?B?Qm1nNVViREpIRDdQZkFnTzMvSWY2NENmc29aNXkwK3oyTjRkZkZYTFdnSDFv?=
 =?utf-8?B?bnRHT2NqSGF2MW9oaVJ2WCsxVjNaNkZnUGtiRTh2UDZORUcxSEt5NUwzZFB2?=
 =?utf-8?B?U1FLKzM3SnZmU2RBeDZ6ZjRVbHJtcW14c1pmYXN2bzE2SEs2ZWoyakhXcjBP?=
 =?utf-8?B?emhpK3BrbjNVZ292d0NDVzNIZG1iWERQeE5vMWNTNXZ6anR0UFhOZnF0QzRZ?=
 =?utf-8?B?TVp5RWc5TlBvY1h3WGZJNmF0ano1bDUydVBIclV6cmNjUk1tTVdLejFEZkRY?=
 =?utf-8?B?a3hXbzhlbHl1M0gyS0lvWm93YzRPUUY1cEtXMlpWUG1kdzVrSFliZzErTTgy?=
 =?utf-8?B?K3VSNmw0MXZmTW1SWXd4a3IzSDVWK3NHZXVrYkk4OUFjRjJtU21YRElPR0Jp?=
 =?utf-8?B?V205SUtsTEVvWmhxZFlwMWNzNy9UQ1dEdXRSME9Wc0ZsbTdqeGhPSWxDMUw5?=
 =?utf-8?B?TzNhYm4zZFhlZDhRQjhnNEJPdjVxOUZqcnZiMStEQktaTGpieDNUMHUzcElz?=
 =?utf-8?B?OGJISDFlTGp1UVh4MFpIQlIxV1NyR082NkQvVE8vSXZOTFpLZ2txY0JmSkVQ?=
 =?utf-8?B?djZrWFJrdlRiemk0bTZPc2tsdWkvbmZJeE5ML1BlR09Jdmd4Tnl0c2htRVRy?=
 =?utf-8?B?UEprV3hOWnBKYzNtWllhMW11VG5ibFQ0QVlyRUxLbVdNKzNWV243QWZxYkVL?=
 =?utf-8?B?ODdmOGtBWlFyUHdHeFJkbWVINEJ2eEwxRGtFSWpkTFlmVndtYzJmTjJYdVZk?=
 =?utf-8?B?WU1CdVJDL0M5aFdnY0Z3cVRyb2dITVFzL2ZJMTk1UGUwaERGZmxmcmRXNGJK?=
 =?utf-8?B?bzRXRjNFaWQ2YzBqN0gyYVRONVN3ZU9PdElCRFIzQjdsajM4NjVsYmwxRktK?=
 =?utf-8?B?a2t4MXVvelBOeXZiSGVjb3lkRnpCdTRkcDYxQ3ZDM05rekx2c2I4ZnBWTlo5?=
 =?utf-8?B?QW4xcCtUbFFsRllBZmI3OEVZQVVCSTFjY1hCa2IyaVNJWnd0Z2RlcmJqWjlM?=
 =?utf-8?B?RC9WcGR0YjlRU2UzdXlndzZxMVJXa1JJRFRmZmxEck5CaXFuNFhzMk1RbExx?=
 =?utf-8?B?anlMSFYvUkxZYWtIVWlQK0FzU3FRcW85WHhGejdPL1ptdW9RNS9TdFRrTjJp?=
 =?utf-8?B?MVRGRzE4VEwxTlRaV2pTVTh0TEZtVktWRk1zdmJKN3h0OUF6OC9HNzMyNVRL?=
 =?utf-8?B?SnVRYW41c3JFaVRJNElKRGNpMlJ5N2lHRjBtbmVTUUZSRkd3QkJ1aDBXVDdh?=
 =?utf-8?B?YmxEMXlKVmNEbUJEdnFKYWY2NHFwNmtSMHEzYUNIOGNpWitUM25YV0dJcU1y?=
 =?utf-8?B?bmNPM1pYZ3h3MEE5L1pEa1poWWt5NnIrQlFZN0hTNHFlU0YvUXUrbTFEaU91?=
 =?utf-8?B?NlY0TzFoSzZseDFCckVYTzJONDNMQkM2K0k3bDB3THBoS2x4L3hTN1RnTllm?=
 =?utf-8?B?Q0xObnVCclFPMkVDMnQ4bFphbHlYNXFFTmdyNHJqY0FxNnQrREorV3A5bisx?=
 =?utf-8?Q?3TwZFw43fco=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmZRQ0Z0cWIwODVhY3lqaFpuR0hqWmZHaHQzTVFNTWtoZXhlbm1TZmM3bTZX?=
 =?utf-8?B?UnUxaUJXRVd3d3cwbXJDMS9LOG5rRXAyWDJKaEtXY1lZRmovYmJ0R2duNnE0?=
 =?utf-8?B?WUlCcXp4eE43QU8vMmhCWXEvNisyU2JmSXNwb3YvZ041SUJBaVVONEZLOVQ1?=
 =?utf-8?B?RXJTSVBON0s2U2pHb0VsZkJGcEV3bkFNMTRucC9ocUNUOEJnQWZHR3Zhdlc5?=
 =?utf-8?B?S2Q3UTVCZ29SeVU5WHVxeG44cllvWUtaZ1ZSeW16MG4wZWw2OHBRdkZyR0tW?=
 =?utf-8?B?WHhRK1YzekxLRGRzVjcyVjRwT2xya3F3N1hOMC8zZ29xNVFUUGErMCtpRGJj?=
 =?utf-8?B?akw1OUFWM3F5MXUwbGp1ZVNLakxRdjUyL0hOOFNDNEJZOUdJNkF4STQ4Ukoy?=
 =?utf-8?B?SU1taFRZencyQ2VWTVVkUWtKbUp4a0dYY1VUbzZ2bXIzUWV3K2g2b2NMK0l2?=
 =?utf-8?B?SEJTR2dnN01zWnNLNzByV3BVdEUxWVZkU25QbFNZdm5DbmxCdjVEaWN4c2c4?=
 =?utf-8?B?TDVMR0pDK1RtcS84emdjQVRjc1FQS2I5SUI2Tlh0Smt2UFhlbzJkb09pbWw1?=
 =?utf-8?B?WjJrcVFLWEtPTTJidFFyclFSZXNvTUhmcStNZ2g0djlpa095VHVtczJEMWhK?=
 =?utf-8?B?b0VoVjZ6aFNoaDg5bDdDQlpVRFFKNkV6Z3Y2WnlPUXpMWW5iVkVWRjJGT2xh?=
 =?utf-8?B?ek80ZDhyNG1KVWprRVZhTmlrb3VyblB6Q0tDN2tMeXpJNHdnTGYrVEVadzNC?=
 =?utf-8?B?UTlSNGhPNVdacmc1b29vYnhrWlliMi9jcEIzZXVGUlRrTHdXcm5qUFpZQXpS?=
 =?utf-8?B?SHpnMVBFQ0tJTUdtZk1MOHBCaHVtdDBORFh6cFNhYm1tYVdHOFNzSm1ybStR?=
 =?utf-8?B?dm5JMVRmdUY5SW5SbURoVExYcFhsTldmd0ZuVzhORnM4T25kaXZlYTBDVXJj?=
 =?utf-8?B?ZDFnQ3pFVTlzSU85UFN5OEY1RVprY0wwTEEwRUNtYzVNdmFuRFIzMWVJQUFE?=
 =?utf-8?B?djhUQUpkVjl0NjBFeEs4Rlpzdi9RSUlwcXNrOWtxYU5CQXJJY2FxcmhyN2xX?=
 =?utf-8?B?bzJPRE9jbXlaQW40akE3d0IweGJibWFpZlIyWm1Qc2tVTjBjdnMyVCtKMFVN?=
 =?utf-8?B?Skk2dXc0NDAzb212K2VaSlhqSllaUVJGb2N4TXUxWGxJYnN5QWFsVjBoa2pz?=
 =?utf-8?B?WkR0Q0I1MWJJc3BEc3NyelNmaHg3QWlFWi9nNVIrQTlFS1hmclBTZjNwZmVC?=
 =?utf-8?B?UUdHajltV0pncTRyVzJwQ0tzSFlieWY0cTlXc1E1OVVKVktYQ3doRDBHWEJL?=
 =?utf-8?B?R2VVWTZqWmhHRTAxWHJ0aUJOQ3BkTm12VUt2QThGc2E4L0tyWXNzWHIwUXVz?=
 =?utf-8?B?cE0zWS9jaE9oZ204Z0x0dXdxMFp1RGdoeHVicXJDeDVOOURTNXNLbmVjYVVN?=
 =?utf-8?B?K2NtaElrSUxHaHlXd1VidjFGdjJCcGFiZjYzcEtiVnhaS3RlNnpiT21xdWF0?=
 =?utf-8?B?UnA2NTM2LzRtUFcwWFBQQVpnZjNsMW9ZNnZxZ20xeHkybzRyVldBWi82Q25K?=
 =?utf-8?B?Z09ZMy9vbjd4eTljYk15dXBiZG4rRzhkSmpncmd1Tm03K09GeUNyeTJCQUQ2?=
 =?utf-8?B?amRTYy9Ob0ZQRWwzdHVJdXVLZWJubHp3VUJuOXdnQjJXWWI5V3plaGpmQnJR?=
 =?utf-8?B?dWs4YkJOditGc0NRYWVycWdhdzhxMnhTNXM3VVFROVpTWWs3VlA3S0hLSnBm?=
 =?utf-8?B?Tkt1eVcrMWZLSmZLaUE1eGlpbkk0a3hZN2NEQVJhWXVPZXJjM3IwNWltYVVq?=
 =?utf-8?B?ZWpJanhiTXoxNjBnRHdhV1hMYUZNSnRCdDR2N0MzSU1wZHl4SVYxSEZpR2Rk?=
 =?utf-8?B?TWxpa0VGYnMycWt0Nlg3T1lYZlA4YzlSUUtPME9uMlh6bmtrY1RObERwUXEx?=
 =?utf-8?B?UzJIbDJqYXVMUWxIZWhWbmgzcHBNclBnYmFzK3B3UW1aZlRYRWNzZ1JPTFM3?=
 =?utf-8?B?ZVVkemZQK0YyY1A1c1lSM2xTYWs3ODNFdExaaXBSL2VFV0R0S3NLaE5kQ0Jq?=
 =?utf-8?B?T2dGRXlhZVZzM1JRbnZWZHZvNk1JRDAySnBuanJPZjZ5ZWhVWE5TQThsSUFs?=
 =?utf-8?Q?cxgOPBiwK9wCLHcCkPhqVcJBz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f06ea9c-7aa8-47bf-1d5e-08ddc3a36d65
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:28:04.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Kq6J3amXLzLnXltZKaDdhGvwHYuvsiUkCm7mAfieWxP7XK4BPyBIb3wklriyJaIDyHg5QfpKnc9I+eEuyTcqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8657

Hi,

The next iteration of our nvme-tcp receive offload series, rebased on top of
today net-next e60c36aa6db1c7e3 ("ipv6: mcast: Avoid a duplicate pointer check in mld_del_delrec()").

If you want, you can follow the KernelCI[0] test executions through the NIPA
contest page[1]. As expected, tests are failing right now as they need
this patchset applied to the netdev-testing hw branch, but they should
pass once the patches make their way in to that branch.

Previous submission (v29):
https://lore.kernel.org/netdev/20250630140737.28662-1-aaptel@nvidia.com/

The changes are also available through git:
Repo: https://github.com/aaptel/linux.git branch nvme-rx-offload-v30
Web: https://github.com/aaptel/linux/tree/nvme-rx-offload-v30

The NVMe-TCP offload was presented in netdev 0x16 (video available):
- https://netdevconf.info/0x16/session.html?NVMeTCP-Offload-%E2%80%93-Implementation-and-Performance-Gains
- https://youtu.be/W74TR-SNgi4

[0] https://kernelci.org/
[1] https://netdev.bots.linux.dev/contest.html?executor=kernelci-lava-collabora (tick the Individual sub-tests box)


From: Aurelien Aptel <aaptel@nvidia.com>
From: Shai Malin <smalin@nvidia.com>
From: Boris Pismenny <borisp@nvidia.com>
From: Or Gerlitz <ogerlitz@nvidia.com>
From: Yoray Zack <yorayz@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>

=========================================

This series adds support for NVMe-TCP receive offloads. The method here
does not mandate the offload of the network stack to the device.
Instead, these work together with TCP to offload:
1. copy from SKB to the block layer buffers.
2. CRC calculation and verification for received PDU.

The series implements these as a generic offload infrastructure for storage
protocols, which calls TCP Direct Data Placement and TCP Offload CRC
respectively. We use this infrastructure to implement NVMe-TCP offload for
copy and CRC.
Future implementations can reuse the same infrastructure for other protocols
such as iSCSI.

Note:
These offloads are similar in nature to the packet-based NIC TLS offloads,
which are already upstream (see net/tls/tls_device.c).
You can read more about TLS offload here:
https://www.kernel.org/doc/html/latest/networking/tls-offload.html

Queue Level
===========
The offload for IO queues is initialized after the handshake of the
NVMe-TCP protocol is finished by calling `nvme_tcp_offload_socket`
with the tcp socket of the nvme_tcp_queue:
This operation sets all relevant hardware contexts in
hardware. If it fails, then the IO queue proceeds as usual with no offload.
If it succeeds then `nvme_tcp_setup_ddp` and `nvme_tcp_teardown_ddp` may be
called to perform copy offload, and crc offload will be used.
This initialization does not change the normal operation of NVMe-TCP in any
way besides adding the option to call the above mentioned NDO operations.

For the admin queue, NVMe-TCP does not initialize the offload.
Instead, NVMe-TCP calls the driver to configure limits for the controller,
such as max_hw_sectors and max_segments, these must be limited to accommodate
potential HW resource limits, and to improve performance.

If some error occurs, and the IO queue must be closed or reconnected, then
offload is teardown and initialized again. Additionally, we handle netdev
down events via the existing error recovery flow.

IO Level
========
The NVMe-TCP layer calls the NIC driver to map block layer buffers to CID
using `nvme_tcp_setup_ddp` before sending the read request. When the response
is received, then the NIC HW will write the PDU payload directly into the
designated buffer, and build an SKB such that it points into the destination
buffer. This SKB represents the entire packet received on the wire, but it
points to the block layer buffers. Once NVMe-TCP attempts to copy data from
this SKB to the block layer buffer it can skip the copy by checking in the
copying function: if (src == dst) -> skip copy

Finally, when the PDU has been processed to completion, the NVMe-TCP layer
releases the NIC HW context by calling `nvme_tcp_teardown_ddp` which
asynchronously unmaps the buffers from NIC HW.

The NIC must release its mapping between command IDs and the target buffers.
This mapping is released when NVMe-TCP calls the NIC
driver (`nvme_tcp_offload_socket`).
As completing IOs is performance critical, we introduce asynchronous
completions for NVMe-TCP, i.e. NVMe-TCP calls the NIC, which will later
call NVMe-TCP to complete the IO (`nvme_tcp_ddp_teardown_done`).

On the IO level, and in order to use the offload only when a clear
performance improvement is expected, the offload is used only for IOs
which are bigger than io_threshold.

SKB
===
The DDP (zero-copy) and CRC offloads require two additional bits in the SKB.
The ddp bit is useful to prevent condensing of SKBs which are targeted
for zero-copy. The crc bit is useful to prevent GRO coalescing SKBs with
different offload values. This bit is similar in concept to the
"decrypted" bit.

After offload is initialized, we use the SKB's crc bit to indicate that:
"there was no problem with the verification of all CRC fields in this packet's
payload". The bit is set to zero if there was an error, or if HW skipped
offload for some reason. If *any* SKB in a PDU has (crc != 1), then the
calling driver must compute the CRC, and check it. We perform this check, and
accompanying software fallback at the end of the processing of a received PDU.

Resynchronization flow
======================
The resynchronization flow is performed to reset the hardware tracking of
NVMe-TCP PDUs within the TCP stream. The flow consists of a request from
the hardware proxied by the driver, regarding a possible location of a
PDU header. Followed by a response from the NVMe-TCP driver.

This flow is rare, and it should happen only after packet loss or
reordering events that involve NVMe-TCP PDU headers.

CID Mapping
===========
ConnectX-7 assumes linear CID (0...N-1 for queue of size N) where the Linux NVMe
driver uses part of the 16 bit CCID for generation counter.
To address that, we use the existing quirk in the NVMe layer when the HW
driver advertises that they don't support the full 16 bit CCID range.

Enablement on ConnectX-7
========================
By default, NVMeTCP offload is disabled in the mlx driver and in the nvme-tcp host.
In order to enable it:

        # Disable CQE compression (specific for ConnectX)
        ethtool --set-priv-flags <device> rx_cqe_compress off

        # Enable the ULP-DDP
        ./tools/net/ynl/pyynl/cli.py \
            --spec Documentation/netlink/specs/ulp_ddp.yaml --do caps-set \
            --json '{"ifindex": <device index>, "wanted": 3, "wanted_mask": 3}'

        # Enable ULP offload in nvme-tcp
        modprobe nvme-tcp ddp_offload=1

Following the device ULP-DDP enablement, all the IO queues/sockets which are
running on the device are offloaded.

Performance
===========
With this implementation, using the ConnectX-7 NIC, we were able to
demonstrate the following CPU utilization improvement:

Without data digest:
For  64K queued read IOs – up to 32% improvement in the BW/IOPS (111 Gbps vs. 84 Gbps).
For 512K queued read IOs – up to 55% improvement in the BW/IOPS (148 Gbps vs. 98 Gbps).

With data digest:
For  64K queued read IOs – up to 107% improvement in the BW/IOPS (111 Gbps vs. 53 Gbps).
For 512K queued read IOs – up to 138% improvement in the BW/IOPS (146 Gbps vs. 61 Gbps).

With small IOs we are not expecting that the offload will show a performance gain.

The test configuration:
- fio command: qd=128, jobs=8.
- Server: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz, 160 cores.

Patches
=======
Patch 1:  Introduce the infrastructure for all ULP DDP and ULP DDP CRC offloads.
Patch 2:  Add netlink family to manage ULP DDP capabilities & stats.
Patch 3:  The iov_iter change to skip copy if (src == dst).
Patch 4:  Export the get_netdev_for_sock function from TLS to generic location.
Patch 5:  NVMe-TCP changes to call NIC driver on queue init/teardown and resync.
Patch 6:  NVMe-TCP changes to call NIC driver on IO operation
          setup/teardown, and support async completions.
Patch 7:  NVMe-TCP changes to support CRC offload on receive
          Also, this patch moves CRC calculation to the end of PDU
          in case offload requires software fallback.
Patch 8:  NVMe-TCP handling of netdev events: stop the offload if netdev is
          going down.
Patch 9:  Documentation of ULP DDP offloads.

The rest of the series is the mlx5 implementation of the offload.

Testing
=======
This series was tested on ConnectX-7 HW using various configurations
of IO sizes, queue depths, MTUs, and with both the SPDK and kernel NVMe-TCP
targets.

Compatibility
=============
* The offload works with bare-metal or SRIOV.
* The HW can support up to 64K connections per device (assuming no
  other HW accelerations are used). In this series, we will introduce
  the support for up to 4k connections, and we have plans to increase it.
* In the current HW implementation, the combination of NVMeTCP offload
  with TLS is not supported. In the future, if it will be implemented,
  the impact on the NVMe/TCP layer will be minimal.
* The NVMeTCP offload ConnectX 7 HW can support tunneling, but we
  don't see the need for this feature yet.
* NVMe poll queues are not in the scope of this series.

Future Work
===========
* NVMeTCP transmit offload.
* NVMeTCP offloads incremental features.

Changes since v29:
=================
- document sk_no_condense field (Simon).
- use - instead of _ in ulp-ddp netlink specs (Simon).

Changes since v28:
=================
- move no_condense bit to sock struct (Eric).
- use new crc api in nvme-tcp.
- add netdev locking in netlink path.

Changes since v27:
=================
- make driver code 80 columns when possible (Jakub).
- rebase on newer mlx5 driver.

Changes since v26:
=================
- remove inlines in C files (Paolo).
- use netdev tracker in netdev ref accounting calls (Paolo).
- add skb_cmp_ulp_crc() helper (Paolo).

Changes since v25:
=================
- continuous integration via NIPA.
- check for tls with nvme_tcp_tls_configured().

Changes since v24:
=================
- ulp_ddp.h: rename cfg->io_cpu to ->affinity_hint (Sagi).
- add compile-time optimization for the iov memcpy skip check (David).
- add rtnl_lock/unlock() around get_netdev_for_sock().
- fix vlan lookup in get_netdev_for_sock().
- fix NULL deref when netdev doesn't have ulp_ddp ops.
- use inline funcs for skb bits to remove ifdef (match tls code).

Changes since v23:
=================
- ulp_ddp.h: remove queue_id (Sagi).
- nvme-tcp: remove nvme_status, always set req->{result,status} (Sagi).
- nvme-tcp: rename label to ddgst_valid (Sagi).
- mlx5: remove newline from error messages (Jakub).

Changes since v22:
=================
- protect ->set_caps() with rtnl_lock().
- refactor of netdev GOING_DOWN event handler (Sagi).
- fix DDGST recalc for IOs under offload threshold.
- rebase against new mlx5 driver changes.

Changes since v21:
=================
- add netdevice_tracker to get_netdev_for_sock() (Jakub).
- remove redundant q->data_digest check (Max).

Changes since v20:
=================
- get caps&limits from nvme and remove query_limits() (Sagi).
- rename queue->ddp_status to queue->nvme_status and move ouf of ifdef (Sagi).
- call setup_ddp() during request setup (Sagi).
- remove null check in ddgst_recalc() (Sagi).
- remove local var in offload_socket() (Sagi).
- remove ifindex and hdr from netlink context data (Jiri).
- clean netlink notify handling and use nla_get_uint() (Jiri).
- normalize doc in ulp_ddp netlink spec (Jiri).

Changes since v19:
=================
- rebase against net-next.
- fix ulp_ddp_is_cap_active() error reported by the kernel test bot.

Changes since v18:
=================
- rebase against net-next.
- integrate with nvme-tcp tls.
- add const in parameter for skb_is_no_condense() and skb_is_ulp_crc().
- update documentation.

Changes since v17:
=================
- move capabilities from netdev to driver and add get_caps() op (Jiri).
- set stats by name explicitly, remove dump ops (Jiri).
- rename struct, functions, YAML attributes, reuse caps enum (Jiri).
- use uint instead of u64 in YAML spec (Jakub).

Changes since v16:
=================
- rebase against net-next
- minor whitespace changes
- updated CC list

Changes since v15:
=================
- add API func to get netdev & limits together (Sagi).
- add nvme_tcp_stop_admin_queue()
- hide config.io_cpu in the interface (Sagi).
- rename skb->ulp_ddp to skb->no_condense (David).

Changes since v14:
=================
- Added dumpit op for ULP_DDP_CMD_{GET,STATS} (Jakub).
- Remove redundant "-ddp-" from stat names.
- Fix checkpatch/sparse warnings.

Changes since v13:
=================
- Replace ethtool interface with a new netlink family (Jakub).
- Simplify and squash mlx5e refactoring changes.

Changes since v12:
=================
- Rebase on top of NVMe-TCP kTLS v10 patches.
- Add ULP DDP wrappers for common code and ref accounting (Sagi).
- Fold modparam and tls patches into control-path patch (Sagi).
- Take one netdev ref for the admin queue (Sagi).
- Simplify start_queue() logic (Sagi).
- Rename
  * modparam ulp_offload modparam -> ddp_offload (Sagi).
  * queue->offload_xxx to queue->ddp_xxx (Sagi).
  * queue->resync_req -> resync_tcp_seq (Sagi).
- Use SECTOR_SHIFT (Sagi).
- Use nvme_cid(rq) (Sagi).
- Use sock->sk->sk_incoming_cpu instead of queue->io_cpu (Sagi).
- Move limits results to ctrl struct.
- Add missing ifdefs.
- Fix docs and reverse xmas tree (Simon).

Changes since v11:
=================
- Rebase on top of NVMe-TCP kTLS offload.
- Add tls support bit in struct ulp_ddp_limits.
- Simplify logic in NVMe-TCP queue init.
- Use new page pool in mlx5 driver.

Changes since v10:
=================
- Pass extack to drivers for better error reporting in the .set_caps
  callback (Jakub).
- netlink: use new callbacks, existing macros, padding, fix size
  add notifications, update specs (Jakub).

Changes since v9:
=================
- Add missing crc checks in tcp_try_coalesce() (Paolo).
- Add missing ifdef guard for socket ops (Paolo).
- Remove verbose netlink format for statistics (Jakub).
- Use regular attributes for statistics (Jakub).
- Expose and document individual stats to uAPI (Jakub).
- Move ethtool ops for caps&stats to netdev_ops->ulp_ddp_ops (Jakub).

Changes since v8:
=================
- Make stats stringset global instead of per-device (Jakub).
- Remove per-queue stats (Jakub).
- Rename ETH_SS_ULP_DDP stringset to ETH_SS_ULP_DDP_CAPS.
- Update & fix kdoc comments.
- Use 80 columns limit for nvme code.

Changes since v7:
=================
- Remove ULP DDP netdev->feature bit (Jakub).
- Expose ULP DDP capabilities to userspace via ethtool netlink messages (Jakub).
- Move ULP DDP stats to dedicated stats group (Jakub).
- Add ethtool_ops operations for setting capabilities and getting stats (Jakub).
- Move ulp_ddp_netdev_ops into net_device_ops (Jakub).
- Use union for protocol-specific struct instances (Jakub).
- Fold netdev_sk_get_lowest_dev() into get_netdev_for_sock (Christoph).
- Rename memcpy skip patch to something more obvious (Christoph).
- Move capabilities from ulp_ddp.h to ulp_ddp_caps.h.
- Add "Compatibility" section on the cover letter (Sagi).

Changes since v6:
=================
- Moved IS_ULP_{DDP,CRC} macros to skb_is_ulp_{ddp,crc} inline functions (Jakub).
- Fix copyright notice (Leon).
- Added missing ifdef to allow build with MLX5_EN_TLS disabled.
- Fix space alignment, indent and long lines (max 99 columns).
- Add missing field documentation in ulp_ddp.h.

Changes since v5:
=================
- Limit the series to RX offloads.
- Added two separated skb indications to avoid wrong flushing of GRO
  when aggerating offloaded packets.
- Use accessor functions for skb->ddp and skb->crc (Eric D) bits.
- Add kernel-doc for get_netdev_for_sock (Christoph).
- Remove ddp_iter* routines and only modify _copy_to_iter (Al Viro, Christoph).
- Remove consume skb (Sagi).
- Add a knob in the ddp limits struct for the HW driver to advertise
  if they need the nvme-tcp driver to apply the generation counter
  quirk. Use this knob for the mlx5 CX7 offload.
- bugfix: use u8 flags instead of bool in mlx5e_nvmeotcp_queue->dgst.
- bugfix: use sg_dma_len(sgl) instead of sgl->length.
- bugfix: remove sgl leak in nvme_tcp_setup_ddp().
- bugfix: remove sgl leak when only using DDGST_RX offload.
- Add error check for dma_map_sg().
- Reduce #ifdef by using dummy macros/functions.
- Remove redundant netdev null check in nvme_tcp_pdu_last_send().
- Rename ULP_DDP_RESYNC_{REQ -> PENDING}.
- Add per-ulp limits struct (Sagi).
- Add ULP DDP capabilities querying (Sagi).
- Simplify RX DDGST logic (Sagi).
- Document resync flow better.
- Add ulp_offload param to nvme-tcp module to enable ULP offload (Sagi).
- Add a revert commit to reintroduce nvme_tcp_queue->queue_size.

Changes since v4:
=================
- Add transmit offload patches.
- Use one feature bit for both receive and transmit offload.

Changes since v3:
=================
- Use DDP_TCP ifdefs in iov_iter and skb iterators to minimize impact
  when compiled out (Christoph).
- Simplify netdev references and reduce the use of
  get_netdev_for_sock (Sagi).
- Avoid "static" in it's own line, move it one line down (Christoph)
- Pass (queue, skb, *offset) and retrieve the pdu_seq in
  nvme_tcp_resync_response (Sagi).
- Add missing assignment of offloading_netdev to null in offload_limits
  error case (Sagi).
- Set req->offloaded = false once -- the lifetime rules are:
  set to false on cmd_setup / set to true when ddp setup succeeds (Sagi).
- Replace pr_info_ratelimited with dev_info_ratelimited (Sagi).
- Add nvme_tcp_complete_request and invoke it from two similar call
  sites (Sagi).
- Introduce nvme_tcp_req_map_sg earlier in the series (Sagi).
- Add nvme_tcp_consume_skb and put into it a hunk from
  nvme_tcp_recv_data to handle copy with and without offload.

Changes since v2:
=================
- Use skb->ddp_crc for copy offload to avoid skb_condense.
- Default mellanox driver support to no (experimental feature).
- In iov_iter use non-ddp functions for kvec and iovec.
- Remove typecasting in NVMe-TCP.

Changes since v1:
=================
- Rework iov_iter copy skip if src==dst to be less intrusive (David Ahern).
- Add tcp-ddp documentation (David Ahern).
- Refactor mellanox driver patches into more patches (Saeed Mahameed).
- Avoid pointer casting (David Ahern).
- Rename NVMe-TCP offload flags (Shai Malin).
- Update cover-letter according to the above.

Changes since RFC v1:
=====================
- Split mlx5 driver patches to several commits.
- Fix NVMe-TCP handling of recovery flows. In particular, move queue offload.
  init/teardown to the start/stop functions.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>


Aurelien Aptel (3):
  netlink: add new family to manage ULP_DDP enablement and stats
  net/tls,core: export get_netdev_for_sock
  net/mlx5e: NVMEoTCP, statistics

Ben Ben-Ishay (8):
  iov_iter: skip copy if src == dst for direct data placement
  net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
  net/mlx5e: NVMEoTCP, offload initialization
  net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
  net/mlx5e: NVMEoTCP, queue init/teardown
  net/mlx5e: NVMEoTCP, ddp setup and resync
  net/mlx5e: NVMEoTCP, async ddp invalidation
  net/mlx5e: NVMEoTCP, data-path for DDP+DDGST offload

Boris Pismenny (4):
  net: Introduce direct data placement tcp offload
  nvme-tcp: Add DDP offload control path
  nvme-tcp: Add DDP data-path
  net/mlx5e: TCP flow steering for nvme-tcp acceleration

Or Gerlitz (3):
  nvme-tcp: Deal with netdevice DOWN events
  net/mlx5e: Rename from tls to transport static params
  net/mlx5e: Refactor ico sq polling to get budget

Yoray Zack (2):
  nvme-tcp: RX DDGST offload
  Documentation: add ULP DDP offload documentation

 Documentation/netlink/specs/ulp_ddp.yaml      |  172 +++
 Documentation/networking/index.rst            |    1 +
 Documentation/networking/ulp-ddp-offload.rst  |  372 +++++
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |   11 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   30 +
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |    4 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   |   13 +-
 .../ethernet/mellanox/mlx5/core/en/params.h   |    3 +
 .../mellanox/mlx5/core/en/reporter_rx.c       |    4 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |   30 +
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |    5 +
 .../net/ethernet/mellanox/mlx5/core/en/tir.c  |   16 +
 .../net/ethernet/mellanox/mlx5/core/en/tir.h  |    3 +
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   34 +-
 .../mlx5/core/en_accel/common_utils.h         |   34 +
 .../mellanox/mlx5/core/en_accel/en_accel.h    |    3 +
 .../mellanox/mlx5/core/en_accel/fs_tcp.c      |   12 +-
 .../mellanox/mlx5/core/en_accel/fs_tcp.h      |    2 +-
 .../mellanox/mlx5/core/en_accel/ktls.c        |    3 +-
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |    6 +-
 .../mellanox/mlx5/core/en_accel/ktls_tx.c     |    9 +-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   |   41 +-
 .../mellanox/mlx5/core/en_accel/ktls_utils.h  |   17 +-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 1191 +++++++++++++++++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    |  147 ++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        |  366 +++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.h        |   39 +
 .../mlx5/core/en_accel/nvmeotcp_stats.c       |   69 +
 .../mlx5/core/en_accel/nvmeotcp_utils.h       |   68 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |    6 +
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |    4 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   30 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   73 +-
 .../ethernet/mellanox/mlx5/core/en_stats.h    |    9 +
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |    6 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |    1 +
 drivers/nvme/host/tcp.c                       |  560 +++++++-
 include/linux/mlx5/device.h                   |   59 +-
 include/linux/mlx5/mlx5_ifc.h                 |   85 +-
 include/linux/mlx5/qp.h                       |    1 +
 include/linux/netdevice.h                     |   10 +-
 include/linux/skbuff.h                        |   31 +
 include/net/inet_connection_sock.h            |    6 +
 include/net/sock.h                            |    5 +-
 include/net/tcp.h                             |    3 +-
 include/net/ulp_ddp.h                         |  327 +++++
 include/uapi/linux/ulp_ddp.h                  |   61 +
 lib/iov_iter.c                                |    9 +-
 net/Kconfig                                   |   20 +
 net/core/Makefile                             |    1 +
 net/core/dev.c                                |   32 +-
 net/core/skbuff.c                             |    4 +-
 net/core/ulp_ddp.c                            |   56 +
 net/core/ulp_ddp_gen_nl.c                     |   75 ++
 net/core/ulp_ddp_gen_nl.h                     |   30 +
 net/core/ulp_ddp_nl.c                         |  348 +++++
 net/ipv4/tcp_input.c                          |    1 +
 net/ipv4/tcp_offload.c                        |    1 +
 net/tls/tls_device.c                          |   31 +-
 61 files changed, 4431 insertions(+), 166 deletions(-)
 create mode 100644 Documentation/netlink/specs/ulp_ddp.yaml
 create mode 100644 Documentation/networking/ulp-ddp-offload.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
 create mode 100644 include/net/ulp_ddp.h
 create mode 100644 include/uapi/linux/ulp_ddp.h
 create mode 100644 net/core/ulp_ddp.c
 create mode 100644 net/core/ulp_ddp_gen_nl.c
 create mode 100644 net/core/ulp_ddp_gen_nl.h
 create mode 100644 net/core/ulp_ddp_nl.c

-- 
2.34.1


