Return-Path: <netdev+bounces-290850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJV3KlVhEGphWwYAu9opvQ
	(envelope-from <netdev+bounces-290850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:59:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC7D5B5B7F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 463D030F52E6
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6F1423A7C;
	Fri, 22 May 2026 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTVqZKX6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7253D1A83
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457467; cv=none; b=pSXGkBxIFvxZnz1t9tHBbPoO9S/lntDj6PdtXDnLKwJWjGRMG1L2YcxOFvf7zRmNMjLtD+N65oBH2d/Dw5w9h6XWvCYlmRJkG1WHHESlubzETmRkwL+YLLwCPo1A804d+0Bd+xQtgGYxqg1enEb3maX4f5rtpUUyvzMMQlqGn30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457467; c=relaxed/simple;
	bh=5la0D/R7CJ4PfmB6OsvL8OiyVTJizo/jhlIOOzkCkEY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IRwy0d4hrPkc1s7+PRBdrj1+gp2IagQ2MkRGRi+bHC3McFg242UJJAzJ5ytyi0O+Ibegx9lO7ctgV1AedNaKfnO+2jJKa3GQnnSJ7EDYdaSVDGBaitYI+qpDHUem0yacmfKTp0xK+F4ADBFvgBZ/hMhImbiJmGd/kOsd2Cz2Wt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTVqZKX6; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bd9f61458eso54881627b3.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 06:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779457457; x=1780062257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nuM9CpdZSF4/7l72HqNTMm6D+ZaatVl7iUT+72HqVk=;
        b=fTVqZKX6cGQ95OYWvmMRir96F0BGBHvwmQPKD7PFC30MdYJziLi+5+F/93w444J7o6
         Bo0xik+GDGaYfWmAjaNvExZCyJvqN+MW6lTg6HFq3uPyfUk2ZgbxDp9xFoREzDUzrzZi
         Tq3yBUKHS57pe/8JXyYyQsF2Tt8EUXbLXlMt03SH/joXu0jM+tT3Tm5wu5sa2iOsmlNo
         2RLpH5fWsvlxpn5BzFG1MtoHISh+4HcvEN6cXeOI+GrG5/Uvucj3ENpu6VvjmwjWm2xk
         bhS7K6UAGvNYR1BX6R8MTl6x9NKeALGgs/RHj3LqBTUKyT2ty52DI6HMpzxN9cyuyjgZ
         /3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779457457; x=1780062257;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1nuM9CpdZSF4/7l72HqNTMm6D+ZaatVl7iUT+72HqVk=;
        b=YkkSF9Egn5kkFLKQ7mlMMcpdMVsOs9AFQUepYCgSeexArSiC4Ug+tbNlSClah0JjUU
         pnlRgEq3+wAK4WbcNzdffqvlPXzPQFQTqJtvVtRrIfO752R5DN1OfJLQqM/Ry6d9aBIp
         g6RQWJWdIeR7D2vsPZDM1Wk/2Kz4I0ZiK1NicX9vTM88H1nO4wjnzmN8YQ+IJqlxld2/
         tH7rlgWPtAggidox8xuF89XT+MYkM8nQGR3J/mkiuWIqznflT1/VS9Gp5ude93VTKgyE
         tXTLMeU636vxVKh3tQlulIBBGBTIEPmNx1F+g/l9hI/I2dadjCMzfwRx64jZR1ukHVqO
         8R5w==
X-Forwarded-Encrypted: i=1; AFNElJ/jCHf41r1wg31mkKwH4eLJ7sWZ+HLODnwgCq0QIdmWwK5wc7uJpC8X3+B3XtjuSzjUt7Lveq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY7FkJq2v1pd+VpPKF71PluijrBiQTaXMCW9TQRFcFnL86l0Hn
	U/f4ZKX311rSKr3EkL0sB7TlgrpfnpkQu7eL0/iMxMsdSk13sTT6FiFz
X-Gm-Gg: Acq92OHdOFT7LcoEPKRvN5vxuvG3Udy/fpZxtuEc27hfAi6XO/g5q9EPg9p4Dvf9JX2
	i/3Nkn1zRQTHG+lmNtS7/JXA5t/4PHJebcg0MEz4lxpHo55BBptUI+BxFsewj5cnSjl/sPANf38
	hRN4zRuKTY9UBui+F3hP35TlR3gKVWNSBPNNDii+MQg0KzbcV0IImoI7Cb40iuWH1hTYLwdZJCG
	+71FBDKr/aDqREdSjIPZi3/mu5JG9kNm7P8/GKFc5atn7B/XS4RKHIgnNorkrxxUKs0rYHgIngc
	wDyFGXE5RRXLmHZKHW8CdOWaFDGmumTRLmKMzcQRAQ7+GDoGZ4wtibvt+qIAUWMAxLq2FN5OXLM
	iQf7dtwVapR6cJW8dToo50MCgy2QOvjDBLgiE7BIh29N00JsuM/iYw9iDsHxXq1xYWDPTFBTrib
	/E8GmwaXlwO4S7auBKBMHb38n8U55CqxSSRIyfMjfjSIaFxmF5pw0AMQLVzVpLhDwwVaF7AzeQt
	7hKvvuQsrDKf80qwg==
X-Received: by 2002:a05:690c:d0f:b0:7bd:9899:f904 with SMTP id 00721157ae682-7d3368b4ec8mr41250927b3.39.1779457456882;
        Fri, 22 May 2026 06:44:16 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d389819068sm8218937b3.3.2026.05.22.06.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 06:44:16 -0700 (PDT)
Date: Fri, 22 May 2026 09:44:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 pabeni@redhat.com, 
 kuba@kernel.org, 
 edumazet@google.com, 
 dongli.zhang@oracle.com, 
 xmei5@asu.edu, 
 linux-kernel@vger.kernel.org, 
 Weiming Shi <bestswngs@gmail.com>
Message-ID: <willemdebruijn.kernel.3f39321c1a11@gmail.com>
In-Reply-To: <20260521163230.1478627-2-bestswngs@gmail.com>
References: <20260521163230.1478627-2-bestswngs@gmail.com>
Subject: Re: [PATCH net] tap: free page on error paths in tap_get_user_xdp()
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org,google.com,oracle.com,asu.edu,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290850-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.264];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 0DC7D5B5B7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Weiming Shi wrote:
> tap_get_user_xdp() rejects a frame shorter than ETH_HLEN with -EINVAL,
> and returns -ENOMEM when build_skb() fails. Both paths jump to the err
> label without freeing the page that vhost_net_build_xdp() allocated for
> the frame. tap_sendmsg() discards the per-buffer return value and always
> returns 0, so vhost_tx_batch() takes the success path and never frees
> the page; each rejected frame in a batch leaks one page-frag chunk.
> 
> Free the page on both error paths, before the skb is built. This is the
> tap counterpart of the same leak in tun_xdp_one().
> 
> Fixes: 0efac27791ee ("tap: accept an array of XDP buffs through sendmsg()")
> Fixes: ed7f2afdd0e0 ("tap: add missing verification for short frame")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

