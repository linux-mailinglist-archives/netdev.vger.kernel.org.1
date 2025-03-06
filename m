Return-Path: <netdev+bounces-172573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9D2A556F2
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DFA1884671
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F6E26BDB3;
	Thu,  6 Mar 2025 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quw3/QJW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3BB6F31E
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289957; cv=none; b=aNnGfqDFIfIiCwfgeCGREzmrNiZ1TnVlKOYxua21IEEWlgvab1ocKjJvP7saJrBVq3++OwrnkpjUPyUGlroGuof9FaqAufe6psGX4xASRFnw1rYTy7gCs0ffI1E1kYSYgx38a8rwCQHbKhXU46eYj6v4stzLkdQlCDBwrVXgwy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289957; c=relaxed/simple;
	bh=XLeyAtcQmGuZQtOWfz3BoS1IUEjoRUCRk9IBsqcWV7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLl0ggKj84SRe9eY/nyAFvby+47htPMLREYG0dpJwSrUa1fyoepxFmNJ704Hbx5H/dRw1mrwkfEUkoRR72y4X22IOlQLymjo2ARfZRuUngq9fiVGh8CBw8HwZgfwgavdAr6sg9fmQI61Ge5NZq+E6LDz8hqTE9gLYjrT+EviEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quw3/QJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14953C4CEE0;
	Thu,  6 Mar 2025 19:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741289955;
	bh=XLeyAtcQmGuZQtOWfz3BoS1IUEjoRUCRk9IBsqcWV7s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=quw3/QJWN2XY1pHLIOD3yo+pOPIxmSHwEg0emvu8Flu3fo2ZTqo7opKaJno6uaDgP
	 V51vM4HPDW/f1WVAReAQAyzyiNdt1V/UeWqyjpvZEJ4YJc0lxiwb0ek/4+tpMihgaY
	 QiZo5xGvEPMLYyVFSN39N2Uv0NfBDK0zrX2c4J7xav9duD/APu+O+HHmWd+WtX4Xop
	 TorCaKpq6nlLBm96Rr6CZ8KWF0WOwjE7RYH9jKOIgiZ9vVQppjIofdRPPASn3WEecS
	 ovqcL9l2jZevkgQN/rxoCkgpUPgxLgKEhSxE8HBVbmVBFu1YEE7aihNeqP+uZEceYx
	 FqeraRH/WyT/Q==
Date: Thu, 6 Mar 2025 11:39:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
Message-ID: <20250306113914.036e75ea@kernel.org>
In-Reply-To: <7bb21136-83e8-4eff-b8f7-dc4af70c2199@gmail.com>
References: <20250303133200.1505-1-jiri@resnulli.us>
	<53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
	<20250305183016.413bda40@kernel.org>
	<7bb21136-83e8-4eff-b8f7-dc4af70c2199@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 21:20:58 +0200 Tariq Toukan wrote:
> On 06/03/2025 4:30, Jakub Kicinski wrote:
> > On Wed, 5 Mar 2025 20:55:15 +0200 Tariq Toukan wrote:  
> >> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>  
> > 
> > Too late, take it via your tree, please.
> > You need to respond within 24h or take the patches.  
> 
> Never heard of a 24h rule. Not clear to me what rule you're talking 
> about, what's the rationale behind it, and where it's coming from.
> 
> It's pretty obvious for everyone that responding within 24h cannot be 
> committed, and is not always achievable.
> 
> Moreover, this contradicts with maintainer-netdev.rst, which explicitly 
> aligns the expected review timeline to be 48h for triage, also to give 
> the opportunity for more reviewers to share their thoughts.

Quoting documentation:

  Responsibilities
  ================
  
  The amount of maintenance work is usually proportional to the size
  and popularity of the code base. Small features and drivers should
  require relatively small amount of care and feeding. Nonetheless
  when the work does arrive (in form of patches which need review,
  user bug reports etc.) it has to be acted upon promptly.
  Even when a particular driver only sees one patch a month, or a quarter,
  a subsystem could well have a hundred such drivers. Subsystem
  maintainers cannot afford to wait a long time to hear from reviewers.
  
  The exact expectations on the response time will vary by subsystem.
  The patch review SLA the subsystem had set for itself can sometimes
  be found in the subsystem documentation. Failing that as a rule of thumb
  reviewers should try to respond quicker than what is the usual patch
  review delay of the subsystem maintainer. The resulting expectations
  may range from two working days for fast-paced subsystems (e.g. networking)
  to as long as a few weeks in slower moving parts of the kernel.
  
See: https://www.kernel.org/doc/html/next/maintainer/feature-and-driver-maintainers.html#responsibilities

