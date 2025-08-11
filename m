Return-Path: <netdev+bounces-212411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68432B200BC
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF8E1885BEB
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 07:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8992DA76B;
	Mon, 11 Aug 2025 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLCujJk6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FE51F428C
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898563; cv=none; b=QFQ4KdDDPDjujg5QBtu8uFb2U6iHKx4XvNYiruj5m3WdBtdNbDNz6P4WygBwjgZstTZ2I4qzaH9Z/iqyaslPfCDB306hUEz13goX1jLrduYL/P+qEGghVNfyAy5u0+3X3cNgtOd15U4OdOaT/hzOqSj+TW0MGEoH59ik8x4utLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898563; c=relaxed/simple;
	bh=awZydXiZYww9RStVXo2KEdkieJ8A0KhUcf82ICMJpII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9DnCpvIlw+t/NdHqVy5UsaH3/zBgHliaqMZ5I2faYn/0qbUwU5RSzpe5uDf0eN2Gx86qKCIkTWcDE/L8JjJaX++etZ7HaBXVp2IG43D/fGiqpOKGz+3HIQgX3/HHt7DdvkfboJ2Lx6MkYB1GYCZ6FuE4fS7P4bhw5teuaDrLFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLCujJk6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754898560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e39O+P7UyrQTghATSXOd0d76RB7YMHwGswtjD1f5k94=;
	b=BLCujJk6x9VO+1uMhDhPibfZRhP66LeWcZCwfjgyte/OgYOW7jnVYYBEio5DRAPJuJxHEF
	TsRHcnYKoDQ27VNqQ7ZBBdIaqnZROAK5pYpi+G8+kmTYde/Vb/X3gHcr64FVbpxyYmLrZf
	bcxOng+K63Epwapwn2/RnYjR3s92FvI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-MlfKzPFIN6OfyM5Ad1KVMw-1; Mon, 11 Aug 2025 03:49:18 -0400
X-MC-Unique: MlfKzPFIN6OfyM5Ad1KVMw-1
X-Mimecast-MFC-AGG-ID: MlfKzPFIN6OfyM5Ad1KVMw_1754898558
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-459d7ed90baso31618845e9.2
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 00:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754898557; x=1755503357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e39O+P7UyrQTghATSXOd0d76RB7YMHwGswtjD1f5k94=;
        b=a3yvHrG9bJ9LIDtdSfnk9DgiBTWFhPj4KOVyhEQgUfnkkLCoL0POSQvFBtQOP0TuRI
         r4s2YOypEHTNHMCYCxrwAv7zFZXIcWy11r4xcyNMWEagGmEWesTcJ45PKBMbcWROybvQ
         hH/aGTpgz1mOWtFSg57eyVjCYOgIbK1uMYx8RynX4ct+T+eJV/KDIDXOhzadSo38kpBU
         PxFrsX1PyYTcQzIZA/McXP5NCp2CF9cpZ8zKFdCV0I5d2qLV4pWtfclw4Uc2GffE/Hml
         LhYBC2v3nw7Xmfy0r9k58O9rKzcLXeiBIk3nJwCug45pTZd40JNjZAV7FXnwrzG97doi
         Hm/w==
X-Forwarded-Encrypted: i=1; AJvYcCU7tZ5PSt4EzsLYEWB8vIRjCZmMZF6JS+5VD0Y/cEbOAZXgv6ULH+xjGS6nD+mIuUYWQWTrXk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCG+uLNq5ceMMxgNeV6wVcfri5Oma+L3HJM4QlAqfQQ7y4nPEe
	qAPISgh1LMPc+ekZYO/mQwc51ug4NLiQ+1kFS2XNV41q5OCESBiWDZnPxN1y/gvU57pWsxHXAkM
	vzh7ey4qQbBEqOxwPL/bN+GakTR37e9psmAgzzNJ3ye3a8LGlNTQtoQT1UA==
X-Gm-Gg: ASbGncsiE2hWzQOZexYBMJUIT077DSoZo46DMslso4SoSR4Zj6Z460ot1KrF4GwLUIu
	aeyUn1GRaueavIJsX7WBRBkspr10OFL/4A+xsA5Zt3RPUyk61UH63h1kwgOWbnZ14bYDTWMGXlH
	xPbHzw8IryfHKxo3lzdv9JINNRrM2Hx7gPvFLeVRk5kX89TNvQgJ9XQyFF9rNplmxAN0uCzDYsF
	hTPMoVcNh6IO481YGQmjwymWUI0PFKYPDI+YOAGl2sPh51Xcbgqn+5Hzsn6AbLwMNNsrjAJ04/H
	d5rnuphr6IHBVr3PD9TJsr7xcpo/1zCzToS17w==
X-Received: by 2002:a05:600c:4449:b0:459:df25:b839 with SMTP id 5b1f17b1804b1-459f4f2e2c1mr107217325e9.33.1754898557553;
        Mon, 11 Aug 2025 00:49:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBzrmRxVItct895fJq/KeMpp2Yw2fiHWY2tFlwk4Fdl98aYjyuqpPSF9ER5/MjMJWNXCVbtA==
X-Received: by 2002:a05:600c:4449:b0:459:df25:b839 with SMTP id 5b1f17b1804b1-459f4f2e2c1mr107217065e9.33.1754898557155;
        Mon, 11 Aug 2025 00:49:17 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5d0b1afsm237816815e9.26.2025.08.11.00.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:49:16 -0700 (PDT)
Date: Mon, 11 Aug 2025 09:49:15 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Lion Ackermann <nnamrec@gmail.com>,
	Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org,
	Ivan Vecera <ivecera@redhat.com>, Li Shuang <shuali@redhat.com>
Subject: Re: [PATCH net] net/sched: ets: use old 'nbands' while purging
 unused classes
Message-ID: <aJmge28EVB0jKOLF@dcaratti.users.ipa.redhat.com>
References: <f3b9bacc73145f265c19ab80785933da5b7cbdec.1754581577.git.dcaratti@redhat.com>
 <8d76538b-678f-4a98-9308-d7209b5ebee9@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d76538b-678f-4a98-9308-d7209b5ebee9@mojatatu.com>

On Fri, Aug 08, 2025 at 03:15:13PM -0300, Victor Nogueira wrote:
> On 8/7/25 12:48, Davide Caratti wrote:

[...]
 
> > Fixes: 103406b38c60 ("net/sched: Always pass notifications when child class becomes empty")
> > Fixes: c062f2a0b04d ("net/sched: sch_ets: don't remove idle classes from the round-robin list")
> > Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
> > Reported-by: Li Shuang <shuali@redhat.com>
> > Closes: https://issues.redhat.com/browse/RHEL-108026
> > Co-developed-by: Ivan Vecera <ivecera@redhat.com>
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> 
> Can you submit a tdc test case for this bug?

hello Victor,

Thanks for looking at this!

At a first look: TDC is not the correct tool here, because it doesn't
allow changing the qdisc tree while the scapy plugin emits traffic.
Maybe it's better to extend sch_ets.sh from net/forwarding instead?

If so, I can follow-up on net-next with a patch that adds a new
test-case that includes the 3-lines in [1] - while this patch can go
as-is in 'net' (and eventually in stable). In alternative, I can
investigate on TDC adding "sch_plug" to the qdisc tree in a way
that DWRR never deplete, and the crash would then happen with "verifyCmd".


WDYT?

-- 
davide

[1] https://lore.kernel.org/netdev/e08c7f4a6882f260011909a868311c6e9b54f3e4.1639153474.git.dcaratti@redhat.com/
 


