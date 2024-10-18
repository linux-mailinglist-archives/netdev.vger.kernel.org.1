Return-Path: <netdev+bounces-137017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6E79A4082
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7686E1C20FCA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842051F429E;
	Fri, 18 Oct 2024 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRs/Ax+v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD2F1EE020
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259639; cv=none; b=BYvAeWL0oaP4bjQGdATtSNBn4/ppavQGGd24IsM2j5Mv/DFELZeBym5+4CoowewEx2JgarxwdHBAEKOcYBkwMdZA7A4lOlnIAYVgpILDtS5Usl92jxeI9OkaCyAOcmpEsqEZ8ObfOe8UhVK5XvXLfl7+/spY7dUnoVrVyZbr7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259639; c=relaxed/simple;
	bh=q5XzzZkvpKPZVMQhKt2+hxriexAQpwZS6+J7f/x2Cik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXHY+W1nTcT1jFiSmSOT0ePzTYcWi2FE4xhD3A2Jz7o/ri2UxHnSucbivZdWxXplaybci/ygSK3/ovHI0n2CCgppwZfMoPHGp4ofcA0axa5q3RjUJFgQfhnNbqvdi+ECmxuvtS8EUYVT+8rHrwe66EUU98FplOSaK+/2H0HF7zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dRs/Ax+v; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so22514881fa.3
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 06:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729259635; x=1729864435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5XzzZkvpKPZVMQhKt2+hxriexAQpwZS6+J7f/x2Cik=;
        b=dRs/Ax+vEY7AEA+qnzqkmIlM+rXSj056FuFoP9HOMikK4dQgD7PonkzKuw4vZp7KqS
         WhlCZLKfXeTooCantpz0J7LtdSGeI7gnN95RqaKkUyWijIzO8br/CGD5qMCa5hZ4lDRz
         ZNOKTswkPbDJKAOjdIR1bULFUJq4wCyio7vDNsXtrSr19akj2ZXWjAlcTSiHGsO4+i4A
         EjjODyEISHyecsMayLHA9fyiZwdBaLI3lxzx4OL2rQcVj8aqhQ1EGAhVCyup804mkp3U
         xUMilXyQUOEkkRmLHNZ1RTv9ojBKLcHVSSNwRB3tGpwHphjA3Iiv+8at7XVvFPhh/Y9E
         E1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729259635; x=1729864435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5XzzZkvpKPZVMQhKt2+hxriexAQpwZS6+J7f/x2Cik=;
        b=NazgMlguv5dc/k0dlrttnqE7OSBtHmxmUppcQeTKc1Ozqbu/z+JKdk7+vly4Z9+Hgr
         PLEKugdQ5H3oVRrCpxChcqZMwaEnj7N6GGLXS9osCtT7y/WDTPVX5sesUuNK59nA54d4
         Lfal2ejiaJOAKxwWRrWABGG6lwGr4UfjymWDhXRtbLdvW0wASF11uYWwngSI3KcVszvS
         M1os2ZGPysGGHPea/Vz7ftG6FJq6BREKiz3HjeaL5RL5CTUD8J+lzdgXmMBCbOw6qmqv
         kDF9w6Zua+Rv7VH8CCbKiHAg93H8y+P1VFUn/z8VkTjzHGPEnJNMBC4lbZQvEtHlmVlj
         tfaw==
X-Forwarded-Encrypted: i=1; AJvYcCW9SpNgQOfWJekHB6n1pdE+0HWt0MsNK0o+dD2ph0sGE5rSHETRptjQlHqlW//KiPtpKXL0cNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3h9XXd14ggju1Cqi75o/OqA8imro6xqnDVNimL+1xA7nr0e5F
	AoKU9H5nRV8KkZ6wEIzTdtFVbgSmYCk5FFulPvfl7zMoQ4D2LTb6K8cFhBK1r0I3At9/+nR/VY6
	oTbzPJsPEVPzuGjFDa+xzan2CUi0aqFxAtwm4
X-Google-Smtp-Source: AGHT+IH6I1iVYCSSnO5GcKfbdjMExJuC2VdhLgWpVrmG1gZES1vJlUQUUtw2zhxvyuu66pkVtMwlgQUb8KO8IDxV31s=
X-Received: by 2002:a05:651c:1186:b0:2fb:4982:daea with SMTP id
 38308e7fff4ca-2fb831e6b78mr10675221fa.32.1729259635205; Fri, 18 Oct 2024
 06:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018012225.90409-1-kuniyu@amazon.com> <20241018012225.90409-7-kuniyu@amazon.com>
In-Reply-To: <20241018012225.90409-7-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 18 Oct 2024 15:53:43 +0200
Message-ID: <CANn89i+tJ62nycCWpki-8uMu1Gj3iW928M1qyF00fdZ=JpnC5g@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 06/11] ipv4: Convert RTM_DELADDR to per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:24=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Let's push down RTNL into inet_rtm_deladdr() as rtnl_net_lock().
>
> Now, ip_mc_autojoin_config() is always called under per-netns RTNL,
> so ASSERT_RTNL() can be replaced with ASSERT_RTNL_NET().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

