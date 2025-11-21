Return-Path: <netdev+bounces-240654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9228EC773EB
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 05:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 231734E342C
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 04:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06152F1FCB;
	Fri, 21 Nov 2025 04:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LP6Z/tOI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C2722A7E9
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 04:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763699398; cv=none; b=MUoz1/iQZgrv4oMi1sYsNlp7boX/FS/Ag/cTJOFCNNJw+rVh/Nbcmi7ydXqEO4+jBsCVqs8GxGq4bG7rLRG3CNib1NlcTxhZy9M9bpjRcAHVBcQrjRC0kgqMHaSpH2inYmbOvZTLydRANicLPMedMTJ/vOS//Ax2deFT4ZrYVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763699398; c=relaxed/simple;
	bh=rMGDJKKRnD15c2hQjyolnITvxhyA1MDQFvktLkHIQqI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bw3Gb+JnSLwcyNuUSHj+U0sELbp2rqE5Zyoxqh1R6waRZcHzhs8xb0DJ5WxjxZEYb7dLU3EMDEigBiBL4DiT4c5UWbpLGGfTLjczIwmszVqy+6zvsvhxi/wrpeS+9GqKsJZq1olWdTXkGV1ahSX2LKK4p7OqNNpBUT5M5XRh/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LP6Z/tOI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b8c0c0cdd61so1755081a12.2
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 20:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763699396; x=1764304196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vtU4MakiVqdlEXaNgJAFdiylCJdF9VYLq1aTBv10aHk=;
        b=LP6Z/tOIN2KV5Ll63AN6+0OIdjWRDN03dyIumfcxcupp4FQGDavvgQKdOl9ncLYsV/
         sKQ7b9d1M1bxmvYQNO4lQ38effHVlk1iiU9BVTGzJ8+JQg/u2pHszVk0N8l7FNkQQNn0
         RwlDSzY5M6y3MXtZDnrLZo6nPmQ3H7VfAA75gceIxk3zHmpSuQZj6yvNpCcXzcYAhiE5
         8dsgySQM6Q3jV5BWLdFfNVdXTeml3Z5Glt46CZj1+oY8Ndmh4Znm7JFFFBzD5haYyL5M
         YTeePpcsSkIv6cMvQ0npE1rR2gVaGZfL5E9Fm2+qhqF5/hnEQClKTjaMMuYY5YwHcAEG
         YhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763699396; x=1764304196;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtU4MakiVqdlEXaNgJAFdiylCJdF9VYLq1aTBv10aHk=;
        b=GubXzoHeeF505G+qc0GoT0Pu2Qi7peP4qZgdKezw3varKY7m8bS6RWhq5+uh1diK/q
         Cq4OYlmxlC6R2gAd2O6IpHC3jx8lUssicjcfPt1wgRr53A9Holz7Po7+hh8THisTCYFX
         YmxECykKp+AlpjKVHGFtJaxqn01C12OStNjr8Phdk1NMZ6onDjuzDPtK3jv+gKy3OCpW
         /cQTbM4tNNYzKGWkflIuY9MUGUuFLz0i/YUVQQUg9knm2z11oWQtgUGKUydK79JD9TNc
         4+JZlNlZX5yrOGSX+JC/dHBn8E1NaXgSrxtfijAYMkWZm1vdvg+mIoUiiOCaHe/ZxetS
         giDA==
X-Gm-Message-State: AOJu0Yxe0dG/j+Qsh/GUiPcIg/sM2bYt3NFGKJ0uaYt4W2xlsABrIWAF
	Td+3INCYABWT/sfTuWXIyKcBe49O5kCz1QmcY9e2b1avfHm1bcHY41QJ
X-Gm-Gg: ASbGncu3xlb16ZmEHX39PHrhXwm8vEqEX4Y9EhGwsY36hxu9XrH2gBwkBUZ2ROAP4zT
	5C+6tuiQ/OX2ndLYaVGOuw/TZgPEI4XMrQfLJWabZWMLxGQ5/xPZnYdXPCJLrCVIzzsiiHVd/kK
	VewFf5XqUagusU2lCRHmh0gJt+tFDiIW0F+Yqsgtku0OAiOjBNET6ZupQ1vIIaGQDkoUpkX66mN
	79BbOQc7R+WCBXNzn6Ddbn1Aw9KJf+RoElthMB7cbJqydmiHLfyDTwivLtQrm8m4v+yKQXOSJ/U
	qPS+GSbr9UsoT8iMidJ2RWvrbx2Cu/VZrztyjzEGxqT8NKy/XajtBzNS59eav4ELrgSFP9/bATR
	w0LM715ztX0kS7y2aHPbpuEobV/Ew6odeLiqmrtisiBD6PWZVX3e6tP0xFsOLLJSJhsHVXgnBSO
	JUjOrOiTyQpvh9/tDa+Q==
