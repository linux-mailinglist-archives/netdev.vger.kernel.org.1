Return-Path: <netdev+bounces-78252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6018787483F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 07:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83BEA1C2360A
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 06:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238021CAA4;
	Thu,  7 Mar 2024 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z5+tjnf6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OYUDa+jJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z5+tjnf6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OYUDa+jJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6275C1848
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709793557; cv=none; b=eGoTKdeSCqeQLQquQdj0IcY8aINR3e/zWc5OmkNu8M0PyWxm8UwBBn1kl+erqBU+JtEzDXnlZcweqZd9aj0g5gPSXgG3I/cUJUhjsAGUPh8AD7uICJ8rXLS3Pmj4TaOTLDGZweip+nF1VtOuGPOX8lP2wCFnc1nyshG4yGVFLwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709793557; c=relaxed/simple;
	bh=AYa/Qfgn1Ip7VqDIOYQqiMSfZeF8IQt0uaAhxBYZ5fk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=idVjY5auP3wJGPzJpHNFe37dKbCA+ms7/F0vtk/hggvCv2N4RITgBa2O8GTM0ctVW/VDpWsCVJ4w+5+bWzJoNkuYlih0pJ1Hk20ly9eYwvt1GpxnkxEsMolmWOws/252Vad20aRkBYXyeEBwOsQOnzCmJfb6xCSyYHbvry25BK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z5+tjnf6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OYUDa+jJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z5+tjnf6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OYUDa+jJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ACC0F400FC;
	Thu,  7 Mar 2024 06:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709793553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NigKllvJ8eASV5a6Ssv5WydIVfbrNOg/A6piYIFEW2E=;
	b=z5+tjnf6x2NGJyZlfodWPWjf1fWKflAWh9i+woMM4nhg9IGmbh0dDG6jfqo7S+x0VpWMTM
	gKzX/5bZhgtO/lB7yR8He+Gx9fg1oz2EzUfYjR/qZG/+mpPonKXu1wMMYTAjh7ARWwjSVU
	T/SsNfvBJ/F2zyy6rNrTwDmZYBOxGSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709793553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NigKllvJ8eASV5a6Ssv5WydIVfbrNOg/A6piYIFEW2E=;
	b=OYUDa+jJ1ZXRHx/XWxCeJCo3ukvtIrvdJt+SNaea4alEqDBCWSXLwuwbzJzLQi7PE+uPya
	yS5WKOYW5as6D2DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709793553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NigKllvJ8eASV5a6Ssv5WydIVfbrNOg/A6piYIFEW2E=;
	b=z5+tjnf6x2NGJyZlfodWPWjf1fWKflAWh9i+woMM4nhg9IGmbh0dDG6jfqo7S+x0VpWMTM
	gKzX/5bZhgtO/lB7yR8He+Gx9fg1oz2EzUfYjR/qZG/+mpPonKXu1wMMYTAjh7ARWwjSVU
	T/SsNfvBJ/F2zyy6rNrTwDmZYBOxGSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709793553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NigKllvJ8eASV5a6Ssv5WydIVfbrNOg/A6piYIFEW2E=;
	b=OYUDa+jJ1ZXRHx/XWxCeJCo3ukvtIrvdJt+SNaea4alEqDBCWSXLwuwbzJzLQi7PE+uPya
	yS5WKOYW5as6D2DA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 208CF13466;
	Thu,  7 Mar 2024 06:39:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ELqmMA9h6WXQMAAAn2gu4w
	(envelope-from <colyli@suse.de>); Thu, 07 Mar 2024 06:39:11 +0000
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: Doesn't compile commit 0d60d8df6f49 ("dpll: rely on rcu for
 netdev_dpll_pin()")
From: Coly Li <colyli@suse.de>
In-Reply-To: <CANn89iKseL-ihYhrGmbp3D7Fztg97re61wZuaqB61OMBeJbVxQ@mail.gmail.com>
Date: Thu, 7 Mar 2024 14:38:50 +0800
Cc: arkadiusz.kubalewski@intel.com,
 vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D26DFFCB-1FF2-40E4-BD0B-F0410471650B@suse.de>
References: <70C97E7F-767B-4E75-A454-E4468505F248@suse.de>
 <CANn89iKseL-ihYhrGmbp3D7Fztg97re61wZuaqB61OMBeJbVxQ@mail.gmail.com>
