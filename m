Return-Path: <netdev+bounces-281906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFCfGIfH8GkqYgEAu9opvQ
	(envelope-from <netdev+bounces-281906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:43:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F29B0487339
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4417D3198783
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB8843DA5E;
	Tue, 28 Apr 2026 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d85Sm05J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EA934EEEE;
	Tue, 28 Apr 2026 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385223; cv=fail; b=KtOLibf0fPkj3ZlBX3s+N4Sf0gVFBo+zd3IW9H4nB2MCcyp6Y0ZqDBt3lZGTQFqdvFPvncgBZcf4aK8X52anUPyV00BdkBRy2l6ETerOgZu5RmSzKlxSI0+MZSUIOwtc/82CmsTIfgfPU18I0TjmU2xeBfn3qL3wgFxPGHvL2cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385223; c=relaxed/simple;
	bh=CiSfO4ogEzQmlN8Nr7qWHF5PS/vYxFtT/3gXBIKwspY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oU2oybSnXply8SIxHusjwEVijaygIuocVFucd6Koid35QL+QaFFM+4voPlnyAwN45t0z0XWWbL52cMxUhMRRn0TgzSzpljulK7fic1elKQyJtIHs726RQ7CRo+MfzBBuoJE7hjWhbQbv6t58dPA0KZJ9D9xAhXRTHPr+CmBiORU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d85Sm05J; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777385222; x=1808921222;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CiSfO4ogEzQmlN8Nr7qWHF5PS/vYxFtT/3gXBIKwspY=;
  b=d85Sm05JKqirTLCmPhFMRYHZHnK94CzY7w4pgQ3NGyYzd0BRiG7CJTjK
   JkI9+Le8Zzhq8aoqqDj/B8jlxt6zEnyK/Q3ycyABxdXnyKta+rquu7ylj
   VXu/sP1xqJC7FWw6opiNgXh5Qts+gRWmGD4bvLCbdAJO61QH2wwTq0VaQ
   cEcLYfh20mDd1nRFFdrh5IjKUh9vQwxecBz5vMp6yG4vQXr8Ciqg3kL4t
   ZDIYxDZPp+05BZCZsSfh2h2SYpjlImXkRL/BBKuUyNXFSSW1lHcVFFeau
   n2AS3S7iKD8lfSJZA8PH96MqfpA/4E35jHKtAgelwxS5fUf2XSd5JHM1L
   g==;
X-CSE-ConnectionGUID: YPKR+x7jRwaQhYu1VY5qfQ==
X-CSE-MsgGUID: fy4rERfuSySUXoy1M04fQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="88992176"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="88992176"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 07:07:01 -0700
X-CSE-ConnectionGUID: pbpvyPgnQnSRR79NWawqCA==
X-CSE-MsgGUID: 68RbqPWoQ/qm6A1BbWEaqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="232943029"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 07:07:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 07:07:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 07:07:00 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 07:06:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kvorp+icy21nvznVtfuFDHwTzw//C1JA7rphB/KlpsLB4L+3WyK8R+zWjTyjtGRm85oppRg7ejObcToKp/IKkuokz0VouuM6m64jvfxyvvoBh05EEiwDYzz28aWosZwVm5Qlwh+pLZkD0RhXNV+SyIeD1/9AKJQSnFVSyqsjNp+wXya9JAZDy6etXuPSX2K5lSfZmIdi8ytXhfLjdHnJzvfStPh2BFnOP3OrlX3ALcIWWW6F39QU7CuUfNnTAKRLV1Yh6J57+5y0lMDUvHmBqhN42oI8cabeBZwEs5AceOHo8xMpsCvxGJQoHgJ14dqqqu0+k+0/9CYSOuK+3Xeuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+Mr6nhKRxbn0Bw7atCe//vaG2yTpspUorgzw0nvNzM=;
 b=ceeoEkktctsQHQB0p0adO0HT1kL+BccvOx7C8qlbcYyFNG59AxdYeYgE/eQanZhSPnrnufl08Dx5P1ZV9A/hbywDoNG5qCBjhrIPRZMBulpQ8H8A84AqzWGJLcDOLgptaL5hM+WETx1vSKDCtR0Y6Z+KzGXsGY12oXrS5VaM1BXyBo7STdWwJIg+cpxpRz92kMsyp53x1aXX9vjoTn2gqymiJGdzFeVvCZ7w8eB5iDWsleKgiU8OznW//vHhqS+Cu/4vY7lQ9mgfNCrDhxho5mTsDEVeKyvupE9DODJFSFTYbqtrtx6cZfXYojQELns2+VQ0/NEY+o0BcAtderWm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ5PPF0DADD6EFE.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 14:06:57 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::8d98:e538:8d7:6311%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 14:06:57 +0000
Message-ID: <ef61b770-ebf4-406a-90a0-8a49aba02aee@intel.com>
Date: Tue, 28 Apr 2026 16:06:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] net/intel: Replace manual array size
 calculation with ARRAY_SIZE
