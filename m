Return-Path: <netdev+bounces-296505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jb1iHPmrJmqwawIAu9opvQ
	(envelope-from <netdev+bounces-296505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:48:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD539655D75
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:48:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=CU33JHhO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296505-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296505-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7980305B59D
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 11:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17C936B06A;
	Mon,  8 Jun 2026 11:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEC336AB6B
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 11:40:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918827; cv=none; b=iqCB+rltjrXMNa1AoxqaB3+cqemgVQ8+g2yVzcirez1OpNTd9gGy8Bp3CZulIzGwh2WWeGBiJhr7OaAW/ifu4cSjOeDgK998azACA8sY0a928AdavdgJ/JRF/ISOqDflMYnehe2iJm57E+dsK/8YUZHN7LHSVkDUnufUUbUYex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918827; c=relaxed/simple;
	bh=gt817j5d2FZcQYx9aiRFtGll+41qpg8M37eW3rPlaLM=;
	h=Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type:Date; b=uDLueJ+ZP06Ix9sRTNJ1CBHcSQGSeXzkk41wNoE0VJV/7FaRRYX370zCOsKzp09nbS6WbLI+BQw4f3O1P98I0MaEXH0Rc996RT6pnOjUxMksNF29thNqd36wvpkQ01WGvgjkLahgmIBiOgyttfObKmr05e+l9vZTr4h1Ur31a6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CU33JHhO; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45efb698ef2so1895158f8f.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 04:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780918824; x=1781523624; darn=vger.kernel.org;
        h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gt817j5d2FZcQYx9aiRFtGll+41qpg8M37eW3rPlaLM=;
        b=CU33JHhOJJpl7G85SmXd37aYDGyPNc1hcQU4q+6OJ/2MUTacmuThcIoEtwOpdud9nR
         9/HdLyCw/h6jDB7VnA4vDU8ICEQRvuBVcEz/L4CdSZ0GzGJTb1aL4wu6Dgvgw5vBRNyp
         wA1tJLT+bol7dh3VO+K7B7YxZKMLkw9lCpk52epadCuzaKdyARU4lmYukD8IxlpERS+Q
         uLUFqKLdIRuOCNN/e1LLwxwOPeJ+e6pVjjQj+injFQHEgDxYRUWWeBaAvQB9sgS8mKbz
         +8ARhmnOYxUGm2JN95dC+P7KudilAnUI00WGu1vcxdbCtJnLchqiBwacxAHLp3mnBJUR
         fq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780918824; x=1781523624;
        h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt817j5d2FZcQYx9aiRFtGll+41qpg8M37eW3rPlaLM=;
        b=szyEhWMxjpa1Tjn3y7fvH47ziaLodbtroMijfCyyokasSw2A7EPIRZ+TEcPFus4Og5
         mkWRgkZq93htiUD2PzwUSccfM0bT7Y7EHYItIGg/b60OXvefBsZQBn13FSeRdqX2tghI
         a22RPgHOtSJiOZoK3CFkzMS9cROGZhBVxknWOsWFg3OTmEpM2NOnw6LZuadgK3SHZrM0
         M13KHoQ8JCx1pFvuTM5C8+HFA4oAbFln7d7zjS0Yrw2T4f915GaEw9JgEbq/W8w4xshf
         cieuS2C3Fhy6mtOmujAIgxv1/wECVwnPMqRN3hcS+evg094/eDpdyW8W24aaHcEUFBcQ
         JAXw==
X-Forwarded-Encrypted: i=1; AFNElJ8kBNU5Vn0sADqVoLSc1PmWC0BCjtFoyRKLN51AkXuRvmyOuHHd061MXHP+uLh/6jx/ZzLQPZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqjUhv3xiGTj5xkIbeMRXVVykpe9XGJbkD0m1afQLwP3yH/9Xb
	W9rNZikTQOsWxXIMhJBaPVjwr18ToDTk691rBwy+vS4byfMC3gmidVHh2gLoZdliys4=
X-Gm-Gg: Acq92OGavN4fLLFXxPTupcRWlMBCfFQCpzv/IrLal4sRnM+llpvCFM8PuT//BNObtS2
	bbSS07iWnAGqgeCwpS09/DG6PIj8yReIQVzjQRFgo6xFS7V4nvfUnEX3dwGXkgIJfUDc2y3w28f
	2Gu6i/x8cE1kPbibAt/z2O3lCsSpENxnFE+zwN9BQvjeXTjVZcpT20EuTLvUlDk9u9afMYa/ieI
	xEg6quHVBt4FvE+V0Df7G12lB7TvdjgioWC6qrXKn/6qJQTV10VWPIdwDQA8MsJxeVTlE/ebMwW
	Eb6f6W3tyYNiZ52wE6G4b8Xlpql/hPFqQVURkBWGs6mtzIfNrSaTlRHBFTWfQ0OBJncbMfiiy0+
	m0HZDj1mgKRFXBbqcGZqYxYhKNG3puIcxPT8yK+1nr6CQfBrvoRP2QN7i0h0YYOvtu5Agu9zlm2
	9j9fjywSsWw4eOgYbch5Q/GLkOk+CmCVeYRV0iPCmDH0aiXrIX4M/BkDSFFTBfARbmyRMrDVdmL
	/pnljzPTi70K1YMFyzPLW8OLnB7CfTYtDC8kI8yla+Ydw==
X-Received: by 2002:a05:6000:46cd:b0:460:1492:4f0d with SMTP id ffacd0b85a97d-4603063c591mr15377117f8f.34.1780918824402;
        Mon, 08 Jun 2026 04:40:24 -0700 (PDT)
Received: from localhost.localdomain (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de. [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm40821903f8f.14.2026.06.08.04.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:40:24 -0700 (PDT)
Message-ID: <6a26aa28.283787d8.1f1282.ba36@mx.google.com>
From: "Andrea Cervesato" <andrea.cervesato@suse.com>
To: "Askar Safin" <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, "Christian Brauner" <brauner@kernel.org>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, "The 8472" <kernel@infinite-source.de>, patches@lists.linux.dev, "David
 Howells" <dhowells@redhat.com>, linux-mm@kvack.org, "Collin Funk" <collin.funk1@gmail.com>, "Joanne
 Koong" <joannelkoong@gmail.com>, "Miklos Szeredi" <miklos@szeredi.hu>, "David
 Laight" <david.laight.linux@gmail.com>, "Matthew Wilcox" <willy@infradead.org>, "Christoph
 Hellwig" <hch@infradead.org>, "Steven Rostedt" <rostedt@goodmis.org>, fuse-devel@lists.linux.dev, "David
 Hildenbrand" <david@kernel.org>, "Pedro Falcato" <pfalcato@suse.de>, ltp@lists.linux.it, "Jens
 Axboe" <axboe@kernel.dk>, "Stefan Metzmacher" <metze@samba.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Andy
 Lutomirski" <luto@amacapital.net>, linux-api@vger.kernel.org, "Andrew
 Morton" <akpm@linux-foundation.org>, "Linus Torvalds" <torvalds@linux-foundation.org>, "Willy
 Tarreau" <w@1wt.eu>
In-Reply-To: <20260606061031.3744880-1-safinaskar@gmail.com>
Subject: Re: [LTP] [PATCH 0/5] vmsplice: fix some problems in my previous
 vmsplice patchset
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 11:40:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-296505-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:kernel@infinite-source.de,m:patches@lists.linux.dev,m:dhowells@redhat.com,m:linux-mm@kvack.org,m:collin.funk1@gmail.com,m:joannelkoong@gmail.com,m:miklos@szeredi.hu,m:david.laight.linux@gmail.com,m:willy@infradead.org,m:hch@infradead.org,m:rostedt@goodmis.org,m:fuse-devel@lists.linux.dev,m:david@kernel.org,m:pfalcato@suse.de,m:ltp@lists.linux.it,m:axboe@kernel.dk,m:metze@samba.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luto@amacapital.net,m:linux-api@vger.kernel.org,m:akpm@linux-foundation.org,m:torvalds@linux-foundation.org,m:w@1wt.eu,m:collinfunk1@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrea.cervesato@suse.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zeniv.linux.org.uk,suse.cz,infinite-source.de,lists.linux.dev,redhat.com,kvack.org,gmail.com,szeredi.hu,infradead.org,goodmis.org,suse.de,lists.linux.it,kernel.dk,samba.org,amacapital.net,linux-foundation.org,1wt.eu];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.cervesato@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mx.google.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:from_mime,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD539655D75

Hi Askar,

the patch-set doesn't apply:

error: fs/read_write.c: does not exist in index
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort=
".
hint: Disable this message with "git config set advice.mergeConflict false"
Applying: vmsplice: open-code do_writev and do_readv
Patch failed at 0001 vmsplice: open-code do_writev and do_readv

https://github.com/linux-test-project/ltp-agent/actions/runs/27129052434/jo=
b/80065058557#step:8:21

Please update it to a new version after rebasing with the upstream master
branch.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

