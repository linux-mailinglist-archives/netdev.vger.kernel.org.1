Return-Path: <netdev+bounces-243540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8DFCA34C4
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 11:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B72A931342ED
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 10:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7603336EF6;
	Thu,  4 Dec 2025 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E9ncN5L6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE473321DC
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764845185; cv=none; b=JE8a7MawIVMCuc4cJfzj7ZdIJ0RByNpUYBstHe1DSKk8Ib8KedtortSsLOLmjNl95VKVwxk+9PXKmdSIRb+FHX2sQ+8hbt4N1DUFuVL8bz3WAn0tv0h8zdHnh9BP/mJFQVSxUItQDfJCB2d73oNnyjyoEPWomgSh6AY4lwJRcGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764845185; c=relaxed/simple;
	bh=FrbGLv+F0gzsFKrnZ3OWHoRncChf1UxHba8noKPDClE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNSNd9JUvFar1sBtpqI4j0UtEH1SE6NOcRkwYEMy5wl3vsPhpru1kMPeqEp8FB0epF/5e66wA813/i8/ZCdK2GAfVYcmoUdjKPoviwdwH8RjeWRYADlQ8Hd7SNa3x6Ll1PdGw38LdzPVSsFZY/Gqn8UVrvpqiH+6A/tQOsohYvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E9ncN5L6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42e2e6aa22fso379516f8f.2
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 02:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764845182; x=1765449982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I25txm5sVJExHNkl83s3lOJ0pwVYA1Itpf3THdriA+I=;
        b=E9ncN5L6Y6P9bkyoeGwqP7NHYghUwSy7tLeLMzOK/3WmAJYMAp2L5ORUa0v1/05htI
         9/eML7QzVbh7zjgAHSO52VHcd3yRcl7d70fGUYxPGyDS7cm2pmMqbSC/h3IFa0ej6fOa
         U3z6Sk30ybDjSgQ8HHIgwksAJourwglXKUSJE/OjNyLC50fbvCjtQse7Ju6gaM5KCo/E
         KXpxR3zd5lKsvek7AgS1nFYgsPPp1PgeH2ZU/3DaFXx/uQD63UW8BwYa3h4iG2fbQ7AL
         +bHKSt1jDhE/S2t84+A7fOgipoFBYqSDb/SH062OZX+WTziyYMrK94/fLLXWDPwK8MeC
         rMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764845182; x=1765449982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I25txm5sVJExHNkl83s3lOJ0pwVYA1Itpf3THdriA+I=;
        b=uoot6Bevn3tU4ycGVJkJdow6kqR/rxjjvHHGnd20rpqqrLcKf12yqcCdvg5Ti7s9BM
         n42I74e2JDdSz5Lnp/hLb7PRITmIHfnEfVlzg6cW3EfrI+OD0fARI4Mqvr+NTP9o6JIL
         QZIRAjifq2nO/jNQCNIE1Tj4yWUNWmjsibEN55PlD/0RrVJ35xMKAlII5dXYhPOySVeJ
         TtgfFI7S/qd6ix2y0tnNT1by66i367tZMBSlakDo9VVK53i8BTfTnj2WoRVaeUVdye3i
         0n5ARvlg9aH71Nn19oOnbRRUFgub1vt4UqY7QsXm7HlFjTcYh8GwGM+eExRdpBIvQs9D
         ENNA==
X-Forwarded-Encrypted: i=1; AJvYcCWqmks29HkEkRpnW47NesMMItF7xvK2POHvz5ce37aNmvqUe5RQIv2EQhKl6FrhtlF2S2nfi7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkZTGufVX1OW9sF6O9EZ0aWush/We47bLIzuB8DTE/t6RvAF+f
	LoSIoyt5Q4+G6f/aSfwic2FwOjLYn5Yg1Y3YS3RPLbvbslNtnYiHNTUeOZlN/b1ae0o=
X-Gm-Gg: ASbGncvTcKbTgIz/fWCkmiRaHafZASF8Oo8AhyeQZhEvBCCDRLBeN+qicTTZdHq6zS1
	QNG3a5VhwGGuKmLMTML8lF5BxIQUdAfy8EOLX5r+ElOJHrAf6y5GNJ8aWjm7In4vdHGAWo2LE9x
	dr5VsE1QtKoVLQjdsFKBNVTquggDhItTh39kB1GAVk0oDaI6mMUjvWEvvS/cUbENLg4GcYbMOro
	m4m//8adD4GtzJbDiEKEHtetwzatNDW15GylL9Dx8y+ToXibfvurmOrL7AA4Y6yQ4hJAHwpLbuq
	akwI4uDPDvTHETtUU659bPkfQjrf18wxfiDdpzu3CL1weGMAnZ6X5j9DgpUzTooMGeYXymN4V/r
	Uh6ED/lBT+Ajbh2yKXCB1Aic+2gCWqglRBnWW7FBljBaxYW5uYzFgDL+PUxDC6/9QDDiFxzhaT8
	lvRdaQLePn+fWo0LSrxFyzWhmN
