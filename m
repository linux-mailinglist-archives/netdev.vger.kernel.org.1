Return-Path: <netdev+bounces-219132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4614AB400B9
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BECE3B6587
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBB321ABAE;
	Tue,  2 Sep 2025 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="UzyhUhNZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2127.outbound.protection.outlook.com [40.107.93.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D32F215055;
	Tue,  2 Sep 2025 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816284; cv=fail; b=By6figEGJvXYMC4w1Jvev78sBgZW6e62rxwnw/P8r2FNeju1KXmYWafbM2iSqQQPd98ZrMp2TDJHB5BFz2KsWSHzZO7Dpdh2REaA+o3yN8HNrxY6uMBupt0bDVH7Ig4vsabquJ9etkBd9S4IB5qechQwGnfQljGaLL5wmAH/HmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816284; c=relaxed/simple;
	bh=AY2xzY/DdWIjapmpj4oQXo7QsSk5RF6fkS/oExxMwXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KYVr/IbKWLm1IRSjBjdQRLehRJZ9HKCvqosyb5LeDGOXTJHAsx1xswgQRbRm6QZXnxvKq9h94siT3F5qed2LkKAirzAp62HBRBbwjfxODJ3zRqPMDlTpuEQAxymspUdOMnvJ9fx+TRNlHY79EJGL4wgCZN2HWKCW1GD9nPioGvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=UzyhUhNZ; arc=fail smtp.client-ip=40.107.93.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERb25x0Y4uBzy9dL/VqeOOdRh6Qrlnt1QgtmCddI1/H/V5XQdkKWzjvxJUtW02Jj5ElVo9LAjWh/5ukc+d+rcHTdY8n6IXYBiZGYqr1iHB+3vSWfvEx7zi+QhiD0uopQiGWDj3UvZuJ7l0EYvuSCArNyN4vxspa+ITn7HpnG1VRcBRj4Iqfpmk/Coy3bXzPwegVAGOrTAEBxMo7mkJPjybvgnSC7BhpGcuOZbwAiNdIiXQq4VUzmzq4ZtpD94DslR3aPgPi2c0dL+zGSVc/W5UWZ26tpFp5UP29AhUUtH3BA4HmtsYMQZytoNdaxivTVOStNASpDVSPzt2QkJWRcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+Y1jqHsuMuUA6aXxlprcXtAkZW+HzrPuAkH5OjPX4I=;
 b=t+vwHZYf7knKR2l8Zhhmc7g3MkR0K7zWbXwu0O1x1oRbRrBpLy7pPdqoa6sc7/wph5jsvdb86eWqesoD9k48OxQdi28HF0YSAVzOCSO7hWL51QcBUeiiNI0hrCC768S9pb6jLYRBKinBIedH1CaT6/kWvI6F+hPLFNhP/E3OZ4O3CuYGq5wLp2qcaHeFLkLbei7257O0w75LUk3KD0V7CCMXUtGKpv4ri87KpR7dwavAZ63LRRyMDe9iOz3smiGJMn5qHEznnmrPVhoZByGLDK5v889KbQcP7ihtrGz2cCWEiNu7lidOF0aPV7mmgMbVXVYHOKt509WjDUiK4W9yAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+Y1jqHsuMuUA6aXxlprcXtAkZW+HzrPuAkH5OjPX4I=;
 b=UzyhUhNZgz3brJaB4WcEtN0nuwBA3MMbfKdzjguyMh+CU5tPvSA5e5jPO1j4uF1tfkmPE7840kZNLhKk9PZgg54diMJ8QHCW0BtQkCpWzTcpahenx3g9GpzKvd5tToUe4rVZCg1GWpDGnQrm5YHjRZzp6uJhFu4tFyaH1a7cLg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS4PPF3984739DB.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d15) by BN0PR10MB4903.namprd10.prod.outlook.com
 (2603:10b6:408:122::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 12:31:17 +0000
Received: from DS4PPF3984739DB.namprd10.prod.outlook.com
 ([fe80::ba61:8a1f:3eb5:a710]) by DS4PPF3984739DB.namprd10.prod.outlook.com
 ([fe80::ba61:8a1f:3eb5:a710%5]) with mapi id 15.20.9094.016; Tue, 2 Sep 2025
 12:31:17 +0000
Date: Tue, 2 Sep 2025 07:31:13 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Steve Glendinning <steve.glendinning@shawell.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v1] smsc911x: add second read of EEPROM mac when possible
 corruption seen
