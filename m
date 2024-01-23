Return-Path: <netdev+bounces-65127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1B68394A6
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4621C23A93
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE5164A95;
	Tue, 23 Jan 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rQ/+MkNZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA0350A72
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027334; cv=fail; b=N4bXKxOzixDM2wD4qm7YqZO5mtVANiEbWMyALtNs1DMGpag7baJ052uHOaxazHH3SbdR16okMQRSQA7cvY6LOisSfC4bE+Te41aZdG9dJL+wSi+vo0g2keWusLGCeL2pSSflwDd+k39gAREyqJmW+6+p7jFcIUyYDB2sHF9w20o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027334; c=relaxed/simple;
	bh=3Mv9hum1abLEnLrNIkMWWILFyECQrDDmfDgdfi0sf8I=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=SEy+IsWNcWsy2QqvNLuDriZ63CsqqkDdb6E4jwYSN7SbEeoPS7yw/1Os2ODMOuTaSC+jr5dN5F6/m2OpakBhfStcwgWCW7GVjOoxRG/6IpZUqBs0NnaJip8R2R+1ghSaAhPG/VDsVG8XPZKSd9p11a/F73AFyy8rnm5i0kti2KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rQ/+MkNZ; arc=fail smtp.client-ip=40.107.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxjcNj8Hmrev/O3yVYyNUH7vc5p0Nx/tRa6s1mSE2P+DZX8UwuO5eKHXUWaKxgNdGwIaoqWThprwEfov17rcF2UOPuG6Ii4+MLE/L560ScRRKZu8r7iDPETF0tkByWbvnPpwXygxGAX2K8qGk4f9530gfS19K8G38NjhyK/7UgjGXXM4SYHZU4uaG4+5n/Hn9oIAijQVBlQSaRBGQraQgMwjS/ABwxxEpqFnTqQblIOhAeULIqzC4b9wBGmkfl9WrlTYtSVT8m3HlZsFK4l/AcE7Vzyd9jtPsHbIG85Qdaj5nxQ3WtKRbSK8gcemphv8WYh3u0Xkk380TSuStcOElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwTN25bJOyGoLJx2z4ywYuwZfAjL6M/UX/K+Gq75x+A=;
 b=i4mPcCCqlCXtH7eJDzdCRmc7U8YQHcEIdmaRf13xV5Q1q7Wc2rVNR30/nF94211ip+4dKul0LUarlLtMSm0kXLSkBl+Znb+JgNGGRrhX+yVpNVKYk0eaJr3Eq6zrAtrjK+u9DKnx+vgIt8cvOUVGJNt1m//spnrWM6LmStZX8SraaGrwJ3hzJABXk25Vam+lesEnybarcXWmusNaV5ox1Q7aJ6FNY005ra89fFGF+LUYh9BFrCxwp+Hg9RxJPizw7tyFdvgVDK6j3xyYd6Jp2ArWvcA9SAAZiR1dx/2G9zEDU809SamI1aU3Yr1OcNONZZLyFJ8hWm0HdZBHomFd1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwTN25bJOyGoLJx2z4ywYuwZfAjL6M/UX/K+Gq75x+A=;
 b=rQ/+MkNZLxkzgScpyNKeH26CZ6T1xFXMZtCBpf6OV/C7f7M8JidhYZ+yUgbOjS4e5e+NFBp4IHZgX4SEMqE2kV40JFi6NYLplm7s9AG99GChYvElpyLhnJP8c5bjzdo1gfPYvp8VZ9gvKxXBMRVPLewKR3UKllxg3J4AhKAp6iTS5JEH9H+MWwtxQyXLyF4q7CS5npYpiGNDpSgnLt7BtneWCabpZumiAHAeawZ1QGFaxpGm6ZYrJ6aG6R2AvllSQtPNoexZ0ZPN26EOA+a/d1Z7x4kxFy6V8RdqX9pVDcU+c93nHMdJwOSmrs90XAHVVt7Z7sL/87hSrxScY27n2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ0PR12MB7005.namprd12.prod.outlook.com (2603:10b6:a03:486::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 23 Jan
 2024 16:28:47 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::d726:fa79:bfce:f670%6]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 16:28:47 +0000
References: <20240118191811.50271-1-rrameshbabu@nvidia.com>
 <ZazklN6D5oAio6J_@hog>
 <5532f8bea2241004c279bc6226a0f37df2720971.camel@redhat.com>
