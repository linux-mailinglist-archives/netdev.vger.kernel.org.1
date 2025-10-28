Return-Path: <netdev+bounces-233620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A72C16692
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 19:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E76C3B020D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D319534EF01;
	Tue, 28 Oct 2025 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpIDEIw+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED8734D4E6
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675137; cv=none; b=th8LHVwjhgfXTtm2PMk9zu8+M+QA7+hU5jSlz6I45f/NaH8KmDzHJWN3N877HeMFpOtKcZlxsRnUGydlJB12O/RFEV9WfYJNU/b31mmlN3GheBYarzUh6wbZ4cSQPI7TVuUj0gAYOKpBhXwd8+xjTYQuDjs2bfcGsLzRzmucHLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675137; c=relaxed/simple;
	bh=xh400PhYtETk32cIznIvZAhI5hxKU8P8vAL++bW9D4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkpaeCiwXlrI1sJPmhfiXJpcxeetLY0uC0N+SUxbkubGsyBux9HkCIF6N62N4OxUd/JIoqqeoxVd/YDrl5FtIKsx1Ma1okCsTjdfivzQbrikSSRbBytgVtPz/OiqPh2CYVEick/ZjD67UbFkKFIwmDTGCmHXEt8dy0aQ/YOpF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpIDEIw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF95EC4CEE7;
	Tue, 28 Oct 2025 18:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761675136;
	bh=xh400PhYtETk32cIznIvZAhI5hxKU8P8vAL++bW9D4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jpIDEIw+U1p/Ixt0SMv5V6hpEqLgs5ExG5QHsMhawSwaRiQYLp0SkVaCZ3PlSXypw
	 TQtydZl09NaBaEuIKUpqN6kJ6zh6S9StfIn0Sqqm+NqZiITxG/bmOEhCz9L1zv8fgn
	 n68iR4BHEcRSxmvTpM1FH6725LSBKkS25kHZW3Z8CX+XZkGIbAtZ0aEN686PNLQKzg
	 H3zbQXfjWN+99WpMDGEqloRhKwRpFyin3D0Ie0/Ws87zId1FCZJ9slwRCe6HQiqm5u
	 4qmN5QDUIxEwq6TXI622yRjdDeW+9ggLmLh5IA8Rj+uJUURH42ZknLkrqjZtXY0pjR
	 Wd3qd8dcUM6pA==
Date: Tue, 28 Oct 2025 18:12:10 +0000
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <enjuk@amazon.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kohei.enju@gmail.com
Subject: Re: [PATCH iwl-next v1 1/3] igc: prepare for RSS key get/set support
Message-ID: <aQEHes7y5QQw_gOt@horms.kernel.org>
References: <20251025150136.47618-1-enjuk@amazon.com>
 <20251025150136.47618-2-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025150136.47618-2-enjuk@amazon.com>

On Sun, Oct 26, 2025 at 12:01:30AM +0900, Kohei Enju wrote:
> Store the RSS key inside struct igc_adapter and introduce the
> igc_write_rss_key() helper function. This allows the driver to program
> the RSSRK registers using a persistent RSS key, instead of using a
> stack-local buffer in igc_setup_mrqc().
> 
> This is a preparation patch for adding RSS key get/set support in
> subsequent changes, and no functional change is intended in this patch.
> 
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>


