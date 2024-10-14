Return-Path: <netdev+bounces-135276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CF199D540
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 19:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 524E3B235D9
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8141A1494BB;
	Mon, 14 Oct 2024 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SQVjbxt4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF133CF73
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925548; cv=none; b=SUYtekQdTpqtHiZ4yKXScwX2ec5aiCpxklJ1J1/0oD54/X7XH9YwSe+RUAiMpbPTNNYip93ispwJD/jWLG2wRf7dIKQKi8K8Qsw1QPiZO+2tMwlXiKg511yTnLkl216+Bet7F6LL7sjrMSXD6HbqnghnTg57CQHXSzzIABC54SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925548; c=relaxed/simple;
	bh=I5FcYbkUSGC2cghjmOpPKQS7zLVcaSAXyswygnqB1pM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gM+I0t10yYLW56BjwUNkCbWXTjV9TXhIJ4Jq/Gj616xNdW2OQqyP8Umt+jX4GEqkZIvMRDVp/oQrixDCal8EXSgS+RW8ceg42YVrfA8IXN+wak3lVezB2YSaatnRCWEBBe+fVjFVCYhDdv2EPnrzTpGDE92Qp53DTU4QHbKA5/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SQVjbxt4; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539eb97f26aso1839162e87.2
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 10:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728925545; x=1729530345; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5FcYbkUSGC2cghjmOpPKQS7zLVcaSAXyswygnqB1pM=;
        b=SQVjbxt41ZTOPl3+mZDrbvNJFNAFNHZRdbJYFUTAeGWnhcyaih+7xCVJzMpKs7Jaqi
         qPilw4KTCl8lRbgNOS3r6IBS9oeAGvnx+43f2LmG0uvrCy4Qt5SI2hoLdFdSnIMzFxIs
         5FUWZXzTeKP98b6i4v+Bng0ThEc+vMTWp/HaNROHXFJJGIv92RV3mFZ61LiVduya4w8K
         5ItGQBUYJUdgNpe7tjqRxaXqKdX+LBOcGZMTE0NeqaxQRQWAsPm9EvbK2xcHLQDCQAY7
         /0NCfcJJGl7xSIzH1X0PiUBawjlk2z8LBhTY5zJ+82HtPQPT129wlaoMKT7TifSLSEgU
         AdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728925545; x=1729530345;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5FcYbkUSGC2cghjmOpPKQS7zLVcaSAXyswygnqB1pM=;
        b=xIiF+ceNyUTOC4Rh9supzyO1viFrhruRg7HI+ZBKWwp+IM4IbgBgHZe1wobmtTMznq
         WsoTZQ42nbn5TiydsE1FL2dueFoQFMFy22HGyUSFTqBhKpB3n+DG020L1zjRETeIZm3q
         TxlcFUr2uxGnwYBCRvXUEgpU9E6AI+LO15fkEbB+gPXHZaMd2ZCj6M4TOTO6XS3YpWID
         McniJlpEc14t2iaOJiDg/FBHJW30WIfiw0K3+UFDdB/wSPPHuPsQUZYlj2paAzgiXsHa
         ROdz/2qLftEFLF+1DkSf03oit+fdDfi/n7wI/EgbdCIgBE1g50RdJYbOhYi5+tByUNB1
         hzwA==
X-Gm-Message-State: AOJu0YxISSs5NGjJvitAeDiFy01nv1bLADMl0kSHQqC61DW4uIY97kDj
	9PowNLrdf5bCclsd0YY7tNjjDwxPoBbIZqFVA9xXZ97js/ekJG/Zj94/YoL+1gCf/0l+7WiFvKp
	N
X-Google-Smtp-Source: AGHT+IHZC8BpHa98fqTQ2YcZl1Bs8eAjMB9v2oe/MnNU/Oiw/RmSxHUUPOqFgc5AhYHJcXOn3d7YTA==
X-Received: by 2002:a05:6512:10cc:b0:539:e97c:cb12 with SMTP id 2adb3069b0e04-539e97ccdadmr3124396e87.34.1728925544543;
        Mon, 14 Oct 2024 10:05:44 -0700 (PDT)
Received: from GHGHG14 ([2a09:bac5:37aa:ec8::179:1c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431183567c8sm125595395e9.38.2024.10.14.10.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 10:05:44 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:05:41 +0100
From: Tiago Lam <tiagolam@cloudflare.com>
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com,
	jakub@cloudflare.com
Subject: Egressing non-local UDP traffic, IPv4 vs IPv6
Message-ID: <Zw1PZVgX/l0thRK0@GHGHG14>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Willem et al,

While working/testing the reverse sk_lookup at [1], I came across an
apparent discrepancy between how IPv4 and IPv6 works which I'd like to
understand better.

The bottom line is: setting IP_FREEBIND is enough to allow IPv6 traffic
to egress from a non-local IP address (i.e. an IP not assigned to any
loopback nor any local route in the metal). For IPv4 traffic, one needs
to set IP_TRANSPARENT, which requires special permissions.

The following python snippets show this divergence in practice.

IPv4 (needs sudo for using IP_TRANSPARENT):
```
sudo python -c '
import socket
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
# 15 stands for IP_FREEBIND, and fails if set on its own.
#s.setsockopt(socket.SOL_IP, 15, 1)
s.setsockopt(socket.SOL_IP, socket.IP_TRANSPARENT, 1)
s.bind(("2.2.2.2", 0))
s.sendto(b"x" * 300, ("8.8.8.8", 9))'
```

IPv6 (doesn't need sudo)
```
python -c '
import socket
s = socket.socket(socket.AF_INET6, socket.SOCK_DGRAM)
s.setsockopt(socket.SOL_IP, 15, 1)
s.bind(("2001:4860:4860::2222", 0))
s.sendto(b"x" * 300, ("2001:4860:4860::8888", 9))'
```

From what I can gather, this validation for IPv6 is only done during
bind at [2], when it checks if either IP_FREEBIND or IP_TRANSPARENT is
set when binding to a non-local IP. While IPv4 does the same check
during bind, later it checks if IP_TRANSPARENT is set as part of the
route lookup, at [3]. I don't see a similar validation done for IPv6 if
we egress from a non-local IP.

This is also consistent with what happens when one sets the source IP in
sendmsg using the IP_PKTINFO cmsg, given that in IPv4 the validation is
performed outside of the cmsg handler (again in [3]), but for IPv6 the
validation seems to be performed within the cmsg handler itself, at [4].

So what I'm wondering is if this apparent discrepancy is due to
historical reasons, or if I'm missing something else.

Given IPv6 allows one to egress non-local traffic without
IP_TRANSPARENT, thus without the need to set up special
permissions/capabilities, is there a reason for IPv4 to not behave the
same way?

Thanks,
Tiago.

[1]
https://lore.kernel.org/r/20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com
[2]
https://elixir.bootlin.com/linux/v6.11.3/source/net/ipv6/af_inet6.c#L383
[3]
https://elixir.bootlin.com/linux/v6.11.3/source/net/ipv4/route.c#L2686
[4]
https://elixir.bootlin.com/linux/v6.11.3/source/net/ipv6/datagram.c#L829

