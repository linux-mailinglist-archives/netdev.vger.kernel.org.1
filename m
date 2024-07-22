Return-Path: <netdev+bounces-112444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A05939170
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 17:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7396B20818
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 15:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9B416DC3A;
	Mon, 22 Jul 2024 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PK4mNMWy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9F916DC24
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721661008; cv=none; b=F3Zv5eNl2vt6UFvzP5Ut/JLRGD4uLQJL33zHwV4Og9cX8takGzphIF5QOy/7TwsjtUTwsXpKOdqTPzlqeDkbR7bUvmMq3yvauDWVwnkpRXHqFvkfQn9xKTOtcFl/BcVy4J/oHPRIJPiVnrgTA7aH0HWObIultMMQIRVsEelVBNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721661008; c=relaxed/simple;
	bh=W0ZtQw1OwdNdI0h383e5t2oHf+aozChGb8HmPG5npVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9Iz08hSSnOTlIWiuTE1jE9iXw5cqJODbhbx++HOeGvYvpehbnsBUQjGrwShZkClzCYWB/UMKg7gXMPlpIMvP4j3bFu7IowKys6EE7UwdkVKJuCdLaiUERYLp2UzxuKM/pzrz3P9PoY0V1ZBBlHs8XwZSc08xjWMa2wBLJ0okqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PK4mNMWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FF6C4AF0D;
	Mon, 22 Jul 2024 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721661008;
	bh=W0ZtQw1OwdNdI0h383e5t2oHf+aozChGb8HmPG5npVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PK4mNMWy40IliKUOTohGdefK7PxA3mVDq6jpIhrHOQW+t85WOxDb3b9PcVxJEJPiv
	 JVoLPcZjlkjoQXbxh1LuFt1eBLZDvydouyB8c2SyTNodZ5ISdSB0JiImo6K9BpR8wO
	 +agh+HWTx/TldyY3tAHUimAfthw3wa/1OTVZzMg3NaOaujnnBx5lzX4++nuD0RM62U
	 bubA1mReFqtq1T0kmXFdPtgbFzwGLAP6yHyMoR8h1XRVbnymfXhhvdJazx7oOindG/
	 XfHDGyyCCVFhPze5xm/ZqydKAHvPGdlhL40jsgUFf48c4I5JiF0Hnh243wYJCdRK5c
	 xpintjuYEAJTA==
Date: Mon, 22 Jul 2024 16:10:05 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v3 07/13] ice: add UDP tunnels support to the
 parser
Message-ID: <20240722151005.GP715661@kernel.org>
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
 <20240710204015.124233-8-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710204015.124233-8-ahmed.zaki@intel.com>

On Wed, Jul 10, 2024 at 02:40:09PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Add support for the vxlan, geneve, ecpri UDP tunnels through the
> following APIs:
> - ice_parser_vxlan_tunnel_set()
> - ice_parser_geneve_tunnel_set()
> - ice_parser_ecpri_tunnel_set()
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


