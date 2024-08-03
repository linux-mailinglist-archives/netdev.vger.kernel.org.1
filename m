Return-Path: <netdev+bounces-115484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9642F946886
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 09:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A1ACB20C62
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 07:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD9F14D447;
	Sat,  3 Aug 2024 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ifPnkWby"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B26F450F2
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722669177; cv=none; b=eNP8HGTXNQV/S3BJxaD75UrU37SRGBiHHD3ZYgl8+ZEKk757mkvyaGHnmXfhblMClSEqy4sfKKM93oSoUEZKk0N99h4HkXNIn3BXRBtxjmEKCzPGChjKCT6nC44k2DqG1vY2UTVigUcal5v7Y6HanUFDZNNaP+YCnNEIcZSzxH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722669177; c=relaxed/simple;
	bh=dndVXk+67m+qMiOtj6NOFfjUrYj7hDAN6i8bNRYSWRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H45Mi9Vaov9qaR2EyniJeafnLjqbqxSUfobSaj0+B/I47xEWU7Mfm2jr8x42SbaBmUiBzrZypMUpFaT04rVMCVdZJFKQ08k/Z8y9kIsFmjOmQ2eXkah3SM2tqQBLrjP8LrY2U51eXwAFbHbBCiTQRu69cLTzt+RjWBPNTN48pwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ifPnkWby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694EAC116B1;
	Sat,  3 Aug 2024 07:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722669177;
	bh=dndVXk+67m+qMiOtj6NOFfjUrYj7hDAN6i8bNRYSWRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifPnkWbyaHvNJq5Ryne3G9Kh9RIsKr/BpDAHpAnXkaleFwsED3h4/qwvtj5AZNnTh
	 hN6IsonrnWE3VeEYxI5BjMNxWkL9UswdRZ3hiKJ5lYNdkkEQsB3ozJmcHZYLX6VnlB
	 Asug8pdX/fThJKJwRf7v11a/xOx0/Wg7oJ0WWnhQ=
Date: Sat, 3 Aug 2024 09:12:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net] ptp: ocp: adjust sysfs entries to expose tty
 information
Message-ID: <2024080343-overture-stew-aee9@gregkh>
References: <20240802154634.2563920-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802154634.2563920-1-vadfed@meta.com>

On Fri, Aug 02, 2024 at 08:46:34AM -0700, Vadim Fedorenko wrote:
> Starting v6.8 the serial port subsystem changed the hierarchy of devices
> and symlinks are not working anymore. Previous discussion made it clear
> that the idea of symlinks for tty devices was wrong by design. Implement
> additional attributes to expose the information. Fixes tag points to the
> commit which introduced the change.

No Documentation/ABI/ updates?


