Return-Path: <netdev+bounces-275975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL7zCU7x1GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:58:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C47F43AE064
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B6F230094FC
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC313B2FD4;
	Tue,  7 Apr 2026 11:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="YXyuaM2O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C358B3B2FC6
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563014; cv=none; b=gcScfFlIgBGBjQ2yYOTUQzcEPe2C3xh/bVKfHDIWqUOI0rwOA6oZ1i7zdZnjGclW/cFCSGPvlJmcI7wuRCr4kVU9njMltgCWWkXUZVXgHGERz2mXVaV2TDwnhI4/xsxwXbDJN2jajcKL4lO0FdRJEtsFVBPo3iWZhJ7BfJYpmXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563014; c=relaxed/simple;
	bh=iqBKwfsQkpmtRHhzWuSvuaMtQEA1MgoMG6ussjGlWQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdIFJHSyYxwd64ZU+r0CapNP/XVm+Wn5QaHSKKBKjxl3GTYRjYS0IIa+t0feTtLLn1GqdktpCxjPu3v7q9TzDN4Ha3Um15Lc/gGBVrR1A9L3P7RBc8LeTcdbmFv8P/BtgzwmiW1X7MuPefRE7LD0R9FDg9pgqt1/6TKqgzqjLoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=YXyuaM2O; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so4482537f8f.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 04:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775563011; x=1776167811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iqBKwfsQkpmtRHhzWuSvuaMtQEA1MgoMG6ussjGlWQE=;
        b=YXyuaM2ObTwNlKlEapXW69IAYiy8qRv2K/sBR9ckHw7HGlVaJyr+enmNU6fq1mzAwE
         DrRJNhq76LVJq6i5nUz2kiSrO7pewapICyjBZIn8uD4gdLLNts9thXMzhJSJxIO3Xhhp
         9QkqsSqCjvCFYgS6xkASyD3FqIfzWx+AuZo3l2srzaukdXQZmEViApgqyuHqptyDK3gW
         6zvqgxxlox5nTrIqY7mIO0Y6uI2j7UXo1jrzmcZdVwDzGXnj77D46EEQY7V9rB+O5Vas
         pUSfKIv2tv5RQT6ZlzP4E9flQKk4vgLroDWyBALvjA8lUG2ymaBf/k+EdGXvUjVi8iWC
         6W1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775563011; x=1776167811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqBKwfsQkpmtRHhzWuSvuaMtQEA1MgoMG6ussjGlWQE=;
        b=kzkw6s50RqBx2zGH5yfDj2WOKa6XrQVu6RtlsovFxz/SPMdzvi6CfiFDjFPGWsa0ye
         NDuE9TDo9JMRumaKXcdSOHLrPPDDyW5vrDbmB+/1pmoUINk+pfGP/qi5KARSEtxOXs/c
         7PwZL3DLlsTQE1pGeQNz/L/bDNYBWpCpn/Pqec6DGYme8REFMfwNUqR+TycC6gT7vwCj
         m06+6t7ptp+6x1DtQLjRMOg+o08daYb7SytYkRyqPdeIRhkKCQXIJLjE6wBER7nqfIqW
         TUvtly92KzZrkrW2an4kSUP9559zFLNUtq33qLeLxSArV3n4fLi+zpV1Fm5pMZ8FSriQ
         4Oqg==
X-Forwarded-Encrypted: i=1; AJvYcCXv/YLyatrvyV48U9VFSpHo0rusXtp2h4+Y7qRLZftxjPzW6wKIS1Ca1Vu6e6gSK/nW98JaXcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBB1gcqDE0p+0UZ4roaXgklcT9BKyrKwZ13cqTfYQfWzno7PZ6
	neLYVVHFkOXkVdfz/YZAG+qLD5rGzShM2beWn72plwfzRY8JtSolgPFrcw5T9VUB1n4=
X-Gm-Gg: AeBDieuVkz5JKhPxhQR0imSsvy7FBF/TpSwpr1mpMAhwxKq69EverbyyO5F+BsTqe9D
	uH68lOh7D2DLsyc/F5pyVj+JcvwrtIL3dr4DyvYynFveZ48GrSnwbKDW1Q4BmI6Oa9FuQ4iKVGy
	YkNl7q4OucPwjKu6y4vHM8ob1xt9weJzv9M07YvxyIEajS2YvTIjqbe3qDyBm95Qy9lmY/rD9qE
	yESRvVWPrjNc8e3xDdcCmvBFOkR8YQTOhAlyE2Mp+aV/sgW1IIBUCKPCkCg6FOqzIAljLsY0zfq
	QOdb4ALHYZM/8/N1eVTIH5Er1MqR+qBKEbAuKkln5kv+Z5RtS5NVTEaIhOA7Vyi4cXl5uSQu3ll
	QtU2TMOsfyDFi0WMcoFJLGvrPosB4CAeqyVANsJvRU/0nrylnUyyAhkK4Dug0KBKsfr57ifRT1W
	D5qd7KR5SXYfqvR3qxKRLE1mfGVxA2ty8=
X-Received: by 2002:a05:6000:24c9:b0:43d:1bf6:30f3 with SMTP id ffacd0b85a97d-43d2927f808mr24406945f8f.14.1775563011189;
        Tue, 07 Apr 2026 04:56:51 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5253sm44188663f8f.9.2026.04.07.04.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:56:50 -0700 (PDT)
Date: Tue, 7 Apr 2026 13:56:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marc Harvey <marcharvey@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 07/10] net: team: Track rx enablement
 separately from tx enablement
Message-ID: <x2plbbbe2raatqq2mthltnc4spbmrhcoge4mwpvj7kyslarr22@rpm36la4h4ds>
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
 <20260406-teaming-driver-internal-v5-7-e8a3f348a1c5@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406-teaming-driver-internal-v5-7-e8a3f348a1c5@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	TAGGED_FROM(0.00)[bounces-275975-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C47F43AE064
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, Apr 06, 2026 at 05:03:43AM +0200, marcharvey@google.com wrote:
>Separate the rx and tx enablement/disablement into different
>functions so that it is easier to interact with them independently
>later.
>
>Although this patch changes receive and transmit paths, the actual
>behavior of the teaming driver should remain unchanged, since there
>is no option introduced yet to change rx or tx enablement
>independently. Those options will be added in follow-up patches.
>
>Signed-off-by: Marc Harvey <marcharvey@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

