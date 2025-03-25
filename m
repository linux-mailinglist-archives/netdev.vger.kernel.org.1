Return-Path: <netdev+bounces-177533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F134FA7079F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49C7188CC29
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0084A203712;
	Tue, 25 Mar 2025 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Re5GVfeq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kz5ha7+9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Re5GVfeq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kz5ha7+9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B19C1A23B0
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922226; cv=none; b=CbaHVkafFAWyobmvwLWoYMvO8k5N20yFGxd4R2wkSbQGTtGLu6COYdYZcD++t80rM7sZUx5XPm+uMlZvVcu97MRkEolG6JxSO1FgjvyhlalFoao7JWANonjpkK1Nrci7H8Qhz7nI8hCbvg5x9iiAG+f70KHAtGafvxKqtrWUZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922226; c=relaxed/simple;
	bh=FCPdtEA0JSGltm1KFbCjo+tdMb6lIv4kebpY7y1nTVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5y40zYwGpiGNUKxUbHm8Pr9fyaPnCz2Fi3VVXdzejdPeJSIpjkWZQxF3HaWMQz9BiVyyFdzaaLolJ7tQ9hrTZGkflx7SoCCuwDWyxvIkCPLpfbt6PrrJ3gaL4/si1PXjziqvNh+no3p0fmyj1Bx95iycTWkKSiK6t7ztzw1qAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Re5GVfeq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kz5ha7+9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Re5GVfeq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kz5ha7+9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5843D21193;
	Tue, 25 Mar 2025 17:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742922222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29IzhLMWO8VGVzCVzm/RftgeQXcZpqE1p77vxL0fTwY=;
	b=Re5GVfeq4S/Ys31KcvyjcnMt1oZLCvsbD/+5FwcTvjPanIvc8+IY5rpCY0xOTEv5ItQMRn
	ipxy2LmAnyoTcCH9anTEt3BWMtuK/W9+hRgAOCgpyRddpUkApto5YkpCbtI69RnvdcTiH0
	hZjR9g9VgwPxxzA+YxeXUZAjAr+vnAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742922222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29IzhLMWO8VGVzCVzm/RftgeQXcZpqE1p77vxL0fTwY=;
	b=Kz5ha7+93blYPKhfWR6lHhsDCtmeDwf2vuVrMdvJbas8ovrNTljbUEsjXqNguAFtqlujly
	WW/DTUcyaRTXJVBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742922222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29IzhLMWO8VGVzCVzm/RftgeQXcZpqE1p77vxL0fTwY=;
	b=Re5GVfeq4S/Ys31KcvyjcnMt1oZLCvsbD/+5FwcTvjPanIvc8+IY5rpCY0xOTEv5ItQMRn
	ipxy2LmAnyoTcCH9anTEt3BWMtuK/W9+hRgAOCgpyRddpUkApto5YkpCbtI69RnvdcTiH0
	hZjR9g9VgwPxxzA+YxeXUZAjAr+vnAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742922222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29IzhLMWO8VGVzCVzm/RftgeQXcZpqE1p77vxL0fTwY=;
	b=Kz5ha7+93blYPKhfWR6lHhsDCtmeDwf2vuVrMdvJbas8ovrNTljbUEsjXqNguAFtqlujly
	WW/DTUcyaRTXJVBA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 44EFF20057; Tue, 25 Mar 2025 18:03:42 +0100 (CET)
Date: Tue, 25 Mar 2025 18:03:42 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Eliyah Havemann <eliyah@insidepacket.com>
Cc: netdev@vger.kernel.org
Subject: Re: ethtool read EEPROM
Message-ID: <b5dflgmqztzjmt42rw3x5ccrdth7qkc2kicr6jtofkkrmyo2cy@utly225o6zn3>
References: <505D824D-406F-453D-AE69-7B8499A8FF0C@insidepacket.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <505D824D-406F-453D-AE69-7B8499A8FF0C@insidepacket.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.984];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue, Mar 25, 2025 at 05:16:52PM +0200, Eliyah Havemann wrote:
> Hi Michael,
> 
> You seem to be the current maintainer and top contributor to the
> ethtool project. First of all: Thank you for your contribution to OSS!
> 
> I ran into an issue with a whitebox switch with 100G and 400G QSFP
> slots, that I was hoping ethtool could solve and I want to ask you for
> assistance. It’s pretty simple: I need to read EEPROM binary data from
> these QSFP transceivers, but they are not associated with any linux
> interface. This is because vpp is controlling them directly. The
> ethtool has a function to output the EEPROM of an interface, but I
> can’t feed it the file back to it to read it. The file it outputs has
> the exact same format of the file the whitebox switch provides. I
> created a small python script to read the file and it gives reasonable
> output, but I don’t have a way to test this against a big collection
> of SFPs and I know that this work was already done in ethtool.
> 
> My questions:
> 1. Do you know of a tool that can read these files that ethtool
> outputs? Maybe it exists, and I just didn’t find it…
> 2. If not, can you provide some guidance on how to add the
> functionality to ethtool to read EEPROMs directly?

If I understand you correctly, your problem is that ethtool can
interpret the content of the module EEPROM but cannot read it for
a module in a smart switch.

In general, devlink should be the tool designed to handle smart switches
and similar devices and their components. I'm not aware if it can also
interpret the module EEPROM content like ethtool does but it's the tool
you should definitely take a look at.

Implementing a feature that would allow to use the ethtool code for
interpreting the module EEPROM content also on a dump read from a file
is something that would probably make sense whether you can use devlink
for your purpose. I'll check what would be the most appropriate way to
do that.

Michal

