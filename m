Return-Path: <netdev+bounces-56553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD15B80F57F
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 19:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046C71C20D06
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 18:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C761E7E797;
	Tue, 12 Dec 2023 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcYV7cdJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BD6CD;
	Tue, 12 Dec 2023 10:26:27 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c55872d80so4204035e9.1;
        Tue, 12 Dec 2023 10:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702405585; x=1703010385; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hkS1sBD/3B08xTp4SHRHL7iiVCHyuQNhFokioYY2los=;
        b=GcYV7cdJPrVxjxzAW0Vopy707Moio+JgJTXHEApHTA0PmrP/C/E4RxPliVCI6xUi3m
         ACQDaZV23joJDlx2EhrIH3MN19f4ZRMHXrjavUdV7KnhJ5SFNJXqbO5mCqLlyBPJzF7l
         fKBjtGCLMZZ3o2CNwSiGo3wDj3H0s3g3OYDcdXh1TJwebCl7kQD7wVKy2iCfoxTSjG39
         etupsBp/w2rFb/SiAAffw/cv/ep95tD4SNgn3MgwlcrImcfuhxv5xaxS43xTxuxxqLH7
         YNKxgQKVGvbs0sAr6gJ48TfEEkEwSmmUdCqO1wr6wNm+BsltefipMvxKW/XUSsZUwUVu
         Udnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702405585; x=1703010385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkS1sBD/3B08xTp4SHRHL7iiVCHyuQNhFokioYY2los=;
        b=g0PZRAN1fkrhIz6/xt/FIuXxawYbXiLAo/7VFzCwuhX1zhjcQUD+9KL2jFxRbojMOO
         ycJkkLtDcNqAi2CS1mhuyv6sIxHoGnXGCl57CrgFGdz7s0JRsOZ3CdXrF1jWqDEzgZw4
         qUbaloTXfkxuy5NNiWROMaGBMCJOazi7+fJNV1d6Zvkz1Y5Sc0znWrgq96/Ky+aNySio
         rjsF9L/AvtVKrLyKSzWbPVcVROfGs+0s+TovYnIMgRI1drN3im52YzYIy9W+FRkvpXMm
         UsZsknbhw6WipZqQEdGGIBo7CPccEo58OmZg/a/hOjUl66hMnBNmh0IYBZnBa6abOrO9
         0KhA==
X-Gm-Message-State: AOJu0YyY3G0o/rmM8bNdG2apPvQIbeoh/lt+cMLfMJmVEibVaIyFde8S
	AcLWW9wuWwboSRLON8Roba0ZVogD2VRX9iG4XH8=
X-Google-Smtp-Source: AGHT+IEba4DdBfnMii4Z9zAnc1E9yXjnBPUK4GFfz90NN5jzPgCh/H8iKeVjoSn8lYHWn/TkMYopGm9oF1BQeO8AS6M=
X-Received: by 2002:a05:600c:138e:b0:40c:53c5:ed5e with SMTP id
 u14-20020a05600c138e00b0040c53c5ed5emr694738wmf.131.1702405585098; Tue, 12
 Dec 2023 10:26:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207123437.42669-1-dg573847474@gmail.com> <20231212102304.4f37c828@kernel.org>
In-Reply-To: <20231212102304.4f37c828@kernel.org>
From: Chengfeng Ye <dg573847474@gmail.com>
Date: Wed, 13 Dec 2023 02:26:13 +0800
Message-ID: <CAAo+4rXcmwMqMFcGqf3nJV+H4UQ_G+yt=2PvoMVSsBGiXsJnvA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] atm: solos-pci: Fix potential deadlock on &cli_queue_lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: 3chas3@gmail.com, davem@davemloft.net, horms@kernel.org, 
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks much!

Best Regards,
Chengfeng

