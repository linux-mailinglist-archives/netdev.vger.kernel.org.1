Return-Path: <netdev+bounces-126320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB56C970AC8
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 02:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0501C20BB3
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 00:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AE86FC5;
	Mon,  9 Sep 2024 00:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="NT0ddJSR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD2A4C74;
	Mon,  9 Sep 2024 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725841661; cv=none; b=KX/2I1p0JP+HRmKZUczBWd6K7jIjv3aD7xaep80iP3IgKyPY7xIPP12tX91qGgQNB+rKwzcEKm6MRpD/g0CrF3ck2f1xjWiejLk/RirzlDznfVVmNI3Og6zjP1okXDDfqEo2GiOWAyc2E22hYkPnOamRYBVf0RBvrynMeFFQiDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725841661; c=relaxed/simple;
	bh=Yoj6ce/vzbmlvzh0ggi2USWzX0BN0pIUtTJPSeil7/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dh8g4UTb4xaGiyOmbRJSVq7ugZEHeW3A4gEQNacvob+vOQ2JNJfFUKAYlGpcc6unbJg85Ns/gERl+tLQ9XF/nv/8dxnGW5vf4rflzRG2O9vmgaS62Xbox36XEops/nVp4HDuUZiSFC97EAx6zQKP6U3ziVolBNQhQYt63emUVDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=NT0ddJSR; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
	by m0409409.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 488NDe95002683;
	Mon, 9 Sep 2024 01:27:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=M3bThDj7YBFnnllltlV0H/TI0jClcdEzsz4SPKM3Qu4=; b=NT0ddJSRNyAx
	wFemg4MaUdxdlRccRnW5yu4SKHvb9/ZenJQqCqIZtAx+5sC0pfPpz6IvO9yuDNws
	H7uP4GPDC/5JC+g1OOOgRcqCHXrxaif4Nmsj90OHYzmpVT+xnWMn2b8amKg5MvSI
	CV/044z0WzRd2sS8H1GmMt3o8R0zsWUiuQAf0y27hAiIjmb4VAf6CNzaSUbYJG7c
	08LFTE1bKodq9vmawjXOv2CShKUUHHBPumiOUeUfrVqE4BW+brAOhFI+uUJs8f4u
	VepMG9HOWuxjhI+7xRE6baO8jRJ+XeYAKQlrJDvZB/vSMZQPJtlodkydQM/XvPQO
	PC0xFrQkCw==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
	by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 41h05qn679-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 01:27:18 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 488Mhd0A027573;
	Sun, 8 Sep 2024 20:27:16 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 41gj5yrr6s-1;
	Sun, 08 Sep 2024 20:27:16 -0400
Received: from [100.64.0.1] (prod-aoa-csiteclt14.bos01.corp.akamai.com [172.27.97.51])
	by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 24DAE3409B;
	Mon,  9 Sep 2024 00:27:14 +0000 (GMT)
Message-ID: <18b091c5-f86c-436b-9890-b755d09e3be6@akamai.com>
Date: Sun, 8 Sep 2024 17:27:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Neal Cardwell <ncardwell@google.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240906231700.2097588-1-johunt@akamai.com>
 <CADVnQynX0yWQA1mqWCueo-yZ1WxTkRAJ9nLjkGAne0QbeM1iZg@mail.gmail.com>
Content-Language: en-US
From: Josh Hunt <johunt@akamai.com>
In-Reply-To: <CADVnQynX0yWQA1mqWCueo-yZ1WxTkRAJ9nLjkGAne0QbeM1iZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-08_10,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxlogscore=938 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409090000
X-Proofpoint-GUID: yT2xJ2KOAmFS2cO2FPsJdzVOXuxd87xV
X-Proofpoint-ORIG-GUID: yT2xJ2KOAmFS2cO2FPsJdzVOXuxd87xV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=721 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090001

On 9/8/24 10:50 AM, Neal Cardwell wrote:
> 
> Since this is targeted to the net branch to fix crashes at least as
> far back as 5.4, AFAICT it would be good to have a Fixes: footer, so
> maintainers know how far back in stable release history to apply the
> fix.
> 
> I'd suggest pointing to this linux/v4.13 commit:
> 
> Fixes: e1a10ef7fa87 ("tcp: introduce tcp_rto_delta_us() helper for
> xmit timer fix")
> 
> The bug actually predates that commit (the code before that already
> assumed tcp_write_queue_head() was non-NULL in tcp_rearm_rto() if
> packets_out is non-zero). But that commit is the first point at which
> tcp_rto_delta_us() exists as a function and so it's straightforward to
> apply the patch (albeit with some conflicts in earlier kernels). And
> that commit is far enough back to imply that the fix should be
> backported to all "longterm" releases listed at

Thanks Neal. I'll add this fixes tag.

> 
> IMHO it would be nice to have the WARN_ONCE print more information, to
> help debug these cases. This seems like some sort of packet counting
> bug, so IMHO it would be nice to have more information about packet
> counts and MTU/MSS (since MTU/MSS changes force recalculation of
> packet counts for skbs and the scoreboard, and have thus been a
> traditional source of packet-counting bugs). Perhaps something like
> the following (compiled but not tested):
> 
> +               WARN_ONCE(1,
> +                         "rtx queue empty: "
> +                         "out:%u sacked:%u lost:%u retrans:%u "
> +                         "tlp_high_seq:%u sk_state:%u ca_state:%u "
> +                         "advmss:%u mss_cache:%u pmtu:%u\n",
> +                         tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
> +                         tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
> +                         tcp_sk(sk)->tlp_high_seq, sk->sk_state,
> +                         inet_csk(sk)->icsk_ca_state,
> +                         tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
> +                         inet_csk(sk)->icsk_pmtu_cookie);
> 

Makes sense. I agree more info to help debug is better. I'll review the 
suggested additions and spin a v3.

Thanks!
Josh

