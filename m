Return-Path: <netdev+bounces-96630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 107908C6BCA
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 20:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67CC41F2231C
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 18:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6D3158DA8;
	Wed, 15 May 2024 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7zccS/m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22680158845
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715796183; cv=none; b=T29wyafr/GeOEHnqsdgYuTOikhQxPWYBzaWWLMf2P8/UdJUc1Y3nmTGn+K4f4Q3lsUbqJgQMO29bbsxBJiJbxBkJ03Uyy1OvaLuT7i6KqmK4cHsmXRhce8zqGRaqd0rstD35GGv66IpgyIfW40Ek4jl5KBafzU5Sut1hFKIy1ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715796183; c=relaxed/simple;
	bh=nMe501itZ9RkoProq+XswsdwyrkwdFsJjgljJsGx50Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BKVaq5XFJAA/+eKhB7L3NO32mkF1pi8I3z1g1ul51llCXG0kjM2xoquRVRu4uQ9QRZ5L2IplwDU6XCit11wzLNX2rbBRmHLXr0YvHDKDhTUQ7xoJmffmW2nN2aEaJeMIk1HCV0IfPiMZqEKKvN1K92W7rtISYZKMHYspEWlANos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7zccS/m; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5aa20adda1dso4291383eaf.1
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 11:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715796180; x=1716400980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=548GZ8fvbJBOcURBG1dj0W9ko8NQDg9Ri36sws+QiC0=;
        b=j7zccS/mpl73VmPBUDZ/2woVVhnwLpr2lARIU9cwKPCwgETEnVTf45VLhCx60w7xa5
         81fA0KVVRTRFId5nVONFmBdsPA6oOtEc/SAamO5/+Jb5bHl95XvII63k+uuA/pJMU5d8
         SWlAkB7dTSh4Irby/8LCABakJLMEZEdeOGGBc+AiJRf2RutRjxyeC1MOEh/s/5JVFwIG
         JOjdVJgumfXe7JWio63qPJqvr7CW7tpSltMAAL8Rjm8ZFa1LgYe7bdZAiqujS6wfRPp0
         PQl7Vl9/Rex3yq42xVfD0Urx9TvSplRZr7po4LOkCMKnPPMQeTfSfvQlx5TJW7wbKmsw
         e0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715796180; x=1716400980;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=548GZ8fvbJBOcURBG1dj0W9ko8NQDg9Ri36sws+QiC0=;
        b=BgYTBbOOHRgPzfFoJV1tbIQAd/LLOI4jnJVyExNrsq2uhfLKKmfHVej/x5YXSRKxwQ
         qB0PZD9iQea2n6PGY3lZ0n+bGiJnN0JExNHLgyrtE1l6XrDTrF7EmIjfSFuzxMCaKFSX
         RfUxus2dfn1+OG2o9Ci37I4fnqzyrEAad3Gve7Vxc65wlBP9+/Fa4YqQEZvnXTKJ9cit
         19bOYgYGpK6EQnw6iOQFQ1sO1EjFGqa4Ub+YyM13daviiUIraHvZ22aTH3uOicInc0xu
         8JzEbeuJUqx+j60cW985wvm6/CSHHuhN7OmbJ+JL7Ud3xxD8nQf27Eyp2oPTUd9Olklg
         98BQ==
X-Gm-Message-State: AOJu0YyA+cyYHYlKNG9V8fXLRs8X3w9AST4xw/eT7pT4R1k5py4xsPzW
	JcATuoNXG49Dp2ok/BiWxPjh8bkmMjG33pyIV+sVWMTK4t4/+hqj
X-Google-Smtp-Source: AGHT+IENfKu9FA0C7GeCj9QBcahyyyjmCb1GRXqDlBNnGgOW/qqKY3xi7RjIQydVIW93SSXWPypdsw==
X-Received: by 2002:a05:6358:248c:b0:186:102b:777 with SMTP id e5c5f4694b2df-193bb517dbamr1809143155d.10.1715796179903;
        Wed, 15 May 2024 11:02:59 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1857e3sm66276186d6.52.2024.05.15.11.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 11:02:59 -0700 (PDT)
Date: Wed, 15 May 2024 14:02:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 Neil Horman <nhorman@tuxdriver.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <6644f8d33638a_2af87294af@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240515163358.4105915-1-edumazet@google.com>
References: <20240515163358.4105915-1-edumazet@google.com>
Subject: Re: [PATCH net] af_packet: do not call packet_read_pending() from
 tpacket_destruct_skb()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> trafgen performance considerably sank on hosts with many cores
> after the blamed commit.
> 
> packet_read_pending() is very expensive, and calling it
> in af_packet fast path defeats Daniel intent in commit
> b013840810c2 ("packet: use percpu mmap tx frame pending refcount")
> 
> tpacket_destruct_skb() makes room for one packet, we can immediately
> wakeup a producer, no need to completely drain the tx ring.
> 
> Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for transmit to complete in AF_PACKET")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Neil Horman <nhorman@tuxdriver.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks!

