Return-Path: <netdev+bounces-255681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id c+nQDAfSf2lLyAIAu9opvQ
	(envelope-from <netdev+bounces-255681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 23:21:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 775D4C75C1
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 23:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 456A83004C47
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 22:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D89E2EAB72;
	Sun,  1 Feb 2026 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TN/J/dWZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB027A465
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 22:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769984515; cv=none; b=YkcpynKdtk9DR3EF39ImpinM3B0maUdKOzrT/X3BjeW3inzakSRixByZPw0R5zPRiW5c0evdrvVnNGVcnOm8ZPaIDYtIFIr2wC3JRqzveWqkmYnjKI4F730kaP37ZUfoux78CgpKiqiGJtDuWjlKUFHe8HUrLhT+fxqTIthTXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769984515; c=relaxed/simple;
	bh=/50UstTYTe5qclwh6Uqp/GbNZAC9vdNY1YNsVLSBDY8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Zse/68hZFbV+SBN/+NdAq+69kjn4dPWQnfdol9+/Qa1seO5OxAFUxhQabf12zPw09W0QIkmVDxzjhKN9QjYpVOE4vXxG6YI/pJj1tqUAmz3DCE1VuUep1/oQXbeiawQnnUTmVCc01SMSV/EPnRJeMBFGF5GWdqLkGsF1vnEwGKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TN/J/dWZ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-793fdbb8d3aso34844327b3.3
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 14:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769984513; x=1770589313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92nSMhqZxV/o0GA4gQ9PG0AX7xo4zjcdqIMWnHaJQbk=;
        b=TN/J/dWZogGd2wynsNIgBoOhrA4c4Z4V6xciwiN2lHlR50UfiDcyUIktfbT+M36H3d
         evnal5zznseS1mhk8BFynONl+OjKLnPEO7/9UjI01+jC4sxJC+uOIOhCc8v5DxdGmQN+
         Jy6aig68SNPCb77+sX2gbnXNu0o+5I94QW8dfUvKDXFn4NbjPBtEoU/6tVPnuX5n+qAL
         alDTTUuct+3pJj6OCPk+gFIn93gMnwicvPJ6OZhlrsonYWms1OFAqY1CZiY6qlA6aaox
         gy0MBbUdZAlxvz3cHA/OVxbMrlN7BdNoP5OxiwXZeDIdGKSyaCctwCp3F+2OU5HGisgz
         JqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769984513; x=1770589313;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=92nSMhqZxV/o0GA4gQ9PG0AX7xo4zjcdqIMWnHaJQbk=;
        b=nTjzzvoENXZXiGqQPusndzyWa2xSCK5vPvyQQx5TPnzsT9TJTlLBph/B0URruOQ8p6
         p1dTXLczaWRtANUdB13IUueW++jtI5kq3+t9F1Tz29pmy9zT0WbUDhy1YYhtdaRZzXD5
         SaDdotawLTAe62DYfQYyyt4W8zIY/IM+IaXuDLkc9tqTIQqAh/82RWcP6M41jlENwjSk
         BM3ii1GuKwoTQ4jRXSTJRXsU/ADZsJjjgADZqgEgx2qYTZKFpgYY8gnO37k90yCQR4tP
         mqzNFplvqN8FADJUyW3u4omzCa5LR0C+muP29650M69qG0t16pSlQuC4f/yFaXYa3pOE
         x4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc56wcekGaNBRHYmfj1KMHkw8CWZj/wEgtdZ63Hf8MtAnPDz3XGStYcflaTET6HaDip9YvCl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj4avqkp9cv7beA0Qly1FaWFhSriYnN/MOX/N0lxxnq4lSQLsK
	qsSPfpNfr6LlBDnz83j1BEMNf9gLjlhoTUdI7E8/FyVYHgtTbV8Aip6l
X-Gm-Gg: AZuq6aLA8zPcI6xuVlHeU1IAYFtc6JBZJIHNez8VRGYo3Lq8fEaKLGQQXtPyWWzbSjB
	oylPzdPqT9UxT0HWMWTu8RY0IKD1bhkjBFKwELa2PPZSJtedLFV/0qGfTED7oe7cBLqJK5uKjiT
	hcUDYeh7wUGQhKDBj9wJZAakKuMgoRR7dYMw2g06BuU2YudT/oHniPtsDhSOrB99xazpXcYQVl2
	5H2d71mz9tWNAf3QBM+FK2EwuLmOodag64tdY8gMWzBL3vNm3rlo6rX2NBm+hJiTwsieREHTV+0
	nQTku1T14Gc3F7wkaaMaJH2qHw86OGDRHUrZ2KNrNy4AqgnSZeIVQ2h639YqBaJPd4TwyOAsRIs
	I27CC0rOzCJGZs/By0HBF5+uhZzwHW83bSiSHQnjwd8A+fjmIaRFFpI1kvymVRZb15IantHWVB5
	k4WtdYQEBxIA2zHhkB7muxHgOLU5dFkbLIvAgZrUosnoOVXQjS8vGVCa6Ko+qfa4iULWtzWg==
X-Received: by 2002:a05:690c:6a83:b0:794:8f0f:e8cd with SMTP id 00721157ae682-7949e077adfmr89832787b3.70.1769984513172;
        Sun, 01 Feb 2026 14:21:53 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794a89fc966sm38096557b3.1.2026.02.01.14.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 14:21:52 -0800 (PST)
Date: Sun, 01 Feb 2026 17:21:51 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Richard Gobert <richardbgobert@gmail.com>, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.38507b06f982e@gmail.com>
In-Reply-To: <5a0fd9f22844611b806d1cc8bdfbe1504bb33b47.1769771825.git.pabeni@redhat.com>
References: <cover.1769771825.git.pabeni@redhat.com>
 <5a0fd9f22844611b806d1cc8bdfbe1504bb33b47.1769771825.git.pabeni@redhat.com>
Subject: Re: [PATCH net 1/2] net: gro: fix outer network offset
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255681-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 775D4C75C1
X-Rspamd-Action: no action

Paolo Abeni wrote:
> The udp GRO complete stage assumes that all the packets inserted the RX
> have the `encapsulation` flag zeroed. Such assumption is not true, as a
> few H/W NICs can set such flag when H/W offloading the checksum for
> an UDP encapsulated traffic, the tun driver can inject GSO packets with
> UDP encapsulation and the problematic layout can also be created via
> a veth based setup.
> 
> Due to the above, in the problematic scenarios, udp4_gro_complete() uses
> the wrong network offset (inner instead of outer) to compute the outer
> UDP header pseudo checksum, leading to csum validation errors later on
> in packet processing.
> 
> Address the issue always clearing the encapsulation flag at GRO completion
> time. Such flag will be set again as needed for encapsulated packets by
> udp_gro_complete().
> 
> Fixes: 5ef31ea5d053 ("net: gro: fix udp bad offset in socket lookup by adding {inner_}network_offset to napi_gro_cb")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com> 

