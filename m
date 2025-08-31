Return-Path: <netdev+bounces-218558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BF6B3D372
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 14:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E470189D889
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28D125A2C3;
	Sun, 31 Aug 2025 12:56:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1924745029;
	Sun, 31 Aug 2025 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756644992; cv=none; b=JuhX1fK8iu7TuW/6AaJQymzKQFqY2sbiaq2640lw4SbvvnwAkvn21wCtcxIb83vL55g9JKToHscLlsbiJ7MNGK4w7AAXzfLzZpioPxVAHwJ/yFS5YbRkbT/+rk/4k+x13xOi71MMoGM2LA2GDQvL6PzqXo9IW7CR13zO9VoSdek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756644992; c=relaxed/simple;
	bh=PHb1PQ4tlF+ZkPoai1rMMZRI0SFk0v+RCWPE6rcN9G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdUcN5bOsbo5/cQ0PuGdCk3loamshnXqjGuEGDSc2VPi5SKD/w6DvBb0oj627jnlquVHmlY0WOWojJm3MsZet8sL0UlBVUUkrIqVg3lMgg28uKpvdR13zngWfw/5p2yEQY49D8aVpwV3lwGedSE80QsvvYz0pSnGva4Q8UrOP1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2489d5251f0so6563415ad.0;
        Sun, 31 Aug 2025 05:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756644990; x=1757249790;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VOnG7Zg4hyxcpABPfvTOTnGC7dLIkPViFyHOxvZPfQ=;
        b=QmJ5Vl+HUJFXSh386Z+0jIuC8GqRR1IGTwltnr1Js/st7qDEzsKs0yKnhKfkIoDmVL
         qo9FtTkbP7rHdEXevTNDw02dLmLtarbzW0f6IPbDCqn2CrBT8JaAXdyLX0Ujzhh6z6gf
         Yx6E1up1OjaD8h0Wr3Q2RZmk2qeiJr8R1Wt5OcqXouhFvNFaSJJQKUb7IXvlqSDIuPcJ
         2+YjKkNaqsffIhh+Ta+L4QYlTS4gJRXQdm1wdI66I8CXYOtsCHDA7YyQfruu9MglD9HC
         ynABkoRvcBYsaqc1YwtyHiDaltNx5bZWd0UIDglSxsWSwc+84r/fg6ErbpSCbVplnb8d
         /hkg==
X-Forwarded-Encrypted: i=1; AJvYcCV2oHxTe1cPAq67Nu1m7Dhg8pGNOlVFhU7ojOvls9ibeVKTD4ZwpKY1nablZ8BYOaQS2W7RJ5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoTpR5rlPFfsZMxpqNEv5Nup4FFZDZbE+7VTEA91kLqVCUivwN
	r2sGMw3mAtiWpvxMaE9T5Hj4h3E3vsMaEXcpQW6NbnwEc4bqFDwYvV50
X-Gm-Gg: ASbGnctV0a3Elnw83Sy2fiPNepvkaUXiGt6t5RgmdLGoSLbEB5FJN2tSdG9i7bFXOK+
	lKXl8RSlN+wzDJ460kVDDbf/7Q7qOxTNQW6pU3aCn31j10M0UfhOuK/OuU3A/KH4dpobsj7bL90
	Sa82Sj6YkmahDve08Gurb4KgIuYtMLQuqpigoCU5F1RJP4pGpawRhWHD+WkbW9a+mqatIdOZ584
	dgLybFwYlwyBYbjnQypRGePIh/SN4e23LgeR3nMbsoc1m+TLgWisZe/FPCUESpMpCAUJH3UmOUm
	8CC6Hd8/uZJcGrEJA2Hb8E06s9bVfwT2CLWmfEc6QfnSRYelI+lNwLgTt7gvTS2yRes3uis7CGM
	j3RMDj0bYzHuJrV7gSujnSWs2zcYgNRtQpEtVr6PZoTSFpPh7KX2U/LPNNxL4P7hlPZqX39Rckd
	Dth7/MXkvUkZt8oKvsow==
