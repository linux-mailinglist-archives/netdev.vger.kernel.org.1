Return-Path: <netdev+bounces-199481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDF4AE0762
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EC71BC6BCC
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530DF273812;
	Thu, 19 Jun 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyB0p6+J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A82263892;
	Thu, 19 Jun 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339946; cv=none; b=lr431+RoJWZ071tuRCNY3PkV4D2falFz1ppyJfPdTEj3SEVI4nN+U0Ap0FTDmYqwTkfPMWmjw433PFYLYrta1puxhHG3bN1vOc02cpmYdmD44CxcDtADNYjuLkgWe7Zy8ItYVEdJCvId4FDg3X0qdlw+V1yKNe1blA6YLnjHsVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339946; c=relaxed/simple;
	bh=j9iLegeQo2jV0KzEvzzpbe0VOrBkC6hck/nmSKy8Ptg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC5rj3QQkkduQkHGcUo/VWoh8uRMPW+UmWNKdYcMeJoYVmotos930sOz5Ms8ymN6BwP+pAaM+12Fn7294XlW4kn2ajMS8CdcW4NEykO/2Jgi8wTvHappZjgN/EkffLAbtzxq5oJR1SBbgfJUKoODPrUg3dcJUSmV0ca0JcmgMRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyB0p6+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9043C4CEEA;
	Thu, 19 Jun 2025 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750339945;
	bh=j9iLegeQo2jV0KzEvzzpbe0VOrBkC6hck/nmSKy8Ptg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QyB0p6+JDQrIeeyW5uhvwbTNfV8xk0T5Z5xxG656wpiBrhYrURuUPWozxQvOwD/2F
	 vptJlUVN69OtsxVi65oGdoKQ2NxSfr26VCKqYZ6eDozfnXId2/IlFEdjP+VU2VnUPB
	 XDAVSXbVexRbPTirEM9lkYzI9a+miSrXCnPJvlB0Kpprm5ua1SxcaSYz+5HSiNfosH
	 FgYFdnGuZU0au5yDBd3t4VBp9biNAtbN/Rbtl8MOEGIUhKZrqzcIoDD57mXLXEmWt6
	 M6nnROu2OgqYhWk+pAwi3olOB19/IZ4w1YQgiDiksXu06drMOUltakK3LqswnTq+SG
	 9uPgrbCgUzqVw==
Date: Thu, 19 Jun 2025 14:32:20 +0100
From: Simon Horman <horms@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: Don't use %pK through printk
 or tracepoints
Message-ID: <20250619133220.GQ1699@horms.kernel.org>
References: <20250618-restricted-pointers-net-v3-0-3b7a531e58bb@linutronix.de>
 <20250618-restricted-pointers-net-v3-2-3b7a531e58bb@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250618-restricted-pointers-net-v3-2-3b7a531e58bb@linutronix.de>

On Wed, Jun 18, 2025 at 09:08:07AM +0200, Thomas Weißschuh wrote:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through tracepoints. They can still unintentionally leak raw pointers or
> acquire sleeping locks in atomic contexts.
> 
> Switch to the regular pointer formatting which is safer and
> easier to reason about.
> There are still a few users of %pK left, but these use it through seq_file,
> for which its usage is safe.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


