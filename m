Return-Path: <netdev+bounces-225909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05551B992E4
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 11:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3D1171AC4
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 09:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF572D879E;
	Wed, 24 Sep 2025 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOUeeZW7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA82D8777
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706626; cv=none; b=laGlHl9iWRNMby5RMsDQbYieigO7+MXlCl7LAtre9fJF41mLYGbe9skfUxovUQT0cS+/w9hbjOpcXGSKnAW7+7XLgDFRz4N3dNahD+aO+Od/s0x7S2lppMJF37woPHUP4/KIY+2i8ceyFW7N0tSxjs+sB/gQe8K8pMZuCkBDauU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706626; c=relaxed/simple;
	bh=tHDZPTjqsvGSVtD2vzi+B0EfyL6Wl8yhlQVaMzP6+5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3AUjVjnVNZsF6ha0dSEeN1+3YXViL5MeEaFPcd4gCoJtVP3h3N/uMhS35ZvfR5or0IngTL2Kh5wQAfypoNs6KxotkckOWRB4+MC15x08MJ+ePPWr7IOInNGnfHbwmHnqhKps939Hd5JfUX879XMfjhXuRwAlU98s+7bn/+0cdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOUeeZW7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-36a53fe7ebdso29982281fa.1
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 02:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758706619; x=1759311419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfQjDW9lOZhqCcu0UR8GmRDS7/f9HDxq+dUiuWeXOX8=;
        b=dOUeeZW7JrZiu+ESKbVavy5wTYbdqQl9588/A6PDdjGhRUsmYzMq61bYJUeh5529gB
         SbqVQa+Z2mV0OSNb7Yk9t7dCunhR/+iO+DLQ+Dog5L96DfmySOQbJkKNzljeDuNLasyx
         ISET203X4CWrHT1+VK6RJsd09aJxps1M4teHSZFioQnPGmidNZ+mdIfBATyFKQEZzOnu
         gMfXR/sMao54f0BqIRAlSj0RO/n9GZnN4dL7XPEtfUOrcyAnhA6eGRUUX7LuKaGu2WiP
         aTB0o0QkononnFBw85tNHSiBn+OEuimDokMWeFs3Znr2XPY+dkSB+1U2risufOjne62U
         N6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758706619; x=1759311419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfQjDW9lOZhqCcu0UR8GmRDS7/f9HDxq+dUiuWeXOX8=;
        b=ZE++OLlY8KQqliBl01X4ttatSCM04GL+6QXOpu6y9bzp+xsMXQxy6gt5Y4Qg3T+zCb
         FzgccPPqu/0t87/zbILOmuUWgk+7iaEDZBEJ6ZEgeWQ9KKUWTq3Zix1eZIAeIvVXxxN/
         UITlRcAEQv/Y5xEQxd/4bG7CdqA1husbEwt+eHiOIUP3BLvNScTUuiA+J+JBTNT4FqEj
         K5FSHLHxK7Pr6WxHQ1rx3yvpwJBSoXtSiA35u3rjhMzjE8Vd8WcGO22FqFDSnXQxiX1v
         pmmNmoUNTPFJ8cJFG4qbeZ1prL7PLy1DXJhhGP19pEnsyODW0O+ydRYYt+HegmrnQJjF
         bzQg==
X-Forwarded-Encrypted: i=1; AJvYcCUvXyskExL0tsKnVh4FMwUicgAl5nfBdeH/7BRpWavJQB8lrOwyNeom2nTUerWRGbOfILyjE80=@vger.kernel.org
X-Gm-Message-State: AOJu0YycOQAbDopkpxsBb1aqQP7z+up3Qh6N7dgnldO7VO/EgcVBCYR2
	hnoIuSIWJSjil5kogTNyrjT12Af+rGkxdNHhJ7TDopfRas8xvS1ZmmD/
X-Gm-Gg: ASbGncvBsK2kYhukLpOsc+qU1J21jt8Ycw6BjccdelelODJdTtwO4HansEgKrfFsBgK
	I/fdifuxJCfBRVjudhAymYHMoK0k/af3tpqIR3oVh9uJkBRVs2jVQmmIsdpMw1UB9dkYyTAPdMI
	SvifqzNFYsVca7BFRApQzRO8z/UxyTKFErtRdaqQ1HRmOVuHoVYUXRNZ5A06rjVdBz0q94zsDPh
	pfKs+Vaoe/DPnY8zVIouXyl+W4bWTUS0hS94oNMVVWz2t1Kz2G/jw+YdM+Lg8Ou22QtsnBCzRzy
	lFRE2qBmvJs8kjg/nGopcTfYfxCS8jCCcqGtfqX9qx2SMI0k/6ap1hawIetAGVsnUtS7OdWx6qZ
	9fdoGdxZapPVu/gqHNTC1VFCbmEsUWwJ2T7U=
X-Google-Smtp-Source: AGHT+IGAXIFBfltfcFUi2JvMXFLpdNu20IBm9lusClOWXvJ5IvB5Xvu2p2lzfwLhA2Gs0+4M6+OmAw==
X-Received: by 2002:a2e:b8d2:0:b0:36a:f4d3:82e9 with SMTP id 38308e7fff4ca-36d14ebb0b5mr14965271fa.6.1758706618408;
        Wed, 24 Sep 2025 02:36:58 -0700 (PDT)
Received: from foxbook (bfe191.neoplus.adsl.tpnet.pl. [83.28.42.191])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361a26cbbd6sm43990051fa.23.2025.09.24.02.36.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Sep 2025 02:36:58 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:36:53 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: viswanath <viswanathiyyappan@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net,
 david.hunter.linux@gmail.com, edumazet@google.com, kuba@kernel.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 petkan@nucleusys.com, skhan@linuxfoundation.org,
 syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: usb: Remove disruptive netif_wake_queue in
 rtl8150_set_multicast
Message-ID: <20250924113653.5dad5e50.michal.pecio@gmail.com>
In-Reply-To: <CAPrAcgMrowvfGeOqdWAo4uCZBdUztFY-WEmpwLyp-QthgYYx7A@mail.gmail.com>
References: <83171a57-cb40-4c97-b736-0e62930b9e5c@lunn.ch>
	<20250920181852.18164-1-viswanathiyyappan@gmail.com>
	<20250924094741.65e12028.michal.pecio@gmail.com>
	<CAPrAcgMrowvfGeOqdWAo4uCZBdUztFY-WEmpwLyp-QthgYYx7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 13:32:52 +0530, viswanath wrote:
> On Wed, 24 Sept 2025 at 13:17, Michal Pecio <michal.pecio@gmail.com> wrote:
> >
> > It's not freeing which matters but URB completion in the USB subsystem.  
> 
> Does URB completion include both successful and failed completions? I
> decided to go with "free urb" because I wasn't sure of that.

I think yes, usually in USB-speak "completion" is when the URB is
finished for any reason, including error or unlink/cancellation.
"Free" could suggest usb_free_urb().

But I see your point. Maybe "finish execution" is less ambiguous?

> I wasn't sure how to describe the flow of execution in a multi threaded program.
> I will resubmit a v3 with this version of the execution flow

I think it's an irrelevant detail which CPU executed which function.
It could all happen sequentially on a single core and it's still the
same bug.

In fact, I just reproduced it with all CPUs offlined except one.

