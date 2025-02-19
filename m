Return-Path: <netdev+bounces-167598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0857FA3AFD1
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0006B1891B83
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0844613E41A;
	Wed, 19 Feb 2025 02:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FT43lvWT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60CE28628D
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 02:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739933604; cv=none; b=LXmpweHOa2n0z4c74KS79xJl2tZe+9o92Yom3beDbmg/BiYMseS8kkGZkLZauFt7cZXamIq/9mSwt7vOptWz5h4svwTcOf0tbwSLX/OaGMTSJ1jUwNvdK/ToBXFuYO6CN456d7fzn4dhHAcWJQO0oFWTr48kZPEsPj3M4WiTYCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739933604; c=relaxed/simple;
	bh=LSOgYcYXvIkaS3yycz3WjU5gpd5R0H8v2V8EVEMDW6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJLdiDReKlwOB40skNhsI1FrnheFhANVbIz5DJFrLU9rhOj7pghiUA6iAJXItQ9aKYPgxcb9IOKam7RTboBzR+1XI0ziA3Cy1r/2vY0L7z5iYblhLuiugbF7OHs4NBvzJWE7BluHMiAhOGCakBiqBm0hW/rvqYXNwT9pxJt8G+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FT43lvWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14954C4CEE2;
	Wed, 19 Feb 2025 02:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739933604;
	bh=LSOgYcYXvIkaS3yycz3WjU5gpd5R0H8v2V8EVEMDW6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FT43lvWTSmaJd36ziPob8YtVAaoqkEQDghksMC26BkVK99GitmkQE6DPMINWK2AFo
	 Kh0a2sxce01hIMhblowWw0aLKkndFZfI8IUUnMVx+dbl8VjsTvsD3xR49GVoMgPmgG
	 BTfTFxRBDtc+rGLE/WOy8SrQaxPcxb4u8Tpje/SU8r6JH6wZBH0ZUbIWOop1aGac5U
	 Zkuk6vX0qbixbM3fbUpjwjqFz4H7tqI2v2DxsRyGab9feBVsiS5ingzgHUbR4hTfqQ
	 cQkMtZ06YRXBjB325t4aIYXbVWWfxJmoIx19IcZ6sNdmiyNVF1Qcs/Oep2klrqtWdC
	 gvy6pR/TD4G2g==
Date: Tue, 18 Feb 2025 18:53:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v4 11/12] docs: net: document new locking
 reality
Message-ID: <20250218185323.70f61e4f@kernel.org>
In-Reply-To: <20250218020948.160643-12-sdf@fomichev.me>
References: <20250218020948.160643-1-sdf@fomichev.me>
	<20250218020948.160643-12-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 18:09:47 -0800 Stanislav Fomichev wrote:
> +RTNL and netdev instance lock
> +=============================
> +
> +Historically, all networking control operations were protected by a single
> +global lock known as RTNL. There is an ongoing effort to replace this global

I think RTNL stands for RouTeNetLink. RTNL -> rtnl_lock here?

> +lock with separate locks for each network namespace. The netdev instance lock
> +represents another step towards making the locking mechanism more granular.

Reads a bit like the per-netns and instance locks are related.
Maybe rephrase as:

  lock with separate locks for each network namespace. Additionally, properties
  of individual netdev are increasingly protected by per-netdev locks.

> +For device drivers that implement shaping or queue management APIs, all control
> +operations will be performed under the netdev instance lock. Currently, this
> +instance lock is acquired within the context of RTNL. In the future, there will
> +be an option for individual drivers to opt out of using RTNL and instead
> +perform their control operations directly under the netdev instance lock.
> +
> +Devices drivers are encouraged to rely on the instance lock where possible.

