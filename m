Return-Path: <netdev+bounces-108288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4F791EAAF
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 00:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5011FB218C9
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 22:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E067C086;
	Mon,  1 Jul 2024 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YDC1CcKe"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D6518EAF;
	Mon,  1 Jul 2024 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719871455; cv=fail; b=Nz4vCrjsxrxoRQwocs+jBZv9yKp3r5/FifQb5bAxb7Jbu47SmQdysij93KU7jwxILNhFb5hQoNHHw87i6g/rNu9DrZ08C/cLrxiDKfVmzqKwaEgLSm2InrczfeD1GZyYWwAxHfKuF0lMsWPwO4wMyb+FJEj6mI6Kw/XSp9ZLBmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719871455; c=relaxed/simple;
	bh=A4sU8h3lwq8RY8DwiFw8Cj/+akW8UtHv1DRVrgvkJR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZjbhP/vbT2KvmM6GuzGJp/cvXxSxywUb7XLMigDqijlBW1JqMXOgQIDs1CmFQCtCPOxumLRuR/S67zGKaoLUS3eDdKPzfwkc+EteYKKyuYKAT5zxNLCHC4pqT+VvJPWJpLnhPf+UteiBbYoOvMIaYhW3eciCjiPXgGNA2rnjxRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YDC1CcKe; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dajtuEOs8/ck2r0EMzYUHxtsWjObGJitNyP2GRqJvQN03y36Etm2ySAOL5Q/tT/SjToFjqY/BjC+0aclwg7cR1u4NKEWuSXVscGLcb7Lrn2DwQQx1i5iHCmACI8bVLSJ+fM8wq1jNIsEd+PkX6Ya7jxXHfeA7x1rg14E6UWOTTtLWa65Zy9tv3dxG+kaHF5C4gVFrj4pH+ratbbji36Ukdu8o7tgmDVmibxJ1s80ws8sTCiYSGBbsO1Ph6y5/cnwrzog+xn1oIySQq7yc9fAIZF2G72irzajQPU4OQtxtyeFg1M6E0W2ddiETlysoFA+qy6MRetZ1MVNhfFND9Fhjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=as6mWyz7fdE/eIShBkYN9JIVOt2wNJ94/O21+6gRVIc=;
 b=Q55dnWEnfzTQ5J7vVdZIx2XO4VLAYuBymwWaFGMN+yBom75452c7PFeit++gejabWRY1+DWnNJDRP7Y4YuViZ99vlpMq5ZL7qQf0dzh1lcfpcQ1HmRKM4WYN2I6ffcO1/HAMLxJrFJnwvdt9mvZdCSzBlCXGOHtGB7wRDU9rw7z6++BANZXsBsxMkDvMTegYU1iVxpbwPqd8mZyxeZM+qnYxEp3d7EsCzuc5N5i/iL3sJnR8w4yzSacj2wM52WQbj7iyu74TxNoRe5F4gWanZvf5Nr2N+GOa41JgRTe2FEWIfly0+VS9Jr/tUlLfoSsjFQnRqdiG+3PzywNoNn7npQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as6mWyz7fdE/eIShBkYN9JIVOt2wNJ94/O21+6gRVIc=;
 b=YDC1CcKeDMRA1UY3SMgOCDa23lpeM8uwKU92wjFKMwE2sLk28u8Cn5KR4fpU24/t3lLe8Ey973tuDJICv9CyHpXQNC1Jxfs7Jsm/CP5GdvaZkBX5WrAc/h+H7hWewss/ZF/sE9MIJlATsYhKT15O37bZmoQW8uOukUznjNnPWkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 22:04:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 22:04:08 +0000
Date: Mon, 1 Jul 2024 18:04:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: krzk@kernel.org, conor+dt@kernel.org, davem@davemloft.net,
	devicetree@vger.kernel.org, edumazet@google.com,
	imx@lists.linux.dev, krzk+dt@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v2 1/1] dt-bindings: net: convert enetc to yaml
