Return-Path: <netdev+bounces-104614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA16790D915
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20C81C243BA
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF1355E48;
	Tue, 18 Jun 2024 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA2BpBmg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C202557F;
	Tue, 18 Jun 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727815; cv=none; b=FbdGDM2WgVw6nvFA+9Mqlt/JOIgDcCSzWlgcCIzvZQYKjbuUQRz28W3CKKS0nCgsaMNfg5F1gu0J6iH9DlVQfPho85xxRoBQ9KsZVeEVtrwDLgmgJ0J5BdLkWrwE25E1Cd65uKZRsw22awSKFU0IQrOKVwhWvBwzYdPVV+Ee5u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727815; c=relaxed/simple;
	bh=yg7v45n6czUz39F0WzBodOLAibjTr4LlhQJMh1XKmdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciUjRcva1bRXinKUy3uIShGdo3fp11nx0HNtLt+IivN18Q7XCofy2Q3ZqPmXwyYNw7illcBQg/Q7irLM5njkXCClyd2ymXTUBf1s8bFi2YuGo0s44PJOHHqo83bUla8MaHhRUhwTYBWje501SHlcJ+otToXkV3k5vWL5TsttcA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA2BpBmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDB9C4AF49;
	Tue, 18 Jun 2024 16:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718727814;
	bh=yg7v45n6czUz39F0WzBodOLAibjTr4LlhQJMh1XKmdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OA2BpBmg8fYs1dqvivNYiFMwzt8jtPC3Jbe2Rt33CSK30iML/jz98rW8svw0Zyswk
	 VF5+WLc6GzfsVg7dV+QrTS0ciWjMSUJSdqpGitpSJgrtQu+1B5ZqkhWbjohUttID1l
	 tgWqEYKYD7vQb0QnrN8cujJGxcWIMPxEAxaXAJtu/Db9/ZxRCWLjSQxa9aODGzgxqH
	 Nk0rUUKOrc/uCq3f+rIEFY3rknPX0TAg4LRIsoET3h7AlUuMR8/+4phgIcdzZO/mfA
	 pmP3jJF7Xu13k+IYmYXBlGa44jbOMJfcpn3ioRvy5isN8L6WTwIm/qtafKwSDRU4B0
	 ItZoDOVRAW5nQ==
Date: Tue, 18 Jun 2024 17:23:28 +0100
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
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH net-next v4 4/5] net: ti: icss-iep: Enable compare events
Message-ID: <20240618162328.GR8447@kernel.org>
References: <20240617-iep-v4-0-fa20ff4141a3@siemens.com>
 <20240617-iep-v4-4-fa20ff4141a3@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-iep-v4-4-fa20ff4141a3@siemens.com>

On Mon, Jun 17, 2024 at 04:21:43PM +0100, Diogo Ivo wrote:
> The IEP module supports compare events, in which a value is written to a
> hardware register and when the IEP counter reaches the written value an
> interrupt is generated. Add handling for this interrupt in order to
> support PPS events.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>

Reviewed-by: Simon Horman <horms@kernel.org>


