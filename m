Return-Path: <netdev+bounces-29826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABEB784DBD
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740742811EE
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 00:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B99180;
	Wed, 23 Aug 2023 00:19:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDF77E
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:19:18 +0000 (UTC)
Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn [202.108.3.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A79CE6
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 17:19:15 -0700 (PDT)
X-SMAIL-HELO: pek-lxu-l1.wrs.com
Received: from unknown (HELO pek-lxu-l1.wrs.com)([111.198.228.11])
	by sina.com (172.16.97.27) with ESMTP
	id 64E5507F000095B2; Wed, 23 Aug 2023 08:19:12 +0800 (CST)
X-Sender: eadavis@sina.com
X-Auth-ID: eadavis@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=eadavis@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=eadavis@sina.com
X-SMAIL-MID: 827283786788
X-SMAIL-UIID: B07121F6B49146D88AA5B3F8E03572F4-20230823-081912
From: eadavis@sina.com
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	hdanton@sina.com,
	kuba@kernel.org,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	ralf@linux-mips.org,
	syzbot+666c97e4686410e79649@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Edward AD <eadavis@sina.com>
Subject: Re: [PATCH] sock: Fix sk_sleep return invalid pointer
Date: Wed, 23 Aug 2023 08:19:10 +0800
Message-ID: <20230823001910.1943703-1-eadavis@sina.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <f80fcd476a230c354bf9758762250c43a1f3d5cc.camel@redhat.com>
References: <f80fcd476a230c354bf9758762250c43a1f3d5cc.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward AD <eadavis@sina.com>

On Tue, 22 Aug 2023 17:31:00 +0200, pabeni@redhat.com wrote:
> > From: Edward AD <eadavis@sina.com>
> > 
> > The parameter sk_sleep(sk) passed in when calling prepare_to_wait may 
> > return an invalid pointer due to nr-release reclaiming the sock.
> > Here, schedule_timeout_interruptible is used to replace the combination 
> > of 'prepare_to_wait, schedule, finish_wait' to solve the problem.
> > 
> > Reported-and-tested-by: syzbot+666c97e4686410e79649@syzkaller.appspotmail.com
> > Signed-off-by: Edward AD <eadavis@sina.com>
> 
> This looks wrong. No syscall should race with sock_release(). It looks
> like you are papering over the real issue.
> 
> As the reproducer shows a disconnect on an connected socket, I'm wild
> guessing something alike 4faeee0cf8a5d88d63cdbc3bab124fb0e6aed08c
> should be more appropriate.
There is insufficient evidence to prove where the current report provided by 
syz caused 'sk_sleep()' to return an invalid pointer.
So, the above statement is my guess.

