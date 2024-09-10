Return-Path: <netdev+bounces-127039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C2F973CBB
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECE8283B44
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 15:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E37C19994D;
	Tue, 10 Sep 2024 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5N2uiM1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ED26A022;
	Tue, 10 Sep 2024 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983502; cv=none; b=HTcsxJOi12+dK0DUgfHi/WgecoU29wkndXheSOZ4JXiw7bjaiSSItwMhGnUfJ+LOAMt9FTJfZAywXEMTgA+O+L5MT8HUhgz4Rn7H8fViTeWvVxRvbr1WWPV185ZNPg+Z8UPgeLAsOOqn7AeH6evdJdxPVfg2aAN7L4doHMJ7vJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983502; c=relaxed/simple;
	bh=u+LUaZcmfiXGrPUKUlRbyxCTBqnb4HavaO+FbiBlV+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beOlJ+twIdPS2KHmz62wyPhrB+Hj4dSN0eDa5+t22ypzwAiBClvkUtBuJ2Yr81Jn6TPFvQj126osevvYsUnWi2C4G65a11D2Rx0zavcw1wamCWtpu6AzvEUeNSE31QRapealWwToTjjGfyfjEOiJDkeIiR8g3goeulG+4m5de44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5N2uiM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8C4C4CEC3;
	Tue, 10 Sep 2024 15:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725983501;
	bh=u+LUaZcmfiXGrPUKUlRbyxCTBqnb4HavaO+FbiBlV+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5N2uiM1pWLNmDd5h0HKWfwfCVjfWQp+9QJG27mYdbRGl83FJ1gt6jlIzDbIyXQt/
	 3DbT41hD7Axa7J4+BrsTqSQSK3vzw4Fb+1WdX+qvLwi0ASBpwsaBQVYOJ3o4nEAaJp
	 EepiZmcfW9AW5CWMQqep36htQQrZiO4vE10Q1QgvyzTLpVSock/X8mdypIc9Dsc7BE
	 1E2/wKRGg3pQqfY87+ge3T24b9BEvcNnyjBCynzBhQdYl7L0kQ+g+f7CMoKOR/7N5h
	 dUkuebKd302kzNgTIs86SGrDrmKLMbZqLmBPZBR/nsKYa94FqEpSZACsrzIfkfaWfG
	 5OZ/TodFS0MEg==
Date: Tue, 10 Sep 2024 16:51:36 +0100
From: Simon Horman <horms@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: d-gole@ti.com, lorforlinux@beagleboard.org, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] greybus: gb-beagleplay: Add firmware upload API
Message-ID: <20240910155136.GH572255@kernel.org>
References: <20240903-beagleplay_fw_upgrade-v4-0-526fc62204a7@beagleboard.org>
 <20240903-beagleplay_fw_upgrade-v4-3-526fc62204a7@beagleboard.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-beagleplay_fw_upgrade-v4-3-526fc62204a7@beagleboard.org>

On Tue, Sep 03, 2024 at 03:02:20PM +0530, Ayush Singh wrote:
> Register with firmware upload API to allow updating firmware on cc1352p7
> without resorting to overlay for using the userspace flasher.
> 
> Communication with the bootloader can be moved out of gb-beagleplay
> driver if required, but I am keeping it here since there are no
> immediate plans to use the on-board cc1352p7 for anything other than
> greybus (BeagleConnect Technology). Additionally, there do not seem to
> any other devices using cc1352p7 or it's cousins as a co-processor.
> 
> Boot and Reset GPIOs are used to enable cc1352p7 bootloader backdoor for
> flashing. The delays while starting bootloader are taken from the
> userspace flasher since the technical specification does not provide
> sufficient information regarding it.
> 
> Flashing is skipped in case we are trying to flash the same
> image as the one that is currently present. This is determined by CRC32
> calculation of the supplied firmware and Flash data.
> 
> We also do a CRC32 check after flashing to ensure that the firmware was
> flashed properly.
> 
> Firmware size should be 704 KB.
> 
> Link: https://www.ti.com/lit/ug/swcu192/swcu192.pdf Ti CC1352p7 Tecnical Specification

nit: If you need to post a v5 for some other reason,
     please consider updating the spelling of Technical

> Link: https://openbeagle.org/beagleconnect/cc1352-flasher Userspace
> Flasher
> 
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>

...

