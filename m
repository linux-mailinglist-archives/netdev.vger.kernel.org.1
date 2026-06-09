Return-Path: <netdev+bounces-297195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uac4MuhRKGp6CAMAu9opvQ
	(envelope-from <netdev+bounces-297195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:48:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD496630E4
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:48:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dama-to.20251104.gappssmtp.com header.s=20251104 header.b="OpZ1b/mA";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297195-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297195-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FC7F305FAEB
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401404183C8;
	Tue,  9 Jun 2026 17:34:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAC74C77D9
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 17:34:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781026480; cv=none; b=k8KwcQPgAPW9j+rlvX8JQ2Huc7KKnNoQqSX1jVRPwNqGE0TeJKJxEzp7jk8aAFbZ9Ayx3BC18k5CvAUdujIQfbzEvmJi3e+V+OOq90p7XYTrd4knTLu731QmlgPxtL6l+no6B9Ilx03nmBrjx6rU3C+zCM91j6i1UP7h/RK0aP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781026480; c=relaxed/simple;
	bh=8N7XuyRU6c4ER45QABIfU6iv2y0qjX2rwhUyYzCewtw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tk2Gri+fBmiDnZ3G3FqGHlWOaewAi8VKPbwydiU2WmHd3BRlrEcwZ+cuX5yHxXDtSa/lfVOBs29gBrPpzdWZdyAC3zTCwNe+I8acFy00ievcHnk6B8466BdQb5EEe55dUFLzEPbBuMwGFyjp/KkzzXQ9vpammtjlyc8dTCbVbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=OpZ1b/mA; arc=none smtp.client-ip=209.85.215.172
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c858b5de728so3757965a12.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 10:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1781026478; x=1781631278; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H0O37JLU9+UUO6RjfEV3qnVTJcbwi/sCUYtuia8QZ84=;
        b=OpZ1b/mAM7il9uLaDmV2dJfnKy7q0QPThcx2nA6IjX8bxsh6e7XaTsXd+Wof6Ww5Ap
         Y1WLFpxOgzjlLXSuzXP5+TDlJ71nFcdbNpxZKMvuWgVx3VuZ/JN1eaDKeedW/+syCUA0
         tYgrE4GHaYtKFnwneCV3rWaqVNq/2eYhg5szLbsYhgLiKX1lZgTeaSNQKrt5fvXF6FI8
         5eYa9eDXbSA7X6v3kmmoqXM20Um+z+mzTic4dqPtH3fsgcX1k3MX7CasgmGiphY3bIxZ
         01kNywJk0sGhDcfJ+ceQs09n816BXtMDBYMPNkSQQwc5jaTe7qbus5l6Pj0TafgLFfF4
         G57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781026478; x=1781631278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0O37JLU9+UUO6RjfEV3qnVTJcbwi/sCUYtuia8QZ84=;
        b=me5XWjF/fOsnj8lysJjCohgPb/1OFgJ8GaZIlndTRJDbRHWpsrU0K4y1Y3m3hHjjRr
         BgBUK+CQuZjhO4+/NyLguiU347IiNDgijMQ94Ri3PEbANuF1xFdl4/TaXsHfmR4uwfYo
         p1D9UEfFZAr5fNppFWLIXUkgYyGxZdlXXUt5/vaA32nRO/dfuIjyJMjkSmbpZUe3EfnS
         V54NB3SxsY6+Xtk9XzhfcAeVwDcNLT1YYObIxAtZBIhxJ05DnuTcm88CF4nDOKBoftt9
         NxkU8U23SEPiGwTjpPcFaD/3aeXz8+pw/bU0gGsq7xAFRHojuOs7gK/vctBMn/DJ40Hw
         3f/g==
X-Forwarded-Encrypted: i=1; AFNElJ/WdnkeKWAXHOZXQOLCwaRYZsiQPlwTJHXrKA+FPrJqGynEOyqUS1tvjN+LTU/6OIV6/19/3DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEx+lHyZ2kY2oR1mUpOPB7TBcrhDQ/GXw/eFIX1Wke7j8KySvC
	N9DxGKcVbboOziDWXFDWISmeUpzPNmtoJ9AIZnDuF9Qno67lchXi1oizpYntvd3tzHA=
X-Gm-Gg: Acq92OGP9dCayXr5Y2z4gjdE5bNRVJnopPfdo5ntNPlnIlnkb2vngvPlbqWMJXcMB0L
	09Qz3bSdbSNJvpE/DRkatSTKEhix3G4YYox1o4lGFr54C/+EQVazKFuODSk3XKoBp3U5gm/m8k1
	5O6FtqnAYkL4eUHe6yuH7FJqQ3Bk41qdG96ZbfbFg+7I2CL+oStpJK+K1SwtH/mc9t04SSWLEil
	MMyf1RWe0r9mlUWk28qjk0vdTB6/B6s3x2FMzD4aW9Yu9gW8GTp0xowRUdg8+6+p8QqRPSlsBWx
	hInzKGAy+KTIDncXZlVdWVNoYVhGlp8zOdAkOsErsLQLrnzZCoPauq3XMvel7ViyMOW7N6C3I1D
	cJw/v7fhlN1NgJ1xwPVClmccH5xLD6T2srI5mThhy6lP1r3SgQcjtTjqzYWht4CjowF1G1TDdir
	ArimQXAc/Vb1jncqM=
X-Received: by 2002:a05:6a00:908e:b0:842:459b:d61b with SMTP id d2e1a72fcca58-842b0f90d88mr21560405b3a.32.1781026478050;
        Tue, 09 Jun 2026 10:34:38 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:12::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e5638sm22758898b3a.50.2026.06.09.10.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:34:37 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:34:36 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] bnxt: fix head underflow on XDP head-grow
