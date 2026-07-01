Return-Path: <netdev+bounces-303494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IBvNKum7RGouzwoAu9opvQ
	(envelope-from <netdev+bounces-303494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 09:04:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 188B56EA73D
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 09:04:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=eGOFmN05;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=OBGjnR48;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303494-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303494-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01718304A696
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 07:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0D63B440E;
	Wed,  1 Jul 2026 07:03:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A423A7D98
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 07:03:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889401; cv=none; b=GHnH3BJriFyVmiCXVUMBNQmxKQ8MvJncMAB3WA7oEIWvJWqK9397mJjdrSu4tm3gNXEvgqRm7As+AJ9KpYZ0Hhrb/S2BOnqtVNAwAbsZecInbTOwY9ziS8k/V41TVoEwNdImhf3JbrLk6gpRYkst0PZRqg+SOIj5sLQgaEbhciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889401; c=relaxed/simple;
	bh=MHFUHk39EO2QdtwiguDn4OZVcG8GL8piMESDfsJwTx8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=JifyWbUEeMdPQhD3XE5O2sSMTaNp9d52+h+o1KyQg77xIsWgCKDk9tsr6ZjMX7adh2Sc3B+i0ol03qNyPR7W/u4BTdQ0pRW3i1DQer0+a3jXK9OGdL+7XkXsQel+4hirQosuLiJNZ8RR7v0oMlGcJgsjhvnYqGHvvAScH+rkz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eGOFmN05; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OBGjnR48; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6615lY4x025795
	for <netdev@vger.kernel.org>; Wed, 1 Jul 2026 07:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LhopI0XF+7KQyjRrxtV8135WR8luE8fcp2Q2eTKBIbg=; b=eGOFmN05qWQS66w+
	qtQwWP+bToUhE7pdRMB0hbIwHPfPv/5sB8unjws9hvUb3hOxiLblzqXn/6f1ZXC4
	JvJPjYIkn9cx0Td+xM0lrnOU/25H2wAbFWYx17S4EBwJ3/l+0OgfLeCzdOSvXZDl
	DEGdWRKur8l4vRrYOXrNyPTK34soPabKFiHo5h+/JQjnE/9M5fJiVAIs7UAQDMTP
	SPaBAnr5a6xZMu/0u6fs9GBAmSkyLN7D5FUhJjzPCmjcyTRmPvA1zQe5dvaz40ZX
	hZwCZAMSkRcgSEukU+knXRiY9DwQDc19OywrF1kXFBUTcStHBPaKQwz6Y6WBiK0f
	pqvF7Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hbd3ar3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 07:03:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c82843005eso4889395ad.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 00:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782889397; x=1783494197; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LhopI0XF+7KQyjRrxtV8135WR8luE8fcp2Q2eTKBIbg=;
        b=OBGjnR4836vlB8G61OCMoaMXO6UgMTefDt42wRDEw/IrCuoKoXKPnqBvK7rGaREf3M
         K6uQYA9UiGppTJjlxOgIPuyP5VRFl/uADq5OdWsrxpnfiEvBz7o1m5Tudt4XOhWChDyl
         St7QW4mydrrb3bBkR9x0oxOTys6R33/8YgHy4bsM7wbf/ujPWunGCqJgp7yCTfCsHJsD
         f6PHZwb3EZe5eff2wNVBZ2GBv97c+Pv/gjMdcmc2XcBISnADJpFG8z9gESch6mNl+9XZ
         sgZTQwvp4bY8ttc5+w/1i3886j9b9HditUOhlEVLlbVCDMVnF0zJ33TWR3WZ8nOS2mXO
         SZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889397; x=1783494197;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhopI0XF+7KQyjRrxtV8135WR8luE8fcp2Q2eTKBIbg=;
        b=Y69wxVE7HR+YuwnJ6/vtSY7voP6jqG3woN8x1jUn0aIkNEtj9sAJfc1otPMiAKW6hf
         sch1ZkFYw6pbPjIvDf17CmVhFXYtjSb6USoG6SBRgGB3L2t4Yzv+oXNlQYAEK3p1CHvR
         zHK3q+xeZw5zSqwTuJKz/C4eEvzhEFtJNxg1TqD9clD/eBuvB5mJW39ixC/HZafC+yXg
         ZGNk9czLcnzwBhH4iDXYtMPxqioRS5/tUpZQck759KofEgoW2XF+k5Gi0KSnbL6qzU7i
         O+uL5Ng/7cAFyuNgYa+Wnt7qm6QSVQfTT7EIQMg7aPVDfBJrwNtaeyaVcxmb1QZ6dB49
         MoeA==
X-Forwarded-Encrypted: i=1; AHgh+Rr+vs+WXEL0icxR9bYr2eY4bOOv+TcF9CiNQJYGaIyGy/9FM61HbPIzF+/erN10uFWUF+DDV+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxthaTzX0gW9WVEDZNL793RFUTD/M3NS9ITbw49z+5c+DSwkqy1
	Ts6Ft4YXbfbjHEynXJ1FPYRqlQiYxrr/VjudZ+dd3dBHnXbkQNrdDdsiFtdJuvIW3XNaYbRhtby
	GbclqKzGoRTiatHdxue1GvmzDjH0wFjwdMAirFT9Id/pR7BKUg0Brg9luJBA=
X-Gm-Gg: AfdE7cmSohAAenjaKvz1xjpp1f8usGY3QCoVEuODO6Pc5lNMvLwOKNJJQFKBCGZMYJa
	EdpZZhnGWkvRREFosgyY9KMvm3gK9NftbmIO0vcvsL9kwQ5MZyabBWbcqrScQC/trCFbyA4pAM7
	DiANOqnDowRqCEfrx0llWPA0B3la/UAE34aQtcI6k2guNLmYzcou2vVysAiyiz3NAYc1JKZu/tz
	JoXjt2lk3nVjSgS3d1PREUIiPP0Ca37tTtL9Cc83lYb10SL0nihdh33mnOg2KhN+S0PRYH3nUsd
	B+IOG8dBtQSgtv8Jgsvf/thr8dq5DUZ50TOKrzexp43GdCw7eDXv8O53T6debr4qjJCqkim6o5N
	h5eiG+1jtOSaeLfXizgWElBzt0KGn6tOyDsYm4SszEEnXFUll4dzD7wK3
X-Received: by 2002:a17:902:db0d:b0:2c9:d8c6:1dbe with SMTP id d9443c01a7336-2ca7e6fcff5mr5604065ad.20.1782889396834;
        Wed, 01 Jul 2026 00:03:16 -0700 (PDT)
X-Received: by 2002:a17:902:db0d:b0:2c9:d8c6:1dbe with SMTP id d9443c01a7336-2ca7e6fcff5mr5603505ad.20.1782889396143;
        Wed, 01 Jul 2026 00:03:16 -0700 (PDT)
Received: from QCOMk1gASIiYhG ([76.120.32.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca380c7d84sm26408505ad.35.2026.07.01.00.03.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2026 00:03:15 -0700 (PDT)
From: <subash.a.kasiviswanathan@oss.qualcomm.com>
To: "'Xiang Mei'" <xmei5@asu.edu>, <sean.tranchetti@oss.qualcomm.com>,
        <netdev@vger.kernel.org>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        <bestswngs@gmail.com>
References: <20260630174110.2003121-1-xmei5@asu.edu>
In-Reply-To: <20260630174110.2003121-1-xmei5@asu.edu>
Subject: RE: [PATCH net v2] net: qualcomm: rmnet: validate MAP frame length before ingress parsing
Date: Wed, 1 Jul 2026 01:03:13 -0600
Message-ID: <000101dd0927$b043c9b0$10cb5d10$@oss.qualcomm.com>
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
Thread-Index: AQItJvlE+N7GlVHQc8fjR25V/JgSa7W3+KdA
Content-Language: en-us
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3MSBTYWx0ZWRfX41TbN1QsRJ5N
 jGbQLJnV8xm9GhmTkxKqfJjYvlNCBSRA46v/+vxOJkjenvrsMloppAu6RE1jbHuwQQqxI4VHu9i
 efB5Q1MRT/RPA6dayf4Sr0fzsuZSL+Q=
X-Authority-Analysis: v=2.4 cv=MpJiLWae c=1 sm=1 tr=0 ts=6a44bbb5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=jMAiQizNomS0luNzNiKfDg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=ls6AgJjuAQYc6x4HYs8A:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-ORIG-GUID: 44wYB81JcDlewHKqHaEwUOftkYooUPxu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3MSBTYWx0ZWRfX4/ro1hNm8j+8
 9Y1Sfg8cxpYke0KVafDYkOmCo6cL49Qox7T/l4BqKiS1wMfpLeedKvxsfgNMMPQJCwALqHdMUHU
 5nLvEWHALJ4+GdbC0uzRlqrSw2ZOwa3zTq49SxLTYi+ajQYAoJxN7jgWQYxqi6eZyt5wDYhTTn+
 N6Vs5aP8We95ZZalpDmK9Q+gebaPAYEwX4iXd5AGZKkCOj+lPE9qERDcvNLDRo9UPC+kPct7Sor
 eoTiDOqBtTVsAiPH/HTWSovdgdx6ihUkw39P97rY1K45r8CfRFOBU+6icNJwPX4HFX0Dk4EVnu4
 KTtU0lMH9NuzWFdusoFscwrPB9Hwc2kHD2TTOf1YhZKDwMZ5slHiy+yzi7BCzDuNxS7d1BrCYrd
 HGFNIJbUU6tzha32okwQ+ZtOEsPWyOwPOzJ1vwCIZcuBD7S2mbK6x6kIn/kWIyqv4UIR6dYkR5T
 N/Tjzkk2SphGF6M+L1A==
X-Proofpoint-GUID: 44wYB81JcDlewHKqHaEwUOftkYooUPxu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010071
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303494-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,asu.edu:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 188B56EA73D

> -----Original Message-----
> From: Xiang Mei <xmei5@asu.edu>
> Sent: Tuesday, June 30, 2026 11:41 AM
> To: subash.a.kasiviswanathan@oss.qualcomm.com;
> sean.tranchetti@oss.qualcomm.com; netdev@vger.kernel.org
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; linux-
> kernel@vger.kernel.org; bestswngs@gmail.com; Xiang Mei <xmei5@asu.edu>
> Subject: [PATCH net v2] net: qualcomm: rmnet: validate MAP frame length
> before ingress parsing
> 
> When ingress deaggregation is disabled, rmnet_map_ingress_handler() passes
> the skb straight to __rmnet_map_ingress_handler(), skipping the length
> validation that rmnet_map_deaggregate() performs on the aggregated path.
> The parser then dereferences the MAP header and csum header/trailer based
> on
> the on-wire pkt_len without checking skb->len, so a short frame is read
out
> of bounds:
> 
>   BUG: KASAN: slab-out-of-bounds in
> rmnet_map_checksum_downlink_packet
>   Read of size 1 at addr ffff88801118ed00 by task exploit/147
>   Call Trace:
>    ...
>    rmnet_map_checksum_downlink_packet
> (drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c:413)
>    __rmnet_map_ingress_handler
> (drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:96)
>    rmnet_rx_handler
> (drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:129)
>    __netif_receive_skb_core.constprop.0 (net/core/dev.c:6089)
>    netif_receive_skb (net/core/dev.c:6460)
>    tun_get_user (drivers/net/tun.c:1955)
>    tun_chr_write_iter (drivers/net/tun.c:2001)
>    vfs_write (fs/read_write.c:688)
>    ksys_write (fs/read_write.c:740)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>    ...
> 
> Factor that validation out of rmnet_map_deaggregate() into
> rmnet_map_validate_packet_len() and run it on the no-aggregation path too.
> The MAP header is bounds-checked first, since this path can receive a
frame
> shorter than the header.
> 
> Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial
> implementation")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Suggested-by: Subash Abhinov Kasiviswanathan
> <subash.a.kasiviswanathan@oss.qualcomm.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v2: Validate on the no-aggregation path by reusing the deaggregation
>     length checks (factored into rmnet_map_validate_packet_len()) instead
>     of adding separate pskb_may_pull() guards in
> __rmnet_map_ingress_handler().
> 
>  .../ethernet/qualcomm/rmnet/rmnet_handlers.c  |  5 +-
>  .../net/ethernet/qualcomm/rmnet/rmnet_map.h   |  1 +
>  .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 72 ++++++++++---------
>  3 files changed, 45 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
> index 9f3479500f85..d055a2628d8c 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
> @@ -126,7 +126,10 @@ rmnet_map_ingress_handler(struct sk_buff *skb,
> 
>  		consume_skb(skb);
>  	} else {
> -		__rmnet_map_ingress_handler(skb, port);
> +		if (rmnet_map_validate_packet_len(skb, port))
> +			__rmnet_map_ingress_handler(skb, port);
> +		else
> +			kfree_skb(skb);
>  	}
>  }
> 
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
> index b70284095568..60ca8b780c88 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
> @@ -59,5 +59,6 @@ void rmnet_map_tx_aggregate_init(struct rmnet_port
> *port);
>  void rmnet_map_tx_aggregate_exit(struct rmnet_port *port);
>  void rmnet_map_update_ul_agg_config(struct rmnet_port *port, u32 size,
>  				    u32 count, u32 time);
> +u32 rmnet_map_validate_packet_len(struct sk_buff *skb, struct rmnet_port
> *port);
> 
>  #endif /* _RMNET_MAP_H_ */
> diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> index 8b4640c5d61e..305ae15ae8f3 100644
> --- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> +++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
> @@ -333,54 +333,62 @@ struct rmnet_map_header
> *rmnet_map_add_map_header(struct sk_buff *skb,
>  	return map_header;
>  }
> 
> -/* Deaggregates a single packet
> - * A whole new buffer is allocated for each portion of an aggregated
frame.
> - * Caller should keep calling deaggregate() on the source skb until 0 is
> - * returned, indicating that there are no more packets to deaggregate.
Caller
> - * is responsible for freeing the original skb.
> - */
> -struct sk_buff *rmnet_map_deaggregate(struct sk_buff *skb,
> -				      struct rmnet_port *port)
> +u32 rmnet_map_validate_packet_len(struct sk_buff *skb, struct rmnet_port
> *port)
>  {
>  	struct rmnet_map_v5_csum_header *next_hdr = NULL;
>  	struct rmnet_map_header *maph;
>  	void *data = skb->data;
> -	struct sk_buff *skbn;
> -	u8 nexthdr_type;
>  	u32 packet_len;
> 
> -	if (skb->len == 0)
> -		return NULL;
> +	if (skb->len < sizeof(*maph))
> +		return 0;
> 
>  	maph = (struct rmnet_map_header *)skb->data;
> +
> +	/* Some hardware can send us empty frames. Catch them */
> +	if (!maph->pkt_len)
> +		return 0;
> +
>  	packet_len = ntohs(maph->pkt_len) + sizeof(*maph);
> 
>  	if (port->data_format & RMNET_FLAGS_INGRESS_MAP_CKSUMV4) {
>  		packet_len += sizeof(struct rmnet_map_dl_csum_trailer);
> -	} else if (port->data_format &
> RMNET_FLAGS_INGRESS_MAP_CKSUMV5) {
> -		if (!(maph->flags & MAP_CMD_FLAG)) {
> -			packet_len += sizeof(*next_hdr);
> -			if (maph->flags & MAP_NEXT_HEADER_FLAG)
> -				next_hdr = data + sizeof(*maph);
> -			else
> -				/* Mapv5 data pkt without csum hdr is
invalid
> */
> -				return NULL;
> -		}
> +	} else if ((port->data_format &
> RMNET_FLAGS_INGRESS_MAP_CKSUMV5) &&
> +		   !(maph->flags & MAP_CMD_FLAG)) {
> +		/* Mapv5 data pkt without csum hdr is invalid */
> +		if (!(maph->flags & MAP_NEXT_HEADER_FLAG))
> +			return 0;
> +
> +		packet_len += sizeof(*next_hdr);
> +		next_hdr = data + sizeof(*maph);
>  	}
> 
> -	if (((int)skb->len - (int)packet_len) < 0)
> -		return NULL;
> +	if (skb->len < packet_len)
> +		return 0;
> 
> -	/* Some hardware can send us empty frames. Catch them */
> -	if (!maph->pkt_len)
> -		return NULL;
> +	if (next_hdr &&
> +	    u8_get_bits(next_hdr->header_info,
> MAPV5_HDRINFO_HDR_TYPE_FMASK) !=
> +	    RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD)
> +		return 0;
> 
> -	if (next_hdr) {
> -		nexthdr_type = u8_get_bits(next_hdr->header_info,
> -
> MAPV5_HDRINFO_HDR_TYPE_FMASK);
> -		if (nexthdr_type !=
> RMNET_MAP_HEADER_TYPE_CSUM_OFFLOAD)
> -			return NULL;
> -	}
> +	return packet_len;
> +}
> +
> +/* Deaggregates a single packet
> + * A whole new buffer is allocated for each portion of an aggregated
frame.
> + * Caller should keep calling deaggregate() on the source skb until 0 is
> + * returned, indicating that there are no more packets to deaggregate.
Caller
> + * is responsible for freeing the original skb.
> + */
> +struct sk_buff *rmnet_map_deaggregate(struct sk_buff *skb,
> +				      struct rmnet_port *port)
> +{
> +	struct sk_buff *skbn;
> +	u32 packet_len;
> +
> +	packet_len = rmnet_map_validate_packet_len(skb, port);
> +	if (!packet_len)
> +		return NULL;
> 
>  	skbn = alloc_skb(packet_len + RMNET_MAP_DEAGGR_SPACING,
> GFP_ATOMIC);
>  	if (!skbn)
> --
> 2.43.0

Reviewed-by: Subash Abhinov Kasiviswanathan
<subash.a.kasiviswanathan@oss.qualcomm.com>


