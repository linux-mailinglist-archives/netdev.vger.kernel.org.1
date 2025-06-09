Return-Path: <netdev+bounces-195696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBB8AD1F08
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 15:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E013AD5D5
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 13:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B2E25A2CC;
	Mon,  9 Jun 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Laf5E0Vx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243DB25A2A2;
	Mon,  9 Jun 2025 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476413; cv=none; b=HLhIB88l1CTSts9MPrPTceYfh32DPh+qRnkCq02nNsj+oHjd9eunw4pRaJIG4qw5ncw+9h7UYSA8OHDM0DMUnp0Az3mPVZAGxB2WPOERXiXHskzHsuC47LVKTMNEn0Q7HdqQioIRwYDFtkASgnC+p1YEXJ2ZzyxBiB57LbiC49U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476413; c=relaxed/simple;
	bh=cY4xKlehVdvlZ3NiQzDRzQlO9jXyfXVG9+zrEpxgDxs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ETEeHsEtTbojDUKF3GifyKc9TgilQ+mps8SF8ZlgWKhe7092tqIpKyuSZA//WTaHk8cKicY+2KKWVPoV/CXkF6kAG/sd+P5YhWzCSFOdKCeFqbCtR2xVDtPz3vnPpHhxm1LBFlogsnXJItCY9fTLx9L9S7fajnCdykmDybYo1ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Laf5E0Vx; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-53090b347dfso1410532e0c.0;
        Mon, 09 Jun 2025 06:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749476411; x=1750081211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cY4xKlehVdvlZ3NiQzDRzQlO9jXyfXVG9+zrEpxgDxs=;
        b=Laf5E0VxclgjwUI34BI36dDqNDdq7UQOm+xEhbO2mgRNf/JH8biWWxMbti5TOulf8Q
         GKJ+ewYIW41AAuBo4QkEY6076zTLryGTrt2wEYJ50FwP9UYsDyVcvG+uQXDKNgpkztve
         7UNc1Omj/1oKSPNU8O3c614TJrMV6mv6F1+l/e7IXXUYcjNGaZdEMFmSfFwXZNf41lJZ
         MRjMM0ZOcxpElPop3jW+TSwHYBmHg2SRAOZ1TdmTWVjw8UHgF0YtT4BcunLKGvFULkh7
         FDCCa6a01iQLzBZILcdUbWVYqOu1gutBz4bWpo7g8nAZs5Nd/K0wMXFWrauk4RA9cMDx
         yYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749476411; x=1750081211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cY4xKlehVdvlZ3NiQzDRzQlO9jXyfXVG9+zrEpxgDxs=;
        b=CqGvGPrSyUY/wieA2qU+G0By/3zdAjUxmUWdmOvUq9Ec520Q8Awcs1eO8scgvL4z1W
         bu8e1Au5jbzUqCynE6Fp5p14EzjYBQ7mqWR+tUJRuO4GhX+RB7Qb5KuOuuHw49Al1Bnh
         rq2yft5q+W2bLv0084lPo9ATPskI4RlV6pSp7IX9HNZfUrsBg19FUj9glhVI0c2HGowE
         n4ZrQSciqcgRlaSHTFW12XdaaYf/Yazod8WjGdUHZ59h7jmaZMYDw/wRFRk7OiFHL7Dk
         jMPwkqfhcJ7LfLClOJWdZ8I1/yPa2+zBMglN4sdvyZGZpiGRwj1QVxKlwZd+PtT4kMO8
         RvUw==
X-Forwarded-Encrypted: i=1; AJvYcCX0yLMDS+u6lBIYA34WFqYX/k/L0ru0/Byk9iUv4zlt3xjD9IneVN9Hxkzn/U4OMlELtIKWs+Cy@vger.kernel.org, AJvYcCXvfeLdxBDag2EwGb+p8xLH8XXJ/b4fmadNTAx5yvH2fshX/61cndgBAJxLFKpcplq5KDJZP+697N74Aqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb2RVm36PS1YrIlWqQNPLaZ8nR1EGHZFJbWqZLv0nfagyhMRnJ
	VKUZtVKjpnb7Wm9fDP59sM0gRmcQXIigGSjccxkKc2xZdRg+8BfK45OZu8x4gL/3qKzVJw3fivU
	4fGoGUlvl1vLOKT2c1PHMKFV9RhPso/E=
X-Gm-Gg: ASbGnctiI8dw1sYED5gzduQydLcmdrzcsBe4SbacFQHr9TfJZ9kA8KUzN2jehNMBIsS
	7DlLFe7OIjYUNqsCJSDgOQod44/TW01/N1fOhLQGOerpW99DuXR4Gh9ADntVq58wkhG/OSnTpqF
	1GJeaUk9y3hpjlX6E+AxqKfdFKXt1/3pV2cP0kO/pXoKeL
X-Google-Smtp-Source: AGHT+IGY6fU6lJ8V5VjYmrvOBlPolfPyq3XHCfqRqIx9PvrE87W7ON5Flq55XC+vB3tO7sziS7pDRkGERLXIw/X3o/Y=
X-Received: by 2002:a05:6122:201f:b0:526:2210:5b64 with SMTP id
 71dfb90a1353d-530e48b54efmr10496314e0c.9.1749476410937; Mon, 09 Jun 2025
 06:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xianying Wang <wangxianying546@gmail.com>
Date: Mon, 9 Jun 2025 21:39:59 +0800
X-Gm-Features: AX0GCFvxspkhrn78Sa-QcFbj3ft8P-CqaA5D2axID067xmJTtU7TPXtPy7th6SA
Message-ID: <CAOU40uC6U3PS3cu7RmK71DPA_jbW_ZY0FBkBjCdjVArCiZO-fA@mail.gmail.com>
Subject: [BUG] WARNING in sendmsg
To: davem@davemloft.net
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I discovered a kernel WARNING described as "WARNING in sendmsg"when
fuzzing the Linux 6.8 kernel using Syzkaller. This issue occurs in the
memory allocation path within the sendmsg system call, specifically in
the __alloc_pages function at mm/page_alloc.c:4545. The warning is
triggered by a WARN_ON_ONCE assertion in the page allocator during an
attempt to allocate memory via kmalloc from the socket layer.

This occurs when invoking sendmsg, which internally attempts to
allocate memory for socket buffers via sock_kmalloc(net/core/sock.c).
The allocation triggers a warning due to either an invalid allocation
context (e.g., atomic context with GFP_KERNEL) or memory pressure
conditions that violate allocation constraints.

This may be triggered by an unusual runtime state induced by the
fuzzing program =E2=80=94 such as mounting a compressed ext4 filesystem via
loop device, performing ptrace and socket operations, and using
certain sysctl interfaces. This combination may have placed the system
in a constrained memory context, causing __alloc_pages to emit a
warning.

I recommend reviewing the use of kmalloc in sock_kmalloc, particularly
the GFP flags used under socket send operations, and whether the call
can occur in atomic or memory-constrained contexts. It may be
necessary to guard such allocations or use GFP_ATOMIC where
appropriate.

This can be reproduced on:

HEAD commit:

e8f897f4afef0031fe618a8e94127a0934896aba

report: https://pastebin.com/raw/DJLgSX8N

console output : https://pastebin.com/raw/DLirgK1i

kernel config : https://pastebin.com/raw/aJ9rUnhG

C reproducer : https://pastebin.com/raw/EXf8Gc4A

Let me know if you need more details or testing.

Best regards,

Xianying

