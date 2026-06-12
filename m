Return-Path: <netdev+bounces-298507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kSAvBDq6K2pVDQQAu9opvQ
	(envelope-from <netdev+bounces-298507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:50:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F096776DD
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:50:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=XLmVMoPm;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=JaJCLp36;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298507-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298507-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61FDE3084871
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4DF3DDDB2;
	Fri, 12 Jun 2026 07:50:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28908332ED6
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:50:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250609; cv=pass; b=Z11czIGW1jJfazqWgRKts89yHivFRXeZyhGwAcZ7U87JS10X88PKA3UKJKDGOHZLb+YfNLIrwF8dM72tLMWdWM2Aq26FE31b6kh3fCuBku+o5KCIndoaIPQgRkNklpdvDOfMom1wlVy9aaj8X3UkaINQUhg5p8r1hCXO4W6RUek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250609; c=relaxed/simple;
	bh=JoFh0/LfLTmYydoc7sBaUkxpVWSO6HzF/EXASvItliU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aq+l3qX68TmAxkwzvCPr5iX7N3q9JXxXdOC14yLwvKzGKF+1/IDmfJVaikJBhlZd6fiZQHI62C6f/2T8r7mIUtcSsz1Ae1GpQSRflFqQt9vYNbSZ70g5xOyV/Mz1f2L2LyHJYQc8PBCPfalqH6rXELeJ24KpHwE97uLNqrE7or4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XLmVMoPm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JaJCLp36; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C39p0h2516712
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qmm7WObKn7xbXENIRCTGOPEDqWrWLAIk5HL7kdXDedY=; b=XLmVMoPmv/qzgQeM
	JnPQiBojpLhECC5jnm+6Pcq9iPpWZEcRVr7aelNuLIMm+0e/I6/TdIF0Wrex38gv
	armrrZUaE6GdNBsbsQSv3aBvume/8sQ7Ie17zZphM01GccZlUutEzDRjEOUUvw8D
	XrdGkBTZsg3ByihFoB0dycLGXYte8ZSGKipy5vDaymnWhwfQtvDnHXeMhr3eXteg
	xDfycJlHUINYp1iPk9H+2oS9aDrAdvyEx+5DnutvgxZtlVE7xwDXI4z1Zq8bnv7Z
	3qqRjtFm9Tioh4GO+EOEghHz0hYhwEu0lrNBd7uiy95eSSSSyLdtdqbf1vBKMZgN
	6YzbtQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2r724ne-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:50:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-915b6b63056so145086985a.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 00:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781250606; cv=none;
        d=google.com; s=arc-20240605;
        b=HFJHm7fO39774RiSuax4l/nWHE6f6/JBgyALdvb+Sd0ljX9noeaXk9bqIe9r9thSzY
         XZmBVeTBZRMNdvJ9sKCDzBK3ukoLYP6aTitZ+dVH4V2H/RfnJrBGh2OBjnd3SU6cDEll
         XAJysNI3m6Pe8kZzLAjlwsrh3XyE8fPUscmjtxy7IEyeb94QwNlq0EwOj51nR96INMQ7
         PBYsmyMbHmGL0iBS5xlsVq/jKAzxp9yYUYqBkZ8avV6FYfaIN1jzqAglnZCIAw11tr46
         GCY+aYVsGx6YxLJdG+6KhrrUZv/zGnlPbfKss23XQwhNJ91Uxk60aU9QNe3j7Q/9bcNK
         +KNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qmm7WObKn7xbXENIRCTGOPEDqWrWLAIk5HL7kdXDedY=;
        fh=Eu9k/mNaLZDz/bcvkMD1wLloAj81mj/FKbLqGFOU3iI=;
        b=ADRt7zACObCLtTY1YR1vqVF841n15rQf2uo8Fa1mFP+YG5PsWSlGlYRZYW+HOBgJuN
         I42pPfVRhZyAg0eUAOzH08gNdOHA952AfHOqxRdUxsKmGmuw3t+7l0s4a1i/i0pqvpMV
         kuD4mY7Jjp0C1aIA9QOz5IF5gBGr+jtszZje/h6NFiUzTv6Np6If+LMz1V/1glOUK8id
         9WzisJ2rV8kMK7KZqzAYD/ytUKojLh0Flh/Ey6bR59VGThcvcQFiPcOWPfsu3fB0b+Js
         jMtJVsRP9JkOD/+o/5oTawLVH08QqhpzCwi6QrS/Mq0KGnvo4xwP2EfAOeodcZHy6DSV
         z00w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781250606; x=1781855406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmm7WObKn7xbXENIRCTGOPEDqWrWLAIk5HL7kdXDedY=;
        b=JaJCLp36rN8egSlhZHu98oJP/ixPgK0QZgF03F5e3bpXZXtbBWo7q5wAbHo55DwrTn
         gpPlaXfyR4BFcNfByT0dwxQdhXegjTusj96H3mvB3J3urW/QUceUESuXI5XBq0G1dhQO
         FN5YaVqkrvuDo9tzoxgd2r9MRlc0YuHT8yUECgBdH3GH/RjL8ND6ZJQjxw9pTw7K2M3w
         CBNC9AWoaG/hbfeT11/dHeweN52iIDu31vHhgUjVGQ7/UiswhV5BJ/nOG4cLHoR4VWUI
         l8099ssDxaT/wNVaQP2AyfGptKuBp4KHvIWRFNnTk9K3hEetayfFkeN5jfsPqTYnakVv
         XIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250606; x=1781855406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qmm7WObKn7xbXENIRCTGOPEDqWrWLAIk5HL7kdXDedY=;
        b=l9i5rS9rxfFWvujdvqegVd5AHzCOdLf1JSjRwG5vZRzNi+wSQ7ivbrJv15mGVAbqRO
         RwmxJU3bQV6eA8C4LDUJU6J96sBmpm8HufhX2EXqrAJENz2g7ursi0jjt8fCgyMqD2zc
         nJyY4DBfkLPVG6J/urKbwpDVmKtw4l5l51L05Qe0T8FxypqgP4DhhKs9jJckoasPw/Wz
         1VI63H+7OjEnVA1itRnS5m9e038bjMtMUEdvt+gp/4A22EtPfDHjaIbweUjzrkoNEbj3
         9pgXUI0dvK7SA0CDL8mDHPkylcWI3rqfiKfAtspigFlLtWvT8Hq9HtC3um2g23ZxXFBZ
         KrHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4CZAWaSNJ5HNfbd7YQVglhwI3do+toM1Ou53cvyUzhKbSOpX/OseA368UARqwWus51sETHJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqfQGg4HPb1S6AOa4zCSsiadMLatLSNLTvQTMCrqdWR6UtVKNN
	wv54Lms6ndy7+auQT1ckTQHYHN5whnMsmBmvu35U4Yv4NUP8JTlxrkZkc9mscdOD9vXxLQNn0dH
	7r2l0tG1MA7GjhvjHR5lZEqxRPliv7H2pIuBc/nskxxuMyfmfGr7fdhP9dZ9ENRfgztTJl9sBeR
	+I0O6FSCVIuEEH5CAo5odsdP8/+/wtZkbi3Q==
X-Gm-Gg: Acq92OEFXCZ2xwrLR7FN4VqK82uTiF+vwLXsheAodrZ9CvCVPlAnbuUgTuAvKdSOD2Q
	vPoK+dyIy3ClWbWdyIEEeUmK0Mpjt1gNtt3EexS4cCTb9hIdIfUxuOyO7QviGs2XSx62udhW1Lh
	i6XEulWLLDWgGTyxH6Am9uhfKuBDgZhTROuXqb0IPdCdfLaYgfdQmeRBLnU+tVcRy/68ZcwqIqx
	TxvLkOaPLBs4rNZtjMSF+W8h8h2ju00bqxtmU637Nnd/9n3PejhgJlZgPr3FfqItlWwDhcTGtSR
	6udM5aXRcjWmqbjzFa/5
X-Received: by 2002:a05:620a:7116:b0:915:6758:24d8 with SMTP id af79cd13be357-9161bcecef5mr216692485a.42.1781250606490;
        Fri, 12 Jun 2026 00:50:06 -0700 (PDT)
X-Received: by 2002:a05:620a:7116:b0:915:6758:24d8 with SMTP id
 af79cd13be357-9161bcecef5mr216690185a.42.1781250606153; Fri, 12 Jun 2026
 00:50:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612035613.1192486-1-ruoyuw560@gmail.com>
In-Reply-To: <20260612035613.1192486-1-ruoyuw560@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 09:49:54 +0200
X-Gm-Features: AVVi8Cer0DJ5TXh13mt2JGUCKa5idBXCn9pVhEGsliLpkFVlezLQmjAneqc7X_s
Message-ID: <CAFEp6-2yWfSw=GAx_N6rrMnhCBWdKRX80PPyV6qYvsq+sqwMHg@mail.gmail.com>
Subject: Re: [PATCH net v3] net: wwan: t7xx: check skb_clone in control TX
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: SgLIrTI6hIObYESKCJUh07cBUYXvxohd
X-Authority-Analysis: v=2.4 cv=RJGD2Yi+ c=1 sm=1 tr=0 ts=6a2bba2f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=zoG6pt3vYd9LuZ-_mncA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: SgLIrTI6hIObYESKCJUh07cBUYXvxohd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA2OSBTYWx0ZWRfX1ik0Peo5ARPs
 e1ctcrcZwfA+FBRFy8J5W6FwCIQ/Fieq7xKFbsa7eCwizJA+8VB0NF0b29NOx5QjSGzJ54TRG9V
 pWLKoUlvrNPpvSPlwgr6Iye6KYevAwdTq2e/4ANMnbs0ovo3a/iYdNiN/Rs68Unqv6NdzE1O85o
 t+nt1NBkLG0edr8aUcf33p76/sCVyBh2kDkec29dRcS0ScxiY5qItu4rOYU5lPVW5NGsd/G4pp1
 1LVgXScHI+UAIqudmxg33xsdmFgaovyjpL4ZH7WYlfUwjsdSukB/xWfs1iWnq0ChcqaxysWWdjR
 ELvU7koOjuixReWxcFUsM3VXaIxwYzT8anoEIn/n65FDnTsXNWPSKeUdWjKbBbJw/rte1FNGWFi
 OXClSbvjniYrV1CWVSYgyyCRFCRtYSe7H8hB191I3B9BdNl5oDJuUl68LP0EwZzqOKc2eYKjmFb
 7VWb6CKBca2PLcYXJ+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA2OSBTYWx0ZWRfX6/OwiqFq7fPR
 0G6V8V4DDewIg+YiRYioLVvp8ZhUu1oE0IO29kw+8mig71E+1tH/PJVUj+iv0/9rQIPaaZKPa0U
 el5g3FhigINyBsZ8MEQKkrg0RfuEBHQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120069
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298507-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:chandrashekar.devegowda@intel.com,m:haijun.liu@mediatek.com,m:ricardo.martinez@linux.intel.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,mediatek.com,linux.intel.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75F096776DD

On Fri, Jun 12, 2026 at 5:56=E2=80=AFAM Ruoyu Wang <ruoyuw560@gmail.com> wr=
ote:
>
> t7xx_port_ctrl_tx() clones each skb fragment before passing it to the
> port transmit path. The clone is used immediately to set cloned->len, so
> an skb_clone() failure results in a NULL pointer dereference.
>
> Check the clone before using it. If previous fragments were already
> queued, preserve the driver's existing partial-write behavior by
> returning the number of bytes submitted so far.
>
> Fixes: 36bd28c1cb0d ("wwan: core: Support slicing in port TX flow of WWAN=
 subsystem")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
> Changes in v3:
> - Preserve the partial-write return value when skb_clone() fails after
>   earlier fragments were submitted.
>
> Changes in v2:
> - Add Fixes tag.
> - Return -ENOMEM consistently on skb_clone() failure.
>
>  drivers/net/wwan/t7xx/t7xx_port_wwan.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7=
xx/t7xx_port_wwan.c
> index 7fc569565..d2529df75 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
> +++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
> @@ -106,6 +106,8 @@ static int t7xx_port_ctrl_tx(struct t7xx_port *port, =
struct sk_buff *skb)
>
>         while (cur) {
>                 cloned =3D skb_clone(cur, GFP_KERNEL);
> +               if (!cloned)
> +                       return cnt ? cnt : -ENOMEM;
>                 cloned->len =3D skb_headlen(cur);
>                 ret =3D t7xx_port_send_skb(port, cloned, 0, 0);
>                 if (ret) {
> --
> 2.51.0
>

