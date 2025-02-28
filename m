Return-Path: <netdev+bounces-170826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0BBA4A14C
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 19:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BA23BC95F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434321C1F0F;
	Fri, 28 Feb 2025 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PEL32+6Y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C441F4CBF
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740766767; cv=fail; b=bi7SBo3bP3lYbAuAc1hsrDFF4OFF/X0tG4QHcVUsxyAB9u2eTkOmeoaG57oa2OyNEjh97g6IO/VyvEfeUnvgiXP3DUbOh4/BNOJ/1UBuMRcKm0P797lPfDjeNZtmbVxOzqk1z9iyxaUAOfGRJvtg7j7Om8F/WAWJfykCpvohNHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740766767; c=relaxed/simple;
	bh=PPkeseZCm1i7d3VIv9KX7uLaiOtyP9rmHlPRA5FCB90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fV8p46Yx6ch5Us/vuIFG+pVRITU4T1NP6vVgr5dnQRt4B90HxlaQyTpOLo8LKVDhlaSi5h6b0XA4ahA8TKNPdrcXLnjUG+rLXU1btyHVAVgMbLDM6EgtXBlOGYWC3jDnDwZLtuGNhf0BXnX72enfyB1zEnw2NBMoFb7MgjORsS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PEL32+6Y; arc=fail smtp.client-ip=40.107.96.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFzoLHjJueTVTKB7Dhdu97KK2AesWW1ES4CijBzlZFugGAc0dlwMWgM00gcpy2ykCkitVRlsFzkWmYyUapLbgbgGlrMC7CSIn3TVXVfwDv7v1VHkX6B1EA0j5F9Wyh5rrQhTh5EgKQWch8nTq0R+LtKfIBhqVssJxu9z42ydLIN3TsiQWvv7pd7z63tXtnTeEtlRbwroKdRIUYv/gqgXHXGVexc+GqDo8I90jCXGxQ2d/mtAg669zmgxif0Yodams+cdoNQDZyO48f8PcA9/VPIBoWZb8QcDpJXufHuJokMFIIcjMEXdoTKbMKwoIBZU6XUM2CM+KP1pTAlw/EtvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FItGnhI2b1682ms2k4Be8DJsPddOtG7hQ+aMfDPKf34=;
 b=JaYtHUO+nZ8+CKNzBqlT3zOY4dyYgxkzz9PEgrqz91a/mcJtaeHwcGbOSA1lYC/ZsyR0SXbc52ZY3wPTuASSVZyw1tX/2Uy+ATZD9KbCJjbOSCU59r9bGbhyh1GT7bissCaICiIiOHzVW0Dl0FMHnjCwG5K/SxvIslGmL976+11jcmgHHsBN+s/RssJ0eN71tGoEeHc1W4SIX9cBuMLliO/3p9X2w0aMQrliWyDFoaKqIe6vLFl79zKBQTo4+4KHZDEXS9zBpzfRXwoYtYZT7Htt3B1JJWCZ77x+p5qdW46OiBq0Hr2Ly/jzPYi5nZwELYquOlnVi2SPwnT1GwbKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FItGnhI2b1682ms2k4Be8DJsPddOtG7hQ+aMfDPKf34=;
 b=PEL32+6Y+1ujWg/w0wnNGlEv96A1gFTOFy6wsGNsMSAhC2wSeG/yiK/29ru2joEBb7LTSgx4pZDqur7Cs0pTOa3XnitWPm6yFBugYNSQN/yiyVEDxGGI1eIpobZYyk2DhcjvFZmKgxuY+ZIac0bdZ5beF35neivKN5f0N0lqoZPeJpPFpGIgbUxtOUHyrp53frPz+MpvPaOQYFMYnNtMHLSm2o08vA19B2X9JfyatFySr7upKYimDgAjzqgxZ66ipE2t76X2iSQwIFSVxDJ4b7zIXAV2/mTLjABZ7hDhRGg88c4GbUbt1OdEiT50Ju1w5prI0pjDLpnfeWLjMjbEeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 18:19:21 +0000
