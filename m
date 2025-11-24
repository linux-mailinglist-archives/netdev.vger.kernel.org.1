Return-Path: <netdev+bounces-241338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB1AC82D71
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 00:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 698DB4E114C
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 23:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1EB2F747D;
	Mon, 24 Nov 2025 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1Q/dPfP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860C52D5C7A
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764027861; cv=none; b=fZRi+u3ddrYk16Q2ej4YOTsb7xKEhz3ZPeD3jAoOYowNqpyCV59IaBnC+T13G+8Ysg/ZK1CIrGM3nPXxTEvVhY+pfU31DUBVpflnTP4wulYHGgBZXZrwjVeTzk213yLeQb2Kn5tj3Enb5g4I2fc4rfA4ogrV9FPB/rLygClCROI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764027861; c=relaxed/simple;
	bh=DVw4qFRQDZZ1CpraBVhQqXiAO9C3whzWIXvi2Zo1MZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MT3c5zrlmi7VyDcVuIUBY7DXf+NZAqJ8EEnmIZdobYS8tHdSm+8+P99XlaeZBMNnyhUkZ01NHj4wJ5p8GoM7crthOCJxvfQYnEZ3Qq5U/AXeYVMTDNa8sVme+1K1HdDD+8fYItfrP6unFjyEhFMTkzAup+B7ZgSsB0CT0N78BjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1Q/dPfP; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4332ae0635fso17641995ab.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 15:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764027858; x=1764632658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVw4qFRQDZZ1CpraBVhQqXiAO9C3whzWIXvi2Zo1MZU=;
        b=g1Q/dPfPYqEn2iDJ4xlvIDm/CP2UkdOLVjD4ZZfm4iPbVyNEgsrj0JMu7aMYIxXjOT
         p4fbPzdIrtN0zIJVR5litBRCwG8UUqKso9wJyTCEbW7hx3lI8tZa5Sy28RJiTKbPpbXM
         BC1/aPUteC53JfcGBxnLvro3fgKlh+axo4Q1PwpWOxcCjBjW4GN5iTuQ4+hBpfJENCB2
         f7TCMZkmFxIPAtxix2lEM76dupu4ZMCzrWt3RREwUxt7SWb5u2ZyF8AUQuSivUAPddty
         ZjLI/0Q2o3V98/qWz2tlM+XUePUF+XWbVTfXFvqtTXonVp6x8R8byMp+ts+GYYz3Tu9R
         qu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764027858; x=1764632658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DVw4qFRQDZZ1CpraBVhQqXiAO9C3whzWIXvi2Zo1MZU=;
        b=DG1ANHpxmoC5ZrxqejksvQhkBdoWqEsSgQ4tAxMwpGkrsqldes0Ycx5DjQGjvHA31C
         PJtMf6CmNarvW8DbAWN7x5ab9hBWxyVFTt05JAz6p05XHWeZE9SXg9hiL0xdNTvszCdg
         7CAymDqgimzNNGrW4P/VjDZXKwogoxyCILEXsYqqZ4DfeoRVsAFp/hzMRo6+56+SqFzJ
         HFJfGT0JvudrxPcCBPWuyH9DZRWByLD2NEC/KUG9PpzzOI/aXni66xw2fxYFlCz+Ms02
         +d+XI7KA20FmlxqzxfsVGzWrwS2Sn/or6m0IQXrXLqalnHjNcERKAX/ppmAmPRUcJxzu
         SZ8w==
X-Forwarded-Encrypted: i=1; AJvYcCV90s8YQ+VGsQxNZ4waI68Ztzz4r3xpPNhSq0fXpRNEYUJvRxbW0hisOsvQzVYVuS2wpggdVBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhK3OqvkCihoLqtAq6Dangh4uihVxNBniH4Xr2jc4y65omidD
	RB3pEH19d/ftSoJ0+OTJhnci5e/bfJYDxYzjXwqxPfdl0QJdXCdRZBzDwBli9iOC63gKLeBrOqd
	QEK+k8U4nXvUFECazllZDmSLjUnqbD9M=
X-Gm-Gg: ASbGnctmmHdsy+/BlRuSJTR4CNJDnYKZvRobomq+1/r4l87hO4CoPEPElz7uLFv+BcA
	6zFYZ0mWGn4QZIVXLBqXDuUOGZS7HUspPl3GjCoGE5E6NDUJr2ElBdG6h7aA+UfXYv9tMpMOfz7
	l971/7xuV/rMkpXwqUJtNb53tqrcaOYGUVzOa4bWOxwX/6+z6oYYumPdP3Aqb7EHeVBhSBNvbBk
	gZ5sIhwfPW2ByE2JqPvZTFu0FxU0tdTHVCOR8I+P2SVlVW681xxq+EHJ/G7pSlkJOOpKR4=
X-Google-Smtp-Source: AGHT+IHeGZlUiSq+0eHau7ANqz8fU8Cx36q0FOMYU0Dj/ajvYhWyZhQEtQk4bEZKainAT2wg4zsuz9wwgqWDUaR0gTI=
X-Received: by 2002:a05:6e02:1986:b0:435:a467:b324 with SMTP id
 e9e14a558f8ab-435b9862f5bmr106020245ab.17.1764027858649; Mon, 24 Nov 2025
 15:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124080858.89593-1-kerneljasonxing@gmail.com>
 <20251124080858.89593-3-kerneljasonxing@gmail.com> <aSStkfeUrYRAKZeQ@boxer>
In-Reply-To: <aSStkfeUrYRAKZeQ@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 25 Nov 2025 07:43:42 +0800
X-Gm-Features: AWmQ_bmp_HfOZky6LJApZqlc-2Wz6Qx6wDGYUvB-gpaHTxZraovxAfZTNIriaSk
Message-ID: <CAL+tcoD0Y=ChSuPfm3K_qRQo9h8eBGVnCi74usTEi8mBmeB_OA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] xsk: add the atomic parameter around cq in
 generic path
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 3:10=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Mon, Nov 24, 2025 at 04:08:57PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > No functional changes here. Add a new parameter as a prep to help
> > completion queue in copy mode convert into atomic type in the rest of
> > this series. The patch also keeps the unified interface.
>
> Jason,
>
> anything used in ZC should not get a penalty from changes developed to
> improve copy mode. I'd rather suggest separate functions rather than
> branches within shared routines.

Sure thing:) Will change that.

Thanks,
Jason

