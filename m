Return-Path: <netdev+bounces-192806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5CCAC11D5
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 19:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E41189F6EA
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 17:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC4D17A2F3;
	Thu, 22 May 2025 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxoYyJEL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18D0184E;
	Thu, 22 May 2025 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933613; cv=none; b=ol612tKN1tGKpgwTXlcSdoFuS3ELjVDGW+FFYgtHoIyxrltc0yhvjUnTZqhY1HZzZzclQ4YxMKY+7KPaaY5h7FKr5U/Iw9ABEIwH4iUMFcOTxANX+84nXYWUkObvZg0fhqvUQ3gnY89ENBN99H6cLMfgFsohquh6/UNtveKg5Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933613; c=relaxed/simple;
	bh=Xrq8IL2vFlNFiAWRKzVMFO5UYY1UmJBFHebhTXzI1EA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hrDsxz5STX1aw5TI+FvqiBl4USugp0TkvXralAX/IgIG/4nxwOjd55E1btyWEgqZWFRYT7yJ63rLn0FmKEU0Gz6r9vqUejjZHMFM7TXI57Zv1+hSJlzYYAoGgYp4l7okHOl/tPVw7he6kb4qLGBArSW5z7SBcuM/SX0WUo0TecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxoYyJEL; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476ac73c76fso118503391cf.0;
        Thu, 22 May 2025 10:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747933610; x=1748538410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vqz4uQ6Mi4Zp+A95QCJrlEDt3IrPpTzX/7MsZrQkvuY=;
        b=AxoYyJELsTiZGF9fICZ3F84JGmxiHeRAyEilQFKqjs2Q4jVlDYHP/q2vI/OMzMevqf
         UlVxJKCOtPat37z1R00ifnvy+h1PWChWzXPj0mvAt/I7SItojDWnU4J1FXl3Jvz81pTg
         +Febii3qv4QkmT4LrM5Xn9HeOt04deGF6o0dd/DFEFfnINHQNw96vuAoWuh9UQhkNBTU
         rKvjH05CO8rVKZNb/MfjE44hZKkHoG9xIaGmxA0RypMx5mjHsrCZ/GsjN2nIk6eexdbd
         YCkilEd9kUx2+Vsv5zi62FKnmZ7gax9rOt6uWPEHGVjJu1XMoAKyuhqeO2pfZvZRWVni
         +JuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747933610; x=1748538410;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vqz4uQ6Mi4Zp+A95QCJrlEDt3IrPpTzX/7MsZrQkvuY=;
        b=nM48T2rO36TNS2a/A4Aq24h9lN5HxfeCLpApWU8yaHe5LS70GrPk4UsmCbdu3fcK70
         tRCWeazn15ba9oQRm2QnvWUd1AbhTeRdlFkQM8Yog65jZJEtSzTCYiqwphivU9rJESWt
         MCqRsBtu965kNThJqTpPEgvNl0Ob2APtcuoErqJ+EhBaOaHaEVRM7xI5hAkjnZVpewIW
         dVvH03xD2AspKm+ikFyHs4frVOMfQbdj78Lo30xGnyClWSEq7dutDirMFmdWdP55v4mq
         eIpKUonjP7TJKwGrybyoqes5nkbB+uzWKKBuQF/fAkpODuyWldLmxPs7nhC5dsiDlV9M
         fN6A==
X-Forwarded-Encrypted: i=1; AJvYcCWFuVE+9eo3TprKrNloJ7JEO/ysAmWAlCne3Q1VNQJ63PM/SHLJtp1TFwzH7WJ/uTeXzaWIIi2CJXmUdSs=@vger.kernel.org, AJvYcCWdbPFS42yKVnsh8adYZ71YYbX5ZlWbcotb60n+KG/6eoaP9xnnXDANFmuCXVzempSGvpZYIHEO@vger.kernel.org
X-Gm-Message-State: AOJu0YyiuZIYylgf5FHOw/lGBXKP4fftqfi1pglvjA7yW/gwKs9PwKbW
	Mui7XObc82wS0IiT2fsy72ti845R8t2gAA+B06f8+zzGB252VCM3AFFh