X-Google-Smtp-Source: AGHT+IHsO7lvt5Ss20b5pix2R/jr/E2Ef5Zq97My82ARiw2BH/h2CLSdatJZT3/30ySC6bVyoLOZHA==
X-Received: by 2002:a05:6000:144c:b0:42b:3bc4:16dc with SMTP id ffacd0b85a97d-42f7980cc8dmr2648512f8f.21.1764845181638;
        Thu, 04 Dec 2025 02:46:21 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee50sm2565501f8f.14.2025.12.04.02.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 02:46:21 -0800 (PST)
Date: Thu, 4 Dec 2025 11:46:19 +0100
From: Petr Mladek <pmladek@suse.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, gustavold@gmail.com, asantostc@gmail.com,
	calvin@wbinvd.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 0/4] (no cover subject)
Message-ID: <aTFmew5trILX3RpO@pathway.suse.cz>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
 <20251201163622.4e50bf53@kernel.org>
 <4oybtunobxtemenpg2lg7jv4cyl3xoaxrjlqivbhs6zo72hxpu@fqp6estf5mpc>
 <20251202102442.568f91a7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202102442.568f91a7@kernel.org>

On Tue 2025-12-02 10:24:42, Jakub Kicinski wrote:
> On Tue, 2 Dec 2025 02:18:44 -0800 Breno Leitao wrote:
> > On Mon, Dec 01, 2025 at 04:36:22PM -0800, Jakub Kicinski wrote:
> > > On Fri, 28 Nov 2025 06:20:45 -0800 Breno Leitao wrote:  
> > > > This patch series introduces a new configfs attribute that enables sending
> > > > messages directly through netconsole without going through the kernel's logging
> > > > infrastructure.
> > > > 
> > > > This feature allows users to send custom messages, alerts, or status updates
> > > > directly to netconsole receivers by writing to
> > > > /sys/kernel/config/netconsole/<target>/send_msg, without poluting kernel
> > > > buffers, and sending msgs to the serial, which could be slow.
> > > > 
> > > > At Meta this is currently used in two cases right now (through printk by
> > > > now):
> > > > 
> > > >   a) When a new workload enters or leave the machine.
> > > >   b) From time to time, as a "ping" to make sure the netconsole/machine
> > > >   is alive.
> > > > 
> > > > The implementation reuses the existing message transmission functions
> > > > (send_msg_udp() and send_ext_msg_udp()) to handle both basic and extended
> > > > message formats.
> > > > 
> > This feature (in this patchset) is just one step ahead, giving some more
> > power to netconsole, where extra information could be sent beyond what
> > is in dmesg.
> 
> Having extra metadata makes sense, since the interpretation happens in
> a different environment. But here we're talking about having extra
> messages, not extra metadata.
> 
> > > The 2nd point is trivial, the first one is what really gives me pause.
> > > Why do we not care about the logs on host? If the serial is very slow
> > > presumably it impacts a lot of things, certainly boot speed, so...  
> > 
> > This is spot-on - slow serial definitely impacts things like boot speed.
> > 
> > See my constant complains here, about slow boot
> > 
> > 	https://lore.kernel.org/all/aGVn%2FSnOvwWewkOW@gmail.com/
> > 
> > And the something similar in reboot/kexec path:
> > 
> > 	https://lore.kernel.org/all/sqwajvt7utnt463tzxgwu2yctyn5m6bjwrslsnupfexeml6hkd@v6sqmpbu3vvu/
> > 
> > > perhaps it should be configured to only log messages at a high level?  
> > 
> > Chris is actually working on per-console log levels to solve exactly
> > this problem, so we could filter serial console messages while keeping
> > everything in other consoles (aka netconsole):
> > 
> > 	https://lore.kernel.org/all/cover.1764272407.git.chris@chrisdown.name/
> 
> Excellent! Unless I'm missing more context Chris does seem to be
> attacking the problem at a more suitable layer.

This would help to bypass slow serial consoles. But the extra messages
would still get stored into the kernel ring buffer and passed back
to user space logs, for example journalctl.

I do not have strong opinion whether adding the
/sys/kernel/config/netconsole/<target>/send_msg is a good idea or not.


