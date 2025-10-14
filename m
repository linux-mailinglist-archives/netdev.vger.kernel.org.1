Return-Path: <netdev+bounces-229144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B32E9BD8868
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08DE1923929
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD391305958;
	Tue, 14 Oct 2025 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XDV77NON"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6532ED871
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435111; cv=none; b=mOGWGjO/2B3Fg2u3UkZqEuiefRo0KVhGjUweLvjL2sd/9Wwh+d50MmM+dpDfhdzFedE/ej2rsDOlaoiYBi1rrzf3fn4BcjcVrtu3AnKEvraP/sx5/W4TXlq2NR42kIeDuqfLP46ypRBVbm+lRY3XS57X1zM9kDc1Lp3cb3K/sBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435111; c=relaxed/simple;
	bh=9+jzJmhp4NDYlmVAzrpZPo68lQ6Jij+VLE6Up3JnboA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5dJJTJ8BegW7XflxiVsqrEjYxyq5Y9OghCKUJEPvASKbTkrmo9swlfN+lIkKZF17ClxwSCtZ2U3MYIZYRGW/RoehInQicBtqKnUQK1plSd7a0+GqwLm3iY2Cs/sKD8ArGUPoljGe5pkN71sj+94q4zvX7Ngr2Dnrlf/wBqa+zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XDV77NON; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e5980471eso27629215e9.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 02:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760435108; x=1761039908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R75CvrIgcbILYeZyEie2SvMudL4DW8xIUI8yCH+RsPE=;
        b=XDV77NONhb6aE+xpGklpzVTPYklSS5txSxipRmfV54Mbn08SCU/o8mWQddE3WtE8Sl
         gXJYwCIf9nQCIWLFmIIDwKH5tskqCGjOZnmb8DLrKlYO3BHBVq82H/3l6WdI3dRxkJwh
         TLmut742gMNO3teiW8MPJ/aeDjaZWHLf/93D1stKQ3bHi0p7HwyJ9zLceSnAMqUECGvx
         49IRbGIa9zjSZLaeTNnVd7+uc8eRC7BTqVguORDDmNVXZypPxP0VyiuxjAaIXDP230zk
         Jee9KvOcUqzAFW7wjCAVhS4eLPLEGds2OUIepeCFn+13Br1QwjDsBisnKBG82f8oWLla
         YhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435108; x=1761039908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R75CvrIgcbILYeZyEie2SvMudL4DW8xIUI8yCH+RsPE=;
        b=HXWpt+uUO+E+EwZTp1Qa2qkSSaxQhYjRfTFJzi3v3TuyosT9wpdNeJr9DJCuRAiGkj
         wKZiXAkp4g7oqPZN0hNCvHWpRpMPPsHxseOJ5XGechdVFU5zdc1dbVUHq90OgMJn053d
         aLC7ZQSyWXfn3ItzVyPijlTRecyG6qNgyne2LwpM9riWDM2jS+tq9RZgQyXuAC6Yeibf
         EylhatH2HoGoeCvSYeL12E9Quxk9emZL+T2opXGIcNLzd0YTwihke15tpY1gdE8swXnn
         lOJPYfLEQwDMne833Dq9YlxRgxN77vBUjN+NRq6QDQtPyH3LykNfjv3xqQR3kcT+4T72
         pEvw==
X-Forwarded-Encrypted: i=1; AJvYcCXN5S4PvOwMfwHbVzthqUSbPAvOCCZGqHKdc27+bzGWoj69CyspScZqC2lQtTx+UgVt75Edvk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOzheuXijahhApJxbfQhLyhiYzMGZgiKNwVS3qveWcOC/LJqqq
	ZqhMYuJkHFIcRV9IGq/77w+SwE4C7V3OdgWj0Vzs2ndPxDGHbzo19Ou8+XxQyGjnkt4=