X-Google-Smtp-Source: AGHT+IGmyuNLKEamqWHcF4HSshJr2ATuggxT1r5ZYPvo1qTtYJLphlQHuPyPVnGmbMQ8aU+uSgDYxQ==
X-Received: by 2002:a05:7022:ef13:b0:11b:1c7e:27d0 with SMTP id a92af1059eb24-11c9d548662mr517418c88.0.1763699396102;
        Thu, 20 Nov 2025 20:29:56 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:d6b4:b371:6dd8:4ab3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93db4a23sm19053149c88.2.2025.11.20.20.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 20:29:55 -0800 (PST)
Date: Thu, 20 Nov 2025 20:29:54 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, will@willsroot.io, jschung2@proton.me,
	savy@syst3mfailure.io
Subject: Re: Fw: [Bug 220774] New: netem is broken in 6.18
Message-ID: <aR/qwlyEWm/pFAfM@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110123807.07ff5d89@phoenix>

Hi Will, Jamal and Jakub,

I already warned you many times before you applied it. Now we have users
complaining, please let me know if you still respect users.

Also, Jamal, if I remember correctly, you said you will work on a long
term solution, now after 4 months, please let us know what your plan is.

Regards,
Cong


On Mon, Nov 10, 2025 at 12:38:07PM -0800, Stephen Hemminger wrote:
> Regression caused by:
> 
> commit ec8e0e3d7adef940cdf9475e2352c0680189d14e
> Author: William Liu <will@willsroot.io>
> Date:   Tue Jul 8 16:43:26 2025 +0000
> 
>     net/sched: Restrict conditions for adding duplicating netems to qdisc tree
>     
>     netem_enqueue's duplication prevention logic breaks when a netem
>     resides in a qdisc tree with other netems - this can lead to a
>     soft lockup and OOM loop in netem_dequeue, as seen in [1].
>     Ensure that a duplicating netem cannot exist in a tree with other
>     netems.
>     
>     Previous approaches suggested in discussions in chronological order:
>     
>     1) Track duplication status or ttl in the sk_buff struct. Considered
>     too specific a use case to extend such a struct, though this would
>     be a resilient fix and address other previous and potential future
>     DOS bugs like the one described in loopy fun [2].
>     
>     2) Restrict netem_enqueue recursion depth like in act_mirred with a
>     per cpu variable. However, netem_dequeue can call enqueue on its
>     child, and the depth restriction could be bypassed if the child is a
>     netem.
>     
>     3) Use the same approach as in 2, but add metadata in netem_skb_cb
>     to handle the netem_dequeue case and track a packet's involvement
>     in duplication. This is an overly complex approach, and Jamal
>     notes that the skb cb can be overwritten to circumvent this
>     safeguard.
>     
>     4) Prevent the addition of a netem to a qdisc tree if its ancestral
>     path contains a netem. However, filters and actions can cause a
>     packet to change paths when re-enqueued to the root from netem
>     duplication, leading us to the current solution: prevent a
>     duplicating netem from inhabiting the same tree as other netems.
>     
>     [1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io/
>     [2] https://lwn.net/Articles/719297/
>     
>     Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
>     Reported-by: William Liu <will@willsroot.io>
>     Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
>     Signed-off-by: William Liu <will@willsroot.io>
>     Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
>     Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
>     Link: https://patch.msgid.link/20250708164141.875402-1-will@willsroot.io
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> 
> Begin forwarded message:
> 
> Date: Mon, 10 Nov 2025 19:13:57 +0000
> From: bugzilla-daemon@kernel.org
> To: stephen@networkplumber.org
> Subject: [Bug 220774] New: netem is broken in 6.18
> 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=220774
> 
>             Bug ID: 220774
>            Summary: netem is broken in 6.18
>            Product: Networking
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: high
>           Priority: P3
>          Component: Other
>           Assignee: stephen@networkplumber.org
>           Reporter: jschung2@proton.me
>         Regression: No
> 
> [jschung@localhost ~]$ cat test.sh 
> #!/bin/bash
> 
> DEV="eth0"
> NUM_QUEUES=32
> DUPLICATE_PERCENT="5%"
> 
> tc qdisc del dev $DEV root > /dev/null 2>&1
> tc qdisc add dev $DEV root handle 1: mq
> 
> for i in $(seq 1 $NUM_QUEUES); do
>     HANDLE_ID=$((i * 10))
>     PARENT_ID="1:$i"
>     tc qdisc add dev $DEV parent $PARENT_ID handle ${HANDLE_ID}: netem
> duplicate $DUPLICATE_PERCENT
> done
> 
> [jschung@localhost ~]$ sudo ./test.sh 
> [  2976.073299] netem: change failed
> Error: netem: cannot mix duplicating netems with other netems in tree.
> 
> [jschung@localhost ~]$ uname -r
> 6.18.0-rc4
> 
> -- 
> You may reply to this email to add a comment.
> 
> You are receiving this mail because:
> You are the assignee for the bug.

