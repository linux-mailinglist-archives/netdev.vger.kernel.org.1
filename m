Return-Path: <netdev+bounces-87177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB038A1FC9
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 21:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DC91C21BE5
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 19:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55C21802B;
	Thu, 11 Apr 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xd0ya5Lg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EZEzZhp9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xd0ya5Lg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EZEzZhp9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6444F1773D
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712865217; cv=none; b=JrH+lPcadzRu7+g2kPfi0wV9+kEh8A7y+7PHvJC7+foaQHviz6xis5OpXm/nY/7662VQUu5adxG1IStUN//yaC+dj2glAS6+py7AFm0anx3dpGc9aVbqNSIt7DyBrtJbyM/yzAiPWNMZWK8aLX2UNcvHU7wmToTFJQMdIOrrKXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712865217; c=relaxed/simple;
	bh=Ev3UzVIn8vDwzjHYgic1U5P7VfQpNp2IqaMlwjFWYhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MLvPlfKKjzn9ldLEmFURPUxeqKVM9N6frN1TiCRqQELvsuWCsgX61IVxsD/pwOfKXXU1ktroSR9ef2c/UL4OfH0tbuHdUPXUdipP8Lm/7lRDBHPXlihsT0dLC/q2U0D1LQM3kT1kclGe4BYd+ASneOm0ntGR8kGg5XH0OpHzX2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xd0ya5Lg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EZEzZhp9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xd0ya5Lg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EZEzZhp9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B836378CE;
	Thu, 11 Apr 2024 19:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712865213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h7Av/XccXAxpRKrhQTdpeUr87rOmAAqnpSXGYWhH7Rw=;
	b=xd0ya5LgfzHD6hk2msNoPbItKcV0FNY6ZsQccsi1laR79L/BM9Bw19iPhKg4WOmb/7oOqq
	zD+e1nsIAwZiNmivT4zlWloVulJ15egly+gxaAVk4snL1yCoSwRuskennrt8rN09YtUXt1
	7pI1TTiY1uCRScp3dIqx3RRM+RW1mVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712865213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h7Av/XccXAxpRKrhQTdpeUr87rOmAAqnpSXGYWhH7Rw=;
	b=EZEzZhp9NgQRF2mMwuS8g9gnJXYCHWgVH0rtxLGvYp8tvRWW+Zl5C3DG/UOIMgLgcVMuSE
	2CO+iEXUGgeFkcDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712865213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h7Av/XccXAxpRKrhQTdpeUr87rOmAAqnpSXGYWhH7Rw=;
	b=xd0ya5LgfzHD6hk2msNoPbItKcV0FNY6ZsQccsi1laR79L/BM9Bw19iPhKg4WOmb/7oOqq
	zD+e1nsIAwZiNmivT4zlWloVulJ15egly+gxaAVk4snL1yCoSwRuskennrt8rN09YtUXt1
	7pI1TTiY1uCRScp3dIqx3RRM+RW1mVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712865213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h7Av/XccXAxpRKrhQTdpeUr87rOmAAqnpSXGYWhH7Rw=;
	b=EZEzZhp9NgQRF2mMwuS8g9gnJXYCHWgVH0rtxLGvYp8tvRWW+Zl5C3DG/UOIMgLgcVMuSE
	2CO+iEXUGgeFkcDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDB631368B;
	Thu, 11 Apr 2024 19:53:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0D/ULbw/GGbGLQAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 11 Apr 2024 19:53:32 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <davem@davemloft.net>,  <lmb@isovalent.com>,  <martin.lau@kernel.org>,
  <netdev@vger.kernel.org>,  <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v2] udp: Avoid call to compute_score on multiple sites
In-Reply-To: <20240411022121.65702-1-kuniyu@amazon.com> (Kuniyuki Iwashima's
	message of "Wed, 10 Apr 2024 19:21:21 -0700")
References: <87a5m08y09.fsf@mailhost.krisman.be>
	<20240411022121.65702-1-kuniyu@amazon.com>
Date: Thu, 11 Apr 2024 15:53:31 -0400
Message-ID: <871q7b8ymc.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,isovalent.com,kernel.org,vger.kernel.org,gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

Kuniyuki Iwashima <kuniyu@amazon.com> writes:

> From: Gabriel Krisman Bertazi <krisman@suse.de>
> Date: Wed, 10 Apr 2024 21:54:30 -0400
>> Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:
>> 
>> > Kuniyuki Iwashima wrote:
>> >> From: Gabriel Krisman Bertazi <krisman@suse.de>
>> >> Date: Wed, 10 Apr 2024 17:50:47 -0400
>> >> > We've observed a 7-12% performance regression in iperf3 UDP ipv4 and
>> >> > ipv6 tests with multiple sockets on Zen3 cpus, which we traced back to
>> >> > commit f0ea27e7bfe1 ("udp: re-score reuseport groups when connected
>> >> > sockets are present").  The failing tests were those that would spawn
>> >> > UDP sockets per-cpu on systems that have a high number of cpus.
>> >> > 
>> >> > Unsurprisingly, it is not caused by the extra re-scoring of the reused
>> >> > socket, but due to the compiler no longer inlining compute_score, once
>> >> > it has the extra call site in udp4_lib_lookup2.  This is augmented by
>> >> > the "Safe RET" mitigation for SRSO, needed in our Zen3 cpus.
>> >> > 
>> >> > We could just explicitly inline it, but compute_score() is quite a large
>> >> > function, around 300b.  Inlining in two sites would almost double
>> >> > udp4_lib_lookup2, which is a silly thing to do just to workaround a
>> >> > mitigation.  Instead, this patch shuffles the code a bit to avoid the
>> >> > multiple calls to compute_score.  Since it is a static function used in
>> >> > one spot, the compiler can safely fold it in, as it did before, without
>> >> > increasing the text size.
>> >> > 
>> >> > With this patch applied I ran my original iperf3 testcases.  The failing
>> >> > cases all looked like this (ipv4):
>> >> > 	iperf3 -c 127.0.0.1 --udp -4 -f K -b $R -l 8920 -t 30 -i 5 -P 64 -O 2
>> >> > 
>> >> > where $R is either 1G/10G/0 (max, unlimited).  I ran 3 times each.
>> >> > baseline is 6.9.0-rc1-g962490525cff, just a recent checkout of Linus
>> >> > tree. harmean == harmonic mean; CV == coefficient of variation.
>> >> > 
>> >> > ipv4:
>> >> >                  1G                10G                  MAX
>> >> > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
>> >> > baseline 1730488.20(0.0050) 1639269.91(0.0795) 1436340.05(0.0954)
>> >> > patched  1980936.14(0.0020) 1933614.06(0.0866) 1784184.51(0.0961)
>> >> > 
>> >> > ipv6:
>> >> >                  1G                10G                  MAX
>> >> > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
>> >> > baseline  1679016.07(0.0053) 1697504.56(0.0064) 1481432.74(0.0840)
>> >> > patched   1924003.38(0.0153) 1852277.31(0.0457) 1690991.46(0.1848)
>> >> > 
>> >> > This restores the performance we had before the change above with this
>> >> > benchmark.  We obviously don't expect any real impact when mitigations
>> >> > are disabled, but just to be sure it also doesn't regresses:
>> >> > 
>> >> > mitigations=off ipv4:
>> >> >                  1G                10G                  MAX
>> >> > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
>> >> > baseline 3230279.97(0.0066) 3229320.91(0.0060) 2605693.19(0.0697)
>> >> > patched  3242802.36(0.0073) 3239310.71(0.0035) 2502427.19(0.0882)
>> >> > 
>> >> > Cc: Lorenz Bauer <lmb@isovalent.com>
>> >> > Fixes: f0ea27e7bfe1 ("udp: re-score reuseport groups when connected sockets are present")
>> >> > Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
>> >> > 
>> >> > ---
>> >> > Changes since v1:
>> >> > (me)
>> >> >   - recollected performance data after changes below only for the
>> >> >   mitigations enabled case.
>> >> > (suggested by Willem de Bruijn)
>> >> >   - Drop __always_inline in compute_score
>> >> >   - Simplify logic by replacing third struct sock pointer with bool
>> >> >   - Fix typo in commit message
>> >> >   - Don't explicitly break out of loop after rescore
>> >> > ---
>> >> >  net/ipv4/udp.c | 18 +++++++++++++-----
>> >> >  net/ipv6/udp.c | 17 +++++++++++++----
>> >> >  2 files changed, 26 insertions(+), 9 deletions(-)
>> >> > 
>> >> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> >> > index 661d0e0d273f..a13ef8e06093 100644
>> >> > --- a/net/ipv4/udp.c
>> >> > +++ b/net/ipv4/udp.c
>> >> > @@ -427,12 +427,15 @@ static struct sock *udp4_lib_lookup2(struct net *net,
>> >> >  {
>> >> >  	struct sock *sk, *result;
>> >> >  	int score, badness;
>> >> > +	bool rescore = false;
>> >> 
>> >> nit: Keep reverse xmax tree order.
>> >> https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
>> >> 
>> >> >  
>> >> >  	result = NULL;
>> >> >  	badness = 0;
>> >> >  	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
>> >> > -		score = compute_score(sk, net, saddr, sport,
>> >> > -				      daddr, hnum, dif, sdif);
>> >> > +rescore:
>> >> > +		score = compute_score((rescore ? result : sk), net, saddr,
>> >> 
>> >> I guess () is not needed around rescore ?
>> >> 
>> >> Both same for IPv6.
>> >> 
>> >> Otherwise, looks good to me.
>> >> 
>> >> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>> >
>> > Can we avoid using the same name for the label and boolean?
>> >
>> > And since if looping result will have state TCP_ESTABLISHED, can it
>> > just be
>> >
>> >     sk = result;
>> >     goto rescore;
>> 
>> This would be much simpler, sure.  I actually didn't want to do it
>> because sk is the iteration cursor, and I couldn't prove to myself it is
>> safe to skip through part of the list (assuming result isn't the
>> immediate next socket in the list).
>
> Good point, this is not safe actually.
>
> Let's say sockets on the same port are placed in these order in the list:
>
>   1. TCP_CLOSE sk w/ SO_INCOMING_CPU _not_ matching the current CPU
>   2. TCP_ESTABLISHED sk matching 4-tuple
>   3. TCP_CLOSE sk w/ SO_INCOMING_CPU matching the current CPU
>
> When we check the first socket, we'll get the 3rd socket as it matches
> the current CPU ID and TCP_ESTABLISHED cannot be selected without BPF,
> and `sk = result;` skips the 2nd socket, which should have been
> selected.

k. Considering this, what I get from the discussion is:

since we need to preserve the sk pointer, we are keeping the
condition (rescore ?  result:sk) in the compute_score call and
maintaining the reset of rescore in the hotpath to prevent scoring the
wrong thing on further loops. It is ugly, but it is a single instruction
over a in-register value, so it hardly matters.

If so, I'll do the style changes (parenthesis, sort of stack variables)
and add the early continue to resume the loop right after the rescore,
similar to what I had in V1, that Willem suggested:

            badness = score;

+            if (rescore)
+                    continue;

Please, let me know if I misunderstood, so I don't send a bogus v3.  I
will take some hours to run the tests, so I should send a v3 by
tomorrow.

-- 
Gabriel Krisman Bertazi

