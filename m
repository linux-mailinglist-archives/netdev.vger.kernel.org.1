Return-Path: <netdev+bounces-289365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDBNK/szDGrdZAUAu9opvQ
	(envelope-from <netdev+bounces-289365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:57:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC4657BBA2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4D423139590
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA97478871;
	Tue, 19 May 2026 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq5iSO0y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FD9477E27
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183926; cv=none; b=Gp2XqlWMqB8pV2BWy+UDHxLpkSlfWrB/kzMrd+PuyhSq57ST8C0LvGBGXewPV0PPKDtThnpVVHa02Svf88kB3lZf+O2PyhJxlq4oqpgsD7UVxvjd/Xjq+vCxP1yZlhZx4FX8Y7TmfLjUM7WXcKQSU+xzc8Kv96KP864mXeRYYpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183926; c=relaxed/simple;
	bh=j68GLJAWsgTDjcn8Jjh0WM+87fcdzxnCvkpJ+dJt4t0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=a+5dBmKApWGUQ4jtO3Rwv+CPXJVgqaDa2MyX8leDGAS4hkDos3zzigTB+3OjuozxrBDaLVX3gOy/vF3i8miUVXlT+9cdHo5Sfvfg/FK25LpC67p6sbapPW03dOZZgOuf2+MsZEH7SZKNBUeXkzHoLS+17uG5Krkb1o1zPSONZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nq5iSO0y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso28045405e9.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779183923; x=1779788723; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j68GLJAWsgTDjcn8Jjh0WM+87fcdzxnCvkpJ+dJt4t0=;
        b=nq5iSO0yGjQfu8wS6Ukoh57FEaasHgsRM4JBKQol4IGgsLDdEGPyFPrJXVPKUuKkD3
         mvkCJQ6qJDaQlanRydqM/i1O3PjHl42JvX/6w+fm2OwOVDGGAEzIcNr0oky1Xz/COuIY
         N0IDZY1vOIn5rlm6se5CXmgYoFt/jv7djA4Ddghl7Q4FdLY4Vz++W4NauiA2Ltnz8/ch
         GngN4Ty+ernxWBIxOEDzoHtl4RYkRkrrOLebEnAvV7c4gW/pMsWCVqCLm/1p/D43RX5N
         RlQORVQCAHh8FZqclzF6h4cW2Znne5IzB+uSwnQGq4G8I3dbGnldI5lJwmWf34F6qtFu
         V6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183923; x=1779788723;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j68GLJAWsgTDjcn8Jjh0WM+87fcdzxnCvkpJ+dJt4t0=;
        b=VdVSSIjTH4xAovxUVspqtDx+KSm+KWB/B5Tr/+0czA/vocQE8zHS9fG68aw5ArjKlC
         N4oabRHjLU+YjWTNJtoeXmpt8Nnv01oTkgBgbg3pjI3CFiKzY7nb/m/dGezc6cxtBpXn
         cH8FXPs6CwOTTReTk4VqHakJh1sIOSh1u0OyJ4ZwySTHxm2NaS6nMXY862rgG18FdNIb
         nqNtC501SI03dp53xkngqLgW7mqPwiRrLAU1HTp4uuZYyPHU8yiZl+Aq0FACCm/2onub
         FTk+E0qTlnfe1/iOjvWlOsGoBatrYN67HaMhGw6OeL0FxDak7KrE5Ve2jnJuj9CBhJdJ
         ICtQ==
X-Gm-Message-State: AOJu0YxX8UiXgAU4FMepXlGl9Rz76YLI4lpZRMwmQDJ+KfpT+rSZg+gP
	/LeW7xNi8ZIBVsgUfOszAwUIbA4IHNUWKB9sEYOhKxBIESfA9DgkqMFb
X-Gm-Gg: Acq92OG4YU0CKUVbMC/nuDZtbyEbqaFnclUU/43nTGzqmQhtpCjp0cs9yzOvSnPC1Du
	+E6T6YM/UxnIrgmc2InvcxCeL9ap9IOkUrMij0PXkeAfVgAOCthwSNBef1mqIth8WdAZxCEptTp
	IUgt+Iaw9lmjtBhHnULMiNdhXKXJcHQ6mjTbDzeL/u5Z+xFU84TWcHVf06Tn+HT1Jc7oVQ3f4RI
	U7OnenA0Wz8jx2W+HH3PSRfPMiMGwZNvq5WriU+h7ON7Og5xPM14uvE1rLdIrZHil/yALlGgw8j
	fd4UVqL4ddeiYKZqoXCvpxMKoz2W+qA/Pnst4VbuIJvnqmBhIYKh6Y0YR/nCId/1WcNlLmN9JRy
	JqcVgUbMlWp2oeyK5tgEqeoTmdcJPyFry7NbxVU6QeWtZUcXwvrfOe/s1edQa0XZufWb5DCDF/R
	UyFzSNAMA+X//yV/tGUth9PwolXw==
X-Received: by 2002:a05:600c:871b:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-48fe6613ac0mr282123125e9.29.1779183922787;
        Tue, 19 May 2026 02:45:22 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4900c16c62dsm123421935e9.11.2026.05.19.02.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:45:22 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  davem@davemloft.net,  edumazet@google.com,
  kuba@kernel.org,  pabeni@redhat.com,  horms@kernel.org,
  aconole@redhat.com,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools: ynl: add unicast notification receive
 support
In-Reply-To: <20260518164029.439928-3-houminxi@gmail.com>
Date: Tue, 19 May 2026 10:44:25 +0100
Message-ID: <m2y0hfu41y.fsf@gmail.com>
References: <20260518164029.439928-1-houminxi@gmail.com>
	<20260518164029.439928-3-houminxi@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289365-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6DC4657BBA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Minxi Hou <houminxi@gmail.com> writes:

> Add ntf_listen() method to YnlFamily for binding the netlink
> socket without joining a multicast group. This enables receiving
> unicast notifications through the existing poll_ntf/check_ntf
> path.
>
> The OVS packet family sends MISS and ACTION upcalls via
> genlmsg_unicast() to a per-vport PID rather than through a
> multicast group. The existing ntf_subscribe() couples bind()
> with setsockopt(ADD_MEMBERSHIP), which does not fit the unicast
> case. ntf_listen() provides the bind-only alternative.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

