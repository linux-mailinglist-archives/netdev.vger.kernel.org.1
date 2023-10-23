Return-Path: <netdev+bounces-43425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134307D2F5D
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 12:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA18B20BF6
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 10:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA05614001;
	Mon, 23 Oct 2023 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nuFWxfmb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1764312B9E
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 10:01:36 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E174DA
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 03:01:35 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N9watA032735;
	Mon, 23 Oct 2023 10:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=cUEFH/WIaFD0Dy3RXoMkvc3MvZAiFj8Ir4OOGMzHmQ8=;
 b=nuFWxfmbip5QAiZii0mPxlmm255eORp1OONLbwYOidsMEx7FJ3bJo9dsQ/UN2otmNG+M
 tOxPqYfxuh2L4nXiQImznCiZITFgLLi0OYDZHX3rpIrAlZfEQCM1hK8B7IIkF7wfFsPX
 fBQbzaV54/hvMN81Y7tf9GY5Q2EADKYo8NlVlp+d6iwQdISOZx37bhBx45RsGolNpd/c
 k83Hc7tBPg/0x5ywI00mWrLu86KT893uertOPrCb6tEdTdhxRA+WhAjqgxwIHzxYJSq9
 J6Yi9NcKkZ7vdF6Sk+PmHmhDVO6Pe4xcFhqdLJs0g9aSmN24PuTnig81JPoG9OmDgrBF Nw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv7xfv27q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Oct 2023 10:01:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39NA1RSO030165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Oct 2023 10:01:27 GMT
Received: from [10.216.19.58] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 03:01:25 -0700
Message-ID: <7ce196a5-9477-41df-b0fa-c208021a35ba@quicinc.com>
Date: Mon, 23 Oct 2023 15:31:25 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <mark.tomlinson@alliedtelesis.co.nz>, <pablo@netfilter.org>,
        <netdev@vger.kernel.org>
CC: <quic_sharathv@quicinc.com>, <quic_subashab@quicinc.com>
From: Kaustubh Pandey <quic_kapandey@quicinc.com>
Subject: KASAN: vmalloc-out-of-bounds in ipt_do_table
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XNsHKHnMYv3qnAFrAI5EcZQSt5s2G5ni
X-Proofpoint-GUID: XNsHKHnMYv3qnAFrAI5EcZQSt5s2G5ni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_08,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=416
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230086

Hi Everyone,

We have observed below issue on v5.15 kernel

[83180.055298]
==================================================================
[83180.055376] BUG: KASAN: vmalloc-out-of-bounds in ipt_do_table+0x43c/0xaf4
[83180.055464] Read of size 8 at addr ffffffc02c0f9000 by task Disposer/1686
[83180.055544] CPU: 1 PID: 1686 Comm: Disposer Tainted: G S      W  OE
  5.15.78-android13-8-g3d973ad4cc47 #1
[83180.055613] Hardware name: Qualcomm Technologies, Inc. Kalama
MTP,davinci DVT (DT)
[83180.055655] Call trace:
[83180.055677]  dump_backtrace+0x0/0x3b0
[83180.055740]  show_stack+0x2c/0x3c
[83180.055792]  dump_stack_lvl+0x8c/0xa8
[83180.055866]  print_address_description+0x74/0x384
[83180.055940]  kasan_report+0x180/0x260
[83180.056002]  __asan_load8+0xb4/0xb8
[83180.056064]  ipt_do_table+0x43c/0xaf4
[83180.056120]  iptable_mangle_hook+0xf4/0x22c
[83180.056182]  nf_hook_slow+0x90/0x198
[83180.056245]  ip_mc_output+0x50c/0x67c
[83180.056302]  ip_send_skb+0x88/0x1bc
[83180.056355]  udp_send_skb+0x524/0x930
[83180.056415]  udp_sendmsg+0x126c/0x13ac
[83180.056474]  udpv6_sendmsg+0x6d4/0x1764
[83180.056539]  inet6_sendmsg+0x78/0x98
[83180.056605]  __sys_sendto+0x360/0x450
[83180.056667]  __arm64_sys_sendto+0x80/0x9c
[83180.056725]  invoke_syscall+0x80/0x218
[83180.056791]  el0_svc_common+0x18c/0x1bc
[83180.056857]  do_el0_svc+0x44/0xfc
[83180.056918]  el0_svc+0x20/0x50
[83180.056966]  el0t_64_sync_handler+0x84/0xe4
[83180.057020]  el0t_64_sync+0x1a4/0x1a8
[83180.057110] Memory state around the buggy address:
[83180.057150]  ffffffc02c0f8f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
f8 f8 f8
[83180.057193]  ffffffc02c0f8f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
f8 f8 f8
[83180.057237] >ffffffc02c0f9000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
f8 f8 f8
[83180.057269]                    ^
[83180.057304]  ffffffc02c0f9080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
f8 f8 f8
[83180.057345]  ffffffc02c0f9100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
f8 f8 f8
[83180.057378]
==================================================================

There are no reproduction steps available for this.

I have checked along the lines and see that
https://github.com/torvalds/linux/commit/175e476b8cdf2a4de7432583b49c871345e4f8a1
is still present in this kernel.
Checked around similar lines in latest kernel and still see that
implementation hasnt  changed much.

Can you pls help check if this is a known issue and was fixed in latest
or help in pointing out how to debug this further ?

Thanks,
Kaustubh

