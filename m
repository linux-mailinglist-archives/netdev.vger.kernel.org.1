Return-Path: <netdev+bounces-287028-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBthBQ70AmpvzAEAu9opvQ
	(envelope-from <netdev+bounces-287028-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:34:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 842F151DD03
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D53D3048F0F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE5A4963CA;
	Tue, 12 May 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Jtq/nUwZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6492E49250D
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578147; cv=none; b=b0U94Jlh1V64GPrjoGiRjKI4RY1iyLwkMsA2IQDBhDdGm+QlrQfSBV+nwqb4WoSnQJttcpQ2Z6tov99U1DaxwEaiUaWTSXqP9gyA8Oei7/UGh5AYWimYzGlbkDE4Nvm8LdXYqP1yjbP8tMQYrS6yyuG4JqCo3842I+xEaHG+RqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578147; c=relaxed/simple;
	bh=XNF7s9LHREcd5HQA7aPEH5IiSz2Z5X4Y8+T33U09Ddw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mZXIqnWRErxa/QEC8q12pLT7dq0gmUHmP8rkwO6S6lOAw5zOzvXOJbNdz3MokWpYB+nvZFSR2x1RLcprEHIi8N8ulD7EsHeAnAZKDPal16KsJlpUSNWoAwvYSNk+lWtpPMroSeHLzv0J0d3GahuqNFG0onuiSDZq3PBYz/whERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Jtq/nUwZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bccb9dca1beso474178666b.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 02:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1778578141; x=1779182941; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XNF7s9LHREcd5HQA7aPEH5IiSz2Z5X4Y8+T33U09Ddw=;
        b=Jtq/nUwZa1dPGa6NdaFja2YDd5HRL0trc5c0sOxgfrJHYjUjPiogmL5pT/7zEEz5MY
         CYscMEdq0xpwqz8QE4rAoxrMID/6hRp42gobodZBzGezA5YdOc6iuqLNkGxRHCihNO61
         TnCavyjdppXkV27lKbq8dBc5nMT+XPFbbpqPdd48dBkYn68G0MECcSzhamvplEVMWwlX
         2HZHElMWIJZ2HzW3eBlxORauw4uZ+Hfk8HDFAdldUFySs/4RPWpBFhB0yu4cSS8LG0wH
         GncMV3HnzeDFw+Y4vtymPJrIzIiGoBStcbZtbHibgyCLEN0caKb1h1xnDdU2AcnwX+SU
         wsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578141; x=1779182941;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNF7s9LHREcd5HQA7aPEH5IiSz2Z5X4Y8+T33U09Ddw=;
        b=YGZUBil+fsCVDmEQtlWbOQYhjFldkKgknmV/faQzLWBEEkxJo7VuSnEXsxlmEt+4a1
         DGGrf7CEK8d6BUYJhOonyYs9vXUkQBC3t5QQ5J3/17emc92zAd/AqHkxA8fCJRactDas
         jQnrrTo+YZjr12ASWUKqJsVTBxhdOm6LZVLEph2yk//lSVQAdxGbHT0LE2lmqSspCmcH
         szsPtN49qY4V8y9hukX0VY/dCSQqXXFTat00hctnLtQi87qbbp+EuexCz47Z0kXNf2Kn
         L1gQwplRgZoaU2pRLQeSbAJeiAwmRiB3wDUPtnBv6czJbo77ARwSh7jTlciOQWdVUATK
         BFmg==
X-Forwarded-Encrypted: i=1; AFNElJ8gIweYoGtSMOTv9bIEgmboNTmi2eoZd5688Wky2cpKlel6mpdyV/3Ph4LYdlBhNU5cDDajxWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqnBhzf4rXP7pdfELXHNN4XaXwd//hBeM7XF/YatqWSDTBj70j
	8ivRKqmgkD3z33fMYbgqE21X4Heykaiari0pt154GAZSDXiS9uB1izhluYARbM8bLmg=
X-Gm-Gg: Acq92OFQaFJIuP6mgMrCyo9bz79dCBGsKxmJx3s7qjJRN1GpZg8z2WyhEjkjCBgN6Hv
	FbzXDwDVtZpbxDIu7cxXvSf9Fk6jh3Gg9Y/QXja9tSYLrcKadPW81CuGKklQlYAC0iEcOu122iE
	+KTG4NsZaHzgPNfmGLMOvKfshlJrwWGLZ5ZTr0U1Gb5T3nPPCssdyWEK+JkWJgnRxu4i85zeYBk
	lA/euJ3s2NCBz5eifSvd2qshzziBF5nYKvH+QE1+Pdnm5cRB4JqY/L80a5rZFbR2AZ0H6RdDR0h
	CEjMeon05Axs+7V0skkT0vrx8BhWMmJCN3aOFLP9odlZhkWOqzCy1GdAa8Q0s1qbdJURKoNzKJi
	Rj/JM95cL9YTkEuQZ7J6H16ODeSJwTHHWiCTw6IBe6G7qOoOtN77XPhm6BOhURJQ0yCc0iVZvpU
	dMyggbXSaTUbuastgeiTwoa+z7hA==
X-Received: by 2002:a17:907:8b87:b0:bcd:2dbd:8241 with SMTP id a640c23a62f3a-bcd2dbd8f82mr684678166b.5.1778578140766;
        Tue, 12 May 2026 02:29:00 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcfac35c47asm311438366b.1.2026.05.12.02.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 02:29:00 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  sd@queasysnail.net,  john.fastabend@gmail.com,  bpf@vger.kernel.org,
 Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: Re: [PATCH net v2 0/4] net: tls: net: tls: fix a few random bugs
In-Reply-To: <20260511174920.433155-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 11 May 2026 10:49:16 -0700")
References: <20260511174920.433155-1-kuba@kernel.org>
Date: Tue, 12 May 2026 11:28:59 +0200
Message-ID: <87se7x7z8k.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 842F151DD03
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	TAGGED_FROM(0.00)[bounces-287028-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,queasysnail.net,gmail.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cloudflare.com:mid,cloudflare.com:dkim]
X-Rspamd-Action: no action

General question - do we know about any kTLS with sockmap-redirects
users out there? I've been asking around at conferences for a couple
years now and haven't heard about any consumers of this feature.

If there are no known users, maybe we can have kTLS+sockmap glue code
behind a build-time config option and put it on a path to deprecation?

WDYT?

