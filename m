Return-Path: <netdev+bounces-140327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FA09B5FB8
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 11:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AAB1F21BBA
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 10:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807B81E231C;
	Wed, 30 Oct 2024 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="hfL46OIM"
X-Original-To: netdev@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB43194151;
	Wed, 30 Oct 2024 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282931; cv=none; b=HmOJq1NJW3IPmm+UEiCB5/VM0MnV0ffV7EQk6933aiGCyaFcdbWTJpo0bz0XIeynggn8VOXj0vP+syYpNgaBcCfvjVJIJzNufkfPr1N/mkgsrXsfPpJ+nSjNVWy2QguIU+NFawZN2Xpue43+DQWqjp3gS6THqi+uwTrZKP25mz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282931; c=relaxed/simple;
	bh=GJjkKtJLGg2c+fpkv6w0zC/tfBrQdQJ3rxaYasuqh38=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FhEI6MdN1PkS1QWuP62/gwpH8D431buAGZVUjnP4mGrN0zWLS8DrI/76Pwvy1z6FHjSVHFUXE/IbmP0yKRNdNdXwocbQry2piMIuJOO6tjAYnsS2QvOeofTcbIwIHEctUVxsSg/5PsizxTWWXybVwG3/e7j7V4EPnn6gbwAWKd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=hfL46OIM; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aoyqYRRkHEEL8sSP+v1UFQCenPsx/7LS5sbiYM0jCV0=;
  b=hfL46OIM18PcKRsLAxYyS/WxSYD8Ro3TW3AC0/4WXC5MaBxvvy+xN3hB
   XXKqxYjLwiNlpZgkf+JWhmsYWK7BgcT/4K8e7Q9O+WPv8+wVPmJnMqayd
   2CiTPAnV5k+TOXBKKvU4T9jqFrdIeEZWEX8LNSQ8d/SXcNL9gx/rvEpSo
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,244,1725314400"; 
   d="scan'208";a="191419412"
Received: from 089-101-193071.ntlworld.ie (HELO hadrien) ([89.101.193.71])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 11:08:44 +0100
Date: Wed, 30 Oct 2024 10:08:43 +0000 (GMT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
cc: R Sundar <prosunofficial@gmail.com>, 
    Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
    karol.kolacinski@intel.com, arkadiusz.kubalewski@intel.com, 
    jacob.e.keller@intel.com, kernel test robot <lkp@intel.com>, 
    Julia Lawall <julia.lawall@inria.fr>, Andrew Lunn <andrew+netdev@lunn.ch>, 
    davem@davemloft.net, Eric Dumazet <edumazet@google.com>, 
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
    Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH linux-next] ice: use string choice helpers
In-Reply-To: <ca4f7990-16c4-42ef-b0ae-12e64a100f5e@intel.com>
Message-ID: <498a3d58-55e0-4349-bd92-8ce16c6016@inria.fr>
References: <20241027141907.503946-1-prosunofficial@gmail.com> <ca4f7990-16c4-42ef-b0ae-12e64a100f5e@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 28 Oct 2024, Przemek Kitszel wrote:

> On 10/27/24 15:19, R Sundar wrote:
> > Use string choice helpers for better readability.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Julia Lawall <julia.lawall@inria.fr>
> > Closes: https://lore.kernel.org/r/202410121553.SRNFzc2M-lkp@intel.com/
> > Signed-off-by: R Sundar <prosunofficial@gmail.com>
> > ---
>
> thanks, this indeed covers all "enabled/disabled" cases, so:
> Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>
> for future submissions for Intel Ethernet drivers please use the
> iwl-next (or iwl-net) target trees.
>
> There are also other cases that we could cover ON/OFF etc

I counted the number of occurrences of various cases.  Here are the
results for at least 5 occurrences.  I converted everything to lowercase
and put the two strings in alphabetical order.

julia

