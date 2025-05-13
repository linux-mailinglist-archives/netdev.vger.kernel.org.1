Return-Path: <netdev+bounces-190166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BC3AB5668
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21703A43FC
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1096F2BCF53;
	Tue, 13 May 2025 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZM+fNJb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A22BCF4C;
	Tue, 13 May 2025 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747143962; cv=none; b=hDM7Plfk4msZ2Uoe4Wl+zmyHzATpCLU/O2RiMHDlqRnpLHKHCHZXywVewJer7cWhKwyRqtDopN336A+fzFD3HgJ3BtB88OOV/6pwoX6i7hRBRkktEnrLaPQzbRy953OTnGZ6OG6+9BNS5LfnCQ7DtBuTPWr4EGlosJTzTyESmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747143962; c=relaxed/simple;
	bh=6SVbNL7MdDeVWzGiL7ToqMT+a2F0ihmK/J1QAWCPEHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRvPEXk/kJkQvAcTP3i1jaFyWCPgpEHrTzpiUi9K/CaBi04wToxtWXmPOP6NCOVKwZNeoaKIqbj92yuyYO/h7pvmHkNuXRua58l9PTqArE3x8KFoALdbz8Ak1MG9qbeZYQvofHTU5OU/F/GSEMKaQGgGcT4Yjv1LlZatRb0d6IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZM+fNJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087B2C4CEE4;
	Tue, 13 May 2025 13:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747143961;
	bh=6SVbNL7MdDeVWzGiL7ToqMT+a2F0ihmK/J1QAWCPEHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZM+fNJbbVDxXp167WpBkgTSLgw6AJ95ty168aKV6LQ5Y4oOJp8K2lzuHXnruPQar
	 EVMGiRyiYadaIwf9JSdRXb5uWBY0Ao2EXgTls8Jl+gvzOmJaqt0HTD+ZShpPqFC6YX
	 uqQpsTJbk/yf7IrnsFZPFZ/iDVgYi84CaBpYmmXuQsbZz4nEcbYqV3J03JTu+JJggr
	 TQXULTs9SRLlQ0NnUDWTpyAaftNQiMsZrYcFfYEX2cFC9QOBodNtgpReHJn8bCwCRu
	 USfbH+pwoVKugzRPUPuWS49JNIO3kcnxS++IBBy5swgyl1dvqpGEMavXgvN3Xw82F2
	 D0jbPAjq5JI9g==
Date: Tue, 13 May 2025 14:45:55 +0100
From: Simon Horman <horms@kernel.org>
To: Lee Trager <lee@trager.us>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Su Hui <suhui@nfschina.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 5/5] eth: fbnic: Add devlink dev flash support
Message-ID: <20250513134555.GC3339421@horms.kernel.org>
References: <20250512190109.2475614-1-lee@trager.us>
 <20250512190109.2475614-6-lee@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512190109.2475614-6-lee@trager.us>

On Mon, May 12, 2025 at 11:54:01AM -0700, Lee Trager wrote:
> Add support to update the CMRT and control firmware as well as the UEFI
> driver on fbnic using devlink dev flash.
> 
> Make sure the shutdown / quiescence paths like suspend take the devlink
> lock to prevent them from interrupting the FW flashing process.
> 
> Signed-off-by: Lee Trager <lee@trager.us>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> V5:
> * Make sure fbnic_pldm_match_record() always returns a bool

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


