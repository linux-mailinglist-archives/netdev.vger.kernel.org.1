Return-Path: <netdev+bounces-122163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D066F960365
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2CE1C22513
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F4F15687D;
	Tue, 27 Aug 2024 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NKMs3uYf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB47153BF6
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744428; cv=none; b=ZvuWNv6XalVx4mXUv0oErPlb1P04n2+lJVJG7xeBxId2QcewrIqOKGfai+phxnci7R+SLEcb99JAn3MbvrTV05UlxitrOeOVnENZA6ewWHuml4fzxcMY68NbCUWi3JUpalJAPGhHa8MQ+ePJcKdWJvBI48Wv3yWRIkRySlCHgx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744428; c=relaxed/simple;
	bh=pljMeg/tZIYLgASZ7cHtr7dCWNo79/sFWaht/42VsCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaRf3drqdzAj3OJTpVcxfZCm1P76uYaYm4tjqMnXme/0inHYVWetO33sr1Cg15OSo6bjZ262kKm1oVHxvBDCVVKBR7s666t9l+oz1zlEEtq1TqK5CxrR6j9PUfiYlUbzdyTvPEZnv+6JjNUXuSmSyi+YjzpQHe9HXoVqgPeNCr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NKMs3uYf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a83597ce5beso796771666b.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 00:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724744424; x=1725349224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pljMeg/tZIYLgASZ7cHtr7dCWNo79/sFWaht/42VsCs=;
        b=NKMs3uYfwgiFBt2pns9ZUjCrLAoZyxnrqxtWg+0GSFDgytouBAHuIM9zqnhtVDzRIl
         UHsRtVlq5CMaZ5/urVMuynu6Ee26LdTDNPZSgtFSKzpcQP8HbMph6BPle7Ja+pjNyMk1
         G+wGdfXHr5g8NeYIU0DaS4bWSx91vt/bk6zQ5JQBsH/7+m3OJmUnQ1KKE5Sk5uV3sybV
         fmrMZKZMu+A95p9skR4t5WEYC5y68DnRvhcUpClQ/lt/4o9Q3Sw5PG+g/Qs8IIOkUyCK
         ZRBrStdL5TLFkW6zxSvFtZm/XE1lKQSB60oM5xUzQ7XavoioOktvWZiNawO9iJC8pEYn
         r4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724744424; x=1725349224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pljMeg/tZIYLgASZ7cHtr7dCWNo79/sFWaht/42VsCs=;
        b=fzrPezWyAD8RxghGLVgzEzq6fOSMxxvTsmip8tiZSN4M0p4bjxM2O3qc0MO6CtefGV
         yddqVHNXsP4SDzzRW5ANLzeUcUCLzMV9rq1FORao4dCDcXm228qOxFTcNEiA9NNe6Q/J
         uow5ySm7pC0+BSMswTpSf7/IRcVPosYAX0/iZFu0o9ze7uVE+jXrTIi856X9bJbppGQ3
         svg2/s/Puz30ZCT7C0ysiTBax6dRyeXM7FzMi16rtSOFyWSkPpyvHHpcfvArzUEz2NJ4
         5L0mBjpGjssxN7sqoBgwU4PYc4CfM0MdupR9qyNvcErdeotW0tUgC8BQD9kUah3U3Y5D
         b94w==
X-Forwarded-Encrypted: i=1; AJvYcCWRPwdDuVT6uw79YOcescnHVb6nqjan6Y0QzmG/OrfbaMmnCvZO0bBGftpE/joX5TZmHozEHPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp5eEuK5A0KirS2v1nGg4XgaT4HYlODT7BH194a/35COLy3bHT
	2Aej1/286622jwJwjFRoF2moGCOIiGtGnpJ65yJQMEPGHRrT5rKeZ9y+CQjzLB8=
X-Google-Smtp-Source: AGHT+IFV3VSINboGZ5Er0ne8BDV200ac18VnmBZ7QML+x8/y19gkiMEZo0P87rh59ZwRG9YzJqUzDQ==
X-Received: by 2002:a17:907:2d8e:b0:a7a:c7f3:580d with SMTP id a640c23a62f3a-a86e29feb8bmr192161466b.25.1724744424121;
        Tue, 27 Aug 2024 00:40:24 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5485671sm74803666b.30.2024.08.27.00.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 00:40:23 -0700 (PDT)
Date: Tue, 27 Aug 2024 09:40:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] ice: Fix NULL pointer access, if PF doesn't
 support SRIOV_LAG
Message-ID: <Zs2C5nlDKlgxd32a@nanopsycho.orion>
References: <20240827071602.66954-1-tbogendoerfer@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827071602.66954-1-tbogendoerfer@suse.de>

Tue, Aug 27, 2024 at 09:16:02AM CEST, tbogendoerfer@suse.de wrote:
>For PFs, which don't support SRIOV_LAG, there is no pf->lag struct
>allocated. So before accessing pf->lag a NULL pointer check is needed.
>
>Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
>Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

