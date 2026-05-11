Return-Path: <netdev+bounces-286816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL6rNho2AmocpAEAu9opvQ
	(envelope-from <netdev+bounces-286816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:03:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8167C51568E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82BE03016B4E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4483242AB;
	Mon, 11 May 2026 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgEMHgcc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052DC2E8DEC
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529814; cv=none; b=gpRvnqyNkMNjC1x1EmmGF3PSbEknVIttNPEXZ90PTTt+1ReYPipZm6+R+SR17SkF3XD+/sg83s8yoJi74WlIZv8puN+LqzOFXlvu341vG3Bne5vWnn52AvFdG/uNSu2ySyFGklPw+YKFZRO/0IFWfwR7y8LZLOtmjDtIEsm9l10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529814; c=relaxed/simple;
	bh=/rh78K7dEQaIt4xTNNU+9/Uq8c+lZYbvjEGX+x5v/zs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=J9j1rgGqlryb0eLEhX/+VEx/lKxOE5gSruy1GAYmvSeWLXoh6k2P/bX9OlnmNV0ArpsV4K01ivHmoZbm5RrgewZtqAaGP2k3ZhPs4n7yBN70qGJGinGna5o9yamFjrMwYZ/aELwd+oTG7Num2FSEBMEeb2/K5UWOom8AIiaXWjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgEMHgcc; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7bdec52f48dso66212987b3.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778529812; x=1779134612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df5H5F48lqO775bsK2qtaTIF/Zsa3yd78EW7E45MHkg=;
        b=PgEMHgccMChTSJ8iTQEvXXMJKjF1wAVgCfKJJBHzzlutdwydePP7hRcoV4pqO1N8I7
         N+HfNz1jKpOmlr/A/A8ySvca4sZvq00R4tA3Cbo9/zSCKPSDl3GpyZ+Y0Yk90Jc3pLmZ
         EIvOP/UyDUy5xLT1AgN0OXNGO1FHK289phyBqZ9s93zjITrZauVauyt+u+W8sjeKZql4
         mu+fdRb4IX5lX9eWAocUu/8N2s81fTwlJC/JhQiU1eMtdbz05iMwtkVojG2a4tbt2cs4
         rrbqAc4zRvRQ1385B9ZRkbJB6Nq54Qj//yRFTHddhzywuXxUcxAWSwX9Lkfuom7b1s6B
         az1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529812; x=1779134612;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=df5H5F48lqO775bsK2qtaTIF/Zsa3yd78EW7E45MHkg=;
        b=fr815rOEI2D/4BLMtC/+zkfIOS/b8BUE2Jfr/ZXSi4Qb53EpB5du9h8sfpk/dsaHfx
         Ree0Jpd/l3xd1UvPx2p931eZv5uDLE0tbadNMAc8AmdXsHMLbGFhpw5QjoMU2VISpHCM
         Lf9YFGZlDM3qYdFRw/jokAVVe4naAcGmQmhvUTLSFOsEg3yjtClEqFN4icN2dO5JlsgW
         g+IABR4Lov3wpNouPmm/5EIVxIf5+rjai2OwStXhW4KBgbQ7LFBFShcaTPuC7x5ca5Gf
         mkWkXSvd7RfaOvV2PC+yG7nDmlzylVnMOkdNsJaOcdr131MipaHpK4QyxnW3t3h0lOAE
         jVGg==
X-Gm-Message-State: AOJu0YywmpOnXZiXq1heKrQkw/ALvfH72T5SJ0ztjRpxFTc2qXMX0BRj
	hsNhcQAmXbPYQmOwv6Q5GNjn2VhBynLMUCDK7W/t3nfqrMmgryOSq/pz
X-Gm-Gg: Acq92OEZdhM+WPeuf0GDhWcwKEOi2Bea7CxhaYgprYH+xVvTCQqTVTud1UGI1fFCXAZ
	Run7CmeEuVqwe62gGgpA61b1ofIO+GmciKcyKdIWnMnGOuuLQLg7snYcSDyccyaCbvoZSsK4G8a
	7QB2ViXtfR6qAtPCS0iZPEV2kOK3aCP/llRrFow1Eo/Ds/yRHRhXtRMTBFzMPkSDQKHOl2Q7hnc
	mUcE5X90IjToCdcCNgvCdl8gowdDQwKEECvw7laV4vEbGO8smJ/aDzGQdgQCyHWaZbaD3rkxnZ4
	n3F0A3Nr9QiyWZUqgVNopjue7J0+Oso2e3Qq3RmaU18jAdUx17UyTSYsWXxiVpg9qAJbEjZu0fF
	XQ+OyZ1Nt9/AxYwmE0p0BcMmpF+B5nfcqiBuB+g7sMB9/VgJFSbyMl7EFVJZEQC9xiHfyctMpit
	myXGU3DkxDYCyPg+Jd8v+6x8vqd/8sb1rujv2SAvtPl9ABQfW40SxwBwspH58O0hzgZ1hanE4xd
	5/a
X-Received: by 2002:a05:690c:13:b0:7b3:b0a6:2c60 with SMTP id 00721157ae682-7c50db32344mr9885957b3.1.1778529811811;
        Mon, 11 May 2026 13:03:31 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66888cc7sm152269757b3.44.2026.05.11.13.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 13:03:31 -0700 (PDT)
Date: Mon, 11 May 2026 16:03:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.255240af45e5d@gmail.com>
In-Reply-To: <20260508-nsim-psp-crypto-v1-3-4b50ed09b794@gmail.com>
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
 <20260508-nsim-psp-crypto-v1-3-4b50ed09b794@gmail.com>
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
X-Rspamd-Queue-Id: 8167C51568E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286816-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.986];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,psp.py:url]
X-Rspamd-Action: no action

