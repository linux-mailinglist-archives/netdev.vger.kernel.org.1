Return-Path: <netdev+bounces-267467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC8CN20ctGlLhQAAu9opvQ
	(envelope-from <netdev+bounces-267467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:17:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95007284C0E
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C77CB30C82AE
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040DA3976AA;
	Fri, 13 Mar 2026 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="ObfNwz7s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD5937F74F
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410569; cv=pass; b=m4kq1UinJYXEuT2QDmZ2GRrzEP9sVf0EfC7iqkh5aAUypkUVhv1aVKKqSxA3x7Y3Nw0yRL7/NGFGMbt/gfyf9HW1YRLhJSVs6l5ak5YqinXZNEAtxpK+Y/7tEU7BMxMk8onpqjwApSxgd0hPv2+PcLFhPg4xiOw2Y27pk+UvJ4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410569; c=relaxed/simple;
	bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvu0iloogBvGKQK5ukK33oetUATI0GOKtjABcLj1hEo1iQbWPIVW7AV8Si1x7kKgnilVOnee13wCPxjhr7VlUcdERgYDRta+wivVN71RLNxaFmn9oPv5HyjpFImGBV2GfDVtRTC2tfO6ajMXipnnK/IOjigYkc/yyBy+1TWPyfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=ObfNwz7s; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ca423ad53so2382372d50.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773410565; cv=none;
        d=google.com; s=arc-20240605;
        b=MmdHgI8tdmBKWY9RPSnayEoQTAPuy6shnlAkPyGIU9pWE1lFFcCF0WAh26fSNDCekT
         j3X+9fsj4uiV7q5NWxdA/m0XBjCm7/QtCi0S/gY8K6L0ejafYpTXAMMUN34cAtahKCSm
         NOGKKUoyJ4SgzLa4zlXVfg7gMialOSSxzCB/SjhYQPg9a/NRN5CymQxRVEarfThAIkUV
         aPJzGsBGAMaZCQUbfOe4G0Ed5CxvHJHSZS8Z+wEK7ey2THjzVDLp99r4Z6qOaEzpKKJ9
         noZ2Glyo/qnk46vh8fzBkU8tXUK/uAdHjDSRxuv7abOMi57dTo0vcJlGd4so+WUMqHbQ
         fnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
        fh=7l2J/UICT+uPgtAuNrgKlwQM40n+YWwaLKQSIUqCZDY=;
        b=Znritkx4qDGCPl/6wjaFWgk+75N+d3vifFNl99euhukyd/HeOeADvgM4oAyPC5yVBl
         xLd8SzV9YifmT4ZjfWC0YWlYq4l5lgkp0T5wl/3RfjSoHMNqDcz0PuuO2ahzkxiO8xQn
         kpYeikfJ+CnUcYcFDRwQ6PC3eLIAjsSF7dPCeQGLybiUMgFkhQK0QzN3V2/ibFU1gTeK
         nN0OFNeGmoEH+krDCc774RHZdqvbVU8xKmfTyEMe5I/s1dgUYv8DiO5W1gcsHUx10kMY
         PfOs/TdxAOfKMXmgYgubBujQ7k9+juxnnEF0vl016NKAIkPcQIJx+LLHZPQ1ObwV9TZp
         LrBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773410565; x=1774015365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
        b=ObfNwz7sVmzZBuIGYYUHNiLCrYOnrj8c6jSXCTXbQttafWQ6iigv2iFCUWBaoiYoUP
         65QJafHt+sCKkuHWwkmPoCcyygdqmYnJqwQvkPOoFp//2xTrPOAnMOEt6QHOb6B2JvqT
         uUidn8yG11+xxULj+cUGv2RAFi7xkRZfAAMzfTE8wLSqLl+bB0W1/CQna7kgFTcQ079U
         jdJDbGknVFFIGRjt+9Ia/rAPUbdCEaVBzQY/lQOSzveUUMV9JbrJZ9dM14sssdL0Veoz
         2HvOhbyl3fwXxpTdX3XOVWdJQawUfi41VBhM025fBbFm4jHJUnRUxEJqrBTBuYU1u6Rq
         p7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773410565; x=1774015365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a7/dI9iHAkAoxpT/Y/jlrZ1Uk/u+tnKK+1+hPiLUJTk=;
        b=cBk54lao9BgF8VR95s7rekbJDDF4/lA6dq1WZ6FhwquraGfrdw+lKdInkzkWqAfU58
         nrpE9ubgksqvDKH2QgIrw6Nhnk2SLJO9Zx1ESECFdGgpJ1QhFqexNv85YZDYhpUh972q
         re4lnkrm8QnXyO8keBf/g8/nUijtLTxl+Cbz5fQOW4VhHK0Ea1KDu+96QVyHfB+srWRq
         arHek+0Vq5izLYy9OSr4HzUKcnTN1H4hn/YIK/ip0lr2J8lhO1sEbYxNfqI41NNj9iyb
         0xde2agK7HExTZZ4RFUp0DUbteAyBqreXgWr3xNAAvMdEclE7feLZH1Kr7YHuoUYNkvz
         DsiA==
X-Forwarded-Encrypted: i=1; AJvYcCU+eRVQSr/R7LBkdalsJcIUN6KLFsZghL2D7/uZhtMj1/vdchQs0qJGG02OSJIgHwfPUTWZN8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM0DsClz/pQoVXXNXmj6b3K79P8YPiUsC0m9M2UUSfXsLBz1f3
	5agJoZrwkphQrONmKGZzpQSa5LF4POrazB5f0xkpcRgiJgvDVt8PFTxsyrJFyMKiCqNLPD2UjQQ
	hZ/0X3o7GiYvwStWJqWA9CYSpd9LExLY/6msh5HigKg==
X-Gm-Gg: ATEYQzyws1NtS4trg1xE3ty6qGp3wHjPm8BfAtBdnk1zC25LOYlr4aE1TA2DrLcrsJK
	6IHZh8U3vB9NzO9LZSAxv9h0i/LsRimh+476246B9ZFe/eIFsb67Kultye2q+omUF4wyFIfVc9z
	6tzUoekzjEbqsDT2oZjqXHjaqOiZYHlr8N68YG4aynYWkDNVn6rd/VVG889ZXujGWtNOe8ToCKv
	jC6Yria3/YTRi8dJpMc+K0Da4TmYsWzCx7jMZkOZ/hJ+oRKenWRS2iVnSrFwx+RZ4wubLxFAsqa
	xRerLTE=
X-Received: by 2002:a53:eccf:0:b0:64d:568b:bcb3 with SMTP id
 956f58d0204a3-64e62eeb40fmr2691449d50.9.1773410564388; Fri, 13 Mar 2026
 07:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <1e3c2830-765e-4271-89f7-0b6784b37597@efficios.com> <20260312112354.3dd99e36@gandalf.local.home>
 <219d015d-076b-4c80-8f63-88569115fdad@efficios.com> <20260312114041.5193c729@gandalf.local.home>
 <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com> <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
 <CAEf4BzbnfyhCqp0ne=2gRnVxp-mdGmuZwDeFRyhRYH+eDcz2-w@mail.gmail.com> <20260312130255.6476e560@gandalf.local.home>
In-Reply-To: <20260312130255.6476e560@gandalf.local.home>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Fri, 13 Mar 2026 10:02:32 -0400
X-Gm-Features: AaiRm51K5Hc3O7_rOVK2jMiMzft9bvuP5pyZ-VF_j7db91GKvyylhuGDp34sRoA
Message-ID: <CAO7JXPgHYZ9zF1HFahb2447X85YRZCQQBHB6ihOwKSDtiZi8kQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] tracepoint: Avoid double static_branch evaluation
 at guarded call sites
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Dmitry Ilvokhin <d@ilvokhin.com>, Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	dev@openvswitch.org, Oded Gabbay <ogabbay@kernel.org>, Koby Elbaz <koby.elbaz@intel.com>, 
	dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org, 
	Eddie James <eajames@linux.ibm.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	amd-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[bitbyteword.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267467-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[bitbyteword.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,efficios.com,infradead.org,ilvokhin.com,kernel.org,redhat.com,kernel.dk,vger.kernel.org,davemloft.net,google.com,iogearbox.net,ovn.org,lists.sourceforge.net,openvswitch.org,intel.com,lists.freedesktop.org,linaro.org,amd.com,linux.intel.com,samsung.com,lists.linaro.org,linux.ibm.com,codeconstruct.com.au,jms.id.au,lists.ozlabs.org,ffwll.ch,sang-engineering.com,analog.com,hansenpartnership.com,oracle.com,fb.com,suse.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vineeth@bitbyteword.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bitbyteword.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bitbyteword.org:dkim,goodmis.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 95007284C0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 1:03=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 12 Mar 2026 09:54:29 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > > > emit_trace_foo()
> > > > __trace_foo()
> >
> > this seems like the best approach, IMO. double-underscored variants
> > are usually used for some specialized/internal version of a function
> > when we know that some conditions are correct (e.g., lock is already
> > taken, or something like that). Which fits here: trace_xxx() will
> > check if tracepoint is enabled, while __trace_xxx() will not check and
> > just invoke the tracepoint? It's short, it's distinct, and it says "I
> > know what I am doing".
>
> Honestly, I consider double underscore as internal only and not something
> anyone but the subsystem maintainers use.
>
> This, is a normal function where it's just saying: If you have it already
> enabled, then you can use this. Thus, I don't think it qualifies as a "yo=
u
> know what you are doing".
>
> Perhaps: call_trace_foo() ?
>
call_trace_foo has one collision with the tracepoint
sched_update_nr_running and a function
call_trace_sched_update_nr_running. I had considered this and later
moved to trace_invoke_foo() because of the collision. But I can rename
call_trace_sched_update_nr_running to something else if call_trace_foo
is the general consensus.

Thanks,
Vineeth

