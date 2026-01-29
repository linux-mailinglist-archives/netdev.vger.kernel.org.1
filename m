Return-Path: <netdev+bounces-254908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEufHk6/e2mnIAIAu9opvQ
	(envelope-from <netdev+bounces-254908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 21:13:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC69B42AF
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 21:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BB26300CC15
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AF8330B01;
	Thu, 29 Jan 2026 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="JHpizm0C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843FB1E4BE
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769717579; cv=none; b=dX0hjV8AXRQNj1QQkgUSWsxysfWO6bBK5LDSkrtIxAG3cFsNq6z7NNv9UohukC6qVRA9p///p7bmlVrk4/NvbMp6hnP/Y8FKZ5xPliiZ2juUag79earrWqMWY8CxLnP4vPL/6wIig9KgqSVeyUt6a/XEJ/ZdmnXUrMlRQr4v17c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769717579; c=relaxed/simple;
	bh=iWJxqh9v+b7ONeSHcsSKUAXb/55OwGTO4VzDIK6UzCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFfqdwrOViOwVD1cegcZund9BG2xQJhv7zMRSdVKZWrgMIcu017W7Nxh39mSFqSOOkzi9YUjnXACHAPnwknq9zlBNi5W7+lQi5Qk1rXXeYypJgq4lifwiu5ylE5s3ynwJkG9S8btBUROtMrtvROPZ+GfqAaGLau2rfjOrvQqpLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=JHpizm0C; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-82310b74496so919920b3a.3
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 12:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1769717578; x=1770322378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpFVsPfnfQQNTQ0jdwFqwKURwQ4mgZxUyhFY2LzG0D4=;
        b=JHpizm0CmdpGiLFtoxT1597fZ4Erw2oViB20mK+MtVpedHnMobrxslA26x3OOuReOi
         QELrIDksppgge9w9Kr+l0+pd2k5tLvilNe4Dbd29u2WxGl/Rj6LOuu+Tz82/DpBD2RQw
         g9qz97uj2y7VZkFU6D7ZODz6FTa/WNSZ840UcdbPyC83ZOikgxKkKvhsoEjWrTQD2+4H
         dNk3yTLF63OLTbKU+/ssYxzqleaJVlhBzhfTyP3ulQWiqhTE8r/+i3oJ0fP8puFkKUJ3
         ilEz1zHYu6RL5tg8qwWdzlCwcgnlvF5io5A+SwVBSzok7xyuuMNJhQ8S9X6wZHsB7SQx
         EpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769717578; x=1770322378;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpFVsPfnfQQNTQ0jdwFqwKURwQ4mgZxUyhFY2LzG0D4=;
        b=SkPWj70e/L4OMbtOxMT0nuj7YNpR4HfLluCsMDUHLivf4Q2aulK78aqhE5zF09F1oO
         B0wfrdrZRt/S0Y3J45T5IXpy3xaaOGFBCKvf61dMCWQPjhFNxmBdk78q0TqNsdupAXfH
         5opMDLOMF5WUFg+lT8SerO557ogdt4iWhH2pC1CvEhftLupdvrts4haw2Ou1j9SsZNWv
         l5qByRC3191ONZmNCCl3vFXQDIGMfVxxgbdZM+4mbM4ay4FSLqMNzOnuHv7XqzOOpMWR
         76uSUA4fXIwPk/7w/55a3iWsuVTTxjdc9W6SE46tMaDTiUzIhkxPZ9TxkZXQqgn/E+s9
         XIeg==
X-Forwarded-Encrypted: i=1; AJvYcCU3oZQEV7zbrg5enE9wWVeSDjhX6SiuHf/EnkVVV56j3W6JHdFejMNvZpkxNDgI9u11hp4x/FA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfu/a0KER7GDD1QCnzdtxiJLTVKsvQD4Zl2mFEegGTixLUM1nZ
	DdJ1AiafcTz+xNxVXwluouapRd4VOrSe9r/xlZIGKabORXpqrjgFz50OeBtfIyQR9jU=
X-Gm-Gg: AZuq6aLHCJ4W1s6EseN7p1Tzq07i+tqNfRXw2WAigo7FnSKH5ZOOwRQ6kJ2Ueoy6InH
	wiWjsYrYCKkpvwBAN0FW12fOTx+16LlPqtbnixM9r+yndjksVghDOvr6s4Kl80VxZwz2lzgj6eU
	msnFOQHa9CBO8B2IMRX9iye1Mejt6N3xYAOFzGYldi+ELUsqHBJjvupRLVujy1NdhKWBajg8D3b
	eTRhPcBPsli/cn7994hAPFULJEx38wSx6wzN5gjUXUXMmmDjubmjcTZlru8LPCl0SLHjKANSa2o
	eFlX94/MCAaUgEEHv6ifLBXfAlt6oNd4RJyHma618D2WzjyEbi1gddWhrJR5ZdDLco/KQVSW55L
	A4pNocArwmyTI9NVZq+zhcAXXRYscF2Nm0N4txdKQMHQaPLdf0UlvqQMANhR2kgJj1gM=
X-Received: by 2002:a05:6a21:a42:b0:366:14af:9bbd with SMTP id adf61e73a8af0-392e01a8f7cmr203112637.71.1769717577697;
        Thu, 29 Jan 2026 12:12:57 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642aaecd19sm5852908a12.29.2026.01.29.12.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 12:12:57 -0800 (PST)
Date: Thu, 29 Jan 2026 12:12:56 -0800
From: Joe Damato <joe@dama.to>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>, Zhou Shuai <zhoushuai28@huawei.com>,
	Wu Like <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>,
	Luo Yang <luoyang82@h-partners.com>
Subject: Re: [PATCH net-next v03 1/4] hinic3: Fix code Style(remove empty
 lines between error handling)
Message-ID: <aXu/SDa0Z+w0v5zv@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Fan Gong <gongfan1@huawei.com>,
	Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>, Zhou Shuai <zhoushuai28@huawei.com>,
	Wu Like <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>,
	Luo Yang <luoyang82@h-partners.com>
References: <cover.1769656467.git.zhuyikai1@h-partners.com>
 <ccff2ae7abe91bb3618ded9bb5ef2dc9cb243d22.1769656467.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccff2ae7abe91bb3618ded9bb5ef2dc9cb243d22.1769656467.git.zhuyikai1@h-partners.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254908-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: CFC69B42AF
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 12:01:08PM +0800, Fan Gong wrote:
> According to previous review comment, fix code style of removing empty

Hm, I'm wondering if maybe the subject or commit message could be reworded a
little bit?

Maybe something simpler like:

  Subject: [PATCH net-next v3 1/4] hinic3: Remove empty lines
  
  Make error handling paths more idiomatic by removing empty lines.
  
  Link: https://lore.kernel.org/netdev/20250902180937.4c8d9eb3@kernel.org/
  Co-developed-by: ...
  Signed-off-by: ...

Maybe Simon has a better suggestion.

