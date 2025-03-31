Return-Path: <netdev+bounces-178436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0239A77019
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FAF0188C776
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DFB21B90B;
	Mon, 31 Mar 2025 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOu/4uBf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819CC1D63DD
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743456457; cv=none; b=RXT8ShvP6xq4YllFNx9z84jFOzVjdW+c59kGQmmBLP60T/LXqwg7d1CPFVd4UqCTi1oCjbm4kUKcfril65t+zE5H2T2HnaX0NYwTDFmdBFDAuQsYF/23a6KcqGmu+YFs23Z5h7dc5pRx4g9+F31H7MBN9RlwhUFMJeVC+GgSBY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743456457; c=relaxed/simple;
	bh=j7OaQj73o+b7zJ0DsvrbatEWzUHO9a9o63SU+Xxtthg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BD/hBC9RSla0bqgKQ70GtqpXwXh+V7oDxgb7SQ2dFn1OP/t8VVYgz9zUHkZ9yNiynIr3E/KkqDHJe+RuYRZGbctezRvPNDXoc+qZ4UD10nsZYEewCopYu9Iywp3hUWSmynDjkTmDluzOLe5lNT2bXDdPOg2wlzzfX2q7xIByptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOu/4uBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3818C4CEE3;
	Mon, 31 Mar 2025 21:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743456457;
	bh=j7OaQj73o+b7zJ0DsvrbatEWzUHO9a9o63SU+Xxtthg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WOu/4uBfJB1I5XHsa8esWn2ih4CRf07IL6P+RKGLgMdThUZb0SF1GEqm0ds+RFLxy
	 eRLBtXXvJWibmTa9mNHi412pvmnumoFdDQe+Z2AIr323q5kOj+jdv93fsZ/RZ+1UMS
	 QCeSmUvMw9h3nCCuE3Bvx1rNHAer36k9+sOXD8upx+hpG90bvO9gQwN3WbuIGJrcUY
	 tZK5F/0OARj38g5/NdRtF1LdjuTIysTsfhcFrnh0W2lp9PkGqz90B3+UC7MWhDu+tE
	 3j6AZrVVCf2GK8rKAKwOe17woSJej1mQWxijhOhC6rDHLc+roxIf7eEeaC5V/kGPF3
	 +W/in5mMbjlvw==
Date: Mon, 31 Mar 2025 14:27:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, Cosmin Ratiu
 <cratiu@nvidia.com>
Subject: Re: [PATCH net v4 02/11] net: hold instance lock during
 NETDEV_REGISTER/UP
Message-ID: <20250331142736.263cbd6f@kernel.org>
In-Reply-To: <Z-sFZfPR9QlDwhoI@mini-arch>
References: <20250331150603.1906635-1-sdf@fomichev.me>
	<20250331150603.1906635-3-sdf@fomichev.me>
	<20250331134811.02655264@kernel.org>
	<Z-sFZfPR9QlDwhoI@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 14:13:09 -0700 Stanislav Fomichev wrote:
> > > @@ -3042,14 +3040,16 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
> > >  
> > >  		new_ifindex = nla_get_s32_default(tb[IFLA_NEW_IFINDEX], 0);
> > >  
> > > -		err = netif_change_net_namespace(dev, tgt_net, pat,
> > > -						 new_ifindex, extack);
> > > +		err = __dev_change_net_namespace(dev, tgt_net, pat, new_ifindex,  
> > 
> > nit: over 80 chars now  
> 
> It's exactly 80, is it considered over? This has been done by clang
> formatter which has 'ColumnLimit: 80'.. Will undo regardless, but lmk
> if the rule is >80 or >=80 (the formatter thinks it's the former)

My bad, unplugging the external screen seems to slightly shrink windows
in GNOME. My terminal was set to 79 chars :S

