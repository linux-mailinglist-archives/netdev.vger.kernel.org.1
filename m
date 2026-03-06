Return-Path: <netdev+bounces-264819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGLMIwHlqmkTYAEAu9opvQ
	(envelope-from <netdev+bounces-264819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:30:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F0B222B3D
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98996302258D
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4071E3A8725;
	Fri,  6 Mar 2026 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQnXRPyw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E839F17B
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807363; cv=none; b=S7uB0lOgK5OT9LivEc4O3w2HHWnwVnHQpwBv37E3S5vT7cRpH2n1I7AJB9PnDsLa49+qgJilxlQdHYsgeO/P0RZtZ79Z0rj3HZA9WsqDPY+iGDQ83azaHNil1bO57nBjmWR55Q53x88ObbKel8ayjsdeQkPLohRgn0u+9EOt8KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807363; c=relaxed/simple;
	bh=4dxZNPnaKxb/NGgZVRqmwUJ0LlrEW4DV1oGVNgx8CSg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Y7fRfP5mzFIyPFTcbmk1ZeGBjvVBmYgIas6zAcu2bcKCKG1tObundg+41xDi9dusKmTW19eI+yAg+1e1iTn0mAGl0BBMZ/TzjloLSz5I3I+P7+gmS4mBXoZLY9AhXtFLLUwiyoeln7igr823ql36uARFVY8Q7o4Rr1giFng1mlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQnXRPyw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso85347055e9.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 06:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772807360; x=1773412160; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4dxZNPnaKxb/NGgZVRqmwUJ0LlrEW4DV1oGVNgx8CSg=;
        b=kQnXRPywVBfB9bFvhaGDVZsWeo636FH/0y2fLda4GrSJEhGMnQKDozu5FwLAGrAXok
         0NgLwo36Np6YWmYp+qSx5U6gs+NAJK0n/CQ/1AZ/gWGDCNW9I6KVliTds70BXLBxlN5V
         AbtRV3ysvBbvTrllxZ7P0EoTyRZERDVr8TVtYx58up/cRF27NNDDnPDIfHCAwvQs7mET
         j2uw5svNtrp4YZQGYathI6PUTJUnlOD8z0/PIUxhZodebs4DwBqa0lEvoyLA7qVR34ry
         93vry05rO4Y8dnhYBZOr+meLnsJf/+5wrNs1nbKqK86OFfUlmF/4FZP8gcbus6c85RJD
         30Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807360; x=1773412160;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4dxZNPnaKxb/NGgZVRqmwUJ0LlrEW4DV1oGVNgx8CSg=;
        b=gNx+0tpmuW7i+HoHGbUYVSiXck7z4XbUiJj3yNWLmI7L8IpAuJkNfF/GZC8RQmluMC
         0qY1QpeO0Nohi3S1OLyz1HsSnPTfoMpz5fwSM1CTApljGxfJxeMx0puam7P8fJ8p2rRr
         scsNrI3GKcosccnqUfR1SjxI9kXX0Gx3a5zho0yLNh7TLdenkid6PdU6W00kLPw9pXaA
         XOfwGz5nhmpBaubM7WwLhnjCgnYS/C6ioIIRggCHNhotgTr4YUE2TXalw0FNOl7ud0pf
         UdANJe/Qek6Gn9Cz7s6DYPopaFXDv+DS5ul+PL1tkp8vLv7AsIBwtu9MZlKgebaQM88q
         vT1A==
X-Forwarded-Encrypted: i=1; AJvYcCU5wCinQD0caOp/wfaQA4Xq7ZGOh/NwZPhd8KcsfjFFKzQKKfJRPXFEVcPQJ4EB/SLTKipdK1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxob7Z4GAJNeHXkBJcXchQoTU7FatJnEv1sYJDvXIg7i+Bu9cO6
	ZwIIMtvJMzHpZ4DyWfTrXDNBnoNqy6O7765Lm3FGIm4670BpuTfsk+iV
X-Gm-Gg: ATEYQzzb7K6fJxMO3E3S4NCsa/mNkha8cbVXLJwC7kWe7D6BEUvsYkQVqVREZJKMQkG
	cGoEFZFCe7BwtUMTVmCJpwIg6TEEJSm8E7V/0kKYpQJXjoIR5LoQNyW2Qspzvt21opfd5lWQ9nS
	L3DfS8Yspi6iKPEvQekeEQeDOOQ4fhCXe0p/pxSFwHXdDL5vouauxzobzw817BG6oChcFZeOLP+
	iUDh7AumBZHchcCG20bl/0jO+X/JDh3yIgRghXQozL+yjUF1jz0b+NKWYO/rBkN1SzuuPmCZDem
	0Fzizn0HfseXlxlyaVYMbK6uFrWRUs2GyJFrvMwgIUjDIToitV0UaRy5z5mNmz28xhzakCH18a1
	dbDnUZQ9zNyEhRuzgapk0dkX4n3uRLEnjV3mo2LCtz9X1zmxianBlGce7MrrrfrdFdXI4zGbOg4
	i3GxqcZtmtJQVXhNzcjH9F7bsTkg==
X-Received: by 2002:a05:600c:a12:b0:477:6d96:b3c8 with SMTP id 5b1f17b1804b1-485269648fcmr33770035e9.23.1772807359863;
        Fri, 06 Mar 2026 06:29:19 -0800 (PST)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d95dsm4655526f8f.7.2026.03.06.06.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:29:18 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  liuhangbin@gmail.com,  matttbe@kernel.org
Subject: Re: [PATCH net-next 01/10] tools: ynl: move samples to tests
In-Reply-To: <20260306020901.524105-2-kuba@kernel.org>
Date: Fri, 06 Mar 2026 12:07:32 +0000
Message-ID: <m2eclxi2kb.fsf@gmail.com>
References: <20260306020901.524105-1-kuba@kernel.org>
	<20260306020901.524105-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 93F0B222B3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264819-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Jakub Kicinski <kuba@kernel.org> writes:

> The "samples" were always poor man's tests (used to manually
> confirm that C YNL works).
>
> Move all C sample programs from tools/net/ynl/samples/ to
> tools/net/ynl/tests/, "merge" the Makefiles. The subsequent
> changes will convert each sample into a proper KTAP selftests.
>
> Since these are now tests rather than samples - default to
> enabling asan. After all we're testing user space code here.
>
> Sort the gitignore while at it, the page-pool entry was a leftover
> so delete it.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

