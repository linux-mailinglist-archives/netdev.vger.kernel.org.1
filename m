Return-Path: <netdev+bounces-67970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56626845819
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 13:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8DA1F27FC4
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 12:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E9D86645;
	Thu,  1 Feb 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mc8tgVQi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BEFBA4D
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791848; cv=none; b=ZVL5tQTY380LUI8Yk2f6HUlyoaBh3mQzYpMn3gNk8LdyZX7yiTOBEVYBJN57UJb0DqaJfo+ylNnGWoEtNLXMlD6X0nEtb6tiNd10nQJWRs3lpQzylF3DyhIFEuTLGXy6RhCxbUkNBuBLfBVA/lOWDaJbxRKKongcam0FgxBmdi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791848; c=relaxed/simple;
	bh=WtvuY2p3vI+yBPkAKuo/O6L5ywa9aQADa00BHoWltmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+jGpc8sxqwOv6SfPJoVNomH5Nagx4pReSpDye31HWmlPlpiBOFX4kgFY49XHhKW7bBDnQvYfhrml+nvjAMkgovJibQ/SdmVBa7Nzf8OTwhDKZwwgpS4bkzOUlqaRCLiOcv+EaNg51RL28TtCVYwHUiC7OyAblOlemXaad7v53M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=mc8tgVQi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3394bec856fso1281122f8f.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 04:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706791845; x=1707396645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WtvuY2p3vI+yBPkAKuo/O6L5ywa9aQADa00BHoWltmo=;
        b=mc8tgVQizzz0mYr8sEjlyn0tdXbsqeccHVZqNuc3+wVD/8suOuCNzRZrgCTG/GYmjQ
         GABHdPQV1oFXpKI00mOpgnI8TtNB3w1ffHStZSQp3E4zWaH6mLA0WL3G3BCUGpgCLdAx
         pIoqtDlY7tIjrz5Ne66DxAWZeSU3DFPlmmiuXqDIwkr7wUsWArTGzNeDNcwrQFO8TL6D
         OWNDpblgf8tzNLUsImC21uA0kImefSz2aqr7Ii07wEv8YkqOLpZC9RGqXK/LIOBYhbSN
         V6pyDApCn8gtVB+37rlW0tDPqqX8P2iqN5BxCl3GViJWgsBKNwYhCXGZRqF6zXn67aJk
         VYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706791845; x=1707396645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtvuY2p3vI+yBPkAKuo/O6L5ywa9aQADa00BHoWltmo=;
        b=Rv0O7dfV6PyrY3W48l8Tr97LB65tP8iRu6zHv6sE/B9c/FLTpncOaVE4VmK/CAVDZU
         UOfa/TuWA9csB12mkwbeW0cBgBmZ5FYFL7zPE86bj7A3xs6Yly7GYnBbXnevTvB67SrG
         NB6icP+msXb8mYru0iV8UrGxWO22xPsit1NIB4zqHVxfkV4mGtiNAW/TuNfbjiHApe5U
         MCZ2mAY9GSrrs02moPOgjoxC/UB57+Y99U6gOPOBr8/RQNZiXzwd3mQTglhPH0ghzWLi
         pqobGO+1isTFR5myHfAzqRHz+/el+cxpIIKa+Eaz7Lgz118c/Gw+qu0iZ55v6y+JdPeE
         /IVA==
X-Gm-Message-State: AOJu0YypyPcqQ4lBfNdWUke6CBKou6EfKc2ZArV6shsFX+7PzOGqentN
	2nVL+OLh8roOxbTFc34cUhq/I9eocDRXF8GOH2m4DWnHdUbiO7uJMzTynN/Q/8k=
X-Google-Smtp-Source: AGHT+IFrMYJe0DoDwGSaJZF/UDmvwoWcvxpYm9cpMI7a/bLgWKGnbpiA8ruxDXkc/6TZ0/oqK2diqQ==
X-Received: by 2002:a05:6000:2cc:b0:33a:e605:57c9 with SMTP id o12-20020a05600002cc00b0033ae60557c9mr7675945wry.27.1706791844814;
        Thu, 01 Feb 2024 04:50:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXmMB2/XZoaa81471BBLnL/NlKPd0yc6SZ/ivCPQ9mv9Pu7Ln3ltBpo1fUEDnvOYgTUG2e/sDI1qNS2kXUGLqWvAw2Fibtvq8bImXBURhPAx1BD6Oz+Qod05lPhNgoHHJvsXgssoz2AYFWCBv1XFlBGgk2ZsdMFieGrKxnd4pL8MtVGHajaCWeAQ68oyPPa4iZf/jVwGM1n59gzGqduRz1AUytut6l1LPxZZD7hhLShaO1O0qA49Zusp+71oQnPb4huwZwNSPhHt6Yt/wYJGUo5Yfwifs2SxaqZquKjH5hVatDOLJz8Zi4agocK4BpViefVLO6s2TesROrKIHLV
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6b02000000b0033ae7d768b2sm12346618wrw.117.2024.02.01.04.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 04:50:44 -0800 (PST)
Date: Thu, 1 Feb 2024 13:50:41 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	donald.hunter@redhat.com
Subject: Re: [PATCH net v1] doc/netlink/specs: Add missing attr in rt_link
 spec
Message-ID: <ZbuTocq7fJvDRkcX@nanopsycho>
References: <20240201113853.37432-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201113853.37432-1-donald.hunter@gmail.com>

Thu, Feb 01, 2024 at 12:38:53PM CET, donald.hunter@gmail.com wrote:
>IFLA_DPLL_PIN was added to rt_link messages but not to the spec, which
>breaks ynl. Add the missing definitions to the rt_link ynl spec.
>
>Fixes: 5f1842692880 ("netdev: expose DPLL pin handle for netdevice")
>Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Ah, sorry about this. I wonder how could we avoid this in the future.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

