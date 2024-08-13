Return-Path: <netdev+bounces-118020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AE4950437
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781802840A1
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA2D1990BB;
	Tue, 13 Aug 2024 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4AQUD+S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97611C20;
	Tue, 13 Aug 2024 11:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550023; cv=none; b=pgLokdtMTAg8GnPNZRe7VZt90v9OG4qAKXjI+2SPCl+d+K9L4EukuYRkTyngNYQ5ZXkjrATghMp7o+P28HGHmAYVxSPi1uR6Ae1hvfX01uAv7tf2tOv+7EzG3GX9GI6lqEXU/9rLUxFpm6efH1Ma+RSyrDum9U4D+82WhNedSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550023; c=relaxed/simple;
	bh=8yq9B5t+Ox1euFyvH+kYvTbm1j+0+KSyXvFHxaGq1OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmT6fqUIIESQEZQ+uvULXo8ZYKM+5YhdegJmdS31uTxbYcF1h5JLaQLNyqPJwmeVwor+IlRBQNtuwZ88+JJyBqFV82WMi7NeW/RO3FDWZ6+f26QlK3Yt4uovKqWJGeHps9sbEKPq7V7q39A9K6GXCD1DDeMpL12usClzLn6siFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4AQUD+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239DEC4AF0E;
	Tue, 13 Aug 2024 11:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723550022;
	bh=8yq9B5t+Ox1euFyvH+kYvTbm1j+0+KSyXvFHxaGq1OQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4AQUD+SIocys5c0Wwi4RhIdOeNkSFmrtcNq9VVBM4FTPPKpYMURqbGySyZdc86sK
	 7NKCV2/tIJ5ZnTTlTkhdhNXsIRxaXP3jBFfKVheecEME2FIiqh9cohFjmJhN5ahkCu
	 8lr13e6z0QCsiPIZdwHXnsdL/Vf45tW13bA3DNwX4V84FPdqU9WcNahs4eKbkhYiHW
	 XplXyO/IGMdWMq1Fv3GT+UPtT++JEIhVbOpdI2ZjFWMuia6I1w6h0nyMqyuwxw2o6M
	 cUi2PePq3C0Cd/zUhh/2rYAzYCbhSySIjIgwgg7MK44gEDzOQwI4DysitVVxyBCWUB
	 ZY56yK/ym4fwQ==
Date: Tue, 13 Aug 2024 12:53:38 +0100
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] nfc: mrvl: use scoped device node handling to
 simplify cleanup
Message-ID: <20240813115338.GC5183@kernel.org>
References: <20240813103904.75978-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813103904.75978-1-krzysztof.kozlowski@linaro.org>

On Tue, Aug 13, 2024 at 12:39:04PM +0200, Krzysztof Kozlowski wrote:
> Obtain the device node reference with scoped/cleanup.h to reduce error
> handling and make the code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


