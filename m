Return-Path: <netdev+bounces-101604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316A58FF8C2
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 02:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80B5B22E5D
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 00:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50192525D;
	Fri,  7 Jun 2024 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPL0U5Rn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEB8746E
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717721426; cv=none; b=lwZfaWG/c/fpEahD4+TTkFrrxIidmpARdAkSZ3Oe72PFOt7U3Bl0XW3kTe51RspVAssxCravJopS4WPhVr4Tz58EBNzKsb19f27kyYeCl/7PVoqSVsmMjpGX4Gl9DZOpLWsHYzeJzo6p6L54uZH4EnpNt16SJpkV95/cdtPNAVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717721426; c=relaxed/simple;
	bh=M7n8Pmht3UDHkemmCyMGykaZiMRA8n0dWCVpYAJG1xc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHyyJ9A7cHw0qz2OqlRNo2buF+OrDSDADdXfsNX+O5ulrfDrtt6Dnux50I/nhTCy/rVo26jgtZ7Qz5GJ8udmZ67v94C6fXLaHnxQ7FSTkOcr8lCxIA9lOgfhLpeYvxssFQAELb9x8+o6YzWUErObfU6b+MzoZ8ckUAs2Vd9pMX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPL0U5Rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605C7C2BD10;
	Fri,  7 Jun 2024 00:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717721425;
	bh=M7n8Pmht3UDHkemmCyMGykaZiMRA8n0dWCVpYAJG1xc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vPL0U5RnC4WQ+a6RR+I2sMnfWV4sciAoEcYr5U8ouqbmD+vkBuRbMgv/2rkMCeR9A
	 G6bbKo4MqnfoUPVl5eGNI4ZxZ37nnr+aVcI/KinxlOwllKhbLbceQ1CDOo1duLPzzP
	 MkPnD5WjwHHrDhqWp1TWbCikRM9S05gVWVa7aGpyX8v4IR2ARF+BdmxYWbWl4NMGno
	 NiHhqeUQ+l1LHrtH0ulGZ5i3dkKmT2LWp1laN6k+UC/MFyyPdvYAgSw/nLqxvvven5
	 glEBtrwdTLnp4wkAIxCbNAi1J2L4E6nEbNiZ6Tx1iHmJWxQjnnVDlFl8+tpf99OgFh
	 z+36lVLLk2ohA==
Date: Thu, 6 Jun 2024 17:50:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Wojciech Drewek
 <wojciech.drewek@intel.com>, Sujai Buvaneswaran
 <sujai.buvaneswaran@intel.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH v2 2/7] ice: store representor ID in bridge port
Message-ID: <20240606175024.1274d1a8@kernel.org>
In-Reply-To: <20240605-next-2024-06-03-intel-next-batch-v2-2-39c23963fa78@intel.com>
References: <20240605-next-2024-06-03-intel-next-batch-v2-0-39c23963fa78@intel.com>
	<20240605-next-2024-06-03-intel-next-batch-v2-2-39c23963fa78@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Jun 2024 13:40:42 -0700 Jacob Keller wrote:
> -struct ice_repr *ice_repr_get_by_vsi(struct ice_vsi *vsi)

You need to delete it from the header, too:

drivers/net/ethernet/intel/ice/ice_repr.h:struct ice_repr *ice_repr_get_by_vsi(struct ice_vsi *vsi);

