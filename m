Return-Path: <netdev+bounces-104384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D06B190C486
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 09:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B7F283924
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 07:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613EF15B133;
	Tue, 18 Jun 2024 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dKTpAEYR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AF813AD2F
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695638; cv=none; b=mZ67dsZpNNUE1i2i4in/5+JY/aQWs7x9FaH9j2XTU3YifxKJgneIALetdj2k7RE4olAtYF26+ngQjaaNcB+lrvb3d0nwP7plDZ/Ys5P86GsxZkaFXUrH+xCKwjbrRKtkNjAbUjpzJ9bnchtluo12KKoNAYVrhoLGdATf5nOAyp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695638; c=relaxed/simple;
	bh=uXOh84tRw7JM0hk61OuwPn77OEQNmgd7xadk/+3HU5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obWS+jjtb2/pbxdB+bhTAqGIP7D4A/Xn8bFF2UAG2TViYI8U69tSrJjPXrFY34WFDJpn4c6LRQat8nPByz2jvdZEUfX1p+Oep8ev3gZq2TVtv+RYixNcnZFWA7BDLZmMtJsVI27sKJ9xDTvBFQgFyZjA2XSopk0vRdqoel68Fa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dKTpAEYR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3621ac606e1so146939f8f.1
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 00:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718695634; x=1719300434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXOh84tRw7JM0hk61OuwPn77OEQNmgd7xadk/+3HU5E=;
        b=dKTpAEYR0EfqNEUMQLF3IaIKN+2JHfsqY/X2eKtG/pQp2mCXIIGACX8hbYqS5npeDC
         2xMP1AlX/M701oEikBf8HPuc2RuTNg53ewJnpNmjlfh4V2KmDvBMqQj7aGyniWHHIkXv
         euFfhytYMpbJEvglUkONPKXBZpeJi7+KLmeJP83fTQlBhtmO16IDiehiwl//2kGc+4Pf
         Nay4mCdIGwx4wQGt5b0vCixykGkB3hzEx4p6JxRXzbO5lzR11VQpwAgNtyBeqYsMAQDn
         nFgoIzqI3qwpymUYFr8k2gmC8Y9C4wIyTCejRDIWbYwbRXsiI2GCaeZ9ytggUc96C7tp
         AszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718695634; x=1719300434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXOh84tRw7JM0hk61OuwPn77OEQNmgd7xadk/+3HU5E=;
        b=gxj2Rmn8rruKxtsnfPuuCtrY9PztxymOIRk1RqORV8IkzMqflYmyGra0hhYavzdKLx
         3KaC54ddvKLwm2CrLR7/VkbuExlHIc6QfeGNJsM1hPgzd+xzqSHSyhpuHNklhjFwxUZj
         ZaolaHagENxIOZJAjxJbDUpwyxBxxNJuYv3l6Y/hIdcZSjYeavmrJ0aXCVDgSNLMuaVJ
         of/8YUU0xoeVYX7b/ktNMUavrQ6oJ71087OkIuy2eWhEUb+t3CRseWz5CtfPL6B5Vlr7
         6Q4AXWsz0DXJIo6AER/d7GhQXPnQRzmVvwykHVJzH6tR/eu4ugEfsqqjtweDKmAUDEh9
         DUlA==
X-Gm-Message-State: AOJu0Yw2c9tLizYhxnMx6kr9iL9gYs1os9xqPTb8xivuSUKDy9s8+oc+
	ZQDaEh+FW/k01kA8fidt738Nz+ISamFHnxD/3a0+DJjTx2TMLOMbH6r/12SALrBJtZlSvCd7evO
	mlxc=
X-Google-Smtp-Source: AGHT+IEiD9HPWMksGb86K4t83TwefsWnTek/Dk85JIPTZqVAnQILOfjJTHtlUYKReFRU83zE7UTQbA==
X-Received: by 2002:a5d:44c3:0:b0:362:2af4:43cc with SMTP id ffacd0b85a97d-3622af444f3mr689891f8f.19.1718695634106;
        Tue, 18 Jun 2024 00:27:14 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3608accd8b3sm8044223f8f.71.2024.06.18.00.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 00:27:13 -0700 (PDT)
Date: Tue, 18 Jun 2024 09:27:10 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] virtio tests need veth?
Message-ID: <ZnE2zkSHyg5miJSq@nanopsycho.orion>
References: <20240617072614.75fe79e7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617072614.75fe79e7@kernel.org>

Mon, Jun 17, 2024 at 04:26:14PM CEST, kuba@kernel.org wrote:
>Hi Jiri!
>
>I finally hooked up the virtio tests to NIPA.
>Looks like they are missing CONFIG options?

Could you add:
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_NET_VRF=m
CONFIG_BPF_SYSCALL=y
CONFIG_CGROUP_BPF=y
CONFIG_IPV6=y
?

They are in tools/testing/selftests/net/forwarding/config and I assumed
since virtio tests depend on net/forwarding/lib.sh, it is not needed to
repeat the config options in tools/testing/selftests/drivers/net/virtio_net/config
Apparently that was false assumption.

Will send patch adding it once you confirm it helped if that is okay
with you .

Thanks!