To: Jakub Raczynski <j.raczynski@samsung.com>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>, <error27@gmail.com>
References: <CGME20260428103757eucas1p132f3f1123fae21d596a51cbdce72c931@eucas1p1.samsung.com>
 <20260428103653.3539239-1-j.raczynski@samsung.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260428103653.3539239-1-j.raczynski@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0032.eurprd08.prod.outlook.com
 (2603:10a6:803:104::45) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ5PPF0DADD6EFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf5190e-c470-41d6-7a98-08dea52f68f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7BKmHnWW4e0xOI8pTgTNPljYQpTI1H/IcSV5WNBnZqFTSHsRvFqoQcpjFnOa+dmC8d7NpykRyvzB0SoXhqkQe0M9qN343/o4FWlcJgz9evity0vy+b/gz9HL3UWDEwbtc8XcFtD3NFtqT8uz3/OmLqk28CoOAXs5uHdhsnkzcT0KtszKGcedc93y4jQo2MHTTm4Son3r/VySfdT8aKeUuYO1f4jeC+NqMP/+8MivWv3J4/N2G0tuF2ryK5nO188KjudOkkpVvj4CBdmYXdkOISK9Wk7yFGK1IZ3Q9t3/MsFuPI3m7kAbsLYLdybxwcW2gMl0ebMwQcCMr70K7MCV8/EO8Oa5TcDG4PkZAIIENusjnd5+PMKBFN7OQF6xQi7UjeL3S5UDOb+SHNJHnXqsyYsGJMc732xYD/SEm6qKC/4d3J2uODGqwhKRy6yyHrhup6u5jjuqVICa8Ij5cB9Alf/AXghsUk0uvdkQfyDI4t4IIkxUkhNzpqU96Nu4BCazuAZf47B6Fss4fUyVPzHlD8I2GhIa5eN/1qXcvOOiWnvpqLSM+GxS61eBk0jP/7o96R9EZywHrlfUKm9sONxTnMT9HLQBkILCGg/hCOlrFoDWBfVzsToRTN5DfhJQTfIuyNEsnH89mnzVAEdtrNWoDuReH8jP2/XjkzpEwEJ6Y07ODzwtsU9P3heCk7rcIyvKrdL1kkmstqrdRcfAW/qD8Al9drmgJkoVP60J/4FERV5BOvUAdDDW5mIt53fJ8Prt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZ2QUhhWHgrM2dqMTRpc1BNMDZhY0xWWUx3TWJhWlpQQWJSc0V5UC9WUk91?=
 =?utf-8?B?N1U5WVJlbW1wOHdiSGxpOUhUZHQ5RDZCY2VBUWZkK3BxVTFRbXkzS0kyVTIz?=
 =?utf-8?B?TzN5d3FTZ0h0NnJnQVUwSXhLQ0RMT1NDY2lsWjNsWGlML01EM0E0bnQ4aFZj?=
 =?utf-8?B?MVVGVXRRY1N5NGlTOXdMZ1lDOHNrTFFJUWVJK0l1T2MwVC94NzRvbmdXSkY5?=
 =?utf-8?B?dlovdFZmcFlTSkFQWWhVanVpcHFGb01JdUZEM1VpWUNVQ2VEUTN2ek1BVmlx?=
 =?utf-8?B?eGlkZ1JobkZpNGp6RnNzdVhuTDBCNHVnNXd1YVBVVjBzQVl6eVpjNzhWd2RP?=
 =?utf-8?B?WmZ3ZUZIWVdZMUdSa2RSZldKa2crdzd2MlJSNDQ3RVJVNHlZQ2g4RjNiZ3Vt?=
 =?utf-8?B?QWNiQWRTZUtpS21hb2tLLzNqQXo3WkNpU002YzlDbmdoa3loNE1KdEJhK3RO?=
 =?utf-8?B?WmlvN2drQndIN0FsWlNVWEUyMjdvUkFzMjcwZWJUYm1hb0s5QWYzR25JZGl6?=
 =?utf-8?B?RGgrcEJiTHk0ZVR5czBtM2NUdTBWWHNzL24yWVpOdVJLdUdUa2JxTTAwL25a?=
 =?utf-8?B?MU1wM0FITk1vYW1rWG5rMmZPMUl6eG9xOUJsUG5qOWczK01LVnNNYzZnNnNE?=
 =?utf-8?B?ME5YNi9iamt4NkdhNm03NXhsUEo4REJnYU50UWJhSnFWMHI2SGtvSUxFRjBu?=
 =?utf-8?B?ckVMT0p5a3MvRE5PTm53dXp1SGIzcEgzVW12UVIxWTJ4bFZSYjZVOTU4NjFJ?=
 =?utf-8?B?eGF3YzVhZFR5WWQrL2FjU1J1SjhqbFREUlZxendraDNDSExWYjZCNUFQakhE?=
 =?utf-8?B?bmVpcElpMm1zbmpmWlRZeFVVWGdqZWVCREpOMjVvRVlHWk9nc1EwTStkbGpG?=
 =?utf-8?B?QW1mTmtJSTB0ZElXeFdMWDNlM2R1b0piNWtNUXI4NVBWNkRBcE9BRzhQdGJ3?=
 =?utf-8?B?bS9Tc0JsYzZNdUsyY0l0SlpEVG9JVUw2Zy9qLzUxOS85NGE1QVNBdXRQelFk?=
 =?utf-8?B?Vm5FZzh6M3hLU0hNQmkrRjRWM2haV2M1OGdKQWN2V3hvN3k3dVRpUEdrZmFm?=
 =?utf-8?B?NldoZ3J6ektacVBYcC9sOVo3OWxjNW5iN3VjbSttVENzQ2ZORExqL1N0UDZi?=
 =?utf-8?B?aU1jMkRVZEhRQ0IxUlM0ckdoaElaeVNZZFI5ZTVrOXhoYnpSZVAwRFF1cVQ5?=
 =?utf-8?B?OXR4bGErd1FBR1YwcjMxZ3IwaiszcXNpcHpqcy9sSTlwZ2QvZm5DVXgrdmpH?=
 =?utf-8?B?V3dXdnVLRnRLWTE2cnlpanlaN05uVFNkdFZ5djQvbittN0NwbnNqbVJqYSts?=
 =?utf-8?B?WGFCa1lBK0QxeFpJajNaNXdWOHhyWUU3Uk1QS1hBZUZkazcyTFRDYzI3NkQx?=
 =?utf-8?B?eEwwN0N4R0JoR2pDQzlMYk5NTnUwcHRXZWlGMEIxc2lreHdzc3hXVVBaRlBx?=
 =?utf-8?B?dHB5L2haaWJOSDNEaXY2NDFETFlLbVhnVnYwQ2ZlTGZqNmFERm0vL1orY1pn?=
 =?utf-8?B?ZGtOYzIrNWt3MnpNcElDTXJuUURlVEJrUkZsdldRa2toQzM1V1NIZnY3bDBQ?=
 =?utf-8?B?WFFVUkdXTWJPQXNPNTg1cTJLdjJ5WVYvWStEcTV1RGZ6QTZEcHQyWlNEelpk?=
 =?utf-8?B?WFQrN1p6OGt4V0RkTm42VjJDcVA4N3ZaYks1QVEwMnBOalBZMTVyOXpmWGFN?=
 =?utf-8?B?KzJXTmdvc3QrZHhaSDdkbXZlOG9CRTZyWFpYMXJTZ0tGdGN4U2w4ZmhpYllR?=
 =?utf-8?B?akRwOEg3b2FHL3M2ZnRaSnBURDhiUUI0YlArVGV0TXRQS3B5Q1RES09BNjRI?=
 =?utf-8?B?Y3RGTitWa3dUUW5ZTExqdzF6QzlscXlVVCtCZG5lNmtaMGNGL2N1ZXRIM2tY?=
 =?utf-8?B?SXhrTExHOFJkWGdPRmV4VUFuMm9EZGg3S2w0K2FYKzZyb1ZmWGoxL21acFBO?=
 =?utf-8?B?U25McjZoYmVTakpJUDY4bVNJY1d5TC9yNVhYRWlVSk1JdFNGQkxKa3pEb2RS?=
 =?utf-8?B?dDlBWWYrazNCSExYTWswdE1jREF0US9KQUx5aUJDOEsvZVVTZHJmaUhXU1JN?=
 =?utf-8?B?eTJEL01PVWtCRzBScmVRTU9TTkNQdTNETDU2dlZpZjkvbktVemZVSXNFN2Rt?=
 =?utf-8?B?cGpJa3FzZFlnSXNqNUpZUUwzTExCajVIVnhsWjZPazZGZmd3eEd1V2tuUEt0?=
 =?utf-8?B?QTZQSVU0SldrZklqVlA0aHZOSWRsOFMwWkprdkFaQ2pudGF1dmtBNjBVa2xS?=
 =?utf-8?B?aG92MXh0cTdUcW9CS0dJWUZvdmxJUWdoY2dmSWQxS3Y3bHkybFlFUzVBUnc3?=
 =?utf-8?B?K2F2OHd6aTlWeUMxbnNaNWtjekxaM09KZkpmM3lBcG00K1BlL051dFk2V3hD?=
 =?utf-8?Q?u/DYAxl23AwM4fg4=3D?=
