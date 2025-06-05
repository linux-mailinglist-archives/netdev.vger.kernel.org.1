Return-Path: <netdev+bounces-195181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40767ACEBC2
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 10:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786281896F78
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 08:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33551204F8C;
	Thu,  5 Jun 2025 08:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="esmUzvm3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1DB202C45
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111906; cv=none; b=NhDwkhkGGeQfn7FmCejxQ9XWZo2SKdhWzdlHwhbG8KxOrWFw3nIguO6MkIyrjcVTs7r8GUPapGbhLfAdHTpnlDCIoedm/tVXA8AMmG+swSSRNlJe1sLClasvi2pL7iVkF4OoEXYrOGXe97u2tQE0LDMe9KYGVPOx3bp+RnFgMQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111906; c=relaxed/simple;
	bh=xZaBeZfytCrJKOrjxBjzXhmtknBq7xCcBctElbMsMBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mibS1Je1IC6wjFdhvhtkKeETHYH6AB0pHS7NXfs0etEgsgvJJoD2fYRvjuur8G0bXA7SUP64bF8dxVXAE9A/3cFp3M05Op/LwqEt9x7/z6TsSFEUP6S3GusthMXJJKOnP0c5jNzZjwvlfugETCClFrlr3l7vF2QHXY1uHO/DzLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=esmUzvm3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554JZ96s013814
	for <netdev@vger.kernel.org>; Thu, 5 Jun 2025 08:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UtqcVj6Ok3Dj6NeRpJglAQeZgn6trv34Ds7Go5yrpew=; b=esmUzvm3cW8H23iF
	rVcEDPGn6EbXYZArK0XDbOxU4YfnOkb4uRSWRZB31Pd0Fqs7eY+W8x3hf/HuB8EY
	XZkF83spB64HgrCeV7RN3tH74FuPPxsPMZTWM92FmxfCr8wnhIius+VXM1sBn2y4
	K69otmMDrJpc41dOJHQLoHGxZmFLeC2PHc7nvP/x+8V98jm2lE+rO1NtivJgSm08
	Ja2V50M7QgtvZOYjiw81JaaNKHW/Kq6M2jM4nNGp3wcSV2g3lCTvnnDte2Vf8t1J
	DFId6dEvTCq/41xJCwJZa2oK7QvI7h7gRojzmKtJPdqylamXZXMoiegzh9SaxN+a
	b/erxQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8t0km8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 08:25:03 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6f50edda19eso11259426d6.1
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 01:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749111898; x=1749716698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtqcVj6Ok3Dj6NeRpJglAQeZgn6trv34Ds7Go5yrpew=;
        b=I/Up1Pp5dFSzII5XNHM7G0t6lCYGDEKxGnzPf/AD22TQs2zorZsOMgTtiJfQH0Nwnl
         +Kw7V6Zg3C2R946Nr2D5JRJYURyXI6SIhqONhxMFOzlN6AA9F/UFMbhSZmhQvGmd0nSs
         htGSafkrz3GL9SUhOu8GBr+EebGHAA5c0+cixSuU+vGbyqNrffoDY2ZZPziHmbbajhNp
         RYlNqcOqp4THMp+qJHWljEVXlA5nSw25pSE/Ds+AigS+e/UFubwfBfRBvGLUzmpR4h/z
         w08y2ncxvsvlAFuGcw7I8DgcTV6Q5yxy1Af4FOgDoKZMWzCaQqARbQKGE8sLTsrXoKaZ
         SQbA==
X-Forwarded-Encrypted: i=1; AJvYcCUgiZd/Q+AAjOi3gO/nHHcs1COG25OAmSOVNAkVfiUh2+lvTDKKCupakhNn4Ulu4xFmFyOdRvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq7Ee8Y9PJSBorlLBfuOT1rIoZoqDFMtCbukdFUig4KcfW3x/2
	q5FF69YqzO5dO4txnR0Ekvr8Rt26vSPYxmBhBYC+M+oGmaSQ7myDw5uRy5meU2fkFQRxIuU11ee
	oS6sirHSL2Cr30JCoDXY/IkKy2LmLrGbEiwesLwZU98cwkMr7XbC41j/tmnaXybblvDKgwPaDqi
	s87lxuBmNoEyWHgmEJbDKE8ZHQudtPU8QKgg==
