Return-Path: <netdev+bounces-89340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA80B8AA107
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44754B20FA6
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65815172BC6;
	Thu, 18 Apr 2024 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ocDypQjm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C39B15E20F
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713461145; cv=none; b=jqKjiKEYPhcsbmHlk3HFEnBuBckhVt6bYUKXOuAY9QRs6iqRsYErSz1AvHDAMkpoQwImbtIbueMHQUc4zP29ZAQT+OHvBwFr6VbkUOQanVu0i3JZp3AKkeXGZzRnexPosR+g2NIjkCqFmCTATcooPcZuD9Jm1+Xw9PwYIsucpYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713461145; c=relaxed/simple;
	bh=w9SZnApHyBHOUonz8cu+jVtYHycCUgnp9/31l8txaeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RldD2GLlmYvLxB898OKS2Xl6zkqSTZj5wowNvnyqHZwWLly6SLKyGDt+NA9dxB/Vm/ERA1SPwVhtHOTpzqsxVIXFHiyrnuiSNCbiuDCiHv85vJ8DOddvrTpVYTfoI/LN+g53M32VZXfYUF90eroORT9/6EqMcWG2E3VtkmWcZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ocDypQjm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-415515178ceso8869105e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713461140; x=1714065940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHecw+rzO+LWiL74K7/imim+VobAIrmgiBEeiSPPzs8=;
        b=ocDypQjmLFC8TGN1Gqkyj8fm6OVxgr2zAPaY/1Md+a/UOdtqnyXvdU8RTOTaHfrPC4
         eVDBJSVS7mBa6orbe+VMnxv3UgGsNVq5AepG664UFVqlXqr68fJ1E4mYqBysOU6iB9hP
         nfh38oHkWMoVSxrxSWji8bljfQjZj6wa46kCqSaoIsKSonHrcrYw/lDWDSdbPOw5Me89
         FV5/sQY7r7R3X2cWESvQ2pXzg3rbo2A19TUWUmOi3xd8CJMM2ed99DNGlgSWO3uoltcN
         EoUsI9OmK4JDAe/VtNXrD13CGe9Iu6aLSFvRUI5hUKhTJgfSpEAbNx94/GG4nutwK+Pr
         EJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713461140; x=1714065940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHecw+rzO+LWiL74K7/imim+VobAIrmgiBEeiSPPzs8=;
        b=wlARCTmtiVBpclHRFKxnKswicf5dP5AP6wdAq736/Gx7F95cAtWir1MGrUYpSoxx33
         NC0XMTtA8e5mk5TWWOf45iGmpCqL4+yJ0abP/WhjhCRLaU+1ckBSKzx+Pdp6Tlqf5uym
         lNgADutffyMRG8XKG+zNDyxLOnYfGKbV1S72bfvIB7v8pNYuvDJfmbS03UWkVm4KCp2X
         4Fxd8nPDNu9OJGLWbw4nVE399z+tBS7xBEKwhEh7wzmyDPqPHocSGx6UAbBk0rp9JJH3
         evJ2Ak1UbvCxAojdwZr+CNtyAe6arSc6mi+wq19c/Q/qmFvkvCa/ICb9zjE05nCLyyEJ
         xkeg==
X-Forwarded-Encrypted: i=1; AJvYcCUjxeysDH8Ut5axuAdok2EDxTwn7Ene9S9d6w3v9ZuqUiw1eufSuhGn6Q5djsKZBAIFjRbNTTf7aZ3sSNt59mGS+8e/2kFz
X-Gm-Message-State: AOJu0YyMVd2+89Eu36TFVitIKRX5g2V83fn2LxhDu9Frv9SdQE/PQpGB
	pF2EVnZeB0nguuilhpYGqtnGly5PTMe2maAhhDQx1WjkUm50Iqm+J2LP2XJNmmysrWhJcw8cIqT
	mn3A=
X-Google-Smtp-Source: AGHT+IGUnOs/6X+o4eoVm7vjfPWuKC7TcN0KjqK38tFoax52+2CFzsdhF0TDeQVPAqauerg+LGf+XQ==
X-Received: by 2002:a05:600c:1c91:b0:416:605b:5868 with SMTP id k17-20020a05600c1c9100b00416605b5868mr2314550wms.35.1713461140130;
        Thu, 18 Apr 2024 10:25:40 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b0041563096e15sm7238238wmo.5.2024.04.18.10.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 10:25:39 -0700 (PDT)
