Return-Path: <netdev+bounces-223392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E68DCB58FF1
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8030169F06
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D12128504C;
	Tue, 16 Sep 2025 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByIbdWfq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01188283CA7
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009834; cv=none; b=ny4ugyuDrUYS3Ka7PCYd5sqdyMpEvrXiUipiVWvXJWbtO0WL6TVnNTiriA9PIDeZKXDLLvxf2fpN4U5qyvgytAFlQYWAAIZkr6TvOIM5lnsJyvEbWqw71TlhueThSp2PpuIX+8/XmnL8pABQKuv4OQWYJD6K4S9ac62yPQ5GLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009834; c=relaxed/simple;
	bh=7S3jMA6dJvBpqjiAp8xNW4/IJhcKzItPBV2TuC3nQuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7Vm/0ZcGwbpIl4vLYVXATouXKtPRb7hpuifXjyh+CHFJU8DwWcmHKVM0h0NO4zEeM0+2SvdcosKIyQ1M1fdccEZHdGtWm0wDdazjnQKbQh73unDUST2Sg9NATtfRTVSzgY/dDVlaeGd+E3FWkbjE7k0tWADiZ4g6eAPISy/2TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByIbdWfq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45f2a662690so4396405e9.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758009831; x=1758614631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GtiZrewOUJmbmN1btTpjme1msV4pbF4XenzrEJ4Aw0A=;
        b=ByIbdWfq3m2eID/Eidj6z7cDrxWKXbxrzv7mQDt/b/ETgKM1op7E7qSF1ccyFvPwho
         RMFAH1Hf0C8kj8jBO6Oq2KyW/RdQJgU4YDb1Ht0eL4bl0sR9XBRCQ1/dMPkDjSFyNYZG
         5mJxHWHldrmFyehNq41dQO3ej+Fl1hrXf8u+/ButRZyL3+lQLuVdlY99mAVyplBaaAKE
         BYvLUVFye3wEJHGRKzkmpE6HOem0Dhny+aw1TXa6pmzj47A/Bx+ohvfoRZ1+NbNl1ixR
         D4IUGMff4mZPXwVIiKU+VY5+9a21qECcbCt2JEVeDa8Axor2dV/ZY/NGweF2kzSARGaZ
         UQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758009831; x=1758614631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtiZrewOUJmbmN1btTpjme1msV4pbF4XenzrEJ4Aw0A=;
        b=jK4omXNCL/KVHX0gOqdvfTRNgnfnX3Ic+wju+OdDExe2TPdR0HGFb8rpzBXg9P2E5z
         iEbkYQ7ONdDVOWewjvj5pCjzFhaD5QVx+igLKMdhsK/1lUBVjwhHHL4+tngIci0iftQS
         LYu/Yua2GTYyujVkbpfFy0SKBzcJrNoytNc/+Zuk/yagiFAj4d/Ens5MM8e66V/WG6Uc
         Oa8B2xgnK/lZZvUnL6ab+QmpigslzVcXL7aEXBp+pzR0ues9COKmUgOWv/2uUlCPKt3f
         uGpvVa0CwefGbQNmzFkkKsXeD5BasSfn9V8ZDH+2Q7qMlI8Ix5ggF2RLDSAwK9HEzbMl
         SVhw==
X-Forwarded-Encrypted: i=1; AJvYcCWZn6hhnM7YXHUzp+0KEULmqHyBf9gdL8DT+07D4PobLRoBB1TjjTVHnCQVAxe3NffWpepHYIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqFFA7H2CQlASjimjr7xT+easJac0JygTYF1jjFP4RFyL6yTvs
	EtxAAoQVMyqDx2cXZPG6YvoJ23WSmf0fTXX8dhVxbbS2U+MU+GjWBuio
X-Gm-Gg: ASbGncs455fvNvQ8T6QdiC242Dk5imzoPDhmylPzVODSKEOjO4AvXan804gIM+jxxmP
	jSyc6zu5hj1txv920zSKiBbdi+j+G6SkROo2v93RVZZqouMyGYJOh5Pt7FWO0I10zucTvc2+tlT
	sq83/NJINwIt+aVirfcvbmq152GOtJAbzfKqqcdm1jzCjxMKrbVQ1swg6ks+R1SrPj4ZzLVQO/v
	oXtfStaBefWDqER0vO3bUUfIl7hfyg+ZU0yihhmVPL4YJxLPnAne7Gv1j1an4xUkV4CL2Cmhq0C
	3X7o4MORArSSf56Lz1n6Wbyd5crA6fI2+ot5pK6dVcciES7H7EOOvqlPrxoF6h/YekGxpZGHEZ6
	vPwIpwb1S1Mi81vM=
X-Google-Smtp-Source: AGHT+IGxAN9w5hc1ITa0m9lg8ARwDzqbXi5jTCZPBqSCCmcVl7KsJCQq/5+dONFfwUDlB7tpQlHPhQ==
X-Received: by 2002:a05:600c:5303:b0:45d:d5bb:5b8c with SMTP id 5b1f17b1804b1-45f29b1295emr50748135e9.0.1758009831194;
        Tue, 16 Sep 2025 01:03:51 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:2310:283e:a4d5:639c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9cf04db65sm9554619f8f.3.2025.09.16.01.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 01:03:50 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:03:47 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: clean up PTP clock during
 setup failure
Message-ID: <20250916080347.es66wv7esea6v4oc@skbuf>
References: <E1uy84w-00000005Spi-46iF@rmk-PC.armlinux.org.uk>
 <E1uy84w-00000005Spi-46iF@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uy84w-00000005Spi-46iF@rmk-PC.armlinux.org.uk>
 <E1uy84w-00000005Spi-46iF@rmk-PC.armlinux.org.uk>

On Mon, Sep 15, 2025 at 01:13:06PM +0100, Russell King (Oracle) wrote:
> If an error occurs during mv88e6xxx_setup() and the PTP clock has been
> registered, the clock will not be unregistered as mv88e6xxx_ptp_free()
> will not be called. mv88e6xxx_hwtstamp_free() also is not called.
> 
> As mv88e6xxx_ptp_free() can cope with being called without a successful
> call to mv88e6xxx_ptp_setup(), and mv88e6xxx_hwtstamp_free() is empty,
> add both these *_free() calls to the error cleanup paths in
> mv88e6xxx_setup().
> 
> Moreover, mv88e6xxx_teardown() should teardown setup done in
> mv88e6xxx_setup() - see dsa_switch_setup(). However, instead *_free()
> are called from mv88e6xxx_remove() function that is only called when a
> device is unbound, which omits cleanup should a failure occur later in
> dsa_switch_setup(). Move the *_free() calls from mv88e6xxx_remove() to
> mv88e6xxx_teardown().
> 
> Note that mv88e6xxx_ptp_setup() must be called holding the reg_lock,
> but mv88e6xxx_ptp_free() must never be. This is especially true after
> commit "ptp: rework ptp_clock_unregister() to disable events". This
> patch does not change this, but adds a comment to that effect.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

