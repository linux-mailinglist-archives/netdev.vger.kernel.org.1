Return-Path: <netdev+bounces-270128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEPYN2vpvWmKDgMAu9opvQ
	(envelope-from <netdev+bounces-270128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:42:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA962E29DA
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8EEE3060BE3
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 00:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A3F31E107;
	Sat, 21 Mar 2026 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTtTFSRG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD272C3261
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774053613; cv=none; b=dhEcAACrsg49OiVFvcotTL7ObR0m77IK5S6iPuzGVb17rH2d5VT+HLHd3uay+HlNFt5HVI6sSuAXRoEz7ufu1r/jJZS6lKE9mTeDzI9KGsDKT5eSBtqiidxfeUZpZXqgs53uJDJI8uISSujHsrEuqzhMltB7Gi3cARjP2NvDB2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774053613; c=relaxed/simple;
	bh=MPzkA4rnkkQCuqpXpfd6+oMKFrOoPRYNMbYm4l8qyeQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ou4BWRaz8mTiZC7Nn+dXA3Uwi6/4H9dsgqZzaUsoJKHBnSJMMIVUEGbn/tlT0Xn5c2653oHF5nHyPZnvtGKDGshxKBDF0LV8w1xmmm5Mg2MbhXuV8TIB641VypPB55FD5cN+U/uprhI/iS9ruNk9a1wgaA5QsxK9DTjz2MuXzVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTtTFSRG; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ad019bbd4so1121496d50.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 17:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774053611; x=1774658411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/PwzGRNcB1I/BsMsmiZ9vrYb18/9jvWIWVEOY/l1EY=;
        b=cTtTFSRGIIuDpUw8X/gx7Zqdjnqud6KXEz2MXf1xYtKtH0U8Xzw+H3bQTPGl3OZ/s6
         JBOUnohtef3UJuFpkYTODHHhTGWljjLFp2lmKV8itbhsOo9F4dLDUWgP13kg63WlXoHZ
         2n3TpTIdr+ufTAArB0xDHu+0AM9Y/pTrssXZNaZWdx7a8bgjEPcm+BVmJNto6DD3z7bV
         Gj0elr+31lxSc4rokDflltxzTFERDF48EI1lDQs1BMXonXIx+cebKmo6yJf2ya/TZEBI
         FpQHorTZI5oU+Xac/pj8XJa7icZRAIA5hWa5B9wQh017dOzBQx88SSq/ih8K/eu73Xb8
         5tAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774053611; x=1774658411;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/PwzGRNcB1I/BsMsmiZ9vrYb18/9jvWIWVEOY/l1EY=;
        b=H1Ohz8z50V17fpZGkwTtQ5y35hBUP/F45ySEqTNOErm8E0BF325o6ZmiRQswE1Gd6f
         Dp3w/W3FfD9UYgqD+R1xFiYNZJq1uZWnA0o9anJQ0rBoUjocgGh9mInxIRhsUc6Vh0Dm
         ZT0umvBInQtnHls9GuaidrMzkmt9lcVk9TQDyFs/wXvaKYK3HfhfdG6Usbza7WuLgg6o
         88IaC8/dPacTaCbJvNRtDnGrhZdXJ5ScDgkRbS4oNrmEgm16DQoj76kfX2fNVphVdUpv
         B8SmAAmBkNe/Rw+GEA1KJ9aZMBQQ3WEwEjUHENSB77OAGb5Azz/2Y1EeD79dy7fxhpmV
         GCoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYcBYmXgRBgbj7i9EW9SyFKTLxR41Uiyuon3qwJon3tgsdmwoe8JLHOtmLdUqofzM2d5g/4JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWFhFTs0YI86mTidrQb9Ri1tFPhsgNwh0bqKF0+CtBVQ6I/lNl
	sU4IoPYsa2/XgFKwPRpw5fsrHndSEUqW+manmzbQKP2vIxVthig9hKWp
X-Gm-Gg: ATEYQzzlV3qZQ7VJssxbcbhcrUFG+K5GOm2buphSuL0/isbcM9XWPfE636BEU6G2OaS
	DvHFYkslKeJATbG1oPe27yPP7UUXwnW91GGBC9XIWvCmLzT39XkVmjD9TzLp+CXyhREXw9k890U
	/wGdvcOEmeLHvATGffFTMDh9f7FPQHS3O2Dc0aaJB1FnbZb3L5zNbT+LvGcOE+gmu3lPW701pvI
	q6V1Dp+p2V6PsNWmkvOI7fX/BwJNb3rQhJ4wrgmFQ6qMoG4SlK59fHVkkhDvSGvtO4h+vgsVaO2
	nGH0QlmtXg+k2AL/RRjPWQkjVpp+OcyCGkXePM3dEyxmX6Mwyj/hYyi25DllUCQNChNwM7tOnf5
	sMDhlOCrNQpEkQ6HLsE2CH28V394SIqBC8ZHI8TXz7VP6zcLSgSl38A40/3O2EyFAbtrtcjZ4U7
	fc3/0pInTMJ0aI4U2e/pDfM3ITZ9ZAX4dcyj7a4K/hFCgHsPd0eQBzb/ggQe2ytMIgze/QIwCEx
	IYuKTmFdQhsIpw=
X-Received: by 2002:a05:690e:1b56:b0:64c:aab6:65ad with SMTP id 956f58d0204a3-64eaa77f16dmr4156431d50.40.1774053611236;
        Fri, 20 Mar 2026 17:40:11 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64eabea0166sm2590013d50.15.2026.03.20.17.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:40:10 -0700 (PDT)
Date: Fri, 20 Mar 2026 20:40:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.14fe1e8b715a8@gmail.com>
In-Reply-To: <20260318134242.2725749-5-nhudson@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-5-nhudson@akamai.com>
Subject: Re: [PATCH v2 4/5] bpf: allow new DECAP flags and add guard rails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270128-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,linux.dev,iogearbox.net,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CA962E29DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nick Hudson wrote:
> Add checks to require shrink-only decap, reject conflicting decap flag
> combinations, and verify removed length is sufficient for claimed header
> decapsulation.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

