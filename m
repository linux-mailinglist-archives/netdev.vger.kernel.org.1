Return-Path: <netdev+bounces-259967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHdjGb0hnGkZ/wMAu9opvQ
	(envelope-from <netdev+bounces-259967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:45:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F2D1741EA
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A9BC301D05E
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E2234F48F;
	Mon, 23 Feb 2026 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n2MBqtR7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IyqQbwV6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6267C1D5147
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771839881; cv=none; b=gdFYP8R9M15SR74JLLLvh9DS0CwGyFLQbC5ANbmfHc3wK+8gmIp2Di2enmJNszMThHZ4t7KdMYpotIPEaquU94XYuXXYwywHltP60ipSwtAxjdTL3faoWIpBgsTSYZfjbInJimewZ6R2cOHjvAe07f0f/rtt4ev/X5+Vt92buTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771839881; c=relaxed/simple;
	bh=iS/VY5KtURVTTjkX9EUs9Mrk/BXo67sGTVo1KhtK0yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xs/gfxVDDDQgvy1THlTB1VahhFyLIz0DB5zC1L699dkF/SgmDzzg3TNmjD8tmZu/4L0ZsW4I7YcqCjPmyv/DpuezQgmLryzqkocrQKgst/cBnUWw51FJB+t71jvovMVbpDhbxyhbpYYV8XP6SS/RTt3xKHeXjAAxhEyhXhfALzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n2MBqtR7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IyqQbwV6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N72kj8651253
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=s5Q1vewngJBr91qKkgV5B9pJ
	GBBUeF9wD7BUkTBzUfE=; b=n2MBqtR7gZ7QAYFzUxcvE7xcMUV1W5cLFgQKuEv5
	1KDQfXbHtb35D9yelPJZHf5693s843xj8H87QMweMacHIo/3UJikgZAf53lPxm0u
	Uoj3QwgVpAzYjQh8q09VaLvcHESPeyzvQgkswD1htJ0XsC1MYTRZtVcMTGtamxK7
	2eXX5BJXYJtZGg0KyXsjcgpsarZm/ww0OsJQ+RUQJtEIp8S8T5Mjq2qoHrg6tKeH
	kyyCNKRuFNaR7LVHRvOvuItfjYsEI7O7JOXvFHjvd7kXn5TC0/2v7phbDFfP8ygD
	PXA5l8ZHheUPn17OeqJkIn8OROqOTenQScspNmE1Yrqx5w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wav7gn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:44:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a944e6336eso289225775ad.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 01:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771839879; x=1772444679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s5Q1vewngJBr91qKkgV5B9pJGBBUeF9wD7BUkTBzUfE=;
        b=IyqQbwV6A4MKEfg6mJKu/sGNTZtsroQeqOsbgcIuMxFlCI9Q8bsayZSgdxUzeCKI4N
         iThHT6zEeU3FTDoJeU8EQmQ92tLKIO6KPYtRVcfyTEylmWncd3ulOMsFzsYh0vnDeOXV
         cfcVbo7MuAeyJNMmlO40NNIM5rzv6lWsW0PTJfV8kjGqrqFJ3NvNSNiFasfJT38yF82N
         unv4vrwE/z2LN/4F6zGmsdS8x7VmC3Mv2hBXECVt2ak7RLF6NV6qxz9jgS6rZ+k/GAW5
         Hu9PVdpWBevmWAsGncq8IFpmiJ3RgNcFH7WJWOA+Igmii64qajSuSCelCeDZhDQeOgoR
         40Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771839879; x=1772444679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5Q1vewngJBr91qKkgV5B9pJGBBUeF9wD7BUkTBzUfE=;
        b=lKpH0ZqWLwghngK4CikURp8P/Cx/c+0pVV7kb5TZlcj7SmigTnhsfcL9HhMzn8GyPk
         x5CkH1Vj1uoehrJQtl3QuP0B6i3HOZUh0k7KR7DMG8ccO+2hSbatznWUiHsC5LYVsZW3
         29TV0IUtGjl/FbszCA9pBWuwTAX/CJ+LpsclYdKjLfeWneMxLsjFauSVKLRSSIZpFZ23
         iPeA1A9q8fJY43Mb0yVdRdUnQ2a7tdP3yNwzMH1R30apmIpWzxhFcN17wAgBQWHLG4Mf
         eJutKIK+nfJOu4AQALhMbLDrwewlCngu21ah3UFXjwKtOF7LdCZLuefaiBsvZ+UfYT/X
         H2vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP9nxnr5atw0g+hNxpwbo8LAM6B9kTeHH10yvNsryh0GsuLlthExeewyqaBqPEsn6cHBaSx5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU91SX5KuKZJAiBWJhY7pD/EgTU8CckvBX8/t2Nb0mcsGGpTOd
	4767VyN5pY4fDxyvDfE3UluemS9wenUkKx9w4DcnqPldM0KvQJhR7b4sfDpzz9tj1AjIbKJYid2
	ZfezcE3lY5bq0NgKVnllgu+s6djSWSz+gqxGpm3K8QIpfa0ykfy7NKBfWnUI=
X-Gm-Gg: ATEYQzyK9WzXG4Qz3OnR7c/stLdyJGkn1nGYO6122R8O/aq3LC4l2vslHdOKS9t+DUB
	zsjpdutkiymjbRRrRP5VlXwHaAVvzvAqctHk3T4L82/xtNxKhAV9LOKauSSVTLBVxJLo22pS4Vt
	7LvtCqIsKlFBiJgvbpRMHL/OsWEBXuQGVHntiBjLPHHO3mlxvPOpcJ8eawgK7lPvPKhnxhTnupt
	nUuGHEphNci5bpoBatSkiEkhfdfJswv7t37zXN9w2rrk4Wsl1dqTnzaHu6E8r3mrqnv9vVjJJY6
	eY0LKNnEkLXEYFMEF8A4TECdDhM7XVlQtaAHmESfeJNcdXMHulVotEJIXkkNkA40etIX9bZAgE5
	FHmkQJ8C7lrWLTatPmT/MY7T5IstdvITstVA=
X-Received: by 2002:a17:903:1aa8:b0:2aa:d1e1:29d5 with SMTP id d9443c01a7336-2ad74556f97mr80693955ad.50.1771839879039;
        Mon, 23 Feb 2026 01:44:39 -0800 (PST)
X-Received: by 2002:a17:903:1aa8:b0:2aa:d1e1:29d5 with SMTP id d9443c01a7336-2ad74556f97mr80693685ad.50.1771839878545;
        Mon, 23 Feb 2026 01:44:38 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34247sm63334265ad.6.2026.02.23.01.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:44:38 -0800 (PST)
Date: Mon, 23 Feb 2026 15:14:31 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC net-next+ 4/9] net: stmmac: qcom-ethqos: convert to
 use phy_set_mode_ext()
