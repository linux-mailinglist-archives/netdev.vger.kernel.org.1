Return-Path: <netdev+bounces-205122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B07AAFD752
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F012B485108
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2D92253FD;
	Tue,  8 Jul 2025 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmnWVovS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281D2223DCE;
	Tue,  8 Jul 2025 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003762; cv=none; b=G1egZLzW7UiuV2TMv7xN9Q1xBe/FWuaN4FWSmb1+6aQa0msQmE8bj8iTIKLkIrWNCndIEVTHR3PiZZl6JvlTKIOSHI8wfyZk7z6OcgLUKukGJChxc+Ee1PavBQOB9NHdl20VplMG/NkFEf3JDX506o2X40optqJicu1SlZaxu50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003762; c=relaxed/simple;
	bh=KSXceJjAMr56s8WXO0XKjA/vLlZ2ha6l665Xolaq4MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5jjIrRExVhctVATdbkxSPuuB1vE2CNKEn5MYeUNABSkYDSxeIA9K7s8tA9CT0VH6osxD2zf0LCpj1wfA6xQiRoR8ZwBEeTlIHGgRzW9VW57u0nXlSqCRxbEtG1MjGccdnq6pVukghAN6OdXIwt1xrO31s5tY/h/Pw3Qy0M4wMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmnWVovS; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-747fba9f962so239656b3a.0;
        Tue, 08 Jul 2025 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752003760; x=1752608560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8aD/dc9IrY4KhoC+qCcjIEawTLQLfUWAYgOgwipip0g=;
        b=YmnWVovSutF8fRnCRmcnku5HJJoU17MKAlPMsGL9lZOQErsRoe6iogzSIRTdgKtK2Z
         Z3kpn6LmwDgYwOGT+GC4x2cbPg3RzXQKuI8B2KU3iubUiKxgT3JhCGVxHa/+4BmJzEYT
         5Jd7pN4NkAoibTmk/m7FZHNct65mUD0D7xP4IieRrKRRZQTbRZdJwWFXhX+ysodtv7MB
         O9HG9s+qNB5rgqYJXbvUtvGt8QX/qMNv1EfcyGjOKvrUXZN6LzCmiddh6aLcsatEf0zN
         4EWKhbz/TN/PxslEuucvH098oK5BhwxcPgLUsZ3x4nKPSKNtLCskuvtMlg3RGqCyfBF+
         Hp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752003760; x=1752608560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aD/dc9IrY4KhoC+qCcjIEawTLQLfUWAYgOgwipip0g=;
        b=eDFt4za9qlmfYh13GWjgKLzG1Yo9SQgHuDe0Te5LsNAusK9TQwqrO7iEsZge3/u/uy
         G6CstsO0uqIhQh3VJj+qjw1J/7ffJJKVVYDItZbEuPF2lKk+D5gVu9xYOipwk/SPPtkB
         tHuenFLU07kDedDoGkVFj5zFCbpTFU1OsUqOczwqFHPtMawHQLZQVtEIgCRRaIQfgwlP
         ofiL9gLwTUQl5sDHEHRqOpNq5DiD3acxeSKlWE4tc8VDkw9MKAZJrlka856XlpXukZf1
         A574Qt27W8TkOdZj522NN262ecNaGqYLTCZ0wwkBtO5IYyKwnkkJFLK+Dfz9OSHNllLs
         jvuA==
X-Forwarded-Encrypted: i=1; AJvYcCVY/drVjPbvu+mkiEawyDzv/ccCNFZaJT4g6srhmn7zo0qpz99hpKlne0tTCR6LufvS4K5cPi8DekL1Fqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm271zRH6APvNXiCTO2KrGcfKZJ9caMYmgBH6HjRYtdkHLAvYG
	QpzviJpiJO0MGvJagh/FlYiSLKOw9zw6YpYPKT/PQ76mprh1KgC7V3FR
