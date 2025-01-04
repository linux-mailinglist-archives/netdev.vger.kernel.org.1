Return-Path: <netdev+bounces-155116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D563A01224
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 04:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98FA1884AF7
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 03:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FF885260;
	Sat,  4 Jan 2025 03:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Tp3YQEBq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2099.outbound.protection.outlook.com [40.107.237.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7B12F5E;
	Sat,  4 Jan 2025 03:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735962889; cv=fail; b=RvED7ZKTG4ZkXTHo5yoPb1SOnYTlVe2g9ssXxNq+2BTIvhdqFzQJrdmcOPJR+nrAMgVqfZlZOR+uOXGWv6d6R8Xo1QqAU/H3sdLlrzL7//iZKD6HD3KE05cBxDKV9P9yXl9vjZU3XtFc3b2rAS6NrGYlXT3cC9F4r9YNPcoz8G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735962889; c=relaxed/simple;
	bh=6hkaDgx4V8oR969SUIHx6ylOFrnJBxOyoKt/fWPDuFA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qgHE+slasL4D4JYpFH2PWnfcbWPVuuZT66y1sWqeaGNCaWKw+2O3QAI0yvYVKTQ56DxKlesLSBY70cjTlQAssTiF18/LENgsJYBEKRvfLRKIx6KTXTOUVUCyEWY2GRPOxfb8yzPXISsz0UKl9D/YqdmF/Mt3OXEY8NLlDktm/yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Tp3YQEBq; arc=fail smtp.client-ip=40.107.237.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lgrd/j+t4nN2pXUmV+1dDXbMZRg9WJ2Xv4ZG1DSwIrbCY7e1evwUBHRtGI6b4Iei3YBtKpxSKz98exjroan433HSssMbMNTjKV7vnFFfdypFBNRKx2kAQD4SNERONR+NuTYF6ZHln5E2/CRyoC0HhOcRsdMvHbcbzbeqaSinnxa9TRL4BrHIKEHwbbhZ8FdeFvWgU8lqVzhT3qzkMWdnfs7Usx/ynlrIFqglKZFR4LdVoJBPAdXrixOZrOZopDRhBanmPq02FWKhSVeqa2tHrMsLHmn+rD+b2LAZ5lU4b4yEkPRcrSddPEbcHJOSTUzl4WFjEzxmJ4cfe8LwIGa9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gwvYz8gZxWHsrfrzgBqIXqoYCEgpP0DZDVXrqAzWU4=;
 b=pSwRWHRIkWDPfR6HK1PC2E4lPqulkVnTZUoLeJX8342JP1IvrmThwFIHBI0mTwq6EI3xwq3El1bgH4KeHqMbxEUE+NGj6iSwm4749xeMCmipssUkrcg98Dg9o8RvdYzMYPGz6YMx2Dmjsz2JLpoviFsxBw8Um5TDayRsZZjRw6gegDrD8JfS7EWlM1gn33i6v+rZNzUO5SMy0nULuTZVLdhss2HmnTVNLkhGD6W3ihBkRmgqvw9/rtIM8fsoNjNc5c1vJhP3tID1QMiPvTWs210COPlLQnbEtWc+J6EoBIfv8JbbhkNptvHLP5UE2Mdj9Nfwcxit+X/8VEWSAc8xcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gwvYz8gZxWHsrfrzgBqIXqoYCEgpP0DZDVXrqAzWU4=;
 b=Tp3YQEBqdjHcHyfmcWcDiY63GF9pb+6nKs1XhbWoX89sV2z8gokhvSO1PFRWQ/Ts9LbOiEJ3cLE0DbuVgzssYe1Zdsu2vAHtSs7ytyzdXrclHz99USKV1O1BLWwGarhpeK6ypDkq0CuJZBCjH3a3eOCO0j2Qv7nDnbrdYWIo+7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6171.prod.exchangelabs.com (2603:10b6:806:e5::16) by
 CH0PR01MB6891.prod.exchangelabs.com (2603:10b6:610:104::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.12; Sat, 4 Jan 2025 03:54:38 +0000
Received: from SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d]) by SA0PR01MB6171.prod.exchangelabs.com
 ([fe80::b0e5:c494:81a3:5e1d%6]) with mapi id 15.20.8314.001; Sat, 4 Jan 2025
 03:54:37 +0000
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
Subject: [PATCH v11 0/1] MCTP Over PCC Transport
Date: Fri,  3 Jan 2025 22:54:28 -0500
Message-ID: <20250104035430.625147-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To SA0PR01MB6171.prod.exchangelabs.com
 (2603:10b6:806:e5::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR01MB6171:EE_|CH0PR01MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 620177a1-0bec-44e6-51bc-08dd2c738246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3l1Bi3K/CQqvsIFdPRWWUERdTvxu52TwWNAYv+27bdUOnJoTD+E+1yy75O2Q?=
 =?us-ascii?Q?7pOCUCN9PyeKEQJB/nofSfPp8Gm4um28wFfvRPT/SWP9YPh5DZ8oOmk8rGm8?=
 =?us-ascii?Q?XAvUgu0Q2XGR0HIHGtvMaz8Y6ojUTtS8IGQ8hNYl1pdkPPB8YBvzYtv3a77h?=
 =?us-ascii?Q?WonTPEDgi6zSv54QoBRutJLyXTkLOoqx55UQNKwOkAyfrbcAYPXjI6llLP+k?=
 =?us-ascii?Q?hjy9LnP5J135AMzP+O8z3KBAGvfqQSGbsGKSORCiUMNN8Q8cVrfkS4mVFJwJ?=
 =?us-ascii?Q?2DJWra3z+qP1Vee9YrPJDPtY62yMI+jFhCkJxG06iEbKfq+mbJmQZFzVWOlT?=
 =?us-ascii?Q?uxrmKMCO8P5GOE1Dic5POC4reiZc2FvAhTGWzdNLMykejT+kJwTjfjQRkmj4?=
 =?us-ascii?Q?YQGAUekmk6edVECcHDll0T5pDASsW+Tmba6mv9ozJxtGnAEACyXwmZQRJ0dT?=
 =?us-ascii?Q?+JcoyiiJqEhL/3m6PNO4QByK9/wVRjzpgpceOxsrTIpttKlRGdK9xZFSkh/j?=
 =?us-ascii?Q?+HU6avXatQY+ZHVNYETudN2BmXxW8u9TL9RfNA1bAW5bovqP8/9yq7NdpTyg?=
 =?us-ascii?Q?NRztkbAFun/EDIiKIB0VfSPz49bIcnx8L0LxC1ZT2lipRdgypLfGv0b1mngl?=
 =?us-ascii?Q?GfCQm2svaPGk6pjDPKMZp51+ZwWXrkcQddNlNIuIr9Ke9AhuFEZJwHCKX7SS?=
 =?us-ascii?Q?uHeknk1FWkWnv4uLyCy6l6vjSBx24d8hYaYfHrub/F5NtE1OKFD70/tr/6zR?=
 =?us-ascii?Q?llTGYJmuyu4aGpkOdbU1JzvADOVsWp+96m1AC5N2kn4JUQljDNtASN5kyuNO?=
 =?us-ascii?Q?RTalV2nA0TS9HHsZ0FWv1KR8Jcco0iOWyP4eK69/qTcX+vHMnKTKjonfIwV5?=
 =?us-ascii?Q?sTV4+Y4uYhDm1OQzZ94mNOnGmFKiIul/XVRTBG2ulixrkW1FGCIHvEgyv04m?=
 =?us-ascii?Q?5GN8SuT/+EPfFmcUhOgZ4lb9rKIcEVWRoTVYzkzPi0YdIIfRWRdp3R+V13w/?=
 =?us-ascii?Q?yKqVl1EM3GrF4V5lQ1G58CuAkz/uJo3t66aqZPdoS3Fbmg+2dOxghpBgjg/V?=
 =?us-ascii?Q?ZG+KJah9sfQbFL2KDE5vnsnxD70Xf3rSAFNND4+L8qwEBNqp+mT1x/s1z9uP?=
 =?us-ascii?Q?vPF/+1iVMzXBgkddWhqPY/Pfj5HHEJ4OZ9+szV2w/sFz643/03b/l0RXGS3l?=
 =?us-ascii?Q?tOdboBnYg36nVDv9dziagE6CUgbCvCTErDAn02CU9x9SqS4Y11u+sD3iiEIp?=
 =?us-ascii?Q?dChZ07k3nKEEkEQqh9yifvwCyoeQnWfVtoBCQV24nOO8QAvByYgmFP2fNTjZ?=
 =?us-ascii?Q?k1RM0Z61MVjznXvQMwAlbgOFpwTFNcwO/QSznWGfrK+rKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6171.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zxsLKSRz5XUBv16wk++j6Q1d1rjgxNeccn/fym9Z6FOJDWbyrsCn3GPGzqS9?=
 =?us-ascii?Q?O30TL12PIN9TUl64c/NChUr9jM+SAFvtPfqnW9cvJDe8y8MZs0aVyH4J3FkN?=
 =?us-ascii?Q?4iUH5Iqn5VqXW3e5Jlp0yyGsDwMjUBWlCPGgfz03cE+aIyKG8MfiZEHxUXvN?=
 =?us-ascii?Q?QzGHQnuI8ljM7LkEQCzZdNgEf7ySEGbdQriUucPI3H+GEQB/nd9X9mm9GPS9?=
 =?us-ascii?Q?y754rdLtLLhZFvBDzsamNNVwPQvTFgpdGtmw9Hr7GsR5jLPxEjQCfUDwrLpp?=
 =?us-ascii?Q?w1WqtU/v8ld0V8E7YCMmU/hYBiqvlPsLrVpjs79QpzuQVvcMNsHVGhscLOMi?=
 =?us-ascii?Q?uG9rLsgz/tqEmkkwUWVX96fzGxzzPZv0QCiCh/d6zEiEeeHfCJsvEfoY6UOu?=
 =?us-ascii?Q?ni0gysLMop0W8RfA+Knp/ktj+xGtbtu/mEoFIZ7z77itAOGIrNEjaGKV/d9C?=
 =?us-ascii?Q?e2E+mOjLUbVcivRpJHvFTAvnoeI3XVjMKvAcjdsTVAfKNBglxj+XmjlzW2us?=
 =?us-ascii?Q?hX4Rqd66TAKug23DAMlFnTg78CpFweeI7gn8S+JAc8NC9vuGMyOMXer+7yeC?=
 =?us-ascii?Q?1guEd1clHXy3U+6Jh2ESAdnrxCggGjSk/hheqGgpaTZcDdaYpZZsiJHkjmIn?=
 =?us-ascii?Q?X8263mrIjD4W87hDO1XWmNcNpB7WxljXE8MkBHJ195kYG2hlsdTz3owWnRDM?=
 =?us-ascii?Q?4NExgNVqPXUhdszlUk4jcTwMRvJ71oLxZbjhcbxfgiVKlWfsO2FAVVmld3IQ?=
 =?us-ascii?Q?etDiM/+OkUybzEBNvN2KvyM+2gEcALAoDQ33yuNXXSm+mcQoSeNFV6Y50yQo?=
 =?us-ascii?Q?qjQ2lOtTB6uEB16an2ymayH2Lk8lwsBhnV/c8DovQvygKWGgFwmJRleXJU5b?=
 =?us-ascii?Q?7kHYBdqy6OZ/MHsluaDrh3NcSdgX5QGwObB5D2G5ng0Y09KpTLNv9A2GDKdT?=
 =?us-ascii?Q?7B+All+sG/n1Ncz9OZc8EpCrTGddDnNK1WiBUMlznGHf/qt6K3JcoPgfGHJT?=
 =?us-ascii?Q?ZLX0IHeceXgVgwUs4t6GGY2ALmF6OSzU8Cv39oFkXXVvOe82dtBAYEnuBWgt?=
 =?us-ascii?Q?xRG5185OtlWLByidqXVpvBlAm290+J8ylPJ8JaCikK5nmOPkH6m9bHFB8mlR?=
 =?us-ascii?Q?+CGOlv7mv4pWXwfiTgdUIi6eXq4D9ZcmeVWfCDwog2hUM35FpuTpmdMkEXJH?=
 =?us-ascii?Q?wNwqfa85n8uJ1wRnIXb5oxLtBWWOL4nk05Y21Axcd6tVdF2FVRR0jjNy6GZv?=
 =?us-ascii?Q?dkkjT10nafM4BStro3LinWWv0qORApE26j/fhap4sLmXu+zA4i2FyKjtWQUS?=
 =?us-ascii?Q?ZCtF6dsDARNi8Ydye3FlmBhMeusu1mzl2Ha1W1Cl6NUEXPqIYx6Qs4wnvUt+?=
 =?us-ascii?Q?wNU1FU1F/yQ/hVy9aVjmV+mi2Nr+aqCD6EIImJGVSEvbc9raHdbuhG/6AVEk?=
 =?us-ascii?Q?dhJSYLcQAB9PGh8CvJRmKGOJy4FPHOAZYkeUb2CcBF98vfnX0+Tc3j59MkLV?=
 =?us-ascii?Q?X70L3zFm3ptGiKhhMat1pojQCB8+dZk40E3TdhmplJskPQ1ZeWEmRyrpIBn4?=
 =?us-ascii?Q?hWAx1itx4hV4gvs0Yu432vbaUE8tx+aMYLP/Hq33wzBpowo3ro3raC1P9fQ4?=
 =?us-ascii?Q?uClN8RTZ384dVvNIMvT0Ud+YkbUQoh9dosBXFCMdrHaJPMUkoXb7axJ5MaDL?=
 =?us-ascii?Q?i8Tb8zLzExMDXBn9rxBPJarGw/I=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620177a1-0bec-44e6-51bc-08dd2c738246
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6171.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 03:54:37.6804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gw8KzfToOhduBTs/4WQXEZ/MBmoB9fuANe3QpcH6fiOXJmBao0o+628IBiQ0A4v5ZySWusU/CNXHaAzJJtQys2EtVZs9g+B9K1pFQuRUqY/JSl+Lnhgjn9uKFYc6x4N8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6891

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
https://lore.kernel.org/all/20241219191610.257649-1-admiyo@os.amperecomputing.com/

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

 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 311 ++++++++++++++++++++++++++++++++++++
 3 files changed, 325 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


