Return-Path: <netdev+bounces-133374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4951995BE6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76285287F67
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEF8216432;
	Tue,  8 Oct 2024 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUWgqEFy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673F71D0B8B
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728431500; cv=none; b=ST8/bQlSElgkoSIxbDm/Gl51wtfTp2hmq1dIqe49mnGPZsA639ETiNBi9Y5WVjILDQMWxyPOzQRGIPwvyEJK3aYivlV6TF1Fyoccp59ptnmM69Gk8/Q7PhyqbN4C/YVplBnolFCrdJ/OasioMmDY/9S3v+VhDcZvEbhOcyIXg0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728431500; c=relaxed/simple;
	bh=vz8YZ24Hag6SvOb63hVxuoxPQOMzO7N8ox5d8Qw3hOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ka9Kx4rTi8OLkoIeE4vL/6K8R8IjQjYfnRMGkF1LaU4sKrE8Dn9C078rGsr4Tcd+Tyny8mcJ12HFVoW3yGDBJ/ayzovnXhHLDzR/7GPkxPItk0u7IFGQ1HMKFK/arqZ4F2TBl9135TBQKPLhw/+dUA0IeDcspLqD5hxZMuT8g8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUWgqEFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E82BC4CEC7;
	Tue,  8 Oct 2024 23:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728431500;
	bh=vz8YZ24Hag6SvOb63hVxuoxPQOMzO7N8ox5d8Qw3hOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OUWgqEFyFPd4zNHJ3Ey4YW/Gcfd+7UUQiXvjtbD1jq4+H7NqK2nK/Cz5qF/2HWZCP
	 CR5rwyZdn6e2kIhcmVPLvfL7BD12TINLEv3oPsbTEr4uqIaCUgMwkkXSpD23sRWU7m
	 YHwHcEMO1VfQ8iAM966MIoIZDXq7wJfLqZS3OvEGt9XqOfcSnSHSJ5Y368UVepzzgl
	 di5yvF/9FtCKFkAMIoUea+5mfWX2XrK6m06t/WTv19LIcIpJFiItyja6yM1JUiz5vI
	 7yMfzuL4tsNVIUTs39BUv03iZHSJ9PMspcyLa1lIPOwD1W61KhV3bT69tG+fXwZvYM
	 a0V1/I9H0Pb3g==
Date: Tue, 8 Oct 2024 16:51:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com, Stanislav Fomichev
 <stfomichev@gmail.com>
Subject: Re: [PATCH v8 net-next 07/15] net-shapers: implement shaper cleanup
 on queue deletion
Message-ID: <20241008165138.366827ce@kernel.org>
In-Reply-To: <094ea42117070aaacff25145b23feadef53dbfbc.1727704215.git.pabeni@redhat.com>
References: <cover.1727704215.git.pabeni@redhat.com>
	<094ea42117070aaacff25145b23feadef53dbfbc.1727704215.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 15:53:54 +0200 Paolo Abeni wrote:
> hook into netif_set_real_num_tx_queues() to cleanup any shaper
> configured on top of the to-be-destroyed TX queues.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

