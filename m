Return-Path: <netdev+bounces-201238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5477AE892B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9758C3A4C2D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BD926C3A5;
	Wed, 25 Jun 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+UwMPC9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0526A1CF;
	Wed, 25 Jun 2025 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867593; cv=none; b=Iq+OZPcPth5yF8vsP8GofNUS1TemnLBaO5MzhN9GBnC6bS75921YEo79j+jrdGI2HFd3DPuYH/3vtc9h4SW/bgqVMTCx1QQmM++B+Vnogj+d041/M7NxRkGHrj7rSZNMbCCKqHUtvNGs/euFdqTYaWku07xucY2RiSnCq6rcL9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867593; c=relaxed/simple;
	bh=nEh9ZQj7gvQZNLdKXBerfNLAR4+I/RC+H/9nOzacmEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6mHpjYFI9/Z0oWo3b5XugQG48rHKmlMWZyTUY1hI6MLobCEoHkMPRRzQhzlq8bh3zkSbR+2O+TjuGNUCNd3y7VSvBboeMAHdhTF4aAiYnT5zVGSnlJRTN6jDt6ym9mx3BVgHfkoKAvIq0bebCjLjPobV0stR7YlJZO6MkJYExc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+UwMPC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7508FC4CEEA;
	Wed, 25 Jun 2025 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750867593;
	bh=nEh9ZQj7gvQZNLdKXBerfNLAR4+I/RC+H/9nOzacmEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o+UwMPC9gPmsN9wptCprHFVPboJGKi4p+8W5qrEpd69Eam/j74DOlg2JEW77B+8cM
	 JyCQtfTthjwXpEdbEQjkzRImn4EIwzcUW+r0B9hm8lzo2H0uT71pGLsRONUO4IojAT
	 77KTr2YK7a7LQ5sIw+eho8zxbOXJz/zCcVgYZOWqltQDYQPSQOEDF7Uc3ypMwdBIo4
	 tD2WqN7vMxG1rWpLku81Jd3g5yjosB5LZutJgu/y6CqnI5mC4fVzrKNWP2kf373cwZ
	 L07S2s88cafvtaKnqoaVU1gK32Lqrrj5cMcIou9ar2wdOe6YiAnxgRclBfJ9DOv5X9
	 KQ6UqXB1N8yfA==
Date: Wed, 25 Jun 2025 11:06:32 -0500
From: Seth Forshee <sforshee@kernel.org>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Tonghao Zhang <tonghao@bamaicloud.com>, carlos.bilbao@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bilbao@vt.edu
Subject: Re: [PATCH] bonding: Improve the accuracy of LACPDU transmissions
Message-ID: <aFweiFJHj-3c3Zv9@do-x1carbon>
References: <20250618195309.368645-1-carlos.bilbao@kernel.org>
 <341249BC-4A2E-4C90-A960-BB07FAA9C092@bamaicloud.com>
 <2487616.1750799732@famine>
 <aFsq8QSZRNAE8PYs@do-x1carbon>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFsq8QSZRNAE8PYs@do-x1carbon>

On Tue, Jun 24, 2025 at 05:47:13PM -0500, Seth Forshee wrote:
> As I understand it the intention is to ensure that LACPDU tx is spaced
> out by at least ~300ms, not to align them to an arbitrary ~300ms
> boundary. If so, a simple improvement would be to reset the counter only
> when an LACPDU is sent, then allow sending a LACPDU any time after it
> reaches zero. Though I still think it makes sense to make the state
> machines time-based rather than counter-based to ensure they aren't
> sensitive to delays in running the delayed work.

Sent a patch which only changes when the counter is reset:

https://lore.kernel.org/all/20250625-fix-lacpdu-jitter-v1-1-4d0ee627e1ba@kernel.org/

On an unloaded system the timing of LACPDUs is consistent within ~10ms
after this change.

