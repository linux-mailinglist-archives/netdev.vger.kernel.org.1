Return-Path: <netdev+bounces-131739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D3D98F637
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 20:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00676B21F5C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398181A7076;
	Thu,  3 Oct 2024 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p5aBqMDJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508ABA41;
	Thu,  3 Oct 2024 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980554; cv=fail; b=qbsJGLkdJXaY/ltRYn7VIHg/T9YDoTMtuDEt7Tn5uzxWvO07cHHMapywsbj+ubYnrHNOd0Mnei1w2at79dP932UKt+6WeIZEnYSD4kMwYJm4XUId9d/vo1v+/Hp4Ve8ZFMbATdS7AkYk2JVyt0wZrrSLdO0OnEvehywH2Wpz+Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980554; c=relaxed/simple;
	bh=/lRiKrHHjfQPNafgJ0iH9QQKZfJP1sWWhCPRYRgHL6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dptauu+KK6uUvWJgLx/5tSoBik1zLLpL9BF1EofvX4zvdQw8NqDvS9xT+RB0LxJ6PVWDNOCYCLqGIBxeapz47kGHaEBmBShV8WNa4YaoDSWE8esZqAvADTaNuEe3jtR8OeutQa2WcdgR455y7gIoq9UgFvqq/O3kwdWvKiBrXQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p5aBqMDJ; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/eXr5gSXUFKYaOaxkZrdInG+MoxFK+dQXd896fzHF1ZxC9V8hUteCvUhlT350krsRR/wFua/NoYwmuA/JeBlpg47S9pKD6ohLX28GQBBD+DgLRHVN1o9cSBmrgybJgNQpDbLcI0HW8hjtbgko7cmc7AOKOOn4D5XDfA90E9Gp0BZZkVkKXl74Mb4zBNUluiUYoO18h14eqnRFNx2TnMQveTr5oVJsK92ZlMlfnF/9LzpdO55sFy+pCAM4ph/CUIrTRPk72SS/ZBgt3j+ceNOL/16X5hTngpGtPVCnOSLeZZkFKLFJCvnm8k/LTs/Enfsk4b41C59DMGYoSRnpS0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+u1xeBaDFrl2mE/8lWqzoHSWGaz35bjIdZBVWqTZ2o=;
 b=nX65oVr2in23DV7wRm2OdlPKmwBc0dUK65PPzBIybrMd10G6yc2uCdBH9cIBgRp5vJvoRq6WdNYxK9zarG8pBoLlvIzVOoOLX7KhjQ58W+fbevgZnHSGP8KCzg6OOm4RNww1jh8DtxfZlYBPOCZ9AI8kTEuBvk6MFaNaeOOc1ONNo6MQJLwQBLxXvEPTMhD47TGGtnYG+EURP0wpDe8zLE7D8XQzNuqmc/WX2yYRSoAC0PpvkgjtFNTFFWSxQmBULLGaZrcfuY/IPH7Q4qYZimJNTPw/mZ2kfpXrTe7yE59FTlPJEwDACRzw5hJF78XWPLXvPCPrYgn3/oDehdTusA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+u1xeBaDFrl2mE/8lWqzoHSWGaz35bjIdZBVWqTZ2o=;
 b=p5aBqMDJt0iDCBx5umGrtArESJq3a6g4NEG4oX+EddUnDKt8RDCwtilXJ9RwfuKid6ECDkArBH1wjFfx5qmB6Rx31RWAaRYmJGiTeqSar+ZM6uiXwmwjpbHPZiBoFacqV352kCByjF6oMQP6AOp1RfnD3T9V2yg+SKknZtlXXrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 18:35:47 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 18:35:47 +0000
Message-ID: <70c16ec6-c1e8-4de2-8da7-a9cc83df816a@amd.com>
Date: Thu, 3 Oct 2024 11:35:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/7] net: devmem: add ring parameter filtering
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, almasrymina@google.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, donald.hunter@gmail.com,
 corbet@lwn.net, michael.chan@broadcom.com
Cc: kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com,
 aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com
