Return-Path: <netdev+bounces-215038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EBBB2CD72
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 22:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5AF52548A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 20:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645F0231826;
	Tue, 19 Aug 2025 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Ug/dssRq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2101.outbound.protection.outlook.com [40.107.244.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE51A0BD6;
	Tue, 19 Aug 2025 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755633764; cv=fail; b=n3vLRlWd1Vq8P5KG7/tK16WLgdNtjgsZj8Nn/EuSjf/lb6TBtfOKND3A4Gc8vPAdrNa6DjHwL/xv2kkS2JjGBH2DjKsLFfb/pJXPGs1wd63loyVGC1IPgxKNm0totGhNnHXJk5g96qq+8rVDJR0vkBFE3Ga6P8xgxCOP23WD9Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755633764; c=relaxed/simple;
	bh=waVKKaNSXXhQrj+I6fOCvw/bj/ine5qsQZA8BgWXQzs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P/7ulGgwc2NFkpKHdD1wNWT0B/w5Vw2IIoaBEtu1ryv+SOp3KCmeOyYOqO6tHQeGADwMsZ2O7PNhMcKaMpF/0Xw+J/j5PMEAmajXifaHicGJzcCx/PeDlKOxRIE00unMubnY8hQlfF+KPiaXqMkRyTJm19aoyfCQi6xNhn9DywI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Ug/dssRq; arc=fail smtp.client-ip=40.107.244.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXNxCc99r/ijf5bbbN3wmFROIHtcr6jc7B1TYe2+JFjwdOGH8BC79kxsGIbsCJsH1bfR/bMAHm94Kse0LlgpuhotIvoF9dG54fCgxt5+JPwAQQ7VAbSjjdKdtlfevTkuYG+SDkwMPiv5vsTtX6lWExW9rEF16GGgSfFblQXSCpksuBv3B+Jb89/H6SKvkvnWErEb72+zYO0NldmhfFAfhWk0gJUb3/fQ6+HWGA1FdL7SpiZ6fvuyHgKIXAlUKkQGK8AzZrEraLAiHZ8ZaTR5lAX5wfggB/IS0bxaiT5AtsWdriIDcpwxNPrXDJfKArQudTN0hWVNv4GwiFmMwN5qzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiR/0qvFceUHmyKF871Z1/W5qp1l750ehPxaUTtXYJA=;
 b=HYMuzDEEsv3XQPy3ZwoFF+TKDnNuX2zlvj8EYORCdqukZIgksFJ4rOmJKiWRSc8PAuGr45k8Ljpj7qVa5z0qhzKO8Vp6J36xCnNqlAT0KGHeJsfhH17HovlizRnemwG7wbZX9G0upwcdOsBPpSnLIUYH0MRvaKttWHGpdd5bKc0//8whJ1hXjrJDGeYhj/KTEG8fgYYiiJKztCdC1NlFx7ui6Zh2y64jTx9bdC0Nt8gCd23A2r6IatbizHgHiLFCvuaq2mS6q6JY7NISYKqEU3+xxCHLoOa+1NIve5rCNlXTPZ50eMvAkevt4DOHN/K3vdL3ooNBdSmvVSlYiaNwDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiR/0qvFceUHmyKF871Z1/W5qp1l750ehPxaUTtXYJA=;
 b=Ug/dssRqibn+decXT8Lh2wRzJPTifEYoriELmjky4M2ulHTEeMych/LqCXUyDfmucE1h2iOOIImhiSuVHGS3+Oek/vOVdUZDOfWM56+FudWzXbauXj1JId27nATbi9HF1KWrzE860OPkzzz2iyp82D1Q0PU734qQccj8IkTVFc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA1PR01MB6542.prod.exchangelabs.com (2603:10b6:806:186::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 20:02:39 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 20:02:39 +0000
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
Subject: [PATCH v25 0/1] MCTP Over PCC Transport
Date: Tue, 19 Aug 2025 16:02:26 -0400
Message-ID: <20250819200229.344858-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR19CA0015.namprd19.prod.outlook.com
 (2603:10b6:930:15::12) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA1PR01MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b6d3f1d-9a2b-4c5c-2eb6-08dddf5b5941
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|52116014|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eZm2E/d3cYGLu3V8agAHGKRqwnGgf8Nn5cpbNJv+/q8taKmfYlOD4ap3FBs7?=
 =?us-ascii?Q?vtNDPt1wCtFskuHyrVY6i+bi8tv0m4+ki6+DEs+F3z2tyGyLFPZKH4Fbyluc?=
 =?us-ascii?Q?3YZQFmW7akb+qNPVfke+IEm9YW5XBNUmqwxK0wSghT8AeRHF2r8Y1jp36MWN?=
 =?us-ascii?Q?/SWER4SCU6TcoGCbNNVk9YrhnPwjky6xmTjpVimu5YtqtfN5ZlzkhjrIZVFj?=
 =?us-ascii?Q?8YPlYBmPoK2a1LmImiNxhbTn72AGsmhEiQZzED9lb5nIS9RkzsBIZnfxuZC5?=
 =?us-ascii?Q?+1DOol/zKXpsI1zpM2gpzpuEl1Oy1xmYA8tKNwNnad+nDNRmfAC++TOkukMx?=
 =?us-ascii?Q?WfuYlKm3wfbRcu+63nLji5KfiMpWVpJfJ9Pk4beX4jgu26U3/i+Cel7xaKph?=
 =?us-ascii?Q?Xx85yYF7LDq7qMvR6haZSZyjQRiOUrv6dU7LGiOwN3ip6bFu8RJW+MyQRPfM?=
 =?us-ascii?Q?HXpPQILesSHX6hXZBJvY6D7yv4wmtce6Y9W1hB2tvCFp6FspZXRK6ZJOF9XP?=
 =?us-ascii?Q?sFFccXQDpSamSdNYYUA2n32mBxj2r6ipq7ZRRqOb/GYyI+0Tsdko4x8OemDK?=
 =?us-ascii?Q?GGXnWc1gtpRvqiCl6bcgQRuU0Cs6JcNtout10UyoQFLjXd+l/3e/6ktzTtU6?=
 =?us-ascii?Q?473tn9KuznKY0Hhzt4ojIl+Ue4MZX889qKufcJlnI0zxG9OMZvsY8MVv34aI?=
 =?us-ascii?Q?j/5J9WO7tRzwUTth7vR9x5AVXqyUbC+mj0NXSLRWRVUgRfF2+H1s4yGq/Ier?=
 =?us-ascii?Q?ysTR1T1frY7ZCHb+mub155V7KhYwDplAYUM66SpUsfCl2JQoExtsju3y0tGR?=
 =?us-ascii?Q?umj9RODuqB6r282o6TXC2wXA61vIf0HSRS3qvTTtlWTqREwAkF5HF6irBmde?=
 =?us-ascii?Q?BPJLOsHZ901YhrD0IjqkpNVJFjuE2zr1EzVMs5/Q+AmxiwaJ/yAS9nUAWNI/?=
 =?us-ascii?Q?YJ8MJactsBBgsExN7aMmh6VkIGnUn2ODph8C7bczApNUK2FA4fSnjuMaBK/7?=
 =?us-ascii?Q?UR2LGnmhk/Qo11zezRcUlH0qO58Ej5DDy6b6fcCdOtH1F9OI1anFQUX0gOvF?=
 =?us-ascii?Q?LVTO3D+aQTUApExChYt0KR+yYmnhGqolo+oeOxeZdliVqLs2XBuqnt/WkbHz?=
 =?us-ascii?Q?vV/OcoaMpPCzHWrRqm070gK8tdLUlpAmA4QByfFYk3U35tGkHD4bmrclJk8K?=
 =?us-ascii?Q?3EK5G866YDQj9CM8Jnn/nTrgSiefGaVoVu9OWHITineltRHbRJoi7Wd3SYlo?=
 =?us-ascii?Q?eNvu+uyB3O5c8GHtHD85dDH0UGgd3YC0VFdH0WShgNG4qad3dYarNtN0pk73?=
 =?us-ascii?Q?xWteTQ2pZMFhUpsmWFARkS1GnCzzTIfQZoEqepgZMutUTYvk3WKpXkVG926q?=
 =?us-ascii?Q?xvgwg14=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(52116014)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XXkDJzymal/8aWbNE7eQ0BBT+iXuytBrQIIveQQeRK8QQzojCYbtdqnGEz1X?=
 =?us-ascii?Q?uyspPuJkg3LEbZ8U4qFlw4kQo56fxa4dL69xe+WczsCA7jNXalU8FhXvTAic?=
 =?us-ascii?Q?nuNSSfEnuVeKOg/QZ4tm9JUWwnTjc2p3WsWPDH6UjZFvp55Pw1BErjiFqidR?=
 =?us-ascii?Q?8DrIrtEi4jMSqDNdeHw0ocqmgkWJZuSSOBCD6Y5ioDFqS9l4UbCZXA7YYHs8?=
 =?us-ascii?Q?y+6HqtOnaoJG3rync/PlzgLo2t+loJpE8pmHZ58hOkBQYkhQC75IlAeYbDzA?=
 =?us-ascii?Q?C8Ima6EfkkVqFl0UYaSCiX9xILGzL+OGNmAkMM8qF6YkUVXUrfY1JbrK56BE?=
 =?us-ascii?Q?Vb/UELQhK98jeyMT/1Z++Mgj3kQHuQhpgpuJuQr+gULGauSwV64kn8pIvz/M?=
 =?us-ascii?Q?7Sq7Qmnr3XNZPZxN+qQIzHCAPLFkwjBPTwAPq0MtvtPZACW0JCSwTrwZt00Z?=
 =?us-ascii?Q?svXDIWzXD9prc7/eEYbdu1dgYYO3a2phjsh2mkqhTdJRFhVvyB0+ZwfO6v7D?=
 =?us-ascii?Q?Lz2yvTVAXu3NeoZIo8HxqtNzCcyn/nEfj6DwktMyy1KeaXsCd/++0aR67QGM?=
 =?us-ascii?Q?N9DM4SkXq+A0iMRnzk1Gc0BwZ06Gx/FL+BCllw+KM/NMxVzgrczh8qt+GDiH?=
 =?us-ascii?Q?eJ6J//AZyRuY1d6OrKdg5t36uvgkM7N255CKofrtiF6XA7U46u6XyTtzK++9?=
 =?us-ascii?Q?HKn/B3LHVVg4RU75qpMSTz9ScfSL+fQJY/85XmJsjuYnS94u991MaBvCblUa?=
 =?us-ascii?Q?4EuuQTtvpQx792fIEV7sOGFE8ReWJYaPrYEFDl7z5IYowgh36xCIXDkrx1BA?=
 =?us-ascii?Q?TvQc79Sbzx6XXmSnqCd8nIZDfypB/LSE0hfmhUmWQMBmxZxKn5XqUS56D+9E?=
 =?us-ascii?Q?efWEnZz3dDqJjJAvk8u62rjc/qt2N7Jpy2Jk0+K/tFTd3kQgpUwFT7kiSo8T?=
 =?us-ascii?Q?3x6FY0mN7oGTUl5+o88uikT3TjfXCd1bU8aKlggeM/ZFESB0YHHZt9pC5PuG?=
 =?us-ascii?Q?zfq8zYrD7i+Chf1TpSTf0FyBpiAwTyOuqeIiKWIYMCNZhnlBP/zEg6QBAqQT?=
 =?us-ascii?Q?0tigZeY6QhcU8zQkMyaXkjRsnFHdMhkZSe9W+nWLZ5/uPwkfzzjVVODuE/ur?=
 =?us-ascii?Q?DRMGgMzNIZmzhCO7xlojdD7ppYbKiLF4fB9ErI38EEDZgRY71Deo56Azn0jF?=
 =?us-ascii?Q?Lessx5TH+FnxL+SjWUJPzD48l05mmwk7+xYWb+ACNm/TWTLnoTqTtg+/Ycee?=
 =?us-ascii?Q?F9xeQqDMiWahTI638PFEjz+8rWSjPiqilmgrSMfVE45e8CJw57sESI8FIj0H?=
 =?us-ascii?Q?zZoiZGqU8eFBS+M11Fu45wS5RjvGGr4Q+qTe5Cl3rw6EtZcvUnRsqgRq0ral?=
 =?us-ascii?Q?h6ziRdaSbxj7UIKHCdoGoC5SGaVYZ8Vtrd+xKYt/W7oFTQztDmn2z/kA1M8y?=
 =?us-ascii?Q?ZMDjG+yl6QoEZYXqA/Nan9AfjeYz2DQGo8lZdGv/np0ZppNYYrBjtNZG3v/o?=
 =?us-ascii?Q?apFskrMToQnBC33H2fyoJPhyHWVmpO7nip/GTPWy+acpYpDAOhKjSbxa3hIl?=
 =?us-ascii?Q?XMLplsFuyw4yOlaEeh0OWAfc7y/RJzRHBeK0J5Q/0BPP2AnmKi+xBJQXpA7O?=
 =?us-ascii?Q?LamQQteG4bMSPMcdG3sDfmHYF9jB6b0rpaV0glgcoj4VoZQfnZIA+lHbA+BM?=
 =?us-ascii?Q?eRjKywi0jhElIqADeO2xRuGzCew=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6d3f1d-9a2b-4c5c-2eb6-08dddf5b5941
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 20:02:39.1214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ir8zVN8zA8BFaIpM6tj1luvJ5qefGOUQGznnyfIdKkJZTE6Ym6OaH91F+UMNtQR3PxcXcI6tWHckCrwGOjQ/pJU9gWdh5clU+h/NMfQIb0OfTPcrz9gYERdJRqQw18h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6542

From: Linux Bot <linuxbot@amperecomputing.com>

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

Previous implementations of the pcc version of the mailbox protocol assumed the
driver was directly managing the shared memory region.  This lead to duplicated
code and missed stpes of the PCC protocol. The first patch in this series makes
it possible for mailbox/pcc to manage the writing of the buffer prior to sending
messages.  It also fixes the notification of message transmission completion.

Previous Version:
https://lore.kernel.org/lkml/20250811153804.96850-1-admiyo@os.amperecomputing.com/

Changes in V25:
- Use spin lock to control access to queues of sk_buffs
- removed unused constants
- added ndo_open and ndo_stop functions.  These two functions do
  channel creation and cleanup, to remove packets from the mailbox.
  They do queue cleanup as well.
- No longer cleans up the channel from the device.

Changes in V24:
- Removed endianess for PCC header values
- Kept Column width to under 80 chars
- Typo in commit message
- Prereqisite patch for PCC buffer management was merged late in 6.17.
  See "mailbox/pcc: support mailbox management of the shared buffer"

Changes in V23:
- Trigger for direct management of shared buffer based on flag in pcc channel
- Only initialize rx_alloc for inbox, not outbox.
- Read value for requested IRQ flag out of channel's current_req
- unqueue an sk_buff that failed to send
- Move error handling for skb resize error inline instead of goto

Changes in V22:
- Direct management of the shared buffer in the mailbox layer.
- Proper checking of command complete flag prior to writing to the buffer.

Changes in V21:
- Use existing constants PCC_SIGNATURE and PCC_CMD_COMPLETION_NOTIFY
- Check return code on call to send_data and drop packet if failed
- use sizeof(*mctp_pcc_header) etc,  instead of structs for resizing buffers
- simplify check for ares->type != PCC_DWORD_TYPE
- simply return result devm_add_action_or_reset
- reduce initializer for  mctp_pcc_lookup_context context = {};
- move initialization of mbox dev into mctp_pcc_initialize_mailbox
- minor spacing changes

Changes in V20:
- corrected typo in RFC version
- removed spurious space
- tx spin lock only controls access to shared memory buffer
- tx spin lock not eheld on error condition
- tx returns OK if skb can't be expanded

Changes in V19:
- Rebased on changes to PCC mailbox handling
- checks for cloned SKB prior to transmission
- converted doulbe slash comments to C comments

Changes in V18:
- Added Acked-By
- Fix minor spacing issue

Changes in V17:
- No new changes. Rebased on net-next post 6.13 release.

Changes in V16:
- do not duplicate cleanup after devm_add_action_or_reset calls

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

 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  13 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 379 ++++++++++++++++++++++++++++++++++++
 4 files changed, 398 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0


