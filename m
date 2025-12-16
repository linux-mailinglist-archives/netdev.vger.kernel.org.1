Return-Path: <netdev+bounces-245027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABF6CC5755
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 00:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCE9830046C1
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 23:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9E533FE0D;
	Tue, 16 Dec 2025 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt846+Tq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A81C33AD8B
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765927421; cv=none; b=ckLfAacI5ctkEEInAO+041nJ9M3nlahpQf1DSVY32gIRC6V0MxR4AvPeXiMYZnlmKuL3fOmRptFxjd9+YAD1okJ0HboWE6xwJy0oztGJgC9k4z80YWJ9fzspQ3UK/Tg4Mcj0isIdjUIrxlueA+5hwEf9F5t2ZYUh3Nhb0ymPHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765927421; c=relaxed/simple;
	bh=p2Le98Oihmg/I5e6cqTCv7nZ6Bf6ATtna7X7az6/Szw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PATBv6AyZI3MV6jCxBv+xo5OqW4QUzUaYHAOjYOtG8idm0tue6251LkOdbFyvtimVrT6gFUWVdC4vQpI2zf2Cq6XztwVhPjLcIRmXybMqNpVvM+YVqm+tbuuAHfn5EwjV1JFGiXfzCjX13c4vXyuTnD5Sgt9dd0WB3FwvveDeqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rt846+Tq; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-65b57959b6fso1583062eaf.3
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 15:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765927419; x=1766532219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6tR426XIRMqRtFk2rP7biIuhLUYaP3KajXpeq25hMx4=;
        b=Rt846+TqnTnOJsXu0NNxyd/O/GfFYqfK5Ol6nguZYjffY0PbTkHmTskiHGUOs5RWnc
         g9fBC1AA9ayR4Jts4WOq00BrokSZDzU649xt9vjKSDDoupk2Wc+AG7DLq/4uPRM4zq7n
         Yf8ibijqcJqhSsqFYSXiOe4c/qgYqam57o+bKQ2ZeDuw4QNuSZy1pTltB4tEm5sfCZw0
         OTrfNxmz+AC7uVc5r9OOHMlG0RlSSCE8Yb/lW0ZgphSktuYG4w9onG+ZNxpPwLy5YZoc
         L/J/cLwGYE/FLHdi2qC58TanjbFWevX0mn0y74A6hc2coCV7foToZI9+kF/oztyyzLwN
         xT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765927419; x=1766532219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tR426XIRMqRtFk2rP7biIuhLUYaP3KajXpeq25hMx4=;
        b=CZ6EuKDJUtoOu1GXWq18QoiM95K67GOfVYRhyIjdUdQO8fZvEX/Zb2SjRK6UrwxFfG
         hvKt5ssyvBb5d92SIUgdYHC88Y2hnoMHjHBpUFCE4lB7cbrg02Bx7IRRxwYbD8T3NrTM
         b2r79QVfb9yEvmVlXEM2LMpHoZfr4658rvt1QS1ZooGwVHXibaA4CRw4jBs0I0HguGT9
         BdOxSd2c66Pf8jFltA3h6e3tOtFmK5+MdmADXHIVUITBj0E8ST4dyD8iTwWqAgNVZVoM
         Lugg8iomdn8JLaw7Xu7V7uZKQ7iyoCkZvYdCY0J5NSo6+4SytbejC8iSl050PvwKObYs
         TlJg==
X-Forwarded-Encrypted: i=1; AJvYcCV2UX1NhtumMjmTrFFc9xz+zOruaLQmdSmZTjDHYiI+AttZUztuhCQhjzYgzLOnso1+M2CxnDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp8zXRCkctCIZnh83O1xkiW2UGT8O4fc2weBqX/8GIZVkS/Gmh
	/aKwVya0A1tUM8iT9ecqOA2qSjS9Y9rRP63Q2WgI5Wc4vk7rE/WJ1RVgnYeqYufsIzUagMup5HM
	+4aZvES99mPJtXXqnOVTWuTrZjd2DprQ=
X-Gm-Gg: AY/fxX7MRCaJx3I9ln9pVEys0qYjXCnHw2MEb2A8hnRmWgQPa8VyYLv+B2npdHQpKEY
	djSg4c7vfTcfS+qMjQAvvkgxVsn7E8osvxm5Pp4yCYDKwRIgcMFdwdefkEExqny7ssr+i9LwLVI
	YQ6FnFlLGrhYak3N8cRbAsbITicA1lzE6/EUuRs3wn0+lv+mCjrwBscdL52xGDzjyG4j4P2ZPxe
	BntOF8ZX0w9kCnSm/tPb8MYLQGZpm0XMDikP5l1oNOyY1F+bqoVeek2P3RkfOEsYlUtmrdN
X-Google-Smtp-Source: AGHT+IFVlIqs93eHMoHC0M0yx2toIitcXtSfLRUcuxvp301PLZ3twqBTDuQXP9Ek1V5+Rwg8y0UfTwir7t3yFpYy4r8=
X-Received: by 2002:a05:6820:2294:b0:65b:579c:8479 with SMTP id
 006d021491bc7-65b579c8cd6mr4626167eaf.75.1765927419075; Tue, 16 Dec 2025
 15:23:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69412f2b.a70a0220.104cf0.034b.GAE@google.com>
In-Reply-To: <69412f2b.a70a0220.104cf0.034b.GAE@google.com>
From: Raka Gunarto <rakagunarto@gmail.com>
Date: Tue, 16 Dec 2025 23:23:27 +0000
X-Gm-Features: AQt7F2o3k_WNMGHaMAPIqq6wt5gOmu1NHXvbiYv5er6CvAA0ZWNkDAGzR0yNd-c
Message-ID: <CACUOwmJSqHu+ZxaKat7uD0X7O483omE56xYkKDU+a=dGs_n-BQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] [usb?] memory leak in rtl8150_set_multicast
To: syzbot <syzbot+8dd915c7cb0490fc8c52@syzkaller.appspotmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, petkan@nucleusys.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

async_set_registers() does not free the urb and req on the
usb_submit_urb() call fail path. Fix by freeing both objects.

Reported-by: syzbot+8dd915c7cb0490fc8c52@syzkaller.appspotmail.com
Signed-off-by: Raka Gunarto <rakagunarto@gmail.com>
---
 drivers/net/usb/rtl8150.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 278e6cb6f4..0f6c700a85 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -211,6 +211,8 @@ static int async_set_registers(rtl8150_t *dev, u16
indx, u16 size, u16 reg)
                if (res == -ENODEV)
                        netif_device_detach(dev->netdev);
                dev_err(&dev->udev->dev, "%s failed with %d\n", __func__, res);
+               usb_free_urb(async_urb);
+               kfree(req);
        }
        return res;
 }
--
2.25.1

