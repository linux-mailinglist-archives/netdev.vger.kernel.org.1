Return-Path: <netdev+bounces-292799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOpSCYWLGGrCkwgAu9opvQ
	(envelope-from <netdev+bounces-292799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:37:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BF25F6683
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 286EB3010C03
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC163290A5;
	Thu, 28 May 2026 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhRq8O0d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE62512DE
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993146; cv=none; b=OBTT3CkiYncF1u8E4LF/3jiRgNbfrD2R/lzMbktkTX6g/BUSeGxwK8rkguBCwNOgMfscWFy4/oAXP8ow27N6UCOrNsKEyJFN0gBpCeAnb9iqlM5qK51jGZ9Uqwd5qhNmVOwfCHdQJBvHfdD+6pB0mn8X46u7A/kdazIRyM5FiUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993146; c=relaxed/simple;
	bh=F6dv8TPWW/13dGP+ZBJhBGuAWttYv01S6yZqJ9bd55Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1aRUIIGjNE3yq5XPEvJHGGl2W9HqT5sk5A8QhAG9q+YU6w0FUfpDjY0HGdnEQdpbl+1yvmqLUbE9NocRPv8XhgbXTbYySrwYJjYJhP0k+AqRo6lRVbNO7YFniSmJLtAaqseqozShwtyng5NI3XHN9dl0laUGLn0LXriyRY3ihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhRq8O0d; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so70423245e9.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 11:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779993143; x=1780597943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YgIc6FFWhSDaSLL/Z7NgL4wbq54EDyvmvF+ou2yO3wM=;
        b=RhRq8O0d+RlqfQgi2bF8cVzCvpgalFUFq/BidvQine5M96J7A+pLHzGlscGcY2bOM8
         Bo4LOgxw3NYi9k/8Z0mqLkkVjg+hJ3KfxTOKRJ6+wZVfshKZmYYd7RCSJN//IO30I1jU
         j0OM0gF6sGQQUzdhxTg+/sN9wg0TUW7VbRv0LnYkx2CscweQrHzDMXajHVrhcNg4/+Yt
         BIpAqBm/rxdT8SC2tgv46A6Y4CnbhpFXlsvcd33wVHz+Z5LGFZoCfIUeU/tsGv91b+yK
         tAE9HsB16EwQfKNKbFKhM4gRnPBiwmZVuah6ztKaMre0Q31ymt3T2hcn35oA5Bo2MG87
         GWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779993143; x=1780597943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgIc6FFWhSDaSLL/Z7NgL4wbq54EDyvmvF+ou2yO3wM=;
        b=KKKH4MgjGuYHAjSOLC+YuaPipDsyWtxuY+Hwjs9EwxQbAFMEHx1ykI4kwSLb3IsUia
         LKmnhySEU7IzYafhH+FjAH3khoBWmmX8VScRVJh+vUOA1y57DC8/GvDiuIdtoanp5+6X
         8lzff0iyZGI036vQW7bt3mKWjAiGrWAIXQkN67DqAItEerOkus0dBdK5n+/P4FbnQKWU
         OKRXUTDV2mQ1FmV8USGN0DhamalR6o1GMYoLjOuHJVsTj+XrnZQzYZIurjV/qvEv0AEF
         IK6g2ueDYKCcVlE/PaFoVOSKBanK8cEEHoGOBN+4LgdYtzUv2rzpPYb5qpOffh755+hL
         Nf3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9iYYCcPVsbEGRGrxyNBqhhh1W/7S8PN5Ahn5tq3WAnsBd4OK9MnlHeIj8QuVjaDM9dOmww9v8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrytxf3njsB4G/gZZ7K46NKYEj8oXfMEV3v+3wRNTZZxbBJhyx
	rF5RJ8Df2HTHyd4C67uPtDz8Mb1a6DCRUyfsc2YOjF2OH3B0BbZOS4RM
X-Gm-Gg: Acq92OHGfKYLsR+vi2W+WXrXP5SrKW/qwo/bnmdAJj2mtuDrUhUJ4tmJaP6RMykcLoS
	bSbBHVpuQjLKtUQPJrdIJSXBdNuaB/DCLRtymPsvvrBDvwaeiUvAxLLv/CbPZFpHMYoSHooc/AP
	IqnCGWtaXloM+dwGNJeWBPOFwA7l+c7OZ15RLwUE5ANZS9gLf0yLGm1s6tyWdtdln7vQ+gru7lZ
	gXJMx8Om76GBcPnkUwhu57PJd9PJIbihrflOXwZDLRB5ZPLXLaOMrXyEgyyahnvcN589FDlyRG9
	GeoxBAu8HyOEnCGZ+QtMlvGQ0CJpiVahktHzmb0AWtHzH3ZvaMZ1LmC3nAoFKqN7bvd5uosyJ52
	EJzVG7OFk7FG0igPt+t1rMkjwx0bZK83AULQvoJOVZ5lBlYiylpwF5/bxF7o4US+bIgJczK7Nr+
	CMlT098y4W0JqakEPXMxrD/eWzIISkhwm+Mcr6YgpBS8H8ubtfIo16Zjc60+b5GpgzUZf6o7s3O
	UiEErMnFPOksOor04Qd8yZJjh+3g29ICa9e1+mpjSkLSEkHpvJtxX1gLAOZ/OLzuiPs5IXpV5Yz
	OfcT1ZVrb6vN
X-Received: by 2002:a05:600c:c83:b0:48f:d612:3c4a with SMTP id 5b1f17b1804b1-49042488b81mr468589175e9.1.1779993143226;
        Thu, 28 May 2026 11:32:23 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909235d4e5sm78490035e9.2.2026.05.28.11.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 11:32:22 -0700 (PDT)
Message-ID: <5f63fd24-a0da-4623-b449-1e749c3e2085@gmail.com>
Date: Thu, 28 May 2026 19:32:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: skbuff: fix missing zerocopy reference in
 pskb_carve helpers
To: lazyming <minhnguyen.080505@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sowmini.varadhan@oracle.com,
 willemdebruijn.kernel@gmail.com, w@1wt.eu, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, achender@kernel.org, mst@redhat.com,
 jasowang@redhat.com, Willem de Bruijn <willemb@google.com>
References: <20260526041240.329462-1-minhnguyen.080505@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260526041240.329462-1-minhnguyen.080505@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292799-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,oracle.com,gmail.com,1wt.eu,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 68BF25F6683
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 05:12, lazyming wrote:
> From: Minh Nguyen <minhnguyen.080505@gmail.com>
> 
> pskb_carve_inside_header() and pskb_carve_inside_nonlinear() both copy
> the old skb_shared_info header into a new buffer via memcpy(), which
> includes the destructor_arg pointer (uarg) for MSG_ZEROCOPY skbs.
> Neither function calls net_zcopy_get() for the new shinfo, creating an
> unaccounted holder: every skb_shared_info with destructor_arg set will
> call skb_zcopy_clear() once when freed, but the corresponding
> net_zcopy_get() was never called for the new copy. Repeated calls
> drive uarg->refcnt to zero prematurely, freeing ubuf_info_msgzc while
> TX skbs still hold live destructor_arg pointers.

A bit late but lgtm

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


