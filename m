Return-Path: <netdev+bounces-301554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YcqoIW2DO2pEZAgAu9opvQ
	(envelope-from <netdev+bounces-301554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:12:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C086BC0E2
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:12:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NEk6jZgM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301554-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301554-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECF37302F4D7
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 07:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F9738D401;
	Wed, 24 Jun 2026 07:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6524638B7D6
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 07:12:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285156; cv=none; b=eiyPBitwdGQ2r4Qyr9QDcRzJwxzetDgMnrRITeeeq0AjyGS1nkSeXJ0Elv63i7SwUjlHeg02mIcXl+P6Qx6qm40f4aA5gX2MkjE4OPpz2rT6WW7BlCZOGuPBmePl4QEns9gd21PR3YEhlpCXYF9A2evQQwMDuxcWFqYUimOR/lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285156; c=relaxed/simple;
	bh=T+oTEsZifQSSjkTTm8dieBj546vS01rprc6FRMPpgRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTxZFCjrnA21B3nZUVhz9O9ewUkswllHpKn5fPpY2l/j/ntlqKj2muXKkQ0ZujJGbd3dBnBEFPlpBgJBChNNSLiPNPsmSVgVKJv6v1fPYqRsTHcE8oKE831ikKfIcCghPLHijezIoYL3xG5wzRs6uhdm4tDTWzS48xVsDAyOCH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEk6jZgM; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4633193af19so509439f8f.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 00:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782285153; x=1782889953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhG9FcF945Re4Q58PUpr7BwlsxWpmlT6fgah9/vT28s=;
        b=NEk6jZgMulgJqN17XPHyzxZWrjC3SRgX+YSWsZTjYh/fBnelCNZujLrpG/e+mFyoF7
         f1Gq3XqQrb60v77rGI8/iNo2sqx2/b7UaQAXvH3QITshpe3OUojUSyJlLvUAe2/GpKjU
         SE3hQWJrn17c9XTEnFuUX50Exw4ddu2TEcs+Jh3H2E1/KEmNBi8R2E1viN8X/RS/F8hf
         ArU9eVXTMzswldd/Um38NKIYizUTz23JNVE2PVtj38Gk/Zuo1ygshyyt6BVLAHby6pN0
         x3Dfz9pBCe5euKHjThKElffKbbO9TKgxcg8aVoI/xbwPxYjVbF266rAnHHl+iApuV2NX
         Ru3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782285153; x=1782889953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VhG9FcF945Re4Q58PUpr7BwlsxWpmlT6fgah9/vT28s=;
        b=Qg3QOnVVS82mJJqnLfkZ1xwP5ZEksMypsPgwK8fKoxYyja4ZTmbomH+P6g8vt+8aWu
         XYprn0+XikF+6hBBmDdZtxAtg/NM0CO771qZAQQBeYUufpRrWXhs3saqmoMF28xYAia+
         gFzh/RWHrqiohkTGVpx6CV8OD3+rtn5hKvkWFnkH+SG7vwCGbIorYbC+X2XeA0G9b4PA
         gKUC1RxBkqOfzMCLXQAeIKI1WRi3hGI36xa7h2omZDB3naXtnEuhIbWpinKGIvL4YUs0
         APKm7itEfX/cnWOMUq5+hAjD0ykfejZC44D0FjZ3TusDDz/DrxeIU2469rnwsyIDWCh8
         AWcw==
X-Forwarded-Encrypted: i=1; AHgh+Rr7IN/nwpMSch6B1Q4KUeEvDNznaJleQsCJ62AeddXEYXu0VZ9D3GNgHIly4LOKNwiFhH969M0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ZV4BEs9Csqwxkcw8EdGwogyP44U3RvsQ2t4cpzWWk8oZVr7e
	53KZSC04Cu2C68+p9Uw08fMlJ5hhz1biwB05Pmv1TIYVh3Porcm0bUrx
X-Gm-Gg: AfdE7ckseCr38ApjH37Fy1zZn9lLf+P0h+9MATWUeCqZJRoBlgbWbzBcxflBT7UN7Ve
	nUWEGbtqZ/imuFRmL6cO7x4uIovdG94JLgU75mkxX0bUBpVwkPBRNl8XFkV+Qo226rMKHhbHraU
	/TmYBsQ00U3np4sGc1UNSl4q/F5GP9OXoHHMnIklpZAJJpIZawiFmYLAsMUo8Ny2Ej3nTFybDao
	m6ocdhWY0NrP6Ccd7a/srUgeGTvmuQytGaShn6Ki5V+e9F9XpFC7DoenWKgO+TwSmnarmRBdwu0
	PX28qPpkesHF982txSFroHA2lJqHectnhvPlk5cH4cCcU/G1+hZn++KICe27wKTC3T5nxZzuG9A
	4V12UNMABLoFIpVKkAvcVd8hSC0ZbDIvn4PXR4Syyyr88DLnDAaqZYChSsoxh+IL33eO1tH0JIO
	k7Ll4fL4K7
X-Received: by 2002:a05:6000:4683:b0:46a:1f35:113f with SMTP id ffacd0b85a97d-46a1f35172dmr8359155f8f.21.1782285152523;
        Wed, 24 Jun 2026 00:12:32 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c1ee0189esm4296531f8f.9.2026.06.24.00.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 00:12:32 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: avagin@gmail.com
Cc: akpm@linux-foundation.org,
	alexander@mihalicyn.com,
	axboe@kernel.dk,
	bernd@bsbernd.com,
	brauner@kernel.org,
	criu@lists.linux.dev,
	david@kernel.org,
	dhowells@redhat.com,
	fuse-devel@lists.linux.dev,
	hch@infradead.org,
	jack@suse.cz,
	joannelkoong@gmail.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	rostedt@goodmis.org,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	val@packett.cool,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Wed, 24 Jun 2026 10:12:26 +0300
Message-ID: <20260624071226.2272209-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CANaxB-zK5q=Xw6UZTmeFtXsDZjUsPkFk=p485m-wtNTBnf4hgg@mail.gmail.com>
References: <CANaxB-zK5q=Xw6UZTmeFtXsDZjUsPkFk=p485m-wtNTBnf4hgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-301554-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,mihalicyn.com,kernel.dk,bsbernd.com,kernel.org,lists.linux.dev,redhat.com,infradead.org,suse.cz,gmail.com,vger.kernel.org,kvack.org,szeredi.hu,suse.de,goodmis.org,packett.cool,zeniv.linux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:avagin@gmail.com,m:akpm@linux-foundation.org,m:alexander@mihalicyn.com,m:axboe@kernel.dk,m:bernd@bsbernd.com,m:brauner@kernel.org,m:criu@lists.linux.dev,m:david@kernel.org,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:joannelkoong@gmail.com,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:rostedt@goodmis.org,m:safinaskar@gmail.com,m:torvalds@linux-foundation.org,m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24C086BC0E2

Andrei Vagin <avagin@gmail.com>:
> The CRIU fifo test fails with this change. The problem is that vmsplice
> with SPLICE_F_NONBLOCK to a fifo file descriptor fails with -EOPNOTSUPP.
> 
> It seems we need a fix like this one:
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 429b0714ec57..6fc49e933727 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -1253,6 +1253,7 @@ static int fifo_open(struct inode *inode, struct
> file *filp)
> 
>         /* We can only do regular read/write on fifos */
>         stream_open(inode, filp);
> +       filp->f_mode |= FMODE_NOWAIT;
> 
>         switch (filp->f_mode & (FMODE_READ | FMODE_WRITE)) {
>         case FMODE_READ:

Does CRIU actually rely on ability to do SPLICE_F_NONBLOCK vmsplice into
named fifos? Or this is merely a test?

If this is just a test, I think we need not to preserve this behavior.

I did debian code search with regex "vmsplice.*SPLICE_F_NONBLOCK" and I
found very few packages. And it seems all them use pipes, not named fifos.

(On speed: I still think that my vmsplice patches are good thing,
despite performance regressions in CRIU.)

-- 
Askar Safin

