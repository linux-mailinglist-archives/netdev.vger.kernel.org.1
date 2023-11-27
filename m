Return-Path: <netdev+bounces-51305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B287FA0B9
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 14:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48952812FE
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD19B2D616;
	Mon, 27 Nov 2023 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aH7cXdUf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B8718B
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 05:17:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3gm/xSCd/mwOtQtFs+b2eDoLV3viqZAP6afuA5zCRtL3onNufnxaqMvZvm7KYAddAZg1Oh48Gll3kTFwRPNGyB1wlwnRMjXjhS6GSCi643HpPQSUCIfKqiAw6g+JRVcnyzIfm8MFugMH/THrkZ+NDT+zX5/FRDiDVdB/HoyIHpwVXGmuvOFjesX3mSbd+4gWko1aKU7pjUXOKxpVGyB4kdx+x6PQg1idOS1oPBUIwHplGDFZxcMb8M4uwx6n9iAthQaXlmH2jBe1zkvCBS0C5w4+gQi5GpCnR/+Ozq45Yp1cSGen2o9OWFInXuA1s77llolQ5xJ5KtG4VWfumdBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POyqEmEV+a6JvD4q17W8Fxxfri53i5zTzOHnGhxwByg=;
 b=eVKzA0MYdSTsbcNQY7XVAYkwtd0t0v8MqwypjeBW92MU/jcfcUgSJL8yJgdtiW7d9q6mV0GEWAsUsvNeDr7hb2L2EbWsP2+vHzYtZvzHpPqUnvHMzeJwpWrxHv0VaXhj7SK2uq7FZoJtwmTwQlCfgLhXmWzsMgwboRXE6SWymJZ5XF7B1am6AQeGKrgyZvFtnvyeM/l8gBAAyYAtCzOXWKjlCsbB32Vft5CIxJfFuk5yV4bsAN7foZk7YuhmPZraWwMGqcFLc2FviQJF1PE/1MREzUTMjvGR+7LmVSPf25vxO0IeISeu1GY1IvR66qW2fWqDtmFJAxS18mxSSL2rVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POyqEmEV+a6JvD4q17W8Fxxfri53i5zTzOHnGhxwByg=;
 b=aH7cXdUfczQyChaoY/N2A7W1iwedfi933AQP5UsXLyGNLJymfWai8UD/akWgH90sF98lLXObTvi7M89gMB3HXIFWVNbbiVcggdciWIn3aq60QRutwssS3ioOsRO9EQ/odJEocxEEEz2sHygm+4W1hGx4a+cLLHeB6ABqiB4ZiGS0J3blunp6yARTEz+Kmn3lY+H+x23ZSo68mdxCiBwO3xYa0Zsxfdgh2uR5Pm2tauXgDvNLyOmy5vbzN+K4OTD6Ddp9M8DfVDdmJK6XXskuQwtMUIVMVVHOGRjTdzAvzwP7b9rjzu41lWKZKLyIiblZJluxZ7oBCOu5p3j6WuW9EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 13:17:55 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 13:17:54 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
 aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH v20 02/20] netlink: add new family to manage ULP_DDP
 enablement and stats
In-Reply-To: <ZV98IyA3LSsk2BXs@nanopsycho>
References: <20231122134833.20825-1-aaptel@nvidia.com>
 <20231122134833.20825-3-aaptel@nvidia.com> <ZV98IyA3LSsk2BXs@nanopsycho>
