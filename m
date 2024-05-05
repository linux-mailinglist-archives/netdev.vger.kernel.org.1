Return-Path: <netdev+bounces-93496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E449D8BC183
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 16:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A061C2094B
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 14:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA062C1B4;
	Sun,  5 May 2024 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btUGtZZ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280B51E48A
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714920818; cv=none; b=hUI8pY5yBvqO/bLSsb6MtVLmVLMzvBdLutKi8SEdIJjfrVQpFz5hFogw1vITd6RWNS79MmwXRXWKViIRuK94gqZPG9d/xB9xAxNhDMyeKDR4lb+dOsIf43bEa7j6yADRcRKf46I2tbQj0U5OFFDvE1bCbS+8QbhUjxfTVWjiZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714920818; c=relaxed/simple;
	bh=U3p7X9MpCsLkBtiN+hiDQozS0v4BnNcA5vikdd4YLnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0W5k/fx1jMlbk2y6WKcszrZSC8B4YettWxEn4iS1gh7r62D5AknNd+eET9GpCWcUiX5C5XzWuV8bjd4JBh9HQKys6hd165ls9JODfuh8cmwkqFFUEXCHVtdrn41XNPwY+Eh0YcqyjwTsRfRS3k9yhGGqxh0WIa8HGfEAuQd/ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btUGtZZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FAFC113CC;
	Sun,  5 May 2024 14:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714920817;
	bh=U3p7X9MpCsLkBtiN+hiDQozS0v4BnNcA5vikdd4YLnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btUGtZZ/FvMMynkQCRKb6r+T8SaDtfuKz98k+2HGLNOa5jOoUPwIt+KucdGZwVuqe
	 cFG4PqbXFOD7crk6GHAL+6gxfEoEqqXONrsnd5DWIdxzBen9SA3kJY+K17Hp5NnRUU
	 GmHd/SyoiJ8C7bNALZX8PBOfYt2MpKOGfInL2MT8EDzfszLLowyFvySJRrbMpNTXU7
	 60GEHrSFt5RTwn0/g+ySL0vmi7OX3dsyn92CmRTeoyEAfKczZkdQkfGyfMhxvpxQSU
	 CEtV2gFNzeOiLW/+Yf9cpW4aavUIpbDJK/ojNI04Yxoi42I+vdMuukGKXrGFkTZdPK
	 ZitdxdR5xc8zQ==
Date: Sun, 5 May 2024 15:52:03 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 6/8] rtnetlink: do not depend on RTNL in
 rtnl_fill_proto_down()
Message-ID: <20240505145203.GE67882@kernel.org>
References: <20240503192059.3884225-1-edumazet@google.com>
 <20240503192059.3884225-7-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503192059.3884225-7-edumazet@google.com>

On Fri, May 03, 2024 at 07:20:57PM +0000, Eric Dumazet wrote:
> Change dev_change_proto_down() and dev_change_proto_down_reason()
> to write once on dev->proto_down and dev->proto_down_reason.
> 
> Then rtnl_fill_proto_down() can use READ_ONCE() annotations
> and run locklessly.
> 
> rtnl_proto_down_size() should assume worst case,
> because readng dev->proto_down_reason multiple
> times would be racy without RTNL in the future.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


