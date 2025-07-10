Return-Path: <netdev+bounces-205789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CF9B002B8
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 14:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E15C17115A
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 12:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB952676C9;
	Thu, 10 Jul 2025 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="DdJSLOeC"
X-Original-To: netdev@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021143.outbound.protection.outlook.com [52.101.95.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37321E8333
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752152285; cv=fail; b=INV0H0+YdW6DSXxiEtIot+OretbGL3LswmYRtMkM8n82MNHMqKsCOZzrf2DYFF0X73JMF0hbheknT+wzA17xku7zCm/nRxAMsjn+j30Bj7YTe4CGxLjAmbHWVdEGqa8P0Qsw3BA2UK+tAGD1U/gl79kceuPQirJ9vwKePC7oeGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752152285; c=relaxed/simple;
	bh=bA3vMe4HMNXnro0Wj06Ao5QHdJJCh+XFd5OWjMcg4ho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n84lw7lLj9AyprtptVVVJzY+sWTkG8KGEymvgXNUyHgUY9LBqCgRZsMbiMokFJst4CZq+K2kmFOb/fGW81WTLMO7O78m9vafNDJp1fB9nI6zXNIEIjW02oHNjGrVI6nBh+zufZZMl09Nz8or5/+SA3HOepqp0VovUufQd5Os4h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=DdJSLOeC; arc=fail smtp.client-ip=52.101.95.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXRvohjYH29FxBIhX6i+x8PRpFvik7TwzksoORtlP1ExXtWzSqO+r+ww4Fh2qQsqhDLWEa9VQm2tHk7mAO74+BSCLhi6NLXG/8d2XHx3lklVUpf+q6r7zID1g/nCR7cEmObHi9twpr/PeeIRlLXd7NbiExRuNUxq/noBE6mbHAP+5pv1CVTzj3aVwHakpmcM5eOlI5XRiqZ0APQDVYLuIGr3OT/lf6OKhOjdFEzOnHTUiBnIKL1UMBYK62Wjnipz5QYzdPI7LoLfSsCB2bBb0j0Yo1+8ZIXy6QPoKx5PQHdt4OLjd+R2WFdEngLpGQ9H9ryYvh3W3PIad8T7n49sWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6GHvfpnti3lFXLafa6tBqoqrfAy20RwX0RdCpoGbrk=;
 b=ft4dtUGEzY+orHd7Ejux4T0+aJuHo9oUCy2z0EyDhS+3AMIxwt9XFT/0M656KDuxpydIIk+XztuOKEjhEyOA6fe1OlHDuCIPpcfbD+DP8Tku/1dL307QCBLraIp9yl0NCVw4FYGZah3xa1ivw9DS3PrIRk6iAmClQMuLNd2ZuUj0GezukNLp2fkOcv3HLxNoLijfDCzemzt2ozm924ZtRIPvLLK5iJsHEgYk3fhchqqtPoqFs/12jjnf80/yOuSkzR4GShKsUDYJ7OP5XbQTbO85rc+itHUoegSH4/VFuz96YpTZs3YoUNFg8Z9mW/vqF06MVrQssgOH8//4jdY0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6GHvfpnti3lFXLafa6tBqoqrfAy20RwX0RdCpoGbrk=;
 b=DdJSLOeCK5yA18RzKzzyRljp2cvwtFZwstSObqiObRrCCAsnCwZPTSQs0a5owG455ZUt7S6ctnkWJ6xVhefaL8gYWWHWonCXkY9K5giqZXMDey80FNdipNCxbI9E5eXvgBI6tQyy9AWdD5i+GSnQ/zOfWR6i4zSA20mXE+aZLkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB3064.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 12:57:59 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 12:57:58 +0000
Date: Thu, 10 Jul 2025 13:57:57 +0100
From: Gary Guo <gary@garyguo.net>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Aiden Yang
 <ling@moedove.com>
Subject: Re: [PATCH net 1/2] gre: Fix IPv6 multicast route creation.
Message-ID: <20250710135757.60581077@eugeo>
In-Reply-To: <027a923dcb550ad115e6d93ee8bb7d310378bd01.1752070620.git.gnault@redhat.com>
References: <cover.1752070620.git.gnault@redhat.com>
	<027a923dcb550ad115e6d93ee8bb7d310378bd01.1752070620.git.gnault@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0179.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::22) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB3064:EE_
