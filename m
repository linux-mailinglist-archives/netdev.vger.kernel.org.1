Return-Path: <netdev+bounces-169675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0895A45389
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 04:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E401B3A60C6
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 02:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCA721CA0B;
	Wed, 26 Feb 2025 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hggGxrX3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EA3A59
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538807; cv=none; b=rzLoEM573q+d4QM7gIZU3hIf9LmPiTJnbVZ4B5MqlMTz8f4CIe8nBrKzMEoff2WitkkBHTPItHFE2xK0aV2P8p2lDGj6HKVIUKk0pl9666TAqb3biKpEC2owybbEQdu7CtdY7ipi33T2RGR6DM9NI+3FCrb+4p7APwgj1Z1VMHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538807; c=relaxed/simple;
	bh=A0cLISTBOi4znqoIiQmKQOQiRDb0CqaOS+6gKqsaKz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8iC0ZbeKoSaoeY+vLeC5Z82sCD6btNr+5k51pT0wtoY8cCifgtlusxHyxim/R8woFjZEFiD7v71y+j7jdmjROgFbXYAeHooGmA+WWU5lF8LCM4APqp0YEBKY5XGmHJcEYB6b6eAYNSK/nRQ6duoo2WZTlpsvnMkRnnh9iIg+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hggGxrX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E77C4CEDD;
	Wed, 26 Feb 2025 03:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740538806;
	bh=A0cLISTBOi4znqoIiQmKQOQiRDb0CqaOS+6gKqsaKz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hggGxrX3HUi6ueFCivfwVhYXDIS9H4R2EEybywgrmIBLAPQ/fC5gnquZ7YZVRSWT4
	 9G8R8m1ypq7taL5OfWncmttn+Yxm6yx41Ij59yuQ1HBur0aRWDn8h6Tb7HU7rQx/J6
	 m9WtQzOyCJblw34Awnrou2mB8aTh66OwOET8WvR4fRwE2tBsX0SvMI8Q3mJoAgg2gO
	 ng7jGdbAkk+E3EW9PVM6ZBzF1F/RewUtlV2zoS0K/F8QGkpcYn2hSXTSFaikczm4QG
	 1+IO+NOe/XHT5EJ0KVoW/yPGT8kTQt3wUpp6fehYADt82NBSU8Q3D/XluvXyUmdjse
	 xF2LwZx+hcyHA==
Date: Tue, 25 Feb 2025 19:00:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v7 04/12] net: hold netdev instance lock during
 rtnetlink operations
Message-ID: <20250225190005.2850c2da@kernel.org>
In-Reply-To: <20250224180809.3653802-5-sdf@fomichev.me>
References: <20250224180809.3653802-1-sdf@fomichev.me>
	<20250224180809.3653802-5-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 10:08:00 -0800 Stanislav Fomichev wrote:
> +static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
> +				     const struct lockdep_map *b)
> +{
> +	/* Only lower devices currently grab the instance lock, so no
> +	 * real ordering issues can occur. In the near future, only
> +	 * hardware devices will grab instance lock which also does not
> +	 * involve any ordering. Suppress lockdep ordering warnings
> +	 * until (if) we start grabbing instance lock on pure SW
> +	 * devices (bond/team/veth/etc).
> +	 */
> +	return -1;

Does this no kill all lockdep warnings?
We still want AA splats for ease of debug, and lockdep warnings
involving other locks.

