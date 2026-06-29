Return-Path: <netdev+bounces-302499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d+BLG+snQmpA1AkAu9opvQ
	(envelope-from <netdev+bounces-302499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 10:08:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B52906D74CA
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 10:08:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=iv+TYoyw;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=D+ZIi9pu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302499-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302499-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1292B31DA4D8
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 07:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E8C3E44EC;
	Mon, 29 Jun 2026 07:49:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EDA3DE446
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 07:49:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782719369; cv=pass; b=jGFOQk/+CosmqlVALZcBihlqKRcpSlfWBYDnZGbhjzwQY4a0GJi55PUw0l6qoR8ACzkPOYirLnTWcc/XFS4d1FiKuTO385LzbPdvoZuB++znQJQEAhoYGvfhMDEJiOgKI1d0/dwcIWuM5Dfzn9e8nK5EfOnRgc4cXqype8jxmvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782719369; c=relaxed/simple;
	bh=btbZWvEafKqIS+blxXbzY2y2nMrTGxHr/GSus5YYopQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEAZ5CzIDciNg/crXiEQX05VzisZhkGVF3kptCeq+PWhPZS6+t40IY/Xfnke+AvA1qmEGus/QMWNeQuDS+yuUW1eB24vnL0mQ71WbxfNEQujJPp/azs9+YbA4TbHU8J4wXPG3BslzlSTkVHh/VfXAxDZ3DSUQ918RXhp1f4KX2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iv+TYoyw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D+ZIi9pu; arc=pass smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T72Zof2163892
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 07:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PNuv6Xet+hQ1A5x1kF4sIiJsIr7UgLVZ+1RRk8NCKM0=; b=iv+TYoyw35MqA0P6
	ep2b7mOo7OZjgz/zY4r/iqyoEO+LLdTtlSRQgtkwPLMneRwNeDnaozkmP5tF+pya
	8jntfULb/Slc2gKLiX4vmpicffwkFUMpCr4bGEtzASBXc1K3n1bRfsLRSIt+HG4n
	OKm8zimIQ6xzI6VolXe0Dy0LH/DTM/7eua2nUW3GURHWQl13Ep9klGYk5TrtqfzL
	2xxjJ4o/xY1wnjwdod7sccJp5DbLbQqLqQx5nVVa/qTMENKWYf9U/6H+ozSOPKql
	QulRw8WYTKYeA/yAneN1dABMCvWdQ6Og9nCJyS5Q6BXMYPgSiaW50WgLX+u4aJzr
	MMV0aQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kyjg69q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 07:49:23 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f05dd0dda9so22819766d6.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 00:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782719363; cv=none;
        d=google.com; s=arc-20260327;
        b=Zb0jCH0T0JOBpShIYTG63fiwyeRjQcQGntCfeIUEJzChw/Ry0dNfga/rV7t+Hk3iDS
         rXB0IdIRAqWhhZTnp1ZKM6+BrqfqD7d0VhXXFZH22fO4bT8eGxVGPI0NXQgLfUS9SJry
         kfRzCwyo15jAVRSwFW1NlEWek41lTM7MgArWx0A+FX0bKeVfrcTyrPRX7EKbhshRLShu
         TBJYOXGkuZ+wVhIx2VBcZyE+fliOLBlszhivhxhfTQBAEW/u7yaqkVTj9vD8a3iL3tPS
         cFZdC8CPAtEapENsFVbgZ7F8KH60zriYxLRJQVKCnEOLT0r7sKW56SUhTmIOQQIwCL1C
         nQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PNuv6Xet+hQ1A5x1kF4sIiJsIr7UgLVZ+1RRk8NCKM0=;
        fh=FXKxzB0D/Ad0/RbULVJmh6NG8HfEh4bynAJwtPOFGvU=;
        b=bHwDGIjtJo+1C+KFE88kC+6rb2MXeHYfvzC4xyFQPlwfZYz3VhFBPi4lbuZubyDacF
         nGcEScmZxbpbYfMO/wf6TvC/B4q+oflZMIe4IeNh+9xzTwX3cKrsEroFnbN3OxqE9VAU
         QEFh0OsMAxl2qsI7RxhggkzQnA1WKTxGBZR/Lh028hWN3NLD55VSe/iG2QkLrd9LDP7j
         LX1x7ySIJrN9X0X4LUtRDv3Ez69rd/VUN0rd+Uc0fA1fCRe4jW7GVIjzk6Nm6FLA25Po
         xGnx7BLVyCmJpecAYoOLPSg8Vmr6Xxu5dBnK0yA+zElZG+MFVBqtG5YKPdPEIapWLL6K
         nu8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782719363; x=1783324163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNuv6Xet+hQ1A5x1kF4sIiJsIr7UgLVZ+1RRk8NCKM0=;
        b=D+ZIi9puSNmzy4vUVS9l2ilgrAOtGx74dsiyY+011sIowzSiP0PGJVwVO8tVcqdi+w
         qjQO5lMOqbbq1+iTeBrIYq+tA1AAKJbny0aLL/fKTFWIEnW/Y7+53NO9ZhuPbqvh+vFm
         86l12Yxm4M4vF3ZqGo/ci//UoCuERjTonCatYAxFlZJWx2VPev1Lz7RVfDgu9d/FiSTC
         3g1XOsNVFMOYORGD1aoc1w7WVxKFHNR/B2Ui0Hu2Ho4hzCfIegy8EueKT/IjkqGmnRl/
         Ey3xYIX80q5ZOfahxIvkN4+sdM/gRFkrK0+MtSMPHO5TI3vVMrbnxVwT/BJltUph/nbf
         kEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782719363; x=1783324163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PNuv6Xet+hQ1A5x1kF4sIiJsIr7UgLVZ+1RRk8NCKM0=;
        b=fpEJgfWU42+rAyH/2nhUYOlDTSmzjFFDTHsQ9+HhWu9SSHchHgVlYavlFH4x7vL32e
         e1/KIdVUU6/tSyj/lq2HrolLgrTadDVOF7pAR0TbIEUesgAHuSOU3SU50Nk4MdDCqA45
         FHs+uaofbCGfQOOLzS44BJakehf8HrvdAp2+pQwP6L83/b8svUVzNQVtWuh7sOajQQE5
         nntNNSv8kHYCzEnE63FXDC5RN9KCtEyptjw+F0qIOhxV2is+QER1pXDpZ6nOuuYoSaZZ
         1ibB5WL+0R9bt6ZK6PWJfoJpk+MvhYQI/Cs2nCvcs58pNNnA+90QVHbBMtPyFW1n4QyU
         xg0g==
X-Forwarded-Encrypted: i=1; AHgh+RoCwNzp6yQuxVTRUzf9Rs+MEQkz1Y+s/+j76bfLadfhr/1tohJ39EPSBOcwnTzPeR89jSjnvzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc6gbqh8CapcQXLIiLEkGcGk8WuupowpEZmog9AlTtaj/etKg/
	XlQwde2DZq1ACQ5Ii2YUDndFH5gHXVfbWhQQl8tk5zPePocrhTSsZOfG0ViX6umIsGWp73mK1Ae
	Yg6ZGSFgYkdTnZfamNWLrZtzuHXBSun1FdDd0Peginsfq9bYCG0W2U4bYoezhg/iCX0VHHjvh2I
	Iz+R/CljqQCODxsdHZKZcm/Uu1J1fo0NyfXwFL3LGy6Kam
X-Gm-Gg: AfdE7clE9IBiCVV1euLLsHQSaIZHeKJjEm4ibwB+jqeYvJRCHlpWtldoQpE9ixREHV1
	uJI5yfG3NUlBIA8U3nweEEsmmACUR/mK/YTA34IFeaRvc0YUqXTv3VlHhrnJFtJ4AMwhxIH1F7D
	Y9HGSQZt15juaN4W4BKoQHrgjfunFzcKkbi3Bf++tNarNDO1yVC7eOAmoSQUbO3ezVwtkdXxwed
	DoaBKbfnpLVry17bvMcx5TZeIiSgCjXI/XqSUirGgzYlZL0xrOq0Kd9QpPAKl2UEBq8XtqR7l/7
	WdCgZp9J6Yc=
X-Received: by 2002:a05:6214:311a:b0:8f0:796:480b with SMTP id 6a1803df08f44-8f00796493cmr38684466d6.27.1782719362685;
        Mon, 29 Jun 2026 00:49:22 -0700 (PDT)
X-Received: by 2002:a05:6214:311a:b0:8f0:796:480b with SMTP id
 6a1803df08f44-8f00796493cmr38684246d6.27.1782719362149; Mon, 29 Jun 2026
 00:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178236824878.3259367.5389624724479864947@maoyixie.com>
In-Reply-To: <178236824878.3259367.5389624724479864947@maoyixie.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 09:49:10 +0200
X-Gm-Features: AVVi8CeThT6HkNNgV9aJl_cZk3MWOqnK73KnDiqiYz2ZGnzHZb1yeA29gTxkAQ0
Message-ID: <CAFEp6-1=qPdK1SQo+_ziomp=GzQP8wnc6SuRKsNtRmDspfJJ9g@mail.gmail.com>
Subject: Re: [PATCH net v3] net: wwan: iosm: bound device offsets in the MUX
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
X-Proofpoint-GUID: VY6skZXkYnTGZU6eHvAuDpU3c3kNBYik
X-Proofpoint-ORIG-GUID: VY6skZXkYnTGZU6eHvAuDpU3c3kNBYik
X-Authority-Analysis: v=2.4 cv=Ftk1OWrq c=1 sm=1 tr=0 ts=6a422383 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=SnhycFdtAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=SzebcLgiP4Mo2SmTKnQA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=IdunurJ9zWQ3aaQyNLvr:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2MiBTYWx0ZWRfX9x2+Bi54Btvq
 h/Zz+XlCVgYrrd9z8TkzBtX9IUAViFImiTIneajyOUbTElYZS3+0EiHj22fwd5F0urY1VgSSYLt
 kVrEWn5S0un5/mgcXV2/MYzp8hQS1y4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2MiBTYWx0ZWRfX4stxLRi+eFkq
 22EbwxQindNTQ9FfAgxf/NZXbHtGtkWU7SE3QX1Pna7w7VSCURvmrit1jRpVU9VSptd3yKjJaS/
 dlWH6v4B6TCC1tTAPxWS1GisVYaiXmgmzme4q7uOd4d7YjDkOPZnLOO68BZExDTiTJ/mOJypTuz
 YZ2sYH1Ymbeb/tvCMoh7wvs9yGD8+1SbiAyoOuVulS4gTbr9bL/zOHArvLj3uc97MQudpIivasC
 9cqBafriF2HYjoqIOJphiXUyvgdqBaRVmgSARx2NbJboXhULPScuf48uwM2qXW9XxO3U5vixSGo
 MDF4VhLL40elmpm9SxRyPbd0TUy7JhwrSwafwyKwVYg3Lr2V+QYJlp5NqO66nufdGa8tnwXOaQ3
 1el/6VNp6zuU2OCkvK6R3uslDEJEzFf/ZJgfshOLlWFAYi2IH+lJHM6L+2I1EreEmcc3yoPpYgt
 eVlpPtsD4TtDF827PPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290062
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302499-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B52906D74CA

On Thu, Jun 25, 2026 at 8:17=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com> =
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
> The table chain is also followed with no forward progress check. The loop
> takes the next table from adth->next_table_index and stops only when that
> reaches zero. A modem can stage two tables that point at each other, so
> the loop never ends. It runs in softirq and clones the skb on every pass.
>
> Validate every device offset and length against skb->len before use.
> The block header must fit. Each table header, on entry and after every
> next_table_index, must lie inside the skb. The datagram table must fit.
> Each datagram index and length must stay inside the skb. The header
> padding must not exceed the datagram length so the receive length does
> not wrap. Require each next_table_index to move forward so the chain
> cannot cycle.
>
> This was reproduced under KASAN as a slab out of bounds read on a normal
> downlink receive once the iosm net device is up.
>
> Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support"=
)
> Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
> Changes in v3:
> - Also require next_table_index to move strictly forward, so a modem
>   cannot point two tables at each other and spin the decode loop in
>   softirq. Raised in review of v2.
>
> Link to v1: https://lore.kernel.org/all/178185979029.4044562.999361597594=
9055530@maoyixie.com/
> Link to v2: https://lore.kernel.org/all/178196118045.462404.1106913916044=
8641355@maoyixie.com/
>
>  drivers/net/wwan/iosm/iosm_ipc_mux_codec.c |   40 +++++++++++++++++++++-=
------
>  1 file changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c b/drivers/net/wwa=
n/iosm/iosm_ipc_mux_codec.c
> index bff46f7ca59f..0bbd41263cc2 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux_codec.c
> @@ -553,19 +553,21 @@ static int mux_dl_process_dg(struct iosm_mux *ipc_m=
ux, struct mux_adbh *adbh,
>         u32 packet_offset, i, rc, dg_len;
>
>         for (i =3D 0; i < nr_of_dg; i++, dg++) {
> -               if (le32_to_cpu(dg->datagram_index)
> -                               < sizeof(struct mux_adbh))
> +               u32 dg_index =3D le32_to_cpu(dg->datagram_index);
> +
> +               dg_len =3D le16_to_cpu(dg->datagram_length);
> +
> +               if (dg_index < sizeof(struct mux_adbh))
>                         goto dg_error;
>
> -               /* Is the packet inside of the ADB */
> -               if (le32_to_cpu(dg->datagram_index) >=3D
> -                                       le32_to_cpu(adbh->block_length)) =
{
> +               /* Is the packet inside of the ADB and the received skb ?=
 */
> +               if (dg_index >=3D le32_to_cpu(adbh->block_length) ||
> +                   dg_index >=3D skb->len ||
> +                   dg_len > skb->len - dg_index ||
> +                   dl_head_pad_len >=3D dg_len) {
>                         goto dg_error;
>                 } else {
> -                       packet_offset =3D
> -                               le32_to_cpu(dg->datagram_index) +
> -                               dl_head_pad_len;
> -                       dg_len =3D le16_to_cpu(dg->datagram_length);
> +                       packet_offset =3D dg_index + dl_head_pad_len;
>                         /* Pass the packet to the netif layer. */
>                         rc =3D ipc_mux_net_receive(ipc_mux, if_id, ipc_mu=
x->wwan,
>                                                  packet_offset,
> @@ -589,12 +591,16 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_=
mux,
>         struct mux_adbh *adbh;
>         struct mux_adth *adth;
>         int nr_of_dg, if_id;
> -       u32 adth_index;
> +       u32 adth_index, prev_index =3D 0;
>         u8 *block;
>
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
> @@ -606,6 +612,16 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_m=
ux,
>
>         /* Loop through mixed session tables. */
>         while (adth_index) {
> +               /* The table header must lie within the received skb, and=
 the
> +                * chain must move forward so a modem cannot make the loo=
p
> +                * cycle between two tables.
> +                */
> +               if (adth_index <=3D prev_index ||
> +                   adth_index < sizeof(struct mux_adbh) ||
> +                   adth_index > skb->len - sizeof(struct mux_adth))
> +                       goto adb_decode_err;
> +               prev_index =3D adth_index;
> +
>                 /* Get the reference to the table header. */
>                 adth =3D (struct mux_adth *)(block + adth_index);
>
> @@ -629,6 +645,10 @@ static void mux_dl_adb_decode(struct iosm_mux *ipc_m=
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

