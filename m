Return-Path: <netdev+bounces-119369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEF595555A
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 06:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67952283A7E
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 04:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4DC42047;
	Sat, 17 Aug 2024 04:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB+GRc/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAF01E52C
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 04:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723868961; cv=none; b=CWWFh4uXt5f6hTFwjRWQh1rYIlVGGIZpp04MaKV9l7CzvaWHiiU85nk4BUvJhP6kjpkzqsHoUSAn09GDjBdnVBebj7kMNfcwegJBMZGgHp5G3TU7HTlZuUu/EqUSB8rnOCmAzNK8h37RlV2mCO4ymDyslZHY8HDUnFcblms4PzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723868961; c=relaxed/simple;
	bh=NPnfcTSMiC7ZjJKtZppSr+je4qz9KtE8tb8vTauVarc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfrZTuaBlssdQsFDqyuuTEMpY79jyD01MzsdPtkEnEkL2PkWAo7akZVOtaDVykXUgeznSZWVUKPOLaYQXGZAyPN2y+e0kIlBUZR2ePNbI5jrpmZDpnJVDfpp4UksnhDg/117XFPpsIRN78GBN7rVz1eKy78zIOAU8ifH3E5LOow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB+GRc/E; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd8faa28fdso1084095ad.0
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 21:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723868959; x=1724473759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P6X1xuy9IhznGlrFCNHBh1eBvOvcsVmKnPGuwd0/RZ0=;
        b=FB+GRc/E9ITtNywBnWf2jrAMg1QQuoO9Fi2pE/aa3S46LRQ64aqDfVrcxna3dy/32N
         VATdzEbaWiXC2W8YJoNs36Gpa6K/ZI9Ey/D2yIofnzdMWFJ67OIcrQx+ue8TPAkObzHV
         cIx3g0YQF8ExtGp7slGceGRIyRjWcNDxK21tuPMIbFU27gQwkvXvhYMWVAgFaZ2mGeNW
         fvQoQ8RYWN5FOuv+U0rEKZw4KX5aRZjsyDPT8LrlUd4Z+9ic30yw1O/34MqA7Owvix89
         G8u9nwUM7xYVPzn4AFmU5F9Q+ZhAjJZ4P5DbESPF4WmoMDIy386r9msPlu1PmxaNrbAD
         NiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723868959; x=1724473759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6X1xuy9IhznGlrFCNHBh1eBvOvcsVmKnPGuwd0/RZ0=;
        b=NQSCQJoMmbS6E6KS4IgFz/6djFE5qjNWayVkzt5ut2BcIraGP+YpgVnUTojck3KU2D
         cm/7mc04/9LJ+dP8WlvCjXjGy3d8yBR13th5FrZeK3Udhu1v+i8VqllAZnih0Auxlm9r
         ClSp1PWZjTOJRG7GNmJiCkyBa2+hVcsuJBhMXC7ZNMu2CxkXm2ITNm/dtjUJE7G6Fh94
         lv4hgmGCr03I5+2w0jRYdjGtpvD9RwlC7Cc7rY648EAmXyjce5Z022d69veyNfg3LUHU
         9zLJsDKyBq00MGnX1WKnoy+FZwRhF/v3jFt6lto3Elf0+Z/Cpex6L8tX61vycFOM26Q6
         HeJw==
X-Forwarded-Encrypted: i=1; AJvYcCXN2cuh3cn90ssizzGGwnDniQ5pbhIfF1u7enCKyUbCiO6WLHIP8fBPFg7H6VFIk4cjpeJwi3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YytwQvoGmmJMu61ayvuCJGvybuQAFfQijNZDRMiflEUxm6Y+KN2
	V0LVEElIqdwnhroX8vhZT49K+VBBQIV8tTOBJ+J0Y1daP23XskoX
X-Google-Smtp-Source: AGHT+IHf3X5uDygJx7hYjCN2yhyL1V7xAewy+Vh3tg78zzRCYAC/0nJwEXVKTYHhkrI7/jNfVQ+jPA==
X-Received: by 2002:a17:902:c60c:b0:201:e4c9:5e95 with SMTP id d9443c01a7336-20203eeed06mr31809955ad.5.1723868959180;
        Fri, 16 Aug 2024 21:29:19 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038e26esm32471035ad.216.2024.08.16.21.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 21:29:18 -0700 (PDT)
Date: Fri, 16 Aug 2024 21:29:16 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, darinzon@amazon.com, kuba@kernel.org
Subject: Re: [RFC 0/3] ptp: Add esterror support
Message-ID: <ZsAnHPmTV1eZpc3m@hoboy.vegasvil.org>
References: <4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch>
 <4fb35444-3508-4f77-9c66-22acf808b93c@linux.dev>
 <e5fa3847-bb3d-4b32-bd7f-5162a10980b7@lunn.ch>
 <166cb090-8dab-46a9-90a0-ff51553ef483@machnikowski.net>
 <Zr17vLsheLjXKm3Y@hoboy.vegasvil.org>
 <1ed179d2-cedc-40d3-95ea-70c80ef25d91@machnikowski.net>
 <21ce3aec-7fd0-4901-bdb0-d782637510d1@lunn.ch>
 <e148e28d-e0d2-4465-962d-7b09a7477910@machnikowski.net>
 <Zr5uV8uLYRQo5qfX@hoboy.vegasvil.org>
 <ed2519db-b3f8-4ab8-9c89-720633100490@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed2519db-b3f8-4ab8-9c89-720633100490@machnikowski.net>

On Fri, Aug 16, 2024 at 12:06:51AM +0200, Maciek Machnikowski wrote:

> Also this is an RFC to help align work on this functionality across
> different devices ] and validate if that's the right direction. If it is
> - there will be a patch series with real drivers returning uncertainty
> information using that interface.

Please post a real world example with those real drivers.  That will
help us understand what you are trying to accomplish.

Thanks,
Richard

