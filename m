Return-Path: <netdev+bounces-197830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03493AD9FA5
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 22:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63E23B4C77
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBC02E62DA;
	Sat, 14 Jun 2025 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NL/8QLgu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182FB8615A
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749931820; cv=none; b=UOfXeJaGmaBUvoZEGZq2dSOtwrlHLkjCG0dRXEi/Gbul5Ejg3OVEE2LyDMndXNilQXbTsmuqrED+GUjEFH7B9FnmlJ+Wu+RAC8F2uh4owgUCqq0B3UQm/WSHetpdPQCEacnF9rcnZJT2lNYp+r/3lWvH2w0WH9x/fs86LaPTJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749931820; c=relaxed/simple;
	bh=fqtSjiPKYZf9FAR+/Aac/hlzXqK+ezbesxU2kquqDR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O575t8GQAjj8WY9f8We+tXWh0Jq/G4Rat6N60R2pUJsEg1h5lyelLSBGFki9SOYKTPzIQ6eEDXoajVluWpzRns6xOMycGEpEJbOybbPYC6NFfxQ+lgoYvyPGIS9FbQjshuxdRPAJzzfX5JGMbPfaq0EC/HwVTP2yzrqEX8XX+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL/8QLgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346FEC4CEEF;
	Sat, 14 Jun 2025 20:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749931819;
	bh=fqtSjiPKYZf9FAR+/Aac/hlzXqK+ezbesxU2kquqDR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NL/8QLguQ62XQZx2W1qyi4DuvSXilS4C3qATqOYqG0hJIScIRIyF6jwM2sY2ejZ8H
	 sZBpAHoz4O42DFSJB2+pYr0/of7NmfgZLWltDlN+WyIrWuVWlr4Wp3WZ/L/q1rJjpU
	 ZaFWt1LqVxf5sBsXBxV+97PbE3dHqadqcbLSnZJtgPVTkuvBrwPABLfXpgSSC8Me8g
	 ufz3twaGdnoJ18xbZ8WtVrGa5+vktQbGUVLeT+E+HCXrtj6q1G4R6StP2+BYAgcQNQ
	 FwOkzS6YlOv0sdMeS6hGAPKm9FO4JewQxD9mTXAbXpBS/G7e46/AtoEIxWicuODXOA
	 0nnts/OgrkaRw==
Date: Sat, 14 Jun 2025 13:10:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David S . Miller " <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, jdamato@fastly.com,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7] Add support to set napi threaded for
 individual napi
Message-ID: <20250614131018.6d760d19@kernel.org>
In-Reply-To: <20250613191646.3693841-1-skhawaja@google.com>
References: <20250613191646.3693841-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 19:16:46 +0000 Samiullah Khawaja wrote:
> +/**
> + * napi_get_threaded - get the napi threaded state
> + * @n: napi struct to get the threaded state from
> + *
> + * Return: the per-NAPI threaded state.
> + */
> +static inline bool napi_get_threaded(struct napi_struct *n)
> +{
> +	return test_bit(NAPI_STATE_THREADED, &n->state);
> +}
> +
> +/**
> + * napi_set_threaded - set napi threaded state
> + * @n: napi struct to set the threaded state on
> + * @threaded: whether this napi does threaded polling
> + *
> + * Return 0 on success and negative errno on failure.
> + */
> +int napi_set_threaded(struct napi_struct *n, bool threaded);

nit: missing : after Return

but really, I don't think we need kdoc for functions this obvious and
trivial.
-- 
pw-bot: cr

