Return-Path: <netdev+bounces-258078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEgqN2gli2mTQQAAu9opvQ
	(envelope-from <netdev+bounces-258078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:32:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5B911AE17
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C5BB3041A76
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB1C1487F6;
	Tue, 10 Feb 2026 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bo26i/vB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="di61skmb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5434315A
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770726642; cv=none; b=Sg9PdEDQBaokpS+GTUGDYajQvLzsYof5yUfgjyn2ONXqXPkgoJZHbpR3f5gfZS1a0XlNjOoaKf5x1qpFzAQ8wENSh6UXT0ePc+AImIdYcGDWMIo6YKUM5K0JGpXULAWJ79CluJ3N+cg9t/qefAFy1Fy9p1f3RO+2HGRuEDIk/fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770726642; c=relaxed/simple;
	bh=9Pq1prgBN9qfYnD3i0a53SHrb6ikidOFjotEVScHBSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prWbiWbN0d3BYTrCdSQ5sZXeiJHK0Hf5TjlNynuxIVF5zPgq59K9JBl8GfY3I2bNaXl54KSUmvowgc0Ej1ewKPrgKxoNBKhjb80Hnlw19/KQU1Jh2cfDApEhPbRz64fbST9aKK+VPihRYXiRsaxLWS3ZbvX1vU8WlEfcqqrI2jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bo26i/vB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=di61skmb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AA167A1172379
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 12:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tf5C3tVCVlr5koPgdEsckZhU
	RpQdzZSNvhMopb8sZWU=; b=bo26i/vBsPD6UlbD6WjFK/gHHl7FqpuuDkulWzeH
	2uXDYjbmK7R7LuAwv1VWnq7aMYdhWonMwYtnAwSebVkn4duLhWn4crYVYf5HRQzi
	f12s3mTqX3JHcfNa+nufwBIPBDD8Km3oaWdiL4NU3iH5qpW54ZzskaQgW1I06d7d
	KWgdAOjgSo7QzU8Ng54GBQ6Zi4QjTcTNtxTK7RQl1XpSdxRN8+rKRt5Op+sHLfdb
	85O9bTGYen90WS5B8esbouRxUH5CK0FYUQFI4MIJmx8/lYHOBhk6dzPJgFeqNF6C
	WQCqKWJhjQNVHARwuYbWSTkJo+uTixNlUhg3EsuiyLOBdQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7kftugt6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 12:30:39 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aad5fc5b2fso9501835ad.1
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 04:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770726638; x=1771331438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tf5C3tVCVlr5koPgdEsckZhURpQdzZSNvhMopb8sZWU=;
        b=di61skmbBqp8dFI0dB8VDAghA3adYpwxT3k8YPxvlvkmAjyJ817pRAwQPMnpApLl9H
         kVWHnLiNrK6P7hnpDSJ38HVxSQmuHkV5XALupLc9ZLE74DFzKSsZQ9POlEPCj4l4dgK+
         uJqOe31MdVPjQciE5IVcFqRY9SHMkxRxaXMjkXPDeGkzoAoYpj99MFZl8FEAI9KFMbsN
         GKFcS/Hq5AJ7fkLz8mXTqqhW2wbDLpeaqw4llMyILIHmj8xB9jH0Kmbx2bxdtSKQXNJe
         tG91l7MeTc2iHVKC6b9sYTopn+8FAw3D4pC/0QnqKMlYHc0G1CrVRj0O1cFgCNplfGQS
         6Gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770726638; x=1771331438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tf5C3tVCVlr5koPgdEsckZhURpQdzZSNvhMopb8sZWU=;
        b=pqT95XBzO4SNcNaEaeBEDXdtYiTFrdJaDYLDdYqAVVehutZOWP9USjdn1qrbsrUJ7v
         gpEpQy/bNnMDRkGBpfy0OesVgUzJ19FXqxV4JTbvUPPJMo/fyM5JjujOmXRyY/zinEFB
         +GfYhkIiv0Q35xhPoe1rn2y8gOkDu5VNZh0qFBAYumV2sGU1a38y/EZ8o9UGXkWiegfT
         bMMJC9a+AnNruNQdfPjdv8TpbUu/aAZGcSZPbCa8gBPFWTABib3CePrIIYT9jAO5sToZ
         byAwtfGN4i7VW9NI0QyhGNGzZTAmBAbTrKf2z1b+HPowlsm1E30ngvqGbuGGlcXMtrwp
         1gMw==
X-Forwarded-Encrypted: i=1; AJvYcCU0UBefHdMbR8Amdj2IBB2us+vVki9qiu8x+aJcO0gpR8xV7kzqlafi7jkyLoBUj+s2C5IZV+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmQWyy/Jc5mKNDKeVXKrpsWarmXd9Sj5QOHMwt3oRkWj6CSNuU
	a6fMQfsqmQzumRRfQjEDjbQqPB19HjVsZLJai6XewmZMHnoQeuSZ8IZrUi+xscXdREUwITX2orj
	I6zadsJsmcVPouRUPLdyO0v/IocbpKSGXWiWSwFp9olsquPmvSOIWSmZne02BE87P1EQ=
X-Gm-Gg: AZuq6aKIstNWIQrvDBdnACbvKR3CLMEGFpqMPw9hY66E2dz7zlOrLkAdfgMvKRa6Klk
	E09UrcsxMEES10a6lKAUCYMdbvxlU5xr80oKFB4TacU8ZoaNSwPd7hmfuoBXQgu+dXJM1H5pUEg
	tTaldx+cUTNId1vOQHoAFxdRoQih3V3AOydSKTsD0TzQc/+82Jih0tRHGwmtxysEBncgkvAQoTw
	OFdFkPAUv1zpOFXaaJ9JodimF3KL4iBE3oFYTUoECNa5sYyrfXwNvtcSFRftlB38VV47CAPxNVO
	eOlkJV/VA5yWCl86ZRRNSX6C15PmhhsQk0NblUqs85Ag511+U8Q0QTH86nAVVOfNJCNGWXISPIl
	QaNqfFJGqXR+HaW2Klde1q5XBsBqA0/6MoDQ=
X-Received: by 2002:a17:902:c952:b0:2aa:d333:ce84 with SMTP id d9443c01a7336-2aad333d30dmr80243165ad.11.1770726638012;
        Tue, 10 Feb 2026 04:30:38 -0800 (PST)
X-Received: by 2002:a17:902:c952:b0:2aa:d333:ce84 with SMTP id d9443c01a7336-2aad333d30dmr80242795ad.11.1770726637482;
        Tue, 10 Feb 2026 04:30:37 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c9189bsm147523205ad.36.2026.02.10.04.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:30:36 -0800 (PST)
Date: Tue, 10 Feb 2026 18:00:30 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Sneh Shah <quic_snehshah@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next] net: stmmac: qcom-ethqos: fix
 qcom_ethqos_serdes_powerup()
