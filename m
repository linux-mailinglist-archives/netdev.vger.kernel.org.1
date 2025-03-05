Return-Path: <netdev+bounces-172180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ADFA509CA
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 19:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49E3176112
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4725252900;
	Wed,  5 Mar 2025 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By4bmiw+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F2199E89
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198941; cv=none; b=IJZRT7jd88kJbXNbHo5NVNcYZn/u1UodkwZx3AD5gMEOR1Mv8gWk6lFP5IL4Qd8cgqObOBgu8y1ZVoLZ7WwZlvLei2z1WSNUFdnPQjd3sx47RR6jJ0OPjnX/3ECvEdfr/Xuly9Px3HpnwW/It94emh3jmXzX/qbPgzxGBV8KSYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198941; c=relaxed/simple;
	bh=mpZIyg2ls78pAGAM2oyC/4XdVm/qWQwX7Lg+iFM87wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkKJB7hJPd0B2cHiAWmnMvoUzlIRAt3VnvO+mKopx7ZrOsSMLWQaMdpOf0S9w4UlxPrujPd6BgEprMeHdtiUgODrz4HdW9tKmEK5peBrWRMl5WPFJY/tFyod3QpB0IaOylbpDt8levVzje4zItqG1DDZA5A2GSgfAnepBTAgcgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By4bmiw+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22401f4d35aso12899435ad.2
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 10:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741198939; x=1741803739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGV6LoTeydm+N3uiBcUotDKF/jSGMFjxSbiHEfl/+/I=;
        b=By4bmiw+UHIfuk3CKFRqFkdXTCdgIDBOYebFvIqdpdLU1CS9GwPJWLCdA8MKKzhUJs
         218yya/zMTQRKv4kNZdjoSTIQ1sGF8k49cRa+qQNgneCdmVMvMVp1IddeTA46E24PaD4
         MdkmLx2Ne/HMZeiDuN2obMQaTvbeDwX4CUZYwK19s2+W5wOWmJUs+ems/foZUQc8svqJ
         2Q6jJajn8GI9zN/EAauBmNIZ36jcU4+qtW14Jqf+oXnOO6PE+1N/xQfvt6QPq8ZBmK2A
         tecT/s6/bVgaqgVbYsmLHLdL6AjfXI5Ytofg4Ob4vku6K/F1Vk6/Gr3qpnjK4VJvcYyD
         8j9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741198939; x=1741803739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGV6LoTeydm+N3uiBcUotDKF/jSGMFjxSbiHEfl/+/I=;
        b=LbGHlSsQixLqXaw/WrcAjs+tLcWM2sbUyQAnJUsV5C634Rl54LV+wyFGdQwMJz8dbC
         y/AuyFt/9g4qI5V/TLtLCadvQwhZUYyVx+fU+0k6qrztK3X6MgqMzoxYIUhPpRJ8HGsE
         Fmjc+PZAEGgqMtcPH9dEuPQHSsw3PyAzmSwUH3XXAbPJh8VQ6ew7YieLE75AbYlNiaLW
         HaLIKLH3Kw0paLuBvdDO1hiBPbdRsyQp03qz9l6QvJ8N7mR3q29Ax/hnSgyhrWavgzhs
         yYNdmBtfKUo5y98ntc+e+oKycAo4V5EcXHC7ghZVQTmP8sgEzJhw3NfwdLD2GIEkHt1k
         mllw==
X-Gm-Message-State: AOJu0YwgPx6sCLdcqsaVzOf1eawULuPqrnxGaEixTLNmI9o6YmfVyoY9
	kZbug6PXnnp4jV8p1dPbX4uZVPiO7kH/hGx4O20e89vSqoob0QrDPAxDdA==
X-Gm-Gg: ASbGnctT1nDkWPpVeUo7qgzZE1zwit9flZmDGXebkynDXug/R/v6rNPiSJ+dD7ALEr5
	urjeBvw3QWasocCRwAEVaVEGhRHxBroJebnEAl+udp7EPZfXw5zlMBy153mkn/8XwTlg+umUnZ7
	s4TufMUs36LSSuKkjlB1KPXJRkfNQ6f7Fe9OsuVYkrZiMmfLspahEjW242znbWC0jepRnpkWllK
	bg8aHEj8A2n3FJsmJ1wo/Xa5umj+j4imUnkmv50TKyvarvCfaAvx1kaBnWZwwJZfImNo2kqJuNB
	slAlZnJmTwOcURPt/C1jtHkv/ImZ6wBil2ni3hOAmdzfCSsg
X-Google-Smtp-Source: AGHT+IGU3H1TcEJgITvFddLNA+vJBKU21YRkIyCVt4d9D4l1HIszEO7eHOtubmKH1SMnH+MsYNZqxw==
X-Received: by 2002:a17:902:d50f:b0:223:5e76:637a with SMTP id d9443c01a7336-223f1c97445mr51850335ad.23.1741198939498;
        Wed, 05 Mar 2025 10:22:19 -0800 (PST)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2240229ef56sm6509035ad.40.2025.03.05.10.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:22:18 -0800 (PST)
Date: Wed, 5 Mar 2025 10:22:17 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jun Yang <juny24602@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] sched: address a potential NULL pointer dereference in
 the GRED scheduler.
Message-ID: <Z8iWWQS3PJi6HcrZ@pop-os.localdomain>
References: <Z8ddDSvJZSLtHCGi@pop-os.localdomain>
 <20250305154410.3505642-1-juny24602@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305154410.3505642-1-juny24602@gmail.com>

On Wed, Mar 05, 2025 at 11:44:10PM +0800, Jun Yang wrote:
> If kzalloc in gred_init returns a NULL pointer, the code follows the
> error handling path, invoking gred_destroy. This, in turn, calls
> gred_offload, where memset could receive a NULL pointer as input,
> potentially leading to a kernel crash.
> 
> Signed-off-by: Jun Yang <juny24602@gmail.com>

When table->opt is NULL in gred_init(), gred_change_table_def() is not
called yet, so it is not necessary to call ->ndo_setup_tc() in
gred_offload().

Fixes: f25c0515c521 ("net: sched: gred: dynamically allocate tc_gred_qopt_offload")
Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks!

