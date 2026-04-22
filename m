Return-Path: <netdev+bounces-280545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qnZiDcYp6WknVQIAu9opvQ
	(envelope-from <netdev+bounces-280545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 22:04:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C5244A737
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 22:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B322630071D2
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 20:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E983F210E;
	Wed, 22 Apr 2026 20:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YtLDY9uF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IgovRglL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A8A39C005
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776888259; cv=none; b=ineW2VjPHqYFUij4Xxk7e+oJ/l4Qv0RrZdrRRBMxWylnP3qvm4Ae4QT5xx1lIsBx9GFHUqs4EBqEn3sB09GecOkzb5V1DiUjo9kFn2FSlQEnVG6FAUXBns7BB+0Gf+mOd7AKFyYz2VklTLs1t2xYvFcRrnD0s6AWSCiVNhH7d6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776888259; c=relaxed/simple;
	bh=Vw5lbIz93bfPivnPlgZTf922sy3wFpATm4HMbXkasxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuTkCx84IalYZQi5fLTTiYJbhzhN8vVCfLJ7VhKIMKlzxMfZflINGO7t/V4lYcuIHjo0dPNX8ftzQZVxp2hoNeQdKFG87uwHyqnGz141MswDufNZY4MUqTkdObuAgyGqPPY0R1BRvqxss6ttmvy2EVfY6kLtKnuJ3t9FaTXgTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YtLDY9uF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IgovRglL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MGqhMg1218628
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 20:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TWNv/n77xtlQNACjJ3+8jJLY
	WYV7KxtU3j5KJIFZm9w=; b=YtLDY9uF5xOkCoR8E3Hapt6dWg8lw9y4CViURo4X
	3sj1xGiBYjfiOlGRP6eA/ix80qQtgSD5BDXQ3OUdZi2TY8vDwvtnHONVZG5N4Mtp
	Evjab88v4Ddg4qOo+pRr/xWx9Ns8qPgqG9+E9Y5FUY1c+m9NyDi490VZ+5rT9V3X
	rNy5DzOcpX3JpNZdLuhslsk3tCP+DLqiJIYsqlrsEn3PjEuWX87GqgAERsSGEPLs
	4Q9NPD4F4ixz33UAUspYkKvlTw16b6m5PgJ3Hig/XunesxrltP8r2sSMMsafu2is
	qNEkRl9ZPlkFePAbtM2xVw8xZtpC76DJp4eX5vb3NdhhPA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq282rp19-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 20:04:17 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-620f5085c37so42933137.0
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 13:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776888256; x=1777493056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TWNv/n77xtlQNACjJ3+8jJLYWYV7KxtU3j5KJIFZm9w=;
        b=IgovRglLjqALlavWRYhryS09AZfjTpUyQgJZvl5VWXz3kRma5ipHqIJlski6CIlXtu
         4lCkRaR9TqzZxGL9HQaTCtf+5AZsN8okA4UlztxlaRh6pmY9DbJGLPq7gmKzPSoNyo5V
         qPsROGu4eN6JFKo9Qndiw2Zbf2YnrUlLQPCC8gNJpO9E54KFvVKe8VY7O4AZbP0WcaEm
         SHBol4kMEsW2iKDBlIiwnmzUAKb2rzp49f1Y/RL8NJ+UA8/4mY+ErZ7WyizGV0U37hJ3
         eCocGU1RM3QOuh7wHHnNaLDuv43OSkf+j2Tf2elJRQjWPJgo6DjsjHM8DK3o0zwRsrLv
         In2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776888256; x=1777493056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWNv/n77xtlQNACjJ3+8jJLYWYV7KxtU3j5KJIFZm9w=;
        b=HvI1ggGlosFyXs48ysgG34dY1WqOxBWYy1/qK+bw6taYDucQE5BeK9awQAb1BCrBw/
         AcYVigojQDCkk9G+HcPAcVJNUmN4DF4lW2z8kq2YNUq2a294OKCF0KTtbwOTmJOWT7bM
         4JUfD8eRSwAW6B7EAulCl1K6dmx2Kj8lsp8hN3DhyqY40Q2jbTJGz/+c7Nh6ZSZ5z3Su
         zSBmtTzwz6CIJST1cL+hzQEHEMVHZZRV2yDNl72PzAHA1u37gdAmCAGZQwCz6IwNNzmn
         t9DSYlGKUDn043woYVJFsyFmzagLGbnFN9lVw9wUZXlWGSNyODx3SpQVIrgxwjNdd0ZT
         30jg==
X-Forwarded-Encrypted: i=1; AFNElJ+feNoePH+2pUwwsccRgFspb/kfpazNp/6fNYb1jFh65Qq9lgQYCiDx1UzLEsW3D93aHFFOg5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe8H9vJ+N6btnqmZHSPkN+jtYYyOg2062Dfne4mJiyrgkbSGwS
	0lPy9sFHt88oiHHFmJHJQrzB+IYxtF1fkZoHnTIfEiLjBrbdlKitlCJmZJuFMRLYO83NDCwZYhy
	EbMRxv2+fjuvi06iTj/mq7D2SsHMkqiOc/j/lAt+x0xSU8WuQCqBj4NlDJ4Q=
X-Gm-Gg: AeBDievNJa8q0aet6wD8fhB1XS/hmUGb9dnlZydvJG0TgmAP97kxeMqWp7nCn1T+4tE
	+Bh9nqjFHxZhLnbYmVSPDn/m9cAaDydFRPGxW/Bd3I6dJDTNbNyw1RyBsXS3SyXVJ5dMEP1aRoY
	Tumb29COXJBFcxhpJphf6rTlgdUlg4a3IWC8TLdRlalRzaYNp6Lvn0geYjGYos75FsyMnTzTKT3
	gdY7is4s31lb7HvITadlLLd2bd69PEl72ed7qogNBCl8ubiPDUGh6pM/aGNslwWV4axE3Z5sNzs
	pxmz93yBmYncpmJLHwF3sND/Tegx3GTnlxzT18xSqAerDlSaQQ5j6OHtIM85Gwjl9QmW/kDEhQH
	5GI4LxVpBMmohKGGsVfZoHuIxG7rGHF6wmeqMt0KG9ZMb5TDDLRQdHhcp2kvTJGXW64px9F8Fo+
	oZOA+3fCZ2Ljqmumofb46zXOBIJ3xLSWQGTZN3cHDAWGhA0g==
X-Received: by 2002:a05:6102:f9e:b0:609:4d86:77b with SMTP id ada2fe7eead31-616f73fb077mr11984412137.24.1776888256322;
        Wed, 22 Apr 2026 13:04:16 -0700 (PDT)
X-Received: by 2002:a05:6102:f9e:b0:609:4d86:77b with SMTP id ada2fe7eead31-616f73fb077mr11984380137.24.1776888255894;
        Wed, 22 Apr 2026 13:04:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc25csm4689196e87.26.2026.04.22.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 13:04:14 -0700 (PDT)
Date: Wed, 22 Apr 2026 23:04:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: lumag@kernel.org, robin.clark@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, sean@poorly.run, akhilpo@oss.qualcomm.com,
        abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v3 10/15] drm/msm: Switch to generic PAS TZ APIs
