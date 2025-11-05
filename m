Return-Path: <netdev+bounces-235717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A559C340F1
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 07:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC013349C56
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 06:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353D1266B72;
	Wed,  5 Nov 2025 06:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFg+Woj4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA7139579
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762324233; cv=none; b=nOvjpKsG8o/phTry5oeg6bxQ50+P6Ku+JIvNWUkVP6dRqjlrxWumXAgUYZm3rohF6FMFDnfJfbq0cf8KTRmvvfoxvaN1tyq4wxErpEmi3jk7jRiVpPAkozo25q/RwYzwrp/CY373iwyQJm3iSgYcY6pIyg6Hjd9g/wWPpVXEzpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762324233; c=relaxed/simple;
	bh=XpHiy6HTH3GQtFkbejWYlXhYx97ytl2QsLbopIJ02lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxFa8+knOyYCr6k/EvV9aDVnb0SA7rOADik/n8yqn6DM6T9QPMj2LxxQGov+PggUfUW5Zt15WR8uBll3FuQNXDIn9AOCfZ/MfzZWwGZql6pwGfSsoXSnX9YnQLiAX9AFmxYY8DqH9Df9oZe7+Lc+HwH+c/I/Z9Id5ac1AVpAY+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFg+Woj4; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-4330eb0f232so2269855ab.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 22:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762324231; x=1762929031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpHiy6HTH3GQtFkbejWYlXhYx97ytl2QsLbopIJ02lo=;
        b=GFg+Woj4VQZEIimw+vgyO0JvvMGCJe1hraLjKykX0XK4zaFS0NCQ6zszMcu9rHLEA0
         ZTvfWWlE1vVRgorCR2CrhBIghedyVUTKXpOdsaYitCYG3C3RubGF/NBG7nJFZa0Kjnkh
         WS4rbxKGkWFqisHuqXb2Rk+YSYZzaIHOPc5artuAthgMWIAHP1sI7IN7I0vAeGpQwNEn
         Qg15Ex53oBrWfI/oLt22q63PJ038bK6cPNt/vbCGzNWr3ojYbsYxkWgMSfFiZpUF3t41
         CN6Zw26KkmecPMHb9in5sTX+M9vEJzdrXFqmAXM7uhoiWbxcVpPFItknu5Oo3Im2Rlyk
         ONbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762324231; x=1762929031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpHiy6HTH3GQtFkbejWYlXhYx97ytl2QsLbopIJ02lo=;
        b=joHPPhbemukdag0XiC6qqqqmKXhNwSe26+BTHhCGHlAFiweYUFvXDjxIOgG9hNJHew
         VxfNGNUAgaPhPH4w7YFFx2KTUNfjntI+Maw6DVsKL3oLdufwLjbyQeglcYjtdL8+QQ7R
         XLpyxH34lO2TJB6DRWsYqGCSIsEK96rAyfRdDQYA37v+dovb3OPNiAEe7keyUtSeqVt8
         DtV0GAbrHhYEfC9x57/CNvHrUWjfodaTfPXr+D4/Pb51PIr3kUlsrkYma4oK9nm9aSdw
         RW/u+mqRS8cGecfX8XxMtbcJv8V0bILg3pOBpfYq3dd8ylN5foL1loPBxQNzVkLsby9l
         LAtw==
X-Forwarded-Encrypted: i=1; AJvYcCXwnnrl+VEuiD5GhdExQuEzOr+LhZRuWG26r4rS1/cU7SUJ2+5QDuKJVsJkVbN7sgGL5r2E+Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlVkcJrKde/5YUEuxZjzh3oQK3axGRrOgVUgIEcRLLnmvluy5J
	z9hok91gEkloYz91KJ/He6pkjPYHwfJolHTzNMfPF7/LHN+YsmZNDAf6A8KSup06TJBbH3ddawr
	vnkGSb6VcqF6NH0e1+GxlCF/anoj+2mo=
X-Gm-Gg: ASbGnctpK/y5/RrEQ+RUF+RQdWCG8EJ8WnhEFyoVwNUJCcivcpeaW+/9twR0ruxnN7v
	qrWswVKcg42qdCYWrqH/u02xr0bfjXidnR1uQK/v6WF+TCMWbNReR5RSnus1TQrDl2HniZn8hLC
	I2Q9L30iJd9XYGIt5/luPzWXit/g7jLCb5RkSEkckD+CJrB1L5ACg28LWMLeFQVcm/LVbwjPE4L
	FjzmKRPBnPq+5XErfqWzi40KVu27oySoigPwCAD4/D5jF8x4laSAhklnibx/9zW
X-Google-Smtp-Source: AGHT+IH5Za0QasfIMuHQVPC47BzHrj37osrL7N097OjKEmkbrMDUzjejRu5q1kBVgMJyaDm2AGPt5EZclvmpgnwlIhw=
X-Received: by 2002:a05:6e02:3790:b0:433:2390:3a4a with SMTP id
 e9e14a558f8ab-433401d8a98mr36930905ab.14.1762324230669; Tue, 04 Nov 2025
 22:30:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031103328.95468-1-kerneljasonxing@gmail.com>
In-Reply-To: <20251031103328.95468-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Nov 2025 14:29:54 +0800
X-Gm-Features: AWmQ_bmKfYtfw-wDUDXxb2Tv4pRDBqYnFYQ4ipo0DOifd4gWLxlh0x6XnkuLgVw
Message-ID: <CAL+tcoDdJyy8gkjfdAdFRMX_JZ2tWwjfQZWCCHcfgf3vNBEWVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] xsk: add indirect call for xsk_destruct_skb
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 6:33=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Since Eric proposed an idea about adding indirect call wrappers for
> UDP and managed to see a huge improvement[1], the same situation can
> also be applied in xsk scenario.
>
> This patch adds an indirect call for xsk and helps current copy mode
> improve the performance by around 1% stably which was observed with
> IXGBE at 10Gb/sec loaded. If the throughput grows, the positive effect
> will be magnified. I applied this patch on top of batch xmit series[2],
> and was able to see <5% improvement from our internal application
> which is a little bit unstable though.
>
> Use INDIRECT wrappers to keep xsk_destruct_skb static as it used to
> be when the mitigation config is off.
>
> Be aware of the freeing path that can be very hot since the frequency
> can reach around 2,000,000 times per second with the xdpsock test.
>
> [1]: https://lore.kernel.org/netdev/20251006193103.2684156-2-edumazet@goo=
gle.com/
> [2]: https://lore.kernel.org/all/20251021131209.41491-1-kerneljasonxing@g=
mail.com/
>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Sorry that I miss adding the tag from Alexander.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Jason

