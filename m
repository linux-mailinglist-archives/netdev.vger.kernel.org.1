Return-Path: <netdev+bounces-118794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86165952CA9
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217FE281A86
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227CE1BD51B;
	Thu, 15 Aug 2024 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMOcgjnq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0DE1BC9FA;
	Thu, 15 Aug 2024 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723717429; cv=none; b=gvjxi0AC4/mqUHU9QuIJ230oExavvSvCUMT3cfJUJe2FOtsTP9E61zdcirS7zZOktnxiGJSewe9xvSiCQUpgH/nmxv/jkfpDCzxlxZygWL4olH/e2chPXuRCk4MU6DmgLaXlZwDxzg8VgX76OgqGG4oub9G1gCIhHsmCuibT6S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723717429; c=relaxed/simple;
	bh=sDQnLPPU7CmUJJcoqQzx+GzeOhbElOfyvYedxIsokAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CV+2rux6T+59rluSmdJdilh8R+Bqh6jbjtmaW8dbaM+rYzCOI8n7GXqxSQ4EKbQ9K1hU6chaU9s/ArRBjx5uR8FEGWQYcXswPZd5d4e2Npn+//acaqrQkkWFEGdxNdfUNM4r2J+nsHRwwcqWVfDZl4nHqPdpf+mzz4B1T2LNHcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMOcgjnq; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7093f3a1af9so433541a34.1;
        Thu, 15 Aug 2024 03:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723717426; x=1724322226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3zCUHzp/42aLKvNYjy11VU0WvKfSv2JHMOxj6wRNYs=;
        b=ZMOcgjnqiQB83OcnM18kIFIw9Tt6WdlAEuCY+UMiT622qzn1uACeZ6HwMeo5cd01bj
         fmgIQSEoyCg8+HnE3A1WoA4vmYf2agaFFmOdw8azcJmklj2m/Cag8iv8/RnidsUDbL3y
         sLXF6+B0GrLNpDelGlXAZgflhKvzLLg5tsiYrrAXB4bObN75Jvx/F5edghiei4hhiSdy
         rwcWifF1bf9yk8bZrF+NV6CI6rQJ0N4eZ4MDAfSrkdBUrCBQuopMLuP6FXAg2awOCWns
         0ldM2eTvaiSXsCDIM0xBAYtuz7qlfKTHgqlEkstLS87rLC6Vm3//YskzvGfpOchHJ4Rs
         2keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723717426; x=1724322226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3zCUHzp/42aLKvNYjy11VU0WvKfSv2JHMOxj6wRNYs=;
        b=kszxmLuazL7hfNZHW4FtYpHNUUbRGYstAlOmYlgawhvYuwKVcGDCamDHPYQmF8+Tuu
         BNMACMpPWrr/0PUADGe2uf7acZSWrdMiud5WTjKKw1evfnLvjcZFpClDTrdkND58tlM8
         EkChN3W4/VGSO09X6kLHK+gVL9i943p55fZKeTVx6M1g1G0AI2puMic9jGclze2KeL6t
         i0q48VcKtI4NZCxdmSZSxoisw1Cr8kiy1k0mVqrSh9eDSQuMJal3bUJWRpE2AehVDClf
         13q2LbeSLrQX2SmAKHF30qUZwn48qM3KfIR7BcRZU9vEaovGGQpT3jqAofypVsfmKJ54
         r33A==
X-Forwarded-Encrypted: i=1; AJvYcCXQ36khcPDfmW7eab7jEDo1cXHZN2Gsh4AmJYBTrLy5+lfnSIRH7FD5du4Sm938sNc3TjWFfEN4aT2Q5eMcjdgvuRLNAljlBXUsHy8/RCHOymWVoAf94Bnjy30914Y+E+vhGiUA
X-Gm-Message-State: AOJu0Yxa5axvHOPcOzrwxCk5HVD+2kPtDa9JzbJTqehQKantYtBOGn2s
	3vzUbRjIUtPV6bJXd5pLU0M5p7dKi3OPbYE4AsTRG5cRswLlfi40
