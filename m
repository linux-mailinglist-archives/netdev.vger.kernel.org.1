Return-Path: <netdev+bounces-171648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F06BA4E01A
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003B63B5D72
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99315204C3E;
	Tue,  4 Mar 2025 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJG5nJwK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FBB204C0C
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096882; cv=none; b=cZ/iIWPXQ0doJ5ciqjverTZvX13Tw+Yl+9iRmLjbM3kJNbAPGCu3YhCP2tfZq0WU43Sn06W0M6ccF9n1U0HWlfWu3pqTa4ix7vgfn37hUmI0t5YfjrY+V5PjC1PxFOek2ig9E/z8f+0pN1Fw7Ps6bxz9VuqoXUrTab9mq4xs6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096882; c=relaxed/simple;
	bh=9NQGeMwR5A9/4elkuu9RJ907hf3CjOSJnXsk/XQhrmw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nCTHije26g8jJSgdcs8aEtk+gcw+e0TwkxrIcYMK/Dg/mS01kWXzEkKyLnpW9Z6BH59pgXkydE2aY3SPEBOzHVPY3uFP5ep+gy6HYJxsMRKrCMqAmflQwNZqaLUsVqVLXwRLlxkZDtnKO0jINjRY2jbNJxfk2gyFfnUd3himRE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJG5nJwK; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8a8d6c38fso54160476d6.3
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 06:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741096880; x=1741701680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRqKPWbN6Di6SXasp0m2NK29g0tl4PDm82lImNNtiys=;
        b=DJG5nJwK/wLv+2RdGGO4uHUyl8JGE81/nFwEM4LcjdfoF3GJ6O/8nUcZRyhSvMgEf0
         DOQu5wmUUDkxZm1EC4MwKllfQMMBU6K9QxmM6Mjlbmmq4r7u44QPQwoJyon83QpjkvsI
         0p1Wh3CibGS7utKrBTTdhuriML8Z0J4aHdJxbAtBZsUJhTdTZ5gfXq3PUV3iYqGiPidC
         5WoqslR9WoJyH4ZWTIP7LXEMjUUSG/VPkMUU3ujzoi4ZxBYppTt/Wk7PgU98jcEq09+5
         E1PlsE/WtLaW360UuC5Ygi2dztK1nhkwtTtqrKLoW8OHzpV0V3inssg8aBOvUrjsSJvd
         ww1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741096880; x=1741701680;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iRqKPWbN6Di6SXasp0m2NK29g0tl4PDm82lImNNtiys=;
        b=HOhUGTkXTDi5J7IsYd4NBEDAgim+qlbD8K91Ax2h6soxfEL/7912T5gcMpBBXS4m1V
         MHMZN2KiT5+M4cjatpoBbVdS9AY/R3okjHxoTKcL0t/1BhOLy63hpLqULTe60NaW/Phi
         TQ0LwU+iQqzVYlcpAD6WPAyLSGRcjqBUTO3IVNegAZFhqliMF8E1WgKWpmqDIcZEtkM4
         EMQEXm/xx30Z6ed8KoAFUWV3/lQbjZ/hsM+9z6sDQpgV35RQWqDP9fFzuvKgU1euAQQQ
         sJVvo+UFRbyr84HbHA+fS0MH9mrk7Av6M8X/RnUjEK8ucZFz5oymvtdduqnYJeZMikui
         J5/A==
X-Gm-Message-State: AOJu0YwhptURFKfrYqipuhXoyAADzhSWI0xC2NpypRnSoSRoRyenrS9l
	TEsZJiwKj6b0LTw3SrUjEYUWRVTvTO5z+Uxdp3Ez/3rqmsm/1GBb
X-Gm-Gg: ASbGncs+p2gYjnmvQuc7xhSHKtZNloyZAklBsjbD1ggFZKgxMLYVolgrUVoO6/ZsSLC
	3vcbpOmnz5uYxFtZEe1mgrm8jBP9w/ZLJz39jsRtMk8zAKXoMgYGOKIjx/E8cq4Ragko3NcXGz5
	NeVDMoM+v6wDpwgKAUOuJ88SHKiN+mdpuwTOWAHd2pgdamNPOACeXvP/IhB0S3lxRX6tZA4DAeJ
	96bGJkJvp9cXVVnnsUNbi7Ks4cHr9U+vX5cY4hpkGe0iP93fmbeNmiYiX+pPC+Fuk8ZzmJgPBpQ
	Rdj+uL2NgHU0IMvTs2xffoWvVIIUx88sc4UkFS15uG2ZnXWchH0UptPIXs4nrpD8DkVwFfSe7Us
	SiI852F90eZPgjLAMByTEWw==
X-Google-Smtp-Source: AGHT+IGblZ8q0XFmKg6vnCXT1MjdRtc5Er2+pz0qs7D/vwKFtY2OL4kwN6wDeLTn5p84+sQ0TnJhBQ==
X-Received: by 2002:a05:6214:252b:b0:6dd:d513:6124 with SMTP id 6a1803df08f44-6e8a0d5188emr268062886d6.35.1741096879534;
        Tue, 04 Mar 2025 06:01:19 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976534a3sm66790256d6.39.2025.03.04.06.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:01:18 -0800 (PST)
Date: Tue, 04 Mar 2025 09:01:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 ncardwell@google.com, 
 kuniyu@amazon.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 willemdebruijn.kernel@gmail.com, 
 horms@kernel.org
Cc: netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67c707ae56c92_257ad9294e6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250304004429.71477-1-kerneljasonxing@gmail.com>
References: <20250304004429.71477-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v2] net-timestamp: support TCP GSO case for a few
 missing flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> When I read through the TSO codes, I found out that we probably
> miss initializing the tx_flags of last seg when TSO is turned
> off, which means at the following points no more timestamp
> (for this last one) will be generated. There are three flags
> to be handled in this patch:
> 1. SKBTX_HW_TSTAMP
> 2. SKBTX_BPF
> 3. SKBTX_SCHED_TSTAMP
> Note that SKBTX_BPF[1] was added in 6.14.0-rc2 by commit
> 6b98ec7e882af ("bpf: Add BPF_SOCK_OPS_TSTAMP_SCHED_CB callback")
> and only belongs to net-next branch material for now. The common
> issue of the above three flags can be fixed by this single patch.
> 
> This patch initializes the tx_flags to SKBTX_ANY_TSTAMP like what
> the UDP GSO does to make the newly segmented last skb inherit the
> tx_flags so that requested timestamp will be generated in each
> certain layer, or else that last one has zero value of tx_flags
> which leads to no timestamp at all.
> 
> Fixes: 4ed2d765dfacc ("net-timestamp: TCP timestamping")
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

