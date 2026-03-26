Return-Path: <netdev+bounces-271814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mME9Ow+kxGle1wQAu9opvQ
	(envelope-from <netdev+bounces-271814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:12:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E2B32EA3F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FE0C303B4C5
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D36A374E6C;
	Thu, 26 Mar 2026 03:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpygMZB0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03BC246788
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774494732; cv=none; b=hhJZ0bhcswww7utuuwPuP/lgfWhwE6OAMYKA3u4orh53Wk8p8NgnYOF44yhNLoxlUEOHyje6P2PUC/E0SGr6aXsUkd0zNtaOR2dBv4VMl6HIR12hp6z9KGHfLe5t/UmhBVB54bi6zIP0GpFYAtOWxg+xW2hhkQYAx+dWspSxmNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774494732; c=relaxed/simple;
	bh=cxy4jPFKS+dxyEgCPzGebbTEv+fWYHGtoa7d4CzerZU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=g5ErUDAgbVMPVZEp2VM8ZmHCGTquEbPWaEQcDCtAopvsfOI03zRcGLZQNycu+N8XMv6sODLavBJpymq/SDCy8clxjAjlHEUq4SskYY4y3vrRIy9QuF06ua2vrsjTsqG4DdSq/lwQrJxUc5wNL2is4RstB9oTxzI7D1gLZarLUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpygMZB0; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64acd19e1dfso540391d50.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774494730; x=1775099530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDOAPzrB5C4ZBYqCDQh23MerGG6Hzy4OJS0fb+WkGj4=;
        b=LpygMZB0CYGnR34hnf6GawWfoe7dlQAutDDvC+pPiEJAP5MUxXacuiwM0bdMYYfATx
         a0Ihwhug1zxIiDxDj0xq1SS+5L3Cp0hwWCh+1+z0gFZF3vgtHp0P3GsBV+kg/dBZgk3k
         cT0TFUNl07luA9ErjlXpRh61NOhUDVWg2LLaYJW589w7DSUL/WoJhzXJPYXZDJjRu6oM
         iGdja1SLXclKG+52W/tVktKxrf8X8LOFJ9Et3z9lcBxmwnXwhVqKXa+aL46rVJjrKH01
         gIwiqIAbMTLh10TX2kBHuuM6mu27zBjdQxx10Yxpkk2SQ3eopGH5K9c5G3clsRrnB6wY
         997Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774494730; x=1775099530;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vDOAPzrB5C4ZBYqCDQh23MerGG6Hzy4OJS0fb+WkGj4=;
        b=hpjutiN2+XAPN6ostll9ypfWZSzTycqTcY6Qsr09PmwJpyfCr7zgRs6YJ32zx5Waql
         VvG2fS2MZn2AM4HOSbEVw60DYsBu6DeTAdA94SUGhbVinutpy2rIcOrOSEACFP7WIZ74
         Bi5oP/vW//6mbKFN+NRAW/axscnK7ix7e79PMBorccwJm8cDQJD2WI1O3i3R0cz3FRh3
         qmlX+gdxjWXzmTrpNQ/CjajPXUIrr3PHsBRGLrJxmO0XxS/QvsXIMCb1bGgeWZGI1ejb
         jcx84LbLc34VNDV4EgRM9reMabVLMltx4jZMS3mY5W2LOLBYCmQonmXkB5YlFLDzNodh
         roMg==
X-Forwarded-Encrypted: i=1; AJvYcCXVJLmcX5QlQnWbdO8ILyL/XWIU/6nyQC/0X/+HcVMid8tD0AeQJ1okSjJvruVnwzIQL+FSqqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWSW4GSZuFLqmsaKLFG4XjSBrn77Mulbs1h7yEZrJUuzGEI/RB
	QIcwbf2g7qtlyPHGwcomUkGiZMTOIEiNu3wpghOzSBnsbTWhIRSI3VNp
X-Gm-Gg: ATEYQzzHapWWcCLOLEC6owzfsAI1jfnV8Ipr2Z01qlo4tubIBYwOf2+W8qBxYoz0u3D
	hU3PqnzVX6JMIQeCx4I8NY9blV2um5xn+HActBk9CtnXa1mcXRwPB5x1m7OY8i1XBxGjSjWuVa5
	rPNU5My4BerexW3MKtmJoNxy1yEwc01/20DJEPuMslJMy727/mhY6k+oFz91hvG1UYEBWd1PhVr
	p5N6ns/K2wr4f/7YTGeni9fPAfM8sElXa0X/2nlUSV1NoXIJeZq2XOb41dQk+U8HPHnUJ0NXpYg
	xYH2OrcP94i6Z5sxLEFJQOKSjjIwdhhV+9nZMtOYTgJlmXuTS4lBOtJN2BB1Oum62c5u3wGFALG
	dRvD14gH6xrvPxKXjaqCqpk6IMDdVjY9cK3n3ApefWGm61OihFITWKM1z0HLPu1zzBozGzIfNTB
	AzqaQpPYewgRl+kb/WLUoF8aV4RVKkhVLEahrlo9AGaPvWAJJPemZ0pQ0VpM4yBwC/r9I0J2tzY
	00W
X-Received: by 2002:a05:690e:d0a:b0:64e:e0fc:a318 with SMTP id 956f58d0204a3-64ee6179f16mr5992798d50.66.1774494729710;
        Wed, 25 Mar 2026 20:12:09 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64ef6c36b73sm899042d50.19.2026.03.25.20.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 20:12:09 -0700 (PDT)
Date: Wed, 25 Mar 2026 23:12:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Guoyu Su <yss2813483011xxl@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 netdev@vger.kernel.org, 
 horms@kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com, 
 syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Message-ID: <willemdebruijn.kernel.1a9f35039caab@gmail.com>
In-Reply-To: <CAMa1Pe7Pn5+TTnsnX3yQD02sf1JiuYfnxt3==jCSeWB44rJs+w@mail.gmail.com>
References: <willemdebruijn.kernel.c0bb5d182993@gmail.com>
 <20260320141459.9691-1-yss2813483011xxl@gmail.com>
 <willemdebruijn.kernel.2018fae77325e@gmail.com>
 <willemdebruijn.kernel.2497131610e6a@gmail.com>
 <CAMa1Pe4sxiyekrMKV6w5E3SJ1sk1ZzJs7wdepx6oLKGpRsi35A@mail.gmail.com>
 <willemdebruijn.kernel.5c56580eb49@gmail.com>
 <CAMa1Pe5XGeyk4rf7rX+4FjwPzUhxdKEw5Qsi2GwkeOMr6fw6Jg@mail.gmail.com>
 <willemdebruijn.kernel.35a7766bac9d6@gmail.com>
 <CAMa1Pe7Pn5+TTnsnX3yQD02sf1JiuYfnxt3==jCSeWB44rJs+w@mail.gmail.com>
Subject: Re: [PATCH net v5] net: use skb_header_pointer() only for DODGY TCPv4
 GSO skbs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271814-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 56E2B32EA3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Guoyu Su wrote:
> > Perhaps you're running a different repro from the one I used. Which is
> > the C repro from the run at commit ca4ee40bf13d.

Thanks for verifying.

> I reran with the exact ReproC from that run:
> https://syzkaller.appspot.com/text?tag=ReproC&x=10e3fe5a580000
> (commit ca4ee40bf13d), rebuilt locally, and reran.
> 
> > I see that the virtio_net_hdr has hdr_len 106 and csum_start 88.
> > Those are fine. Same for your repro?
> 
> Yes, same in my run as well:
> vnet_hlen=106, vnet_csum_start=88 (first 20 dumps are consistent).
> 
> > The question is how skb->network_header can be greater than
> > skb->transport_header right after virtio_net_hdr_to_skb.
> 
> From my instrumentation on the same skb in packet_snd():
> - packet_parse_headers() sets netoff from device L2 layout:
>   hard_hlen=172 on ip6gretap0, so netoff=172.

I don't see this, but hard coding it gets the same issue.

More importantly, I took a closer look at a fix.

Unfortunately skb_network_offset cannot be trusted for link layers
with variable length headers. With SOCK_RAW it is the worst case
hard_header_length. PF_PACKET is network layer agnostic, and with
SOCK_RAW on variable length link layer packets, nothing communicates
this.

So, a straightforward check like this may have false positives where
a valid packet is shorter than this worst case estimation of network
offset.

	@@ -103,7 +103,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,

			if (!skb_partial_csum_set(skb, start, off))
				return -EINVAL;
	-               if (skb_transport_offset(skb) < nh_min_len)
	+               if (skb_transport_offset(skb) < skb_network_offset(skb) + nh_min_len)

As a result, I don't see any test we can do at this point that will
not have false positives.

Only for GSO packets is there downstream code that requires the network header
and that assumes this header starts at skb->network_header. __skb_gso_segment
calls skb_reset_mac_len(skb) and parses the headers in skb_mac_gso_segment and
skb_network_protocol robustly using skb_header_pointer and pskb_may_pull.

We can at this entry point anticipate reaching that code and add an
extra branch if gso_type. But might as well just make robust the one access in
the GSO path that is not yet.

So in short your original approach is probably preferable.

Please do add a Link: to this thread.

And one more thing: skb_header_pointer already takes the fast path of
just returning the offset if within linear. No need to special case
the DODGY vs non-DODGY path.


~                                                                                                                                               
~                                                                                                                                               
~                                                                                                                                               
~                                                                                                                                               
~                                                                                                                                               

