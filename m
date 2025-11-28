Return-Path: <netdev+bounces-242599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E293C927CA
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 16:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D3A74E1271
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 15:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8E2241C8C;
	Fri, 28 Nov 2025 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MWhmadvI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C322FF22
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345301; cv=none; b=WmgHfQCEDSaKqXctzxHZpgZ9KB8k3MAcBGrLFHUTC+wXf0mGg5+GMc0TO69GsCHD8xSCKKao1SnBURVKou0QsaLEdQoEXgr2i+ltQ8UsxVnbhxfiLmfyhSjrWcVbF29np/euuf81YCY/q/TdGI2vKw2zRCDWIODqlMIcHHoGqpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345301; c=relaxed/simple;
	bh=VOSnOZlbPmjY4jMTpM7NCbxuJpBaeHS5AFM/v1YAAdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6Jnvuf36hYi3Im9J7dGNd26D/Sk8rlZ+VXBum+2prrGWygDejjZ91bajONPbP6hBNclJ0mWvVQjTrfLp3gnTjTb/v1WCA5/ehGpUvVDJ9SzLZ0lMgA8BIeM87JYYuTbaN+d9yxSVYNCTDtxceICByaFrrZRggt0dwz0JgEBy6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MWhmadvI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS987rb024334;
	Fri, 28 Nov 2025 15:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TRj541
	PHrjdYGOr7N+3gi6qoUQUDy2poCPwqrfTs/wg=; b=MWhmadvIZs3dlfsu+kawe1
	4qHv7GI52lFza5PxWETkufdcCOmNju3ThdEB44bbfws4JAkxYrpYmRC+TPtvpYcq
	bwn7WKCde8wzPGHJWS8OSKsud4XpWnS9+sVLhldwYo044DdotwAOHPNsH2v7QKXT
	MvqUSE6BlfwoJPCKwweVj6sE49/X7J2dBA/hfl+RmcieJL4GkrYzv8sErMUVZEq3
	DI1KGEMwMeYp1DPdueWp8s/14bNta2+jxFpXbrndicrNcwk+27hSo8LLqGvs1FtS
	HXd2d17XIUPYRzsTyIAVh2QZKY4DCrp2z1mubULmHdKNXlgnaH+hw5efz8HtYb+Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4pjf8ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 15:54:31 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ASFsVGR013188;
	Fri, 28 Nov 2025 15:54:31 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4pjf8rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 15:54:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ASFPWV9027417;
	Fri, 28 Nov 2025 15:54:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4anq4hehjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 15:54:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ASFsQRl40567196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 15:54:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBA6420043;
	Fri, 28 Nov 2025 15:54:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87E4B20040;
	Fri, 28 Nov 2025 15:54:21 +0000 (GMT)
