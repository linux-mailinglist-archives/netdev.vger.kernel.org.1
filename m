Return-Path: <netdev+bounces-50383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C81397F581B
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 07:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593CB28177E
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 06:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AD9D2FF;
	Thu, 23 Nov 2023 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUb2NuNO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FA4110;
	Wed, 22 Nov 2023 22:21:21 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cf79a1e6c8so932135ad.0;
        Wed, 22 Nov 2023 22:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700720481; x=1701325281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cKEdH0ZwdUoNKkeGpsCW7ySfBW8S/qwXt1FLa+Woc5Q=;
        b=QUb2NuNOlvAR3HPpWbO94CTzp0MFk3VOR3MVqqh8AVzjBE2lO61lI+1nzL2z4Pomy1
         Tftl3PDqXvGmfx7gyxh4bPDlZqtlhxSALxnuvmGNX3FbiMQaNvM41oc9bq9T+DLECkJO
         /gxPBACYF/p3mCKqqW5u/oNMrDCCwQBH7CMyMZNcFbzczVKPU/X6IdMvz8nbayjbU6FP
         WXS6gJPyR2J0u3NDNQ3UTLGNSaD2ezRdbDPsV30COrXTRV6q9o7hXEWx7dJiilsni4F6
         TOIJc18A/xLgMUVcmWjfq5qcmqRDCJjAdDxH1SWS8h0kO01VKDCdtpwdJeI9dFLjvWDf
         2bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700720481; x=1701325281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKEdH0ZwdUoNKkeGpsCW7ySfBW8S/qwXt1FLa+Woc5Q=;
        b=TYSlK12EOyE1M7AND32U/kd8V2dAZjFK3BT4R8U49Ua58TxdUX8h0QZb0DRlqI3tiq
         nIJtCWdhVLsHJ+nP/dmgwPjqqgctgLR7ntojzBVP66930Khz8/QEXbgMV0xQzzt1jUpx
         rOSyf0lVJCjCakzps+ATbgPHw7V1K/P5CrfmF9bTNo/nsCBG25BPGjRd0nBlZvw9jRCx
         f3iGXCTtHdQ6KxG8FySE95casqwiPAh9J0Z7L4Kn2AEIkRKWcG86n1/QZ6hppOgBPQd3
         rqmxeYcWtd3+Je9DNZr+q1IZwS4wSPAXZFZ14jTvDUcOpu0HSqtulFjQLJcI+6QyqcZX
         A4rA==
X-Gm-Message-State: AOJu0YzK3jjfJDsO/BKweaoOQAoonTndJFZINhj+/P4QXUZlyYf6fLke
	eLQ3Bl5GyxWj3ggoqBNI8G8=
X-Google-Smtp-Source: AGHT+IH7FPv3CE4beFh3fe2WnQA1th0QiOX5i2WEz8gDzrCmQrknUbis3uYa0pNrLHuAWlJm8kgEPw==
X-Received: by 2002:a05:6a20:daa3:b0:188:67f:ff2c with SMTP id iy35-20020a056a20daa300b00188067fff2cmr5957434pzb.0.1700720480875;
        Wed, 22 Nov 2023 22:21:20 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090282c700b001c5f77e23a8sm478677plz.73.2023.11.22.22.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 22:21:20 -0800 (PST)
Date: Wed, 22 Nov 2023 22:21:18 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sagi Maimon <maimon.sagi@gmail.com>, reibax@gmail.com,
	davem@davemloft.net, rrameshbabu@nvidia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, maheshb@google.com
Subject: Re: [PATCH v1] ptp: add PTP_MULTI_CLOCK_GET ioctl
Message-ID: <ZV7vXuJMMtuxZyTT@hoboy.vegasvil.org>
References: <20231122074352.473943-1-maimon.sagi@gmail.com>
 <20231122201058.0bfb07a9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122201058.0bfb07a9@kernel.org>

On Wed, Nov 22, 2023 at 08:10:58PM -0800, Jakub Kicinski wrote:

> Please CC maheshb@google.com on v2, he was doing something similar
> recently.

+1

Thanks,
Richard

