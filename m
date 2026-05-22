Return-Path: <netdev+bounces-290848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK3vAhRnEGpJXAYAu9opvQ
	(envelope-from <netdev+bounces-290848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:24:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC105B6167
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D537630C6BE5
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF7841B366;
	Fri, 22 May 2026 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQnIRaxE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8204840FDA0
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457178; cv=none; b=kD5HbvBeXqJ4vH49cHO8dXE7ds9IXuKQk0BD1+J1zQ/c2RQ6HcjKtMJtwaNpHClOoLiGzvvMkHbs4q4Gy7ltw0Rm0wab8Q8wIGnhhEfQ9o6749pHFQ9RmOhn90qh2Dk5R/5wCsJB364nTEXbrBEosLBsO9Rod+hzjC4W6G6GtrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457178; c=relaxed/simple;
	bh=jDeN2QBMl7BMOZROrFun6LhTmnGtFP6y8AFygNKYfL4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JRvveVtV700vGOqTJ31XBEwDfvs11M6LYkHptIbZjSnt4Ad/32poNNx3pZXrQ6OyhBhKMXJ/7KCIOp5C3FyXjm5aiOM/J8oqpHIuCDqDA0HMwtEsjaUNJeNvJ3Px6qsz0vO8rb9/8lsuBxx0ndnz8Ib4r2UlagvZ1m5EZpTpEv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sQnIRaxE; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7c0de780bf1so62897097b3.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 06:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779457175; x=1780061975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FlGOyjgzpwLj70dY2yF6Meo00osZD3FjwZeaTgq4XE=;
        b=sQnIRaxEHl3bpJVceOG2ILeREZJPCxTCmABuDk6pqPZ9agpWkmGVaEN2Bp3vqnyTqH
         CbjYscADpbO7k7EyhgXFOk3bMkxpHP7o1f3NYQgIk0wJL1hXtJs9QL2m8Ud9eAVs7jmo
         7ou3J/07WKtekKgg1GA2V7m3n1chxZDr/4YZj8knHSM0AHxuLsxeUe8WgeJhRDGnni7b
         X7CXdO4l6bMQY1PPHPGdvXNXCKKSekHRkDY8rjeQqxXDboMApsh07eD44I0VZ5kM6KfN
         Vkjqy3bquDKIuK+0aLa0IE1H9kXjFg5d5HrSu+kRUUyj7K1IU8Ja5HRrmYJwj4WwoG+8
         FpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779457175; x=1780061975;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FlGOyjgzpwLj70dY2yF6Meo00osZD3FjwZeaTgq4XE=;
        b=bHOT4m4GotaCBbc5/Qe9cADq9RD32hRqpcJ/MO6SzGxhlq9v2xSdHl9xvLk2a8Nhq3
         1cONhIcROX4kTcOy8oR/PpHiY2DW5JrkQ/ciMtSmcHRYKZarNddVK/b0Spn5MQ7PdX+U
         pMmyAba+aYxo5auFdZltNOl7Q2yY1JGaeM42Vbl2kOt3y9Ci0mIEFTJSqV/mp+Ic4DYy
         qdjN05E315ZT7r0HoNVj2+e8yNeaCLlJ2lHMut/jwr9xpD1dcMZ1lXyr1icLLvBfIn6o
         GIZquYhVtyYkClN2Gx51qBsBf1IjrH63mLA9ZEQzNseFkqeN30ngW8DfKKPJisDO6Dot
         gl2g==
X-Forwarded-Encrypted: i=1; AFNElJ/vGd4KahEO3rNoc3KcBEws+yrkwfwWCCRDL7nRDDX4E+wJ7Fvl3ct3Mcme59nkmBWzuj8TWUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxftr/Zu2VdsjxYqplK+ZLZdRhtnq8rRdVsFzYp2l5I5kN8Qeu5
	EwGIdQ3ZTYQ0QrcDRqTLgqMbnRX480sVtk/YVkULrMvvK/Ol6WZTWmn3
X-Gm-Gg: Acq92OG1wrnP4DoWh1yLCzh9qm/Zg8hjUVrXjRqkSRS8bgEO0IEMifXClUGl+Cxbms6
	JPY6pi0R52VKKhEi0shP44/UWGC/HBW0SlvBeTSqtrFjyulaPuaNx8Ut3q3S7q6OI2aHKOZqKdA
	qXNm5EBssERV+zmy+dRRYvyqFIuYUdw1I0jdqIIWkFRqYv3ZPzBMHgob+rCoz0iebTbclvOQ+gV
	z2dYNtsS+/w2oTHtfjb75H5z2JrkY8Z31JdLLNVhRBCr5yXPjjvC1/0TTYjQSnpB05kQfLKwmBz
	qfvF7ftzAFHOOYH/Se6qa0+pVxDBHVHLoxLxml/yDCMaixZkJDE0bMmgC4Qwz3sSaDR6hIBT7d7
	hnNgkBV0VYkHqyXYLRfQqJsuHQmBLSIa3oqW3YHU6+9v58uFVdnF5rGAN0pNGdWMvfb9plXDzwA
	jQgkcwK/dVsoCg+NkECwv1PXmpCQOpeaYFOkWEvLBeSE1tq1FADyoBVyWPdY4Vjdk5F8wIgvmCq
	5POL24=
X-Received: by 2002:a05:690c:9a03:b0:7a3:7ad3:3e9e with SMTP id 00721157ae682-7d33a256b12mr40259867b3.32.1779457175239;
        Fri, 22 May 2026 06:39:35 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38bf2f84esm8032277b3.31.2026.05.22.06.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 06:39:34 -0700 (PDT)
Date: Fri, 22 May 2026 09:39:34 -0400
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
Message-ID: <willemdebruijn.kernel.85f251a8258@gmail.com>
In-Reply-To: <20260520160020.375349-2-bestswngs@gmail.com>
References: <20260520160020.375349-2-bestswngs@gmail.com>
Subject: Re: [PATCH net] tun: free page on short-frame rejection in
 tun_xdp_one()
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org,google.com,oracle.com,asu.edu,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290848-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.261];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 2DC105B6167
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Weiming Shi wrote:
> tun_xdp_one() returns -EINVAL on a frame shorter than ETH_HLEN without
> freeing the page that vhost_net_build_xdp() allocated for it.
> tun_sendmsg() discards that -EINVAL and still returns total_len, so
> vhost_tx_batch() takes the success path and never frees the page; each
> short frame in a batch leaks one page-frag chunk.
> 
> A local process that can open /dev/net/tun and /dev/vhost-net can hit
> this path: it attaches a tun/tap device as the vhost-net backend and
> feeds TX descriptors whose length minus the virtio-net header is below
> ETH_HLEN. Each kick leaks the page-frag chunks for that batch, and a
> tight submission loop exhausts host memory and triggers an OOM panic.
> Free the page before returning -EINVAL, matching the XDP-program error
> path in the same function.
> 
> Fixes: 049584807f1d ("tun: add missing verification for short frame")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>


