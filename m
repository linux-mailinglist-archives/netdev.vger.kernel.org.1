Return-Path: <netdev+bounces-259773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA4nIiLQmGmcMwMAu9opvQ
	(envelope-from <netdev+bounces-259773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:20:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2946016AF78
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A096D301C13B
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781F730DEC1;
	Fri, 20 Feb 2026 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h94blShf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA4946A
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771622426; cv=none; b=J5g3oPEQXpqceg2NZ0prJX9PiGV6yFRPIRbx97p1LR1PyTpFptQpBqxq7+CVIf2X9jTcY1dcJDdrYSCO2SyiOEyOE6tv5NIJPa3IBn4QyX0B+gacvN0NZrHdKMetD66wq5SPcImT9gXrh9XO7ZR4b9bRii9uYDZkGunRqe1a2do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771622426; c=relaxed/simple;
	bh=wAfVMr7+cros2O4xTIRu2T1tZq7KZAAWj8UlxD4QVIk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZeUNSoRrc1ysMXM2hAmW13J+7ix12sPnbDxkhtv2FEljIeiEDGXPFzolM7m1I9/CwZ5gnsrO7zjmaBfGrkF/ZwMzb2Vty/21wjd72LK2/aAIOxRnaEdTQaPI4OYjam7C/PrMDXnCPqOd8Orsc3q1VO6AJZSzgL1O2SI5MyIB4xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h94blShf; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-797a52d8c34so24448517b3.2
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 13:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771622424; x=1772227224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By1Omn0zFXLLgpuF9+9jVLKPXu+GzV7zVAXvuWHoVX8=;
        b=h94blShfOUtrd3xV+xxlUOUtEThB0Jr9MzvpCfXx82UWuT0D+19lb9WYPCMRpos927
         uaijpu6RutPu+MzKlXFU1HHPtsIWazuBnxkd9/TvPmttb8LcWSEqZq9wqvTkRorIx+Ki
         UQbDf5vDd9vPuGmFACK8Io6TpIXRKO/V12lyAZDFGOeg2dGR48UJMwpFHXPMvrRCw1k+
         KEe53i7K4WJHspO2brNJOgR28+eo41xlzH3PaHtDILhQkDXXaFI7GIXY0T18lG3pGvrs
         1IXCbbhG5oKwbKiPvqi0GFNrA0uWclhMGP+jOFhHZAn+be4WLf3zlEuFasVMt6hKXAfV
         VRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771622424; x=1772227224;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=By1Omn0zFXLLgpuF9+9jVLKPXu+GzV7zVAXvuWHoVX8=;
        b=BEvBdIAnybVnNfBwOfHoPJYex28Bvx3AW0YX7L+nJluosYxUnLopc1JP5a9B8sDcV1
         YlcC1tDGZpLKHLFJsIbTxQ1AdI30DxHbg4HAGLYSK7xf4+xE1LLKKmpImR3lxzbmFjwU
         jOYueP7kL7KFf33K3H69qiDQp9HdgctznP3kkNIlVcxkfsA/0KkraanBBYuFuH4KlqJM
         Akm7cUmodcrgxVKrxSbGuWug8Zirhgc0dLRZJfrUjAXHlbrOTDSZ2LKUcgBv+OaMeRKI
         5/xVZtNDy2ibHRt6qYNbu+il2zWkdbCPJu7nkKmkLbGc2MjcW6DvVjRFtNNGghfyFOWa
         eLJA==
X-Forwarded-Encrypted: i=1; AJvYcCVK8/HWLywYbMxcgPMA46XzDEnzBm2udU3/hsH3FKvg1CEOnWNg+dgl5wnIB3ZHv9Mkpla8h3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwcEG/bu75sZPULGsiPAi/UlVFt7utetisb0IheEi/TbbWr5XA
	yI0VcCWxiFTf79hN7uZMdEVOwMjtSMzfUOeP/D+n/MWFuh7rzSHEoDmU
X-Gm-Gg: AZuq6aJptJjga3nN5NJZCOIL7+Sg1cfvpUEk5ebPjbsuYNUYQ41UkapszTYZRNEyL15
	YzNYTzPscEBcMAnuOqR5WhHg1ruz0yVz0BYVOux5UfkXy295uaw0lSAxqv1Qn+tkUcr4LL0v5eL
	42X/gDAbuAfdvCayklieHgseqe2t9bEYZ1ZxueGuNpwu9vYh+fMakmEvJeuppauMV+9PUt3vJtx
	J+lC9hh9DMWuTHnshzEDNjJkt9z+ZDGlMp6PwT9Z/VZUcf4EgR5/2mOLil9xMzqYQf5M8JFtTQ4
	0z10fzpo5NSx0MN8Hj3BVmJ+JwpAkqNcAsTEU5ptIWwvAWMKMQElpmw2ST9fEJYWTaCmez8sCZ1
	y8geA61Nuvh/6FYMpTOZcbEO6w/Mj7BIZijtlE+Cw/EhSDdVAdx1mlRZ/X5lJSRDjoSMwAwFqmB
	F8+Kcpt3mL/4Xgm23F08JKqI+ISAVHRkzyaqTnrHFKzw2x3GAfIPO7hvVGwIyKrtPsD+L8uvE=
X-Received: by 2002:a05:690c:6086:b0:795:1ad3:26be with SMTP id 00721157ae682-79829041d59mr13310737b3.52.1771622424294;
        Fri, 20 Feb 2026 13:20:24 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7982de1a659sm1546707b3.52.2026.02.20.13.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 13:20:23 -0800 (PST)
Date: Fri, 20 Feb 2026 16:20:23 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.aa4c7a437236@gmail.com>
In-Reply-To: <20260220183858.N4ERjFW6@linutronix.de>
References: <20260220183858.N4ERjFW6@linutronix.de>
Subject: Re: [PATCH net v2] net: Drop the lock in skb_may_tx_timestamp()
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,linutronix.de,redhat.com];
	TAGGED_FROM(0.00)[bounces-259773-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 2946016AF78
X-Rspamd-Action: no action

Sebastian Andrzej Siewior wrote:
> skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
> not be taken in IRQ context, only softirq is okay. A few drivers receive
> the timestamp via a dedicated interrupt and complete the TX timestamp
> from that handler. This will lead to a deadlock if the lock is already
> write-locked on the same CPU.
> 
> Taking the lock can be avoided. The socket (pointed by the skb) will
> remain valid until the skb is released. The ->sk_socket and ->file
> member will be set to NULL once the user closes the socket which may
> happen before the timestamp arrives.
> If we happen to observe the pointer while the socket is closing but
> before the pointer is set to NULL then we may use it because both
> pointer (and the file's cred member) are RCU freed.
> 
> Drop the lock. Use READ_ONCE() to obtain the individual pointer. Add a
> matching WRITE_ONCE() where the pointer are cleared.
> 
> Link: https://lore.kernel.org/all/20260205145104.iWinkXHv@linutronix.de
> Fixes: b245be1f4db1a ("net-timestamp: no-payload only sysctl")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Willem de Bruijn <willemb@google.com>

