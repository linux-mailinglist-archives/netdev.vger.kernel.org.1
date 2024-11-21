Return-Path: <netdev+bounces-146715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9899F9D540E
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 21:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E092839AE
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 20:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE151BDAB5;
	Thu, 21 Nov 2024 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="fvHIk3uB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CAD6F06B
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221722; cv=none; b=Ni5WyfqK5VOebtH155IDSMw3fTDx7urYZyCggXZIi9AHz95FkeX0ZJ8ZdO6456ko71AwKpjZ31lNL3vxEepN/orGkPw5TmjwzkT0FaS2zB3dLYVsrMrTdwN1nxjsq5yqqvyKhDXHfjcQoPP0++VKjDTSd+NFCU7YgAR+KPlwT78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221722; c=relaxed/simple;
	bh=XlI0OnDiOaizTVszUbqjoZIwEHh+ixVlyL2Qmqv+wIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVrVuLzTcCuNT+F+RUCV0d0aSp9mnLx2oIhQ9pwr22iNfVHXnltsXBLsjWQea9sV4dUecfkVahbF65gu+ARHJn1PTHcwatstBTtatTHtP8eFTF7OMJFjjHaUJ6P53RiNb3/fYe9L0QkaL6reKKNwD7eJkgnMyTkrNnTQ6z7Wu0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=fvHIk3uB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21263dbbbc4so14719105ad.1
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 12:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1732221720; x=1732826520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCGLz5RIixMPPxOnrXMRWzOBk99mSBEEcRo3aLAlBrM=;
        b=fvHIk3uB3S44jYczrG/6FdANmWbXFac3J2hKnDanpG26UD2ExBDE4R3x838ZasJ0w3
         5SP7j2PZHf04Cb92eLLUG++IYXzEkL05L2ciRW9MkVKHYmca3J6XoMdurw6MmG6RjTbK
         J0Z6pjUPM7gXtj96//u4iShoGAmFpbJB7hzT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732221720; x=1732826520;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCGLz5RIixMPPxOnrXMRWzOBk99mSBEEcRo3aLAlBrM=;
        b=HUOZK6koJ0Sd2DQ9PdVr4J9wo1zJwhfxRVYfOlaMf6RJeKfngc8xexiKcMEb0xedOK
         Vwwsn3zEHBAU05j8yaTZ6uu254HTvtRnVfW8ywVKsFQyBi0qVqyNli0h3PO7gAuBL6X/
         C/lQI/9YScZ98AobYHz0eEQbCd61CKXXQPylveFuj7Smq0faV6QV2iJu1GTnTqJ0coeO
         wc49riGnhbkCd64tKZsgqUdVfDu8Rth2pQO3AJpBO0nQUFeUpTpH/C3hvWIfs+pamjaF
         FPYD04wURfhBkUKiMGpa1lSZnkqnoUWjaxK4vyKKGo1B7CFSt1mRD+pcONzAf8u+GjoW
         mFXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD0KA/PGx1zhGMzGHR4xLUPy+zvFWso8uHwQnEXz0wQpA3+IO/7roBb9mGtWYh0mtYhMCO5dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtCe759htUTQDqoMLk5eg5CUxKVU5Ms0PMbMUn4iA0CRFXH+D6
	4DFZ1UH87JbqYLR37Jf36SeyDtYR+/C16OY47Yi3vtjdb/p9Wei/JDCBNEoHhtA=
X-Gm-Gg: ASbGncu93d6fXRL6j+mFHUW7UTuz4E78Cqbc2DmJyZqnzOtmG2DStSx/0JjHUPhBpkj
	xOv4BWoA5K5D7yDDlHafe2CbdaGuLwFBcc7LzQCfjTD75qjyvKI1bkr009nwQghSagJqBMHpgCA
	0+BLK5QNxkZtrOUD2UHfA9W1PNbzYUF1DWLc1PoH+pUKHGREP51SrCVE58ZQVrM5lI7kdKqApLJ
	9Bl2lMXyHa2djNKuteoSXXXg/+/PL23ULbvWxhM8CNdQnEfkeK2bfWnSHUiQuwU7GwgsG/j7Y3/
	+aLV2DXjWFJ8S4hs
X-Google-Smtp-Source: AGHT+IHRw5TUhZ+JCEooOI1mm00s6bVtj9xe5+hjx30pBGlZB8NYUVClBO8Vaabreb3XgO++LF7M4Q==
X-Received: by 2002:a17:903:230e:b0:212:3f13:d4d5 with SMTP id d9443c01a7336-2129fd22060mr2433435ad.27.1732221719786;
        Thu, 21 Nov 2024 12:41:59 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc22119sm2444085ad.247.2024.11.21.12.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:41:59 -0800 (PST)
Date: Thu, 21 Nov 2024 12:41:56 -0800
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net] rtnetlink: fix rtnl_dump_ifinfo() error path
Message-ID: <Zz-bFGXFE_hjeCYH@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20241121194105.3632507-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121194105.3632507-1-edumazet@google.com>

On Thu, Nov 21, 2024 at 07:41:05PM +0000, Eric Dumazet wrote:
> syzbot found that rtnl_dump_ifinfo() could return with a lock held [1]
> 
> Move code around so that rtnl_link_ops_put() and put_net()
> can be called at the end of this function.
> 
> [1]
> WARNING: lock held when returning to user space!
> 6.12.0-rc7-syzkaller-01681-g38f83a57aa8e #0 Not tainted
> syz-executor399/5841 is leaving the kernel with locks still held!
> 1 lock held by syz-executor399/5841:
>   #0: ffffffff8f46c2a0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>   #0: ffffffff8f46c2a0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
>   #0: ffffffff8f46c2a0 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x22/0x250 net/core/rtnetlink.c:555
> 
> Fixes: 43c7ce69d28e ("rtnetlink: Protect struct rtnl_link_ops with SRCU.")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Joe Damato <jdamato@fastly.com>