Received: from [9.39.27.229] (unknown [9.39.27.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Nov 2025 15:54:21 +0000 (GMT)
Message-ID: <2a040c83-822c-432a-8a5a-4875a2e4cf07@linux.ibm.com>
Date: Fri, 28 Nov 2025 21:24:20 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Remove KMSG_COMPONENT macro
To: Heiko Carstens <hca@linux.ibm.com>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Dust Li
 <dust.li@linux.alibaba.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Cc: netdev@vger.kernel.org
References: <20251126140705.1944278-1-hca@linux.ibm.com>
Content-Language: en-US
From: Sidraya Jayagond <sidraya@linux.ibm.com>
In-Reply-To: <20251126140705.1944278-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxNiBTYWx0ZWRfXyOZYTkXE1lPg
 hgcFE4NbZTNOwBPOqaUQGJ8d+cVCEsQ5Zz0Vy6vX3H3ye4mx7+8N1Ki065/XDw5WZPYmUDpGBCs
 yhYnDY4i7R5CR/aC0CSoaORFJFq8YVGmWXpH65slNShNAq4qOEY3FsZhco9bfiYm2JdppCrkdBX
 SYOuyCHusicvw0u4Y/Hb0fBHqbe2cK0E6dRhPFjXZ+lI/Ej/Nv0dR1lbT3DwL/ipa306Ovzms84
 WsqHpF8PDEM2Pxk9h/nZ6wFqPclCFrif59n3RQEBc8GQj56P00wG2g1FxbrLdU3Yotn4QRINnNI
 eyF4p3mkao+kjZZZSuEdRKa/2BjEu6QgewOIQEoryroRPZnHIqJfCZ+yGjxTLZ5OM4bYm3zFfeg
 CQWgf/lqLDjbYUt735XJqFZBoAIGpA==
X-Proofpoint-ORIG-GUID: 0FYXkyg-g_uu-4Yh7ql_F7djnnicK9Pa
X-Authority-Analysis: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=6929c5b7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=07d9gI8wAAAA:8 a=VnNF1IyMAAAA:8 a=NsJvohJoAAAA:8 a=UOZ5hxCXAAAA:8
 a=gUo0nQmciNYxh4_jDiEA:9 a=QEXdDO2ut3YA:10 a=e2CUPOnPG4QKp8I52DXD:22
 a=EhyWc6Ge1J1sLbzhIhWN:22
X-Proofpoint-GUID: g5GKTuYPtETyXvfQYbLVt-aUpf1ZTGsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220016



On 26/11/25 7:37 pm, Heiko Carstens wrote:
> The KMSG_COMPONENT macro is a leftover of the s390 specific "kernel message
> catalog" from 2008 [1] which never made it upstream.
> 
> The macro was added to s390 code to allow for an out-of-tree patch which
> used this to generate unique message ids. Also this out-of-tree patch
> doesn't exist anymore.
> 
> The pattern of how the KMSG_COMPONENT macro is used can also be found at
> some non s390 specific code, for whatever reasons. Besides adding an
> indirection it is unused.
> 
> Remove the macro in order to get rid of a pointless indirection. Replace
> all users with the string it defines. In all cases this leads to a simple
> replacement like this:
> 
>  - #define KMSG_COMPONENT "af_iucv"
>  - #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
>  + #define pr_fmt(fmt) "af_iucv: " fmt
> 
> [1] https://lwn.net/Articles/292650/
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  net/iucv/af_iucv.c                      | 3 +--
>  net/iucv/iucv.c                         | 3 +--
>  net/netfilter/ipvs/ip_vs_app.c          | 3 +--
>  net/netfilter/ipvs/ip_vs_conn.c         | 3 +--
>  net/netfilter/ipvs/ip_vs_core.c         | 3 +--
>  net/netfilter/ipvs/ip_vs_ctl.c          | 3 +--
>  net/netfilter/ipvs/ip_vs_dh.c           | 3 +--
>  net/netfilter/ipvs/ip_vs_est.c          | 3 +--
>  net/netfilter/ipvs/ip_vs_fo.c           | 3 +--
>  net/netfilter/ipvs/ip_vs_ftp.c          | 3 +--
>  net/netfilter/ipvs/ip_vs_lblc.c         | 3 +--
>  net/netfilter/ipvs/ip_vs_lblcr.c        | 3 +--
>  net/netfilter/ipvs/ip_vs_lc.c           | 3 +--
>  net/netfilter/ipvs/ip_vs_mh.c           | 3 +--
>  net/netfilter/ipvs/ip_vs_nfct.c         | 3 +--
>  net/netfilter/ipvs/ip_vs_nq.c           | 3 +--
>  net/netfilter/ipvs/ip_vs_ovf.c          | 3 +--
>  net/netfilter/ipvs/ip_vs_pe.c           | 3 +--
>  net/netfilter/ipvs/ip_vs_pe_sip.c       | 3 +--
>  net/netfilter/ipvs/ip_vs_proto.c        | 3 +--
>  net/netfilter/ipvs/ip_vs_proto_ah_esp.c | 3 +--
>  net/netfilter/ipvs/ip_vs_proto_tcp.c    | 3 +--
>  net/netfilter/ipvs/ip_vs_proto_udp.c    | 3 +--
>  net/netfilter/ipvs/ip_vs_rr.c           | 3 +--
>  net/netfilter/ipvs/ip_vs_sched.c        | 3 +--
>  net/netfilter/ipvs/ip_vs_sed.c          | 3 +--
>  net/netfilter/ipvs/ip_vs_sh.c           | 3 +--
>  net/netfilter/ipvs/ip_vs_sync.c         | 3 +--
>  net/netfilter/ipvs/ip_vs_twos.c         | 3 +--
>  net/netfilter/ipvs/ip_vs_wlc.c          | 3 +--
>  net/netfilter/ipvs/ip_vs_wrr.c          | 3 +--
>  net/netfilter/ipvs/ip_vs_xmit.c         | 3 +--
>  net/smc/af_smc.c                        | 3 +--
For net/smc
Acked-by: Sidraya Jayagond <sidraya@linux.ibm.com>
>  33 files changed, 33 insertions(+), 66 deletions(-)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index a4f1df92417d..1e62fbc22cb7 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -10,8 +10,7 @@
>   *		Ursula Braun <ursula.braun@de.ibm.com>
>   */
>  
> -#define KMSG_COMPONENT "af_iucv"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "af_iucv: " fmt
>  
>  #include <linux/filter.h>
>  #include <linux/module.h>
> diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
> index 008be0abe3a5..da2af413c89d 100644
> --- a/net/iucv/iucv.c
> +++ b/net/iucv/iucv.c
> @@ -20,8 +20,7 @@
>   *    CP Programming Service, IBM document # SC24-5760
>   */
>  
> -#define KMSG_COMPONENT "iucv"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "iucv: " fmt
>  
>  #include <linux/kernel_stat.h>
>  #include <linux/export.h>
> diff --git a/net/netfilter/ipvs/ip_vs_app.c b/net/netfilter/ipvs/ip_vs_app.c
> index fdacbc3c15be..d54d7da58334 100644
> --- a/net/netfilter/ipvs/ip_vs_app.c
> +++ b/net/netfilter/ipvs/ip_vs_app.c
> @@ -13,8 +13,7 @@
>   * Author:	Juan Jose Ciarlante, <jjciarla@raiz.uncu.edu.ar>
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
> index 37ebb0cb62b8..50cc492c7553 100644
> --- a/net/netfilter/ipvs/ip_vs_conn.c
> +++ b/net/netfilter/ipvs/ip_vs_conn.c
> @@ -17,8 +17,7 @@
>   * Changes:
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/interrupt.h>
>  #include <linux/in.h>
> diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
> index 5ea7ab8bf4dc..90d56f92c0f6 100644
> --- a/net/netfilter/ipvs/ip_vs_core.c
> +++ b/net/netfilter/ipvs/ip_vs_core.c
> @@ -19,8 +19,7 @@
>   *	Harald Welte			don't use nfcache
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 4c8fa22be88a..068702894377 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -13,8 +13,7 @@
>   * Changes:
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/init.h>
> diff --git a/net/netfilter/ipvs/ip_vs_dh.c b/net/netfilter/ipvs/ip_vs_dh.c
> index 75f4c231f4a0..bb7aca4601ff 100644
> --- a/net/netfilter/ipvs/ip_vs_dh.c
> +++ b/net/netfilter/ipvs/ip_vs_dh.c
> @@ -30,8 +30,7 @@
>   *
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/ip.h>
>  #include <linux/slab.h>
> diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
> index 93a925f1ed9b..77f4f637ff67 100644
> --- a/net/netfilter/ipvs/ip_vs_est.c
> +++ b/net/netfilter/ipvs/ip_vs_est.c
> @@ -12,8 +12,7 @@
>   *              get_stats()) do the per cpu summing.
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/kernel.h>
>  #include <linux/jiffies.h>
> diff --git a/net/netfilter/ipvs/ip_vs_fo.c b/net/netfilter/ipvs/ip_vs_fo.c
> index ab117e5bc34e..d657b47c6511 100644
> --- a/net/netfilter/ipvs/ip_vs_fo.c
> +++ b/net/netfilter/ipvs/ip_vs_fo.c
> @@ -8,8 +8,7 @@
>   *     Kenny Mathis            :     added initial functionality based on weight
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_ftp.c b/net/netfilter/ipvs/ip_vs_ftp.c
> index 206c6700e200..b315c608fda4 100644
> --- a/net/netfilter/ipvs/ip_vs_ftp.c
> +++ b/net/netfilter/ipvs/ip_vs_ftp.c
> @@ -16,8 +16,7 @@
>   * Author:	Wouter Gadeyne
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
> index 156181a3bacd..e6c8ed0c92f6 100644
> --- a/net/netfilter/ipvs/ip_vs_lblc.c
> +++ b/net/netfilter/ipvs/ip_vs_lblc.c
> @@ -34,8 +34,7 @@
>   * me to write this module.
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/ip.h>
>  #include <linux/slab.h>
> diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
> index a021e6aba3d7..a25cf7bb6185 100644
> --- a/net/netfilter/ipvs/ip_vs_lblcr.c
> +++ b/net/netfilter/ipvs/ip_vs_lblcr.c
> @@ -32,8 +32,7 @@
>   *
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/ip.h>
>  #include <linux/module.h>
> diff --git a/net/netfilter/ipvs/ip_vs_lc.c b/net/netfilter/ipvs/ip_vs_lc.c
> index c2764505e380..38cc38c5d8bb 100644
> --- a/net/netfilter/ipvs/ip_vs_lc.c
> +++ b/net/netfilter/ipvs/ip_vs_lc.c
> @@ -9,8 +9,7 @@
>   *     Wensong Zhang            :     added any dest with weight=0 is quiesced
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_mh.c b/net/netfilter/ipvs/ip_vs_mh.c
> index e3d7f5c879ce..f61f54004c9e 100644
> --- a/net/netfilter/ipvs/ip_vs_mh.c
> +++ b/net/netfilter/ipvs/ip_vs_mh.c
> @@ -17,8 +17,7 @@
>   *
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/ip.h>
>  #include <linux/slab.h>
> diff --git a/net/netfilter/ipvs/ip_vs_nfct.c b/net/netfilter/ipvs/ip_vs_nfct.c
> index 08adcb222986..81974f69e5bb 100644
> --- a/net/netfilter/ipvs/ip_vs_nfct.c
> +++ b/net/netfilter/ipvs/ip_vs_nfct.c
> @@ -30,8 +30,7 @@
>   * PASV response can not be NAT-ed) but Active FTP should work
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/types.h>
> diff --git a/net/netfilter/ipvs/ip_vs_nq.c b/net/netfilter/ipvs/ip_vs_nq.c
> index ed7f5c889b41..ada158c610ce 100644
> --- a/net/netfilter/ipvs/ip_vs_nq.c
> +++ b/net/netfilter/ipvs/ip_vs_nq.c
> @@ -26,8 +26,7 @@
>   *
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_ovf.c b/net/netfilter/ipvs/ip_vs_ovf.c
> index c7708b809700..c5c67df80a0b 100644
> --- a/net/netfilter/ipvs/ip_vs_ovf.c
> +++ b/net/netfilter/ipvs/ip_vs_ovf.c
> @@ -12,8 +12,7 @@
>   * active connections
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_pe.c b/net/netfilter/ipvs/ip_vs_pe.c
> index 166c669f0763..3035079ebd99 100644
> --- a/net/netfilter/ipvs/ip_vs_pe.c
> +++ b/net/netfilter/ipvs/ip_vs_pe.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/spinlock.h>
> diff --git a/net/netfilter/ipvs/ip_vs_pe_sip.c b/net/netfilter/ipvs/ip_vs_pe_sip.c
> index e4ce1d9a63f9..85f31d71e29a 100644
> --- a/net/netfilter/ipvs/ip_vs_pe_sip.c
> +++ b/net/netfilter/ipvs/ip_vs_pe_sip.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_proto.c b/net/netfilter/ipvs/ip_vs_proto.c
> index a9fd1d3fc2cb..fd9dbca24c85 100644
> --- a/net/netfilter/ipvs/ip_vs_proto.c
> +++ b/net/netfilter/ipvs/ip_vs_proto.c
> @@ -8,8 +8,7 @@
>   * Changes:
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_proto_ah_esp.c b/net/netfilter/ipvs/ip_vs_proto_ah_esp.c
> index 89602c16f6b6..44e14acc187e 100644
> --- a/net/netfilter/ipvs/ip_vs_proto_ah_esp.c
> +++ b/net/netfilter/ipvs/ip_vs_proto_ah_esp.c
> @@ -6,8 +6,7 @@
>   *		Wensong Zhang <wensong@linuxvirtualserver.org>
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/in.h>
>  #include <linux/ip.h>
> diff --git a/net/netfilter/ipvs/ip_vs_proto_tcp.c b/net/netfilter/ipvs/ip_vs_proto_tcp.c
> index 7da51390cea6..f68a1533ee45 100644
> --- a/net/netfilter/ipvs/ip_vs_proto_tcp.c
> +++ b/net/netfilter/ipvs/ip_vs_proto_tcp.c
> @@ -13,8 +13,7 @@
>   *              protocol ip_vs_proto_data and is handled by netns
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/kernel.h>
>  #include <linux/ip.h>
> diff --git a/net/netfilter/ipvs/ip_vs_proto_udp.c b/net/netfilter/ipvs/ip_vs_proto_udp.c
> index 68260d91c988..0f0107c80dd2 100644
> --- a/net/netfilter/ipvs/ip_vs_proto_udp.c
> +++ b/net/netfilter/ipvs/ip_vs_proto_udp.c
> @@ -9,8 +9,7 @@
>   *              Network name space (netns) aware.
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/in.h>
>  #include <linux/ip.h>
> diff --git a/net/netfilter/ipvs/ip_vs_rr.c b/net/netfilter/ipvs/ip_vs_rr.c
> index 6baa34dff9f0..4125ee561cdc 100644
> --- a/net/netfilter/ipvs/ip_vs_rr.c
> +++ b/net/netfilter/ipvs/ip_vs_rr.c
> @@ -14,8 +14,7 @@
>   *     Wensong Zhang            :     added any dest with weight=0 is quiesced
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_sched.c b/net/netfilter/ipvs/ip_vs_sched.c
> index d4903723be7e..c6e421c4e299 100644
> --- a/net/netfilter/ipvs/ip_vs_sched.c
> +++ b/net/netfilter/ipvs/ip_vs_sched.c
> @@ -12,8 +12,7 @@
>   * Changes:
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/spinlock.h>
> diff --git a/net/netfilter/ipvs/ip_vs_sed.c b/net/netfilter/ipvs/ip_vs_sed.c
> index a46f99a56618..245a323c84cd 100644
> --- a/net/netfilter/ipvs/ip_vs_sed.c
> +++ b/net/netfilter/ipvs/ip_vs_sed.c
> @@ -30,8 +30,7 @@
>   *
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_sh.c b/net/netfilter/ipvs/ip_vs_sh.c
> index 92e77d7a6b50..0e85e07e23b9 100644
> --- a/net/netfilter/ipvs/ip_vs_sh.c
> +++ b/net/netfilter/ipvs/ip_vs_sh.c
> @@ -32,8 +32,7 @@
>   *
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/ip.h>
>  #include <linux/slab.h>
> diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
> index 5a0c6f42bd8f..54dd1514ac45 100644
> --- a/net/netfilter/ipvs/ip_vs_sync.c
> +++ b/net/netfilter/ipvs/ip_vs_sync.c
> @@ -32,8 +32,7 @@
>   *					Persistence support, fwmark and time-out.
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/slab.h>
> diff --git a/net/netfilter/ipvs/ip_vs_twos.c b/net/netfilter/ipvs/ip_vs_twos.c
> index 8d5419edde50..dbb7f5fd4688 100644
> --- a/net/netfilter/ipvs/ip_vs_twos.c
> +++ b/net/netfilter/ipvs/ip_vs_twos.c
> @@ -4,8 +4,7 @@
>   * Authors:     Darby Payne <darby.payne@applovin.com>
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> diff --git a/net/netfilter/ipvs/ip_vs_wlc.c b/net/netfilter/ipvs/ip_vs_wlc.c
> index 9fa500927c0a..9da445ca09a1 100644
> --- a/net/netfilter/ipvs/ip_vs_wlc.c
> +++ b/net/netfilter/ipvs/ip_vs_wlc.c
> @@ -14,8 +14,7 @@
>   *     Wensong Zhang            :     added any dest with weight=0 is quiesced
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_wrr.c b/net/netfilter/ipvs/ip_vs_wrr.c
> index 85ce0d04afac..99f09cbf2d9b 100644
> --- a/net/netfilter/ipvs/ip_vs_wrr.c
> +++ b/net/netfilter/ipvs/ip_vs_wrr.c
> @@ -13,8 +13,7 @@
>   *                                    with weight 0 when all weights are zero
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
> index 95af252b2939..3162ce3c2640 100644
> --- a/net/netfilter/ipvs/ip_vs_xmit.c
> +++ b/net/netfilter/ipvs/ip_vs_xmit.c
> @@ -21,8 +21,7 @@
>   * - the only place where we can see skb->sk != NULL
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index e388de8dca09..f97f77b041d9 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -16,8 +16,7 @@
>   *              based on prototype from Frank Blaschka
>   */
>  
> -#define KMSG_COMPONENT "smc"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "smc: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/socket.h>


