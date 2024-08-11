Return-Path: <netdev+bounces-117525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0841F94E2B2
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 20:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B111F21150
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 18:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A611537DD;
	Sun, 11 Aug 2024 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbYirMcD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E5014B95B
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723401382; cv=none; b=lP8fDiusdRORGjuaU/Usj9QNKcN1gyZX/llxMp0KPU6GJ+xXEfq9R6fEowaRJT3494XV4b107vVhwA0CtmUiLXfpWxROS1Zn0McI3MbeQc0TQo123xKhg8z3YGG6G1yjq4x4bTSOr00T02mO1hWWHaPWKydvh+QdL6Xwh6D5bI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723401382; c=relaxed/simple;
	bh=3NI/r7oDE/ePFOSSutH7Dqef9lZ4yw2LghjhazweMK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEObCb3Qlx/pIAGFeMT6Sr4r5u8EyFpaq0N6Me02uPdi7W8cAfQBkOF109VaPjwoalkA4FjKbce3bC5S2FR3HSGSAmuq2AjwvkCpAjj11BipsiR7VWJBFQ2+K5ZDXJbirgEJmV0/24GBbILwdoe9cgXX0iRmUUKbJmtaUARwJqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbYirMcD; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3dd16257b87so165091b6e.2
        for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 11:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723401379; x=1724006179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y8FAkeLc9Xm9DTTRbc+ZegI5K2jgJPmd7i1hDZR0q/U=;
        b=XbYirMcDY5dP9hDyG5Ey44tRuPKMi8b0gSeoo7vT0MhcdY+WmAZwkv7aJzuibppx4E
         hEQV6zbAv0SnIQi9PpFDCZ2J5IosEj979FRVS0E76xLRuOq1ScroVDP1QotaDD7G48W+
         a/qE0hMtzy+vTUlS8zJfocVe2D2Yi95jF/QnzsWWDtjgeB196x1CqbZ7mpThpffOMKXc
         Fi22a6duG1I3tSFG7NrsBlaEdnAHoNUJr3wNZl5yaCOAqNp/PaMo7vQTEgxtOXxmEdOI
         mu+LflLvs1fIJoVY7JoJbSMn9Qt/fvSx9sIo/U6OBZoch8cHrUScEckfk40gjhb8kYhy
         3weQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723401379; x=1724006179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8FAkeLc9Xm9DTTRbc+ZegI5K2jgJPmd7i1hDZR0q/U=;
        b=i28BEnXYcOf7Kh5IV+sryNCDL6whweOc9u64YLfKFINxLT3NkOtsZnTkocsaevGfU/
         y+KpRPbpDI3s0I/2rWxlM7/7CUbL6+tzN2bM8tP44gB6cEBxXuy3Mk6sJZqo93EmBpte
         VyV2NfokCzQK7ar6CE7iobJGqCwfqELwIq4HWY9jev+wW3+5xztw2xyuWIdm+2PB3kE2
         uEps302xGLbG+u40lGLnzPgjzsiJlC2LkV+IRkZp5Q42PYovYg2d968CJtU11gPfgKr6
         BNWua0NwWpt1RKpq71yPztYtFfwHaY3VAoFOfxHu8e70xo1aG0XzkXnp8pFRALRnjgSO
         K/bQ==
X-Gm-Message-State: AOJu0YwpxngbHvYb6pK3jIpyUeuxCA0hB4VLQFv6LvtGKOr1/4yUtyJP
	+jORyNYt9/qy0Uo9nC/c9O4Wl2CRQw2q2kqTjfeUyXR0TysCo1ae
X-Google-Smtp-Source: AGHT+IHD/RCxPbAXodWAVIW+qMN7cE30scGyquAXI4KKqix86VrQby44m/e2HmBoFnV9DtZizV6p+Q==
X-Received: by 2002:a05:6808:3a15:b0:3d9:de1e:c24c with SMTP id 5614622812f47-3dc41665a78mr11131068b6e.3.1723401379609;
        Sun, 11 Aug 2024 11:36:19 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:8ec7:dbc7:9efe:94d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bba3f374sm25107065ad.259.2024.08.11.11.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 11:36:18 -0700 (PDT)
Date: Sun, 11 Aug 2024 11:36:17 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	tparkin@katalix.com, horms@kernel.org
Subject: Re: [PATCH v2 net-next 6/9] l2tp: use get_next APIs for management
 requests and procfs/debugfs
Message-ID: <ZrkEofKqANg/9sTB@pop-os.localdomain>
References: <cover.1723011569.git.jchapman@katalix.com>
 <0ed95752e184f213260e84b4ff3ee4f4bedeed9e.1723011569.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ed95752e184f213260e84b4ff3ee4f4bedeed9e.1723011569.git.jchapman@katalix.com>

On Wed, Aug 07, 2024 at 07:54:49AM +0100, James Chapman wrote:
> diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
> index cc464982a7d9..0fabacffc3f3 100644
> --- a/net/l2tp/l2tp_core.h
> +++ b/net/l2tp/l2tp_core.h
> @@ -219,14 +219,12 @@ void l2tp_session_dec_refcount(struct l2tp_session *session);
>   * the caller must ensure that the reference is dropped appropriately.
>   */
>  struct l2tp_tunnel *l2tp_tunnel_get(const struct net *net, u32 tunnel_id);
> -struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth);
>  struct l2tp_tunnel *l2tp_tunnel_get_next(const struct net *net, unsigned long *key);
>  
>  struct l2tp_session *l2tp_v3_session_get(const struct net *net, struct sock *sk, u32 session_id);
>  struct l2tp_session *l2tp_v2_session_get(const struct net *net, u16 tunnel_id, u16 session_id);
>  struct l2tp_session *l2tp_session_get(const struct net *net, struct sock *sk, int pver,
>  				      u32 tunnel_id, u32 session_id);
> -struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth);
>  struct l2tp_session *l2tp_session_get_next(const struct net *net, struct sock *sk, int pver,
>  					   u32 tunnel_id, unsigned long *key);
>  struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
> diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
> index 8755ae521154..b2134b57ed18 100644
> --- a/net/l2tp/l2tp_debugfs.c
> +++ b/net/l2tp/l2tp_debugfs.c
> @@ -34,8 +34,8 @@ static struct dentry *rootdir;
>  struct l2tp_dfs_seq_data {
>  	struct net	*net;
>  	netns_tracker	ns_tracker;
> -	int tunnel_idx;			/* current tunnel */
> -	int session_idx;		/* index of session within current tunnel */
> +	unsigned long tkey;		/* lookup key of current tunnel */
> +	unsigned long skey;		/* lookup key of current session */

Any reason to change the type from int to unsigned long?

Asking because tunnel ID remains to be 32bit unsigned int as a part of
UAPI.

Thanks.

