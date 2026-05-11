Return-Path: <netdev+bounces-286820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGjPFNA6AmrmpAEAu9opvQ
	(envelope-from <netdev+bounces-286820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:23:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EDB515C83
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B0F0300A74E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A080F37D133;
	Mon, 11 May 2026 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbpAhYXJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAA5332EBC
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530775; cv=none; b=q2pa+K3As/LNWpx6RSGix+C/dAxrL7osHSJwGu6ARKWOdob4RZoUEAw6+PnKcpTbAi/zdVmH3NakPC4Q24uKYHTqTj2qDQ4IiiFywIPZRf6oo3DBaw1ujhxjpVKP7Ub3x7OUR1vLjkHKP3C+bDHshzDK43rwRjXpyLjsMvWgOcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530775; c=relaxed/simple;
	bh=ogdKtda3T9nQf61cshw7Muwo57KPHf25egE0OXwm+S8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rd3G5+ipHNbY6iOUrfDcXzd563juoaHpq7oRf50DJw+mHYUpnjtN1E9hjrf4i7xRFKs/ny8ADHZNR0kF3rzzrHlg/iLra18eGpoV2d9/kDYvdyVE7MfE3no67jhlNUBfhB6WsAaLi+ca1rS307LI7m0eF2gJBnFHcEaCkyYpN5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbpAhYXJ; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65c7492a2ceso4353060d50.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 13:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778530773; x=1779135573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yyAWseWenb7TNJCjcuAu++nXRSt7iXOp1vMueGjd6Y=;
        b=NbpAhYXJpq8PNbjCM3G6qqbPuYwSyfaTcEhUtQ3JG0+VNSNJ30snlR8DurBpfWSN/g
         n7l7S+MvdRCfETsuRJ3EvzBWQ+w887qRB4g5ErV/daGO7F+M/1kSJWjJTv5hwynn8N/x
         bFnJ37Rs+c0m5YGSFBj9WRPJuZR96Ovt3RwqxZom2Q0QXuzLtxPm35kj5IF1NvcSzwD/
         rPJfsS4ZGJmgnQyQp1CQl0ulUYLjvFxS3URz/FP1lCs6sRskGXJmaXoOHKGOlCdPoADB
         ECBurIlsedqTAPEUITnE/mm6HqpA20FS6pOezjqIkkEl3Xa8mlNnOtjlNB5YCVBoiWhZ
         BQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778530773; x=1779135573;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8yyAWseWenb7TNJCjcuAu++nXRSt7iXOp1vMueGjd6Y=;
        b=mvk9vauxmrljh+R/IlhrJE4fDTi2OiwoqtgePg7xbVOsErWc1SvN2DaBZ63fjqiPFA
         eXu227fTVl/18AK4gLEl4EnNZaiHmGys4KjPOj7fxRd1lso+Ca0uLup6u5JFdvzuxZ51
         ibYJflf6ntI6RUSlDzVh9odQEDdPwONbTovadh/ygDRaNd+NOPOvKyD72R4tgvhi3+BK
         UPcNERBBHxoWbYI662qG+aeBPmVjJ3TDS0+LatY9DL0GvHtp3/F0WeAq+gxzOZyiP8Yh
         3iYtq4kezmfyM1Y5W6BJ3fJovorJdTcJ32K6yof4CzqJLwmc8d/ecSDMXJffLEP2OJs7
         lWvw==
X-Gm-Message-State: AOJu0YyDW5i5PRBUqh0Mw/v9TqeW1ESDAKctWrIVczrICIeaXawYa4MD
	xeQIrIZB8O4ZnqZzLwqAy/0/vEXoa4wsLHzJvcCq4oGdnuSB0Ld2f3up
X-Gm-Gg: Acq92OHbwmJDjmDab8ov6Mlffe9k2zmKYghmfNYbWEPuWXgUknugv0Zx4DBuvfm5WYm
	emcyE0C8aTEsniG/8KkFHiAeaAQpndXoR+nAIutDhJN4Iiq6tE7x3LasZ8HeQnu2oHE7kUrTcWb
	VvozJCVjMPFU7tA4me3KLkA6Z7UREQ+DeiTjgXrzGI7nKzogA+XaE1dwRx7wcjLFBem9x/NhOY2
	RkigDgvjcOCObuU2GtyaveAGPHjts7AYGSPprfExlXLbrYN4nUqR7BfaN7GrpEjSMLD5h2lSCtg
	+XdyG56COaNhBFFRIz0b6RBmfx0Ko7ZMnDjaAxfheKsHbXJ3LuM+KZ7L2BTs06sAc5S8D1M1VGt
	1cithjY5vP9kdTmayNo+/cBkAVLAwbDAvrv7e86c9bYk7JbloEXiCFh/6iYQHJUknd+NBgWKRXL
	jNmt58UShiNRytKKth9soXH9ZPKp4S/Pd5XJl2IKdRSfgEwVqqMQocsrNdVY7Kqn9O6fid/b7GO
	rFp
X-Received: by 2002:a05:690e:400c:b0:650:dbd:6f83 with SMTP id 956f58d0204a3-65c79edcc2cmr27108347d50.48.1778530773426;
        Mon, 11 May 2026 13:19:33 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96be4aa2sm5840964d50.15.2026.05.11.13.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 13:19:32 -0700 (PDT)
Date: Mon, 11 May 2026 16:19:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2e67d0e8191ef@gmail.com>
In-Reply-To: <20260508-nsim-psp-crypto-v1-6-4b50ed09b794@gmail.com>
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
 <20260508-nsim-psp-crypto-v1-6-4b50ed09b794@gmail.com>
Subject: Re: [PATCH net-next 6/6] netdevsim: psp: count rx authentication and
 length errors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B9EDB515C83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286820-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.996];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Daniel Zahka wrote:
> Now that netdevsim does psp parsing and aes-gcm decryption in rx, we
> can report authentication and length errors in the psp stats api.
> 
> Assisted-by: Claude:claude-opus-4.7
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

