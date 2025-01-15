Return-Path: <netdev+bounces-158622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AB3A12C05
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 20:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1161655F7
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 19:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475CD1D6DD8;
	Wed, 15 Jan 2025 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="irvZbGRo"
X-Original-To: netdev@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020074.outbound.protection.outlook.com [40.93.198.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8031D6DBB;
	Wed, 15 Jan 2025 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970748; cv=fail; b=SDNPTi9ltvuH3vr3UjIxj2kvLf61bxRAWwmL19DvJKrwFJZI9tUW+aSHqmAeyOcYUlbVSOLnGWPvkhBFEjPyiQjGYEShdlj28uaia2+hrZlmAIWkwnxk2Hvso7lUxZJRpIBmdbK7YYp+r9IempQ6Z+LK6en1BhW8fF5O8690kLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970748; c=relaxed/simple;
	bh=oZ12QSBwEvufrTysbyjvxZtDhrhYLSrSHthPr2PfOtg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ROTj5QYXP8idrXK/CvdTrY/02xkV8q2vBDhHjD9UIA2nZRKbdF8LarJTupwzig7bw6aLqYF+b1pPRWDpW1kuXoZF4Yg/mhhEIK79ymVaRVudOB+IOydgBjEKstUXpWKFK2EavAsrLsJ8Co6H2980elJG7hmLTct9CAKU1f5WJaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=irvZbGRo; arc=fail smtp.client-ip=40.93.198.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOGT0Nik6tVFg0PZJ1G3PE6N96YtklVeZUucSE0V9XZvMa/Cg8QghbmestaOYUDcuMYAKeWpPxKehurr5fu57TX+TJrDjWO58lwU4cXvYVNFR2c0WcQKqXB0IW/XGXxXCSqRMiyoiCWSebozslf9BVMjx0OPPo3J5lt+/dn/fVghXDeSL3iOeFFVI9x0s5onAH4NoJXIIindtuJAuCYZln+ns8Wu9cHTmFlN7TTjijt5jw5npMyYSCd35Q+RJ4inrPbtSkfz6v31pg9F1SGCXtAXpL720bwgtXLty56Vft51aQx8hhv/7ZljIVBkt/HhukunY0+r9GtzvVmnMxU23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9VbzXaqTeyUfl6GCs7s/gNVilQ4IocG4iLqftZyHNg=;
 b=Pc+wQpp5MMQeToas7/prKotLhSLiMkzR096PyQU48j4mOiKMIqOp8h11MM6B8ELPZLH/EPJYNeURHA+MHdfhbAfzCUesjrSkA0nR/iBJuvkRhdkvS7rfqk9iLjVX2ok2Vldf4zj8NODxgy1U19MBYEF+B1NtxInwDI8hxhmzWzdwLbwsvYKJ7I0vudgnRfWYccgiYpMbTOu6RRYxjinXeCSasKW4FiYKRqViLf75xvZE57qnZ855J7YRwbA4SQr0VbgCql/4oJ2ZoLmArejhOhF40sVVbPHu9JicZX8Yf094PgqiQwIum4UUC+AKSI31lhlds559//taJTN+5vmi+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9VbzXaqTeyUfl6GCs7s/gNVilQ4IocG4iLqftZyHNg=;
 b=irvZbGRo6gmCX2zaYY+Po+aa45ZE8u7b4BAAQeRqGzN5xSBj/bNUeFnplU5o76iEosdHdVMnrsya+YDtpKI56WIaExXOeYNd5hyxJaF7NtDBb57V81OWbH94SZ9L9Y4OyKsRmoME51uKMbY4Vai4EMQkPEZ1kRvnbVx2eafO2II=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 SN4PR01MB7517.prod.exchangelabs.com (2603:10b6:806:204::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Wed, 15 Jan 2025 19:52:22 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%7]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 19:52:22 +0000
From: admiyo@os.amperecomputing.com
To:
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v15 0/1] MCTP Over PCC Transport
Date: Wed, 15 Jan 2025 14:52:16 -0500
Message-ID: <20250115195217.729071-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:23a::7) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|SN4PR01MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d8766d-72db-40e4-97e3-08dd359e204b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sMzEHfi/QC7ox40pUsCLEN8OS9XS1+vINHsKnr6ttQkJn5VWlkGwsZXhFiEN?=
 =?us-ascii?Q?eicmJOTHjWDvU1OIeRZPIvP7g6p+3JkaM3C6W1fu3zBVNvcTf7bXDe0bqaeb?=
 =?us-ascii?Q?kRBmokVHL4FHoYb5UxnpaGCv5zai+mEV3NbQbpxxhMD1JvBl/uuTAoefz6uu?=
 =?us-ascii?Q?kbih008gFC1q4epWwFHuApWaFICbJeRWQ1Z6yk63oWnh/+IysQMt5cFFRkMp?=
 =?us-ascii?Q?va9lda/4bq48oiJYlSUX4ILqzjS27UG/K5eVYOMvDyUwTyc7pXkqVHnfm0fR?=
 =?us-ascii?Q?L3ZXc0NsiF1WXYXCx9d/wGr0D92NGmzZj3/RuY9HtW0oxvD3gUt0I+eKsdwy?=
 =?us-ascii?Q?1n2WkiIUZZ+3BNPGj57diQ8eOE4fyuLD8mD+VJ6uOlYaWF0CQA9F1SYicy9F?=
 =?us-ascii?Q?uFGbV6KnlzFnG81blC+oMGcCQ1us+zcMHdsyOc4LOPB1CD8GEO0gV5trQ4kO?=
 =?us-ascii?Q?nO6xbJNjVGPT4tVP4lUacXevr25Xlwz3JbnQf25oXJdq9N20y0GXMJDgYd4N?=
 =?us-ascii?Q?Q9iRCvIkTp6NaBs8SXyj2F5w1kVMGw03hb7KEv0kbj2J0Av9/AxAXeWm5TiQ?=
 =?us-ascii?Q?nEaf217Zz5ckpHV53QXtM+JUiTnpmJT1gp5tRWDKCzJkdefSsxYJMmWCohm2?=
 =?us-ascii?Q?7DFWmsUsgRqs5rmwU9lJ+/WUKv+2SicACvM6DelCo5r2ZX3O6nsJEYQpq8Ar?=
 =?us-ascii?Q?OSiqe9jSQEVkRvLt4+qPvqjdOmA528Do9Xl6LLMvK9XkBOrpwp9CCFibVVBz?=
 =?us-ascii?Q?LK3IbMSF/CfOVyr7FGQqkYxez8ie4QBk6l2XjEUCS9tbCATPRNX9MVtNl6X3?=
 =?us-ascii?Q?hyHUG9ZvnisMmbUzA7kf3pLDQL8DWKxWRN1I7mDaS/aEOvABlFqfEwWp37zX?=
 =?us-ascii?Q?lHminciDTAiChJpwYTULJaAT/lbYm36LDiRzBCafExDSLpGyuoOMkdCVtKVG?=
 =?us-ascii?Q?6Fk7++BnMZBrtcgx7xNTjC1iy6F+BE6AWuBjXNkrWqcewlHfi+yC/v4nmh4r?=
 =?us-ascii?Q?gTXm159zXc6mAywSanwOUFcxoW2KZAqaeRRuXpI/vhqceCL4xyUqDBBwRB0V?=
 =?us-ascii?Q?E72HzoEUn9HpidrBDVd6d2d73imBI44YuQB6LMjUxaLi8MUBfplu3+GZ/9eu?=
 =?us-ascii?Q?C7zZ9gj8px27EorPDDDu8V4JyT6fyu60UY5b2BgAHEbRI1k23aNnXmo6/Vov?=
 =?us-ascii?Q?rNSn9O75OnyRjSuIF0G667AKGZ5qayDGFxLEg4+dq41ow9mth7J2D1SwuU5j?=
 =?us-ascii?Q?uVBQC3C6x+krWZMTy8sGW0YSnD2Me+kVjx7DaQt2B8JfcOaLhV2feo8zi9ER?=
 =?us-ascii?Q?dgq1Ui209REpuLdX6nn7ccVGq/vr2creGY+aUbxHwW9AzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rae98zom3JbimE0Yc8NEtvkO/MKrztXcoI9o/+RxBFsg8r8h4NPsfCcK1V+/?=
 =?us-ascii?Q?/x815tg3j2ksR0W+SjNLmff3LiJWmQBC4PvB2ll+SioUwPRXi2tfoBdVoWj4?=
 =?us-ascii?Q?Xi0w5lX2zwC3c2T8RMURldSSJwfvCbZYyhHnCyNIcPRuNBAWqrLMyDjqilb9?=
 =?us-ascii?Q?xff/ziVbhRN3gU7VJoli73CxOnHYmR+YYUdKwlyWovWvSVrSusVI4wUBbMh/?=
 =?us-ascii?Q?53NejokPa2a+/ynXzK72E3IXR5WMa5KtnlVkaGIe2eeX59v3m66B6yhiJ4I5?=
 =?us-ascii?Q?/HW169NJ5FC6E1CHykNx+J7vxk2MShkKBfJF+ouC3QhahoTiDyMe3F5ilXRJ?=
 =?us-ascii?Q?hwSHeXAH4uPBgUNLYtcnnnyk8cQVhp2JHX9ueui6O/Is4GFD8xzgD8pVBhrw?=
 =?us-ascii?Q?BVqVBz+rFk9HXUA7oyWSB5+sZqtjecL79HWV9xRxf6ZTGRYBWucSgvCCFmq3?=
 =?us-ascii?Q?ajkAmJO4TJ19Udn3tbfh2JG/m+NWmRgA2hembMZZPrPO1VCkJNdoMtigg4fh?=
 =?us-ascii?Q?H6n38WrkrwYE2/cwCthcDx6QLkRsm/2mxY+74XzEYAIDYlRRUAuEV9mjfMrf?=
 =?us-ascii?Q?SNaG7xwwWmg7nbprsQpP0bUwbW//aoZgWbEdNZ/n/3ZQFI3NgOQISLz3I8mY?=
 =?us-ascii?Q?RImdzTWbLDSMJXiI8Y/0V3RO+dy1wiNDmqmvlvix5HsNYCRH3UG06WDgrBQC?=
 =?us-ascii?Q?agc7nn6Q4k2RR71UfFFSvVOuVPHGNl6qHq3/Z7lAxyfy5aNyqnaB7lKeccga?=
 =?us-ascii?Q?BLF6bI/LRc6lPUbKkpL9OoHF4t77Jq5AQvKLLLAcj4+MtIVJmYSYlWQD1WPU?=
 =?us-ascii?Q?osajc2FKLHv8lXqvODWef88Qg0DDKj+qKGCQf3tdOAjOeJBfXZvPVtmVgi3e?=
 =?us-ascii?Q?BrO9TGOEDmoaZu4ShdQ7B6NHRkZZp6p2SWi6rUz+aOBvEQmJP93HfIN3xnMT?=
 =?us-ascii?Q?0i1gV3LEzqm3aXAxX9jfmT9DgVMmYkvGuE3LLFXT0FoxEq6I1cp8ujGCeGmy?=
 =?us-ascii?Q?50BJnzl+TWnMhaN6Dt+SOgTouiF22UlZfQH6XZDVtKdB2dnRVuHv6zj8qpr6?=
 =?us-ascii?Q?XG8t2ds5krphYjnSxLMNmGZWj61D19xZtPuUQqkkC7il8DW6evttRG9rBfb2?=
 =?us-ascii?Q?Ydj1z1ZSz2Y458gSd8zFRgei0uvlMolSGXfbq+LQuIWruCefbc6qdBA+STXb?=
 =?us-ascii?Q?2hPT/BowGDwpXn1wr8MiLh8RuRrzley6gIXmAqbXYXzt7EJSS+GxClPJ3XFq?=
 =?us-ascii?Q?cArQKZUV1neinP75ZggtR5CFJ1BiOHjvJB1yBVFqkNHHYQe9oJjfwkHJSKl0?=
 =?us-ascii?Q?+uy/0QQTqkIb0LDm455FissG2YVrjP6FXDSMVONrjee/ScT2jdE01TUnir1o?=
 =?us-ascii?Q?HYoYeH0C32muwne0oVFP0CdhY8cQhEU0fvjRj761BOf461LG9tXfDZVCKAKw?=
 =?us-ascii?Q?RN51w1Cd6oUsXN10Vcnl6lsLDYrjuKccgPx1tTdnDWfuz/FY68dywofrLfoi?=
 =?us-ascii?Q?i6eoV5NXOB+59SenFe8j7eoFr8105bEpWikaLG0vXUZTagL1usnwy3Gu55Yv?=
 =?us-ascii?Q?6fFAmcLC9x95gCgEHKUZlayZ53eYm9JyrxG78mXUGqSDx3baEBHRN7VehvdX?=
 =?us-ascii?Q?ViPlaYQyjaT8AjrkBfuPT5heirjyJ49dWmeDX0DwvnmxvCSZ0hgNUGi64wlI?=
 =?us-ascii?Q?CqnlmZVqeR1uU49bfj+1596Zwjw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d8766d-72db-40e4-97e3-08dd359e204b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 19:52:22.0628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgwoiPp6HyWvzceeVgX3NxuGswaaib4EhFliYJxVPfOaCweO99L5yObQ3WyvktUcty08hjLg0U/b+2pXkHMvXkhSeeAT2yN7p+t/G1RZx3YR9CoKeoEb7WBqO/CJalFs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7517

