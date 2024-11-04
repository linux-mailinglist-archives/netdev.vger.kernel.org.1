Return-Path: <netdev+bounces-141722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A20959BC1B9
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 00:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B24B1F22454
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBDA1FE0F0;
	Mon,  4 Nov 2024 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="XdGVBH6P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3DC1B3951
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764604; cv=none; b=SbRynjYK222eNjThs6Td1sNZOC3A/39IkFO9SkETxCfavCGz4eo1dehvtVnVBi1UbIkb2OMyL5NqtV8Ycqn61J00hq8BpQBUc8h2dKu4aPqr4fyop57AN/QcjR50uOtOJ8EjRq4tyEkJuOov8VrqQHnxyHHZYwm9W8+/RsQzmDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764604; c=relaxed/simple;
	bh=GyiMXQlBq6qvZrV4GoHO1EgraZe6/DObPT0hriIoVh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsoAx4Wv5qTJL8QR91clh7ptz8j/OOBVjUIxNPkA8nn73Dp9qHHEqnYVta8iziCjEA3IuYhL6S76jluadanenpSn8gPdxY83ZYS6KtCsA0+wrZ6qXDoysYk+9Yer3xBiXjyOPEaB6a4qWP4zqxl0a9FjN8fGKzbyjon1WO3FZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=XdGVBH6P; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c805a0753so44911215ad.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 15:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730764602; x=1731369402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsX/sQ5xC5xk/6SdoZ3Q3KNFL650Ny8AuOYjQqoNMy4=;
        b=XdGVBH6PIFblysFLRyTEqNwDBLYOa5M0nUUmCCUygzetbGDFPB7BNdNqe+FUANvPwv
         iI3Sv1mV+Jju8r0kaW3NxSIMmTCS5eIPdhMbt8DtvnRjZs8zFgPObJLPqqfzovWtbNDa
         lq6LgQU7VlhxdDnb+HQo5gpsLFU51nGMuZ4TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730764602; x=1731369402;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsX/sQ5xC5xk/6SdoZ3Q3KNFL650Ny8AuOYjQqoNMy4=;
        b=pyERnKOC9hBIIK8CHfgMSrBUwmOZYU/BPIjQe7BMkjM4p12jtCx/0NhvXJ5yvL1pCa
         RubiSG5npAolRt7Ct2LV+a8MmNSlVaicGB2zkJxAcmoh2S7eLHo08qaukyxsouKLy3RR
         qtx4L2FloPDo7zQ3G9DAz6VgRlix0IQ5/WNDbfccLpYRyIRS8+C4NZwWezIDiD2i549z
         xa0xTAloeI2jn9Py66ngPwI3v7qtEsNGKNOxhIy5ddoeY4CURha8ImUtstrgkjpYwHnE
         YvyRk1+aqP0ZAyQdedmsrY3ucajGr8jcuBWmEP96QmeND0+BSzoWzZlil9iHCI9PazgH
         SqGw==
X-Gm-Message-State: AOJu0YyqIbOK70x995q0I/VPd+CJPR1AoNEexNvpiaRTnB4A7Mo7EkoU
	HFklThFq027j9QT6fGPye361nEkGA/ZntH0eH0MNFdQKzE9qrdU24OarFEPNwZM=
X-Google-Smtp-Source: AGHT+IFXrKScWi5lR1AqaeFnOC9rvxSoVe8YOCE1enP0wNblmedq/YRlE7wtDuDZ1oTXeTsAa9yTLw==
X-Received: by 2002:a17:902:e80f:b0:20c:9e9b:9614 with SMTP id d9443c01a7336-210c689bd32mr446173145ad.15.1730764602405;
        Mon, 04 Nov 2024 15:56:42 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d3c49sm66855305ad.253.2024.11.04.15.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 15:56:42 -0800 (PST)
Date: Mon, 4 Nov 2024 15:56:39 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 07/12] selftests: ncdevmem: Properly reset
 flow steering
Message-ID: <ZylfN-YE0-dz5eVl@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-8-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-8-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:25AM -0800, Stanislav Fomichev wrote:
> ntuple off/on might be not enough to do it on all NICs.
> Add a bunch of shell crap to explicitly remove the rules.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

