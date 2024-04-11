Return-Path: <netdev+bounces-86808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C418A05AC
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 03:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294FB28883A
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 01:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06B6B646;
	Thu, 11 Apr 2024 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G6rqFYHu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ujCvsqBq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cFlI9CDI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CKbMS2uD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8290633FE
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712800481; cv=none; b=Ml9IbFDeDq7x4OCcRMgUcTRbzvXkmU1r7mB/jsZbhik4W8b/AoTg4sGlqx1l82RFT1Dw1gVAuqe+/R9N2hdEIIgKs1ypMhQm2l/8ZMoX9tDORC+veab2e8Gg/eSu10VBYidzzXk8rbznBPuei7e4pgwr92RS+Gff2mgHvM50uJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712800481; c=relaxed/simple;
	bh=wIRNMbcm11xPg7LANYQtds93bwCzOG65LvlqEsMXtXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JKZdkdufnwI+KnvjgZcv1I+ReWSgl6RZMBiYtdjQmd5JQ3RNLMgIpsUSnfLp5yy3RJ3u6nu44gYEHyPmhBImFy/3Kn+EdvPwu7nLS5tmtK0zGkJzCiHtr9ydvzvM6BahGgWwTMPz71WeUm6sA57DTpzXHlkobyqMsveBpr9Yxi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G6rqFYHu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ujCvsqBq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cFlI9CDI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CKbMS2uD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 07FA12043D;
	Thu, 11 Apr 2024 01:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712800478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gX3NNHbYDoQSA/Nf0ZlAsDSKGtiENjz1PSH/ONJkCKo=;
	b=G6rqFYHuMReIMzEgF/QsVvyYZxIBADnl7xoBoyqTdx1RBGKwbS4xIDmevBD4Vzm3QvGApP
	DFOXAWQc9YI5rJULRzUS4V3fiDLvWhA3yFph9AwTPmebs64nAd/RjCt6QsUOyWdgYDAPTc
	oG91EbdWqpNpoFjrx05CiHLO3hQLGTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712800478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gX3NNHbYDoQSA/Nf0ZlAsDSKGtiENjz1PSH/ONJkCKo=;
	b=ujCvsqBqWbG6cgGh51rPWyOE1LRz4rQkxMMd0lPE3ovNpbsmb8tJTGquLGPeLbD8YgnYzB
	TjoQgpo5gU0PFXDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cFlI9CDI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CKbMS2uD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712800476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gX3NNHbYDoQSA/Nf0ZlAsDSKGtiENjz1PSH/ONJkCKo=;
	b=cFlI9CDI+LYD1VnP8AQphRQdwJZ1Bpfkz+8hVGEGC4KCTrDNFdfNdqLOMMLHbk/aUYDT23
	0qdDI8mEIfz6DuJ3/bdii+z5VK2PSIJBSHd7U564m+xUAe2z8VHlxeNyAFe4rfFuPVGufx
	/+Hm0Oes/EbnADXcrKfUC/KIlRgx/nE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712800476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gX3NNHbYDoQSA/Nf0ZlAsDSKGtiENjz1PSH/ONJkCKo=;
	b=CKbMS2uDeC+dL2ov1qVMBE0xMsWmyAxD2t9wMh1yB1tYq4m3oB5lrizOFDKqo5Jxgxry7C
	MOAFVau3O0/OUiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C27B913929;
	Thu, 11 Apr 2024 01:54:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YRVEI9tCF2aaVgAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 11 Apr 2024 01:54:35 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,  davem@davemloft.net,
  lmb@isovalent.com,  martin.lau@kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH v2] udp: Avoid call to compute_score on multiple sites
