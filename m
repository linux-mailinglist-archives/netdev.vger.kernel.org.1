Return-Path: <netdev+bounces-258076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHe2CVYki2lyQQAAu9opvQ
	(envelope-from <netdev+bounces-258076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:28:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C6C11ACAF
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D75CB305B0AF
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5417E328B70;
	Tue, 10 Feb 2026 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qM4kkhHa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD613328B69
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770726392; cv=none; b=RDAcwm84uWnx3bdFDq94YsC6BAuz+J/d8BMw0E6ASqBTMP65frOVPZ43ChhEca33khDHpqfeqhXlx/X+ALps+EjsBNptDuBDDAYKZ78tUUrbZOyLY6K1UeAUAUujYOEDoaZfTMm/0xSMe5j+7pu0HUifd1prxp5Hb5vHXQkVZu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770726392; c=relaxed/simple;
	bh=YRb2HOzWgmU6BprpsCak/NLFtfG/xrxo/cn2EIBmiok=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UM17+HPg4qsuDLzXr0bgGLwQK2SrqXuADOcnDSvEY/DIQdP3VOshKpSuIgK6Tt1SorNp/MT5artMxaamIG3MB2MzPMcvXvNE7iFoJ7sGqCI4s6uobnewAqVbNVeXKIU7i1M/3WwbO4ov03Q5jEY+Vz1mHKHDTv3juhE/CkZzY7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qM4kkhHa; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d18cf89e72so551342a34.1
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 04:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770726389; x=1771331189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XB+eVCb0S1waRrWAonsVS/4kh4pOBDwTkWkVaXjSGw=;
        b=qM4kkhHa4fD8cH5/q7imRADcYbiiVVzSOHAPxfxpEDt01ZltikeUwvkrAhbz2O+ZvL
         tFELwheiyod0sWYjQ1xF6Gy2aBC6f4j7swmXDEeICUPBgLu9in/IiZPhvlasD5YtWvU1
         1EPfUB7x8izIFBYa1aPn1vUpL563ZoxFITCBmKrgd+YTtAbMdXk7MlRYele0D4xbMcCD
         nvPgs/HBzRnH7yDFbfdahulmJY1jWFUEvocgCAM5uFd5JwJzpTpjIeeRkP0F0wMidPYI
         W5xrC0WkUc0HUdqmzvQ9kNN9qgX2HDFpgDKRRKdacIpoieL2199nD6s11frnSjqs3FM6
         jISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770726389; x=1771331189;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3XB+eVCb0S1waRrWAonsVS/4kh4pOBDwTkWkVaXjSGw=;
        b=X7/LxkoP3gQvpolaOU/0cvNqUuOgir7HyDzseaC8haiB03DKzBxTQIjHaBJ0LFOZuC
         XZT6Eq1G8xPdmOn7UMVBN5qi2ea3WtYBLWSqECUeBI+8g+u2vEsQXLn+iSOf2885Doq/
         fZTAYb13fGRU5BcloNfwbYTebg85INZ7ccEY7Au6MwevmlhJXCQH2p8nh3mXBIa7nF/5
         L/lIUj50rI9rEXeA8//1j4kjku2ORGfyYQmitTyhVblxhHjRsoD9utMQEyI9/K0RzpWb
         Nfcykgn4RmLY8EvjZlGA6We9OJboNrp2M7XFdzOnQg3/YmkAXUlgjiguTo7vvKjHVcxQ
         3lUw==
X-Gm-Message-State: AOJu0YxAYe3/2x/Rw8HzllvLHTcJbLqh838DcUygBDXvfY7AOHNrS0qw
	1RDqH1Hj1ohb5iq58q4ouWg9Q+nj0Ls7fjqZ09caLnP9pP1ZZ8PhdVXK+aduHRHjSiJTMZfBgxz
	8EE210BQ=
X-Gm-Gg: AZuq6aI/tJ12I50fwIEC/DoSTiP7MGmuMvyOE07DqoC6mqTgJnJ6MxrCcEjO5Lq/Ft9
	wyCecTjywcbnAaLkEE2zATx/tvMkAlKyWiGndbouky1pOaRaoKk7QL9MYG04XSPL0dgV4WSDioM
	rJ0BLuP1RmiCo/S2O2u/1OO3PPbcPtCbPVpYST9IGfMtH/WnymoRLh4qEJFCvJegGvzvKM6X5Z5
	90QZsT+E7cUTPVBYoBDxHEinWU3iGgm0p54fTuil48zjf9CzwPWFn87F5yhrCExlvXOBsofcrNG
	fgmxlA+yyVfD4l3a2exLM68wZI5Emil8EEIylDQFcGYwEgeSJJwB7DBveojRb9PiQtkjJW3Wnl1
	mm99REYRXRg98wrcgFJIHux7wL6U+pzyJ1wvegmiqGropKf0RqfuPn5/QHzWGGMNYZxFRgwh8qG
	PuOT6DAOsdmvzMighind/HVOcDO6XmDrJPAwaQih07VBCZkK1LSLbqHX/Ne15A4XiId9PPuNtkZ
	+5S
X-Received: by 2002:a05:6830:6ad9:b0:7d4:57d6:956 with SMTP id 46e09a7af769-7d4641ebc6fmr7923836a34.0.1770726389077;
        Tue, 10 Feb 2026 04:26:29 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d46470dab9sm10115924a34.10.2026.02.10.04.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:26:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org
In-Reply-To: <ebd70ad4ce36d8487ac994ed464b97aa08d8ed3b.1770314615.git.asml.silence@gmail.com>
References: <ebd70ad4ce36d8487ac994ed464b97aa08d8ed3b.1770314615.git.asml.silence@gmail.com>
Subject: Re: [PATCH io_uring 1/1] io_uring/zcrx: improve types for size
 calculation
Message-Id: <177072638785.481609.146411505603287880.b4-ty@kernel.dk>
Date: Tue, 10 Feb 2026 05:26:27 -0700
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-258076-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B9C6C11ACAF
X-Rspamd-Action: no action


On Thu, 05 Feb 2026 18:04:43 +0000, Pavel Begunkov wrote:
> Make sure io_import_umem() promotes the type to long before calculating
> the area size. While the area size is capped at 1GB by
> io_validate_user_buf_range() and fits into an "int", it's still too
> error prone.
> 
> 

Applied, thanks!

[1/1] io_uring/zcrx: improve types for size calculation
      commit: 417d029dc412c1028bce3d4685700332c0539a95

Best regards,
-- 
Jens Axboe




