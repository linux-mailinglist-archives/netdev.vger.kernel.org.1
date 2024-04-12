Return-Path: <netdev+bounces-87308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B47E8A27D7
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 09:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9329286D3C
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 07:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE76482FF;
	Fri, 12 Apr 2024 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="difjC7j7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4184D58A
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 07:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906481; cv=none; b=ci2aOtdXpH9zpqL579Vhlu9d/55BHMnU2cAvkn+7+ZVlIpFf8ZUNXslFOCE6pbiA8MdtkFa7L1IoebPSwj6rqKHAMFo8dgu6KnRs1yOFjAkdFyBmapASGZnrEeZwFvm8ZN2VW4cd/zgqwFNuvC3PWTwb5n8WO1G2FL68kRytwmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906481; c=relaxed/simple;
	bh=VPgHEx4yeITWUyWvduIV/zWYcay0QwpkqEsYb+K9LsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gq8DJVjxOKCBS36k6BxYDhd52dUd/Clwa/hWHkqCnZIJnS4NOymIsZ6uWmlwLRqKC6o2dyczLNRIPti6Ayc3JrN3X7rVayHjPf3mj1XRg52rLHE7WQ6heF6ACNVQlyn2g0r+S+9ivbzxgeLMLoNDboFjJzCzxxkDttnYYOkLetU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=difjC7j7; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516d0c004b1so858862e87.2
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 00:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712906477; x=1713511277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VPgHEx4yeITWUyWvduIV/zWYcay0QwpkqEsYb+K9LsY=;
        b=difjC7j78RPiY6vetZ7HthUvI4vYsr9zR2Mb6Q6IPiTTM6QsG2c8ZQD/nHmZ5Woggd
         jutws6wvsjvHbnKHdRy3xXimYuJw5tQ3aKTvEz/jvdkFX9wu/OzTCzts5PMBjWVzvhAO
         uauXcFMCLSQkNn1iaKUg8LzhF1I2G4+tDjDKAqYqjP53dEbVnQfeJT00xR/URWCKt+0y
         E7VCoVi9OP/ThZEhVYh4qOFZNT0PNrOc7qOfBMNqDSd/QzDnhyPIxyW1nxDTgEjASvAG
         C/kw9rhsHOHyZQ+dnSLLyFi8J7p1gG5xXslYg6IgW5NeXCCioa02Rk2SDQBMWy/PNNen
         S32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712906477; x=1713511277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPgHEx4yeITWUyWvduIV/zWYcay0QwpkqEsYb+K9LsY=;
        b=dueMKJDqBsSan/dHQYG708hwHXoRNct02x+2oq+mFZQL3R0VoFKvi7jTcuu9g0L+TN
         40P7jGuhEBmdgtbrJ4xKKIF08FApsMSvyjDvU7ll21olp+AJ1beZR7itKnFa8/0JvUOo
         ChuBmy3FZer+o6o41TZL5k3ULuCo9PDJ4DpazhUlj2w0a3Ei+OeVnPcWPr3h/DnriSXB
         dXBY2EqKSn4hPrRCyweMFcQRsR5PM/tePEEIP/DYChC90e38TD5gq5V2i1dxVRxXPZus
         mda8+JFtXmitnh3RHXQfKtrTbkA8d1x6qBSu6x8R6pN3CDBzLbA7Xec7Vv3dKVqOevux
         +vJA==
X-Forwarded-Encrypted: i=1; AJvYcCWH+wtGbb3V6SSJSR7bqXTVv5zZe5FhimNdRAEbJOrmk0AdpHh21X3sjxBrZchDEZQkqeEfsqqlqnpVtjvy6Sd+vL3A4wdm
X-Gm-Message-State: AOJu0Yy0qmT6wgF82PyWTWn3tO8cJSWZu2P61GrxauY1hw7dOaABT82l
	g4hMhdKe4+lH7dpelXIivnPu+ykRgARfF3AMGN7mMu1rkSXWBwK4WRize0t3bfM=
X-Google-Smtp-Source: AGHT+IHQaoqkaYxyV9GnjMQVUT9kFnPy1FEDhAnqtFFeWHjj/2GfMDxoHJGBJx70B0SdoiFqupHz1g==
X-Received: by 2002:ac2:44a2:0:b0:513:c4d9:a0d9 with SMTP id c2-20020ac244a2000000b00513c4d9a0d9mr1293220lfm.22.1712906477431;
        Fri, 12 Apr 2024 00:21:17 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u26-20020a056512041a00b005175e94dde1sm443478lfk.79.2024.04.12.00.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 00:21:16 -0700 (PDT)
Date: Fri, 12 Apr 2024 09:21:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	mateusz.polchlopek@intel.com,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [iwl-next v3 6/7] ice: implement netdev for subfunction
Message-ID: <Zhjg6noDXGROVPuu@nanopsycho>
References: <20240412063053.339795-1-michal.swiatkowski@linux.intel.com>
 <20240412063053.339795-7-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412063053.339795-7-michal.swiatkowski@linux.intel.com>

Fri, Apr 12, 2024 at 08:30:52AM CEST, michal.swiatkowski@linux.intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>
>
>Configure netdevice for subfunction usecase. Mostly it is reusing ops
>from the PF netdevice.
>
>SF netdev is linked to devlink port registered after SF activation.
>
>Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

