Return-Path: <netdev+bounces-276655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEDtAkyL1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:07:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 677103BF462
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B0D630567B7
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 17:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5FB3D3487;
	Wed,  8 Apr 2026 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTlH5UDy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C2935C1B2
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667763; cv=none; b=CMY3uWBiK4NGlFE19q2YxP4AhQs6bliLw19YQh6dsvosYR/lxe1c+42hzkhA3wD1ZttFrcRMrpUMXerJDKQPTU5Tn+hIuZvHxnEn2sKp0EjeeYIWw17cTtwRj1htwKElActjQIIRffPnAfU7ikjF2toUVzIsPRsmzr60b8rFcAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667763; c=relaxed/simple;
	bh=xdLLVMMQT69JFQt1brGOUFUC5V03wHdBk5qEpoTRbKc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQz7MxQfpnHgkwCJh9pLvt5DDiPtSNwH3Q37E3jyB0xg4EO+FggzqSCXHTMoBYddRxFpirhCN+enyNV3JCIfXyiaRcnI1E5XywmC0Ycps8TPOdoVpdIpGa3gRPkN6F/tsy/CqcEYkyCV7Lqimm/XAxW1R21Klvy5xtZQzNh1+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTlH5UDy; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7dbb6c072f1so30914a34.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 10:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775667760; x=1776272560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMpI3o2mUCKoqrF6VB4ezds9Ya6pdU2HqjJAbgYriXQ=;
        b=FTlH5UDyfbxYhlBp0sxVrDv0sG4vY5BIN6h9qqoMbtEi4tRFnnWTQrBZZa6YrddcAQ
         N2auK8zv7t1LFG9mz9La7e+sWR5ZZq8gKlkXFRCs6ayikUL2uulDxGelJma7MaeM4Ymz
         bHtxfv+PRJ2aEqrZKgSro5IJ5EAVFLZiMWRks+cf5Hc0rkCwm8cpgQKEGmVwPvlXwwTw
         /NNJMcmftJpy06QCEeZ/2o+moBQfiJ+o4MxjvVkSQQmP2JBHR7C88wrGrU3VxHTrd7Lq
         ieuA3XanTNPPRm9iiosJAoVZXRBVQuRziCZVgCCQs/I7BnpiqTc1Utj/ZY9Czt/JY+KA
         PpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775667760; x=1776272560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMpI3o2mUCKoqrF6VB4ezds9Ya6pdU2HqjJAbgYriXQ=;
        b=eY4t5LiE2u896yEdXYDPFtO/G4vOwQqEmypOtYncGKMVOHbDEDSAH+0keJF2qPM5xm
         5Ey7vzC9YOglHAeW2xam9G2Dr3bAdGbGlWZetWYNlVwl4TSslwYRVLPMMsSP1Fxha9et
         V0g06CzHaOKXYz5Mud5fEI/wp5YDvXAejNCpu11jCr9rBrdO6YwnG9uvC2KMavVx9LhF
         sCuTWmGfa5MKNEOMdsv89xDk9rfwGUtN7XHEs/UeOPkNeST40yiQEVy1s9Dc+eJgnMaL
         QbV11/oFdnc/J0cEqPpKg62k4RytjaNUjEDYAiU7S5rlQLb3OoYO1kKvpuJxe7IEzSyR
         o9gw==
X-Forwarded-Encrypted: i=1; AJvYcCXwiD08N7CFV1wi8KUh6geh7fDJhZSIepdVQ8Ux8MV8J8gf6ZCs0SpzsHUjBArV9iHnUBXmvTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6l5NukIZQpWKSfjnkETg5a3OTCs7Srh57Il8OGuo9FNQ3+FHd
	81ZJiQB79R7VyKkLsPQHKwManwHMxnlQTR6/uEW+IX37XZ1yEkFwdcmH
