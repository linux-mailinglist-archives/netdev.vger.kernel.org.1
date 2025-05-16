Return-Path: <netdev+bounces-190983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C429EAB992A
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BEA51BC69A1
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE1023182C;
	Fri, 16 May 2025 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntTk9J6I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C468C230D0E;
	Fri, 16 May 2025 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388676; cv=none; b=oHC/1rAkgQJmjJDRR4S5E6kEoe9wMcDzL0XuhTzg/l82hw5olTiRjBaqtfgLkSi6ixSDgRWQWpduJRsyTcnY3rxH5nyvRRw6QLdYfXxQglfLfNAdoMWFfWSfSnm8Lgh9Biik0tL7nmFGYc/ppj2lwd/SPH0b/jtSf9uru4DYLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388676; c=relaxed/simple;
	bh=3JKVCHuwfCH0ovS0CE1nP1MwRo0qB1iO+++BwqsWJfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/G0zdA7PaW+cuxlSntunOA9VU00dLlg8uvGDkbsQ3AWoRweNEGVQ79xEDlGmQIRNepmRIjRdNnzyWOGVijyGtSJ7sEaSw1e2cCEjv5xeJE7fwTE0wKZgbYCtFw70+QHdF84qv/HxsxjAi0nY3XGk5H0CjboOixdQFWaRYPwTsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntTk9J6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92966C4CEE4;
	Fri, 16 May 2025 09:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747388676;
	bh=3JKVCHuwfCH0ovS0CE1nP1MwRo0qB1iO+++BwqsWJfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ntTk9J6IQzajFR0GB8wRqAt+dyAMqoDGaVGO8XAZGTgOyI51WjqcDpn5H4eWk013Y
	 WDoqp1hZbjt10rJ+MXjdGycIOGS9eeIaPG+mJteAcWR7ucX+2JlFAqbtAEwERPER4q
	 yfIjyokm20ATf0zF8gycdC6lQQbC6TzCEYMSqeEk82Tq36BsBQ38NV7v/qW7RJ0LQJ
	 drKMgk6nG4frqj9TTaKBTJ4Q6qyLiTHeYyACRhilIOzTI8W9QPW7/ogcsVO3/YZ602
	 0HZDWkyy3ihVy1v4FZOywJ5JHWHdt5lv7oJTnwSh3Dch9zwEf0hAaS/JSXqkmLpDa8
	 DYWNDpt/CWEpA==
Date: Fri, 16 May 2025 10:44:31 +0100
From: Simon Horman <horms@kernel.org>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: Re: [PATCH iwl-next v2 3/8] igc: refactor TXDCTL macros to use
 FIELD_PREP and GEN_MASK
Message-ID: <20250516094431.GK1898636@horms.kernel.org>
References: <20250514042945.2685273-1-faizal.abdul.rahim@linux.intel.com>
 <20250514042945.2685273-4-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514042945.2685273-4-faizal.abdul.rahim@linux.intel.com>

On Wed, May 14, 2025 at 12:29:40AM -0400, Faizal Rahim wrote:
> Refactor TXDCTL macro handling to use FIELD_PREP and GENMASK macros.
> This prepares the code for adding a new TXDCTL priority field in an
> upcoming patch.
> 
> Verified that the macro values remain unchanged before and after
> refactoring.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


