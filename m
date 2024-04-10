Return-Path: <netdev+bounces-86663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4EF89FC04
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 17:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A00B28390
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA1116F272;
	Wed, 10 Apr 2024 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="nafOrhTQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8164E16E86C
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764406; cv=none; b=LVx3N/eCkRlNG36BKlzhntSNIOX/JPC70jnHDlF3HCbRkpd5fE9F/b3Mee5Vs7qCwxiclZfDNHLW6JL38yvvnpjGkQIv5dCf4mOqyYiQ1/bb/hwc9X/PXCdm+vdxqiQO2f0wfdKJuzECwRjMcXQjaUR5zTE43DmqC7uZ78nPj3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764406; c=relaxed/simple;
	bh=/Y1qzOn+30DznShDaw07uMYVYAFX+JUDunHxGSZrRQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fy+d9tNEPIUHCFQhiyq+aQskfF/K/qf+Z6btg/C/eG+JYLlEzLytPkakk4/bVZYFYwEESMh8KLNP8++ZfZQjFC5rnUPayJTlOojSzNABkDsggQtVtMm1h7XA2u67OhQcSikSXAPgjeoRnh1COkwu9n3ZYEtvHaEkGvkscAd8j6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=nafOrhTQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ecf3f001c5so5680720b3a.1
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 08:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1712764402; x=1713369202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y1qzOn+30DznShDaw07uMYVYAFX+JUDunHxGSZrRQ4=;
        b=nafOrhTQQDm+wEzM1xOPgJ9NknalbwidEvciZhQBHDjq6hRNGzQLwnB3JuiXsBTan5
         HXm1QDW9VfkK1iseRuQSpQCWGlpwe6IC15v8BHnVycdXPsgRrW84q1QsFwKJRlKfHoHL
         Hv8bknRZDs3KdupCIiBkHp8yZmbDrsWQxK2zwayW67RjpBPc9Up08UR6CwK3cKYvv6Fr
         Gtn4T1FU1ReOmaqJeWfg/oFXBlQxeiOKzYcMN43oKN4p2hxML6vWrcYhIvEds5Fs2v9t
         xLlPpIbrQMT0XZi3SrgkYOs0ye7JvZF9v7ya583m0UKxnTcm6rumraobca8KqYeggDno
         GQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712764402; x=1713369202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Y1qzOn+30DznShDaw07uMYVYAFX+JUDunHxGSZrRQ4=;
        b=NhSYPh0Ybo/SWFg1dW6ba+VJCQapqL0Y2fLU5gwv7ZiptPijapZqm1Kvvd8/c7jWXw
         bHnqLaNuQxoc33Q0zXOcQ71Je7tGWHr4s5Ox2Eg6rC6I9LSPzfUSi22f1UPadKxSi8At
         9sKnhw6o4wZIPvPkWC9Td9zvXRTJOyJ5ZGKnPg15fQwfT771sdL7za8qSUoQUgnVMMUT
         nlPfSWkLYHSnvQ2e20zbxCXHR+b6PkybYZwD4UQaCAjcFSYQpGngkpucowxKBUg8ZhXX
         OXna31BPOc08NbMs9nbGsw8T4yECxP3+Xc3u9L/mVdGpYOiKZIqs1r6vliU7KN8UxWiM
         DeWA==
X-Gm-Message-State: AOJu0Yw8+2V4ukAnPVsNAg6Pa01BAg+zXCqEQNnzodJBzj7/yOkp/oOy
	FjL8efj+ydE4l+5kZoyRaNjeZydgWxXQnrdtfhcVPO9F1zG4L+6AuwUN2M/Liow=
X-Google-Smtp-Source: AGHT+IGlSYszNygu7yJbhha7sK1FYA0WW2Vp2H2Rzojh0U+usac4cJKHJwZvrcf3C/hkF5LnBsSTrg==
X-Received: by 2002:a05:6a00:4b4f:b0:6ec:ceb4:49b8 with SMTP id kr15-20020a056a004b4f00b006ecceb449b8mr3742786pfb.0.1712764401660;
        Wed, 10 Apr 2024 08:53:21 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id y1-20020a62f241000000b006ecfd2ad4ddsm10550541pfl.146.2024.04.10.08.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:53:21 -0700 (PDT)
Date: Wed, 10 Apr 2024 08:53:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com
Subject: Re: [PATCH iproute2-next 2/2] f_flower: implement pfcp opts
Message-ID: <20240410085319.2cc6a94a@hermes.local>
In-Reply-To: <20240410101440.9885-3-wojciech.drewek@intel.com>
References: <20240410101440.9885-1-wojciech.drewek@intel.com>
	<20240410101440.9885-3-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 12:14:40 +0200
Wojciech Drewek <wojciech.drewek@intel.com> wrote:

> +pfcp_opts
> +.I OPTIONS
> +doesn't support multiple options, and it consists of a key followed by a slash
> +and corresponding mask. If the mask is missing, \fBtc\fR assumes a full-length
> +match. The option can be described in the form TYPE:SEID/TYPE_MASK:SEID_MASK
> +where TYPE is represented as a 8bit number, SEID is represented by 64bit, both
> +of them are in hex.

Best practices in English writing style is to make all clauses have similar
starting phrase.

Existing paragraph here is a mess already, so not unique to this.
That part of tc-flower man page needs some grammar fixes, as well
as being broken up.

