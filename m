Return-Path: <netdev+bounces-170889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A2BA4A6EC
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 01:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7207F16AF8F
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 00:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6AC63A9;
	Sat,  1 Mar 2025 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I40fBvO0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DFC4C98
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788510; cv=none; b=kaDsqdr43Phvu1Xf0OTFbVf6AF4SZpDclSsTEM+u02P2dhEVeby2EZFc99SZ+hzyzJG6rUZ4HB6opqRytAvmUzBaLPkTWHuqYVfmwH29HKiq1wqoKbFleYSDPpE52kBzu8cQCBy6Lg4erxyczWa1ZuixWlfcNDOUlR1csxhVLAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788510; c=relaxed/simple;
	bh=aL/I8rHhO3fQ39gXZRKzRS9OTuR5y6q1r0Nfj7Kj7bc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pxidsm+nlkIeE7up+llksiurDJhcwsGG8C5MyJmfyOoWAITdBjUtIVovZdXCA2Dz3QuvOJfUeIU1gC5ec/gItUhKOZP+ZZaM9vwyxehk5TjEffwpd8DhYV3QoXKIMad4GvJbHvdlvdN5fDulAetgUQ9V+Br/6D/3oS0Op1q0I28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I40fBvO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D790FC4CED6;
	Sat,  1 Mar 2025 00:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740788509;
	bh=aL/I8rHhO3fQ39gXZRKzRS9OTuR5y6q1r0Nfj7Kj7bc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I40fBvO0cr++89Nqr6eKQqGmKqNxDeE8cP5Ddh/CDwVFyngy5H4NA1xMC4fYlWAU0
	 x/Z7ZyELTx7pksvXDNMb1qTlJNZA5EpRFCSGJjOlZ4tkbW6RnvJGykPeI1BM2F32RS
	 3c+qahfg6wkyaAlXB10zPUQiXXBOE8QzFc673krlxJjPWYAIyUcs2Izz9mjzrPi8cm
	 CRmpSEZqeZBxB1fl+fGQdBFblwcfHvd/Cjl8VH8nNbEGn1TDfNvSDPZJhkvOfzETOp
	 IKlt/+6tYFJyJIcaE8gyNvDNR5nKiSbuecp4060PTq8RwXe14kBw1zrsfFWox8nfxX
	 VrBtyEPoF/Jhg==
Date: Fri, 28 Feb 2025 16:21:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: allison.henderson@oracle.com
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 5/6] net/rds: rds_tcp_accept_one ought to not discard
 messages
Message-ID: <20250228162148.3301b20c@kernel.org>
In-Reply-To: <20250227042638.82553-6-allison.henderson@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
	<20250227042638.82553-6-allison.henderson@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 21:26:37 -0700 allison.henderson@oracle.com wrote:
> diff --git a/net/rds/rds.h b/net/rds/rds.h
> index 85b47ce52266..422d5e26410e 100644
> --- a/net/rds/rds.h
> +++ b/net/rds/rds.h
> @@ -548,6 +548,7 @@ struct rds_transport {
>  			   __u32 scope_id);
>  	int (*conn_alloc)(struct rds_connection *conn, gfp_t gfp);
>  	void (*conn_free)(void *data);
> +	void (*conn_slots_available)(struct rds_connection *conn);
>  	int (*conn_path_connect)(struct rds_conn_path *cp);
>  	void (*conn_path_shutdown)(struct rds_conn_path *conn);
>  	void (*xmit_path_prepare)(struct rds_conn_path *cp);

This struct has a kdoc, you need to document the new member.
Or make the comment not a kdoc, if full documentation isn't necessary.
-- 
pw-bot: cr