X-MS-Office365-Filtering-Correlation-Id: a1af22c1-0270-4c57-0f29-08ddbfb16554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KwQhwcbMgseLSN75RAxa8C6tH59dEPu6hhm9Zu5lJryP5buxLYQWwVBbtoN5?=
 =?us-ascii?Q?4d9ACwGFzVkv57/THhJvVMv8vY43uiBhYMc63ZLC3rpKqES7AZoQPsK3PMwJ?=
 =?us-ascii?Q?IIEqMV4OqN7VBfsRZM2mFmOQPcQwo9iIOZyOSvf8XkjNyr1V25dJx9W/S1aW?=
 =?us-ascii?Q?u/JW1EYPUB52f850XXHSIXGwtxaITFPPK98YEInTgOLlAyE90kuvkKmvWmzZ?=
 =?us-ascii?Q?qPJDx+Lw1iYn4Zly3You3cIUoI0Trn+uaddrAjocs0f0FuypFWdKHREai9lM?=
 =?us-ascii?Q?MYn8AL2+uR5jVmKmEBHYfM59GWJ2iidpOJ7wJR/ur16n2CsNXMB4cdcEFrwc?=
 =?us-ascii?Q?h6MeQFEMSmt313U9GGVJnz/iQvu+juOHEstICBuSCfFCb0Sh7ISe9HRpNOpy?=
 =?us-ascii?Q?1EF8lRsMgsw1QYR/XqiTmg3wQaLAxyaEpad1a9xkJLoftb2kC1g0anQm1q4M?=
 =?us-ascii?Q?W5A+8SDNUy1bYRkuuD2xpAI0NAEwPdnD/1WmhTwd07Vk90wpCuABsyJF+c1+?=
 =?us-ascii?Q?7Dgw62Izg8Mc2ho4/JYcDPbBYvhI/5SetmssvhVz06nJmEZ6fg2fgTn2Y/Y9?=
 =?us-ascii?Q?uAq8nHyVCKOuBHPcaOHrZmH+zoAyGFEK4SKyJmb2D8Y6zfNEw42X/jZoVZw9?=
 =?us-ascii?Q?AfXUTaf9EGp0lt2ryIpp4fCgyXkJbxi5jV5SOgIIQUBCdi/P06pYVZEvA6mM?=
 =?us-ascii?Q?UM45o/cofYvOzMhud8Hr2VrLPe8MRKg8Kv0aUNSbHV4RPsEJ+1Ve7jceZvvo?=
 =?us-ascii?Q?ljtb+0RJw6TUSrUBiUg8Xjszv53Hlzo0hvpt58ZjqT6ypXBohOXqzRhPGVAC?=
 =?us-ascii?Q?91V6WIUG4Lp5AAgxbL9YhEScEKaRxgyY/pQbawWmaSUuZdcy8cZjd1trmtNx?=
 =?us-ascii?Q?E3ZltQyudi9eM57m/GbrYFIIHER35INZi2sj8Tk65Y01IelFI7jTrkPLpdN1?=
 =?us-ascii?Q?c5VPkQq8yIsydU7cmUSHCmqLkFcIn/OkcNC2cNSzLYagSS6vtvhd4kft8o2n?=
 =?us-ascii?Q?64KE+Dp0c3XAeEhzd/c1LEE8fWCuXzm7gNBZ3LdGL0jxMfQ5cZKhDYpF7XAy?=
 =?us-ascii?Q?xOsO8Rr5DXpGolyg0Q7fUF6yR5haPVWRnhhW3jZAmNzMwCgDU0K8jTqmmKtz?=
 =?us-ascii?Q?dFDHf5/TNhfCeBXAvpZvwZPL0QrhlOjk/Dx45Jjl1noH+1DLk4WNr0xxeHgJ?=
 =?us-ascii?Q?5+wURFrTRWRjYthy45J1+n+I1O8g92IGnm/JLJEcH3dhkDYc9MBPk9fHpak1?=
 =?us-ascii?Q?XzQzHYpwjc7dMCUly+0y8tPfjrkzZyUaSM6X4Y2QB/mPtkXscTkOPSYfog25?=
 =?us-ascii?Q?W9ySg1/fS6SsKDOpAFwAgVFPY5hh6KOMZdhL824deExp+cxZTNebxSP5mF26?=
 =?us-ascii?Q?yWavc8MXSfShgTbNuuHpzoZ3z68Q5okMvatfUILz2tUeZuOUC4/P1XKnVQfP?=
 =?us-ascii?Q?WUJ6ttdcRKE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aM/IzvjklJ25QYquWzOyL5vkoKztOEfbzfezMRnYx4rzVExMoHf86Le7OP99?=
 =?us-ascii?Q?yZBAwOhVZ+onvt+Xo9G/GMpUChT/VPNO8vSn1V4mQH2JKh8JaPEuJgNvyj+2?=
 =?us-ascii?Q?JxHCCmLCgiDYEeYXRAH7bPBjKPTPBU3i2mwEZkUIkLTdS4DitgYGbFil63qV?=
 =?us-ascii?Q?EnfY1hROvKHDIBBvQ4wrYzWR95tZJwhtft6tvA8P1w4UR14dB6S4M1+9qHOI?=
 =?us-ascii?Q?bSVulQTwdCyG33pbjgPGDsrbjWLz5AbljAQM37tfSnEILkjKVBv72UeuTOUA?=
 =?us-ascii?Q?wyKog1gE6+TZxH8X4ERw04IHP2kAjWJhymXhynydMYBrUwJRMBLAZRZOQ6ZD?=
 =?us-ascii?Q?MWfs5MavUV/aRjHp/ryAAwsmf7+i4O1+696Q4p6+MksH1dBkwMO7HQJJLAjC?=
 =?us-ascii?Q?V7WCq5TAzwMBvgb5EttUn5Socdyyjzmk49kDUPqpXTWFQofGOoK455wJ5nxC?=
 =?us-ascii?Q?VzS7ZeYNK+ZdCOwgwB8hY0ut3V+rTphUchH8U2T/cl3kGhmm9LhWuSC1DmYX?=
 =?us-ascii?Q?pHbQ6klEDTv7FFBO2v0i9RuDHPUgzgKkD0Uc5ZugQkrqyB1MPoUVSIlqTyTe?=
 =?us-ascii?Q?ZPFp+dpwsjxDcLq2yo3Tdt69TDoEgrWVtKzsgA1d+Q8n6IMxaK4jtukMGVFg?=
 =?us-ascii?Q?dLc5/yD3Kdm4KSG0ErZtWMXYdcjGlRRvI/jeXhk5f4ni/35c8W1fnI8Y87XC?=
 =?us-ascii?Q?fbLaHUR19gwRM8jjl5rjtkGmbQy/hlqYiTzURkHm4yLOW8/ly5jpvk+4wAGQ?=
 =?us-ascii?Q?EsBANTnUeDdene9GIROM9X8LpkQKzjcq9ItmQol2TlYgU+IELdNMPXfXgwy3?=
 =?us-ascii?Q?NsNJ52Vl0Nmoewj16NGHQJCChyAU+e57EZskeojV7aoJ71srRrsbFbTtu2Us?=
 =?us-ascii?Q?KmA+Th/ohv5qiYVrE0IYlH7ICmMX1tn3ucI3jWcaKZxovyvxb4YqRSeltH4B?=
 =?us-ascii?Q?yOo9VLHneEP/krZZKY9uT2C029acZ9asWxJnMeCA8SGSINGNOAAHJ7cD4/EM?=
 =?us-ascii?Q?J1aZE3aVKA66OTqS9jTas3YrwezVEQ9H8R7tqegcCVkBc/AglRHjX+/L7STp?=
 =?us-ascii?Q?pksopQqHpfpwCUFzLMyti9Q0AJMMrNBoAbWf/UKXekFwxE9ysCrj9uu7uBz4?=
 =?us-ascii?Q?XgsNWeec5hEagVt9DK7xc+DPTjNY6FAJMdiTBDHRwisYY6HQoxdRZhSU1Saa?=
 =?us-ascii?Q?pgyhWmEC8Y6T0AwTiv6xeubyrQ60XjEhp8SpeW1rvUqcxJ5S6IUAQ7Xs9lSI?=
 =?us-ascii?Q?tKeFe+01zvTSoNw2oJp9C1l3iKX9I/6Etdu1U6oA+4CDVLm+bfAVBlH89rn8?=
 =?us-ascii?Q?yyhkKcfpdCCAQf1fVtqcN6K4CpYA8YxmR4Xz2XaZIuVi3OnijmKZSmTQ2DFV?=
 =?us-ascii?Q?PUO/OPURt+grRloqFQsJylwj5lVSZV6gqYBUb0Unz7n462Ve6G/wEY7dAAGK?=
 =?us-ascii?Q?ZdxtH2o7AwsUyGnmwQq5ppc1m9p7m6WR7F0n3iqxXi5PoYlCa5M+jBoS0xe8?=
 =?us-ascii?Q?pS+NM6G0ITQl3N0mfnARwWN5vE4hU27/g9OkuULZbt16+afEJUQQC220mpnT?=
 =?us-ascii?Q?/wDw1VGqPTBl17j1kEoQVoaL20bPBUXdpbGi/fnt?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a1af22c1-0270-4c57-0f29-08ddbfb16554
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 12:57:58.8272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VS4/L+PraDVMID/cBRDV0Lza2hY7D8wuYiulf9uvvkMqL8DsE+mXb20/AQI+QHJWwlX+AObwYa5rlXkJovqVkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3064