X-Google-Smtp-Source: AGHT+IGw3re/1F5YuH9z9F3XYz0qQLECMO0rpRpL5Fv1Vazq8EdEloFiVgW1aN1EQAGRnq6n+kwlVQ==
X-Received: by 2002:a17:903:41cf:b0:248:b43a:3ff with SMTP id d9443c01a7336-2491f246be0mr43496895ad.8.1756644990252;
        Sun, 31 Aug 2025 05:56:30 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1ca7sm7654095b3a.71.2025.08.31.05.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 05:56:29 -0700 (PDT)
Message-ID: <1df5a745-902a-4a57-8abd-6b48cf54fc87@kzalloc.com>
Date: Sun, 31 Aug 2025 21:56:26 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] [nfc?] WARNING in nfc_rfkill_set_block
To: Hillf Danton <hdanton@sina.com>,
 syzbot <syzbot+535bbe83dfc3ae8d4be3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, syzkaller-bugs@googlegroups.com
References: <20250831095915.6269-1-hdanton@sina.com>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <20250831095915.6269-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Oh, thank you Hillf, for your help!

On 8/31/25 6:59 PM, Hillf Danton wrote:
>> Date: Sun, 31 Aug 2025 00:02:33 -0700
>> syzbot has found a reproducer for the following issue on:
>>
>> HEAD commit:    c8bc81a52d5a Merge tag 'arm64-fixes' of git://git.kernel.o..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1508ce34580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
>> dashboard link: https://syzkaller.appspot.com/bug?extid=535bbe83dfc3ae8d4be3
>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11019a62580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1308ce34580000
> 
> Test Kim's patch.
> 
> #syz test
> 
> --- a/net/nfc/core.c
> +++ b/net/nfc/core.c
> @@ -1154,6 +1154,7 @@ EXPORT_SYMBOL(nfc_register_device);
>  void nfc_unregister_device(struct nfc_dev *dev)
>  {
>  	int rc;
> +	struct rfkill *rfk = NULL;
>  
>  	pr_debug("dev_name=%s\n", dev_name(&dev->dev));
>  
> @@ -1163,14 +1164,18 @@ void nfc_unregister_device(struct nfc_dev *dev)
>  			 "was removed\n", dev_name(&dev->dev));
>  
>  	device_lock(&dev->dev);
> +	dev->shutting_down = true;
>  	if (dev->rfkill) {
> -		rfkill_unregister(dev->rfkill);
> -		rfkill_destroy(dev->rfkill);
> +		rfk = dev->rfkill;
>  		dev->rfkill = NULL;
>  	}
> -	dev->shutting_down = true;
>  	device_unlock(&dev->dev);
>  
> +	if (rfk) {
> +		rfkill_unregister(rfk);
> +		rfkill_destroy(rfk);
> +	}
> +
>  	if (dev->ops->check_presence) {
>  		timer_delete_sync(&dev->check_pres_timer);
>  		cancel_work_sync(&dev->check_pres_work);
> --- x/net/bluetooth/hci_core.c
> +++ y/net/bluetooth/hci_core.c
> @@ -1476,8 +1476,14 @@ static void hci_cmd_timeout(struct work_
>  	if (hdev->reset)
>  		hdev->reset(hdev);
>  
> +	rcu_read_lock();
> +	if (hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE)) {
> +		rcu_read_unlock();
> +		return;
> +	}
>  	atomic_set(&hdev->cmd_cnt, 1);
>  	queue_work(hdev->workqueue, &hdev->cmd_work);
> +	rcu_read_unlock();
>  }
>  
>  /* HCI ncmd timer function */
> --

Last time, as Krzysztof guided, I wanted to try fixing the bugs reported
by syzbot, but since it was my first time following this process, I needed
to look up the steps. Including the bug I’m seeing now, is there anything
else I should do to address these issues?

My plan was to look up the procedure and then revise the patch description
before submitting a v2 patch.

Thank you!

Best regards,
Yunseong Kim (金潤成)


