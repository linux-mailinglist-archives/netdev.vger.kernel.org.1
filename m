Return-Path: <netdev+bounces-274286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPZ5DlSyzWnJfwYAu9opvQ
	(envelope-from <netdev+bounces-274286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:03:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8CA381DD5
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26C90301B86E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 00:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2ACC2EA;
	Thu,  2 Apr 2026 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPN/b5ZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ADE40DFB5
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 00:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775088207; cv=none; b=tOjJLOU7uiFXLuHzVB8EOXM5yAAXQw5kpkC4X+zp0cgdAiojzSBC17Z+lOADAwUHeYwfVMZVsLtnFdKKQMTbEfSuQUqZQ9hCV21StHe2MHXyUH9SltOf5nsOY8palRcqaYjo/uWdePRUuvtTQBxXRbpn/TjnvSGK1/5PAZRwCfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775088207; c=relaxed/simple;
	bh=Y1N1O73Noe11Ry+7RkTMEumTw7rqGwyAy8VKzzmXGKo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=c+sXipa+/qNeE74yZGQ1DA4b/g9IGlFuNsHMXscGiitZKpTHR6vL6/DIsnT9IoxFBRkGrnx1J8PNGuen6kCF2z5Qx5iodEVD5S3JVWWldCceMpz2vPG1t36J1hKUTHuju2+I2Ovovwz166zhpREA4ip8KQmcqj/rEIQajmmKSY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPN/b5ZL; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79853c0f5b9so4830177b3.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 17:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775088205; x=1775693005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFQs/ETxRhHEXZRT2NHqizkA8V+kgzkft9bf3gQGYO0=;
        b=RPN/b5ZLrxh/lmz2VNh5HxizGmAmkDcnQotIwRZUeP0KGzIZFp9meHscoCvEGhVR7j
         br9UChpW0a8A5sk/2CXXEXAyUZb6dUPGUWA7PprJJ2scxIec8vBfgZ29NNlTvWHl5uae
         AYROqUK+VDchMyFn1rXp0RIc7R4skjfaAbXAGnXtd9rxEK5Gi+2slRdiH5S6vaxM+YHo
         4QoCJ9rAQCbP4Oj7GbUQnT0J8bBnG7HTs5QrZ1cnFFCGMa1jIXwzyC9u2mp6sa++ZCz/
         vue92duaZAC+nyy7c3+kj6PX790uXIuD7U5Sxg/rVBr8FjkRX6EI8vLfn87H7MDQ+A0S
         6e1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775088205; x=1775693005;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFQs/ETxRhHEXZRT2NHqizkA8V+kgzkft9bf3gQGYO0=;
        b=eHACYcRp85TCw0671IW18vheiJLnzS1cdmLHTjpdgL2YZ0QqRXMtR1dtmfQDKJQBgP
         lWaIBfzOZk80ZzNhpou+RTxBzVWFBxF1hqPkcF2bH54rhZQwc0DAMRPq2wfsJexm5Som
         ka17tCwqtXihOhn0CuhY4rMB4KhDFGTf7O+AvyfNyo+UcpWYmpvgh9xKlIk1XHWUGHPl
         s2xsMGpmgjjZ0ohhwP0GLEm0etCRm7Bbu2W1EVFifDhKD16nJZ8bGP4NVPnQ9QC/Jh9K
         hutpHCZMUdGh2HBH6j1phlhkGqaFEBL2+owmW9xV3wbuXvEWfvB+OV8kUS/KIGNUtXm+
         BeDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhi9Pg+sCfNPbWIgRBGu1eTp5XVkHeJyNZFTFsuJE6ZFbbfPKVKaI6So+JEw5HeP+XguEKbVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6wWBgpeMu47it2HMxH6cG0ZPc+x1TyR9YXk5wZ+W/EP4q7rKv
	fsXSl4EHndc9QY42iDD+vvt2C//YJeBZ9VJ93/0IuktYy2UmIHx9KYKR
X-Gm-Gg: AeBDieuRnk0eFMXQ1pq2dY3R+5h7ih31aRgddmYR0ztWFK9vQwJjekZlQtDQRvMv+gp
	rVvWugxohn3fJ63pLaHnuWRFji/MbbVkSW3t9YYiStCdYHfPHcAoFIWQe45nxeMXg9o9UigX/jb
	2YtCPSCDJNCi+51+xuaoHRXljAPqFl4jLX3bEEHNTX5Mk5lYtrf/0ObjP1+RB2qe8WiLZnsweft
	sGjvDWDVp/e5umhGCb6OOAj3Yun/ARuK51X9VlMpDuSb4S2ZPf927mTc0r+6xRyciDwKd4RqLrf
	l+nK97A8frQvj9zfUAkOY9y6nlphhd4cbBrN7smX9a/e5Z9BEdGG22KxHUq7Vy/28kbz61aBPxc
	w/SmuuKce0CnhMJq6O8umWjVJg7OoYLwzZcQMaWAwKO7tmJZpxMKjEv8wV66Rn+n+D5SfyUK/8Q
	XmXKsHITKwc7TnjG2pXKenTd0bO0rBVeFuOtO3rR0ePY3b3nYSlLtMJI0U7jMQaFqdwCJQXRbdY
	ghqa8ztoO0YW7Y=
X-Received: by 2002:a05:690c:698a:b0:79a:bf27:fe65 with SMTP id 00721157ae682-7a211944c03mr62480757b3.35.1775088204878;
        Wed, 01 Apr 2026 17:03:24 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e22b926sm4778687b3.5.2026.04.01.17.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 17:03:23 -0700 (PDT)
Date: Wed, 01 Apr 2026 20:03:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.39df795951b68@gmail.com>
In-Reply-To: <ac2OJvW8ZfzDFtHr@mini-arch>
References: <20260401183309.378671-1-kuba@kernel.org>
 <ac2OJvW8ZfzDFtHr@mini-arch>
Subject: Re: [PATCH net-next] selftests: net: py: color the basics in the
 output
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274286-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C8CA381DD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Stanislav Fomichev wrote:
> On 04/01, Jakub Kicinski wrote:
> > Sometimes it's hard to spot the ok / not ok lines in the output.
> > This is especially true for the GRO tests which retries a lot
> > so there's a wall of non-fatal output printed.
> > 
> > Try to color the crucial lines green / red / yellow when running
> > in a terminal.
> > 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> > This is a bit of RFC, I'm not super convinced this is worth
> > carrying in the tree? Please Ack/Review I'll apply if we get
> > 3 supporting tags.
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Minor aside: I don't know exactly how to exhaustively test whether a
terminal supports colors. If unsure, an inverse approach to err on the
side of caution may be safer. But overall +1 on the intent.