X-Gm-Gg: ASbGncvQjkZUvFsTEkcc381psmcaVxa7lTVG0HfzjDTYOA/C5vif0Mu7hWBCWiifUJj
	TBf9gdKooopOqBQxXj4n3azfzOgD5+JQmsrbK7MCX0/QDOiGFK3f7UMd8o53HOsl4bKh52IQEQ0
	h/K30cNd6RhD9YvSTc/eJKYUy0/FBwYYaNOjacibC9ab8mjIs7TFO/wR46HPWA6LuEcn22mZoKI
	00IOmkTODl9bSQzG3Urtrz3qrxZKQIiz3rcTCRncKBzqWavu3Lw7eOUfwTjxxmG5oCRbYdomUG/
	1g0L79XoA/qdJ3+dnwad+yVJGYWiNP0U1mwC9PxBOhyfuhvyEM0VysV4B7mNNU+/3Ufk1gsaBz/
	zRb7VtnEjlncY+0Npdnr/wohA4YZ8p7UASq12i4zCAGHVdVju3S5gmUsvRoU65RVnosh3tw==
X-Google-Smtp-Source: AGHT+IFLMF/oRlSecQb1AgZUj9ViudEM8BAiQCOLkhiN8cHZAWDwJ7zBbTzbicn8TdmEii38ZLu7Sw==
X-Received: by 2002:a05:600c:890d:b0:46e:32f7:98fc with SMTP id 5b1f17b1804b1-46fa9af3656mr132535685e9.21.1760435107774;
        Tue, 14 Oct 2025 02:45:07 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489ad27sm230711415e9.15.2025.10.14.02.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:45:07 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:45:05 +0200
From: Petr Mladek <pmladek@suse.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: lirongqing <lirongqing@baidu.com>, wireguard@lists.zx2c4.com,
	linux-arm-kernel@lists.infradead.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	linux-doc@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stanislav Fomichev <sdf@fomichev.me>, linux-aspeed@lists.ozlabs.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>, Russell King <linux@armlinux.org.uk>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Joel Granados <joel.granados@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH][v3] hung_task: Panic after fixed number of hung tasks
Message-ID: <aO4boXFaIb0_Wiif@pathway.suse.cz>
References: <20251012115035.2169-1-lirongqing@baidu.com>
 <588c1935-835f-4cab-9679-f31c1e903a9a@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <588c1935-835f-4cab-9679-f31c1e903a9a@linux.dev>

On Tue 2025-10-14 13:23:58, Lance Yang wrote:
> Thanks for the patch!
> 
> I noticed the implementation panics only when N tasks are detected
> within a single scan, because total_hung_task is reset for each
> check_hung_uninterruptible_tasks() run.

Great catch!

Does it make sense?
Is is the intended behavior, please?

> So some suggestions to align the documentation with the code's
> behavior below :)

> On 2025/10/12 19:50, lirongqing wrote:
> > From: Li RongQing <lirongqing@baidu.com>
> > 
> > Currently, when 'hung_task_panic' is enabled, the kernel panics
> > immediately upon detecting the first hung task. However, some hung
> > tasks are transient and the system can recover, while others are
> > persistent and may accumulate progressively.

My understanding is that this patch wanted to do:

   + report even temporary stalls
   + panic only when the stall was much longer and likely persistent

Which might make some sense. But the code does something else.

> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -229,9 +232,11 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
> >   	 */
> >   	sysctl_hung_task_detect_count++;
> > +	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
> >   	trace_sched_process_hang(t);
> > -	if (sysctl_hung_task_panic) {
> > +	if (sysctl_hung_task_panic &&
> > +			(total_hung_task >= sysctl_hung_task_panic)) {
> >   		console_verbose();
> >   		hung_task_show_lock = true;
> >   		hung_task_call_panic = true;

I would expect that this patch added another counter, similar to
sysctl_hung_task_detect_count. It would be incremented only
once per check when a hung task was detected. And it would
be cleared (reset) when no hung task was found.

Best Regards,
Petr