From: Adam Young <admiyo@os.amperecomputing.com>

This series adds support for the Management Control Transport Protocol (MCTP)
over the Platform Communication Channel (PCC) mechanism.

DMTF DSP:0292
https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf

MCTP defines a communication model intended to
facilitate communication between Management controllers
and other management controllers, and between Management
controllers and management devices

PCC is a mechanism for communication between components within
the  Platform.  It is a composed of shared memory regions,
interrupt registers, and status registers.

The MCTP over PCC driver makes use of two PCC channels. For
sending messages, it uses a Type 3 channel, and for receiving
messages it uses the paired Type 4 channel.  The device
and corresponding channels are specified via ACPI.

The first patch in the series implements a mechanism to allow the driver
to indicate whether an ACK should be sent back to the caller
after processing the interrupt.  This is an optional feature in
the PCC code, but has been made explicitly required in another driver.
The implementation here maintains the backwards compatibility of that
driver.

MCTP is a general purpose  protocol so  it would  be impossible to enumerate
all the use cases, but some of the ones that are most topical are attestation
and RAS support.  There are a handful of protocols built on top of MCTP, to
include PLDM and SPDM, both specified by the DMTF.

https://www.dmtf.org/sites/default/files/standards/documents/DSP0240_1.0.0.pdf
https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.3.0.pd