X-Gm-Gg: AeBDiet63uwH27vluuu8E6D+6ECQkXgzGZWqVD20fQVcjT0CiBYdjw1r9UPD0L6HNQf
	o8vaWqg3onceTvhDL2Q/Gq0x+AQFtJ9wAozrZoNj2YXUP+9h4Lee2z1j+boWtE9FzjC/seL4zP0
	J6PXf4W3UX8UwYdMTb+jg4FWTRse6QuF1uqCHkFfNscp8/WfYWlQnuqlHaGMuBLRcy4aJ5K/jn+
	ieJV2/nVTHtPKKSx1/GyzGmiA55xN5wldpF9BM9siwA7Jxxtpg9pf03ihVPG6rdLJ3jDOUu0nP6
	Kl7qhfxfw1omeqzZjsIkaWpgBrfpVd2p3rdv4RlPl9tFyZ56FyBGB0WCsl7fpG9VgBhrMjLRg0+
	1Fuq0xQQuVASI9INxxn/7/55kbIhzXcMsMOjMUA6qBuUCwLbCi5zUiwaXkT02N0cUejNo2vXiiy
	vQ3Nyxk1Fgi4E3YIX1
X-Received: by 2002:a05:6830:6103:b0:7d9:e9a7:cfaa with SMTP id 46e09a7af769-7dbb712a3a2mr14340529a34.15.1775667757936;
        Wed, 08 Apr 2026 10:02:37 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:3::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba73d8126sm14465822a34.27.2026.04.08.10.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 10:02:37 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Wed, 8 Apr 2026 10:02:36 -0700
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, metze@samba.org, 
	axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>, io-uring@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 0/4] net: move .getsockopt away from __user
 buffers
Message-ID: <adaJqy6Q4L7c-eTs@devvm17672.vll0.facebook.com>
References: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276655-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm17672.vll0.facebook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 677103BF462
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/08, Breno Leitao wrote:
> Currently, the .getsockopt callback requires __user pointers:
> 
>   int (*getsockopt)(struct socket *sock, int level,
>                     int optname, char __user *optval, int __user *optlen);
> 
> This prevents kernel callers (io_uring, BPF) from using getsockopt on
> levels other than SOL_SOCKET, since they pass kernel pointers.
> 
> Following Linus' suggestion [0], this series introduces sockopt_t, a
> type-safe wrapper around iov_iter, and a getsockopt_iter callback that
> works with both user and kernel buffers. AF_PACKET and CAN raw are
> converted as initial users, with selftests covering the trickiest
> conversion patterns.
> 
> [0] https://lore.kernel.org/all/CAHk-=whmzrO-BMU=uSVXbuoLi-3tJsO=0kHj1BCPBE3F2kVhTA@mail.gmail.com/
> 
> Updates from v2 to v3:
> 
> * Use two iov in sockopt_t instead of a single one:
>   a) .iter_in that is populated by the caller and will be read-only in
>   the protocols callback.
> 
>   b) .iter_out will be populated by the protocol and it will be sent
>   back to the caller.
> 
>   - This will avoid changing the protocol reset and changing the data
>     source at the callback, making the driver callback implementation
>     and converstion saner.
> 
> * created sockptr_to_sockopt() to convert sockptr to sockopt, making the
>   call to getsockopt_iter straight-forward
> 
> Link: https://lore.kernel.org/all/CAHk-=whmzrO-BMU=uSVXbuoLi-3tJsO=0kHj1BCPBE3F2kVhTA@mail.gmail.com/ [0]
> ---
> Changes in v3:
> - Create Two iov in sockopt_t instead of a single one (Stanislav Fomichev)
> - Implement the sockptr_to_sockopt() helper (Stanislav Fomichev)
> - Link to v2: https://patch.msgid.link/20260401-getsockopt-v2-0-611df6771aff@debian.org
> 
> Changes in v2:
> - Restore optlen even on error path (getsockopt_iter fails)
> - Move af_packet.c and can instead of netlink (given these are the most
>   complicate ones).
> - Link to v1: https://patch.msgid.link/20260130-getsockopt-v1-0-9154fcff6f95@debian.org

LGTM! Not sure what's your plan for the selftest? You wanna keep it
outside or maybe repost v4 with it?

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

I'm also not sure your unconditional 'copy-optlen-back' will work for every
proto, but I think we can put something into sockopt_t to make it avoid
the copy if needed in the future.

