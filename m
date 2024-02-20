Return-Path: <netdev+bounces-73415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AFD85C4D6
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 20:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4179D1F20F94
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 19:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F5F1350DD;
	Tue, 20 Feb 2024 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F1Tqnauz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACB976C89
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457525; cv=none; b=HeOHvc745OVE8Y2X3n9C40ao+wOrCxF/uEJfo69s+B/Jvw2mCPBYxeIOaFbFwWCCy7Y699dVXlYwtLAgQN9GIqGZZFItt3fKjkyx75cbeyGP21YVHb1v0Zi9YHFtykvfN96ma1MP4E+2alVqMXpOa7jCJwlSQj6StWj1z4ro8pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457525; c=relaxed/simple;
	bh=yoFi/NNJCxrnpiZ/tP3irpIQa6hkgeYWQxV3E6hH+uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFq4U2/EJFTFmz6+ZTkL6yhjN3bWMcwrKMzbBfVViwsksiyoKMMFtIFXxr8Td4eYjKLTQ/G6QV+8MFJ5g14QjBVlfev4hqQq4KwPYWy86bpCuD0/siEsBpavqWmC5vQ5BdBN4RYDNyYuyJS53ZLL6HlkHPVeE8+cZCfRL7PmwGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F1Tqnauz; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512a65cd2c7so4077670e87.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 11:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708457521; x=1709062321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoFi/NNJCxrnpiZ/tP3irpIQa6hkgeYWQxV3E6hH+uI=;
        b=F1Tqnauzp5+CK4D/pZ8c10MTDO5x20yj86JrO+cBBZgYmQRTtZKuklb+/3cmiMamLN
         w+/iTE7agcu4EPSfUdwBTWJHnDcYhxHd/tPYYnwLj6vg8FEvVfPHZPOW3RVI4hP/JNia
         V7dBtFigkkdywhIZXJLPppiiC8elTIBD0YKS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708457521; x=1709062321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoFi/NNJCxrnpiZ/tP3irpIQa6hkgeYWQxV3E6hH+uI=;
        b=Vpl/JjaPsHcHpxtXEeXP8uQ26O1+zpF51WmMETo9R/19JZXUgUFXMR3R12x2t/xTzY
         lpnV5vjQ5yeCqENNOf9IL4i/brzumvP4KVHxRBDlLY+zzKdHBvwlROCdzHvLo2YZVt2b
         R5WflEAjDOWf5Og++y63Yq5eWnZMgoghB5jVko7buhWNcS2HkUv/UlHTKfa58GEco8b+
         ZQJXimyRLaAIE1isW2iHMEo0g0d2ZcCHqufBSvXOiPdRV8hKasSaIa5AMDAR9jdMe0kF
         CJOEkd5DnTpqS4lmvNVLkk6qfZDWv3UyC1D+er2VyTLCBlV3IiQUKE9fgwE9dekuba2/
         LWsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV0gWL+ai4wf5f2nZXbvCuhpp9pAdDWN5cSahoVznPYkEz7ZRXxdyaojAWhn0smwbV4q5SWBLaSc88sweutcCUXCprgfj9
X-Gm-Message-State: AOJu0YykdDJj2AHh0x4rYseq2/3Y9yx0QvkY41kaoEsD731JIHTBDglg
	MDp+Bz0SAcNAk+ze9MdXKRLC52JbkZ7HkojKDIufONaPVghgIM/pguG02KKRpaHW6dlGBE0Eiao
	APtLoOJuDXdlCIi+R+4jOEH7TPtI1FFFLZJCi
X-Google-Smtp-Source: AGHT+IEDdLTK1+iOBtMMTl0gr6yhldxySgme4ETLdTFyiKu9iBkdki/xqCuuCV7+Yp5TQFEO+TYBBs9tA3YYC6hR4+I=
X-Received: by 2002:a05:6512:2244:b0:512:b0c4:71c8 with SMTP id
 i4-20020a056512224400b00512b0c471c8mr7036460lfu.29.1708457520872; Tue, 20 Feb
 2024 11:32:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9fcf20f5-7763-4bde-8ed8-fc81722ad509@gmail.com>
In-Reply-To: <9fcf20f5-7763-4bde-8ed8-fc81722ad509@gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 20 Feb 2024 11:31:49 -0800
Message-ID: <CACKFLikoE3WAjLpUAOCJKfg1O4w2j1ZPMF5R7o56S4i0oiGh1w@mail.gmail.com>
Subject: Re: [PATCH net-next] tg3: simplify tg3_phy_autoneg_cfg
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 10:04=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.=
com> wrote:
>
> Make use of ethtool_adv_to_mmd_eee_adv_t() to simplify the code.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

