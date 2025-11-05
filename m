Return-Path: <netdev+bounces-235759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4788AC35060
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 11:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A576818C20F0
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 10:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E732D0602;
	Wed,  5 Nov 2025 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1NWNOyy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C310E2BF3E2
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337063; cv=none; b=PCHJML1cB2Orut9u2tK+vq6cks90RlptdZY4mi3fb41oCyE/rrRRhy24VE8tbxq3vRrAl12rIVHkZoeaGZAb8ggkhAvDp41CDZZeJVPSJ9kfyQuVJHb33j+T2QWx3WQJB+Z5/uTXLoIEh0kHgGp1AV+fLywesFcVHmxJFDASbOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337063; c=relaxed/simple;
	bh=Le/pDoysJRWk7yuxVty2Hd5PN/rbL/2GKhj/ehO3stk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCCiUWmvZM87vZWnMyAKGK27+SqSe9C+UfOpsK5Ra7y9O1NMfYjDA70MUoEsNO4NIwOYSlzsIM8ZT8+49dwmR8IKUT6SiurfPRn7H2dg+96pMZgYglY5CqvkhMry0kiYm0dDV85giqbf1pwriJPNxh/quIK/sfIGl4+onOmsuFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1NWNOyy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-295291fdde4so5618775ad.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 02:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762337061; x=1762941861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOm7tfsMbQ9gn+1rZ1WTdngWRmcpDgQVp1lJAR4kXBM=;
        b=S1NWNOyy/pkMr7O4ReQ/g6oKcN1mZB0VWht2RAaMqes9nezv3aPSk9H6myph6X2nxv
         L80FCwhidpbZCbtTYecy/QDbuT77xnmnr92gnMYGcaBRnxFGheRr+1a2KL4+BC/einqw
         nWwQqLVEo4YZK1+9RoaJXGue4yVlqFzZxP8CoZlBVzpCeSH3OlkuAZnH8Wo+hbOHsVI7
         OmucSrtTdlQzrJHu5axsyjX0s909Mux5xPfIy/tDFgyAGEOpSX4wmeNzApx1MpeYM3Vi
         ojHR6wS8/Bq7fjxGEJ+kWn6QHA2X/+Tzzzz69gdlCWxV9A6YZpWOWbiLnvCC3EuZ7wyy
         GCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762337061; x=1762941861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOm7tfsMbQ9gn+1rZ1WTdngWRmcpDgQVp1lJAR4kXBM=;
        b=ZH2kzB2djLcUH6nPeEJIRyxfYMHtDZ+7tT10w3SsxsDUiYmqmW2FnF0fmrVPqZW3et
         Q+h+eFhUokHdLeAlkMGiXtnJwCB34oTZIZMFg90CMmILMgtTdr1LGibUGxJidk+09+mc
         isDSlQmWFD/XKXVPixpTw1GlTGM+404ByNUcA+fLBZ8DkxrEieKpJVVgZQ82IBXPHv22
         4ujrqzVBtXIZjODapj19iyGe0J90KXLj/Q4o//Mw1mUCs/kV4JtKh98SvFEpd52ZD25p
         euXD7frQNNFwKhIc5GSz16NsveAj0W3MhVU1D/fyh2BVJ/VgWX+1RalXdebr9w/Vfs8t
         +GKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ/87bwWi4nIHrfaQAR1IbJLUKl8Z0cc98+rt0R4Isx2ehivUMlaxNN5VBWPl4zZE1zURujHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxiemfNu07G5n8u3NUtwJXFKrI9u/Fj7KGOpwlLoc2WPmHk+hO
	gJCIVfRsdB2YnKGm5jGvGwL6KhHbHMZMobtRaRb8BAO7egFNsAsI/rlEQrOPdkAp
