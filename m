Return-Path: <netdev+bounces-94744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9FC8C08AD
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 02:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC6DFB20A09
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 00:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABEB10A1D;
	Thu,  9 May 2024 00:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+7o5coP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A20DDA5
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 00:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715216009; cv=none; b=fm+ASfkyIMYOoZZWQvr9JRakIGK0/VvGB9Y0/n/U8/5Jmk8VW253n1h/+NuxbLdtGkOw7fyWzZOICEJsOXIWqGe+KPtD4AqWn1mijUWwVSUhfHaPyLy+geO5Hbrn3M7pQU2v5hEA5xhAEKwNQ4EqGqKzOGC6cob14LPBrYX97mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715216009; c=relaxed/simple;
	bh=U1BqdA3luMmbNZuY/avlaEcBNytu9kf/26cH5StYa/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQ72qlsclqyRCYzAQhnAEqIFop8GqhOlSI117GTZ3+5GjPd/zGaImHKi2JcrFcfygB5Ih9No/qNpsi7CvQVAXLxDDz05405FQ97xvRgLFoQrP8zffhZqnGm/hFUR6l2tQbTxKWvgpCKI4Gl4oSf22zdxxPqeCd+k59xS1fcwFMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+7o5coP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDC7C113CC;
	Thu,  9 May 2024 00:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715216008;
	bh=U1BqdA3luMmbNZuY/avlaEcBNytu9kf/26cH5StYa/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A+7o5coPp7uOntMgJMi3YxlKEF1FxXbbYMfmTIL7g6Y+GRgtcgTJ95uMt+lrerHVJ
	 dMdI2dmCIsMCJHytcLoui3nnL77ZNFInUIAOdv9gCAt/9TCetnqtLMSjH0P3i/NBrA
	 6g6BYr5PsCqcvKtehqRXlo9N3FYfnZ2gG8R0OCZ43hZrASxBP4UQFnQvvdjr3rYmX4
	 AA0evsb6t7xJ09cpfQLvQr7KmLtA27IwgVDAqISwxP1wPr/yTpTUV8AIhzwPdfpA9W
	 XCSFd7SMq6+TVFBbMi7Ym+qEovr9Ke7E6Q3Z1miBv6LE6dyeDIqO6h1hEknSxMDADE
	 bv3baFT1zgTMw==
Date: Wed, 8 May 2024 17:53:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 00/24] Introducing OpenVPN Data Channel
 Offload
Message-ID: <20240508175327.31bf47a3@kernel.org>
In-Reply-To: <239cdb0d-507f-4cf0-87a1-69ca6429d254@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
	<20240507164812.3ac8c7b5@kernel.org>
	<239cdb0d-507f-4cf0-87a1-69ca6429d254@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 May 2024 11:56:45 +0200 Antonio Quartulli wrote:
> I see there is one warning to fix due to a typ0 (eventS_wq vs event_wq), 
> but I also get more warnings like this:
> 
> drivers/net/ovpn/peer.h:119: warning: Function parameter or struct 
> member 'vpn_addrs' not described in 'ovpn_peer'
> 
> However vpn_addrs is an anonymous struct within struct ovpn_peer.
> I have already documented all its members using the form:
> 
> @vpn_addrs.ipv4
> @vpn_addrs.ipv6
> 
> Am I expected to document the vpn_addrs as well?
> Or is this a false positive?

I think we need to trust the script on what's expected. 
The expectations around documenting anonymous structs may have 
changed recently, I remember fixing this in my code, too.

BTW make sure you use -Wall, people started sending trivial
patches to fix those :S Would be best not to add new ones.