Message-ID: <ZoMn0Pc/agPGKeTS@lizhi-Precision-Tower-5810>
References: <20240626162307.1748759-1-Frank.Li@nxp.com>
 <20240627155547.GB3480309-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627155547.GB3480309-robh@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c66582-82cd-446e-c069-08dc9a19baff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s0xtfJfD7fUcRIFlqBlOAHpLHzMU63CaW/E+bHSxiqr+U9OtDS95sFX6U9Kk?=
 =?us-ascii?Q?/SG2NM+C4JGreEk2AIIXeHf5n+HpSg61hutrdI6J2IH3mtQZe/0U1KxvuPN/?=
 =?us-ascii?Q?fD0MR0FrgLDXW72THeevyuDeqc5Khyf7PlVjUck28yczEyyhoQl4QClobn5b?=
 =?us-ascii?Q?I5DdR8B61EyODL4MhufqronNKNmhnrzcWR/YIA5JqgUUxesNUgy7+WcQ6xL2?=
 =?us-ascii?Q?x7GsVFQzYwXxHHUSXN3oqgHs9zgsczvaI6XOBzFBMyEqKKq4EHs6tGW6NEeR?=
 =?us-ascii?Q?QyyiUXypnsvG0g4m1kspPYM6Dqrg3818QzY1eJkfL3yvhIP+MerGPUwoE/PU?=
 =?us-ascii?Q?YJaBYYjY2aDIaCUPBGaH+4CKvFAMGbVOskGG1KD52Be8FZqAsgRqSDNC+W14?=
 =?us-ascii?Q?OHXpp2PMy6CxmVEkMSpwaCBRFhG36is3ueoDoEHzT2TbKSQ+3uJilZ8Ix9oh?=
 =?us-ascii?Q?u4J25Xycn9Elda2zRc9+W8sPgJ7V2KXJX9HvEjQ8F0UJNuTl6k6BStID+6pu?=
 =?us-ascii?Q?TP7sh0mCcNyUlDV9yDeR3AOWOhTh4MYHWKr7B0fHgLJpHg8yXkBIlBx4/7+m?=
 =?us-ascii?Q?2ozGljKyhg3YfFQEA26X9iBGZxGb89HnFEG9ub+5S6HGOuKJrnqkgHJU20wS?=
 =?us-ascii?Q?sxc/ZQyHVIJeXyP8dyOdfl3bTQEYujQkpz38nRGOoc0hIWn1FDn+rD6O5s4X?=
 =?us-ascii?Q?Nb/g3g/efVyCGtGdN3h7bVFmwfRNMdhDuALaqU7HybrrjlbjtlrHxPr21orA?=
 =?us-ascii?Q?pTYucw4bXToR6KIGdzPnlN9AjQnXtEiR0vY1S7lov00qf3FKglqgEDw++5fc?=
 =?us-ascii?Q?/8Ypx+AO8jixf+NHvsAVLXHVFRCuBp86uZotWrfzk8KiE6YMh6WkWcf2xuXY?=
 =?us-ascii?Q?IsMb4LRA+yMMNiBQKFrSeovk3az9H9OyS1Nw1gbMWBly+t6HMWg9WMi29AwE?=
 =?us-ascii?Q?MQeGkk2qq/tpL/YgYJT48NXvgde+Ga1cjnVW3saukAWx9xzRMlDiON+Dn8lC?=
 =?us-ascii?Q?D6iEYSG4Cfu7RYp5Tne69/ysvwcCbQ5OQ2t8fU+5FWn3bbqWzBMYEKoTVflA?=
 =?us-ascii?Q?wRAJAnlhvKWNFEYhZih4OSs3cXDs2Mwn3kWoWP3qUgUAbM8OUankrtxu6Svv?=
 =?us-ascii?Q?8UCysbTI7mkpeMSwcHoBaxJHZeudYl5mfHzU4dQ4XA82hF3pPAjqTyC9Z89z?=
 =?us-ascii?Q?fmKYfmaVyvh0QcfijxHTGOgAMIJ5wCnTImft6PUBinAmOsePi7E6kl2XmqJT?=
 =?us-ascii?Q?2kOi1rJDreXv6FnDfYfiFFFtT9/KbZCGI1XLNi7cGuQArzndQfUbmmCD2hkk?=
 =?us-ascii?Q?B1jDKeUNHbH2wwgNIoc942Y7bIgJ90KxWiM9r/peSWDkdcyh+YQuCt8O8fSQ?=
 =?us-ascii?Q?smQ4sjI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y55HByOkRSiURcpw/iac5Clk3gc7pY4snemwk0xrgdiIyVPQvY+QkT5QQz5R?=
 =?us-ascii?Q?X+Q6dHv5XPawrQ6wE4lb/j6OnvtP2Jw+N5igwb9cDCfF0Uy7PcB3FUJlDikx?=
 =?us-ascii?Q?fhDJ7qWL94MQjz0VAhB0KYWwYXuwBIrvlVWWJLNCTVNlBtx0qI++k9I7xZN/?=
 =?us-ascii?Q?YUHm7X43xBczkxsmT1TgfGnz4Xm/5uLJmkPhUpgcBQElqQLOOOo1ywU8Y+jz?=
 =?us-ascii?Q?9IWK4O9xWu+6XT6oWxsFOV83uIN1eHgRw/iMUNq12ty91OpKgJ3ehwmFqZs/?=
 =?us-ascii?Q?hFyKWt+YZ1+MW8HHL0nvRq1RKpzbGkW286B2Tu61Xnciu4yfrGQGEA4V+w+p?=
 =?us-ascii?Q?duWJMicIP/d9FMadpVPYmiHxsJjivzMWXpmCCW/LS9QqTZpuVSaP+TMMlLPs?=
 =?us-ascii?Q?F6ytvMzQMs26qc/BiVNYYVG4BOv5V59TcN4iK7rcxIK3qG8RRgfboVKIhohF?=
 =?us-ascii?Q?su87yzZ/QxUtqQSo7QJm7txk1JzMx0koAwUyhqxDKdQOuXMhzZNuDfrmTjpD?=
 =?us-ascii?Q?S6aUTvEfxqtql+TKQfKRXsOo/w/w7xnVdiwF/KqzwhJwcO28czY9WL74UNyk?=
 =?us-ascii?Q?lAAKJ56xVJjAQ49n3PfphiLRl+hhADnNXKvFxyN57TfLpNyM9yM+xhw2ZZGU?=
 =?us-ascii?Q?PZOuyQRmu2sP75hk4c89T0x8pbjYl89riyn5ilEegS4G+K02eTZxIdMjQQ+Y?=
 =?us-ascii?Q?iy9VWfLvkc+n2xtxEsE1lqNJ4naSmg7vgf6X/kc0qHsnw79fDtMlK1nCf3OF?=
 =?us-ascii?Q?gC9RAqEywhAc2ERlYQzfmZdICh9k5ArphXAU2uDbgVPWp6feJQzlyzuHzcjr?=
 =?us-ascii?Q?pary/3Zrn7DJlmnsM2oN4lpt281O2nQNn5TCxyPmbGgYSS9JHlVFLL9Wifsk?=
 =?us-ascii?Q?JCcDqhKw2h4XHe1ErEGGhHkEKdJYLNrRQYbyN8knpx24zHDvGGtOqi7zyXKj?=
 =?us-ascii?Q?dhfkuuU1/n5nvkTfiCOe97v7U+xuQnKzkOyg8Id32jH8h9jIFjjShuO/5aM/?=
 =?us-ascii?Q?IIif8zjKEeqCONjEXvpxg/sjaFtNa+AIlanGTYCKrdwXW6fm7AaPf+FPyM7z?=
 =?us-ascii?Q?8Gmzbw4Sjxm+9hO4a41DH+LZHB96rvwcVBcDxfBw5s17FH4Xya+n+pY7ryTX?=
 =?us-ascii?Q?WYZmkBbL7C0hy1p1HwC72HEhWksOrjqIbOEA26I6DYZByE5Ma69FmfmTT9lj?=
 =?us-ascii?Q?UVzsDd2pc7lrUvVrNeSZ9/DbGI0v4ZfmgTYTyZeEFTuzOWULVE6EfzJ+1+GG?=
 =?us-ascii?Q?C5DLSgBdKw/ufia5YKzKtaZmZ4GGy+q7f8a+19hwPZl0XpRfQ4vbpE/T2dCK?=
 =?us-ascii?Q?LwL2O2B8qMIss8gYbCUFD675G4A5wcKd1qf6MJwlx1hC4NglfFqVsnMJePha?=
 =?us-ascii?Q?YdPKR2Yps1l9knM1c6ScojgaK1AykNc33j+TeORidqrJBqpwurJVUgyRVpUQ?=
 =?us-ascii?Q?Adx8GeAWxW3S6IrUBsQu3I/huxMBZMA3smJF39c2tSQG/QiAPgSfRhbGxZ7F?=
 =?us-ascii?Q?vgNrC4AP17IBiAzUoHoWnI5a/dhfwEY/1yofBzoSbdX2D7Yd2WWCnuazBQ4Y?=
 =?us-ascii?Q?I+nMTrjhoGx5/bK/Y4S0xKTZ9YkFGjPGiEl8Yuan?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c66582-82cd-446e-c069-08dc9a19baff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 22:04:08.4392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwcWOKRxQCcIa0Z1+u12QD7Lxnc4ncF9pmcp5n5ZFUJyUYXDfyvGjb8or+OKYLknhaXtpnIGyJ7kVaxNWDZZ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540

