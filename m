Return-Path: <netdev+bounces-124260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EE3968B5A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 17:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB71E1C2160C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 15:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A431A2627;
	Mon,  2 Sep 2024 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vsWcbz3i"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E66C19C553;
	Mon,  2 Sep 2024 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725292597; cv=none; b=P6KBULuGjnK0ZoxIiQ1/odlpN5zt6RbL10MgDlZ9tRfE9yJc0i8VZsHfkqxm8oJiYh4FrWrjWgwVP1Jg5Z2vMAq7S6OM0hOs3NO0WkmPwl4k9/l1v/qdWQzHUOQb8JrDhoFk+9xbb68pxEE2hes01RVyFTO2/EnfFLiRl48Qi9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725292597; c=relaxed/simple;
	bh=48vwBFieGEUKoqzGVlnFt/6I5qveqrDaEKf/YZIdRL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sxul2rtctWSDrT9YaVqZoKpzqIG1nAext565ntPD5MoHcoxTGA92YKknqXtL5Q8KpkdtBvNW7wKewAZAfgaxzfz0J4p4S78Zi6Gwe1mzyfsq6rxbn4Ak3KF6TUV9+aLfgtj807jxmCPR5rTlrra83WYok1eGZSpr9voVWeuUgd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vsWcbz3i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J5pJmC5oLwHSMu91hqqcsiI5vfm4huGAR92EelaWZK0=; b=vsWcbz3iKWfFGxshOXOM6XXisK
	ieBTXGGYG6InMFOW/DhG/0QAqILYnyETRFbqNB78yvjbObN4wEqRRJc9ArAHaUBjdh6KJ9dCxgXJe
	SRJ+VsGMnPJDbkWHulWildhaohS2DMWgbuMR8HUYZ5x4Pj7Kp2+EiPxdqn7zKPoYqeno=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sl9Pl-006K2B-Jq; Mon, 02 Sep 2024 17:56:25 +0200
Date: Mon, 2 Sep 2024 17:56:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wentai Deng <wtdeng24@m.fudan.edu.cn>
Cc: linux <linux@armlinux.org.uk>, davem <davem@davemloft.net>,
	edumazet <edumazet@google.com>, kuba <kuba@kernel.org>,
	pabeni <pabeni@redhat.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5p2c6Zuq55uI?= <21210240012@m.fudan.edu.cn>
Subject: Re: [BUG] Possible Use-After-Free Vulnerability in ether3 Driver Due
 to Race Condition
Message-ID: <5d028583-07b5-4b4a-ba93-d9078084d502@lunn.ch>
References: <tencent_48E7914150CBB05A03CD68C4@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_48E7914150CBB05A03CD68C4@qq.com>

> Request for Review:
> 
> We would appreciate your expert insight to confirm whether this vulnerability indeed poses a risk to the system and if the proposed fix is appropriate.

Please submit an actual patch fixing the issue. We can then decide if
it is the correct fix.

       Andrew