Message-ID: <aLbjkQF8mA5HGDfx@colin-ia-desktop>
References: <20250828214452.11683-1-colin.foster@in-advantage.com>
 <20250901135712.272f72a9@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901135712.272f72a9@kernel.org>
X-ClientProxiedBy: BL1PR13CA0265.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::30) To DS4PPF3984739DB.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF3984739DB:EE_|BN0PR10MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: 7018330a-5cfb-4c06-7d93-08ddea1c9c9b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H2Q9Q3/+MLMjqGRyw/s9qIsE6Iyoe1Z6aSIm4pwYIgh1EqypLH6FjqYyZtMH?=
 =?us-ascii?Q?aoca3xYcFNz/KhhsA4YFO4z5ju/NF3MOkcdXwZ4YzgGvWu3P+8ucZ7wTngNY?=
 =?us-ascii?Q?oHkjUTmlg1xiqFBUegNDqK0LDHWfa8KnmKrnfEJjIMrAyL/W1kQQLuN6HqaY?=
 =?us-ascii?Q?FEpcrH5xULGDbTYfZhyodWM+PLXGod6U5qcezkgn65GIOEUaKzZC+4bQjw+H?=
 =?us-ascii?Q?JdEIRpkqDtml/b9TmoG3MUHu8Zj98YmB2OhWK64UvtKXvu5vhs4QKiouEQL4?=
 =?us-ascii?Q?sriygFMLJrN7jDjIDYY5WZwZ5OaS+CfHqPCf7KKkTjLNOO0/E14fe7uHWG29?=
 =?us-ascii?Q?vxKItuqoKgW/4BQ399vL8vaSk3Igq1TAfa3TVLnTOamI8P6u7JBu98jJ1FXv?=
 =?us-ascii?Q?CGdeRAVxPfItotG4a7hA+PdRzEVSbl7+R16kUPCOZc907g4Ml/LzYwTDOip5?=
 =?us-ascii?Q?s/wTwJVSWBvcHnA0otfgMAe0aCxoZu4Yr+eXTKs4slJe9+P/WJUcKXc480vz?=
 =?us-ascii?Q?SJaGgn6NKEJGSkMPyK248kv1KAC3/dpj6Y+3qXW1asOJNap79BJUIJnhk332?=
 =?us-ascii?Q?2z0Wh/KjrbVBrqTanDNo4lEAm73OZ4CtsEy50RdKBfN9MiZiqT6P0wRil765?=
 =?us-ascii?Q?1k1yQ+caxwF7YOMijvixuBvbtnoe52YLXIPvfJLWJrV8ZI3jp7wL5r2eBRfo?=
 =?us-ascii?Q?y8AV/DC/V6W3DivPhVKLgys/D9A7skr2cBW6ZBm+m0XaiS6rpBsm2qaz3Dq7?=
 =?us-ascii?Q?61H545ffXu9yChgi5y/VhARpq6ntg6rteUlFhnXyv0hN39AY53hhz/RWX7ZN?=
 =?us-ascii?Q?l73fq1a/EaDjjp5FBrL7hOnhSIxVn/Bi7sFItIzO3G2FspIrvZ6+nxpDteeI?=
 =?us-ascii?Q?0ZQvzdrKZgo/ecO0/172U6hGZoEmhWW4lDqFOstVtTNhzKcUimCCP+0oW4p4?=
 =?us-ascii?Q?jGKUmSIKTCWenDDzOWn4+qcb5Hiu6ayuDjmVFAOqd5PEXX2GtKKmIK8azX/a?=
 =?us-ascii?Q?J1qvIpf1zC4XJivBBuRnCO339D0EJq2oqBIjJIIS9v+CFl6JjpLjAFBzz2Tr?=
 =?us-ascii?Q?0nSsH2YSfLAe7P7WI6T6v89+yxXTP8Bw8xxpSrFSFtH+NpVM8wvbhWZWsDtF?=
 =?us-ascii?Q?tcwTvoQ+thUaNE+Bov2I8ofHWoYOSMAusbfbhJhf3VjiRML6zcI4ZXcOZBWe?=
 =?us-ascii?Q?INDODyTetH9HfDYjfgzg4dNEiEQhMZCEvPaxxkBS9UIcy2/4rNa0ya8FH6Xs?=
 =?us-ascii?Q?ARO0x4fELj6a29l+cz6VsBvQ5PWKi+p6HwzBwPY3P/aCP3EJZcTltniWd7zx?=
 =?us-ascii?Q?FNwhPsVUEB9hGv4tdSZV5X7wC4p14abD1a7w9mqzLDm7u5pCF8TCCEC3sP05?=
 =?us-ascii?Q?ZUfqADdJNqnlTPkHQLWXRaO06N+6lvabnDxT1YkHKPf8VExMeEInqYu88lVP?=
 =?us-ascii?Q?VIO4jasTu+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF3984739DB.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YzhU69WHBShlvz/kZI/LhdBiJpsOgJlnRCIIcpvhlYe75E31RRFJ92pEFy4f?=
 =?us-ascii?Q?xtTs4hV+cqDn5rBBBK+o7LocTAkeJuzqiNe40aNjJ9TKT/9XqDcbumCixeM1?=
 =?us-ascii?Q?3PGDkZez/+cvw4rt/51LlbPs2MNDd7uCTx+1NyKKoKFY29sir9LlGfdRYtjL?=
 =?us-ascii?Q?/+x87fNnMAM76iMzViyKa3W1fT5nCJUQnJIpIUI5jFlC58tSDLMLxOx9s0Hm?=
 =?us-ascii?Q?zFaqC61k4/pjvOIV7Q1WNkXw7RoxG4m5oMEqERa32VXdai3z/WrU5pHLep9y?=
 =?us-ascii?Q?Shjk6l6lG+khpkARiZIgN0e1WXBEUW8e92BuNAm16By1pDqM5rngKVl5sxuR?=
 =?us-ascii?Q?EB+TW+SdpUfuaoliAx0neUO7pABJOumt+Gq8WRhmld6z+znfh0EuVaZuUa8S?=
 =?us-ascii?Q?s9jX6lj4djoChY9aGaiOscqtdbUZmVOqBhTCfBsog0uiA/tFRPggS35zqlwm?=
 =?us-ascii?Q?VJA0SdbFTlGFsZq6uByMwXwRYcrS1dJT+hjt3EcnGTlIcJV/6uZ4kr+T4UkD?=
 =?us-ascii?Q?VmJz6oATqCIe7/vEcWmky6stn++aOoTF80tEZfWUFpruL1tXG9vnUGECoiN9?=
 =?us-ascii?Q?gyNgDUdDOj3g6eE4Ev1ZiZHaF9ACsLwJ0UlyAwmPPiSgjC4KGXf/g7QicRKE?=
 =?us-ascii?Q?WsYvKnzpyhkuwZly9yARGPQYs15LewuGyM0p5Fs56zLv/xV2W9NyY43sjnIN?=
 =?us-ascii?Q?VDoppDwhW8lU+zIHRhoLgosyyEWK/ZBg08C7D1HR4jUP8r36kBvifdGpcJfv?=
 =?us-ascii?Q?Czj+KfiDwfrJPAZ++LdUWYY6lULrhGdRAuJRYR2UJlHy18dx1fgJqoSNFao9?=
 =?us-ascii?Q?QS+3ClGluYPUqWFglPbmCj+aygMpHroh2mEAlnrusefg/BwAKg4IWf1ihFG4?=
 =?us-ascii?Q?64tQkMZRhmAm/ZPiVnUef8uOBjugEEaZGBfodNW820v7tcrVnyc9kTY8UL8B?=
 =?us-ascii?Q?M1xU3A24VICfCZSxTPDl9UrgGidfbF6tAcuAHYuGk2lv+AUb1y9S2U44TOOi?=
 =?us-ascii?Q?VVKX8WZo5L/2Y2OVXo7xUBR8XeWcGM6d0A/HETGJuWBQYO3lNRDtSQ0RbzkV?=
 =?us-ascii?Q?9nGSWWmfludkRYZekzgXhEKJrm0VxIx+Ryituvku45cPGznfuMugJNkKH5aN?=
 =?us-ascii?Q?JbVTl6pp9BKE2EDLdYuKXxTVjkEvqKtcoc2Xjj7O6UvMqRbUU9d/qTbCxq9B?=
 =?us-ascii?Q?1kUrllgdlF1EmghTcUhDCxYAEZPwLypwBy/EmDJ385G+VbQXfxxVT5bA4Bcv?=
 =?us-ascii?Q?2XURYdMLfPX/TK8RC5rxy4QxJ1n8Am9O33/+bsYRcABWMf7eKgGWE+KmzKdD?=
 =?us-ascii?Q?hi4MTCXQYps3GOxqBoLBObkeqeHNhZ3MaWzjXY2URAKqQI1AGLR6YQZnnC2+?=
 =?us-ascii?Q?/OIFgU2bTSUls57bA5Wt3JiUmtmf+2gtZG/+tiYXyWY92IiDwVQN0OAqzcTf?=
 =?us-ascii?Q?OFIggT/IFlRTqfflBgGuOsqZMzcVvJqyAwkjIL64KlGwMjoEnGow6ChjneSd?=
 =?us-ascii?Q?AYySV0k6Es6BS2QmGrv27P/z1ddwh2ijD9cZ3pJjkTIzYx2SamEBCNQhJJT4?=
 =?us-ascii?Q?GWKE/BLR+g7ZPP5pdnHYNCC3qDbmDax/2zj52N5WQytMx+A0y5Thz4lT8CoV?=
 =?us-ascii?Q?Da2Cpr+/8fR6hrlVKbWK8VE=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7018330a-5cfb-4c06-7d93-08ddea1c9c9b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF3984739DB.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 12:31:17.0046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gK+DnzZcVnc042+6hf86r4ypYJBq98+hpYnbIQaCBnoMVRe1d3A1EE0DCP5xlD9VCs94oRNCrtmcB3afRmrqmYZ59J43tuDUI/W1Udbnquw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4903

