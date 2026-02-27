Return-Path: <netdev+bounces-261956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGIZEH/xoWnYxQQAu9opvQ
	(envelope-from <netdev+bounces-261956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 20:33:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B60A1BCD79
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 20:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C730B303A882
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 19:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F0A44D008;
	Fri, 27 Feb 2026 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1X1OldCe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD544CF51
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220793; cv=none; b=aYT3HqS5mwtHgWdGDo40jxcCCFjzmHSI101TvyM6LABNo3nAR9O1GrOAcGcjOhqI1SXCQyWq5Flg+RwpJM2vRJ7LVvHvUMeHKjbbAErAwsnrTHXOZwr0u9Xrqwd7dUXZqZ1hrrsOacGBV7/D1rq3kjfWPBh/bCrzZA+G3LZrJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220793; c=relaxed/simple;
	bh=S4WdxBoSFmfJsmtzwU9/+jBMzeHEFzoLSWqHQ/oztJI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y9OfeGg1ImawPnTo5rkB7uroDkGLgtpyFPFJvK9zlDRgjrFlR8i6CXG40y8cHYEVvgMSPBsdmqVhbokJ9Y3Om4VxHHdCbmH4nGsQvR7erTY+qWBYlPSGK0yhoZTHkTrmYBOMSsTRbk+BiRC8wYlx0lA/q8FDVSgSpgBDN72bk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1X1OldCe; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-679efb9eb0dso1802608eaf.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 11:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772220790; x=1772825590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I72P8NX2zIzLVHc9Smmzo8h4IvPgg0/X8dsbl8+CW3I=;
        b=1X1OldCex4/JPZOpIy/JkuJLRFosKdFsiDcLrZ0aBLZaSALtPtUtGSlRwAAF97Gjt5
         pf7zgo1epiZRJhVW06C09Oa+0dERandX2x6rI9z2G94YovIx7J1diU2ZFQeIdTkTx17j
         wQiy5tKKtHKPqcXJT6P/uzE+4yRvKzIbZdH4nvZmsqmxrGCZR+GembW3+wcRFbAFYc9B
         4gsbZhU3g0+fPmG2VVd33DlOQ/95Sriij35OF3w3AGZ1xhjRHW4F0ZiJ2pq7D/Axg1aU
         sXrig4BeuUYe+JB47HkQq+NK2kFI86xWlKW2xYdhUujiPdnCdxMVk5I0OkOTs6gQsCfW
         R5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220790; x=1772825590;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I72P8NX2zIzLVHc9Smmzo8h4IvPgg0/X8dsbl8+CW3I=;
        b=E25wbYVRF7tqLp0+sIeyxcOn++oDIQDzYL51xUeNFlZOAedBNQHYHpbRkOyahRvbVq
         EzRRhoh0W/Gxa3Nor7UCC/CgVW/dJDxnfii5w4N/ZN3j41VqKGzcJbOTHZLtPDuEhRBC
         weMxtSv7Vqi7zDcNaty7ABho7gkC8JUEZnSkQKZZUXxmlsvB4HwlvpaPta2pt+7n3xMe
         1+sgaq0/e4M/CMhR/cGE9DlBK1OZy0BcftzdulQeAySQOJ6gkYYsSRzBb9f2QtIyrXKM
         ny5Ftsk+LK4amfL1md7kXdfNFTTGazck1xHvdcSIXNcRnT6s9qHkMMtIFmM4+pLxuats
         o2gw==
X-Forwarded-Encrypted: i=1; AJvYcCUW+YQHRcssQpDQ263hwCNrHA7cNhmrII37vptCJmlLR8nG1aIwYbnsx6M5t5lRnyBSBA889CU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7OtovCP04fObKbxXIw8rVmy68aDhxSQ6f9BI9ly6Tgqwk/nde
	zhXx09CwZVvwzgkOHBkhRGjvJImoFWaqzq+F6hLTn3g77tvRF3aw+VNTV3XRIL1rqvY=
X-Gm-Gg: ATEYQzw228GrrKwWZrKVspgfT9lGmDSujZ+7h8k2ey7pejV+Hp0PhM8Bjbsj+0AwMZ6
	XYSWrbzmzR1pnm5oP3JgzspYPgEm5PJReK/os1cneI1f4Z2GhyUyXvpdQN6+SXLVavq+5eNMixO
	oqMy4afH8q+iHYkNng6n2A4RAqfOgJpfMzXdAOnToZTsw/K9sws2syv0LfNjk5gTA2OxXGHFy0Z
	cyn33LofXOdVE8JoaAKztnR3l5ok+4s2QIIHcz1uWpxbblYnZjrHGM9ijlQWib5kARvvwcUo9nB
	w7opTCkuMWVolt/54+7VcbIj+ndyh96s/gO/BwHiFQLd5gCz6Opl/NuLtPBnqKN/V89GAahq4Kl
	XKB7KivnZu3XzJVgjaEvgTca/wnhwCD0rvqN9f1g2PRQMxp3JrdCXV+3TCCjnfVSZRgqcE7vrRa
	aS3cmtpql16n16rUxoiPK8/XPTylqnnVkIwE86XTb7BR1JWRYjGM3gwMydArZNR5zUifPahpG83
	GYf
X-Received: by 2002:a05:6820:2226:b0:679:f6f1:8063 with SMTP id 006d021491bc7-679faf96001mr2489233eaf.67.1772220790033;
        Fri, 27 Feb 2026 11:33:10 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d20ec7fsm5478145fac.11.2026.02.27.11.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:33:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: asml.silence@gmail.com, io-uring@vger.kernel.org, 
 netdev@vger.kernel.org
In-Reply-To: <20260227170745.2845550-1-kuba@kernel.org>
References: <20260227170745.2845550-1-kuba@kernel.org>
Subject: Re: [PATCH iouring] io_uring/zcrx: don't set rx_page_size when not
 requested
Message-Id: <177222078925.1175759.14027962125344899947.b4-ty@kernel.dk>
Date: Fri, 27 Feb 2026 12:33:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261956-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:mid,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 5B60A1BCD79
X-Rspamd-Action: no action


On Fri, 27 Feb 2026 09:07:45 -0800, Jakub Kicinski wrote:
> The rx_buf_len parameter was recently added to the Rx zero-copy
> implementation. The expectation is that when not set system will
> maintain previous behavior and use the default buffer size (PAGE_SIZE).
> 
> This works correctly at the iouring level, but we don't preserve
> the same "zero means default" semantics when registering the memory
> provider on the netdev. mp_param.rx_page_size is unconditionally
> set to PAGE_SIZE. This causes __net_mp_open_rxq() to check for
> QCFG_RX_PAGE_SIZE support in the driver, and return -EOPNOTSUPP
> for drivers that don't advertise it -- even though the user never
> asked for large buffers.
> 
> [...]

Applied, thanks!

[1/1] io_uring/zcrx: don't set rx_page_size when not requested
      commit: 3d17d76d1ffb139a7492317b196ee03c8eabc9dc

Best regards,
-- 
Jens Axboe




