Return-Path: <netdev+bounces-42427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816477CEA18
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 23:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21672B20CAD
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 21:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0C13589B;
	Wed, 18 Oct 2023 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMYLrq/W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9076742930
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 21:36:21 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A35210C4;
	Wed, 18 Oct 2023 14:36:20 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40806e40fccso16400635e9.2;
        Wed, 18 Oct 2023 14:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697664978; x=1698269778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCVhrp90okWSl9RRgMNdpBPnBJhruFjjACD6W7aKPnE=;
        b=fMYLrq/Wp45Ig88rjE3KTV0ATRN2Ui6Q+yQhIhCyG81hL+Hfpo/HSUyoI6IS9S2wZe
         Mol6t6hncOWwXXCCYwfn01MUDGDztJ0KHJQTcu1aCiZsafnm69dFzBxh0g08CRpEz+kO
         1MB5JXE/KTGn36iuvqEeN3vmszxGTEMo1P1p+RH9ZEQdRiRi4ACyoOHfWBvA31TkGpVm
         AwaTzhykr830pSOyQNsC/P4QavSGU2jj47YKFhMZycLnudCSbSktB/KifFf5iPbpBPal
         hfKGw/ryAx9H8UCo69/mRD81ScA86XUzIwzsUn6YS1ruEjI48F3VEmU/ryZq65fFRGwf
         TOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697664978; x=1698269778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCVhrp90okWSl9RRgMNdpBPnBJhruFjjACD6W7aKPnE=;
        b=LnURJyIRn93elarE8MxRklVxjhBvKkWiXLHp5vDx8dfUHCNLkHIVLVQhwwKJtIZNaQ
         E/3dlEMOy4Z0ouHTDTJxlth0s4E6Gx4SnSVxPVYlOMNizERwE0ir0REypNh0TpclMc62
         gu7na9QyePw4fUDDL9cGQSbk5M0irdWgpalnqdzp2ptTfCE8Go35Me60tANgEHB3F5Tc
         qIcrRDkrTYL/b0cgVpZkOZIGNzYZGryXjBttAgM6j/Vwrm4Ive/u8JcQaWekOBZ1jsx5
         AnWXL8WXmAvgIWVr5fQRhHMhBj80rNowDlEdyTHKLOXCkF9gqZHaWXhIZwnUKmfCvH6S
         sH5w==
X-Gm-Message-State: AOJu0YxuncAz0w5at4qArHaIwH139YzV7Kp7uqN08TO2xUDH1mIwCj1c
	2bobm9NkrPoaR6vAbXDk49k=
X-Google-Smtp-Source: AGHT+IHjqcHZlWwSZER6472scqSi0GlbXjVK2Qg9iOIon9lhuOzZOXx7h0ejemyGWbBMaK1zGnxvqQ==
X-Received: by 2002:a05:600c:1384:b0:408:4160:1528 with SMTP id u4-20020a05600c138400b0040841601528mr409741wmf.30.1697664978620;
        Wed, 18 Oct 2023 14:36:18 -0700 (PDT)
Received: from reibax-minipc.lan ([2a0c:5a80:3302:f900::978])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05600c3d9a00b003feea62440bsm2617007wmb.43.2023.10.18.14.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 14:36:18 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: dan.carpenter@linaro.org
Cc: davem@davemloft.net,
	kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org,
	reibax@gmail.com,
	richardcochran@gmail.com
Subject: Re: [PATCH net-next] ptp: prevent string overflow
Date: Wed, 18 Oct 2023 23:36:17 +0200
Message-Id: <20231018213617.3196-1-reibax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <d4b1a995-a0cb-4125-aa1d-5fd5044aba1d@moroto.mountain>
References: <d4b1a995-a0cb-4125-aa1d-5fd5044aba1d@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nice catch Dan. Thank you very much for the fix! Looks good to me.

Cheers,

Xabier.

