Return-Path: <netdev+bounces-162249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B39A2656B
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D15163F6C
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8401BD9E3;
	Mon,  3 Feb 2025 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="t32zItGm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9792F35944
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738617412; cv=none; b=KFVZ9SJRW2BZZdwRoJo920Z5MP8YMvhRqfIgLIOxRq19QjVDh360nfhRnZ+t9ebcFgmzJaq4yJP7C8UNbLLWRisTF/BMV6sjFECYy0B8iSZmTGapmD7/mEUj6SOfCATV9778d59S38csQ5EJk1uo/McNnoD52wvGi4k+K+3wCfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738617412; c=relaxed/simple;
	bh=NCh5YC5RoPHoE6MCYvlXPMBa1pDudEydL5Ou2bpwmuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhC1FJipfckJnlpvq+NAUGungHoo2JNID4RnZrXhWpXow+NaluGMjk/X+Ruaje3upc5+9HdCgUrRxgygXDvAseysOYqdR1v5VkoaQr3FFvy/jdKdEX4GLNF5W3Fh0RgU45/IQQTuuSDkBsPKMinp+gLrA2HzX2Xp1kXrxlyLkkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=t32zItGm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21619108a6bso82038535ad.3
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 13:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738617410; x=1739222210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQpJpqJrOZXq/O/oWy7F8BjqFljp4QxhfcB1hBDCBLI=;
        b=t32zItGmU4+SWg/ZL+DdlI/PPix2yNvpc3g05PFoVoTKEuyKHilWBaaD/61ibm1cCj
         zImuijPDtiqLYADg9wfs8mXtcDL7axmre3pkr7oG7lEOBk0TeZMGsgjUna3RAU5P+gEX
         AQa+mMM3ByfG/XbeMX2oA0lsG3fBmU7RCWfCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738617410; x=1739222210;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQpJpqJrOZXq/O/oWy7F8BjqFljp4QxhfcB1hBDCBLI=;
        b=wKetEfe9Uax9zXao4eUEucyyFXNovA9GPtd6sBIWjrpQrDhLDyoa4QEl28XmxxFeYx
         Mlvi6SvtDrWCF7ML6uVVFRWKmOplKoPPEtrZDieCNDm4smuv0jlnCke/VNW3t7LYAjmD
         1y/lUmCR73tl0wLp1hJqovELWg48dLAWL10HwEm0DOPiPzH6cq/0X9TsHOP9r/TKa2JI
         2roDtGrT/HJb0NI51A1hfRxyd8aIbOUaahl1tciS7la+zQbOahZqB+uYHW2/w3OBS/X5
         aRBa0MjyVsAs2VEZUtSH7xzROFW0+/rj7pLN9g89N/2tJQRp3/yIl/GMUF2uWx2FkwUG
         d5Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWRCyQsxCIJ3QIqUJ790I3x8jT1xOc2/krBHnNGF4wxPeuxG4KvkRk/FhMUzAIEc7SO6l4Iluo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0GtiOvY1uneevppGCj38dpw+72hBG+pVFVzXV7MGs1A537iHY
	s3qVTHuYiAcHR2yutI5gJLOnbQZpbAOiMlYdQUk4ENT5952pkGwUp/Wmm5qx47E=
X-Gm-Gg: ASbGnctCoko1xwzpfuYtUvV5AufX7xR6I0tY1MHSQBYjvuczUoP+6czRTJ2lNNFo/vG
	D/z3xSCKVtb5X7pU3gACLIVVqDiHsLaja0MLXMVWn6UuLObwBn6z0xK/tkPiiBV1V7Qfpx0SVjY
	R/MqitDit+nbP6vr2UvOJsZSThMGlP3LhiaFSSMj0pNWh0nus+WQV+qRTZzZxMCbnpTAmlI/nTW
	VNifigaxr5LP8zZinjlxU1GbCyypA8MSeDeq8vu9ChaRFYuzDPeSoSCnqgL5+mYpYOm/HCqKJII
	axk9Kx6j8kkExwiEXFGYb2MEDbVSPshv8XIDjgVIBDEUuDyC3L8is0OFkA==
X-Google-Smtp-Source: AGHT+IFZ9oH/CBc2uW8bRHsQMayYD1DjbR72+w6rfVkDF+kjhPhQ7oc3xagXEJ2XltGlha9Bx+v8Aw==
X-Received: by 2002:a05:6a20:438c:b0:1e1:ccf3:a72 with SMTP id adf61e73a8af0-1ed7a5ef586mr37737542637.28.1738617409861;
        Mon, 03 Feb 2025 13:16:49 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba489sm9125261b3a.99.2025.02.03.13.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 13:16:49 -0800 (PST)
Date: Mon, 3 Feb 2025 13:16:46 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, ecree.xilinx@gmail.com, gal@nvidia.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net 2/4] ethtool: ntuple: fix rss + ring_cookie check
Message-ID: <Z6EyPtp4rrCYSCTb@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	ecree.xilinx@gmail.com, gal@nvidia.com,
	przemyslaw.kitszel@intel.com
References: <20250201013040.725123-1-kuba@kernel.org>
 <20250201013040.725123-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201013040.725123-3-kuba@kernel.org>

On Fri, Jan 31, 2025 at 05:30:38PM -0800, Jakub Kicinski wrote:
> The info.flow_type is for RXFH commands, ntuple flow_type is inside
> the flow spec. The check currently does nothing, as info.flow_type
> is 0 for ETHTOOL_SRXCLSRLINS.

Agree with Gal; I think ethtool's stack allocated ethtool_rxnfc
could result in some garbage value being passed in for
info.flow_type.

But I don't think it's worth respinning for such a minor nit in the
commit message.

> Fixes: 9e43ad7a1ede ("net: ethtool: only allow set_rxnfc with rss + ring_cookie if driver opts in")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/ethtool/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

