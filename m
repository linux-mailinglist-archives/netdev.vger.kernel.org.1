Return-Path: <netdev+bounces-273268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOkVDj2pymmx+gUAu9opvQ
	(envelope-from <netdev+bounces-273268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:47:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF0435EFED
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5B243010215
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229EB38F653;
	Mon, 30 Mar 2026 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="H30Lusyl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A273E38F931
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889117; cv=none; b=p+U1lOpY+P8ytDjQQ4JT/oKy0WKEn9bDlyrUe4qdDd+jm9nEkC3SeTIDKVIMtiOQbffu2Vqwr39cVwkJINdHcxJ+OZfDJGvRwN7ImSNX+TdSDvrQCm/vOnchCZfEwC8K3H0+oahxh0bQj/lMJDLViazsKsPJyWnC0aXweMHjswI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889117; c=relaxed/simple;
	bh=oV7QgQhgX7+o9PqpnbSuY82jRXnH+orZd/iKLoOLrI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEN05SIPk0sIVIeOMw119o22RN401uG3jQucqXZ+c1KmatXSFkLqSyXetzhLUqQhnKRuV5WjombNFXtpnO7F8vJQNXhnLcQdam7YdhJfRKAoFIgaDZTx/Sbvsv97/G5QgEeDMr7GNqppTpWVCv4R3YyIsXtO5Xi2eZgJcGYVyNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=H30Lusyl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aae4816912so29962635ad.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774889115; x=1775493915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34/ZKtZOcwiQXY86DP33Z/1lymjL2gc+vnTqWnuII0E=;
        b=H30LusylPSTVxgVu2iyPumhFEpfssOddPLy4S24heye9mURYZK+Qdy296Z3FAuVVsG
         DOE6fPLz3cR4cjyUUISJoEB6QssjZJpZ/mzbMxi6ZxWPScQHgN+nxL2erzMX+2Nglv6H
         K6KzCOHt7UsuDwnihGW3SV424ADak/kQai4jT2mbihzH5y2CDx/5f2MOqfXqhxXuwyzP
         jkcnDk/x9H1XR29VEK5+WPMqu0TpfY+esUCosvjmWFw2OkcKqB+UlrhYJxN3uoFQOPyX
         1A32osP7SW37OadSUEh+qp8bsHW8FTVfXQV1L9+ihHBF3mRlT+u8hVSTlSESCFRKyekv
         Cj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774889115; x=1775493915;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34/ZKtZOcwiQXY86DP33Z/1lymjL2gc+vnTqWnuII0E=;
        b=nbdZCLtEk+i5DRpdByyCYi8jzBb7snTHSAyU9XzbruAlB+aVzVm22hEE8XFpmXJa2g
         sU30xKE4RJf4rZe7qMVf74et5WT7iWDOTEWMJIain3Rsi4bkds7fmmW0od2dsQ2c/54X
         5nP928Xa0+PMexs2MGEoaGAS5K1p2Vscqc8BqBnjxAOmrzrwPtV9i4Ia9Wg+5VJ9RUcz
         u0pQEnSXg1CYtAiJS12waQQBFlP09lLr22/ZsLzkBxwScaOyQGTcJBjwWtuBix9psiJR
         gCpWfNkdldYTDhPOUb60PdJRAYWsVjP9FTO9oKi3EMLhl1yPeEuInAWEVifCchKLl2JW
         VSrg==
X-Gm-Message-State: AOJu0Yz6MSmqK3grGUJKMhMpScgF4GNScs+jPJCNqK35czzInv12s8nT
	gkTtx0D1jWGqhCHaFdjKgFvbybBeZWDaC6MZeGDMmsWFXHBdL3Sw2P0tr3BEg/8hW80=
X-Gm-Gg: ATEYQzyeOoBh8KEPFgRnXWpZWNHEZAeGi6lcGw8lekL7cO+65FqUx8aSc83dbO5uawX
	bBmnkprcYsATl3I7GlzSZDYLhmM3gFA+7ixstQ6bBddxCMYbZTcfJdtLVC2KVRKacdHYItYwenR
	J3+RQvwLVAt2pusQDlgHdU+3VqOQDgNCbikb0Mk7LjhHmvXwRsudgt+70xHOqzIRoQSIQoOr0Ol
	9jZRqRiAlIvWA0PewiB6PeW4lpNCUr+0uyRQYP6PvLxz13ldUBd81dIytUrFIa1wm7XYK0i3nYM
	4BEnDlRsXfZ4od/HxGffL0oE+hlnmrVc+B9gffjTCxH7ihMtry6+Bw0PIvJQJRrkZ6FwhySlkVy
	eK+ZqOA2tvvddk8sjbNIbPEVkyDZa9XN78kVISrHd8y0Cq6WtfH5Vd2A7/YrcBoHlTpQZkYBepV
	Ava6P1
X-Received: by 2002:a17:902:f60f:b0:2b2:5c31:24bf with SMTP id d9443c01a7336-2b25c3148admr12768315ad.19.1774889114616;
        Mon, 30 Mar 2026 09:45:14 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c3a4esm109091455ad.78.2026.03.30.09.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 09:45:14 -0700 (PDT)
Date: Mon, 30 Mar 2026 09:45:13 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org,
	leon@kernel.org
Subject: Re: [net-next v6 01/12] net: tso: Introduce tso_dma_map
Message-ID: <acqomTgNfmkNuNK8@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, linux-kernel@vger.kernel.org,
	leon@kernel.org
References: <20260326235238.2940471-1-joe@dama.to>
 <20260326235238.2940471-2-joe@dama.to>
 <20260329151147.6d2fc8e0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329151147.6d2fc8e0@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-273268-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm20253.cco0.facebook.com:mid,dama-to.20230601.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FF0435EFED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 03:11:47PM -0700, Jakub Kicinski wrote:
> On Thu, 26 Mar 2026 16:52:20 -0700 Joe Damato wrote:
> > Add struct tso_dma_map to tso.h for tracking DMA addresses of mapped
> > GSO payload data.
> > 
> > The struct combines DMA mapping storage with iterator state, allowing
> > drivers to walk pre-mapped DMA regions linearly. Includes fields for
> > the DMA IOVA path (iova_state, iova_offset, total_len) and a fallback
> > per-region path (linear_dma, frags[], frag_idx, offset).
> > 
> > Helpers to initialize and operate on this struct will be added in the
> > next commit.
> 
> Let's squash this with patch 2? Quite useful to see the struct when
> reviewing the code..

Sure, will do for the v7.

