Return-Path: <netdev+bounces-159388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7C4A1563D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4605C7A0FF9
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CF41A23A8;
	Fri, 17 Jan 2025 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OD+528Vo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEE919E99A;
	Fri, 17 Jan 2025 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136955; cv=none; b=lDaUoTd7y7taMtO/Aqtxt+XNrCc5z7QMnh/HJyDuCDH7lvpe2InymryONxAJ3z15njtuSFsW0MwO2IRe1CBgYUYtOZZ4xDgXo3lXxEMWdPyaitm9rdpO1VGb8xFw8nTnYg0ebsCULHDXDvG+qOxcteEgXg+iyXwolUQhA8Qiq7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136955; c=relaxed/simple;
	bh=c1yETGsmH+TKr9grAHERbGK4oSbOOfuIyoAfo6FuT+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHYPbZRtw9Ra/zpc+epT5kEs1CsbqjGAb0/3Z+61js4NlXPAVGU8A95IHBewIGKIvUWgD98Zk2Mpe6LNYU1V5aI/yyOlW2TysrW39nvhBWuwh3+3DOh2/262agB4PfQ+Nrmi/4FF/0MOl9//j58iiRYQ9qMz4d6zNNSGI3I+7ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OD+528Vo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE04C4CEDD;
	Fri, 17 Jan 2025 18:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737136954;
	bh=c1yETGsmH+TKr9grAHERbGK4oSbOOfuIyoAfo6FuT+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OD+528VoJjufED2muvl48/+qJ6/FH+A8vrNmG+wfNuuuktUIvHjmED1Ry213ooqsD
	 1/FOCi+zFOlY4h/+pT9RdvklGn2HELt2YxzcyCMv+CA9VPGVikYiNAWMg9IgjS5uMj
	 695HnxtNKd0tJywH6y/3CKTzI/Y+xF6XfoGKmHCPHnd33nfbE7xfc+kHfie62VCD+8
	 vchZshqHYeSXnROVfjlFSfP6QcrPQK611bZbrs6HEISAynrSN2HI7cF1CpQ2l4pROQ
	 O3M0V+bA8UbTUbA1kUAvyMcPaJ0hgEmqgHkQlBPw4rmfK5zpRlFz/RxYKTPdDwbY0A
	 RFqXpFkjX7//g==
Date: Fri, 17 Jan 2025 18:02:29 +0000
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] tipc: re-order conditions in
 tipc_crypto_key_rcv()
Message-ID: <20250117180229.GR6206@kernel.org>
References: <88aa0d3a-ce5d-4ad2-bd16-324ee1aedba6@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88aa0d3a-ce5d-4ad2-bd16-324ee1aedba6@stanley.mountain>

On Fri, Jan 17, 2025 at 12:36:14PM +0300, Dan Carpenter wrote:
> On a 32bit system the "keylen + sizeof(struct tipc_aead_key)" math could
> have an integer wrapping issue.  It doesn't matter because the "keylen"
> is checked on the next line, but just to make life easier for static
> analysis tools, let's re-order these conditions and avoid the integer
> overflow.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


