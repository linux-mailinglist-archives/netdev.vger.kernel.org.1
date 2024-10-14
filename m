Return-Path: <netdev+bounces-135230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A9C99D0BD
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0219F2857F8
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331E3611E;
	Mon, 14 Oct 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rFHDaet+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361613A1B6
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918399; cv=none; b=JDa3WPSe/rNjhHv6KjeRGi/aVgOOkeugP8w/AWl6S03rvyX/MAUEkp7tKoOI8FWAVw2earkgMVxpJvrC7ySyrCZLTFUBWoUsb/k7WKZxJIuN03HTxHBLbz0ClBow0oQWQ1fBjgU2lpepz1O5ULCNLb6UFvXAI6gj9yYY4AMk8Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918399; c=relaxed/simple;
	bh=rlqisPIgxcrl3UB6dNozzBqfNvPtNK9kdcTb0jjyoNo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nEhjb9CaJmkK7jwImozYe0W6FSKQxdHUp92UDGuOht7W0ua2A/fEAEwcLy6P2ovBUlQF6VpLB5ZMdZgHfkpdCNydPYUhv4pl3r09vSlaeFTICRoqjl5kzvI/pyknVjHvAVIzbh7cbwXNsTqpwtdddb1AsNCfyihJYzRkfi4J39c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rFHDaet+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EEjaAg018002;
	Mon, 14 Oct 2024 15:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	RkWZDSgquIWesSX7qx6MZPmmwLuvrdXnNIJTvU4X96I=; b=rFHDaet+Y7khycRT
	cbVrkQfuiG6aAxPp+u25UhzKeHPbnI8sPbwcwF7V5Aa8wiUbAMLuR+WvxtvdFiBW
	bU6XrV7NDJvZ8EDYgwZvplE8iK04WQLSCAsGc1J6RrD680S/GCArVRGPLc2odZjH
	VwYF6ENi/71HQf4bdKRAtresgBugkrGzqwGKv/zw012IqqF3N3cpTA+0bp+lUytK
	EFB6RZLD+arzpAPh+vIv5VcUpYPHqg0eBDiH1G2HvvDPubgDJTYG4aNLDqD+dEEn
	gJKE6I7kB9VeI3shGT12Gp4s11rtfLJVlXM8TdJbTl0eaTKo7xTMdhkFwPKLgHlc
	rtjpPQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4295bag36u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 15:06:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49EE9BK3027467;
	Mon, 14 Oct 2024 15:06:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txf9jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 15:06:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49EF6VbC39190960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 15:06:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6483320043;
	Mon, 14 Oct 2024 15:06:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BE5820040;
	Mon, 14 Oct 2024 15:06:31 +0000 (GMT)
Received: from [9.171.19.190] (unknown [9.171.19.190])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Oct 2024 15:06:31 +0000 (GMT)
Message-ID: <c6718bb940436d7ca154c6c63b7809495210eef4.camel@linux.ibm.com>
Subject: Re: [PATCH][v2] net/smc: Fix searching in list of known pnetids in
 smc_pnet_add_pnetid
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Li RongQing <lirongqing@baidu.com>, netdev@vger.kernel.org
Date: Mon, 14 Oct 2024 17:06:30 +0200
In-Reply-To: <20241014115321.33234-1-lirongqing@baidu.com>
References: <20241014115321.33234-1-lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Nz1GY_ybIWmyPul_5Piiba4D-nXQd2Dg
X-Proofpoint-ORIG-GUID: Nz1GY_ybIWmyPul_5Piiba4D-nXQd2Dg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140106

On Mon, 2024-10-14 at 19:53 +0800, Li RongQing wrote:
> pnetid of pi (not newly allocated pe) should be compared
>=20
> Fixes: e888a2e8337c ("net/smc: introduce list of pnetids for Ethernet
> devices")
> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
> Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> Diff with v1: change commit header as Gerd Bayer suggested
> Sorry for not CC all maintainers, since this patch was rejected by
> netdev twice
>=20
> =C2=A0net/smc/smc_pnet.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 1dd3623..a04aa0e 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -753,7 +753,7 @@ static int smc_pnet_add_pnetid(struct net *net,
> u8 *pnetid)
> =C2=A0
> =C2=A0	write_lock(&sn->pnetids_ndev.lock);
> =C2=A0	list_for_each_entry(pi, &sn->pnetids_ndev.list, list) {
> -		if (smc_pnet_match(pnetid, pe->pnetid)) {
> +		if (smc_pnet_match(pnetid, pi->pnetid)) {
> =C2=A0			refcount_inc(&pi->refcnt);
> =C2=A0			kfree(pe);
> =C2=A0			goto unlock;

Thanks for adapting the subject!
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>