SPDM entails various usages, including device identity collection, device
authentication, measurement collection, and device secure session establishment.

PLDM is more likely to be used  for hardware support: temperature, voltage, or
fan sensor control.

At least two companies have devices that can make use of the mechanism. One is
Ampere Computing, my employer.

The mechanism it uses is called Platform Communication Channels is part of the
ACPI spec: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

Since it is a socket interface, the system administrator also has  the ability
to ignore an MCTP link that they do not want to enable.  This link would be visible
to the end user, but would not be usable.

If MCTP support is disabled in the Kernel, this driver would also be disabled.

PCC is based on a shared buffer and a set of I/O mapped memory locations that the
Spec calls registers.  This mechanism exists regardless of the existence of the
driver. Thus, if the user has the ability to map these  physical location to
virtual locations, they have the ability to drive the hardware.  Thus, there
is a security aspect to this mechanism that extends beyond the responsibilities
of the operating system.

If the hardware does not expose the PCC in the ACPI table, this device will never
be enabled.  Thus it is only an issue on hard that does support PCC.  In that case,
it is up to the remote controller to sanitize communication; MCTP will be exposed
as a socket interface, and userland can send any crafted packet it wants.  It would
thus also be incumbent on the hardware manufacturer to allow the end user to disable
MCTP over PCC communication if they did not want to expose it.

