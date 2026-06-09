Return-Path: <netdev+bounces-297090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oSPiMI8qKGqZ/QIAu9opvQ
	(envelope-from <netdev+bounces-297090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:00:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A36C0661729
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 17:00:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dama-to.20251104.gappssmtp.com header.s=20251104 header.b=QHI3la7a;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297090-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297090-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5473A307CECF
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE3235BDCE;
	Tue,  9 Jun 2026 14:51:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2412735A933
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:50:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016662; cv=none; b=uR29oRXFqbTNik8+4JtmI/F2Zhy4Id8CpApS0UyuHempZN4frWxFbeOCuSh889BJikUT4rvYSOGyle+wqrpufWb4p73BylmCd15MQe/80OePnyG6WX0v+6IFFTmOkNeeFFOfwHFoNhkJ7YvdRfargAjG7jUpiES+GYj0SaG38IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016662; c=relaxed/simple;
	bh=gxPRu6nbXG6vnDGagaNFiPthkbWpRHQdXXkxtNNL2Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs/zq+D+/uvLi1J7AsASry1qHuut3cfwhUtyiK4whDpgjjx+jAhD6T3js533fu/y9Kv367xZNhrVvLIwMYm+tx6kuuF8oY6HBA4QWZgtEYvS7MGUxbojEjGOgulBroQx0OX7fszxPdWjbO2z2o0WqUWVa1A3LXskdrocLUO0cf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=QHI3la7a; arc=none smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423b08b293so2451733b3a.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 07:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1781016659; x=1781621459; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CX1RLepI6BxsG1iHPv+ylDoNwQ0QIiidp1+2cKX8sjE=;
        b=QHI3la7aq7We/mUYCxIFPmB6lw/If0nWNbQXczWFkyvpLWJuxxb8aqCdbq1dInyBrV
         XlWISMKWfDPdVdkHMHq8xXDQdxiT5SUM6/WFNvR7IqI50kvVaZJ/KJbx8WvreuFlI+fd
         4yCSmg2Y283FUI/fE6DP9hpvgrFYKH2erqm8FSbK8XtQ/6fYRfOak0JXwbc8WH1GF1B5
         d4BBStBetC10jA2zHyiRyiiFVWlpz/Z/k893Ps+NRtg2fG/pT46Y7kAgRrRlaky5Pfhd
         nHIoLR58Okv0vww+UVaOPsnwm0sY27eMyyKUtR5uIywLO/GRwF+7ArgrvIKvIQtYnFx+
         8P3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016659; x=1781621459;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CX1RLepI6BxsG1iHPv+ylDoNwQ0QIiidp1+2cKX8sjE=;
        b=J4ymC/0pFmByfzrPc5Yh5SJNNq4yoZRnjFNjIaa4QCJtZ6KyTmP7WFomGLlTk82mKE
         EGdRLV8LtVBIeM0W+1RssiyX+Y4UDiOBnHqsp+a5jQhNTsZw9qKhL4fNISZQEbvaBG3x
         OqO4GIWhwbfQUEFlO2NRyc3q3ApWnXKSX6TJ+SinhN8kn5bTLGsaLVYlpbqhw6QNCf7I
         RU8OuEfibIZjxXTYfsqVva36SoP1AJR9SLO9GoSSbm175tyeWq/gtqQA3SIZ0I1NO7x1
         iIj7w685B7TuFkvBm/e6y2Z0I4sM+m1sQLHufR+7wr5BwVMk28ROKGLFyXiVui2n+eXe
         Z+iQ==
X-Gm-Message-State: AOJu0Yxtn78a8/R7M/dXerlN1f79eW3mqsyB8Lrm7yYnbF6A0Ttc23Mg
	nLL061K8aC0TjBj+19kf174WFhqBHmfK++5yBkxPywC+gFg7lV6MjwIYj/8NXQCBEfE=
X-Gm-Gg: Acq92OH6ST1/XEhgFjZXEG+asSmB2p01TcpugRzPFFmLc2IwHFToIhCLIKFlU0EunNQ
	co/sLVsJbHo/FVfQBTPLcVPLi3NsCR/qmKelVoGfCx92cX13EAt69N3bcQz8SKeTqL2PZSU2waZ
	o6Yr3F9B0b4Z7X3YqWHjGO927gNtnpltXLkO0eFRA4kLveNbQW8ZEzcNGhKT3Wnxm7ahBWOBEFv
	CNh6iBLot2RHP2XyhbdJlUV7XSdfIyeZtKZEbIasyki22Yf+EkkpA/+YLcU6cJ8UTKVl6qlplW8
	zHZ7055CRMQV1JJ6+QFvk70VYhWCpffr3tZJEWUeE0JWUi7su4vWn0b7mimKSsP3CpvkL2h25R3
	zP1a+tPUOlblZhsFLUetL6L1qUcn2f/T4PiepSVdGGZEM0Sk4JixwOK8n4n/ZmdH7SPoP8zPl5T
	PUgyZAwLuCYOq5iw==
X-Received: by 2002:a05:6a00:bd04:b0:82f:2226:5aeb with SMTP id d2e1a72fcca58-842b0fa16a6mr20948292b3a.20.1781016659235;
        Tue, 09 Jun 2026 07:50:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828821d0sm21446834b3a.28.2026.06.09.07.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:50:58 -0700 (PDT)
Date: Tue, 9 Jun 2026 07:50:57 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
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
Message-ID: <aigoUdgW/icfFwvh@devvm20253.cco0.facebook.com>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLikOyMh3Kbee-AifLXQryyPt-CftW7VYHeeKWoCuMoXj8w@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.chan@broadcom.com,m:netdev@vger.kernel.org,m:pavan.chebbi@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:somnath.kotur@broadcom.com,m:andrew.gospodarek@broadcom.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	RSPAMD_URIBL_FAIL(0.00)[devvm20253.cco0.facebook.com:server fail];
	FORGED_SENDER(0.00)[joe@dama.to,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-297090-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dama.to:from_mime,dama.to:email,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A36C0661729

On Mon, Jun 08, 2026 at 09:22:07PM -0700, Michael Chan wrote:
> On Mon, Jun 8, 2026 at 1:31 PM Joe Damato <joe@dama.to> wrote:
> >
> > The xdp.py test test_xdp_native_adjst_head_grow_data crashes when run on
> > a bnxt machine (and also crashes in NIPA).
> >
> > It seems that the bug is an underflow in bnxt_rx_multi_page_skb, which
> > builds the skb head:
> >
> >   napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);
> >
> > The problem with this expression is that in page mode rx_offset is:
> >
> >   bp->rx_offset = NET_IP_ALIGN + XDP_PACKET_HEADROOM;
> >
> > Which evaluates (at least on x86_64) to 258.
> >
> > The test test_xdp_native_adjst_head_grow_data tests a case where the
> > head is adjusted by -256.
> >
> > When this test runs, data_ptr is shifted to frag_start + 2 (where
> > frag_start = page_address(page) + offset).
> >
> > Then, bnxt_rx_multi_page_skb is invoked and the napi_build_skb
> > expression subtracts 258, landing at an address before frag_start. This
> > could be either the previous fragment or the previous physical page when
> > the frag_offset is < 256 (e.g. if the fragment started at offset 0).
> >
> > When the skb is freed, the page pool fragment reference is dropped on
> > either the wrong page or the wrong frag of the right page. In either
> > case, the corrupted reference count can lead to the page being
> > prematurely recycled while still in use. Once (incorrectly) recycled, it
> > can be handed out again and on driver teardown this would result in a
> > double free.
> >
> > The commit under fixes updated this code to handle the case where the
> > native page size is >= 64k, but it unintentionally broke the head grow
> > case.
> >
> > To fix this, we need to do a bit of math to recover the offset if this
> > is a page fragment since it is not passed into rx_skb_func
> > (bnxt_rx_multi_page_skb, in this case).
> 
> I wonder if we should add an offset field to struct bnxt_sw_rx_bd to
> simplify things for page mode.  Struct bnxt_sw_rx_agg_bd has the
> offset field for a similar purpose.  Thanks.

I don't mind doing that, but I wonder if that's better material for net-next?

In other words, we get the minimal fix in (this patch?) and then do the
cleanup and struct tweaking as a follow-up in net-next?

I could definitely be wrong; I had just assumed patches for net were supposed
to be as minimal as possible.

