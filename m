Return-Path: <netdev+bounces-270127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NEdCDvpvWmKDgMAu9opvQ
	(envelope-from <netdev+bounces-270127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:41:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9AF2E29CC
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 801A7305DEEA
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D687E31D367;
	Sat, 21 Mar 2026 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo6ZdL+P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A702311967
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774053601; cv=none; b=pPZr8wRVRWt3Be0w0fJoSRckJKyzHRSSrEQpk/olyV+bhQa9sp4DzlUqEVv268eVNe6zsalu889HfyQI0t3x5ieQTdJo84fBlGqUDigqpPlSqj4cNd9DPsB+pFChaDKEi0BpA8T/QR+qRqsHJFWjsviIp/snhnfyUjsDq9Z+VdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774053601; c=relaxed/simple;
	bh=yXs+s4BvdFYJYm2dbaHRIlcd9JxSNaE2rtcDi14iUJ8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SblTc7BQPONUcj/X+4DMlkNoWdRvpratNKpbeNqMosm/86m8wX2hIQfq5GqF2bbE+8lpPXNhD4rGo4Ys+5jWSb0jukY0e0LaSba9i9R0XVmJvoN+jgSsJVRtwa61x5VXjcQwbSMyQ2vXNoST//FsDmlKjAS7VAVJZ2zwNf2gtIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo6ZdL+P; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a5ad7cc52so27295917b3.2
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 17:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774053600; x=1774658400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZYPe3Fzt4XiWBzmxWxCmd97onqN8khEvECVztrT0eg=;
        b=Jo6ZdL+PPtu42RMyQ181vEsfhHNF+Fxqa8jwHlH41ms8mjuDU91yNYiMbxeWJb3wxG
         fZ4mmdIt3UdXZpTxtp46RYazm8aNFYraf11bQw0reX7EX6vja+LBg7UlTihtSsnrcNgI
         ruQGFtZNSvUUn+8J+Q3wEAFDcbOhHQqX32JuNcEyxnq5K65eSpTYMsw+fgbzrWRKUfF0
         mgChHASSkTtCSH5UN5KuOgu6HCfLPyThDzNyXjAwBhjJK6xcH3WQ0acG3vdasJkuHsLr
         7L9ReioOhdS1q+eShGt0QcIKtroAQjXvnUXsHG86vkuAiyvUS+p+5Fh+xr/DpyKlBq4f
         DCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774053600; x=1774658400;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZYPe3Fzt4XiWBzmxWxCmd97onqN8khEvECVztrT0eg=;
        b=kmaHd58v0CWfa34v4RfNgVFIOB0d/eX5YdfSDMY9eKBmQtgBaLi8Q5GfDPUFnTY+hK
         SyijCnXL/d3CSJL5nwX9IgGjCAMdPsifMx6QSBainPayhvkUnY5FOfhcOgBL5ll643Rc
         I2XNc9f8UannWD/kN5v16XJ7ZXfvgojSSb6weDMubzWO7MkZaM31x/mEiqusw/+KaMI2
         RS7ILK6j/a4Pl64B4AXgPpLsIWdcMM5mOIWlZ1WE8rxa41qj2FTR6OSOLVuFzflHwSDi
         UTyF0GXCCz8k6u35s59Zy+SRzmOlZAUN803ueJ9JRmADMV2jAx5YXe1S6TE+HJvkPEHD
         6eyg==
X-Forwarded-Encrypted: i=1; AJvYcCWifROiVYQNJ6NpZbfw5BSctJUdGn4XtrQYlBgaqFPAS4KyZfwsLlqkm63l2cjJlDnwkx4S2Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcovvhxyShZz6pTceVKj76hl1REpIza+XYphJXVkIryXV5I6D5
	rN7agsUZT/cdEA3ziR+VMnDQtqeuMh8BbSC7UY5NjRX10/i4Ck/vuyDD
X-Gm-Gg: ATEYQzwLtQHZd5jz8B1sTJUowwk0Zo9iHP9s0siqtqCRcCe7BKcS7pibAKYpW43vkyh
	RhiGP2WV6T7mlk5FN8ibFtAVb/vWnevvd5ROxDKlQqYnOqmtn4OrJ25/XL8eDx9og+fN49Z8R1n
	MbJ5HO6RrHVWoSRsGI0NZM7Lg/onDZliuC5yl17WH7ZrU6ckVKcKWGw7+IqQ7niwAux30ayjGIk
	7K2EHWO67E7EllG//eXt9S/jCPiYBPKS3lIyesnIThASP0ecD+NULIUItjjosFEBupI1Fm1swS5
	AxmX16RFE903r4imRQRT5vQ0KSLB5xhSEW7+7qFsCv1JIxqlK9N5T0cbPO7EEw3L8mBiedFLpG6
	L30fyHSmVKNF3zbg2PvReUdH+LBv/iMzD33CqwmudZTqIe70YDWNdhYRiionBjNqofTtZoJ8TQC
	/VOfqNdd9oA0nxl3YwxDYjMww7JwXRbTza1vn8egEBDtvPDEWVUkowgVocdo8hxdvbyMgsLs7ro
	1bI
X-Received: by 2002:a0d:dc07:0:b0:798:5b22:ecb0 with SMTP id 00721157ae682-79a90b09f20mr37919447b3.22.1774053599741;
        Fri, 20 Mar 2026 17:39:59 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a9054ee5bsm24336127b3.31.2026.03.20.17.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:39:58 -0700 (PDT)
Date: Fri, 20 Mar 2026 20:39:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.28a05bcb1c591@gmail.com>
In-Reply-To: <20260318134242.2725749-4-nhudson@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-4-nhudson@akamai.com>
Subject: Re: [PATCH v2 3/5] bpf: add helper masks for ADJ_ROOM flags and encap
 validation
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
	TAGGED_FROM(0.00)[bounces-270127-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,kernel.org,iogearbox.net,linux.dev,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E9AF2E29CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nick Hudson wrote:
> Introduce helper masks for bpf_skb_adjust_room() flags to simplify
> validation logic:
> 
> - BPF_F_ADJ_ROOM_DECAP_L4_MASK
> - BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK
> - BPF_F_ADJ_ROOM_ENCAP_MASK
> - BPF_F_ADJ_ROOM_DECAP_MASK
> 
> Add flag validation to bpf_skb_net_grow() to reject invalid encap
> flags early. Refactor existing validation checks in bpf_skb_net_shrink()
> and bpf_skb_adjust_room() to use the new masks (no behavior change).
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