Previous Version:
https://lore.kernel.org/lkml/20250114193112.656007-1-admiyo@os.amperecomputing.com/

Changes in V15:
- corrected indentation formatting error
- Corrected TABS issue in MAINTAINER entry

Changes in V14:
- Do not attempt to unregister a netdev that is never registered
- Added MAINTAINER entry

Changes in V13:
- Explicitly Convert PCC header from little endian to machine native

Changes in V12:
- Explicitly use little endian conversion for PCC header signature
- Builds clean with make C=1

Changes in V11:
- Explicitly use little endian types for PCC header

Changes in V11:
- Switch Big Endian data types to machine local for PCC header
- use mctp specific function for registering netdev

Changes in V10:
- sync with net-next branch
- use dstats helper functions
- remove duplicate drop stat
- remove more double spaces

Changes in V9:
- Prerequisite patch for PCC mailbox has been merged
- Stats collection now use helper functions
- many double spaces reduced to single

Changes in V8:
- change 0 to NULL for pointer check of shmem
- add semi for static version of pcc_mbox_ioremap
- convert pcc_mbox_ioremap function to static inline when client code is not being built
- remove shmem comment from struct pcc_chan_info descriptor
- copy rx_dropped in mctp_pcc_net_stats
- removed trailing newline on error message
- removed double space in dev_dbg string
- use big endian for header members
- Fix use full spec ID in description
- Fix typo in file description
- Form the complete outbound message in the sk_buff

