Return-Path: <netdev+bounces-122047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 933AE95FAAF
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CF1282F03
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528C378276;
	Mon, 26 Aug 2024 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrHbPwdJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4BB364A9;
	Mon, 26 Aug 2024 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704324; cv=none; b=KrobGn+vARDNtVM+hi4DCxt6S8Fjy4+ISb1w5RKg86OhY+WMCAKN7XYg19Di8bZGsaGFYp1IggyyHDPQ5gq59DqTedJ+2zHhqzR/Bq70IZ7HVpi0djT0QCFdaVKhs2aU+bT6W2mqyOQMBA6r7GNGAGKggzmHdtsuFlHYSMOg3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704324; c=relaxed/simple;
	bh=KRvbs77WcqubEIb5cFwXXC969pdORBlApI9vgtpysrI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNkNhcdfGfu3QJ1fdzUEXueut/eRNblBx+8hXb9wWpGirWJboN9S+HoGfcOEj9yT7PxNwQrHF/i4BVKbnRUSaY7HtsplL16oJE3UrUg2oJx8fKcAsNMdDH1JR7zpiXD8IEFMvj0gaWVUniSmvuM0DE1KAq5vaBGjmQ38wPc8mzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrHbPwdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A23C4FEA1;
	Mon, 26 Aug 2024 20:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724704323;
	bh=KRvbs77WcqubEIb5cFwXXC969pdORBlApI9vgtpysrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LrHbPwdJH4Pcrap4QcPRL+M+eIoSjfgaN4PkLIKP40V41Ygy8RKYuthpSeLHjTLnU
	 ntbV3JcHjuRSOBVfOwqy3wQ4jnswAeuGr3MKwYkGcviuhZci1qAV4Qt3E5gbF/Hn3G
	 FU6mKlpoEFvP9IY636NTq26nXD+p7T8QQyPssFjKkcbaKuvUFY06M5co0dt19GXe6K
	 nR3S8I/DdM7HRuGLSBilK2ke7K9r77HLQDNyspvrYAVChEfLoZntTQFmsRZukqHdGL
	 y7AcN3KaukU5zyBD1Ew+3ePqZ2vbPDZS4rhEzN9HljCo0vQIJOTe1Z4I9P5l6Y+jIA
	 WEmBsEc/ulSew==
Date: Mon, 26 Aug 2024 13:32:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Josh Hunt <johunt@akamai.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, davem@davemloft.net, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/1] tcp: check skb is non-NULL in
 tcp_rto_delta_us()
Message-ID: <20240826133202.5e8507ec@kernel.org>
In-Reply-To: <a76ac35a-9be2-4849-985c-2f3b2a922fa5@akamai.com>
References: <20240823033444.1257321-1-johunt@akamai.com>
	<20240823033444.1257321-2-johunt@akamai.com>
	<CANn89iJ7uOFshDP_VE=OSKqkw_2=9iuRpHNUV_kzHhP-Xh2icg@mail.gmail.com>
	<a76ac35a-9be2-4849-985c-2f3b2a922fa5@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 12:43:36 -0700 Josh Hunt wrote:
> Thanks Eric. I will resend and also check the commits you mentioned. I 
> didn't include the writeup in the patch submission b/c it was rather 
> long and detailed, but will include it in a v2.

FWIW in linux networking we use the cover letter as the merge message,
no matter how many patches there are. So both end up in git logs.

