Return-Path: <netdev+bounces-47436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9488A7EA2EE
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 19:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA52280EC4
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 18:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F0C22319;
	Mon, 13 Nov 2023 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2FR69VXD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J9CVMOZs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6A42374B
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 18:34:49 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D223D68
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 10:34:47 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADHi6aR009373;
	Mon, 13 Nov 2023 18:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4zIvjVpqB/fL35eS1l2YhNl3FayD9XHqpK2Ca/xh6GI=;
 b=2FR69VXDycdprlFjlv9BLi2vC1fF1rQk2AvCb7RzE+DHPC+++NydXgWQwJNvLfIrgHGn
 gI7XM5Tv4xHvx8zmiRoPwB/KC4l9ghhQmKjQA9teogNeoGcVgLeZWv/t5dGZqa8gOpK1
 09lXlyMboCKOj89Pzp5AW5hMpAUi6CBHmUXW3IstnC+vhwHeOurySHUw1ddkr8sU8WJ/
 AdZ08mWHwjcQ4+fHuSf0XL39P0YoVdj0Ky4izx2jkLxYWYoBZtagwN7xzRAhfxTmSMoE
 b+/yqU7/i0jiFu6cx7i1fH/6L6W5Kpew2YIITNpPmqgyakIocHdvLoFPPJpTXADeFvlm 6w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qd3fyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Nov 2023 18:34:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADHXdnx022615;
	Mon, 13 Nov 2023 18:34:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxpx2d0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Nov 2023 18:34:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtZK3K1RpQ9zjnKX8cuBBJJ2IC0oWzB7D1CsND3aiquPawTD/48qbKHLL2rxdLa7ZFh1hXGc3o+ANmQifnoi28y4326fbfo9aKHEHIO0GoAqxZc99imy4VD1nq9VeRMyOBtqBcjltLA+n9fZ3mffEBWh1IazXvTX5mpWTFXKabj7i/xRLys55KFLrPo/XjSNifXKxKHxh2AmtgWVKmiJFhrpRkWFZrQeNsHZluzr2NFFIvWDYt6SJJyUkASLv96OzUkrpyDnF0YSPSh2qHc38hP2n5gcGL2MPh44ZWXn26ywBuqWxJnhy6Imyx1opRCJchLBcLy/yp3EZBrwuxpEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zIvjVpqB/fL35eS1l2YhNl3FayD9XHqpK2Ca/xh6GI=;
 b=oYX31mIWW9K4l3bxqA6fov2204mFkOsEVrjTfXAkdmoA/PtH5udXfTYOIKcW55AIwAJmGsbcIGErSqz+Mw++Gb3mmmkafD7LSaEhpjiaajSxOeiWiEy1HYFLN+ThQuCJM2HBVsJYxeVkJmjEhAcMSwPz+cj3SiFbb33JaF4AoHc8+J6a8Kwmldkn4ifyFSBY0vy52nm62pNx7proCtCh0MYlv9LZGuVar6gZANuGlxYqeUJfODSoBQ41JJhfuc6N/G/EWYpcudj7qy0tZFNlyEp9AqCIVBMgoV8E5ZbOh72q0KJofWuDEskC31OhxtdXszy9SEy6nufFFDPr/p9atg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zIvjVpqB/fL35eS1l2YhNl3FayD9XHqpK2Ca/xh6GI=;
 b=J9CVMOZsvNmLWwwZNHZh9czQWqnX7dHCPQ6PYtch3GivbPZt7FolX0ekRd9s4FwfdsDcBSr/eyVnmHFt4g+/s11jGGAVuD5fzW93Xhg/32TPfevut7yRQPXvEOTUbQczxMDjovEkQrgtSmVU4T2ul5cNc6mQIZKqck90R8nVVZ0=
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by CO1PR10MB4724.namprd10.prod.outlook.com (2603:10b6:303:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 13 Nov
 2023 18:34:35 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::b1c2:c24b:ea19:dc51]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::b1c2:c24b:ea19:dc51%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 18:34:35 +0000
Message-ID: <4c71d3e3-2e6c-4a88-b251-d6dad64ae8de@oracle.com>
Date: Mon, 13 Nov 2023 10:34:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] af_unix: fix use-after-free in
 unix_stream_read_actor()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller"
 <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
        syzbot+7a2d546fa43e49315ed3@syzkaller.appspotmail.com