X-Exchange-RoutingPolicyChecked: sM9z4Vt8mbkJLkJvNnqownW9ehQRn8U0VkbVDWHbIyyEvesQQQb9zYOU/t30aSbPC1HoWhUFE8lEa03i+l5DEFJnvmIKV/zvawLc75ELwJImE72P7YfUW3HsqEjzbs7sDajhQflX2T5M5pBXtYJAMEuSIkHGGxwHL+ZUpN53lH5bfZvMAonXrU+5N3pmvecuT3X3aw0V3qQuzqQ9v7GujIPnW/TJBTxDfC0HIpUdfvzM2+MqD/scEbbl2G4e4E3xFcv7PGVmr8MqIqL0xkEYJRZm8FnJQy2wCCM1AHor0bYMYs2rOJ/4SotQv/s9Q6VpAmyue4XvFzFtXLoy8o7Y9Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf5190e-c470-41d6-7a98-08dea52f68f1
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:06:57.6680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEKN5z42QxCEWnjyS+F1pv4C+fkxfpBWp28c4FqTeEqjL2o43V6cQOiaqjG3iKRSFCi4Y6QYhsCmU4oM5P1EnCNj7Ae9la7VG1aEJSpyoMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0DADD6EFE
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: F29B0487339
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.osuosl.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-281906-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]