User-agent: mu4e 1.10.8; emacs 28.2
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, Gal
 Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, "David
 S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v2 1/2] Revert "net: macsec: use
 skb_ensure_writable_head_tail to expand the skb"
Date: Tue, 23 Jan 2024 08:27:04 -0800
In-reply-to: <5532f8bea2241004c279bc6226a0f37df2720971.camel@redhat.com>
Message-ID: <87r0i8m2td.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0107.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::48) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ0PR12MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 408927bc-2e25-49d9-d618-08dc1c305fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mv/i6hNttph+sgKxeYkIUjXNkgux7hIoAYwfl3KGk6gyI0GOOEaWtIJ4L+UuX42IqGf6NmGlSp5CoSyYDKev3TZt3am/VpY2UWop7OFncB7dGhWVhrEGOjE8oiICDL/gsvFgyVgkEkpJIDpc6YGJZ06D42V9NkSxNY92lgE5Qmx2GlCoDkd8k5CTPyisFMI3B1wNpbEqCp6fgxrKs8Qcw99sWo5tGn1KczseIb2wXYG8+qnE9ZPFJbgDz0veBh22zhfdR1rWGc6iMnmSVRdsMD4XRRD0RySmmShQZ47VgD4HicRA4/COQ1pk/ZJ1l0yB4ySHeKd4ZLymLs6djIW4kVKhU2HTXyvJrcsNMSLQ3LA7ltfofW/tvY4V79yMHqypYwP2qN111y0U01KO9sUUwK3XhcoF0rL4pfU1Rf8Ies8hGW8D7C08uTQiRgi/uU2Qn0xPgtdKohCqjXJQsPbzxCKO3EBxTdGb6ZNIAaH9hiaxcNmw/0sO3Xdr4wDwtJN9DXpA/voYI1adiqwP20PyxzKVfkNgkqXkVIN+KAJf0eSjuorsV1FhYHo45T/4yk1obAssxgg+Ld4L6cO4oyb3yWcSpHU2w5FbYSjK3P0ct/7DNJCtkJDudR3GPT3j8rxu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230173577357003)(230922051799003)(230273577357003)(1800799012)(64100799003)(451199024)(186009)(6512007)(6506007)(26005)(83380400001)(2616005)(41300700001)(4326008)(8676002)(8936002)(36756003)(54906003)(316002)(6916009)(2906002)(5660300002)(66476007)(66946007)(66556008)(86362001)(6666004)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?niajGO/Ax0yY+drCCmJUj382+W0C+sPXykL4g1NTlSM3aXImF56WRlilBeAN?=
 =?us-ascii?Q?aIKCJa6bWWE3myt3eCcL+mA0DdKIeR7/SpEDHflrhGiY7G783kY05nho+kK7?=
 =?us-ascii?Q?tAZ6cFsBqEET0+6FLl1X0pKAoDB60bGkYEuoBFuFaKaQxuNen6tToZNAad4R?=
 =?us-ascii?Q?12Wy3R3lRCdrdQ8Jtxfg1tBPi6kqvH49Uv+fTHaqx/RUQdb+K+H3Z5Lfy8eV?=
 =?us-ascii?Q?QnkFW4CbdmxZeH2iWjoYH+77c2Lv2/qPw9XAzHLlaytiEQahMbwI641Zh3Bo?=
 =?us-ascii?Q?yhXS30W16eK1hpagxFFF1S5vG6FxKw8Rp4IhcU6sAFVgBQ3elTuMtW/LjbIq?=
 =?us-ascii?Q?SBj9R9aEQVUU84fBR/KId/ybMuP5wVZjJ1BU4XsTrPb1XyYtJMtcYVTFo+WC?=
 =?us-ascii?Q?9EGfxwUQFHv7UdLYzJdd+xU+dehgHP4nHP1G9Zs8TTzG9y9yoF3ZzJ+n1/63?=
 =?us-ascii?Q?T0d94BJwrT5X8mIjt1Ri2nAD5wng4Y6LVfijjtdtc6GEODBwT5MWwdMqk8tl?=
 =?us-ascii?Q?jEdESmIW6fMyUvLZEcQ5pGp2fbf5Sk3kUwJO82vx6TWKormqW43K6pUdlbyt?=
 =?us-ascii?Q?4K1+U4LQNTJXD9wZnXYMtjj6WRrlYSKH+OVSPWj+AmvNQVMlYYey+8fwmBMG?=
 =?us-ascii?Q?E9F7BzClYjHr0cBXnI2HdiSqn/dXUi8dfwfezRWd8uCINWIYafeRdqLhtKxm?=
 =?us-ascii?Q?9189pIQluLwbNu9iA6IsiPD83jWXEJ1btL4XYJySrKOCxz5jYGUbBB4ae2Je?=
 =?us-ascii?Q?W1du+PZIFvVlLQV21bjUYqN2hN+JJWcIkKmgOFxDMPBWzLOdJKzP5aQahDfW?=
 =?us-ascii?Q?G4nSGNamcBFClfHzWdUvcZQUeLhzEPapN8o4RaTr2u8andBv8pA4JsDkmLR4?=
 =?us-ascii?Q?2aFfq7WovhpJYW0AN1ksg/ISS875S/MKUbtyQ0k16hGwoNjeIQgWFafV97dx?=
 =?us-ascii?Q?FUied6h/c1CHep8n0KfhCE/ifztJ3UOB2xAeGdGEK1QWS0uwWOZjTonYo+B7?=
 =?us-ascii?Q?S/SlD3PhFN9/s0560w+6CrxQBzxDVkQYtpPL1qesNbNnd3QPGZn1DfBx7QbB?=
 =?us-ascii?Q?gjDQTMzlETZYUZbAccl/kxuFAkJKVICiuuamsPfouHfE9NTpuqxnsZqy65X3?=
 =?us-ascii?Q?dfzMhSIVL7TSHbTgLltrDsWOqoo/4nmV5D1r91SPQ2q0o4MYFBN1RpDgmkG+?=
 =?us-ascii?Q?NLh//XbR23qN5DG9xfKt0LMDFuVDvkm2CPj3sjUwDAMTpMJiu4I6OeS6EIsU?=
 =?us-ascii?Q?trLUBEfZHOnNdk7dLlwfhW+YQ60zALSrn3qOIY+W31cHEDhVFT4yq0q+0TyL?=
 =?us-ascii?Q?J8osslL9t3fpwG5QFvZg+hsbQc4xSRc+VGx/xYoo5cz82Lg/2qKRsOuOxuk5?=
 =?us-ascii?Q?8RioduicYMdwZhJGShicaSiKGquLBpyh7km54D6fq58q8KvjzGEPZY1DYene?=
 =?us-ascii?Q?0T40ukfm9NIZMYX2IreA/DFRCW1ZRJlZ5cNM2SSEn4ZMgrlRtLo5/1fyQpZg?=
 =?us-ascii?Q?ra7e5YxVpj4tXBzVTwWSsACqXeOper6VUcDo8tqo+eXgaBJn0ekRGBeeUbV5?=
 =?us-ascii?Q?D+YPWboHOrrGNN3+d4WqhdX+iz1JwurS5XegGXIOCaidtBXTJwFTIYBQEhiW?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408927bc-2e25-49d9-d618-08dc1c305fca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 16:28:47.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uj7VL0ZD30oLQXBoEV1ZMtdK84/1/IsxSL+3g4/fL41tKF7Q+GSCEJFryfZTLaQdygMzyzz8b/K51tUfqZVULg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7005


