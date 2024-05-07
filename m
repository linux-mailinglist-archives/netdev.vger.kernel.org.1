Return-Path: <netdev+bounces-94104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D285D8BE215
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100621C22CAA
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BB9158A31;
	Tue,  7 May 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YsqoD66p"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E12136E2D;
	Tue,  7 May 2024 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084970; cv=none; b=Bhrgvy8VNDinwhYJTH/Ebck+O9WPKFKTgFCk9pfYfmwUzHy9o6MhQ3tWDQisdfJP6j624N2HHqo0ds8RhY3hi4ZBNwwHhtvYFQLJEQh8kayR6V8JYiPASzW4nh3GZrkvlVUYantc8DuhEjlZOEd0LYK4vk6JGMyVInPrASTgpho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084970; c=relaxed/simple;
	bh=Ih+G/794+A8sluHrmrTfPtWPhvrNrNwwqD6ODTAobkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmREWM4YHeHNp4Tm5r5+0bitmTbfC3OCdASLe03Gaghzo+rRsjgXqOp4Fl1eFKBwtyCR1SrLZ1geSP0k9i3fIKHVIBvcpZOyDa5vdHtLb3LyjXqOzovm0O8pyinBytySoz9NjZAxpkEOe/jgvEi3yxzwORm5rr/ol21NQ7DjR4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YsqoD66p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5V+1nFSAUkiuiW5zI+KiDr7XGM1wYhBwOjZiie4eCy4=; b=YsqoD66pR6k8Uver9MP2Vpm5EA
	Q1gzlHM+IqOrnrZBXnp18aN58tO+r8SsxPBJTIWAAna58kgC0OLj29qbwvP4QNvDwrgXm3VJSS1p6
	ySAN+0ihKOMD/LDg+QvguGfBx7S9TblyZnHzePTTu6NMNMRWcUscLEuQiuMC6Qot6rrQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s4Jwj-00Equp-Oa; Tue, 07 May 2024 14:29:25 +0200
Date: Tue, 7 May 2024 14:29:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: En-Wei WU <en-wei.wu@canonical.com>
Cc: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>,
	Sasha Neftin <sasha.neftin@intel.com>, netdev@vger.kernel.org,
	rickywu0421@gmail.com, linux-kernel@vger.kernel.org,
	edumazet@google.com, intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org, anthony.l.nguyen@intel.com, pabeni@redhat.com,
	davem@davemloft.net,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 1/2] e1000e: let the sleep codes run
 every time
Message-ID: <010c2d24-201e-4aba-b4a1-d973545121a7@lunn.ch>
References: <20240503101824.32717-1-en-wei.wu@canonical.com>
 <7f533913-fba9-4a29-86a5-d3b32ac44632@intel.com>
 <CAMqyJG1Fyt1pZJqEjQN_kqXwfJ+HnqvW1PnAOEEpzoS9f37KBg@mail.gmail.com>
 <d2d9c0a8-6d4f-4aff-84f3-35fc2bff49b7@intel.com>
 <CAMqyJG2S4yvO-UiCiWydO+9uzOWpeKR9tmMDWrw=m6O7pd3m0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMqyJG2S4yvO-UiCiWydO+9uzOWpeKR9tmMDWrw=m6O7pd3m0w@mail.gmail.com>

> > (1) How serious this problem is. It is normal for link establishment to
> > take a few seconds from plugging the cable (due to PHY
> > auto-negotiation), and I can accept some link instability during that time.
> Actually, the problem is not critical since the link will be up
> permanently after the unstable up-down problem when hot-plugging. And
> it has no functional impact on the system. But this problem can lead
> to a failure in our script (for Canonical Certification), and it's not
> tolerable.

Please could you describe your test. We should be sure you are fixing
the right thing. Maybe the test is broken, not the driver...

    Andrew

