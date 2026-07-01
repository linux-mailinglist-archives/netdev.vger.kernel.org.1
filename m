Return-Path: <netdev+bounces-303700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FIRDA5YlRWoy7woAu9opvQ
	(envelope-from <netdev+bounces-303700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:35:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B946EECE7
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:35:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="Te3dOX/o";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Kl5AH9gA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303700-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303700-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDF4B30CBE78
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 14:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F742343893;
	Wed,  1 Jul 2026 14:27:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5D34252B
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 14:27:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916047; cv=pass; b=gPqry/e7D+Qsr5pAGs9MPP+LxJgWZZix3hNIhNp/FhRJacPmoJQM1HmipNTkvUN1Cgaz6DvJtDRb/KLLcFvHnAuZ+OzlHtO7v49SdHngmfX5E7uAPkn/ErMeTLUZ0pFHoQBjTAqZMtHcjj6XxjdN5c37kstu8OLcS9BjJbtOjPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916047; c=relaxed/simple;
	bh=o5hJ4zjdUnOfv1QaEjf+KgFzHDm/5IZUg+OW0f16z/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPCayhEmdJBHq9Hm9zn73GF4lLAGXuKTkFZDCH/lJyGKpomM6uvQ+/6UMZZ1EEp0h0v/ENWwZIW4+NxJG+8NA3ZjtJNlXI17XkGyzs5pS+xpztBB/OioEkAVdf6/CjjlZWZcSdjvrP2PSF9NB5dwnPhgqX+h5S8RAYcdDSxW9/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Te3dOX/o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kl5AH9gA; arc=pass smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8XYW673206
	for <netdev@vger.kernel.org>; Wed, 1 Jul 2026 14:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	slNfsSPq+LKvZAWAAOKAp2yofr1taXH3S3WyXQ27TPE=; b=Te3dOX/oMm1dsiSh
	NMdFy2Wpu3MOA63ZucRuVwxcW+Nz7k9jDJhweSvRVVAP5QWCY+0AYmgxnV95hlJA
	W4LoxGz+hblSca0DMxszJKqB5mZ2JkPjhi+Oa3plAjM54WeaNR6Mu0WI9LjQACDc
	7v7bIWwjNhfTK/7vtsCevwB+TldVs0rK3QjSyzHKuvJ+afwTFlC1uQtqY9R87r14
	gK2H+Xm+7fa4yJ2XsTVU3yG/WkYwvhKkR5rUch9RgKJYlPZlFeba9JVTPJWl+hDL
	fu0Px8Qe5RvibYZ7pqCNqi50pTzCeRajeo66W2yVfs5zoLYtN08YGyLKG4JDlGm8
	sHu3mQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f502usa24-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 14:27:25 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e55f0613cso74303085a.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 07:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782916044; cv=none;
        d=google.com; s=arc-20260327;
        b=YrKlN0IZTtBrEPjPoEFAuDeaEXzbEVhflr1GpYbYEFFHT9K8hMTjNN5JpaGZ2rKxaC
         pfvqH0luCzXYSw4hCkexI4IvxZvrUPpH5MjLeg//t81gIEDx7idn1BoFO4pvSa0X6Es/
         bMwWBDECE24mngOUqyrWW1sKHj2Rxo6XzcQihnn1RexYLXIM50jq7J9a0y/pgCYQ1xee
         47CHqsbFUBRnaD4XgUaOAYKedBIFlOCcyzmLH2ACkLpjntJkb5UFrIK83/oC4wvWv30E
         yNFl/KGcCt+/1NtzvbQ+L7ua1ZfNDLtXKDlGMc4Bwbw5psERFgJlrtHbT92ihP98dBhB
         rAww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=slNfsSPq+LKvZAWAAOKAp2yofr1taXH3S3WyXQ27TPE=;
        fh=D6bpNmAb60oljDIT2+OVbQQaVoM4KNho82SuzmVk96c=;
        b=m1DXH9KH49/Nj9h9zrFaUw0yoAqOALApnAgmx2BZg8iCtFlTvzHK5qWZ0FJwNHAlMm
         7DDNdmdNTHaqB5NRqQXOOiFtRSc/UknOAGgcEyRRZ1KeC/Ds7eiPkEXok1uRAb14J6sb
         BQ4vHWvCvZ1j03Z1M6eOv++WWedlweWlKqHxH4mdnX9YjYQvLddRT87yt4Cth7H13gKx
         CdHf2PDnYRCY1WOT0D/7CQFz1zeVq1YwscVN76Qfgs12jhSpPoMASYqSeLBDNEFqqUIZ
         plNdTsRrOa/zCkdLN5fgE1ImP49RvDBwR3P2p4dkVzxlNlPwRpvSX3v6S/xiPSBkYrLp
         HhVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782916044; x=1783520844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slNfsSPq+LKvZAWAAOKAp2yofr1taXH3S3WyXQ27TPE=;
        b=Kl5AH9gANTalDVZar4+xp3tmV8gIEl6SHvFMJ21yCsnCg/UdDIvq9mxkuW2DwDr0H1
         XDHsdmbGrb1D8rSJMIENwwiRyrjlvV/eoPzHWqM8HjvMqrMHfOgV+34vnN5XOkufTTxK
         tVndNGKl/E6AG1s5BjzkS4USEIHyUv3QE4/KxXjouk/tYiaaXzMDGhCJfY6tEUUKLRzb
         odOQ3/fFAZ+IgG0qNBJD7QILLaPVzNmCNZmBcXuhn3iTEManGk/sEj9oLRP7GIRuoRV8
         9rIwrUB5IIeHLTBqBu/V+ekjEmsBBXzl7fJepu/Brqi25yhdJW/l5FPrHXPVwECgWx0U
         rXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782916044; x=1783520844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=slNfsSPq+LKvZAWAAOKAp2yofr1taXH3S3WyXQ27TPE=;
        b=JzOZudfIPiMUesXeSEcXiLaOs1WEh2SrnZ15A0VON9FuKnkKDAHl5FnaXfqBZJ/XGL
         aWS9WpANiGyJ3YFiGgl4PtLMApSHCsHG4xdS28gvG2OmfhiT1dTzzX23q+CT3Ym0NOb5
         7+G+aJHRRdPYSxyBQpqm54Ckjjz3x4+io5fUfUnxHpJkD+E+DleIouuPiFDAjH2dK3hO
         DA0FA8FGPYI1UQgwbOeukIR82a1b8yL1MfNJuiEVk8BR4OCgXTY4AZhxIioZo1hYs5Au
         BetWKfTgukIlVNGGGen29dQxGWC5K4I5XzU9H0gzdfcMkLNOAJJUn3y2FnwK/xM91ef3
         Cn5w==
X-Forwarded-Encrypted: i=1; AFNElJ8ONlW4ZYNL6VRLwk8ioqTYsvcA4uFxnM4xOl4YVyh0/bK+YvzBIQOghynKShB95X4SflEXBV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP+RUKLxjwBJQnDlLWGt8VhSDGrdulp2yyewJ+qJBy+AIKWI+z
	TnOxauH+fvjR6HK9Uk1kVZOoav33RQrfYNMp/+gddlycJPybJ94oxJzzZrvHZEAgTAigON8w5FH
	w9+iNtDWH718SCnKnRXy8YqeU9oCo6lLnjxnDArIHU+O7ZMuRLabrBNBuE59bRJqgih+jNKQpH+
	YKenTKcU1TQl85rXMzZzcgQDYBXrTu+tJywFpmylvruWAkCNA70g==
X-Gm-Gg: AfdE7cnY5ybQxzxprRdvg9iML7u5bZpIaI31o1LbfKizS+Po2wik6ZXDbFy9bY2fMtl
	QFhUrSafVyJgUDL2cRtdB4fD3D6IihSp81d1elRQPqT/1Sb72q96Gmx00FPm1uGyWfBj89AC/Az
	l/hikTlLNxgtNdEpMII9TGBH9rteIhSvf4+pfxiV5YZmywV3ih6A9l+29PpN23+2sT2RsVsbeOk
	T5mvcgDisqiEo++qh6d1ZQtMDO+FDFmqe2fUd3XN+O1nh5O6B4w2DQuH+phXO+4oUFidBivDwtj
	gC1bsFdzog==
X-Received: by 2002:a05:620a:4711:b0:92a:dcf5:ba5b with SMTP id af79cd13be357-92e781d35e8mr268236985a.14.1782916044217;
        Wed, 01 Jul 2026 07:27:24 -0700 (PDT)
X-Received: by 2002:a05:620a:4711:b0:92a:dcf5:ba5b with SMTP id
 af79cd13be357-92e781d35e8mr268229085a.14.1782916043639; Wed, 01 Jul 2026
 07:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701095344.309409-1-zwq2226404116@163.com>
In-Reply-To: <20260701095344.309409-1-zwq2226404116@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 16:27:12 +0200
X-Gm-Features: AVVi8CefzM1LituZvWyAk0MJEQ4HiP0taqRwbGukgdhVHhBq-uNWIgfCAUrAGm4
Message-ID: <CAFEp6-2ZPRbakA7wVHnaqMXgPnEL2BQ_gAEQC-2mH_=rOjHY1g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] bus: mhi: pci_generic: fix Rolling Wireless
 RW135R-GL and RW151 support