X-Gm-Gg: ASbGncs1WqxjOaP9hPN0OEZeNCU5Ui0d/P1AaoWPG8lrfHSNbqCZJVTkmFHTawFLcwb
	z0p1GMzKLot7oaMI7qdZGawPqbjVF/8AH33h4+M7e+OuxATcUOrvOlM7EEWKgUSTKTKeNkryh/p
	5AaJ08uxctjhGyL95yS8zb7YJNbX8vWF0KQek8qAJvaQdnktk+BgdrI5ngc3ZxL4JfcseRzDh0T
	/pj3RGRAsHviacyC7nTJJui0wNSncC5vSJRupZRyBdQ6VjqVwYGY2T1lDG8YqLBUlndbY0a/lEv
	M9PIgNdcrC/vu7vanumEaH5nT0SEK5pxD3zGss/yitpHbdua5MzW+5DBYq/0952iFHwjT5nKUPu
	iQg4MJmOvhWlC8UYsj1rGsk0=
X-Google-Smtp-Source: AGHT+IEGDWqUbNThCKT87ztwaE/lAdSrYVWFPyDYaua7c+9Il+9cIbYYQSfVU0q3Jm88R5lZgZ8UIg==
X-Received: by 2002:ac8:718a:0:b0:476:ad9d:d4e9 with SMTP id d75a77b69052e-494ae3d6caamr253225061cf.24.1747933610635;
        Thu, 22 May 2025 10:06:50 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-497ae224a4bsm76673711cf.76.2025.05.22.10.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 10:06:49 -0700 (PDT)
Date: Thu, 22 May 2025 13:06:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 horms@kernel.org, 
 stfomichev@gmail.com, 
 linux-kernel@vger.kernel.org, 
 syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com
Message-ID: <682f59a9887be_12c79229452@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250522031129.3247266-1-stfomichev@gmail.com>
References: <20250522031129.3247266-1-stfomichev@gmail.com>
Subject: Re: [PATCH net v2] af_packet: move notifier's packet_dev_mc out of
 rcu critical section
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stanislav Fomichev wrote:
> Syzkaller reports the following issue:
> 
>  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:578
>  __mutex_lock+0x106/0xe80 kernel/locking/mutex.c:746
>  team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
>  dev_change_rx_flags net/core/dev.c:9145 [inline]
>  __dev_set_promiscuity+0x3f8/0x590 net/core/dev.c:9189
>  netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9201
>  dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:286 packet_dev_mc net/packet/af_packet.c:3698 [inline]
>  packet_dev_mclist_delete net/packet/af_packet.c:3722 [inline]
>  packet_notifier+0x292/0xa60 net/packet/af_packet.c:4247
>  notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
>  call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
>  call_netdevice_notifiers net/core/dev.c:2228 [inline]
>  unregister_netdevice_many_notify+0x15d8/0x2330 net/core/dev.c:11972
>  rtnl_delete_link net/core/rtnetlink.c:3522 [inline]
>  rtnl_dellink+0x488/0x710 net/core/rtnetlink.c:3564
>  rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6955
>  netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
> 
> Calling `PACKET_ADD_MEMBERSHIP` on an ops-locked device can trigger
> the `NETDEV_UNREGISTER` notifier, which may require disabling promiscuous
> and/or allmulti mode. Both of these operations require acquiring
> the netdev instance lock.
> 
> Move the call to `packet_dev_mc` outside of the RCU critical section.
> The `mclist` modifications (add, del, flush, unregister) are protected by
> the RTNL, not the RCU. The RCU only protects the `sklist` and its
> associated `sks`. The delayed operation on the `mclist` entry remains
> within the RTNL.
> 
> Reported-by: syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b191b5ccad8d7a986286
> Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

