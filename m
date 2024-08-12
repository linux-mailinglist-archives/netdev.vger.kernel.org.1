Return-Path: <netdev+bounces-117715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7266C94EE27
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA1F1F22D8D
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 13:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7957917C21C;
	Mon, 12 Aug 2024 13:31:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08B2170A31
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469473; cv=none; b=AC5MHipLzdNsLPwhE7J8zBBNVqINkWPkIkysCVSuIXXFk3BtQvHOlR2NsZ7sDsLiQhwj1C+hjCYNvHFmixHhLJKoV87iC9La6TRzz/9WGYopFuZFQWaOnjV37kpYM5Inlw9XJTBV8ir8gOmNe+MEdHt94WhNlZXctpFjJA8CcwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469473; c=relaxed/simple;
	bh=4MSDwiezBX10BpCrtnTOXjYawS7qUs3kgNVU0jPxGOw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=JITjo4cHZ2wkuWn3dHOdY/XLsTqlUmR4Dy78AAYfyV4sIrWm7926xdH2zZ38FWv7igiTfh++mVR6LCYx1tfkPIDXOBpGnfx3KR0U5XKMy2PAPpZb+FoPe98iD8nUBHkRqINpKQ7TS8II5a7F+cyUMzXNvsMPycqWSRD5O0FLcEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-824c925d120so16638239f.3
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 06:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723469471; x=1724074271;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2MDDwxPus6L9nBZUy+Tw4tNy6gY2TGHmSnbh9IyXkQ=;
        b=rVGvgz4Li1C4ulMrD0CD7AHY88RCUIaH2EEhnZ1XCNI4M3kd7xDe+xxydalnATJMBI
         vYGoAkKoUGfqikp40xlWgZead1X7TQ1VaxiDeskciJLYUMFfcr41sqXJXfBiZoRI39hI
         trH0rhnxQTrSWhZ1DswDIACJGgIhPpFgvnd/UFm1UwSKBDQNuTz9UsA8tZwSltoWxkfO
         PtjR7q9tsro0G8mioQlCDzxO0L/UkGwaZN51YTTAn2hRVsXV1Tp5B/0neJFJxq9Gu1ko
         JIeo+/tN/eRHN5A9OWX9MOUszk2s5weohTxJeJk9PVKoNVkfoixronxGY/cYL+4kBFby
         uofA==
X-Forwarded-Encrypted: i=1; AJvYcCVN6yw9ipJ+Oc89pgObXFVayDTXsIysGzEnjw9Iysmo11Jk71pZttZrBXTPoMbudEhopgPGLu6BQMnPLMGy13FPZfXmNkVn
X-Gm-Message-State: AOJu0YxWn1tx5pLk4F32LQO/zk0Ok4nnWKpFK031yFGcOo3e3+JHfM0y
	KLLLun6YMhffUk0l0qXA3kArpFhrpWxcpvKlSQGRKwNXPxvZ6bL4iQHIB/+czVCq4MkWrPqiATS
	1hZ0Os2hj66Np4FKiXMUC716mqqC6hiXrdYtDJG+icB8CV4nhu6jZlD0=
X-Google-Smtp-Source: AGHT+IED46H0i7+ooNgDxGsNBK5R2Bs4IMtUVYkHrx0D+KRy4Eo2VtW9NkIdkiwfJMYpasCVhJoidMhTngYiRwwiCA1DqzyHSnoJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410b:b0:4c0:8165:c395 with SMTP id
 8926c6da1cb9f-4ca9f7d4fc8mr4665173.3.1723469471016; Mon, 12 Aug 2024 06:31:11
 -0700 (PDT)
Date: Mon, 12 Aug 2024 06:31:10 -0700
In-Reply-To: <87ttfpx3z6.fsf@toke.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099fa6e061f7c815c@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in skb_trim (2)
From: syzbot <syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com>
To: toke@toke.dk
Cc: kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, toke@toke.dk
Content-Type: text/plain; charset="UTF-8"

> syzbot <syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com> writes:
>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    b446a2dae984 Merge tag 'linux_kselftest-fixes-6.11-rc3' of..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13eb467d980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=305509ad8eb5f9b8
>> dashboard link: https://syzkaller.appspot.com/bug?extid=98afa303be379af6cdb2
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/49d96e53e1c4/disk-b446a2da.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/f05350d128a7/vmlinux-b446a2da.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/805c7d86a2db/bzImage-b446a2da.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com
>
> #syz test

This crash does not have a reproducer. I cannot test it.

>
> diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
> index 0c7841f95228..f77cb743ca06 100644
> --- a/drivers/net/wireless/ath/ath9k/hif_usb.c
> +++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
> @@ -755,7 +755,7 @@ static void ath9k_hif_usb_reg_in_cb(struct urb *urb)
>                 goto free_skb;
>         default:
>                 skb_reset_tail_pointer(skb);
> -               skb_trim(skb, 0);
> +               __skb_trim(skb, 0);
>  
>                 goto resubmit;
>         }

