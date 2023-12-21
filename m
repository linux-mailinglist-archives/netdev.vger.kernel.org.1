Return-Path: <netdev+bounces-59687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BE981BC70
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 17:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81EFB21001
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 16:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA2663514;
	Thu, 21 Dec 2023 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C8glIE8E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64D58237
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMJbyyoHdrL4gFHDoBE40JQWi7M+RHE0A3MewUws+pKjdBNOb4wkqBvAE1UVwMvz6bMo/G4F9PiTmj9a9Rg625a6zlY5BqpdR1H+p/iqWHBrTxqvP0X3fVwGoYFC/RsJ/P0iPtCoMXpLUIBT3r14WJT5ZoH4k4nyQthddma2cfLTusCu6PKMG0iqvryoa1SpmNA2Hqu1gDRE4loR67WNmn2/oukBRiHZcpCfFE/8BYN90+ryGENxWhHsUIEwLA56Od1Zusr8MgDUgHRrU5bQm02Yc0niOvTSPNRcaCI7pLFk0RIQSMolhmfLYlarjKNh+7LK27f0wWjCAGEN2FGlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j96YuFyhNhFErZtiu9bLXAG48V2JlY058cR9AlTRTyU=;
 b=VbqFcI3UlkpmyY4Dxt3B+xy6pbhg7O7X7ok43v9s6VmwAM8h+pc96TRl37+bntFDXJItQClJ3BnpK4SDOb7lSY4Oqxc7bbxP8Fbt5UED/x4YatsGlKrL18ebSOJ5JnYN+K/Ln0dWP0HS4djySnoPDHSIsqONHvI+yAHF1q0prQqTHzuFbgC6/CnR682F7q5ZZIkOBx9Di9Vd1rpYk/QoYVq8wNZDM9MaRfCS/UEr8VG4Jju+f9EC/lok0Zn6NGJb4HrxMq/8wnXZL8gkJ+lzr5Sh5dZO9BpDHIOU5QvFfpM9JkGOujsErHFaWof4araPsJD0f/24w7k646yRURK5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j96YuFyhNhFErZtiu9bLXAG48V2JlY058cR9AlTRTyU=;
 b=C8glIE8E7IJuOdeIZvGM+l6Byvint6eZocZSUGYZt6n4DXM5B/IX6851uQko1vbrUO3vYnvv5nvXQ9w/ae7hDaPzApVQ56S0P5idJkkEFbnnruyq+yDzG7717MN8Klx6VFRBYN0NoFTb0sYPDlZbbY26U3NWsfJl7FBe9567RZ9DdBidCerV6PBEbgkg2tvmdX1MKWRDZsFihXMM4VxlXNGU2z4kkK3YjPI+hnXzQOK+dXOoojQmj3NhVzMunVWkPplx27dOsJY6tFK19yXmYFQcOG7WsZPezfdpMDNrxzd5iHCCVWsiveidtYvYbFrFgLSMO3fEmNh09OQaxqtgFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 16:54:51 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 16:54:50 +0000
Date: Thu, 21 Dec 2023 11:54:49 -0500
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: Re: [PATCH iproute2-next 01/20] bridge: vni: Accept 'del' command
Message-ID: <ZYRt2VCTVnGxI_1j@d3>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
 <20231211140732.11475-2-bpoirier@nvidia.com>
 <20231220195708.2f69e265@hermes.local>
 <20231221080624.35b03477@hermes.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221080624.35b03477@hermes.local>
