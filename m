Return-Path: <netdev+bounces-245840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43718CD9024
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 12:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9209930012D4
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653B133D6C0;
	Tue, 23 Dec 2025 11:04:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A98D2609C5
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487840; cv=none; b=f8zsNB+R0wHW9+R+KljXiFMuQXP92exqTcjvMiX52b3NoqbfvUYDUpFlT3UJPRo4qx4vw6Jl+NEkE2kspN59/CVAP5SJpEYk5QqTifDZ02VtU1atJ3G0uPmRG5OvGDOD+Qr6IgIan7QSbgvxbkg8Oq+yoawqDgmFH0Sh+elMGz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487840; c=relaxed/simple;
	bh=J+B+7xahjB5B+x8xFad/pE1SwM93uwXgihriBfK/wVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iL5yW9EkQOltmsmYmD2YkJrPUj0dCOcyr1gCfVxdz5TrZD06o0iv+aHZBe8fxjkzH3x8CS7fhnKlYrh1nG1MrnpP1w1stznYgZwAjEpjNfkEQRhWw6o0CBIWPXdjIqqidumjL5/C3rMEs34xz/sKmV8gMYByv+MNvvKA9PCLiuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vY0BB-000000005s6-324s;
	Tue, 23 Dec 2025 11:03:49 +0000
Date: Tue, 23 Dec 2025 11:03:43 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: netdev@vger.kernel.org, "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>
Subject: Re: question on gswip_pce_table_entry_write() in
 lantiq_gswip_common.c
Message-ID: <aUp3D45Ka-rYL44u@makrotopia.org>
References: <87sed1shwl.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sed1shwl.fsf@prevas.dk>

Hi Rasmus,

On Tue, Dec 23, 2025 at 09:48:26AM +0100, Rasmus Villemoes wrote:
> Hi
> 
> Reading gswip_pce_table_entry_write() in lantiq_gswip_common.c, I'm
> wondering if it really has to do all that it does. In particular, it
> seems to write the same value to (a subset of) the GSWIP_PCE_TBL_CTRL
> reg twice, then it reads the reg value back, manually tweaks the
> remaining bits appropriately and folds in the "start access bit", then
> writes the whole value to the register.

My understanding of GSWIP_PCE_TBL_CTRL is that this register is used to
set the table and address/index to used for subsequent access with the
GSWIP_PCE_TBL_* registers.

It also looks weird to me, but I didn't have much time to try to
optimize it, the sequence of register access is present since the
initial support for VLAN unaware bridge offloading

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8206e0ce96b33e6513615de9151e794bbc9f3786

> 
> Why couldn't that be done by reading the register, do all the masking
> and bit setting, then doing a single write of the whole thing?

I agree, and it looks like it could be improved in this way, the only
"special" bit there is probably GSWIP_PCE_TBL_CTRL_BAS.

> 
> The data sheet doesn't say anything about this complicated scheme being
> necessary.
> 
> Another thing: I'd really appreciate it if someone could point me to
> documentation on the various tables, i.e. what does val[2] of an entry
> in GSWIP_TABLE_VLAN_MAPPING actually mean? I can see that BIT(port) is
> either set or cleared from it depending on 'untagged', so I can
> sort-of-guess, but I'd prefer to have it documented so I don't have to
> guess. AFAICT, none of the documents I can download from MaxLinear spell
> this out in any way.

I also don't have any for-human documentation for the switch table entry
formats and registers. I doubt any documentation of that actually
exists.

Most of the switching engine itself is covered in

GSW12x_GSW14x_Register_Description_PR_Rev1.1.pdf

but also that doesn't describe the individual tables. My reference for
that is the old/proprietary SW-API driver which describes some (but not
all) of the table entry formats in code at least...

You find the SW-API as part of various GPL leaks, all files there are
under a dual BSD/GPLv2 license, so I can also share my (latest/official)
version of that driver with you in case you don't have it.


Cheers


Daniel

