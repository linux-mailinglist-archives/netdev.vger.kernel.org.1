Return-Path: <netdev+bounces-187499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A733AA77DE
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 18:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A3C3B571D
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6356525DD04;
	Fri,  2 May 2025 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZGMfLl9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1BC1A5BB7
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204885; cv=none; b=Go3udBRUoLOqswTx0WU6q46d1H3pV/NnyS/x1msq9qpA2SR2259GLbI+tNZbIQLjP4zTbw7UZTgAS/1GSWu1k2Z4+9VoN5N0W3rILsd6V4gqHO8g43clhrUjfihjKZkiThFFhDEWPaiwR1nYhwF1lAb8vLTHGjjm81vKTSpSc6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204885; c=relaxed/simple;
	bh=gmoUu0MuCihduqTPtESgW9uZNMasoRLjsJb5MsIktJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXYLzS4x6440MCCR8qPkp18PdPXFB7i1zZRweUyWNUfbEF7wYrLEcJ3phr06SY5OysnLIFbGqQten+da2fozSKnoVVLtvXpoaHEGYbbHJTMQGNAEklXz1FfCj9+e8rCnMfH4bhONXXEkrC/q7t94TknYBKHkZXIYd8LeS7J8b5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZGMfLl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBB0C4CEE4;
	Fri,  2 May 2025 16:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746204884;
	bh=gmoUu0MuCihduqTPtESgW9uZNMasoRLjsJb5MsIktJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZGMfLl9ReX4CQEjHd1YKmGo2SD3gxcEkcU6VxMKHIQ7z3cp8O9oBPiIRwrTNtklY
	 gLsZ/M36ley7aBwLbSfws2TMSkpyqxee6JYjOTRLk85zrTuUh79bAQ7JBaei+Wyr9Q
	 Ox3YhOwpHK1BOajsfOmH4iHbCzbam3GrR1ODN7icgIP87LFxewamrGv6MIQpJ3T8zp
	 8dUKOhJnvRT1ab9sZE0IwuyfSUuurXKzMupCdB/jHftCMjKxl+7/XYSaKAp+qn6lq7
	 prQSmrqaaSq/XIxcCTFhxJUJWYfvFU9fkKOkjBMILsFV/l8wleZYuh5NdGfeKnUJUw
	 oiFiGEutufibw==
Date: Fri, 2 May 2025 17:54:41 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [net PATCH 6/6] fbnic: Pull fbnic_fw_xmit_cap_msg use out of
 interrupt context
Message-ID: <20250502165441.GM3339421@horms.kernel.org>
References: <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
 <174614223013.126317.7840111449576616512.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174614223013.126317.7840111449576616512.stgit@ahduyck-xeon-server.home.arpa>

On Thu, May 01, 2025 at 04:30:30PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> This change pulls the call to fbnic_fw_xmit_cap_msg out of
> fbnic_mbx_init_desc_ring and instead places it in the polling function for
> getting the Tx ready. Doing that we can avoid the potential issue with an
> interrupt coming in later from the firmware that causes it to get fired in
> interrupt context.
> 
> In addition we can add additional verification to the poll_tx_ready
> function to make sure that the mailbox is actually ready by verifying that
> it has populated the capabilities from the firmware. This is important as
> the link config relies on this and we were currently delaying this until
> the open call was made which would force the capbabilities message to be
> processed then. This resolves potential issues with the link state being
> inconsistent between the netdev being registered and the open call being
> made.
> 
> Lastly we can make the overall mailbox poll-to-ready more
> reliable/responsive by reducing the overall sleep time and using a jiffies
> based timeout method instead of relying on X number of sleeps/"attempts".

This patch really feels like it ought to be three patches.
Perhaps that comment applies to other patches in this series,
but this one seems to somehow stand out in that regard.

> 
> Fixes: 20d2e88cc746 ("eth: fbnic: Add initial messaging to notify FW of our presence")
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

...

