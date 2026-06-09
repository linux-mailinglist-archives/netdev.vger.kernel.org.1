Return-Path: <netdev+bounces-297229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ynTuA71cKGr+CgMAu9opvQ
	(envelope-from <netdev+bounces-297229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:34:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 248436635B2
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:34:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=Cs79CGYX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297229-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297229-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C719F3004D88
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 18:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11E848B367;
	Tue,  9 Jun 2026 18:25:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322FC3F1AA6;
	Tue,  9 Jun 2026 18:25:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029557; cv=fail; b=SQCczmJiR8LukZJRhoa9/I70TWFgL9+TT5N38psMEJp3Sq+Ks2aY6seHSZgyZZxFd5IyDqLUyBDkISVfdwJKRBbebRxxBuAoQN0VH+E3WbXEd+iO5i3vmvyOqlcVjKjmtm2mPZ1ZHMgr3kU5CZykEZyFSbPMikJft2yaEBjaRCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029557; c=relaxed/simple;
	bh=q0uzkrpdVBtgYG6wXsIGTl+7XBqR1zT2zGQlXefLmFY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MRkSDT+mnquZJ+ZRroJZskNN+eo+X0tX0utaZiiS5P7xyphHQ5HnOP/dEyB4QW/yhOnM2DUQJ+HrJh8duclRnCo9oQfnqG7WMfvH8P5Wm2T3fz87YEKancea5dG0XPHGFOMToJZC++uUj1OGXpyBxoSDxxvnqritKp4JbQgySCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=Cs79CGYX; arc=fail smtp.client-ip=173.37.142.90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2587; q=dns/txt;
  s=iport01; t=1781029555; x=1782239155;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uXP+DPaB7bJjHSMtLY+4WdBd1a65JDXp1xyjq58DMaE=;
  b=Cs79CGYXUtk+U9RZj2O61FR+b+iPXRLvdJrjgTEp53Gp4pfcG4JwEhw7
   R4B1DpPdMt9rt1bT/8FV9Rx+7ExnIigNMJLzOUkEM/zsOrMDcbks2zKpT
   Or2Jkdce7ZI4Tfw5WcZoOOK/R3SZ0X6NJWLyXOGqN4hi3MXIRP0XjKmu4
   HFQIECPmwUCz+fDwXxLCFpg7PpKWWZTHM4XBG47WZ+AO1wqy9fAHuh1kG
   YLcT/Ryvc1/sfrnMua6uIhVm3U+D5RkY//X/tt94IYvfgnJwSPyyxY1dH
   QBtZJQolHyyUzXpP7Ww4RKaEuYUIMIOWpcHN6Z7cpkrR5HEnURcvtLo4x
   A==;
X-CSE-ConnectionGUID: Oni5G+XjSBazbR8RkEBLXg==
X-CSE-MsgGUID: P4DDJpncQxCaO0J3GS491g==
X-IPAS-Result: =?us-ascii?q?A0AEAAABWShq/4wQJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBZYEGEAYFAQEBAQsBgWlTgitJhFeDTQEBhE1fhliCIQOeG4F+D?=
 =?us-ascii?q?wEBAQ4BUQQBAYUGAo06AiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFAQEBA?=
 =?us-ascii?q?gEHBYEOE4ZchlsBAQEDEhEECwEFQRALGAICJgICMSUGEwIBAR6CYIJ0AwECq?=
 =?us-ascii?q?w8BgT0Ciip6fzOBAbgkgXIUAYEKLgGFcIJpAYV2hHwnG4FJRIE8gks4PoQKh?=
 =?us-ascii?q?BSCagSDLpBtUngcA1ksAVUTFwsHBYEjQwOBBiNLBS0dgSMhHRcWHlgbBwUSI?=
 =?us-ascii?q?CpuRiMDAgghJBFZQjgLRgWBXQKCGk4jHwM5gRWBfIEoZ2kVMTVZAgELbT03C?=
 =?us-ascii?q?QsbBD2NMhcPgUhxWSsLgmgLHpNAgmmPE6EOhCaBZp96Bg8EL6prLJhapCGEd?=
 =?us-ascii?q?AIEAgQFAhABAQaBaDyBWTMaCBsVgyJTGQ+OLRYcygRZPwcCBw8CkXOBfQEB?=
IronPort-PHdr: A9a23:XoumYRwq+T2nW2zXCzPsngc9DxPP8539OgoTr50/hK0LKeKo/o/pO
 wrU4vA+xFPKXICO8/tfkKKWqKHvX2Uc/IyM+G4Pap1CVhIJyI0WkgUsDdTDCBjTJ//xZCt8F
 8NHPGI=
IronPort-Data: A9a23:WM/om6laW88cOG4G0AE8oRvo5gztJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIXD2nSMv+OZ2L8eNBzaY6+/E5VupPVn4drGgE/pClhE1tH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4Errav688CQUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+ZG31GONgWYubDpKs/Pb8XuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05Faoe+7tYQlFMz
 tYROjo3PiqAqsiS8L3uH4GAhux7RCXqFIobvnclyXTSCuwrBMiYBa7L/tRfmjw3g6iiH96HO
 JFfMmQpNUqGOkEXUrsUIMpWcOOAnXDjciZYq1K9rqss6G+Vxwt0uFToGIWKJ4LaFJwOwS50o
 Er+o0jVIAkcP+WP4jOiqlD3qdSTzHr0Ddd6+LqQs6QCbEeo7mgSDgAGEFi2u/+0jmagVN9Fb
 U8Z4Cwjqe417kPDZt/wQxG1vlaasRMGHdldCes37EeK0KW83uqCLmEASjgEbJkts9U7AGRxk
 FSIhNjuQzdotdV5VE6gy1tdlhvrUQA9Jm4ZbihCRgwAi+QPaqlo5v4TZr6PyJKIs+A=
IronPort-HdrOrdr: A9a23:9A9PUKAPVcbFD/3lHejZsseALOsnbusQ8zAXPh9KOH9om52j9/
 xGws576faVslossb8b6Ku90dq7MA7hHPlOkPgs1NaZLXfbUQSTXeZfBOfZskHd8mjFh5FgPM
 RbAttD4b/LfDxHZK/BiWHSfadDsby6GeKT9J3jJhxWPHhXgs9bnn9E40qgYytLbTgDL6AUUL
 Cb4c1KrSehf3M4UuSXb0NuY8Hz4/fwuNbDexApOz4LgTPisdv+g4SKYySw71MzQjlPybAt/S
 z/lRDl5qKsive/yhXN/W7e5ZZblbLau5d+7YG3+4MowzPX5TqAVcBEYfmvrTo1qOag5BIDl8
 TNmQ4pO4BW52nKdm+4jBPx0024uQxepkPK+Bu9uz/OsMb5TDU1B45ogp9YSALQ7w4FsMtn2K
 xG8mqFv958DA/Gng76+9/UPisa3HackD4Hq6o+nnZfWYwRZPt4qpEexlpcFNM6ECfz+OkcYZ
 9TJfCZwMwTXUKRbnjfsGUq6serRG4PEhCPRVVHktCJ0hBN9UoJj3cw9Yg6pDMt5Zg9Q55L66
 DvKaJzjoxDSccQcOZUGPoBe82qEWbAKCi8cV56GW6XVp3vBki97qIeuN4OlaWXkd0zvdUPca
 36IRBlXTVYQTOoNSWMtKc7hSwlDl/NGwgF8fsuk6SRioeMNoYDDhfzPWzGs/HQ6sn3UferE8
 pbfqgmTMPLHC/JBZtD2RH4Vt15LHkTV9BQh/MAMmj++/4i7ubRx7fmmDG5Hsu0LQoZ
X-Talos-CUID: 9a23:HMKG+mxHxMwKs4CGGPn4BgUzHMF4XT7tzkz6Kl2yMzZTS5C/bW+frfY=
X-Talos-MUID: 9a23:+kD4OgbtK0TLqOBTj2PAqBN6MsxR84+nLxgvyro955jdOnkl
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-03.cisco.com ([173.36.16.140])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 09 Jun 2026 18:24:46 +0000
Received: from alln-opgw-3.cisco.com (alln-opgw-3.cisco.com [173.37.147.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-03.cisco.com (Postfix) with ESMTPS id 2B97718000439;
	Tue,  9 Jun 2026 18:24:46 +0000 (GMT)
X-CSE-ConnectionGUID: M4N3uudoTUanqfbFxvOMig==
X-CSE-MsgGUID: 44Mwx+NGRxOHVDpd56188w==
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="55965543"
Received: from mail-ch4pr07cu00105.outbound.protection.outlook.com (HELO CH4PR07CU001.outbound.protection.outlook.com) ([40.93.20.101])
  by alln-opgw-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 09 Jun 2026 18:24:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRbQhfrVjnTqvbHQ3+foOcu7SGEt5aEXudP2Hy9fAA91gCo1quX2GIANAeVkyki51ehAT0YdEhchxE6T4IVSrDRknciL8AYgr2K2ikVqBc9yUrhEg65OAfLAf+yt6nX9GyXYT1zkQCj4I3BRmK9duFRvc9B1HJSX+pZMhDRzNGCr9MyBOPZ6f1VonQBUrXUEym7upcrodiqXghpPIXd2F/cmH8o8wyInDiB0wEBsi1C2dSnGm5xWcaAYaRJM5lXpayyxyJXwrAgI2M+Z9hI6Y/JeOnM6c3YuY1J1v4Fda5YGcq0uaP62x+GKUisU4kTHXVQ1rhwO1SbsaKyXmnkHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXP+DPaB7bJjHSMtLY+4WdBd1a65JDXp1xyjq58DMaE=;
 b=ujq+FCehxvXJNh0ZUb7JIeAwKH4sOjd0icbIJO1OPu2Lcd3oqBSZvJDg8OEU6ueADKhYOgQBn//QflHW/j0t5fEXTNVJVhOXHK48J1DzzIn2erCLXwQ6Dpk28yLiP8dembjICBzH259mp+82PGIp0wI7WijKS/Rzt2XzkwxdCLqkEP6chRzoL3lXR4Fds723C2cc8rv66T9lZMiBueVy+IDu1iDQ89B5k8TBSPnr8wdH/FU11bvQshjevPJm3GFHtD7CNgkAbt5IolAEvwfm4CS2ef6db2DioREs2zJ9TQmsdRIYTgnbXII+kSJVujFjbhq/axdbUEiOHoYbFKz94g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DM3PR11MB8758.namprd11.prod.outlook.com (2603:10b6:0:47::15) by
 SJ0PR11MB7702.namprd11.prod.outlook.com (2603:10b6:a03:4e2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.11; Tue, 9 Jun 2026 18:24:42 +0000
Received: from DM3PR11MB8758.namprd11.prod.outlook.com
 ([fe80::a457:7d37:d8f:7340]) by DM3PR11MB8758.namprd11.prod.outlook.com
 ([fe80::a457:7d37:d8f:7340%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 18:24:42 +0000
Message-ID: <99bbd283-84a0-47b8-9e2c-e3d412ad03cd@cisco.com>
Date: Tue, 9 Jun 2026 11:24:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 01/10] enic: verify firmware supports V2
 SR-IOV at probe time
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sesidhar Baddela <sebaddel@cisco.com>
References: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
 <20260609-enic-sriov-v2-admin-channel-v2-v8-1-8ad8babbb826@cisco.com>
 <aihNYOiYUc3p1Y6_@gmail.com>
Content-Language: en-US
From: Satish Kharat <satishkh@cisco.com>
In-Reply-To: <aihNYOiYUc3p1Y6_@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To DM3PR11MB8758.namprd11.prod.outlook.com
 (2603:10b6:0:47::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8758:EE_|SJ0PR11MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: b8d77501-4c08-4296-bdd1-08dec6545fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|6133799003|5023799004|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	k3OctXhWpEbrPkgN7ykqnZHkZCwvwTXdEn9BPLf/poHPw5VYNlLHeby3CBUasAMoCRLofTjMQkQRiKvcOQT2LujdTfMxSGrTi/eQ5Kg6O7q3W6wfD0t6tmnoYmtARZAI6SG/W+k3+AARxthCqzhbjohXhoI7pyIWbXsLYtzxLUM/kwoocBCBjAUb3u7qdcWJykdk4zRahujtk8IfQnmbzrmOC+r3PbwIDx1MgvYQCqy0rYcrPFGT3IfetyMDBuF30Ey7SNisoZngkKKfZaYnSrHvXDrnSLixVt8vkVPrN4/zIgHal4olfRiLkbPuujPdckoMtBeRe7QGTYRUA94uycBSmCuTjJZ+7Sz8/+6M4SeqcmQ5co+O7tRFpBMnUwN3vvR0GstPLTDaZnK6Dau853pjUfKNW2PGKHlk8iAotV7evvHvDuNoEGrnlIGCsU1WFGAgut752W5gmwvQ61MVp1oiLuPluQaB9SmBPKC/SS8j+VJMdB1Rl+py5Cf+ZdDuQccH5f1RPLUcI5MGXGb+b4xgmi8U59/Da8mHPW4ATD5D396RiqgZGDKuimNM+m+UDdTQgsB4ANic1IN5BGYXNfaWp2cGys0FYQ+auyE2Tr2bUtFArmMfk+/zV96AkmokYODjIB4Jxj8mUQYOKVn9bJXfPKCdwusgGoHrO/XroRC3gAdL8OidJr3yRAwxfAOC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(5023799004)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW9laVJHZXN6S0FKVGJGVlNBKy80YXBSeGk4SjFUWmtIRGZ5VVhGaSswdWpi?=
 =?utf-8?B?N0NaRlEvRnZhTjFpSGpQOUJWYmNMU2RhSDlhTDZTVTI3cTN3c3kxLzdldkFt?=
 =?utf-8?B?clRQOWFxQVFES1BIM3VSME5UNjA2SzE3U09PVlFWMll5T0RsOGJhbmlkVGtR?=
 =?utf-8?B?UndFVGxmOGpOOEpqVVRLYVB5RnFDUTFFbitMKzVHcnRtbzMzYm9FNzlmc0VH?=
 =?utf-8?B?TTVRVkFHZ285QXFnNTJkZkdpREtMT1E3c2NScVdhWjZ5WG9LV3REdnBRcXpD?=
 =?utf-8?B?ZnU0RkR3N0FIUkVaYUxUeEp4YWx0dUhmMitNRHlkS0ZjR05ybzduZGNabHdv?=
 =?utf-8?B?a1d4M1R3QmRXRGRrbkNGUGo3YnFheEd4Y3poNmJ3b1BFKzJUQlR5d3JRL0oy?=
 =?utf-8?B?UUNJWEJKZXRJMERhVitaTnh5b0lsZ1I5N0tVZUJiUXN1Yzh1ZnNoNEdzLzZK?=
 =?utf-8?B?VTB6LzlvdUR0NHBQS2hwRksvb2ZGY1RDQ1lvSEk4RXVLayt5NjVpcjIzMFhO?=
 =?utf-8?B?bEkyZzU4WWdWNldHR1NFeFNHZXVYeHhQenVGRmhrcFdYR0pBY2daaGM2ZjJL?=
 =?utf-8?B?K1pvUEl2YXIwNXFlRkg5WFovZDdWVllNTEQ5Z0E1YlUrZWtiYjA4QWJreG5v?=
 =?utf-8?B?WmNhQVc5LytpcG4wVFZ6ZlFxY05JYVdna3paQ0trblpSeEcrMUVBV055UmVj?=
 =?utf-8?B?RUdmNWcxUU01WHZ5NUpQeVpoYTByUEN6WWExeEtTak5SeG1ab2RWK0dHbm9i?=
 =?utf-8?B?NXJOaTRBRXNMRitOLzM3emZuT2YrZTYzM1hVSXZCanpWanUvYWk1QlBGa095?=
 =?utf-8?B?K0w1MU1oTC9NN09yTVM0QkVFcEM2MFB6WVNpZ0tWMWVBQzBkVHZkUHdhVkFp?=
 =?utf-8?B?SjY0VHdta0hKZ1JyQ3ZDZW5DWTVHaGNvdHEzSWZZelZqbi9NRVUxWFpadUNp?=
 =?utf-8?B?Ky9Ia2ErVmNONmhBdTdtQ1VRODdMSUwvNmMxckYwT3lYazNkVDFZRVVjMytW?=
 =?utf-8?B?YUxlSExWUTNNQ2lydGxjeG5GTlJqcjhIQjlYYmxvUDRWMWs3WWtPWDRXVWdj?=
 =?utf-8?B?eG9BWE5BUm1TemtLR3NXUVhTck9uRGNtY3pieHBSRnplZExhd0N3eUFKTzhQ?=
 =?utf-8?B?R1A1UnhSUnEzWTIyYVBwdmoyR2wwY1dmbGI5eElqU1RjTTM0N1VnV2xlcXdN?=
 =?utf-8?B?ay8zaDVaalgwUU0rMk5jb25tR3pJSDRzWFk3YjlTemVodW92VFpFUjZvZ3V6?=
 =?utf-8?B?NXhGVVY2T2cwQk1Hb3Z1amhweHo4V0lPWE9LRmlOSW1LV3FaQ1B2ZTZyZzNE?=
 =?utf-8?B?MjZjM3AzMVVOanlIZEZqSVdvaXNiZERwTGJhVW9QUWpCRTFuUEZZcFgrekpj?=
 =?utf-8?B?ODdPdWIvbXVxQmhVTnF1YmREY3B3VVBTM01QUUczaXoybnA2NXJhY2lTYjcr?=
 =?utf-8?B?UUx2dWdNWFNCMnZYdjU5dENidTZEUkxvNkdrNHJBWk95SjZ2WEtXTnd4a3lj?=
 =?utf-8?B?UHUvVVl2d0poNjBaZytRM3VoK3ZrbWZjL2c3NnRUVFdPQU9JNzltR1hCN2xJ?=
 =?utf-8?B?SENGRTd1RlBEbHFTTzZxM1JKdTMyV2VzNkZCRXJaRkVYcCtIajF4d0M0UTNE?=
 =?utf-8?B?eUx1bGUvU3VFQ0p0V2xRc1ZuMjVwMzIzdXJGTnFPSnBsSXBGdjA5STFmUjI1?=
 =?utf-8?B?cUtOR0ErUlFaWC9OT0MxcFdwWmJBR042R3kzV0I5Zmg5Qk96NDVRb1ZaSU9T?=
 =?utf-8?B?a3NCa2JpekE4SkJUZHhPdGZIVEcrV3VuNnFSai8vY3VhdHZuQTI5MlcxU3Ir?=
 =?utf-8?B?N1dwVlJpMWp6L2RVNzk1ejNIc01kbDhUbk0xcTRieVBTdWQ5cUU5NWdZaEZ3?=
 =?utf-8?B?UmhQRkNYV1lHeXArSDcvbHBJL3Z6ajM5RXcvTzZnRjZkZ3Nndi9TK2d2dE00?=
 =?utf-8?B?TzZUWUJWUnYyM1NKS1BENGVCeU9HOWpkcysxQVZHNk5YcGlBd2N3aFoyMUhL?=
 =?utf-8?B?c2hIa3pDRWhFQ3AzVld4Mm1Pa1dJL1Z2NjB4dHBtckRQbTFFZG9Db2xmTW14?=
 =?utf-8?B?aU1SMUI1ZHVPbU1vZ1NOR2xsWW13VFh6OEF6aHpxOEJxcUN0K1FNL2V3MXMz?=
 =?utf-8?B?Unp1TTRmVWxLR1ZaL3RqUVZGMzRFK0VOVEs1d2lFTFdqa09VMk9JQ0xYZm4w?=
 =?utf-8?B?S25VQWJVdG8rRGRhOTJNYkhMWWlrQ3BoZDhPdjFEaERjZWEvSmpkTHp0WEdN?=
 =?utf-8?B?NDZoM0x3TTlHVjFwVHNRMUc2SG53OWhoYW5JUEI5a1V3cTU5U1lJd0drcUNU?=
 =?utf-8?B?S3hKNGF4UmZLUTArR2pRNFA3UzhiSy80c1BGenRBdXhYOWZ4K1hvdz09?=
X-Exchange-RoutingPolicyChecked:
	CK7j6HEuwvaR93xScKK9h9FiJEfQO7C72XkaYBL4btbdXAiMYv+9FAgLgIuTSVcrX5Zc6OwFxz7+/5jPL96lJSlAEMARwEkRDJaEnIErFgVuX6RP4K8KhOeELV/dLzsfL/KgrzXmUof4fHwXt0r0863bHCEZaN5qQgwW9eqCy4Xn8bFM7RBRHABaUcEUWj/5RvRRHMUkG+sau4dYLcwuJNQZMSQzqSB1H7EbU+0jpPBbIyhghaI1ir8FdRwHp4wiFNAZiF2dxomXrBOWbkLskdcY8xqUeKY2//iQtDLX7tSdyKo0gWzCA0UT0ILMO9G+3kJavSroUEmbP85PGhQPGg==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d77501-4c08-4296-bdd1-08dec6545fb7
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 18:24:42.0477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8nzjrZpTkjGoRJz93/a3zqf6s5lI69a27r/jbKKuooIw3dcPihrKfaYraVOKfuggGyxmCGXUU56zVDxTP2MaFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7702
X-Outbound-Client-TLS: ANONYMOUS;alln-opgw-3.cisco.com [173.37.147.251];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 173.37.147.251, alln-opgw-3.cisco.com
X-Outbound-Node: alln-l-core-03.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297229-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sebaddel@cisco.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cisco.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 248436635B2

/"Can we get here with SR-IOV enabled? Then we want to disable it on 
failure."/

No — enic_sriov_detect_vf_type() runs during early probe, before any 
SR-IOV enablement path executes.
The auto-enable path (for pre-configured VFs at boot) runs later in 
enic_probe() and already skips V2:
if (enic->num_vfs && enic->vf_type != ENIC_VF_TYPE_V2) { err = 
pci_enable_sriov(pdev, enic->num_vfs);
The user-triggered path (sriov_configure) also checks vf_type and 
returns -EOPNOTSUPP when it is
ENIC_VF_TYPE_NONE.
So at the point where this function downgrades vf_type to 
ENIC_VF_TYPE_NONE, SR-IOV has not been enabled
  and there is nothing to disable

On 6/9/26 10:30, Breno Leitao wrote:
> On Tue, Jun 09, 2026 at 09:32:27AM -0700, Satish Kharat wrote:
>> During PF probe, query the firmware get-supported-feature interface
>> to verify that the running firmware supports V2 SR-IOV. Firmware
>> version 5.3(4.72) and later report VIC_FEATURE_SRIOV via
>> CMD_GET_SUPP_FEATURE_VER. If the firmware does not support the
>> feature, set vf_type to ENIC_VF_TYPE_NONE and log a warning so the
>> admin knows a firmware upgrade is needed.
>>
>> VIC_FEATURE_SRIOV is assigned the explicit value 4 to match the
>> firmware ABI.  Slot 3 (firmware's VIC_FEATURE_PTP) is reserved with
>> a comment rather than a placeholder enum entry, since PTP is not
>> used by the upstream driver.
>>
>> Suggested-by: Breno Leitao <leitao@debian.org>
>> Signed-off-by: Satish Kharat <satishkh@cisco.com>
>> ---
>>   drivers/net/ethernet/cisco/enic/enic_main.c   | 21 ++++++++++++++++++++-
>>   drivers/net/ethernet/cisco/enic/vnic_devcmd.h |  2 ++
>>   2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
>> index e7125b818087..53d68272d06a 100644
>> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
>> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
>> @@ -2641,8 +2641,10 @@ static void enic_iounmap(struct enic *enic)
>>   static void enic_sriov_detect_vf_type(struct enic *enic)
>>   {
>>   	struct pci_dev *pdev = enic->pdev;
>> -	int pos;
>> +	u64 supported_versions, a1 = 0;
>>   	u16 vf_dev_id;
>> +	int pos;
>> +	int err;
>>   
>>   	if (enic_is_sriov_vf(enic) || enic_is_dynamic(enic))
>>   		return;
>> @@ -2669,6 +2671,23 @@ static void enic_sriov_detect_vf_type(struct enic *enic)
>>   		enic->vf_type = ENIC_VF_TYPE_NONE;
>>   		break;
>>   	}
>> +
>> +	if (enic->vf_type != ENIC_VF_TYPE_V2)
> Can we get here with SR-IOV enabled? Then we want to disable it on
> failure.

