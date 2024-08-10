Return-Path: <netdev+bounces-117356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4589394DAD5
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF501F224FE
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4191E13958F;
	Sat, 10 Aug 2024 05:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbpfL1mH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7891311A7
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723266375; cv=none; b=eYL/8fawUF8yLJNQin1UoucL57Suri7Dx1hDv/7NiyV7COgrsqpSW7wQ4WZTosMfQbT+Y0DHbW7f6QRe1Eyy9AB/cgCjvfj8HknhgDOSm5Fui8laUKK7354s6/QM1+068PWeS+7rnfmy9RXAiI/QSPFytpMO/IMhogcmEeLyV2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723266375; c=relaxed/simple;
	bh=2T5bbckQYbWGZGSDZoiAWMEXkNTvIczXI+IJo4uJiO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rug+OMP5DJmIwep2raX9eAQ3qofU9CzJf40XbYLefBjaaUGLFNUtXdI9XjsWlMI9dlWFJSmwqKxih+ty4zCc/EGDtmj/dZduQEyRiNMfwTezk9K9pjIvgizJsh7lrk0fFnbaaig+xTvMu2rd/hVHETkZ2HDocRy1DsosS30A8Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbpfL1mH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF8CC32781;
	Sat, 10 Aug 2024 05:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723266374;
	bh=2T5bbckQYbWGZGSDZoiAWMEXkNTvIczXI+IJo4uJiO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XbpfL1mH5Ml52wEnYAa7bXzaQot/22iYMBJi51tpKtMtnmmupF1tSnCaDRoUxjD5Q
	 A1Vynd7NK6eh+r+UJKnylojE7LgaNef1QprGGDEtDTasQbLytLNxWmga++grRETCtG
	 PPGq9NfXChIAO5pbwaQSg6dqZx4r2iqX/llJZaVLnSLr7rvfHPoGODn64SP+GWTnGv
	 m03RmncZnqck7CpBlVyasxKMpGNOHYIii3h6WWihLSYA9N4rhRU58l3ws/6PdY1qj/
	 7PZScRwrq5aPxL1GfynRjQ18PY6/n7EewHHiZRdL9Cs/Qw5eD2DkOrZfTzoEXbngxG
	 8Vuru5RsJWJfg==
Date: Fri, 9 Aug 2024 22:06:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Junfeng Guo <junfeng.guo@intel.com>,
 ahmed.zaki@intel.com, madhu.chittim@intel.com, horms@kernel.org,
 hkelam@marvell.com, Marcin Szycik <marcin.szycik@linux.intel.com>, Qi Zhang
 <qi.z.zhang@intel.com>, Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next 08/13] ice: add API for parser profile
 initialization
Message-ID: <20240809220613.27588caf@kernel.org>
In-Reply-To: <20240809173615.2031516-9-anthony.l.nguyen@intel.com>
References: <20240809173615.2031516-1-anthony.l.nguyen@intel.com>
	<20240809173615.2031516-9-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Aug 2024 10:36:07 -0700 Tony Nguyen wrote:
> +/**
> + * ice_nearest_proto_id
> + * @rslt: pointer to a parser result instance
> + * @offset: a min value for the protocol offset
> + * @proto_id: the protocol ID (output)
> + * @proto_off: the protocol offset (output)
> + *
> + * From the protocols in @rslt, find the nearest protocol that has offset
> + * larger than @offset.
> + *
> + * Return: if true, the protocol's ID and offset

drivers/net/ethernet/intel/ice/ice_parser.c:2307: warning: missing initial short description on line:
 * ice_nearest_proto_id

