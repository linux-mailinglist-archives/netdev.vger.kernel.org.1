Return-Path: <netdev+bounces-94088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBF78BE167
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522AAB22949
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E62F156879;
	Tue,  7 May 2024 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQEY++mB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D98152516;
	Tue,  7 May 2024 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082676; cv=none; b=Q2EqH38nJR2DOmKn7nTnPALKCpxYjpWMyTyMijkoY84BCQCO0g8fYHvfZj1pciD+YZC+OTgwRSHuyh2LLkq0eqy8rBdY0BamVX5krBhzxs2KE4R64qN2u1YYEdyLKVxHT5ADrYZHbJ1vOlPHI8Qi1N535Nn+DXUUpCXwwvEUFL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082676; c=relaxed/simple;
	bh=CGFh7Hfl/d5wAS1SYyKsQcFF/fGKTBBJq3hrEI/nR4o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HAqUFtqO6iWDi63RkQ956C3GnXIqrj/N2DlZi4plIjjX4NJD88HZQaWQHe38ldNUwqJX31RJcmsJj6Uu/28ltEovOku/L9+jAQcCbP4cHHXKC4cOJKVQfanBh47O2N3aaxedZR/SNEnA5HGtCgG67DnXoRhT8OKTXQ/pMM/EHBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQEY++mB; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6a0406438b5so14461636d6.1;
        Tue, 07 May 2024 04:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715082673; x=1715687473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=716kUxhffnrYB5n58jkP05BrEcpnvwydyVRRLnVGoLY=;
        b=aQEY++mBqyjfC26Xg5SLJ8kANL9lbLh2NS4trd8Zt73lr0KZF+xHc5T82pRI4PUj9b
         /MFczmcv9sMTRntOtYyGA27kVlftIX3ddHuDKCCbEEiPfmGHyLywAKC9Lf9qOOkXo4zL
         Kwet7aPackx6QvcXMpkC+j3JZ510ecF9kxcna5ZN1SewTlMJ4MgbSG8w1M2ewb2riG+P
         1KExKMefkOusSU06r3HH1mY3RgZPqsYWEEjvb+F7a8cfiDwjl9cT7mMLWLlMlfjmOMkP
         C9YJ4yeyFoZo+BCTN8MbsAxDQcxeQWCyV39lQPs7ztRSRObiv0RYCrb1KXmaPmhBYwXJ
         wSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715082673; x=1715687473;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=716kUxhffnrYB5n58jkP05BrEcpnvwydyVRRLnVGoLY=;
        b=S8dx0Yu/Ur0ipRuZPogFXv2w5B9lbJcV7uYs/Dfc7Xbh3yQDEJeC6TudKjXmMOyx4F
         p9ACM8c6aruRFn2aYxuJGJ8ZEc46cpAXyv8WHUefoX35igeOZOOmirjYWSPOOunVTyrA
         9kZwbQR60Lb0y6FL8BxcUeFnBYFANX4nMNqHQN/mLBuZYmLSf/AwEso5PanUx2FHQqo9
         J8TmMkxI4cGIitza9A9PPqpD+TFwu/oAsAJjx7G+e6tM4FCBrXPRCXDHeqjDKG5EK+r+
         0lIT52QJQgJIeDboHuYSYMTTb6HVaEF2YAgWGchj0/5FKIP5ULKAsmtTIlI9fcx0qLF9
         pXAg==
X-Forwarded-Encrypted: i=1; AJvYcCXxHR8S2+v2tAALBZO8Dwg8VRzfLJl6amXZsoQjau1h6vML2wzamC9HNIJmq9V7BhuHpCgS2O/lJDm3oo0EtoIB9HHog3QP
X-Gm-Message-State: AOJu0YxSs7F239PJkxyWWjtkeN3a37dghpULligVJJb+6BUsclMtrtmB
	DtqKul4Gk2qBKvpf+01f9AG26Hk6FgBVpHMCd+DFHzWPnQUYBY6Q
X-Google-Smtp-Source: AGHT+IFYOfDiGuprDTED3MyUDLFdpX4VMcTCMmBjOfUnKGh6TJSYm8JtrNUjCr8IExYaoybc/YIVXQ==
X-Received: by 2002:a05:6214:d88:b0:6a0:91f0:ca4d with SMTP id e8-20020a0562140d8800b006a091f0ca4dmr15177913qve.22.1715082673549;
        Tue, 07 May 2024 04:51:13 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id t3-20020a0cea23000000b006a100fa5fb2sm4617184qvp.77.2024.05.07.04.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 04:51:13 -0700 (PDT)
Date: Tue, 07 May 2024 07:51:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Suman Ghosh <sumang@marvell.com>, 
 Felix Fietkau <nbd@nbd.name>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <663a15b153de_726ea29475@willemb.c.googlers.com.notmuch>
In-Reply-To: <SJ0PR18MB521604310B1F7DC297C2870DDBE42@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20240507094114.67716-1-nbd@nbd.name>
 <SJ0PR18MB521604310B1F7DC297C2870DDBE42@SJ0PR18MB5216.namprd18.prod.outlook.com>
Subject: RE: [EXTERNAL] [PATCH net-next] net: add missing check for TCP
 fraglist GRO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Suman Ghosh wrote:
> >----------------------------------------------------------------------
> >It turns out that the existing checks do not guarantee that the skb can be
> >pulled up to the GRO offset. When using the usb r8152 network driver with
> >GRO fraglist, the BUG() in __skb_pull is often triggered.
> >Fix the crash by adding the missing check.
> >
> >Fixes: 8d95dc474f85 ("net: add code for TCP fraglist GRO")

> [Suman] Since this is a fix, this should be pushed to "net".

The referenced patch has only landed in net-next yet.

> >Signed-off-by: Felix Fietkau <nbd@nbd.name>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> >---
> > net/ipv4/tcp_offload.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> >diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c index
> >c90704befd7b..a71d2e623f0c 100644
> >--- a/net/ipv4/tcp_offload.c
> >+++ b/net/ipv4/tcp_offload.c
> >@@ -353,6 +353,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head,
> >struct sk_buff *skb,
> > 		flush |= (__force int)(flags ^ tcp_flag_word(th2));
> > 		flush |= skb->ip_summed != p->ip_summed;
> > 		flush |= skb->csum_level != p->csum_level;
> >+		flush |= !pskb_may_pull(skb, skb_gro_offset(skb));
> > 		flush |= NAPI_GRO_CB(p)->count >= 64;

The same check already exists in udp_gro_receive, which has for longer
been calling skb_gro_receive_list:

       if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
               NAPI_GRO_CB(skb)->flush = 1;
               return NULL;
       }
 
Alternatively it would make sense to deduplicate the check and move it
to skb_gro_receive_list itself, before

        skb_pull(skb, skb_gro_offset(skb));