Hi Jakub,

On Mon, Sep 01, 2025 at 01:57:12PM -0700, Jakub Kicinski wrote:
> On Thu, 28 Aug 2025 16:44:52 -0500 Colin Foster wrote:
> > When the EEPROM MAC is read by way of ADDRH, it can return all 0s the
> > first time. Subsequent reads succeed.
> > 
> > Re-read the ADDRH when this behaviour is observed, in an attempt to
> > correctly apply the EEPROM MAC address.
> 
> Please name the device, and FW version if applicable, on which you
> observe the issue.

I'll add that to the commit message. FWIW it is the Phytec PCM049 SOM.

> 
> > Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> > ---
> >  drivers/net/ethernet/smsc/smsc911x.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
> > index a2e511912e6a9..63ed221edc00a 100644
> > --- a/drivers/net/ethernet/smsc/smsc911x.c
> > +++ b/drivers/net/ethernet/smsc/smsc911x.c
> > @@ -2162,8 +2162,20 @@ static const struct net_device_ops smsc911x_netdev_ops = {
> >  static void smsc911x_read_mac_address(struct net_device *dev)
> >  {
> >  	struct smsc911x_data *pdata = netdev_priv(dev);
> > -	u32 mac_high16 = smsc911x_mac_read(pdata, ADDRH);
> > -	u32 mac_low32 = smsc911x_mac_read(pdata, ADDRL);
> > +	u32 mac_high16, mac_low32;
> > +
> > +	mac_high16 = smsc911x_mac_read(pdata, ADDRH);
> > +	mac_low32 = smsc911x_mac_read(pdata, ADDRL);
> > +
> > +	/*
> 
> nit: netdev multi-line comment style doesn't place /* on a separate
> line:

Apologies - that shouldn't have slipped through.

> 	
> 
> > +	 * The first mac_read always returns 0. Re-read it to get the
> > +	 * full MAC
> 
> Always? Strange, why did nobody notice until now?

For me it is 100% reproduceable. The first read is always 0. I've added
delays in case timing was the issue. I've swapped ADDRH and ADDRL and
the opposite effect happened (where the first four MAC octets were
zero). Re-reads always succeed.

Without the patch, the last two MAC octets are always zero.

We didn't notice it until we started hooking multiple devices on the
same network.

If there is anyone else running this hardware, I'd love verification.
Its an SMSC9221.

That's a long way of saying "I don't know" unfortunately.

> 
> > +	 */
> > +	if (mac_high16 == 0) {
> > +		SMSC_TRACE(pdata, probe, "Re-read MAC ADDRH\n");
> > +		mac_high16 = smsc911x_mac_read(pdata, ADDRH);
> > +	}
> 
> > 	u8 addr[ETH_ALEN];
> 
> Please don't add code in the middle of variable declarations

Ack.

> -- 
> pw-bot: cr