To: Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 MV_CASE(0.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linux-foundation.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60



> 2024=E5=B9=B43=E6=9C=887=E6=97=A5 14:35=EF=BC=8CEric Dumazet =
<edumazet@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Mar 7, 2024 at 7:14=E2=80=AFAM Coly Li <colyli@suse.de> wrote:
>>=20
>> Hi folks,
>>=20
>> The commit 0d60d8df6f49 ("dpll: rely on rcu for netdev_dpll_pin()=E2=80=
=9D) doesn=E2=80=99t compile and see the following error message,
>>=20
>> colyli@x:~/source/linux/linux> make
>>  CALL    scripts/checksyscalls.sh
>>  DESCEND objtool
>>  INSTALL libsubcmd_headers
>>  DESCEND bpf/resolve_btfids
>>  INSTALL libsubcmd_headers
>>  CC      net/core/dev.o
>> In file included from ./arch/x86/include/generated/asm/rwonce.h:1:0,
>>                 from ./include/linux/compiler.h:251,
>>                 from ./include/linux/instrumented.h:10,
>>                 from ./include/linux/uaccess.h:6,
>>                 from net/core/dev.c:71:
>> net/core/dev.c: In function =E2=80=98netdev_dpll_pin_assign=E2=80=99:
>> ./include/linux/rcupdate.h:462:36: error: dereferencing pointer to =
incomplete type =E2=80=98struct dpll_pin=E2=80=99
>> #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
>>                                    ^~~~
>> ./include/asm-generic/rwonce.h:55:33: note: in definition of macro =
=E2=80=98__WRITE_ONCE=E2=80=99
>>  *(volatile typeof(x) *)&(x) =3D (val);    \
>>                                 ^~~
>> ./arch/x86/include/asm/barrier.h:67:2: note: in expansion of macro =
=E2=80=98WRITE_ONCE=E2=80=99
>>  WRITE_ONCE(*p, v);      \
>>  ^~~~~~~~~~
>> ./include/asm-generic/barrier.h:172:55: note: in expansion of macro =
=E2=80=98__smp_store_release=E2=80=99
>> #define smp_store_release(p, v) do { kcsan_release(); =
__smp_store_release(p, v); } while (0)
>>                                                       =
^~~~~~~~~~~~~~~~~~~
>> ./include/linux/rcupdate.h:503:3: note: in expansion of macro =
=E2=80=98smp_store_release=E2=80=99
>>   smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
>>   ^~~~~~~~~~~~~~~~~
>> ./include/linux/rcupdate.h:503:25: note: in expansion of macro =
=E2=80=98RCU_INITIALIZER=E2=80=99
>>   smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
>>                         ^~~~~~~~~~~~~~~
>> net/core/dev.c:9081:2: note: in expansion of macro =
=E2=80=98rcu_assign_pointer=E2=80=99
>>  rcu_assign_pointer(dev->dpll_pin, dpll_pin);
>>  ^~~~~~~~~~~~~~~~~~
>> make[4]: *** [scripts/Makefile.build:243: net/core/dev.o] Error 1
>> make[3]: *** [scripts/Makefile.build:481: net/core] Error 2
>> make[2]: *** [scripts/Makefile.build:481: net] Error 2
>> make[1]: *** [/home/colyli/source/linux/linux/Makefile:1921: .] Error =
2
>> make: *** [Makefile:240: __sub-make] Error 2
>>=20
>> Can anyone help to take a look? Thanks.
>=20
> Look at past messages in netdev@ mailing list, refresh your tree to =
the latest,
> you will see this is already discussed and fixed.
>=20
> 289e922582af5b4721ba02e86bde4d9ba918158a dpll: move all dpll<>netdev
> helpers to dpll code
> 9224fc86f1776193650a33a275cac628952f80a9 ice: fix uninitialized dplls
> mutex usage
> 640f41ed33b5a420e05daf395afae85e6b20c003 dpll: fix build failure due
> to rcu_dereference_check() on unknown type


Indeed, I did that on Linus tree, but last commit of my local log is,

commit 67be068d31d423b857ffd8c34dbcc093f8dfff76 (HEAD -> master, =
origin/master, origin/HEAD)
Merge: 5274d261404c a50026bdb867
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Mar 6 08:12:27 2024 -0800

    Merge tag 'vfs-6.8-release.fixes' of =
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs


Maybe it is a CDN synchronization delay, I will try to pull again later.

Thanks for the fast response.

Coly Li=

