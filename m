Return-Path: <netdev+bounces-243965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B80CABA88
	for <lists+netdev@lfdr.de>; Sun, 07 Dec 2025 23:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C077A3005002
	for <lists+netdev@lfdr.de>; Sun,  7 Dec 2025 22:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616D21EB5E3;
	Sun,  7 Dec 2025 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VezopdYz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F782D3EEA
	for <netdev@vger.kernel.org>; Sun,  7 Dec 2025 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765147547; cv=none; b=KrSvzun3lw147LQyRvXNMVi/J7wtD2xzIWypESbGnRI/BumcL4hJmq63G1IJbmE7cLWIeMFD6HRmwCcHu8zGV9sIem3Nj/IdRDFnhlm72MXczNLBIcjwD+49FZhAFKWYxqX9pNzhEKvlT/P4hoWcBFkCkDkqfv5l48mk99vH8hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765147547; c=relaxed/simple;
	bh=OsvqPV078tMZwdnt5ejSkIVUbA2GYD6axkEA2FMUkGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFV4SJg91SgQ+oGcGKccHjwp9Z/eD/vN7NM7QDrZGahDgxNh7rj6sf1H5t6c4b/pGYebw67qfBdIL7Y2DwI9onnV8+DNRLhcOsfbTwe+5dDzvXUWbwzrQkYSFoFENqu+mORi19TInK4lWpRtkXI/qc/x7+HEZW5STVfrFEXXj9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VezopdYz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c0224fd2a92so250571a12.2
        for <netdev@vger.kernel.org>; Sun, 07 Dec 2025 14:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765147544; x=1765752344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfJuq0pWWMw1tReJy2Kq4nA9djFTsZDg14VFkq2GV+M=;
        b=VezopdYzMp8EHLvoGTvPoJE9WjH3H676j3yhTajFPLNMIRTYyg+GgXNrepj95c3V5T
         sSvv0w4ittzJiLrXERIAfVdCXkt2YMDh/FW6T9SqQqP3UJeP8NtcrQBv5gYuXfPMgB6I
         I5t5JEHOIPGF9xSEtWFDyiSl/pOf4LBopx1UIjpE0KyCy7WBC/Cqr40+ltUeWgcz7DC+
         bwNMoHTIHeizjAdjWouitAv85cc/P4ht4KzANYYD5fFLVyaAV9EKaNd5ZbAhbpiYw2U4
         t+SnYlNHgHr66dxX77a/xi1wQhqedxA9FsPhMsD1aru2o8Fcbz+EKT1r27ubrKIYULvx
         XHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765147544; x=1765752344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfJuq0pWWMw1tReJy2Kq4nA9djFTsZDg14VFkq2GV+M=;
        b=CI/hxsRQjgSU0coLqeSPU1sKeOkeNXRxpzaLLxVRG0XcpsV5e/TbpdgeVpesgw5qeN
         eXjFMu5tEV+0TKTMjRxZbGnHp18UW/3XdIJrb3g9a16nGctTVMe22DWFBYY/PKAwrXsS
         1gdMcEReN15fdsFloHcgtlDABHTmxz8N2uMYJGuevWAiDibL41aSnfzLwrxcGufcV4Fh
         5Q4PwY44TNW17KY8EmiTCs/7ZtKKYr2yGOyixzGAc3a2TizOuD6YRxO06tylINBDLzjz
         +gaFYZDWRHihCZUDk83xf1pQWniu3c1ySZXevsXWcCxE3ns0hoOZsYWxtJF1PN5l26Kw
         4HIw==
X-Forwarded-Encrypted: i=1; AJvYcCXspvcfwHAEIqgLyhPLmjxHIqJBrKMu3Xe1R/dexHnd//QsZICLOffnQOhg8jKEGfIFWGrEAqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUuKR4H5Tugi5cnqJZs0pyo/a/6k/x5mgHR8AZHWntrUSQU0p5
	cwHfWEvIMwVjHcTW89e0sInOjjo/SvFdefMI5Qv0AGJuZiVsS8dJb82r
X-Gm-Gg: ASbGnct9cOHpkKBXYljd25+kSOVXXCEIQnQr3s6PqcI1804+/9cGpYJU/BnzM99lmSg
	21lNHrFqye+0/jZq7IL1mx06IuHYBh0obJsj02cypmeP8X7ejnJ2lUulO46woqoREgFl6e7NIb5
	20KOGjFAr6Bml+FC3MqgXiFLk1sHuTCNi1N3AfI8uMCyWDScciRub4kOy8nEcqwX18LAvXawF8D
	aplx2LxZ/3P0ZAfhZg5H/6fXVpbNUm5GsqLNSEl3Ya1OMZhdr5eHTHd7f+p7LfMoSB3QZpu3H0y
	KqHObB+6JjF6hne3hR/ru1k0Eerf6QzkXf6V299VX2lCPtIa6FOCsScaknpW8ncxXZVn3n/g29h
	RTdXJW3V4Kbf9EUxTbpf6zMHWI/SI4wxIvRf2pHw62JLNYgOO0+F8OdDTqk9MDc8P3OqnQAQthz
	bX4UVctj1vnAoa
X-Google-Smtp-Source: AGHT+IFn4BeNP9GMXhA0H4yfE1QdXNgfJCl+9rlLJB6D5L0hoU+Gq2aXJugD7NeH0UGbfdId37/xpg==
X-Received: by 2002:a05:7300:d58d:b0:2a4:6c43:b0c9 with SMTP id 5a478bee46e88-2abc720e99cmr2778852eec.30.1765147544129;
        Sun, 07 Dec 2025 14:45:44 -0800 (PST)
Received: from localhost ([216.9.110.14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba87d7b9dsm42136118eec.4.2025.12.07.14.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 14:45:43 -0800 (PST)
Date: Sun, 7 Dec 2025 14:45:41 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com,
	jiri@resnulli.us
Subject: Re: [PATCH net] net/sched: sch_qfq: Fix NULL deref when deactivating
Message-ID: <aTYDlZ+uJfm7cQAn@pop-os.localdomain>
References: <20251205014855.736723-1-xmei5@asu.edu>
 <4mxbjdgdxufrv7rm7krt4j7nknqlwi6kcilpjg2tbcxzgrxif3@tdobbjya7euj>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4mxbjdgdxufrv7rm7krt4j7nknqlwi6kcilpjg2tbcxzgrxif3@tdobbjya7euj>

On Thu, Dec 04, 2025 at 07:11:12PM -0700, Xiang Mei wrote:
> The PoC and intended crash are attached for your reference:
> 
> PoC:
> ```c

I hate to ask every time, but is it possible to turn this C reproducer
into a selftest? To save your time, use AI?

Maybe I should add a warning in checkpatch.pl to catch net_sched fixes
without selftests. :)

Thanks,
Cong

