Return-Path: <netdev+bounces-212972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C08B22B18
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4EC162732
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD57C2ECD3C;
	Tue, 12 Aug 2025 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToQTGhcZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9862B2ECD1E
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010019; cv=none; b=vGH1rVk0dn0GGcSB1EM/hZWSTOtvhxbov9FL6nHZmqtdpviBcY6fnEZabSnr8yB1u9emj0oPguRuUHTBH9CxgJtVdb1DqUEOBLxBO/lMDeIpK79UvcT6WakH0WyLKRLR/watTPEQvXaJE3sxWId7xCXhLyb9jpw5c4VzBIr0mzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010019; c=relaxed/simple;
	bh=RZt/5S2pYmISVbpwMRrUmWwXobHLgHQpgwPmB3gZmAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nV+w9Sq6TrkdcRSCHm9mtPPPscwPFuLXRi5U1cEvmk1n8Fl9m1mxlyyC5BLQO8nNgv+YFRcWCqGjqYtktDOe1kt3IYzhN48tIkdDsM5i0baz6ME/GjOepfVXvD7tbcKqxjDSwhTXk3r/avRV5s8W24zt+qvL/6hCGncvyWwUuHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToQTGhcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B88C4CEF0;
	Tue, 12 Aug 2025 14:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755010019;
	bh=RZt/5S2pYmISVbpwMRrUmWwXobHLgHQpgwPmB3gZmAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ToQTGhcZ9qOZ314uHcHDyIRrl5cg9tT4Y30DoFSE1xAWuG8TIvcDNX8ppvQplm62+
	 JNVIaZCK61/TYYGlzR3Bvm8+3QGLTNbyc2jhSEjVUvEIVxsfNw4i7vAFm4AJussCim
	 2Dxsv+Ef4Wi0Kt5kpgn+huCaxCm6c8TS+MyWsyd5h/IWGoJGa3FlDv/C0KLMsaeKHL
	 LSECnMIBPdbZCqwcxE2IfHuPBvtMVr21QWhVYemv64zH5+YPwv7tsHwJ8YvKjngECA
	 1FgnUCVhPUKe4ZmG9AAyphYAg3L9GaJyniPbBIMuHh5KJUmLXCpnsdZBuzuElXM3GX
	 yMqwyRrqcguaQ==
Date: Tue, 12 Aug 2025 07:46:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parav Pandit <parav@nvidia.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>, <jiri@resnulli.us>, Jiri
 Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 1/2] devlink/port: Check attributes early and
 constify
Message-ID: <20250812074657.368dc780@kernel.org>
In-Reply-To: <20250812035106.134529-2-parav@nvidia.com>
References: <20250812035106.134529-1-parav@nvidia.com>
	<20250812035106.134529-2-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 06:51:05 +0300 Parav Pandit wrote:
>  void devlink_port_attrs_set(struct devlink_port *devlink_port,
> -			    struct devlink_port_attrs *devlink_port_attrs);
> +			    const struct devlink_port_attrs *dl_port_attrs);

Why not rename to attr, which is what the implementation uses?

>  void devlink_port_attrs_set(struct devlink_port *devlink_port,
> -			    struct devlink_port_attrs *attrs)
> +			    const struct devlink_port_attrs *attrs)