Message-ID: <fuypqlwseulyvlsgiq3dnh3kwhernjid2yqljiwmrxufzfuukq@mfy343uq5gs3>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-11-sumit.garg@kernel.org>
 <aeduRrAMOAW4f5TU@sumit-xelite>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeduRrAMOAW4f5TU@sumit-xelite>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE5NCBTYWx0ZWRfX0m+wD7tMfKWP
 Wz3xJ2uAInbMslWPn5AbY7C4KFPsLGfWU4yrWXE0A9ww5qYxQse7rI9DoLsqYMy0LfFWMMyPWtc
 2WvhAcCLmnuBSvfSvgQ5rlkBLNig2LkFAhPiGtMCx14QwHkXv9cTHf0czmSGRoPfZTwXb2atck6
 uyRylAhOzXjg7LXLkC9kXhpnqOaMttUDTPbIhzxulrRWVk53Fur6gIwQmSXsUvESvV15LYHiRMo
 h7JcO23+OpH/s9aI5vfPn/jv+APIZO95o2Wq+jcV4GlAlWN/0MbaMocrzyIzEW66Sol/rIO/a+O
 OOtsSWbzdpQs2fqVhIU5d1xH4OXyZsjx6ZUdL/zuyGNksHyt+YZEq2xLKpJOLEiO5iuU3IP1th0
 TNPmOVgy8dCAcNS4yzRPB9BpVubZW9e6W0/Tr/W9lQR2u1oPIXGu+t1373ahVA8EOmS/HkCs34O
 EA1fhM4JUdXQs5ZHi6Q==
X-Authority-Analysis: v=2.4 cv=Zond7d7G c=1 sm=1 tr=0 ts=69e929c1 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=dgZ2eqGgcVFd7X0fNysA:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: qhRJ03lDQHovwCc_XFDqsqq-Nr6S5Bqv
X-Proofpoint-ORIG-GUID: qhRJ03lDQHovwCc_XFDqsqq-Nr6S5Bqv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220194
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280545-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 31C5244A737
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 06:02:06PM +0530, Sumit Garg wrote:
> Hey Rob, Dmitry,
> 
> On Fri, Mar 27, 2026 at 06:40:38PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
> > TZ service allows to support multiple TZ implementation backends like QTEE
> > based SCM PAS service, OP-TEE based PAS service and any further future TZ
> > backend service.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/Kconfig             |  1 +
> >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
> >  3 files changed, 9 insertions(+), 7 deletions(-)
> > 
> 
> Can I get an ack from you on this change? I expect this complete
> patch-set to land via Qcom SoC tree.
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

