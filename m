Return-Path: <netdev+bounces-297863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VWMwI5j2KWrIgAMAu9opvQ
	(envelope-from <netdev+bounces-297863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:43:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A41866D693
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:43:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UUJBhkB8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297863-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297863-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD78F30C61D9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0EE38D401;
	Wed, 10 Jun 2026 23:43:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ED037DE84
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:43:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781134989; cv=none; b=jg2ZPB2uwZ6xvZ5JhA8wp+8VEpC/nmW/5EShNUaLJsakktsBSrVnbtFfT8JFRhW///R/z8aKTLMQq2vbyPrOZ0oemFEs5I/rhlUp+Z8W8+GDqeVcE6dUMyv7WCT8xDpASK9O61vTUYZPbvWC+5xK0BbkRpMpxKe0uy8Yd0ffATQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781134989; c=relaxed/simple;
	bh=JsSFSoN44TFVz/6cV9BMkzX2QhQadkdQZzqFNXNwr0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUhi3NcWkbJwdZ+YhjWrymJIBjDqnEUoPvXENJ/31WwYcUcbYe654m3NdebeRIoDjxmZ9ky3fuRKSF02woFWWHv/maUR7f9m1YM5FB2Pwsz/OT5OHbFFZX3gaIuWhg+v6cxzqFut7YMTQw4aBPipP0YIxW9vA4Cd+XWJsQoa3Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUJBhkB8; arc=none smtp.client-ip=209.85.216.66
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-36d9794d82aso5067939a91.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781134987; x=1781739787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=an0SgUn1oFV1bun03BprU1b2Uy0096MbOZfVjaHKMKY=;
        b=UUJBhkB8sfpvem76yql6tqKJZ/ehx6KUnAf3EaoOARnr2Ce6EIqJx0/uXQqIEvTR23
         GVFuRlmhrE4XFu+auh6oEcrhhgdbteoEdKv3vLDEP1dmD9t6OcGCAZfUxJWd8BS0PuzF
         R+xhGBLMrm5t3P/TjFMlkeULDS2xozEiHZ4CXkUIPUS8nMvzyCP6BpaSP/YJVy6nS/NR
         RT4nD+Ve2ftWudlHjCXt/7bEzbtSYFUh1DWr9PZjCFNC9HcHiJuurvHLdnKvrgxzkLlh
         cW23kHyJXGkP/Q7PqUrHVhJhmbxXJTJ67ByRcStPjNrWf/5JDD+fZhou+zM3n58hleYa
         ft3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781134987; x=1781739787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=an0SgUn1oFV1bun03BprU1b2Uy0096MbOZfVjaHKMKY=;
        b=pcIdvsk5KsyYoPwlCOfQE0dyVGppAvATCYIgyUvWsaPge8MIS4dpNNzgZQJw7mxK7m
         g3lYJZ6xqXjKmozKs8z5ESE/tEJGRWuatp1SXLNekVra9Q6rvn10pZO3uLNcZMObtN3y
         7Zn1ACJSzyRs1+F88Q2oShIgQHHBVz4COQzRVKNooo0/XGAzICYI7DhKnQQxBUGxrL+S
         6kpAO+7eoZ2daHllvciwioBKHZ5fBEhtrJz/pW4BTTyqXPZLL3RtuWqI6WMy/GI7Wdhr
         vk4I0GSe2WT/yR7bK16UPTC01wQpcH+tvB3l3Xzpsdh28QH5jPEXydn0x/t/QclUdnnZ
         p1lA==
X-Forwarded-Encrypted: i=1; AFNElJ8GpNZH/pu/C4xtpM/nsLAT/Cq0AlzD92PYf+IbPNiuQvp8IfBv1sA3DC5UNoyXb+TDhuV+kkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60pg2nPKlBVRr7Yf/LkCfwtDruRVnA5zOeWjr1m8zzmhXz7B2
	yq51HLlxp6BOZY+SaSyBo+rYWq9RTDIvm59M8rYWy97Gcm6HpNSbKXc3
X-Gm-Gg: Acq92OHQ8IkxBK0m71ZZMt19tYpOPh95to/X5TS/e4HIPRD3Y8o7LgpAAahukFqEvM5
	VRdBPCzXRHeUKShxW8mm39dkFXdW2nzMZzI71XtVTQs0pOYXHfpL35SWL0b/49FjQMgycqWm/DN
	BtVjn9cSftDC4TP2v7gCK6qdU3IEqpeDTd1z7LCYnnl0e1pHIoYRMoIgRYeFLtUa/wtvQPKs7JA
	xAwmNHEFBmEo2XpL/JFtjIKxn7DC9yTwQyYo3ge/nBcVfo2TjVYyVnwYC3ZMx2x+mMcpr94V/pb
	b//tJd81Wo3JQSyCE32NjdL8ZFtpO/hwyLCq8dMPYM5hVcQw5hZ5+vALBKACab7IUVGe3S3J83N
	5ltq063Rb2kkwZ9lIWOQVsmmn4unSdn555aOPtHLOo0BaRrfvU2otvfpc01e3u29hbuF7I6UJBE
	dX30q9uZF7lLhoUHWShRvqBNc=
X-Received: by 2002:a17:90b:5708:b0:362:e826:cefe with SMTP id 98e67ed59e1d1-377a9194d84mr388890a91.23.1781134987030;
        Wed, 10 Jun 2026 16:43:07 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a1a9esm495657a91.4.2026.06.10.16.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:43:06 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:42:59 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, skhan@linuxfoundation.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me
Subject: Re: [PATCH net-next 1/3] docs: net: fix minor issues with XDP
 metadata docs
Message-ID: <ain2fMNX27Z-ZlzT@devvm7509.cco0.facebook.com>
References: <20260609201224.1191391-1-kuba@kernel.org>
 <20260609201224.1191391-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609201224.1191391-2-kuba@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297863-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:corbet@lwn.net,m:linux-doc@vger.kernel.org,m:bpf@vger.kernel.org,m:skhan@linuxfoundation.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,linuxfoundation.org,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A41866D693

On 06/09, Jakub Kicinski wrote:
> Minor updates to the XDP metadata documentation:
> - s/union/struct/ for xsk_tx_metadata
> - document nested request and completion metadata fields
> - point capability queries at the xsk-features attribute
> - fix grammar in the XDP RX metadata guide
> - typos
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: skhan@linuxfoundation.org
> CC: ast@kernel.org
> CC: daniel@iogearbox.net
> CC: hawk@kernel.org
> CC: john.fastabend@gmail.com
> CC: sdf@fomichev.me
> CC: linux-doc@vger.kernel.org
> CC: bpf@vger.kernel.org

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

