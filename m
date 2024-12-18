Return-Path: <netdev+bounces-152832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1944C9F5DDB
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 05:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1515E164552
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E3B14C5A1;
	Wed, 18 Dec 2024 04:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5ZZq4+5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B231369AA;
	Wed, 18 Dec 2024 04:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734496898; cv=none; b=ngibpvw/oIoMyluDqpn8PCxS3uW2gCY8Qd+IHe11GVUdFtgmTAiVuZ6GgMU1QO6o9w1Ovg55ZtHvgjMxJTxfhyW4Ft9c8xVrdoV0DmxeXY9NWMWuAf6aMI4axHhQNVDlsht1uNScEOwC9h89pBvZzKKRnFJrZsR63c13qgqQVxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734496898; c=relaxed/simple;
	bh=2ea2mUHm1euM23IWtdSjpOowpwP+4eDuTDLcW6WZyM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udJCKXib2pc4E0BXS15rmMmAY4hi22RoXEkclJZot4bMhbEOKN3NqWHd/SzVd+cjKD4Yfy3UIKMd3boY9sJcjr2iXiGKFyYv1fmEavmNDdq3RiT/AsQgnLNQ5cR82N+un8GujlmyBwg7xJii6eyJhpJvQHV3cf4vNkUVZJFLPsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5ZZq4+5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72909c459c4so4207748b3a.1;
        Tue, 17 Dec 2024 20:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734496896; x=1735101696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ea2mUHm1euM23IWtdSjpOowpwP+4eDuTDLcW6WZyM4=;
        b=G5ZZq4+50ly7hz2K1cKtEpPqQX5QKWCi+JeoP+fyQ0Wwm+6DhFt5EIXPEdIphuxRQ0
         SxmqUE1KY3x0VGctTZk2rEhmZDObKNgmus4mELfz3X3gCy30wdVgFeSCPNryvDjUIq6Y
         ZubOV0RbFjEKoK0OTh5zCBWU/zbF4VIkz3q+gPixP985vM7PFOkqx8xf9k0iL1CqaF+N
         RmL8NxNVHIImLG7W4Qn77GZri/lRBB2nvx1m9ZkHwYErCkGJo4NpBa6xKmb0fwUu9TzD
         mDYOVIECs+q+j80j0sKU3UFEsYRzx/eg4fsK9TdKZSYcbh0RZVRGgaSs281KRC2V9Y0q
         +/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734496896; x=1735101696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ea2mUHm1euM23IWtdSjpOowpwP+4eDuTDLcW6WZyM4=;
        b=EFLXRo7cxVMFzS9YBbCwoWKJRRJ/6qhszIt+E3Q9xNK6mlSRLT53CY9+RYDNPo1uNL
         Mz2hnAodDbdvKZCOQKsqdYbTBMuTKq4NVRwwvwfbjp9mxN8t9bnySa8xcWeISUJa/zWK
         84P3GbpK0G9ZfeUR2f2apMxF584MbTo2+8CcZJAObd6Td3geO5oUBtzDRCxICJHJeJ3a
         EygxaGbfguO63aGt4DXNE9qgwdk6XNIZvEvjm5JRYRGyGNEKFpE1mONUjoBCCgNnpIJp
         JOfkphHX0dk4f++Lu+SpkZ/7N3VJnQ0AjQDs1xQgyiB/lT88VdeO3BvzH2WCeqie5Nho
         nveg==
X-Forwarded-Encrypted: i=1; AJvYcCV6xy14o91ln/b6sHoImy0yuoQmUfnpNwIrh9fT9BzKbU4R+7m8aIK5NKWkpUe0ahBMdpiTs4h7@vger.kernel.org, AJvYcCXA90GrRTBZHsv2VzeW8EMfF5xp/ar9Pr0+iA6cqKIqfVjz3kSNBYKTQX7e/AgbaeddinxJEXi7M8/SyPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYuWQO607qm+CVh9SZasGp4QDzr/7GmaNRrG2oaB9ZbNJ90JXa
	TCfSSRML2hmK7ZllByR9wMJTxY8Fsqm/VjdipxCrOV/zh66BhRZV
X-Gm-Gg: ASbGnctURxdeLyDDNLBNOaIGs5/gwLKcZhCe5xV3Y+iRQDBQr1K7//ZzazuxYoCssbL
	ilUbokETufFZyHDF/PmxthDRjwWzepXVF0e+MEuXCBYzW7vo2weJaM0fqeFU0YZWjqJwgUwWER4
	cwCb2seRwuK2aFoMQ5559jc1cjsvHCKTfJXXOy7dtLVh7HwVW0ieoYb2hhi2bC2ofeOnJ48KqlC
	gpLnz10ID5566QWGbNik67pQhU3b9HgmVZlyLxBuJU+OpKJJnMyoo32zY8b+ClDGqUROvDpktjN
	tEt2+lVwWa11rl977uytUyfgJSdsqOFAibVIiY4ajH56YwU=
X-Google-Smtp-Source: AGHT+IHTlEIZ9aSrIot8wJ+q94Y5tlNlokGsdIJVlZMSjpPcSfaiWvTZNKyakl/AMV7Cd0EgMmAOFg==
X-Received: by 2002:a05:6a21:4a4b:b0:1e0:bf98:42dc with SMTP id adf61e73a8af0-1e5b487d793mr2598254637.28.1734496895842;
        Tue, 17 Dec 2024 20:41:35 -0800 (PST)
Received: from hoboy.vegasvil.org (108-78-253-96.lightspeed.sntcca.sbcglobal.net. [108.78.253.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad55dbsm7552593b3a.43.2024.12.17.20.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 20:41:35 -0800 (PST)
Date: Tue, 17 Dec 2024 20:41:33 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Divya Koppera <divya.koppera@microchip.com>, andrew@lunn.ch,
	arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v7 2/5] net: phy: microchip_rds_ptp : Add rds
 ptp library for Microchip phys
Message-ID: <Z2JSfYKI5LasF5YH@hoboy.vegasvil.org>
References: <20241213121403.29687-1-divya.koppera@microchip.com>
 <20241213121403.29687-3-divya.koppera@microchip.com>
 <20241217192246.47868890@kernel.org>
 <Z2JFwh94o-X7HhP4@hoboy.vegasvil.org>
 <20241217195755.2030f431@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217195755.2030f431@kernel.org>

On Tue, Dec 17, 2024 at 07:57:55PM -0800, Jakub Kicinski wrote:

> Fair point. Since this is a PTP library module, and an optional one
> (patch 1 has empty wrappers for its API) - can we make it depend
> on PTP being configured in?

Sounds okay to me.

Thanks,
Richard