Received: from IA1PR12MB7663.namprd12.prod.outlook.com
 ([fe80::4846:6453:922c:be12]) by IA1PR12MB7663.namprd12.prod.outlook.com
 ([fe80::4846:6453:922c:be12%4]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 18:19:21 +0000
Date: Fri, 28 Feb 2025 10:19:19 -0800
From: Saeed Mahameed <saeedm@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: Re: [PATCH net-next 04/14] net/mlx5: Implement devlink enable_sriov
 parameter
Message-ID: <Z8H-JyRRkknKj0Di@x130>
References: <20250228021227.871993-1-saeed@kernel.org>
 <20250228021227.871993-5-saeed@kernel.org>
 <uovifydwz7vbhbjzy4g4x4lkrq7htepoktekqidqxytkqi6ra6@2xfhgel6h7sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <uovifydwz7vbhbjzy4g4x4lkrq7htepoktekqidqxytkqi6ra6@2xfhgel6h7sz>
X-ClientProxiedBy: SJ0PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:a03:333::14) To IA1PR12MB7663.namprd12.prod.outlook.com
 (2603:10b6:208:424::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7663:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 889ce8a2-167f-431c-0c88-08dd58246bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1/j8VcwjFDBulKISTUQH+fF4lRoB3mqX+fPohWyzoWaaHC2USIoEk/xHoiJp?=
 =?us-ascii?Q?xSDQuV8Odm5bUtFV4V5TY1cqShcO1ivA8AsVeC5V2N7SNCoGf+W51RwpOjy/?=
 =?us-ascii?Q?gVKMBqCWvlN1hjjJVM0e8IAwEROcO2tLlKiTFX15/eyFhaCllX7A2z/xiJry?=
 =?us-ascii?Q?t/xlPVOeai9ujDqTRkIl9EvZXUEMqRoAi4glhs0bzX5TCvnbwZYlypqDEhJL?=
 =?us-ascii?Q?hQ/Sej/d5NbFJmyjMfeFLNQu28dXj3+dG6HaHSVI0E+NYrvJsUpV0DTSBMHB?=
 =?us-ascii?Q?Hnfx+DfjGGeJ9A7N2sLA8yCBPgauZhfjLey54rLy1NSr0Os9CJCGeDxI1ga7?=
 =?us-ascii?Q?7zuND4o2+WLPzdIhvrPw1RNea3R4sj6G6DAvzrx98970fvXNw+wqMzz+r9Ac?=
 =?us-ascii?Q?/9wUrSm6nxa1bCa5b2fRxJjnTF0mHAaBlhU3ETRbs99Lj3BmWhIl3lpSNhu0?=
 =?us-ascii?Q?z+pr/YawBZ6psRHQ68yYFKf8fl07EwBwexmKYXyq8KJNRA+lRe5LCvFwCt0C?=
 =?us-ascii?Q?Pv80F49WdyOqWWcNgsZK0GbbCnGmDZW+ox0dkhtEF1xhR1+MuRVlZiyOYZRa?=
 =?us-ascii?Q?dSD1KqhyarEM7wFXT3P46tG1iZoG0kwPNG/SrO/3+mekU61NJLNIsugfqO5u?=
 =?us-ascii?Q?xeVCe2y6e40gfCWTa7rFjGYeOB4kYdD8oy7V2M4FMpK+tmDgujmgvzbSjO4D?=
 =?us-ascii?Q?uaSD24PaelLsdJPsZn5LQaMWJB5suU3Gz24J8ems/BymXg3u++61lCny7GwD?=
 =?us-ascii?Q?TFHg3E/LkB2GgoRQc3/82EWvtmJvkBx7AciUaHoLntekuDKjSOnH94h+XAzL?=
 =?us-ascii?Q?39r5faG+ft2riMFwqDjAFRX7e742qgPaHjW3G9qv6fPP3oXmcinEYIbSBkpA?=
 =?us-ascii?Q?MnjcaapWCM+9TC+2wNskft0R8FqQ3cwVPuae6NtTikcJklPjTNUKqxRbGa6m?=
 =?us-ascii?Q?AQzMPkNj9WEiRrbRFhaD27/DIgh+eQXN4us/tW+kTdXDgLjON89EgBz7ungE?=
 =?us-ascii?Q?sIwvSnoOWiValMdOe4S7I2jyddBKgxXNu/IssiwXf3tC/LymoDTTpAGIsowk?=
 =?us-ascii?Q?j8QFqx55Qx+jEs+zzLop88jH81W6v+2eJA/cZ0IVie+1J5A5oWK1vffBE5nl?=
 =?us-ascii?Q?3E0CeHCObhrmcB7aMhtwgx5P5qqGpCi0MKCqubd0cC99RXisGhKwMGi1BnFN?=
 =?us-ascii?Q?H9Ep9Z9lWSkH4OWDBjcKhh1DqcR5KdXN3d/emk2rR0P1p+BT36RmNFhx4mcj?=
 =?us-ascii?Q?gH6ajQK1UutVGtbnZvgat7xnfIHcQC1wx00a3Q2D9+A5BycMicPwhykycVoK?=
 =?us-ascii?Q?2xTLOLU6nfytvLMAvKNFhHaqVTMPwEVcwzTyojbsboF01ZGlRZOMJ5okDOyy?=
 =?us-ascii?Q?+33EpaihAPQsStd5Q1KBbwJ8kg5n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sazcB3xjys/sUQOSZKXI8vvmnrM6/L46mmu+4eWr9dN88WO2IPxRL1lnf9qy?=
 =?us-ascii?Q?B1ggWrrHFHmB8ioy683GJOQHLp/3kmPTSJObzSQSaxr4PBFetu418F5g/jbD?=
 =?us-ascii?Q?Y4CNisx9PmHSAYguvWNsjzt36mkRhudtmm6Zo5rtEvkw+n7/JSO5iWDoV5tB?=
 =?us-ascii?Q?/lSspICoD/krPQc0MksRA08+h/+gEHq0vYrW93QWb+yHpeKDKWRZWLe/retq?=
 =?us-ascii?Q?K9vs8eEgltWPaMkyk1rBUwbkTEfGoFH51t7NgcHoGmxtuJXVXVkLAmqaKx9b?=
 =?us-ascii?Q?s+H0SgIVASdF/WQCoANgKhOv/MfcdeFWMVtiNG5BiSbT+XrGNrKnHDZWoaHj?=
 =?us-ascii?Q?A1ZvGCb6IoNPcFwIiFefAJ8vhu1Y0mD+dipXkt43R3y+uJcSKLWlM1JTTaGg?=
 =?us-ascii?Q?27k1Q/iuts99esl/PsQN1Y/ismv8nQysRLds5B4Dxh6gDBXCfcwGpsZ8x8n4?=
 =?us-ascii?Q?y/Jnj1VAqM7xGzY2Bprs/Db/2IkwJMe3sxmpo73amNJm1AcQgwWWo1z6Aphr?=
 =?us-ascii?Q?xKCbutn7biEZiU2CuH5xgWhnYMzpMcz+W6F7wT29WK/yAhsn3D0mrNig9UjB?=
 =?us-ascii?Q?RRiZCzEB7bbRkgQJQFUzE7Q9tZep/dihd201tD1m62LAYOyO4kUU/ZA2ac7C?=
 =?us-ascii?Q?LXMPZV4OvMaXPSMpRwvLoQpA7/ZnW0AG7k8CRirraMY4yedIdr6Y0MwUHDTs?=
 =?us-ascii?Q?oldOPMdME5YbGiKNhNvFaAh1GYaOW5VM0C+RJzNI7NxbbTPvIu2sA1dBvWZK?=
 =?us-ascii?Q?7iQ9dNZHtKrXQQUG5OxzfEnEvsvWR6+iNpaQMSx1i0ve8OttOyt06dCAYt9+?=
 =?us-ascii?Q?opUHsABFL63Yd5MXY6ZIN6L4bv97WP4bFuAtYtjo22Bmgf8tzjZHpF6kQLL8?=
 =?us-ascii?Q?za1DXMZxJkFcbg8izCklLC2c9vivb0baL5z190GHyuH3qndWV2BMNFODG18c?=
 =?us-ascii?Q?0tspX4dn23DXAj/Jsgb8S7ZKoU6dP5SiyeqO++ulMd3iCB4nWlefRUpM4HSV?=
 =?us-ascii?Q?9Y71O8GiFoUF7+oTBjTu3zI8Mkgur9IQnx1xj8b0izabh2Mpvwaz/zkgD/uI?=
 =?us-ascii?Q?v7DMDvKq1SuaPD9qp7clx10tSVXV7cyPdNQYVJZr5EGjINdSiMM9lUE+Mrxa?=
 =?us-ascii?Q?XT3BVC/o4o3q9EO7fa+wRi+Au0eRjywQP1Ut8WitHOBXEk012mB+QU4XFluU?=
 =?us-ascii?Q?2/uIiVdxIHQM9iwZRYgPrNFiQLGyLvaroa79W53o3Dz7sXg7yk7DG07ny4N/?=
 =?us-ascii?Q?ZUnD4jxMiijxpKt8Ts5h3PfJX2EdwjA0cApeYLCziPS737KwSDmCp1K9Emch?=
 =?us-ascii?Q?kb++PH7Xsav7eKxtpVXbz8GpYuHZVQfjtqYO4KPNdQvAux9MVqN0BMjKoG0j?=
 =?us-ascii?Q?r8L8YxuIwMvJOxWduCe6VkX/7TsFeWMsyCY04bUtYHol7HHAg75fYBBvtY0B?=
 =?us-ascii?Q?THiivg0a2S9PZQcdZSGETKtn9IPrQl3zBfFuC1lgmcAy3MKuEenArrzAS5G/?=
 =?us-ascii?Q?zfmO485av7IrW4PESeCAGswK6GogWm5nwqePtFlbzvYfX60aL7sjMdbPweqm?=
 =?us-ascii?Q?jJRZT+3PFNVcvVSP42Vv2cdmx2zempCZcVY7kMBE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889ce8a2-167f-431c-0c88-08dd58246bf6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:19:21.1605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EndA5IHFFHWP2U3qoCoEqCwL3TANv/sTUnq8Oqdcltyv/JNS24vECnObPdyJX5d1G9BuufKk3fRj9rr/jola/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

On 28 Feb 13:46, Jiri Pirko wrote:
>Fri, Feb 28, 2025 at 03:12:17AM +0100, saeed@kernel.org wrote:
>>From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
>>
>>Example usage:
>>  devlink dev param set pci/0000:01:00.0 name enable_sriov value {true, false} cmode permanent
>>  devlink dev reload pci/0000:01:00.0 action fw_activate
>>  echo 1 >/sys/bus/pci/devices/0000:01:00.0/remove
>>  echo 1 >/sys/bus/pci/rescan
>>  grep ^ /sys/bus/pci/devices/0000:01:00.0/sriov_*
>>
>>Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
>>Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>>---
>> Documentation/networking/devlink/mlx5.rst     |  14 +-
>> .../net/ethernet/mellanox/mlx5/core/devlink.c |   1 +
>> .../mellanox/mlx5/core/lib/nv_param.c         | 184 ++++++++++++++++++
>> 3 files changed, 196 insertions(+), 3 deletions(-)
>>
>>diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
>>index 417e5cdcd35d..587e0200c1cd 100644
>>--- a/Documentation/networking/devlink/mlx5.rst
>>+++ b/Documentation/networking/devlink/mlx5.rst
>>@@ -15,23 +15,31 @@ Parameters
>>    * - Name
>>      - Mode
>>      - Validation
>>+     - Notes
>>    * - ``enable_roce``
>>      - driverinit
>>-     - Type: Boolean
>>-
>>-       If the device supports RoCE disablement, RoCE enablement state controls
>>+     - Boolean
>>+     - If the device supports RoCE disablement, RoCE enablement state controls
>>        device support for RoCE capability. Otherwise, the control occurs in the
>>        driver stack. When RoCE is disabled at the driver level, only raw
>>        ethernet QPs are supported.
>>    * - ``io_eq_size``
>>      - driverinit
>>      - The range is between 64 and 4096.
>>+     -
>>    * - ``event_eq_size``
>>      - driverinit
>>      - The range is between 64 and 4096.
>>+     -
>>    * - ``max_macs``
>>      - driverinit
>>      - The range is between 1 and 2^31. Only power of 2 values are supported.
>>+     -
>>+   * - ``enable_sriov``
>>+     - permanent
>>+     - Boolean
>>+     - Applies to each physical function (PF) independently, if the device
>>+       supports it. Otherwise, it applies symmetrically to all PFs.
>>
>> The ``mlx5`` driver also implements the following driver-specific
>> parameters.
>>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>>index 1f764ae4f4aa..7a702d84f19a 100644
>>--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>>+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>>@@ -8,6 +8,7 @@
>> #include "fs_core.h"
>> #include "eswitch.h"
>> #include "esw/qos.h"
>>+#include "lib/nv_param.h"
>> #include "sf/dev/dev.h"
>> #include "sf/sf.h"
>> #include "lib/nv_param.h"
>>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
>>index 5ab37a88c260..6b63fc110e2d 100644
>>--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
>>+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
>>@@ -5,7 +5,11 @@
>> #include "mlx5_core.h"
>>
>> enum {
>>+	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CONF               = 0x80,
>>+	MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CAP                = 0x81,
>> 	MLX5_CLASS_0_CTRL_ID_NV_SW_OFFLOAD_CONFIG             = 0x10a,
>>+
>>+	MLX5_CLASS_3_CTRL_ID_NV_PF_PCI_CONF                   = 0x80,
>> };
>>
>> struct mlx5_ifc_configuration_item_type_class_global_bits {
>>@@ -13,9 +17,18 @@ struct mlx5_ifc_configuration_item_type_class_global_bits {
>> 	u8         parameter_index[0x18];
>> };
>>
>>+struct mlx5_ifc_configuration_item_type_class_per_host_pf_bits {
>>+	u8         type_class[0x8];
>>+	u8         pf_index[0x6];
>>+	u8         pci_bus_index[0x8];
>>+	u8         parameter_index[0xa];
>>+};
>>+
>> union mlx5_ifc_config_item_type_auto_bits {
>> 	struct mlx5_ifc_configuration_item_type_class_global_bits
>> 				configuration_item_type_class_global;
>>+	struct mlx5_ifc_configuration_item_type_class_per_host_pf_bits
>>+				configuration_item_type_class_per_host_pf;
>> 	u8 reserved_at_0[0x20];
>> };
>>
>>@@ -45,6 +58,45 @@ struct mlx5_ifc_mnvda_reg_bits {
>> 	u8         configuration_item_data[64][0x20];
>> };
>>
>>+struct mlx5_ifc_nv_global_pci_conf_bits {
>>+	u8         sriov_valid[0x1];
>>+	u8         reserved_at_1[0x10];
>>+	u8         per_pf_total_vf[0x1];
>>+	u8         reserved_at_12[0xe];
>>+
>>+	u8         sriov_en[0x1];
>>+	u8         reserved_at_21[0xf];
>>+	u8         total_vfs[0x10];
>>+
>>+	u8         reserved_at_40[0x20];
>>+};
>>+
>>+struct mlx5_ifc_nv_global_pci_cap_bits {
>>+	u8         max_vfs_per_pf_valid[0x1];
>>+	u8         reserved_at_1[0x13];
>>+	u8         per_pf_total_vf_supported[0x1];
>>+	u8         reserved_at_15[0xb];
>>+
>>+	u8         sriov_support[0x1];
>>+	u8         reserved_at_21[0xf];
>>+	u8         max_vfs_per_pf[0x10];
>>+
>>+	u8         reserved_at_40[0x60];
>>+};
>>+
>>+struct mlx5_ifc_nv_pf_pci_conf_bits {
>>+	u8         reserved_at_0[0x9];
>>+	u8         pf_total_vf_en[0x1];
>>+	u8         reserved_at_a[0x16];
>>+
>>+	u8         reserved_at_20[0x20];
>>+
>>+	u8         reserved_at_40[0x10];
>>+	u8         total_vf[0x10];
>>+
>>+	u8         reserved_at_60[0x20];
>>+};
>>+
>> struct mlx5_ifc_nv_sw_offload_conf_bits {
>> 	u8         ip_over_vxlan_port[0x10];
>> 	u8         tunnel_ecn_copy_offload_disable[0x1];
>>@@ -206,7 +258,139 @@ static int mlx5_nv_param_devlink_cqe_compress_set(struct devlink *devlink, u32 i
>> 	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
>> }
>>
>>+static int
>>+mlx5_nv_param_read_global_pci_conf(struct mlx5_core_dev *dev, void *mnvda, size_t len)
>>+{
>>+	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, type_class, 0);
>>+	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, parameter_index,
>>+				  MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CONF);
>>+	MLX5_SET_CONFIG_HDR_LEN(mnvda, nv_global_pci_conf);
>>+
>>+	return mlx5_nv_param_read(dev, mnvda, len);
>>+}
>>+
>>+static int
>>+mlx5_nv_param_read_global_pci_cap(struct mlx5_core_dev *dev, void *mnvda, size_t len)
>>+{
>>+	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, type_class, 0);
>>+	MLX5_SET_CONFIG_ITEM_TYPE(global, mnvda, parameter_index,
>>+				  MLX5_CLASS_0_CTRL_ID_NV_GLOBAL_PCI_CAP);
>>+	MLX5_SET_CONFIG_HDR_LEN(mnvda, nv_global_pci_cap);
>>+
>>+	return mlx5_nv_param_read(dev, mnvda, len);
>>+}
>>+
>>+static int
>>+mlx5_nv_param_read_per_host_pf_conf(struct mlx5_core_dev *dev, void *mnvda, size_t len)
>>+{
>>+	MLX5_SET_CONFIG_ITEM_TYPE(per_host_pf, mnvda, type_class, 3);
>>+	MLX5_SET_CONFIG_ITEM_TYPE(per_host_pf, mnvda, parameter_index,
>>+				  MLX5_CLASS_3_CTRL_ID_NV_PF_PCI_CONF);
>>+	MLX5_SET_CONFIG_HDR_LEN(mnvda, nv_pf_pci_conf);
>>+
>>+	return mlx5_nv_param_read(dev, mnvda, len);
>>+}
>>+
>>+static int mlx5_devlink_enable_sriov_get(struct devlink *devlink, u32 id,
>>+					 struct devlink_param_gset_ctx *ctx)
>>+{
>>+	struct mlx5_core_dev *dev = devlink_priv(devlink);
>>+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
>>+	void *data;
>>+	int err;
>>+
>>+	err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
>>+	if (err)
>>+		return err;
>>+
>>+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>>+	if (!MLX5_GET(nv_global_pci_cap, data, sriov_support)) {
>>+		ctx->val.vbool = false;
>>+		return 0;
>>+	}
>>+
>>+	memset(mnvda, 0, sizeof(mnvda));
>>+	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
>>+	if (err)
>>+		return err;
>>+
>>+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>>+	if (!MLX5_GET(nv_global_pci_conf, data, per_pf_total_vf)) {
>>+		ctx->val.vbool = MLX5_GET(nv_global_pci_conf, data, sriov_en);
>>+		return 0;
>>+	}
>>+
>>+	/* SRIOV is per PF */
>>+	memset(mnvda, 0, sizeof(mnvda));
>>+	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
>>+	if (err)
>>+		return err;
>>+
>>+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>>+	ctx->val.vbool = MLX5_GET(nv_pf_pci_conf, data, pf_total_vf_en);
>>+	return 0;
>>+}
>>+
>>+static int mlx5_devlink_enable_sriov_set(struct devlink *devlink, u32 id,
>>+					 struct devlink_param_gset_ctx *ctx,
>>+					 struct netlink_ext_ack *extack)
>>+{
>>+	struct mlx5_core_dev *dev = devlink_priv(devlink);
>>+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
>>+	bool per_pf_support;
>>+	void *cap, *data;
>>+	int err;
>>+
>>+	err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
>>+	if (err) {
>>+		NL_SET_ERR_MSG_MOD(extack, "Failed to read global PCI capability");
>>+		return err;
>>+	}
>>+
>>+	cap = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>>+	per_pf_support = MLX5_GET(nv_global_pci_cap, cap, per_pf_total_vf_supported);
>>+
>>+	if (!MLX5_GET(nv_global_pci_cap, cap, sriov_support)) {
>>+		NL_SET_ERR_MSG_MOD(extack, "Not configurable on this device");
>>+		return -EOPNOTSUPP;
>>+	}
>>+
>>+	memset(mnvda, 0, sizeof(mnvda));
>>+	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
>>+	if (err) {
>>+		NL_SET_ERR_MSG_MOD(extack, "Unable to read global PCI configuration");
>>+		return err;
>>+	}
>>+
>>+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
>>+	MLX5_SET(nv_global_pci_conf, data, sriov_valid, 1);
>>+	MLX5_SET(nv_global_pci_conf, data, sriov_en, ctx->val.vbool);
>>+	MLX5_SET(nv_global_pci_conf, data, per_pf_total_vf, per_pf_support);
>>+
>>+	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
>>+	if (err) {
>>+		NL_SET_ERR_MSG_MOD(extack, "Unable to write global PCI configuration");
>>+		return err;
>>+	}
>>+
>>+	if (!per_pf_support)
>
>
>Hmm, given the discussion we have in parallel about some shared-PF
>devlink instance, perhaps it would be good idea to allow only per-pf
>configuration here for now and let the "global" per-device configuration
>knob to be attached on the shared-PF devlink, when/if it lands. What do
>you think?

Do we have an RFC? can you point me to it? 

I am just worried about the conflicts between per-pf and global configs
this will introduce, currently it is driver best effort, after that we
might want to pick one direction, global vs per-pf if it will be separate
knobs, and we probably will go with per-pf. Most CX devices support both
modes and it is up to the driver to chose. So why do both global and
per-pf when you can almost always do per-pf?

>
>
>>+		return 0;
>>+
>>+	/* SRIOV is per PF */
>>+	memset(mnvda, 0, sizeof(mnvda));
>>+	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
>>+	if (err) {
>>+		NL_SET_ERR_MSG_MOD(extack, "Unable to read per host PF configuration");
>>+		return err;
>>+	}
>>+	MLX5_SET(nv_pf_pci_conf, data, pf_total_vf_en, ctx->val.vbool);
>>+	return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
>>+}
>>+
>> static const struct devlink_param mlx5_nv_param_devlink_params[] = {
>>+	DEVLINK_PARAM_GENERIC(ENABLE_SRIOV, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
>>+			      mlx5_devlink_enable_sriov_get,
>>+			      mlx5_devlink_enable_sriov_set, NULL),
>> 	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE,
>> 			     "cqe_compress_type", DEVLINK_PARAM_TYPE_STRING,
>> 			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
>>--
>>2.48.1
>>
>>

