Return-Path: <netdev+bounces-271480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCShAnSxw2kktgQAu9opvQ
	(envelope-from <netdev+bounces-271480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:57:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FB1322835
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D85030D3E4A
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4739C3A1D0A;
	Wed, 25 Mar 2026 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Rj1cw4ep"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107363A3821
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774432536; cv=none; b=e/iYJXYRh3h9z8+Dy+NR6m7iqniSxbhg/n52Hl6DqNdiC5KcP0Zq30rSlh/wATjB1kxLyBBaAtyX8g9N9hp98D8/W7l2Y1X++Y/Mcpwd3U5kMp56vOiQY0Li0cwH5iwgoxd6Kb6o/SrDNmzv+Gb4KvbBfkU96VgI7BNJIXwYkPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774432536; c=relaxed/simple;
	bh=RA879Mc5eqYpxzupCKFgZr+t7ltYM0CQqsupGWffDfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btPRWtEXvZ0KTC4bzG+WrdruNyjozVrxzUSwghwKkexvUFUZyv5Ja7ujRUcUKdk30cAjGYr9yD6NQGQnI5wJHLbM02S+e/6eePyDPpQyPCw1YpxNSHl8q/M5XFp0zLqt9YNMiNRxch9Xv3DX/x01pD4SkaIFN5Suua3mvzsAw6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Rj1cw4ep; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso54516095e9.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 02:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774432531; x=1775037331; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e8y33SBUR5HKYweEJRlG29C7iVpw2TmVK7LIC6oiZqk=;
        b=Rj1cw4epaCLj/1DQDi5MS2WMvqXpfDSD3BBM1kQdtcxXvOfex/QinRpoFApzLMBl3p
         76E6lG688KhOGfLkloqeS7/J/ddk7u2v7B0yAFanTx2MKl2Cic1fNYzbMRnFhQ1PzhXW
         wUtx+D05z2weWtDfWj1NC1g4Ns8gzQR/5P3Xwd500fjBe4OTc/sRPmtDFOWQejyI627o
         ORO4gBL6bRqaYUwx7ykR6gEcRQPjzBt7qG5fxhozTHY2wsuXNCUyeyjzxHaayULBx03/
         aZbXV08pFW+3ORNYvpVoqJQ4cg/9noFZEpVeFtFPB9fOkX1q6mc4klSu0C/0LwhJkzjn
         RdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774432531; x=1775037331;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8y33SBUR5HKYweEJRlG29C7iVpw2TmVK7LIC6oiZqk=;
        b=RymytVAYC0+HXyBTJWqvP+g79vMJsFTeYQoTOAwIFFDKDSIxYww7KV5dQmh7P/yzV2
         dK1yKjw1dlKIhgVoET2yAY8ge0V9swkZ7Zw0QpUTiteY3mhVdYXwWRhcemXhZj34sI9Q
         k93k2cqKz25pXI1+GE5lKNaKTvhr3dlNVgxUNDmr5WuVitbxo8OwGnVWHdBS6XMwIGTc
         40JMJD4bfNoCxP0TC8M/RHxr4tsrwUwNnvZ8gWSWE870c9RtQNRKy2BN05BhUxAVBvPp
         1R35KEkzR95K5iGV/rdVaqa8V8TSJ0Ks5OU/YqH5yP90ySIRHUj8ErLX68fFvlKmOzTc
         Juqw==
X-Gm-Message-State: AOJu0Yw/0+1I0PIYuV2hrqAgMfgU3WM4qQrrLNAWk8WOzaehazTGeb3I
	5JF4eLsTxaFiKnEx15140XhAjYGxi4bx4SwDUXCbOqiGzhSEq21A7L1vmUv9ms0Gbgw=
X-Gm-Gg: ATEYQzw9rbO9q8FqzXb21H7oHU6lW3nkZqiPOfE/EFwG7WLUX3D2Noy2lPboXKEKEZH
	FXrSFl24AF/nUQl/zg91b7W7k8w33E6lCZTrY8NuuErPZ4S4GqnQFVPigACTkuDEiyS+T9HOZhq
	6olEy/c3QF4+xLSiCxn2BQzv/kcXNsEaRCJYeX1D/wOGFI+o74jHqnQSg3SsKuWZtsK9l2fsFiP
	m+tiMBk1jAM/C0qB9itowIMYxjqp12DEwXnDbXh6T4RaXlmtKx/cybwis720yU8XKwvW93JyT5T
	KdFcR+Qcf2H8eaiIcdgDIQz8QZY7S6rwC/9Ls4RiU1mF4gxfH30MYs6mwpzJokc1RS3XtysSmAh
	q4SAvRO7ZpHPUWUUYKMPyigu7DYXzRx4kqyZt9IjoYxiG2ci0MeWSiTC1KKaspOcxJAMNqEqt9w
	OZAT0A3vyAse+jepBp2NM7mEnKN51FNgUqrv8=
X-Received: by 2002:a05:600c:8b88:b0:485:3fd1:9936 with SMTP id 5b1f17b1804b1-48715fbf82amr42957115e9.5.1774432531140;
        Wed, 25 Mar 2026 02:55:31 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116ee57esm111687295e9.14.2026.03.25.02.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:55:30 -0700 (PDT)
Date: Wed, 25 Mar 2026 10:55:27 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, poros@redhat.com, richardcochran@gmail.com, 
	andrew+netdev@lunn.ch, przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, 
	Prathosh.Satish@microchip.com, ivecera@redhat.com, arkadiusz.kubalewski@intel.com, 
	vadim.fedorenko@linux.dev, donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v3 net-next 3/8] dpll: extend pin notifier and netlink
 events with notification source ID
