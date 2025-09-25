Return-Path: <netdev+bounces-226365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006E1B9F92B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC1F19C0AD4
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 13:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A33235358;
	Thu, 25 Sep 2025 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHhaud+s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998412417D4
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806929; cv=none; b=eb/+vY0B5REBg8QeIAgOYuB+IASLpIHZIt35I70tuudPhqtJBvtcngd8fv3aTLSQTMrQ+oA+pGITDbNHAEMoS/zXZ3kw9iIWUDCC7AlDmhpJ1A2eckPJWJ5MDg0N1fcu9ltqG4ZGPK5bj39JqErt3XDKetMUv8zqTlp5ryMEwNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806929; c=relaxed/simple;
	bh=1FiNIcneYN0lx2HvUgcqUBdFJAhxJjJ2x/onBI+Yrs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUuGcOGv7GM2EThvAv+btmi/ghWWfMzQy+OfUQhVIAnovUfCOXoTerwI4ZjPpP524eKYomiJRA1HaqIttnrGuSqbBQD1tfmIHq1zCJ1gI32UPN2hbvVPMpQrPco0jIMzCG+nj3rXhstDrALR/UsHLrzjtKbg81A2Vr5F0WNG4rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KHhaud+s; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so674334f8f.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758806926; x=1759411726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wp58/Fg9Zw3xoKwG1DXjRBI51T+T1GKwsDLk64qZArA=;
        b=KHhaud+sKfU9GmJ7mcrVLGKUOYK06gbcMRTOgwvCbMmQY6zBc8tsg5EBWu9tvCFTOv
         xkEcmWNS/FsRnqu9zm3Ev0huYQZja+d8dI44wgOkiY4456V75zBwgJiTfkMnKmAJxssl
         RpZnaGEkcY/EIYWC0neFYTEClurx9W3CR3ap1PmZDflZ5muMGvDXZWs0kuET+SqKybRR
         Q/61fU5FBOAngp4U4nQGtE+7Ac+a7HSv9in9LKdTvlUVYgHQRNyr/ZiJqEjuxHfGatsp
         gDrQ+ZUzgFGNnAhl58hMrLGbgn4TXFxMd/gr1rErJ8FHgdkUS6VmiyEuyTFqXgGaQriH
         aaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806926; x=1759411726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wp58/Fg9Zw3xoKwG1DXjRBI51T+T1GKwsDLk64qZArA=;
        b=VOCTXAr3H/bS57ptCKbAeRTDWmjbXUBzOwc33EOzTcLIH23tRELHpyz/to+TcMyZ7g
         N2WWASy72Om+ogXaDXKhcr3TXKNwHfTlwXpdEf089uhpZoIIvZxVeh/IX0R8lPxEOi6p
         TIhfY1r1BsOJ7Yo2VGPG1t+qbY/SATMk2IEUnV77kgKRTq4jqxQSE0ouveaKnZyso99p
         aBxeSJ0QRickzKM46nKk9G+/1VOj/IM0zRkZnaKSdzHCkTTr3R/z4KCMitrGX6qFVTGj
         vpsUxGh94Pfwh9QHxEVu6fov90d3OAs0mFS55wYUV1VVAmpbC/tarqI7BF6kkv1y8q32
         hfug==
X-Forwarded-Encrypted: i=1; AJvYcCVmCWWDJpgoCabgUEdi96atodovtxJ8w/z0jqe1Td37uZDIxkfSLCdNSK+KEbflAg3CVw5fuco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3VlyFbxnW0pwyl0pWZSc2r7Gam7f+WgEBoEBFHHz9iCSYw44Q
	xQM+5I+8guU+1NgK5AQo+DYX/K+9ATYbW9t1+vc9m/voNTpZZdhAB3DvnWP+GM1eXS4=
X-Gm-Gg: ASbGncu3YuhgyhWKmRF3h64VgODeFZJDU2pY40ynXmMuF54KB+LANKjJslPKiyEOHi4
	CwsiJwMFhRDPMUS/zHFGnhRCKeP93piAXrLz5zOgZ4C6oO1anPXiRYx9dH/i+cBL3K7YQsfe+oJ
	tb49uhdyEM6wXcLQnIxVsaFQI06sjzQgQ4EaJBHEzmJJn/OtzBFq3NovTMUqf0d/A4p0su3NQVC
	h8p/A7B3FcfIYxz3L1ulgOHX6p8ifv8x4u0kq1DihXQ+ynqPt8ZkqqEjLT2qZkPuZlzAUR3Fwrx
	4Hclr/oTh/PRzPsttNEwjDt64/MJCRAz8H+xewMvKolUzxf5DlHWEa5ETudjvcSODlsxgWyNBSW
	oiQGU9hFQFcsOINS1R7V5sma4tYZX
X-Google-Smtp-Source: AGHT+IHEfXijaL+23iCR11cBYBG6j0gp/yAlAN7xoxHtuYkzjN8fDbBiJ7bNzYz3ne5Aj8wBn5ePpA==
X-Received: by 2002:a05:6000:2c0c:b0:3ee:1294:4780 with SMTP id ffacd0b85a97d-40e4a05bf15mr2460323f8f.30.1758806925981;
        Thu, 25 Sep 2025 06:28:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fc7e2c6b3sm3258932f8f.54.2025.09.25.06.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:28:45 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:28:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] dpll: zl3073x: Fix double free in
 zl3073x_devlink_flash_update()
Message-ID: <aNVDijGWI3ZO2aOw@stanley.mountain>
References: <aNKAvXzRqk_27k7E@stanley.mountain>
 <20250924170057.GQ836419@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924170057.GQ836419@horms.kernel.org>

On Wed, Sep 24, 2025 at 06:00:57PM +0100, Simon Horman wrote:
> On Tue, Sep 23, 2025 at 02:13:01PM +0300, Dan Carpenter wrote:
> > The zl3073x_devlink_flash_prepare() function calls zl3073x_fw_free()
> > and the caller also calls zl3073x_devlink_flash_update() so it leads
> 
> s/zl3073x_devlink_flash_update/zl3073x_fw_free/ ?
> 

Sigh.  Let me resend.

regards,
dan carpenter


