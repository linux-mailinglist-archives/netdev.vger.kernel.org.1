Return-Path: <netdev+bounces-112443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D72D939169
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 17:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E5C281B87
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E4016EB44;
	Mon, 22 Jul 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGAeyWCF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A493A16EB40
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660814; cv=none; b=asKCK/DtLXxaHsM+7rpnwXV+SUqoBUv0Lqa+gEYWE5fBCOiKND887tcqpbUDwOQqIIbCnJPgh50idpH8qxwcLn1GaqAO6z0GFC8JA3HysQnqx8A4nsO4IdxB+kRli6s/4eOXZnkU839naKW7DbWUWkMMfcYqYLIU4249IdKL0Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660814; c=relaxed/simple;
	bh=W0ZtQw1OwdNdI0h383e5t2oHf+aozChGb8HmPG5npVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKiz/1Pzi2rtq7mPpBaN6XsT4zlKhwtMRj4kXue0rxBrbI+L9gSw+CTS4R1qxS0XzkN21RdjeUKbYQIWYmteaeur8moye/Pv6rCnQ3UH7PuqmFcqNc1Ns9mrpjAOaSlfldc2IjatdSi2YJ0DqefzFf9TOhfbWC+2BbWegcqjCU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGAeyWCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BE7C4AF0D;
	Mon, 22 Jul 2024 15:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721660814;
	bh=W0ZtQw1OwdNdI0h383e5t2oHf+aozChGb8HmPG5npVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGAeyWCF23RCcgVIJxWdFiHzw4kVXyPBA1l8xVdv6CmMw8HGb75IjhkEMGLRZUJnc
	 FHVpnFPAOzr6p7tP6Cvcw9NjDMNFSFQXEYABbXbPRWhlQsFNBlOw/tLS2YvCCbfoRs
	 CcCmZtDKEg4ow5J8vjNAUklvxerq2b5wu4GIBT0MrWklvYa3MNhdEYet1f/tKq7ykG
	 YYgKpI40U6jdIJ9UIsXlP4fqqZh2s45jbL4C8IdmnyxZ2QCzGfQ0HNgKpn1MfHPOI1
	 pv8KCxSC+o73strawcqcPG7rwduB7KLY5DLIvTkKUAw+HBSe1+nswlbpxqVZ0EeG7C
	 GPZMegc0xTGiQ==
Date: Mon, 22 Jul 2024 16:06:50 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v3 07/13] ice: add UDP tunnels support to the
 parser
Message-ID: <20240722150650.GO715661@kernel.org>
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


