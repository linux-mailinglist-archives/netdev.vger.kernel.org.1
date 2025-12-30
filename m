Return-Path: <netdev+bounces-246305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A06CE9085
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 09:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66C88300C2BE
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 08:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1F02641FC;
	Tue, 30 Dec 2025 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R2D848oJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e4A3jgsY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1C51F30BB
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767083514; cv=none; b=lDCI/uTDAs+UG6ATWsgZLUJSnMx3EkZ1lbecy0ytXjCaIntkQ5s88m6itjQEO8HCD1mQKB2Y51C1Kw/dG8/7+8+hAFgLbPrrupegcRmxNYAB0qDgyBuC9hR8oNxr0mG1jB6FLkncdUK70QGtITRM7BlGckBw0t5npqP+s3Cjk5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767083514; c=relaxed/simple;
	bh=m6hvbevJyuhk10WNOvBFfjn3rxeFkTJLsdGukclyKE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlS9US7kklT6TKGJmtfGV9L7TQAuVfCkHqMrHU52H37QasLPAzZXp9SVV5emqYHmkrXCyfE7BTFHUbeEi4W/ifLrOsdWUJoaILrZL4fmW8Ibn8xaD0oDMTTrRAdAMnUvUKAft1Om8CBOZQ40X9khgtRm9Xy+SoeV8vqIl/RulqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R2D848oJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e4A3jgsY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BTKefxS2725780
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 08:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y2Kiv61EPEz01nq0NjrAsUOCXUCMEjN7vnkWpbw0MHE=; b=R2D848oJFCwYBQqR
	v+6i8pRjzwPCz+ZgaEo1OJvarDMSp9mItGxtS9JTsfIAJ41Ju2efDmMVEbEhI/z1
	8cYHZwwaPlTS4eiSwTQc5WD9OJ9vtN2Z3Lcqlekrb3THg7hbB+jgmZMOCdvWjWLY
	MQImwCtqoOiJHI0Yb3KHTscwsKu/0AmXWoaR8/Yyo1cn1k+MkeMo75KBGBhrtJ/D
	9Yt6U2zL0Cn03GfvL4spy53pewdZx4gtmskw++hpGAZkHYUrHhcTHQyq8V3m0u2j
	74sh4sj+ZzgskCLgPYxMnAQ8Ln1/aZjBjXVcjhK4sSMw1mruMofzZaFgOPOJ6lui
	ttCjdg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc0vdh9he-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 08:31:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8804b991a54so368055026d6.2
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 00:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767083511; x=1767688311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2Kiv61EPEz01nq0NjrAsUOCXUCMEjN7vnkWpbw0MHE=;
        b=e4A3jgsYgKGJg3wNiUnSyM5dem+TMnsKMZOEA8Zq052DpyI7TQqevYhG8yh5tM5oW+
         +Q38jI0nkVkTAqVm7pPTKHqN/mENf3V7QgcBjafM+rFgY5O8QS9008SsM+h3OQy7dYK5
         kRumTojndci3OSdbJnQM2eglJR9czNwq2fokAjBegbloOpuhtkJmSIO5xTageJzfUT7g
         yV5STWc+M1m6itSknsK4srBazdT+otZf8KJIS3TXGIAVb9aoi8hTC3ziCeVrRA6EVVan
         nQLMulq+u+IUmUh7H9dMTPQtJQ2XYTlYHPGJSBSZV54Q8Y8wIPHC110FM0gYG5OeWL3/
         HpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767083511; x=1767688311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y2Kiv61EPEz01nq0NjrAsUOCXUCMEjN7vnkWpbw0MHE=;
        b=SnLKCj8weNyvtngBenJqFKsmufkZTDq8h9tZd7TUYXFRubs57w35Y0byi6o7M6sClv
         Ua3UQ3YhI7oWLA5FCzrechV8eHmveONqmejXv6BXW4dRp0aYNwXAFjRvmczZxprQi6e/
         ESj2ljEb14Om0HEMD2qVbW4ACE5eqR8PpuKO5HQkremsTzIqOTkXTzU3DrMVZvV7n4IV
         ggX+9kFDcQLJKmb0guwROL1Ol7obj96ehxXGkzEO9Cw4ftS9ynNJXMsKRJY/7guiKwl7
         MhNdWyIAgaamNxeBEcEzIR6jJiZBKjmi/NUBxV8+rQnX3WHIS528mE69+FhzwV6wujwS
         QMBw==
X-Forwarded-Encrypted: i=1; AJvYcCUGme53qUoo10lrV434BvorQJ8ssSrgWt0hOfoE3sNuN6d7edgWGjyEVlLsMS2w2ghfWs7V8HM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6eQMj9YTGY1yHW5XhQ3+DWIXLQDsVrg9UsBRh4N0GtuuHvdZo
	QjEx98zeLCh0HQ4dF+Qqj338UnV8UdLT5+B394eSz5Lkpa9naH2jSy/XPzZ+dZssVQjPcI/L+1q
	ie5YQFVSRwKv8wkpqX3zMImJNCfc0UOVfWeiOJUgcADDTNums8rDpHjGFiVnUVRzu3K0Fz+yLf9
	alR+P+bRBw1rryRTjMlvVf87IT4dzBc52bZQ==
