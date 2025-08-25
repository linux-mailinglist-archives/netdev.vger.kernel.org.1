Return-Path: <netdev+bounces-216700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 016ABB34F93
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90E02A24C7
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 23:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C0C2BF3F4;
	Mon, 25 Aug 2025 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTgvKnMy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD90C2BE02C;
	Mon, 25 Aug 2025 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756163499; cv=none; b=pa86m61wNDxQjiu5tJTYAGaGrKpPr+dhDXdIqJy0VhGqKvLX7tVDplDTkWArXD4hRW3z9JElMV9lidLzEmw3IHL1NUgCibZuK64F7CCpqCyIbY9O9b4HJaLHL+a5WIzu2rW1YIaaqvk0w2vDzg1PxDbKWu/DBZ9Wxl1S46T8Vps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756163499; c=relaxed/simple;
	bh=zTY0MwwZf2yUlWHFGV2cfI9KnxLx+HtmFdoyGYQVba8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFPFiEXewZRkB+XnonMo2sYumRdCPp+TNP4/4gfx7aZxLsbbKFP6hc+uu5LWjiAdKw9lh7RGWrW+DGqKaBCge/HCdiCYX/oyBDxoUCcz/rskusLL9W1hv2zd4fsxih2T9Wx6hLl3nms2KaiGo/KiLymGDwFXWGwBlLQAq4SJsIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTgvKnMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F2CC4CEF4;
	Mon, 25 Aug 2025 23:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756163497;
	bh=zTY0MwwZf2yUlWHFGV2cfI9KnxLx+HtmFdoyGYQVba8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UTgvKnMymEoOaDu0KbafNkgCA0WORin2MTCPD762z5kQlrid0psIPHEXU2f2TKTsP
	 AHzgYW4FIcUSxls6UGYAFQcRlYC65oWZOVGwpd1AdJE1Wliy6kLxbrWLO9gUHL+6/5
	 iVn0c5GFFFXvJ06ijBBmHyzp9YyxCc6l7sCGLZ3DqD/ahPyqIzzsHQROdqJyR9VCAx
	 Xg0caFAzUPRocTMUBIQ2BJFUVbWIRXd5sGT4hv+sLhLcG3GZXttN0DwScPDzRVb4NE
	 JGmDQWRWjUCMxAHmyzdACABuUYTqBf5ZOh3DqnQqxwlpoVmr72jQjmOUbhWHv4F6v2
	 rRBTTTKSneM5g==
Date: Mon, 25 Aug 2025 16:11:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: nick.shi@broadcom.com, alexey.makhalov@broadcom.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 florian.fainelli@broadcom.com, vamsi-krishna.brahmajosyula@broadcom.com,
 tapas.kundu@broadcom.com, shubham-sg.gupta@broadcom.com,
 karen.wang@broadcom.com, hari-krishna.ginka@broadcom.com
Subject: Re: [PATCH 2/2] ptp/ptp_vmw: load ptp_vmw driver by directly
 probing the device
Message-ID: <20250825161135.44e97a4d@kernel.org>
In-Reply-To: <20250821110323.974367-3-ajay.kaher@broadcom.com>
References: <20250821110323.974367-1-ajay.kaher@broadcom.com>
	<20250821110323.974367-3-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 11:03:23 +0000 Ajay Kaher wrote:
>  static int __init ptp_vmw_init(void)
>  {
> -	if (x86_hyper_type != X86_HYPER_VMWARE)
> -		return -1;
> -	return acpi_bus_register_driver(&ptp_vmw_acpi_driver);
> +
> +	int error = -ENODEV;
> +

checkpatch says:

CHECK: Blank lines aren't necessary after an open brace '{'
#110: FILE: drivers/ptp/ptp_vmw.c:168:
 {
+

-- 
pw-bot: cr

