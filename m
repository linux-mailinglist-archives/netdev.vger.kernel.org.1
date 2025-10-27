Return-Path: <netdev+bounces-233148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 041A6C0D293
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 12:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA8519A39E9
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 11:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF592FB98F;
	Mon, 27 Oct 2025 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpH2GQF+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409342FB962
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564876; cv=none; b=N9JGlacHHhZ1XHgfEo508hnIM/ckRUNJz+I2rrc2h5y8PW4ZbmiT2t0W+x9bDcLwH/P6PfjuX4dGn6xxzN+r0n3+Pd91Z2R+ME3vUWKuoJ4jgHTfmTGpUvnNukdQHVGIVZK188FG8BASLPmBao/1pQrEcDSUUiqjiFar11B++qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564876; c=relaxed/simple;
	bh=Ie6jihOFwN5+P+ywW7eHf1ZacD39o+roMjwVXpmQpTQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=oQKvKcQySHbId2s/GDcarS2lH4+cA3ty6VAycPmGgqrhyzF6bfzzxjHOf29JSQDWvwTrDHn7Ph4hFJBLrsgiLy6qlnUiKrZwGoU6ruu8j91D6KJd5I4a/oASyrkhZHHoKpsLXpNL6TbipU7a9oY7r3fJTePWqX02fq4cppc9elQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpH2GQF+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so4694461f8f.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 04:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761564872; x=1762169672; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EEI7h1sknZeS6BgfBQcQk93ov2b1bgQc3fu248l/Wpk=;
        b=YpH2GQF+OXjEJv4yCWNXaw6w0tRNOWqutDSgq8KcPvExknMhDxxzh/tyL9xZtlSc58
         HqlYz8r0DX9XBKvTfs6+nsabWruc2Gn54LZ0oWHdQDZyAOdslDgpCaaKgvAqWqA0uNRX
         jPaVGMz2jvJ/rt+l+M+PurcQCmMcdQWBifo5JGCS84+UIUlc498+GVi6yqx8WlHN9gY4
         UNvlkzGs54DDOeDEiY/+tuUXHZTV5Kj4KO7CnCzWsu9IpCNRYJep2Erwy9juzvkgDW4+
         yS053Algzv/e1zijOLiZQwSl3sUtoV1TIVS4ToDjZPkS56/TFMLsCbiNczQsaUavGmTi
         I/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761564872; x=1762169672;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEI7h1sknZeS6BgfBQcQk93ov2b1bgQc3fu248l/Wpk=;
        b=aGWga40Oeh2mC/yP7pN8k6eG64YMVDUPiZzpmeysP8R0eaeFtFh8KkBE+VLSHbCRhI
         VIOHKGWu6l5Nud1RJxCahVlWfmHUjCdSzQE8/zXLg9SYL5tE7YEIUwrvPbR3aivK4mVG
         gMFCY5Xe1jbPocXFqdmqT4MmOuTG3b4hH2rOitMZExP32dCuZe3UChfeSNkgIGx3Gkgm
         UazicEZFVqH/HMBC/WJmnNjqGHIOk+CIED2yvNLh3PrmJYDN0TSbtNlJNiMdUE6mr32o
         /cR8SC1uVwUYqPU+aykioTng9KHJcNAYXBKXe/W5XOgaZkw8+aEziBOphZgYQ0CnRw7Q
         ypfw==
X-Forwarded-Encrypted: i=1; AJvYcCWi9GBYljNeohA9Typ8js/4J8w+0SQFKGtjPL74nTIgAEWfpG5UPs471IGND7+TyGl9ipe+MWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyevlnXsxIp8gz0kdVAUU0qqmIPkllo3W/MrzqM3E9Kjwnc1NwP
	rUgjyW7crs2oLj+jI30IRVJ/How8vw64WH8FB1oxQC2uIiyI7CTpTD2h
