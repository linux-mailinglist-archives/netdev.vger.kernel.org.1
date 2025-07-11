Return-Path: <netdev+bounces-206254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ACAB024A0
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875D13B58AA
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A981D61BC;
	Fri, 11 Jul 2025 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVzUTfcx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F65469D;
	Fri, 11 Jul 2025 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262346; cv=none; b=iK3iZtgbTI3fTigD2NHa3i/Lo4GIVjdM0ZqauLnyGRyVVrb1bNTxviNd1rJ88Tr+RnloOvSczC2uAbfPURGuCyIytDLm+Xa1qBbK1axXT2Rt1hGvb90YkLbX28cJql1jb6Omvo1A+GjQkuY7+lH9GDPJbG4qszMinhaYq8RH/yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262346; c=relaxed/simple;
	bh=AV1GOzsvYZpFI+vT5vnkh4+JP2p8asFzq4kKOl8oYwc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TWB5LcVr7Co3uOUqiFQZ/28u1pdJ4PoaONtgTgsD6kMCA4PAVENXH+jFwNzRqstJ+pEGf3Eem7T6xMStGsS5E7I1PXU5h+4dcuba2khIdD51CYJOSu2m7PR9eq8Jf4LtABOprmXXxJJUz1fvKSqr3KxDMnnsURfxZW7dtG46h4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVzUTfcx; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e8187601f85so2226006276.2;
        Fri, 11 Jul 2025 12:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752262344; x=1752867144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wej+oXDuCOb9Uaq9h24VfVr5AhGVyzTnDepMc4aIfm8=;
        b=MVzUTfcxBsPIvlM8v7uybSdbzgzRNd4D4cs5Jo5BKdwH/xqnCby924cmx/VwsoBLVD
         WIIWIJ1oSe3WbiWbRQXMFeA8XIt/w9Egt1dPsjM1lGHYslL73w0nTvXowLZ+ECT/usHI
         lqLYySGCwrsLd81/6bMOjmTYb3B/sZJDEPJsIwkJ+DC4FeE+O4c0G+MuU/R6NI5lWzvY
         c3z8GdLqxgz3IwjxyENh/qUlfQ7m667myU3lAJtwROXeWAFDeTTfThyDmBKIm85jqdIy
         bagkYNGoqr7tm4omDIhdxQ6uorgfmV9JOYeV+Prcz7gexkIMPP4ilIyf0vxq9jX26SV/
         SbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752262344; x=1752867144;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wej+oXDuCOb9Uaq9h24VfVr5AhGVyzTnDepMc4aIfm8=;
        b=A+WBdl3D2pP2u9utfc76AA5/qL7B2IeA0kmU5DVavm07S1Kcs5h6w4s59ert7ZldU5
         ZuaeM/4sKCN+jA0ee40Jzh1YwNBp6M2QS+kGCb6/tLKlBtx3Cgcw4V1nILOhEQzoNp4P
         rCenW/1jJOLIGW6CXYqOrBGwpHwIuq7lvkUNrWPsVcu+VpUXqxkBJiHuBa5ny/W3CR7G
         sFLen3oM0dFlbPOtESfDLqLtXIhcIpj937UZ+l3Ss/2FRcFs5bhU+UTRqYZ15u4prU+6
         hIAHT7JeZeM2WnztzczW/TE6msODtSTtqvEXVxO77NqwWy73zp4+4+5Wi9y5omqy6wZ1
         TEWg==
X-Forwarded-Encrypted: i=1; AJvYcCUeMsHqZZ5rgPjeqwDU0SlgWTv5IbDO63p4HHfgDNCDIHocXZjbwSBxMEMTbXWgQQLxkt8fXzemcMtLbvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW5Uloc9ztvXCvBLEoLm6uiRob0KM/Grumc70a4ePbNJtLiyIZ
	R1bpEx861575Xg/zD5YwJaBfZZjjPKyX5kYKVZ3aYM6TCVMnRS1rwxah
