Return-Path: <netdev+bounces-38954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2407BD398
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 08:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27EFE28100B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 06:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DADBE4B;
	Mon,  9 Oct 2023 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tkuOs2uu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909112F39
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 06:40:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFAAA3
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 23:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIw01p7QltYshOLvDGrxAzLNb54YYn5avYQeEI5uj8OIktbThox7T974ETowSD+WrwEIJyGdkKjr+dDjpnwyidv1YRMIdGciWb2eU33sF55KGI5zYvgGpGBf7HyJ0y5ui/CoswvFVjT/0tnfKoBt6g1H2sSR1K82/jkaFyiw68H6Bm0PtNU+krWxtjeoE7uKyxsu0EMnCMNt9frslBPWZ00wFDnDh/86auBJp4qkvjki+QoSjNX0yJ0CE+7C9mdk8rEciNHr9Bvq+meg3eMfiR878tQGEv6I6DhLxfCjeMUUZO6MlwqQ7CFGKFG8vsvx+4/et0fozE73dAwFtuglgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNG+d41rPg1mz4kp06NXPKRTtyC0EXdSafY/E0Nhk54=;
 b=XjUbRWUkDFoNb+DSXMKm8yA4zSd4TLn/ncopRjfBgLwTkAxt2J5j4796+aU25CnFsXTnvEbFrVSkEUub52r1SGwCDns/YolN4YXmVJ7Nd8+YEnn+HoqQwIQvNwXhFW/BCnmw2vrzZTaJYe8dmsVo6lj4mPrdFi2AE80dqhHNNQQoSLx5DfCv4+SmtZs+NR98UaSr/dtPESkvHvFOK7d7zz0YKpLf6HIqIr3O+5e45lb8btLNyItTTD//mlShguVbAOfezDs1yVJFFfjgupJaw3OAntrT4PR8gJ0FoSVgC6JZgCku+WHxf+5zR87e+nkznRV7Xp+C2wCw55tX4tNtig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNG+d41rPg1mz4kp06NXPKRTtyC0EXdSafY/E0Nhk54=;
 b=tkuOs2uu2I2N3Ue8uJSnM3jUezCn0IlmM4ZmmLzPH9wDBKuRdTYMpBBMwgiSFnZJ90oAkL1JEcgC9kjZ+sPgvk7+OjfueKH59zmyklfoggiZYQ5Qf2gfGHC7Deoy4UE70OgnlZACwSLbPhVPrjytUdvGP0DVvEoTTpLp7pQk8GFbZVNPYxmzVB+qPy8gGuzYHDXeIKUe+YaOrX9e2yOcdxhiwbSac7S0jNVZyhrjdIeAhv6e8i1ZJFTJrDWPopl23YMLhtByKXn1sqZ3Hc8Z39pVQv9LkaLFK61X6TDXA2eywOOh2sEOAjx9Ltafu8EZO7S4DKhNkKHysMEiRQcY1w==
