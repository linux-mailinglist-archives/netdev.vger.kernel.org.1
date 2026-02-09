Return-Path: <netdev+bounces-257884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP7sK8ZIiWm25gQAu9opvQ
	(envelope-from <netdev+bounces-257884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 03:39:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D48610B333
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 03:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18C6F30120E2
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 02:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC8A2D131A;
	Mon,  9 Feb 2026 02:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8Gl5npm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0893EBF32
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 02:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770604643; cv=none; b=lZdliML5nRGs38T9YUXcPwBHFMsmYDiYMtIQTJnT/fD8Tu6HivLRihBiLPVI+Qtsz0EOmVqUmE7JnDyuOj2F0GIQ4xvnm6CWELgr60doGUyejaI7mUhQYu4WXqjNykyDkBLDOvineBPaU6O/rb4dnZQ5tEIpgFiNwA38d9wzU+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770604643; c=relaxed/simple;
	bh=pRQAO/ZYBYUQ77y7rK0JvvKA04zg434VlWUpr7akJJU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VUHCKjYJzB77ROCvZqLcj/RrayLFKwZEsL3ZcST3FPjdgZoM61tqhbO9UdznoT3P1k80VlJiYODgdpV7foSpz0BLxR+ZRdU1/funbuED3s6aMuyK04UHVwYLqGZqYPL0PtsUAmyj1JrVCvJ4WtlYv2z+myiBj16aHo5q47r2Z3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8Gl5npm; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-649d4c77a32so3322577d50.2
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 18:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770604642; x=1771209442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/V4WyWhAAZkw5TNJuCQHRUvYWFPGZ8OrTECOGPh6Dk=;
        b=Z8Gl5npmF3h7BCvIlBv/pdDg14pBOhE7A0097ii0q4ziW3+5N36BhFE4j1+cpzG2yf
         cdTB2cL805tGfyxtCQQC6CU3bTStqPz3l4AKPwTXROewVrmtDSNxCQt8omTSMbGSfS59
         juAkqXrhv7bipf8K2Rx0/ApHj9AEaB0zbEVDOeZL47+nZrkxEvLmn9y8oFNOcNMbTKMa
         whuYLwmUGsYVr8fUV555PoinzLiDT/wSy4xoz+ne4MjXzzb/VvKrvt0iBLaGlhyZZho5
         UBqy9/Xw8NU7eWFGFeTpEUMLP4V4RJcrFIovsHg7Hh4tuBuK2PMrZBRNZuhcDsqrmnxQ
         aVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770604642; x=1771209442;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/V4WyWhAAZkw5TNJuCQHRUvYWFPGZ8OrTECOGPh6Dk=;
        b=tYOQe2KXp0GoarVaSWp8JCqHlJBwzDAfnXW1NGYamjkDfQmaybipd3no+hDBizkqRX
         ruhhB5ORkFDukwD4BLEb9dk3CXk4+oI25aoAjNE1yKthx1AvDby6ZriCnTgPidjQHdgr
         F+KoM47bor8XVlkVo2dUvx3X/qE5BCNNEciWD91i3Gzp6CZOWtmenUx+qFsDJuWe9B6P
         cFCiDFJZVCYPNAWP8U3LOTGSVj7YYjwik7DKG2Zgo6MiAGg7DQ1B2SniIi2ZcGW0ZPU/
         5CsfhQ6lK9TUE8GXjJpL6cqulNZG7C401WWx3Lu+zf9FQOTyEGPrcEfe9Kh+ZxiOkCWh
         KKXA==
X-Gm-Message-State: AOJu0YzZAKKK4ONSI/LlbOrg5xGvOakucOTKXVeSRvPfixzLDomWhVcx
	YnaQZFOO8h6nD2aX8tfEvngSwfgOJMkY6UFPNujZ5WeXrqYK4p4lGnvt
X-Gm-Gg: AZuq6aIOIQr7QdXicy11OMhXQBZklZSMTfZFOxwWPZ4OzwuTSd9hT9/7sGzpmoDWdmP
	GrS8Hta4kr2yzjqMLlM7Mf/li8kc5kUfi1VIcTaopcMmx5tDZL729mZD9+ckGkNhK7EUv+QJ5cq
	OFSiErzjRigFj078fT0rQBodZP8UDQ5m4dg3kB2U4rOb/oUKy212uF1D0lnntxfOONX6D08dhGS
	ZACSURls22YVTgk5Y/CM4xTLYMh6PRzkNf9HJ7JMex7vm6iYhKl1zW5/Wifh0yKNf8Oa3BgQ8ue
	FEHRKPgqBxgRAYB3IYNpOxhRg78tf6Ho7+x/Tu7uX866OKB2GhA6a7XUSwC0/kU261OgEJOqK+r
	G/JNrowH6VcPem6IfJcmauaqqgdQ+31jJ6+QWXr9ImxTvLhWBbz82ZSaYYYe9BXcsPRPQTVkNoZ
	vCgsanqw+Qg7JGPHFoWF3Vw5R2T5dNR0FEzU6AnTbT37XvRhX/CYiLi5yQtAB3PmR7Dh1JFg==
X-Received: by 2002:a05:690c:c50d:b0:796:4486:b7d7 with SMTP id 00721157ae682-7964486c022mr20245177b3.26.1770604641852;
        Sun, 08 Feb 2026 18:37:21 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7952a1db63csm80694087b3.33.2026.02.08.18.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 18:37:21 -0800 (PST)
Date: Sun, 08 Feb 2026 21:37:20 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 petrm@nvidia.com, 
 donald.hunter@gmail.com, 
 michael.chan@broadcom.com, 
 pavan.chebbi@broadcom.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.35e36b64302f9@gmail.com>
In-Reply-To: <20260207003509.3927744-6-kuba@kernel.org>
References: <20260207003509.3927744-1-kuba@kernel.org>
 <20260207003509.3927744-6-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 5/9] selftests: drv-net: give HW stats sync
 time extra 25% of margin
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257884-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D48610B333
X-Rspamd-Action: no action

Jakub Kicinski wrote:
> There are transient failures for devices which update stats
> periodically, especially if it's the FW DMA'ing the stats
> rather than host periodic work querying the FW. Wait 25%
> longer than strictly necessary.
> 
> For devices which don't report stats-block-usecs we retain
> 25 msec as the default wait time (0.025sec == 20,000usec * 1.25).
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