On Tue, 23 Jan, 2024 10:19:21 +0100 Paolo Abeni <pabeni@redhat.com> wrote:
> On Sun, 2024-01-21 at 10:32 +0100, Sabrina Dubroca wrote:
>> 2024-01-18, 11:18:06 -0800, Rahul Rameshbabu wrote:
>> > This reverts commit b34ab3527b9622ca4910df24ff5beed5aa66c6b5.
>> > 
>> > Using skb_ensure_writable_head_tail without a call to skb_unshare causes
>> > the MACsec stack to operate on the original skb rather than a copy in the
>> > macsec_encrypt path. This causes the buffer to be exceeded in space, and
>> > leads to warnings generated by skb_put operations. Opting to revert this
>> > change since skb_copy_expand is more efficient than
>> > skb_ensure_writable_head_tail followed by a call to skb_unshare.
>> 
>> Paolo, are you ok with this commit message? I agree it's a bit
>> confusing but I can't think of anything clearer :(
>
> Yes, I re-read the relevant code and now the fix is clearer to me,
> thanks!

I tried thinking of how to rephrase that description a couple of times
and could not come up with anything better.

>
> I understand the intention is to drop patch 2/2.
>
> Could you please confirm that? If so, I can apply 1/2 without a repost.

Yes, the intention is to drop patch 2/2. It's a "defensive" patch that
does not actually fix any issues from what I can tell.

--
Thanks,

Rahul Rameshbabu

