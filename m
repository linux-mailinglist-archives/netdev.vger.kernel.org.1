Return-Path: <netdev+bounces-258116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CjTAmBZi2ljUAAAu9opvQ
	(envelope-from <netdev+bounces-258116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:14:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC4D11CFB0
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD0C230214E1
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34653876DD;
	Tue, 10 Feb 2026 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfXhkwDo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EEB389454
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740060; cv=none; b=ORjBjv+soBss/wgVoBK3wyfshYCg8ktaIY1OEKPeD0RJZNFUs1XjtjuZkHK/cAXiIxP/mbZAhwkwLeu688hLgvHevFWkHPNShDrVz0c8wLrlakj/aiwLTL3epd8+ujgbgP8WqgkdIE7cgKoNB6/v0xsrub6ZdGntbx+kP/9+lHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740060; c=relaxed/simple;
	bh=CXytLxrI9iUQwr2VbzFGCBUnkWtdUiReWQUTzH2PPdY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oTe1HLCRiJIygsbA4kV9kMyFFe+ZrKcVE3LrfXlNS98MW6VlnULR2hGYszYLH1m/m25ANTn1FYSBf11GT+HYibLbnc3WMQNP+NobXF9RuS9bQ0VJ6KubttYJxPeeIoggoMgK3H0LoekRAJfSUcWoKQVgDX1QSe2AAT1cPxpNLyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfXhkwDo; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7962119ff2bso43700167b3.3
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 08:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770740057; x=1771344857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gchGUW1rkpuZA2Rc75u+DqHEmEZ2JQMqcNEoDXirPgQ=;
        b=ZfXhkwDoWaY2H7rHC6Sck6TzKOE1Yec8KHIv/FhnNdLSw8WfeWJ0Xj/bTycvj9j72o
         gp0L+zsRCAJo0YWWXHUBESLk3I2l8nddBBKC+0+U4t0EEghtnNdsRpDcj+04uQGjzYre
         d9iEW5cd3kI2vHcYrK7pjXHR9eNbJ+PpDL11jui+K7hWqOKdOhE9ZSKJz1I7D9cxWpe4
         hJHpB8gdLJEoS3VWUit3AesvuCjRtIFJgLXkTbnvG10AwUmhKFM+ECCeptut4NnqVhVF
         nmWIFNr+qxPGeVXusHalXgJzz6MWg72Mj1F91JGbXgZBMcNzmwDJFOxYkU2OScG4ST8Z
         lNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770740057; x=1771344857;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gchGUW1rkpuZA2Rc75u+DqHEmEZ2JQMqcNEoDXirPgQ=;
        b=YQ27NOzADKAUahmjdZY90hj0euKfP3u6QKrD/9tDu/aS10PZf1QWlD8NkOMZldODop
         q7QrgVqqcAekNPak7GiQsjfFYgL/PIIWKLppB9lMJy1E0SRSi+J2SFm8QXGdLu8ZrpgM
         2LFREmBxHi9ZXSCQ/to1scXNsNkOXWK7XS0SAqryEbDhfZJUXO12juhBKbzFiQAnpBVi
         g5NgOZ5EBnRH6hSl0plPiKVgfTA0bDRxLTQz6N1143FPwCaK1NzX6Ky9wb85sIHH4L/t
         xApExctwiESZyPdSUo/uSOS0NpTbBHCrbiGdFT6k8ZQ4yZtubjTsejXEE0/gDz50e9Q+
         U+3A==
X-Forwarded-Encrypted: i=1; AJvYcCV9DpI8mWP9iRYlhrarH/MX6Kx4OZkuzNTDjoFRuZy9VtEmecLCmEPlUcMxrNnfsUbCCapOcCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJybKrmkwVTI2C29f2125+t5gEEqnYgrWJP9q6f4pX7b7E+d+D
	cc3NXakLz+JKXfI6Xs4977pzm+svfAlGhd+SaV/DoM4JOSdu0u9m6xPz
X-Gm-Gg: AZuq6aKWypUyLlkwDs2PmbqxsaCy4Lur5sBJA1ypsqc4e7Saj1KKFyc3/Vxk+j3+a2I
	XufaNdFZMIViYl8KSVstfAu7gsD7sD1uCYnXF020QeHxuOK9ZC7Qye7Gd29TwzeJNy9G0LljNfE
	co6wLx7vJ4412hfRkhENnPnXR6h6jvlxsYhAZLt2IIyRLMK6LbFufy5W+gC+e2CYpbcTDYBS30s
	ym04mRQz5Yw0FvVRzHuYZRi85nyOeqApPALUDEzCtuxign9fyfJ5XmTzjf9oZuluBcB1y+ANOPM
	jv0Zq123SO3qIXv6qmrbJkhFSxjd9ypHhwu0Ws/Oh+ITfwvCdt7nxnH0KZZJuVmsUf/+/qdVj2Y
	7ScJssf5nOhP38EeU0qII6BjSK8oNjkx01CugOH8gRCbT1aPlFyqGfJ/8GyiqJSWPCw2teoQwQX
	33ZVFZKnHt5NWg865MgAlHy7qkAV09oJzo5ZCGH6RPJuz3ELvyqUs5Z0MEKSnvfZuhV6egJYU=
X-Received: by 2002:a05:690c:c50b:b0:796:2fde:5dbe with SMTP id 00721157ae682-7962fde6696mr123516557b3.44.1770740056764;
        Tue, 10 Feb 2026 08:14:16 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7964cd48badsm49249307b3.19.2026.02.10.08.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 08:14:15 -0800 (PST)
Date: Tue, 10 Feb 2026 11:14:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 "Gomes, Vinicius" <vinicius.gomes@intel.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
 "Keller, Jacob E" <jacob.e.keller@intel.com>
Message-ID: <willemdebruijn.kernel.cceee43f5b9b@gmail.com>
In-Reply-To: <20260210121207.9kLHroS0@linutronix.de>
References: <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
 <601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
 <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
 <20260209090621.GiZqTiMJ@linutronix.de>
 <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
 <20260209114836.GPU-vnnh@linutronix.de>
 <78e2af2c-40e6-43f1-9471-42f350e69389@linux.dev>
 <willemdebruijn.kernel.2e6213a98660b@gmail.com>
 <20260210121207.9kLHroS0@linutronix.de>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-258116-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,google.com,kernel.org,redhat.com,davemloft.net,intel.com,linutronix.de,molgen.mpg.de,vger.kernel.org,gmail.com,lunn.ch,lists.osuosl.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BC4D11CFB0
X-Rspamd-Action: no action

Sebastian Andrzej Siewior wrote:
> On 2026-02-09 07:46:01 [-0500], Willem de Bruijn wrote:
> > > > Yeah, but what is the legacy user here? If you enable HW-timestamps but
> > > > never set OPT_TSONLY and the sysctl is also 0 then you reply on the
> > > > CAP_NET_RAW later on. Right?
> > > 
> > > Legacy users here means users of HW TX timestamps expecting full skb to 
> > > be returned back with the TX timestamp. Legacy here means that skb will 
> > > be returned with headers modified by stack, which is kind of exposure of
> > > data, which requires CAP_NET_RAW...
> 
> Ah okay. I assumed the err-queue was the standard way of receiving
> timestamps.

It is, for tx timestamps. The open question is whether they are queued
with or without packet payload.
 
> > > > I just try to justify the CAP_NET_RAW check and if it is required to
> > > > move it earlier (where HW timestamps are enabled). And if the sysctl
> > > > check is enough then maybe it is not needed.
> > > 
> > > Capabilities should not change during lifetime of the process, should be
> > > fine to move. On the other, sysctl can be changed system-wide which may 
> > > affect users.
> > 
> > Ignore the hardware configuration. That is entirely optional. Some
> > devices will timestamp every packet.
> > 
> > The capability check here is per-socket, independent from the system
> > hardware configuration.
> > 
> > I don't see how it could be moved.
> > 
> > Before OPT_TSONLY was introduced packets were always queued with their
> > payload. The sysctl check was added to optionally disallow this. The
> > check could arguably be moved earlier in the socket lifecycle and the
> > decision cached in the socket. But then flipping the sysctl would not
> > affect existing sockets, so that is a change in ABI behavior.
> 
> You could cache only the part under sk_callback_lock.

Can you elaborate a bit?

> Any other suggestions?
> The access from IRQ is quick and avoids any detours.
> The alternative would be to move the whole routine into an aux_worker.
> For every driver doing it from the IRQ handler.

Perhaps CAP_NET_RAW can be checked in a way that does not require this
specific lock.

See for instance other examples that instead use
sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW). Though that
uses current_cred() so probably won't work in interrupt context.

Changing the check may subtly change behavior. But that may be
acceptable as long as the consequences are clearly described.

An alternative would be to delay until dequeue. But that would wake
the reader and then drop the packets, so without any data to read. Not
practical.

The core issue seems to be that the ptp_tx_work is not scheduled
quickly enough. I wonder if that is the issue to be fixed. When/why
is this too slow?

