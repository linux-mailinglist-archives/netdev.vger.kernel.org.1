Return-Path: <netdev+bounces-198345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F95ADBDD0
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017641760E7
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCD12264CA;
	Mon, 16 Jun 2025 23:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OGQymbvs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953EF1DC98B
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750117650; cv=none; b=WBvqEiRRgK8zbEVI2z4bEuFYs2ySHuUtEKoDkwQrPKU0VR+LMw9D+6DY58dhKmFk9lmxTNt1lnhYcdGvEuWzlQgUJXYVKYUoY2UBYeGhAXEF/o3ggWK/xsTAuLV8zDA4KpSGHMI44NZLtAJ/aaTHBJrPNtLOsG1QrrkH14qZuUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750117650; c=relaxed/simple;
	bh=w/O4phhiloAoAk8UIdYjwviImCzP2bgbOkCI90TqAsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3Dh5YjOQIOeqNYD80I3/ZUe2gNI4VCjYqtR36H4uPP2RJEGvLHT4Xlv1i1b5XHcOm1eTvSwRCrfM7O50T9p91j/wpK0tpf8Sjt+V2tj/w8bch2GAancBKaOCOooVjG8WiLoGg4swzdRzcC9j4KeWUdRNvbrPGzcGG7FXG89kFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OGQymbvs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GHB8ga003184
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wREK7s7vLW9O6OL1o6MmjXSA1GqZpuZGsiS/DxVnVJo=; b=OGQymbvsi4SOEud5
	UkXL+6AvyErqlpJmpqIYFcO+KkkUGx0Oy0v7WgE3opcqzkGasKT2p7a0/R6PYjkN
	9UuGgHDnv/8PXnGuOvuzo6ZJrwdsg3l51uhAVtQgLZWXQA/paicnNGBHNp2SvOMJ
	2yF3uZOJBf+sDW6EtTisD+GvMpVKjx5orUZ9304V/nBbGSSBFVNSoNchS/D/jzIx
	k23BRJWSJBVp8PhG8VqO1VDeSeg82svy1Jkday7dj5GDky0pNrqW32giuCFQTFL4
	8csHbTUrtDlKAQSF+q4DW2GJgAvrqFDm7Bj574wb0usQXODhdJ6CMTtyjgg0pvkf
	WQ/7LQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ag232bts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:47:27 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3132e7266d3so5187170a91.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750117646; x=1750722446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wREK7s7vLW9O6OL1o6MmjXSA1GqZpuZGsiS/DxVnVJo=;
        b=Y5DL1J0gFhRaZce0ZhcRTiK22t4lf6WbIBXTSJGlhLfOLC9ervwnLRO5LWaYnLnYnJ
         Vdal3D/8vSVkZQ+RCM5hVVBoU59vo0D20+3JnLjl3p5IZqBgx0W4Ssv/g7Smrvhuw39e
         LQx7AZ3D6u/ftLXwaQY2MwiXfJYNnQdV++UowcBINVIo69tQ1kxi0uorXP+7NLNvwfOA
         5LxdpsQ+CnfqzoEVpuc5kZVeGLr2yPHLPCl+tQhi2inEaESh3cR4YezQ7iMKYpRdTP7f
         w2XNexFu9+bGUqBg840I+UeZJcEL1Tlv7M9NeSoXlURZ3jH2JCRRMzspeRD6cGrZOGVM
         6PsA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+p7qdGGqc5qyNN5bHHzTfH+hg27xflY1mThSAlTzKSRfPmJNby5ccsAxN5QqGUsihJvWcVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypZ526ppLwG93a0VLJr4sks3sUvIQCUmHGIwxWxODiLmiN9Fwj
	ijhfaS6tdAcRJq2jMmMgg/aiLcGayNeqe6vUhrE9z6uCIsiBTmjv1urOr7WsbxP/tCFvkM3Kn/e
	J8arK8OnT48yhtBBLxvYbZ/u86SAJvEgoQukp1qe98sUsOkDD5Groe3W1MmzVxxvvzA3LyGglz7
	QzsRaNezxuDerNNQqo8dX5pM28cB+v0TXZKQ==
X-Gm-Gg: ASbGncv7J+c0HGOHqj/IHykLuhlzE/eJXNMYz/J/D4bk9Yz3IfKepL6yqv7GLLMDUBo
	3mGglwwhw1RFhEnjyWqqF9yvB3CLV71O4Nq2w6p5qdF6ukpo+eA/xLJMM8F64wcWv3HVEbiStgC
	2zQrFr
