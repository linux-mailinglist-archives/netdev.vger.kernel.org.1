Return-Path: <netdev+bounces-185820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4A5A9BCEB
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC28C3B0D74
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5B4154BF0;
	Fri, 25 Apr 2025 02:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlcvGmh5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1F154423
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745548592; cv=none; b=FsXZ685bx7PN3TFlessuSiFiRreuckl2SVEczM76L9C8ZUrX0e3bfLXkbESV068cAzFLxeMBzMTYDJPOUDv9WuMbgplwMfxtcWQ+9ZLIfL6ghL8arGi4FdSoQtztUhLeMtUJqSsaxPIS1BNPu89BoXelRu6ANV/1toXEQDHZjmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745548592; c=relaxed/simple;
	bh=h9sFxUhDSf8WP0s6i5KD93+p2r1zf5RF5h5UpnV2ECs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0CNk9tHVibgobrVA4PyhO6Cluyj/1g0LLxeZCnI/DjRnmpk+gYcTaqT9TJflO4f1OQ6z7qq+ncVG1ncIuPyt6YlDR0VoHEzUE91y5GLiIRPZkXKn+5R8WSdScb+je3TIWWecQ0lmHD0L7u95g6bVSjdryse/g8VUxrDWr9Gt4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlcvGmh5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F663C4CEE3;
	Fri, 25 Apr 2025 02:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745548591;
	bh=h9sFxUhDSf8WP0s6i5KD93+p2r1zf5RF5h5UpnV2ECs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FlcvGmh5ZFYKNI3RFqDMSTr56DkCKW0yZ0MLQlH+5ihBdlzM4yJZZGc2g8U0R2R7y
	 tFYWcsnGyVv/EfDPhaKclKfJeejNDnxrp1g21A+ccXkV2HHVG8pnhrjLBjPFYobza7
	 gToWYb4PGf2cIT1gz2GlfGQHCwJcELu7BS8Zq+NR+ndtq4Jw8Vv1iQ0dquQDp2U6f7
	 qiyrwa4fByOvRQqfApst/LEDFy3vXFOZKKItkSkHf9mQWB3VSMBbarcTb0MDToL6yK
	 yrwQZZS4DC3KrMxD1jbt6pXPBitTTZY4vg1avk9sRKMDDX9hUmDQzpHotQarBaD/w1
	 TSPAGbdK/8ITg==
Date: Thu, 24 Apr 2025 19:36:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <donald.hunter@gmail.com>, <sdf@fomichev.me>
Subject: Re: [PATCH net-next 11/12] tools: ynl-gen: don't init enum checks
 for classic netlink
Message-ID: <20250424193630.2a195593@kernel.org>
In-Reply-To: <4b8339b7-9dc6-4231-a60f-0c9f6296358a@intel.com>
References: <20250424021207.1167791-1-kuba@kernel.org>
	<20250424021207.1167791-12-kuba@kernel.org>
	<4b8339b7-9dc6-4231-a60f-0c9f6296358a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 08:59:45 -0700 Jacob Keller wrote:
> > +        if not family.is_classic():
> > +            # Classic families have some funny enums, don't bother
> > +            # computing checks we only need them for policy
> > +            self._init_checks()
> >    
> 
> I feel like having the comment inside the if block was a bit misleading
> since its talking about skipping the checks, but this is the control
> flow where we *don't* skip the checks. I guess thats a bit of taste as
> to whether this makes sense to go before the if check or not.

Fair, will move

