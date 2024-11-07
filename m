Return-Path: <netdev+bounces-142612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C469BFC6C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70AE1C213EC
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80419175AB;
	Thu,  7 Nov 2024 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VclsOTMU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF90168BD
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945463; cv=none; b=s5TvS/hh0qyvdsPjMyYpQU5wfqpx9qythbtgh6a5AwjRwudMRYUuZsZW6VnfS+AQsFgw49IIrmArK1biDURyxhCwVqHaKcBIlL4y7plXnFRpex9Gww85OVDIe1l15V7PZkHzUhisbORS8VP2JuGqX7gF2/++IvkIdtZpVuRGICg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945463; c=relaxed/simple;
	bh=pYuPz5CkOCEWWzQU9AnQkR4kzrzmq1aY8Emo9qIOJrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkLWId+YN/uhASPZ6ajrwI+PU35M85ryF/cmYZGvIiw6c+d5vQzr42QglOraHNpBOHN+/0efrxkPOgatnBpywHcS/2IRWBKYNvy4+dr3NRShD4DBfQtYbQfErv4GL03NsQEO/JuFIEQrzCNbf4cPBM1J8rMluoP6NNqI0rl8UUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VclsOTMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45735C4CEC6;
	Thu,  7 Nov 2024 02:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730945462;
	bh=pYuPz5CkOCEWWzQU9AnQkR4kzrzmq1aY8Emo9qIOJrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VclsOTMUql9XDQYNd4g33M5muAGSol+vdfD2C6AuOBt8JCiv0Jn94/R0ASRsQm9gA
	 2Ylyg0R/qi0+SQER72arrFbThkJURebyOqqlZa6OoDzMlY5w+I7rA72EbiTp4opV7/
	 3lYowIzkzLBhME4zk1VdtE1s/Q8tzSDt6a/lyjpWwF7SyKjc8cr4u/8BWdvAOYrTtk
	 FM6MKlYh7d8FGrDb0LtF3SUxxKsyNi1HXZPohHtWoPVhhnR2NfVZL4KC0fhAjeM0Sn
	 /TZNjq7WcVzIU1M/GoIRj0sq3U0mJVmdTCkhMPfAO0MCM2X56RLxMzqIs5hvC9tE2/
	 tVgaEFdJS3MAg==
Date: Wed, 6 Nov 2024 18:11:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Paul Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Pucha Himasekhar
 Reddy <himasekharx.reddy.pucha@intel.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 05/15] ice: support optional flags in signature
 segment header
Message-ID: <20241106181101.01eafbcf@kernel.org>
In-Reply-To: <20241105222351.3320587-6-anthony.l.nguyen@intel.com>
References: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
	<20241105222351.3320587-6-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Nov 2024 14:23:39 -0800 Tony Nguyen wrote:
> +static bool ice_is_last_sign_seg(u32 flags)
> +{
> +	return !(flags & ICE_SIGN_SEG_FLAGS_VALID) /* behavior prior to valid */
> +	       || (flags & ICE_SIGN_SEG_FLAGS_LAST);
> +}

nit || goes at the end of previous line

