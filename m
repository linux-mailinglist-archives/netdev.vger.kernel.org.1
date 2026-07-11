Return-Path: <netdev+bounces-306899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WW23DtqjUmpfRwMAu9opvQ
	(envelope-from <netdev+bounces-306899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 22:13:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 969A1742C98
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 22:13:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SlH2KY1C;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306899-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306899-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88475300E5E6
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 20:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913FE311C2C;
	Sat, 11 Jul 2026 20:13:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BC52C21FF
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 20:13:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783800791; cv=none; b=iMfzBcPAXA1oPMdRG5fbhWRrgOrcyvb+2kZjfrLlWiHybu9tDwhUOIMGcDTkPcw9YbhsOqF7hC+eZtvVp529Tlqw8qZBbbnAvZm3gsFkRxe6nMuB++yTfim33kMhopGaRec4rAyEa4PEUZjPEIG12LduigR/Yfq5mUmI6uwBviE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783800791; c=relaxed/simple;
	bh=Ra+bHi0h8wGsmlICGkEB7NUeR5lIs5ENI5i9Jnis7kA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=D/8kVS7TnT9r8mC+LjFs+KQgOo7BoJq0zUzBl4zO1WES49QoLbplyCdo2AgJNqvL8oybOrhTVFpozMsfWvQGc9xyz1pK/++7ldCaAqSfErmuic9dLtf1iGfqKVOyHuR1C1vq2UuWzxMqtha9h+EshmJMDm4+Z/MQ55TJTEjIc9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlH2KY1C; arc=none smtp.client-ip=209.85.128.177
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80a1fb0c683so26406467b3.1
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783800787; x=1784405587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uN24kay8P3eNSzcBkcSHouN6HCZ/VnkG1NS4ZZCkgd8=;
        b=SlH2KY1C1mbcidtgsd0A+7aGr9zMihz5xxOsW00ydAujemjXBI4BqoJ0WUOhQz9CCD
         Q/Zhl0Sy24SqLxSzSZ19An746DjNBFUn3JS1peZg3Ru3ISIWF9O+5T0TGNYuATX8ScQp
         sl1zhf/VvYtp5WkTArLP1LOgB1XhLjYOqqk37NFNZZbRusFmNmtrCmBI0BjC1em3xMY7
         Gt/E0mQJcP21UcT17p0E5tFAKc9L3q8naiI8Onq+IXbraFwY3J1XGHXmpYkmGQxcRKem
         TmZq+asQovS6554mNfgAkyG3mS0v+XQ5Ci6GeJxUk+E0Jod2WdWra2f7VV6Fl4wdDF3t
         TTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783800787; x=1784405587;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uN24kay8P3eNSzcBkcSHouN6HCZ/VnkG1NS4ZZCkgd8=;
        b=ejmKZj26Pn21bWNan9zy+988/L/fHwFwcIVZ6iZJumXboXcN3fvPdoJcRlPbDHqnsH
         s9/k+YV+jovpHaV/E/SH9q2seKqa7YpQImPp/GEsSXPnhND6+1JxcdGhMsVWYGLAnp6f
         tzDEBW37cYeLmZyXDdiKxFs7FqnpzMOGMJNaVVjsOVgaTHka1Jo1v1EBmsce6cdOqsij
         YEizCUyZeOCZuOlZ50O2iKzzf8Nb+ChljqJTbNo9zVo8HMJlAkFRt2f9BJOtXny9iEzO
         zrpFl0LukAq11otNUTiBESN5h4L/uAFSIbSjbdSkyJXydfbn9YxMBKBKwX1IN31GGwWI
         snkA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6n9tYN3iqXFmSe+a+NMToHxH/BrszrNndmf1L7X4kf8HDEEw7TCqN36lFRTk3VuC/BMA9n2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7+Ag7FkvgQwiVgPkb+Ke3fV2dkDqFfK9RKrs8/OrEv0ia0TF
	eI5xLhq30Typ2XGNgHBWoSZb57AwMVt8fl3KHIG5kBTL3qr7S9cg3B+o
X-Gm-Gg: AfdE7cmcAzUL3CHrJ0pOx+RE/dKqzmzQMZJBMMSNenOxKigDMm9V9nCKVrqhd2XNqQy
	qOMS7PnJMfkwWuaHRpytnJJ4eyGrRU5E6x8pSbYXbqtP6UtymNVgfzOPPHfMA84l9AZgYUmJvZQ
	VtN4Ozhmp9XgWSdeHozTDleZ1at+3rpEWHiRHeCPFRtIOKCC38LG+VHgzQcHB04z+7WJf4UvsEG
	VV+sjn8a4DeyHkJNhq4LjI6Lyo8a5lBfwPRfySLxvYtwCb0zFqGFTjGgr6xvYCMiWiJzfZJj7uF
	976uJEBv6UWHWtyxqMRKlHMU9gUxMTHEhbQ4H+8TS/INFuT+R86aen9L4rLdnWXkEMQpPFmE7zb
	aaQyz9vJZENDex9ym9vuHMbVwoQtMf26LquTZK2g4DrmH8SH62Hkp6U0zN07yq0keAaa9Gx2bGh
	BpR4ezAVdSIxo+Rvl3LC1VbmyLW66CD2dMghzqf4KnKix9CvONBAtsz2DyzR5noQvIEawOJ7+OR
	q0E
X-Received: by 2002:a05:690c:1c:b0:81d:9452:715c with SMTP id 00721157ae682-81e90004cadmr28515677b3.20.1783800787383;
        Sat, 11 Jul 2026 13:13:07 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c22ed8esm77067007b3.44.2026.07.11.13.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 13:13:06 -0700 (PDT)
Date: Sat, 11 Jul 2026 16:13:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew@lunn.ch, 
 Willem de Bruijn <willemb@google.com>, 
 Joshua A Hay <joshua.a.hay@intel.com>
Message-ID: <willemdebruijn.kernel.3e2302b5fcd6@gmail.com>
In-Reply-To: <4e86865a-a152-46ef-9f0b-74dd42b7cf66@intel.com>
References: <20260706133433.3142805-1-willemdebruijn.kernel@gmail.com>
 <20260706133433.3142805-4-willemdebruijn.kernel@gmail.com>
 <4e86865a-a152-46ef-9f0b-74dd42b7cf66@intel.com>
Subject: Re: [PATCH net-next 3/7] idpf: support pacing offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306899-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:willemdebruijn.kernel@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew@lunn.ch,m:willemb@google.com,m:joshua.a.hay@intel.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 969A1742C98

Tony Nguyen wrote:
> 
> 
> On 7/6/2026 6:34 AM, Willem de Bruijn wrote:
> 
> ...
> > +static void idpf_tx_splitq_set_txtime(const struct idpf_tx_queue *tx_q,
> > +				      const struct sk_buff *skb,
> > +				      struct idpf_tx_splitq_params *tx_params)
> > +{
> > +	const int ts_gran_pow2 = 9;
> > +	u64 ts, now;
> > +
> > +	/* Skip if netpoll: not needed and not safe to call ktime helpers */
> > +	if (netpoll_tx_running(skb->dev))
> > +		return;
> > +
> > +	switch (skb->tstamp_type) {
> > +	case SKB_CLOCK_REALTIME:
> > +		ts = ktime_to_ns(ktime_add(skb->tstamp,
> > +					   ktime_mono_to_any(0, TK_OFFS_TAI) -
> > +					   ktime_mono_to_any(0, TK_OFFS_REAL)));
> > +		break;
> > +	case SKB_CLOCK_MONOTONIC:
> > +		ts = ktime_to_ns(ktime_mono_to_any(skb->tstamp, TK_OFFS_TAI));
> > +		break;
> > +	case SKB_CLOCK_TAI:
> > +		ts = ktime_to_ns(skb->tstamp);
> > +		break;
> > +	default:
> > +		WARN_ON_ONCE(1);
> > +		return;
> > +	}
> > +
> > +	now = ktime_get_clocktai_ns();
> > +	if (ts < now)
> > +		return;
> > +
> > +	/* beyond offload horizon? set overflow bit only */
> > +	if (ts > now + ((u64)skb->dev->pacing_offload_horizon * NSEC_PER_USEC)) {
> > +		tx_params->offload.desc_ts[2] = 1 << 7;
> > +		return;
> > +	}
> > +
> > +	ts >>= ts_gran_pow2;
> > +
> > +	tx_params->offload.desc_ts[0] = ts & 0xff;
> > +	tx_params->offload.desc_ts[1] = (ts >> 8) & 0xff;
> > +	tx_params->offload.desc_ts[2] = ((ts >> 16) & 0x7f);
> > +
> > +	/* 0 is valid 24b timestamp, but also means field unset.
> > +	 * Add 512 ns (ts_gran_pow2) to avoid this case
> > +	 */
> > +	if ((ts & 0x7fffff) == 0)
> > +		tx_params->offload.desc_ts[0] = 1;
> > +}
> 
> Slight nit but seems like this check can be moved before the assignments 
> (and then return) as we don't need to assign the other 2 bytes in this 
> situation?

Thanks for the reviews. I'll address this and Paolo's points in v2.


