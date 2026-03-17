Return-Path: <netdev+bounces-268406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sObiDUTGuGnTjAEAu9opvQ
	(envelope-from <netdev+bounces-268406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:11:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B36FF2A30C1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 04:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41A70300CC35
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C092C178D;
	Tue, 17 Mar 2026 03:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0nXchQH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A99C2C027B
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716805; cv=pass; b=t/TfJ98QyEiA6PzuS4yuiMzN2Os7Wjulcp175txtbei42Hss+UJCQRx8oTRFBY3KA6yR1RCanyM970ctjkUx7ezx3mH9yfzQGblzwbbhTEsvlu3wXh6ousTSZXVPUJv6rD0oCkmMZp6KrCHAbJkwgBQp52p1oRTgVaNi6YCf3oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716805; c=relaxed/simple;
	bh=KHyuNaMd/zewSaRimahrmp0hwQ4b9EQOYNegrTRKIpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGmMAt4I8N9dXGwhFf1UFZXIGCItplW81FHqIJblz+R1y4YyqmcmwXkHGtCXNftkwhW+AT/H9BV9XSbM/+oqasTwBsrTh+lD5pIgI0lu5WOsVE9oS/E16JRSlKTcXQtTNffpDdDc6/4Blu8UcToulmZNhPIo8G3GnuqYnAqYt/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0nXchQH; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7947cf097c1so47557617b3.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 20:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773716803; cv=none;
        d=google.com; s=arc-20240605;
        b=hBNdkmgq2LXoXmDJ7mkZ2T1dlLPUC98WhrJYM27FsaO6f+2AlVnLEtiRlkjuVDTtv4
         LKeu+zaYnKC0qRMy7wqERyIh04wCqFU3087UzifcvF3z5o2BtBHTvaf8Wo6oOouIJt9/
         seNgqrOgFcHXULmlhFz8puTRkBuQfFWeDCgCnykx8lT0yTXEQcV24AmUqMK4LovE02Yx
         tv8dN3KjVWKxTyIZy4kRgqF1iUNTvFP80FRid49VVqfaubotyQFYM1SbD00dI4zGY1n2
         WA7wdU05md5zv0U70siKrh+cer5vu0pRqHEzQoUGddxxEXF0eSaP41XZtpG4fnx1IzAY
         ZQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KHyuNaMd/zewSaRimahrmp0hwQ4b9EQOYNegrTRKIpU=;
        fh=eFLiDnWdIAPsB1WOBgerXOZnQ2eoIjPGrY9uKzzSGcU=;
        b=SQRE7CYGptEoI5TiXBXJF15eiJ3YvIJQQTHXBFHrKv6pq/F5IrAvGHOToTeAthz1YK
         VE2Ug2HtCRLq54drXjhz0/SkkWa36610r3Qvsoh7zgCy67WTd8bxJZClGDbMvhXAV4iM
         B0xIIXYmQ/iLFOYbqxQF08IKvzW8EQSa0JWToO4KK69uUzPvLxT9yzlhH4TTh6aIn8vH
         xBP7wK614vYKYnLg1gB+GcvVMl804s8LhYAsohcR+yRRhDkjuDKvyCgaFpZcEdutZJU6
         SnI7oER2Xy+B/5ZL3BKgboqTYbFEgokN+oOJVLsdsz3zUuVZX0SRHa4vSL7iSaZbmQ23
         5wVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773716803; x=1774321603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHyuNaMd/zewSaRimahrmp0hwQ4b9EQOYNegrTRKIpU=;
        b=S0nXchQHYdRFr9eAa0GDMMfuJa9FHqzkSymQ2qfwGCtAAn5pzm50x2pQU/BxEPTAOG
         U2jr9T8+fML2Zk/yzs89KUUaOJtXZT9HzxvjmuaWD5QlDwwr21NOL4ZqfDJa38eAWMRM
         J/3xHZwV2WHdo7U564qnCGJIqtXx5c+Nf4AifsSIJOnTMiDO+lz8CaeFw8wUpxHwl+cf
         wWiLrU3Oyai+LlRipRRo/cTheTzfYKQZdZUiapHzLBqwRKsq528gFQQucqC2SK8XZZR0
         hsaJiGXNPh7/CfzCELCgjVn6TlHmY4wqVMEenOqfT/GypoP2R9RYIfKG7vRcR/Z4ko7O
         FjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773716803; x=1774321603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KHyuNaMd/zewSaRimahrmp0hwQ4b9EQOYNegrTRKIpU=;
        b=QLYhLfJrgLNiDUDs0XFxKwYbzBzi+FWnsizFAUetNi5Xqi5HS5G/yIOR/U9/gODXNZ
         9AaqXLZnLVAMgqNYz8wWGOgAafD8wF9duWmj7/eh8okE/qCR4+oRPGicUcPnoL5FvMFb
         tIprpUG7JVelvRva579i/1Qpih1+/IReM18inqI1ar1zq7T3872C6zkcvlfYiMGSgciW
         VjiesKNJnZAW31LqBtrv2OAFPjxXIV9yHpOk1AMC3l27Q3n3VJIyvbOOeSh/Mv9bXqXh
         +p4sBzxkO1fOzxyBBr8FpIUW1YywcNdG9jenH/N9i6ow0V1DHmOMFFHjrvfTYfHeZbCw
         vOdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl1GjGB6actA1LtWu3jn0bG5uNXKgcpsgmSah7u1rrUixQpPjiZTTIxv9Yo9wqd+jQ/4/sokg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBTQX2r54lP7EWNOm2MqYKM9vuB49GnyO40xF+y0bwUSrH5Y5g
	fepIdgUsJKG+FAeCOJmSkNRDmtlMj0wxLK2a8dHLooYrttH6/plJwX6PXPYKnpuHamAo1bumGnQ
	bgy8b9/7AWESDPZQnXTLCVtXWYCkpSzU=
X-Gm-Gg: ATEYQzyrr577ZTqloU8ea31W9AyGfOkgEZCGwl7MlxIfwNPshHR7DuhGtmqGfFCX+7l
	Y/ZcuJ2XDplevE3QfIOUxi1m8hMXhjexuTbnMMpovAEybPinwJ2kNk/00Eo5K3MRD04jyFrelE4
	M/BycIjZ8+GQSe/6IKB34q9lAKwgXJYv+2V+q97TeBHlBVmco2ErHcCmBUN8qPM+JYKmkaQG9KQ
	XPmuL2F+YhnOKosrFGpI50Tj9HtefZCE4m2hY1bKnCvMFGRjzTCN//D2dhKj61CXETodkmhS6SJ
	q0cFcpfh+YO3PAS6
X-Received: by 2002:a05:690c:6d10:b0:794:b5aa:9c71 with SMTP id
 00721157ae682-79a1c188226mr145576267b3.34.1773716803385; Mon, 16 Mar 2026
 20:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313034732.209792-1-dqfext@gmail.com> <20260316195459.6e4d6d9b@kernel.org>
In-Reply-To: <20260316195459.6e4d6d9b@kernel.org>
From: Qingfang Deng <dqfext@gmail.com>
Date: Tue, 17 Mar 2026 11:06:32 +0800
X-Gm-Features: AaiRm51kcVupIusAK_mL8GpvXC0j6yjDwi907eM0BgIIWSGZspNSviDkhtqURIs
Message-ID: <CALW65jbz+tLH3h5HhHw_623VJf0SMMu9hcLJ9Ssd_k759beQwg@mail.gmail.com>
Subject: Re: [PATCH net] l2tp: ppp: use max L2TP header size for PPP channel hdrlen
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-ppp@vger.kernel.org, James Chapman <jchapman@katalix.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-268406-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B36FF2A30C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 10:55=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> If the main effect of this patch is that we avoid reallocations I think
> this is an optimization and should go to net-next?

Yes, it is to avoid skb reallocations. I can repost it to net-next.

Regards,
Qingfang