X-ClientProxiedBy: YQBPR0101CA0279.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::10) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b895d40-6b2f-4c76-ff0f-08dc02458c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5TJVq1K/TZizNlmriW+74maH9EGwIZRIVLJ4evChI6COwAwrlvzGQ+WBXdUdgFjlzd1+YMIKj7pm5Rz5gevy7p3HgqYyVyL51C0jKJbZtjx38eAVUosWEyxs1F1MWr193Igm3RaPZiK1ngxinYYLptzSGm9W+Lq3OaKiJ7wFVGSe9vT4J7Rh1YZ/O2dOl2EQBpenq3scidy/OtfhZEgqdMZ75xt440VTzONTcXkAXFEyW681JaPx6yqtc3TxwB9iYG3OuD+16lt8LS0idwJVLuK6RXD+sbfoFOLrEjYuyUNxIDLNyJcy9EanOJQjrEnmPxNQFlgBYlAvaXgNVu273lrTStEW1Z6XPuyUKOoylwtC5ojMeY0Fg+ClkwNuEmA4AsP+I2VjJ4oDVwwIh4sG277CYzxYMc6yQIuvZX6SpDyUnsGI/hOJmlfGUkpAb6fiI1e2ahkd8UweR8gqw/GJ3MXwoY/WWJoACXDH9ancs/Yd6x7d3OD8112ku1UG22d75c3gq/MuKBR4Go7U76TTFPsDNGMj2L4v+JlzoRkzJ+rmW8crPxRDErJKo2eHupIu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6916009)(66556008)(6486002)(66946007)(9686003)(6506007)(6512007)(66476007)(53546011)(478600001)(107886003)(83380400001)(26005)(2906002)(4001150100001)(5660300002)(54906003)(8936002)(8676002)(316002)(4326008)(86362001)(38100700002)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GucTVzQEZY1GURyPmjTDswPDF7XOHk7e8TIZ8cVBvBZR3Ktw9WqjDDaP9CV5?=
 =?us-ascii?Q?lTT2SwPa3UtYKt//nd3osZszgguOYI0rIJBcl4OjgAICCHkCnSYJkbT/Ki21?=
 =?us-ascii?Q?0pR2j6vWCsRqqGyWyb6NOFvLZOZfSXuNBTbNLj6erZ9XLu2yLBUu0G6uzaL7?=
 =?us-ascii?Q?giZLb3977HT5pnxBVsfKZ4TyS1o2EzZa5r5iJ59A3k40VmKQdi1/R7l0CHkD?=
 =?us-ascii?Q?7ely/vQ3elI3nPgoGImUbQddrxuDOzoXHmmVPbjD5qQT3nFSd4duLnM5PQaO?=
 =?us-ascii?Q?PhoiaUggg0AQdyaQkHktlP2+wAxtqVnKNH5F9lW6SfZjN+iTAubFAz1y7ivj?=
 =?us-ascii?Q?3JySlyQX+OYVr7E1OjzSmxJjTNL14oa8ZAw9VVlV8AN8IhAB+2T+lbwyFamQ?=
 =?us-ascii?Q?yVMnj8cUdH2tXOhxj4QrSXlQ/uNjExusKsa7Ore7gOXMOKVEeNC7i8d1wkMj?=
 =?us-ascii?Q?tGLUrJoGIBcf0LKzImUgC9ZA+4fu5LtisVZs5cphL2HmOEIy34dIyOBrKewH?=
 =?us-ascii?Q?rRFGJ3tHDkw4wZSVU1qjU6WiLHgy0547PMqiwf253Dfx6vq7uf6GUWGXEw7V?=
 =?us-ascii?Q?sgHliMnJh7b3YRgEi3W2dKYEWX8syzeN03+MlwlvT1Cf6ugPZmeEbPuli69v?=
 =?us-ascii?Q?hT23FzvJQ2tRCpxZoa772CWZcaIAXbqxz0/qtkAInp6p8KEh9BO3qk32LNyA?=
 =?us-ascii?Q?os+ACzm6kSHUDAMgxs1MCA+5wnj8sNEvOJjzYK5LA6LIXBdBfOCEANFS3/Rr?=
 =?us-ascii?Q?9jPTwhKBZwadDpZoG6LJ2b1Nxn9i6miGLSP/9NWsS5tlhy2qckpX16mDk7+Y?=
 =?us-ascii?Q?U3Q1yZTeDf3z6DoqD9Wft+z0geLgB6mkeTkToQn7iCBcBI1Jcc736t4MbO9B?=
 =?us-ascii?Q?56AG53G/17tp3iASYth/DD+Tvd8XlsLIzwPvTxcQT84ZDsESZdWKCvqOyuvY?=
 =?us-ascii?Q?zj5j0JmcnfT8138IdA91AjF987LIGBb6wQ6wRgQjAKK9jTtcycOfUdc9a4M3?=
 =?us-ascii?Q?pTEiWOt/g1ZoNiRhS9qXIyzxp7L1N31jONMiAf4Gip9dT0rElpF9KbLP8WVC?=
 =?us-ascii?Q?zeUxCGQRdRm88SVaOZfPBQMpiUnI2BIVBOy3DBPVxwI4fSwozHXt18S053K6?=
 =?us-ascii?Q?zlm9cQIosym2vzZfOy0SsX/U+KjVJVagNsyFd+Cxc0nvwYtAmX0KP1wSNV8r?=
 =?us-ascii?Q?iAgd5CxskOji1Tvnb3/qnfYspdCXKCv+5zUohf4qT5ZVU/yPlDNrL8eRa3nb?=
 =?us-ascii?Q?9+TFsl3lljEQnGobWkjfIX6JAPPV8mgE0KdZ8R1lK5ONXAiagUze/FZIKSvP?=
 =?us-ascii?Q?TQAv0KsaYkxWlzR57DUSNeUjbEc8DxQBbuxKaqL/EZymOrdA76mJ0ivV8xGh?=
 =?us-ascii?Q?AKKbxc7YyDbJQqr7LlSF8fsiIpIv5CIQFIOrdKe3VjsC3adew5Hf/OwXvZjx?=
 =?us-ascii?Q?PZVh+rOi5PU5rQ9NlDH9CWJHNrOVfjQF/Hj5DiQpWEdGoEfSA089tbEEAI+2?=
 =?us-ascii?Q?uQ/BQkWEIN3REmQ2VNwZKhOTK77atFygxk5aFVib/AJvvfnK4QxN6AkBD8PS?=
 =?us-ascii?Q?LGPA6XaeYpu53x7TPhdVPGWH4Hz+dmrKyYiw8NjH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b895d40-6b2f-4c76-ff0f-08dc02458c2d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 16:54:50.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dT6y/pD8mRuvaStmx1SmcdjBhZJ9ibx5NRlJIcznjVQ3wu1DodN01cU51qie1GcfNtoV6cobTXTUlsQ6TTEimA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868

