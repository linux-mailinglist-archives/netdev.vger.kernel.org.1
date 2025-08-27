Return-Path: <netdev+bounces-217288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6FBB383A7
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D70DB7A4853
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AC7346A1D;
	Wed, 27 Aug 2025 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aUmw3tX9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2767C298CC7
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301245; cv=none; b=pbe7aykpUfrieIbiZhU+8g+8WWA4PL3ZdvSEYjhzjCeweilQR6SoeSBcb9KA3ce12dzk8vMxeJqta5TLyaXLoatKoJspFznJWH/aJ+SA6JjZJN0rc0PUGO2TzINwHwXw65aLWnrlILnHctruy2THKTy41ODbB8B+nhcuZx9XQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301245; c=relaxed/simple;
	bh=3lKOrjefgxkmUKwLi1C9rB33yAcCifL0LQZhPHbPOOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ki/Nu4FfDJu2rirMdpjHhFvFGkLFxn1PEvysYi0X11ECdiZhCVkxAOpip0/ckQQOzs+3oRI14uTZkcaR9qWhszRMHQMr3xrBvJtFbXZWN88ID2sEibtSTKoWualeawpJGvO1hajG1brvpHr+7kfjWyePTOJXlhUajpzO8kEW0ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aUmw3tX9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R6kGuJ008283
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 13:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SJVYYjYdxfF4p3sCNzv7moDWVy1fEvP4+O85me4AGX8=; b=aUmw3tX98ouaWrNP
	c7cRcUvLJ/uaKbTmFly+SR6LyDANGw9appliTsxXUvGCHlOQLAmRjGciqGnHrfIU
	/AsQZ7IOZRFww/JQQtS26oTU4t9ZYR/tYgOBGVCeGsNPYDU2JMWsmgM+jnEaMAl/
	4v9bKwvSSSzFEbsoGH6oi9OAEhgB1Rxzw8sOUI2VRQYVBY+iTGeFqfWJRJ0r53TA
	fiZvhbhhg7JB4UENGWF5SVB/7UvNUPW44T7+GSpy7QX4RlSJIaf70FH9owwjicGr
	CvVJLLLpFt2jXzbOsEbkfNY/icvceTtYqWgzxaLKwIRw/LpYfeF8VXTOYikXmu9b
	ZBMjOQ==
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48sh8ajyth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 13:27:23 +0000 (GMT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ec58544f79so95897175ab.1
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 06:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756301242; x=1756906042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJVYYjYdxfF4p3sCNzv7moDWVy1fEvP4+O85me4AGX8=;
        b=YyWzpiC5GASroxzXJFFdwuNDm+piX236LORyIswmLJM+3n8vqKlh6lTi3BfFyLExJv
         V4Pa4MYtky7DMyIJOe85mLyQpNAr2IJQatjU3mriHOt6jkqi8cP9Ti2jKhGfwu7f7sHM
         84K1h8WSHZ3QgRoXUDhtC7P6SKnd0IllwgTEXPkiCfa8liU819rCqDBEVh2lD+d7Py5g
         vunjZWFLx4JZfybeHnUE6Skc5VVU5awnkFRWM7mVTNBjUJO2tpjLssvgzK2JRZhLxqnt
         ss6LtUjoy1R2ZBM/iYHnfXGF8ZJ2FlHjWeUiqTXxtv5NDakSusKUQ3MzuL6GrJjFMbnf
         UFew==
X-Forwarded-Encrypted: i=1; AJvYcCUyGb39+7ONad2N8pn/zI9DG6RWLNjyajnmRLsNm29bd9FCj0Mb55l/H2cUlv03bDjLJUMXYKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxgqpAftU1uACsBhQHxDtlirlzuC2h0hT/1q4cwJzxiVgh3ehy
	go7tMsIuoGzmhm6N5OIKWra8gWyJ0sLMEOQ8LZnQxHYwj0AXwktgvblhX74VKyG4yxSvT2iYrDn
	wBfc1l6N8uyHCKZ2y+n+G1ReC1T96/K3gbQm0yTQt4K+gNYfrqld6plr7CA6in261Cpv6hlw6OC
	FRXcIcF48ph4nvpahUaatGkAa7uDM3VvhB+Q==
X-Gm-Gg: ASbGncvpvPHhmmB9695p21gE8jx+ajrNfSPtYLzpzdL+Vp+vjroSYTwKuWx8Qo2HooF
	TNKXNs6c1GOPsm/S4V7kQQXKLDWsZq/7PJfXajN9iObiOerCDFl7tZnAr7KNm//XQAawA3J0na8
	oohuKx38QT++oeBUDe4GkhJQ==
X-Received: by 2002:a92:c24c:0:b0:3ee:931d:8272 with SMTP id e9e14a558f8ab-3ee931d85d9mr86187875ab.27.1756301242106;
        Wed, 27 Aug 2025 06:27:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXGPWw2hCMcJeQwiV5IoCHGM6jK6hrlxrHOgdWVoa9qCoqe01JmjR/TC3MdI8BwFgEeEyrV49mBsxLH9bfitc=
X-Received: by 2002:a92:c24c:0:b0:3ee:931d:8272 with SMTP id
 e9e14a558f8ab-3ee931d85d9mr86187435ab.27.1756301241703; Wed, 27 Aug 2025
 06:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826135021.510767-1-rongqianfeng@vivo.com>
In-Reply-To: <20250826135021.510767-1-rongqianfeng@vivo.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 27 Aug 2025 15:27:09 +0200
X-Gm-Features: Ac12FXzb8MeF3YNH5KT8aiAXaNlyGCJ0i6W5AAkJ9v519Ak-1GpAJyjOi3X6R4k
Message-ID: <CAFEp6-0J8e1rQbAwEE-E=LzhLyV5x10bhQE6EDwSvL=gz5S9JA@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: iosm: use int type to store negative error codes
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=cLDgskeN c=1 sm=1 tr=0 ts=68af07bb cx=c_pps
 a=knIvlqb+BQeIC/0qDTJ88A==:117 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10
 a=1WtWmnkvAAAA:8 a=EUspDBNiAAAA:8 a=_vuNJv8LpkyJlonoWToA:9 a=QEXdDO2ut3YA:10
 a=8vIIu0IPYQVSORyX1RVL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE1MyBTYWx0ZWRfX46DZUdFD8Koa
 zOYwNnztrHlALVIrnpHtUFC2cjO15JYJAOAmIJ8vMQsHJvJ8xlNQlBexH+D/zUyQF/xvYiUpDBU
 YjeKHGStMNZiQxUdzBzcrIXf7tbGfdYpzEdQW/WXliiR9T/SZNMNRt26WCa3czIiyVIC0gdgkBK
 lcN/yoiTQOt0hJtjHL4eHwQlIrhRzCYhOM/Y5PTx4m0Das7KL8ATx2z8pN+p5V8ua4FsjKREIHJ
 SGCNWTL/xutEyMavmkbmh6fkImGN36SsMYUNwE1cJxX8nx1Q9ZNp1jl+t7yEH8xoOWocWWnzuov
 VVahT1IP9kP9TZdk+YEdA8FWpgEo6yK/0XGTDzmBFpXiwvRsfneHTov43NrmARShcCXhqy7zoXC
 TNPtrdOJ
X-Proofpoint-GUID: exiH1Nq45SEmfR5Awge0LiVy-OubvrAe
X-Proofpoint-ORIG-GUID: exiH1Nq45SEmfR5Awge0LiVy-OubvrAe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260153

On Tue, Aug 26, 2025 at 3:50=E2=80=AFPM Qianfeng Rong <rongqianfeng@vivo.co=
m> wrote:
>
> The 'ret' variable in ipc_pcie_resources_request() either stores '-EBUSY'
> directly or holds returns from pci_request_regions() and ipc_acquire_irq(=
).
> Storing negative error codes in u32 causes no runtime issues but is
> stylistically inconsistent and very ugly.  Change 'ret' from u32 to int
> type - this has no runtime impact.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

>  drivers/net/wwan/iosm/iosm_ipc_pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/ios=
m/iosm_ipc_pcie.c
> index a066977af0be..08ff0d6ccfab 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> @@ -69,7 +69,7 @@ static int ipc_pcie_resources_request(struct iosm_pcie =
*ipc_pcie)
>  {
>         struct pci_dev *pci =3D ipc_pcie->pci;
>         u32 cap =3D 0;
> -       u32 ret;
> +       int ret;
>
>         /* Reserved PCI I/O and memory resources.
>          * Mark all PCI regions associated with PCI device pci as
> --
> 2.34.1
>

