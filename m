Return-Path: <netdev+bounces-103194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5565A906D19
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3541C23ED4
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EF1146005;
	Thu, 13 Jun 2024 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ4k9SyE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BBD145FFF;
	Thu, 13 Jun 2024 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279553; cv=none; b=TDW2hN/bwK+BXB/hZrebW0jaWFc2zi07M/hEOmpS9sgT5GgTe2yybofEUFl9hVSwC3NccxEOtb8ufdMdIulaqBeAVhm4BFWsZBRy9XhOcfpLa+DljS6lA5UIzn/F9UnIKsEqsBE0Taga/nI0c9pvFL7LEx50qjtJd34DJRNpMQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279553; c=relaxed/simple;
	bh=UiLaxLJk/49aOyDDnp3jrSQnCFDqvVhGAb9VZY64J/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rr3IDMLMluTAnDxeWGQ2vxyFOXbcqEwAm6VhPsLvfd28Iv03DvdOzmQ1MDghPbVED5WuRlP2+T8QkWZMhO4TPdzOnIjH5TFHDR/l87PZClIW1syxGxZcZW5O662EfkSHcwcQwAwZJAIP/w1OooQqFViQ8CzPAVu4/7nby7BnYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJ4k9SyE; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso1519952a12.1;
        Thu, 13 Jun 2024 04:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718279550; x=1718884350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dbv/nrVwyXXxlAOsMk49c7RMKvSToPFz3Zd6uf8bQcE=;
        b=mJ4k9SyEmE+l5SIWhjigMEVJqkoHAG9E1jtjh6YCP6EdSAuYfcJV/7ASXj9W+tagdH
         Qq/uKmbi9TXxsKRejP46cgdpCYNvSMX7eAbFZ5OmgLRu29rdv94j0eZecLLr/EM/XPgL
         ragOtQMe1lePNK1Rd76cDF2uwLvGPCSWAbMlpmRBcQhsbMLrt/zDEZMv8K6++D2ZFi21
         o/9VtpqfP8mDYhswSk6SUmuD5eSOqYoSUpoL1GGODScDISqZT218Zts8TDx3rlonFFCK
         wJOGXXxQmKRj35eQLLBb/VI2c9hWXHJEee8CxrzJEADG7OZeO7Ev1dSbmaN0PAfUBHYz
         rTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279550; x=1718884350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dbv/nrVwyXXxlAOsMk49c7RMKvSToPFz3Zd6uf8bQcE=;
        b=dFrYZo+fw4xuMAzhMC94oxlcuhcVmD28Az6WHx9r/jeVav4BTQYv+ErGngvl14w/qr
         UIA/VBVytZ4GLOBoYHxqvdjPg3jmon/f9IrAUtS93y6sxqBKhm4a3b4fO+GPHG2ntNjL
         bieAdHk0AOUum4YoWU1R2zfc5SO1NtIGayMTtA9TzyXO7l57cSUFl4cbz3zhZjBRn54/
         8bpdCn3QgjqDHZTVoz7KIv9d1qdScMugCUJ7W0/bLj0Gu16Gi+x/Y4WHT4O8x0oesbAl
         wsl0ZpE5v+A3tcpT4TZQUDUxcnQm5H4NscJTxEmZlnOU6WEZAVMh2K9lRgNENQQX2dB+
         YaYg==
X-Forwarded-Encrypted: i=1; AJvYcCVm+pnzgOyte3NOF/1ReOIvKq2990sv5rAS9+X+ALY+LFJvnDP6NJzceZf9gvT6q5a7eB1rgYjwmhby06SX6dnuuv7E783uQsuhp2BHUQO8uNcaekXTrTPQ8C4J41RC82PpGp26RuZsyfHH6/QUgdjOurz+rw+/y+8F9LhWwnXe6w==
X-Gm-Message-State: AOJu0Yye4EF5/hy3yTi5F8A8g5aG6zrnXJwZKD5UkumNZwM8sV10yU8Z
	j3qfTR9IrwadqsvpXMCeAbaJPyM8gI0yFfyY+byfBs31jBp7MbXO
X-Google-Smtp-Source: AGHT+IG8qwB5MgX8BR4mjTHhID5JisGTczWwZagsP8iVADJIw6N1lHklOdF+IL0AKB+uX1m0tw5ZBA==
X-Received: by 2002:a50:9f87:0:b0:57c:a793:8f43 with SMTP id 4fb4d7f45d1cf-57cb4ba1c25mr1940653a12.3.1718279550006;
        Thu, 13 Jun 2024 04:52:30 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e782sm808239a12.64.2024.06.13.04.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:52:29 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:52:26 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 05/12] net: dsa: lantiq_gswip: Don't manually
 call gswip_port_enable()
Message-ID: <20240613115226.luvvmfwsdkp6bmx3@skbuf>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-6-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611135434.3180973-6-ms@dev.tdt.de>

On Tue, Jun 11, 2024 at 03:54:27PM +0200, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> We don't need to manually call gswip_port_enable() from within
> gswip_setup() for the CPU port. DSA does this automatically for us.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---

Needs your sign off.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

