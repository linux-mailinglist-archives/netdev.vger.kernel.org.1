Return-Path: <netdev+bounces-222950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CB6B5735A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131D93A5C5D
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 08:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3ED2D5436;
	Mon, 15 Sep 2025 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y/mQsrzc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F01217A2E1
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926024; cv=none; b=ms8eUW5P9jMzWcxFEYVkkh7Yd0Fz83OwnyJwwh1S/lKjGL3ESq91Y0IGmWsC+aWddDTDpUYfNmHSnrce0aRlFv8GfySFQCn6PfvEK2U8JWstZ6+iwIx7DMy7gPI8v2xqq34h+vsW9c09fKwBjcnZqXa6w3jr8FZtp5So/ZerpO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926024; c=relaxed/simple;
	bh=Nh1fmSS7S0Y+TlIauZOnptlFGVr7YB83chfdrVSrH20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8AvqUCC//606ode4RrWYCkGW1/JJ81LLLWR81iEP8wH+OzFFokSgP0iFqlm3F8WhiXHQm1EULASG/tbxQcLZ+s11v//QH6Cc1rBWNUIv98AmfS1a+52VOPknZeyPo0N87dbTv5xpI0Wg5zVNY5gh0d/i2aRrjEEPFC0W4PlrnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y/mQsrzc; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-776df11e5d3so1508350b3a.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 01:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757926022; x=1758530822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRL/oERcgqujpEFqLS0DNlUVpNwIxOMmrM7SzRWb83w=;
        b=cOueCjHWdlyfGRmR6Jxvv8HIYk3jxWDeQQdoyamS+XDOHe8VQqrPowrnxuCqY14n4X
         +YH9HefiPO/j9dnsSMBpjvGejJw45MnhGE9xEDUGoHFVNZPFKOyJTeC3OthsZzTk9No2
         R3akT42lyX8GezSu+U1iHgaOhFLMHDetEq13+4U3jDnyk0/TqjOToc5HwbMTFOgnwLsB
         VhwyXEheW8kIjauRvzYVdn8gV2QJPSYRhydGDFuUHlyq7AQcq0NthI6ZRzOZerAauMBu
         j/BvQQqeCD/Xl2Y9gv5CC9umyB1DPZxBWR9Sxh7B7wi1y0W3YmO6N84xocGIq3Bbfo1y
         dTUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgHwr7OQsgKZXrVD6DIikoY3Dbrl0TECvA24P7vDEvERjfQbtjTIVK8p5M3m000psctpXZ4ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymzr8MnaGlCp9t+usd1ZxYR0kf9yK1ylYF3NU0SUf+GjnQhi7K
	vMBVHWpqFL4a+3jDCd+T4D/oQ4uQhD5DK8KwEH5TD1Xk8uN5QbuQdGByCLnc74v91YSwUlJgnZ7
	fTBXeJPgDCDoJ99kpYMuMkLPhhz7asFRoE1p8RvHzEgHI6ZohmlVyWfbx7fT8zediTNdpf2gJb6
	FFLrgkR6AlLkLN5AcwNbdxVnzXMEb08FlklybrBXvAjhCgC6qLb3sStGa8D6k0lF9iEWdsg/uwO
	+GALLP/pA==
X-Gm-Gg: ASbGncunfXDEDpfgsD/ewVZYdSN9X+Mol3t6Xw+30rCLFEAQB1Gyyia+aJu3yrE93Ig
	uk/saobFlSBpeEQznaGt7pRl6kAN1BKxYpan8d2+IbLRlbc7ZZUV/yFyivfAFktG9s9Wb6P72KI
	sS46HHKx2KQMu2AL8dp3/V7H3jFfq+jTDvLpuCmklczzVEXrpFAUTVMeQX9KW3eaMP6T0hqJvoK
	YuwqaXTAv1CbBT4jQaL4hFgGEZ36BwXItcpxKCz5YSnPLdqb1bz6iIJm1mODT+wdRkDXMsB2+7R
	y4CgFfx9fwKmOyyMCRRPaqICNTGQXO9tmKubKPimv2aItpRr+q3yFU28mIgZlq4LZYrqnx9mnZG
	ftNS7PgEH7jhkIJxAmsR9tgQw8+6P8z3/hmsKAWdJZys4kGRgqXWIuw7/60rCtJTMKMCCtW3xU1
	3s