Message-ID: <aZwhfzkk740kUegR@oss.qualcomm.com>
References: <aZcGxDBwfMXHbo_O@shell.armlinux.org.uk>
 <E1vt3US-0000000A5eE-1RHM@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vt3US-0000000A5eE-1RHM@rmk-PC.armlinux.org.uk>
X-Authority-Analysis: v=2.4 cv=KJVXzVFo c=1 sm=1 tr=0 ts=699c2187 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=McwRrj-fpISi4v25ROEA:9 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4NCBTYWx0ZWRfXzseCrZe5+4Rx
 X7KMFxUqF3A1fD44s/2ynkcMcqqiveZFou29BnQgDpO/4XsrN1u3ZBPn3+RVBhqCX2yqcHbD6mo
 QGbmM9dwvkFWs5o6TiRSEUP90k8lL1tzakFvPM3YwSghoNyMTTTMwpKG8PU9aFrXX33N9Zw0YqX
 f6Fk3tYxf3bSDbuROXgtJiZ4CaGsvwCoWkSdzSqzv8DnULt7+kJueRROrEN0ZQK0cyHJgqj+i9L
 4E4Jo3mxvbkfYenCSVrNK7ov4zIBv0zefvjvMWvJ4oFrY6JcLAeNn/v2kj+Io3fgfpzEIFJfgRx
 GZZFaEEnikeaJ8eUG+YxNj/sdCKEYLgByRumenFlUZwCuYranUwcucZ/9TBSPbTDehrka0nvFek
 YZ+uodgAPV1PpJK5qcKbrmUq6tqd/J5WLnDjdNEcPyj8f8753jpRSLv6AnhCFgg7oG1Z/yB9jjm
 yyJYbLGaerVeFNgswBw==
X-Proofpoint-ORIG-GUID: Y5GZhTW5rJ1V3TUmV7rM9lbGdZ8c4k_b
X-Proofpoint-GUID: Y5GZhTW5rJ1V3TUmV7rM9lbGdZ8c4k_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230084
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259967-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A5F2D1741EA
X-Rspamd-Action: no action

Hi Russell,
On Thu, Feb 19, 2026 at 12:50:44PM +0000, Russell King (Oracle) wrote:
> @@ -675,20 +676,16 @@ static int ethqos_mac_finish_serdes(struct net_device *ndev, void *priv,
>  				    phy_interface_t interface)
>  {
>  	struct qcom_ethqos *ethqos = priv;
> -	int speed, ret = 0;
> +	int ret = 0;
>  
>  	qcom_ethqos_set_sgmii_loopback(ethqos, false);
>  
> -	speed = SPEED_UNKNOWN;
> -	if (interface == PHY_INTERFACE_MODE_SGMII)
> -		speed = SPEED_1000;
> -	else if (interface == PHY_INTERFACE_MODE_2500BASEX)
> -		speed = SPEED_2500;
> -
> -	if (speed != SPEED_UNKNOWN && speed != ethqos->serdes_speed) {
> -		ret = phy_set_speed(ethqos->serdes_phy, speed);
> +	if (interface == PHY_INTERFACE_MODE_SGMII ||
> +	    interface == PHY_INTERFACE_MODE_2500BASEX) {
> +		ret = phy_set_mode(ethqos->serdes_phy, PHY_MODE_ETHERNET,
> +				   interface);

Shouldn't this be phy_set_mode_ext()?

	Ayaan

