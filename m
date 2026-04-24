Return-Path: <netdev+bounces-281059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6VGGLGrT62mQRwAAu9opvQ
	(envelope-from <netdev+bounces-281059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 22:32:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 243BE463343
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 22:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77FEC301939E
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 20:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B8B284881;
	Fri, 24 Apr 2026 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfuBunUC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953AD1F1932
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777062757; cv=none; b=LXtJHi3EYtGQyfwKA60/1lSiX6S1GoFRlhONKJ0ETHlqdEncRlGz10XmSTDg/XAawgJogM2fhzPvsGKZo0jyEpSFK5e2XxIDYQHvSAaiI0bk+fq+YX/cEq69MK9KnBq/8ZrhTpDKbqRCu5GVmk+WVMC93qvK3UTu9Lo7fjfsW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777062757; c=relaxed/simple;
	bh=FU6p+3POBVRSERpP8ZtkiWJilhhPLhJzicOB/M0qIzM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PHuQaTqFXxNkUS+dK2MpLCaylz5PA/j1Kf0dis/OlTky0Pvl4ae/4gg4TedrkJ20hybM450jNg0wCp/t5d9G7M9AXbXwLAEuZFBIxpPBWfrSFD4IuqOt1IzmLlN/Iu02YyYZououSjXVVyY76qNqUJgQcS1ZOJ+sOcTdstv/ILs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfuBunUC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891cd41959so63866995e9.3
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 13:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777062755; x=1777667555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfJjmhDHLMekoHwDHXYTkJMasD4cWdKh/MUO+Y7u60o=;
        b=OfuBunUCmyihcWA0Lmn8GCMd9+HX5t6nkI9wRto7i49QQWDtdHhtxnQHL0U4wN+yYh
         dmVJvPQJO2wzcILEE5Lg+Xgj1CWvIeCxq1pEPEr0yL8LjwiHiocN5ESVq/boWHXtkLuM
         zG33S0pm8hj4gRUMymlu1hAecN/z3uiFVQg9j/RohGUIUMAdfdKalVYcfZ2yXdMV+gWU
         qb0IpFh0RbFAuXLtrREg5J6bvmFe99bYl1lj0Zh7QYF0rkkzvy+QHS8cq3NwcFdZubXo
         lyYUHyshTU8YNJUAqs8TXPe40xPcIEz8C9nbeSlyi5hxNmLu0m5zvyomO9kgR/akQ7ul
         kLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777062755; x=1777667555;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfJjmhDHLMekoHwDHXYTkJMasD4cWdKh/MUO+Y7u60o=;
        b=tHzK3dF7h9RgOkgTDYwfYr3kLa3uD1B3dRi/aY8Yo2Aug6emITdy+yUcVqSq033aQB
         L8UXVuTqAE6dXrFMvIvn2dUi23z9xi6HuL2qBN12xC3vxXrPIyPds4b6NeQlLLIKhB71
         6KxL3petJ4LgnWtky0pmmeS9EFPxcZE3JnRTVYJbb1gMQ87JV1q7vnr+/uzwnW+YxA++
         V1sReE0hes335SnkuwJhLg4gKT7A+easyD6JAAfb1GWRqbzMKcCA7/bzfAnV8VHFAkh/
         DpaIXuUB8202rdZuyBVSFVr/lAnXlFelMla7PGj4lmwXhWWaS8n0vr0MExRopGis1ErY
         PaQQ==
X-Gm-Message-State: AOJu0YytrD+TYljAVXhxWscTVmTibfP8uxC9no0Ql77cfHkwSUdRxVu0
	oA76VsHlEpQ8V1IIH1RFcFTYSHpWm8wqGkfeBlz050f5sC2Z0mETR923SBymsw==
X-Gm-Gg: AeBDies+8LmzdGGdN913v7++dwJpMAZO9nyDr+Tl719ALhVOo8Ok7EADUu8UjXmwLVn
	ag11wMzkHWtVqhHO0SfuyTbpptbIykCwmQga9ErB2g0xGqkz1fWHN9WqJuGao+MbCXHHqK/F0F4
	wgNM/TrSmeNrH3nSq7snpcDaNcEKvOUrnEntGA0YLW6+NhfIrRE621C31SQ81S6VueuyYOz8F+p
	461kO67Ga1LaK9M0ubpjNpAMgdkAV/TL8NdMpxYvtxaLUXZ8xAc1kCSWOnTGvMuTJH980L6MEg1
	1h16tYuz4oFlV3BP6I/p4gaxXJ6MXdolbuRT3UB4MDc54iEzN1QZDbV6bfqWtSBf4A/dWmgKqtj
	Y23JEglEXKexSBOHEZPzBrrVZbI6ysAzHhLsN8dls08W/jYCAlJUnNQYR7TSnEmQm7q3k5tJT/T
	6HN15EDv+xuVFLadGcBGvu6Fbt
X-Received: by 2002:a05:600c:8115:b0:488:8577:d9cc with SMTP id 5b1f17b1804b1-488fb77faacmr421763485e9.20.1777062754784;
        Fri, 24 Apr 2026 13:32:34 -0700 (PDT)
Received: from nz.home ([2a00:23c8:a613:101:6a07:6835:efe8:e43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891ffd2030sm114009535e9.20.2026.04.24.13.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 13:32:34 -0700 (PDT)
Date: Fri, 24 Apr 2026 21:32:33 +0100
From: Sergei Trofimovich <slyich@gmail.com>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org
Subject: Re: [ANNOUNCE] iproute2 7.0 release
Message-ID: <20260424213233.4dabf6bf@nz.home>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 243BE463343
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281059-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slyich@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nz.home:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

> Download:
>    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-7.0.0.tar.gz

This URL is 404. Looking at https://www.kernel.org/pub/linux/utils/net/iproute2/
it looks like tarballs slightly changed their naming and now prepend `v`:

iproute2-6.19.0.tar.gz                             18-Feb-2026 15:36      1M
iproute2-6.19.0.tar.sign                           18-Feb-2026 15:36     566
iproute2-6.19.0.tar.xz                             18-Feb-2026 15:36    936K
...
iproute2-v7.0.0.tar.gz                             13-Apr-2026 19:31      1M
iproute2-v7.0.0.tar.sign                           13-Apr-2026 19:31     566
iproute2-v7.0.0.tar.xz                             13-Apr-2026 19:31    940K

Should `v` be there? Worth removing at least for next releases?

-- 

  Sergei

