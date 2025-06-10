Return-Path: <netdev+bounces-196206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA5AAD3D77
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6691BA50B2
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084DC2376EF;
	Tue, 10 Jun 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N7dOYFNI"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55E23534D;
	Tue, 10 Jun 2025 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749569369; cv=fail; b=DVUNXdKRm4ZnQHNRGN//VQDSmDqd0yVJhB5Aph5aObcz60HcIkR4DQ3PlNfU+hy98sggCLlLlofyhK+r9mClZAxRu81fX+QcgEPQBI56N5qbEyA3eKlLW126qGziuKvaQiraKAAGQALsH3a7sD+uCjPZRHofgJtpBuM5/dflHek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749569369; c=relaxed/simple;
	bh=7Zu8La72STGPfTTRXRR+1r4QRphTw7t7NJr4a/1X1OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aIx3wD9YzcbDuLApBgvO+r+rODb719u3liaFJDmqKCo+vwFdByx5jkzEd5FSIRtOu6aY91Mp+G795p4wIhOhSz148dDmERR0XQRSTpaxTFllpPIFi5pyhbRnW2XypKED4xlZT2yIWgKULWxQilZVzBi9f8jIW4HyBp6YOJSP/4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N7dOYFNI; arc=fail smtp.client-ip=52.101.65.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzUQA7leHLsM9VTMFOvhFao2nCI5nN+Wew3WryUBwfkSxu9fqm5zULmSADnZANOfpID+Yk0GZvn3aHNBoEvoR1u1KD2J5/UGtWqrlXVHAWGFBPGljiGGUO2hOtKczq8yVhu93cdCsi+rtOd42HgtwYGCOyPzqnyLsLCN7yIZBaHDm7ymU5SCyc+slXZLxdf7w1ss9mNrUEDn0/fPfwHm3CptvcRpI6Lg5BIU+A22/RSts8xvY7rjkxegG7vXiVv48gRQ8ghZsyMd3ouYepkr++2SczjVmrb9N3jw8teX3yV5ERXRy4NOJjDUULTuzmLHgIut27GXa+5GxguOR+10Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59j9TGg9/SatssdZ5gABQ6PAZoOoHLM8CEiHb7RsCIg=;
 b=cliY061+5eHVLmRO6lalHe6rbrCGx/QforeiCdp3u+pki27sgEmWj3nDc4BK3TtQNZ5uiB+Ih94fk/T6BqqAQP2sWuUdVQhedyW+Q3ge0EZRQIANs+sPpiQoWK0C57wjFCACW9rYpEpV098RHhtIBH/KiVvGAW0+Ek2ds0Mv2pskFFhvINjQD78XjM7CioslxfvhosH5Yz2NXnksoHjzTjHtlWUuT00HYWVS3fzX/3zkIdTfi+JNrvZ0LcEiZrWibr55UyENb1UjJ5pisipAoBuURfojSEAtkM8yelWADs3lIgdKqOJdmqFHgHPXvp3hStdrhi0OxqX8urEa36Mo+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59j9TGg9/SatssdZ5gABQ6PAZoOoHLM8CEiHb7RsCIg=;
 b=N7dOYFNIC2DbOzMyPKHqxtsMCLRXXSZ0gh7wxGp9kiKlnrXZ6+Vz4RmFujNwisQgaAk3+6Hq++69cnToaoetSTsXPj0vQB8dQ+LqiBD146mft1aiqQJ0xNA7SB/K04DZjtBrHsJZNP1HriS8RG6e6vJeNRnY05mOBE12rCfnZjmZOI1wn/7tujPo+JR3Fh63aUbPM0ZWrmSY89lQr5pYi++9bpzdwfk/VH/UxNDdb1wEAW1ALEu99YlGKXXbnPYVH/qsbd1GjdWJe2qjfJiQnSOjq4eopHyskx0PiEDFd61lvPE/1TBeeqnDn8vcGLn0D8eDY/BXIKNhU19WFKZ92g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7171.eurprd04.prod.outlook.com (2603:10a6:208:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 15:29:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 15:29:24 +0000
Date: Tue, 10 Jun 2025 11:29:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: net: convert qca,qca7000.txt yaml
 format
Message-ID: <aEhPTXHHulIP5MqG@lizhi-Precision-Tower-5810>
References: <20250606155118.1355413-1-Frank.Li@nxp.com>
 <20250610-thick-gifted-tuna-7eab4f@kuoka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-thick-gifted-tuna-7eab4f@kuoka>
X-ClientProxiedBy: PH7PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:510:339::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: b994e8ab-a21e-4f03-da2c-08dda833947d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gnFsT2f+aR1WaADNzr26gsVTTon1B0PZ9UayHCzzoc71/zv0g7ZkB2SUHQG2?=
 =?us-ascii?Q?4MbeCInU1/+ddiFvDIijGvk/KY5d0OEAx/fzDfjYopSfZ8Qw758N8iMYXvrd?=
 =?us-ascii?Q?x2sCFgvB4alXO9YR7cCf9jnKkcst/3rYsx165mwdnMQUuRI099t7SQdx3EHP?=
 =?us-ascii?Q?53fgNe0d2DTXjz0vu9710SR5mzaG2ijV1vazpz1gGKUVqBQRrxdz/AqXQSdK?=
 =?us-ascii?Q?gSB/jeUmguV0zQnhsIGobBCurg4J4WmHKwVtA+sR5MO25H2Ed/9SzP4mdSg5?=
 =?us-ascii?Q?ohhOCu5TUf/iyMpxiXNvdRuWyJMeSqbOm0fM/MsIg8/YFdDSs39yMsYuOXwK?=
 =?us-ascii?Q?OkPte2ngAj5VfSl5cTYUjIXhuL5AskqKICUt59A1l8EcPxSimV1/N2WZIZG/?=
 =?us-ascii?Q?MuREbV2SgIDqIxjJBymr0ffFww2n9VqDjW8mTXG5+RI8hMachwavvbt4Ukqh?=
 =?us-ascii?Q?TiAx6xcm3Vew9dmKLQX0AG+rB+kNtBEU1vlB/+CPt5RZd6gHdla1QBAqaR8S?=
 =?us-ascii?Q?aFc4t3sfz2PL6e6a8nM/GSa/1D0KLVUViU8hNli9I5Q42XpmLYdyOreqKu7U?=
 =?us-ascii?Q?7zUFpNbS11re624+0s6+ZYHaWQMxtZkRD6GrTye/mznZ3EAf/XNgcnebNQGO?=
 =?us-ascii?Q?S7w8lkpoHxGl6MZr1qqhgXNdpt8UWpSpzyyLGPmGrH6XtgT6vzFHSzCLqKZt?=
 =?us-ascii?Q?9UtCW18V5nOHO6grI9Dja9p3xGkaFb+L6at0G+HuO1CmQ/2ZUxGpQUeu/Eoi?=
 =?us-ascii?Q?sCB6X1nM9p26n4nD6AVjADa8d5RQSZxOa57YyZn0a438RYyWnIlWl6dYSTyn?=
 =?us-ascii?Q?5Whse4OB93s4rvWN/yqTRaMnHqnl/iMd0p/DG9Hr7bAiBeAgFRWd+2m4zYFV?=
 =?us-ascii?Q?kIby+unOlx4aY9aNVq1VsRZEqfvUMzpoHIDvGeXP+z2Mp8w66jVJHBzhyC7t?=
 =?us-ascii?Q?YXIUJKvscJFoTzfW1cAPOZWeU/+5l92/DtfWsX6OOWhVvE9aV6rB0IRYJLhh?=
 =?us-ascii?Q?0id6hZAlEgc1TLwwneaclqgjYHUNIQCP5lbzfMMiVwzkWQpAb3X0IkrGSxVQ?=
 =?us-ascii?Q?GtJkztr5j11s/nTIq77xqtgJN5k64xO2UxlTwy3pfEm0WuyE55X4ZGni2yvC?=
 =?us-ascii?Q?sl6tX9GQ+/NZXdQyl/pmIUS7Mba617joiiNTcbyRuLgKLp7O7xk3u1pP5Mv4?=
 =?us-ascii?Q?Oiw4N0GskjiEYVaSRgBJzFcA4w8gMmJAeUXFB2d3Aw8Uk4HiTjWxuWm3bp+X?=
 =?us-ascii?Q?Rq48/RAAsbvU3r1YzuOJ0F40G8repbrXpa3pRO4Z+ktt0a1XicZ8SDd9xb9f?=
 =?us-ascii?Q?gArQXGNZQQ18zXbzJeWZqZECe2+nBzAvauIIAKqaZpe6Ex6zgMuUbBGefi+X?=
 =?us-ascii?Q?BjDhxP0l3IyA6pIythyJHk/QWBrSb9GOTj4TPce3Q+YDq/Dy0htj2cMNtiAH?=
 =?us-ascii?Q?yBLzgfrifAthbu8XPvRrJ9XfCv5geHR7a79krTeqSZXZlnmJjnvc2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4d357FD7DY8EhnXK2+tencXzLniGBZtjmw5BPpgP11NaIYARASXfNDqHlSk4?=
 =?us-ascii?Q?+CLu3dOJK0qJ2VnpXUh6GCke31xRLeBldcCaK1bf7cUtwwaoc+UnSxRMbPr+?=
 =?us-ascii?Q?bzy9Wpkcc/cZf0NFOEjETV9bJIu8SB8ulcWMCa0QlWRC1JOYeWqjfM4D9Jbx?=
 =?us-ascii?Q?Q5BL7paMEpVSJtoXM749Ham3/6vaWWxcHlPx/ARbIBsWR28akHNPzdTgf5TR?=
 =?us-ascii?Q?MlSHniAySHAaqV37qgLgSRmtHxbjGZ7ls4CcWHfPKS0rQz2TG1beibrQ6XAw?=
 =?us-ascii?Q?DpPGaK9bzjLEIqu9Y3LNRdnjBVrIn4lf7A8ut9RiwDTF0dN/rPIxko8wzpvZ?=
 =?us-ascii?Q?Dekgbl36ZJOm4qrMq8Hdx382F3IW1mBX49VyyRf5j84+dmqwryp+jDl9Ln3I?=
 =?us-ascii?Q?X5GhPvkovqfBkil48wYG/2c4Bf28dSkS4lQT9IgBdJhpx8oN2RpBtG2gq9WI?=
 =?us-ascii?Q?AGKzw78SZKEsLBNDL3f68iOJKi/0WiSTbzrCz38ltrjWIjHSsBuLw/m61LEr?=
 =?us-ascii?Q?cFrhRcCgRXFVXkqBTf54DP50vD3pIGg5cCYW5LjniySqo1uPLtYeau8ynptU?=
 =?us-ascii?Q?P5f9SWorJmgKthCzfpiWBSM82i3QTu7u14l+c4udXRbf6D9DASGnwQlPLbci?=
 =?us-ascii?Q?/dCrpOnK6rE76a6VSrf1z+RFJA+Iuj6qCA8EnWTsJVVYAJDMZDXwTpq0pDok?=
 =?us-ascii?Q?IebdCI/ono2Z8ro4wGECYmZvMcMNjauMiUnH1Q2ErsdODKyx9OOqQsTCmilD?=
 =?us-ascii?Q?JZnIeGKvbwfOEAO0etEE30jGFjf+/YrdsfcL3uaP+cOaL47sveg+wbw/Z5/j?=
 =?us-ascii?Q?SayglTQhFOLMH7Ivm+0Fg9WJi032eesVbAtROIu0Kz2Hs7aqUuksyRy0zVgk?=
 =?us-ascii?Q?x1wwJwe5VvghNLUkAwRPYSpAtsLZGQSe/eoNlxFTTE4dEDQENbcSxWWlmMn1?=
 =?us-ascii?Q?6iiYbgRID2o+0jjlhnOf0co+oKxRoVTsbH4nLyExU6JKQY6p972VO7JCA7Vg?=
 =?us-ascii?Q?CZBarEnL1Hzr9dom/upLH+WKiBb8wF8cokQE3MrgC9tI1UUFOTIRmlWOCMMK?=
 =?us-ascii?Q?URkHMqjv65QJCg3fzF8Nso7Lc0CO3dBKfUcFrFfnDd+rrTqirf3OqF+f/2UV?=
 =?us-ascii?Q?JAzThPGgJAK8xRevT3BIqTrn+Y5Oa9lmEBsIiwkR8Hc4o6ZqWUUtJO+Dd+At?=
 =?us-ascii?Q?FiKxGd3yXbDZBvqjE6SAO0vIVPnU5R2qbCR04ADaamnhu14YuKTTG1qsiXq3?=
 =?us-ascii?Q?VtpEnivqcEuWFBxum/RFAIdpuzT4Eu1j9TdaLhzvcH4M8bvw559b1YJ+v+JO?=
 =?us-ascii?Q?SK1UMQ0UsqquP6zOt50k3nBgakYJJueIJmMTg4IgZp2zCNoPkn9ZMC5D1IF+?=
 =?us-ascii?Q?U2Z1DgTIn5mjPOkqbZMPjaDyrrL5KP7zlnAvGpTwbPfpX4V7avrySIXwyT64?=
 =?us-ascii?Q?MGhMyvp7KRGwccL6HMQ73vyFJrEGx6GVfhoUMZA4LvFhxjyufGoMpxcLY1dm?=
 =?us-ascii?Q?cSXb/d9jeO8XK9lZaE6M42GEqChKcnLNjclCGxYdtbXZvfP+d/l8Ac2k1aV2?=
 =?us-ascii?Q?m65Ic3F8sqpMEuzm/k86dj2wRdZYsDEa1qG90UCW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b994e8ab-a21e-4f03-da2c-08dda833947d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:29:24.6098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IW65PdBZdDgLAG3bQm9V6nIxxAjGzbij8oXGIvPPYozcGzE2fP/kqQKmAsegfKvNzzVzKG5ewU87aGVZQgDPzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7171

On Tue, Jun 10, 2025 at 09:24:40AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Jun 06, 2025 at 11:51:17AM GMT, Frank Li wrote:
> > +description: |
> > +  The QCA7000 is a serial-to-powerline bridge with a host interface which could
> > +  be configured either as SPI or UART slave. This configuration is done by
> > +  the QCA7000 firmware.
> > +
> > +  (a) Ethernet over SPI
> > +
> > +  In order to use the QCA7000 as SPI device it must be defined as a child of a
> > +  SPI master in the device tree.
> > +
> > +  (b) Ethernet over UART
> > +
> > +  In order to use the QCA7000 as UART slave it must be defined as a child of a
> > +  UART master in the device tree. It is possible to preconfigure the UART
> > +  settings of the QCA7000 firmware, but it's not possible to change them during
> > +  runtime
> > +
> > +properties:
> > +  compatible:
> > +    const: qca,qca7000
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +if:
>
> Please put this if: inside allOf: section, so you won't need to
> re-indent it when adding one more if-clause.
>
> > +  required:
> > +    - reg
> > +
> > +then:
> > +  properties:
> > +    spi-cpha: true
> > +
> > +    spi-cpol: true
> > +
> > +    spi-max-frequency:
> > +      default: 8000000
> > +      maximum: 16000000
> > +      minimum: 1000000
> > +
> > +    qca,legacy-mode:
>
> This should be defined in top-level properties and you only do:
> "foo: false" in "else:" part.
>
> > +      $ref: /schemas/types.yaml#/definitions/flag
> > +      description:
> > +        Set the SPI data transfer of the QCA7000 to legacy mode.
> > +        In this mode the SPI master must toggle the chip select
> > +        between each data word. In burst mode these gaps aren't
> > +        necessary, which is faster. This setting depends on how
> > +        the QCA7000 is setup via GPIO pin strapping. If the
> > +        property is missing the driver defaults to burst mode.
> > +
> > +  allOf:
> > +    - $ref: /schemas/spi/spi-peripheral-props.yaml#
>
> This should be part of top-level allOf.
>
> > +
> > +else:
> > +  properties:
> > +    current-speed:
> > +      default: 115200
> > +
> > +  allOf:
> > +    - $ref: /schemas/serial/serial-peripheral-props.yaml#
>
> Same here.

If it is one top, how to disable all properties in serial-peripheral-props.yaml
if it connect to spi (reg exist).

Frank

>
> > +
> > +allOf:
> > +  - $ref: ethernet-controller.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        ethernet@0 {
> > +            compatible = "qca,qca7000";
> > +            reg = <0x0>;
> > +            interrupt-parent = <&gpio3>;      /* GPIO Bank 3 */
> > +            interrupts = <25 0x1>;            /* Index: 25, rising edge */
> > +            spi-cpha;                         /* SPI mode: CPHA=1 */
> > +            spi-cpol;                         /* SPI mode: CPOL=1 */
> > +            spi-max-frequency = <8000000>;    /* freq: 8 MHz */
> > +            local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
> > +        };
> > +    };
> > +
> > +  - |
> > +    serial {
> > +        ethernet {
> > +            compatible = "qca,qca7000";
> > +            local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
> > +            current-speed = <38400>;
> > +        };
>
> Best regards,
> Krzysztof
>