On Wed, 9 Jul 2025 16:30:10 +0200
Guillaume Nault <gnault@redhat.com> wrote:

> Use addrconf_add_dev() instead of ipv6_find_idev() in
> addrconf_gre_config() so that we don't just get the inet6_dev, but also
> install the default ff00::/8 multicast route.
> 
> Before commit 3e6a0243ff00 ("gre: Fix again IPv6 link-local address
> generation."), the multicast route was created at the end of the
> function by addrconf_add_mroute(). But this code path is now only taken
> in one particular case (gre devices not bound to a local IP address and
> in EUI64 mode). For all other cases, the function exits early and
> addrconf_add_mroute() is not called anymore.
> 
> Using addrconf_add_dev() instead of ipv6_find_idev() in
> addrconf_gre_config(), fixes the problem as it will create the default
> multicast route for all gre devices. This also brings
> addrconf_gre_config() a bit closer to the normal netdevice IPv6
> configuration code (addrconf_dev_config()).
> 
> Fixes: 3e6a0243ff00 ("gre: Fix again IPv6 link-local address generation.")
> Reported-by: Aiden Yang <ling@moedove.com>
> Closes: https://lore.kernel.org/netdev/CANR=AhRM7YHHXVxJ4DmrTNMeuEOY87K2mLmo9KMed1JMr20p6g@mail.gmail.com/
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Tested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

You probably also want to

Cc: stable@vger.kernel.org

so this gets picked up by the stable team after it's merged.

Best,
Gary

