Return-Path: <netdev+bounces-185150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBD9A98BBE
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CDFA3B9CC0
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C511A08DF;
	Wed, 23 Apr 2025 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3P8AxUy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBAA1A08A6
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416014; cv=none; b=W/erEfu4JWpTQxQppsppj6lWZym9jI3thfG0y9F3oa2uj9i5NJzGFWMp4cY1ua4+yug9lT0eyL0Nknxk/be6eSkaEm6nrOLqPNplbQ5O3PkOqDBn0PGTwuXJX5jj5RHTDTwgybSylAoMBArWVc2jpOJcyyLYGxX+zn+Ag+ojEXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416014; c=relaxed/simple;
	bh=yHmOW04DPppLh8IfziITDSuZp7e8mfznwZ/kZcUjsmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpDsDkmZ9qR3r81sjmKlXTO0/h6ddRoKFuHYDAcTx3jk4viqD79hni3p6v6DrN1ZQ34rbgE1uNKd5HaOTSiSgqFbuj4/6OarXspcIJ09IMb8j1xVUiPvpXZCE5aIYaUh0cKfpWPXFADglCSpt9K5bB3Olwh8vHe6WRg5Ay/Gx5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3P8AxUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A28C4CEEB;
	Wed, 23 Apr 2025 13:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745416014;
	bh=yHmOW04DPppLh8IfziITDSuZp7e8mfznwZ/kZcUjsmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B3P8AxUyEwdtKNOvnAldK82ebTk1P0wOghBPErzA1uotXCjE8fC3ox5xs57jL75fh
	 K8En2G9rHmRry7TdRWxI1A8LP4ngqfQC8oUbQKMgdPh8AKjw+JFjgcW8pF9r8BtcqR
	 O979OYT7ai9+aJSCNzHLa4QTFtghqkWi3WJr5ATU1D0UrQ1Y4Oe8shM5YFO989IR5b
	 CDQ+1QILQHPPqbtpuEZlh2/n3uYLKsqhs6utFrEEG5LZoXhBxZ4107wCDwYy7myPDE
	 4IcBaJUOpDbLYipMNqpzmLEY2YiEYIjJVPtpWpkGbvVcgTzUqruONvr9R+3ghULI+O
	 eMnWWGTuRCbnA==
Date: Wed, 23 Apr 2025 06:46:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
 dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
 jdamato@fastly.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 19/22] eth: bnxt: use queue op config validate
Message-ID: <20250423064653.6db44e9a@kernel.org>
In-Reply-To: <a5uokb5qgp5atz2cakap2idwhepu5uxkmhj43guf5t3abhyu4n@7xaxugulyng2>
References: <20250421222827.283737-1-kuba@kernel.org>
	<20250421222827.283737-20-kuba@kernel.org>
	<a5uokb5qgp5atz2cakap2idwhepu5uxkmhj43guf5t3abhyu4n@7xaxugulyng2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 10:00:01 +0000 Dragos Tatulea wrote:
> > +static int
> > +bnxt_queue_cfg_validate(struct net_device *dev, int idx,
> > +			struct netdev_queue_config *qcfg,
> > +			struct netlink_ext_ack *extack)
> > +{
> > +	struct bnxt *bp = netdev_priv(dev);
> > +
> > +	/* Older chips need MSS calc so rx_buf_len is not supported,
> > +	 * but we don't set queue ops for them so we should never get here.
> > +	 */
> > +	if (qcfg->rx_buf_len != bp->rx_page_size &&
> > +	    !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS)) {
> > +		NL_SET_ERR_MSG_MOD(extack, "changing rx-buf-len not supported");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!is_power_of_2(qcfg->rx_buf_len)) {
> > +		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len is not power of 2");
> > +		return -ERANGE;
> > +	}
> > +	if (qcfg->rx_buf_len < BNXT_RX_PAGE_SIZE ||
> > +	    qcfg->rx_buf_len > BNXT_MAX_RX_PAGE_SIZE) {
> > +		NL_SET_ERR_MSG_MOD(extack, "rx-buf-len out of range");
> > +		return -ERANGE;
> > +	}
> > +	return 0;
> > +}
> > +  
> HDS off and rx_buf_len > 4K seems to be accepted. Is this inteded?

For bnxt rx_buf_len only applies to the "payload buffers".
I should document that, and retest with XDP. 

I posted a doc recently with a "design guide" for API interfaces, 
it said:

  Visibility
  ==========

  To simplify the implementations configuration parameters of disabled features
  do not have to be hidden, or inaccessible.

Which I intended to mean that configuring something that isn't enabled
is okay. IIRC we also don't reject setting hds threshold if hds is off.

Hope I understood what you're getting at.