X-Google-Smtp-Source: AGHT+IEL0sjJUA1zblNs0vtjrQnTjauzorFY4j7lsUkQ1v+f+0pAI+smMie/kzey4k0fjS3J3NBnRLL4LCGy
X-Received: by 2002:a17:903:388b:b0:25b:fad8:d7c2 with SMTP id d9443c01a7336-25d2675f816mr138593625ad.39.1757926022583;
        Mon, 15 Sep 2025 01:47:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-25ed005c31asm8117615ad.64.2025.09.15.01.47.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2025 01:47:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32d4e8fe166so5837708a91.2
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757926021; x=1758530821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRL/oERcgqujpEFqLS0DNlUVpNwIxOMmrM7SzRWb83w=;
        b=Y/mQsrzc+Hq1oVDy9azeq3cGsWi3oSagWa07aDFW5T2NDDIUxanxTBaSx3blwEo0Uy
         Gm7ZUdK6GWlxzLtWVNe9xUBzw7rViXV8FCVNPFFd9yaxxdmi4LGEl+iXwmuCke0/tqc1
         yO9To5tBcRyoJuh4WTFGnHgL9YIwjVGIT5iRA=
X-Forwarded-Encrypted: i=1; AJvYcCWjV3TMnGmOpIpZfZiauVVAC+UIovDvaUpq/Dft/PuLbw5S+8P41kYo52cuEW94WWy8gB2oJAc=@vger.kernel.org
X-Received: by 2002:a17:90b:390a:b0:32e:32e4:9773 with SMTP id 98e67ed59e1d1-32e32e4a039mr6276260a91.10.1757926020945;
        Mon, 15 Sep 2025 01:47:00 -0700 (PDT)
X-Received: by 2002:a17:90b:390a:b0:32e:32e4:9773 with SMTP id
 98e67ed59e1d1-32e32e4a039mr6276241a91.10.1757926020541; Mon, 15 Sep 2025
 01:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
 <20250829123042.44459-7-siva.kallam@broadcom.com> <20250912084234.GT30363@horms.kernel.org>
In-Reply-To: <20250912084234.GT30363@horms.kernel.org>
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
Date: Mon, 15 Sep 2025 14:16:49 +0530
X-Gm-Features: Ac12FXxCwAvULClSZKcYwWuvMI0YbqfkcBpa1uDsHkgAnwASiLraUmmFYMFCC5A
Message-ID: <CAMet4B7PWUrZNnwVf+qdMVAA6L5Gw3sFEw6akNTWeq0X-HtdzQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] RDMA/bng_re: Enable Firmware channel and query device attributes
To: Simon Horman <horms@kernel.org>
Cc: leonro@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, vikas.gupta@broadcom.com, selvin.xavier@broadcom.com, 
	anand.subramanian@broadcom.com, Usman Ansari <usman.ansari@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Fri, Sep 12, 2025 at 2:12=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Aug 29, 2025 at 12:30:40PM +0000, Siva Reddy Kallam wrote:
> > Enable Firmware channel and query device attributes
> >
> > Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> > Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
>
> ...
>
> > diff --git a/drivers/infiniband/hw/bng_re/bng_sp.c b/drivers/infiniband=
/hw/bng_re/bng_sp.c
>
> ...
>
> > +int bng_re_get_dev_attr(struct bng_re_rcfw *rcfw)
> > +{
> > +     struct bng_re_dev_attr *attr =3D rcfw->res->dattr;
> > +     struct creq_query_func_resp resp =3D {};
> > +     struct bng_re_cmdqmsg msg =3D {};
> > +     struct creq_query_func_resp_sb *sb;
> > +     struct bng_re_rcfw_sbuf sbuf;
> > +     struct bng_re_chip_ctx *cctx;
> > +     struct cmdq_query_func req =3D {};
> > +     u8 *tqm_alloc;
> > +     int i, rc;
> > +     u32 temp;
> > +
> > +     cctx =3D rcfw->res->cctx;
>
> Similar to my comment on an earlier patch in this series,
> cctx appears to be initialised but otherwise unused in this function.

Thank you for the review. We will fix it in the next version of the patchse=
t.

>
>
> > +     bng_re_rcfw_cmd_prep((struct cmdq_base *)&req,
> > +                          CMDQ_BASE_OPCODE_QUERY_FUNC,
> > +                          sizeof(req));
> > +
> > +     sbuf.size =3D ALIGN(sizeof(*sb), BNG_FW_CMDQE_UNITS);
> > +     sbuf.sb =3D dma_alloc_coherent(&rcfw->pdev->dev, sbuf.size,
> > +                                  &sbuf.dma_addr, GFP_KERNEL);
> > +     if (!sbuf.sb)
> > +             return -ENOMEM;
> > +     sb =3D sbuf.sb;
> > +     req.resp_size =3D sbuf.size / BNG_FW_CMDQE_UNITS;
> > +     bng_re_fill_cmdqmsg(&msg, &req, &resp, &sbuf, sizeof(req),
> > +                         sizeof(resp), 0);
> > +     rc =3D bng_re_rcfw_send_message(rcfw, &msg);
> > +     if (rc)
> > +             goto bail;
> > +     /* Extract the context from the side buffer */
> > +     attr->max_qp =3D le32_to_cpu(sb->max_qp);
> > +     /* max_qp value reported by FW doesn't include the QP1 */
> > +     attr->max_qp +=3D 1;
> > +     attr->max_qp_rd_atom =3D
> > +             sb->max_qp_rd_atom > BNG_RE_MAX_OUT_RD_ATOM ?
> > +             BNG_RE_MAX_OUT_RD_ATOM : sb->max_qp_rd_atom;
> > +     attr->max_qp_init_rd_atom =3D
> > +             sb->max_qp_init_rd_atom > BNG_RE_MAX_OUT_RD_ATOM ?
> > +             BNG_RE_MAX_OUT_RD_ATOM : sb->max_qp_init_rd_atom;
> > +     attr->max_qp_wqes =3D le16_to_cpu(sb->max_qp_wr) - 1;
> > +
> > +     /* Adjust for max_qp_wqes for variable wqe */
> > +     attr->max_qp_wqes =3D min_t(u32, attr->max_qp_wqes, BNG_VAR_MAX_W=
QE - 1);
> > +
> > +     attr->max_qp_sges =3D min_t(u32, sb->max_sge_var_wqe, BNG_VAR_MAX=
_SGE);
> > +     attr->max_cq =3D le32_to_cpu(sb->max_cq);
> > +     attr->max_cq_wqes =3D le32_to_cpu(sb->max_cqe);
> > +     attr->max_cq_sges =3D attr->max_qp_sges;
> > +     attr->max_mr =3D le32_to_cpu(sb->max_mr);
> > +     attr->max_mw =3D le32_to_cpu(sb->max_mw);
> > +
> > +     attr->max_mr_size =3D le64_to_cpu(sb->max_mr_size);
> > +     attr->max_pd =3D 64 * 1024;
> > +     attr->max_raw_ethy_qp =3D le32_to_cpu(sb->max_raw_eth_qp);
> > +     attr->max_ah =3D le32_to_cpu(sb->max_ah);
> > +
> > +     attr->max_srq =3D le16_to_cpu(sb->max_srq);
> > +     attr->max_srq_wqes =3D le32_to_cpu(sb->max_srq_wr) - 1;
> > +     attr->max_srq_sges =3D sb->max_srq_sge;
> > +     attr->max_pkey =3D 1;
> > +     attr->max_inline_data =3D le32_to_cpu(sb->max_inline_data);
> > +     /*
> > +      * Read the max gid supported by HW.
> > +      * For each entry in HW  GID in HW table, we consume 2
> > +      * GID entries in the kernel GID table.  So max_gid reported
> > +      * to stack can be up to twice the value reported by the HW, up t=
o 256 gids.
> > +      */
> > +     attr->max_sgid =3D le32_to_cpu(sb->max_gid);
> > +     attr->max_sgid =3D min_t(u32, BNG_RE_NUM_GIDS_SUPPORTED, 2 * attr=
->max_sgid);
> > +     attr->dev_cap_flags =3D le16_to_cpu(sb->dev_cap_flags);
> > +     attr->dev_cap_flags2 =3D le16_to_cpu(sb->dev_cap_ext_flags_2);
> > +
> > +     if (_is_max_srq_ext_supported(attr->dev_cap_flags2))
> > +             attr->max_srq +=3D le16_to_cpu(sb->max_srq_ext);
> > +
> > +     bng_re_query_version(rcfw, attr->fw_ver);
> > +     for (i =3D 0; i < BNG_MAX_TQM_ALLOC_REQ / 4; i++) {
> > +             temp =3D le32_to_cpu(sb->tqm_alloc_reqs[i]);
> > +             tqm_alloc =3D (u8 *)&temp;
> > +             attr->tqm_alloc_reqs[i * 4] =3D *tqm_alloc;
> > +             attr->tqm_alloc_reqs[i * 4 + 1] =3D *(++tqm_alloc);
> > +             attr->tqm_alloc_reqs[i * 4 + 2] =3D *(++tqm_alloc);
> > +             attr->tqm_alloc_reqs[i * 4 + 3] =3D *(++tqm_alloc);
> > +     }
> > +
> > +     attr->max_dpi =3D le32_to_cpu(sb->max_dpi);
> > +     attr->is_atomic =3D bng_re_is_atomic_cap(rcfw);
> > +bail:
> > +     dma_free_coherent(&rcfw->pdev->dev, sbuf.size,
> > +                       sbuf.sb, sbuf.dma_addr);
> > +     return rc;
> > +}
>
> ...

