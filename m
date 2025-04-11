Return-Path: <netdev+bounces-181650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74450A85F9D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D399E16CDB0
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 13:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8759E146585;
	Fri, 11 Apr 2025 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ij6oCShN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o9e3NWu4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ij6oCShN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o9e3NWu4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F671953A1
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379238; cv=none; b=qfZvZKe/bZ0E0ZiV2Wxq+LDiWRfD7h+rNrIu6wA9Zgt3T6M5FFKjEaq6CLrtd95KFqVLSqUDV+R/oY7FzWGIarSa2Qkdtpdc+4Bx1Rv9UDWBZSjwFSdHQCCfKcL6RZ2ariZjx6WNVHKzoVcYjecVh9Ivm/I6TTkIdq4uHoASt1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379238; c=relaxed/simple;
	bh=+ypVCUiQD2We9YpUjl3X7axRAhcD8QCXyTXiFAWLxz8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P9ZBRyyq1k/wwQkq2W4HFD7GxygS5S6knuu7HPy7mL1L3BLNR+2KZ6c6HSRrh8v7jcZo5jmU37NozGE9fAS4bSTwn7G4MogHuLbzS+C1SxyXNNgXw9QdydIh2zMlevyKrFvFYKLH5Os88h9Rpz4MjRci24/tQgUGCXvnxUgfOa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ij6oCShN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o9e3NWu4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ij6oCShN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o9e3NWu4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C587D2111F;
	Fri, 11 Apr 2025 13:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744379234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Acztb1UlGldLXASplomZF5L+DZPjJmKPoqAI3ISbuJg=;
	b=ij6oCShNh7a2A4ekS5vjSgvy2YXo74b9t2hXcO4LgZhAwCKyuoHoXznfHGGJGem+TWdjKp
	oVsDCheVKqExxjFgG6mCHcmrcyYlCCcP+9W4f5FEk8VceP8o8EVhXKQcsfVVaATZO4dMfk
	/z3qJaAW4am0hVvxWkvBuMN0J0UXg/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744379234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Acztb1UlGldLXASplomZF5L+DZPjJmKPoqAI3ISbuJg=;
	b=o9e3NWu4GRaI2F6mP2KhXj3O5uuxp6k0Uh6c40xoq+2164C8TmcFkimGOqS9zDEdIADnsK
	3VxhQtqpOPs0ehBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744379234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Acztb1UlGldLXASplomZF5L+DZPjJmKPoqAI3ISbuJg=;
	b=ij6oCShNh7a2A4ekS5vjSgvy2YXo74b9t2hXcO4LgZhAwCKyuoHoXznfHGGJGem+TWdjKp
	oVsDCheVKqExxjFgG6mCHcmrcyYlCCcP+9W4f5FEk8VceP8o8EVhXKQcsfVVaATZO4dMfk
	/z3qJaAW4am0hVvxWkvBuMN0J0UXg/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744379234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Acztb1UlGldLXASplomZF5L+DZPjJmKPoqAI3ISbuJg=;
	b=o9e3NWu4GRaI2F6mP2KhXj3O5uuxp6k0Uh6c40xoq+2164C8TmcFkimGOqS9zDEdIADnsK
	3VxhQtqpOPs0ehBQ==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id B33FC2005E; Fri, 11 Apr 2025 15:47:14 +0200 (CEST)
Date: Fri, 11 Apr 2025 15:47:14 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Petter Reinholdtsen <pere@debian.org>
Cc: netdev@vger.kernel.org, AsciiWolf <mail@asciiwolf.com>, 
	Robert Scheck <fedora@robert-scheck.de>
Subject: [mail@asciiwolf.com: Re: ethtool: Incorrect component type in
 AppStream metainfo causes issues and possible breakages]
Message-ID: <p3e5khlw5gcofvjnx7whj7y64bwmjy2t7ogu3xnbhlzw7scbl4@3rceiook7pwu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Flag: NO
X-Spam-Level: 

Hello,

I got this report (and one more where you are already in Cc) but I'm not
familiar with the AppStream stuff at all. Can you take a look, please?

Michal

> Date: Fri, 11 Apr 2025 15:16:28 +0200
> From: AsciiWolf <mail@asciiwolf.com>
> To: Michal Kubecek <mkubecek@suse.cz>
> Subject: Re: ethtool: Incorrect component type in AppStream metainfo causes
>  issues and possible breakages
> 
> This probably also needs to be fixed:
> 
> https://freedesktop.org/software/appstream/docs/
> sect-Metadata-ConsoleApplication.html#tag-consoleapp-provides
> 
> Regards,
> Daniel
> 
> pá 11. 4. 2025 v 15:06 odesílatel AsciiWolf <mail@asciiwolf.com> napsal:
> 
>     Hello Michal,
> 
>     ethtool is user uninstallable via GUI (such as GNOME Software or KDE
>     Discover) since 6.14. This is not correct since it is a (in many
>     configurations pre-installed) system tool, not user app, and uninstalling
>     it can also uninstall other critical system packages.
> 
>     The main problem is the "desktop" component type in AppStream metadata:
> 
>     $ head org.kernel.software.network.ethtool.metainfo.xml
>     <?xml version="1.0" encoding="UTF-8"?>
>     <component type="desktop">
>       <id>org.kernel.software.network.ethtool</id>
>       <metadata_license>MIT</metadata_license>
>       <name>ethtool</name>
>       <summary>display or change Ethernet device settings</summary>
>       <description>
>         <p>ethtool can be used to query and change settings such as speed,
>         auto- negotiation and checksum offload on many network devices,
>         especially Ethernet devices.</p>
> 
>     The correct component type should be "console-application".[1]
> 
>     Alternative solution would be removing the whole metainfo file.
> 
>     Please see our (Fedora) downstream ticket for more information:
>     https://bugzilla.redhat.com/show_bug.cgi?id=2359069
> 
>     Regards,
>     Daniel Rusek
> 
>     [1] https://freedesktop.org/software/appstream/docs/
>     sect-Metadata-ConsoleApplication.html or https://freedesktop.org/software/
>     appstream/docs/chap-Metadata.html#sect-Metadata-GenericComponent

