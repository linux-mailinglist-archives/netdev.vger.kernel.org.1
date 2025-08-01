Return-Path: <netdev+bounces-211326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C360BB18011
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 12:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A69B1C80471
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 10:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A75522D786;
	Fri,  1 Aug 2025 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9acK11L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333A52CAB;
	Fri,  1 Aug 2025 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043664; cv=none; b=bZ0nmSZqoPkiWQjWQhaqwVZzisDxmoPjG/N/5sWtDFu9ltbAsDY3EkxziSJmqBHsuEHPA3GOnnLuJBp1z+vGTJgEizz5qhEzmUALW9yWDWoi+/l5LSZPdezIXsUZ0fAqWPbNOP38X4beqFfgkKWNZQpJAwtkbdvWL5JuFV+92Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043664; c=relaxed/simple;
	bh=SsPMthVZouyLNTNWtFvs42zrGkstYTZpQCaiNSYZVj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3NlJjsB1jTPubJRLkkhIetnqeCvg+uqqgxLeo1oKQ0a3iJmFcG5cfP+nyqLo0aRf6t+0A9yECidsG6eZXqmq89/bQowzUsHahxI4OnTHFx1ePxtlvplE0OV0GWDbDtN98B4EhaRQEcAiieaQgLDuVuzZWLKQ6iEzLNqonK8cKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9acK11L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBFAC4CEE7;
	Fri,  1 Aug 2025 10:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754043663;
	bh=SsPMthVZouyLNTNWtFvs42zrGkstYTZpQCaiNSYZVj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9acK11LamXRTeTuBGMXg81ib3S1uLOhdSVwmTZrBiDRAidGdPDaETyJFXU1i8R08
	 qdG7oGgWywFTEfZwkniiktjcUinepPfMpAODktgZgkI4ihwEHh/yT9yyzLa/xzFvSJ
	 ubZHijkjNrAYXrEvbUo8WgFh1EsYTLwLA2n8I7ZoAZyLI9Z7DEbnean8dHRltQC0O5
	 d8ahK9tYYGDC9Q8qYUEryZ8kSGh7dDFq2wvAZfl2PZ/IGlcyvynW6A6a1y+u2yPz+2
	 +mzaigGC/07DV0eKj+F08KfI3E466l87qBmGQ4HcJXtN8mxmWkTCjCLm49au1Wb3BE
	 QaNamxZGY+v4w==
Date: Fri, 1 Aug 2025 11:20:58 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: hibmcge: fix the np_link_fai error
 reporting issue
Message-ID: <20250801102058.GL8494@horms.kernel.org>
References: <20250731134749.4090041-1-shaojijie@huawei.com>
 <20250731134749.4090041-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731134749.4090041-4-shaojijie@huawei.com>

On Thu, Jul 31, 2025 at 09:47:49PM +0800, Jijie Shao wrote:
> Currently, after modifying device port mode, the np_link_ok state
> is immediately checked. At this point, the device may not yet ready,
> leading to the querying of an intermediate state.
> 
> This patch will poll to check if np_link is ok after
> modifying device port mode, and only report np_link_fail upon timeout.
> 
> Fixes: e0306637e85d ("net: hibmcge: Add support for mac link exception handling feature")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