References: <20241003160620.1521626-1-ap420073@gmail.com>
 <20241003160620.1521626-6-ap420073@gmail.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20241003160620.1521626-6-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::14) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 19527d66-7104-40cb-1e08-08dce3da32b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHlLWkZENGpWcTFwS0l2ZlJnNGdZa243RjJKbGs4NEVZSmJBNVMwUjhVek5n?=
 =?utf-8?B?Wmp5dERVSUZaM0MveEEvbFVRNk5QOTBPNGlqcHB3Njg2TzNFQUxJeko0MDRU?=
 =?utf-8?B?dmR2SVphdGpFUTdDelF2SDVCTnBkeU5SaFE2ZFNxN2dKN1ZXeFFMUW5KNkp3?=
 =?utf-8?B?YlUrUXlzM3Y2VTNBdzFzRWQ2Z3VFcFB1MExOdzM0YTdtcHBEanFkS2xtWFdK?=
 =?utf-8?B?ZVN5T0kzTHJUZTl5NmplTW83dEF3QTM5cU92REtPR1ZIektkYThQQmhFSjF4?=
 =?utf-8?B?R0twUDZ0dEVkUXQyVnlvN3htKzBncG1rS0VGcVY0eE9SZmRXWDgwc2xUMGFs?=
 =?utf-8?B?RjRRM1BQaCtrcEV3OWUzem4xdXZuazdNVWVqaStqQSsva0FSWnB0QmMwcWZ0?=
 =?utf-8?B?aGhlUjlCbzFtOUtzUjd2NjVZNXZkTVJkTlFXVXc2RmFMb3RUTllxV2c4Nk50?=
 =?utf-8?B?YWpiUG1pWndjRVloaHBZUHRxTk0xcU9PZ0VTbTZtdjNPcUViK0dYZ25PcDht?=
 =?utf-8?B?UzNiMGJCTzl3eHBNQjYrVnV2NHd3blNNRHpSU1lqUE5pZEdaVEttMEsxS243?=
 =?utf-8?B?Z3lpeGtPNWp0R1ZpVkVMWTRqdDE1TWEvRlhvWGNMSGhidWpkWXlLN1Zlam1X?=
 =?utf-8?B?M0VWRDVFSzh5MmxmcEVYRVJnaU9STHFiSElGVEhWb21oaHlsZU0waXZKdytp?=
 =?utf-8?B?SXhoOEY4bTNRVUlNYjYzZkxodkxQTzltd1Y2V3FJQ2RBZEFKRVFUeTVaWGJk?=
 =?utf-8?B?WnJmY1l4WlZPa1A0ejJTYjZvMnQvMk9kTTVjNVhkVkdCYiswVGgxMGVXUFRy?=
 =?utf-8?B?RlEySHRpc2xKUkk5elA5VWJTem1HT3R4UTBwMGZYK1BNelR2QnhRL3crdGJ5?=
 =?utf-8?B?QmhXRVlRVzcvRGw2a0ZHT2pDVEgzRHd1emozOFRxYVVvREdQQm5BZm1UWmxI?=
 =?utf-8?B?RGlvK0dmMWpuK0RyMHVMR29yWEtFbXZ4TG1pdXZMVWM4YW9hUmdzTG4wSW1F?=
 =?utf-8?B?NENmcTZydEpVR0RtVFFoMlRidW0rYVJENzRxcTRqazNTVXk4M3kyaVlTTWh5?=
 =?utf-8?B?OVZna0twV2d3RlVWekkrQXhwcjQ1blRkbHJsaW8vQUFEWXpCMUhEMzl6bmFS?=
 =?utf-8?B?TFVHNjQwdnJOWXliZFRtOHUvMWNTTURVS3FjMGpBQVBTTEs3cGROWWk4cWY2?=
 =?utf-8?B?eDBzSlVhUmRJUUEyN0Q1T3lpci84Q3FtRkxVQlZ6K2s3Y3FnR0VuZ2FQRGxj?=
 =?utf-8?B?a0hCMUpabllyMnNFUWpGb3dMUjRpYWsrWElTK3p5NWlwbUIvSEZ5L2ZCZjNB?=
 =?utf-8?B?Qjd1ZDl5d1BlY0FqVjFBZ1hIUmprSC85ZWErVjlHbEk2TGdBRjJ6NWxYczVj?=
 =?utf-8?B?WXpmRDJzMUJvUGdjdmtVYXRJUDdpaERoSEhXOGJIblYzU1pWWmRyVzBmWEw0?=
 =?utf-8?B?SkJ3TUZ5WFZFMjZMWUc5OVpKcldyclEzcDM0SmJkaEdqc1BnRi96ZndrdG9M?=
 =?utf-8?B?UnVjbnVwNzdoZmkrQzhxdTYwQTl0QWlIYmZ6OEFtNjN6eEZISUIrbDRvNHdn?=
 =?utf-8?B?ZlpobGpURTVYeFRpczF1K3hGRm9xVkZ5TER6OVZqNlpwNklvYUFtTHN3V3Fu?=
 =?utf-8?B?dVc3blZ0ZGtXVzNRYnp0Y3gxdlFCNXJLRlJNYS9kc2xoTXlueUpCb1h3RlNQ?=
 =?utf-8?B?SGRqL0lzSWwzUllpbzdpMURoWXAzTlRYUEt1Q1QwSkNDUE0waHpxaUl1bCtT?=
 =?utf-8?Q?HMjlkA+9s/ynN5gAtVsi30SnVnppKCHO17w73lx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGhZSGpONXFJdGtMWkpIbDFwbERPNHFPSnlmY0x3RmdJOEUzdVd1TmdUYlcv?=
 =?utf-8?B?WkhsdDhFbXNubnQyM0VoblZpYVowd05TL1VQM055Sy9naFFsUFZiU2U0NXJi?=
 =?utf-8?B?cFBjalcwdU9rNGs2VGhCK1pzU0hJU1BENHZNMlpNRU9Ja2dGTG1CN1BVVmYx?=
 =?utf-8?B?d0dDbm1qb25ibURTZmpBMitGbkZlQmFLaGJ4b2Nta3Z6cGlCYUhjeTdmVFVY?=
 =?utf-8?B?cGFFT2lwVk1xQkxPWUxGMFlkUVBEQVh0Rldqa01wWHlQZE9DemgrTVlkMWR0?=
 =?utf-8?B?ZkhwS1E2cW50RUoweGlKT3VZN05BcklxUHkwRUJ4em8vL2piWTgxUlZjQkgw?=
 =?utf-8?B?K3hnV0Q1MEViVGZ2ejA3MHBpQUlCSDNmVWZKVzhRQTVDSnhWZ0dFeXE4a1Nz?=
 =?utf-8?B?QUh6TERWaUptako0YVM0bncreUR6emxFWmJFSFdXd1BxOUlKN1JQNUYvT1dK?=
 =?utf-8?B?VUdWNU9WUzA4Q1lWamVpRk5KbHhDbEN4WHJmV01ObzlVaTF6dDh3dU1SMGZm?=
 =?utf-8?B?b3hzeEF6Lzlaek5WRUY5Qzk0cGFENjg3VGFZdFVqZXpaRUlPL3JLODFWWmJD?=
 =?utf-8?B?T1FmRE5Jc1Z2SnlSQ2VRSERYZjJ0U1RrUFgvYXhEb2hqa1dEM05ZS1Z3YkYx?=
 =?utf-8?B?Q0tDSFlQcXd2bXFsbzYvZGlwSy9QV25HdkIwK3JmZzgwZU5acFhZWGtEUzJB?=
 =?utf-8?B?NEt6TjYva3lXcHJIMDAxaTJWVk1MalZ4akxQNzFVOC96b3J1YkxLZzc4enVn?=
 =?utf-8?B?RmlZSGpvemVLTTNQb2oxVFhveENWTGNyVCtmU0JwUnAwSlNKWFV2dnJlNXkv?=
 =?utf-8?B?d0JpZXdaV2JjNzhnY2VVRC96UGk3RDZ4TU9haU9DbW9UUDhOWWtFUTJldUlU?=
 =?utf-8?B?aU5FcG9OQ2hWWmJaaTFOTlFjQ3FJUTNJRXpwUXBOTS8wS0Z0U0VzZEhMNjAx?=
 =?utf-8?B?OW1nN0ZEYnpWemtyamQ3VmlOSVNTNTFXd0VWYmJHVzJhd3M0aGdHTERCcVI5?=
 =?utf-8?B?NFV2b0N2bDk3SSthN0NtTzdIYm1odWJVZEI4VlhwRWZSV25sQ2RrVUtpajRX?=
 =?utf-8?B?SDh6bTdTTXNrOGNTdStTK0krRDVxOHExUTJQNlRTUGIrd05YQ1VRQTFzaGwy?=
 =?utf-8?B?SmhjeUsrM1phU3RIdGc5MDZlNnBHVUJkTGp3cHhZM0JqTC9vQ001dlJJbFdN?=
 =?utf-8?B?TDNOQlgvay9wdXFwWUZ4djNka0V5Znc3ZUUwNk1zRy9nOU9scGxVMFF5TDZk?=
 =?utf-8?B?RlBFcXdPblE0OEpSMGdxWUJGVVJQa2lrMU16ai91bTVnclR4UE5XTlJpWXdp?=
 =?utf-8?B?cUNPSG1tVHRmdC81V2lBL095US9mQzhJQXpsVjZrYXVZY0pkSTYzN0pvNkh1?=
 =?utf-8?B?ZkMvMVhNRyt5NTd3Y3IybmtYTjkzS0hhNU9ibzZmVDN0Tm5rZTZxbXVyM3RH?=
 =?utf-8?B?R2xFaGJCVm1XQW9XQjMwRVFjOCs2VkttTFBNcm56WDBqZVdTUlZseVppbWs4?=
 =?utf-8?B?bGpVU3hzV25NQlJ5WVRacFg5UEorYmVyek55WE5iaTlnb0s5YUhYN0xIQk44?=
 =?utf-8?B?blZPWjFKT0w3QlhKdHE0UHN3VHlGZVgwME5EUmRXZXArRk1iS0NqTWxySmpi?=
 =?utf-8?B?aGptSWVJTGRZSmx1d0xXd0lmYWVKcjIrWkVzK3VJekpKQ1FsTENyZmY2OE9q?=
 =?utf-8?B?bmhIRXV6YW9SbjAySXo5VThDeTNla2xEcHhPWWpvTlZocjYzMG9uTGFIeFVM?=
 =?utf-8?B?am5OS3E1Zkt1YkFoL3prS3NnNFkwcGw5dEVIaHJkVHBsZXVjU0c4cVo0WC9F?=
 =?utf-8?B?Qkc3L3pmN1FFZnUvUlVuYVFLNzcwNlgxMzd3ZUFOaDc2VjJjNmJqV24zdXhM?=
 =?utf-8?B?TmdSd0RKUE5FNGZMaVpSM25aOTNmRU0yTUVQRUlJTDM0UU4yQUlWS3U2b0tY?=
 =?utf-8?B?SklWYWpDUU9Rell1d3VkdjRlVUgzOG5TTUVoZmgvYjV3bmZ5U0pUMnA1NG1X?=
 =?utf-8?B?c1pzTkNia2FmdXhneFJFdmFLa05vUmRiQWs5ckw4SkNYMWVOMVh2bkZDRVFK?=
 =?utf-8?B?SzNuNS9HaDJ2SU05cEt4b1lTaURUeDJaTHV2Y2pxdTNqQ1dlMkdXbFN4cVlu?=
 =?utf-8?Q?OFRefMPyY6EVOC0jMt1iZXo7E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19527d66-7104-40cb-1e08-08dce3da32b9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 18:35:47.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wY9FVndUyQOvJO2ICtKobUU05AhbI2m5ltUEMVvIzHjeWC3+W/fPL0hAtbehRTa3cRVtVIipDE1EfqNOvMe0Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752