Message-ID: <aihOrCfOLloudXmk@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260608203129.920104-1-joe@dama.to>
 <CACKFLikOyMh3Kbee-AifLXQryyPt-CftW7VYHeeKWoCuMoXj8w@mail.gmail.com>
 <aigoUdgW/icfFwvh@devvm20253.cco0.facebook.com>
 <CACKFLinzaJr8EjXx7yME5cKv9LR1+pF+2iY43V+GeYdEjbUo+Q@mail.gmail.com>
 <aihLw8yR6Vu5B6lS@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aihLw8yR6Vu5B6lS@devvm20253.cco0.facebook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:michael.chan@broadcom.com,m:netdev@vger.kernel.org,m:pavan.chebbi@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:somnath.kotur@broadcom.com,m:andrew.gospodarek@broadcom.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FREEMAIL_TO(0.00)[broadcom.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_SENDER(0.00)[joe@dama.to,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-297195-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dama-to.20251104.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid,dama.to:from_mime,dama.to:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CD496630E4

On Tue, Jun 09, 2026 at 10:22:12AM -0700, Joe Damato wrote:
> On Tue, Jun 09, 2026 at 09:44:17AM -0700, Michael Chan wrote:
> > On Tue, Jun 9, 2026 at 7:51 AM Joe Damato <joe@dama.to> wrote:
> > >
> > > On Mon, Jun 08, 2026 at 09:22:07PM -0700, Michael Chan wrote:
> > > > On Mon, Jun 8, 2026 at 1:31 PM Joe Damato <joe@dama.to> wrote:
> > > > >
> > > > > To fix this, we need to do a bit of math to recover the offset if this
> > > > > is a page fragment since it is not passed into rx_skb_func
> > > > > (bnxt_rx_multi_page_skb, in this case).
> > > >
> > > > I wonder if we should add an offset field to struct bnxt_sw_rx_bd to
> > > > simplify things for page mode.  Struct bnxt_sw_rx_agg_bd has the
> > > > offset field for a similar purpose.  Thanks.
> > >
> > > I don't mind doing that, but I wonder if that's better material for net-next?
> > >
> > > In other words, we get the minimal fix in (this patch?) and then do the
> > > cleanup and struct tweaking as a follow-up in net-next?
> > >
> > > I could definitely be wrong; I had just assumed patches for net were supposed
> > > to be as minimal as possible.
> > 
> > I think some minor refactoring/struct changes to make the fix
> > cleaner/simpler should be fine for -net.  I think the total number of
> > line changes should be about the same either way.
> 
> OK. Are you OK with changing the signature of rx_skb_func? I was going to add
> offset as an argument so it can be passed through.

Oh, actually nevermind. I think once offset is store in the struct we can
derive like this?

frag_start = page_address(page) + rxr->rx_buf_ring[cons].offset;

And then the signature doesn't need to change.

