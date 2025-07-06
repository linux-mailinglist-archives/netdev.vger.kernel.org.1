Return-Path: <netdev+bounces-204375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E573DAFA2D5
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 05:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDF5189B67D
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 03:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3595B17C211;
	Sun,  6 Jul 2025 03:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQyGXwqr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC73207
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751771312; cv=none; b=pMN2F2WEbWL5neYaG0gH3NAb3fZhSWmU7jWPQN4q7ragqZRn3NBC6Bat5YhP/c8rN7Mv6QYyakh6VpnahUiAebzrSdIaiZmBycCgzcs9Dp/3FJSLh61XeH0MHhJm0xDSgKyK62X1ubrhb006Wi58R7dPJTJbOnlgx+truP9cnIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751771312; c=relaxed/simple;
	bh=0d12FCIXX9IZSK1PZHciEmgBOJM42ng3u55nJBrqLUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esdZe27gePkONq6oXYMNQhDE0bQj39MrNgO2Lrjb2Gq8B1L507+6erJsV8FiNyRQvl87EAR1lgtEFngSBCDoWXQNaRDou7yzj6KOf8xEB3bJ1LQCN7a2Qge/I0Bp55imCkfmLYDChaODqIl2Le0iUgv+01X0VexEQKJq3eHU8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQyGXwqr; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74af4af04fdso2385600b3a.1
        for <netdev@vger.kernel.org>; Sat, 05 Jul 2025 20:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751771310; x=1752376110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YECEbU4ySrlaG7iZCMOw9YTUVdZ0AdOjVjUaYg494MU=;
        b=WQyGXwqrFhU1KS2f5f++RwSTjo0J2ygdGI0KrBfREMWIo/MdGONrwhnTawGYj2RVoI
         2PnAD6OQo3EeDGkj4mQFFC+m4Y40Hm2BOGLvnaEEYTRA4QqlKZ+D5pJ8v54RyZnv7CEM
         3nC4ygc0dmWJfBOlU3ey4VGCV7/vGJd+3dqJg2+ZkPLqRLA+trNZtCEqZ2am2T9t64Qf
         w2I8IblxO/nuwvkiHXPMAES9Q66Q0m7N/rvPGoDaUdt+XIMCbExGNM0avUbcRzarecaW
         le7Dc0nT7rsF2tbqtGCa5pvMe7x1JX5BzDqUe559uTgfya1BGTDmh+7AidX+RAh5CaWh
         veMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751771310; x=1752376110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YECEbU4ySrlaG7iZCMOw9YTUVdZ0AdOjVjUaYg494MU=;
        b=VLKQP3hC+QT2Q+nB+B6PBDxBdvJ+Xi/oljU5E67ivC5VgW/BrWWIaQpG7EApUkEZ/1
         o1iEq5M6XusgvUHHhU2PWRaMmKjMxuWhK1Ge7X06poS3NicK5FPO09839/8QM8at2Wjo
         AZIuZ4A0HiSiHRJXc0Gc5JWYO5HN8Eoh5LFP0C9Qh6jwGjjWGf1ADEKNspBnx5PeHkUI
         Kdq5FDxgwDdyRzx2ziNMoOdddx7HQN1b/ZvxxXgB+E6Fplv6LSRaxpQ4rtcLUoj7j3Af
         mIvV13o1PVgMl93eYccs43R8BtuT9xCND0Ft55WXLkD8TgOp0KztlYpaT2rONlT0P9nI
         kang==
X-Forwarded-Encrypted: i=1; AJvYcCUFftlKZZtSfK1pb3fnP75y2q889bwtLvdD6d3F8Ggn2HcUzRAKzkgChy12OyJ3PdNUUeClUwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXVtffdVDYVuv1UaqQ4Y4Oy4+E/IPm9hABUHt1W0uqiFRLYJ4
	h1Yl9mJ8yTPo5eUm/L/6MM1rRyAtgqjux5dJkRkOSPJBLpj4fBINHzH8
X-Gm-Gg: ASbGncsZhK/6O7BVQvETII7qI6T0K5WMnr4yE0hk31auRBXuBzdGpwvTqdjsSM20dw8
	uoWcXDI6BNn9LM3aPK0+W5HfN6IZg400OLZo4o5o36c8OdxnWpBXaqzDlPxDxcNjAkjgO+yxHRK
	5kY/qvBRf1S/x2dnC0rp01wMGTF90W6dqoqbHKajiKCn+dVKnfXvSijE2EedmR+Mdh/6Xk5zD8/
	bP4SAB48oM9vMDxMu9RU78AhBrHehAoBYUt0A2hWwf3rmBye2g/pnaKVt/NC3HmI7nU7W4Gr1tV
	tdxwmhZN1fHb1NvuSEzrGhV1uyODwtHqAC6ebudl76IxuKQJ3SoIAlmpFLDw1esuz6Li5WwswWy
	METE=
X-Google-Smtp-Source: AGHT+IHcjsR2pVaOzCUKai5TUXgqVnANZQnQN0WvdnoDcrcVKSB45yprq/THVec+9mV/kFYDib3AYQ==
X-Received: by 2002:a05:6a21:62c9:b0:218:17a2:4421 with SMTP id adf61e73a8af0-22597006721mr13431320637.10.1751771310142;
        Sat, 05 Jul 2025 20:08:30 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:357d:7cd8:b68f:6a2a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee5f643dsm5322764a12.37.2025.07.05.20.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 20:08:29 -0700 (PDT)
Date: Sat, 5 Jul 2025 20:08:28 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, pctammela@mojatatu.com, nnamrec@gmail.com
Subject: Re: [PATCH net] selftests/tc-testing: Create test case for UAF
 scenario with DRR/NETEM/BLACKHOLE chain
Message-ID: <aGnorCGIYg3MPpk2@pop-os.localdomain>
References: <20250705203638.246350-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705203638.246350-1-victor@mojatatu.com>

On Sat, Jul 05, 2025 at 05:36:38PM -0300, Victor Nogueira wrote:
> Create a tdc test for the UAF scenario with DRR/NETEM/BLACKHOLE chain
> shared by Lion on his report [1].
> 
> [1] https://lore.kernel.org/netdev/45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com/
> 
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks!

