Return-Path: <netdev+bounces-280364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IECpAByW6GmENAIAu9opvQ
	(envelope-from <netdev+bounces-280364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 11:34:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEE04440D0
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 11:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2A3230038FA
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B832372B3C;
	Wed, 22 Apr 2026 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="Y28Zb+ci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DF32877DA
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850410; cv=pass; b=VoMnGYR05WOQp5itlvugzJKCt9seS+POFvDoG3OteOretVTGA2WGkj54tTlCcBFQ1Ixlr0QzML74QxZkPZjezDserftENVp+pngzfVAJipElCL1LVXYm0HB2ohBU18cpOT1EFFb4qWm0DWKtLf4KqPFJxMEofMM7b6uQk4+iguE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850410; c=relaxed/simple;
	bh=Tw2n9cXwT+6+jHxEkq2DsjVwY/8dX+aCnX6Kt4mfc8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aspfL+foo4giCXZisXY659InYIhWcbTYHa6q0VO1I47SKMaEz6TRTMdRm0WUnYlp+ki9teXY83JBHTzbjNPX7oxRK9egzX0rzVz82Z0GBlwzmq2rUMev9Swk/todTZijmlNy30RlSEzbHNlRUiGJdBIYzGvCmeS6vOw1Ko8cZp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=Y28Zb+ci; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c726f46baso6352418c88.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 02:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776850408; cv=none;
        d=google.com; s=arc-20240605;
        b=N/1J0zWbAr78Xgwad+2GHuBPzYb13Abrw3DIO4rP8UXjfeobU8sZTCEw/EdoLjuVv2
         fgWQvN9NH4lnQQdiCZlWsYp9VGHlXJZ6tvYRu31RqnDTlknFd+CN8Jv5p6Ir+RfE+aRa
         Ex2+TeWInL+a9k1Nogvc+vOOauU9iZAh2cCmJQP7bA+IH+jsWZ7rqq30k+8GWuVMXWi0
         YiR5LFMmzrOScUbWZLCSKr8bcZdpiRczqXKehaSytMlp3Jft3uCVv4VzhQatuZyYvny9
         gY4q8JDphe9u5zMp5thbb28pD9WG6Dmiv4SiDA9wNx5ublv0vuv4a+HGt+8W0KAOJxxj
         503A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Tw2n9cXwT+6+jHxEkq2DsjVwY/8dX+aCnX6Kt4mfc8s=;
        fh=kp+hH/o6VMfrA5QqyhLQHhRQWuQIEVHTt4gXEUdPRo0=;
        b=jg/FirwIrJTNFm92zlJTHqJGa0xZX/4hcQiVcLm+QkQpg2yLP1btS0ooSoqWftZrww
         hEZfAda8rOdFYo5eEATLfbeIKe5/1yUjt7fA8zy0bvREkzo7/TKhkS4qcxWr1Q6oyogn
         6qU7XuklcwaO3MQoJo9LqhOObEKhgj3THH89510t2KTaHLzSStxrWMV+mi0UE7dhiRyy
         H/MWn6j081vx/0fnp0stU6G5PRyT3xNpXPxGQbsWlWZSgLDxcyMlvkLdXY7l6TK/RnXQ
         L+4ucXh5jVLfgphS6v9WQHCZOFwHHNErbvd99+VJsfHD+LevFfRg0LPfWBvPmjL9ddOT
         Zw9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1776850408; x=1777455208; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tw2n9cXwT+6+jHxEkq2DsjVwY/8dX+aCnX6Kt4mfc8s=;
        b=Y28Zb+cifTkK+KPzvQDK/u08+a/ODY0e1VfztuE9BP/AjWU4JHLYwMe15Ljoe09Kgk
         SULQXv4TKyo5XRyxAeHtZ1FWboIlMSJDumU/QIEFBQhjOG7Al+MdYneNMdNpkvcA4smL
         99cNNjmfnw0SoAkam2NQPxAz0ClEBiGYM34CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776850408; x=1777455208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw2n9cXwT+6+jHxEkq2DsjVwY/8dX+aCnX6Kt4mfc8s=;
        b=F5NH74PttcTvzfUkj6raG0LW16rh7apLN8aCHNeUrU4NM7cWixorh/XCOczyaXVM1/
         jP7JAHaXeLxqxMY9gSTpKYwhb3MWR5qeXHDhoV1ZzAVaVUTH5zBHCqnrsO92nob5Xw1A
         YDPfZv9MPjv08i2zsK4U092ifbwARUx0Cv65KwZvKBflEnA04mCDxfeBpdcTfUp9Bgnj
         Ku5EoxDABr2OCr2FrHoCKmmi+fRRaDBAQaGlLGk4oPzGpG7QIzMihI4V/gJ58gWmYL8G
         bFKw//i15K19PIHKB2Z4aA7k3DeEZJrsrT4eR1H6MtDNIF0eYMEhIQS5qaAYVW1aImXo
         x9NA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ky1hMit7bAIjBhfxpxeh3CeTyLyCSH8C41NIAShnwh6JDqgN7ScUvddVDIoANtDbxQrH86C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWSx3VX2FzHKmR7QhQEAEAHWF5z9UENoVyCjNN9nRhsQJgzAU1
	6tiPa7hzp1hy1njyE+edigaUmIT3M3nWGo6ZXbvIKjuMelHHqNinJ+T1m8m0U6hfQcPgLMXPBeT
	uf0FgURnJLoGgm/llQigE92LxEEmySu56XxdKJ/ypwg==
X-Gm-Gg: AeBDietpSEt5T+WBvf3bLl7mMD8uzbZ9i3fa8mrzifT1o4/bCGJRia8dhpqxV26fPXr
	/Af8gRKevCRtWrVRHCvjUyf0OSYvcRsMiBTx5tI36uK4pSpQ8bI9gi+kJvp0wZjE2grXQcSzuAD
	F1einoPR7n/zCWnjU9drmB699Yct7OFLbwAScZo1IYn/SOarqn2OKv96jKeODdDBg+7f3PfnqG+
	I52dbNxRwbHJ/m9QhRtuJD6ziYAMGlF+uLQANbTpdNvbPlPryHrEfWWzYdkRZyS9D6VJ4VgDOvN
	Ek1L08bixETHc7aERA==
X-Received: by 2002:a05:7022:ef0d:b0:119:e56c:18b3 with SMTP id
 a92af1059eb24-12c73f9707amr11176241c88.27.1776850407568; Wed, 22 Apr 2026
 02:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
 <CAFr9PXn1ixyhD42OswoyGZ=W-O-oZygUGpRNm2dcAuYBNgtmQw@mail.gmail.com> <20260422101316.0efdcf24@pumpkin>
In-Reply-To: <20260422101316.0efdcf24@pumpkin>
From: Daniel Palmer <daniel@0x0f.com>
Date: Wed, 22 Apr 2026 18:33:15 +0900
X-Gm-Features: AQROBzC8UhBBuFYabzJQVE1x8d1ncMEmw7w3GOX43GOVwnAy_HhF7MUhgRjqthU
Message-ID: <CAFr9PXnuyb0jTAhRgJGRmdzUMxP-0HrHHHN3YpQnOn8-nBBC1g@mail.gmail.com>
Subject: Re: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet drivers
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[0x0f.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[0x0f.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-280364-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@0x0f.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[0x0f.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1FEE04440D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

On Wed, 22 Apr 2026 at 18:13, David Laight <david.laight.linux@gmail.com> wrote:

> Is marking them EXPERT or BROKEN enough?
> (Or a similar new option.)

I think EXPERT gives the wrong impression that they are difficult to
use and BROKEN makes it seem like they don't work.

NEEDSHOBBIES or LIVINGINTHEPAST ?

Seriously though, I think we should have something to mark stuff in
MAINTAINERS and elsewhere that is in the kernel but only because a few
people are having fun with it.