X-Received: by 2002:a17:90b:1f87:b0:313:1e9d:404b with SMTP id 98e67ed59e1d1-313f1c6f65amr18456391a91.2.1750117646010;
        Mon, 16 Jun 2025 16:47:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzdg42kN5pptUMLJA00bSabF+DQ9gwSWRKhX9NQOyY7Hl7/HckGq6Ag9Ajpk4VibNTFzYpU6jzDCASTYFhado=
X-Received: by 2002:a17:90b:1f87:b0:313:1e9d:404b with SMTP id
 98e67ed59e1d1-313f1c6f65amr18456352a91.2.1750117645514; Mon, 16 Jun 2025
 16:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604-qrtr_mhi_auto-v2-1-a143433ddaad@oss.qualcomm.com> <CAFEp6-1h01SScjbv_m8rU9DxhEgAFOBT_7U2mQegFZQq_O0y4A@mail.gmail.com>
In-Reply-To: <CAFEp6-1h01SScjbv_m8rU9DxhEgAFOBT_7U2mQegFZQq_O0y4A@mail.gmail.com>
From: Chris Lew <chris.lew@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 16:47:14 -0700
X-Gm-Features: AX0GCFsbJYV1ZJdeUUQ7DQBojDZBgGWW6Eexg_cdNTRLaq52u816F0qpQXR7xwg
Message-ID: <CAOdFzcgqiR9qR9KajxBL+CzS5NLBFy4+18L0YfxXU+G=RWEs1A@mail.gmail.com>
Subject: Re: [PATCH v2] net: qrtr: mhi: synchronize qrtr and mhi preparation
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Hemant Kumar <quic_hemantk@quicinc.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 50MjvAfFXUORG6N-fUbSOReri-t-rs4X
X-Authority-Analysis: v=2.4 cv=edY9f6EH c=1 sm=1 tr=0 ts=6850ad0f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8 a=EUspDBNiAAAA:8 a=-niRd5vj0Es7JO4lwy4A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=xwnAI6pc5liRhupp6brZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDE3MiBTYWx0ZWRfX0Dm7vWizpJJL
 E9HJgwuAVMjAmyVepXPLf2sauV9y0TOzd4sJoqxfRqjAcmBbkTI23udUWb/zgpLGssxkwWYkxQ/
 G0W45gyhmAgyTpXrFidK2ZVuElh6S+y7yZ3JeX/VI+SUNa9r4iMNqb4rnN0AQ47b1qjXS+gBBhZ
 +DOua3JCsTzZyTFT+GuLBUQK7sTMv6dnD6ulYhpQMtK0CHaWMlE8q45G+1/MR6y5xxDDk7nb9R7
 HQEMP3lGHDbVu47uFsUz19De/Ou0PjWEo7u9d5m/albgmLpA4BehhcNS20wrOd2Da6GK5H/yLnQ
 PIsrX45pFIQ+raMzWWu7bA9hnbHzc/RSYOnFqMWTtrhSIqpUUTKcTzNZ7CkkbofaFM2N20IqB8U
 Ec8YroPJXzn6sVQ6DCHJhLUG5Z7I9DdubBVHZ471k9XdKmwH6fTz6FSKs43kp0fFkItmxeiY
X-Proofpoint-GUID: 50MjvAfFXUORG6N-fUbSOReri-t-rs4X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_11,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160172

