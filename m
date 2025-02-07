Return-Path: <netdev+bounces-163752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B56A2B7AD
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9A018878D0
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC2727735;
	Fri,  7 Feb 2025 01:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SP6o5WlX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6107DA67;
	Fri,  7 Feb 2025 01:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738890847; cv=none; b=G/zxwNWhOJOtbjBqL9H5AenKFQoxAWJzZrt9VTU8DGKfwNYBqar+FH8GZEVu0mnqsoGNj3LuC/WlnAkTDu/r8Dfd/vsQYj1yd5/OIp7yeIq9x9OWaaU79T86kGr2FmPSlgEpeUYqf9JlobaPMZlRx54rH3UU/RaYF3+NjwGoS1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738890847; c=relaxed/simple;
	bh=ghl/9LiZ/JA57powXLoT0RWBoOSp3+YWLndH6YAVcpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VjRtQi7j07isoudJjg3SqVpvjIW9htL6EEyHsgKjFz8CTstHGiGjV8VOCMcygO+rBLNOVd+cQpEPPHvgUqQF2x1YVa7ExMRI5h3G2kxH12DxNWkYXzs0tOHRgpjt0XANUVHhOeZF+ipr6EXKeCINMcmv4kkV+ymb2uxB+H5dQlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SP6o5WlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D87AC4CEE0;
	Fri,  7 Feb 2025 01:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738890846;
	bh=ghl/9LiZ/JA57powXLoT0RWBoOSp3+YWLndH6YAVcpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SP6o5WlXQTZeIHZ8cF3jCJR6CkPqVBbK9flslsG2ez1AogDBcmvzOJh12VJ6GLJ7r
	 tc3StyQ2AI1AjbyGr4o9OLjd8nYAXnj4sbxA9F577eHVI2L7BdBekjOzDxan2AhIgv
	 toMG3uw5aH+qNNrIuSNtuAlkFzBSTI2UrPUJF1yzN1MA7jvZ1AAcEeYn+I+WsVsbWT
	 K24jB5SHaPzpkbFIvymYuJgf9opH3eGHaE7Og0jZNAD3cxp+IohOoAiWySBc+1vnjl
	 ZCiFAiXS70+nKhcqcwTOeMgVoEU8evXBeLWp1e9YxjumCHtzy4nJBdf4NGuFfiLnFP
	 ERki1tifZ7nvw==
Date: Thu, 6 Feb 2025 17:14:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 sridhar.samudrala@intel.com, "David S. Miller" <davem@davemloft.net>, Simon
 Horman <horms@kernel.org>, Amritha Nambiar <amritha.nambiar@intel.com>,
 Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org (open
 list)
Subject: Re: [PATCH net-next v4] netdev-genl: Elide napi_id when not present
Message-ID: <20250206171405.01f1552d@kernel.org>
In-Reply-To: <20250205193751.297211-1-jdamato@fastly.com>
References: <20250205193751.297211-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Feb 2025 19:37:47 +0000 Joe Damato wrote:
> There are at least two cases where napi_id may not present and the
> napi_id should be elided:
> 
> 1. Queues could be created, but napi_enable may not have been called
>    yet. In this case, there may be a NAPI but it may not have an ID and
>    output of a napi_id should be elided.
> 
> 2. TX-only NAPIs currently do not have NAPI IDs. If a TX queue happens
>    to be linked with a TX-only NAPI, elide the NAPI ID from the netlink
>    output as a NAPI ID of 0 is not useful for users.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Applied, thanks!