X-Google-Smtp-Source: AGHT+IHg0rTvW1URXIJnndrN5lBUZKzPcNKldhzVUS7WjmxvA0df04isk9562g++e7EnyLb3vki6cA==
X-Received: by 2002:a05:6830:660a:b0:709:34e4:9b8b with SMTP id 46e09a7af769-70c9da1770dmr7368623a34.32.1723717426470;
        Thu, 15 Aug 2024 03:23:46 -0700 (PDT)
Received: from localhost.localdomain ([49.0.197.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae73564sm786129b3a.92.2024.08.15.03.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 03:23:46 -0700 (PDT)
From: sunyiqi <sunyiqixm@gmail.com>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	sunyiqixm@gmail.com
Subject: Re: Re: [PATCH] net: do not release sk in sk_wait_event
Date: Thu, 15 Aug 2024 18:23:29 +0800
Message-Id: <20240815102329.172161-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e6171479-28b4-4155-8578-37a14dabee50@redhat.com>
References: <e6171479-28b4-4155-8578-37a14dabee50@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Aug 2024 12:03:37 +0200, Paolo Abeni wrote:
> On 8/15/24 10:49, sunyiqi wrote:
> > When investigating the kcm socket UAF which is also found by syzbot,
> > I found that the root cause of this problem is actually in
> > sk_wait_event.
> > 
> > In sk_wait_event, sk is released and relocked and called by
> > sk_stream_wait_memory. Protocols like tcp, kcm, etc., called it in some
> > ops function like *sendmsg which will lock the sk at the beginning.
> > But sk_stream_wait_memory releases sk unexpectedly and destroy
> > the thread safety. Finally it causes the kcm sk UAF.
> > 
> > If at the time when a thread(thread A) calls sk_stream_wait_memory
> > and the other thread(thread B) is waiting for lock in lock_sock,
> > thread B will successfully get the sk lock as thread A release sk lock
> > in sk_wait_event.
> > 
> > The thread B may change the sk which is not thread A expecting.
> > 
> > As a result, it will lead kernel to the unexpected behavior. Just like
> > the kcm sk UAF, which is actually cause by sk_wait_event in
> > sk_stream_wait_memory.
> > 
> > Previous commit d9dc8b0f8b4e ("net: fix sleeping for sk_wait_event()")
> > in 2016 seems do not solved this problem. Is it necessary to release
> > sock in sk_wait_event? Or just delete it to make the protocol ops
> > thread-secure.
> 
> As a I wrote previously, please describe the suspected race more 
> clearly, with the exact calls sequence that lead to the UAF.
> 
> Releasing the socket lock is not enough to cause UAF.

Thread A                 Thread B
kcm_sendmsg
 lock_sock               kcm_sendmsg
                          lock_sock (blocked & waiting)
 head = sk->seq_buf
 sk_stream_wait_memory
  sk_wait_event
   release_sock
                          lock_sock (get the lock)
                          head = sk->seq_buf
                          add head to sk->sk_write_queue
                          release_sock
   lock_sock              return
 err_out to free(head)
 release_sock
 return
// ...
kcm_release
 // ...
 __skb_queue_purge(&sk->sk_write_queue) // <--- UAF
 // ...

The repro can be downloaded here:
https://syzkaller.appspot.com/bug?extid=b72d86aa5df17ce74c60
 
> Removing the release/lock pair in sk_wait_event() will break many 
> protocols (e.g. TCP) as the stack will not be able to land packets in 
> the receive queue while the socked lock is owned.
> 
> Cheers,
> 
> Paolo
> 

Also a question about it's protocol itself should carefully use low-level
kernel API encapsulation to ensure its thread-safety or kernel API should
guarantee thread-safety since sk_wait_event or sk_stream_wait_memory used
in many cases.

Sincerely,
Yiqi Sun

