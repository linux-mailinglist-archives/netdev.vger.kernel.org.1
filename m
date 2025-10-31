Return-Path: <netdev+bounces-234634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6FDC24D15
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4773AE350
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE33B346A1B;
	Fri, 31 Oct 2025 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dGblSvdG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2207E2405E7
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911014; cv=none; b=J7cVcDgD3clMtlikWjA+L08LSZjFdKPy4XTeZlFekEqz7/eAnEm/TTS6PYo6bDp4c4tIaoV0TX3Rx8v0603EnSj4I9OyRamjohS1nUiuVvPe0MlGM7yRpC5DThBGqNqDI83j8mM6tPmJ+y4w0tzdkcVTy7Zg0gKjhqL9CYbk//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911014; c=relaxed/simple;
	bh=k0pT21Suqty5kqcNkS8z/yAUh7rDNHOHITor2PsYU0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWVAOjhlJw46m2nVG6nE0uRHYnjUfBiCgFAnAd/vRHa7K1fHb0aT2JJfoqk3nrdaE1b2LrcGCej08ybpdDUp+DCpYg7o5mIPHZjz6RnCTV6/ABQqUCkN69ra0CUuwkvCAGSIY3tuDf0GA0SGBCA34HJvtruTA0hZ4Oebcv8gt7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dGblSvdG; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ecf0336b61so20621351cf.0
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 04:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761911012; x=1762515812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0pT21Suqty5kqcNkS8z/yAUh7rDNHOHITor2PsYU0o=;
        b=dGblSvdGkpvfyVKTVnA5bnHMrg3ACU+c58ko/vcwXNzJtzbEOhqVgmua9WiEZn5HrO
         wdBZgu+Dh47PwPN6p3dzC8RW4+t7l2SeaSavICm1SfhJgHxwu7bVvX09TGTWQhzy7neo
         mV2d0pOhtvWgCBG23l30ID9SuG85AcJIhSFrUcHbXC/7NKYe+w/Yc9qAPsC9d1OEs4W0
         lKqhrC5qO9SI24JFkPLN8lvsGZZZ3W4B02MdwbqXAB8RoigFsGlVMt510wM/P8LmqmBe
         M/rfipCFpeY10oUJzFyRDKgzCZPcvTaLkbyP21+FGwgnZg88uxdFmg0RiRmZdhWKcMNd
         sDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911012; x=1762515812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0pT21Suqty5kqcNkS8z/yAUh7rDNHOHITor2PsYU0o=;
        b=bF7nshk7fVXx9ZmMglML0u4xneDLbBdHSYKLv9OxeykY0htAI60fKAdKzs5GdnvoMz
         9nLxBlBBFLLReCInaVcJODIdNuGPfWZ//bg+LsHT6tZAeTp+YqJJu+IStpTZnM4Iln/c
         ++1aZ7mShTDu517OvcbLrq818DPyjHtfX9otycRX7ZgE8jERh0yKLRhLdfOK4Fs9ZUJG
         YlotdQuKAGDDoSn83NYobt/enyIhlWv+LoMWn3qEz1/MbhZA9Kfarmb1LNGLUkrBNiGp
         sFWinHH1474hathtE5RDDMVFQJj7ZC5TNATw4i8oQ38Zb1xbGBpz0k0B9vVK2wWadJ7D
         B8gg==
X-Gm-Message-State: AOJu0YxCFMhZRX+LFqDVMO0dg6oa/X++6tl1+x3s8keXWpp5mjdXw/DM
	DzZupnlFJLW/paBs20Lp2I+oznPOHzJd7NCeHZG5EI7kcdHWXk5Uymb8JpzxJRDpAADWuRbPx/H
	X29zqUJW3Bik4O/sNHw7J6iMflxgt3oKm6ydtqSCV
X-Gm-Gg: ASbGnct2wr6KIyHMBsckLsGkmXGDa+f3Z4zyiKLtUYB6KElRZ2PNJRn2p/Yse3BeEJU
	k4S/xAyTQb3dlhiPXsDUN+wIxPZIS8XuYdrrXQwppjh3HdgbgcuGd7cL/xp2A8jSSWxwhfb6QCW
	L9OOcvNrLpJ8dgdi6UiBc761+cNNDN93U3T/lIrktj/pXTFauRv65DQ0vMmPzPy4qfWUtzUjL0c
	TiTaiHzoOc4IaqbWUaAbvKO+dFouKLPPVdwHF1rgE/dIJKftC3yZLmAiv0k50A/RUbaSXU=
X-Google-Smtp-Source: AGHT+IFqoco0hzxAVFJzQW9vvGOxtKNFjwqUfq6YEZCPkqLEXs5pzducXdEoOItsXHrnpiPGl3E0ulPY9KO1h+rwozs=
X-Received: by 2002:ac8:5ccf:0:b0:4e8:92ff:753 with SMTP id
 d75a77b69052e-4ed30f57539mr41715721cf.24.1761911011648; Fri, 31 Oct 2025
 04:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E3B93E31-3C03-4DAF-A9ED-69523A82E583@akamai.com>
In-Reply-To: <E3B93E31-3C03-4DAF-A9ED-69523A82E583@akamai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Oct 2025 04:43:19 -0700
X-Gm-Features: AWmQ_bmmZBWAMIeb4sFAXi3iiVp0dUi9MjSBNHnxdOgRQ2LAEqP1A9RlP2D3bb8
Message-ID: <CANn89iJQ_Hx_T7N6LPr2Qt-_O2KZ3GPgWFtywJBvjjTQvGwy2Q@mail.gmail.com>
Subject: Re: skb_attempt_defer_free and reference counting
To: "Hudson, Nick" <nhudson@akamai.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 4:04=E2=80=AFAM Hudson, Nick <nhudson@akamai.com> w=
rote:
>
> Hi,
>
> I=E2=80=99ve been looking at using skb_attempt_defer_free and had a quest=
ion about the skb reference counting.
>
> The existing reference release for any skb handed to skb_attempt_defer_fr=
ee is done in skb_defer_free_flush (via napi_consume_skb). However, it seem=
s to me that calling skb_attempt_defer_free on the same skb to drop the mul=
tiple references is problematic as, if the defer_list isn=E2=80=99t service=
d between the calls, the list gets corrupted. That is, the skb can=E2=80=99=
t appear on the list twice.
>
> Would it be possible to move the reference count drop into skb_attempt_de=
fer_free and only add the skb to the list on last reference drop?

We do not plan using this helper for arbitrary skbs, but ones fully
owned by TCP and UDP receive paths.

skb_share_check() must have been called before reaching them.

In any case using skb->next could be problematic with shared skb.

