Return-Path: <netdev+bounces-229917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 11092BE2069
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 09:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 893B735299D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5A52FFF9B;
	Thu, 16 Oct 2025 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GLMuqSN7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o5FTWD0P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nk+EEeH9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JeGyijXh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7861F2FF676
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601010; cv=none; b=hDKJGAhuOyOg+4YbKSzrkUWYRP1qHwOweFG3MzZIRAWNRt+Yu8tnceZ/kGAIcWbViZf4gAE5eLhqIlJOfUQ60Ks9uekRMuqre2R4+9Feu+7+JefLdpzPkpNIw4wO+U3UMJh4hngwymJi5MdlSeDsWaSFdzUcsntNfiZ0e7ukxa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601010; c=relaxed/simple;
	bh=aXuv3tSyiJV8KNlKZ+KkmgKFZtNyre+/2pL61RBDtoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D98avkBfgx/j2rOi2nB0GmQ1lKceSyBh8n/02D2CiVdR687Q7DeHCqGjR2Hf9nW/cjCyBJJtdGwoCtg0+nsV/RrK4TkVBxvNipyFVf7Yn5+g3MFZ4v/vnxpzLy2UX3zIXi6+i7IqrhX4GJGH9+/lJSOxI0F4saJYr5kLZnZqzFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GLMuqSN7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o5FTWD0P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nk+EEeH9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JeGyijXh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DABE61F7D5;
	Thu, 16 Oct 2025 07:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760601001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4w5N+d5fWi0pVM9o1+XRD2Qyvji/NhqmrKPiLBf0XTA=;
	b=GLMuqSN7XN6TvH/IKYXy2D+FdOneIsCWMi9lasB0wj/6MRJbe8d/1hE+Wp08udr1EZ7rC1
	Npq68/rscsaB+SOhzP2QICJoYBFXP/Tf0pukmB/TwvFg6Nqc3wNKqjPqVmpGqonoUJctOG
	MQtl3s4gXP0Amc1ciKkl+LfqgWd4R94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760601001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4w5N+d5fWi0pVM9o1+XRD2Qyvji/NhqmrKPiLBf0XTA=;
	b=o5FTWD0P/ddukrqGwBrIzzLulSigTnaIuL3TMkdS0UcBZTpndrqnPcEhb1FC88Pvf+qamq
	BlozbvJW7W4PRpDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nk+EEeH9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JeGyijXh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760600999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4w5N+d5fWi0pVM9o1+XRD2Qyvji/NhqmrKPiLBf0XTA=;
	b=nk+EEeH90NqX87UuX5rea7POfv0ubt5wdwzUsZD21jRXQVHT+UVCntO5ys8F/Eh/vg8cqR
	u7YqL9fHnPoT0zcATcBwF6Uz1NmzTQFmzRTsflneuyMAry3RyUBM43nCmgPoIiDbgYhq3R
	sd6aqBx6RCZrkJgxyX2ggU7BRjlVA38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760600999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4w5N+d5fWi0pVM9o1+XRD2Qyvji/NhqmrKPiLBf0XTA=;
	b=JeGyijXh1f08gmx5jTqyS3vDtrAC4UjeHX16WytNbySeKzlGJwExkIdthT3fKWCWmThQ++
	SwkzotnXnVNxoCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ADCF1340C;
	Thu, 16 Oct 2025 07:49:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OrLUGqej8GjFbwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 16 Oct 2025 07:49:59 +0000
Message-ID: <5bedb16f-af89-490f-80ef-e1eebe237b07@suse.de>
Date: Thu, 16 Oct 2025 09:49:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] in 6.17, failing
 __dev_change_net_namespace+0xb89/0xc30
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Cynthia <cynthia@kosmx.dev>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org
References: <01070199e22de7f8-28f711ab-d3f1-46d9-b9a0-048ab05eb09b-000000@eu-central-1.amazonses.com>
 <20251015133120.7ef53b20@kernel.org> <2025101649-lid-cancel-4a69@gregkh>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <2025101649-lid-cancel-4a69@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DABE61F7D5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 



On 10/16/25 8:25 AM, Greg Kroah-Hartman wrote:
> On Wed, Oct 15, 2025 at 01:31:20PM -0700, Jakub Kicinski wrote:
>> On Tue, 14 Oct 2025 10:04:43 +0000 Cynthia wrote:
>>> When I updated my machine to the newest kernel, a bug started to appear.
>>> The system does not panic, but an error kept happening in dmesg.
>>>
>>> The bug happens with LXC/Incus when it tries to start a new container.
>>> (but probably other things are affected too)
>>>
>>>
>>> Steps to Reproduce: the bug can be reproduced in a libvirt VM, no need
>>> for a specific system. Also I suspect the bug is also
>>> architecture-independent, but I cannot verify that.
>>> 1) Install ArchLinux (all dependencies are available). I was testing
>>> with vanilla kernel, so any linux distro should be affected.
>>> https://aur.archlinux.org/packages/linux-mainline can be installed, this
>>> is the vanilla kernel with a generally good kernel config for most PCs.
>>> 2) Install LXC/Incus (pacman -S incus)
>>> 3) configure incus and start a container:
>>> usermod -v 1000000-1000999999 -w 1000000-1000999999 root &&
>>> incus admin init &&
>>> incus launch images:debian/12 first # start a container
>>> 4) Previous step should trigger incus to do namespaces. I'm not sure
>>> what syscall is causing the bug, I do not have a mini C program. These
>>> steps should be enough to see the log in the dmesg.
>>>
>>> I also did a git bisect, the first commit to have this bug is this:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c17270f9b920e4e1777488f1911bbfdaf2af3be
>>>
>>> I initially reported this bug on Bugzilla, but after seeing 6 year old
>>> bugs there, I'm not sure if that platform is still in use.
>>> https://bugzilla.kernel.org/show_bug.cgi?id=220649
>>>
>>> Since my initial report, 6.17.2 was released, the bug is still happening.
>>>
>>> I'm attaching 2 files:
>>> dmesg_slice: the slice of dmesg containing the problematic frame (on a
>>> bare-metal linux with AMD srso mitigation disabled)
>>> bisect_log: a log of the git bisect process
>>
>> Thanks a lot for bisecting! Looking at the code my guess is that sysfs
>> gives us ENOENT when we try to change owner of a file that isn't
>> visible. Adding sysfs maintainers - should sysfs_group_attrs_change_owner()
>> call is_visible before trying to touch the attr?
> 
> Oh, I never considered that call-path, and given that I haven't seen a
> bug report about this yet, it's pretty rare :)
> 
> So yes, that should be checked.  Can anyone knock up a patch for this?
> I'm busy all today with other stuff, sorry.
> 
> greg k-h
> 

I can send a patch, I hit this yesterday too.

Thanks,
Fernando.

