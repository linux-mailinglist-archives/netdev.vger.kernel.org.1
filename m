Return-Path: <netdev+bounces-131087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD9998C875
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 00:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72ED2286171
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819B51CEEA7;
	Tue,  1 Oct 2024 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q2b4tLjX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FA71BDABD;
	Tue,  1 Oct 2024 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823372; cv=none; b=tIEDr8N5fbe1U7BLf3yR7nq8mihlc6SAiprmjb7+4/sWyBKe3yeu7cwTqt+mJH/9jrvtbTLqOXuu3CLO9JCNhsiGHYGGFsyIMSQA/wjfB7EEPzLIYAyUJ+zEZPLYzoU79CNxnuaaquxzgkRLT9S0Ug7FYa6Q6zhUhuFXP/2oJL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823372; c=relaxed/simple;
	bh=eTF7zrfREL1a4RvlKpkEP6yiI8+3aVYv88/9Gaul87I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYarDkq5LaeSHCe/5WUIHQX4IBVZox0qLH/kMNe4ulkPvhSjf5mM5jh5T6JHx5HiSEGLH26IuO4wrFTdSW1FKxctDmhU944YgqkMSvOIcdchbgg2vZ6hnxIzfrjqMl7mwGp8xyAmAC1QCjXK1oUDVg/COxcEC1os8bleY8vVgiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q2b4tLjX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hWBU2Eg+tFjoVyOuxmqCvEXo14EoTrxkd+OkDmGaY0k=; b=Q2b4tLjXAnFjO3sQeyJfNaxEJ8
	zIQx9Yc/BvazNDCx4zJRZr5WbUAi42o61Ps5M5CtLuGl6usQGzMw2DjSG+m656rKR7YLsi7w+a5fd
	H5DMt+DY0tbW3SY33AtOk//ku9XOwvPy64l2K8+UjAX6X0k+TC651G+pblIUphMjWDm8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svlmk-008mfV-C5; Wed, 02 Oct 2024 00:56:02 +0200
Date: Wed, 2 Oct 2024 00:56:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	olek2@wp.pl, shannon.nelson@amd.com
Subject: Re: [PATCHv2 net-next 05/10] net: lantiq_etop: move phy_disconnect
 to stop
Message-ID: <6ebf08e6-07fd-4aa2-a02d-e56190a58285@lunn.ch>
References: <20241001184607.193461-1-rosenp@gmail.com>
 <20241001184607.193461-6-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001184607.193461-6-rosenp@gmail.com>

On Tue, Oct 01, 2024 at 11:46:02AM -0700, Rosen Penev wrote:
> phy is initialized in start, not in probe. Move to stop instead of
> remove to disconnect it earlier.

This commit message does not make any sense.


    Andrew

---
pw-bot: cr


