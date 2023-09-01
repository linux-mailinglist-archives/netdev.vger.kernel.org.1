Return-Path: <netdev+bounces-31672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E5278F7AC
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 06:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8240C1C20B3A
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 04:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C05EBE;
	Fri,  1 Sep 2023 04:37:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B6415B5
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 04:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A96BC433C7;
	Fri,  1 Sep 2023 04:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693543065;
	bh=TxeMncoil7FlVij6iViyLR6olMYV30Ccexze25vPDN4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=njsQV402VCZs/76eNMzZT9ZmzOqT+oP5o79xQg5Td314bQb4iTVfyAxEr3dkXHNaQ
	 +y0uTGkSKEqC3iejc0BGtnj71rIQxT7dYfb1I4ko4A4jFp71wMfGkAfQ9ufSmUcKCU
	 F3iOaTfyLENTUiP8wOyeIMFPgznZ/Tg0bf1ETQdW7kE4vE2t4Uf5jq8TwUM3GS0v9V
	 Rp60Zxa7KLywaesdfD3cS5nUpT6x9+IzzWlMYB/rfC+aKN8qNAF6cp1CblCag9zCg+
	 4T2brcsTvRzoDUOKZrjH4RqNyskn4QeOsrDAG5QEHnuyYz8Py547GSSzIInl1yfvX3
	 Nf+aT46/vwc1A==
From: Kalle Valo <kvalo@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: <linux-wireless@vger.kernel.org>,  <netdev@vger.kernel.org>,
  <johannes@sipsolutions.net>,  <davem@davemloft.net>,
  <edumazet@google.com>,  <kuba@kernel.org>,  <pabeni@redhat.com>,
  <weiyongjun1@huawei.com>,  <yuehaibing@huawei.com>
Subject: Re: [PATCH net,v2] wifi: mac80211: fix WARNING in
 ieee80211_link_info_change_notify()
References: <20230901035301.3473463-1-shaozhengchao@huawei.com>
Date: Fri, 01 Sep 2023 07:38:58 +0300
In-Reply-To: <20230901035301.3473463-1-shaozhengchao@huawei.com> (Zhengchao
	Shao's message of "Fri, 1 Sep 2023 11:53:01 +0800")
Message-ID: <871qfitsm5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zhengchao Shao <shaozhengchao@huawei.com> writes:

> Syz reports the following WARNING:
> wlan0: Failed check-sdata-in-driver check, flags: 0x0
> WARNING: CPU: 3 PID: 5384 at net/mac80211/main.c:287
> ieee80211_link_info_change_notify+0x1c2/0x230
> Modules linked in:
> RIP: 0010:ieee80211_link_info_change_notify+0x1c2/0x230
> Call Trace:
> <TASK>
> ieee80211_set_mcast_rate+0x3e/0x50
> nl80211_set_mcast_rate+0x316/0x650
> genl_family_rcv_msg_doit+0x20b/0x300
> genl_rcv_msg+0x39f/0x6a0
> netlink_rcv_skb+0x13b/0x3b0
> genl_rcv+0x24/0x40
> netlink_unicast+0x4a2/0x740
> netlink_sendmsg+0x83e/0xce0
> sock_sendmsg+0xc5/0x100
> ____sys_sendmsg+0x583/0x690
> ___sys_sendmsg+0xe8/0x160
> __sys_sendmsg+0xbf/0x160
> do_syscall_64+0x35/0x80
> entry_SYSCALL_64_after_hwframe+0x46/0xb0
> </TASK>
>
> The execution process is as follows:
> Thread A:
> ieee80211_open()
>     ieee80211_do_open()
>         drv_add_interface()     //set IEEE80211_SDATA_IN_DRIVER flag
> ...
> rtnl_newlink
>     do_setlink
> 	dev_change_flags
>             ...
>             __dev_close_many
>                 ieee80211_stop()
>                     ieee80211_do_stop()
>                         drv_remove_interface() //clear flag
> ...
> nl80211_set_mcast_rate()
>     ieee80211_set_mcast_rate()
>         ieee80211_link_info_change_notify()
>             check_sdata_in_driver() //WARNING because flag is cleared
>
> When the wlan device stops, the IEEE80211_SDATA_IN_ DRIVER flag is cleared.
> And then after the set mcast rate command is executed, WARNING is generated
> because the flag bit has been already cleared.
>
> Fixes: 591e73ee3f73 ("wifi: mac80211: properly skip link info driver update")
> Reported-by: syzbot+bce2ca140cc00578ed07@syzkaller.appspotmail.com
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Wireless patches (ie. anything which starts with "wifi:") go to wireless
and wireless-next trees, not to net tree.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