On Thu, Jun 5, 2025 at 1:24=E2=80=AFAM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> On Wed, Jun 4, 2025 at 11:05=E2=80=AFPM Chris Lew <chris.lew@oss.qualcomm=
.com> wrote:
> >
> > The call to qrtr_endpoint_register() was moved before
> > mhi_prepare_for_transfer_autoqueue() to prevent a case where a dl
> > callback can occur before the qrtr endpoint is registered.
> >
> > Now the reverse can happen where qrtr will try to send a packet
> > before the channels are prepared. The correct sequence needs to be
> > prepare the mhi channel, register the qrtr endpoint, queue buffers for
> > receiving dl transfers.
> >
> > Since qrtr will not use mhi_prepare_for_transfer_autoqueue(), qrtr must
> > do the buffer management and requeue the buffers in the dl_callback.
> > Sizing of the buffers will be inherited from the mhi controller
> > settings.
> >
> > Fixes: 68a838b84eff ("net: qrtr: start MHI channel after endpoit creati=
on")
> > Reported-by: Johan Hovold <johan@kernel.org>
> > Closes: https://lore.kernel.org/linux-arm-msm/ZyTtVdkCCES0lkl4@hovoldco=
nsulting.com/
> > Signed-off-by: Chris Lew <chris.lew@oss.qualcomm.com>
> > ---
> >  net/qrtr/mhi.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++---=
--
> >  1 file changed, 47 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
> > index 69f53625a049..5e7476afb6b4 100644
> > --- a/net/qrtr/mhi.c
> > +++ b/net/qrtr/mhi.c
> > @@ -15,6 +15,8 @@ struct qrtr_mhi_dev {
> >         struct qrtr_endpoint ep;
> >         struct mhi_device *mhi_dev;
> >         struct device *dev;
> > +
> > +       size_t dl_buf_len;
> >  };
> >
> >  /* From MHI to QRTR */
> > @@ -24,13 +26,22 @@ static void qcom_mhi_qrtr_dl_callback(struct mhi_de=
vice *mhi_dev,
> >         struct qrtr_mhi_dev *qdev =3D dev_get_drvdata(&mhi_dev->dev);
> >         int rc;
> >
> > -       if (!qdev || mhi_res->transaction_status)
> > +       if (!qdev)
> > +               return;
> > +
> > +       if (mhi_res->transaction_status =3D=3D -ENOTCONN) {
> > +               devm_kfree(qdev->dev, mhi_res->buf_addr);
> > +               return;
> > +       } else if (mhi_res->transaction_status) {
> >                 return;
> > +       }
> >
> >         rc =3D qrtr_endpoint_post(&qdev->ep, mhi_res->buf_addr,
> >                                 mhi_res->bytes_xferd);
> >         if (rc =3D=3D -EINVAL)
> >                 dev_err(qdev->dev, "invalid ipcrouter packet\n");
> > +
> > +       rc =3D mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, mhi_res->buf_add=
r, qdev->dl_buf_len, MHI_EOT);
> >  }
> >
> >  /* From QRTR to MHI */
> > @@ -72,6 +83,30 @@ static int qcom_mhi_qrtr_send(struct qrtr_endpoint *=
ep, struct sk_buff *skb)
> >         return rc;
> >  }
> >
> > +static int qrtr_mhi_queue_rx(struct qrtr_mhi_dev *qdev)
> > +{
> > +       struct mhi_device *mhi_dev =3D qdev->mhi_dev;
> > +       struct mhi_controller *mhi_cntrl =3D mhi_dev->mhi_cntrl;
> > +       int rc =3D 0;
> > +       int nr_el;
> > +
> > +       qdev->dl_buf_len =3D mhi_cntrl->buffer_len;
> > +       nr_el =3D mhi_get_free_desc_count(mhi_dev, DMA_FROM_DEVICE);
> > +       while (nr_el--) {
> > +               void *buf;
> > +
> > +               buf =3D devm_kzalloc(qdev->dev, qdev->dl_buf_len, GFP_K=
ERNEL);
> > +               if (!buf) {
> > +                       rc =3D -ENOMEM;
> > +                       break;
> > +               }
> > +               rc =3D mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, buf, qde=
v->dl_buf_len, MHI_EOT);
> > +               if (rc)
> > +                       break;
> > +       }
> > +       return rc;
> > +}
> > +
> >  static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
> >                                const struct mhi_device_id *id)
> >  {
> > @@ -87,17 +122,24 @@ static int qcom_mhi_qrtr_probe(struct mhi_device *=
mhi_dev,
> >         qdev->ep.xmit =3D qcom_mhi_qrtr_send;
> >
> >         dev_set_drvdata(&mhi_dev->dev, qdev);
> > -       rc =3D qrtr_endpoint_register(&qdev->ep, QRTR_EP_NID_AUTO);
> > +
> > +       /* start channels */
> > +       rc =3D mhi_prepare_for_transfer(mhi_dev);
> >         if (rc)
> >                 return rc;
> >
> > -       /* start channels */
> > -       rc =3D mhi_prepare_for_transfer_autoqueue(mhi_dev);
>
> The autoqueue has been introduced to simplify drivers, but if it
> becomes unused, should we simply remove that interface from MHI? Or
> improve it with a autoqueue_prepare() and autoqueue_start()?
>

Yes, I think it is reasonable to remove the autoqueue() interface from
MHI. If another driver comes along and needs something similar we can
revert the commit that removes it.
When I had more cycles I was planning on removing the related code. I
was very late in providing this patch, so I wanted to get this on the
list first.

> Regards,
> Loic

Thanks,
Chris

