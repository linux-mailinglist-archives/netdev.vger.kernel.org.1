Return-Path: <netdev+bounces-226174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1581B9D639
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 06:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5CE16E892
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 04:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B77735950;
	Thu, 25 Sep 2025 04:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JlO8ZLBz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03BA34BA52
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 04:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758774704; cv=none; b=hHv5Scvh9NC/xaEJzgoG424zs5hnhIv9kAMjwSNQGdVoQcfhzW9lCKyO34WcfE8IMm6ZvWSQBDMf2a8wO15ufbhqTgJIGUPuuRbmWDReCy4awD/gtJYPQINDJMz6SqF3YGFwjVNyL0f4MayV6JmCuXHJClsQ0NI4jouQc0xP9eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758774704; c=relaxed/simple;
	bh=sCcnqFLWHU8heV0W8Pm1g/H3fJt8YHqIkwgV7nhtX7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBJGJcY+1U8gUFgvag9zNO8D8CxvgfW3GaVJSWPSrBtCN1Y7RbPm1Gbtg3i4gzrL4aDFGTwiD8F2MiDl8rj3hM1a6p18dqSsUT21AxB5K84G5x5cyiS7t+yR1W4w7mpjrnVSvQ60esv47267RFg/BLv+5n/astNYBySXW2V6Djc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JlO8ZLBz; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-b523fb676efso565692a12.3
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 21:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758774702; x=1759379502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBafFCK+JnHKaArKXckEbmKkFjzNnAKx1zY717dMJMU=;
        b=GplVcKUEQ9Pe0Q/j5JZWcYU1bx8C4hC2oIF5JoBVwwebDeqYvT0Xx+u+No62LdOUa3
         NETSvOkthk0CVgYEA2rU4OdB1D4yLUVDyoXNs15Z4BjOgwsnKZksAAad59oi/rwsPXWj
         BR4nm+ioC9pDHCYF5qypJlDnrsluuqTsfkHnJ954Ww8DnZQJCjF5iOMhTEUCmsFa7skQ
         KVv/oxxUpATfF7XPA8Y+FZg1GoH31IA5V3sqaxijq78rtobad8Ea4UMIOBziBsQhVnZj
         uxdPlYH8qBDjmhDqXD9cofikQP7vDFSz8jRobfKfjjrP5qHUTsOZcJAqnq4FXAbriB5t
         Ji1A==
X-Forwarded-Encrypted: i=1; AJvYcCWSR58JOB2q2DG/SQbp3JKrX1rTQUFK/GrY2mmQ8II81VqVcNYmg77KkEHcdU4sYVWH3r7lQk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8oGuOOykK0HbKn4BSKpM/gxa4tbRl3nmS6T1WwofiAt/51809
	eEjjx3s8QcuUptId+OEQ6NfDrNDUpz7s5LVHmsqHTFWvejipSSNSpxUctORauBeFGU9jEjkQ2Zg
	NbaQyyAavS0yTVYtiPMsHogOfSRbvr/4T+DHy4zy/dq74wGNXJbGHwG983n37GtWHOnSZywvdum
	px2CCu23ELm+WplrFz0b9WYXmbVGKdHBVZJ5291YMKt3cNf0Fg9lMyYYBqxw9mcidIkOBGg+BSC
	n0Yl166OzNKrA==
X-Gm-Gg: ASbGncvxw453Wm3c+jtgu2xrZWNL4iyRMKc0pzv62V5i1s9Cl9Ezju9ssZ9CGmd0qW/
	B5Qgqq1pyV8wlk4Xu8kbyVk0plJd9Xw3xQ0okm+HZHwQwCLbS21f9bvCbgbmVQ2HOctKP0b55o9
	CpxUpoj3r2O8fVFMM8JRR5AtRZCDADJWejHQeB59ixJADkrvZs/Y6wb4Tm2+WoOcRA+8aw3UkH5
	ttJTqKDYz7X9XEIEQ1wj061xVzqZJfW8oyibbUqEuah2LJTdOjgUfS7dTBSskj0JlJ6vJHQEGkQ
	TUnX6FjkaGU3QZ7MEUrfKNuvN8ifwDm9j9E/jFbpjTaYlhQfbaFpe3lbbUNXyP4waTZgY7ajf48
	3ZHZpztR9amQtttV2/u0KSB4VqiU9xqFaM/HooC4ZVkdEU59E16wFc/TfW3F0+kHxRjyiSjf184
	t4jg==
