Return-Path: <netdev+bounces-160945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A679A1C641
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 04:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DF11886C17
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 03:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2F518B495;
	Sun, 26 Jan 2025 03:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6O0ID68"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36072183CD9
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 03:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737863563; cv=none; b=oBk7NJPF9cybn89NtU3WzUAH5IIWpb8HY10tWpX8euaWDzgpRSQVA+kdFNNA08mLaIAwwk77fJPBZH9guIlRBb8Fp8st5ZrI5FYuCTlRchTjSYB4FMUiYbxkLUYyAdWZ8/G8SfpVhYBn9tOL9ar7sUoPDGKB82CTfQDktgVqcIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737863563; c=relaxed/simple;
	bh=GioEQGQIalTI+LP8FC7e3ekhQiYVvNEUvsRiJydq51I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rc2nZmbaumCZ8cVbm5jF8XH9MgchrQHxQIgOGjeTzbKsgSjd5gyXKkHEu07IyvuXko9nO747DuvFLu//5VzU15YzzPAtoGxxCJHjITJomi2Ba6Kqo11BLFQod+Ie+3oBIIn8Xn0LopgJ5QxjB6Uk4yO+bKWZ2fPA78xjpNyqR3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6O0ID68; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so4538172a91.3
        for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 19:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737863561; x=1738468361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jYryyxpgnXaFSNI6mT9wPFW2nkO1fprklQyLGgNOQwI=;
        b=U6O0ID689TUD0E7tGYOpOnsZ/ot/juZUdd3n93TFv320t2Vj0fJ8ggO2BKbHil3CCM
         5WhtBKcDZIyTC0wf+TilzV2dlvMTwmZgh2U6/Wobw44jGvwaAUvdG6dsSYd3stsBCULr
         mvkMknOAn2jaNA0DlpM9HE45aOXN6sgFiR/EFWX1yZv3WJ1x10ZKaHs1U/aBFv8/ISL3
         JXpO5MDj0fvHPPsDJWacoPg5Y4gWagPM+MoBIUg2h1zpyFfpsOkV+hSVdgM1uC98/wB9
         d0OYgdFdYj8UF1bCb5yQIkEglpRSDd6aYhhk78Z2Jp64en4VD0i43E5QCJ8L5PxUoKP+
         lkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737863561; x=1738468361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYryyxpgnXaFSNI6mT9wPFW2nkO1fprklQyLGgNOQwI=;
        b=hFRV+4nKNP3okXK9eDYRZTeFS/XFxIk6fp88xXgKD81pqEWLyT8XQNMi9IpQFzQJP2
         iIbChT7R51SDIGNserB1mbD0dauOLd68cui6dYbjafgUmBVWzvGzthVIIh9LFD/f93RA
         up1zj2io/3U5AbYnvBLKcSs9EpChW9dE+7Gy1btZgZhILu3eBvjQ1TbhJOvMQ/lGY0R/
         szBGPTexLXuIyBwrPjzwwE/RuNix2MOjntytmnOwQsP9VBORtn/sle0WCn8H7nHLRg88
         yuuVVEBOhY3Cb4YbQZYNx/vA0uhFdBD38D2Dc3NXGzQ3x1uT6QhbEoDpbURYmaIsjI1F
         8BEg==
X-Gm-Message-State: AOJu0YwAhlDqP6Y1iYlXXdzln2e+e328XFdItsuY/ZC/uk//4P5FR+Lo
	BNEa8sjc7hlZR7FBvkZP6VfFsl+MRCMjShfnbf1ag2lRvTHQ7JtM
X-Gm-Gg: ASbGnctTTF/76aL/9NxBTDT1dQZXNyRK1gQK3aRl+hl19cJrd9Hz2DgG7S/THA0jgf/
	TkKUPycA5Tko+DrSUq0gnddDceRLMkz54QxjqRrXz5WYxKgXAyJejqZagD6CUtnFiNFglNr4eso
	hPNROVrzBXuPXWHCLSldafpIDh+EJzthVl86jO43vS3DNosw5wtRQi2ibUlcdQ+IUotu9wpKrq1
	IdUgHtsOo7Z45WhAwhbOQcmvAhULM98WygOkN57eEeZCA9Az19EmndDbWshuSiVnd859tPinuCg
	40RuXkVSgYU=
