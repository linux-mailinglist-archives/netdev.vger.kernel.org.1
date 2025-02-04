Return-Path: <netdev+bounces-162526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C323A272F5
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D053A4B39
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330BB20DD64;
	Tue,  4 Feb 2025 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSFTqfsQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9012B20DD72
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738674838; cv=none; b=oNBBOCQY5irkLTmzGdJQzbLAIWn+NcBCTk3d09tZEt4l5X+1+eprrQAqeuYiyz1k82V7Cf4nXd4wCczOb07PboADMDQsfCJi8qdgGxlGO+Z7FKOss14UhiPhUlBGpU3oVdWPGUEbDaZPlsw/NDb9TQO9kNb5RZQ5z/TwPm2BMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738674838; c=relaxed/simple;
	bh=TvgD4ndsUkhwd+FadLmQbxldQJCFlGXv1NjPVmKhvY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npwvkcY2CYkoSazFNn4H+vnx4rIKNiU7jN+seqbUUqfsbVgEVHsVQHcf2KLUIonqsSUbIYxwE7RXDQNBfAPHD4LcBqGA2rCdQcUMs7eIfWmHWp3WMFg9Ks129DlwwrbkSPBCeBX204i7pGhyu5d24oMYDZdCNnNgxudZ7YjmN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSFTqfsQ; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb3c143727so3159069b6e.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 05:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738674835; x=1739279635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0csLIbiTE9eLGFdzCoJoJsl7sfxj92t/YP6xM/NOFtM=;
        b=mSFTqfsQt2QFxG37a3N+5G5GJZfMp1SzjbIxeUikiBw9iNkpRI0XzowzKxbyhLOQ2+
         6DiRw9L4HTRa5Jt59c48hhBzD22/5SpUiuJ3+3gvXoFj6YErgM0Y/OVGKY7GCxtjHRJj
         XnuA3W+nY5nmMuzv6HDRjMgxXKGtY/Nf2DSUzH6MfATZ3+019F4igIkdq2T2p3LF6TSG
         oEJrxyP5TP9idPiUL/yAVr4oIEJXw7xz4z+J79HxqdkP0NuQklpGo+MIkNdTVXhSmhoQ
         O9ir1dPoz1cWEJn1OBki2XKSMXuPKL/yD2VAXoasWUmb4NAoH7zeShYdo1N6CMG6Ip+E
         AcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738674835; x=1739279635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0csLIbiTE9eLGFdzCoJoJsl7sfxj92t/YP6xM/NOFtM=;
        b=xBwayfhs0U0fgd/M8ELVgnQgrnQ64C+mxWMSoMyzxhI3IrDgml2e2JAjWn01/lTBZk
         QrCfDJTenTrUr5jqOjEb/I7XWuTMtZhS9bu3bXOhtw31p4tu49/o5RfKsOlr4DFP854D
         gx2NmMfKWfXjjL4Gtb2kA0fenojh3bn0jy0R61stv9gcvD5W7qXAQT3QJF2EN9BbXPxF
         yfGBcP0XP1ApGv/gmkWLaNrF9U0QNu6CKOIZ66Cjvd+GjEuH0cb++zC2MiQ5Z7cCqZxE
         0BkDY5ugjjn8iHSRXsfQBPYx1/48KhW47QnoZYDOXV0ZpDYSIwvC/TUOQvQu6zvDM7xG
         6Q8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLgbZhgv9eloJt6BYYgG2AWgIwZc967D4SkP/V+umaS40DbyTt2mIHoRrqxgQR3OWBPu9rm+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ3+QxTsyTuzccvwminvMN2IzHvvTbDW5XUZbIGM7kctEk6V6B
	P8xJFLgPSrFv5kHZStfpkswWbefRJDhnekMVfJGHMFe4AuAxOUk=
X-Gm-Gg: ASbGncuXIg1zQinqUkWINAhKwDJS7ESltW9wf0w2bl+yPqRDJQFWsPwZcpDCDbpTlsO
	T+XANsPkTEv8plU4Dv8igMEGGzyEoXyKmyZYbz0WYDhbG52dazG1QVOxm2aS72Y8OuGE9frzh8L
	lWsgyK9gIk9io0qHSHi2DauEVDVdhR/FCph82Az1T+NfyNQgGLkoFqPzgbzlY7XeYvLTrRQczPv
	PvH3EoZXWJm6HDifDKb6h+hnvcv2lV+5Dp4uoFBf+9Yyfc+bj6kes4L4OhNnQqnCXIntJvlOVn3
	a4A50eN2rf5C
X-Google-Smtp-Source: AGHT+IHSobVuMAgXLUNsgWzmThpIFOhYCu0eJ//e9f2gGfmB8wJhA4QuEIr2azgkjx+0mZXbBQgM3A==
X-Received: by 2002:a05:6808:170a:b0:3e7:ea12:6dfd with SMTP id 5614622812f47-3f36ddf5694mr1508458b6e.18.1738674835523;
        Tue, 04 Feb 2025 05:13:55 -0800 (PST)
Received: from t-dallas ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f333682eb9sm2971099b6e.43.2025.02.04.05.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 05:13:55 -0800 (PST)
Date: Tue, 4 Feb 2025 21:13:53 +0800
From: Ted Chen <znscnchen@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 3/3] vxlan: vxlan_rcv(): Update comment to
 inlucde ipv6
Message-ID: <Z6ISkVTHtknDTPGn@t-dallas>
References: <20250201113207.107798-1-znscnchen@gmail.com>
 <20250201113422.107849-1-znscnchen@gmail.com>
 <Z59gc6--yjT6nLCE@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z59gc6--yjT6nLCE@shredder>

On Sun, Feb 02, 2025 at 02:09:23PM +0200, Ido Schimmel wrote:
> On Sat, Feb 01, 2025 at 07:34:22PM +0800, Ted Chen wrote:
> > Update the comment to indicate that both ipv4/udp.c and ipv6/udp.c invoke
> 
> Nit: net/ipv4/udp.c and net/ipv6/udp.c
> 
> > vxlan_rcv() to process packets.
> > 
> > Signed-off-by: Ted Chen <znscnchen@gmail.com>
> > ---
> >  drivers/net/vxlan/vxlan_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> > index 5ef40ac816cc..8bdf91d1fdfe 100644
> > --- a/drivers/net/vxlan/vxlan_core.c
> > +++ b/drivers/net/vxlan/vxlan_core.c
> > @@ -1684,7 +1684,7 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
> >  	return err <= 1;
> >  }
> >  
> > -/* Callback from net/ipv4/udp.c to receive packets */
> > +/* Callback from net/ipv{4,6}/udp.c to receive packets */
> 
> Maybe just remove the comment? I don't see how anyone can find it
> useful.
I'm ok with either way.
Please let me know if I need to send a separate one or the current one
is fine.
 
> Regardless, please submit this patch separately as it's not related to
> the other patches in the series.
I came across this comment when I wrote this series as I found vxlan_rcv()
is called for both IPV4 and IPV6. Besides, I saw vxlan_err_lookup() has a
similar comment.

 
> >  static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
> >  {
> >  	struct vxlan_vni_node *vninode = NULL;
> > -- 
> > 2.39.2
> > 
> > 

