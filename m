Return-Path: <netdev+bounces-256823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFnvHM+wg2l1swMAu9opvQ
	(envelope-from <netdev+bounces-256823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 21:49:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB764EC96B
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 21:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15C8C300D95D
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 20:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F7F43C060;
	Wed,  4 Feb 2026 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by8izE9u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F63543901C
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770238151; cv=none; b=XkCA+2MFX6jvDvwFq6FSRCx+qcp3ATLLQ8LGFJNvSLVG1mx+VkEPzsnIomj9toGypzvTbOOUCyzBqGS0OnbMGk/horCCIPpmxtjAMF58rIAaYTAKYw4DrpgJwfFb3i+d9PoZsahdorl/0IS03uRZXXlFSCul/ym5D49DsftzO7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770238151; c=relaxed/simple;
	bh=0ZX0GEhN5MaPV9X0VVXvM267Z/Tt6KLu0h+wGGL8Lhw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EVtmzlQsJz7oPjkN79S20+hOqGXMBS+8ulQIZtgFjijdGaSDvtYllWg9XMggg5vMyDm8s78RxV/zz8B779LZjfA4GxFxdgGtZTbmymvd7FTQcM9xlkObDBTEIK+W7MOTvYidZS7Re5L5sVHtPT2PgE6VuAkimJG54kiDfIbvm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=by8izE9u; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-794f701a3e6so2067197b3.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 12:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770238150; x=1770842950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zh/nDkVXfVHqHixPII5STDSbu+qVTIIasWwzxlzmC4=;
        b=by8izE9u1ebfZK8r9oLn4HtGvw+Y8q+y8/jungs5/qc9uGUZ9PQdBNCqVxRj632sEX
         hVGZXvmbM9QXN83/WPwf0hxjPDJW2zndgBeLLKKQmdECGoFJOVyEHXBoJygs07BEmSWZ
         MpCRb+PpO3kQKJqrobRywP0rZuZG+x61PdNNVs4LOq5VVTDXRVF5pWhIOjZ+etzAP1yz
         Qp8zanGMa4UVIDDo+HtRtrK74ziWNgqdv/zy2pRs22HdlCbODlHrvopvzdedk5tBtACL
         bbLn+ks6PhhusP8zShBQwCaxv4swHYiyFj3iI+ntpehM9C2+XjwT9qPIkVjCvGvO2DP2
         buew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770238150; x=1770842950;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2zh/nDkVXfVHqHixPII5STDSbu+qVTIIasWwzxlzmC4=;
        b=gTEwd/dItXUC9nx7e3yNR9HRuEZxzPozuBJciK9x/f1wfadRFDjkrNWfWqozwMXG2A
         Or2i+FqTx1D2ZwXgfNx8EgCozUDHtXxfXW79l6jWA7T42AjkdJfs7o7Bgclz9/87eBaT
         2fHHFfQvOgvtQOjmzv0ZXpRj0FQqatS7xWryt31d+m4BEMwozsI4pOik5L498SY3aqra
         Su4/pnd+xUffDbhB4+yEJAF1jUD6UYfUk3QcCe8WhOw/+G0g2NEElO1SHjxI0zhab1QJ
         pKFnsY4mvRFqBGDDZQG6AlARGgTUu2I/odXTrnNArrqv1v50K9nvSDEwyY0hHGEW63lc
         4wIQ==
X-Gm-Message-State: AOJu0YzFQM/BcBZWdE6c4oHEtqBeluTrQwTdyBk3zOmlnogdCfNKq7OZ
	th6brWCUvszYk6samt3ZPI8FYJxVQQL9CeRhgsQMkpTmMZ+Jj40lG5X/
X-Gm-Gg: AZuq6aL01aRRIkN/gw4pp0V8gtJv6+U/Y+4AFkAke3Txbd8OYjyqM6nfhDp3RGAIr5q
	CZZ5KBYEyVk7QZQkEmdW1R3RWSaqZc6Wx4e5KbosadBj8sLJh577h3bTYvOAjn1NhsQReqzDrdn
	cGjTyOY44FqIZWCs3FfjswRqQCpbWtdk+vz70Wq8068aV6yqWyg6ug5GLqn4tu0pi71pPGLrmlO
	xnzh1gee0qTQVfvITOkX9786dDSD6f56wh2+B4GnMv+nYtxTRIrtkqdx8ABrX/oqyEwOg4tPZoJ
	LlerD6QmPhvfq3XCv2LlLNQyPwJ6bBJSLZGLSgj1QZb3g6YkvCcbRAbbWeQq/MIJefMdzJ5Udix
	zVv0bJjHGTmI22QiRRgdPKR85wIiCBYl5LVzHfV/nzJoIfIFfErm4Y+irfv3y2F2YM23Cld0Av2
	sfvk7+JE8kCmq6AOnQaYd2K6Ya0eY//Enl63lTMGJX7cOnJVwMXtslVJ6dXOIbp/G9+K07DA==
X-Received: by 2002:a05:690c:9691:b0:794:e463:d080 with SMTP id 00721157ae682-794fe8782bfmr39196417b3.69.1770238149991;
        Wed, 04 Feb 2026 12:49:09 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794fee82932sm31167667b3.7.2026.02.04.12.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 12:49:09 -0800 (PST)
Date: Wed, 04 Feb 2026 15:49:08 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
Message-ID: <willemdebruijn.kernel.36883640361a4@gmail.com>
In-Reply-To: <20260204-psp-v1-8-5f034e2dfa36@gmail.com>
References: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
 <20260204-psp-v1-8-5f034e2dfa36@gmail.com>
Subject: Re: [PATCH net-next 8/9] selftests: drv-net: psp: lift psp connection
 setup out of _data_basic_send() testcase
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256823-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB764EC96B
X-Rspamd-Action: no action

Daniel Zahka wrote:
> This is a pure refactor, so that the key exchange sequence can be used
> in other test cases that start with a key exchange, but might choose
> to perform different tx/rx patterns afterwards.
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

