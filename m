Return-Path: <netdev+bounces-187772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D6AA992C
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB32178B8A
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B61B26FA60;
	Mon,  5 May 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ahiRZRZO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E118926FA4B
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462922; cv=none; b=UjTMEFi1N0QNBzchV3Ien5/awgNBmadCIC/J7pEtfQLCAjn2IyT9RAMUhpr/5wd3BfL6XMU/O8rRUNOz7TZDm9zY1fB3tTWja5MMf8tgosmMzl93sP8jgrhLYrSc6CgdJZ+k0pGtLX3d+kIVmOfZrf6P39fx0FkY/EwASeVH/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462922; c=relaxed/simple;
	bh=juE815DCXYgsMZZY8yY7lXS6YnXJ7xxwzt16oaACaIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sq8sbxdCQT3zqKVcGWZuiaSOVRBCVmNziL9V7oBcAdld4urWlJLj5Q+TzMkFlCfQZaFuTo7FDqkq+phDcmDGluiV6VRypyIb/rMUDifeLlpn5PrVeNbLfhdZqnD6jjMTVWKcVrNqLNJINh5XbG2QR+DKsSKtvWGX28blRkVck+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ahiRZRZO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso29150385e9.0
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746462918; x=1747067718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=juE815DCXYgsMZZY8yY7lXS6YnXJ7xxwzt16oaACaIY=;
        b=ahiRZRZOCZKOx6UMUer0rGOvuTSrDwmdsnQc8TYiefzdrXYqYBVghfeuqEWqMGCoPj
         CTl0A4DnXRTtVWVE78OagHlHAlEcg7YRS+9dZZ9a/GpXrzC4zCy3PchmVIQf8vKfytaP
         8wCWkxX3X0ppseQ0ey3Pno5vMI/TkaWltWXjw/SuxVJfi2BAanG+t6enQj30eoi1WaFA
         QL5bLnHe9nOqTig1urqA4kUoDmtE7iP1sGzYuVHwTdGYBQVMwYcBM4p7hkgpDstrIKko
         xZzDVSzFukGVBmxSbU9TAqa3LEvT46y9smKDCHKWb1pUo+ZSOJbw22LV11Rxic+W0/wo
         hP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746462918; x=1747067718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juE815DCXYgsMZZY8yY7lXS6YnXJ7xxwzt16oaACaIY=;
        b=XBCSLJCiweCRei6b7aeEZ2WYoN7dpGq2CSBfOrpdLWJFF86c5Zw5AneZ/p0GiCzOCu
         X0YUddmWYCo+6r9vNGZbK9NDQrMQuF3ESzjrHEr8I39AYnztp6z4o2TIJsJ8AuKJFSj6
         59boavXqsE5Co5OWDdvZJbk+Uolrs+2PM53zKPSvUguPxkMyasB9D+M2oeaKgS6zslie
         XYV83h9Sp0vNRXxAMe7ksbgYn1VbWTUaWe1GIimFmcXXN6/qwWkFVjo0lmkkLTtjCW4M
         zR8kQ+JMe4xGSc2iR1cVw35Xl5lQr9HA6WDfYj/kkp0f/VV1zDhMxEtOk6FSCIfIk/FS
         CM4g==
X-Forwarded-Encrypted: i=1; AJvYcCW4RZ0k8D6D2Xm0popBUiwNUqzxmI+9StjM+VIIklFcddDjJYOjW9cPWpRe1HhpVfchNb/MUcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaktOXDwsJ2O8T5v7eZ8SaSICvzgGwMs8oEIm0w8GYUw0UPTVe
	W0Y7m1+Un3WAOcqtQbd1bPgO3KFNUoyq/HM5vQidJrTRMJNdpbfmYFol1h/A4v8=
X-Gm-Gg: ASbGnctcIDBBZvDDnUm7lfMYsv2RYoYjOlXKGAU4u81XE+/ubrzumwShLE9B3Mzs9oa
	Nbpkhqyb7xTQDkaBKK25Qd5CjjUmJvTE8wiQfnurEysZvWqPHTaED/OymocvpnnaSzbjQlUQNNi
	UHmXyqbO+e+2/pQGdz3y7Ksde93CVC5TTvnk/meX7jyNT1zC6Xv0Mtb2LSVvDV3EERe28oLUnZR
	yRmCyolhoA04is9uWKgpS7xZxRtu5yU0kB9vAIQpGZKvnjxXjvqCx1/RZVkwamwerEgI/IQFi0+
	EejUI0oARtqgynsOdqN/gIPAKiToL65bpPY/kfdaahsvVIgXMAMdlXtd9tAVV85LF7RsZTgKK3x
	a8TQQV0Dsi593r6aE
X-Google-Smtp-Source: AGHT+IFkwOsMlzqRv2bC/v+aOkEbeL1Zb8r+tmj6ojBrqj1SpbUUh2U/BiEt6XhwrBJCwirrXk9eTw==
X-Received: by 2002:a05:600c:c0d1:20b0:43c:f680:5c2e with SMTP id 5b1f17b1804b1-441d0105ee3mr801805e9.13.1746462917794;
        Mon, 05 May 2025 09:35:17 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89ed4f5sm140074835e9.18.2025.05.05.09.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 09:35:17 -0700 (PDT)
Date: Mon, 5 May 2025 18:35:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, karol.kolacinski@intel.com, sergey.temerkhanov@intel.com, 
	michal.kubiak@intel.com, aleksandr.loktionov@intel.com, jacob.e.keller@intel.com, 
	mschmidt@redhat.com, horms@kernel.org, Rinitha S <sx.rinitha@intel.com>
Subject: Re: [PATCH net] ice: use DSN instead of PCI BDF for ice_adapter index
Message-ID: <of7mx4pyyka2rx7oauukv6jbtvcphj2uofblqugdrplgy4ki6n@tnyct3vzqdae>
References: <20250505161939.2083581-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505161939.2083581-1-anthony.l.nguyen@intel.com>

Mon, May 05, 2025 at 06:19:38PM +0200, anthony.l.nguyen@intel.com wrote:
>From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>
>Use Device Serial Number instead of PCI bus/device/function for
>the index of struct ice_adapter.
>
>Functions on the same physical device should point to the very same
>ice_adapter instance, but with two PFs, when at least one of them is
>PCI-e passed-through to a VM, it is no longer the case - PFs will get
>seemingly random PCI BDF values, and thus indices, what finally leds to
>each of them being on their own instance of ice_adapter. That causes them
>to don't attempt any synchronization of the PTP HW clock usage, or any
>other future resources.
>
>DSN works nicely in place of the index, as it is "immutable" in terms of
>virtualization.
>
>Fixes: 0e2bddf9e5f9 ("ice: add ice_adapter for shared data across PFs on the same NIC")
>Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
>Suggested-by: Jakub Kicinski <kuba@kernel.org>
>Suggested-by: Jiri Pirko <jiri@resnulli.us>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
>Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