Date: Mon, 27 Nov 2023 15:17:50 +0200
Message-ID: <253cyvvjpxd.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0328.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::7) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: da66a0c0-51cf-4635-a2f2-08dbef4b43a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c3+T9ikzAB6UMQlfqOGwUoJqsW/6zGVNuHt+s6AxHDsMn/IPHxAIevDjvornZwJIZShCYhQ+C08zgBWnc3zz9zm6dnx4Z4BNOcZYOJ6wcQx94ebgvj+h0J09FXgv2ZDj+BhArQ8uK9Qa3wYO77hLJSb85vi9/DDRFmUPt3xKTALMpuM42LrwoX0FdNxcQlhpaZoIfyDWMEQrHns3Rc34vCARKoh1TcIbGksjcBWfZ8odOy6815CEdyEHV3k/Gquzmo10jj06WFN4yOV5itkPJpP7e4E9xCwuDikYeA4t1Mo7SMd+qQtUS6MorH8LrFA6+Hct4EOUAHSzIsdW8HoelMtk71pdYFA0Pva06DTJeqzOn4RslJ+tzsQyJqg0xwCfsFWvPK1+w9anWJk8d1R9FFCDdE8QD5o0N+CxMgIj5TN+cQ3qefJ0LUchxxy9+r4jDbuXjKhwfBopRZcIy+hV/up95BAWLj1ogO5hZmNEwDIqv0DQ4WKco4RcKQR4Bn4vjYPgrzA1XneXqe8LC42kjnoiZ3Zq+3t57ZQxLadncN4NBkzvMHDWtyE9EgMFmnxs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6666004)(8936002)(8676002)(4326008)(6512007)(6506007)(66476007)(66556008)(66946007)(6916009)(316002)(6486002)(478600001)(2906002)(36756003)(38100700002)(41300700001)(86362001)(26005)(2616005)(83380400001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iC+nFZzHg8VAhmPOnLojHwWOtAiaJNFK7RHGEaaB4E4SVYR05VlRfCQQdYS5?=
 =?us-ascii?Q?ph1N9jWNA8V61xwC0dw5UeDfSWn8Bjqxa+DE74FK71qDhmkBZ4IG9dkL/NCS?=
 =?us-ascii?Q?+tDOohDsB5AMXQFrwehn0VmbGzpUDZ3QzngMKXYZGfuDKUGLtzbNZPIP3ktg?=
 =?us-ascii?Q?i31ROQtFXk+WOAoYgIejjnFOEvr+sQ5fc29iewWK52RTcNi3AngltzhP9NnV?=
 =?us-ascii?Q?2WMUiuqtfHplLl++uT4GEKmDz/r6UsVeAXRV9CrGM9fKJLibvcanmnFEcZof?=
 =?us-ascii?Q?3DIafK29UFemzV7whcGZ++T1UT8De5kgXBPwSBLEX9BdhZ4EZPbznJ5I3n7f?=
 =?us-ascii?Q?Iwx+kosaYQqpjp2YwYi3Y/y56jOToCtFD8+W5youSExEleoG0GoKlWIIJxta?=
 =?us-ascii?Q?4dyGQCtGMo5n132a/Hkbkafm2AJwz0oFdJ6dDjGSe0CJULXss++13ZJEpywF?=
 =?us-ascii?Q?Fh80ONHn98zBeuVIuRJlw22T0a9blyreMs6dCtgaf6M1EPreXuoUaANPAmBA?=
 =?us-ascii?Q?4vYYRsa2SYqbtVcg0cfEULQ6ZZ9pbcFRqq/wuiaYjEjxikvyEEdegeMbRwib?=
 =?us-ascii?Q?gceR3MkxC5d+25STvpvEE7wjfsIyAGbUI6eDSyEr5I35FkwPVzWB30PV2qPn?=
 =?us-ascii?Q?Y4W4GD4zVcRj4O6aTLIi3PI4ibyTNuDNVp0Mit3oQw7CjN1QqQ0YS167eAP/?=
 =?us-ascii?Q?G2LiSsM4UHIzRyO4e1Fmdpw5EflV+EXlm4PhiS+0jYHJ/RDUSAlybccie2gO?=
 =?us-ascii?Q?OphsF241Nu3lVe7bAD2VMil8lW3xwM3sNMnVJxw22GqWEtkjdogTG0v2C6Um?=
 =?us-ascii?Q?+2rxq/Ty+hQqJPL2nPHHTKREvd8jrFWteJGvxpo0W1/vzLfw4N+Kc9Bw02k0?=
 =?us-ascii?Q?6+cL0mfsFjUH7LO3H0x+08450KHq5Yfe5uf568vNRoAv8A+ERshJ1nM6yTv3?=
 =?us-ascii?Q?XF0V9hNj0dnXkRUzCd+yw4CQZDBplT/RKbUHsN5ZXjs/gwyTRARu5/IaH0Za?=
 =?us-ascii?Q?E9PHm/PgJJD7T9fEr9fbkk8ycFRvGkgJJCyP5JZGqLyBRRmy39Qvk1Qt5qnc?=
 =?us-ascii?Q?OkXK56drraJn9w8y0cuTjZvujYgI/put5lbLRd360OR3tKPO2K0ku0OL8bv8?=
 =?us-ascii?Q?7cIyOrq74ffDldJ4NBSzJ4s+Eg/Ey5s5p9dDzCblCOKXo/YzZ6AHFnJLcFFS?=
 =?us-ascii?Q?cStS+SdHW3cdyQpoKw7pxwxNaKPk1oUjh0O+8Ln5OomzZ6pjMIMfwHUp2jON?=
 =?us-ascii?Q?aA6FA+oiH5PjyfAT/Tk3UmkyqmuWdOA5RXVdegZGXhk1zv//ePGdS49VxzJW?=
 =?us-ascii?Q?aY4Tf0CbyDC1kOrxhClpIeZwLLO+rzY4A0e25PCzeImg0SlvQfbzJGyz4VKz?=
 =?us-ascii?Q?parIhXgTZLsRABHCFnCmuG6SK5/7o5I97LOuAnxZ2FvegEogtZoX8se2WZCK?=
 =?us-ascii?Q?WlLDsry3DiZdVFPkXlquVlnH/pJkO1F+it9kasrC41ug6E6uetxwRHE09vMf?=
 =?us-ascii?Q?C2RjmhQHjyGkZSak7XX7TUOtjdGZDy4bXywyGH2f6y8FTuHo5y5iJEZ72mOi?=
 =?us-ascii?Q?zvs/jDMPEjPc8MoIbD0P012I3t6EMIkslYUD3AgY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da66a0c0-51cf-4635-a2f2-08dbef4b43a9
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 13:17:54.2409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXdQSLNs/By0xPDI45uqVWoz4RaV6/LQ68OGAgVde6iJ9LG8iaVbUXatZiDE3LwOLcCrU3fkDvLOK5T+UnHXaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987

Jiri Pirko <jiri@resnulli.us> writes:
> Overall looks good to me, couple of nits below, take it or leave it.

Glad to hear. We will send v21 with the changes below.
Hopefully we can get a RB or Ack on this patch.

>>+
>>+      ctx->ifindex = nla_get_u32(info->attrs[ULP_DDP_A_CAPS_IFINDEX]);
>
> You don't need to store ifindex. You have ctx->dev->ifindex with the
> same value.

Ok, we will remove it from the context.

>>+      switch (cmd) {
>>+      case ULP_DDP_CMD_CAPS_GET:
>>+      case ULP_DDP_CMD_CAPS_SET:
>>+      case ULP_DDP_CMD_CAPS_SET_NTF:
>
> Hmm, you never call ulp_ddp_prepare_context() with
> ULP_DDP_CMD_CAPS_SET_NTF. Perhaps just warn if this case is hit. IDK.

While that is true it also reflects what the payload is and it mirrors
ulp_ddp_reply_size(). We will keep it as is.

>>+static int ulp_ddp_write_reply(struct sk_buff *rsp,
>>+                             struct ulp_ddp_reply_context *ctx,
>>+                             int cmd,
>>+                             const struct genl_info *info)
>>+{
>>+      ctx->hdr = genlmsg_iput(rsp, info);
>
> Interesting, you use "hdr" just in this fuction. Why isn't it a local
> variable?

Good point, we will make it a local variable.

>>+      ret = ulp_ddp_write_reply(rsp, ctx, ULP_DDP_CMD_CAPS_GET, info);
>>+      if (ret < 0)
>
> You mix "if (ret)" and "if (ret < 0)" in this code, I don't see any of
> the functions return positive value on success, so you can make it
> consistent to "if (ret)".

Ok, we will change the checks to "if (ret)" and change
ulp_ddp_apply_bits() return the notify flag via an input parameter.

>>+
>>+      if (ulp_ddp_write_reply(ntf, ctx, ULP_DDP_CMD_CAPS_SET_NTF, &info)) {
>
> Always use "ret" variable to store return value before you check it.

Ok.

>>+
>>+      rsp = genlmsg_new(ulp_ddp_reply_size(ULP_DDP_CMD_STATS_GET), GFP_KERNEL);
>>+      if (!rsp)
>>+              return -EMSGSIZE;
>>+
>>+      wanted = nla_get_u64(info->attrs[ULP_DDP_A_CAPS_WANTED]);
>
> nla_get_uint()
>
>
>>+      wanted_mask = nla_get_u64(info->attrs[ULP_DDP_A_CAPS_WANTED_MASK]);
>
> nla_get_uint()
>

Ok.

>
>>+
>>+      ret = ulp_ddp_apply_bits(ctx, &wanted, &wanted_mask, info);
>
>         ret = ulp_ddp_apply_bits(ctx, &wanted, &wanted_mask, info,
>                                  &notify);
>
> Would be a bit cleaner to read perhaps.

True, we will change it to that.

Thanks