X-Gm-Gg: AY/fxX5ht7P8h90ne7J/Rx8KKjAqahaSU94RlHhzKmnSR7bPKShH24xWMIx9b6btEBj
	xcqahQOE/Dml/wHYRFUxt88or1MBQuewtFQFCY8ODXgQEsVTN+Lz1+cMVadP/0UIXr1lYZvMNQn
	7yaVYPm69qFaOt2Mon5Yewrzh6Jc6YPoiFhCzVTI35uGohGsqWkxEUDHB7YXPJL0r13nAX58SJh
	Jn5Ej4GpyIFuf8DsIeiHMTO4Ws=
X-Received: by 2002:a05:6214:5082:b0:88a:2b73:db72 with SMTP id 6a1803df08f44-88d87af3aacmr538276996d6.55.1767083511050;
        Tue, 30 Dec 2025 00:31:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlytyrWfqGacbq6jhfS1Kjjo3UORFqjnyT7qepIEarqZmvgkgByM+VEXBg7QlZkmlh64MhDsTWZV8GnQAtQJE=
X-Received: by 2002:a05:6214:5082:b0:88a:2b73:db72 with SMTP id
 6a1803df08f44-88d87af3aacmr538276736d6.55.1767083510662; Tue, 30 Dec 2025
 00:31:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230071853.1062223-1-zilin@seu.edu.cn>
In-Reply-To: <20251230071853.1062223-1-zilin@seu.edu.cn>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 30 Dec 2025 09:31:32 +0100
X-Gm-Features: AQt7F2qz6AjXDkjLv2IVr0jEsV7rCZHzHYmHrrPwVgXEUtxqpuw5DbfCEi7yChI
Message-ID: <CAFEp6-15L291Ae1zbon=cD-iaQ-4RbVZNW42KUHx4G7KRP8Mdw@mail.gmail.com>
Subject: Re: [PATCH net] net: wwan: iosm: Fix memory leak in ipc_mux_deinit()
To: Zilin Guan <zilin@seu.edu.cn>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=dfONHHXe c=1 sm=1 tr=0 ts=69538df7 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=bq_3mZz8qLaXMhAjHesA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA3NiBTYWx0ZWRfXzSSnLKfIRlqc
 lCQcSfU8nIkbkJZyXR9df5NDf9QaO4d6zju1rBeOFElz1WxXPXrXZ/Dyy2K3uWpXnndV0oW1fZw
 dz50RQKBRMevru2ZImvr8P9Hl6wbZD6RLfB8Q3xZaXCzcxKObQF4kp7CJHciHGCtRpyHvggrwYk
 qpmZ+vrDMdxHkc3YhrB79ADZqClOnYhixaxkohfhGOqsYSsROP1OnDiOqM6Ks6PoLRsxEQkm2Ep
 EN9ooUSuX9T//MRR4K1yJUd96DhVmajl/4QMr4mZFg/2cU2+m94q1OmjonI2rYsHKUY+gGLhwQF
 bLegDx62OseCSRTk9ziTn4X5p7tCPaKKR+RZUq0v0/TiSN/gs+sN7+XQlkkWbaUl7U8ETw90T9n
 lNHIjAHTroUbdMhGMrHsj/e4zA8ave7NT7FXzpf+fx00nRSf2FeVX8GuKa93pQPm9Xy8mee1Oyg
 SHkpyDRKe+qGq5orDew==
X-Proofpoint-GUID: 0FzcMki86NaVSDJvtnvV1DxdFYvgRxCh
X-Proofpoint-ORIG-GUID: 0FzcMki86NaVSDJvtnvV1DxdFYvgRxCh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300076

On Tue, Dec 30, 2025 at 8:19=E2=80=AFAM Zilin Guan <zilin@seu.edu.cn> wrote=
:
>
> Commit 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support"=
)
> allocated memory for pp_qlt in ipc_mux_init() but did not free it in
> ipc_mux_deinit(). This results in a memory leak when the driver is
> unloaded.
>
> Free the allocated memory in ipc_mux_deinit() to fix the leak.
>
> Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support"=
)
> Co-developed-by: Jianhao Xu <jianhao.xu@seu.edu.cn>
> Signed-off-by: Jianhao Xu <jianhao.xu@seu.edu.cn>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wwan/iosm/iosm_ipc_mux.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux.c b/drivers/net/wwan/iosm=
/iosm_ipc_mux.c
> index fc928b298a98..b846889fcb09 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_mux.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux.c
> @@ -456,6 +456,7 @@ void ipc_mux_deinit(struct iosm_mux *ipc_mux)
>         struct sk_buff_head *free_list;
>         union mux_msg mux_msg;
>         struct sk_buff *skb;
> +       int i;
>
>         if (!ipc_mux->initialized)
>                 return;
> @@ -479,5 +480,10 @@ void ipc_mux_deinit(struct iosm_mux *ipc_mux)
>                 ipc_mux->channel->dl_pipe.is_open =3D false;
>         }
>
> +       if (ipc_mux->protocol !=3D MUX_LITE) {
> +               for (i =3D 0; i < IPC_MEM_MUX_IP_SESSION_ENTRIES; i++)
> +                       kfree(ipc_mux->ul_adb.pp_qlt[i]);
> +       }
> +
>         kfree(ipc_mux);
>  }
> --
> 2.34.1
>

