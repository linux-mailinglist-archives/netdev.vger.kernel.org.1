Return-Path: <netdev+bounces-263891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNmmNVRfqGmduAAAu9opvQ
	(envelope-from <netdev+bounces-263891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:35:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FECA20460F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A76FA310D341
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A5335B634;
	Wed,  4 Mar 2026 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSFpK5rQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F56734DB59
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639779; cv=none; b=l7yoHV+SdURaIT0k5YmfJrsXXg6R+/hwXMerGWHJcGZEMs+fqZYa2bnITLRuTYVGQ2cHCX12D9jNaJS8IGkOHL9CX1FYsIRqvuZ/aF1WZBtU7maZCU/1USHd9fUG4NUd7OP1t2u6QpS6Jkt/Y3+i2G0OA5io251ehrLcf1vt540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639779; c=relaxed/simple;
	bh=16Zic4SDQGWTmQBNLBdQRXwUEC8eGi1n2jiGkrA7otY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DBXl1wMcT41iso5uc74GuITw6NQUIExdG29q1RuGed8nr9lC0TWZADkkkpUKlYJg1YhB9/4UD6OxYoLzKBt3im4hrXfrjFGAC9rpbnW1cOP0Hg5F0AMlL+WaFQM1Bt5h72g551xVkPphc0I5GL2fSmSdMTEmfd0MoaNNlbgRidk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSFpK5rQ; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64c9a6d7f81so6353875d50.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 07:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772639777; x=1773244577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xokoHdMD3J18FiFUDczlkDJ0ezoq483FegUXS3bZr4k=;
        b=lSFpK5rQkkeIGgfkZBRoHCZuchJKVHxquNwsPpms0xTUW+NQAWpCaMtIG4W6Sotb7T
         tmSG/cKXMwp9MvozjwQyJwk+Y5XCiDHFW86qyHCMl2RC6tZ5a2Uy6rd4Wc4u41hTttgo
         07a7XrI7P+wIG8dwNkPGv25+PPkfWThLHHzV9n0b4lWWS7cNc4DCAQaUk46kA1B4yHMv
         ge9fuQNUkuuyXaZJv+0lBDipcghAHG8Df6UKYAGzLHiIt6h0OXTPFiUW1UIKX29o56g5
         PWfgLOIflxmUv8IBdxSpYNhuVP5SvV5Q15BAcWhKYpgUT5ZoU1IzsAIuctZv5HApMpbr
         YeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772639777; x=1773244577;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xokoHdMD3J18FiFUDczlkDJ0ezoq483FegUXS3bZr4k=;
        b=OCLWmQ/tKpF7U+jHVOvIkhhOxuZI91p9sc43plG8XdceHx7GRVe2L18KnlYlKu5JUx
         wQ6EtN+iQmxkmKirzDvzMDNTpiCqaVTQNkfI9dcJ8YHDxCzRSpNwxDrrBbiOXlVVOZw6
         zfOHz3AW1vQwj6CmSLo57tHj9b9OFvrbQ0BmxMeYqWpEUXY9QBvdxm7wYkPQrS+dlV/U
         zs67tZeMRewu61XMYKW9cOzv8BJZWAH4f0i3nx/yhuwSr16WnNd3vueoIpnhW8DMyOzD
         ghTJluJ6GplBUjD/gh4Y8VdU7HhioW9TLFXhQtUg1GGj7a2EdFnXH0qncXdTkNgDSJbh
         4dOg==
X-Gm-Message-State: AOJu0YxEZdU8e2Q7Hu8Ju9PvGb0Mt+5htrnuNwkEUCW7SaIeAGPt+A8B
	We8M2O8K3sFm/JFEjivFhYQMHWfG6RlikmwcDQ9bXjpgA9JecWgS64Ff
X-Gm-Gg: ATEYQzwq82fvl+J0ViweiI31CCZ8rRTMffD+MsKLOOPBb9k5XtCzR4lw2MHwC6HMk48
	PmV/hIhAqZniiOBvLVivIP9f0qr6BGwyrOdHBLJZMOY3/dFDBnPu0wvvHjA97WePRkqKAJNvXzm
	5M9ywwGSV8kylp0HQZP45kURfRUFtERrivFnTfB2/U8TyAPW88pTVLFrOZdXLswwuC8k8cLwewh
	kLyOgriGoQjWDClX+9P1t50JxSFyPbjE5MUo1MeVfIb4ChZJRJJreQZA6jtW/0Pqgbxmf+3dx4X
	npPof+HHsd5l9KXQGnbUhheWwqrRZmFkMkNqHwagH5A041DkjmCEigkuDMhHnx4ohxakzPrg1iB
	FX/iuOhE2BacBzjCOxaswUYu+83IK4isl0vjBB8g28+F1WXd+2NzG5UXtBFqZvi6z14IHt5fQJE
	KC0ih2W4NRNlUYHQ8ix9dP4gZByvp2mOHEJECtIcn7d8G2+YwReDsxjksNipu1M1/mX+RKjwc=
X-Received: by 2002:a05:690e:138c:b0:64c:a761:7f90 with SMTP id 956f58d0204a3-64cf9b5c0bfmr2180642d50.36.1772639777446;
        Wed, 04 Mar 2026 07:56:17 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64cb74b985asm8022480d50.0.2026.03.04.07.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:56:16 -0800 (PST)
Date: Wed, 04 Mar 2026 10:56:16 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Felix Maurer <fmaurer@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Simon Horman <horms@kernel.org>
Message-ID: <willemdebruijn.kernel.1d699189fce58@gmail.com>
In-Reply-To: <20260304145821.TQhzhhjF@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <20260204-hsr_ptp-v1-1-b421c69a77da@linutronix.de>
 <willemdebruijn.kernel.2d4b5c08dd442@gmail.com>
 <20260304145821.TQhzhhjF@linutronix.de>
Subject: Re: [PATCH RFC net-next 1/2] hsr: Allow to send a specific port and
 with HSR header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6FECA20460F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263891-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.992];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Sebastian Andrzej Siewior wrote:
> On 2026-02-04 12:30:47 [-0500], Willem de Bruijn wrote:
> > > --- a/include/linux/skbuff.h
> > > +++ b/include/linux/skbuff.h
> > > @@ -605,6 +605,7 @@ struct skb_shared_info {
> > >  	};
> > >  	unsigned int	gso_type;
> > >  	u32		tskey;
> > > +	u32		hsr_ptp;
> > 
> > skb_shared_info cannot easily be expanded.
> > 
> > This is too specific a use-case to warrant fields in every packet.
> > 
> > I'm not super familiar with High-availability Seamless Redundancy
> > (HSR). Perhaps you can use either an skb_extension. Or the skb->cb[]
> > field if this data is only needed within the HSR protocol logic, so
> > can be assured to not be overwritten by other users of the control
> > block.
> 
> skb->cb does not work because I need share it between the HSR stack
> and AF_PACKET so it gets overwritten (as it is no meant to be shared
> between layers).
> I need actually three bits: HAVE_HEADER and PORT_NUMBER which 0-2.
> Would it work if I add a :1 and :2 member to struct sk_buff into the
> header group after unreadable? In my config there is a 6bit + 1 byte
> hole. Worst case (all ifdefs enabled) it sums to 30 bits so I would have
> just 2 left. Exceeding it by one bit in this case would extend create a
> 7bit + 1 byte hole and shift shifts tc_index + alloc_cpu. However there
> is a two byte hole between alloc_cpu before csum which is removed then.
> 
> Would it be okay if I occupy three bits in sk_buff which look unused?

Have you looked into using skb_extensions?

