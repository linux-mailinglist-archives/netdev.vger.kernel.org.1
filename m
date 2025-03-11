Return-Path: <netdev+bounces-173982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC37A5CC30
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 18:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90239189D6B3
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82480262802;
	Tue, 11 Mar 2025 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7fJGHoB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B5D1876
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714216; cv=none; b=jvlW61eBXKGkDfGfhRjfYz7iiTuL6V3U5ngQyDRPebYeTwgmlxfpWbQOgzzSRapY7/NOXYQM3bhbbwC/c9ksGlBo6v1CyrmLhWuSXmnDDQX4DEZ5XrTiCpaxxcJG5/nnsUaG5pYLz2ojCjw8HUJRsmdteDGHXGsZLQqvMfWPjho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714216; c=relaxed/simple;
	bh=uzDotXYQ82cncov/k6jOpuEO2HtcShZWqVi0+lcLHfs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OQy5g9xUW0rHSgKvXs5SAj/9twS1HzdnHm+KhwADOzo+GjGp0PImim49Mq9so627U2h4wPz3cRrtkRDOGYf/fb/2EdkwJYXQJBevy6yEAace2MXQb+czV9DwHSZPqgcMqbVHjukL4DCUzslFl+cvW89H4J7ijhnkzvl8HJskxJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7fJGHoB; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8fce04655so42838466d6.3
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 10:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741714213; x=1742319013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9MmGdtBkFs//nG1JO2SU9G1DE6bWpfZHkKtk43tMok=;
        b=Z7fJGHoBESwdgCxzsYEijZOGcbNVYGoFO8HcWaGW4y/Y/pp2WbFGLku3cXuj7B0Wyy
         D84jxfGw1GFzeZupTcW5s8fJRCLe1sCP0CyjDeOk3kDsx/a/tb4iFrliRIalgC+2WRp5
         33+XoDD2g3liLsM3cgBs7znmMLtqacWlrSYgaeoEBUbR2WWcxj8HB1nc0xumlrpkeLty
         +AZ27smUPoQYiagZCy7EiimDdxd1xYctgmTywAeH26PM3wuDndoEV60cSk8fblLcucEF
         xa7rAOyPUdgwyO0oMe08HmE+Z5w8xBXSI2ECKpMANNJmJWpwv4oj9dADfW+RQBcMwOwl
         o7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741714213; x=1742319013;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M9MmGdtBkFs//nG1JO2SU9G1DE6bWpfZHkKtk43tMok=;
        b=mz9fBqEb3oLPbAKqUYcAMODlTgmKhlA71DXmo1ptKX6WYEI3gC+l/p9Ipu/T0Sdbl2
         TTE/OFEssXaI66PNbTVDTKHj0zRpxEXWppzUammRMx+nFv+eZho+YgE5sy+sTQDccAHm
         Jl5o5m6Sxut/9RZd6tAM9ETSs4tGIhckodjag+Tp0Yj3ZGQYtQxA3sFwgVJkM1++VnSG
         RVzRJhX9B3cc38orB4OJ6AVgflt1upNXvQmUYVtou70/ZuylQJo2i00i0ILi30jh81X9
         fEsSefezvtoquQ/H5OPeOIEIDuRWNAi07JSJuNCtS5/7S5uHcpTIMql6psT52GX06FST
         /uCA==
X-Forwarded-Encrypted: i=1; AJvYcCUD7zP3gsZ6lPuds9bzH4MJSUGi/MlvmkrNPl8FEJQ7Cf2SXpXr0Dlbck9thc5sJP6qGHFUO2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhASoY1YVtdyD485rZ2ImmeTEXmWpfDCOeYpwdnH1rTV8OExnZ
	w/oI5YyU7KkKw3ZNCoZ6KiX3TJqPZ191d0kOm6keQM68GHsIZEs6
X-Gm-Gg: ASbGncsYpzdgfESWzEW4xhBYxHZxnF3oCc1o7VFOkXiUl9sp+RhM6fIFbNf6MugXpee
	gE/sOp5Fb00ZsMn49kGzZbALUwmEx5RFRzOD7Kl/X3v0BVqflQ9prCUfGDb0N9prNVLE0tIlhr1
	VzsbpEikgoEtRYSsjFanfSn2iIBX9DPKe0biRGwSjJdpVqD3UVlLmUgh1QEZsfW6pw8Gev6587a
	LssAQYtbMdgbJChTXQVrPex7YuKjeFn2Hzio+jrmrCn51xu18AsyGJoLaGbZGxYrasyUrKFYqwX
	noD5SwQPa5IT+eU76z5QqTQ8zhTAOUNiTFVl/Sam94ZpzDhVtxdIuT1Ucwdc/I5ZyzMhvgEPtMC
	KTgC4bCnPtWiTC1Hle1x/7Q==