Daniel Zahka wrote:
> nsim_do_psp() does PSP decap and skb extension creation in the tx
> path. This has the slightly undesirable property of not allowing the
> psp rx code to run on PSP packets cooked up in userspace and
> transmitted on a packet socket from the peer dev (e.g. packetdrill).

Whether this happens in the nsim_start_xmit tx side handler directly
or is deferred to nsim_napi_rx is irrelevant, isn't it?


> This commit instead triggers the psp rx path just based on parsing the
> received skb. The current code relies on a bit of a hack to simulate
> authentication with the proper key: the peer's psd->generation was
> placed into the tx key, and during decap used to fill out the
> extension the packet before being sent up the psp rx path. This commit
> removes that hack, which creates a transient break in psp.py test
> cases that rely on this behavior (e.g. data_send_bad_key). Subsequent
> commits which introduce real aes-gcm crypto will restore the correct
> behavior.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

> +/* Returns true if skb was consumed, false otherwise. */
> +bool nsim_psp_handle_rx(struct netdevsim *ns, struct sk_buff *skb)
> +{
> +	struct psp_dev *psd;
> +	struct psphdr *psph;
> +	struct udphdr *uh;
> +	int payload_len;
> +	u32 versions;
> +	int psp_off;
> +	bool is_udp;
> +	int l3_hlen;
> +	u8 version;
> +	u32 psd_id;
> +	int err;
> +
> +	if (skb->protocol == htons(ETH_P_IP)) {
> +		struct iphdr *iph;
> +
> +		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
> +			return false;
> +
> +		iph = (struct iphdr *)skb->data;
> +		if (iph->ihl < 5)
> +			return false;
> +
> +		is_udp = iph->protocol == IPPROTO_UDP;
> +		l3_hlen = iph->ihl * 4;
> +	} else if (skb->protocol == htons(ETH_P_IPV6)) {
> +		struct ipv6hdr *ip6h;
> +
> +		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
> +			return false;
> +		ip6h = (struct ipv6hdr *)skb->data;
> +		is_udp = ip6h->nexthdr == IPPROTO_UDP;
> +		l3_hlen = sizeof(struct ipv6hdr);
> +	} else {
> +		return false;
> +	}
> +
> +	if (!is_udp)
> +		return false;
> +
> +	if (!pskb_may_pull(skb, l3_hlen + sizeof(struct udphdr) + PSP_HDR_SIZE))
> +		return false;
> +
> +	uh = (struct udphdr *)(skb->data + l3_hlen);
> +	if (uh->dest != htons(PSP_DEFAULT_UDP_PORT))
> +		return false;
> +
> +	psph = (struct psphdr *)(uh + 1);
> +	version = FIELD_GET(PSPHDR_VERFL_VERSION, psph->verfl);

This seems to reimplement a lot of psp_dev_rcv. Is that needed?

Is it a hint that this psp driver API needs some work?

> +	rcu_read_lock();
> +	psd = rcu_dereference(ns->psp.dev);
> +	if (psd) {
> +		versions = READ_ONCE(psd->config.versions);
> +		psd_id = psd->id;
> +	}
> +	rcu_read_unlock();
> +
> +	if (!psd || !(versions & (1 << version))) {
> +		skb->ip_summed = CHECKSUM_NONE;
> +		return false;
> +	}
> +
> +	psp_off = l3_hlen + sizeof(struct udphdr);
> +	payload_len = skb->len - psp_off - PSP_HDR_SIZE - PSP_TRL_SIZE;
> +	if (payload_len < 0)
> +		goto drop;
> +
> +	skb_push(skb, ETH_HLEN);
> +	skb->mac_len = ETH_HLEN;
> +	err = psp_dev_rcv(skb, psd_id, 0, false);
> +	if (err)
> +		goto drop;
> +
> +	skb_reset_mac_header(skb);
> +	skb_pull(skb, ETH_HLEN);

Similarly this is a bit of a hack, pushing and pulling a fake Ethernet
offset.

And is this skb_reset_mac_header needed?

> +	skb->decrypted = 1;
> +
> +	u64_stats_update_begin(&ns->psp.syncp);
> +	u64_stats_inc(&ns->psp.rx_packets);
> +	u64_stats_add(&ns->psp.rx_bytes, payload_len);
> +	u64_stats_update_end(&ns->psp.syncp);
> +
> +	return false;
> +
> +drop:
> +	kfree_skb_reason(skb, SKB_DROP_REASON_PSP_INPUT);
> +	return true;
> +}
> +
>  static int
>  nsim_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
>  		    struct netlink_ext_ack *extack)
> 
> -- 
> 2.52.0
> 



