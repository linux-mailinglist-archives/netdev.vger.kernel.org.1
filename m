Return-Path: <netdev+bounces-262795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI7nH7/spWlLHwAAu9opvQ
	(envelope-from <netdev+bounces-262795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 21:02:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8D41DF117
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 21:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 730D330B6D40
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 19:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48833859D8;
	Mon,  2 Mar 2026 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNBn9+G0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EC32BE057
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481491; cv=none; b=AX9IXmxlVA5JlVo9YSYMLTBoDwoJV8gJtkfoUn3EK23qT44Ft4HFEbpVG/f5LmNg7bZ+MlpboflCLXykfyW/b/8lgzCmvM5mfuJyu3yTJvj0aIFw6hIe/auG2x8J1ZMisFTNbKIL848/Fm2ahJEOnTNipG91745B3sOkyCW3M9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481491; c=relaxed/simple;
	bh=458fDQ/B9kqPB2eKzsPd62bpJwFO/C+QTJWCfiPbi+Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aIrxDDVDNlrxuOR+NT6/9lwvFKTnMQN1/xwjPxb0L2GM0DUN7sufbjOO51wKs24g5Qgwev7DRdGIBRHHHp673nvFKFYqnUpol9z/ortoIlUIvlYeYRwvPpIjO4TaOvYAtcyaA4fPcDurhEYcTq4sErE9COfFS9YZpAIeco2ymQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNBn9+G0; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64ca6595c8aso4457576d50.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 11:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772481489; x=1773086289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KW7DL//y9R9HUHz7cqHcb5MSmIT8NHHaKcijje+Dlc=;
        b=QNBn9+G0qA2yUW/hlDPzOkrVvgMDDNp9StTKJiaAlZ8M8kNHd095Fo6PDsn8tuYuJE
         XbfilE1HX3n+zY6CuahXopQ7bFFPubxpCfR8w/sSETCH/0rSMk1D8oJbxlipnXxTzso+
         2J2L6wPmWV1oGRNNFc+OOfqSCB1PRjP41WANjd/4Kwx0ZQNJkaCIThZJC9RZeanG0rtw
         D789yLZQMIhoPbfad5Obmi3f9RlPH30PZx3DW9yTogcQee5OOmjbSkmaHGeYEzvLKV1P
         cBEmOayRFwLVKqW8F9jPWGdzUNKS6ke+MsGm0Byb5j//cRV8tjHJM2lLLU7MkBehZksq
         vOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481489; x=1773086289;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9KW7DL//y9R9HUHz7cqHcb5MSmIT8NHHaKcijje+Dlc=;
        b=aMqZ99zDZJEIEtJGhDyuLtCprKYf7t6Qep0vuLCarGGnU0AuOpgTBYDaVj4FV4+QIA
         SvdMAsWZffAYpN2RfSMy3aonqMZBJG0afl1U5r3VGkCRirgx/WhkZuv8YblaMg521PEu
         1JiAHon5T1pWKNGSmoIW7mbE5VX+Uml3k03Pn27O2i+fuj9Aygz3yh8ZsgRlPK+2IoDK
         6NAuLx41UwUYltTWxVWfd+7TwO/Fq35UxbRImLGDR5NAsbI3rMV4/YEGokDoylDdwNzV
         0jfL2LbfRgMg6AX6AZO7PVKqzGEkG1nmQCHYTvduwotbU7bsI3WYUFlcLqWEvm1vLE/a
         76Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVhyfq7ks79nX8Rk8M5IWeBiR9zQhf+83uCDtfSAlk9HZWJ4TwpxS+IDvfiVaPxTJAXwKVKa+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGTB4W+4bu3cUuYZrk2pBjwpO3dPnuB6ueWzYqm63/9M6RxhF
	P4aKvY++sG8r4eis+PQrfCjZFyvl9ZPMgd+WQ74ckO8YIIYMj/VrgmRF
X-Gm-Gg: ATEYQzzbe0c5o+o1j3zUYfAVj3Q4XbxCxyoU7Vn+hcHPgF9fZ2HGT/Cro6Kuxr1OwQx
	9dQYwFJds8yOvO2ryhC1QGpgQ61jjfRJHroOFtJ+juw/Jh22sXCK0IPGattV6syL62+PbjpJA+o
	+lBtIDswVnSaegi/cr1AoDzdpbIRe+KVyyrdbOGwN7L7XkiVowWOmFr8w910fpeTr5XOaEJdbB7
	gFyuC3hqdX6ORNWY2wNNTEmEIzmEaiDoyIt4EWND6IxmN/oSVqIJZbhgFtzauHqOGD6tFzMY7Uy
	5LaFJ5nlleHeT7oTVQcSCpnqWbxotDeXgW3/Y0yqa01iGgwW7vIc+ruIu78rjMhImJgQ6uaM/8j
	O27DnktQh5xi7DBtGeJSnmZoz4pJ1LjQQdXhdi3RgP0tEMYkkeKGuNAlVFYLfgBhOmopIqm6B6i
	unWwYNqxcPGEioFOAuCyBK2Go+tpy6KH2uIxJecOHOWdfnkCIRKPFI1sj80dorQTlvderS3us=
X-Received: by 2002:a53:d00e:0:b0:64c:b65b:4062 with SMTP id 956f58d0204a3-64cc2289918mr7474046d50.42.1772481489064;
        Mon, 02 Mar 2026 11:58:09 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64cb75a1157sm6105171d50.6.2026.03.02.11.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:58:08 -0800 (PST)
Date: Mon, 02 Mar 2026 14:58:07 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.352024981d617@gmail.com>
In-Reply-To: <20260302163933.1754393-1-edumazet@google.com>
References: <20260302163933.1754393-1-edumazet@google.com>
Subject: Re: [PATCH net-next] net: fix off-by-one in udp_flow_src_port() /
 psp_write_headers()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BF8D41DF117
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-262795-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Eric Dumazet wrote:
> udp_flow_src_port() and psp_write_headers() use ip_local_port_range.
> 
> ip_local_port_range is inclusive : all ports between min and max
> can be used.
> 
> Before this patch, if ip_local_port_range was set to 40000-40001
> 40001 would not be used as a source port.
> 
> Use reciprocal_scale() to help code readability.
> 
> Not tagged for stable trees, as this change could break user
> expectations.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