" " "\n   ": 5
" (full)" "": 5
" (last)" "": 5
" csc" "": 5
" recoverable" "": 5
"" ".5": 5
"" "1": 5
"" ":" systemlow: 5
"" "\"": 5
"" "_backup": 5
"" "auto-": 5
"" "non": 5
"" "t": 5
"" # x " ": 5
"->" "<-": 5
"070701" "070702": 5
"2.4g" "5g": 5
"2g" dpk->bp[path][kidx].band == 1 ? "5g" : "6g": 5
"80m" dpk->bp[path][kidx].bw == rtw89_channel_width_40 ? "40m" : "20m": 5
"aborted" "completed": 5
"active" "disabled": 5
"anode" "sectors": 5
"assert" "deassert": 5
"attach" "detach": 5
"basic rate" "edr rate": 5
"bulk" "isoc": 5
"client" "server": 5
"closed" "open": 5
"correctable" "uncorrectable": 5
"dedicated" "shared": 5
"fcp" "nvme": 5
"fixed" "roll": 5
"full duplex" "half duplex": 5
"full" "high": 5
"gsi" "smi": 5
"hit" "not hit": 5
"ht20" "ht40": 5
"init" "rt": 5
"ips off" "ips on": 5
"lps off" "lps on": 5
"mc" "uc": 5
"migration" "recovery": 5
"none" "tx": 5
"off!!" "on!!": 5
"pause" "resume": 5
"rf_1t1r" "rf_2t2r": 5
"running" "stopped": 5
"set" "unset": 5
"veb" "vepa": 5
kern_emerg kern_info: 5
" " "\n": 6
" -- kernel too old?" "": 6
" and " "": 6
" flr" "": 6
" iaa" "": 6
" int" "": 6
" pcd" "": 6
" periodic" "": 6
" x4" "": 6
"" ")": 6
"" "*not* ": 6
"" ", ibss": 6
"" ".": 6
"" ":": 6
"" "_flip": 6
"" "amps, ": 6
"" "i": 6
"" "no": 6
"" "pkgpwrl1, ": 6
"" "pkgpwrl2, ": 6
"" "prochot, ": 6
"" "thermstatus, ": 6
"" "vr-therm, ": 6
"(not available)" "(success)": 6
"1" "2": 6
"20m" "40m": 6
"32" "64": 6
"???" "dma write": 6
"active/passive" "passive only": 6
"analog" "digital": 6
"aura" "pool": 6
"beacon" "probe response": 6
"c-vlan" "vlan": 6
"cancelled" "initiated": 6
"capture" "playback": 6
"cc1" "cc2": 6
"decoder" "encoder": 6
"downlink" "uplink": 6
"exmode" "prmode": 6
"found" "lost": 6
"gdt" "ldt": 6
"get" "set": 6
"group" "user": 6
"host" "peripheral": 6
"ipv4" "ipv6": 6
"is" "not": 6
"kill" "on": 6
"ns" "us": 6
"reading" "writing": 6
"recv" "send": 6
" ..." "": 7
" overflow" "": 7
" suspend" "": 7
"" ", nowayout": 7
"" "...": 7
"" "c": 7
"" (#x " "): 7
"" column_sep: 7
"active" "idle": 7
"add" "del": 7
"add" "remove": 7
"autodetected" "insmod option": 7
"capture" "output": 7
"ce" "ue": 7
"dual" "single": 7
"enter" "exit": 7
"fail:" "pass:": 7
"gate" "ungate": 7
"intx" "msi": 7
"private" "shared": 7
"read error" "write error": 7
"read from" "write to": 7
"ro" "rw": 7
kern_debug kern_err: 7
" async" "": 8
" fatal" "": 8
" sof" "": 8
" x16" "": 8
"" "a": 8
"" "b": 8
"10" "100": 8
"40m" "80m": 8
"active" "passive": 8
"bypass" "ram b": 8
"connected" "disconnected": 8
"dcs" "generic": 8
"done" "failed": 8
"dst" "src": 8
"entering" "leaving": 8
"failed" "ok": 8
"failed" "pass": 8
"fast" "slow": 8
"hard" "soft": 8
"invalid" "valid": 8
"kernel" "user": 8
"local" "remote": 8
"primary" "secondary": 8
"ram" "unknown": 8
"restart" "start": 8
"runtime" "system": 8
" err" "": 9
"" "-": 9
"" "/s": 9
"" ": ": 9
"" "[": 9
"" "]": 9
"" "d": 9
"2.4" "5.2": 9
"absent" "present": 9
"fail" "pass": 9
"locked" "unlocked": 9
"offline" "online": 9
"r" "w": 9
"struct" "union": 9
"failed" "success": 53
"" "un": 55
"down" "up": 56
"high" "low": 57
"" "s": 65
"full" "half": 84
"" ",": 86
"not supported" "supported": 91
"" "not ": 96

