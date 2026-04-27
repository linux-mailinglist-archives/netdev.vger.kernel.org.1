Return-Path: <netdev+bounces-281534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI9MDNns72mjKgEAu9opvQ
	(envelope-from <netdev+bounces-281534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:10:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8133047BB83
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCC46300DF6A
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637953ACA7C;
	Mon, 27 Apr 2026 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBYheo8w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DEB2DF12F
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777331414; cv=none; b=KOf1Bfjs3uD3HPbMfcM1OnzTZyP+eIeUjVZJED3+FO1cKF4pOr9PhzNLWOtRtifa3992XMi2rodmBVs8Yjr55KIteQPsBNSeDTZ4Xq2mKc+FZ7oPZWwS4ZEr6fAYN/qvvjCsm3FJXKDSdQXS7YM9TKZhUxbWrtcicgmu48oq33g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777331414; c=relaxed/simple;
	bh=CSI7F20F+XmAo5hDjJW5dsCKsqUL5ibHCIcsvBjX510=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lmSH7+d+YfPpqYy/AFsJ4SEJRMD5en4n1aOAesdKPLYnByATs6s/a4qAmZfP2UZU90BHX3pJ80+pylbfqyPHxIlIzjABeasa1HjBW0ZNjdpn6gaq4wC77cbIUdw+76OOhlBJSJcxY7RLsrMKVN7gmbfUTTfqTh06HijyFaM47C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBYheo8w; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79885f4a8ffso114565537b3.3
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 16:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777331412; x=1777936212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJMQ5+ww3M//MOV42Q4uI0oLHRbxuGr+md3DIPOawPw=;
        b=UBYheo8wsDfEzQpNIkmfgFiMKflLRffCPdp0kR6e+ZYmBfmj8BBMlgM7xuZW7zINH1
         wWpUyNRM7ise9114JQ0KPkf+KKioRJl+SViKlJWpE0LqYCwqUImUwOGmo6NLXV+1EEhH
         Z5hET1wQmwVtRYBY8WAt9TF8FF/+weErjb+ra47iewl1HtwHEjFXhxw47CbAb4Cx91j+
         7Z0E2CK0xN3YhdzJiBy9IGkf7oKuEpML1oAPgcuZgWC7xlmtWvX023k262jJJ1OmXepT
         ZQeOojUrg/1wjqVFGvjCdyjpZpaQwEzKw1PV0c/ThnynCebIzUcxx0C1nnfic+jjSaOG
         5MKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777331412; x=1777936212;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJMQ5+ww3M//MOV42Q4uI0oLHRbxuGr+md3DIPOawPw=;
        b=scr27bvVClNu0T6Ah2JGTq4bDNni3eYne4qRdGWDjXY7WFe66d3EjCHFAqH7onZmlJ
         SUvX1ha1Ppe8vTy6tptKNhaZT5p22t9ihk7pf6hw+pmyCwGb95wLjvUJKXsKlReBaiSk
         Umat/r2jeErh0fLxtmRfykRxSDoVRqRZBmfXPBIzuxAqCmrDRzmCzoV+tJRlmUKYFyE/
         hCn+FGzGu4Eark/InLzm03XCvZnefmxXbsUHULJJ4T6U91MNmi9/qFf1q/KQII6sra52
         vJtJHC9GrXlgUc4ErnNiTVB4ZrqzXpI/0VOdOHdCEF+w01HI7t2+Pdcn6jVhBB8J55iF
         z4gw==
X-Gm-Message-State: AOJu0YzB1OumjeF4lQ1ewWIYoL5bFozOZtdS4SmvqbQsmcHN3NQEjUWT
	fk/VMzJRecCZG4DYsAtODqhdBujgd+Q/Oo/Yht3Pp6sk4CiUvs0B1KRh
X-Gm-Gg: AeBDietvMhm3MAToI0wUEa9eutU8yVPKtMKCIfZ2e/x4bHO8Sv0qFzTBtKUgoDImUJi
	RqlUb5s6GVqp1U4EVPbONnfMDCHwQ/QFpw+9OqeUa9vXC8ZGaflghciNYnc/8Zir8Lrbv8ng/XU
	a28bc24VVm31M09JiL7Xog4KTuHHBhHmpjBWt65SBu6Va4X5mb/9KNnHN/PDmNcCECskkurxumr
	1uRlcV6IQ9/m8sauUiE+1dDUU7Jcybgvgj8MBipHtWayp7L86h3462JQbGy8XURioKtsVpjR09y
	0I6o6ZyskcS5ag25HcC8n8Uk9ZQ/9uk/NQIfSr++MaQxZKlobIhSIYhErbnJVyRjCU5CQHScOSb
	gyvXBFzTxyKH0DCJrivJjy0Vwqo6Gn5uyu9mRKpZS6JDUgOQ09DZCUsbgePyMBIYdvLuQXN7STe
	C1bQhxz6pFIxBZEnGx+auT32K9oUxUeET3g4KUgcwCJvadew5hfDQpUpmi59DSdxY0UC14+OnvN
	rKQ/Jfm2f3aD16R6U/f6+YUIA==
X-Received: by 2002:a05:690c:3586:b0:7b8:bc4e:a75 with SMTP id 00721157ae682-7bcf51f29f6mr6511367b3.19.1777331412040;
        Mon, 27 Apr 2026 16:10:12 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bcf0aebe09sm4443907b3.30.2026.04.27.16.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 16:10:11 -0700 (PDT)
Date: Mon, 27 Apr 2026 19:10:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 daniel.zahka@gmail.com, 
 willemdebruijn.kernel@gmail.com, 
 donald.hunter@gmail.com
Message-ID: <willemdebruijn.kernel.375ee60037335@gmail.com>
In-Reply-To: <20260427195856.401223-1-kuba@kernel.org>
References: <20260427195856.401223-1-kuba@kernel.org>
Subject: Re: [PATCH net] net: psp: require admin permission for dev-set and
 key-rotate
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8133047BB83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281534-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Jakub Kicinski wrote:
> The dev-set and key-rotate netlink operations modify shared device
> state (PSP version configuration and cryptographic key material,
> respectively) but do not require CAP_NET_ADMIN. The only access
> control is psp_dev_check_access() which merely verifies netns
> membership.
> 
> Fixes: 00c94ca2b99e ("psp: base PSP device support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

