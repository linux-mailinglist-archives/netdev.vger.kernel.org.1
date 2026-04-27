Return-Path: <netdev+bounces-281210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIImKz/I7mmvxgAAu9opvQ
	(envelope-from <netdev+bounces-281210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 04:21:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F1646C123
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 04:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D8EB30097D4
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 02:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD12B3164D8;
	Mon, 27 Apr 2026 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="uIcAWcs4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09EA2E7179
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 02:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777256507; cv=none; b=FUPL/vkC0rMRnKX2iBdRyNuJCzIcgRMlmgHXs9JIENTamQ9eq3BpFURG4oVQhuQyUatzW00FlfI7pNEk61qMjMJk8jYzejhu0Ma9fselXUUdwRrAmDE3vXpuTfXafUaBAQav9E8go5sZv0oKZ/QABXUs/XTfnyN6bHw1hlRDio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777256507; c=relaxed/simple;
	bh=sWrJUi8cl9/CaVwIOP0PW2RVAENzXIRsdanxfXkA3LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVsRkkV4ASTRX2E3vYpj2S2EMLSyfygfBCI6b7jmr7WLmzRPp0+N63S7Dn6tqynlyICWtkxUTOJsLr6KlZtWmmJcg8/fWh88SGt29ntZhKlYwm2YqC29Vek7P3HiJ6zDZ0ULhcmat7hlW5AGmXT2ETJ9Ya6y0wPbs5R95tIx5oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=uIcAWcs4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f0884bcfaso6588804b3a.1
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 19:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1777256503; x=1777861303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWrJUi8cl9/CaVwIOP0PW2RVAENzXIRsdanxfXkA3LM=;
        b=uIcAWcs4Kfx5nl67IF3h/SKO+v3LmAqJQrvIX5LCewRx7VYla9jouh88b8kotqUHOU
         oOJNy35WvA8f2yRyFOpNnElREb9bf/BZiygXeau9Y7CdEALB+q5vnmhrhH0sovuBxDwT
         XipfqS8OXVfqL19jc+uSXajlsfEg0MntBfhcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777256503; x=1777861303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sWrJUi8cl9/CaVwIOP0PW2RVAENzXIRsdanxfXkA3LM=;
        b=n/WMSCqffeOnk3yDjdyKJopHxbqY2GOlaRC+8twdyb5NOxkU/GfCTIL657zdGkNLfr
         mEHZoqiLStPSxNZI4I8O20VMNjAGG7OyrJ7Py2yFV2s9V34mAZa3z9xfGWwUgvqxMZ90
         qrgH2DKmavAOn2IQjIDSZ8sQw/9g8/x+LQFF/+/Xjue7P7pVWCLhL+3YWVOe+RxDhj67
         mpTDygHqchjlkA7YjTwovETR6vIyKQDvniJWW6P2loFSXu+1gejfUysARKRm8ccoEKO0
         eEagSYdgbBm4QpBvj320KkWNJ0/FjiumHPycUzKj+2fbF+AU0g34msEuEQfYivsQfm20
         x4SQ==
X-Forwarded-Encrypted: i=1; AFNElJ95JZLKhnh0CwkzA1LOMMRfXmKdwtJeWfpOoMWA2xWNRTY6KclPraZbo9XC10nqdk6wjpLUqWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgGsbpmnsH7aKGX0a1XIQDFzDVWG64MeLFDtdVmn21EbHtMCzT
	zKBAtTOHKmt37pu1aEZSlfinny9gUJdgs2CUhtviMfQI/6o46AfLGplZyRJwfynOZ/4=
X-Gm-Gg: AeBDieuAHP98/8UVPL3c3MPRAyaAMBh7MbQbY2SX5IksAqGnEUvYlorfTU1T0N3e49E
	H1UibmzoGp68gb2v64JtloXtezUSEZeXl6VX+EVJ9IF+kWR/XqBHBOXOre/ulbrUW9x13TRzls8
	N6Bj+uYezOXRroWz605cxT6hlFM4loGxPtyjmh/J/U+/KLvKDWGqzv55OJ6MWwxlWbIQyMCJzXp
	oBZMmrAUQM/D5QetK6nl82koGZFNSoyj1r5rrScQarTtm73VmF4TLJA1HB5lMfkeTvq38b+bVYE
	fDyw0Nn9bBDm0fi0zfrYdm3xmu1wpypIvlns13xRaCIDujA9FZmJPh7Iy0f8wQ9B6TbjU/aCizo
	UgOEEwefQfxD4Cmif06GlmrK3FHNAAS2oRyMPLq/sPU72x7kFf8y0f2e3IhzKDxjQAwWbBBHKOp
	d/D8f6K8TqhJZ30Sk6KrF+xqZwOCXvS2sTRc/wSx3u0OBO8jUlP+Ub1XHVIyfE1KHD87UW3is8g
	KutXD9kX6gS
X-Received: by 2002:a05:6a00:2d25:b0:824:adf4:5a2f with SMTP id d2e1a72fcca58-82f8c934230mr42491061b3a.43.1777256503240;
        Sun, 26 Apr 2026 19:21:43 -0700 (PDT)
Received: from eulgyu-desktop.localdomain ([147.46.174.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d9a1csm32499509b3a.20.2026.04.26.19.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 19:21:42 -0700 (PDT)
From: Eulgyu Kim <eulgyukim@snu.ac.kr>
To: edumazet@google.com,
	jiayuan.chen@linux.dev,
	pabeni@redhat.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	byoungyoung@snu.ac.kr,
	jjy600901@snu.ac.kr
Subject: Re: [BUG] KASAN: slab-use-after-free Write in sk_skb_reason_drop
Date: Mon, 27 Apr 2026 11:21:35 +0900
Message-ID: <20260427022135.38925-1-eulgyukim@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9992caa6-ec37-4727-ae5d-80d0b5b596c0@linux.dev>
References: <9992caa6-ec37-4727-ae5d-80d0b5b596c0@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 87F1646C123
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[snu.ac.kr,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[snu.ac.kr:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[snu.ac.kr:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281210-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eulgyukim@snu.ac.kr,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

>
> The fix could be this:
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index b183189f1853..6a0bbd4def76 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -289,8 +289,12 @@ static void tun_napi_disable(struct tun_file *tfile)
>
>   static void tun_napi_del(struct tun_file *tfile)
>   {
> -       if (tfile->napi_enabled)
> -               netif_napi_del(&tfile->napi);
> +       if (!tfile->napi_enabled)
> +               return;
> +
> +       mutex_lock(&tfile->napi_mutex);
> +       netif_napi_del(&tfile->napi);
> +       mutex_unlock(&tfile->napi_mutex);
>   }
>
>   static bool tun_napi_frags_enabled(const struct tun_file *tfile)
> @@ -1783,6 +1787,12 @@ static ssize_t tun_get_user(struct tun_struct
> *tun, struct tun_file *tfile,
>
>                  if (frags) {
>                          mutex_lock(&tfile->napi_mutex);
> +                       if (unlikely(tfile->detached ||
> + rcu_access_pointer(tfile->tun) != tun)) {
> +                               err = -EBUSY;
> +  mutex_unlock(&tfile->napi_mutex);
> +                               goto out;
> +                       }
>                          skb = tun_napi_alloc_frags(tfile, copylen, from);
>                          /* tun_napi_alloc_frags() enforces a layout for
> the skb.
>                           * If zerocopy is enabled, then this layout will be
> @@ -1981,6 +1991,7 @@ static ssize_t tun_get_user(struct tun_struct
> *tun, struct tun_file *tfile,
>                  mutex_unlock(&tfile->napi_mutex);
>          }
>
> +out:
>          return err ?: total_len;
>   }
>

Hello,

We have tested the proposed patch, and our reproducer did not trigger any issue.

Thanks!

Best Regards,
Eulgyu Kim

