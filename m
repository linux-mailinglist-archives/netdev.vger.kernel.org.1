Return-Path: <netdev+bounces-176755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE139A6C008
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4A44672E4
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 16:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CA914601C;
	Fri, 21 Mar 2025 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuD0xC+/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F9613635C
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574938; cv=none; b=IQB0DurkbqKG8MR99knRu/r539Fr19xaTooJx0COA/h9IA6c1QyxUy/9ATKsz3W8h3E90w07NVirC6nTPTT1l1c+geeUIg/sX/HEcgWmeO0v9+bZ7FZ1Oy/Sokm4PBHdBj1vkgONIFPjeO9z0ymyCR1oHkdw15EJjxGgmRb+5uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574938; c=relaxed/simple;
	bh=I5mK9Q01ioBKKeKNgtzVIi7n16jf8TqiHEBSnnBizxc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bq1P3ElUf3I3dzm/hTT8CQMs1ChgcE8F7A962bYqsixuAzoQPV8UsqDOjz+sxpnuXXT6pBCex6BtApdmU+vpEF94m+KufFjxm9dVjlZnERrWDTE9j0UQtOe8uLXu6V3qmpIo9nLc9jSl4TqZW19Kntbw5hqH9aVjjUx3pxCmGmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuD0xC+/; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c08f9d0ef3so129465885a.2
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 09:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742574936; x=1743179736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCNeIgLr1r6uTHNIqnla1uiHrbwOPUark4B9rIFkcH0=;
        b=DuD0xC+/zOo6IVZ3Zx/CFjcWpsvSzlxI/02Y3YieveU7eTsp7lxrvM9JR0fjZI+x8v
         54U0gPTV/lSfS28h+1xWdWPm9f0zgmw+2wd3wdOYWNPKAOSnSHLFYUSoOT+6Q8/7E6H1
         z2g221F2vEBQU7DXxglR9oXUw0qDtgVZvIYaGymfqv8hSOlV9nu4RXjlJFhDoOmp+pwg
         lrcamjr+gMgMOSVYr2RYTZ63zEfaj7VU48UL20NkVbIJqO+/MrmsvKt9B9iWYrPotgje
         GHDOR3l3lM1ShhBm/TEJXRiDGoyoPfPDthB5FvdHV7ziI6VJnvT4GeG44b1yjqUeIKoL
         LbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742574936; x=1743179736;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KCNeIgLr1r6uTHNIqnla1uiHrbwOPUark4B9rIFkcH0=;
        b=hkXob6YThjA/g65/vJ5Rd0OE0zqVaTHE1qZl8Lg9xGnGMxIB3nPlrPF7Zz5Q3+NI6E
         O290PZRCNBp/thtiPS7xt3ACti7sC7pwQN6VYL+lVF/9jC2m5CkB8w5s/hpIBSHGvBQ/
         yKCNr10tr9ZpzmBaJUT9rVX3VTNmCwi+SzewtO+uMDi9W4Spm/pxgzkrl55E3TbA+r/Y
         sJeAXZWVeLY+RjiXVFBuo7uxLSCY+GmDkDq7Pep+0V48ZcSNNINH1XgJXqjXgxmfSZd+
         ADRr9CseAXK7eOG0OWTR7imJszpfKCN+q3ydzZtx40Iek1Q4runkUAtVu5yW7MZXFkRY
         32Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXH6fks3KkgAWeXYpKhFBp1BQHkukBt9akGwK0S6mgfCI1Fw+Pr5h1ZC69wa5NOrJZOmY+znxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR9MQ82SrHdyPOZ/E0U+wQ9NwbRFM/hYYQLOXqVmYln/dx4+cb
	XmGIiPmMt7siXQHyqza3ZSv2fzL7n9x2pfEeyl1Y4cIQujpzg1IJ
X-Gm-Gg: ASbGncvHy/qdIprTBBAVU6dKB0reSoX/OmMsbMzu8fOGFWMArUGqYxY0HeQUPmjahNH
	4B4DlhXkF2LCivjjY3fyOlAaOkzY4cUlROfuHaUByRXOr/5wNK7yNxNUnwcTZG3STBgvpSMXcu0
	doL/myBm11lWKibXpx2LDh5EHxH7atbTZHUQ5AUGgpK6HjqY5G0VDSP8+slUogTvjEfjEl04UC6
	Pyh630biz73+MPCOr+9GOLpYQAqOc7AWlf8nhhhRGnDvUmI4cOXY3M447f4nIPGbuQM5lrrlJZO
	d34J1+4ZWv85iJofW1+dGs3HTaZzTjMmR0oGPi+3QS8cdA9jcz70e5pixcoWidd3uKwJ6wDzY75
	CXkAZrQ+IsjDMtoj7u9t4HQ==
X-Google-Smtp-Source: AGHT+IEzNnYyhGynLj07ZZIh4+VErlYMT7P51DCcNzlUfuMq0B7Sosfs6ULCLKWAe5z7eJMKtgqqbg==
X-Received: by 2002:a05:620a:4588:b0:7c5:4088:e48c with SMTP id af79cd13be357-7c5ba190efemr488369785a.29.1742574935999;
        Fri, 21 Mar 2025 09:35:35 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b935f0a0sm147014385a.116.2025.03.21.09.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:35:35 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:35:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>
Message-ID: <67dd9556e1305_14b140294a7@willemb.c.googlers.com.notmuch>
In-Reply-To: <5c4df4171225ab664c748da190c6f2c2f662c48b.1742557254.git.pabeni@redhat.com>
References: <cover.1742557254.git.pabeni@redhat.com>
 <5c4df4171225ab664c748da190c6f2c2f662c48b.1742557254.git.pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 2/5] udp_tunnel: fix compile warning
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
> Nathan reported that the compiler is not happy to use a zero
> size udp_tunnel_gro_types array:
> 
>   net/ipv4/udp_offload.c:130:8: warning: array index 0 is past the end of the array (that has type 'struct udp_tunnel_type_entry[0]') [-Warray-bounds]
>     130 |                                    udp_tunnel_gro_types[0].gro_receive);
>         |                                    ^                    ~
>   include/linux/static_call.h:154:42: note: expanded from macro 'static_call_update'
>     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
>         |                                                 ^~~~
>   net/ipv4/udp_offload.c:47:1: note: array 'udp_tunnel_gro_types' declared here
>      47 | static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
>         | ^
>   1 warning generated.
> 
> In such (unusual) configuration we should skip entirely the
> static call optimization accounting.
> 
> Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/cover.1741718157.git.pabeni@redhat.com/T/#m6e309a49f04330de81a618c3c166368252ba42e4
> Fixes: 311b36574ceac ("udp_tunnel: use static call for GRO hooks when possible")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Should CONFIG_NET_UDP_TUNNEL just not be user selectable and only
enabled by implementations of UDP tunnels like vxlan and geneve?

> ---
>  net/ipv4/udp_offload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 02365b818f1af..fd2b8e3830beb 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -83,7 +83,7 @@ void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
>  	struct udp_sock *up = udp_sk(sk);
>  	int i, old_gro_type_nr;
>  
> -	if (!up->gro_receive)
> +	if (!UDP_MAX_TUNNEL_TYPES || !up->gro_receive)
>  		return;

If that is too risky, I suppose this workaround is sufficient.
But having a zero length array seems a bit odd.


