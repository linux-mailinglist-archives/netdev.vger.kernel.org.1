Return-Path: <netdev+bounces-303360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0gXnOq0lRGrwpQoAu9opvQ
	(envelope-from <netdev+bounces-303360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:23:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F3F6E7C6F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 22:23:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm3 header.b=NtNfENdA;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="A xxt0L7";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303360-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303360-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=johnericson.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CA33306FED0
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1A3EC2CB;
	Tue, 30 Jun 2026 20:22:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C93DFC93;
	Tue, 30 Jun 2026 20:22:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782850970; cv=none; b=geg9KS9S/JjhrXcTveVaUSJnFKpRe/lQvyvgndyOMTCxc8wMAkCvof47utZXIGpH/HhW3Z8AkyWest722RarLQnVSBie64yisyecF/yBeYRPPPPOUozL6u7SGGVvtWMStlcnYR9lpywrcXbXW4IBtfQUItQ7IDkVs7HfKZgxjH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782850970; c=relaxed/simple;
	bh=E/1GRPAhq/z8dkF2qE+9M54j9+TZzZ6ebgYpimWXjx4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XX7jaLfBj2jkeKFeC7Nfv97Aw8nyENpYQP1riHrzZxU3Y6JBgJOHFZB387I4JYuR4KrQazddnUn4jqSWfbSiFdFj6AHR1bZ66Fv77TyCJ5YYEsiKpwfQgBLodU/NDVtFFVsnbuYrpQlNK8KzuLYfUAXV4isrQHeVFnPQTbiZWZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=NtNfENdA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Axxt0L7g; arc=none smtp.client-ip=103.168.172.150
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 03840EC018C;
	Tue, 30 Jun 2026 16:22:48 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Tue, 30 Jun 2026 16:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1782850967; x=1782937367; bh=ImMCq2g/+CnrELmjJfykJhJwl9epgRAt
	MN2WHOmfAYw=; b=NtNfENdACRh7f6vuoHr9w2tXjbjdTHJjbWh4G2KLkCIkBsib
	yJzg/DTPFFQMvAqxC56OkmaqoNIGqZrpuwtFSM2Wsar2hYirZXRWhFln7MQHcmEc
	6kkc8pUTEU5Dz7cZx6+jMvL2YE7uCpvEGVHLm7eCpLCgyggKk6XyOUcfUWzc8Kz6
	suCZ1ES6VspruEp9SW0EoVbLRNevueu7z5TrevV1Qu7BZUrcx8mbMgeXub5Yfoyh
	oASuFVIQuck/ethgdk4N4sCfgU/EfXRnsMgLrdnyMzlC3hCS4+hZI4O5S/pVdqCY
	52q0XNbOASQ3YCclmBqlXxpZdVGnK4VnM/F6Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782850967; x=
	1782937367; bh=ImMCq2g/+CnrELmjJfykJhJwl9epgRAtMN2WHOmfAYw=; b=A
	xxt0L7gVMqSrwoiKq3LqUdKTAhqolHVApIR/sVKX17pr+OKbR3wSI9z51JHB3HkE
	FxO6V/vqHzUk6tTURBri91nYHlU0s3RZ6k7vwnWmZDI2VOAigXAXxL6yzWWVM2Cd
	lNpZ+I+Zp2iZX926UJiWWjv/SMotoBjeWijwizgCA87g+XlSdT3fw7KR6D6V9t/w
	VLVCOAha6+rrFcualQ2EeCmCXV/gUbjdLB5SN4M5XYSTE47LKY8vRih4xq2fTM0F
	bFDw3/Lk67xT4SkbEFkWQkZ7XwabLwMo8Toyo1QDcfmMsQ93zNVrpk5rwfuCZbM6
	SHTXkvl5lm8ma3aH09XSA==
X-ME-Sender: <xms:lyVEajfpni2RYPLcu9P-jCI3zPy18SpZMQ1oOXax-RhFym0Lp9RChQ>
    <xme:lyVEakCKc74QS9_U7SjIPw5sYg0VA-KxbTEWQDegRp2LX94qZ67WJJJW0jzKTkFdT
    yki8K1gQamV5k_iBeYl8QeFDUVeWCbeD6z9-zxkrlkzj7qxv9qOTQ>
X-ME-Proxy-Cause: dmFkZTEob2y7xsHNEpz/7I02rTab7fGg7x7fjcd6S9Va4JVcYH5vCtabOClhZHXi+41eaR
    1VSm1ZUO6YkVjVZ4lciGuVzFDosH2S4m0HTnNWtX5Mh8P6x279hOjqpqJEQcJQWjW+TxJE
    E2biBtIb9cAL1CvtBOuyGKpQQiOy2bmkhiBEUEYuK48BrmQW4Tr7ALBTnxdlX/5jpAbzw4
    1/m7cp5Ds/WNcwyxj1FuIA3XG22FoPbngHN70OmIKfgA1z+VV+/QcbplNulXKCQ08tRH1S
    wXkK6+MuVakggurtLx3RiOcOaczsgSLJiPWnEkBCSgL1o95iqcwzJb5I9TmBm7jU/VYVZ9
    WQ+0NR1ZtlWSHx5h9bIvV90akohUk6wGDVgGd6lqfneK1NLc1cc3KeL+rtCuSL7bfUFuXT
    TMeGsyy3JfcVQXMOq8ikjUztz7RmxfjWRZ2IRLa7emHLEMIDl6fyT+X03RF147zz52Y/gf
    UYXVrPzmxRW16lukDPVLv9xSZRkYo1vA26OaLHhw6j8/1jvMJExkEdezN1TTGao4NZgsxU
    h4GRpwQ6p93s6wgga1Ny5eSVXeL/LyswknZI0NA0CTO3Diq6LRucA78cx6ZzJBYQsDhoTN
    TXmIfSh1V82546thVvEFtiICLgbd/p7+SK4C8Uw1c7Wvdq+sHjvxpFhMTm2Q
X-ME-Proxy: <xmx:lyVEatEu_FDqYIZOiJLhQ1vidQUkMR-SxbE3bFeQCpa0jwcXtzxoaw>
    <xmx:lyVEasYUacYtmc4QEp_m9fCgpB8-QsvSNBNen7xoK-3eJGuHPAPnsA>
    <xmx:lyVEavAXyjES9Znt05JlLWrv5UVebEyAfvjTaIQ588194mCnx_Exog>
    <xmx:lyVEaknMNoTZhQ_P0LZMGBuHqaCZmAT32aEc_tAsPotYpPojyFbIOw>
    <xmx:lyVEauPih3bsBcvndDxw6GSCL14n0JgxfS-ci95ae0La3tBFx5bR89t3>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 91A2C2CC0083; Tue, 30 Jun 2026 16:22:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aqzxz9K-cSE-
Date: Tue, 30 Jun 2026 16:22:25 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Cong Wang" <cwang@multikernel.io>
Cc: "Li Chen" <me@linux.beauty>, "Andy Lutomirski" <luto@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "network dev" <netdev@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-Id: <e396ce86-ec84-4189-9da2-98af7cfa6c41@app.fastmail.com>
In-Reply-To: <66eb8227-85b6-4684-a4fa-e3e17ac2fa45@app.fastmail.com>
References: <b1af80fc-a57c-408d-bdfe-fa6bae26eaca@app.fastmail.com>
 <aicbyQIC2qEveNd-@pop-os.localdomain>
 <455281ec-3ee1-4f27-989b-c239f0690d8b@app.fastmail.com>
 <aixU_RccxS_BKhgX@pop-os.localdomain>
 <66eb8227-85b6-4684-a4fa-e3e17ac2fa45@app.fastmail.com>
Subject: Re: [RFC] connectat()/bindat() or an alternative design
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[johnericson.me:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-303360-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mail@johnericson.me,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:cwang@multikernel.io,m:me@linux.beauty,m:luto@kernel.org,m:brauner@kernel.org,m:axboe@kernel.dk,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[johnericson.me:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@johnericson.me,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,app.fastmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46F3F6E7C6F

I'm bumping this and adding new recipients again in light of the
discussion happening elsewhere in
<https://lore.kernel.org/all/a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com/>.
I don't want to count my chickens before they are hatched, but it is
looking to me like a consensus in that thread is building around the
ability to opt into intentionally empty/unusable root and working
directories (at least with nullfs, maybe but less likely with other
mechanisms instead).

That new functionality concretizes the motivation for what I am
proposing in this thread: in such a world, there is little to no point
binding listening sockets in the file system, because the containing
directory would have to be conveyed by file descriptor anyways --- might
as well just directly convey the socket to connect to by file
descriptor. Likewise, abstract sockets are not appealing, because the
abstract socket namespace is either too coarse-grained (leaking info in
the same way root/cwd would), or too cumbersome to keep it from leaking.

To recap (with some slight changes, like renames), my latest proposal (a
new version, not either of the two variations in the original email) is
new syscalls `bind_unix_anon` and `connectat`, supporting a workflow
like this:

    /* server */
    int lfd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
    int addrfd = bind_unix_anon(
            lfd,
            /*flags, for the future*/0);
    listen(lfd, 64);

    /* client, handed `addrfd` */
    int cfd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
    connectat(addrfd, cfd, AT_EMPTY_PATH);

Or, more radically, `bind_unix_anon` and `connectat` could let one skip
the initial `socket` calls by returning those new sockets directly:

    /* server */
    int fds[2];
    bind_unix_anon(
            SOCK_STREAM | SOCK_CLOEXEC,
            /*flags, for the future*/0,
            fds);
    int lfd = fds[0], addrfd = fds[1];
    listen(lfd, 64);

    /* client, handed `addrfd` */
    int cfd = connectat(
            addrfd,
            SOCK_STREAM | SOCK_CLOEXEC,
            AT_EMPTY_PATH);

(Note that in this variation `bind_unix_anon` would return *two* file
descriptors: one for the server, with the permission to listen, and the
other for clients, with just the privilege to `connectat`.) (Maybe
`bind_unix_anon` should furthermore `listen` right away on `lfd` too?)

Of course, it would be nice to have io_uring versions of these too. But
I don't know what the usual process is for that (regular first? io_uring
first? both at the same time?)

Thanks,

John

P.S. For anyone just getting CC'd now, the first message in this thread
is
<https://lore.kernel.org/all/b1af80fc-a57c-408d-bdfe-fa6bae26eaca@app.fastmail.com/>.
Hope that might save people a few keypresses :).

