Return-Path: <netdev+bounces-80477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B1787F070
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 20:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121C1282810
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 19:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE7056767;
	Mon, 18 Mar 2024 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAqm5HDx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0901A56755
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710790287; cv=none; b=oeZK5fTLYLShtgYbHByXpTFY4XynsJ/RtAbzMEqY8yo3FSR2dJmOQyX+X9tCqkmXvAt5RFsp0zV62hT4E6Q54TMaqlVYduf8Ea1X+Kk/rAR/tF69DUP1K88AAs7oV0MnxFDyBuNJ+i739TUMba03XVKCATgF/mlIzRry5QSiPTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710790287; c=relaxed/simple;
	bh=9ED1UA2aTtgsP9lqYvHliAsugiOz+ZDOcdsAbNgRAg4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F8sKAXwUf5Fw2zSITX2Sm13Ibu5d1dAKN50Srzn1Tj3Ly5khIfYz38vQCNMpKWH2ZwmHS/X+MOf8M50VsKszP+x3iYNeyNXZn4RQIgJnvPObi93BtejJoj13sZZBsgIAqoTYXR0RtNVsSMNLlwoO/cL4XibbYNowjYJ+Srz3lDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAqm5HDx; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78850c6609bso197443985a.0
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 12:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710790285; x=1711395085; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3HCtE5FSo/r9cX0PreD1CPVvUUAArzDA00BY23dMYLM=;
        b=MAqm5HDxyDaC/xSi3enHc5AbP+TCqid5nO5pMmm5NSyGzJ5OLwevywgCTDdw1c9QAH
         wKpsa3+AQqLn0PWM79zrtclQwskmo44TI119mZs+MlYX0CVi6OKqhsX9WYXdLkYXEiGJ
         b+qXNcAunzQGgPo3fzIuEv2sEiEn4xW2AEDPyrv6umwyrGrMbweyD04VIQVK8Rw3c2Pj
         3gg8HMlO65TILrfKDqoabqs9E4pJnhXmmZLIhf1HMmizASbcprztEAj+Chb66UsyDkks
         LaQPuqhqQ4b3GdtMOJcF9JMrVpYFBOZUtdzdUosb6Z9bTHAcrfJ4TVUK2erPJxz9L6gK
         8Ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710790285; x=1711395085;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3HCtE5FSo/r9cX0PreD1CPVvUUAArzDA00BY23dMYLM=;
        b=l5JhylL4kOFH+Dw+3Tixz7aut9aR02iNGU7TbVwEEUHOyrM3ZexD+owyF0niYJH8+I
         gm0KMRDA4yJvrduecdHTpLzrY6+sTWbvMMUDafblQjAMZSbRsWA9eQLUeuH2IL3v50ey
         8edsy7pxDBe3BSXm59Y5zGihb0lm772A9BXkOOyDfci8LD7+82D+g0oRcw/1n8m6fVsC
         VeMteX7JlIoGBy/Brh42c/7KJDpafFF2FxGPp4Kb3DGOoUUnK9LEIsInVcveYcDjc/rX
         IbgimPoIzlo20j2BxgvlIRWLgv/H4X3zwX6vwEGPY4TXWQlfrBcbIQCmh+4jDIurG8cQ
         +bRw==
X-Forwarded-Encrypted: i=1; AJvYcCWYNxYzLfiRidZlVJ4qGPH3XO9jt2eWd+UNyB//OxK2cOqKJ+9AAjHIDiH20ogTvpXgbtxUDi//Ch7HO9KfPbAb+DSQW+pg
X-Gm-Message-State: AOJu0YymuvvwDUmLd2GD6Ftsk7ELntRJpoihYmcTY0EbuEjg3elnfcxa
	nkbgSJdE006ughQQ3yRdVSdcLcjwCQe+3nR4jTKzBeYuNXhDnDo=
X-Google-Smtp-Source: AGHT+IEM2/UAdpOwySD5GxnJlR8xpYe4iTsQU8iP+0qN60W7JwatwDYP328gheEyeu4bDeRJz4VZIA==
X-Received: by 2002:a05:620a:3883:b0:789:e902:a608 with SMTP id qp3-20020a05620a388300b00789e902a608mr8513379qkn.54.1710790284937;
        Mon, 18 Mar 2024 12:31:24 -0700 (PDT)
Received: from cy-server ([2620:0:e00:550a:f223:a573:b90d:c1bf])
        by smtp.gmail.com with ESMTPSA id h15-20020ae9ec0f000000b00787930320b6sm4820387qkg.70.2024.03.18.12.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 12:31:24 -0700 (PDT)
Date: Mon, 18 Mar 2024 14:31:24 -0500
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, zzjas98@gmail.com
Subject: [net/sched] Question about possible misuse checksum in
 tcf_csum_ipv6_icmp()
Message-ID: <ZfiWjOWDs2osFAnX@cy-server>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear TC subsystem maintainers,

We are curious whether the function `tcf_csum_ipv6_icmp()` would have a misuse of `csum_partial()` leading to an out-of-bounds access.

The function `tcf_csum_ipv6_icmp` is https://elixir.bootlin.com/linux/v6.8/source/net/sched/act_csum.c#L183 and the relevant code is
```
static int tcf_csum_ipv6_icmp(struct sk_buff *skb, unsigned int ihl,
			      unsigned int ipl)
{
  ...
	ip6h = ipv6_hdr(skb);
	icmp6h->icmp6_cksum = 0;
	skb->csum = csum_partial(icmp6h, ipl - ihl, 0);
	icmp6h->icmp6_cksum = csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr,
					      ipl - ihl, IPPROTO_ICMPV6,
					      skb->csum);
  ...
}
```

Based on this patch: https://lore.kernel.org/netdev/20240201083817.12774-1-atenart@kernel.org/T/, it seems that the `skb` here for ICMPv6 could be non-linear, and `csum_partial` is not suitable for non-linear SKBs, which could lead to an out-of-bound access. The correct approach is to use `skb_checksum` which properly handles non-linear SKBs.

Based on the above information, a possible fix would be
```
-	skb->csum = csum_partial(icmp6h, ipl - ihl, 0);
+	skb->csum = skb_checksum(skb, skb_transport_offset(skb), ipl - ihl, 0);
``` 

Please kindly correct us if we missed any key information. Looking forward to your response!

Best,
Chenyuan

