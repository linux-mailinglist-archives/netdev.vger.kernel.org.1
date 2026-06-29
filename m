Return-Path: <netdev+bounces-302825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zeUIKljTQmrZDgoAu9opvQ
	(envelope-from <netdev+bounces-302825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 22:19:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E08A6DE972
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 22:19:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=W9DAQSpt;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=i1bohtN0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302825-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302825-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6F28300D34D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CF2388369;
	Mon, 29 Jun 2026 20:19:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE4F38F24C
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 20:19:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782764373; cv=none; b=E2stR/6LLaCvhLciIyXPkxGJZTIYPJNq9cAZrPqHzRBMmrNOLE2+7RXeZIRfeOCa2TOExRfTGjJ1tzmAVI/wXx6EZfE5zL8OMOgeW8u31YEASR5V+ns3HwNj7V7mfG6AVribR8E1cJNnnHrzaarvHXFfLYq6tkkBL8Z72bx/nRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782764373; c=relaxed/simple;
	bh=J2o9siOknjUV1EIyuyIEguI/OuQyvr7osGhO/HaaCVA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=CiMN7n+z6j37FQM2z44QHDdRQC/+JHXm0Nr1XhwCcBpxHNzMbOhhLsaj32U2J7x0I3zqlElEtzMtCI5M9scr6EO6vx8Y4X+AcHOdHWBSgDMNxdHRZQ93TGq/mmOyBrOLsokDpjXE+BcMcSOEkzMulBxvORTABEICgA9b+u8gNSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W9DAQSpt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i1bohtN0; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TJss6O3867324
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 20:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YrPo/wrins9m3aOwmOa8IZ6Og4C3nSZZxKNrdPPXXPk=; b=W9DAQSpt5htlg5z1
	mpMIs5cdn2PEQ526sAaNI+Alzz5Vg7ayQXmDC2KzMAXaO23KFOafLH2BWGmjIIeu
	s1hm4cjl8JxdeSDDp8NMk0eYlEWi41/RkIN8v4koFQaZlx1rvA4a4CnabP8fKi89
	tzDQcyQPj5NWlvRwfUyfLw6aiKl66b41Ad8QRBn635NB9WZnd/kWzkgBDjMHHdB7
	WuQrp1KchLc06K3xu++1oiD1SQn0SKm9gFO48ZggeVrI+j7Gz7VuCMBVznTByUcb
	nXto4/m7b3hZmAcp621aja1AEdnttphPGIROCTDfF9TFS+9XlE8KHH+aL8uxf+Ax
	o/Idvg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9j02mf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 20:19:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30ca3374c6aso10128363eec.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782764362; x=1783369162; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YrPo/wrins9m3aOwmOa8IZ6Og4C3nSZZxKNrdPPXXPk=;
        b=i1bohtN0ZfaIyfFik+MhMSrLQswafLKPrsc3z3xQ53W0kFG9l9cf0tM2NYftL9ZbP/
         rL23BzzIvWKn39wRY4hHWiTE9+5OI/xU1Y+GZgvUkjWtfQT8zzicEKViij5a1zUFh4ZV
         KjskJwevQeSoFqTQ3k1hZb0DqyhRI25IU/e8IKXffKYDDmte0OXbIL8dMCOzMJOTYs7v
         b175DI+w6RIa4eE5cM2TOODnckJMrA69rp/dgZDT18wTvtc5UU131swQmXD8K/P6Af/J
         dbAEbibxjmlJMsuWv9qbn+eaW5k1s99sBW9f2GEISJQhW2NPtDmCESl2Lvk/jhep9SWA
         4U1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782764362; x=1783369162;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrPo/wrins9m3aOwmOa8IZ6Og4C3nSZZxKNrdPPXXPk=;
        b=c1UrEpn/nLJvCZhqSx/X2BSQByxXzdlTEMSrLANBmok47kH1a065CPEVQp7DG3XKjT
         dqm/npmKajDE6NLQ9IuHnqX43lky09z7bApxWaDPgcG56mNURJZiTt6Cm524x0LeqeBf
         GOGIA8nAjNjKTaSPkR80tcdLJDYKleMoPUge/4xov+tkYNw9Cq+HuCVG0F5sTQfiFY3z
         Usd+7oc4DZP9pwrM5MBM2jh7KB0Rp6aIC7ewoZYWppuVXsoFttw0bfqHoz/gl0dDyAbS
         rxD+aIS0UpdcEsJ49DRh+MeaZeyk4rps9QDDfrmCCmaDjWc3u67kPW1fInHpXtsgQc/t
         LEYQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJwo+vSXxhFuASAqqh6JLN4aSEwUnDXgYrQ9rpvRb/E93yZEvPfu4oQNdPLymE7ZM7+FIoj44=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzHnhGD2fdffG7QUoSfV8/txCIfYiVZI10SGC0skLA49ammpX0
	9RK5DmxenwXioUeG4YIvbNkqNCWeaHyGYiu0T20Y73WleBHw4BeC6IFx7uWvGVbvsQaFu2nScEJ
	gayOxRgENbjkuCbij4+9+li5l1yR/D3ewLQGH0iWhVyM6xPrwq6M46hRfCpU=
X-Gm-Gg: AfdE7cnOIeVjUfAnULqvSsqiFxtNGcsCOuFse3q4BiSuPw1TKOvaeQCG6G5irClSna1
	GQz/Zn8zXpFWvT5V3BqwzWL3D8pYLOPoByu0p1TuthvBvXuFZKWQoZ8Hus+LiMxtC4TqLNg69ci
	6z8AEifMnIdeqrWX5zqKMAcZ7x6UjMrWIM2GSaKmC5lxsQfwRmtVxQ7f/kh0F7KHwUAvrqTwHeF
	JcBLmaezZhsy1CXsi+HvvrCSnNz3rYKeIclqxr9FHuyrvt/CpZFFMegENraHoGKII4Zp+ELzbdQ
	tI995yMZbNhOYpFihrD6tXVn+tNJrC3YaXu+bbFAuPYJ2jJCChrTE9KH9Wo6c7zzbIakDhE2YAq
	UFMqS5+546dZXMOAJgwGWJ5vtXZ21/F4wzFx7Rg5ay8LKuwtT8QliT+dbkH3gEpVMcQfWIi4LvC
	scCpS7FGA=
X-Received: by 2002:a05:7300:6ca0:b0:30c:9f31:b604 with SMTP id 5a478bee46e88-30ee13852c7mr605267eec.25.1782764362198;
        Mon, 29 Jun 2026 13:19:22 -0700 (PDT)
X-Received: by 2002:a05:7300:6ca0:b0:30c:9f31:b604 with SMTP id 5a478bee46e88-30ee13852c7mr605238eec.25.1782764361328;
        Mon, 29 Jun 2026 13:19:21 -0700 (PDT)
Received: from QCOMk1gASIiYhG (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2ffdbfesm651643eec.11.2026.06.29.13.19.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2026 13:19:21 -0700 (PDT)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: "'Xiang Mei'" <xmei5@asu.edu>, <sean.tranchetti@oss.qualcomm.com>,
        <netdev@vger.kernel.org>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <bestswngs@gmail.com>
References: <20260628075205.62280-1-xmei5@asu.edu>
In-Reply-To: <20260628075205.62280-1-xmei5@asu.edu>
Subject: RE: [PATCH net] net: qualcomm: rmnet: validate MAP frame length before ingress parsing
Date: Mon, 29 Jun 2026 14:19:19 -0600
Message-ID: <000601dd0804$91cbd910$b5638b30$@oss.qualcomm.com>
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
Thread-Index: AQHQ7aP9pGM6mVEWYd59aeRp0a7HYLZuKwKQ
Content-Language: en-us
X-Proofpoint-ORIG-GUID: g0rm_M2f35cNsvr-ZJtLBtKd2poosgzB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE3MSBTYWx0ZWRfX08mF9aG0cDGg
 dt1vEOuY5a8j2ZqvmKJ/SA/+HytTjuZq30DlJSbLKNA0AYMb2xsS5lzJ2Yf8UdSFPiOW1xyCM/k
 E1KeuJtNnekAnjfpOLmuXBLbjSVtLaZHf5suJjWDiCyaf/7KkWHvwSUzw/fxdpM8lmqUnzcgDo2
 WVmr6sPyztXTdgmRAhp//hU6jR09sYcM3XA0nMiFuZjEKsu/VQ9Gf+uqUYFYNDBcmAK5YeKRtib
 ZHn1dz5Z7bRZ7exFsQkGZ57XY5y8fSmKvsLPKbn0Q6e7K7qB4zAvUvOXhWENUyuAxDQz5hFNI1u
 8oFZg21fBS7at5TELO9S7aSmwKEuvxwyQ22djieWQiQ54ZUOHIgNA3JnVkA5/ZSRBPkEsX1CgE2
 sFqolGCnl0PCTHvmRU77wEbdrD/wIDlgJbwWspnREfbYEahyFBsnMD+b0+A9ATs8Y9iTX1BYEAL
 ijPYT+fxRC2bqHS6GLg==
X-Proofpoint-GUID: g0rm_M2f35cNsvr-ZJtLBtKd2poosgzB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE3MSBTYWx0ZWRfXzA6Jfx8uWAEV
 aCnHPhuSfV7syqNqs76iGiXo6N1h5f6dH7z1cr/t4KGkFtrOTy7DcK6tm9h4ypZTyG5PbBIZk8G
 rmGsnKtxR77K6wGbu2hsw+1xXE+EG14=
X-Authority-Analysis: v=2.4 cv=SINykuvH c=1 sm=1 tr=0 ts=6a42d34b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=vR_vMVs8yzpaFJNcJ2gA:9 a=CjuIK1q_8ugA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290171
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302825-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,asu.edu:email];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:sean.tranchetti@oss.qualcomm.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[subash.a.kasiviswanathan@oss.qualcomm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[subash.a.kasiviswanathan@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E08A6DE972

> -----Original Message-----
> From: Xiang Mei <xmei5@asu.edu>
> Each guard uses pskb_may_pull() before its read. The MAPv4 check uses
> ntohs(pkt_len) (== payload + pad) directly rather than the derived len, so
it is
> unaffected by the u16 underflow in len when pad > pkt_len. Well-formed
> frames always carry the header/trailer they declare, so only malformed
> packets are dropped; this mirrors the length check rmnet_map_deaggregate()
> already performs on the deaggregation path.
> 
> @@ -61,6 +61,9 @@ __rmnet_map_ingress_handler(struct sk_buff *skb,
>  	u16 len, pad;
>  	u8 mux_id;
> 
> +	if (!pskb_may_pull(skb, sizeof(*map_header)))
> +		goto free_skb;
> +
>  	if (map_header->flags & MAP_CMD_FLAG) {
>  		/* Packet contains a MAP command (not data) */
>  		if (port->data_format &
> RMNET_FLAGS_INGRESS_MAP_COMMANDS) @@ -84,11 +87,19 @@
> __rmnet_map_ingress_handler(struct sk_buff *skb,
> 
>  	if ((port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV5)
> &&
>  	    (map_header->flags & MAP_NEXT_HEADER_FLAG)) {
> +		if (!pskb_may_pull(skb, sizeof(*map_header) +
> +				   sizeof(struct
> rmnet_map_v5_csum_header)))
> +			goto free_skb;
>  		if (rmnet_map_process_next_hdr_packet(skb, len))
>  			goto free_skb;
>  		skb_pull(skb, sizeof(*map_header));
>  		rmnet_set_skb_proto(skb);
>  	} else {
> +		if (port->data_format &
> RMNET_FLAGS_INGRESS_MAP_CKSUMV4 &&
> +		    !pskb_may_pull(skb, sizeof(*map_header) +
> +				   ntohs(map_header->pkt_len) +
> +				   sizeof(struct
rmnet_map_dl_csum_trailer)))
> +			goto free_skb;
>  		/* Subtract MAP header */
>  		skb_pull(skb, sizeof(*map_header));
>  		rmnet_set_skb_proto(skb);
> --
> 2.43.0

The patch seems fine at a high level. However, it ends up adding duplicate
checks for the deagg path which is the commonly used path.
Perhaps you can try something similar to the following which adds all the
relevant checks of the deagg path to the no agg path as well.

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
index 9f3479500f85..086874b673c6 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
@@ -126,7 +126,8 @@ rmnet_map_ingress_handler(struct sk_buff *skb,
 
                consume_skb(skb);
        } else {
-               __rmnet_map_ingress_handler(skb, port);
+               if (rmnet_map_validate_packet_len(skb, port))
+                       __rmnet_map_ingress_handler(skb, port);
        }
 }
 
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
index b70284095568..46495b7966f3 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
@@ -59,5 +59,7 @@ void rmnet_map_tx_aggregate_init(struct rmnet_port *port);
 void rmnet_map_tx_aggregate_exit(struct rmnet_port *port);
 void rmnet_map_update_ul_agg_config(struct rmnet_port *port, u32 size,
                                    u32 count, u32 time);
+u32 rmnet_map_validate_packet_len(struct sk_buff *skb,
+                                 struct rmnet_port *port);
 
 #endif /* _RMNET_MAP_H_ */
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 8b4640c5d61e..1729b73249f7 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -333,24 +333,16 @@ struct rmnet_map_header
*rmnet_map_add_map_header(struct sk_buff *skb,
        return map_header;
 }
 
-/* Deaggregates a single packet
- * A whole new buffer is allocated for each portion of an aggregated frame.
- * Caller should keep calling deaggregate() on the source skb until 0 is
- * returned, indicating that there are no more packets to deaggregate.
Caller
- * is responsible for freeing the original skb.
- */
-struct sk_buff *rmnet_map_deaggregate(struct sk_buff *skb,
-                                     struct rmnet_port *port)
-{
+u32 rmnet_map_validate_packet_len(struct sk_buff *skb,
+                                 struct rmnet_port *port) {
        struct rmnet_map_v5_csum_header *next_hdr = NULL;
        struct rmnet_map_header *maph;
        void *data = skb->data;
-       struct sk_buff *skbn;
        u8 nexthdr_type;
        u32 packet_len;
 
        if (skb->len == 0)
-               return NULL;
+               goto err1;
 
        maph = (struct rmnet_map_header *)skb->data;
        packet_len = ntohs(maph->pkt_len) + sizeof(*maph);
@@ -364,24 +356,48 @@ struct sk_buff *rmnet_map_deaggregate(struct sk_buff
*skb,
                                next_hdr = data + sizeof(*maph);
                        else
                                /* Mapv5 data pkt without csum hdr is
invalid */
-                               return NULL;
+                               goto err1;
                }
        }
 
        if (((int)skb->len - (int)packet_len) < 0)
-               return NULL;
+               goto err1;
 
        /* Some hardware can send us empty frames. Catch them */
        if (!maph->pkt_len)
-               return NULL;
+               goto err1;
 
        if (next_hdr) {
                nexthdr_type = u8_get_bits(next_hdr->header_info,
                                           MAPV5_HDRINFO_HDR_TYPE_FMASK);
                if (nexthdr_type != RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD)
-                       return NULL;
+                       goto err1;
        }
 
+       goto err0;
+
+err1:
+       packet_len = 0;
+err0:
+       return packet_len;
+}
+
+/* Deaggregates a single packet
+ * A whole new buffer is allocated for each portion of an aggregated frame.
+ * Caller should keep calling deaggregate() on the source skb until 0 is
+ * returned, indicating that there are no more packets to deaggregate.
Caller
+ * is responsible for freeing the original skb.
+ */
+struct sk_buff *rmnet_map_deaggregate(struct sk_buff *skb,
+                                     struct rmnet_port *port)
+{
+       struct sk_buff *skbn;
+       u32 packet_len;
+
+       packet_len = rmnet_map_validate_packet_len(skb, port);
+       if (!packet_len)
+               return NULL;
+
        skbn = alloc_skb(packet_len + RMNET_MAP_DEAGGR_SPACING, GFP_ATOMIC);
        if (!skbn)
                return NULL;


