Return-Path: <netdev+bounces-147545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6C09DA1A7
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 06:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11845168E59
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 05:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ED613C677;
	Wed, 27 Nov 2024 05:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DN5u6hr6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UX2lm8bd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DN5u6hr6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UX2lm8bd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D68481CD
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 05:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732684476; cv=none; b=KcgP6j9kfXTWpfOSPWFFB1HanuAGdV+OewAjIuyAT0RFOsXrqEpF2J02db8RkEn3s7TyvVkCPzeYjn6YS7zFuFaA3qUSDIscD6a1ok8nZG93vMULZtM4LFNhJVtQOoaF5pxg3P5XQD6Ll5NozaJc5D4+/oNeWaNixUX6zg0GF3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732684476; c=relaxed/simple;
	bh=KcQ7oALOy7zkJo8djgAgCoJCx/1IAAr1miXMnsitupU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ERlwdkWKb0rbO1LTBLP4+jj3ZmCRgug7Qn1K30XQZmpI52Fu9g2nJ1E4tFZ1UrZl2eQnn9aHZ01B45/oRYE83d6zCUIuv+lzb3Dj29nXjs7NNTx2GcsYdTIcz3B7pdcOwY0j+8XF3ZOHMy+xBxF+f1cAJaewSdtjVpvVDIfBot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DN5u6hr6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UX2lm8bd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DN5u6hr6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UX2lm8bd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BA3B21168;
	Wed, 27 Nov 2024 05:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732684472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTeYVCNb9tu+LcChhDjGOWsPDQU0HwOx3M+oDj38rA4=;
	b=DN5u6hr6lF2mIHedAiuFVQCKhbU7Ok+4TvWe2nqZIsEHld6xiPv4WWwpXISkGRQUCYL16g
	0gW+sVzUGuScfJYWYv8yBhPdJBLVMqg9l4mKKUmUhJwVX9xHWjQy/6iRWYROFUt0skeItb
	jSsaVu+a3SFP5/Iy7out9PJKghfaAXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732684472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTeYVCNb9tu+LcChhDjGOWsPDQU0HwOx3M+oDj38rA4=;
	b=UX2lm8bdfk1tLftUpvIpqOPAqv1gSCEBYWWx141eNl8YjQ+Zf5/uyNR1vhMyjFYQjHpnlu
	gkjjhupaNcL4pIAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732684472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTeYVCNb9tu+LcChhDjGOWsPDQU0HwOx3M+oDj38rA4=;
	b=DN5u6hr6lF2mIHedAiuFVQCKhbU7Ok+4TvWe2nqZIsEHld6xiPv4WWwpXISkGRQUCYL16g
	0gW+sVzUGuScfJYWYv8yBhPdJBLVMqg9l4mKKUmUhJwVX9xHWjQy/6iRWYROFUt0skeItb
	jSsaVu+a3SFP5/Iy7out9PJKghfaAXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732684472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTeYVCNb9tu+LcChhDjGOWsPDQU0HwOx3M+oDj38rA4=;
	b=UX2lm8bdfk1tLftUpvIpqOPAqv1gSCEBYWWx141eNl8YjQ+Zf5/uyNR1vhMyjFYQjHpnlu
	gkjjhupaNcL4pIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C19BA13941;
	Wed, 27 Nov 2024 05:14:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l7qjHbaqRmd0dAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 27 Nov 2024 05:14:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Kent Overstreet" <kent.overstreet@linux.dev>
Cc: "Herbert Xu" <herbert@gondor.apana.org.au>, "Thomas Graf" <tgraf@suug.ch>,
 netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
In-reply-to: <4mnlqfprxh5zuvhjxqrqvqr2btaqggcuy5ofgvdlsxpwi3gljt@rd3pfavturcx>
References:
 <>, <4mnlqfprxh5zuvhjxqrqvqr2btaqggcuy5ofgvdlsxpwi3gljt@rd3pfavturcx>
Date: Wed, 27 Nov 2024 16:14:26 +1100
Message-id: <173268446669.1734440.17749966565144969951@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, 27 Nov 2024, Kent Overstreet wrote:
> On Tue, Nov 26, 2024 at 12:36:54PM +0800, Herbert Xu wrote:
> > On Mon, Nov 25, 2024 at 11:35:48PM -0500, Kent Overstreet wrote:
> > >
> > > That knob was. That's not what I'm suggesting. Can you go back and
> > > re-read my, and Neal's, suggestion?
> > 
> > That's exactly what the knob used to do.  Let you add entries
> > without any limit.
> 
> No, the other option would be to add a knob to block until the rehash is
> finished instead of returning -EBUSY - that wouldn't be insecure.

Blocking is never acceptable for hashtable_insert().  It isn't needed.

I only suggested blocking (after dropping locks) because it is currently
the only way to handle some errors.  It would be better not to get the
errors.  This means accepting the possibility of longer hash chains.
Sometimes that is an acceptable tradeoff.

> 
> If allocating a bigger table is failing, that would require the limit on
> chain length to increase in order to guarantee that inserts won't fail,
> but that wouldn't be a security issue.
> 

but it would mean you cannot know if a long chain is a security issue -
someone determined your seed and is attacking your hash - or if it is
due to the density of the table being high.

I think it is perfectly reasonable to use use a word like "insecure" in
the description of the knob to allow longer hash chains and zero
failures.  I would want the insecurity to be clearly described, but I
think we would all want that.

NeilBrown



