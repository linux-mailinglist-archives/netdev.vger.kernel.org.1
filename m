Return-Path: <netdev+bounces-96109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C22C8C45E0
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B58D4B238E7
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC2B208D4;
	Mon, 13 May 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="riSzfD9p"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2036.outbound.protection.outlook.com [40.92.59.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC7C200C3;
	Mon, 13 May 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620790; cv=fail; b=u7GaVD9iFTmbpfHIa/F6bkRZldcpLEtU3AXkhrEQZPAJDXDEH87fXBNsRe/5hqfmOzsZZhc24PTDnGfXNjClWi1JQCWdYdzR9LUxlJtyxrxFVNh7Wll3ijPQbA0WNnz72B5ul9AWEy9X9tcQS5izKceWNxpBH9BqVsLvDpsmWJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620790; c=relaxed/simple;
	bh=ZgbVEL+vsrij1DSMczoVQ4FTy6aeHqktaS/azvnWwH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j19Uoak8iC6vcetiKogS24gPBF7hKOnDr2mP5QJQzejmrkxWdpz4XcfPeFcMilkFDtQQXDYRcB1b4FPdg2SLZ0iEcw0n71VqHGbmRS8hGZi8pifzLrjClDVUgi4ylU0jVi1aTxArQrYQm9UjDeU7TiZL1kUNgYvweQLlOBArUrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=riSzfD9p; arc=fail smtp.client-ip=40.92.59.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFt+1Lat4suMMssH1VqYXBWs1LnsafpBCdJh+lGtt/nLsAS51aLzRi9EXR3rNNq9lyLS4NvdAqjtvsEf3D8V3r0nprwuqMhLUF1Ty2Y75TnIcLsH5mUY7M64Q8APzxI958nJwCw4UwEmtZIXXIewR9fRbqxwJswmg7YeuLomjuoHDzzmDUXD3W8ENATs5TH97jfm/85srDbqAp70Hkqani4NG+EEhFAXXYb4yFz5vbXftcgbBOCSgxGtF8YvS5roLQRCC2sM1Dw14ie578NZRhWtFBauuUFH6JOC27A37KEdgMUOpRAv1e+ZU2nfK737zH+WPOuVMI29vX4XXLAwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBSFxt6DKoMUnf98J40iCQppC4H0Qk+LIoOpb0XIiz0=;
 b=F54SvvN8rWTzX53tMD99ZDK7IiHgr1KrMuYHoyH0/k+oKHPjDSmG0Ija30i/VVl9BJQIcPEyCXArqijRWlkhNyFY+Viyq9nlFg7s0DPUkNw6sqeOkLzET0v+oVQ1KsayvL2g1XE7aovzaLEUHrQaeaFafV+XfVZNKzT+8PnIlIEjcQ9WjgNXDquRhUIJi3ry9VhC18gpwUa1E59ELgaPHcBwT1uAeTF8GRgckUtPObco2hDN+4Hc4XSZRILVUEAGbZ0Q/HZA/8DtnS9rpkXtUDhA73mJfJqZipHTuAr8+CNx4Ra5h6u63Re6yVmDKUaKtbJRM0ADgFT4lpV+2iIIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBSFxt6DKoMUnf98J40iCQppC4H0Qk+LIoOpb0XIiz0=;
 b=riSzfD9pVKCDZZjIHm53Ob/zplpuhSpLep1HXRpZmTUdkqMRJAINwv/mkqNh7DVCt61VxZJj80kqUF4Rs4NjaHHCNhnU+WlRjWKn1WhlUF9pfzJUkLbc/IqnoOz5iGGKBGj3tNvUfWXtS16aInuFnwzsZWNUbQBuFQ+LF7cKA8G5S6UZgMmClHmrHFmuRA9Jl26VgKCDTA57iPov1eXCAukEVKWKbBNInZv+tbW5XMKd2Sik+pD9arg8ERUoNFKdGBB6wN1Jr/L5uVWZEQbMilNy4LZJWSFWI5bzScHWMLPKJooIHlgcn37opiky9FZbQQi9SPc6sn+P0sQwPaVm4Q==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DB9PR02MB9780.eurprd02.prod.outlook.com (2603:10a6:10:451::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 17:19:46 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 17:19:45 +0000
Date: Mon, 13 May 2024 19:19:43 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Kees Cook <keescook@chromium.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S.  Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] Bluetooth: hci_core: Prefer struct_size over open coded
 arithmetic
Message-ID:
 <AS8PR02MB7237C71997007C058A51233E8BE22@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB7237ECD397BDB7F529ADC7468BE12@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202405122008.8A333C2@keescook>
 <CABBYNZJcg5SpO_pew6ZwN98n1sR7kNZs6VtkFToyOs9NM1bO8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJcg5SpO_pew6ZwN98n1sR7kNZs6VtkFToyOs9NM1bO8Q@mail.gmail.com>
X-TMN: [zlDpCEdadwWhEMJF58mS9nRALgBSH1at]
X-ClientProxiedBy: MA4P292CA0011.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::17) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240513171943.GB7952@titan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DB9PR02MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f48050f-e8e3-472c-9d0b-08dc7370e2b5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	SBurZOrSjFH12RoEYCRK9S411xTtk5NwudYUPHN8oFKYCfZO8w2fUypa2DRI2bWLo2CJlF/Q4BUbXUR9q2C719O9JS9KPMIwwS6c8sErg//4zaULw+2MYVNA8GE2SWDPqO3FUURKgstqLEOBSsYm1Toyc0IBBAWwKlnKLIyUWAs/GSVtkeJ+pXYkQQkNm0sn4nxgCk1nbT/c/O71qLhx4UJGqCNYZo6Hyo7VSf+eI/sO5+ALF/aCGBXL1WkFavyyFVqlT6BQ9BWtSkxMCQCMqRngC9d3Qvw6xXAa3jeqvcXc39v88/6xsLo8AnfkLIMdZgmvqRj/yJaOMTIOfqTQu8b4JrDh3lmdkUUCq7k4DQGEKONOnggx2+iLAvW0dBe0/VDG3zx7zBwEJ36RRCTdXeDddf6tbaY4DYWqwT/Ro9PV1/nqr8iugGi7Pp5vnHrfQC8JcqOMPvjk/tpdZhEf9y0BjYYaKt3U+hUCoojeb8bbzHQovcXQPwQDrV7KdBmUQeATLoWwn3Yizcx8+z3mddV6DIhDdr2nLpQKDA5CGXY6Tm7fJtcB1OWaraU/iupqPGHUg4d1bK2HxFiXaKiFsx9269NY6lVUW/SrK+fS0qAbZRIiUHOqjyx6bMMQUmgF
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1ExcWNqUG1DUkthLzZPRiszeVlCVHBYajArL09ZUk5xeVNyTDFmdmJCdUtp?=
 =?utf-8?B?U3Q3WTNyVHlIaVdyeFhCcElLdkRDUGRPb04xOTRwQ2dNVWlOQ3N4am5jYjI2?=
 =?utf-8?B?WXh0L3kza0FjQVo0TlRmY2xpU1YweGNvdU9hM2pQTlBVZHZTaTNMUWZCRHdq?=
 =?utf-8?B?Wjg4MTBPblVZbFp6THdmOWxiVWF2dTEyUmsvcnZMdmlyaS9OOXF4bkNuUEsw?=
 =?utf-8?B?VlZUYkYwY1orWTRFRUJqRlpROHp2M3d6dkNRSzhvTjFKWVF2dkFFTjliZ3JC?=
 =?utf-8?B?RnNZMnErdVVCaGt5b2hvazdZd08yd1IvdUFNZjJSMnVjUElBSU5hcGo2dnVW?=
 =?utf-8?B?Q3lxSDlBSXpBRVJDNjFzTkFvQVVnMHFzSFVhZ0hxQW9NNlVxMmFSWi84Zm9I?=
 =?utf-8?B?dnJ2cStNN2Y3R2FReUxzWjZSOUhZR0NGTXJReDF3NlhBZ3lXbFpGQnVuQ0ZC?=
 =?utf-8?B?ZnY1L3JmWHZjOFgvN3o2RVZLQjg1QTFrT2pMMHZCcXJmc1hqNXdDelFDVmlk?=
 =?utf-8?B?RlcyUnR4VjYyMGpOOEVXcEVjZ3RQK2dtamZWVzUwNUptVk1XdURVLzRPUENL?=
 =?utf-8?B?UEExMEk4V1g2NWdjVkdRUXdtYThlN0NIcUhaQldBQXg3TFptbGEwZ1lIVGt4?=
 =?utf-8?B?dzdaSjBseFUxOE1HcXBqQitUdUExZlhuZzA3aUc4elBDZFY1dWZmbzhwWlZL?=
 =?utf-8?B?eUZwWERrQ0c5ekdWQ1FZYm00aTNUZndSM0hGVkxVQlVQMFA1RE5jZWRUSWww?=
 =?utf-8?B?Q2xCRHBPZ0NJdGF0MXRDTnZWRCtKVDg3cmpwSUxyaE8xbkJSNjY4OW1jVzE0?=
 =?utf-8?B?ZjFRamc1WkxJWTJhMUFpQXZQdGJTbmhiN2RjS2xjVVFYTE52SjEzZzBwbEZE?=
 =?utf-8?B?Zlo1K0RkaDFXT0djVjFTVHJBbDd1ZjUzam1odkJBdWxhaGE2VFNmbmtuQlE2?=
 =?utf-8?B?d0d5alVaeGxUVFVvWExyVm9KUEZWYVRtWHZ4Mk53QzQ3alVCbXJDNVJ3TUxw?=
 =?utf-8?B?aW0wOERrclhEZmZnZy9FeGNvUUNObWZYQlhKUHpCbkxQSDFCYThIeU9Wd0Rv?=
 =?utf-8?B?bW4yWGtpZ2pnL2FZeXNhekw5Wi9HdHhIMWNFRThOMWxaOWZ6VVFWVlBobXN3?=
 =?utf-8?B?RVVhTGtueDVkMDZFNUF3b3NBM2ZWTEU2ZzdsWW5Ub1lZYU1YTmd3dDNtVWlB?=
 =?utf-8?B?SEovWGVpK0cwWTBzeHRpdkNpMFIyRy9KM0xnVXBpaWNpOTZrVTB4dTVXL094?=
 =?utf-8?B?WS9YMHFJU0VpYld0YldHUjJyL1c2MXNwRFl3UzdISjdQRGZoaG5XZm9HK0VG?=
 =?utf-8?B?VFZheCs5Ums2UzMzRXZKS1JMVkhVeXRJaU8vUzcrdHRIQUk3T29DSFRRTnph?=
 =?utf-8?B?YUx0a0RUMUwxOUtocU9maElxeURnNVloVThZOERJVUlhT3ZWRmt2QktyQ0pH?=
 =?utf-8?B?V3dVVzdZZEx1WU9oZk91WFpSeGdvTldZa0VVYTBpRHZoQVlGeEdZZTJDb1pq?=
 =?utf-8?B?eWZlYU9pdlgwdE5jK0Nsd3BGbU5qaXRmNFF2M0NaRFpEWjM4ZG5qUUFETk5h?=
 =?utf-8?B?OE1yMXZFbFd3RjRrVFU5TGFjb0NPK0RFNGVVNkFJUW5rVTRkV2VOYVhwSkFC?=
 =?utf-8?B?NVlYQkF4dU5qSTdld2V5b3lqMXVzUVJFbHE1UXc1ZzYvUE9EdlF5cUdZaFlh?=
 =?utf-8?Q?ZNuEid4kfyTmHiV9xheF?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f48050f-e8e3-472c-9d0b-08dc7370e2b5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 17:19:45.8113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9780

Hi Kees and Luiz,
First of all, thanks for the reviews.

On Mon, May 13, 2024 at 12:31:29PM -0400, Luiz Augusto von Dentz wrote:
> Hi Eric,
> 
> On Sun, May 12, 2024 at 11:08 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Sun, May 12, 2024 at 04:17:06PM +0200, Erick Archer wrote:
> > > [...]
> > > Also remove the "size" variable as it is no longer needed and refactor
> > > the list_for_each_entry() loop to use dr[n] instead of (dr + n).
> 
> Have the change above split on its own patch.

Ok, no problem. I will send a new version.

Regards,
Erick