X-Gm-Gg: ASbGncvdBFoIv4anY+hGZJ/5bjVsZIbvacxQu6A1HMfXQoGp2aJcuavLWQcG6C5Mi6l
	Cd9L4ntRcrqGrS73v6ZkDCPB9GvF/g3uYK39fCxuli+81rsFK/cKfXjRH4YieKcwfiWenS05w3a
	H1TekV8NAyiMqT6jAFQZ2En3hV3RrXfiGEClCEPFm9DKvgIqCi8lDb6JXZpafjb7G+9tShtaJuS
	uwWzDxj5XMXdPAWruYxvGa2fWAQxen4GzCqU9NXulFn4oKyvrbzNUC20lPLlM+mECLoI46ylo9Q
	TJB+whzZswPGGwmgAgf9mqsZ+X0gbCjJyPBdguRy+9CuX/vBcz+E1TvW8Ry+YFk6LS88xPmQkKF
	70xDEn/xycaIwxm/MN1vOC/Rpue42AIRsk3iZoZz6Q8iX2W3e3Jg1FIXoqqhtGKoxAQOSXawwKZ
	Y=
X-Google-Smtp-Source: AGHT+IHbXPkwP7hhlNP40QD5GBFnYAhlzzWMVa+9u5CqDherPla7am9mptlVeM+rsqNvxUnTRIylAg==
X-Received: by 2002:a05:690c:45c2:b0:70e:7503:1181 with SMTP id 00721157ae682-717d5e944a0mr80568067b3.18.1752262343753;
        Fri, 11 Jul 2025 12:32:23 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-717c5d6d8c7sm8756727b3.38.2025.07.11.12.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:32:23 -0700 (PDT)
Date: Fri, 11 Jul 2025 15:32:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yun Lu <luyun_611@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <687166c6cbc8c_168265294ba@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250711093300.9537-3-luyun_611@163.com>
References: <20250711093300.9537-1-luyun_611@163.com>
 <20250711093300.9537-3-luyun_611@163.com>
Subject: Re: [PATCH v5 2/2] af_packet: fix soft lockup issue caused by
 tpacket_snd()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> When MSG_DONTWAIT is not set, the tpacket_snd operation will wait for
> pending_refcnt to decrement to zero before returning. The pending_refcnt
> is decremented by 1 when the skb->destructor function is called,
> indicating that the skb has been successfully sent and needs to be
> destroyed.
> 
> If an error occurs during this process, the tpacket_snd() function will
> exit and return error, but pending_refcnt may not yet have decremented to
> zero. Assuming the next send operation is executed immediately, but there
> are no available frames to be sent in tx_ring (i.e., packet_current_frame
> returns NULL), and skb is also NULL, the function will not execute
> wait_for_completion_interruptible_timeout() to yield the CPU. Instead, it
> will enter a do-while loop, waiting for pending_refcnt to be zero. Even
> if the previous skb has completed transmission, the skb->destructor
> function can only be invoked in the ksoftirqd thread (assuming NAPI
> threading is enabled). When both the ksoftirqd thread and the tpacket_snd
> operation happen to run on the same CPU, and the CPU trapped in the
> do-while loop without yielding, the ksoftirqd thread will not get
> scheduled to run. As a result, pending_refcnt will never be reduced to
> zero, and the do-while loop cannot exit, eventually leading to a CPU soft
> lockup issue.
> 
> In fact, skb is true for all but the first iterations of that loop, and
> as long as pending_refcnt is not zero, even if incremented by a previous
> call, wait_for_completion_interruptible_timeout() should be executed to
> yield the CPU, allowing the ksoftirqd thread to be scheduled. Therefore,
> the execution condition of this function should be modified to check if
> pending_refcnt is not zero, instead of check skb.
> 
> -	if (need_wait && skb) {
> +	if (need_wait && packet_read_pending(&po->tx_ring)) {
> 
> As a result, the judgment conditions are duplicated with the end code of
> the while loop, and packet_read_pending() is a very expensive function.
> Actually, this loop can only exit when ph is NULL, so the loop condition
> can be changed to while (1), and in the "ph = NULL" branch, if the
> subsequent condition of if is not met,  the loop can break directly. Now,
> the loop logic remains the same as origin but is clearer and more obvious.
> 
> Fixes: 89ed5b519004 ("af_packet: Block execution of tasks waiting for transmit to complete in AF_PACKET")
> Cc: stable@kernel.org
> Suggested-by: LongJun Tang <tanglongjun@kylinos.cn>
> Signed-off-by: Yun Lu <luyun@kylinos.cn>

Reviewed-by: Willem de Bruijn <willemb@google.com>

