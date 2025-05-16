Return-Path: <netdev+bounces-190982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33600AB9928
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CD4168E62
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A45A23372C;
	Fri, 16 May 2025 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgJSC7de"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B6F231846;
	Fri, 16 May 2025 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388660; cv=none; b=i+q5mGc5wqWF5AB30KmQKhQ+2fX3hwyJDY9dyjJvE5rAQK8eONvl3Pt6jJJ2H4btEM75fW6eKD/IbN5pxRMomQn8NtYR9R8vQRG/8tLatiBXPG4vSyefXx41QQbMq58T5waCjihJRK9j076n/ekI3NtrEVc5LwoGN+UQ3sFy+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388660; c=relaxed/simple;
	bh=ViLQOvXZ7YdUVRBAco/N6BvNCqjN1vNbQcT7t0hpYQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhCQSTrwsJvgz1KS7grFUjq2ydQMuk/PdCdn0GvL+0MfnD6EpyeNULpKo7kZlH8Ieqp7IIcop5lEfWD8nQVcSF36JGzuReD/76vMzdyJNJ5bvO4cnSELUzMEpmhaNkjf/NtXgR9Snu4bbNhhRrN68/RGcRj/NIhRo/EXFmMXzz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgJSC7de; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02905C4CEEB;
	Fri, 16 May 2025 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747388659;
	bh=ViLQOvXZ7YdUVRBAco/N6BvNCqjN1vNbQcT7t0hpYQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PgJSC7dep6wWZebWv0Eu3olDtkMJKJTsvZefEr1t/r+GzZ59D6Pe/eScKYZcxhBle
	 BSKeosCKLu9SUspwMjSko6M8N1sY6UzPGvxvn0/GZMkXnnbwSt388NjMoMVsWTfsje
	 6EfFMVFewQOu6UAgRZsOSPN+DKb5DZOrlpz18bcKCyB4Z2tgXbE1bpF2g8g1MWyali
	 PGmuxzSELPV1cANbjgTS70AyMIGKh/rGEUGbKTtEtMHjk7z7xLsnThsU9m15XJkY8w
	 1EN0zFJTeQGTsfS5b6vQ6exg1Ukkl9k0i9bnrQQe2SIvyiTXM/ZTFAqiIft0i7VeI0
	 qE8pPtDqGsMKw==
Date: Fri, 16 May 2025 10:44:14 +0100
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
Subject: Re: [PATCH iwl-next v2 2/8] igc: add DCTL prefix to related macros
Message-ID: <20250516094414.GJ1898636@horms.kernel.org>
References: <20250514042945.2685273-1-faizal.abdul.rahim@linux.intel.com>
 <20250514042945.2685273-3-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514042945.2685273-3-faizal.abdul.rahim@linux.intel.com>

On Wed, May 14, 2025 at 12:29:39AM -0400, Faizal Rahim wrote:
> Rename macros to use the DCTL prefix for consistency with existing
> macros that reference the same register. This prepares for an upcoming
> patch that adds new fields to TXDCTL.
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


