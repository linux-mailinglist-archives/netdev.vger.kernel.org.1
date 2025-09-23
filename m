Return-Path: <netdev+bounces-225690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8B9B96FAF
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 19:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E8318A552C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 17:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6763027934B;
	Tue, 23 Sep 2025 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bR69AqSe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD76D2737FB
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647832; cv=none; b=Jzay6jTFx4I+BA7MrmA7YvKyGLimmbWEOFI9vGm+Z/wzmQOG7mY0Zy3dR9p8w43hB3V5KxQ7Tf2V+Sj5MhoQ1T/cG3NtNVFVDWfyR3SzXhlN3raN8voF8PUj/YO9S5ge4pZ5OfXe1V/jm7gBPi+JHtTA7vJtApn7lRa7ZaNHkkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647832; c=relaxed/simple;
	bh=2EGHVQtTFIYKF5voFEiTBzC9TbQhQGA7OeekjX1wpxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0Idn1xKklyz5pzlK2vs4trgcUTUaZJj58+65RENb/qGxlTQxrujMujpPKLIM0yUK+q93UAnkTg9kK5cawJmvxlYhToXP/4mzQIqhkf72GkxAzvp5opk9vt0MeA/+RfNok/MY5gItQbIhl7aCqfhWP6tzBgN2bPwyYLZ82f3fyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bR69AqSe; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-54bc6356624so70635e0c.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 10:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758647829; x=1759252629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GBmDDXU1IVnC7UAPPZvbxGn03hq5hZpSF1QqVSLzmLw=;
        b=BjQCtX9BEe0aRo1XpkowtTRm/TmMWN+fAn46aitTdEExFzgHHRvVmgTvea2uYXnhVu
         tUEtm+OtMWcTOK+NS2oowDA8MYp58JLbAMG2p7gDTLh1uJHBzdJBU0EMawYLH2p+5WqD
         FCeQrSXtmIiCpw7/lyUkZyXOYL5LvaUSh0ofrmzfRxr73U/WhpuKHKPiFWct4uLZJIt/
         Oe+1L+cEz1sT88Tu+3bl8AazppqKoBtH8+kohUKLQLU+NYoSvWL60kH9whc3ZVouka8a
         fudTH1R08dWuEIfuL08UxdXyhNNOBU+Y29pO28yh5ll0iSo+ryVePU+452B4vV3OX6IR
         wkNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoV0Bl0a4Mj1wZQQEcu7GSoa7tw7ltUMgP4h+z32PIEQypzt0YvrgZ9JW2PTReeKFBKgdLDLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoaLyE43t3aLLMG4TEREuRvEgO2ka9ItdpldJFNxkjS7hv7xsS
	XeiqbMM66ZT3qK7sOfENrdphtN3BxUSa1SqW4rZCcVd+eNSRICq6HY6pb4bugom9YcbEi2P7gBh
	pTBkq5lkpXLzxHYloxs+JoNtzle52fTtf/6sfxvBszAmNv1c5QP144dO4fuQHqbSyl3E3eNv902
	r529VPDdScxbZaiH3wdn6cuXkyKVsghVCT6LSLUR8o3H1+1/Y+NLu5Xq1SYjXM7xSjfSISjpzZw
	Ap4elj01Ck=
X-Gm-Gg: ASbGncv+mdtiK06pnCAmLc92LnWO6y3r+ivqHJEgUMkuILhZq6zUqtx71n3qg4RON33
	pEC/JJTf7bqC3aUKq60KWgau0MojoILypFtownnwwBvewgD6zGyvRqp6XbR7Mw8F05bFDDYpoZE
	/USE+WZpf0AV+UEwUZgcEkoINdFgsNDFuchkv+3/0yHzd5/xh1SxjVMx4+BHe1dHDU6vBt6uv2+
	eKYlUcFVETF02Nu8+EnKZSyin7TRfM4Wqa8u0ahTjvhXeeSMnsXpxHI11N1DDOz3E9A7M8eEpOV
	RTUDVMmO3c2lOc9ttUMxWHV75rWDmqRreRGLXNMw8BjyOEz0oEtsCRm2GzZYPPiiJyyEPmQoiqA
	Y8JDSW3GDdM4iglKPhLObhENxsuRPX9eQ9lcPV6A7xWDbb0zA0mws27dAearQO9yNqJ3/4Z7Xdk
	s=
