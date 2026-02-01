Return-Path: <netdev+bounces-255674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dqLdE9++f2l9xAIAu9opvQ
	(envelope-from <netdev+bounces-255674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 22:00:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FC0C73A8
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 22:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F37323000FF5
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 21:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E382D839F;
	Sun,  1 Feb 2026 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBzbZMnI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D642D948A
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769979611; cv=none; b=asjUvr1r5Q/GaEAyLUEHjLe14Rc2Vp31Ha/yl6GCoUy2awqixydnHB/c2u2FXhTJCdbaic02Y3H/FHEQK5IGG6RR0oCvnhfoaEaa2F/y7VHcozy52LlM+q4QlHkzyeNfwKyx5L/w2M3WEbe58Uar4FgJsFCqyGEYQpCiGxxKXtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769979611; c=relaxed/simple;
	bh=AogniDSenuhKHGa0cFSla2/PdbM2zPi3vyokWKYGcDc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=g6+izyYrmQMOskkb+pRFjmFBVO5dcZvDglAYZgeCpBAEqmGDdad0tB4/s8zVkg4nKBm5Wjbug0Dlz3IdjPCWk1BK8e3IKm5wDwv4thhf+fLfXWvvi2v72NvdAm80ypp3SlJg1xmWYC0IwEwFL+roBNYHqmgmgHKZIudG77dbX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBzbZMnI; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-794c2db2ee5so8114257b3.2
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 13:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769979609; x=1770584409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrM4NX39l+4X3I0Jzz5a+t2W5kTMBNHHRvTlPtw0XBk=;
        b=gBzbZMnI02S1ghQ8QZKNhdHSnzOXrIHHscxax4BenHUZRN5qJXh8MAXnwO3uDsMuDg
         oAsgBzRjysFr8DB4DOzO8ZnbiKU0wqQsqelJLa7/LuWbWJQzruSGxkN7Y0lq4QMeJFo5
         zTxDSn0i92uYJAxZpFgJDO/5pogpdmO5isH6sd20/t7KEGR8/3nNuY6GE6RbxJDzNNXT
         vd19fzGbPjHraASOCLgUNLZk10R6MOxwU/5sfv71jtugv7WLyrL+Wpfx/+VzkuYTeexr
         L6D1n7qoFr21XLFwX02eRRt3hRrbLQpbB+Pvq2cBRvFpsunfUccmDIKwAyGmuSL1/cw6
         dxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769979609; x=1770584409;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JrM4NX39l+4X3I0Jzz5a+t2W5kTMBNHHRvTlPtw0XBk=;
        b=K1z4SEj448zACnFtRlkL76zaeTZTkC0CyPbEIJyxvkECDa6bEc4iFaw/Lvp14voPUV
         QxozZSBft2mD/0CKvnlrb9n1nb+7I3Wa8FI5+JrRz0xquZrNbk5SeegxzGBwanGy4/7i
         j81UafzGIJ7U3wVO2/jyIN3Zu38N74IQjJw2lnWdv9yurVbJYb2OXHRELj8Qh5Ch5u1D
         CBp+5FnHm2ATr27UyEhLfiAT3dwmfujNtktICEGEyt2JOYNtzUfD9yD9cOdqR4nBWFDr
         5LDeJF7OVgSAcnPBXlRbz6EgnNmiRT3i+dsqs+LlVP+JSd/QQffWEE2lNMszdN1XW0aE
         HZPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVTxUSFmNzz6TeixkpQaAmk28KCvt0FUD4acRI7ag9IhZhtYTp55vZiuQdZ66pXOtlVFRfGD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXOBwELjgVk0O8CcGTHUuKabo/32zo6Zpu6uRiLKhJJYR/0wVJ
	FeLyjOKn2QxrODnni1d3RLeDCYjP8d+ClMCKy/SvleQf7ZJUdvQy9sMq
X-Gm-Gg: AZuq6aLNOh3BARQVGXTtqTE0AXRlI0ME1sRJEW4qzeh1Yj7GgUkTHvZSqKUhl/fvBqi
	2egHAb4tDyrie3uYK54nJXyASYZtb2bx1/BCN70PObuD9mJ31x1wrGKQTNjGLOpLSuksKi5x8QJ
	oedLK1ScikvsBLZhFgu9N7vLC1QjgnaMrlWYIFTZ3cgJyHk2w/VfOl2VGncOjHh2K71tCJ+nPzk
	xlaXSCrokmYjB7BrycmeR7ZsT09YB/I8/rI4OQTBKJKQ9pXZHki3Jq9URa5D/tYjY3SVOJRBws3
	Jkr/CoGk3o0OlH0SeuofsQBczOL0UDmx8lJYV1PW/f7T7NzM3CPG5i6wgqzJwW0oDH8OR9rAih4
	xehuI0X9EmjxSFt8FGMcdM6r1ASMIaYGEFbK774dRlTzXIrzfX/+oLLsAKIbW8sr5JIDFsyJFig
	pOZAdxTdExfA5vftxGdjKQjObmcTJ3rmKujvdA3E1YhbbyHFtz408B1caq4+k=
X-Received: by 2002:a05:690c:34c3:b0:794:cb5b:89f4 with SMTP id 00721157ae682-794cb5ba215mr18826067b3.41.1769979608674;
        Sun, 01 Feb 2026 13:00:08 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794d7cceafdsm4958417b3.15.2026.02.01.13.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 13:00:07 -0800 (PST)
Date: Sun, 01 Feb 2026 16:00:07 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Message-ID: <willemdebruijn.kernel.279585f37ad8@gmail.com>
In-Reply-To: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
Subject: Re: [PATCH RFC v2 0/2] virtio-net: add flow filter for receive
 timestamps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255674-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[pengutronix.de,redhat.com,linux.alibaba.com,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3FC0C73A8
X-Rspamd-Action: no action

Steffen Trumtrar wrote:
> This series tries to pick up the work on the virtio-net timestamping
> feature from Willem de Bruijn.
> 
> Original series
>     Message-Id: 20210208185558.995292-1-willemdebruijn.kernel@gmail.com
>     Subject: [PATCH RFC v2 0/4] virtio-net: add tx-hash, rx-tstamp,
>     tx-tstamp and tx-time
>     From: Willem de Bruijn <willemb@google.com>
> 
>     RFC for four new features to the virtio network device:
> 
>     1. pass tx flow state to host, for routing + telemetry
>     2. pass rx tstamp to guest, for better RTT estimation
>     3. pass tx tstamp to guest, idem
>     3. pass tx delivery time to host, for accurate pacing
> 
>     All would introduce an extension to the virtio spec.
> 
> The changes in this series are to the driver side. For the changes to qemu see:
>     https://github.com/strumtrar/qemu/tree/v10.2.0/virtio-rx-stamps    
> 
> Currently only virtio-net is supported. Performance was tested with
> pktgen which doesn't show a decrease in transfer speeds.
> 
> As these patches are now mostly different from the initial patchset, I removed
> the Signed-off-bys from Willem, so he mustn't be ashamed of what his work evolved to ;)

Good to see this picked up. I would also still like to see support in
virtio-net for HW timestamps pass-through for virtio-net.

> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
> Changes in v2:
> - rework patches to use flow filter instead of feature flag
> - Link to v1: https://lore.kernel.org/r/20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de
> 
> ---
> Steffen Trumtrar (2):
>       tun: support rx-tstamp
>       virtio-net: support receive timestamp
> 
>  drivers/net/tun.c               |  30 +++++----
>  drivers/net/virtio_net.c        | 136 ++++++++++++++++++++++++++++++++++++----
>  include/uapi/linux/virtio_net.h |   9 +++
>  3 files changed, 151 insertions(+), 24 deletions(-)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20231218-v6-7-topic-virtio-net-ptp-3df023bc4f4d
> 
> Best regards,
> -- 
> Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 