To: zwq2226404116@163.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        mani@kernel.org, ryazanov.s.a@gmail.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, kuba@kernel.org,
        Wanquan Zhong <wanquan.zhong@fibocom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE1MSBTYWx0ZWRfX4li4qiS1TSXL
 2nIophM5tQJHgPDZ17kLz51N2+pw9P8yFP91waF4gI86cbIjopFG0CEUr21XSJhSZZFE3KBHyWl
 qJRfogBVwaFnqMLWDRnLqy8986QbIgg=
X-Proofpoint-GUID: ohudgi7p6oE2-FBQEWT15vhHbVZLFvNz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE1MSBTYWx0ZWRfX17RZnNitK3Ks
 LLApmjiQ8j2Qki5uir7tWz0NrvNGNTmXV2uGrmyx93kjOA9ASui8oONNzihTvQhasxF/JJ8Bd6t
 rkk4J1gH2E2XYzfkSWDJVeuZSIcuGVMTMojGIxCmnDgUt2LVKLR/OcQHQBHmpJ4LuilECAsUXAW
 yKnsaSdoIxAiTXKlMSXkOj6MtX/5oqMx9/JNoEyvGgYMxJRksnDK4E+xKPUj7Elql/sfFbtxboU
 pFkYR1IuoS+vfUgb4HeNBPZULMsro/QNhsntbonwYdYjqRO9Lp7dt4T0NhWkCCfzOjufsfbKQPI
 EaZ4aS6G81FFg5+z0OoPhy6i48je4q5QQZN2cAq14qRusEcE/RMrB+gRj8XC7Aqrr8vYvnNyuy2
 HYUzKYcKlWJYtY71BFqJWeFtbACvKmaWFSFrWQnrsbhfZFzSP9Gy7Q2QYDlqNeNdUlk/OjFbPtt
 uwA753/cQ4ChiHCqDFA==
