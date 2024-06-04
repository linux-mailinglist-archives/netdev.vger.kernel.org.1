Return-Path: <netdev+bounces-100742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230048FBCF2
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 22:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5827285692
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 20:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEC714BF97;
	Tue,  4 Jun 2024 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQXJ4Y8d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386A614BF90
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531410; cv=none; b=VA6J5r+y4/kKhD+YnLtJ/1Peq9VVwjy/3KXWQ6biKrBrg9i1WOhmjJ6/Nad3ZeKd4ds3uEd03B44U638JtDyH3v7UotIZrc6jxqW6bPw+gdU81WSN/5upRJVetTAL9eUn8FOCuNZZvzWXRpnVWOpq5+73NlBySYC0gdLRickadQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531410; c=relaxed/simple;
	bh=EJ+nb6mgvXrcrNlOanEIBui6TzSBWrbnSmX33lbKiNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alzZFtZWE+5yief/b1IJuWdHz1v8valYNVrzzphG/aiAFbpF6IK5BgN0Le0qijLDKhi2u/tneeVQNoLyhLlBqu5alUbW66+IMxdJ1dbrWx9P5As0FnZshUwljx6d1b5IMjKv/rh45JiY8Rd72S/ErUNDbFFPzeV+Z3pp20hvpKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQXJ4Y8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C22C3277B;
	Tue,  4 Jun 2024 20:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531410;
	bh=EJ+nb6mgvXrcrNlOanEIBui6TzSBWrbnSmX33lbKiNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQXJ4Y8dGkz8duRPQxu77vrF8mgJz1Lh/sTVZB2MtnWWs6cmycgOr53gMhooBXcNm
	 Mv01PJUtzoWj6JuiAN4fDY7XdAZBDTTbzH6imVkknRPuNh0wlS8PgRRDcds98w0YWn
	 9aNrOynJ0+STzXZb2wSqjNiwnQl5AZuwTUlVzmNlJpOJK8y49xXfzB1e2u3aZ96BgN
	 10yfJFiJMEpZRLAJbtVv0Nricu/BxVwM+AsI3hUHvtyDaQDKLcOcpp1yJtaDQZSHTS
	 u3NcnAerbXrDx23TYvXR5r6fHkpxnUebEXVf/2gLPpY5cJmcBoXsjPPoWDRg2g9hiF
	 Zb7AhNNBHI4uw==
Date: Tue, 4 Jun 2024 21:03:25 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: annotate data-races around
 tw->tw_ts_recent and tw->tw_ts_recent_stamp
Message-ID: <20240604200325.GF791188@kernel.org>
References: <20240603155106.409119-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603155106.409119-1-edumazet@google.com>

On Mon, Jun 03, 2024 at 03:51:06PM +0000, Eric Dumazet wrote:
> These fields can be read and written locklessly, add annotations
> around these minor races.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


