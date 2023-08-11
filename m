Return-Path: <netdev+bounces-26704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993A97789FD
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E631282130
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D596AB2;
	Fri, 11 Aug 2023 09:31:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A5753A5
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:31:35 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED6330ED
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:31:34 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AMjlUG001549;
	Fri, 11 Aug 2023 02:31:18 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sd8yp9uqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Aug 2023 02:31:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJq2gIZAPSVKGd32saMyvUNiKpQAr/ds0ZYShMNyU18NyO0b/k3dAj5sYZ7K7n7Ul4m2Zlb/jCAwNCXYvSTxyF7IiWgTlPWcpLaNOuz/Xuhim0dsDH0Ejde0epZVJ6Pm8KLmz/u9f1gXtAy5ofx6hE5yPtp3IGpeaU6c0trMBYm1wixK8v2v6Hh1gzfK6I9HXuC0XEeEiWO/ANwoJadrawa7GMh1zgY2jSQo9HNIp4tJs1M6shr+rH1q/iEwijOtiAiBaA+DCl5ElC41dBYtJGvZ0v0j7To2VCvVAUG1t9XdhpYhgnjZwRE50yxeHJW1BNtJpWYp/6cLvgP4ZFwDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InACIZSu35buKRQjY0ZA3bK4WtRFsIHwLhGVTOLDPzA=;
 b=X6pLWbS8CXBZirzOKy/O+20nhJcUXPRXlL6oZPyXWgZjyLHLCEXHYJ2uhYWxWz/VXUNnkmm4HqGU0lXc1M8QzH5INeypOcKW5JJ/5+DZRpxhLcnkDbWRlbKDrYXf+53LcyFEwrqc1EHs7kAQRvNAYgfdWQ5PbF10Uf6tNHPNxF6/TJNgywjcORTQvl8YtRXoSwKjzBXNChGIZ5p+0SJ5pyNavuXMF6AErNXx7ba6taIUkPvyFzZWkgRIiQqTNc1Wfth6UQYXXLpK8UL1qzjw6V+xLuQButji36hle8QFddHG4s5kKJSob5s5OuKLeveHMuHZ6NgiP/jOc2QShhqdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InACIZSu35buKRQjY0ZA3bK4WtRFsIHwLhGVTOLDPzA=;
 b=i+rjWyJR6/Sa60INZCtlC9ycdr9mdmYhnJI0/z3nXz8bXrZhsTG9HMBPHa/dKTjLr4p1OEDMurYVwocBqZQzX2lA6/ZDPxyXxtMXJETrWg56QQ8PU0YdRb7RNg6q9REaLB4WmOF0h/Izmx0ZVMudi8m077p2ZkdOJUbjB2N/MJY=
