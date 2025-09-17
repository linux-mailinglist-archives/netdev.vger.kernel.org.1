Return-Path: <netdev+bounces-223896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00BEB7DD4F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA233A9F57
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 07:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795DE274676;
	Wed, 17 Sep 2025 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXfuQLbH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CB0226D04
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095335; cv=none; b=O4daDzTGqaZKX2zsl0eaaqoFzHUkQdoCwuniorXu1J64/hYiPB0Yx5XLceVtdIf+6PxRXZ9KHTDLKghXPclfiyZdNxxv+SxVMU/j8QEijVl8x5OVfOTnPPk0oqKujaa+RZ+CqmbSOju4yVLEnArOhtGpEwzz79XsVdRUujWYPaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095335; c=relaxed/simple;
	bh=GvG4ZrNeu3Bih9o5JKPRxWfcPy07BDNekStcTkR0NZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u83JoeRvNUxQpy2mFUbBduqqBxsvIWDEKQ3+Yj7rd43VRGRI51tTob+tamgaG9+GwWIcbco2gCZvfwwSZm9DcnaI5AJ4xKUcKkqwi/9YVJz+2ix8N+o22hFIsmPTKBae6KvsbBO+gnhDWA/bUheOhNfB2h0zv0DA2nFoHMgby/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXfuQLbH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ecdd162cd1so114457f8f.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758095332; x=1758700132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8wO7TzGJ1CsD3wQ7QRbj80R2FbQIfeqksFtR+W48DU=;
        b=aXfuQLbHBotscl6eb+rg33I9QOlczzD/3WHma3UuX387KphwVrpxq8fbvcjlfxmK3s
         C7R4KAkSwvx6HwVXFl0nCJTZ7wApH2wiOIYmahKPtXlU5/DLc4uG5NlWY6/gWgU+aJzn
         MEybPSNA01Ca7yM8Wnm2lwy/3yJcK3uwxU04Mte2uuTfmwknIiR8oNQqS2OB1DcBFedH
         hzjobFQ5fvAZCkwyS4wcjBpOkMF04Jk0hk4+imkECpt3oCTqZLsKhTyl8NB6dix+q3AM
         8sZCdgWU1lYtYEbz5dyoC45pQBCxFywyl3j6/ncXRFAU8kY2sbcKrpKHkpJbxPPhVfwn
         qSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758095332; x=1758700132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8wO7TzGJ1CsD3wQ7QRbj80R2FbQIfeqksFtR+W48DU=;
        b=teDP5MZgW1Wdb0DHHtbs0CIdradcQD4D8nIWiBcWuie7NB7uWuLEWK4lZVGXrd7Y6k
         4zdT8FttHk0ChHEPsGDm8Q6iu+LgnCFspRKwrkpy9LvD9AdbI2ccsv0kKpK53z6oQhrm
         TQ0EvwFKqoxGyrsqguLnscNJftYSzwOMI66TLGpJJcV0doGzUCh5fMlLRo+OSdRZVzDn
         h9kuBcNJkWfHbWgQ8Ax8quWJ2ug+m+Rir3HSQSxNnHMSTHtgGZ4Zg0kOT/p9WITgoekp
         dlQABieGD7USVca6hGlheMjPF2BjT0jIH95ntJzayUhBiy0VQC1yBnsjc0tdYXoK1ynP
         xOVg==
X-Forwarded-Encrypted: i=1; AJvYcCWQCA3w7giLWpasLKR23LGIwxeJI5brSXABRlyprycBmIAfsxw58SFdW168FondT4g26pcQtPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHe4goMqdHHP3RTpVvb5BRDgQ1ZmSoR7gMnSq+hGjy13U/qj/u
	DHv3hceKviXUJgfUPtQRo2T3L5YRhYHgnoROfZacl25Vfnhj5eFQYtfH
X-Gm-Gg: ASbGnctmzxy1nQI5fdJqScF/NgRIGTjJOHNGpi6YGCd7lpD68nxznj716HwAfGNfJZe
	C6VQEA3kKPl/C24oTxDLH8iUklpXzHMyS/kRUPlx8QGQIr/3v5DdsFc2TfzNPWy/Qn37CQhmyko
	r046T31FaVmEgskKEQLazl8vFQT0rZKMYxrJF8kBvBrVkOCcuq2VSR9BRWrnTm+/j2SbH71XdMR
	ZDY08Ef54Wycx5HlenfGpeHY+wBHoAJoDIiPJDX4quGaDPN2Vzc7UIQqVVM9Lr5KGpFwr8BzLsn
	/F2g/iqDnj+WCcB1SLHUr00TlfEfrYgXiqtyu/MjDYBeMDNQcDYhuy6eORaD8CWbxNDybbwpmQ/
	c+153T9UyHSO4ENY=
X-Google-Smtp-Source: AGHT+IGP66R9YGIfI9dU67bVddlj+EfkIEoePShuQKSstEqkr+z+S4oQhfPP1Zqaea9RwOBEdxNqiQ==
X-Received: by 2002:a05:600c:c16f:b0:45d:d57b:69bc with SMTP id 5b1f17b1804b1-462074c689amr5484435e9.8.1758095332170;
        Wed, 17 Sep 2025 00:48:52 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:8bcc:b603:fee7:a273])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139e87614sm25680475e9.23.2025.09.17.00.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 00:48:51 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:48:49 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v2 5/5] net: dsa: mv88e6xxx: move
 mv88e6xxx_hwtstamp_work() prototype
Message-ID: <20250917074849.ddhqdb6sys4zjnjj@skbuf>
References: <aMnJ1uRPvw82_aCT@shell.armlinux.org.uk>
 <E1uycOK-00000005xbI-3u2c@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uycOK-00000005xbI-3u2c@rmk-PC.armlinux.org.uk>

On Tue, Sep 16, 2025 at 09:35:08PM +0100, Russell King (Oracle) wrote:
> Since mv88e6xxx_hwtstamp_work() is defined in hwtstamp.c, its prototype
> should be in hwtstamp.h, so move it there. Remove it's redundant stub
> definition, as both hwtstamp.c (the function provider) and ptp.c (the
> consumer) are both dependent on the same config symbol.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