On 10/3/2024 9:06 AM, Taehee Yoo wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> If driver doesn't support ring parameter or tcp-data-split configuration
> is not sufficient, the devmem should not be set up.
> Before setup the devmem, tcp-data-split should be ON and
> tcp-data-split-thresh value should be 0.
> 
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> v3:
>   - Patch added.
> 
>   net/core/devmem.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 11b91c12ee11..a9e9b15028e0 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -8,6 +8,8 @@
>    */
> 
>   #include <linux/dma-buf.h>
> +#include <linux/ethtool.h>
> +#include <linux/ethtool_netlink.h>
>   #include <linux/genalloc.h>
>   #include <linux/mm.h>
>   #include <linux/netdevice.h>
> @@ -131,6 +133,8 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
>                                      struct net_devmem_dmabuf_binding *binding,
>                                      struct netlink_ext_ack *extack)
>   {
> +       struct kernel_ethtool_ringparam kernel_ringparam = {};
> +       struct ethtool_ringparam ringparam = {};
>          struct netdev_rx_queue *rxq;
>          u32 xa_idx;
>          int err;
> @@ -146,6 +150,20 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
>                  return -EEXIST;
>          }
> 
> +       if (!dev->ethtool_ops->get_ringparam) {
> +               NL_SET_ERR_MSG(extack, "can't get ringparam");
> +               return -EINVAL;
> +       }

Is EINVAL the correct return value here? I think it makes more sense as 
EOPNOTSUPP.

> +
> +       dev->ethtool_ops->get_ringparam(dev, &ringparam,
> +                                       &kernel_ringparam, extack);
> +       if (kernel_ringparam.tcp_data_split != ETHTOOL_TCP_DATA_SPLIT_ENABLED ||
> +           kernel_ringparam.tcp_data_split_thresh) {
> +               NL_SET_ERR_MSG(extack,
> +                              "tcp-header-data-split is disabled or threshold is not zero");
> +               return -EINVAL;
> +       }
> +
Maybe just my personal opinion, but IMHO these checks should be separate 
so the error message can be more concise/clear.

Also, a small nit, but I think both of these checks should be before 
getting the rxq via __netif_get_rx_queue().


Thanks,

Brett
>   #ifdef CONFIG_XDP_SOCKETS
>          if (rxq->pool) {
>                  NL_SET_ERR_MSG(extack, "designated queue already in use by AF_XDP");
> --
> 2.34.1
> 