On Thu, Jun 27, 2024 at 09:55:47AM -0600, Rob Herring wrote:
> On Wed, Jun 26, 2024 at 12:23:07PM -0400, Frank Li wrote:
> > Convert enetc device binding file to yaml. Split to 3 yaml files,
> > 'fsl,enetc.yaml', 'fsl,enetc-mdio.yaml', 'fsl,enetc-ierb.yaml'.
> > 
> > Additional Changes:
> > - Add pci<vendor id>,<production id> in compatible string.
> > - Ref to common ethernet-controller.yaml and mdio.yaml.
> > - Remove fixed-link part.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v1 to v2
> > - renamee file as fsl,enetc-mdio.yaml, fsl,enetc-ierb.yaml, fsl,enetc.yaml
> > - example include pcie node
> > ---
> >  .../bindings/net/fsl,enetc-ierb.yaml          |  35 ++++++
> >  .../bindings/net/fsl,enetc-mdio.yaml          |  53 ++++++++
> >  .../devicetree/bindings/net/fsl,enetc.yaml    |  50 ++++++++
> >  .../devicetree/bindings/net/fsl-enetc.txt     | 119 ------------------
> >  4 files changed, 138 insertions(+), 119 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
> >  create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> >  create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml b/Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
> > new file mode 100644
> > index 0000000000000..ce88d7ce07a5e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
> > @@ -0,0 +1,35 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/fsl,enetc-ierb.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Integrated Endpoint Register Block
> > +
> > +description:
> > +  The fsl_enetc driver can probe on the Integrated Endpoint Register
> > +  Block, which preconfigures the FIFO limits for the ENETC ports.
> 
> Wrap at 80 chars
> 
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,ls1028a-enetc-ierb
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    ierb@1f0800000 {
> 
> unit-address doesn't match
> 
> > +        compatible = "fsl,ls1028a-enetc-ierb";
> > +        reg = <0xf0800000 0x10000>;
> > +    };
> > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> > new file mode 100644
> > index 0000000000000..60740ea56cb08
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> > @@ -0,0 +1,53 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/fsl,enetc-mdio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ENETC the central MDIO PCIe endpoint device
> > +
> > +description:
> > +  In this case, the mdio node should be defined as another PCIe
> > +  endpoint node, at the same level with the ENETC port nodes
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>.
> 
> stray '.'                         ^
> 
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - pci1957,ee01
> > +      - const: fsl,enetc-mdio
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +allOf:
> > +  - $ref: mdio.yaml
> 
> As a PCI device, also needs pci-device.yaml.

