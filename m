Return-Path: <netdev+bounces-90555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC60D8AE798
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3213DB20EB0
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0AC1350C8;
	Tue, 23 Apr 2024 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uH2vRfjx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2042713443E
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877812; cv=none; b=mcikyoDnyVHGoYJLviiSEpK1bWa+bYSD++WvAlLeU55cmH1tNffDcPxmazmXDsyygdLL7G6RYG+aEjieVP6Q0oENBYqlgcdUmGYUvaKso6LjqLlALLWcPfVmdud/1VaIw+Us38Iu5Igxx1W1mK3npq2oxxBoGz4BQqXHugOkbZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877812; c=relaxed/simple;
	bh=1P7k7RvJJNQZz4x2X7O8+TQzEs61RgczBSx5UCLsVGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j981cgsLpXJiKRjsRCE5nVmuABEJg/0e2xNK2dlM/eU9BwfHMTilDrStREticlYeJFV0ft0dtUKW99OtjJJkXjjaXEvq13UnsguB85AlMRbXN/7FvaM+8IJhtX3pQIczuWt2bh7+7LRGvKXX8Pp65XrsnJUZz5YycEM+9kp2mWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uH2vRfjx; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572256b1636so299125a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 06:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713877809; x=1714482609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j+tHAbBEYqYv+a9EJ1bO9gjgAzEg2JlIOcDinuh8vPQ=;
        b=uH2vRfjx+3uuxmus+3npUoLY+5TqgKf8AELymiaFh6YzzAPAhSudD0cBb8EsoN1bZh
         5Iq+ODwY1RtaaXhlNdTkstJhUG4jGwCDdqo5I/CRKdhvIuA6OETf1gSDMsZShxzfuM8G
         pPmVkpdzsoL02/FnwrCCw9XpLFZN/I4xpdMp5xzdudOs1wCBdXjvzJuUWmwKdLBqw7ki
         zJLWpYbFqNDvgtLgvWVgHpUxghZ/dhr/ZlUfpEP6+oRBol0Bo9p2RXA8/nnMZyHlv0NC
         CM6SgqnMtHP27OB8SQtTSWii8YaiFey5H46dwrZr5xYMOFdAXjwZDoDrxeLb7vanMsYS
         iRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877809; x=1714482609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+tHAbBEYqYv+a9EJ1bO9gjgAzEg2JlIOcDinuh8vPQ=;
        b=sWIeGbNxTVtB40Tbr9FpvZg5i/PNdpWjqk2iFDZCMcaDb42Y89INrRUA3clVIVbkFW
         VZ/iaxALUFwXJOFT9FSNyjZGpS75VFPXZWdAe8jwdZisWU4T/rj8jt996eylyJo79Zs3
         /OaJarr0fCjlk03nBTOg13NEQ3Vo6MK6vQkTkZ0j2I82JN/fK1F8/mUfsLiXrAPUI0L6
         LI57P4RFXfUlUfoDypD7OBdJ86vQCXvDyldGqIPb127dTKnLzbTrG15LOD31VS06dtgi
         ZeyBcruPt/xIPx/xDuecUa36e64PUsfn3Dg0ZhtJTfXg79mXWYDxKPjBcS6iN2BRPI/N
         fNEg==
X-Gm-Message-State: AOJu0YyzTsG7aGz6j/mogthj26TQtzmRSnH0JuxY+5U+c86gTvn7LJrT
	QrROlJjp0hMUn/syXXw65LBNTrPo06kBT+L7fhYHeOnYBhBBdoCaM+WX2DxSYdc=
X-Google-Smtp-Source: AGHT+IFEyT49HObtzdIcu72CDONbq26VSg7xctXDfnuLgNBYOPR3yLQTDpfZdos2L+faXTyjz2txiQ==
X-Received: by 2002:a50:d589:0:b0:56e:355d:2ece with SMTP id v9-20020a50d589000000b0056e355d2ecemr724554edi.30.1713877809234;
        Tue, 23 Apr 2024 06:10:09 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id k4-20020a50cb84000000b005705bb48307sm6624224edi.42.2024.04.23.06.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 06:10:08 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:10:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v2 0/9] Introduce RVU representors
Message-ID: <ZiezLYNgc6fLijJp@nanopsycho>
References: <20240422095401.14245-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422095401.14245-1-gakula@marvell.com>

Mon, Apr 22, 2024 at 11:53:52AM CEST, gakula@marvell.com wrote:
>This series adds representor support for each rvu devices.
>When switchdev mode is enabled, representor netdev is registered
>for each rvu device. In implementation of representor model, 
>one NIX HW LF with multiple SQ and RQ is reserved, where each
>RQ and SQ of the LF are mapped to a representor. A loopback channel
>is reserved to support packet path between representors and VFs.
>CN10K silicon supports 2 types of MACs, RPM and SDP. This
>patch set adds representor support for both RPM and SDP MAC
>interfaces.
>
>- Patch 1: Refactors and exports the shared service functions.
>- Patch 2: Implements basic representor driver.
>- Patch 3: Add devlink support to create representor netdevs that
>  can be used to manage VFs.
>- Patch 4: Implements basec netdev_ndo_ops.
>- Patch 5: Installs tcam rules to route packets between representor and
>	   VFs.
>- Patch 6: Enables fetching VF stats via representor interface.
>- Patch 7: Adds support to sync link state between representors and VFs.
>- Patch 8: Enables configuring VF MTU via representor netdevs.
>- Patch 9: Add representors for sdp MAC.

You are missing devlink port created for each representor. Please check
mlx5 for example for the implementation.

git grep DEVLINK_PORT_FLAVOUR_PCI_VF