X-Gm-Gg: ASbGncvfKfe1cW+S16yg3v4uCmwoxvLQy9elIIKBLts0DIONyNUYNmU41huc/C6Dop+
	9lI0m3hJrkXXRGGLZH7UG2I12Tc1ovvaxDkgK7vVtyiXomHtV6Bx/0uazgHqI7uGd7Rf9SQ==
X-Received: by 2002:ad4:5ecd:0:b0:6fa:cdc9:8b02 with SMTP id 6a1803df08f44-6faf6f9e8f2mr86670326d6.16.1749111897904;
        Thu, 05 Jun 2025 01:24:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwCWJddjYrv66EpklTX8+EcEihxS3i6p2Y/uBi1wSP3SPDwA7FauNdbdHLl/D99kI5j790nOP61NBUmgl1UqE=
X-Received: by 2002:ad4:5ecd:0:b0:6fa:cdc9:8b02 with SMTP id
 6a1803df08f44-6faf6f9e8f2mr86670066d6.16.1749111897530; Thu, 05 Jun 2025
 01:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604-qrtr_mhi_auto-v2-1-a143433ddaad@oss.qualcomm.com>
In-Reply-To: <20250604-qrtr_mhi_auto-v2-1-a143433ddaad@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 5 Jun 2025 10:24:46 +0200
X-Gm-Features: AX0GCFu6xWPgyNFI69TOSuHK6IF_kGY0Cv_eMSlpv6YDKdLvYpYbd911sy_xsb8
Message-ID: <CAFEp6-1h01SScjbv_m8rU9DxhEgAFOBT_7U2mQegFZQq_O0y4A@mail.gmail.com>
Subject: Re: [PATCH v2] net: qrtr: mhi: synchronize qrtr and mhi preparation
To: Chris Lew <chris.lew@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Hemant Kumar <quic_hemantk@quicinc.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=RMizH5i+ c=1 sm=1 tr=0 ts=6841545f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8 a=EUspDBNiAAAA:8 a=us5iPAVF1rjgtYe1CekA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=xwnAI6pc5liRhupp6brZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA3MyBTYWx0ZWRfX6pRw9yuyiajJ
 kN5SXOZDsRj3nhrQmuyGhaSIK70+5ZR5QgBoMVPhhcw+rGcPQY+48YwtlWqn+xLAk1db7QTsUmN
 BNQILBarlC61+kvak24z6IA5nghNJqDuX7+r6lDQf6eF7UOCV4EkmrRsVA0lP4/U9E0YZcAu2bT
 S18I/YFmGxpgnX+0B4/hv8O/YBvJ6kfXlQtpsl9SVYU6foYUwZNySXSqirKx27AqOLyxLySp+C9
 mlO2lUpQMNbdQn7FGm15oSCtVeY1E5vJdh29Fs5WliaQJaZTcj7VyI0bWnwcuSNm4dN9+oGM7I/
 aYe9CIhW0uXEPIkFwg2ueD96SRNLEFRs0qyB84I428Wa8PERDwpM4/AAElz2je3pht4i+gxqj5E
 Oo8E/xo4f5SOKmAvbPkPkCmX5khostqv2aoParxgCyldz6DaMEipcpEB95/dUY7XEtBmiqHc
X-Proofpoint-GUID: YAvMa8s4r6syd8tjP6LqSlAMFCA5tnNn
X-Proofpoint-ORIG-GUID: YAvMa8s4r6syd8tjP6LqSlAMFCA5tnNn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050073

