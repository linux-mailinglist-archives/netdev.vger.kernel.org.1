Return-Path: <netdev+bounces-304885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mbleEJlXS2rePgEAu9opvQ
	(envelope-from <netdev+bounces-304885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 09:22:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C2A70D772
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 09:22:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="Day/Bmxl";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=FrDxuPuK;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304885-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304885-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2768B34F86E1
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 06:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AB13EAC9A;
	Mon,  6 Jul 2026 06:32:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93633E5A21
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 06:32:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319551; cv=none; b=EBnml2FVKo8xWR3GhN6lA2GKTMsgNQUVRM6om73GUePLZsm3kjLe7hmXEY9vWcB4QFrdM9f4/BCsFnZnaq7xpxfU1FdgMl1Rnh9g2QZ56cl5ou+qPJeDjn9YS26z6/viuCAFAFE6dvWUiHdHHEhJnRA0LKAzCilZH5AqqzfC8UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319551; c=relaxed/simple;
	bh=2ukGz3VQdURdNyZn+6PUsVFRx6r+MoLKEuqGM4+bhb4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kkaxu8HgXaIHXs5tqlj/iZflXZGfGAbDnStyOfj9T3/HGoHmPjrADJRicIATsyRazB3dso9CoBZRa9vawkExNXIOKN1yWGu8c89xx7JqdZnoPokEah79PMsK9y6Ng7nZZdnGsfFdz/hz1HEzZEpqnoICUwtFt3H01RUeeHkJIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Day/Bmxl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FrDxuPuK; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641k9l3624654
	for <netdev@vger.kernel.org>; Mon, 6 Jul 2026 06:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k6z0zLJ+idfzdDcNIDMi1+2Af6Q2uE4kWy2ZbiprKnQ=; b=Day/BmxlH9O2G3zt
	Ho3huspU/MNJrwRpYNG/U5u015hJqJmDDWyZ3JJaN1xtRtcV65NPKfwT3bJBBSxB
	1Yt113Q59Zmj9O8an/WQhzKh6tjFk9ifAzVYzPPL0i/RWfMx6rLMLIQAKN5cVq7y
	RoYz1bNV7AV2We2pup+cZdQRK9eMPExAtEmT8BVQFj1FM+qajlwxJX8N0NFI+zlT
	BnVS1n4cOVBarhnR/lzO84p0Po92kjgGAFkxRaZ8bUP6WA2IyVYL1dbixjtCTEj6
	SCoGR/C+KtX0HHXEf1yWyrVYwBw89YzGfqWLmiYldjJZzxz8sityeFkG+2T8+ngP
	dsjhWQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4svucf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:32:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3812b0c6f23so2437086a91.1
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 23:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783319477; x=1783924277; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k6z0zLJ+idfzdDcNIDMi1+2Af6Q2uE4kWy2ZbiprKnQ=;
        b=FrDxuPuK+ut31xPuQE4JHypfSN7IjvTVrPYLW0U1HRHUFxBYrtB5mqS+Qo6lOXfrbi
         aALO4nqe4VvVr6qm4mZtXON6AKYn54jOboeYuhC6LvyizBYvqXoPIJzcXuEqJrDqSj52
         zKrv5Z0YLkKtE3oetN3eMFFZN6fd6h/I1k8oT3Ip1Nw3Qj+2n/iu9C3s3r2LgoVZFMUc
         MRzWeP6RKU99iUZJFglJOP2E+RbDCwQnlQFwuZOQnkcrqgSJxjudSfa3gEvj+/gtWJVu
         L3x7X9wWu2vDvsFsHGs70O6sjLmhmYD3YooY+gQUzLbobj9Es0zLpBAmQvuKrHqTB2lY
         oJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783319477; x=1783924277;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k6z0zLJ+idfzdDcNIDMi1+2Af6Q2uE4kWy2ZbiprKnQ=;
        b=bDvgV5yur/69U8yjwAntALj2Y6Gti9Hi2coeQjCwZMquPuBnIC6Nc0H0M8bB4FpEBO
         +jGZ/cs2HqTFFEmfp4rEAbGEG0lSX/O4Pk4YgpVTKZ+l76lQfgrnITYZMHLzw7yGUYBv
         D8H5NzsczH72AvV9MSmxlbvvKZg/pVEQYDzmHSS9C0rV2PkhewXC6CdDFttD/jW+hY05
         WqPIdXy8ZOwMXiLDwKvoAZafocNjnmzv8uO5L1U4lolaRV13p+0YnMGglr/vzj74QPY9
         DYtrBlCX5HKgLKWfBl7+8W+iC0AErc2rX770beR9gTYMjgJjpNrwEqm6yOuf/o1tLFWm
         pMQA==
X-Forwarded-Encrypted: i=1; AHgh+RrIHiBcwR9jKLU1TWTs3qPATdRoe0Eu9QHh1ggO/vMbMFbofYSreQk6K81qw7UHjLXbmPYKFCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztpGydyKKTFuHGhTJGGAl7Kv37uofQN4afWqBRvw3ADrnlYBLj
	o24LTQCLcFqtgm51YBCoE5aaRcS2hdRcJYQ/o+040WcOeNX5Zds3WmhZ6xdmACDqvNOZ1qv5uE5
	39mb6JrNAARnNlgwnMM4PgCa44nNDrrZNNfK3UAaEYfysXYhPDGdaZAdIJMw=
X-Gm-Gg: AfdE7cn8wSncaQ8A6+gvUqP5d/frFCMocRbABIjI1ksASX0iJwujJJZmGPL+Mde74hV
	pfLH4OcYfbXuYF2qb0SnG92kKaApbBMPtStqc/yAAdGKFhnxGkcUoMZ86XVSJ+5t1p9ZCjajinl
	Wbyt7wu+rGXuTJiX6SzQ+Duax2VKhFI8bYTGxr7oIaYNMFsCHG8yq7tUAZLywhkruT3fDhaoVNt
	xrUHSiJApG/0/1+3K3AplR52mJ2OGMR9qi8eYLABySKT0BvN3QCWPvfxiOazO3OrUC2HznIMAtP
	sM15WSH6rHKqVZf505jbkIW38Fpg97lp7cvggNa74rFbgYyZALIVNXs2eweoxIeZDQjF/vhYTG5
	S/CuZDKHmf89yoPVIHl1z8DXREG8loNfLObWDXs35EkMRN8RvFLBo2m4d
X-Received: by 2002:a17:90b:4c90:b0:37f:9ce1:7360 with SMTP id 98e67ed59e1d1-3829f9e3a58mr9222057a91.33.1783319476778;
        Sun, 05 Jul 2026 23:31:16 -0700 (PDT)
X-Received: by 2002:a17:90b:4c90:b0:37f:9ce1:7360 with SMTP id 98e67ed59e1d1-3829f9e3a58mr9222034a91.33.1783319476259;
        Sun, 05 Jul 2026 23:31:16 -0700 (PDT)
Received: from QCOMk1gASIiYhG ([76.120.32.211])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-381281a64c7sm4377960a91.17.2026.07.05.23.31.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jul 2026 23:31:15 -0700 (PDT)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: "'Runyu Xiao'" <runyu.xiao@seu.edu.cn>, <sean.tranchetti@oss.qualcomm.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jianhao.xu@seu.edu.cn>
References: <20260701124017.3205729-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260701124017.3205729-1-runyu.xiao@seu.edu.cn>
Subject: RE: [PATCH net-next] net: rmnet: annotate endpoint lookup under RTNL
Date: Mon, 6 Jul 2026 00:31:13 -0600
Message-ID: <000001dd0d11$0be0cd30$23a26790$@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHcZ7BKT5WQbGCOatiiZF+LrlqalrZhUpdg
Content-Language: en-us
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA2MyBTYWx0ZWRfX3moELzF50W0V
 ZQyZu4jCqdkg/nbdm27WTD8T3IbyH3cAYyUVYptIlRttBYDqmTmCugF9i5Ck8S2Dv0/PTN+NoLb
 C4PpJQQc8Of9KcYsyN11j9tbN8gS/Jw=
X-Proofpoint-ORIG-GUID: VraznULmurBPoktXL9CioatbaXRhiubi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA2MyBTYWx0ZWRfX4XjhwsjKdGik
 69zNGwfNem9MS6qvyj6SeTbwVyDoii8XEpxVbXllXXZbERw77cE6MJCnhOtnATgQXYj9TJtUCIx
 tylaLsEzS2U1NpeB/XDU6G14FYy3tySTUZGbQSrsIQlMQg2aU5qcBlxvWvQrCXARrZz/dKpQo7z
 IFT8n65Z6iNg/20K1c2e66tBz7cQ9MuwzN8u6aBuEm0kCb4249tKbUeK6gY3CkCiGG3/Jn0iLi6
 TinnscdGQbGWgiA9xyKnPpJbQbl/bkFYNsmhW8WpLYGk1DBhg2ko9O98hz0Awd9qWviDSB4FgSM
 KcNZHh82qeBpG1P0tLbduISdG0LpjfHaA9PsG/bsUQtugfLgbTIAqXb/mifK0qKWvG7qfiJPaTM
 VHu7F0OznK1JyYHF/HdgXTZuaVhRN1Ol0gYK4keJCrcehMUvq5549b71YngD5gEGiyIpecIMnY+
 +fky6kWJ4YHyo5SKr9w==
X-Proofpoint-GUID: VraznULmurBPoktXL9CioatbaXRhiubi
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4b4be7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=jMAiQizNomS0luNzNiKfDg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=0b0rcIROmjzGs64mSwgA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060063
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-304885-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:sean.tranchetti@oss.qualcomm.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[subash.a.kasiviswanathan@oss.qualcomm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[subash.a.kasiviswanathan@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72C2A70D772

> -----Original Message-----
> From: Runyu Xiao <runyu.xiao@seu.edu.cn>
> Sent: Wednesday, July 1, 2026 6:40 AM
> To: subash.a.kasiviswanathan@oss.qualcomm.com;
> sean.tranchetti@oss.qualcomm.com
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> runyu.xiao@seu.edu.cn; jianhao.xu@seu.edu.cn
> Subject: [PATCH net-next] net: rmnet: annotate endpoint lookup under RTNL
> 
> rmnet_get_endpoint() is shared by packet receive paths and RTNL-protected
> control paths. The receive paths already run under RCU/BH context through
> the RX handler, while the control paths reach
> rmnet_get_endpoint() after obtaining the rmnet port with
> rmnet_get_port_rtnl().
> 
> The helper walks port->muxed_ep[] with hlist_for_each_entry_rcu(). Pass
> lockdep_rtnl_is_held() as the non-RCU protection condition so
> CONFIG_PROVE_RCU_LIST can see the RTNL-protected control-path calls
> while preserving the existing RCU-reader behavior for data paths.
> 
> This was found by our static analysis tool and then manually reviewed
against
> the current tree. The dynamic triage evidence is a target-matched
> CONFIG_PROVE_RCU_LIST warning; the change is limited to documenting the
> existing protection contract.
> 
> This is a lockdep annotation cleanup. It does not change endpoint lifetime
or
> hash updates.
> 
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> index ba8763cac9d9..977fb80d8bf8 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
> @@ -423,7 +423,8 @@ struct rmnet_endpoint *rmnet_get_endpoint(struct
> rmnet_port *port, u8 mux_id)  {
>  	struct rmnet_endpoint *ep;
> 
> -	hlist_for_each_entry_rcu(ep, &port->muxed_ep[mux_id], hlnode) {
> +	hlist_for_each_entry_rcu(ep, &port->muxed_ep[mux_id], hlnode,
> +				 lockdep_rtnl_is_held()) {
>  		if (ep->mux_id == mux_id)
>  			return ep;
>  	}
> --
> 2.34.1

Reviewed-by: Subash Abhinov Kasiviswanathan
<subash.a.kasiviswanathan@oss.qualcomm.com>


