Return-Path: <netdev+bounces-245068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9ECCC68A3
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 686463033A8C
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 08:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E4E346A11;
	Wed, 17 Dec 2025 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7ccWfGx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8649346A0C
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765959092; cv=none; b=R5tmJeOagBTgw3wPiaPeMDCIqabBdh7oFdmMiFKD2zfmkiFmWULGwnYSxZnbveJPuU8NypaX23+GNLUc/2p77sQp6C3Oys1crPSAfSjB7C3Z+QnkTR9yFu900MNbuQs3UdQkzJKIjGlRBOqBIpb8202zpDrEvIoAfHj/9iBoYbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765959092; c=relaxed/simple;
	bh=VP4slbkuMNhOyt7ePv5O1rMZejitKV/WZW9BwIPLmig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yhpz4wsDsxuuhTgKFzLgK/TotwSFcc4B36fe0I4H3R6gmV+2Nw+mBwsh1zxPzEljbTrQibYT8va6sCBbAfUX8i+M5e4XJYZJYcElhWiOCfm213sMWAOn/ukYBrJpv5KQyuOUMAoqCb2Cas7CBBsRMwrJ2SPDyURuzSjA4+af2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7ccWfGx; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-787da30c53dso55489177b3.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 00:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765959090; x=1766563890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=se9qlqaNK4Zda1UW6fV88JOcpay1tuUGGKJbYPeSY4k=;
        b=i7ccWfGxlyRD8ejoTUws8FtWTYApuWenulgaMNrUAFo2VR5dJl7WhveRpslZhYmDOo
         mpWt/qd2GpsQn9JBilp3DWKJR/9Mo8BvtjT1937vpbaav+BBmcd5EW5RnkEvyHpUG/jK
         wX5VgKoqjfRjQ7CmC7PcxKzlRpktP98KKZZfjQCAlGzDFcqSPQUmDfYVAbxsAQ1mYo3w
         molzx0IS3WtLe1Xasa1DWb1cCfV5lz5D0ZB1TMRcgrVYfzxXd5C1hu1xCtEgwYuYbCAN
         zoMbVcnf/fwzbpL8Ymf7hJkzeBFCoHEnQ9OU/uoUBLdlYv9d19arimz28jOovUztm376
         2xAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765959090; x=1766563890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=se9qlqaNK4Zda1UW6fV88JOcpay1tuUGGKJbYPeSY4k=;
        b=ML8/4lPOnVLly5D+xOOZJyTXQQEgzpd6RmOxsoLoSItnuMNlfH10bsNhlIQlQaWtFm
         3ANxdVtTexin7D2obV8AqYYgK5gM+P8ZVWuqCFc6n8Ueyax0DrBAYw7Rm2oK1B6KV/Lx
         XMHn52cAoR/8kFe+GLRHGUB9A7VlLobcQdwQ++DbWbzSGFtlErrH8xeKdRqwhukisg7h
         GfEVEw8JeYSK1pWwy/IlufuyWzkcCrAXgWILFmirZer+cu1Iy3ZlSGmjtWDjYYn4Cph5
         WnqoHjdASe5PtBAcs3GgFEqvqTPUaZFWr3L8nMyOGp+8ytrfU09+MvoVjLt6zbqROp2W
         RwVw==
X-Forwarded-Encrypted: i=1; AJvYcCVoHIk2ioEhXf/bWjt0kkZQAeZfRrhONhvNPrXCZbmUJr2Qng6xDM2lHl1asvqQY23g8P8EJh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVHUWWm/MHUGaPn1vVVaDgWZd9uNNm5Ow+sMLw3WQImcLQqTGv
	UP/0D0gUq5dgvVWs8hrp98I4hzsiFPH0gkN7xzZaFRlec2uOYFQ06c3e3PEonM1nflx4GpJ5Lb1
	xiztXUg0ci+qKky6UoL1ymr/0dUrq8uw=
