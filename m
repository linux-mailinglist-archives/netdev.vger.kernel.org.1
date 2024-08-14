Return-Path: <netdev+bounces-118379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6209D9516E6
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9486C1C218B8
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBA31422C3;
	Wed, 14 Aug 2024 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MA4I+/KE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF89A139D13
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625133; cv=none; b=KspuOVaapDwQ5tFufstjoQDcDF4zqDUkeXThGse5z3gJRSW4hEChIVhYT6A4MMHLbENE3KrxtSjenucfUgDfdIaV8RjFcOPJVs874SZsFhKRdPgUvF2Cp9BKIEr8lUcAxXBR0+jIeINpKeK7U/yWZW71yaq4CqQ5savkrSkVwTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625133; c=relaxed/simple;
	bh=J5/jo3hgryM8uNvFF7g2Ox+mflSd2uupsd/HG5kMIXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkhzx1bzpkXIDQMTNX2TMsird55xLGiuYI+sEeo1iPbUsqudWQaRfBXyZL0ajtqH6qrodGROgSim+jDknkpeKsfDZ561bTSbVF8bnVxeDTMZTKayI8prYxk+855lwSyEw8D/ostg3j/KjAhHrAeMN5Ow+QOuRYkP4ytN8tar9yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MA4I+/KE; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso74030531fa.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 01:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723625130; x=1724229930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J5/jo3hgryM8uNvFF7g2Ox+mflSd2uupsd/HG5kMIXw=;
        b=MA4I+/KEZBxnh67GmBoU1dH7WjC8KONaFsPnOayizRr/6052UMWRGj4OX7aS+viwZ+
         WoL8VzSXR/dtUPqd2uKvdNZZcIDygHi/zLLqQ/adMDdk9YIbStK0R6ffrQClCXMO+FuR
         jP4b2vcchiTJDy1M3vcMVdEAQtOsmx9jUqtlezYoT4LmpRhDfgvRMHgI1x1twXnbZYs1
         S89TnLr2cCq1IaiqaR9fw/RbduZYOgGzpUTf+vxC1S8CT87sLlvuOGe4h9FgYQeDJc1S
         fhVgJ1TSMAkBR8aTQNlDJ3lSofCls4aCKXPyDRHi+xYGgpbEgswdWiQZuPV+Am0+DrXf
         GYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723625130; x=1724229930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5/jo3hgryM8uNvFF7g2Ox+mflSd2uupsd/HG5kMIXw=;
        b=N3jFTTIAKLq6CvW0+NCaCVmofKJdxLdIlvAX/IlWFup5bDCGM9dN38g+fniZzlNHuh
         X0uk4Oo+mjWA83TKZQQ1CkdG6yWLwfBDOrd/Tj6UydN5YxDTdbAHZpg8szjvH2qkqeA9
         qIu0ooP0iJGzQIOD4v3b2SSvq6XMtm92oPjbsXejWTYZWkpwsT8EmqkN5K1EC4RYjHAf
         Hny2yIH2zLW+yzj+TaC1MvWS+bNz1jnjgAQYbhtZThB9n/GZdHHv2bByZejdXKmoEx6v
         AiKYQtPrgHn77tQ/u4U0y132xN/z+FwlwlN2KSwa8fZ4wOII5ZmDO84u4ZIT5Sd05J/w
         tH1w==
X-Forwarded-Encrypted: i=1; AJvYcCX+9EG1Zn4efBKLVAGDq2cuxuuyNc/yCAS2/IOcwvr6hgpUVrK1VW/DaD6QmmgO76hjmMAD7pLV4WDVFNa4dvv1mchIyla4
X-Gm-Message-State: AOJu0Yyrs/02LD1dM3bRiecFg2Dfuo71zmcXtpyE5u2aASd8RITXBni4
	oyDR2rwydb9VL2eUOUuMDfgMU/lmtwVT7CNSl7wf8Zc4ys+1aiKY0Nw7D5EHdNE=
X-Google-Smtp-Source: AGHT+IGcANcpSv267sJ1ZUOeS/o7nyV0NNsbZOApBdVdw1u4GSU/5InJvwxB+a4D59BFfqZfM77QUw==
X-Received: by 2002:a05:651c:c3:b0:2ef:3126:390d with SMTP id 38308e7fff4ca-2f3aa1ef4demr12723801fa.42.1723625129572;
        Wed, 14 Aug 2024 01:45:29 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a60214dsm3602651a12.91.2024.08.14.01.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:45:29 -0700 (PDT)
Date: Wed, 14 Aug 2024 10:45:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com, jiri@nvidia.com,
	shayd@nvidia.com, wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next v4 15/15] ice: subfunction activation and base
 devlink ops
Message-ID: <Zrxup6D86L4bM_HZ@nanopsycho.orion>
References: <20240813215005.3647350-1-anthony.l.nguyen@intel.com>
 <20240813215005.3647350-16-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813215005.3647350-16-anthony.l.nguyen@intel.com>

Tue, Aug 13, 2024 at 11:50:04PM CEST, anthony.l.nguyen@intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>
>
>Use previously implemented SF aux driver. It is probe during SF
>activation and remove after deactivation.
>
>Implement set/get hw_address and set/get state as basic devlink ops for
>subfunction.
>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
>Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