Received: from BY3PR18MB4612.namprd18.prod.outlook.com (2603:10b6:a03:3c3::8)
 by SJ0PR18MB4089.namprd18.prod.outlook.com (2603:10b6:a03:2c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 09:31:16 +0000
Received: from BY3PR18MB4612.namprd18.prod.outlook.com
 ([fe80::7050:fdf4:a7f2:18ed]) by BY3PR18MB4612.namprd18.prod.outlook.com
 ([fe80::7050:fdf4:a7f2:18ed%6]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 09:31:16 +0000
From: Manish Chopra <manishc@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ariel Elior
	<aelior@marvell.com>, Alok Prasad <palok@marvell.com>,
        Nilesh Javali
	<njavali@marvell.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        "jmeneghi@redhat.com" <jmeneghi@redhat.com>,
        "yuval.mintz@qlogic.com"
	<yuval.mintz@qlogic.com>,
        Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "horms@kernel.org" <horms@kernel.org>,
        David Miller
	<davem@davemloft.net>
Subject: RE: [EXT] Re: [PATCH v2 net] qede: fix firmware halt over suspend and
 resume
Thread-Topic: [EXT] Re: [PATCH v2 net] qede: fix firmware halt over suspend
 and resume
Thread-Index: AQHZy+1lZM+1lomQPk24GXtBdk57Ya/kzXtA
Date: Fri, 11 Aug 2023 09:31:15 +0000
Message-ID: 
 <BY3PR18MB4612F2621E50B2F12F2BC342AB10A@BY3PR18MB4612.namprd18.prod.outlook.com>
References: <20230809134339.698074-1-manishc@marvell.com>
 <20230810174718.38190258@kernel.org>
In-Reply-To: <20230810174718.38190258@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWFuaXNoY1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWNlYzVkOGMzLTM4MjktMTFlZS1iNmRlLWQ4Zjg4?=
 =?us-ascii?Q?MzVmNjc2YVxhbWUtdGVzdFxjZWM1ZDhjNC0zODI5LTExZWUtYjZkZS1kOGY4?=
 =?us-ascii?Q?ODM1ZjY3NmFib2R5LnR4dCIgc3o9IjMxMzYiIHQ9IjEzMzM2MjE5ODcyMjg1?=
 =?us-ascii?Q?NzE1MiIgaD0iT2E1dHhSQ1lOZlR1d2JqSW1qcmU2ZXFxTnpVPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBTjRQQUFE?=
 =?us-ascii?Q?QVNGZVJOc3paQVNiODM0STIrRXJoSnZ6ZmdqYjRTdUVaQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQnVEd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFFQkFBQUFJN3FUcEFDQUFRQUFBQUFBQUFBQUFKNEFBQUJoQUdRQVpB?=
 =?us-ascii?Q?QnlBR1VBY3dCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY0FC?=
 =?us-ascii?Q?bEFISUFjd0J2QUc0QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBZ0FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWXdCMUFITUFkQUJ2QUcwQVh3QndBR2dBYndCdUFHVUFiZ0Ix?=
 =?us-ascii?Q?QUcwQVlnQmxBSElBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmpBSFVB?=
 =?us-ascii?Q?Y3dCMEFHOEFiUUJmQUhNQWN3QnVBRjhBWkFCaEFITUFhQUJmQUhZQU1BQXlB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdN?=
 =?us-ascii?Q?QWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0QVh3QnJBR1VBZVFCM0FHOEFjZ0Jr?=
 =?us-ascii?Q?QUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBB?=
 =?us-ascii?Q?WHdCekFITUFiZ0JmQUc0QWJ3QmtBR1VBYkFCcEFHMEFhUUIwQUdVQWNnQmZB?=
 =?us-ascii?Q?SFlBTUFBeUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFB?=
 =?us-ascii?Q?QUFJQUFBQUFBSjRBQUFCakFIVUFjd0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFj?=
 =?us-ascii?Q?d0J3QUdFQVl3QmxBRjhBZGdBd0FESUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFB?=
 =?us-ascii?Q?R1FBYkFCd0FGOEFjd0JyQUhrQWNBQmxBRjhBWXdCb0FHRUFkQUJmQUcwQVpR?=
 =?us-ascii?Q?QnpBSE1BWVFCbkFHVUFYd0IyQURBQU1nQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVpBQnNBSEFBWHdCekFH?=
 =?us-ascii?Q?d0FZUUJqQUdzQVh3QmpBR2dBWVFCMEFGOEFiUUJsQUhNQWN3QmhBR2NBWlFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJrQUd3QWNBQmZB?=
 =?us-ascii?Q?SFFBWlFCaEFHMEFjd0JmQUc4QWJnQmxBR1FBY2dCcEFIWUFaUUJmQUdZQWFR?=
 =?us-ascii?Q?QnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFHVUFiUUJoQUdrQWJBQmZBR0VBWkFCa0FI?=
 =?us-ascii?Q?SUFaUUJ6QUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFFUUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?Q2VBQUFBYlFCaEFISUFkZ0JsQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4?=
 =?us-ascii?Q?QWJnQmhBRzBBWlFCekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJo?=
 =?us-ascii?Q?QUd3QVh3QmhBR3dBYndCdUFHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dC?=
 =?us-ascii?Q?MkFHVUFiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1QUdFQWJRQmxBSE1B?=
 =?us-ascii?Q?WHdCeUFHVUFjd0IwQUhJQWFRQmpBSFFBWlFCa0FGOEFZUUJzQUc4QWJnQmxB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcwQVlRQnlBSFlBWlFCc0FGOEFjQUJ5?=
 =?us-ascii?Q?QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBSElBWlFCekFIUUFj?=
 =?us-ascii?Q?Z0JwQUdNQWRBQmxBR1FBWHdCb0FHVUFlQUJqQUc4QVpBQmxBSE1BQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHRUFjZ0J0QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJ?=
 =?us-ascii?Q?QUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBWndCdkFHOEFad0Jz?=
 =?us-ascii?Q?QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBB?=
 =?us-ascii?Q?WVFCeUFIWUFaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QVl3QnZB?=
 =?us-ascii?Q?R1FBWlFCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0Fi?=
 =?us-ascii?Q?QUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0JqQUc4QVpBQmxBSE1BWHdCa0FH?=
 =?us-ascii?Q?a0FZd0IwQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFn?=
 =?us-ascii?Q?QmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBR01BYndCdUFHWUFhUUJrQUdV?=
 =?us-ascii?Q?QWJnQjBBR2tBWVFCc0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?MEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdC?=
 =?us-ascii?Q?aEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhBR3dB?=
 =?us-ascii?Q?WHdCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBYndCeUFGOEFZUUJ5QUcwQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: 
 =?us-ascii?Q?QUFBQUFBQUFBUUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VB?=
 =?us-ascii?Q?QUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3?=
 =?us-ascii?Q?QnVBR0VBYlFCbEFITUFYd0JqQUc4QWJnQm1BR2tBWkFCbEFHNEFkQUJwQUdF?=
 =?us-ascii?Q?QWJBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElBWHdCbkFHOEFid0Ju?=
 =?us-ascii?Q?QUd3QVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFH?=
 =?us-ascii?Q?VUFiQUJzQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dC?=
 =?us-ascii?Q?ZkFISUFaUUJ6QUhRQWNnQnBBR01BZEFCbEFHUUFYd0J0QUdFQWNnQjJBR1VB?=
 =?us-ascii?Q?YkFCc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJ?=
 =?us-ascii?Q?QWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBY2dCbEFITUFkQUJ5?=
 =?us-ascii?Q?QUdrQVl3QjBBR1VBWkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFY?=
 =?us-ascii?Q?d0JoQUhJQWJRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIUUFaUUJ5QUcwQWFRQnVBSFVB?=
 =?us-ascii?Q?Y3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQnNBRjhBZHdCdkFISUFaQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4612:EE_|SJ0PR18MB4089:EE_
x-ms-office365-filtering-correlation-id: 5ffeb9a4-94ad-4d87-cb0b-08db9a4db604
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 tjjhGhtmYyHGaHwQim6gPHX2V58i/f37BAfY+9bEUDCh0Ecxm7BZueRI8bWb1AgcYsFNhfE0i5vCVkA0O4s+3MAfaaXihRoacaZe+/jBv55+uyxIKoNrrSc6SoHUxngLQmUnzN0gj5cnJ7+ck6Ka2JtBmvrKwnFHU6IB04wMQaIggs28VPhqTP3f81+q/91XB0FOHbuF78USIBxtW/8UQH438yz+gmcvT9jxkqpKuXK4AV8MPxMj8eTfKfGxv2nC4UdHZeVzr0HXb0aEqa24U5ya89SUAjKB4A4k/BpbyxaPOX70fNPUeWIypsvZqMc8ItRycpLZEvfAsZbn6is+KfUqI1hzMntd5bWtMyABzZxuzGfDu3fZlffbiuX8ZC2BBuNdvlOXuXBsQM8CZwp0KJCSaRa+5hXf/bUIdLwBIplZYadyhKhWwulzjK2MiS3Z6765YYjVC6QpIkijBLqfp3Dmog0j87U+mDVljtwKQtaqRNub4hB7/YOntp14vdsXyN3eQeWcF8wPs+nHUOhtYXx+gqvt9LyqORiRSiP5cRcU4tA1b/7qlbmqfVJdijh1Gji7e/qyP7uo8gr0/AfSLLJqFqz2vStDcNMN1u2snZ+2yyWL0crXFZbEPT9o+Bh0
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4612.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(1800799006)(186006)(9686003)(86362001)(7696005)(478600001)(122000001)(38100700002)(52536014)(54906003)(66946007)(6916009)(71200400001)(4326008)(15650500001)(5660300002)(38070700005)(66556008)(64756008)(66476007)(66446008)(33656002)(76116006)(6506007)(53546011)(316002)(2906002)(41300700001)(26005)(83380400001)(55016003)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?U3rRpKeLIv3mLPCrzMqBGTK5HE5aIlXxQFOBrEOM3yH4Z2p+tyV2KsZ7QGIn?=
 =?us-ascii?Q?EnHSs4QNsr6ZMZCeyDg2Vhjd+5VuvlQIFXGOBbVTooIBQC/IczAHBXHzgH2l?=
 =?us-ascii?Q?ft9EmhHQHV39XJH9EyxyTfTD8lUz5A3o/q3qFLbuYHrIxbXAujubs/dvS5dc?=
 =?us-ascii?Q?ZN9LScHvLEm71uxu911IWtIPqal6P/dmfKrrUZnp1koeXzYcaj66t+YPXNta?=
 =?us-ascii?Q?HlVsuae7bXvyqEdtzLOJXD+m/UiQexr96axAnOA28qydFQZEfCTcaUEKIdBn?=
 =?us-ascii?Q?Ufs7hRa1ZaM6BtthKNhgEUnVfu70YeJLWJ3TmBSOtK+Opykf6schjDrc2tmI?=
 =?us-ascii?Q?sHcyIIwVyS1CUgB3/d/SKPGvmfZlVUKdSzmzvTDhnjfxzgRRFOxWl7UuM3QM?=
 =?us-ascii?Q?mmLmX4Ika8vUsX+Nd+XMgIlLlF8sXAzFXqqg7enyCAAlDBo3Vp4e+3lRANzJ?=
 =?us-ascii?Q?TBbkOe26OWYHTSUfS8oB9pT6nvmccxjmLBb/L1SBGlph9y9vHLGFmvvTttgA?=
 =?us-ascii?Q?YINFDZr8zfZxdWtgWl2Z6klb+4pxC8K6xB07/LYC6E6p25gz06d++n1LdWlk?=
 =?us-ascii?Q?e/rqGVMkQiykJys6/+yayYoA+4QgdpcoLYcKCdM8FGSCB/Z2w4fFJFkT1vOI?=
 =?us-ascii?Q?Gno7R/rc0AbK3jJ8ECfp2lu/yTB9oRRPr4T+aZ71kKWfnSsNLPunapkzjSFp?=
 =?us-ascii?Q?uL3RB5IVVaCZCVKDyWvmVXhmwhKa8EPSYHpDOD1rKytiwjGGpTEpe0IqTN6c?=
 =?us-ascii?Q?Vm85Bsblx0D+ld5NlMz1Q7EdHbMJaFcbmZfddG2vG2Y4SfwKVKiRkIY3PAoa?=
 =?us-ascii?Q?OTiJ1lZVjyUZQSJ7LU9YqQtSnh5MH7BracL5LR2d/MLVQgwUE0MsDTS3YGmW?=
 =?us-ascii?Q?SP+64l0OkT63t/Vf8Adl7nvD4M0npCs/0Pc/29a+HUbm1SUDLnCVzC95XJfs?=
 =?us-ascii?Q?GIqTy99ZXqdkySJtxQjzQyYm0O5M1cUNHwbKhwhG+l1uWqm2ilRiCiEDyrpF?=
 =?us-ascii?Q?BrCOesRj/DdTfEXhbzIyCR/RZd69JBoMt7WGLyMq0ViKFnKnFzFWnzhhLMvS?=
 =?us-ascii?Q?ex338MFTRub1nxZa3GcJ7SMdPHRLKvmNsjmK7gSvPrpQJoFgVshLq7/WS7YK?=
 =?us-ascii?Q?E0G9q0N8nKUbfOFNrCTZ1k8+MRAH0VgVi4hgKeE/PY1VBsYt/QdEovYL6csc?=
 =?us-ascii?Q?A8nUFtKDL9jnaazirgTAiL0hXuPKI9NNjm8bmduUjlcpjjESETp993HSgQ7u?=
 =?us-ascii?Q?0uRbPkF0W/TpHzGh8KuFKADm6aa3dzTdxGbl7Nl8REswyP4t8QeAUV5t0IM6?=
 =?us-ascii?Q?zW6fE9OwAl2XjQcKAHM9mEmg1qkCZhkeJ2qeHbVQlQlmaaEqc5+t23MLF3rg?=
 =?us-ascii?Q?tvmgDbG2nloEAOuI/4lVEgydXCiTKNpNgYicUtvulWEWCD48tLMKVkCqJCYE?=
 =?us-ascii?Q?fcV8ZPvrHxj+ZR3PASR27nE5wmTtKEuPgh/Pg81qYtQg5c2ixtJoMqsiPmlO?=
 =?us-ascii?Q?imCZbrPwDrox5ZTEYpIRYubfy3kzRTm0JH5TfbZVOGRs+tT/+/TDVLrVVWVQ?=
 =?us-ascii?Q?Dm5rR4kHg+KTjlKrcf8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4612.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffeb9a4-94ad-4d87-cb0b-08db9a4db604
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 09:31:15.9876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rfhG6YV5hXhwVnkVDH6ISRvXCBqIsBAs3cVc6a+S2Y1enk9+++gh9VxKrjaypGHRV80+v0DUy/e4SOGgWH7HlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4089
X-Proofpoint-ORIG-GUID: S5UVrmlo-nWcJQGmaWDeOeRccs8JhttR
X-Proofpoint-GUID: S5UVrmlo-nWcJQGmaWDeOeRccs8JhttR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, August 11, 2023 6:17 AM
> To: Manish Chopra <manishc@marvell.com>
> Cc: netdev@vger.kernel.org; Ariel Elior <aelior@marvell.com>; Alok Prasad
> <palok@marvell.com>; Nilesh Javali <njavali@marvell.com>; Saurav Kashyap
> <skashyap@marvell.com>; jmeneghi@redhat.com; yuval.mintz@qlogic.com;
> Sudarsana Reddy Kalluru <skalluru@marvell.com>; pabeni@redhat.com;
> edumazet@google.com; horms@kernel.org; David Miller
> <davem@davemloft.net>
> Subject: [EXT] Re: [PATCH v2 net] qede: fix firmware halt over suspend an=
d
> resume
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Wed, 9 Aug 2023 19:13:39 +0530 Manish Chopra wrote:
> > While performing certain power-off sequences, PCI drivers are called
> > to suspend and resume their underlying devices through PCI PM (power
> > management) interface. However this NIC hardware does not support PCI
> > PM suspend/resume operations so system wide suspend/resume leads to
> > bad MFW (management firmware) state which causes various follow-up
> > errors in driver when communicating with the device/firmware
> > afterwards.
>=20
> Does the FW end up recovering? That could still be preferable to rejectin=
g
> suspend altogether. Reject is a big hammer, I'm a bit worried it will cau=
se a
> regression in stable.

Yes, By adding the driver's suspend handler with explicit error returned=20
to PCI subsystem prevents the system wide suspend and does not impact the
device/FW at all. It keeps them operational as they were before.

>=20
> > To fix this driver implements PCI PM suspend handler to indicate
> > unsupported operation to the PCI subsystem explicitly, thus avoiding
> > system to go into suspended/standby mode.
> >
> > Fixes: 2950219d87b0 ("qede: Add basic network device support")
> > Cc: David Miller <davem@davemloft.net>
> > Signed-off-by: Manish Chopra <manishc@marvell.com>
> > Signed-off-by: Alok Prasad <palok@marvell.com>
> > ---
> > V1->V2:
> > * Replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS
> > ---
> >  drivers/net/ethernet/qlogic/qede/qede_main.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c
> > b/drivers/net/ethernet/qlogic/qede/qede_main.c
> > index d57e52a97f85..18ae7af1764c 100644
> > --- a/drivers/net/ethernet/qlogic/qede/qede_main.c
> > +++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
> > @@ -177,6 +177,18 @@ static int qede_sriov_configure(struct pci_dev
> > *pdev, int num_vfs_param)  }  #endif
> >
> > +static int __maybe_unused qede_suspend(struct device *dev) {
> > +	if (!dev)
> > +		return -ENODEV;
>=20
> Can dev really be NULL here? That wouldn't make sense, what's the driver
> supposed to do in such case?

It's not supposed to be NULL here assuming caller must be validating it way
before. I just put it for sanity. I will remove it.

> --
> pw-bot: cr

