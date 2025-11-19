Return-Path: <netdev+bounces-240041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDEAC6FA30
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 229983A698B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A782D1905;
	Wed, 19 Nov 2025 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ98A8P5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7132BD030
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763565044; cv=none; b=XpDwLDK347mYXH2h26pkpnkH+iOijaBAGNaTnK4U/0aaOa77tKJoYQ/I1w3EOb2FJKS5j4SUzQ32rnU5yYTEZzJN36VlYvabBWh/pMdkdkSlfLeOokVM1Ch8d4IgteUnwaBsZMLXrDlf7+P5AFI5PrdWoOWQsW+J3xlgYl0eIQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763565044; c=relaxed/simple;
	bh=DXpCJ+DP5BG1h4B3VkCL1Soequp2Zd2bwkGg6TvZqGs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZP7EK5KpZkmkMJoNzb5YPYKwfk8vFN+SVMVUhl1+7cC39v/wB2eSzl+aDrxm/Sco9gp57vJIHvxYnlcdSJhuF6hqsHpTBin7jLd2tbl+nSlpNifqp2CKnRCR752UUhLc8yo5UAgYtHiKOkvTtRcjdUrbgwtpR0u6l1OjLhN7o4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ98A8P5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477aa218f20so13490325e9.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763565041; x=1764169841; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXpCJ+DP5BG1h4B3VkCL1Soequp2Zd2bwkGg6TvZqGs=;
        b=kJ98A8P5AdyFA0yiayhVQiMqHuZtBLeuqzHOpyLer2BkRhu1lSGHKOGRWyFXnfF1sP
         GU9I1cceG6nTrCEwpACUcTYR1l1JB+8isubrJLKvLYBgmwCwGoGVXwHVJNVgnAXpmnJI
         jfhsU9hArmCNsQmFoUZX7w7duEN/w/s9lvWTQDUwso0anmDGVhVGNosUC2NgEqzUV3kB
         h6y6U0tp+UkBW+PFRM5c0KQMJrJV7aEzt5aXwnDfJN1gpYLG9vee0nBde33duf24h/pN
         IFS7Rr2Zy6tYewUBfD3/qIqjAoaYNfQZ+v5O6Ux1crR23ztMBq4u8fXxqED7fZX+2tW1
         ICZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763565041; x=1764169841;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXpCJ+DP5BG1h4B3VkCL1Soequp2Zd2bwkGg6TvZqGs=;
        b=qhTXk/6fEoATwPhIQ6oNQ6lyf33UHcmBWqqvWdvYXyhK7PAG1CPcfXDswFsMB0hwOa
         SCX6g+0WU22SS+o2ZqvJD3qQilZ4ceALBjaIPVpT/2MC75SZ8HiqSGR28GwQRgUpgOyY
         5l6w1czsUQ34RkkcwnW93nRC123Q/D1OQhshn9Rn9pZNKRoZFQc8X5vU0+bLTMvHfnpq
         obkv0ah7Zhe1mjKFoUsJwjt6G7sHnY1Ma5vAC2yhg2cXjfjyzO6EdBoaPlOYnpvngGb9
         dp488j4DXmwVsj6Ssae2uX53eyUE3blCA7dzLk5aWbYaflSOUgz6Ap9ZLHr7PsyVFmXG
         pOXg==
X-Forwarded-Encrypted: i=1; AJvYcCWW9Kj5xncgKv89lR88ctvBPf4qqzJ/aIZ2f5ANGWoSjsXaEFQmepXUXKgNfJmKPdWidoSdKQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN7X+gOmlYPUNts0WCryGx26ggX8as74OYiuBX7BJckxQ8io+t
	T+Rjib8WfvHExgdRqqkeFzVGHBeI2VR7Q4aa+a6d5hfxLLgvnPCWC3evQqjAwg==
X-Gm-Gg: ASbGnctNFdJCFXHB3NAAXob6uAYtn99aMcQctrHHxWmJ7nBFNJVX/+9zH+oPUwP8CVT
	rHtXz0OowXHmAIbMQy5/VArcJTsow+lPhi4tfE/tCZ09FYujJVptTJXNs86Y7FR5Y0a8gLDTNA6
	BL4SyPt/Ij2l3etlhOZf2tlBKor511mrJPjQENIMcbt133oM6dV6tG/JeIBBACrmN0SRbUdJ2KG
	DPkrsIlR6hUyjWGJacvP1Hm2SfiHEzI9bWncdmrWI9ze3K8aQyZtDwgHqQbqlRcqhLzvylOrOgG
	/XcwmiQO1c7EplEbF7Cwbl8KWOS7kDFSOnC6ig9z7BDHJ9uxMM0Mn5+wVZ3NQtiGIJjztCioNx2
	20ZDFkD1mAzDmzcH3y1J0ggROUh6FTYJzUso8v75fLJAWnDb53RkNnPcXWqn4t0m8V9olG1oi3w
	6iL1kVC5n4Nhw=
X-Google-Smtp-Source: AGHT+IH22pr3evuoNbJw/gQtZD+7hNQ9uB1ODF3bmeLD1hYXJZBU6uxSnEAYkQGJh6tyhNUBcKBblg==
X-Received: by 2002:a05:600c:a47:b0:46d:a04:50c6 with SMTP id 5b1f17b1804b1-4778fea0c6emr232480675e9.30.1763565041187;
        Wed, 19 Nov 2025 07:10:41 -0800 (PST)
Received: from [10.5.0.2] ([91.250.240.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b102bc9csm54764845e9.8.2025.11.19.07.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:10:40 -0800 (PST)
Message-ID: <543fa73bcf272166a8fb1455d6016ff9eedda45a.camel@gmail.com>
Subject: Re: [PATCH 0/2] net: phy: adin1100: Fix powerdown mode setting
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Alexander Dahl <ada@thorsis.com>, netdev@vger.kernel.org
Date: Wed, 19 Nov 2025 15:11:19 +0000
In-Reply-To: <20251119124737.280939-1-ada@thorsis.com>
References: <20251119124737.280939-1-ada@thorsis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-19 at 13:47 +0100, Alexander Dahl wrote:
> Hei hei,
>=20
> while building a new device around the ADIN1100 I noticed some errors in
> kernel log when calling `ifdown` on the ethernet device.=C2=A0 Series has=
 a
> straight forward fix and an obvious follow-up code simplification.
>=20
> Greets
> Alex
>=20
> Alexander Dahl (2):
> =C2=A0 net: phy: adin1100: Fix software power-down ready condition
> =C2=A0 net: phy: adin1100: Simplify register value passing
>=20
> =C2=A0drivers/net/phy/adin1100.c | 7 +++----
> =C2=A01 file changed, 3 insertions(+), 4 deletions(-)
>=20
>=20
> base-commit: 6a23ae0a96a600d1d12557add110e0bb6e32730c

Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

