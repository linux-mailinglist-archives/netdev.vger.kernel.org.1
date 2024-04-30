Return-Path: <netdev+bounces-92339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DC68B6B2E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 09:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18A3282060
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 07:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040E92C184;
	Tue, 30 Apr 2024 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="ZDAuNTsi"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD98D2556F
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461241; cv=none; b=MryPHTcnKbOaZMcbpzSbkWnm1J5DCg+nPaxKXFS/W3V9IwlAfKUGD6LQUeiJEZqJXYVV69smSPHUnTzWWTVetZYzX7A98vWKaFG/u8ZDBOFzDjj05pwuuxFx995rXaiTdgclPIiocUBaeyiyBqginAox7fxhFmymHAHCsZcytSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461241; c=relaxed/simple;
	bh=1maMgUGLULgEBpuMVlI6qN4dTNKPBMv89C45lp89roc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDWsUaa7zlHOVe66WKw/uPopaGesnqaR+IC09QxhrDRFiBAEos2DIMDykvNayjr4CoEEYc9t+IM8b8DWCzT+Y0aukm5KVAi7NjCsYuVhmndw04YeMhnLj+MOI3ca6Whgefl+2IokVWcvAsP75/5+GVSoUUvjzqhifM5Rf9wGwLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=ZDAuNTsi; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 304bd2ab-06c1-11ef-836c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 304bd2ab-06c1-11ef-836c-005056aba152;
	Tue, 30 Apr 2024 09:13:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=zlSrHQFTqMbJzbw9UPPEmxAjU002p4f8WMKFA1cGgt8=;
	b=ZDAuNTsic6OwaQtRd0NA+R2e6saMeWewp+G/lDlZ4nk7U+CkzlWGegH+X3kS3wPM0bf0IePhBpCJ8
	 HIaiw31Imjx0XEBnoEOIMFc8ioh/XEgwYAXAdTUh2rajjCw7E+Yyl8lekhD91Xw4bSh2B39YNfldPT
	 c1iqDtGf/HbVSAZw=
X-KPN-MID: 33|DcY+D3IcxwZR3Divm6RUQ//JTBnB4404taX5wR2TCmmBlCBRkfR9ZEpAeO/UrJX
 36nPDZ51jtza/G8LJ38s/V51uVNhG0orjP/htcN3w5L4=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|pTScfeBsNrg1oTnoy8WJyDMQ2/uPlnmWQ/hT5xMD/5/Jy6zhhQ+aYtVNpEtek9X
 4khyyPzq57d77m4/F1HxYsQ==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 30f6dc61-06c1-11ef-8d64-005056ab7447;
	Tue, 30 Apr 2024 09:13:50 +0200 (CEST)
Date: Tue, 30 Apr 2024 09:13:48 +0200
From: Antony Antony <antony@phenome.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH ipsec-next v13 1/4] xfrm: Add Direction to the SA in or
 out
Message-ID: <ZjCaLKYVIEhJvn9t@Antony2201.local>
References: <cover.1714118266.git.antony.antony@secunet.com>
 <21d941a355a4d7655bb8647ba3db145b83969a6f.1714118266.git.antony.antony@secunet.com>
 <Zi-OdMloMyZ-BynF@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi-OdMloMyZ-BynF@hog>

On Mon, Apr 29, 2024 at 02:11:32PM +0200, Sabrina Dubroca via Devel wrote:
> 2024-04-26, 10:05:06 +0200, Antony Antony wrote:
> > diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> > index 810b520493f3..65948598be0b 100644
> > --- a/net/xfrm/xfrm_user.c
> > +++ b/net/xfrm/xfrm_user.c
> > @@ -358,6 +383,64 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
> >  			err = -EINVAL;
> >  			goto out;
> >  		}
> > +
> > +		if (sa_dir == XFRM_SA_DIR_OUT) {
> > +			NL_SET_ERR_MSG(extack,
> > +				       "MTIMER_THRESH attribute should not be set on output SA");
> > +			err = -EINVAL;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	if (sa_dir == XFRM_SA_DIR_OUT) {
> > +		if (p->flags & XFRM_STATE_DECAP_DSCP) {
> > +			NL_SET_ERR_MSG(extack, "Flag DECAP_DSCP should not be set for output SA");
> > +			err = -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		if (p->flags & XFRM_STATE_ICMP) {
> > +			NL_SET_ERR_MSG(extack, "Flag ICMP should not be set for output SA");
> > +			err = -EINVAL;
> > +			goto out;
> > +		}
> 
> Maybe also XFRM_STATE_WILDRECV? It looks pretty "input" to me.

Now I think it is. I wasn't sure before. I have never seen this flag in use.
> 
> > +
> > +		if (p->replay_window) {
> > +			NL_SET_ERR_MSG(extack, "Replay window should be 0 for output SA");
> > +			err = -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		if (attrs[XFRMA_REPLAY_VAL]) {
> > +			struct xfrm_replay_state *replay;
> > +
> > +			replay = nla_data(attrs[XFRMA_REPLAY_VAL]);
> > +
> > +			if (replay->seq || replay->bitmap) {
> > +				NL_SET_ERR_MSG(extack,
> > +					       "Replay seq and bitmap should be 0 for output SA");
> > +				err = -EINVAL;
> > +				goto out;
> > +			}
> > +		}
> > +	}
> > +
> > +	if (sa_dir == XFRM_SA_DIR_IN) {
> > +		if (p->flags & XFRM_STATE_NOPMTUDISC) {
> > +			NL_SET_ERR_MSG(extack, "Flag NOPMTUDISC should not be set for input SA");
> > +			err = -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		if (attrs[XFRMA_SA_EXTRA_FLAGS]) {
> > +			u32 xflags = nla_get_u32(attrs[XFRMA_SA_EXTRA_FLAGS]);
> > +
> > +			if (xflags & XFRM_SA_XFLAG_DONT_ENCAP_DSCP) {
> 
> Shouldn't XFRM_SA_XFLAG_OSEQ_MAY_WRAP also be excluded on input?

I aggree. this is odd flag:) me wonders who use it.

> Sorry I didn't check all the remaining flags until now.
> 
> 
> Apart from that, the series looks good now, so I can also ack it and
> add those two extra flags as a follow-up patch. Steffen/Antony, let me
> know what you prefer.

I just v4 lets see how it goes. Thanks Sabrina.

