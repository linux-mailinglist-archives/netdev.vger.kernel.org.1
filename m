Return-Path: <netdev+bounces-216593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C20B34AC0
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 21:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6698E1B20B6A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 19:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A044263F38;
	Mon, 25 Aug 2025 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aEJtV6oW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564EA1C5496;
	Mon, 25 Aug 2025 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148667; cv=none; b=WSEsDzZR2l9s71msprQ2KAEzBANWOcWBwe0DxykAI9fwGttlE6zruDxDJCV4Aky0VVpo3R73a6se4LnMSC0SRhYkNYk/nMR0nWgWTm7SSgghD6UY0z2BO6VooZOn3S/3vxqjoHmKzp3lyo+LBVNiZ79pNRnHpwN4rjjjukpFWy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148667; c=relaxed/simple;
	bh=pg2kEZOJmfyEZLoFsEqq7fK9iGakwkxlFY6SjyvafiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9SWuJACp0Sb9TC7I3irV4tSX75LDEhk2hSUmfjQcvGFf/h9WdPv0zES7wpZGeCJZdWPN62ZvLuw+5yxgCb/GC3ml9wwPKP1z2Mo5dJB3CKNbt8KPsNTOtvNNpDIk3/xhWbMhf8X/ez18oIXYXwKd24h9WInNAAZX5Mta7OA2lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aEJtV6oW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Yj7mYbacDh/jp6YE/Yi4mwXI3oHxz0o90Np+ZyD7dls=; b=aEJtV6oWoqLHqk9Zva8t76Zf/F
	Sbi6t0qnDSbt+qZt86DohnRr+BEZLqvraCzxMu6vFvH/HrZ89nEqvJ8vB0gTt/qpuRbXEMHzGCxUD
	Gd6dJUK33o8B0QMpOxOoh8LsZw4BlaClhMWE2sa3NqvJKO1Csk1OHT39z1BaYkq+GvD0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqcUG-005yrx-0Y; Mon, 25 Aug 2025 21:04:12 +0200
Date: Mon, 25 Aug 2025 21:04:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alex Tran <alex.t.tran@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] Fixes: xircom auto-negoation timer
Message-ID: <7dd4c448-df2a-4fee-90d6-cc3606a5c3dc@lunn.ch>
References: <20250825012821.492355-1-alex.t.tran@gmail.com>
 <c6c354ec-e4fe-4b80-b2e5-9f6c8350b504@gmail.com>
 <6214363b-0242-481d-9b93-2db9e1ba5913@lunn.ch>
 <CA+hkOd72gg-8VVfdpNpATbunJt-Oc7Dujor9crQP7sFiDj_L8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+hkOd72gg-8VVfdpNpATbunJt-Oc7Dujor9crQP7sFiDj_L8w@mail.gmail.com>

On Mon, Aug 25, 2025 at 10:40:45AM -0700, Alex Tran wrote:
> > > You state this is a fix. Which problem does it fix?
> The change was originally suggested under a FIXME comment but it seems
> like more of a cleanup.
> 
> > > Do you have this hardware for testing your patches?
> I do not have the physical hardware. The change was made based on code
> analysis and successful kselftests and kernel compilation on all yes
> config.

Sorry, without the hardware: NACK.

For old hardware like this, please only work on them if you have the
hardware. Otherwise, you are likely to break it. There is no gain for
work like this, and in effect you just waste reviewer time.

    Andrew

---
pw-bot: cr
	