X-Gm-Gg: ASbGnctK7k669Ffito9QsnjXq4xMps1uCfB5lsZiQTyJYZ2NhAzC4CAYbbyTL1yGX1K
	Q1wMRRjMKS7pJCPf3/eHULdoN6ET6SDag9u+wGvqu+CHiJYxI51DiTvaBDI3hCxVBWyfcrQ0B0f
	5+7Rn1i03rTrqkNDnG3CLq2zy7tEQpN0KyG6ho+SuewktgmK8nVJJT/s9ai6ki3SuTaK5hKpN3c
	ytgJYfEtIF7DEfWTrQJGdPktVrMBMnN+fF7iyylFpD1aoOFYnckkBecQSKoPj/QONFHC/lAsu9A
	KJFFYhh++btrJkgu7I8deGzY9p9K5hoRDt60rnDS+h1s85Zeu7JI1RDKtwtwB7EfwgW0Bbmq3EW
	B/elDoZtro4PGXsSKhlSNDEEQv0whIjjLYuz2+hCN4Loy40k/TQraSMOH14vy28Q94eIoqEdKh5
	SrfvSzAk06Lg1W
X-Google-Smtp-Source: AGHT+IFjWuWp/HxtdMC2iCHaPUeebHaDJSUf4ShxamqIWjx8LN8WfEQBWDUmZXxw7lKm8+Gr3YoVcw==
X-Received: by 2002:a05:6000:22c5:b0:3dc:1473:18bc with SMTP id ffacd0b85a97d-42704c88474mr25032343f8f.0.1761564872443;
        Mon, 27 Oct 2025 04:34:32 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:5830:b32c:9dbd:1424])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbc55sm14171795f8f.10.2025.10.27.04.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:34:31 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  ast@fiberby.net
Subject: Re: [PATCH net-next] tools: ynl: rework the string representation
 of NlError
In-Reply-To: <20251024215713.1250688-1-kuba@kernel.org>
Date: Mon, 27 Oct 2025 11:00:25 +0000
Message-ID: <m2ecqor4mu.fsf@gmail.com>
References: <20251024215713.1250688-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> In early days of YNL development dumping the NlMsg on errors
> was quite useful, as the library itself could have been buggy.
> These days increasingly the NlMsg is just taking up screen space
> and means nothing to a typical user. Try to format the errors
> more in line with how YNL C formats its errors strings.
>
> Before:
>   $ ynl --family ethtool  --do channels-set  --json '{}'
>   Netlink error: Invalid argument
>   nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
> 	error: -22
> 	extack: {'miss-type': 'header'}
>
>   $ ynl --family ethtool  --do channels-set  --json '{..., "tx-count": 999}'
>   Netlink error: Invalid argument
>   nl_len = 88 (72) nl_flags = 0x300 nl_type = 2
> 	error: -22
> 	extack: {'msg': 'requested channel count exceeds maximum', 'bad-attr': '.tx-count'}
>
> After:
>   $ ynl --family ethtool  --do channels-set  --json '{}'
>   Netlink error: Invalid argument {'miss-type': 'header'}
>
>   $ ynl --family ethtool  --do channels-set  --json '{..., "tx-count": 999}'
>   Netlink error: requested channel count exceeds maximum: Invalid argument {'bad-attr': '.tx-count'}
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: ast@fiberby.net
> ---
>  tools/net/ynl/pyynl/lib/ynl.py | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
> index 62383c70ebb9..bac9eb33ba89 100644
> --- a/tools/net/ynl/pyynl/lib/ynl.py
> +++ b/tools/net/ynl/pyynl/lib/ynl.py
> @@ -105,7 +105,17 @@ from .nlspec import SpecFamily
>      self.error = -nl_msg.error
>  
>    def __str__(self):
> -    return f"Netlink error: {os.strerror(self.error)}\n{self.nl_msg}"
> +    msg = "Netlink error: "
> +
> +    extack = self.nl_msg.extack.copy() if self.nl_msg.extack else {}
> +    if extack:

The 'if extack' condition seems redundant given the way extack is
initialised.

Otherwise LGTM.

> +        if 'msg' in extack:
> +            msg += extack['msg'] + ': '
> +            del extack['msg']
> +    msg += os.strerror(self.error)
> +    if extack:
> +        msg += ' ' + str(extack)
> +    return msg
>  
>  
>  class ConfigError(Exception):

