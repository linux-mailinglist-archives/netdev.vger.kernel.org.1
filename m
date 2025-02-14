Return-Path: <netdev+bounces-166594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A84A36852
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CE51891824
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1A71DE2B4;
	Fri, 14 Feb 2025 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVGObGSW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57571519B5
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572452; cv=none; b=fLjF118cpwdEVFpqz5ZRrEfSwcJ5HyTaWWrAlz7B42KZieSmbR+xxmcOUWmg6IKtJD1W+zSumNo3I+JLGEd8dJzymcAggYeWA+HUGEKdWoLOryEWtU14KcDsB3+Q/HkUhXxZyD2oYXSaFbT/0/QyzWdBMd1IToCtf0NfEI9yV7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572452; c=relaxed/simple;
	bh=gL3pWhhvq+7UMT9jloSSQ7iID6QDaDI+kDnKTXS4B1c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FFMm7p9nwMyn2TRfbQHWs7fxKJCU5vjJcauUvoic77i+eAGQujUv8HgowjIvTUSEvxLYhq4sEYdB1lZHsCfMxrBKJq0hl3uLnGkoAfF8Vp9BWhwUJ5ubxYd9GXYyyDMMq9UCdfVeUYbuK+kh8K8P9tJus9Jp9VkMEgRh3Wthnqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVGObGSW; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46fa764aac2so19869481cf.1
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739572449; x=1740177249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUVIqKJC4cWeVOX67GEtVoZzbFmUJ2psRu4W/JvBgSo=;
        b=KVGObGSWQ0iMCZzFI36uCIWgrXw7JD1+GGDQFAH+Ya3DR3JZLLah9ZBw+i+MgAMBL4
         r8duCGPzpj/0qo17fkDEaad557Zp8FlWY225u+0AMFK5iROjdOb2tjwd8xWcGFKqU3Vw
         Qne6AfAT9BwCmqCl7Uk00hH7q/jbnvTWKbqCkYi73yKVvzRG6KKd89OnOIC2Kq251fIq
         gN9jS8O63Grx9BqU6tNL9v19TXXZNTdeFHeiBt69QQuuKzmZZvT7FXLBuFyvbKfpa7mC
         HcvqXtsSoctOSZYR0eg2JF/xv2qM2mXbnFPZplrMie9B7On/Z2ETliEtmXjH1MqWlT5/
         C4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572449; x=1740177249;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jUVIqKJC4cWeVOX67GEtVoZzbFmUJ2psRu4W/JvBgSo=;
        b=TQ0FCMUfi0dGWIACePzhS2CvLk37oE0UEBOaCG6DoCs33z3/5wOm/ACUnKW9d+HQHj
         da2nITiMuJtk4igheSfruc3D1QhLnQn16weQxg2Ah+34opovdD/nmx7zlHwB5c53I/pR
         rJ/gQEB+qlbO1uDZMi3rzlcfhX3InyZl5yUn4WI0L8v1WdjckxcFDPIXPYZubuf318H1
         tyWpQZDNAajlPOjEKMEbP9XsiDapD6n+m5jF7Yoz1en+ps0FhkW6262GnizU8qz80hGc
         68Efr0pv9/KMlBJ/R64/zvsd0R4281BWsUpDAoPLOB/Bd06ghGWUwKDPMhq9wo/FAKyo
         b+sA==
X-Gm-Message-State: AOJu0YyHFNnROrFJ6n2/2ICrKqFz0AMJoYgtn+DDk8VBQjjvXGSP5m4P
	CO8KIUJxAPzitsi43NTU48i5oESOeZd6xFjG7cOd/0vQtXj/tbUW
X-Gm-Gg: ASbGncvYUBlk8GBz9H85gQJTk1yyf/w2Z2B6MRejpHmLjfdbZ8d6ntfv8ty3Zb4mGWR
	V6cjwgLT6OfP7UtYntrMq2CXxXEPE2sLT0qbfBPFyP+IML3EfPUaSAFXKNkzuusr4jg+k6Ljcny
	k7tLqvpyygbTDv67EWapGPIXE/srfueHP0UrOJdserY6cM928QNFuoBCnPtKfGY9QOLk7j5mzOl
	3oxOFQEnQNDYgx+LxC2MlqY6b6BmZgV9FrPKJCyponLjaPEgiYx5TVDXKDIfIXVUPGWJVHcjY/t
	1XjhxZKVPQqlGlWhf0KvyD4IEWQ/AgGlIi9/8sVBmrvWJzA/ERVvlienR+W8NYw=
X-Google-Smtp-Source: AGHT+IELxaFoKGl7DnNzF74/C+6jhz0wFtbQlwREXwGQ55JAM8LpFMiNXsezI6EtfaovDehmLjnkHg==
X-Received: by 2002:ac8:7f50:0:b0:471:bdf8:4b55 with SMTP id d75a77b69052e-471dbcc20famr14739391cf.6.1739572448701;
        Fri, 14 Feb 2025 14:34:08 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2a12b5bsm22437991cf.20.2025.02.14.14.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:34:08 -0800 (PST)
Date: Fri, 14 Feb 2025 17:34:07 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 horms@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <67afc4dfb448f_30f1c129439@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250214130629.00a35961@kernel.org>
References: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
 <20250214130629.00a35961@kernel.org>
Subject: Re: [PATCH net-next v2 0/7] net: deduplicate cookie logic
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Tue, 11 Feb 2025 21:09:46 -0500 Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > Reuse standard sk, ip and ipv6 cookie init handlers where possible.
> > 
> > Avoid repeated open coding of the same logic.
> > Harmonize feature sets across protocols.
> > Make IPv4 and IPv6 logic more alike.
> > Simplify adding future new fields with a single init point.
> 
> Sorry for noticing late, looks like this doesn't apply cleanly:
> 
> Applying: tcp: only initialize sockcm tsflags field
> Applying: net: initialize mark in sockcm_init
> Applying: ipv4: initialize inet socket cookies with sockcm_init
> Applying: ipv4: remove get_rttos
> Applying: icmp: reflect tos through ip cookie rather than updating inet_sk
> Using index info to reconstruct a base tree...
> M	net/ipv4/icmp.c
> Falling back to patching base and 3-way merge...
> Auto-merging net/ipv4/icmp.c
> Applying: ipv6: replace ipcm6_init calls with ipcm6_init_sk
> Applying: ipv6: initialize inet socket cookies with sockcm_init
> 
> So CI didn't consume it..
> 
> Could you rebase & repost?

Done. Sorry about that. Not sure what went wrong. I had v2 on top of
netdev-nn/main as of Feb 11, commit ae9b3c0e79bc ("Merge branch
'tcp-allow-to-reduce-max-rto'").

Now rebased on top of current head at commit 412723d54a8b ("Merge
branch 'net-phylink-xpcs-stmmac-support-pcs-eee-configuration'").

Good point that I could have noticed that something was up by looking
at the CI. Will keep that in mind.


