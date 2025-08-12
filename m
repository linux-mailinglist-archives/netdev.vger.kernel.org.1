Return-Path: <netdev+bounces-213073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E52EB232D6
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFDF189CFF4
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72B82F4A02;
	Tue, 12 Aug 2025 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="fouCeRSm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FA81B87F2
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 18:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022644; cv=none; b=Wr+uJ95JrnhYZDRePVblrGKhQk7u06ZS9tV1PegifBTneE7yqn4K+TWHwvDV9xuZ+pBZnmc9Jqk+Ajnhll8L7pkgJDtQfLbYMXOpFImeohMxPtYNbzJ4kL/qsIjo0ol9n5p/W8b38mRtliSpvU7Z/Im5bS2Vwu4im7N9Ls/4OkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022644; c=relaxed/simple;
	bh=EMvQd3d1WlKkMgyYl6nmwZf21rQLaUhdMd88yyw2ml8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJF6EH+LmTrTGIvW5utq5VPvom9ZsvSIDMw3gQOTN1Qlwexng6t32SmkRbAetZb5f6GaH/vof1er41k73s18Qy1OGNPkZViBZYrGvnkzMqndmZ9b/wY/qRL/Y8U2K8dmOgdux6hSzSgMTOhT+U/AHpmTpdhoKvYE0djKvRdaX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=fouCeRSm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31f28d0495fso7867338a91.1
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 11:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1755022642; x=1755627442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMsriY29YvNF5zAGx23oTqCNdYx68Xnkyo51DYe24q0=;
        b=fouCeRSmU+GOlJn8FNDilWLnfH4F6mxza0lezZWMPGB/kPLWaBpYhnh1u5OMBBnyrC
         UvMfkIjQ+sgcCT3ekSgl0l7RgQCTCzLV885GoptsH3ObVJq3jlwR3MUdtVuRYuJw3h4T
         QXFbRSU9OxxnGxM7OT4xpbLvlajZ5rW+n+i6qk2/IbkumwKuoVdfPH5k5JZtrMYsR4N+
         CWkusqUSJ4xmNedT+Tgx2RrOyFT7KHxXi//2pCV+1MaiFtefF1L3Zv2YBsxNWm1PMZXH
         YrwAUUdewgs+cGFE99k9uOMZbs8aonzq2uUiGEf9lc5J5vj0FFC1JBWqsW5ozcS/nhgD
         dHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755022642; x=1755627442;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMsriY29YvNF5zAGx23oTqCNdYx68Xnkyo51DYe24q0=;
        b=mkfuGbdlLerElnd56b1p+BT2r4DeEcL01mzc46LAeu7lJNsxyQHETi0lIhDSP2hqsX
         f/lHG+CNi9ulTahaP0AZQTAJvKBJdFQP9BrlzwaQGgxEkukYOA2H/i/R8Z0ckZHM0a5y
         qIDT2l+RzObyrhe+dOoNy2sqW5Itfj0YPBDyIEKlhNhVfvQP8gF4MU+XUh7Bc8O7dUut
         4sQmxbpW6SRmI76BytrvM5efOV17lA1ULAzhg/IdQ0rEw0eYX8Zkznw6d1pgLDLUiujN
         NfKVCkPTEsFd2g1klyE0IxwG6Ev71CO5iPkqUMP8wzgYC/uBxHlpfshHU/r7HgWhL/hB
         JBjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ6a+UZAvjNtJg3DOs0kemQTthKrR/y6LsS1MgxjCectyKj7hnyBw2M4X57L6TyA+5KR2/Mr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+gU4dumsoq/rsuKkDfV5eUcj2Dy7sjAqp2u/GYh02qwg/yqA/
	fStwVzowacfGqp/PXY+PkFm4U2X4VA3KuNVgf2JbRumts3+lzeN45v1Ww91TeUL7CQ0=
X-Gm-Gg: ASbGncsbFr/Upq8ZzhOUU+9QbI+XbdD7niAtrGN0ykEnOkZuJ6JgWU8A6U4/6rQehwO
	mWsDXORIxNB2JyebspIiZ/+7LTbX0ohdjj5W8Qg+fTgKdBOCvhsYKXveR8/kYvMZAUeWYz9Oow5
	xeUjwIB5IheotC8d46+mPOVXrSqZhfHYcGHYUi4x1Hg5ROY4VDCxOWQOIPbhnYv6EHSEI55UIBY
	OF6qrJ1K2ryPwOZnsBDtl2wI94l1EXHQPArxlOVcJhju+jKuX/mCcRfumwQXKOAerUzlCVvywlB
	F+O1iVYsmqEeWMnGnNA3f2tEBXz4wCL2GJoq06NKn1MwXYA+mapWE1ejOaa2GbtG5v4fmXbOMUv
	DyT9oD/IHke977wfVpxDVIJ4qzCSrcbqrYnPgosiTrBO+peF1BwZg6dO6ST/svwRacgsz1Gy2
X-Google-Smtp-Source: AGHT+IHNhWzWkwRf4t4T8nX0GvXq0IE7nZzVv4i5678hX4iND6uqFIFh5YX2G/IUawi7Y4lWCYrvwA==
X-Received: by 2002:a17:90b:1a88:b0:31e:ec58:62e2 with SMTP id 98e67ed59e1d1-321d0e6d0famr45436a91.19.1755022642311;
        Tue, 12 Aug 2025 11:17:22 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321611dd694sm17922432a91.1.2025.08.12.11.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 11:17:21 -0700 (PDT)
Date: Tue, 12 Aug 2025 11:17:19 -0700
From: Joe Damato <joe@dama.to>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@axis.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND net-next v2] net: enetc: Remove error print for
 devm_add_action_or_reset()
Message-ID: <aJuFL__jLySvTNIp@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@axis.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <pnd1ppghh4p.a.out@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pnd1ppghh4p.a.out@axis.com>

On Tue, Aug 12, 2025 at 02:13:58PM +0200, Waqar Hameed wrote:
> When `devm_add_action_or_reset()` fails, it is due to a failed memory
> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
> anything when error is `-ENOMEM`. Therefore, remove the useless call to
> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
> return the value instead.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
> Changes in v2:
> 
> * Split the patch to one seperate patch for each sub-system.
> 
> Link to v1: https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/
> 
>  drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index b3dc1afeefd1..38fb81db48c2 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -1016,8 +1016,7 @@ static int enetc4_pf_probe(struct pci_dev *pdev,
>  
>  	err = devm_add_action_or_reset(dev, enetc4_pci_remove, pdev);
>  	if (err)
> -		return dev_err_probe(dev, err,
> -				     "Add enetc4_pci_remove() action failed\n");
> +		return err;

I looked at a couple other drivers that use devm_add_action_or_reset and most
follow the pattern proposed by this change.

Reviewed-by: Joe Damato <joe@dama.to>

