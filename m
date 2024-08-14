Return-Path: <netdev+bounces-118376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4071E9516DB
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F5AB210FC
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A931411E9;
	Wed, 14 Aug 2024 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CQp0g6iA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D2913E02C
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625040; cv=none; b=jMCFxgGoCezzFWyHBVpP9vMdexR0J8yGvpyqNVU1rxYDd+BWgwr81HpQRkjAEK5sUwiLrnPCmGGChlBPgzLx7bnoaMWJgaDV14FNOElNn4Gy6ELQKqlMyLwh2BqnBVgN5huhW6xiTdw3KmIVc6QSe6a288DyoU/l7JRlyF4ZT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625040; c=relaxed/simple;
	bh=EVmZgGsYG4J1+rEh0MegTFo2+BsMrBN27KN/AProGYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duOuCitcnag+cRRuyUxF9qkl5TsBJ4DnGXgWqrdiuN1q8M4ROyT/dSimihFsrN4aMR/UVZpR0e7HpYcegTVcPlO3BQL7O75iDEgqdbRDAjEk5hLsRbeHIGp6GGgaxBf3USND3t8yJopvxCFd5PEqUyPvcGi4rhCOCzR02yfrpjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=CQp0g6iA; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f025b94e07so75338661fa.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 01:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723625037; x=1724229837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVmZgGsYG4J1+rEh0MegTFo2+BsMrBN27KN/AProGYY=;
        b=CQp0g6iAjfAZjeA2OGW+CciT5cHDsV5PCGUm5k9+5Ep8XlLQk6tpWx3Y8eOuGqEhfq
         ql6bJTmjT5iqBQ1O236Q0TkVZ06kFGgEXsRNSdaPLr4I8NCpPdcHbDJo65BTljfKEMyU
         G3N6dgkU99Xmecoti2GFfsmkbJdsKsAWWBBqHasHt1NfLrkOrZIJtZG/84Oq585B3uWR
         WabST8a/c+Gt0zkOEX7kPCV7F20sn8t/SXJvsRTG84WKQP0wSGIN7C0Eggd2I7Ap+Gdf
         pd4fxYQz+6QfPAOf2+mnPPbBRXhDYNEZDzzuU5B0p2NjEHWg1FSEFch6JSKDZo0D+aIn
         hIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723625037; x=1724229837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVmZgGsYG4J1+rEh0MegTFo2+BsMrBN27KN/AProGYY=;
        b=ZgkG3NaebiBKT3zmj8RC+rcLrxWZMjYnDh+zGu/FMY7Is1Bh9Pws9BOa2S6Azd3Qt6
         YlurJ44HaX80Ds3CDezOOVtcR3JWLZT48X1hFVI7B0MTk9y2xdIwGKslBNcaftZpfk/7
         81x9khaUevRAg9dI1WTQHGAv4jR5cww4YJaIcdr5JK9A9hUH40FIEGveHyYhv8B6LP9b
         HnzggANzoKM/hZ640hQkjHuNFMfgbVTMkbci5iC1pgXxLDOi2CWeHL54O+p7ddR5W8xa
         YR9EXS0vsPXRF4r9XAyG1l0JMdhpYCg835hYKBL7PnNO/UWWjoOeV4RTy8jpf6EvQRTt
         FlVg==
X-Forwarded-Encrypted: i=1; AJvYcCWDy9R/gY2t0G58HDZhVinqelUQxulVHlThH+kdz2stllqaW/mBfoIcn2tB4vRZcX17bItw/rAxdBbQMQffc99RjlSLamho
X-Gm-Message-State: AOJu0YzzD1Hxps4f/h2VvK4grBLa1uxI5JP1GIW6EEnC/7V1+pRtUbnP
	zbCSNxI2qsmvySHTdm0e+x5TysR3tffI0LCgKQ+a4n4y+kO4mKYTOmZIKHzZW28=
X-Google-Smtp-Source: AGHT+IEyaNpgjlsjAUbO+RXjmJjaR8Q8nxnI/GjZPOULCeMGrARVo1uwXUbWuyYzXHUedxCZuQVwMg==
X-Received: by 2002:a05:651c:50b:b0:2f1:5c89:c893 with SMTP id 38308e7fff4ca-2f3aa198764mr14411481fa.8.1723625036861;
        Wed, 14 Aug 2024 01:43:56 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a6031f0sm3642385a12.85.2024.08.14.01.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:43:56 -0700 (PDT)
Date: Wed, 14 Aug 2024 10:43:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com, jiri@nvidia.com,
	shayd@nvidia.com, wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com
Subject: Re: [PATCH net-next v4 00/15][pull request] ice: support devlink
 subfunction
Message-ID: <ZrxuSkbu7PEAmfa9@nanopsycho.orion>
References: <20240813215005.3647350-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813215005.3647350-1-anthony.l.nguyen@intel.com>

Tue, Aug 13, 2024 at 11:49:49PM CEST, anthony.l.nguyen@intel.com wrote:
>Michal Swiatkowski says:
>
>Currently ice driver does not allow creating more than one networking
>device per physical function. The only way to have more hardware backed
>netdev is to use SR-IOV.
>
>Following patchset adds support for devlink port API. For each new
>pcisf type port, driver allocates new VSI, configures all resources
>needed, including dynamically MSIX vectors, program rules and registers
>new netdev.
>
>This series supports only one Tx/Rx queue pair per subfunction.
>
>Example commands:
>devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
>devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
>devlink port function set pci/0000:31:00.1/1 state active
>devlink port function del pci/0000:31:00.1/1
>
>Make the port representor and eswitch code generic to support
>subfunction representor type.
>
>VSI configuration is slightly different between VF and SF. It needs to
>be reflected in the code.
>---
>v4:
>- fix dev warn message when index isn't supported
>- change pf->hw.bus.func to internal pf id
>- use devl_register instead of locking version
>- rephrase last commit message

Could you at least mention in which patch you do which changes?