X-Proofpoint-ORIG-GUID: ohudgi7p6oE2-FBQEWT15vhHbVZLFvNz
X-Authority-Analysis: v=2.4 cv=PbLPQChd c=1 sm=1 tr=0 ts=6a4523cd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=Byx-y9mGAAAA:8 a=6GUwiT5CAAAA:8
 a=nWUtx5Q0ph_BRYhHASsA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=tp1klI1xYmtLYojU9LVd:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010151
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
	TAGGED_FROM(0.00)[bounces-303700-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zwq2226404116@163.com,m:mhi@lists.linux.dev,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:mani@kernel.org,m:ryazanov.s.a@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:kuba@kernel.org,m:wanquan.zhong@fibocom.com,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[163.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,kernel.org,gmail.com,lunn.ch,davemloft.net,fibocom.com];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,vger.kernel.org:from_smtp,mail.gmail.com:mid,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78B946EECE7

On Wed, Jul 1, 2026 at 11:54=E2=80=AFAM <zwq2226404116@163.com> wrote:
>
> From: Wanquan Zhong <wanquan.zhong@fibocom.com>
>
> bus: mhi: pci_generic: fix Rolling Wireless RW135R-GL and RW151 support
>
> - Increase RW151 MBIM channel ring size from 4 to 32

Why? What is the problem today? If they don=E2=80=99t address the same issu=
e,
they should be split into two separate patches.

>
> On HP and Lenovo laptop platforms the device probes successfully and
> WWAN ports are created, but pci_generic enables runtime autosuspend
> (PCI D3hot/M3) after a short idle period. Resume from runtime PM leaves
> the modem in MHI SYS ERROR; driver recovery (reset) fails and the device
> becomes inaccessible (PCIe config space reads as 0x7f). The failure is no=
t
> self-recoverable while runtime PM remains enabled; keeping power/control=
=3Don
> avoids the issue.
>
> Set no_m3 on RW135R-GL and RW151 so probe does not enable runtime M3
> autosuspend for these modules.
>
> Power management testing (separate from runtime PM above):
> - Suspend-to-RAM (S3/mem): tested on RW135R-GL and RW151; MHI/MBIM/wwan
>   function after wake.
> - Suspend-to-disk (hibernate): not available on the test platforms
>   (/sys/power/state lacks "disk", ENODEV).
>
> Signed-off-by: Wanquan Zhong <wanquan.zhong@fibocom.com>
>
> ---
> v2 -> v3: RW151 MBIM ring size 32; disable runtime M3 (no_m3)
>  drivers/bus/mhi/host/pci_generic.c | 4 +++-
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pc=
i_generic.c
> index d598bb3b3981..d0fee7e3ba3a 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -942,6 +942,7 @@ static const struct mhi_pci_dev_info mhi_rolling_rw13=
5r_info =3D {
>         .bar_num =3D MHI_PCI_DEFAULT_BAR_NUM,
>         .dma_data_width =3D 32,
>         .sideband_wake =3D false,
> +       .no_m3 =3D true,
>         .mru_default =3D 32768,
>         .edl_trigger =3D true,
>  };
> @@ -949,8 +950,8 @@ static const struct mhi_pci_dev_info mhi_rolling_rw13=
5r_info =3D {
>  static const struct mhi_channel_config mhi_rolling_rw151_channels[] =3D =
{
>         MHI_CHANNEL_CONFIG_UL(4, "DIAG", 16, 1),
>         MHI_CHANNEL_CONFIG_DL(5, "DIAG", 16, 1),
> -       MHI_CHANNEL_CONFIG_UL(12, "MBIM", 4, 0),
> -       MHI_CHANNEL_CONFIG_DL(13, "MBIM", 4, 0),
> +       MHI_CHANNEL_CONFIG_UL(12, "MBIM", 32, 0),
> +       MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
>         MHI_CHANNEL_CONFIG_UL(14, "NMEA", 32, 0),
>         MHI_CHANNEL_CONFIG_DL(15, "NMEA", 32, 0),
>         MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
> @@ -986,6 +987,7 @@ static const struct mhi_pci_dev_info mhi_rolling_rw15=
1_info =3D {
>         .bar_num =3D MHI_PCI_DEFAULT_BAR_NUM,
>         .dma_data_width =3D 32,
>         .sideband_wake =3D false,
> +       .no_m3 =3D true,
>         .mru_default =3D 32768,
>         .edl_trigger =3D true,
>  };
>
> --
> 2.50.0
>