Message-ID: <aYsk5mFH2YlAO1zd@oss.qualcomm.com>
References: <E1voPUH-000000083ji-25FH@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1voPUH-000000083ji-25FH@rmk-PC.armlinux.org.uk>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEwNCBTYWx0ZWRfX33Iq0E/paPXZ
 4YW1mitHvws3cWCuj1afCaPxSlqlLgZ+iI9Y+4zPj12X9m0s9Sjvc+EPxAfM6XK6N5DbPfr+thX
 HBifUTXObxjEpKLVTGfSpF55gkZmvdKYjsnWYy+wRELIjApq8W6uw5mgyCqnSkvlOH8wlMz6Xge
 Yf/RzTSWpX7iS/XeFdccFGUgzk7nVhMaqAlRqIjjks1rR1ebBKDkTxIUxoehVwLKM27gGlzZJ/m
 /JVTtjdUJ66fUPGG5S/wo36XyF3AxsMJ72V9XP7iDK+/2G85UpUe8+Oa4bXgTDc57k86MNxjEGU
 paXVOzlremwTCNgIFg42FM+BiY6GoQGr+WixWYKLV1OucfcJ5rcGkCddI+H6cc5Sj2U1BivnZOb
 oJBJO9OEudCbq2q5GwcZtcJgS2wYAGUPYXpmozaL6lkKGS6twA3NuEJ7baY5g4DD/ABEvlDfoZq
 i6lcd+tBh9SjXJW388A==
X-Proofpoint-ORIG-GUID: TqjFYVHFVq4g4uwSRKR3lBCGjs_2TmCe
X-Authority-Analysis: v=2.4 cv=XfuEDY55 c=1 sm=1 tr=0 ts=698b24ef cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=PHq6YzTAAAAA:8 a=EUspDBNiAAAA:8 a=C4_wdI1o37mb7NTJsvEA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-GUID: TqjFYVHFVq4g4uwSRKR3lBCGjs_2TmCe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258078-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4C5B911AE17
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 05:19:21PM +0000, Russell King (Oracle) wrote:
> Add cleanup for failure paths in qcom_ethqos_serdes_powerup(). This
> was missing calling phy_exit() and phy_power_off() at appropriate
> failure points.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c  | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 869f924f3cde..af8204c0e188 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -659,10 +659,18 @@ static int qcom_ethqos_serdes_powerup(struct net_device *ndev, void *priv)
>  		return ret;
>  
>  	ret = phy_power_on(ethqos->serdes_phy);
> -	if (ret)
> +	if (ret) {
> +		phy_exit(ethqos->serdes_phy);
>  		return ret;
> +	}
>  
> -	return phy_set_speed(ethqos->serdes_phy, ethqos->serdes_speed);
> +	ret = phy_set_speed(ethqos->serdes_phy, ethqos->serdes_speed);
> +	if (ret) {
> +		phy_power_off(ethqos->serdes_phy);
> +		phy_exit(ethqos->serdes_phy);
> +	}
> +
> +	return ret;
>  }
>  
>  static void qcom_ethqos_serdes_powerdown(struct net_device *ndev, void *priv)
> -- 
> 2.47.3
> 

Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Reviewed-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan

