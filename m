Return-Path: <netdev+bounces-116134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B57949338
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225D32825F5
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C980517AE11;
	Tue,  6 Aug 2024 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzGxo2v3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E4D18D656
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955050; cv=none; b=cJh4jbFcD67rYFC16HIgU3oqxyeE5ZnpJDylRejfUP2OoxyrzatYpRXqyYLU8QPFYQOQB1gE51oC01G2A96jZTf65bRuq2Rme/zicYWZkKgWaI5skBCCXwkEVDERAJ91Nq+2qtserDgBNHVe3lbvlcik3CEhkJ5dev2SBst6Yqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955050; c=relaxed/simple;
	bh=ZrzteCppFpEXiiimoJAMY9fXnO66iADx0uvLaA6Wds4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7tP9ELSt5DABFRw927l/zWcilogCeIynp5iAocJQ6x3+FLNKrU3tnLvyxC4PlP5h3wKlCiCcF93TdOEsZzYyu6Hx/2h83maQ000gAwNuKaRbHJwoHNYWC2M37haQjHaz0lJxIL0spbtOCVwSBDj/5e4GxCKuTTEPZ/v9JuZmrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzGxo2v3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521FDC32786;
	Tue,  6 Aug 2024 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722955050;
	bh=ZrzteCppFpEXiiimoJAMY9fXnO66iADx0uvLaA6Wds4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RzGxo2v3A5Vwjq0i/Rdh0UjdFxhLG7cLwVN9Uv/CLq8HMRDKlEHgFF9kwosphkijc
	 TdNxA49a0J9QuaKT4HfUiQCDlcPJ2JD9Q0jfePPbAs6jskXQnGr3JQ13JQsDCj3F5A
	 evxBMd/pg+Iejbt1JwIrPWMBrrHKko80J2Yapll5pSDU1/RKQYuX1wqF9MVis0J/0U
	 Sfv93JsokbT2bY7FtjHLeS/gKaRnZ8EoOWHictNxZYOhAcf9KvqYowo71C0KpPHh6t
	 28GHenaSKXqLvKDS5MVchRwCpoSj8bdzgfcZ299IGC0eChWs3/jPHEOIQIw0zaFlRC
	 hgVBG/12oZP9Q==
Date: Tue, 6 Aug 2024 15:37:25 +0100
From: Simon Horman <horms@kernel.org>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	tparkin@katalix.com
Subject: Re: [PATCH net-next 4/9] l2tp: add tunnel/session get_next helpers
Message-ID: <20240806143725.GU2636630@kernel.org>
References: <cover.1722856576.git.jchapman@katalix.com>
 <4067ff5019040bf8ee2bd3c06db9e3d27ca39ded.1722856576.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4067ff5019040bf8ee2bd3c06db9e3d27ca39ded.1722856576.git.jchapman@katalix.com>

On Mon, Aug 05, 2024 at 12:35:28PM +0100, James Chapman wrote:
> l2tp management APIs and procfs/debugfs iterate over l2tp tunnel and
> session lists. Since these lists are now implemented using IDR, we can
> use IDR get_next APIs to iterate them. Add tunnel/session get_next
> functions to do so.
> 
> The session get_next functions get the next session in a given tunnel
> and need to account for l2tpv2 and l2tpv3 differences:
> 
>  * l2tpv2 sessions are keyed by tunnel ID / session ID. Iteration for
>    a given tunnel ID, TID, can therefore start with a key given by
>    TID/0 and finish when the next entry's tunnel ID is not TID. This
>    is possible only because the tunnel ID part of the key is the upper
>    16 bits and the session ID part the lower 16 bits; when idr_next
>    increments the key value, it therefore finds the next sessions of
>    the current tunnel before those of the next tunnel. Entries with
>    session ID 0 are always skipped because they are used internally by
>    pppol2tp.
> 
>  * l2tpv3 sessions are keyed by session ID. Iteration starts at the
>    first IDR entry and skips entries where the tunnel does not
>    match. Iteration must also consider session ID collisions and walk
>    the list of colliding sessions (if any) for one which matches the
>    supplied tunnel.
> 
> Signed-off-by: James Chapman <jchapman@katalix.com>
> Signed-off-by: Tom Parkin <tparkin@katalix.com>
> ---
>  net/l2tp/l2tp_core.c | 122 +++++++++++++++++++++++++++++++++++++++++++
>  net/l2tp/l2tp_core.h |   3 ++
>  2 files changed, 125 insertions(+)
> 
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index 0c661d499a6f..05e388490cd9 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -257,6 +257,28 @@ struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth)
>  }
>  EXPORT_SYMBOL_GPL(l2tp_tunnel_get_nth);
>  
> +struct l2tp_tunnel *l2tp_tunnel_get_next(const struct net *net, unsigned long *key)

nit: Please consider limiting lines to 80 columns wide,
as is still preferred by Networking code in the general case.

Flagged by checkpatch.pl --max-line-length=80"

...

> @@ -347,6 +369,106 @@ struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth)
>  }
>  EXPORT_SYMBOL_GPL(l2tp_session_get_nth);
>  
> +static struct l2tp_session *l2tp_v2_session_get_next(const struct net *net, u16 tid, unsigned long *key)
> +{
> +	struct l2tp_net *pn = l2tp_pernet(net);
> +	struct l2tp_session *session = NULL;
> +
> +	/* Start searching within the range of the tid */
> +	if (*key == 0)
> +		*key = l2tp_v2_session_key(tid, 0);
> +
> +	rcu_read_lock_bh();
> +again:
> +	session = idr_get_next_ul(&pn->l2tp_v2_session_idr, key);
> +	if (session) {
> +		struct l2tp_tunnel *tunnel = READ_ONCE(session->tunnel);
> +
> +		/* ignore sessions with id 0 as they are internal for pppol2tp */
> +		if (session->session_id == 0) {
> +			(*key)++;
> +			goto again;
> +		}
> +
> +		if (tunnel && tunnel->tunnel_id == tid &&

Here it is assumed that tunnel may be NULL.

> +		    refcount_inc_not_zero(&session->ref_count)) {
> +			rcu_read_unlock_bh();
> +			return session;
> +		}
> +
> +		(*key)++;
> +		if (tunnel->tunnel_id == tid)

But here tunnel is dereference unconditionally.
Is that safe?

Flagged by Smatch.

> +			goto again;
> +	}
> +	rcu_read_unlock_bh();
> +
> +	return NULL;
> +}

...