On Wed, Jun 4, 2025 at 11:05=E2=80=AFPM Chris Lew <chris.lew@oss.qualcomm.c=
om> wrote:
>
> The call to qrtr_endpoint_register() was moved before
> mhi_prepare_for_transfer_autoqueue() to prevent a case where a dl
> callback can occur before the qrtr endpoint is registered.
>
> Now the reverse can happen where qrtr will try to send a packet
> before the channels are prepared. The correct sequence needs to be
> prepare the mhi channel, register the qrtr endpoint, queue buffers for
> receiving dl transfers.
>
> Since qrtr will not use mhi_prepare_for_transfer_autoqueue(), qrtr must
> do the buffer management and requeue the buffers in the dl_callback.
> Sizing of the buffers will be inherited from the mhi controller
> settings.
>
> Fixes: 68a838b84eff ("net: qrtr: start MHI channel after endpoit creation=
")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/ZyTtVdkCCES0lkl4@hovoldcons=
ulting.com/
> Signed-off-by: Chris Lew <chris.lew@oss.qualcomm.com>
> ---
>  net/qrtr/mhi.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 5 deletions(-)
>
> diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
> index 69f53625a049..5e7476afb6b4 100644
> --- a/net/qrtr/mhi.c
> +++ b/net/qrtr/mhi.c
> @@ -15,6 +15,8 @@ struct qrtr_mhi_dev {
>         struct qrtr_endpoint ep;
>         struct mhi_device *mhi_dev;
>         struct device *dev;
> +
> +       size_t dl_buf_len;
>  };
>
>  /* From MHI to QRTR */
> @@ -24,13 +26,22 @@ static void qcom_mhi_qrtr_dl_callback(struct mhi_devi=
ce *mhi_dev,
>         struct qrtr_mhi_dev *qdev =3D dev_get_drvdata(&mhi_dev->dev);
>         int rc;
>
> -       if (!qdev || mhi_res->transaction_status)
> +       if (!qdev)
> +               return;
> +
> +       if (mhi_res->transaction_status =3D=3D -ENOTCONN) {
> +               devm_kfree(qdev->dev, mhi_res->buf_addr);
> +               return;
> +       } else if (mhi_res->transaction_status) {
>                 return;
> +       }
>
>         rc =3D qrtr_endpoint_post(&qdev->ep, mhi_res->buf_addr,
>                                 mhi_res->bytes_xferd);
>         if (rc =3D=3D -EINVAL)
>                 dev_err(qdev->dev, "invalid ipcrouter packet\n");
> +
> +       rc =3D mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, mhi_res->buf_addr,=
 qdev->dl_buf_len, MHI_EOT);
>  }
>
>  /* From QRTR to MHI */
> @@ -72,6 +83,30 @@ static int qcom_mhi_qrtr_send(struct qrtr_endpoint *ep=
, struct sk_buff *skb)
>         return rc;
>  }
>
> +static int qrtr_mhi_queue_rx(struct qrtr_mhi_dev *qdev)
> +{
> +       struct mhi_device *mhi_dev =3D qdev->mhi_dev;
> +       struct mhi_controller *mhi_cntrl =3D mhi_dev->mhi_cntrl;
> +       int rc =3D 0;
> +       int nr_el;
> +
> +       qdev->dl_buf_len =3D mhi_cntrl->buffer_len;
> +       nr_el =3D mhi_get_free_desc_count(mhi_dev, DMA_FROM_DEVICE);
> +       while (nr_el--) {
> +               void *buf;
> +
> +               buf =3D devm_kzalloc(qdev->dev, qdev->dl_buf_len, GFP_KER=
NEL);
> +               if (!buf) {
> +                       rc =3D -ENOMEM;
> +                       break;
> +               }
> +               rc =3D mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, buf, qdev-=
>dl_buf_len, MHI_EOT);
> +               if (rc)
> +                       break;
> +       }
> +       return rc;
> +}
> +
>  static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
>                                const struct mhi_device_id *id)
>  {
> @@ -87,17 +122,24 @@ static int qcom_mhi_qrtr_probe(struct mhi_device *mh=
i_dev,
>         qdev->ep.xmit =3D qcom_mhi_qrtr_send;
>
>         dev_set_drvdata(&mhi_dev->dev, qdev);
> -       rc =3D qrtr_endpoint_register(&qdev->ep, QRTR_EP_NID_AUTO);
> +
> +       /* start channels */
> +       rc =3D mhi_prepare_for_transfer(mhi_dev);
>         if (rc)
>                 return rc;
>
> -       /* start channels */
> -       rc =3D mhi_prepare_for_transfer_autoqueue(mhi_dev);

The autoqueue has been introduced to simplify drivers, but if it
becomes unused, should we simply remove that interface from MHI? Or
improve it with a autoqueue_prepare() and autoqueue_start()?

Regards,
Loic

