Return-Path: <netdev+bounces-86836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D82418A063F
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 04:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788821F25A12
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1751813B2B3;
	Thu, 11 Apr 2024 02:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRNEY3S5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94913B2A9
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804102; cv=none; b=BrrCyXFbJDXKMAZhq69WgB2vvWJ+LhmP9XwYvvcHmXlu47ossnWT2rSobetMYuZPWV6q82rMazbUfTF//wFOBJoQCywxnX5L18luimtS5bmTJS1da4Qn/tIaiPtz8D+r0xSGmgnLcdnt2d7+N3v2mdaUthG8T4SWkJyCmr+tCuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804102; c=relaxed/simple;
	bh=8UPF3By6CImZVFOEpgyKi1TgDj/2UU6JF9oyEazh1VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcwSXJ0rXr5qy6gMnaGg+1j5yQ5bXWJu4K/uaFqfyD0Gdx7igl4cN1N/9m//Ewqp0dbt0FZbL884dG2v5wtg3aYlpCPHZZeQ2oRE2A/rPWmFH64hMjzlh2xYS+Ztm/wIDk0OmwvZWvIvDdwQpat4FtSnOQ4Vezn6o35oaPeGi/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRNEY3S5; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5176f217b7bso2163381e87.0
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 19:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712804098; x=1713408898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UPF3By6CImZVFOEpgyKi1TgDj/2UU6JF9oyEazh1VE=;
        b=eRNEY3S5NZNfTAWDgUjBKUWtjphFdnF3lHPxNusfBUtABUZoQMuuQAkR3g83nHW4+R
         4L4Njwbotd+Rs8nfr/0BV4v2a70+gQ7HAZDCxGo/kGb1JNbIqgI4cibfZEvRziaWhc4N
         HaBxSuB86trAPnzAzFNGSoYYO6noBWU/BHfZnxHqjJQC5KfrkP7JuPE63jfHXo2N/tI7
         5+w2ooB63Kxb+FFQzQgmwXn0mUP+9luNL9JU/FHimnxthev349UOkCtg/bvpGhpaQYUI
         yD3BphHf5Sdpc4edSH4H3n6bdW8/TYrAjhn7UIW9XdE628jHvTMPvzbHfe3ynr/x2EkY
         +E2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712804098; x=1713408898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UPF3By6CImZVFOEpgyKi1TgDj/2UU6JF9oyEazh1VE=;
        b=p7oRy3y6mwYnKbdsYYVlSsVARePydhTrvLwlsSFZPIOJ5ScNPvrPjx883T2erLxy0o
         bKCeWzq/ZKBGN8F+t6mVB+tBEfKrhxbQCeH7+Mc52967aCBn/wfxwrrWWWYmTPTp3Am1
         Xi1PXd8p0ALSVGW8kc02x40EYMITcfEYDGakHhzFznkTpap3Gu35iA73IRS90EtpLM/Y
         xmVB7A+XRbDyCDbTmCe5Fg9CQboh1JE+AYAyTTrqEXDnj5fQkY6FE1+gchVi1sBhY59v
         elP3TfOhbruxPIPwakvEZzM/xQqjPAz/NJlXNVz8068PB8ytCwMOKMoCjQTe4La6P75/
         4d2A==
X-Gm-Message-State: AOJu0YyvsT4jHc0Bc3Tu1jmP/5iG7OMp2APC4XuPcDDKPXy0r2XDNa/i
	yZRpdfDs3bt/zxSZf8sz6rPb8k18IhxOcVEd2UCWZUeVwMJpl/MQ8z+7R2OhV5ADQ5oKbIH2NKn
	KxWEK8mpVzI2FC7G/K37fiM1jQ6W3uKxu
X-Google-Smtp-Source: AGHT+IF7RRqLN8f3T5hUB+K7C9RxT2Ha+11cfPIbBLDi8wmUq5NWuHJG+Lv9kaiD43p+fFldIZictQ0rr1U8Rj5uc9s=
X-Received: by 2002:a05:6512:2c04:b0:516:d3de:88e with SMTP id
 dx4-20020a0565122c0400b00516d3de088emr3721260lfb.49.1712804098140; Wed, 10
 Apr 2024 19:54:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712711977.git.asml.silence@gmail.com> <a887463fb219d973ec5ad275e31194812571f1f5.1712711977.git.asml.silence@gmail.com>
In-Reply-To: <a887463fb219d973ec5ad275e31194812571f1f5.1712711977.git.asml.silence@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 11 Apr 2024 10:54:21 +0800
Message-ID: <CAL+tcoBqVwJawfvNgs2SCxdR-Jf+TC4baOg=xaDQrkahdAfrDg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] net: cache for same cpu skb_attempt_defer_free
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 9:28=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> Optimise skb_attempt_defer_free() when run by the same CPU the skb was
> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
> disable softirqs and put the buffer into cpu local caches.
>
> CPU bound TCP ping pong style benchmarking (i.e. netbench) showed a 1%
> throughput increase (392.2 -> 396.4 Krps). Cross checking with profiles,
> the total CPU share of skb_attempt_defer_free() dropped by 0.6%. Note,
> I'd expect the win doubled with rx only benchmarks, as the optimisation
> is for the receive path, but the test spends >55% of CPU doing writes.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

