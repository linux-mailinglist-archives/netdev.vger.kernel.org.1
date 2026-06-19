Return-Path: <netdev+bounces-300754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iIXuGTCrNWqA2wYAu9opvQ
	(envelope-from <netdev+bounces-300754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 22:48:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3326A7B51
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 22:48:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=JswXacds;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=U6+OoMoK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300754-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300754-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEC013021655
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 20:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404463BFE40;
	Fri, 19 Jun 2026 20:48:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3B32B126
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 20:48:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902126; cv=pass; b=gViA/06nWf7lIK9xiygRojauPXw92jZf1Ln0zeCnxYYJskikm2x9D7JB59H0LvzuqDm/x8ueKxZxOJAPCsC4CE+gCnzVqeH4r9tAH0uycYqhXS/hCL0H1WQITQjoa/VeT1K7haZaAgvs+x1Yb7V5Xmof4HB6Um8xsyqjW5bgYxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902126; c=relaxed/simple;
	bh=apqdQKr7PEHlxfQQiXiex1WWm8qUWolV2mUZV3BhAi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUzDveOM46GBNs+LBulEoXIqSJOutDp2dvTPsMkSuEDkLp5Q7mMm1P3zqfyyS/cOCIhACq1BTfBhQ29Yayma0nPAZbDikzCgZZbD9HDnKmm7kiIbEYa7HCXCKtATR/QiWEosa+gvzIZxcm8LX3YBZmdQWNyv1nqtqlZTiN3sodo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JswXacds; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U6+OoMoK; arc=pass smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JHVsvv1122034
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 20:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zA8WqZ4MHUkpwOcrbs9rDdlT2zHB2hwUW99729Sbo6k=; b=JswXacds6arRJBdU
	BJn3HY+P8T68LsUJxkpxBB5wKEHB8ZawFBQM5umE1kWxgtBcBzHZTM+0PwlzQK93
	MW+bHlhgGdg8WzNUu8TFDuz+Clo5iseNEz8nz5hNk8adcDTOubNtoPwy88OLKJ8a
	kHRP8au++2NzpKn82UX6Hnj4EHU9tXuxBHaHK596WlnWxWIfYT2Q2/grjTpp3fUt
	KNXP+DaENpyEi1Iko0y7P5J5HmWX3nzEFfMQGXWLFfSHBmIiVQsF1rG4uDmPb1e+
	yhYzcf4dRAWtmyX/tqZdy+kU6rAuKIf/NTDIu3hlc9cOSGFqf/rggJc9+uweXW5K
	t0KkiQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evpyuvn1p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 20:48:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-91579011fd1so359178785a.1
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 13:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781902122; cv=none;
        d=google.com; s=arc-20240605;
        b=Q/a5o8QL+uROAY8boGdYae1SMcxKA0UbB8L9cBK/k3RtwOMK16ZpkNzFYMMoxe2F9b
         RsW/7ltDhhs0FPSjFL+ND+YqqSrIFvuDAzCEmqiddzzbRRZvgaLQY1twoCgsQv8RJ1th
         hJS+jG50T9V0Ci5Dt+SKAFq0H6iKv0tLeQXdWgPqeh2YYGXuxoSNcdkOK49BOdcQUc+L
         cCYUlfJUX/FUUJ7OKSUkESlbInjxpNwEegFLLIcVYRHmkD3P7kQMJOvg3azwGea2FELk
         m2M8vUdos7UtIdSO0gdqhT1E6D0WthfnjTlxq8yQfhuS6/0RagvcKn3CjInK4uyftRxk
         +dMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zA8WqZ4MHUkpwOcrbs9rDdlT2zHB2hwUW99729Sbo6k=;
        fh=SJ2zfbNPvXehn/PUvQhCAKUCBUeGG4yI5T47zzuexwU=;
        b=DpTIwf1Uydd0MTaO/uhf5jVYVi2TFkNSKuz/rrSNi3yFtjeAWn4Ij0qyQlcp3LLW/2
         M2CaqT8h7TzW4dD7puyYXtSS/CRk3wdgLklq6zYi24tBlzkzac1kF/ZKyBggQpfYkbCz
         bj84+oMN6KjCgxfYON2VVV1oQsV/TMoH3S5Xl3usHLrjUpJRYhB1eRNqp5swxV40zMYw
         CMkOxzoL4XrhUwX9YpkIaHXEvvvl5osEnnZVy3Kw8zYi3bGDVPsELJisxeQ0GcnNXnqg
         gQQkmNNM6/VSMnxDU1JVFZhEZfBCaLlcJdKfBc4VBBlCxjv/Hn9/EuEqbb8lxWFykjZy
         PE3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781902122; x=1782506922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zA8WqZ4MHUkpwOcrbs9rDdlT2zHB2hwUW99729Sbo6k=;
        b=U6+OoMoKIh21RyXbOjGWQHEJyH4gn+fIQLldzPy9kKpjzFVwSWo/6IZCIa+q4GYsoN
         xoTdMqe89RzzTbHyjrmHUprbr4AjNhuf0MmTcfakdUO1Ev6zFpFn3C1goF4F6ABDn9Pi
         wDtQOQw6C51xS1x8w/MF64DBppf+O/9XucHZAuOzCHzGTBZ7GvIO0biT8GqIuU4gVTZ5
         aUVI55gHXjlSsyRIrd+ho4P+2M6f66S/MUs3v8vtn34mryejzzc3Gz/jsxkAoOL21E+m
         mokElNun/kxgo1VMNkOdY1H4LHHBognwGSRuvqmH8qZGmRw0/tRR6QJvkyl+1sUutxD6
         JR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902122; x=1782506922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zA8WqZ4MHUkpwOcrbs9rDdlT2zHB2hwUW99729Sbo6k=;
        b=Ov0+9diJwDDCGRfuoW4EK5z1wjaGUHwnFrWlNHlEy3+AuXRtEJIPY247+Ec6lRfAfJ
         9K2RotTBSbUe74YJ+bLQI7q6NCbHHgcivcKjW/Po7fI+bdelzAFRYfxA/SN1FkqoD2Sv
         FpRh7bx4e4x1YiUtEM4ijXZMm5SgVOvl2m56Fb7inXG+TxSoLwqP9LGPcC8GaokVKn6d
         99pyv+cu11TzNfyiE9SQv5E+PX5Goo+3ySluuhimrdzsQ68LZV+0mn+VZNXdaC5GGTT8
         5xFIXjPSM+ImKfrXJRQ0qrHS6Rb6eTN1wYkUfBpOB/4z5D9GfbdfuKDXTT9yUAK1TybH
         Un5g==
X-Forwarded-Encrypted: i=1; AFNElJ+DMFtk/mCewi1vwbVGO51yczMnJv+spZuXPzn+9wdMe5KZCMDJKGNhjr7I5ojPenngau972Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7aoG5LfoOYaqRETKGoH8w25997CV/YiAt48eCfVdmRPBJ2FrX
	kMkuJPifBqVLW0rs+D86kRS9mP7ux9XXtyTOXRBzmBNmdEtWybFEQgn7VZQ5tUrqDuln2f9hhz1
	HHp/9m5qJdWkWuJgwbWA7/HSQmIwXRjOjnI/SuTzaE2D4RjR1J2dV3WV9s3RcZsSjm8Ugxy8jyb
	xAxR9H5DD2KgpP+UEfdaS//vRco7VxZqd0Kg==
X-Gm-Gg: AfdE7cki4/RLVD3wKHm8YxHoY8fr6MdFGNcxIskAsunXEqwhIKu7orh/ydNM9SzK4kp
	QvwIwqiHKMUBKrZToC7PdDLn9qvAVIplSeo4TOju+BkVL9VRsZfREC7db4RP6zb9TGLVc4FXp+p
	txzoQN6dJgSvRIFcSi5nRIBD/DCGTNWkvBmTUS8+M8t1PaxldjXdMTbTc/2oasHjigbd71UHWSW
	vbjZaLEi1VPqu3rEtteO7SGSBuM0whUgv3Xx4QhuYLO3G6P/lmZkyPeaL9A+6VyMG7EOEexqYW5
	sDCQ/Yoo5w==
X-Received: by 2002:a05:620a:2688:b0:915:7c1a:1390 with SMTP id af79cd13be357-92091786f27mr820313985a.39.1781902122150;
        Fri, 19 Jun 2026 13:48:42 -0700 (PDT)
X-Received: by 2002:a05:620a:2688:b0:915:7c1a:1390 with SMTP id
 af79cd13be357-92091786f27mr820309685a.39.1781902121691; Fri, 19 Jun 2026
 13:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178185979029.4044562.9993615975949055530@maoyixie.com>
In-Reply-To: <178185979029.4044562.9993615975949055530@maoyixie.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 22:48:30 +0200
X-Gm-Features: AVVi8CcIfYL72Jybgb_uyRdiwHEb7NkzGSSu17a63NnIJruCaL_QhhQ5jNnd0gk
Message-ID: <CAFEp6-37ambJxjnwxqMCnc5bGLmL0d+6dNtu_pNVYc4WKOSb5g@mail.gmail.com>
Subject: Re: [PATCH net] net: wwan: iosm: bound device offsets in the MUX
 downlink decoder
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIwMCBTYWx0ZWRfXzVHiqq1tCDhx
 izqZzbRsx/n2huaWYlZJXC0JxNvo3qWt9YemlByJHQVZ/A5DazlsSWhq9Jut6QtdnQGu+a11M20
 LxCObmFnrQ82CyY/hi2x5HT6RWMGfOU=
X-Proofpoint-GUID: AgJlUAaGHvHjS-gPPPsV364lr2RYBbxr
X-Proofpoint-ORIG-GUID: AgJlUAaGHvHjS-gPPPsV364lr2RYBbxr
X-Authority-Analysis: v=2.4 cv=cY3iaHDM c=1 sm=1 tr=0 ts=6a35ab2a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=d3nvGuovzB6WDmDeTcMA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIwMCBTYWx0ZWRfXxSybkZjrY5MZ
 Ds7mq7vo/iLEABCJmKC1nGixMKQ146SGlKE4vrpVgRxi4IDBDMC2DBUji0//vVMAxt0PB75gznS
 XEdSANwL7oaTE36UReAtV4dzY3C/odFwYYl/h/ZPYAEA/bRQUC8A3LBbcJ4KKdJFUIxcLGRyKgA
 CPQER2Fj1mkZcl3IkVnEH9wK4YKG4eM2f9rn9up+mx0zcyndlAQc69h+zS8SW7LIfNLeewH5R4s
 gXjMX6oST+5/3Das+tHHru5AslV/rgZpGApUg5lGheqIZYFwl5xy0usPywG+X8o8vZSnjiE76IH
 A+bR0RJSmXBv9am/BeBXjUMnM6W9CKqv15/GxgUjo5nwpEAJO+2h9XH+beDs2hfvvZmTsjr0EE6
 hwNJhro0Lti0Mv5yahyWi07nK/raMVgVcbJt+RaTec8ZY6PRwWKCrbWooUH2U7J/fVN4PS4bLRV
 DPc3Mvlt3UL+KTh2lhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190200
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300754-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixietju@gmail.com,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA3326A7B51

On Fri, Jun 19, 2026 at 11:03=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> mux_dl_adb_decode() walks a chain of aggregated datagram tables using
> offsets and lengths taken from the modem. first_table_index,
> next_table_index, table_length, datagram_index and datagram_length are
> all device supplied le values. Only first_table_index was checked, and
> only for being non zero. The decoder then formed adth =3D block +
> adth_index and read the table header and the datagram entries with no
> bound against the received skb. A modem that reports an index or a
> length past the downlink buffer makes the decoder read out of bounds.
>
> The buffer is IPC_MEM_MAX_DL_MUX_LITE_BUF_SIZE and skb->len is at most
> that, so skb->len is the real limit, but none of these in band offsets
> were checked against it.
>
> Validate every device offset and length against skb->len before use.
> The block header must fit. Each table header, on entry and after every
> next_table_index, must lie inside the skb. The datagram table must fit.
> Each datagram index and length must stay inside the skb. The header
> padding must not exceed the datagram length so the receive length does
> not wrap.
>
> This was reproduced under KASAN as a slab out of bounds read on a normal
> downlink receive once the iosm net device is up.
>
> Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  drivers/net/wwan/iosm/iosm_ipc_mux_codec.c | 23 ++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwa=
n/iosm/iosm_ipc_mux_codec.c
> index bff46f7ca59f..1c021bb0aa7a 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> @@ -557,15 +557,21 @@ static int mux_dl_process_dg(struct iosm_mux *ipc_m=
ux, struct mux_adbh *adbh,
>                                 < sizeof(struct mux_adbh))
>                         goto dg_error;
>
> -               /* Is the packet inside of the ADB */
> +               /* Is the packet inside of the ADB and the received skb ?=
 */
>                 if (le32_to_cpu(dg->datagram_index) >=3D
> -                                       le32_to_cpu(adbh->block_length)) =
{
> +                                       le32_to_cpu(adbh->block_length) |=
|
> +                   le32_to_cpu(dg->datagram_index) >=3D skb->len ||
> +                   le16_to_cpu(dg->datagram_length) >
> +                           skb->len - le32_to_cpu(dg->datagram_index)) {

The logic is ok, but for readability, I would suggest to convert
dg->datagram_index and dg->datagram_length into intermediate
native-endian local variables (e.g dg_index, dg_len), making the if
condition cleaner and avoiding repeated conversions.


>                         goto dg_error;
>                 } else {
>                         packet_offset =3D
>                                 le32_to_cpu(dg->datagram_index) +
>                                 dl_head_pad_len;
>                         dg_len =3D le16_to_cpu(dg->datagram_length);
> +                       /* The header padding must not exceed the datagra=
m. */
> +                       if (dl_head_pad_len >=3D dg_len)
> +                               goto dg_error;
>                         /* Pass the packet to the netif layer. */
>                         rc =3D ipc_mux_net_receive(ipc_mux, if_id, ipc_mu=
x->wwan,
>                                                  packet_offset,
> @@ -595,6 +601,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_m=
ux,
>         block =3D skb->data;
>         adbh =3D (struct mux_adbh *)block;
>
> +       /* The block header itself must fit in the received skb. */
> +       if (skb->len < sizeof(struct mux_adbh))
> +               goto adb_decode_err;
> +
>         /* Process the aggregated datagram tables. */
>         adth_index =3D le32_to_cpu(adbh->first_table_index);
>
> @@ -606,6 +616,11 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_m=
ux,
>
>         /* Loop through mixed session tables. */
>         while (adth_index) {
> +               /* The table header must lie within the received skb. */
> +               if (adth_index < sizeof(struct mux_adbh) ||
> +                   adth_index > skb->len - sizeof(struct mux_adth))
> +                       goto adb_decode_err;
> +
>                 /* Get the reference to the table header. */
>                 adth =3D (struct mux_adth *)(block + adth_index);
>
> @@ -629,6 +644,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_m=
ux,
>                 if (le16_to_cpu(adth->table_length) < sizeof(struct mux_a=
dth))
>                         goto adb_decode_err;
>
> +               /* The whole datagram table must fit in the received skb.=
 */
> +               if (le16_to_cpu(adth->table_length) > skb->len - adth_ind=
ex)
> +                       goto adb_decode_err;
> +
>                 /* Calculate the number of datagrams. */
>                 nr_of_dg =3D (le16_to_cpu(adth->table_length) -
>                                         sizeof(struct mux_adth)) /
> --
> 2.34.1
>

