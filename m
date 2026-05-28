Return-Path: <netdev+bounces-292722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P9PIZZUGGoQjQgAu9opvQ
	(envelope-from <netdev+bounces-292722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:43:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 075965F3DED
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98A0731D18F5
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393AF3E5575;
	Thu, 28 May 2026 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="eWbst5Nn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E9352023
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978710; cv=none; b=JQKNDIGkEtg+J7/t46yn4k6hLMs9tE/oiXbmEWwusL4+s9pOp4H5bwHhZd6e0qDzYRJ9bdwsaas30tJsBfgm9bTDAGWwh8zoTHhnmxRQ7T4ZLHkELWWqpxdcD242wcH+9NqxjLbRJ3S9qY7Zm4RmQBRR1xrRgGoYo02y1ZZmvTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978710; c=relaxed/simple;
	bh=SXlX7u48JnMYKj0Nje6QkmsuNv0J7If4EK/lplL+lZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DsalK+BM9B+/gmV1xmnCzsbAT4a+XbKStibEH9D1xnAg/IUgSilwCKDPwT4F202yx/8DKf0spOta9/p1u0wSA7R5fPymo18w0zaanoDZdIBVplcVBAy/rmRi4ljuc1lLsWZ1jgHMk4EL2zIeMoE6Mz2OBzW43yLEHrFS2z89bQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=eWbst5Nn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so81797385e9.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 07:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1779978707; x=1780583507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bM+WzYj202rkhAKw8isFN4meBqK+WDYoMBYuhC1fFsk=;
        b=eWbst5Nnb2w9WuVCo8m3AAC9Bn5jGWnrLKg75i+1Xfq+EIV5SMpqw68QD4xIvTzrw3
         ev9rd8Sv/IF01cnXct6I8NytbTpi2sEkLcPaoCF7R8FFFc7Nd/Ral0XrkF64E4HevZ5a
         24IJOpiYJ2CQYIq/uTldsnyosyKDB5a1Ny9gKZ/F1X7gYm7nT9uPXXQpIhKPMp5KQ82N
         BrGTS+ZUtKHK6WWAfIMFRiGljl4dh3auW+7B4b5mK6xYx+OazHflR129QHLJp8KWPM9b
         nyziR+/HrbCQeLIPzB6eAHfIayBM5XYye5r2ysnVX+eC0uWZA1XHsUFy6eyxBDqGcyhc
         eMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779978707; x=1780583507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bM+WzYj202rkhAKw8isFN4meBqK+WDYoMBYuhC1fFsk=;
        b=n+NI+PgdLcSFv0xI1MPRTZI0O1+7QACnRRz3TM5f3URQzgqxMXWBZo5UTpqb7nj6dY
         T3rGRrONAvYXRSzbG521aMrjP45OFNh06aj3LDd2ytcxG0wcLfdx558ofe8vEsOp7ZoT
         gIOwB5ajAsxpDcjcaPurBvg8Sk4gTwO9DGfn94Ar+GGEozv3Yyjl29ozSOXLYe4jAIlr
         oGeHqRALHbAvldX0TxQF+aGAh7DXBL+UeIJzxxb178BpNiJSFiD6UHGhkiV/qWbMRhwe
         Vvg8y0x1XGUooJGYafx3i5zMVROlMG6u70tAAPzR7xW+4XwpMN37GLQW7g5LWmUsn1ey
         BlBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+xP2SjZK0peZokwun99sziY+jsqrsxZam9GTX4hUowescbGMXoIeZ/jdjlcYj+vgy5v0qFyxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5YOwe4GjL24dvCs4sVHONmOop1Sm3gjcTw1mJ7AWsLTmH4H4C
	NMqgTFIy4WGU8YYcKkLs6rudfp/ubQypVPDlRlCEg4eF7IKotP+O1gCe2UzdlRFinHCQBN9QDlc
	LTFSIDFB3EMnVYvcTFyJO1ZP4jXQ3WcOUJyjOZjHPByfy75fEjHQ=
X-Gm-Gg: Acq92OF0yKdTfdLenYY3aF6mEhQVVUx0FF099osXLCeMvph9PWtC9sYrdpBn8qr7Kj8
	BGnIsP+FJ8QG7spoL08UCDwXvVwCyxIi6mOapd46BlOeZdo7Fq58fgkSOZU306QjbMsrw66aHt4
	cw6LZAnzRnw5pNI91iZih5bgNWcZf3I6KhzXYr0eGm6yE9TEoNMOkyHqboHyKetwmc4gNWya7E5
	YacdWTnq33vwXh2Yq47MXhY1jpODc00lP04zk6sZLoExvvsCz8O7dABAnTRCFb2SHPmsKsDmd4M
	B87hccu2wj83hAhu3p4B5aCcyHz0lpEWy0eCxv3Q0/P8isSsgHZ0ttt98SfkCaX8s+rx4715bXt
	RRy1HmnN1QWFdV3UibCgmXcUV7hgXNbnLLxlUw31VfOdTSiTb7POnuW12GfBZOMz0JgidP9UuOg
	ar+mLutmw2UDR+WW6bhHhaXssjAsWbTXdhZ3F1p0NIfY7vetD7ZgVPjLVFzw==
X-Received: by 2002:a05:600c:c16a:b0:490:6237:5200 with SMTP id 5b1f17b1804b1-49062375334mr331038155e9.10.1779978706926;
        Thu, 28 May 2026 07:31:46 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:4cf9:4344:20b8:5b16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908e9b0c57sm25004975e9.7.2026.05.28.07.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:31:46 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] ovpn: fix peer refcount leak in TCP error paths
Date: Thu, 28 May 2026 16:31:40 +0200
Message-ID: <177997869357.4170470.2497863930631173471.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523090244.504790-1-jhapavitra98@gmail.com>
References: <20260523090244.504790-1-jhapavitra98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292722-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 075965F3DED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Sat, 23 May 2026 05:02:43 -0400, Pavitra Jha wrote:
> When either the TCP RX or TX error path calls ovpn_peer_hold() followed
> by schedule_work(&peer->tcp.defer_del_work), and the work item is already
> pending from the other path, schedule_work() returns false and the work
> runs only once. Since ovpn_tcp_peer_del_work() calls ovpn_peer_put()
> exactly once, the extra reference taken by the losing path is never
> dropped, leaking the peer object.
> 
> [...]

Applied, thanks!

[1/1] ovpn: fix peer refcount leak in TCP error paths
      commit: f9e5e5f464d7a7c5b71a48e06d616f57e05a66fd

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>

