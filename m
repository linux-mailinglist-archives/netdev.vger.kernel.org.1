Return-Path: <netdev+bounces-216225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F6EB32ADF
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 18:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B17D5A3881
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 16:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A613215767;
	Sat, 23 Aug 2025 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvzyjsvn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FEA155C97;
	Sat, 23 Aug 2025 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755966798; cv=none; b=AtnqrXCeTY0OSUgtUvoAcvw+arP9uEhghFGfCy8J3ovZnPCnO4bVy534ATVfvcXkg6KEYset5gc2jposX0CqptU1yZnlOrLYiH6LaQvyeJDRdx1Oe9EWhnK3LdomBMu5uPJzV08uAmLPLyU/P5SzF+YGYOagbp1klMmTQk9TvHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755966798; c=relaxed/simple;
	bh=aUtp3Wo6XkXgDHPvdQGSe87XUavHdltM58gDO7cwVyI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=B6NiHNJFGb1YVBEOJPfEqDwMH9RmUITa/ncO2TBd8FF/tvh4UM7bUo/LUow+tsduiFlr1zaKYShMWQRIJ/l+hfpHWNOeWwA7oOCgZ53mDEf70Joiy/Meld9Qrg7R1L5PSfTwt0YHiFfmPmscbvpuTzJg4ArwsF+nsTvt9masfS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bvzyjsvn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24639fbdd87so12264695ad.1;
        Sat, 23 Aug 2025 09:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755966796; x=1756571596; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7S0GbUPk23Y1kLFifM6lqQhkNqk3chZVo7AtveVLfSg=;
        b=BvzyjsvnJwLBXc/dcDddMk66C2K/dPlug4qdBE31PqAsuMPKtJdN3btoaMAE7O7n9B
         yDzTNa6ED5vFYUSnJqzkUrSu5c2TBfGvlCoY8sneQvzwQfW4+0hrAqKZE52N5kHRF6wz
         G05wS23mG7bLPVSQ06mPG1FznbMTIGejLLRKj6uaQMja1/wQRiwiSWdoRlnCi48c38WS
         hUpMUitWfCBoGdjQFIQag5dl9BlADj/adofTka048qEVlKem/ur/gr1PEMlex619Ezp7
         fEnPwIJMV4QrFgXmAUt91DciZwjZ+cLLCXDXujXHVvZ/K6f51EArCc5Bd3uGAO0qZeRi
         x5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755966796; x=1756571596;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7S0GbUPk23Y1kLFifM6lqQhkNqk3chZVo7AtveVLfSg=;
        b=Bq/THXAt30MxAi09W9kk2MhQvJEg7fIvTSc7phbijNNGRFy7VBcX8VpQKNaKswbfPZ
         eZC2M/3rK555zN5VSw2Q7b9H6bkxDNe62le3NdH+/pVuKwOXZ/Njn7uN/fICRfALMu0X
         AsYN3ASlQ8xysHqq2On/b2jHa5Up1auFTfUKdt5/6V9Sq2p41TFLHxK19hCLjtojaxMQ
         IX+7MgFfI2XcfGT6QLzA0EiJhihSNfStcOgsetUPCv/KZy8aeL4aMuxUliWhfw98HyPk
         JVK15UIjcgtdf0m9Qsn7AdiTyZMBsZIafpae252PrjDdsUCdNaLKHUHn1OeAvbkth7/I
         +3XA==
X-Forwarded-Encrypted: i=1; AJvYcCU5P5vefbJKPMxeI8c6QrBNbKIJPjW8D6pgSCm89Gi0fvOzWTI4K0QM+LFyCgPXWdUz+C0NxUUlOq/mZ+s=@vger.kernel.org, AJvYcCWiq0PwURhNCXROVeA46ss1u+7vkaVofF3+/QnLL78KvEW6vdzRzdLs2rnyEqr0H4oL0CcfBy5U@vger.kernel.org
X-Gm-Message-State: AOJu0YySY3XT/slrMXPcUzR/Kas2Z5MP2WKRSLWLr9mCHzYTBCltmqYm
	I1iN7IvG5gXKyTpD39dRymx907vFbh05ugQww1BEoxuOpxHdw/e/XYfM
X-Gm-Gg: ASbGncu2EHVOz+51wavAezsJUD/9LGWhuYOex3LSNX/cfhIS3BGglQpS8IQhXDTANuX
	RPEvu0LxEhqvgvk/wudmgGKJ0yoUFx5JOF0KlDxeozLHc2CmfZQi4bEu0vIifQ1nCVJoXMoKNlC
	yk2g17INDp+v6W3CqyPCMjuyAraQljS5KRF3/JCHoIREk7FdzJJ5C1yT8L2LfGy6KNaAxpyKRtw
	UQTbP/uR7TyHwJBR5jE9MfFKbJ+2hD5zBe62uEjdqJ08b8+h0B++Mb6IvY6Bf2Xg8ECIt8HWRxi
	Zu/Lv2FkJKyGSdcRqg5VoqaguqL1yBiaz8EvRwic/ufprwD3YLGoR0cPT1qYSs+OQ95wDGAtJ34
	h7utjkQfvhcCY5Uta8XdlhT1RcVBTel7SPehYg08qcNwKk1yqWB68
X-Google-Smtp-Source: AGHT+IHKLTpZT+rKd5jLQcBincXbnZMEjla8KZ1W+bnVw97cR9eh+2P4bso08EEf6Vmvk6LDOAlMXg==
X-Received: by 2002:a17:902:c40f:b0:240:86fa:a058 with SMTP id d9443c01a7336-246023aec06mr141899325ad.7.1755966795783;
        Sat, 23 Aug 2025 09:33:15 -0700 (PDT)
Received: from localhost ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254ae9a763sm2617461a91.12.2025.08.23.09.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 09:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 24 Aug 2025 01:33:11 +0900
Message-Id: <DC9Y9ZQA78BC.34TLXL2P7VT3T@gmail.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: dlink: fix multicast stats being counted
 incorrectly
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250822120246.243898-2-yyyynoom@gmail.com>
 <8f47407c-fb5b-4805-a95f-ca15d6eb7838@lunn.ch>
In-Reply-To: <8f47407c-fb5b-4805-a95f-ca15d6eb7838@lunn.ch>

On Sat Aug 23, 2025 at 12:15 AM KST, Andrew Lunn wrote:
> The hash for fixes tends to be shorter than that.
>
> Fixes: 3401299a1b9e ("de6*/dl2k/sundance: Move the D-Link drivers")
>
> If you add this to your .git/config
>
> [pretty]
>         fixes =3D Fixes: %h (\"%s\")
>
> You can do
>
> git log --pretty=3Dfixes 3401299a1b9e747cbf7de2cc0c8f6376c3cbe565
> Fixes: 3401299a1b9e ("de6*/dl2k/sundance: Move the D-Link drivers")
>
Thanks for pointing that out.


> This problem actually goes back further:
>
> git blame 3401299a1b9e~1 drivers/net/dl2k.c
>
> shows it was broken in the first commit in git.
>
> So the correct Fixes: tag is:
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>
Regarding the Fixes: tag, I have one question. You suggested
1da177e4c3f4 ("Linux-2.6.12-rc2"), which is indeed the first commit in
the current git history. However, the actual code change seems to go
back further, and I found it in the history.git repository.

In such cases, should the Fixes: tag refer to the first commit in the
mailine git tree, or to the actual commit in history.git where the bug
originated?