X-Google-Smtp-Source: AGHT+IHQA4y/jm9cFbqYvXmzCIco7EdadNMuaFY/hgf/d7bTYYZaA4yQpBVzdsJr1mVrtRyuUvpLgA==
X-Received: by 2002:ad4:5aa2:0:b0:6e8:eabf:fd4c with SMTP id 6a1803df08f44-6ea2fbb7b4cmr57515036d6.26.1741714213373;
        Tue, 11 Mar 2025 10:30:13 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7090c63sm74558576d6.38.2025.03.11.10.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:30:12 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:30:12 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, 
 kuniyu@amazon.com
Message-ID: <67d07324aff9a_2fa72c294d@willemb.c.googlers.com.notmuch>
In-Reply-To: <8a47efb6-ee87-4287-b61b-eff37421609f@redhat.com>
References: <cover.1741632298.git.pabeni@redhat.com>
 <b65c13770225f4a655657373f5ad90bcef3f57c9.1741632298.git.pabeni@redhat.com>
 <67cfa5236c212_28a0b329453@willemb.c.googlers.com.notmuch>
 <8a47efb6-ee87-4287-b61b-eff37421609f@redhat.com>
Subject: Re: [PATCH v3 net-next 2/2] udp_tunnel: use static call for GRO hooks
 when possible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On 3/11/25 3:51 AM, Willem de Bruijn wrote:
> > Paolo Abeni wrote:
> [...]
> >> +void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
> >> +{
> >> +	struct udp_tunnel_type_entry *cur = NULL, *avail = NULL;
> >> +	struct udp_sock *up = udp_sk(sk);
> >> +	int i, old_gro_type_nr;
> >> +
> >> +	if (!up->gro_receive)
> >> +		return;
> >> +
> >> +	mutex_lock(&udp_tunnel_gro_type_lock);
> >> +	for (i = 0; i < UDP_MAX_TUNNEL_TYPES; i++) {
> >> +		if (!refcount_read(&udp_tunnel_gro_types[i].count))
> > 
> > Optionally: && !avail, to fill the list from the front. And on delete
> > avoid gaps. For instance, like __fanout_link/__fanout_unlink.
> > 
> > Can stop sooner then. And list length is then implicit as i once found
> > the first [i].count == zero.
> > 
> > Then again, this list is always short. I can imagine you prefer to
> > leave as is.
> 
> I avoided optimizations for this slow path, to keep the code simpler.
> Thinking again about it, avoiding gaps will simplify/cleanup the code a
> bit (no need to lookup the enabled tunnel on deletion and to use `avail`
> on addition), so I'll do it.
> 
> Note that I'll still need to explicitly track the number of enabled
> tunnel types, as an easy way to disable the static call in the unlikely
> udp_tunnel_gro_type_nr == UDP_MAX_TUNNEL_TYPES event.
> 
> [...]
> >> +	if (udp_tunnel_gro_type_nr == 1) {
> >> +		for (i = 0; i < UDP_MAX_TUNNEL_TYPES; i++) {
> >> +			cur = &udp_tunnel_gro_types[i];
> >> +			if (refcount_read(&cur->count)) {
> >> +				static_call_update(udp_tunnel_gro_rcv,
> >> +						   cur->gro_receive);
> >> +				static_branch_enable(&udp_tunnel_static_call);
> >> +			}
> >> +		}
> >> +	} else if (old_gro_type_nr == 1) {
> >> +		static_branch_disable(&udp_tunnel_static_call);
> >> +		static_call_update(udp_tunnel_gro_rcv, dummy_gro_rcv);
> > 
> > These operations must not be reorderd, or dummy_gro_rcv might get hit.
> > 
> > If static calls are not configured, the last call is just a
> > WRITE_ONCE. Similar for static_branch_disable if !CONFIG_JUMP_LABEL.
> 
> When both construct are disabled, I think a wmb/rmb pair would be needed
> to ensure no reordering, and that in turn looks overkill. I think it
> would be better just drop the WARN_ONCE in dummy_gro_rcv().

SGTM, thanks.