X-Google-Smtp-Source: AGHT+IF/NwDCzcAt7gb6Fkh57sR9bK7o4SQcFpXz05p9Z/lThdwJllii7N+WCHmXZJYghpVe0q3vpeQJakw+
X-Received: by 2002:a05:6122:659b:b0:54a:87d3:2f2d with SMTP id 71dfb90a1353d-54bcc0fa89cmr1163273e0c.2.1758647829518;
        Tue, 23 Sep 2025 10:17:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-8e3e7afb20esm155928241.6.2025.09.23.10.17.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2025 10:17:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3306543e5abso97641a91.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 10:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758647828; x=1759252628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBmDDXU1IVnC7UAPPZvbxGn03hq5hZpSF1QqVSLzmLw=;
        b=bR69AqSeq2DAlw1En+Y1NQBh5Xa0cfUYorRVSU3rt7Ai7xsQ+u96RhCh6uaILmylu3
         v8rHJ2dv6b3R3n9lUR+MfRsm6rhj0eu9zd+Dv6uk1PLcqHqhabOSrApAi9Ytg9urYhX4
         Oz0CnKlebIB0qfR1SIySYaoThd+3Atw1Fn8CU=
X-Forwarded-Encrypted: i=1; AJvYcCV+JgDxaVd/tt6ewoYGEaFIv7HnVVj9gJzo74sX/2CgZEUE/UG4uE4StVJcdQ67xDAyrpCohjg=@vger.kernel.org
X-Received: by 2002:a17:90a:d44c:b0:32d:e309:8d76 with SMTP id 98e67ed59e1d1-332abf0482dmr3556719a91.10.1758647826826;
        Tue, 23 Sep 2025 10:17:06 -0700 (PDT)
X-Received: by 2002:a17:90a:d44c:b0:32d:e309:8d76 with SMTP id
 98e67ed59e1d1-332abf0482dmr3556688a91.10.1758647826409; Tue, 23 Sep 2025
 10:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
 <20250923095825.901529-2-pavan.chebbi@broadcom.com> <aNLL3L2SERi2IRhg@x130>
In-Reply-To: <aNLL3L2SERi2IRhg@x130>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 23 Sep 2025 22:46:55 +0530
X-Gm-Features: AS18NWDSgTGQIvq55yTTrk6GUjzApEVTNtvqI6c1mBhhg7R_jkrg5J4b3JzOxkU
Message-ID: <CALs4sv0F+RW8gFu83=1-PfdbT7Eyfy6Kb2FYiAP3JhuVw7Jo7Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/6] bnxt_en: Move common definitions to include/linux/bnxt/
To: Saeed Mahameed <saeed@kernel.org>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, dave.jiang@intel.com, 
	saeedm@nvidia.com, Jonathan.Cameron@huawei.com, davem@davemloft.net, 
	corbet@lwn.net, edumazet@google.com, gospo@broadcom.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	selvin.xavier@broadcom.com, leon@kernel.org, 
	kalesh-anakkur.purayil@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

.

On Tue, Sep 23, 2025 at 10:03=E2=80=AFPM Saeed Mahameed <saeed@kernel.org> =
wrote:

> >diff --git a/include/linux/bnxt/common.h b/include/linux/bnxt/common.h
> >new file mode 100644
> >index 000000000000..2ee75a0a1feb
> >--- /dev/null
> >+++ b/include/linux/bnxt/common.h
> >@@ -0,0 +1,20 @@
> >+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> >+/*
> >+ * Copyright (c) 2025, Broadcom Corporation
> >+ *
> >+ */
> >+
> >+#ifndef BNXT_COMN_H
> >+#define BNXT_COMN_H
> >+
> >+#include <linux/bnxt/hsi.h>
> >+#include <linux/bnxt/ulp.h>
> >+#include <linux/auxiliary_bus.h>
> >+
> >+struct bnxt_aux_priv {
> >+      struct auxiliary_device aux_dev;
> >+      struct bnxt_en_dev *edev;
> >+      int id;
> >+};
> >+
>
> This file is redundant since ulp.h already holds every thing "aux", so th=
is
> struct belongs there. Also the only place you include this is file:
>    drivers/net/ethernet/broadcom/bnxt/bnxt.h

Hi Saeed, later bnxt fwctl will include it as well. You could say it
can still be
inside ulp.h but fwctl is only going to need bnxt_aux_priv. So I
carved it out of
earlier bnxt.h.

>
> So I am not sure if you have your include paths properly setup to avoid
> cross subsystem includes, in-case this was the point of this patch :).
>
> >diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/include/lin=
ux/bnxt/ulp.h
> >similarity index 100%
> >rename from drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
> >rename to include/linux/bnxt/ulp.h
> >--
> >2.39.1
> >
> >