On 2023-12-21 08:06 -0800, Stephen Hemminger wrote:
> On Wed, 20 Dec 2023 19:57:08 -0800
> Stephen Hemminger <stephen@networkplumber.org> wrote:
> 
> > On Mon, 11 Dec 2023 09:07:13 -0500
> > Benjamin Poirier <bpoirier@nvidia.com> wrote:
> > 
> > > `bridge vni help` shows "bridge vni { add | del } ..." but currently
> > > `bridge vni del ...` errors out unexpectedly:
> > > 	# bridge vni del
> > > 	Command "del" is unknown, try "bridge vni help".
> > > 
> > > Recognize 'del' as a synonym of the original 'delete' command.
> > > 
> > > Fixes: 45cd32f9f7d5 ("bridge: vxlan device vnifilter support")
> > > Reviewed-by: Petr Machata <petrm@nvidia.com>
> > > Tested-by: Petr Machata <petrm@nvidia.com>
> > > Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>  
> > 
> > Please no.
> > We are blocking uses of matches() and now other commands will want more synonyms
> > Instead fix the help and doc.
> 
> I changed my mind. This is fine. The commands in iproute2 are inconsistent (no surprise)
> and plenty of places take del (and not delete??)

Indeed. Thank you for the update. In that case, can you take the series
as-is or should I still reduce the overall patch count and resubmit?

