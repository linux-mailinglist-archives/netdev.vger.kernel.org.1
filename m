Return-Path: <netdev+bounces-269445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JSzLlb5u2llqwIAu9opvQ
	(envelope-from <netdev+bounces-269445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:25:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 514402CBEFD
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C643031D5AC6
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C624F3D47CF;
	Thu, 19 Mar 2026 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEeQUDwl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161373D3CEB
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773926683; cv=none; b=gTaFyGdkQi2Fpi/EzLGHepnI/hI/psz+hLojgpfGQRHwoEbrg9WqEc0fcaNRRex3OjDmU38ip0j6fFhTWlWNILgNdk65Umkw6AZlgRnyDkJRDfBH0D4qM8QWXn7lG42ku9t3sOU8EGrh0VrNa3hElc2WblhlGMKznC8zODNaEwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773926683; c=relaxed/simple;
	bh=SkpLpeOLfCj2GU76XmFx4ghYmRIZ+1PVqfByjE+H/pU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EusselZo7rVUMbGJ/bgyFGD/Wq0iQbpC7Gas4mbf4Suca49es9tZ1XVNJU9eo7De00Pt2jP1k1l0m4lFJ2gKOMydMj3xIL8+JFYayBgR3ywnmbLbFlRU43D8PLPYkMYLDmlQ9FN5oYU56XnUPps5Dra05E2qo88hRNM7TuSR61k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEeQUDwl; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79495b1aaa7so5198737b3.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773926680; x=1774531480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9RQ6JRYqSbn2WRhZy8MD11g0JCaQRZZDGdfPYjhOb8=;
        b=gEeQUDwleBLzngzsiQuqZFuVmGf1MLghWw7ruAE9MqnuU2rnDLZ8doLjWYGamvLQuV
         QGwptRjAN7J+6ILObk2Vg6GOVRcz12rLbbQWorjxV8NbHYN/PIX1jhj8J6t/RhOErR/9
         AR/QIHapdRS16PtdQ1gcmRvrHZu78sYgFk4G+lwfA2l3iK8c/mWhohzlaJCbisa3oa25
         vPinHDo/bxAS6Id+bGBdZIfIMPpqX7zfX+idDrg0rftKyNP4joGN+35WbbfWy8fsPnCD
         hjWQbpCnpDDNh/PysgzYfBr84zVmK4F3AtM4PcW8dxnm0HtNsW94tpckLQjB+UtaAdD8
         TfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773926680; x=1774531480;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9RQ6JRYqSbn2WRhZy8MD11g0JCaQRZZDGdfPYjhOb8=;
        b=ovut+/JIW0efvixxZU/ljiXvogzgfj9ZWS//vltG6ObzevfCm2VkHQYqfksi/nKTV4
         NIz7LaG7KfN+tQ4xfIqlMVVWqYUzrCVB//C9ojURe/f9Udtquzrh0lKDb0qHEqDv5BBl
         b/JuiYdQ24uuV2HBuZNBVkPbct9aYBSm/grSO2YcYVAu7DffMFM5E1rnG6SaTNAFv0qc
         vOyzGLdVXHXhK4uxjW/8m06WkA81oF9JsIGmEGeE2m9IOWqMK0ecGKq1qL2VvzOQG6h9
         GIorfeEjqTQYD5q2+ZwxdqnLF9U3DiCkaiTsX1ylo5xp9PqujUN/ca1VAVDl7hPdaZR4
         AVRA==
X-Forwarded-Encrypted: i=1; AJvYcCUMioqRPoKrGNb9pY+0XA0qyPiXcQYcl9HsVmgmTv7e5Bm2gnSqYWcxNtgfMdFTa16ZUt7sBh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQFt1W4ve05bEzc+O3n6IGNZJvHAOjFjRg1QbIWII/2Qbh5rxS
	aZRfJz5TzGz0mNPXGcimOCdrcV0lYoqSDTJL369M5MX9ngV4pno1nk1e
X-Gm-Gg: ATEYQzxwhL+bbwBYfMhwau4EGhZfSKZW2FKBU9c4bIamRTAT/T33RiI9QOcSiEl3AGh
	ZnuT+crwruv5j7ya3AX9aA+fAVQ02fG9XK6mzM5XY2diKZ6ypRX628xaVnzVPfc1rP5/7axvDLz
	TVfZfkfn3wTPPHB3Um8qXXjcLMMsnC4GrLKMbldqdrhl8YfdnadH+oAfgGLfEaCla1eP8w0iNGJ
	1c/i6JIXY/BGt5ZpAq5Q4owQiYdK4qq7EMBCYeUNyLk2Todks2wpWWvDPkrd/QtqUK9fP0oJRv8
	kU/Ih6Nj0B/Dx6UERSMEiLYbedRFYnBqJNFoCHiHiFnNZLGm/SaK6MNNFlCDuY0NInKBsUwToMB
	2mEng1CS6Ry5r7UcHw2h0UPrY2ExYf0KDsy7TzPIBlEAYLLI65A1jTZCbnKXf4zWU0bxH4FB7Fy
	0tRmxQeNIiSsCBTYNLxM1zJtHXFpKf2QNrTDzfPnUJDS7NC3826mD7+K3wDuxSH24NZ01F5dOuE
	tn6ACS+TadxRT8=
X-Received: by 2002:a05:690c:358a:b0:798:7907:5cf with SMTP id 00721157ae682-79a71ed56b6mr75059467b3.54.1773926680000;
        Thu, 19 Mar 2026 06:24:40 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a715d6acfsm37639657b3.40.2026.03.19.06.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 06:24:39 -0700 (PDT)
Date: Thu, 19 Mar 2026 09:24:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Hudson, Nick" <nhudson@akamai.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "Tottenham, Max" <mtottenh@akamai.com>, 
 "Glasgall, Anna" <aglasgal@akamai.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <willemdebruijn.kernel.18a884569c72@gmail.com>
In-Reply-To: <03A3369E-0F7B-4708-92B9-B335A6F86976@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-5-nhudson@akamai.com>
 <willemdebruijn.kernel.26b750d5f8926@gmail.com>
 <03A3369E-0F7B-4708-92B9-B335A6F86976@akamai.com>
Subject: Re: [PATCH v2 4/5] bpf: allow new DECAP flags and add guard rails
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269445-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[akamai.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.245];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,akamai.com:email]
X-Rspamd-Queue-Id: 514402CBEFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hudson, Nick wrote:
> 
> 
> > On 18 Mar 2026, at 20:02, Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  This Message Is From an External Sender
> >  This message came from outside your organization.
> > |-------------------------------------------------------------------!
> > 
> > Nick Hudson wrote:
> >> Add checks to require shrink-only decap, reject conflicting decap flag
> >> combinations, and verify removed length is sufficient for claimed header
> >> decapsulation.
> >> 
> >> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> >> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> >> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> >> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> >> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> >> ---
> >> net/core/filter.c | 47 +++++++++++++++++++++++++++++++++++++----------
> >> 1 file changed, 37 insertions(+), 10 deletions(-)
> >> 
> >> diff --git a/net/core/filter.c b/net/core/filter.c
> >> index 7c2871b40fe4..47aec44a9cd3 100644
> >> --- a/net/core/filter.c
> >> +++ b/net/core/filter.c
> >> @@ -56,6 +56,7 @@
> >> #include <net/sock_reuseport.h>
> >> #include <net/busy_poll.h>
> >> #include <net/tcp.h>
> >> +#include <net/gre.h>
> >> #include <net/xfrm.h>
> >> #include <net/udp.h>
> >> #include <linux/bpf_trace.h>
> >> @@ -3496,7 +3497,9 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
> >> BPF_F_ADJ_ROOM_ENCAP_L2( \
> >>  BPF_ADJ_ROOM_ENCAP_L2_MASK))
> >> 
> >> -#define BPF_F_ADJ_ROOM_DECAP_MASK (BPF_F_ADJ_ROOM_DECAP_L3_MASK)
> >> +#define BPF_F_ADJ_ROOM_DECAP_MASK (BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
> >> + BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
> >> + BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
> >> 
> >> #define BPF_F_ADJ_ROOM_MASK (BPF_F_ADJ_ROOM_FIXED_GSO | \
> >> BPF_F_ADJ_ROOM_ENCAP_MASK | \
> >> @@ -3743,20 +3746,44 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
> >> return -ENOTSUPP;
> >> }
> >> 
> >> - if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
> >> + if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
> >> + u32 len_decap_min = 0;
> >> +
> >> if (!shrink)
> >> return -EINVAL;
> >> 
> >> - switch (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
> >> - case BPF_F_ADJ_ROOM_DECAP_L3_IPV4:
> >> + /* Reject mutually exclusive decap flag pairs. */
> >> + if ((flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) ==
> >> +    BPF_F_ADJ_ROOM_DECAP_L3_MASK)
> >> + return -EINVAL;
> >> +
> >> + if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) ==
> >> +    BPF_F_ADJ_ROOM_DECAP_L4_MASK)
> >> + return -EINVAL;
> >> +
> >> + if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK) ==
> >> +    BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
> >> + return -EINVAL;
> >> +
> >> + /* Reject mutually exclusive decap tunnel type flags. */
> >> + if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) &&
> >> +    (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
> >> + return -EINVAL;
> >> +
> >> + if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
> >> + len_decap_min += sizeof(struct udphdr);
> >> +
> >> + if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
> >> + len_decap_min += sizeof(struct gre_base_hdr);
> >> +
> >> + if (len_diff_abs < len_decap_min)
> >> + return -EINVAL;
> > 
> > Should this test come after the below IP flags?
> 
> Should it?
> 
> Seems to me it can bail early without having to check the IP flags. len_decap_min vs len_min.
> 
> What am I missing?

I would think it common that UDP decap also includes an L3 decap, in
which case the len_decap_min should include both header lengths.

