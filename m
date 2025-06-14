Return-Path: <netdev+bounces-197831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE377AD9FB8
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 22:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED6C174C12
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3061DE2D8;
	Sat, 14 Jun 2025 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xfg5MUJ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99F1F3FC8
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749932909; cv=none; b=nCjcFeIYomAZt7lMr79tJLmZVOG2NSPf7N6Jv6dJNg1q1WaCP0WEXvJVHBTHrXwMXpN2AY/UiejP/xv5OW1WRrN1JoT79A9TiC0LhxqK0brbpM3qAMJgCc95P6a/FG2zNWuWtLS28BJ4hZ+dO+6cvHfJZnZ8EVn3tg0X72+cVoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749932909; c=relaxed/simple;
	bh=47q61lKdvzeB0OCiL5ikWL06nyrB8ueZWni9pYQOHmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZCBny9XzYe/1kTSz85f76aH9RtF5/X8A7JmCrd8VRapr1+/S4YuLyfpBVfwsL5WeCXXpNnnrZy/5VIMD/iSjEJE+SDxS5J5+rpY2IxTLo+TBhd/NiWYeesYF3tDeuFsBCqhwdUtqykQe8o+ffMPQF9owHQ86IxWTBXScAI0QQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xfg5MUJ1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3109f106867so4607652a91.1
        for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 13:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749932907; x=1750537707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+s3O4uQZLG9NWqJYlo9sNvL4EDsg2lkIIcHNEbeL8Y=;
        b=Xfg5MUJ1lIuIoHNUN+VL11JeNGVnX0S2M7bYqdze4fuUAHP8J/Eo2GaqFIb00q4Di0
         ky1DzGEmRkgM2XY1bQLCCX7DzvErmft4fOy82LZD02uzGrjM2SeatmMVvUHuRRHjJNNB
         qOKqfLrDNU98VNj6M1JrZzOm2pkTaRSqCuiduixPjYq4NOXEsJSbPWJEi6T7UC+wFqq1
         AeVrOk606a3Pj0Kr4wiyEBD1rMJHGpi/OeZBO+1bSQNrUJeG/JXYLU32Cn6zN0IsGcC0
         Ci1P8Gl1NEnryCcRk7xebOVb4ioCWkFZ4nIcW8jr9W4wS947i+siSq46w5IoUhFU7njf
         2KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749932907; x=1750537707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+s3O4uQZLG9NWqJYlo9sNvL4EDsg2lkIIcHNEbeL8Y=;
        b=SGZ/G/1l/PQS+aXQxKYINZd/xAllaXIWXpIt3x8op1yLCT9ixq3oNMkn5OD40F+JJF
         /B6p1tzzol4Z7lk4+Eb+EC3O9VbUTjJPMKRhLwI6MroQOUiYiiIDznd2y7mkKdiLP1Qs
         MOJWEwdw/amzj/dnWTVJy6RepEw2CtwURNJlBfUwqROcx4TrpOMsJU2AVBP7XaRmnEZS
         YD/GjzcS87GFPShOnyvXsY4q+3TvnymGNCQsMCmZEL1YAQ/xR1rniV8N1CNIrglFpNlG
         wL5z0A3ZCkcbmvhZf6XnXcgiY73CNNv1QzFsARuUOCuXSLya/16PnfGK59nJr3ryva0n
         xZdA==
X-Forwarded-Encrypted: i=1; AJvYcCWMQbhYcvEADYh3t9A0Wue3lqe1obNDAXTINtBhrDWGBM7KLoMPOcmky2zSaJytOg0hgeKMUJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3y3J6wmFmZMIA/5j5cYlhmZqWtSWSrGDf7bSmE+0KfHSn3IaY
	3RGDo3XRxEy/nBFeA1cs1cl1/CbaxtyMUk2QOOdldC25Z0PGG/frrX4=
X-Gm-Gg: ASbGncu+wdgYejBQC69Tk7sleg5NryhdTN3+R3Z1tG3szstYLOo9kjGSUp//Qg/QZLx
	1L4JchZx/ZdJwN7M2JgNWLJhPb869WSE0TJPu6xef6U+PipumvFhPkt1SaIO9QHxb16XzSUkFPv
	mpKIiIjgkWVr7qI4UdD47CrD6g3mZPwxcY0fB7n/fJNrd5CxIVxTNUsfPdCZwqtQNMdwwTuAaYo
	ewiO0rVPJb9MBpWxYmD3HSvHD35BA49SSrGM1cr+thPSWpOgHRAozWjNbwhINicuELWxwCxDK5H
	vBlPblAR52/OeRprjJxirATiCKcNYDU4a0DeelA=
X-Google-Smtp-Source: AGHT+IHNTop6zEUCCyOb4+Ru2r5J2scu0mGDW4Zw003BXYpkdU/PadWptG+0GGnwj58FL/EoHkYdIw==
X-Received: by 2002:a17:90a:dfc8:b0:311:f05b:86a5 with SMTP id 98e67ed59e1d1-313f19d2977mr7421401a91.0.1749932906987;
        Sat, 14 Jun 2025 13:28:26 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1b49843sm6186097a91.31.2025.06.14.13.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 13:28:26 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: horms@kernel.org
Cc: 3chas3@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	kuni1840@gmail.com,
	kuniyu@google.com,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net-next] atm: atmtcp: Free invalid length skb in atmtcp_c_send().
Date: Sat, 14 Jun 2025 13:28:03 -0700
Message-ID: <20250614202824.2182751-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614161959.GR414686@horms.kernel.org>
References: <20250614161959.GR414686@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Simon Horman <horms@kernel.org>
Date: Sat, 14 Jun 2025 17:19:59 +0100
> On Thu, Jun 12, 2025 at 10:56:55PM -0700, Kuniyuki Iwashima wrote:
> > From: Kuniyuki Iwashima <kuniyu@google.com>
> > 
> > syzbot reported the splat below. [0]
> > 
> > vcc_sendmsg() copies data passed from userspace to skb and passes
> > it to vcc->dev->ops->send().
> > 
> > atmtcp_c_send() accesses skb->data as struct atmtcp_hdr after
> > checking if skb->len is 0, but it's not enough.
> > 
> > Also, when skb->len == 0, skb and sk (vcc) were leaked because
> > dev_kfree_skb() is not called and atm_return() is missing to
> > revert atm_account_tx() in vcc_sendmsg().
> 
> Hi Iwashima-san,
> 
> I agree with the above and your patch.
> But I am wondering if atm_return() also needs to be called when:

Oh, I noticed atm_return() was for rmem_alloc, so I had to adjust
wmem_alloc manually here.


> 
> * atmtcp_c_send returns -ENOBUFS because atm_alloc_charge() fails.

In this case, I guess vcc->pop is atm_pop_raw() that handles wmem
accounting.

        if (vcc->pop) vcc->pop(vcc,skb);
        else dev_kfree_skb(skb);

If it's NULL, we need to adjust it here, but this pattern can be
seen other ATM drivers..

Okay, sendmsg() requires SS_CONNECTED, and __vcc_connect() must go
through one of atm_init_aal{0,34,5}, which sets ->pop to atm_pop_raw().

So, it seems !vcc->pop() is defensive unlikely path.

In v2, I'll change the invalid length handling to goto done;


> * copy_from_iter_full returns false in vcc_sendmsg.

I agree.  I can send a followup.

Thank you!

pw-bot: cr

