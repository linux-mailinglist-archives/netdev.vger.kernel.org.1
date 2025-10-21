Return-Path: <netdev+bounces-231152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAFABF5B60
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE8018C7D42
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8300D2F1FFB;
	Tue, 21 Oct 2025 10:11:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063612E9EB9
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041464; cv=none; b=mBlj65tWq0xvHpHA7n6KQouNbTB9VZNlF9qnqIlg/CrwGTENUKg3DrQxMZYAuIqxojSw5aMPrpOHsMIe5UkIl4Kzd8SPlBoFYrjMbxBsZ+bbYg20wC2pYd+JJBSuufKIq+4hSrd7xIn3EBEruOvAqwW9IXCus688CVD0/aTHJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041464; c=relaxed/simple;
	bh=vpXQiflVU7E/srPq9JfjysqPUwZeetf3iBJFxoNFNfA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hv08sx6+II871cLYjznmQ8+62+3x7WoVoOEhtq0rtO63t8tAmacPaGjq+BkP8E5SrGPk/i0O0VxI9rUFKYZ8KYkrFueUUGUqCVMH+2fyhzpBA/pc2Maa6D/lgb7zas/YS4/rKBF+sbIXAK4BfPqiTyJRHF4Q87VN+Jx+JSzrJd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-940e4cf730aso361003739f.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041462; x=1761646262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ijl+KuktG6GVPgjZkCiCYwgydFvbdcvzoiJcnFOxm7I=;
        b=ho5BloWiy9kKIPOqLKXox159cMdR3B29ygfd28RAK4xZdnA/vz/mM2s0BwsETv6UTK
         S9YEUHC9XRxdDF7C3Q/XrkDzQCsHamGN18e45xPJcUcusxA2UiJf+9GOZgZf2Z6NA6oX
         WVeb7qe5WzjQa8IJt3DZam1cTOcWEdQXnk7UGZpGD3Up0WqCSJlGu+VRD6/SXUuONm71
         7Ch6fgqbpLx+gp4MJpmZtyYzcaqQw/8iiqNpebigb2JXTNr5YLTkFRKI+saAuXcwz5fp
         6KxNpFuxz/EhVKvr+Vb5IT8cIoZ2d28VpOEeJ5nWtlHLg3wV3U/uJ0hMwg+LJI3gEJwE
         AeKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVstGMHvd+WCcTN2eD2pbtJlvw+7rUqfmjdxxVn4SGdAzU4rGk2H8yDY0pBh1mKmVXCarZTojo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYIryRu9LkvlBqLza0joJTa6rpaiMCTkfXP/JzWgBZW6bQ2y0W
	tcvWhw/JLAf/T6DD4/GKyAly8Bz+4/7TXrdxwinWccX2WiHvaYW7PA2Qf+oN8AtmxE5aFHINbwG
	Pw21qMlhy7MMcgzvr623qri51Q7jG2pTh4eorw/gLW5Jn93xTfVYuuNtefTw=
X-Google-Smtp-Source: AGHT+IFO/PptUIaZovR6keuCooSX+DOI1vkk7sEagxXGmiTLgzZnl5FSVhzaAIb+vmqRsREXvQCYmlgS7kfKa9KhO/ZMeJlBHq+0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:718a:b0:893:65c1:a018 with SMTP id
 ca18e2360f4ac-93e7627ad1fmr2655618139f.3.1761041462284; Tue, 21 Oct 2025
 03:11:02 -0700 (PDT)
Date: Tue, 21 Oct 2025 03:11:02 -0700
In-Reply-To: <mpv4ljrxyucr23x4hj7k7s4vmtvv3bgeq7uct3t44ghaw35l4r@wanp7mklhw7x>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f75c36.a70a0220.3bf6c6.0003.GAE@google.com>
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
From: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, mhal@rbox.co, 
	netdev@vger.kernel.org, pabeni@redhat.com, sgarzare@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/vmw_vsock/af_vsock.c
patch: **** unexpected end of file in patch



Tested on:

commit:         6548d364 Merge tag 'cgroup-for-6.18-rc2-fixes' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17204e7c580000