References: <20231113134938.168151-1-edumazet@google.com>
From: Rao Shoaib <rao.shoaib@oracle.com>
In-Reply-To: <20231113134938.168151-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::27) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4494:EE_|CO1PR10MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: 2342045c-4458-48e3-54d8-08dbe4772f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ONLA7rBh2g1RBn1W9uLCRU79YFWaDso9Y50ivwbb++o4P1P6iUmniInqEtyiTHeRzGzKXBC1bvm0TThHWs04b7V8yHfaq0UvPAn7l2eNayAvo/+KLXgJzm36BAloDLt/cnzKTZF6NnSZNUh9EVjO29bSVWcbF3zP4aj0tXLBPXa/5+p26+ZDMGUKxTaUkBz2lSLOdWvK44szBgiGp1lD9IUYXxx5XT1AYvrmfHuUrfnBYo769rZzypij8yeWzHrJGmNDFXZdbNUcSvhYc/ZPNfga571z81i5D6556sG27SGCHR1xd94qICCiCt2y7iRaGIJs8+wmZfQiX0ZfUZ4JAta/zfMZAC6ji+ZIbzTt1GbOxLLcApw8EA2TTIP1OrcA+DoyJ2+sw9thdVb9dhvqJiPxrLk04TGdCv/p8zrQufpWzVSCByxaSuxMPHVPHuq0Z4HLw26caOCwupnWZdsx8rej6zIhxMHkYOEvr7uEO0U0DPzpHLd6cxsf3mIVdcwzgbPekFRLB4BIoYvCbhPvWZl0WbFOcCxj5VxP1yWY4L+/1KPIbHbKZo0hwPUQl58DuPDJa/RH8xMCwNxzaj41ISbRfDxhfFPU1LXt4S/e6Rmv2yLA+DZhPZJ1JusKCDA/OVkQV43czWykpfv+DXgYGQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(44832011)(2616005)(5660300002)(86362001)(31696002)(41300700001)(26005)(110136005)(66556008)(66946007)(6512007)(66476007)(316002)(38100700002)(83380400001)(31686004)(36756003)(478600001)(6486002)(53546011)(6506007)(8676002)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SnBJVWpUVEM0eW1RRTE3WjZCdk5La2Nid3VEWFBreFpyM3dtVnVVekhodU5J?=
 =?utf-8?B?T3dsSGJhNzJCWnh4bW10S0kxQUN6eDdqd2ZVM2laSTZPaGNiV2JXdTh6dzQ5?=
 =?utf-8?B?c1pla1djdnA5VjEvVjJHL1ZTd2tOTEV1STNQN0x3QUFQSWhYOHFzOVJvOFht?=
 =?utf-8?B?ekFWOGNwQytNblk1RmlVbFdIRkRiREd2aEpaeEo5Ymx6WWQ4MkM1QUE3emQ0?=
 =?utf-8?B?TFAvS3hZTHdaYW82dGpkSnlJT2ZVVyt0bU5ESDA0OE5ZcldkQnhjTitIRk9H?=
 =?utf-8?B?dzJPeFBWMGNuazkxWHdPejVXUGErcVlncDFpUnNQMlZwaUZMSHQrcUU4QndZ?=
 =?utf-8?B?ODFJZlJiMm5vaG5QeURwSkk5bVNQcEN3M0tIQnMxWTc0RFpsbzM2RE1TUllz?=
 =?utf-8?B?VFNkUWV4dlNXMjlJVG9JUjBrdjNOamJMMXNzR28yMkhvVE9IRGFEejlhbys3?=
 =?utf-8?B?RzF5MzFzamY3d05kQlM5enFYUjVXeWRmUHBDVklaRm84U0Vrb3JEcG53d2Ji?=
 =?utf-8?B?bkg2THJTdm1YVkZDWXp3cjNhU0RHdnRsOU5oa0M3WDVJUDdtR0dYVGVTd3Jr?=
 =?utf-8?B?NFo1U1crRjdYdkpmQms1SXhZdzZMUlVmRTVMMTZaOXVkOU5odmRmay9KTmdR?=
 =?utf-8?B?c1hTNWRKNHNPdzdZUlkyZ1QwejBlSnN4VTFXempCREp2RG11T1RSUEFnUVA3?=
 =?utf-8?B?WmFWcHRUb2xib282Ri8veEZUc0hkZU9CZlozWS9SSmFXc1lhNDJSWE5aY0Fk?=
 =?utf-8?B?VnJMQnBFek5KV25lNkt5cFltK21xb3k0bVV6K2JuQVMxVWN4RDRRbFdwN3pJ?=
 =?utf-8?B?K1dYRWlCWHZTVEx0TnNNMlNaMEVOd09ISUVIMGxvbi8xZU1DbFkxRzRpUDY3?=
 =?utf-8?B?dEdxUzNlUVd5ZDB6Q0wyUmxQNFB2MHFITVVIcEFZRFVkZVVWRWdSVGJwMGZo?=
 =?utf-8?B?NkhpdVdIT1JPNFJvY0E1bFBkMGVLczAwQlI3bW9nVldkN0JqMmhnOXo1Ritq?=
 =?utf-8?B?SVd5WHJvN3hhblVWbUhFWVV2STlLSmpFTWRxTFRPdFdzNGp6b3dKTnNKMXZm?=
 =?utf-8?B?VjNibTRtSVY1SVgxTzhtM1U1cTRLeS9JWWYyMzFEQ3ZwY3VpVVRWa29LeWNS?=
 =?utf-8?B?Ym9QT1BsS2VBbFY1TnA1MDNpcmVZc0o1UGt4ZUdCYUZwajI4bG1RZVM3Nmhh?=
 =?utf-8?B?VFYvcVlJMHYyQXJDUTJoRHhzb2hwLzR1d3B5alE4MDY4NFJwUC9wU1Yzd1JJ?=
 =?utf-8?B?ZE45SFN1bWFZQ3ZEVXpJbU5wTXo4UCs4d3JPanpyQWZHR04wRHFBeVd4MlJJ?=
 =?utf-8?B?UDUzd1JKWVJkTjlwbHNQdXozdWxiMTRNVXZINkMxcEZ0V2NLOWFscGxKR2ND?=
 =?utf-8?B?UDJWbkpYN3QvRkdEeGZ5TzBRWGNoUzB1c1Yvek81ZmVML2xVTy9vZm9zY2kw?=
 =?utf-8?B?SDI0SlhaWkJVQXZTRXR3UzNXTTlWdVNTSWdmS2xPMlNoeGZ1em9QaVFRMW1E?=
 =?utf-8?B?L2J2ODU1NlNoZEIrNjZDNkNsdUsrZ2tqREt1SVFrdGVtZWNKYWVSV3l3TmZq?=
 =?utf-8?B?Nkt0akREaThBbjVvZEk1MUUvbU93VnEwZlo2WFlpV0VyTHp0TTJSMnltbXAw?=
 =?utf-8?B?cHRhRFhQR1RLTWxKQml4c0hxYld0WlZGNEkzYjFXaHVNVzY2QnBqelNjTjZm?=
 =?utf-8?B?cjlOUUFjSFI4bTFVUTBWdzVOa0x5dElYWHJuV08rS0paYUVHaXZrTUZVUVp5?=
 =?utf-8?B?dk54VXdMSUJJb3pMNGRrM1RySDQ1Y2diRlV1WW9UOFl3TDJNcmtOZHZBdVhn?=
 =?utf-8?B?dUplRXY5dzM5OEVFaWsyT2NkckVQSVZOdGpLWWdkTGE4K0g0L2dDZFk0NW9o?=
 =?utf-8?B?RUdkUmhubnhNMERlbVpCNWZGcnl6RnZJS3oxMXdkNi9yek8vWjNZVEhjWGRK?=
 =?utf-8?B?YVpSSWhqWDZPMnlkL2tQQ3ErUDEzSGRaTUI0YXdKZ1BxMk9CYkFJWFpteDh2?=
 =?utf-8?B?VTNET1VpN3JXWGFmeHR0SnluSjhRT2t2c3hxQ2xlRjZNdUc1RTEyY2NRRnpa?=
 =?utf-8?B?WW9HdTlqV2VsU1U0cmQrQ21Gc2s1TWxRbzR2YzNPc1BtVUZoNi93R1pCandO?=
 =?utf-8?Q?LP6MN2iwLtFSfYG3UjlbBE+Ce?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?WXVKOFBWbHlKVC9Pd2w1Qy9mOG8xaVdFUTdldWUreENEVUVQZDNJdjJpK3M5?=
 =?utf-8?B?cytCanhqZmlsbGE2d2hTamRvUWExZzRnamQ2OGx1aTU5NzE0UFV5QTZ6S0Fj?=
 =?utf-8?B?aVBvTW9vbEtXaUxOd3NWMVBUWFdFOVJWYUorRm55WHRqRjJMbVNPVnhMQXBy?=
 =?utf-8?B?QkJoSjE4WlAvOFBGaWc1RnE4UTQ3WW9vS0pqR2xQNDN3OFNLdFBWYUtoQXVv?=
 =?utf-8?B?NXlyeHZVSEJRVFo3SkJJMVF0MWNYNm1sWVgzdnIyOUNBM3FPa3BTR1NscFNK?=
 =?utf-8?B?L3NTWS9hb1lkL2syM3dnM2hqN3diZjhnSEN6YWx6NC9oYTYxc0JoS0NCcTN1?=
 =?utf-8?B?Ry9UcDE4c1l6YTFGZkFoYkI4NVBDU0lrZXFaTmlsYk9BbUZNSE5NSnZPbzJE?=
 =?utf-8?B?TFhIK3hqeG9ySzc4RjAwSEs3RDNhK0pOVDloWVFPRjlRZ3BqVnBobjErOW1E?=
 =?utf-8?B?aXVQdjdyU016RlNEUEE1MmZ1MjMvUmpMOGtSNTY2Wk9BMjU2L2xLRnEzc3k3?=
 =?utf-8?B?elZKZEl5UDRxM2ttc2VUK01vaDNJY1pNM3hXbHAyd3FETGtOdExHTEppRXJH?=
 =?utf-8?B?OTlJaVRPRDd3QTY0YXZWbUd5UUQ4a0lFMG9JMTBubG9oZjlKLzdvVGJnZkx2?=
 =?utf-8?B?Wm1yajE5TzlWSHlFZ3VWbW00OTNBRCtXeGw3dVp2bnJhSzdpUGdoODhiOU05?=
 =?utf-8?B?ZXRxYUNrUGIvYTRuSGNmcVdZU0ZQWThJM0FTZm9OYkpnRzZ3VkdqOHVVMCtp?=
 =?utf-8?B?UTBBOEtFV3FhN0tRVVdpaUwzbHZTOFJ6cEFIOE1NdUphZGFBRVlJY2dIaFRH?=
 =?utf-8?B?UG9KemVCSlltcC92WThvUkF3NVhCZHN1cW9kTCt2ZzQ5N2FhT2pMWE5keGNk?=
 =?utf-8?B?RXh0MjRFVWcxYXJydmtVZVpjL3JjL3dmcDYyamJTLzk5M1Z2OXFnQzE0YVV1?=
 =?utf-8?B?TTNyNnA5WXUrNDFSN1lWWWVwNDl2S2pUU2ZaV21JT3hKYnlZVDR5NG5IZXAy?=
 =?utf-8?B?MEFTUGFGWkh1bVdXcXZJZlBtVHpvSnB4RVRIUmtpa3NhejVWUUVJVmc0ckpL?=
 =?utf-8?B?Y0N0U1htZ3k0eWpDY0E4VEF4bEZ6ZVBiRlVlNkF2MjltL3RIZEtLUVNvTG9L?=
 =?utf-8?B?NDNWUVVaU3c5dFh3ekgzMUxwb3JKOS9aRWd0K2VUa2plZGZJL3BkL1VFYVRi?=
 =?utf-8?B?emVwUnovVEpub1krVHNLS0hVZVJJWlhROVFwTzhuWi8wb3NDZWZPL29iNnZX?=
 =?utf-8?B?NEkwc1ovcTVxSzJnNEE4VVB6QXVVclNqa3RiYVJRQzRhbmYzY0tRMVJ3RXMw?=
 =?utf-8?Q?+qmxy0tJI9Qas=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2342045c-4458-48e3-54d8-08dbe4772f62
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 18:34:35.2155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXUXKbBjRY4gR12CFXG/wi7/VhlbHZphjR0K98HgjSkrLAJ48JEakZJtqq4fYi77sPwO6iP4WdYjYS8PxMuPaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_09,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311130151
X-Proofpoint-ORIG-GUID: eGHU47rmABgAdePe5s_PjUfWyteSQq8j
X-Proofpoint-GUID: eGHU47rmABgAdePe5s_PjUfWyteSQq8j

