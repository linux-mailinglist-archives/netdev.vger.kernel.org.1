Return-Path: <netdev+bounces-147116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB669D7929
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95AC2826F3
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 23:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC74156F5D;
	Sun, 24 Nov 2024 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JdIAXh5N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0v86LT+E";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JdIAXh5N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0v86LT+E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADFF17E017
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732491806; cv=none; b=ToRVYTLkf3ThehIUrUo9OqZqOQ67SC3z1Mq5vTa5vnvoTP4ALY6f7oNnSPItFAJ7DR9bWPHtV/CRj8OWZzvPSBQtdREP044rtu4mINyWcwQJ3yLFnkI/fAmYjFxzICJhiyThIljPJ8SfxPkgcEZFM01CABX5IBkN9jENXHQJUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732491806; c=relaxed/simple;
	bh=NT8YzLSzORufnUUwG1oBmgWrLkbxPn52zh8Ip36Q0i0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZW4KXalAKGe0t5THR982ldLkPNv3PTiOGi6xbXyGM6yBeE3ouJlmwTpSV+yb5mH+n1tXuoYd/1FytkPcW79taJduO77/qyIJF1s3XgpUJwRGobeZzx62FpCoSHfhL9H72blLSt8sFb81SuZ5REQatyx4/Q8GqTjKP1w0h0Yi4e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JdIAXh5N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0v86LT+E; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JdIAXh5N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0v86LT+E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7C6521189;
	Sun, 24 Nov 2024 23:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732491802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSDjACpvENEkB1yzni7clI4Ewzc/zs26B+UliJw5U64=;
	b=JdIAXh5N5DtqHzqtm9eOger/WQ3CCVJHRA+GrAqinzs5FEPb5stn8O00ZastDdbLG7Vdk/
	DrRQZ2mShAPZZvd5g/j1Aow7sB16fOj/Oz9zvMvLdRT3onji2cX5VUN5UUP+ct4FMsfPL1
	6iNnBhCjsBuj7dKD5OlE9r7rZSH4l6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732491802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSDjACpvENEkB1yzni7clI4Ewzc/zs26B+UliJw5U64=;
	b=0v86LT+E42JTHolydA8j/7Vm5D/L8WARS0JmsKTMjRHanOIabhQXGVY09oAX7XbGICpXAr
	0AW3LlaXhSKm+yBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732491802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSDjACpvENEkB1yzni7clI4Ewzc/zs26B+UliJw5U64=;
	b=JdIAXh5N5DtqHzqtm9eOger/WQ3CCVJHRA+GrAqinzs5FEPb5stn8O00ZastDdbLG7Vdk/
	DrRQZ2mShAPZZvd5g/j1Aow7sB16fOj/Oz9zvMvLdRT3onji2cX5VUN5UUP+ct4FMsfPL1
	6iNnBhCjsBuj7dKD5OlE9r7rZSH4l6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732491802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSDjACpvENEkB1yzni7clI4Ewzc/zs26B+UliJw5U64=;
	b=0v86LT+E42JTHolydA8j/7Vm5D/L8WARS0JmsKTMjRHanOIabhQXGVY09oAX7XbGICpXAr
	0AW3LlaXhSKm+yBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8C5413676;
	Sun, 24 Nov 2024 23:43:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OL56Ihi6Q2dGRgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 24 Nov 2024 23:43:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
Cc: "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Thomas Graf" <tgraf@suug.ch>, netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
In-reply-to: <Z0O02AvPs664hJAa@gondor.apana.org.au>
References: <>, <Z0O02AvPs664hJAa@gondor.apana.org.au>
Date: Mon, 25 Nov 2024 10:43:16 +1100
Message-id: <173249179605.1734440.169960974865430595@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 25 Nov 2024, Herbert Xu wrote:
> On Mon, Nov 25, 2024 at 10:09:43AM +1100, NeilBrown wrote:
> >
> > When writing code I don't only want to guard against problems that I can
> > reproduce.  I want to guard against any problem that is theoretically
> > possible.   Unless you can explain why -EBUSY is not possible, I have to
> > write code to handle it.
> 
> I just explained to you that it's extremely unlikely (e.g., less
> than the chance of a cosmic ray flipping your DRAM) for you to get
> EBUSY.
> 
> Not only do you have to have an extremely long hash chain (> 16)
> to get EBUSY, you also need to have a hash table that is less than
> 75% full, and that there is an outstanding rehash on the table.
> 
> Admittedly the last condition is a bit loose right now because it
> also includes routine rehashes such as growing/shrinking and I will
> fix that up.
> 
> So there is no reason why you should handle EBUSY, it chould be
> turned into a WARN_ON_ONCE.
> 

So please turn it into a WARN_ON_ONCE and don't allow the code to return
it.

NeilBrown

