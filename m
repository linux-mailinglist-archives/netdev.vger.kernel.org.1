Return-Path: <netdev+bounces-123564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C3F96551C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A181C21FCA
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ACB482DB;
	Fri, 30 Aug 2024 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkKKqUJw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F528DCB
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983754; cv=none; b=JvThqhRbSIv2Ou7fpkP60fPI0VCHCa9Yoc2k/jOialJKb2DSmbOJ+LyIT/6wfIQeU0SD+/oWM0AzuUQ/k/60q5ypxZbBIh9Miktqg86SVlIjTZj4UtVtntizkPlPqw8ff4OLH5RAOno70SHT6dj3vBlhFogYneaLJqO8YKUcvR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983754; c=relaxed/simple;
	bh=vMuoZjZX4HDxSuFFUFm/l7wtZeJQMXbYBRk31JMt+wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzX3Ys0mCKD4153sBU+DqHjcc/eG0r46v/0oJGn/8mFhqb/JqJDD2sS0+49hsmaz4jox3uRiTp6TK82FHycBar9za28AOKLHd9Yqn4bR0qsiKr+o/+h671fdpQ4O0q8CmpbX9/CEuDP/LuX2qTuGBsFi1I7M7cvAROL7/HD2Umo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkKKqUJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D31C4CEC1;
	Fri, 30 Aug 2024 02:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724983753;
	bh=vMuoZjZX4HDxSuFFUFm/l7wtZeJQMXbYBRk31JMt+wQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NkKKqUJw1jC08CDorDQxDShoOqOPLaVQoDdmXqIzlDkaxbkICDSBve6pyw31RcYJp
	 gkM7o5aBbmk5xMGFT4YkIVTVoMdf9CCp381MQtx4w7bXGJvBxC3eWIVeXWY+G/x/SA
	 cv2/f4hNXlhvJ3lK/LEw8B2lXO/m5/6O8SnM5ZhVN1CC04eaJt1nHg2DMFhqgMCmAb
	 MNAglBHzIoW7Qa9NpoOwQadiUOShH94gEmU4SwVikYYXHY1fOnR+Qwdm5oitcR7GYn
	 jAVDpINAN2tSOxK/atoDALJ3VYQ2gVpCNGWgEsJqfYbtzLk6PsxKLWllnV7n0YuFGx
	 kMmf71zxUe6GA==
Date: Thu, 29 Aug 2024 19:09:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v5 net-next 11/12] iavf: Add net_shaper_ops support
Message-ID: <20240829190912.6f9055d2@kernel.org>
In-Reply-To: <8b95089a48ebe8ae26a8904b62a39639688e3ce2.1724944117.git.pabeni@redhat.com>
References: <cover.1724944116.git.pabeni@redhat.com>
	<8b95089a48ebe8ae26a8904b62a39639688e3ce2.1724944117.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 17:17:04 +0200 Paolo Abeni wrote:
> +static int iavf_verify_handle(struct net_shaper_binding *binding,
> +			      const struct net_shaper_handle *handle,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct iavf_adapter *adapter = netdev_priv(binding->netdev);
> +	enum net_shaper_scope scope = handle->scope;
> +	int qid = handle->id;
> +
> +	if (scope != NET_SHAPER_SCOPE_QUEUE) {

should be checked by the core. add "mask of supported scopes" to caps

> +		NL_SET_ERR_MSG_FMT(extack, "Invalid shaper handle, unsupported scope %d",
> +				   scope);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (qid >= adapter->num_active_queues) {

should be checked by the core..
we prolly want to trim the queue shapers on channel reconfig, 
then, too? :(

> +		NL_SET_ERR_MSG_FMT(extack, "Invalid shaper handle, queued id %d max %d",
> +				   qid, adapter->num_active_queues);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}

> +static int iavf_shaper_group(struct net_shaper_binding *binding,
> +			     int leaves_count,
> +			     const struct net_shaper_handle *leaves_handles,
> +			     const struct net_shaper_info *leaves,
> +			     const struct net_shaper_handle *root_handle,
> +			     const struct net_shaper_info *root,
> +			     struct netlink_ext_ack *extack)
> +{
> +	return -EOPNOTSUPP;

Core should check if op is defined.