Looks good!

Reviewed-by: Rao shoaib <rao.shoaib@oracle.com>

On 11/13/23 05:49, Eric Dumazet wrote:
> syzbot reported the following crash [1]
> 
> After releasing unix socket lock, u->oob_skb can be changed
> by another thread. We must temporarily increase skb refcount
> to make sure this other thread will not free the skb under us.
> 
> [1]
> 
> BUG: KASAN: slab-use-after-free in unix_stream_read_actor+0xa7/0xc0 net/unix/af_unix.c:2866
> Read of size 4 at addr ffff88801f3b9cc4 by task syz-executor107/5297
> 
> CPU: 1 PID: 5297 Comm: syz-executor107 Not tainted 6.6.0-syzkaller-15910-gb8e3a87a627b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
> print_address_description mm/kasan/report.c:364 [inline]
> print_report+0xc4/0x620 mm/kasan/report.c:475
> kasan_report+0xda/0x110 mm/kasan/report.c:588
> unix_stream_read_actor+0xa7/0xc0 net/unix/af_unix.c:2866
> unix_stream_recv_urg net/unix/af_unix.c:2587 [inline]
> unix_stream_read_generic+0x19a5/0x2480 net/unix/af_unix.c:2666
> unix_stream_recvmsg+0x189/0x1b0 net/unix/af_unix.c:2903
> sock_recvmsg_nosec net/socket.c:1044 [inline]
> sock_recvmsg+0xe2/0x170 net/socket.c:1066
> ____sys_recvmsg+0x21f/0x5c0 net/socket.c:2803
> ___sys_recvmsg+0x115/0x1a0 net/socket.c:2845
> __sys_recvmsg+0x114/0x1e0 net/socket.c:2875
> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7fc67492c559
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc6748ab228 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
> RAX: ffffffffffffffda RBX: 000000000000001c RCX: 00007fc67492c559
> RDX: 0000000040010083 RSI: 0000000020000140 RDI: 0000000000000004
> RBP: 00007fc6749b6348 R08: 00007fc6748ab6c0 R09: 00007fc6748ab6c0
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc6749b6340
> R13: 00007fc6749b634c R14: 00007ffe9fac52a0 R15: 00007ffe9fac5388
> </TASK>
> 
> Allocated by task 5295:
> kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
> kasan_set_track+0x25/0x30 mm/kasan/common.c:52
> __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:328
> kasan_slab_alloc include/linux/kasan.h:188 [inline]
> slab_post_alloc_hook mm/slab.h:763 [inline]
> slab_alloc_node mm/slub.c:3478 [inline]
> kmem_cache_alloc_node+0x180/0x3c0 mm/slub.c:3523
> __alloc_skb+0x287/0x330 net/core/skbuff.c:641
> alloc_skb include/linux/skbuff.h:1286 [inline]
> alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6331
> sock_alloc_send_pskb+0x7e4/0x970 net/core/sock.c:2780
> sock_alloc_send_skb include/net/sock.h:1884 [inline]
> queue_oob net/unix/af_unix.c:2147 [inline]
> unix_stream_sendmsg+0xb5f/0x10a0 net/unix/af_unix.c:2301
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg+0xd5/0x180 net/socket.c:745
> ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
> ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
> __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Freed by task 5295:
> kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
> kasan_set_track+0x25/0x30 mm/kasan/common.c:52
> kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
> ____kasan_slab_free mm/kasan/common.c:236 [inline]
> ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
> kasan_slab_free include/linux/kasan.h:164 [inline]
> slab_free_hook mm/slub.c:1800 [inline]
> slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
> slab_free mm/slub.c:3809 [inline]
> kmem_cache_free+0xf8/0x340 mm/slub.c:3831
> kfree_skbmem+0xef/0x1b0 net/core/skbuff.c:1015
> __kfree_skb net/core/skbuff.c:1073 [inline]
> consume_skb net/core/skbuff.c:1288 [inline]
> consume_skb+0xdf/0x170 net/core/skbuff.c:1282
> queue_oob net/unix/af_unix.c:2178 [inline]
> unix_stream_sendmsg+0xd49/0x10a0 net/unix/af_unix.c:2301
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg+0xd5/0x180 net/socket.c:745
> ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
> ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
> __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> The buggy address belongs to the object at ffff88801f3b9c80
> which belongs to the cache skbuff_head_cache of size 240
> The buggy address is located 68 bytes inside of
> freed 240-byte region [ffff88801f3b9c80, ffff88801f3b9d70)
> 
> The buggy address belongs to the physical page:
> page:ffffea00007cee40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1f3b9
> flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
> page_type: 0xffffffff()
> raw: 00fff00000000800 ffff888142a60640 dead000000000122 0000000000000000
> raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 5299, tgid 5283 (syz-executor107), ts 103803840339, free_ts 103600093431
> set_page_owner include/linux/page_owner.h:31 [inline]
> post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1537
> prep_new_page mm/page_alloc.c:1544 [inline]
> get_page_from_freelist+0xa25/0x36c0 mm/page_alloc.c:3312
> __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4568
> alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
> alloc_slab_page mm/slub.c:1870 [inline]
> allocate_slab+0x251/0x380 mm/slub.c:2017
> new_slab mm/slub.c:2070 [inline]
> ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
> __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
> __slab_alloc_node mm/slub.c:3375 [inline]
> slab_alloc_node mm/slub.c:3468 [inline]
> kmem_cache_alloc_node+0x132/0x3c0 mm/slub.c:3523
> __alloc_skb+0x287/0x330 net/core/skbuff.c:641
> alloc_skb include/linux/skbuff.h:1286 [inline]
> alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6331
> sock_alloc_send_pskb+0x7e4/0x970 net/core/sock.c:2780
> sock_alloc_send_skb include/net/sock.h:1884 [inline]
> queue_oob net/unix/af_unix.c:2147 [inline]
> unix_stream_sendmsg+0xb5f/0x10a0 net/unix/af_unix.c:2301
> sock_sendmsg_nosec net/socket.c:730 [inline]
> __sock_sendmsg+0xd5/0x180 net/socket.c:745
> ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
> ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
> __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
> page last free stack trace:
> reset_page_owner include/linux/page_owner.h:24 [inline]
> free_pages_prepare mm/page_alloc.c:1137 [inline]
> free_unref_page_prepare+0x4f8/0xa90 mm/page_alloc.c:2347
> free_unref_page+0x33/0x3b0 mm/page_alloc.c:2487
> __unfreeze_partials+0x21d/0x240 mm/slub.c:2655
> qlink_free mm/kasan/quarantine.c:168 [inline]
> qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
> kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:294
> __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
> kasan_slab_alloc include/linux/kasan.h:188 [inline]
> slab_post_alloc_hook mm/slab.h:763 [inline]
> slab_alloc_node mm/slub.c:3478 [inline]
> slab_alloc mm/slub.c:3486 [inline]
> __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
> kmem_cache_alloc+0x15d/0x380 mm/slub.c:3502
> vm_area_dup+0x21/0x2f0 kernel/fork.c:500
> __split_vma+0x17d/0x1070 mm/mmap.c:2365
> split_vma mm/mmap.c:2437 [inline]
> vma_modify+0x25d/0x450 mm/mmap.c:2472
> vma_modify_flags include/linux/mm.h:3271 [inline]
> mprotect_fixup+0x228/0xc80 mm/mprotect.c:635
> do_mprotect_pkey+0x852/0xd60 mm/mprotect.c:809
> __do_sys_mprotect mm/mprotect.c:830 [inline]
> __se_sys_mprotect mm/mprotect.c:827 [inline]
> __x64_sys_mprotect+0x78/0xb0 mm/mprotect.c:827
> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
> entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Memory state around the buggy address:
> ffff88801f3b9b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88801f3b9c00: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
>> ffff88801f3b9c80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ^
> ffff88801f3b9d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
> ffff88801f3b9d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
> 
> Fixes: 876c14ad014d ("af_unix: fix holding spinlock in oob handling")
> Reported-and-tested-by: syzbot+7a2d546fa43e49315ed3@syzkaller.appspotmail.com
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Rao Shoaib <rao.shoaib@oracle.com>
> ---
>   net/unix/af_unix.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 45506a95b25f8acdb99699c3c9256f50d0e7e5d0..a357dc5f24046d98674da9935eccbb9e18ea4616 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2581,15 +2581,16 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
>   
>   	if (!(state->flags & MSG_PEEK))
>   		WRITE_ONCE(u->oob_skb, NULL);
> -
> +	else
> +		skb_get(oob_skb);
>   	unix_state_unlock(sk);
>   
>   	chunk = state->recv_actor(oob_skb, 0, chunk, state);
>   
> -	if (!(state->flags & MSG_PEEK)) {
> +	if (!(state->flags & MSG_PEEK))
>   		UNIXCB(oob_skb).consumed += 1;
> -		kfree_skb(oob_skb);
> -	}
> +
> +	consume_skb(oob_skb);
>   
>   	mutex_unlock(&u->iolock);
>   