After I add pci-devices.yaml, I get
Documentation/devicetree/bindings/net/fsl,enetc.example.dtb: ethernet@0,0: False schema does not allow {'compatible': ['pci1957,e100', 'fsl,enetc'], 'reg': [[0, 0, 0, 0, 0]], 'phy-handle': [[4294967295]], 'phy-connection-type': ['sgmii'], '$nodename': ['ethernet@0,0']}

It looks like match to two schemas, then report error. If I change enetc's
compatible string to other random string. No error report.

I am not sure how to fix this. I have not seen other schema use
pci-device.yaml yet.

Frank
> 
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    pcie@1f0000000 {
> > +        compatible = "pci-host-ecam-generic";
> > +        reg = <0x01 0xf0000000 0x0 0x100000>;
> 
> Drop compatible and reg. Just need the minimum to define a PCI bus node.
> 
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +
> > +        mdio@0,3 {
> > +            compatible = "pci1957,ee01", "fsl,enetc-mdio";
> > +            reg = <0x000300 0 0 0 0>;
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            ethernet-phy@2 {
> > +                reg = <0x2>;
> > +            };
> > +        };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > new file mode 100644
> > index 0000000000000..843c27e357f2d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/fsl,enetc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ENETC ethernet
> > +
> > +description:
> > +  Depending on board design and ENETC port type (internal or
> > +  external) there are two supported link modes specified by
> > +  below device tree bindings.
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - pci1957,e100
> > +      - const: fsl,enetc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +allOf:
> > +  - $ref: ethernet-controller.yaml
> 
> As a PCI device, also needs pci-device.yaml.
> 
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    pcie@1f0000000 {
> > +        compatible = "pci-host-ecam-generic";
> > +        reg = <0x01 0xf0000000 0x0 0x100000>;
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +
> > +        ethernet@0,0 {
> > +            compatible = "pci1957,e100", "fsl,enetc";
> > +            reg = <0x000000 0 0 0 0>;
> > +            phy-handle = <&sgmii_phy0>;
> > +            phy-connection-type = "sgmii";
> > +        };
> > +    };