X-Google-Smtp-Source: AGHT+IE/1JiFg4VEpHrzjKWtsJJa2ZFJ7Oh7pn8GHP/MKF94xI8gU77OmHQEglpCJW6HCRddDB2LUg==
X-Received: by 2002:a05:6a00:2e24:b0:728:8c17:127d with SMTP id d2e1a72fcca58-72daf948568mr58093471b3a.8.1737863561263;
        Sat, 25 Jan 2025 19:52:41 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:86c9:5de5:8784:6d0b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6d235bsm4526095b3a.80.2025.01.25.19.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 19:52:40 -0800 (PST)
Date: Sat, 25 Jan 2025 19:52:39 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	quanglex97@gmail.com, mincho@theori.io,
	Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch net 2/4] Add test case to check for pfifo_tail_enqueue()
 behaviour when limit == 0
Message-ID: <Z5Wxh/oUF2meTEBS@pop-os.localdomain>
References: <20250124060740.356527-1-xiyou.wangcong@gmail.com>
 <20250124060740.356527-3-xiyou.wangcong@gmail.com>
 <20250124113743.GA34605@kernel.org>
 <Z5WqCnOiSF72PGws@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5WqCnOiSF72PGws@pop-os.localdomain>

On Sat, Jan 25, 2025 at 07:20:42PM -0800, Cong Wang wrote:
> On Fri, Jan 24, 2025 at 11:37:43AM +0000, Simon Horman wrote:
> > On Thu, Jan 23, 2025 at 10:07:38PM -0800, Cong Wang wrote:
> > > From: Quang Le <quanglex97@gmail.com>
> > > 
> > > When limit == 0, pfifo_tail_enqueue() must drop new packet and
> > > increase dropped packets count of scheduler.
> > > 
> > > Signed-off-by: Quang Le <quanglex97@gmail.com>
> > > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> > 
> > Hi Cong, all,
> > 
> > This test is reporting "not ok" in the Netdev CI.
> > 
> > # not ok 577 d774 - Check pfifo_head_drop qdisc enqueue behaviour when limit == 0
> > # Could not match regex pattern. Verify command output:
> > # qdisc pfifo_head_drop 1: root refcnt 2 limit 0p
> > #  Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
> > #  backlog 0b 0p requeues 0
> 
> Oops... It worked on my side, let me take a look.
> 

I ran it again for multiple times, it still worked for me:

1..16
ok 1 a519 - Add bfifo qdisc with system default parameters on egress
ok 2 585c - Add pfifo qdisc with system default parameters on egress
ok 3 a86e - Add bfifo qdisc with system default parameters on egress with handle of maximum value
ok 4 9ac8 - Add bfifo qdisc on egress with queue size of 3000 bytes
ok 5 f4e6 - Add pfifo qdisc on egress with queue size of 3000 packets
ok 6 b1b1 - Add bfifo qdisc with system default parameters on egress with invalid handle exceeding maximum value
ok 7 8d5e - Add bfifo qdisc on egress with unsupported argument
ok 8 7787 - Add pfifo qdisc on egress with unsupported argument
ok 9 c4b6 - Replace bfifo qdisc on egress with new queue size
ok 10 3df6 - Replace pfifo qdisc on egress with new queue size
ok 11 7a67 - Add bfifo qdisc on egress with queue size in invalid format
ok 12 1298 - Add duplicate bfifo qdisc on egress
ok 13 45a0 - Delete nonexistent bfifo qdisc
ok 14 972b - Add prio qdisc on egress with invalid format for handles
ok 15 4d39 - Delete bfifo qdisc twice
ok 16 d774 - Check pfifo_head_drop qdisc enqueue behaviour when limit == 0

Could you provide a link for me to check?

Just in case, please make sure patch 1/4 is applied before this test,
otherwise packets would not be dropped.

Meanwhile, I do need to update this patch anyway, because it hardcoded
dummy2...

Thanks.

