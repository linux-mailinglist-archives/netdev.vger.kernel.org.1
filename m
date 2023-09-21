Return-Path: <netdev+bounces-35630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD847AA5B9
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 01:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1F12E28344E
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 23:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5B22941D;
	Thu, 21 Sep 2023 23:37:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67A16429
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 23:37:56 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999F918C
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 16:37:52 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LNbLDj001793;
	Thu, 21 Sep 2023 23:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=oPgLwC1sigPqhnkN886g7hVjTJIWydlwpW+ZWPC14iU=;
 b=nLZvtm+EDfpnFStmFEd/oRKFiXoWQtyyfQccSIW9KrC1AF2SidIqgrjfi07eWUUPAIZ+
 ETVRXDqCs+MMq+gSCyGkgaAfJfFpRTSxQNZtVUSV5irFGiJ0w2pEaCMv6qDMFhSBIat/
 fVDXN3HY9/bB9wuiPl4QJNn7OTRm+RVRDU3YzS+AJ2Aw7mCuLVMs6nk/dqmnakhb5CJB
 Rmh+QBtWZIlu17AG88XpdG2w0g2/wNH/T+cqCR9d+3L9EHJGzdaMslcigai4qUcMuqZB
 Z2d8mhNnjVKa0iaPXpW6Sc/Ou7sjtnfvnrGuUJ7fKJ0U+X9IDTJPkET7uxMUekSuR1pO Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t8w11ux9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Sep 2023 23:37:47 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38LNbUuc002947;
	Thu, 21 Sep 2023 23:37:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t8w11ux8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Sep 2023 23:37:46 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38LN89KZ029361;
	Thu, 21 Sep 2023 23:37:46 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t8tsnmsu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Sep 2023 23:37:46 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38LNbjR77209712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Sep 2023 23:37:45 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 068EC58053;
	Thu, 21 Sep 2023 23:37:45 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5EF65805F;
	Thu, 21 Sep 2023 23:37:43 +0000 (GMT)
Received: from [9.171.4.137] (unknown [9.171.4.137])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Sep 2023 23:37:43 +0000 (GMT)
Message-ID: <f7b690e1-2afb-1126-8ca7-210dfa77ba85@linux.ibm.com>
Date: Fri, 22 Sep 2023 01:37:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 1/8] net: implement lockless SO_PRIORITY
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller"
 <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20230921202818.2356959-1-edumazet@google.com>
 <20230921202818.2356959-2-edumazet@google.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20230921202818.2356959-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2fAsoeLvgoNnAjlTXJSQRFsM8mu9JNrf
X-Proofpoint-GUID: drAn2rdJC6OH1_Xl6dURzVQWEVRvkKQ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309210205
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 21.09.23 22:28, Eric Dumazet wrote:
> This is a followup of 8bf43be799d4 ("net: annotate data-races
> around sk->sk_priority").
> 
> sk->sk_priority can be read and written without holding the socket lock.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   drivers/net/ppp/pppoe.c           |  2 +-
>   include/net/bluetooth/bluetooth.h |  2 +-
>   net/appletalk/aarp.c              |  2 +-
>   net/ax25/af_ax25.c                |  2 +-
>   net/bluetooth/l2cap_sock.c        |  2 +-
>   net/can/j1939/socket.c            |  2 +-
>   net/can/raw.c                     |  2 +-
>   net/core/sock.c                   | 23 ++++++++++++-----------
>   net/dccp/ipv6.c                   |  2 +-
>   net/ipv4/inet_diag.c              |  2 +-
>   net/ipv4/ip_output.c              |  2 +-
>   net/ipv4/tcp_ipv4.c               |  2 +-
>   net/ipv4/tcp_minisocks.c          |  2 +-
>   net/ipv6/inet6_connection_sock.c  |  2 +-
>   net/ipv6/ip6_output.c             |  2 +-
>   net/ipv6/tcp_ipv6.c               |  4 ++--
>   net/mptcp/sockopt.c               |  2 +-
>   net/netrom/af_netrom.c            |  2 +-
>   net/rose/af_rose.c                |  2 +-
>   net/sched/em_meta.c               |  2 +-
>   net/sctp/ipv6.c                   |  2 +-
>   net/smc/af_smc.c                  |  2 +-
>   net/x25/af_x25.c                  |  2 +-
>   net/xdp/xsk.c                     |  2 +-
>   24 files changed, 36 insertions(+), 35 deletions(-)
> 

Thank you, Eric, for the fix!

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

