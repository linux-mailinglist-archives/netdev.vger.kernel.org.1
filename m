Return-Path: <netdev+bounces-307051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rom5I1KXVGrynwMAu9opvQ
	(envelope-from <netdev+bounces-307051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:44:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DAD7484ED
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:44:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="bJ9bUS/M";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307051-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307051-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B65EA30041D3
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 07:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0D33911A2;
	Mon, 13 Jul 2026 07:43:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA138F230
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 07:43:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928636; cv=none; b=oQzP+VZ2Eu+C5rxcQ0D0+p9NDjc4S7B22aoai+zhxO+1q/T+AhLg22L3gJ07d6nbPKSfUrhT/6128mxZIfRh5aOLh3SAuOLIFjK9XIhrD7PF3Zt35KQTX80hYuOBTgpvHQhGu4vgRj7As/OyeY0j8U93KMIWk+OtDuUWEXb32sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928636; c=relaxed/simple;
	bh=AAaNItx7PoGwXieW+iUsmGp2F78HS5z6sxkgExs6Rdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSIVjiQfPY4rTXojG1BWk4q/UavAd4rzTFG5Si+m4OU22o8Rg0UgIeSPvG1iwcopXvQ+fTr4UVCpRJRNNCeN1QeHcQiXPdJW38NHNXKs2PNZ72NyaaaHidTnelgwafcU54WFhGx5LmNeDJ4iMge+eOzckYDeFHhmQAHTk+Netvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJ9bUS/M; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso463887a91.3
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 00:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783928634; x=1784533434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AmfefPSEnZ5TnAAkRvtRWNfNvlfXKltz+ZQkAhJgUSo=;
        b=bJ9bUS/MVHOnOXpOYACoPf/ZqVosmWjz9jg6N4jB/C8ZbGQTIHhDgp+CbGsj+rxJYL
         3dKsaLLXV458wHTYBNTsBYPBi6//Sqj8eAMJ+23bQcDypPjecmES6Pp+F791im4l+8HE
         NfCqvuYlUgBNIAg8SoDQb7WXOmXq5J7sQxlGJZ41WVLOEHzS4oEJJdoj4Z1AQ1jejTY8
         S4zCLTWvPveFaEMe0Vw8sbNzqzcArzKO1Y7XNppIJTuissas1C4yttBBTz/iE05FVA6B
         MLfVv/ocEyx8FS5UOKC0h1c/mx6WYXZOpYpseafzVOzMKqDF+z2+v7N+VC2llZYIwlN0
         OI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783928634; x=1784533434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AmfefPSEnZ5TnAAkRvtRWNfNvlfXKltz+ZQkAhJgUSo=;
        b=bdOxPKM59ifUQ9KLLGh0buJkRLRAeNsimgseWPGVzMADdsbNGWQYjkGVJ2HD898Hz9
         jTjkAGRY0/NS7L8rTm18l5nJkfZM81izEATXkUwT3kB5+IK6lpAvKjTHiD+GVmDYj7Y7
         rbrlBpHKOjbn5a9OjEsAKLFP2eU8ur1BEZutn6kFqtEr+Kimy7XKx1Uw/wVlHpReBhRd
         Q7yr+aN/DzuKD94X8s3VDXk9JLMW1Iyz0dsobvwSJtse+F+NXZ/bxyS9ZRjhHsxnUqud
         oQ5iyPrZigdkDcrS4SD8jmFxEj8GRpjc0A2MjgD9B6idvehKK7vGOaM3i5BUD93hzMTz
         lymA==
X-Gm-Message-State: AOJu0YzlJXGLxeiUJtG/EUiY+akHgx01TQc2CnWZVtdKso3QD1E86AcJ
	O+uAfw2SCB+ophIshrQzo5TAQXkP0yyE5XSze3/eMeQefIuTrxlFPGoJ
X-Gm-Gg: AfdE7cmvvOh3be3Bth4DM0n+zXubcqK5WNTDqdRwFZIAU2F+6/bmbvDYaFcMvO6zh4O
	PTnjSOgQ9KmIeZpih/xij1dmUyJuf6fiN4GMLLaI2LvzIsYfFlQyalD7mq28TF674b/c9MrDeM8
	zTDwbKK9S/XyvRbjtgv1hvOruOB9aCEAabpT2+ORQgphB19JEnW+jqkm0IM5KceFsFtM2QCOJG6
	38d4XpcZ5n/TAagaYiPV7JhDmk50v9e//OewvtZF6j+Jk2SYSslufEpAuzYgancbLdTWRPrinB5
	F2b1zM3KMnvmAe8YRGBQAihWPMZOnGJ8jucLTK6rAqBONX99afNozsK2FF+utSLJF1JqP9/G2+8
	PqPL0IEbKwn4/rbCmQhpF+hkBcyqAuakjxhxVz6FezpQ6ECcP1B0aP4zs9zU59wIMhLD8fiKPFF
	WguOLhqwRK42+gD32FMH5chu2u
X-Received: by 2002:a05:6a20:72a5:b0:398:6ea8:21d2 with SMTP id adf61e73a8af0-3c110a69208mr8562324637.19.1783928634554;
        Mon, 13 Jul 2026 00:43:54 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5afeb060bsm8007310a12.14.2026.07.13.00.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:43:54 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org,
	Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: Re: [PATCH net] tipc: clear sock->sk on the failed-insert path in tipc_sk_create()
Date: Mon, 13 Jul 2026 16:43:24 +0900
Message-ID: <20260713074324.3577116-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <GV1P189MB1988AF0F2722101E30D902E1C6FA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <GV1P189MB1988AF0F2722101E30D902E1C6FA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,davemloft.net,google.com,kernel.org,lists.sourceforge.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307051-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tung.quang.nguyen@est.tech,m:netdev@vger.kernel.org,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:4ncienth@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[4ncienth@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[4ncienth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29DAD7484ED

Hi Tung,

Thanks for reproducing and testing. Decoded with scripts/decode_stacktrace.sh
(line numbers are current mainline net/tipc/socket.c / net/core/sock.c /
net/socket.c):

BUG: KASAN: slab-use-after-free in lock_sock_nested (net/core/sock.c:3839)
Write of size 8 at addr ffff8880047cdc38 by task init/1
Call Trace:
 lock_sock_nested (include/linux/instrumented.h:112 net/core/sock.c:3839)
 tipc_release (include/net/sock.h:1713 net/tipc/socket.c:638)   // lock_sock(sk)
 __sock_release (net/socket.c:710)
 sock_close (net/socket.c:1501)
 __fput (fs/file_table.c:512)

Allocated by task 1:
 sk_alloc (net/core/sock.c:2308)
 tipc_sk_create (net/tipc/socket.c:487)   // sk = sk_alloc(...)
 tipc_accept (net/tipc/socket.c:2744)
 do_accept (net/socket.c:2034)

Freed by task 1:
 __sk_destruct (net/core/sock.c:2289 net/core/sock.c:2391)
 tipc_sk_create (net/tipc/socket.c:504)   // sk_free(sk) on the tipc_sk_insert() failure path
 tipc_accept (net/tipc/socket.c:2744)
 do_accept (net/socket.c:2034)

So the same sk is allocated at socket.c:487, freed at socket.c:504 (the
sk_free() right before the line this patch adds), and then written at
socket.c:638 (lock_sock()) from tipc_release() on the accept() fput cleanup.

Thanks,
Daehyeon

