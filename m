Return-Path: <netdev+bounces-49158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4A47F0F66
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6B91F23378
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A2A11CBB;
	Mon, 20 Nov 2023 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86078A7;
	Mon, 20 Nov 2023 01:49:59 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vwlwy7d_1700473796;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0Vwlwy7d_1700473796)
          by smtp.aliyun-inc.com;
          Mon, 20 Nov 2023 17:49:57 +0800
Date: Mon, 20 Nov 2023 17:49:52 +0800
From: Tony Lu <tonylu@linux.alibaba.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: dust.li@linux.alibaba.com, Alexandra Winter <wintera@linux.ibm.com>,
	kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
	alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] net/smc: avoid atomic_set and smp_wmb in the
 tx path when possible
Message-ID: <ZVsrwM0U7XUTgXAo@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20231117111657.16266-1-lirongqing@baidu.com>
 <422c5968-8013-4b39-8cdb-07452abbf5fb@linux.ibm.com>
 <20231120032029.GA3323@linux.alibaba.com>
 <22394c7b-0470-472d-9474-4de5fc86c5ea@linux.ibm.com>
 <f648fe4f-c911-43c5-be52-1a6324f063a6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f648fe4f-c911-43c5-be52-1a6324f063a6@linux.ibm.com>

On Mon, Nov 20, 2023 at 10:17:15AM +0100, Alexandra Winter wrote:
> 
> 
> On 20.11.23 10:11, Alexandra Winter wrote:
> > 
> > 
> > On 20.11.23 04:20, Dust Li wrote:
> >>> It seems to me that the purpose of conn->tx_pushing is
> >>> a) Serve as a mutex, so only one thread per conn will call __smc_tx_sndbuf_nonempty().
> >>> b) Repeat, in case some other thread has added data to sndbuf concurrently.
> >>>
> >>> I agree that this patch does not change the behaviour of this function and removes an
> >>> atomic_set() in the likely path.
> >>>
> >>> I wonder however: All callers of smc_tx_sndbuf_nonempty() must hold the socket lock.
> >>> So how can we ever run in a concurrency situation?
> >>> Is this handling of conn->tx_pushing necessary at all?
> >> Hi Sandy,
> >>
> >> Overall, I think you are right. But there is something we need to take care.
> >>
> >> Before commit 6b88af839d20 ("net/smc: don't send in the BH context if
> >> sock_owned_by_user"), we used to call smc_tx_pending() in the soft IRQ,
> >> without checking sock_owned_by_user(), which would caused a race condition
> >> because bh_lock_sock() did not honor sock_lock(). To address this issue,
> >> I have added the tx_pushing mechanism. However, with commit 6b88af839d20,
> >> we now defer the transmission if sock_lock() is held by the user.
> >> Therefore, there should no longer be a race condition. Nevertheless, if
> >> we remove the tx_pending mechanism, we must always remember not to call
> >> smc_tx_sndbuf_nonempty() in the soft IRQ when the user holds the sock lock.
> >>
> >> Thanks
> >> Dust
> > 
> > 
> > ok, I understand.
> > So whoever is willing to give it a try and simplify smc_tx_sndbuf_nonempty(),
> > should remember to document that requirement/precondition.
> > Maybe in a Function context section of a kernel-doc function decription?
> > (as described in https://docs.kernel.org/doc-guide/kernel-doc.html)
> > Although smc_tx_sndbuf_nonempty() is not exported, this format is helpful.
> > 
> 
> 
> Tony Lu <tonylu@linux.alibaba.com> ' mail address has been corrupted in this whole thread.
> Please reply to this message (corrected address) or take care, if replying to
> other messages in this thread.

Yes, that's true. Thanks Alexandra.

Please use my correct address, RongQing: Tony Lu <tonylu@linux.alibaba.com>.