X-Google-Smtp-Source: AGHT+IFbUU8n8zXyP2l7r+/e3WAN9OclOesCeF93BhHAI3fpLzx0u81hoWa+DVBd3o/HtEL2WkNwLuJ/hc24
X-Received: by 2002:a17:903:fb0:b0:264:b836:f192 with SMTP id d9443c01a7336-27ed4a2d511mr23077045ad.35.1758774701898;
        Wed, 24 Sep 2025 21:31:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-27ed685c535sm701695ad.73.2025.09.24.21.31.41
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Sep 2025 21:31:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b2e52494b84so59644566b.0
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 21:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758774700; x=1759379500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBafFCK+JnHKaArKXckEbmKkFjzNnAKx1zY717dMJMU=;
        b=JlO8ZLBzwemfz/juf6Rj/colugcXPwuDQ6LyQ/3l1VdwVBIWh7tUWXqC3q4i4WEiqO
         Pxa3xX3KE6+8Lp43blH4kBzlm2Go+GlPtg6/Vh3wkGL4iT2Oex7maZdDoX9XqpP2eOBC
         RCQOKgUiD4psLkJAvSq4lbwmRZxBW2TH2VE5Q=
X-Forwarded-Encrypted: i=1; AJvYcCUn3HZEuoSOp7EnSAKOZmZDXt7NziWpApEqL6AlzRH/HHffHw+MYOb331q9ljxofu6SVlgBsLc=@vger.kernel.org
X-Received: by 2002:a17:907:6d0c:b0:b04:830f:822d with SMTP id a640c23a62f3a-b34bcb5f5a7mr219855066b.63.1758774699791;
        Wed, 24 Sep 2025 21:31:39 -0700 (PDT)
X-Received: by 2002:a17:907:6d0c:b0:b04:830f:822d with SMTP id
 a640c23a62f3a-b34bcb5f5a7mr219853066b.63.1758774699369; Wed, 24 Sep 2025
 21:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
 <20250923095825.901529-6-pavan.chebbi@broadcom.com> <548092f9-74b0-4b10-8db0-aeb2f6c96dcd@intel.com>
In-Reply-To: <548092f9-74b0-4b10-8db0-aeb2f6c96dcd@intel.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Thu, 25 Sep 2025 10:01:24 +0530
X-Gm-Features: AS18NWAvlAflWW5T2qO8fxylB0cvL6bMygwUIoQzbSO1B95oHpaSaAgjUbLbkPc
Message-ID: <CALs4sv0GMBZvhocPr4DTUu0ECFCazEb8Db6ms9SwO9CVPzBNVw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] bnxt_fwctl: Add bnxt fwctl device
To: Dave Jiang <dave.jiang@intel.com>
Cc: jgg@ziepe.ca, michael.chan@broadcom.com, saeedm@nvidia.com, 
	Jonathan.Cameron@huawei.com, davem@davemloft.net, corbet@lwn.net, 
	edumazet@google.com, gospo@broadcom.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	selvin.xavier@broadcom.com, leon@kernel.org, 
	kalesh-anakkur.purayil@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Thu, Sep 25, 2025 at 4:02=E2=80=AFAM Dave Jiang <dave.jiang@intel.com> w=
rote:
>

> > +static void *bnxtctl_fw_rpc(struct fwctl_uctx *uctx,
> > +                         enum fwctl_rpc_scope scope,
> > +                         void *in, size_t in_len, size_t *out_len)
> > +{
> > +     struct bnxtctl_dev *bnxtctl =3D
> > +             container_of(uctx->fwctl, struct bnxtctl_dev, fwctl);
> > +     struct bnxt_aux_priv *bnxt_aux_priv =3D bnxtctl->aux_priv;
> > +     struct fwctl_dma_info_bnxt *dma_buf =3D NULL;
> > +     struct device *dev =3D &uctx->fwctl->dev;
> > +     struct fwctl_rpc_bnxt *msg =3D in;
> > +     struct bnxt_fw_msg rpc_in;
> > +     int i, rc, err =3D 0;
> > +     int dma_buf_size;
> > +
> > +     rpc_in.msg =3D kzalloc(msg->req_len, GFP_KERNEL);
>
> I think if you use __free(kfree) for all the allocations in the function,=
 you can be rid of the gotos.
>
Thanks Dave for the review. Would you be fine if I defer using scope
based cleanup for later?
I need some time to understand the mechanism better and correctly
define the macros as some
pointers holding the memory are members within a stack variable. I
will fix the goto/free issues
you highlighted in the next revision. I hope that is going to be OK?

