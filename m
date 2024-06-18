Return-Path: <netdev+bounces-104613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1066F90D912
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6B71F244F9
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA33D4D8B8;
	Tue, 18 Jun 2024 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgPX7GKs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C01E2557F;
	Tue, 18 Jun 2024 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727797; cv=none; b=IkovsvHKHJoUzaX/ljd+nYNz+BEySDHtDMgIUPEACI9FHjITOylpJPLnnmIfxnc/FnBW1ANaOEoUBJW6yfcKdf1jyq96Nb/bPb1wwfOqjPwZneWG/kJAZZtE8QYvwJDQfRodUAWRv4yXshZNwZB+Xoe43Qr9qDDOd+1ilXQODMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727797; c=relaxed/simple;
	bh=4xETAguTn+AhD+YeE7iJ7UW0UbMl2zwS/d0OxL+4pSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTVL/g9CloKvzTLcit8/SBLkWRSPw5VXPEf/7QX4vDgC/dTMRqJUMyFohdB6DpKIbUqDDDNQVmhzeno3YgYy0HB7EKhX23AMVPYJHS1kBRIJsE3MLHN8pR/TTQx0CoGYcgWIEqddce1yIRID8Sde8I3jct/HdcuK7GtyytihsmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgPX7GKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A8EC3277B;
	Tue, 18 Jun 2024 16:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718727797;
	bh=4xETAguTn+AhD+YeE7iJ7UW0UbMl2zwS/d0OxL+4pSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PgPX7GKsa8w8hZE5U8OLAgIni2NVbvGwbnboSZaR5fH+1/o9rh6sZqXM4aj7l+fXK
	 LlbPg/mhMeHxkgw+A7ZCkjF3snjevGaOtUAIhgkG69R2M1wSDi0D5RKzXFUJ8EqEQA
	 2PHZH1eIz8VgboB5gnLVZLz9H6CELaIaZWtGZoeIh/tuZi5NmcK1Kd6cVpNxgiKX3C
	 D2pZPY08Ovmtsys996+GmF5b2R1oW3uV5cBp47MyeXlHmcVK/0bXhX2GHfl7j5Hnku
	 tDob/oh8TaQ/RFU/Q2gCEFAJYupBQ1dkfeTZTZRhIbXPtCBtHs+1wwLaLMaaL7KSCl
	 h1aGqmyR6w04A==
Date: Tue, 18 Jun 2024 17:23:11 +0100
From: Simon Horman <horms@kernel.org>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/5] net: ti: icss-iep: Remove spinlock-based
 synchronization
Message-ID: <20240618162311.GQ8447@kernel.org>
References: <20240617-iep-v4-0-fa20ff4141a3@siemens.com>
 <20240617-iep-v4-2-fa20ff4141a3@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-iep-v4-2-fa20ff4141a3@siemens.com>

On Mon, Jun 17, 2024 at 04:21:41PM +0100, Diogo Ivo wrote:
> As all sources of concurrency in hardware register access occur in
> non-interrupt context eliminate spinlock-based synchronization and
> rely on the mutex-based synchronization that is already present.
> 
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>

Reviewed-by: Simon Horman <horms@kernel.org>


