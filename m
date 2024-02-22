Return-Path: <netdev+bounces-73901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6BF85F305
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 09:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6951C2277E
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 08:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BA62260B;
	Thu, 22 Feb 2024 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG8ssBtD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127824B52
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590741; cv=none; b=LhRif6NBMovtam2jFgSX1YpVyvsUQSvVTIV1pP0kU3KLiCBffCDEDNx+nRsoG8j+xYQqn2D584A0I0/TgRRETp/6kp9xuqUbJGkSpHT7Zy8das62sfeIDLC7pbVs6CMiUjwhyx/NkDLOMtFGuH29cw1XW0lD5a2LI4zTelIjOYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590741; c=relaxed/simple;
	bh=HpQ1HPohr9X2Xw31xzDahw/YDOvaYzgyfoG8ymRoCCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqgfAKNgmN/u38BnrlWVt/qIz7nQvZufHMK9XakOmEDQ2B4XAmZxC73GeiINnQiSXIycnrd9QL9C6KWNZoVspYUTOHKsM652/OEPEEBJZQlBA8morr8/1EVeAUCQe5FB0XEhbTggn6/JCMLHb9z7+LJSjIGwM5EoHwvesGguhPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MG8ssBtD; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bc21303a35so2818445b6e.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 00:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708590738; x=1709195538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/bLwWkDgxQKw9qu4QthKJ30PVwsiOLY1KR/S4UqpzOQ=;
        b=MG8ssBtDrQ5Z5/vL34I7zM3ImgQsjPZeDGrElm/Ue0CJDRnXrDlX2CNzG15Rz8kGuu
         ws/9GVdskstC+ffWkMXMXxhFNuzpJVjG7B0SzIhEUfaqbLPpHAf93txGvNyb7NlzBzBF
         t7B+n+RTsaZcUK28f1sXFrNykAKVuq0kBs8CojKfjt0g9kssFaCHpdxMG4NwjqRCVnYt
         EwU5F5JdNqC76/jK+pTcJy5jFQhp3DmHZpXIOh1jqaRHSOUEkSjCeIAp14zj54EVMMkh
         vgYzWjUkUq9M6TFGF2BCzRxjQYhr739vz+TyY0vGdR40EY7vn+vF1VtnAo6jQithC7uG
         iIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708590738; x=1709195538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bLwWkDgxQKw9qu4QthKJ30PVwsiOLY1KR/S4UqpzOQ=;
        b=HE307ciH67oi1V57HgiVh/TyHpNLeRihxShxWn6N98dZlW9Lt8Qo7hFizlu8UjEoDI
         G+x7XjDZYKiyjVCadLD670IKN7Yl6X8VeZhpoC+YI2erN1E5CQjZ3goonRgk4fu+puSZ
         kWpZRRB5GtB2vcWNeN4T5yVPASxwygRpP/g6OB7LdaIgoUk0S6YvClckBdSNGO4SIfDA
         zDeFTZcxnZj0DEwdfYmrO16PYy0OPjFk7ry0GEN0jIx1AIN9DNaag2oL22t06qdyWS95
         viNsYz9xVQVTBSHkr/LEzHs474lV55ofJx26AaZp9HN1+R68xwTTPq+CadUEZLFmquiO
         YT2w==
X-Forwarded-Encrypted: i=1; AJvYcCW9XeipB2eshM8IAZccyjx0hTgNewDSHSG8hWoo3kVnZQv5KCW9a6RqARMq3hnKoyWNf/3NaVgJ2MHuQhAyEYF+Vl3ZGXN6
X-Gm-Message-State: AOJu0Yx0+HvgbRUxiNMLpd31VVOzQK2nKaf2HITxt9zep3O64FNyp8fy
	3S+1h+nO5M9N29dsuUImXdFvPZc4oDdT+tS0QWUMiZeWtC4S7JHDY9nupB2pTGTv2Jsc0I7HI9F
	tcpHU/nS6YIxELAuZlgM+q5rSvGMhbmmMVjovCw==
X-Google-Smtp-Source: AGHT+IEE4nXXIO+BzOBICLRK/x3Z/cpLGEwvL4kVwPqzcfcDZ7GcnpHd/bBAOj8oIrscxuGJU7ZAfZX0knJ0qiMcov4=
X-Received: by 2002:a05:6808:1828:b0:3c1:52b0:93f8 with SMTP id
 bh40-20020a056808182800b003c152b093f8mr2066251oib.3.1708590737838; Thu, 22
 Feb 2024 00:32:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220214553.714243-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20240220214553.714243-1-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 22 Feb 2024 09:32:06 +0100
Message-ID: <CAJ8uoz1988OLXQ4HzPbP1COiHarc=ErSdakmnyMfDogEzuZexA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 0/3] intel: fix routines that
 disable queue pairs
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, magnus.karlsson@intel.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 22:46, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Hi,
>
> It started out as an issue on ixgbe reported by Pavel [0] which first
> patch is supposed to fix, but apparently i40e and ice have queue pair
> disabling flow a bit out of order, so I addressed them as well. More
> info is included in commit messages.
>
> FWIW we are talking here about AF_XDP ZC when xsk_pool is sent down to
> driver. Typically these routines are executed when there is already XDP
> program running on interface.
>
> Thanks!
>
> [0]: https://lore.kernel.org/netdev/CAJEV1ijxNyPTwASJER1bcZzS9nMoZJqfR86nu_3jFFVXzZQ4NA@mail.gmail.com/

Thank you for this fix Maciej.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Maciej Fijalkowski (3):
>   ixgbe: {dis,en}able irqs in ixgbe_txrx_ring_{dis,en}able
>   i40e: disable NAPI right after disabling irqs when handling xsk_pool
>   ice: reorder disabling IRQ and NAPI in ice_qp_dis
>
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  2 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |  9 +--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 56 ++++++++++++++++---
>  3 files changed, 55 insertions(+), 12 deletions(-)
>
> --
> 2.34.1
>