On 4/28/26 12:36, Jakub Raczynski wrote:
> There are still places in the code where manual calculation of array size
> exist, but it is good to enforce usage of single macro through the whole
> code as it makes code bit more readable.
> While at it, beautify condition surrounding it by reversing check and remove
> unnecessary casting.
> 
> Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> Reviewed-by: Dan Carpenter <error27@gmail.com>

thank you,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

(next time use "iwl-next" in the title, no need to repost just for that)

> ---
> Link to v1/v2:
> https://lore.kernel.org/kernel-janitors/20260421114029.2689961-1-j.raczynski@samsung.com/
> 
> Changes in v3:
> - Add 'Reviewed-by' from previous thread
> Changes in v2:
> - Beautify code by removing excessive parentheses
> - Reverse if condition to remove negation of whole check
> 
>   drivers/net/ethernet/intel/i40e/i40e_adminq.h | 2 +-
>   drivers/net/ethernet/intel/iavf/iavf_adminq.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> index 1be97a3a86ce..dcf3baec7b73 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> @@ -109,7 +109,7 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
>   		-EFBIG,      /* I40E_AQ_RC_EFBIG */
>   	};
>   
> -	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
> +	if (aq_rc >= ARRAY_SIZE(aq_to_posix))
>   		return -ERANGE;
>   
>   	return aq_to_posix[aq_rc];
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.h b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
> index bbf5c4b3a2ae..dd2f61172157 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_adminq.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
> @@ -113,7 +113,7 @@ static inline int iavf_aq_rc_to_posix(int aq_ret, int aq_rc)
>   	if (aq_ret == IAVF_ERR_ADMIN_QUEUE_TIMEOUT)
>   		return -EAGAIN;
>   
> -	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
> +	if (aq_rc >= ARRAY_SIZE(aq_to_posix))
>   		return -ERANGE;
>   
>   	return aq_to_posix[aq_rc];


