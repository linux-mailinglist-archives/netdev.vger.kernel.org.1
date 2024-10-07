Return-Path: <netdev+bounces-132817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4D19934EC
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 19:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680F7B22FA9
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A851DD55E;
	Mon,  7 Oct 2024 17:25:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBAE1DCB06
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321949; cv=none; b=ocQlktgOAaiDwZbQRppuHm0Pi8WsXL613x0SeYGgEasOCxJ5ufecgwgfHKEdJeoZfd4lI86OIOAkL4V7y0SdfU9Z0iXqzYSHuDRdJeIpBxtOB5HRvEpY0WWaeNMCUMZ78n2pU8O7s67jDoyw/rw0N6MlXaLdY4oToUQCDtFVrwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321949; c=relaxed/simple;
	bh=INmZol1x4vw5tKLuL89pb8JapLI8y0qO+8Qmvw6IKNI=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=rLc+UIsKvC9GpeThrQIOokmeAXPfCJEODRUAYh76Poofr0m5be4x4aXclFmEyoZIB+qpWN1Ql9Wez/48kwOjL7d6hX4N14f0hEBW3a85VONBWDCK9MntmFExGC6hE7+q2PGjIitmQP8gpwHVYzxK04zSTR3oJNB/ncFvbGHC/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:55392)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sxqap-003cT9-ER; Mon, 07 Oct 2024 10:28:19 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:57128 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sxqao-00De15-EK; Mon, 07 Oct 2024 10:28:19 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <davem@davemloft.net>,  <edumazet@google.com>,  <kuba@kernel.org>,
  <kuni1840@gmail.com>,  <netdev@vger.kernel.org>,  <pabeni@redhat.com>
References: <87h69ohsgj.fsf@email.froward.int.ebiederm.org>
	<20241007154210.22366-1-kuniyu@amazon.com>
Date: Mon, 07 Oct 2024 11:28:11 -0500
In-Reply-To: <20241007154210.22366-1-kuniyu@amazon.com> (Kuniyuki Iwashima's
	message of "Mon, 7 Oct 2024 08:42:10 -0700")
Message-ID: <87v7y3g9no.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sxqao-00De15-EK;;;mid=<87v7y3g9no.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/7pfb1vLEY3ZWaKhAYVhnIMeaXvdqi5o4=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4872]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_04 7+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kuniyuki Iwashima <kuniyu@amazon.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 452 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 11 (2.4%), b_tie_ro: 9 (2.1%), parse: 0.96 (0.2%),
	 extract_message_metadata: 13 (2.8%), get_uri_detail_list: 2.2 (0.5%),
	tests_pri_-2000: 13 (3.0%), tests_pri_-1000: 2.4 (0.5%),
	tests_pri_-950: 1.33 (0.3%), tests_pri_-900: 1.01 (0.2%),
	tests_pri_-90: 87 (19.2%), check_bayes: 85 (18.9%), b_tokenize: 8
	(1.8%), b_tok_get_all: 10 (2.1%), b_comp_prob: 3.3 (0.7%),
	b_tok_touch_all: 60 (13.2%), b_finish: 0.95 (0.2%), tests_pri_0: 309
	(68.3%), check_dkim_signature: 0.60 (0.1%), check_dkim_adsp: 2.8
	(0.6%), poll_dns_idle: 1.00 (0.2%), tests_pri_10: 2.1 (0.5%),
	tests_pri_500: 9 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 net 5/6] mpls: Handle error of rtnl_register_module().
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: pabeni@redhat.com, netdev@vger.kernel.org, kuni1840@gmail.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net, kuniyu@amazon.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Kuniyuki Iwashima <kuniyu@amazon.com> writes:

> From: "Eric W. Biederman" <ebiederm@xmission.com>
> Date: Mon, 07 Oct 2024 09:56:44 -0500
>> Kuniyuki Iwashima <kuniyu@amazon.com> writes:
>> 
>> > Since introduced, mpls_init() has been ignoring the returned
>> > value of rtnl_register_module(), which could fail.
>> 
>> As I recall that was deliberate.  The module continues to work if the
>> rtnetlink handlers don't operate, just some functionality is lost.
>
> It's ok if it wasn't a module.  rtnl_register() logs an error message
> in syslog, but rtnl_register_module() doesn't.  That's why this series
> only changes some rtnl_register_module() calls.

You talk about the series.  Is there an introductory letter I should
lookup on netdev that explains things in more detail?

I have only seen the patch that is sent directly to me.

>> I don't strongly care either way, but I want to point out that bailing
>> out due to a memory allocation failure actually makes the module
>> initialization more brittle.
>> 
>> > Let's handle the errors by rtnl_register_many().
>> 
>> Can you describe what the benefit is from completely giving up in the
>> face of a memory allocation failure versus having as much of the module
>> function as possible?
>
> What if the memory pressure happend to be relaxed soon after the module
> was loaded incompletely ?

Huh?  The module will load completely.  It will just won't have full
functionality.  The rtnetlink functionality simply won't work.

> Silent failure is much worse to me.

My point is from the point of view of the MPLS functionality it isn't
a __failure__.

> rtnl_get_link() will return NULL and users will see -EOPNOTSUPP even
> though the module was loaded "successfully".

Yes.  EOPNOTSUPP makes it clear that the rtnetlink functionality
working.  In most cases modules are autoloaded these days, so the end
user experience is likely to be EOPNOTSUPP in either case.

If you log a message, some time later someone will see that there is
a message in the log that the kernel was very low on memory and could
could not allocate enough memory for rtnetlink.

Short of rebooting or retrying to load the module I don't expect
there is much someone can do in either case.  So this does not look
to me like a case of silent failure or a broken module.

Has anyone actually had this happen and reported this as a problem?
Otherwise we are all just arguing theoretical possibilities.

My only real point is that change is *not* a *fix*.
This change is a *cleanup* to make mpls like other modules.

I am fine with a cleanup, but I really don't think we should describe
this as something it is not.

The flip side is I tried very hard to minimize the amount of code in
af_mpls, to make maintenance simpler, and to reduce the chance of bugs.
You are busy introducing what appears to me to be an untested error
handling path which may result in something worse that not logging a
message.  Especially when someone comes along and makes another change.

It is all such a corner case and I really don't care, but I just don't
want this to be seen as a change that is obviously the right way to go
and that has no downside.

Eric



