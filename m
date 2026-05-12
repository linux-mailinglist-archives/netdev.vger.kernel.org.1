Return-Path: <netdev+bounces-286890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dzxAIJp5AmritQEAu9opvQ
	(envelope-from <netdev+bounces-286890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:51:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E5F517FE3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 02:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0D423021995
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 00:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2533623372C;
	Tue, 12 May 2026 00:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1xZLS8x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E0522F74A
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 00:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778547094; cv=none; b=f0Pu1FUvrljlhQ4kc5bS7CYGiLCwiyJHhYXsoKFn77DRgwEsTobZSX3k14BPHJv/9O0Ud5rttYObnAdO6e6rvwWcYY2W2kFtCAlN1KeJmcURTQfyN7G/aIIZkeZfz4XybOOF4urtt5J6g8TAfHM8tiTPi37FWt5c9THNT9Dc3rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778547094; c=relaxed/simple;
	bh=f0RRwhVwZZY0XRS6uTtiUkwdoDW0fO8pPZBXqz2/eOM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IzVsKtKwp2ka/+YK9Q776DWdzoQjAiVk2aBcd6pblqnshK9Hd7omHKfT8CBkXg4wVaBCsQH3D6M0pxe8gdgSD5UB2hb4rfUCjVkM1MhSKKFFqjjN03I2ysi+lhHRSAHPODs+XqCx2JIuUkNdbWoI8LZCVg+d4Pyh8mIAwcFDRnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1xZLS8x; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7bf14e33f5bso44164417b3.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 17:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778547092; x=1779151892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zziufg3DXdLJHPbUcdcMN7kXgJx9C/jwfLS4a4Ly0sw=;
        b=g1xZLS8xJdRtCEV0JR9MGKUMi2yqWthQR20n9gVvDyEulEgEt1dS1AMc0UYZMD64jP
         uJgh7TgsuWeZMNxi33r47uUBrvZ8xf+8Z0m9NnbWknAYx8FSXGjJ9Rg5ZGaUkZQD7epz
         qRGnKmn7ovyhz80pusP9Cwr2PAuTXBmkCFxPgIlqHvHX4XsXswI/7gkQEQwO3CSrazYj
         SOfqD9iJ6Uu3UHBnOXiofnf5c6zpKlfq/HCN8U/M9FPUC0+pY2hKv9iUnVs7RD1nX3n0
         WUUbqDfXq/UrR7fuVgJ8nQCXxsM5XHnoOzbqqRzV8+AkDD69ufzjdolElU2+rAu2ySAf
         yCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778547092; x=1779151892;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zziufg3DXdLJHPbUcdcMN7kXgJx9C/jwfLS4a4Ly0sw=;
        b=M8qIuryIXA/lihY2G6b/R0gFdi05n9riwn3/nJLmnTfIBRrq8+PjVkVcRnTrRu4E1F
         +TQjAJxX7AiAcUFGVS6p3sytmqssBII3Bz0pQIiDIspc4wnYBjnvuu2N/KaH7ynOczpU
         tF1Ce5gvZBWSYfxEb0CsDv1qGsT+MOEOmX9ezGjYdoYXgZ8pLBIRAVLDU1wt2iaOJdG3
         Njjb0A3PIqqoZ7XHUtGazG0rCqvdZTurWhpr1Mbtd6D4bi2E38XzzLCFmQYP4cLsSC3e
         P8V9V38v1KtOBGAOMR1XQ0JYKbgAI5TUFTIpgOgyzvixFavCJef5rxPRKD6x3zkG4nD0
         Oszg==
X-Gm-Message-State: AOJu0YynQWt6v9q+ZXj3gEv02hMmBYtaPIg2OVuCVc+pdQuQSVyGMvfR
	+dLoBwpm4Twmgdxf3MZCOCIOzRjTNQIQYVUpdlPh43BKdJCEAJJop9u7
X-Gm-Gg: Acq92OE9LT7tOrEZH5hyTP447WtnhRt9pvdn79/k9AhnF1S6p0uAzaXj+KpK7vZW9mk
	SGLrY5ou+wXy6BZ9OGbgbKXT0gpvm84CmOudErTro9CaHRHqN5NZoIHKC6CQIL5x0aGWcxdms5I
	iMO8UrNoWfIkJ9cEGQgOuLi1JlisF1P3i54hFJnPx6V3jd9uNpvwpgoISFOFSyRhr2X61QIypwG
	TzRSeyZAGFJeqbF09gnkxL3aEBzPhXwthhQtrMIUO4CBow8zg9QBH3dPxyf6GBNL7bCyewSkA8V
	71L+2q47SbYyUi+VABbIm3em4xn7BxEh3q2cVhC+fc5QC2y2aOC7TkzkXakkEWWYs97c2K709xA
	ehiWfMCJ7wcuVQ7XUNOV1iL9qtdfRoNRwuSvJ2ByOeXmSpQrtKAfTHIFbD1pSg0eb51rrQfkUEp
	Ap+LMcAsLtC8IZjfm1i1vztsWmFbq9A4qsHwRkEw4Lugp20YXiRGkB56cZxvw5JvY3u2yNk/gMu
	VKl
X-Received: by 2002:a05:690c:e3ce:b0:7bd:9f34:5998 with SMTP id 00721157ae682-7bfb9aa172emr168105257b3.34.1778547091734;
        Mon, 11 May 2026 17:51:31 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6683836asm160318087b3.25.2026.05.11.17.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 17:51:31 -0700 (PDT)
Date: Mon, 11 May 2026 20:51:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3467d6902b8a2@gmail.com>
In-Reply-To: <a3aff385-4c40-46e7-9ad9-d64f399750f6@gmail.com>
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
 <20260508-nsim-psp-crypto-v1-3-4b50ed09b794@gmail.com>
 <willemdebruijn.kernel.255240af45e5d@gmail.com>
 <a3aff385-4c40-46e7-9ad9-d64f399750f6@gmail.com>
Subject: Re: [PATCH net-next 3/6] netdevsim: psp: move rx processing into
 nsim_poll()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E1E5F517FE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286890-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Daniel Zahka wrote:
> 
> On 5/11/26 4:03 PM, Willem de Bruijn wrote:
> > Daniel Zahka wrote:
> >> nsim_do_psp() does PSP decap and skb extension creation in the tx
> >> path. This has the slightly undesirable property of not allowing the
> >> psp rx code to run on PSP packets cooked up in userspace and
> >> transmitted on a packet socket from the peer dev (e.g. packetdrill).
> > Whether this happens in the nsim_start_xmit tx side handler directly
> > or is deferred to nsim_napi_rx is irrelevant, isn't it?
> 
> 
> You're right. The way netdevsim works, it is entirely immaterial. I'll 
> correct the erroneous commit message, but I still think having the decap 
> code in the napi_poll side makes a little bit more logical sense here.

Agreed
 
> 
> >> +/* Returns true if skb was consumed, false otherwise. */
> >> +bool nsim_psp_handle_rx(struct netdevsim *ns, struct sk_buff *skb)
> >> +{
> >> +	struct psp_dev *psd;
> >> +	struct psphdr *psph;
> >> +	struct udphdr *uh;
> >> +	int payload_len;
> >> +	u32 versions;
> >> +	int psp_off;
> >> +	bool is_udp;
> >> +	int l3_hlen;
> >> +	u8 version;
> >> +	u32 psd_id;
> >> +	int err;
> >> +
> >> +	if (skb->protocol == htons(ETH_P_IP)) {
> >> +		struct iphdr *iph;
> >> +
> >> +		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
> >> +			return false;
> >> +
> >> +		iph = (struct iphdr *)skb->data;
> >> +		if (iph->ihl < 5)
> >> +			return false;
> >> +
> >> +		is_udp = iph->protocol == IPPROTO_UDP;
> >> +		l3_hlen = iph->ihl * 4;
> >> +	} else if (skb->protocol == htons(ETH_P_IPV6)) {
> >> +		struct ipv6hdr *ip6h;
> >> +
> >> +		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
> >> +			return false;
> >> +		ip6h = (struct ipv6hdr *)skb->data;
> >> +		is_udp = ip6h->nexthdr == IPPROTO_UDP;
> >> +		l3_hlen = sizeof(struct ipv6hdr);
> >> +	} else {
> >> +		return false;
> >> +	}
> >> +
> >> +	if (!is_udp)
> >> +		return false;
> >> +
> >> +	if (!pskb_may_pull(skb, l3_hlen + sizeof(struct udphdr) + PSP_HDR_SIZE))
> >> +		return false;
> >> +
> >> +	uh = (struct udphdr *)(skb->data + l3_hlen);
> >> +	if (uh->dest != htons(PSP_DEFAULT_UDP_PORT))
> >> +		return false;
> >> +
> >> +	psph = (struct psphdr *)(uh + 1);
> >> +	version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);
> > This seems to reimplement a lot of psp_dev_rcv. Is that needed?
> >
> > Is it a hint that this psp driver API needs some work?
> 
> 
> It could be. I'd have to split the parsing from the decap logic in 
> psp_dev_rcv(). I just wonder if another user of the two separate halves 
> other than netdevsim will come along.

Fair. Why does this driver need it. Only for that version check? If so,
can that move after the generic decap.

> 
> >> +	rcu_read_lock();
> >> +	psd = rcu_dereference(ns->psp.dev);
> >> +	if (psd) {
> >> +		versions = READ_ONCE(psd->config.versions);
> >> +		psd_id = psd->id;
> >> +	}
> >> +	rcu_read_unlock();
> >> +
> >> +	if (!psd || !(versions & (1 << version))) {
> >> +		skb->ip_summed = CHECKSUM_NONE;
> >> +		return false;
> >> +	}
> >> +
> >> +	psp_off = l3_hlen + sizeof(struct udphdr);
> >> +	payload_len = skb->len - psp_off - PSP_HDR_SIZE - PSP_TRL_SIZE;
> >> +	if (payload_len < 0)
> >> +		goto drop;
> >> +
> >> +	skb_push(skb, ETH_HLEN);
> >> +	skb->mac_len = ETH_HLEN;
> >> +	err = psp_dev_rcv(skb, psd_id, 0, false);
> >> +	if (err)
> >> +		goto drop;
> >> +
> >> +	skb_reset_mac_header(skb);
> >> +	skb_pull(skb, ETH_HLEN);
> > Similarly this is a bit of a hack, pushing and pulling a fake Ethernet
> > offset.
> >
> > And is this skb_reset_mac_header needed?
> 
> 
> skb_reset_mac_header() is needed because psp_dev_rcv() shifts the l2 and l3 headers forward, and the mac header has already been set. psp_dev_rcv() expects the mac header to be there. I hear what you're saying though. The driver api could probably handle these for us, but I also didn't want to overfit to netdevsim without another user. I'll explore some options before I post this again.

Ack, thanks. 