X-Gm-Gg: ASbGncvQqUlLE9/1mePRZ3XrqMS/TSljFoXmUERhK/+g1DuCfM7ycBJzxgLdOFPRjIX
	BG30uqAXaNKOEG9lOS67+8YhB7tSjMCgkR/kuAcrELbDRXsqZfKeWVfl3hLcNyv5keZjrWS+dsU
	eglPp8YxN0la7GwAH9ewEEb/uOlcxg8jGrjdhmN1WgQ6q6CgaJ2henne3br8hK6AO/Lsf7vQG4P
	Gfpd7Nafsz8nGLCCfRLGQC/FE48PjwTV93WL7y1taH5b/EaMDahEMoFmabVKre4IHTsEaVp2BHJ
	kEuAO7nwq4BU2OAJmkP594IZWAc+Hhu87r18eQdhhPcNpxZMdOSBZ43uYsPLxBBZlqRXpY7hJa6
	x8btiAK+Xso0KBNVZLP3UTuYBMHLLUEaoOcS+aMqoX2FUWiKA6Hskm/bTtiIDAoHJPB2EcWkFgi
	CgpDporzLRHhTrpDk42Tvq/Wdwa7G+o692FL9DXbF/RkbIXu1IhqR8
X-Google-Smtp-Source: AGHT+IGk5DBNlN3hTIt/OU+KnoTcYwEyDT5lGKLbg7D04mmqvIMyiOIVgDNc3sz+2O4XNKqDHIVh+w==
X-Received: by 2002:a17:902:d4c9:b0:295:290d:4af9 with SMTP id d9443c01a7336-2962ae976d3mr23428015ad.11.1762337060800;
        Wed, 05 Nov 2025 02:04:20 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:53a0:ab47:f43a:acda:ee47])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f1a19cdbsm5027590a12.2.2025.11.05.02.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:04:20 -0800 (PST)
From: Ranganath V N <vnranganath.20@gmail.com>
To: horms@kernel.org
Cc: davem@davemloft.net,
	david.hunter.linux@gmail.com,
	edumazet@google.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	khalid@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com,
	vnranganath.20@gmail.com,
	xiyou.wangcong@gmail.com
Subject: Re: [PATCH v2 0/2] net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak
Date: Wed,  5 Nov 2025 15:33:58 +0530
Message-ID: <20251105100403.17786-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aQoIygv-7h4m21SG@horms.kernel.org>
References: <aQoIygv-7h4m21SG@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/4/25 19:38, Simon Horman wrote:
> On Sat, Nov 01, 2025 at 06:04:46PM +0530, Ranganath V N wrote:
>> Fix a KMSAN kernel-infoleak detected  by the syzbot .
>>
>> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
>>
>> In tcf_ife_dump(), the variable 'opt' was partially initialized using a
>> designatied initializer. While the padding bytes are reamined
>> uninitialized. nla_put() copies the entire structure into a
>> netlink message, these uninitialized bytes leaked to userspace.
>>
>> Initialize the structure with memset before assigning its fields
>> to ensure all members and padding are cleared prior to beign copied.
>
> Perhaps not important, but this seems to only describe patch 1/2.
>
>>
>> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
>
> Sorry for not looking more carefully at v1.
>
> The presence of this padding seems pretty subtle to me.
> And while I agree that your change fixes the problem described.
> I wonder if it would be better to make things more obvious
> by adding a 2-byte pad member to the structures involved.

Thanks for the input.

One question — even though adding a 2-byte `pad` field silences KMSAN,
would that approach be reliable across all architectures?
Since the actual amount and placement of padding can vary depending on
structure alignment and compiler behavior, I’m wondering if this would only
silence the report on certain builds rather than fixing the root cause.

The current memset-based initialization explicitly clears all bytes in the
structure (including any compiler-inserted padding), which seems safer and
more consistent across architectures.

Also, adding a new member — even a padding field — could potentially alter
the structure size or layout as seen from user space. That might 
unintentionally affect existing user-space expectations.

Do you think relying on a manual pad field is good enough?

regards,  
--Ranganath


