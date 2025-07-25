Return-Path: <netdev+bounces-210154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9528CB1230E
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 19:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0085A1E40
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 17:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751CB2EF9CB;
	Fri, 25 Jul 2025 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfY+kAbz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2BE240604;
	Fri, 25 Jul 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465140; cv=none; b=ITedFHkrGXFD+QjmwnolaQeVOsIoMYXbbhn6ITIrGzJk9O/rlGsp4kVhwAro/LMWTEEGnvWfz/11tvdp/Dl+0KpDqp6pHBwkmQ6qmKQCV+0CjyAf3H6Kqi9ksHTcbKdsoHghGupgNGSjHJSntkcAPERQI4CupGOEEtR4c88U/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465140; c=relaxed/simple;
	bh=iqEyJ4g+V4jbO41dl3FcQ6q+NsMBCzGc4JG61zEscwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R43cQmkZIfl+lxqcmW1n3SUcxHauuEEW9l0TQSrEOiyPeHG3Wd20B2Z7wH6xq97x8KFrtbItkro8VTOfNxODy4HqH7fHt33nBF1n/mtTcCgtr4l9r6u1CbxraRqZjwRp6Fgh6OQa7HKqesO4rnaAxRUtOhme27X6CL5MCmMDPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfY+kAbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A036C4CEE7;
	Fri, 25 Jul 2025 17:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753465139;
	bh=iqEyJ4g+V4jbO41dl3FcQ6q+NsMBCzGc4JG61zEscwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gfY+kAbzSssFFucERHOGlUIIfiORcImOfanOyNM0DSXC899mJKy58a3HBDjyKlO5D
	 xFQTGhbgaq54Qc8CNihJsZs2W3tXg48YvvMXPWvPqJduio3dPEXS+kCR89aIBu3S+4
	 CtDUw7R98VM8b2AjbotHLkXs0BfT+VOj1lKzFH74yvagxvR7YnwS/s/tMAtT/jJKpF
	 HxZA50a0FaN3eiPOmRhc0OuKwLDVbfhlLb014bXmRS4jFt9QUlCSjlxq0VskuHzYfw
	 eSnEllhLQGMg2WFs+YoYrcH9QvlHixWnVvcf0bCa8BfwyisoiE3h3UqRSgTzUs/ZPm
	 pKX1dx0InsfpQ==
Date: Fri, 25 Jul 2025 10:38:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?="
 <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen
 <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, Christian
 Brauner <brauner@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Li Li
 <dualli@google.com>, Tiffany Yang <ynaffit@google.com>, John Stultz
 <jstultz@google.com>, Shai Barack <shayba@google.com>, "=?UTF-8?B?VGhp?=
 =?UTF-8?B?w6liYXVk?= Weksteen" <tweek@google.com>, kernel-team@android.com,
 "open list:ANDROID DRIVERS" <linux-kernel@vger.kernel.org>, "open
 list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH v18 3/5] binder: introduce transaction reports via
 netlink
Message-ID: <20250725103858.109f1c5d@kernel.org>
In-Reply-To: <20250724185922.486207-4-cmllamas@google.com>
References: <20250724185922.486207-1-cmllamas@google.com>
	<20250724185922.486207-4-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 18:58:57 +0000 Carlos Llamas wrote:
> +++ b/Documentation/netlink/specs/binder.yaml

We started running YAML specs thru yamllint since the previous posting
(the fixes for existing specs will reach Linus in the upcoming merge
window, IIRC). Could you double check this file for linter issues?
We use the default linting paramters, no extra config needed.