Changes in V7:
- Removed the Hardware address as specification is not published.
- Map the shared buffer in the mailbox and share the mapped region with the driver
- Use the sk_buff memory to prepare the message before copying to shared region

Changes in V6:
- Removed patch for ACPICA code that has merged
- Includes the hardware address in the network device
- Converted all device resources to devm resources
- Removed mctp_pcc_driver_remove function
- uses acpi_driver_module for initialization
- created helper structure for in and out mailboxes
- Consolidated code for initializing mailboxes in the add_device function
- Added specification references
- Removed duplicate constant PCC_ACK_FLAG_MASK
- Use the MCTP_SIGNATURE_LENGTH define
- made naming of header structs consistent
- use sizeof local variables for offset calculations
- prefix structure name to avoid potential clash
- removed unnecessary null initialization from acpi_device_id

Changes in V5
- Removed Owner field from ACPI module declaration
- removed unused next field from struct mctp_pcc_ndev
- Corrected logic reading  RX ACK flag.
- Added comment for struct pcc_chan_info field shmem_base_addr
- check against current mtu instead of max mtu for packet length\
- removed unnecessary lookups of pnd->mdev.dev

Changes in V4
- Read flags out of shared buffer to trigger ACK for Type 4 RX
- Remove list of netdevs and cleanup from devices only
- tag PCCT protocol headers as little endian
- Remove unused constants

Changes in V3
- removed unused header
- removed spurious space
- removed spurious semis after functiomns
- removed null assignment for init
- remove redundant set of device on skb
- tabify constant declarations
- added  rtnl_link_stats64 function
- set MTU to minimum to start
- clean up logic on driver removal
- remove cast on void * assignment
- call cleanup function directly
- check received length before allocating skb
- introduce symbolic constatn for ACK FLAG MASK
- symbolic constant for PCC header flag.
- Add namespace ID to PCC magic
- replaced readls with copy from io of PCC header
- replaced custom modules init and cleanup with ACPI version

Changes in V2

- All Variable Declarations are in reverse Xmass Tree Format
- All Checkpatch Warnings Are Fixed
- Removed Dead code
- Added packet tx/rx stats
- Removed network physical address.  This is still in
  disucssion in the spec, and will be added once there
  is consensus. The protocol can be used with out it.
  This also lead to the removal of the Big Endian
  conversions.
- Avoided using non volatile pointers in copy to and from io space
- Reorderd the patches to put the ACK check for the PCC Mailbox
  as a pre-requisite.  The corresponding change for the MCTP
  driver has been inlined in the main patch.
- Replaced magic numbers with constants, fixed typos, and other
  minor changes from code review.

Adam Young (1):
  mctp pcc: Implement MCTP over PCC Transport

 MAINTAINERS                 |   6 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 313 ++++++++++++++++++++++++++++++++++++
 4 files changed, 333 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


