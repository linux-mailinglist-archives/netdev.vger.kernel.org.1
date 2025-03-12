Return-Path: <netdev+bounces-174295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F21A5E300
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197EB16E275
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF956155A4E;
	Wed, 12 Mar 2025 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkbtMX8g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2FF200CB
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741801603; cv=none; b=Ryb7ZyTra/6BYJl7KHcoHo9xoMRcWFULJSJki9mR1Gr+vAI4N00z7E3u5oeHiPHQO4PTSN68A+tlSsvISQzSznS6apNM2hNfOuLXTJFVikddw7RRKHEaHE8CFXWpp1e6TD+6xGyr9gFHS+phMqptxYQmcubZAn4xPQnbw69RJQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741801603; c=relaxed/simple;
	bh=mO0TeuHXYHIY/u094B9NyOQzbS4Jn23AsmtovLcbC20=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dMc6pzfxAnVdHhD7MMwBy8DHf1KuogAY3/tkoiYEWyMrvzyiDs8upHdQuUf5Vp/GKGIoSKfrKB6UyIqcYAVyM0qOVeFNXFFKTjOI/bWZ3t1QnQuXfZOsM9gJOnbiTwERou6EHfVVMppKUFIf6IT0bpfYo4bNql8VomsPbqM1jTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkbtMX8g; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c55b53a459so1934885a.3
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741801601; x=1742406401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ls/PGYhkhYVjJiF6D8Ypi7RCb/Qg3sfk+aATfYNdAYc=;
        b=QkbtMX8gryVVU0YTfFVD9t7bmt9t2CGSs8X0Ow+1RcZP9E/1NviAUBtIZ2vGpvCGUU
         39b5QmNQzcDs+UggAKWOwtNcaE9GPc70O/gIoSFIC9K1MRyy2O7Lul4LR8t6sPxJT9VS
         czyYx+hbi6CP2/9ZXwhr/Z9eW7qR/dLHV1tBwCJWKpDC9ZYNaxD5x80ArBwnpxesVg2s
         sjlXww2+11J0QmZ/ksODVxq8fCE7nhys1VPobngdHYlf43UaMex4PcBu3GFmzLJzQUHe
         b+VY8r6t9e6Wvp4FVr+CEthVW7W2JqpYScKOGwSGhyK3kiPU24hAmEa1gPz46cVX0BXI
         WbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741801601; x=1742406401;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ls/PGYhkhYVjJiF6D8Ypi7RCb/Qg3sfk+aATfYNdAYc=;
        b=bW5TwdTovIAxb1G0eeOjjtgMXAKV1QDVjhEMmUF4bg4U9P/+WF5ul1LyLkBqWqMuH9
         gsn7bF1OA6lPbEpU6wzzAe6vOOJCzywATmTgx9+WEsRQUu4aZgOOASee/3A1WMlMu0OR
         pKvarQlbMg4Gt4Rm5eTmIu0nql41qtC6gJrSh5HZzkRzkPWvBYi7shbWraRVTd2tkiLV
         h3Qf37Hp0Si1SgWYCn2dbw+qqH+Gt8RaCoKZ0a27zrKwDkFQCPRd4v3BMRVeVZ52WRu2
         hVMZPopUq9BpGWsf0I03vMkeZIOfRR6EYh949Ci4zraG1Du+CtECZqIdZOJOZ+AbWoJp
         dL5A==
X-Forwarded-Encrypted: i=1; AJvYcCVw+bXw1efa4eOBPuJiq/SlGcqfUb2UT4IYcfyYO/eNktTcJIZkXMvRHg1nhIPzCFbebGIfThU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34+ADfgSk2IQgK2IuumxkNEUWY8/7QYB8nhsYKKMxvbGjZViD
	yKsdrixApe6BeiQ0syE4U0Yf4uxyFpgB+jB8bjA5jzhliHuDvHhI63JFPQ==
X-Gm-Gg: ASbGncvgVyPUj+wec/n6ymEhr0sb/06zJomSBtlU6Awq6MAdyI0x/eB7RBnHC8G1p/U
	BLDexgTF0jgDX//A/kZ6edDj425SudoKASfAXHq+4LHUL5dtkCJuPptuY2Cf8ddN42LGy/PARqu
	bNx2qtouTPfGM8yVa5zOHY2ytk9ARNyPoSmOblOEjQDYpbb4QzWiAKZSkz4P3kpNziThMix+qI/
	3BCdNZPUXWiEuPluns0pQ0w2z2T8Lkh3UlHmk/BewYJvv0LwW5hojhoY+aqLTQuhN9roTfSj4Du
	yLnopsSgsa8prNcfkP07OjkXD6BXGjgj8lKZC7suuLxAgUqM4IUpjptWUvxe37KCOdWsVal65lT
	rx6oYZYIlUVPeVYn3O22h4A==
X-Google-Smtp-Source: AGHT+IHNaO/9voibYylvBoRrrAymSK7gUYjvfNVOvMaIMhlf1WRmCk/j0mfeQJSCEhX7r/yqtWrwhQ==
X-Received: by 2002:a05:620a:600d:b0:7c5:4949:23e9 with SMTP id af79cd13be357-7c54949255cmr2447849985a.6.1741801600942;
        Wed, 12 Mar 2025 10:46:40 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476ae289d35sm10991681cf.17.2025.03.12.10.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 10:46:40 -0700 (PDT)
Date: Wed, 12 Mar 2025 13:46:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, 
 kuniyu@amazon.com
Message-ID: <67d1c87fa3783_38d99f29416@willemb.c.googlers.com.notmuch>
In-Reply-To: <4d5c319c4471161829f50cb8436841de81a5edae.1741718157.git.pabeni@redhat.com>
References: <cover.1741718157.git.pabeni@redhat.com>
 <4d5c319c4471161829f50cb8436841de81a5edae.1741718157.git.pabeni@redhat.com>
Subject: Re: [PATCH v4 net-next 1/2] udp_tunnel: create a fastpath GRO lookup.
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
> Most UDP tunnels bind a socket to a local port, with ANY address, no
> peer and no interface index specified.
> Additionally it's quite common to have a single tunnel device per
> namespace.
> 
> Track in each namespace the UDP tunnel socket respecting the above.
> When only a single one is present, store a reference in the netns.
> 
> When such reference is not NULL, UDP tunnel GRO lookup just need to
> match the incoming packet destination port vs the socket local port.
> 
> The tunnel socket never sets the reuse[port] flag[s]. When bound to no
> address and interface, no other socket can exist in the same netns
> matching the specified local port.
> 
> Matching packets with non-local destination addresses will be
> aggregated, and eventually segmented as needed - no behavior changes
> intended.
> 
> Note that the UDP tunnel socket reference is stored into struct
> netns_ipv4 for both IPv4 and IPv6 tunnels. That is intentional to keep
> all the fastpath-related netns fields in the same struct and allow
> cacheline-based optimization. Currently both the IPv4 and IPv6 socket
> pointer share the same cacheline as the `udp_table` field.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