Message-ID: <ncudf3km2qvvbbx6rb4agurqfrvsu2u2cmidhvtwgvfvxxkfew@xicgdybftgqb>
References: <20260323222133.1796997-1-grzegorz.nitka@intel.com>
 <20260323222133.1796997-4-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323222133.1796997-4-grzegorz.nitka@intel.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271480-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,linux.dev,kernel.org,davemloft.net,google.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 72FB1322835
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, Mar 23, 2026 at 11:21:28PM +0100, grzegorz.nitka@intel.com wrote:
>Extend the DPLL pin notification API to include a source identifier
>indicating where the notification originates. This allows notifier
>consumers and netlink listeners to distinguish between notifications
>coming from an associated DPLL instance, a parent pin, or the pin
>itself.
>
>A new field, src_id, is added to struct dpll_pin_notifier_info and is
>passed through all pin-related notification paths. Callers of
>dpll_pin_notify() are updated to provide a meaningful source identifier
>based on their context:
>  - pin registration/unregistration use the DPLL's clock_id,
>  - pin-on-pin operations use the parent pin's clock_id,
>  - pin changes use the pin's own clock_id.
>
>This enables richer event routing and more accurate state handling in
>user space and in-kernel consumers.
>
>The current DPLL pin notification infrastructure does not provide any
>way to identify where a pin-related notification originates. Both the
>in-kernel notifier chain and the netlink notification path only carry
>information about the pin itself, not about the component that triggered
>the event.
>
>This becomes problematic on platforms where multiple DPLL devices or
>drivers share the same physical pin via firmware description (fwnode).
>In such setups pin creation, deletion, or state changes can be triggered
>from several independent contexts:
>
>  - from the DPLL device that owns the pin,
>  - from another DPLL device that re-registers or rebinds the same
>    fwnode-described pin,
>  - or from a pin-on-pin relationship (parent pin registering child
>    pins).
>
>Without a source identifier all these notifications look identical to
>listeners. Drivers cannot reliably determine whether a received event
>is a result of their own registration/unregistration actions or
>originated from a different DPLL instance. This leads to several types
>of problems:
>
>  * risk of duplicate pin registration when a driver reacts to its own
>    event,
>  * difficulty suppressing notifications that are merely internal
>    bookkeeping side effects,
>  * inability to implement correct pin‑multiplexing or cross‑device
>    synchronization logic when pins are shared across fwnode domains.
>
>To address this, extend `struct dpll_pin_notifier_info` with a new
>`src_id` field that identifies the originator of the event. The DPLL
>core sets this field for all pin notifications:
>
>  - pin registration/unregistration: the source is the clock_id of the
>    DPLL initiating the operation,
>  - pin-on-pin relationships: the source is the parent pin's clock_id,
>  - pin property/state updates: the source is the pin's own clock_id.
>
>Netlink notifications now also carry this additional field.
>
>With this information notifier consumers can differentiate true external
>events from internal ones and ignore the latter when appropriate.
>As shown later in this series, ICE/E825 devices rely on this to avoid
>reacting to the events that their own registration logic triggers
>when a shared-fwnode pin appears.
>
>This change only extends the notification metadata and does not alter
>existing semantics for drivers that do not use the new field.
>

I wonder, did you miss my comment to v2?