X-Gm-Gg: ASbGncup6cSou7lZCN1b3SvF13aPA2PbFUUBFmWhnYN65XadB3/DkzG2m+PnMuNDpDY
	YtNmDipI3QNy6Td1mJB3pPWa8ENbJs/tduH5s9FhUp1H4+6k9ZmV7kgUTij5CarhPuFlQ4IoXiW
	cAfyfJ+GG1KKGoGgdHy1VnkqMLjNJ0OYRmAHIK19vNyZERiN1K0qMd2EaHFjKpFjP+YpAidkJUD
	b7/1bvzIeG4nJRDDbklJQec7GK5XS3AsRjkWqi7THiJ72meJBEc5bjM8Nf54sr9FVK8eIfCa23i
	iX+SsGJVjzEcNgsvhKMxNOnulMvxi/hKPbFx9rG/rWr5iIrp3pIub7cJeK6EFP8DOQ==
X-Google-Smtp-Source: AGHT+IFvPpyAkt8nBD5KnsmBx1Pixva+deEadP3F4seU0SRDJfo3lLxsotjkEeHHmjcSwUcLWLgVbg==
X-Received: by 2002:a05:6a00:1903:b0:736:4d05:2e35 with SMTP id d2e1a72fcca58-74d2673784emr4964522b3a.3.1752003760210;
        Tue, 08 Jul 2025 12:42:40 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417e8e6sm12651239b3a.91.2025.07.08.12.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 12:42:39 -0700 (PDT)
Date: Tue, 8 Jul 2025 12:42:38 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, victor@mojatatu.com,
	pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org,
	stephen@networkplumber.org, dcaratti@redhat.com,
	savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: This breaks netem use cases
Message-ID: <aG10rqwjX6elG1Gx@pop-os.localdomain>
References: <20250708164141.875402-1-will@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708164141.875402-1-will@willsroot.io>

(Cc LKML for more audience, since this clearly breaks potentially useful
use cases)

On Tue, Jul 08, 2025 at 04:43:26PM +0000, William Liu wrote:
> netem_enqueue's duplication prevention logic breaks when a netem
> resides in a qdisc tree with other netems - this can lead to a
> soft lockup and OOM loop in netem_dequeue, as seen in [1].
> Ensure that a duplicating netem cannot exist in a tree with other
> netems.

As I already warned in your previous patchset, this breaks the following
potentially useful use case:

sudo tc qdisc add dev eth0 root handle 1: mq
sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem duplicate 100%
sudo tc qdisc add dev eth0 parent 1:2 handle 20: netem duplicate 100%

I don't see any logical problem of such use case, therefore we should
consider it as valid, we can't break it.

> 
> Previous approaches suggested in discussions in chronological order:
> 
> 1) Track duplication status or ttl in the sk_buff struct. Considered
> too specific a use case to extend such a struct, though this would
> be a resilient fix and address other previous and potential future
> DOS bugs like the one described in loopy fun [2].

The link you provid is from 8 years ago, since then the redirection
logic has been improved. I am not sure why it helps to justify your
refusal of this approach. 

I also strongly disagree with "too specific a use case to extend such
a struct", we simply have so many use-case-specific fields within
sk_buff->cb. For example, the tc_skb_cb->zone is very specific
for act_ct.

skb->cb is precisely designed to be use-case-specific and layer-specific.

None of the above points stands.

> 
> 2) Restrict netem_enqueue recursion depth like in act_mirred with a
> per cpu variable. However, netem_dequeue can call enqueue on its
> child, and the depth restriction could be bypassed if the child is a
> netem.
> 
> 3) Use the same approach as in 2, but add metadata in netem_skb_cb
> to handle the netem_dequeue case and track a packet's involvement
> in duplication. This is an overly complex approach, and Jamal
> notes that the skb cb can be overwritten to circumvent this
> safeguard.

This is not true, except qdisc_skb_cb(skb)->data, other area of
skb->cb is preserved within Qdisc layer.

Based on the above reasoning, this is clearly no way to go:

NACK-by: Cong Wang <xiyou.wangcong@gmail.com>

Sorry for standing firmly for the users, we simply don't break use
cases. This is nothing personal, just a firm principle.

Please let me know if there is anything else I can help you with. I am
always ready to help (but not in a way of breaking use cases).

Thanks for your understanding!