In-Reply-To: <661717f5c2839_2d123b294f@willemb.c.googlers.com.notmuch> (Willem
	de Bruijn's message of "Wed, 10 Apr 2024 18:51:33 -0400")
Organization: SUSE
References: <20240410215047.21462-1-krisman@suse.de>
	<20240410221301.44576-1-kuniyu@amazon.com>
	<661717f5c2839_2d123b294f@willemb.c.googlers.com.notmuch>
Date: Wed, 10 Apr 2024 21:54:30 -0400
Message-ID: <87a5m08y09.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	HAS_ORG_HEADER(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,isovalent.com:email,suse.de:dkim,suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 07FA12043D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

Willem de Bruijn <willemdebruijn.kernel@gmail.com> writes:

> Kuniyuki Iwashima wrote:
>> From: Gabriel Krisman Bertazi <krisman@suse.de>
>> Date: Wed, 10 Apr 2024 17:50:47 -0400
>> > We've observed a 7-12% performance regression in iperf3 UDP ipv4 and
>> > ipv6 tests with multiple sockets on Zen3 cpus, which we traced back to
>> > commit f0ea27e7bfe1 ("udp: re-score reuseport groups when connected
>> > sockets are present").  The failing tests were those that would spawn
>> > UDP sockets per-cpu on systems that have a high number of cpus.
>> > 
>> > Unsurprisingly, it is not caused by the extra re-scoring of the reused
>> > socket, but due to the compiler no longer inlining compute_score, once
>> > it has the extra call site in udp4_lib_lookup2.  This is augmented by
>> > the "Safe RET" mitigation for SRSO, needed in our Zen3 cpus.
>> > 
>> > We could just explicitly inline it, but compute_score() is quite a large
>> > function, around 300b.  Inlining in two sites would almost double
>> > udp4_lib_lookup2, which is a silly thing to do just to workaround a
>> > mitigation.  Instead, this patch shuffles the code a bit to avoid the
>> > multiple calls to compute_score.  Since it is a static function used in
>> > one spot, the compiler can safely fold it in, as it did before, without
>> > increasing the text size.
>> > 
>> > With this patch applied I ran my original iperf3 testcases.  The failing
>> > cases all looked like this (ipv4):
>> > 	iperf3 -c 127.0.0.1 --udp -4 -f K -b $R -l 8920 -t 30 -i 5 -P 64 -O 2
>> > 
>> > where $R is either 1G/10G/0 (max, unlimited).  I ran 3 times each.
>> > baseline is 6.9.0-rc1-g962490525cff, just a recent checkout of Linus
>> > tree. harmean == harmonic mean; CV == coefficient of variation.
>> > 
>> > ipv4:
>> >                  1G                10G                  MAX
>> > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
>> > baseline 1730488.20(0.0050) 1639269.91(0.0795) 1436340.05(0.0954)
>> > patched  1980936.14(0.0020) 1933614.06(0.0866) 1784184.51(0.0961)
>> > 
>> > ipv6:
>> >                  1G                10G                  MAX
>> > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
>> > baseline  1679016.07(0.0053) 1697504.56(0.0064) 1481432.74(0.0840)
>> > patched   1924003.38(0.0153) 1852277.31(0.0457) 1690991.46(0.1848)
>> > 
>> > This restores the performance we had before the change above with this
>> > benchmark.  We obviously don't expect any real impact when mitigations
>> > are disabled, but just to be sure it also doesn't regresses:
>> > 
>> > mitigations=off ipv4:
>> >                  1G                10G                  MAX
>> > 	    HARMEAN  (CV)      HARMEAN  (CV)    HARMEAN     (CV)
>> > baseline 3230279.97(0.0066) 3229320.91(0.0060) 2605693.19(0.0697)
>> > patched  3242802.36(0.0073) 3239310.71(0.0035) 2502427.19(0.0882)
>> > 
>> > Cc: Lorenz Bauer <lmb@isovalent.com>
>> > Fixes: f0ea27e7bfe1 ("udp: re-score reuseport groups when connected sockets are present")
>> > Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
>> > 
>> > ---
>> > Changes since v1:
>> > (me)
>> >   - recollected performance data after changes below only for the
>> >   mitigations enabled case.
>> > (suggested by Willem de Bruijn)
>> >   - Drop __always_inline in compute_score
>> >   - Simplify logic by replacing third struct sock pointer with bool
>> >   - Fix typo in commit message
>> >   - Don't explicitly break out of loop after rescore
>> > ---
>> >  net/ipv4/udp.c | 18 +++++++++++++-----
>> >  net/ipv6/udp.c | 17 +++++++++++++----
>> >  2 files changed, 26 insertions(+), 9 deletions(-)
>> > 
>> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> > index 661d0e0d273f..a13ef8e06093 100644
>> > --- a/net/ipv4/udp.c
>> > +++ b/net/ipv4/udp.c
>> > @@ -427,12 +427,15 @@ static struct sock *udp4_lib_lookup2(struct net *net,
>> >  {
>> >  	struct sock *sk, *result;
>> >  	int score, badness;
>> > +	bool rescore = false;
>> 
>> nit: Keep reverse xmax tree order.
>> https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
>> 
>> >  
>> >  	result = NULL;
>> >  	badness = 0;
>> >  	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
>> > -		score = compute_score(sk, net, saddr, sport,
>> > -				      daddr, hnum, dif, sdif);
>> > +rescore:
>> > +		score = compute_score((rescore ? result : sk), net, saddr,
>> 
>> I guess () is not needed around rescore ?
>> 
>> Both same for IPv6.
>> 
>> Otherwise, looks good to me.
>> 
>> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> Can we avoid using the same name for the label and boolean?
>
> And since if looping result will have state TCP_ESTABLISHED, can it
> just be
>
>     sk = result;
>     goto rescore;

This would be much simpler, sure.  I actually didn't want to do it
because sk is the iteration cursor, and I couldn't prove to myself it is
safe to skip through part of the list (assuming result isn't the
immediate next socket in the list).  I'll take a better look, as I'm not
familiar with this code, but if you considered this already, I will
follow up with the change you suggested.

>
>> 
>> > +				      sport, daddr, hnum, dif, sdif);
>> > +		rescore = false;
>> >  		if (score > badness) {
>> >  			badness = score;
>> >  
>> > @@ -456,9 +459,14 @@ static struct sock *udp4_lib_lookup2(struct net *net,
>> >  			if (IS_ERR(result))
>> >  				continue;
>> >  
>> > -			badness = compute_score(result, net, saddr, sport,
>> > -						daddr, hnum, dif, sdif);
>> > -
>> > +			/* compute_score is too long of a function to be
>> > +			 * inlined, and calling it again here yields
>> > +			 * measureable overhead for some
>> > +			 * workloads. Work around it by jumping
>> > +			 * backwards to rescore 'result'.
>> > +			 */
>> > +			rescore = true;
>> > +			goto rescore;
>> >  		}
>> >  	}

-- 
Gabriel Krisman Bertazi

