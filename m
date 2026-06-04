Return-Path: <netdev+bounces-295130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AwTzJwpDIWqqCAEAu9opvQ
	(envelope-from <netdev+bounces-295130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:19:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 957C363E757
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:19:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Z4Qk/eMs";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295130-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295130-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8456830BE894
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 09:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3143E7145;
	Thu,  4 Jun 2026 09:06:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6886E3FB7D4
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 09:06:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563974; cv=none; b=XxaV8kZ34pnq3K0skqDw/U1MQFXohV9V2ABdncztRV0hgRFWA0GZY05IOsN+zgzjtSIN9/HgPAnb0Ryz7ZYgA97HmzjG5nX82JGBFcoOs6KAjPzb9QzXmUmFZig2Y0mLE0mnCZCRHtpQKikrb8mQMohCF5NcfwvP06EhRSXW+D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563974; c=relaxed/simple;
	bh=6nC4qMmpp4fUyVsAFDYujq7+sxNujf5CGEPAWJHIlFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKEniNDDVFmEv4xpjSUt2r7Z3MwPXdFpcPbXmg935mGsTjApdJcKqYt3/0nuyG3SK5VuOq5DQO8AXCpnwQOm+o2kpUJSIJjKeMvKI6EYI5DsGd/oIoFp/Oppp29yMIVUTQdn35pwho1Mw9+J1P22Oa5U8ty0+HfT27CASrM3+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4Qk/eMs; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so3759165e9.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 02:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780563972; x=1781168772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdFuwsES54dFvGT6zPCTaZ+yF4K8AlHGY+rBuqBIdh4=;
        b=Z4Qk/eMsRQn5NaOl5EnL49h5mkIDXCd6CVB06Y3pkNHIQBrrOz07RC4i9WNJ7soZ5V
         ZwZnlbdEhstvH16TCDK3NLc3IDK022X024ITEBaBP7leRrZPYvIKM0a2oZgI8eLPi4hf
         l6bUS8EAAbKpENkoLhJlvpJaE3SPEuYNQtAyuGwu5GFaav3z27CJASM9RViLgvZnE9iX
         HnaGV4X3VncpchGb6vO7ALPLhi36EY0JNacWYHGwLG7HcXBXRzq/C0S0jLJRDSq+IYgB
         Ameqbmz9JWPN6B5sTwrZ27N7L7FPN5xbYHLpuQPyHE4EtAIwP41vpiRcH1y53BQ25zuc
         Uo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780563972; x=1781168772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EdFuwsES54dFvGT6zPCTaZ+yF4K8AlHGY+rBuqBIdh4=;
        b=Sfu0iqsDc1005FeJAF9Mj9ksAC9nqePdTtmIRQztwebEKX69yPx+/V+RedzyS6mT2E
         MqbcCamhAH8zkMgG9HEdrbd87uDJ/cHkuAS7WlNGdwTs+euxGgSRnNcGdyt0x+oh4rfY
         FjJH0yAK21UWt4U8KmTABwkeKpeFcq8L4plLVYPujffuKC4nxvO82G7Sxj+DNypRkftq
         F+hPPsKInMWgv81VZFSPDfulUCJdl7xXodjUecAbOQDb+jRjSBGF3qp+AGzUKCtLaWNM
         uu1b/vj1QGG9ePe+9/E3YskCHQnGicCPbjmYPvgU3dCC8N9/ZVO5ILD6T4+3sVkVceqX
         ezhg==
X-Forwarded-Encrypted: i=1; AFNElJ9nOA67TKWYTsIZ76f3KBELwW0w9cNbHYRVM/oyrzbCgUjltKXWSNG++FPamr8l477HGBQhCUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyQQ9N/TkuetNdu0xWuarBXQIQvTxu3NR7eF6OGFVoGjDbDDlV
	e6c8YMYqi4ulhy+ZfsCsl+7D3SO1gl7f950FUmxyY2kKgHyMmGP5cYuT
X-Gm-Gg: Acq92OG7EAXrMCdOg2EJydEOkZWwhSODhPr33FHrTHAwlwJs4wp7Ee9qG7nW/zOiBxm
	J2+smWzfeZLL576HU/PVa3Q+QZ90ZZcOx4Un+9a9/TpzOPAEXoNiNk/iGMj8dVI/6sGknTWoE1z
	LdGzo03j9dkG53YPSl4DeCW5z2fp9wussd84jIJqE6+OP8Mq951qQQm+Ny4yTuGY8bBnpElD5c2
	+ujkUiwDRFmeDeluLrw+MXGRZkQ7mFHZuNfczFdhCJLGGs0UZ9AhZIkxdsYKWaJ9nEBDJm0YoGC
	HlYFhEY+crP/7aDQ4AC6vaB4WJ/1wJXXojnFPjD6bOHJo4AZacBJZCxmFDPqISDUl+LEwAyiEAv
	hvaQGrVLZ14RzDdrY+QS7/mme4THiIsalhp+T9IAeNqf3snI5yOFyEQJeVXftBTtO+Dd2hitcMn
	7MFUf+FlhPUaVopjj9Vsk41CvW4tZ9QxhGxbhYl2Y2I1BWs2ogJ2UNwF5Fbwp9+IrLyPOnjnMG8
	3wEzC2ZFQ==
X-Received: by 2002:a05:600c:8184:b0:490:5cd8:d213 with SMTP id 5b1f17b1804b1-490b5eb44f8mr113527135e9.15.1780563971711;
        Thu, 04 Jun 2026 02:06:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7e6c774sm70203515e9.1.2026.06.04.02.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 02:06:11 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:06:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Askar Safin <safinaskar@gmail.com>
Cc: metze@samba.org, akpm@linux-foundation.org, axboe@kernel.dk,
 brauner@kernel.org, david@kernel.org, dhowells@redhat.com,
 hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org,
 patches@lists.linux.dev, pfalcato@suse.de, torvalds@linux-foundation.org,
 viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260604100609.6b37f500@pumpkin>
In-Reply-To: <20260603211736.755139-1-safinaskar@gmail.com>
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
	<20260603211736.755139-1-safinaskar@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:torvalds@linux-foundation.org,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295130-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 957C363E757

On Thu,  4 Jun 2026 00:17:36 +0300
Askar Safin <safinaskar@gmail.com> wrote:

> Stefan Metzmacher <metze@samba.org>:
> > Why is 'int fd' changed to 'unsigned long fd'?  
> 
> Because preadv2 and pwritev2 take "unsigned long". I want vmsplice
> to be as similar as possible to preadv2 and pwritev2.

Something needs to ensure that the high 32bits of the fd get masked off
on 64bit systems.
They can be non-zero in the register that comes from userspace.

-- David

> 
> > Should that be its own commit if the change is desired?  
> 
> Yes, possibly. But this patchset already got to next.
> 


