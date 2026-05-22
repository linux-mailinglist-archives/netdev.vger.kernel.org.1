Return-Path: <netdev+bounces-290849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GvGD2JjEGraWwYAu9opvQ
	(envelope-from <netdev+bounces-290849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:08:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 490E55B5DBC
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1976A312B167
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355C242EEAA;
	Fri, 22 May 2026 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZTKx2ex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A02E428822
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457212; cv=none; b=MGS8vnvlxMe1rfbjQwGnlppoymjYnDtQuVULmyEaZJSHJfVaE+Nef4naXbjguYEizoT1Fpxfj5PQUO4HpxIyDsloPvvvqhhCvzkpSt057JHcvCnif3Fsykn3HfvifFDTJ73PKanYDEthjp4k2Dpqe4lxsl6jwIyLA9O9JOgzKpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457212; c=relaxed/simple;
	bh=ErCSwgQgXtBcXou94NTTw1Cmt5/A1R0k3ZRWfKQ8dw0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OzRhDjy44jn70dgYYXBQQk3h0AftG5Ouc1Gc36rmU2nEnjnMXoGHrK5fz+RoN8i8HXS06bRd2atGvX5gonxHSNoyYZCLxq55jUmw1V0ImaOyv3ZKFgCD7hDtBp8QX2sfjnLZqZA1oErvOmFSklFPnTpOCZLLOTPMgRs76m3fyG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZTKx2ex; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7bf0b1a47b1so74855727b3.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779457207; x=1780062007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swBrvw+ex4GMCF0ISIs7kUEUPhpY9o/EJ/ELsD9/dRw=;
        b=QZTKx2exCbXZLk9BCCfXCjBDTg9fziwhBcOpMKt7jEgFH6CF2r7E9kr8FqgBzRpOFA
         JN6oUIZqzOVZe4SzkXDeBMruG+SXrqAIDJfyOLOXcOvbGCNhLo4QiQrTFMW3sfJSpgMM
         /dW6s/82yfyDu4z/ncKZXsKTiWFZD+U4cDo/Z15/8fWorAWGwRmENkkWLnxUhu4LHVxL
         Dw0libzzuv+gNPdopfdA8ITyab+4+3Q84n9AbzCjZhgz09/Bc9WcI06biizpbAtmQHmm
         iG7k70/+CdMqvfgBwJRPEuNQe4FXnH459gLbApzFKMiy6IAlL1a3oUX27Z+6q48e4aVR
         t9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779457207; x=1780062007;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=swBrvw+ex4GMCF0ISIs7kUEUPhpY9o/EJ/ELsD9/dRw=;
        b=nq/l+TKgXY5l8M7pEWnNvsTdNm64I6H+LaMdh2gCdRgkTrJRswfkALCrM+C6zqsGmr
         Neq7g49XPc4UZU2yddF+tSZJXO9cOO1pSEah44Hrd1iU/ZOfZLotFOo9/lTU7UDoPDmn
         /2YucgQ/tECNZ2meReneM2IkmOy0uep2idJYmxLGZH+LZjt/jIo5ludarE57vgQ5t9zo
         4MdvRJJRmmFXZPBh0SSmzTxt3/sp/wvvlFI8j6haEnW9WkFy3iReJ2it0FwHvpgKD2vr
         fBh88K+C0o4EEnVXahQicgZydI9pOUfote2m08VKFan4ih9h42DQ4k1LgwWJdhp+y3aY
         TKgQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mupI/1w/d/erDAAV9+BxPWVXZZQUmijjuNagQSD93bqcg5ZbB8K/Z7Gc5RzV/vyYVD+hH6fE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrzo5YG7wL2BSlEJ4yiZEadfDapa+JCE7h7bAbEqhnn0Cw6RfN
	8NygfgA3gTQr8uhN2eh7qcBaA5TZLn/M1xRojPAc+lEzOWLurXuvjSOk
X-Gm-Gg: Acq92OHL36Pg9ZOuFPE93PFQSOxkQ33HUdoRB/p6OAGp7/NRG3EfB+W2QA5TFakScS0
	EAnS1ZirWeZ/lJwyHiQADjvMinYuOH5SylmULwyMc2OhqxYTR9W0sjhE5midQXRYp/zbElMTUGg
	+nds0EzoKOv19nBq6G/CEGhOXtB2m8JgdURfyvaF0wBlcj9Yin50CmbRtEat56TTPy6iIvpZi9d
	rPFN/t1hFihXULtTLDzzw1zTtoijISVfuTg2DL+E/1fQ9VIgrVLn4tk+uK8wRu4XPw1xCyM0QgO
	TNn944kFWKnm8pun00+ZhgEJZYdVEYx/DIwBwD8NqWY88rvCzWSCzEhNzVKeS1/RcHiBjUL75Qe
	GYN7ptNX5+g5OfCshShFrRjHs1HRnM0IxpWPBVIkfljAexUa3yVqdZIpPPDhp9aSJsgAV9hiwei
	EM7FVi+J+gwYCQrDyZ/p9mZKkDUtc/jV73k6cPZLEW1RwSiia6yl42p07uMiZvTTt3Z0FbprRJZ
	kiNnjs=
X-Received: by 2002:a05:690c:7402:b0:7d0:261a:692 with SMTP id 00721157ae682-7d3368b80bcmr42586287b3.44.1779457206675;
        Fri, 22 May 2026 06:40:06 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c335164sm8173877b3.33.2026.05.22.06.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 06:40:06 -0700 (PDT)
Date: Fri, 22 May 2026 09:40:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 pabeni@redhat.com, 
 kuba@kernel.org, 
 edumazet@google.com, 
 dongli.zhang@oracle.com, 
 xmei5@asu.edu, 
 linux-kernel@vger.kernel.org, 
 Weiming Shi <bestswngs@gmail.com>
Message-ID: <willemdebruijn.kernel.32cb5503b979c@gmail.com>
In-Reply-To: <20260521163312.1479805-2-bestswngs@gmail.com>
References: <20260521163312.1479805-2-bestswngs@gmail.com>
Subject: Re: [PATCH net] tun: free page on build_skb failure in tun_xdp_one()
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org,google.com,oracle.com,asu.edu,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290849-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.259];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 490E55B5DBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Weiming Shi wrote:
> When build_skb() fails in tun_xdp_one(), the function sets ret to
> -ENOMEM and jumps to the out label, which returns without freeing the
> page that vhost_net_build_xdp() allocated for the frame. As with the
> short-frame rejection path, tun_sendmsg() discards the per-buffer error
> and still returns total_len, so vhost_tx_batch() takes the success path
> and never frees the page. Each build_skb() failure in a batch leaks one
> page-frag chunk.
> 
> Free the page before taking the error path, matching the put_page() the
> other error exits of tun_xdp_one() already perform.
> 
> Fixes: 043d222f93ab ("tuntap: accept an array of XDP buffs through sendmsg()")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