Date: Thu, 18 Apr 2024 19:25:35 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com
Subject: Re: [iwl-next v4 5/8] ice: allocate devlink for subfunction
Message-ID: <ZiFXj-58u2shLL3g@nanopsycho>
References: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
 <20240417142028.2171-6-michal.swiatkowski@linux.intel.com>
 <ZiEMRcP7QN5zVd8Z@nanopsycho>
 <ZiEWtQ2bnfSO6Da7@mev-dev>
 <ZiEZ-UKL0kYtEtOp@nanopsycho>
 <ZiEyP+t9uarUrLGO@mev-dev>
 <ZiE_nUEsGT8Cd3BK@nanopsycho>
 <ZiFGOkSMWs+/N2vI@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiFGOkSMWs+/N2vI@mev-dev>

Thu, Apr 18, 2024 at 06:11:38PM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Thu, Apr 18, 2024 at 05:43:25PM +0200, Jiri Pirko wrote:
>> Thu, Apr 18, 2024 at 04:46:23PM CEST, michal.swiatkowski@linux.intel.com wrote:
>> >On Thu, Apr 18, 2024 at 03:02:49PM +0200, Jiri Pirko wrote:
>> >> Thu, Apr 18, 2024 at 02:48:53PM CEST, michal.swiatkowski@linux.intel.com wrote:
>> >> >On Thu, Apr 18, 2024 at 02:04:21PM +0200, Jiri Pirko wrote:
>> >> >> Wed, Apr 17, 2024 at 04:20:25PM CEST, michal.swiatkowski@linux.intel.com wrote:
>> >> >> >From: Piotr Raczynski <piotr.raczynski@intel.com>
>> >> >> 
>> >> >> [...]
>> >> >> 
>> >> >> >+/**
>> >> >> >+ * ice_allocate_sf - Allocate devlink and return SF structure pointer
>> >> >> >+ * @dev: the device to allocate for
>> >> >> >+ *
>> >> >> >+ * Allocate a devlink instance for SF.
>> >> >> >+ *
>> >> >> >+ * Return: void pointer to allocated memory
>> >> >> >+ */
>> >> >> >+struct ice_sf_priv *ice_allocate_sf(struct device *dev)
>> >> >> 
>> >> >> This is devlink instance for SF auxdev. Please make sure it is properly
>> >> >> linked with the devlink port instance using devl_port_fn_devlink_set()
>> >> >> See mlx5 implementation for inspiration.
>> >> >> 
>> >> >> 
>> >> >
>> >> >I am going to do it in the last patchset. I know that it isn't the best
>> >> 
>> >> Where? Either I'm blind or you don't do it.
>> >> 
>> >> 
>> >
>> >You told me to split few patches from first patchset [1]. We agree that
>> >there will be too many patches for one submission, so I split it into
>> >3:
>> >- 1/3 devlink prework (already accepted)
>> >- 2/3 base subfunction (this patchset)
>> >- 3/3 port representor refactor to support subfunction (I am going to
>> >  include it there)
>> 
>> Sorry, but how is this relevant to my suggestion to use
>> devl_port_fn_devlink_set() which you apparently don't?
>> 
>
>Devlink port to link with is introduced in the port representor part.
>Strange, but it fitted to my splitting. I can move
>activation/deactivation part also to this patchset (as there is no
>devlink port to call it on) if you want.

You have 7 more patches to use in this set. No problem. Please do it all
at once.


>
>> 
>> >
>> >[1] https://lore.kernel.org/netdev/20240301115414.502097-1-michal.swiatkowski@linux.intel.com/
>> >
>> >Thanks,
>> >Michal
>> >
>> >> >option to split patchesets like that, but it was hard to do it differently.
>> >> >
>> >> >Thanks,
>> >> >Michal
>> >> >
>> >> >> >+{
>> >> >> >+	return ice_devlink_alloc(dev, sizeof(struct ice_sf_priv),
>> >> >> >+				 &ice_sf_devlink_ops);
>> >> >> >+}
>> >> >> >+
>> >> >> 
>> >> >> [...]