X-Gm-Gg: AY/fxX6FSs/3WjQqz8WG2BZz7JQm9j4gFtrgbPEPxNTrr46hXi7XaokpkG1GCuo1bgu
	BwFojwb0as+KlqPB0SuOlrCWKswddElapilpA56K0Jj633hkcZ0JJeqb3un17eyf/cRRy0XVZxH
	1+SoL77JRhA8s5iNdCaAaB+rDXpSQ0nFODzh0aMHHdyw3UcVdHjMmIAeJfjPt1AJeF6mghf8GwY
	+3JfXkwrlkX+TaOuRHUghhRC+NHW6NGlxoE9EPoJk731fnkhEeowH0Fh80/O5vnBSxLJ6Br/SHn
	EwK/R+sJ97Pt3SCSP52fU8qhQfFD/dMro5JY6f6sFx439Z5G9IPCfCcbcRj9
X-Google-Smtp-Source: AGHT+IHwFE8LQ70NmhySNinUszjIWXXVa0CUscfFXT8ZG0i+4lpei3MD7y7T54rfBzISK24Y6TP+EtGMOB8be1M0sF4=
X-Received: by 2002:a05:690c:4b0e:b0:787:c9a1:13f0 with SMTP id
 00721157ae682-78e66ce44demr144008317b3.8.1765959089932; Wed, 17 Dec 2025
 00:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217054908.178907-1-kartikey406@gmail.com> <ea5ae096-fdbd-4c93-98ff-7f5b67860898@kernel.org>
In-Reply-To: <ea5ae096-fdbd-4c93-98ff-7f5b67860898@kernel.org>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 17 Dec 2025 13:41:18 +0530
X-Gm-Features: AQt7F2oPGgilSXG77WtNwldSwnm35r6WedpdHH_Og8vUH0XFja7XcEW0kty3y2k
Message-ID: <CADhLXY4pBLt8vLfo8JeZMgfNYD7f=F+zGWTim5HmPyM-7j9THg@mail.gmail.com>
Subject: Re: [PATCH] net: nfc: fix deadlock between nfc_unregister_device and rfkill_fop_write
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+4ef89409a235d804c6c2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 1:01=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> 1. So your code allows concurrent thread nfc_rfkill_set_block() to be
> called at this spot
> 2. Original thread of unregistering will shortly later call
> device_del(), which goes through lock+kill+unlock,
> 3. Then the concurrent thread proceeds to device_lock() and all other
> things with freed device.
>
> You just replaced one issue with another issue, right?
>

Hi Krzysztof,

Thanks for the review.

Regarding the UAF concern:

The callback nfc_rfkill_set_block() is invoked from rfkill_fop_write()
which holds rfkill_global_mutex for the entire operation:

rfkill_fop_write():
    mutex_lock(&rfkill_global_mutex);
    list_for_each_entry(rfkill, &rfkill_list, node) {
        rfkill_set_block(rfkill, ev.soft);
    }
    mutex_unlock(&rfkill_global_mutex);

rfkill_set_block() calls ops->set_block() (i.e., nfc_rfkill_set_block)
without releasing rfkill_global_mutex.

Since rfkill_unregister() also acquires rfkill_global_mutex:

void rfkill_unregister(struct rfkill *rfkill)
{
    ...
    mutex_lock(&rfkill_global_mutex);
    rfkill_send_events(rfkill, RFKILL_OP_DEL);
    list_del_init(&rfkill->node);
    ...
    mutex_unlock(&rfkill_global_mutex);
}

The unregister path cannot proceed past rfkill_unregister() until any
ongoing callback completes. Since device_del() is called after
rfkill_unregister() returns, no UAF should be possible.

Additionally, if nfc_dev_down() runs after we set shutting_down =3D true,
it will see the flag and bail out early with -ENODEV without accessing
device internals.

Regarding nfc_register_device(): The same lock ordering exists there
(device_lock -> rfkill_global_mutex via rfkill_register), but during
registration the device is not yet visible to other subsystems, so no
concurrent rfkill operations can occur. The ABBA pattern there should
not cause an actual deadlock.

I will send a v2 addressing:
- Adding Fixes and Cc: stable tags
- Keeping the blank line after variable declaration

Thanks,
Deepanshu