Received: from BYAPR21CA0002.namprd21.prod.outlook.com (2603:10b6:a03:114::12)
 by LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 06:40:31 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::7) by BYAPR21CA0002.outlook.office365.com
 (2603:10b6:a03:114::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.2 via Frontend
 Transport; Mon, 9 Oct 2023 06:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 9 Oct 2023 06:40:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 8 Oct 2023
 23:40:16 -0700
Received: from fedora.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 8 Oct 2023
 23:40:12 -0700
References: <20230930143542.101000-1-jhs@mojatatu.com>
 <20230930143542.101000-14-jhs@mojatatu.com> <87edi5ysun.fsf@nvidia.com>
 <a57b639c-dd5c-4e16-9943-2c0aec724c5d@lunn.ch>
User-agent: mu4e 1.8.11; emacs 28.2
From: Vlad Buslov <vladbu@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Jamal Hadi Salim <jhs@mojatatu.com>, <netdev@vger.kernel.org>,
	<deb.chatterjee@intel.com>, <anjali.singhai@intel.com>,
	<namrata.limaye@intel.com>, <tom@sipanda.io>, <mleitner@redhat.com>,
	<Mahesh.Shirshyad@amd.com>, <tomasz.osinski@intel.com>, <jiri@resnulli.us>,
	<xiyou.wangcong@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<kernel@mojatatu.com>, <khalidm@nvidia.com>, <toke@redhat.com>,
	<mattyk@nvidia.com>
Subject: Re: [PATCH RFC v6 net-next 13/17] p4tc: add table entry create,
 update, get, delete, flush and dump
Date: Mon, 9 Oct 2023 09:29:04 +0300
In-Reply-To: <a57b639c-dd5c-4e16-9943-2c0aec724c5d@lunn.ch>
Message-ID: <87a5ssz4c5.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9978d5-6cb8-4a92-83af-08dbc892a17b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y63UwCXgYw618Qp/34zo3eLydr4uGIhMBAQg/MnUb8H7HKRBr55cEEQwvQ9h3vGaIWslmWjG0vuTbpQRHukMG4QDyDQ7DUqEty1FuWS4pWSWfEMs5Itduij15f5O0OA/zxP1BI8BoQE9awRiuq26SW74yFnB0ILEX6uQU4Bo92mOc04/Z2cO9y6+RpaX7sQ4KGiq7kGRYY0DqZg1tyRPhCa8q2f3NglKZXNIyOUqZStRX+k8eCMeNaaTvC+89dkkoqLzfr1TfIXFpHt3BKYc/O+EikwsbVhm0RJCfoF5RRQ6L7IUqh+3tO9TiyJcmf3Hb450d/cF0SfELenEJd/7tNgWwrX8O+NnfJ3C0pOQVD2dYKeatCNmijf22lSe68C9M83lw01fcZucAp8DyoXRCC2r+o7hAHIieB24Ym2BoZ4hW933Z5QlMTk8bi8hGVMmVFrG7EOqHphxikieFDmLqrETwWkd7G4B6Cm/IIjaR08M7c2Z/jR2OsehcNlFw6vsuWE5JO6O3kxXLDEbUZS5nGxVTGUGpXz2cV4gth7cs7KVkgI3V7cOXHJJ3uyl3VCmuSKM7cS/Cb9wyIioBwcyTVofUmfZTnlxHMO9XNivPR7HFGSCX+j7WVmtLb7eUBboYZ9nHAnV0qYLCoi4c+cSdGzDtXDGlBu0fdIEQsJyBK73JMp0yhFYjHa8bzc9Fks+H8uOCjgZGb6/vhTezthITXOaXIo2HFAb2zQbT9GzYp+a5WNIeWFOQRBCvr2nkncQGEVdKJrky0qQk8p2A8CyWg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(1800799009)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(2616005)(107886003)(16526019)(426003)(336012)(26005)(7416002)(54906003)(6916009)(70586007)(70206006)(15650500001)(2906002)(83380400001)(40460700003)(86362001)(36756003)(47076005)(36860700001)(7696005)(6666004)(478600001)(5660300002)(8676002)(8936002)(4326008)(316002)(41300700001)(40480700001)(356005)(7636003)(82740400003)(32563001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:40:30.2126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9978d5-6cb8-4a92-83af-08dbc892a17b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Sun 08 Oct 2023 at 18:53, Andrew Lunn <andrew@lunn.ch> wrote:
>> > +/* Invoked from both control and data path  */
>> > +static int __p4tc_table_entry_update(struct p4tc_pipeline *pipeline,
>> > +				     struct p4tc_table *table,
>> > +				     struct p4tc_table_entry *entry,
>> > +				     struct p4tc_table_entry_mask *mask,
>> > +				     u16 whodunnit, bool from_control)
>> > +__must_hold(RCU)
>> > +{
>> > +	struct p4tc_table_entry_mask *mask_found = NULL;
>> > +	struct p4tc_table_entry_work *entry_work;
>> > +	struct p4tc_table_entry_value *value_old;
>> > +	struct p4tc_table_entry_value *value;
>> > +	struct p4tc_table_entry *entry_old;
>> > +	struct p4tc_table_entry_tm *tm_old;
>> > +	struct p4tc_table_entry_tm *tm;
>> > +	int ret;
>> > +
>> > +	value = p4tc_table_entry_value(entry);
>> > +	/* We set it to zero on create an update to avoid having entry
>> > +	 * deletion in parallel before we report to user space.
>> > +	 */
>> > +	refcount_set(&value->entries_ref, 0);
>> 
>> TBH I already commented on one of the previous versions of this series
>> that it is very hard to understand and review tons of different atomic
>> reference counters, especially when they are modified with functions
>> like refcount_dec_not_one() or unconditional set like in this place.
>
> Hi Vlad
>
> Please always trim replies to just the relevant text. This is a 3000
> line patch, which i think you made one comment in, but maybe i missed
> others will paging down again, again and again....
>
>        Andrew

Hi Andrew,

I considered eliding the rest of the code (like I did in another reply
to this series), but assumed that any further discussion regarding my
question might involve other atomic ops spread around the change.

Regards,
Vlad


